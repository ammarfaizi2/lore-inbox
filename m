Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWEWP7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWEWP7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWEWP7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:59:54 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:25616 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750751AbWEWP7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:59:54 -0400
Message-ID: <44733172.3070100@de.ibm.com>
Date: Tue, 23 May 2006 17:59:46 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/6] statistics infrastructure - documentation
References: <1148055132.2974.17.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060523135609.GA17354@in.ibm.com>
In-Reply-To: <20060523135609.GA17354@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> <snip>
> 
>> +Actual semantics of the data that feeds a statistic is unimportant when it
>> +comes to data processing. All that matters is how the user wants the data to
>> +be presented (counters, histograms, and so on). That's a job that can be
>> +be done by a generic layer without intervention by the device driver
>> +which is the actual source of statistics data.
> 
> Can't this be pushed to user space? Can the same thing be accomplished with
> the help of a user space library?

Does your qestion refer to the formatting or accumulation of data?

As to the accumulation of data:

Usually, that should be done in the kernel, instead of reporting zillions
of events up to user space and maintaining counters or whatever there.

As to the formatting of data:

Well, there has to be an agreement between kernel and user space on
how data looks like when being passed between the two. Some protocol -
though it might be quite lightweight - like the netlink taskstats
headers etc., or the format of my debugfs files.

My point is that such a protocol can be and should be generic
with regard to its payload; or, to be precise, with regard to the
origin of the statistics data. A counter is a counter, a histogram
is a histogram, regardless of the kernel component being the source
of data, and regardless of the entity that a statistic is embedded in.

That is why, my protocol has been reduced to only reflect which
information makes for a histograms etc. I think, the minimal formatting or
packaging work that needs to be done in the kernel is exactly about that.
I agree that anything beyond that should be done in user space
(Some script that is capable of generating bar charts in the format of
one's choice comes to mind).

> 
> <snip>
> 
>> +
>> +	How data is reported
>> +
>> +There are two methods how such data can be provided to the statistics
>> +infrastructure, a push interface and a pull interface. Each statistic
>> +is either a pull-type or push-type statistic as determined by the exploiter.
>> +
>> +The push-interface is suitable for data feeds that report incremental updates
>> +to statistics, and where actual accumulation can be left to the statistics
>> +infrastructure. New measurements usually trigger pushing data.
>> +(see statistics_add() and statistic_inc())
>> +
>> +The pull-interface is suitable for data that already comes in an aggregated
>> +form, like hardware measurement data or counters already maintained and
>> +used by exploiters for other purposes. Reading statistics data from files
>> +triggers an optional callback of the exploiter, which can update pull-type
>> +statistics then (see statistic_set()).
>> +
> 
> (Ge)netlink does a great job of supporting the push and pull interfaces.

Okay. Sorry, I am still reading code and documentation.

But, I think we have to be careful here not to mix up concepts, as there are
two interfaces: the programming interface provided by the generic layer to
exploiters, and the user interface provided by the generic layer to users.
The former supports both a push and pull method (statistic_add/inc/set),
because of the different natures of data feeds (as explained above).
The latter is about making accumulated data accessible and is currently
implemeted as files, and so it's a sort of pull interface.

I am not sure yet whether a more sophisticated user interface is really
required. So far, my position on this has been: "user pulls data from file
if needed" is good enough for now; and if a use case for the other method
pops up, we can discuss an enhancement.

I would appriciate feedback on the need for a push-method being part of the
_user interface_, as it seems to be a key point in the debugfs vs. netlink
discussion. Any use cases?

>> +For example, the same statistic might work as a single counter, or as a
>> +histogram comprising a variable (user-defined) number of buckets, or as an
>> +adaptable list of buckets for sparse concrete values, etc. Whatever the result
>> +looks like should be left to the individual modes of data processing.
>> +In order to reduce all kinds of data processing and their output to a common
>> +denominator, an output format along the following lines is suggested and
>> +has been implemented:
>> +
>> +  latency_write <=0 0			\
>> +  latency_write <=1 13			|
>> +  latency_write <=2 13			|
>> +  latency_write <=4 56			|
>> +  latency_write <=8 144			|
>> +  latency_write <=16 184		| a histogran with
>> +  latency_write <=32 181		> 13 buckets
>> +  latency_write <=64 74			|
>> +  latency_write <=128 271		|
>> +  latency_write <=256 0			|
>> +  latency_write <=512 33		|
>> +  latency_write <=1024 0		|
>> +  latency_write >1024 0			/
>> +  latency_read <=0 0				\
>> +  ...						> another histogram
>> +  latency_read >1024 0				/
>> +  size_write missed 0x0			\
>> +  size_write 0x1000 143			|
>> +  size_write 0xc000 42			|
>> +  size_write 0x10000 14			| an adaptable list
>> +  size_write 0xf000 13			> with a growing number of buckets
>> +  size_write 0x1e000 12			| (up to a defined limit only)
>> +  size_write 0x14000 12			|
>> +  ...					|
>> +  size_write 0x9000 1			/
>> +  queue_used_depth 970 1 18.122 32		> num min avg max for a queue
>> +
>> +Such output can grow as needed in debugfs files. It is human-readable and
>> +could be parsed and postprocessed by simple scripts that are aware of what the
>> +output of the various data processing modes looks like.
> 
> What is the extent to which the data is buffered? Lets say the file
> contains 1000 such records - they all need to be maintained in memory
> till the file is closed or removed - right?

Okay, as a user I would get this by cat'ing the file content to the console
or into some file on disk. This costs about as much as reading from any seq_file.

I don't think 1000 lines is a typical use case. No exploiter has that many
statsitics to report for an entity. And most likely no user is interested in so
much detail (histogram with 1000 buckets, for example). However, 1000 lines
of such output would be about 1000*25 bytes. My code allocates a scatter-gather
output buffer of the required size build up from single pages allocated with
GFP_KERNEL - for the short time of 'cat data'. I don't see that as a real issue.

> <snip>
> 
>> +  2. Performance
>> +
>> +
>> +	Some preliminary numbers
>> +
>> +FIXME
>> +
>> +	Per-CPU data
>> +
>> +Measurements reported by exploiters are accumulated into per-CPU data areas
>> +in order to avoid the introduction of serialisation during the
>> +execution of statistic_add(). Locking of per-CPU data is done by disabling
>> +preemption and interrupts per CPU for the short time of a statistic update.
>> +
> 
> Is this not an overkill. What if the subsystem updating the statistics
> does not require interrupts to be disabled for serialization.

Public opinion seems to second a per-CPU data approach:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113458576022747&w=2

Anyway, if the exploiter doesn't require such precautions, it can indicate
to the generic layer trhough a flag not to use per-CPU data. And it can
use statistic_add/inc_nolock() - statistic_add flavours which come without
the serialisation code.

>> +	Memory footprint
>> +
>> +Because the statistics code uses per-CPU data, it observes CPU hot-(un)plug
>> +events and allocates and releases per-CPU data as sparingly as possible.
>> +
>> +The differentiation of:
>> +
>> +- struct statistic (any data required for gathering data for a statistic),
>> +- struct statistic_info (description of a class of statistics),
>> +- struct statistic_discipline (description of a data processing mode), and
>> +- struct statistic_interface (user interface for a collection of statistics)
>> +
>> +means avoidance of storing redundant data per statistic. Struct statistic
>> +can be kept quite small.
>> +
>> +
>> +	Disabling statistics
>> +
>> +Data gathering can be turned off (by default or by users), which reduces
>> +statistic_add() to a check.
>> +
>> +
>> +	Kernel configuration option
>> +
>> +CONFIG_STATISTICS can be used to include or exclude statistics during the
>> +kernel build process.
>> +
>> +
>> +
>> +
>> +  3. Modes of data processing
>> +
>> +So far, available are:
>> +
>> +
>> +	type=counter_inc
>> +
>> +A counter sums up all Y-values of (X, Y) data pairs reported, regardless of the
>> +X-part.
>> +
>> +For example, a (request size, occurrence)-statistic would yield the
>> +total of requests observed.
>> +
>> +
>> +	type=counter_prod
>> +
>> +A counter sums up all X*Y with X and Y belonging to the same (X, Y).
>> +
>> +For example, a (request size, occurrence)-statistic would yield the
>> +total of bytes transfered.
>> +
>> +
>> +	type=utilisation
>> +
>> +Provides a set of values comprising:
>> +- the sum of all Y-values,
>> +- the minimum X
>> +- the average X
>> +- the maximum X
>> +
>> +This appears to be a useful fill level indicator for queues etc.
>> +
>> +For example, a (request size, occurrence)-statistic would yield a very
>> +basic statement about the traffic pattern, with information about the range
>> +of request sizes observed.
>> +
>> +
>> +	type=histogram_lin
>> +
>> +Comprises a set of counters, with each counter summing up all those Y-values
>> +reported for an assigned range or interval of X-values. All intervals of
>> +X-values are equal.
>> +
>> +Additional required parameters include:
>> +- entries (number of buckets, at least 2 required)
>> +- range_min (first bucket stands for <=range_min)
>> +- base_interval (interval size each bucket covers)
>> +
>> +For example, a (request size, occurrence)-statistic would yield a histogram
>> +of observed request sizes, with the same precision for small, medium and
>> +large request sizes.
>> +
>> +
>> +	type=histogram_log2
>> +
>> +Similar to type=histogram_lin, except that the intervals double
>> +from bucket to bucket. That is, the histogram loses in precision for
>> +larger X-values.
>> +
>> +
>> +	type=sparse
>> +
>> +This one is similar to other histograms, with the exception that it provides
>> +buckets for discrete X-values instead of ranges of X-values. Since it
>> +utilises a list instead of an array, it is suited for compiling histogram-like
>> +results for rather few, sparse X-values which users want to measure
>> +separately.
>> +
>> +Additional required parameters include:
>> +- entries (list is capped at this number of entries)
>> +
>> +For example, a (request size, occurrence)-statistic would yield the
>> +occurrences of all request sizes. Since it records precise sizes,
>> +it can also show the odd one out, which might be problematic; who knows...
>> +
>> +
>> +	Other
>> +
>> +The statistic infrastructure has been designed to make the addition
>> +of more ways of data processing easy (see struct statistic_discipline).
>> +
>> +For example, two more types had been implemented which are not included
>> +in the source code:
>> +
>> +- A "raw" type statistic which provides a record of (X, Y)-pairs.
>> +  Nice for verification and debugging purposes.
>> +
>> +- An enhancement of other basic types, like "counter" or "utilisation"
>> +  by the dimension time, which provides a time-tagged history of their
>> +  results for successive periods of time.
>> +  For example, a (request size, occurrence)-statistic could yield the
>> +  transfer rate over time, like bytes per second.
>> +
> 
> Cant all of this be moved to user space if (X, Y) tuples are passed down?

No.

My sample SCSI statistics say that I can have easily millions of requests
and, therewith, millions of such (X, Y) tuples showing up during my
lunch break at the cafeteria.

You don't want to pass every update to user space and then have user space,
in a simple case, just increase a counter, or, in the worst case,
just drop this information because it's not interested.

It's much more efficient to do some sort of accumulation immediately and
to dramatically reduce the amount of data that needs to commute from
kernel to user space.

	Martin

