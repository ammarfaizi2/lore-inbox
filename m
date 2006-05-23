Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWEWOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWEWOBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWEWOBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:01:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21959 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751022AbWEWOBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:01:22 -0400
Date: Tue, 23 May 2006 19:26:09 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/6] statistics infrastructure - documentation
Message-ID: <20060523135609.GA17354@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1148055132.2974.17.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148055132.2974.17.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> +Actual semantics of the data that feeds a statistic is unimportant when it
> +comes to data processing. All that matters is how the user wants the data to
> +be presented (counters, histograms, and so on). That's a job that can be
> +be done by a generic layer without intervention by the device driver
> +which is the actual source of statistics data.

Can't this be pushed to user space? Can the same thing be accomplished with
the help of a user space library?

<snip>

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
> +(see statistics_add() and statistic_inc())
> +
> +The pull-interface is suitable for data that already comes in an aggregated
> +form, like hardware measurement data or counters already maintained and
> +used by exploiters for other purposes. Reading statistics data from files
> +triggers an optional callback of the exploiter, which can update pull-type
> +statistics then (see statistic_set()).
> +

(Ge)netlink does a great job of supporting the push and pull interfaces.

<snip>

> +For example, the same statistic might work as a single counter, or as a
> +histogram comprising a variable (user-defined) number of buckets, or as an
> +adaptable list of buckets for sparse concrete values, etc. Whatever the result
> +looks like should be left to the individual modes of data processing.
> +In order to reduce all kinds of data processing and their output to a common
> +denominator, an output format along the following lines is suggested and
> +has been implemented:
> +
> +  latency_write <=0 0			\
> +  latency_write <=1 13			|
> +  latency_write <=2 13			|
> +  latency_write <=4 56			|
> +  latency_write <=8 144			|
> +  latency_write <=16 184		| a histogran with
> +  latency_write <=32 181		> 13 buckets
> +  latency_write <=64 74			|
> +  latency_write <=128 271		|
> +  latency_write <=256 0			|
> +  latency_write <=512 33		|
> +  latency_write <=1024 0		|
> +  latency_write >1024 0			/
> +  latency_read <=0 0				\
> +  ...						> another histogram
> +  latency_read >1024 0				/
> +  size_write missed 0x0			\
> +  size_write 0x1000 143			|
> +  size_write 0xc000 42			|
> +  size_write 0x10000 14			| an adaptable list
> +  size_write 0xf000 13			> with a growing number of buckets
> +  size_write 0x1e000 12			| (up to a defined limit only)
> +  size_write 0x14000 12			|
> +  ...					|
> +  size_write 0x9000 1			/
> +  queue_used_depth 970 1 18.122 32		> num min avg max for a queue
> +
> +Such output can grow as needed in debugfs files. It is human-readable and
> +could be parsed and postprocessed by simple scripts that are aware of what the
> +output of the various data processing modes looks like.

What is the extent to which the data is buffered? Lets say the file
contains 1000 such records - they all need to be maintained in memory
till the file is closed or removed - right?

<snip>

> +  2. Performance
> +
> +
> +	Some preliminary numbers
> +
> +FIXME
> +
> +	Per-CPU data
> +
> +Measurements reported by exploiters are accumulated into per-CPU data areas
> +in order to avoid the introduction of serialisation during the
> +execution of statistic_add(). Locking of per-CPU data is done by disabling
> +preemption and interrupts per CPU for the short time of a statistic update.
> +

Is this not an overkill. What if the subsystem updating the statistics
does not require interrupts to be disabled for serialization.

<snip>

> +	Memory footprint
> +
> +Because the statistics code uses per-CPU data, it observes CPU hot-(un)plug
> +events and allocates and releases per-CPU data as sparingly as possible.
> +
> +The differentiation of:
> +
> +- struct statistic (any data required for gathering data for a statistic),
> +- struct statistic_info (description of a class of statistics),
> +- struct statistic_discipline (description of a data processing mode), and
> +- struct statistic_interface (user interface for a collection of statistics)
> +
> +means avoidance of storing redundant data per statistic. Struct statistic
> +can be kept quite small.
> +
> +
> +	Disabling statistics
> +
> +Data gathering can be turned off (by default or by users), which reduces
> +statistic_add() to a check.
> +
> +
> +	Kernel configuration option
> +
> +CONFIG_STATISTICS can be used to include or exclude statistics during the
> +kernel build process.
> +
> +
> +
> +
> +  3. Modes of data processing
> +
> +So far, available are:
> +
> +
> +	type=counter_inc
> +
> +A counter sums up all Y-values of (X, Y) data pairs reported, regardless of the
> +X-part.
> +
> +For example, a (request size, occurrence)-statistic would yield the
> +total of requests observed.
> +
> +
> +	type=counter_prod
> +
> +A counter sums up all X*Y with X and Y belonging to the same (X, Y).
> +
> +For example, a (request size, occurrence)-statistic would yield the
> +total of bytes transfered.
> +
> +
> +	type=utilisation
> +
> +Provides a set of values comprising:
> +- the sum of all Y-values,
> +- the minimum X
> +- the average X
> +- the maximum X
> +
> +This appears to be a useful fill level indicator for queues etc.
> +
> +For example, a (request size, occurrence)-statistic would yield a very
> +basic statement about the traffic pattern, with information about the range
> +of request sizes observed.
> +
> +
> +	type=histogram_lin
> +
> +Comprises a set of counters, with each counter summing up all those Y-values
> +reported for an assigned range or interval of X-values. All intervals of
> +X-values are equal.
> +
> +Additional required parameters include:
> +- entries (number of buckets, at least 2 required)
> +- range_min (first bucket stands for <=range_min)
> +- base_interval (interval size each bucket covers)
> +
> +For example, a (request size, occurrence)-statistic would yield a histogram
> +of observed request sizes, with the same precision for small, medium and
> +large request sizes.
> +
> +
> +	type=histogram_log2
> +
> +Similar to type=histogram_lin, except that the intervals double
> +from bucket to bucket. That is, the histogram loses in precision for
> +larger X-values.
> +
> +
> +	type=sparse
> +
> +This one is similar to other histograms, with the exception that it provides
> +buckets for discrete X-values instead of ranges of X-values. Since it
> +utilises a list instead of an array, it is suited for compiling histogram-like
> +results for rather few, sparse X-values which users want to measure
> +separately.
> +
> +Additional required parameters include:
> +- entries (list is capped at this number of entries)
> +
> +For example, a (request size, occurrence)-statistic would yield the
> +occurrences of all request sizes. Since it records precise sizes,
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
> +  transfer rate over time, like bytes per second.
> +

Cant all of this be moved to user space if (X, Y) tuples are passed down?


<snip>

	Warm Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
