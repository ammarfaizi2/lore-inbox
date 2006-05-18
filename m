Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWERGbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWERGbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 02:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWERGbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 02:31:18 -0400
Received: from xenotime.net ([66.160.160.81]:29320 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751077AbWERGbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 02:31:17 -0400
Date: Wed, 17 May 2006 23:33:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, chase.venters@clientec.com,
       nickpiggin@yahoo.com.au, kaos@ocs.com.au, akpm@osdl.org,
       clameter@sgi.com, fche@redhat.com, peterc@gelato.unsw.edu.au,
       hch@infradead.org, arjan@infradead.org, ak@suse.de
Subject: Re: [RFC] [Patch 4/6] statistics infrastructure - documentation
Message-Id: <20060517233343.1d5517dc.rdunlap@xenotime.net>
In-Reply-To: <1147892085.3076.20.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1147892085.3076.20.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006 20:54:45 +0200 Martin Peschke wrote:

> documentation for developers and users
> 
> Signed-off-by: Martin Peschke <mp3@de.ibm.com>
> ---
> 
>  00-INDEX       |    2
>  statistics.txt |  760 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 762 insertions(+)
> 
> diff -Nurp a/Documentation/statistics.txt b/Documentation/statistics.txt
> --- a/Documentation/statistics.txt	1970-01-01 01:00:00.000000000 +0100
> +++ b/Documentation/statistics.txt	2006-05-17 19:11:32.000000000 +0200
> @@ -0,0 +1,760 @@
> +
> +
> +  0. Which problems is it meant to solve?
> +
> +This common code layer implements statistics in a device driver independent
> +and architecture independent way. It minimizes the effort by providing a simple
> +programming interface. Added benefit is a generic user interfaces.

  ... generic user interface.

> +
> +
> +
> +  1. Concepts
> +
> +	Overview
> +

> +	The form of reported data
> +
> +Exploiters report data in the form of (X, Y) value pairs with X being
> +a quantity for the main characteristic of the statistic, like a request size
> +or request latency, and with Y being a qualifier for that characteristic,
> +i.e. the occurrence of a particular X-value.
> +
> +Thus, the Y-part can be seen an optimisation that allows to report a bunch

that allows <something> to report a bunch
e.g., allows a function or a module or a driver or a filesystem

> +of similar measurements in one go ( see statistic_add() ).
Drop extra spaces:  (see statistic_add()).

Is "go" a technical term?  Can we get something better, like
in one call?

> +For the programmer's convenience, Y can be ommited when it would be always 1

omitted

> +( see statistic_inc() ).

drop extra spaces

> +
> +
> +	How data is reported
> +
> +There are two methods how such data can be provided to the statistics
> +infrastructure, a push interface and a pull interface. Each statistic
> +is either a pull-type or push-type statistic as determined by the exploiter.
> +
> +The push-interface is suitable for data feeds that report incremental updates
> +to statistics, and where actual accumulation can be left to the statistics
> +infrastructure. New measurements usually trigger pushing data.
> +( see statistics_add() and statistic_inc() )

drop extra spaces

> +
> +The pull-interface is suitable for data that already comes in an aggregated
> +form, like hardware measurement data or counters already maintained and
> +used by exploiters for other purposes. Reading statistics data from files
> +triggers an optional callback of the exploiter, which can update pull-type
> +stattistics then ( see statistic_set() ).

spello: statistics
drop extra spaces

> +
> +
> +	How data is processed
> +
> +(X, Y) pairs can be processed in different ways by the statistics
> +infrastructure, according to the current settings applicable to a
> +particular statistic.
> +
> +For example, X might be used to distinguish certain buckets (see histogram).
> +Minimum, average and maximum X values might be determined (see utilisation).
> +Y might be summed up (see counter, for example).
> +
> +See below for a reference of processing options.
> +
> +Please note that the statistics infrastructure does not care about the
> +actual semantics of (X, Y), an that it just adheres to abstract rules

s/an/and/  (?)

> +describing what to do with (X, Y) pairs for certain settings.
> +It is up to the user to interpret processed data, to add semantics
> +back to it, and to choose settings and, therewith, data processing modes
> +according to their needs.
> +
> +

> +	Why debugfs for now
> +
> +While sysfs comes with a refined structure reflecting almost everything
> +in the system, it is (by design) not good at representing large and variable
> +amounts of data, that is, more than one value per file. As for statistics,
> +we could make good use of the former, but not of the latter.

Why is debugfs not suitable for large & variable amounts of data?
Please expand/explain.


> +  2. Performance
> +
> +
> +	Path length of statistic_add() & friends
> +
> +Some flexibility and functionality are achieved on the expense of slightly
> +increased path length.
> +
> +A function pointer is used to implement different data processing modes
> +users can chose from.

choose


> +  3. Modes of data processing
> +
> +So far, available are:
> +
> +
> +	type=counter_inc
> +
> +A counter sums up all Y-values of (X, Y) data pairs reported, regardless of the
> +X-part,
s/,/./

> +	type=sparse
> +
> +This one is similar to other histograms, with the exception that it provides
> +buckets for discrete X-values instead of ranges of X-values. Since it
> +utilises a list instead of an array, it is suited for compiling histogram-like
> +results for rather few, sparse X-values which users want to measure
> +seperately.

separately.

> +
> +Additional required parameters include:
> +- entries (list is capped at this number of entries)
> +
> +For example, a (request size, occurrence)-statistic would yield the
> +occurrences of all request sizes. Since records precise resize numbers,

"Since this records... "  (?)

> +it can also show the odd one out, which might be problematic; who knows...
> +
> +
> +	Other
> +
> +The statistic infrastructure has been designed to make the addition
> +of more ways of data processing easy (see struct statistic_discipline).
> +
> +For example, two more types had been implemented which are not included
> +in the source code:
> +
> +- A "raw" type statistic which provides a record of (X, Y)-pairs.
> +  Nice for verification and debugging purposes.
> +
> +- An enhancement of other basic types, like "counter" or "utilisation"
> +  by the dimension time, which provides a time-tagged history of their
> +  results for successive periods of time.
> +  For example, a (request size, occurrence)-statistic could yield the
> +  transfer rate over time, like bytes per seconds.

second.


> +  4. User interface
> +
> +	Locating statistics
> +
> +The statistics infrastructure's user interface is in the
> +/sys/kernel/debug/statistics directory, assuming debugfs has been mounted at
> +/sys/kernel/debug.  The "statistics" directory holds interface subdirectories
> +created on the behalf of exploiters, for example:

I'm curious:
Is /sys/kernel/debug a common mount point for debugfs ?


> +	Changing statistics
> +
> +
> +One can either write the entire line describing a statistic, including
> +read-only attributes (which are ignored by the statistics infrastructure, as

as is any junk).

> +any is junk). Or one may modify single attributes, assuming this results
> +in a valid configuration.
> +
> +This simplifies the procedures (copy, paste to command line,
> +modify command line, echo attributes from command line into definition file)
> +and (cat to file, modify file content, cat file back into definition file).
> +
> +Some operations can be done in an atomic fashion for all statistics grouped
> +within the scope of an interface. Simply, omit the name= attribute:

drop comma


> +  5. Programming interface
> +
> +	Creating statistics
> +
> +
> +	Reporting statistics data
> +
> +
> +The above examples show statistics that feed on incremental updates that
> +get accumulated by the statistics infrastructure on top of data already
> +gathered by the statistics infrastructure.
> +That is why, statistic_add() or statistic_inc() respectively are used.

drop comma

> +There might be statistics that come as total numbers, e.g. because they feed
> +on counters alredy maintained by the exploiter or some hardware feature.

already

> +These numbers can be exported through the statistics infrastructure along
> +with any other statistic. In this case, use statistic_set() to report data.
> +Usually it is sufficient to do so when the user opens the corresponding
> +file to read statistic data. This will trigger the optional callback function
> +to be executed. Place statistic_set() calls there. In the same context calling
> +statistic_add() or statistic_inc() for incremental data feeds works as well,
> +in case that's needed:

---
~Randy
