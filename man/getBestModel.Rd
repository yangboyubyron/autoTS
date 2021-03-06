% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predictions.R
\name{getBestModel}
\alias{getBestModel}
\title{Determine best algorithm}
\usage{
getBestModel(
  dates,
  values,
  freq,
  complete = 0,
  n_test = NA,
  graph = TRUE,
  algos = list("my.prophet", "my.ets", "my.sarima", "my.tbats", "my.bats", "my.stlm",
    "my.shortterm"),
  bagged = "auto",
  metric.error = my.rmse
)
}
\arguments{
\item{dates}{A vector of dates that can be parsed by lubridate}

\item{values}{A vector of same size as \code{dates}}

\item{freq}{A chacracter string that indicates the frequency of the time series ("week", "month", "quarter", "day").}

\item{complete}{A numerical value (or NA) to fill the missing data points}

\item{n_test}{number of data points to keep aside for the test (default : one year)}

\item{graph}{A boolean, if TRUE, comparison of algorithms is plotted}

\item{algos}{A list containing the algorithms (strings, with prefix "my.") to be tested}

\item{bagged}{A string. "auto" will use all available algoriths, skipping algos parameter. Else, specified algos  of the `algo` parameter will be used}

\item{metric.error}{a function to compute the error the each models. available functions : my.rmse and my.mae}
}
\value{
A list contraining a character string with the name of the best method,
a gg object with the comparison between algorithms and a dataframe with predictions of all tried algorithms,
a dtaframe containing the errors of each algorithms, the preparedTS object and the list of algorithms tested
}
\description{
Implement selected algorithms, train them without the last n observed data points
(or n_test number of points), and compares the results to reality to determine the best algorithm
}
\examples{
library(autoTS)
dates <- seq(lubridate::as_date("2005-01-01"),lubridate::as_date("2010-12-31"),"quarter")
values <- 10+ 1:length(dates)/10 + rnorm(length(dates),mean = 0,sd = 10)
\donttest{
which.model <- getBestModel(dates,values,freq = "quarter",n_test = 4)
}
### Custom set of algorithm (including for bagged estimator)
which.model <- getBestModel(dates,values,freq = "quarter",n_test = 4,
                            algos = list("my.prophet","my.ets"),bagged = "custom")
### Use MAE instead of RMSE
\donttest{
which.model <- getBestModel(dates,values,freq = "quarter",n_test = 3,
                            algos = list("my.prophet","my.ets"),
                            bagged = "custom",metric.error = my.mae)
}
}
