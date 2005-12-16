Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVLPM2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVLPM2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVLPM2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:28:08 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:64496 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932221AbVLPM2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:28:07 -0500
Message-ID: <43A2B2B8.6090008@de.ibm.com>
Date: Fri, 16 Dec 2005 13:27:36 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ak@suse.de
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/6] statistics infrastructure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

..oops, should have made sure that my mailer does line breaks 
appropriately. Getting it right this time, sorry ...




Andi Kleen wrote:

 > Locks and indirect function calls?
 > It seems very wrong to me to make such heavy weight statistic
 > functions. Most likely you will disturb the performance whatever is
 > being counted badly.


Well, that's a tradeoff between flexibility/function and performance.

I don't have any reliable numbers ready at hand. At least, doing I/O to 
my SCSI devices with enabled statistics didn't feel bad.

Here is the rational for both the indirect function call and the lock:

If a statistic is disabled (that's the default) neither is locking done 
nor is a function called indirectly. So far so good, I would say.

If a statistic is enabled the lock for this entity is grabbed and one 
indirect function call is done. Anything else is inlined. I use granular 
per-interface (per-entity, for example per-LUN or per-HBA) locking.

The indirect function call allows customization of the ways data 
processing is done for particular statistics.

For example, one could deflate a histogram of latencies into a counter 
providing the total of latency measurements, that is the total of 
requests observed; or inflate a statistic the other way around if 
required. Another example: one can make a statistic gather data for 
recurring periods of time, like megabytes per seconds instead of just 
the total amount of bytes transferred, or like queue utilization per 
whatever-unit-of-time instead of just an overall utilization.

A statistic that feeds on request sizes can be setup to provide the 
following "views":
- number of requests observed (counter)
- number of requests per unit of time (history based on a counter)
- number of bytes transfered (counter)
- number of bytes transfered per unit of time = transfer rate (history 
based on a counter)
- traffic pattern (histogram for descrete request sizes or for ranges of 
request sizes)
- raw measurement data gathered
- etc.

As a device driver programmer I might pick a "view" a user is interested 
in. My pick might miss by a mile. I simply don't know for sure beforehand.

The indirect function call could be a replaced by a switch statement. 
Not sure whether this is less critical and more acceptable than indirect 
function calls. Might be architucture dependent.

We can get rid of the indirect function call (or an alternative switch 
statement) if the vote is against this level of flexibility.
Then it would be solely up to the exploiter to define once and for all 
whether a particular sort of data is shown as a simple counter, a 
histogram, a fill level indicator, this history-type statistic thing in 
a ringbuffer etc. This might be fine for a considerable number of cases.

The lock is there to avoid trouble with concurrent updates to a 
statistic. If per-CPU data was used, concurrent updates are fine as long 
as they are done on different CPUs. Precautions for concurrent updates 
to the same per-CPU is still needed, though.

The current interface allows to use the lock this way:

lock(stat_x->interface);
statistics_inc_nolock(stat_x, y);
statistics_inc_nolock(stat_m, n);
statistics_add_nolock(stat_a, e, f);
unlock(stat_x->interface);

Because we hold the same lock when creating output for users, coherency 
of several statistics of a single entity can be achieved if statistic 
updates are done within one critical section as shown above.

The lock is also used to make sure that updates to a statistic don't 
happen while the setup of a statistic is changed by users. If we get rid 
of the indirect function call, some of these setup changes go away, 
anyway. Other cases, like statistic resets or inflating a 5-counter 
histogram to a 25-counter histogram, don't go away. If I can figure out 
how to reallocate, say, an array of counters for a histogram without 
holding a lock while updates happen... Maybe I could temporarily turn of 
a statistic.



 > Take a look at many other subsystems - they do per CPU counters etc.
 > to make this all fast.

I am looking into per CPU data.

But, is this really required for _all_ statistics? I see that it makes 
sense to have per CPU optimizations for very critical components, like 
parts of VM. But there are still a lot of do-it-yourself type statistics 
around that use an atomic_t, for example, without implementing it per CPU.

Then, I am not sure yet whether per CPU data is feasible for histograms 
and other more complex statistics. I have got to find out.

I tried to write the code in a way that allows to add other statistic 
type, like counters, histograms and so on, with moderate effort. Maybe I 
can use the internal interface to plug in some disclipline based on per 
CPU counters...



 > But it's still unclear why it would need such an heavyweight
 > infrastructure. Normally it's not that bad to reimplemented on the
 > fly. Maybe some common code can be refactored out of that, but
 > probably not too much.
 >
 > [... lots of other code snipped ... ]
 >
 > Looks all very very overdesigned to me. How about you just start
 > with a minimum specification and describe what you want to do?

As a device driver programmer I don't want to reinvent the wheel when 
coding statistics. I would prefer to use a few and easy to use library 
functions. I don't want to worry about getting my personal wheel being 
functional. I'd rather use my time to worry about which kind of data is 
really needed and which is not.

I'd like to provide a tool that can be customized at run time to a 
certain degree because it might not be acceptable for customers to 
install private kernels in order to get tuned statistics.
As a device driver programmer I can make an educated guess, at best, 
about certain parameters that impact the processing of statistic data.
Users might know better whether they need to focus on latencies from 2 
ms up to 64 ms or  from 100 ms up to 500 ms, because this kind of 
decisions depends on the environment to be measured, e.g. devices attached.

In a device driver, I don't want to spent much thought about the 
statistic's user interface. Particularly not if the statistic is a 
little bit more complex than a simple counter. Would be really nice to 
have a user interface that looks the same for all exploiters, i.e. to 
have common output formats for counters, histograms, fill level 
indicators etc.

Martin

