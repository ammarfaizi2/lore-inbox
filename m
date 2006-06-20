Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWFTPkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWFTPkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWFTPkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:40:11 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12455 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751331AbWFTPkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:40:09 -0400
Message-ID: <449816D1.3040104@de.ibm.com>
Date: Tue, 20 Jun 2006 17:40:01 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: statistics infrastructure (in -mm tree) review
References: <20060613232131.GA30196@kroah.com> <20060613234739.GA30534@kroah.com> <20060613171827.73cd0688.rdunlap@xenotime.net> <4490923D.10904@de.ibm.com> <20060619221238.GA20018@kroah.com>
In-Reply-To: <20060619221238.GA20018@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>> 6) Some library routines would suffice to take over data gathering
>> and preprocessing. Avoids further code duplication, avoids bugs,
>> speeds up development and test.
> 
> As long as the library functions do not cause any speed degradations,
> which I think your current ones do with the pointer dereference (which
> is very slow and measurable on some archs).

Implementation detail ;-)

I will post another statistic_add() derivate that requires the caller
to specify the way data aggregation should be done, and which,
consequently, won't have an indirect function call.

Then callers / clients / programmers can chose between higher
flexibility and best performance, depending on the requirements
of their statistics.

>> 7) With regard to the delivery of statistic data to user land,
>> a library maintaining statistic counters, histograms or whatever
>> on behalf of exploiters doesn't need any help from the exploiter.
>> We can avoid the usual callbacks and code bloat in exploiters
>> this way.
> 
> I don't really understand what you are stating here.

Sorry.
1,$s/exploiter/client/g

Any device driver or whatever gathering statistics data currently
has code dealing with showing the data. Usually, they have some
callbacks for procfs, sysfs or whatever.

My point is that, if a library keeps track of statistics on behalf
of its clients, no client needs to be called back in order to
merge, format, copy, etc. data being shown to users. The library
can handle as a background operation without disturbing clients.

>> 8) If some library functions are responsible for showing data, and the
>> exploiter is not, we can achieve a common format for statistics data.
>> For example, a histogram about block I/O has the same format as
>> a histogram about network I/O.
>> This provides ease of use and minimises the effort of writing
>> scripts that could do further processing (e.g. formatting as
>> spreadsheats or bar charts, comparison and summarisation of
>> statistics, ...)
> 
> Common functionality and formats would be wonderful.  But I'm not sure
> you can guarantee that we really want the network io and block io
> statistics in the same format, as they are fundimentally different
> things.

Subsystems are free to gather as many/few statistics as required.
And I am not trying to enforce semantics.

All I am saying is that, if two statistics are aggregated using similar
algorithms, then the results should be presented or formatted in a
similar way.

My assumption is that the format of results doesn't depend on the
the semantics of the data feeding a statistic. But it depends on the
way we aggregate data.

For example, there is no reason why statistic A of subsystem 1
aggregated in the form of a histogram should have a different format
than statistic B of subsystem 2 also being aggregated in the form
of a histogram.

A <=0 0
A <=1 0
A <=2 3
A <=4 7
A <=8 29
A <=16 285
A <=32 295
A <=64 96
A <=128 52
A <=256 3
A >256 1


B <=10 1
B <=20 3
B <=30 92
B <=40 251
...
B <=490 34462
B <=500 23434
B >500 0

Semantics are different; statistic names are different;
number of buckets, "diameter" of buckets, scale etc. might be different;
basic format of results is identical - as long as both statistics are
aggregated the same way (as histograms, in this case).

A library can provide a common format, because semantics just don't
matter. Its statistic_add() function (or whatever we want to call it)
has no idea about the actual semantics of the incremental statistic data
it accepts and processes according to abstract rules.

And I think a library should provide a common format, because it
makes it fun poking in the aggregated data, and writing a script that
does further processing of that data.

> Also, you will have to live with the existing interfaces, as we can't
> break them, so porting them will not happen.

Okay.
A library could help to avoid a further proliferation of interfaces.

>> 9) For performance reasons, per-cpu data and minimal locking
>> (local_irq_save/restore) should be used.
>> Adds to complexity, though.
> 
> If necessary.  Is this really necessary?

I would think so.

My initial patch was criticised for not using per-cpu data and,
therewith, requiring more expensive locking.

Besides, all other serious statistic implementations use per-cpu data
(kernel/profile.c, include/linux/genhd.h, ...)

>> 10) If data is per-cpu, we want to be very careful with regard to
>> memory footprint. That is why, memory is only allocated for online
>> cpus (requires cpu hot(un)plug handling, which adds to complexity),
> 
> Agreed.
> 
>> 11) At least for data processing modes more expensive than plain
>> counters, like histograms, an on/off state makes sense.
> 
> So that userspace can tell the kernel to go faster?  I don't know why
> this is really necessary :)

Okay, here are two functions implemting two different ways
data can be aggregated:

   static void statistic_add_counter_inc(struct statistic *stat, int cpu,
                                         s64 value, u64 incr)
   {
           *(u64*)stat->pdata->ptrs[cpu] += incr;
   }

   static void statistic_add_histogram_log2(struct statistic *stat, int cpu,
                                            s64 value, u64 incr)
   {
           int i = statistic_histogram_calc_index_log2(stat, value);
           ((u64*)stat->pdata->ptrs[cpu])[i] += incr;
   }

with statistic_histogram_calc_index_log2 expanding to:

   static int statistic_histogram_calc_index_log2(struct statistic *stat,
                                                  s64 value)
   {
           unsigned long long i;
           for (i = 0;
                i < stat->u.histogram.last_index &&
                value > statistic_histogram_calc_value_log2(stat, i);
                i++);
           return i;
   }

While incrementing a counter might be cheap, updating a histogram
is more expensive. First, we need to identify the counter out of
a set of counters that is to be incremented. For logarithmic scale,
this requires a loop.

Checking whether data gathering has been enabled at all might look
expensive in the context of a plain counter. It certainly saves
cycles for a histogram that users aren't interested in and that
haven't been switched on.

>> 12) In order to minimise the memory footprint, a released/allocated
>> state makes sense.
> 
> Again, telling userspace when to tell the kernel to free up memory can
> cause problems.

We have to make sure that released memory isn't used anymore.
That's what _statistic_barrier() is for.

Do you see other issues?

>> 14) Kernel code delivering statistics data through library routines
>> can, at best, guess whether a user wants incremental updates be
>> aggregated in a single counter, a set of counters (histograms), or
>> in the form of other results. Users might want to change how much
>> detail is retained in aggregated statistic results.
>> Adds to complexity.
> 
> Complexity where?  Userspace or in the kernel?

Complexity in the kernel. Sorry.

When a statistics library allows users to chose from about half a
dozen ways of aggregating data, then this adds to the complexity
of that library to some degree.

>> 15) Nonetheless, exploiters are kindly requested to provide some
>> default settings that are a good starting point for general
>> purpose use.
>>
>> 16) Aggregated statistic results, in many cases, don't need to be
>> pushed to user space through a high-speed, high-volume interface.
>> Debugfs, for example, is fine for this purpose.
>>
>> 17) If the requirement for pushing data comes up anyway, we could,
>> for example, add relay-entries in debugfs anytime.
>> (For example, we could implement forwarding of incremental
>> updates to user space. Just another conceivable data processing
>> mode that fits into the current design.)
>>
>> 18) The programming interface of a statistics library can be rougly as
>> simple as statistic_create(), statistics_remove(), statistic_add().
>>
>> 19) Statistic_add() should come in different flavours:
>> statistic_add/inc() (just for convenience), and
>> statistic_*_nolock() (more efficient locking for a bundle of updates)
>>
>> 20) Statistic_add() takes a (X, Y) pair, with X being the main
>> characteristics of the statistics (e.g. a request size) and with
>> Y quantifying the update reported for a particular X (e.g. number
>> of observed requests of a particular request size).
>>
>> 21) Processing of (X, Y) according to abstract rules imposed by
>> counters, histograms etc. doesn't require any knowledge about the
>> semantics of X or Y.
>>
>> 22) There might be statistic counters that exploiters want to use and
>> maintain on their own, and which users still may want to have a look at
>> along with other statistics. Statistic_set() fits in here nicely.
> 
> 
> Ok, these are all implementation details.

Maybe. But at least 21) is fundamental, as it provides a base for
writing such a library: The library deals with a defined form of
data, regardless of the semantics of the data.

> Can you please step back a bit?  What is the requirements that you are
> trying to achieve here?

Our customers have serious concerns that Linux has no means
to gather SCSI performance data. Making sure we can get data from
subsystems, we both provide for better service and give customers
a good feeling.

Statistics, and SCSI statistics in particular, are seen here as one
of the more urgent things and real inhibitors on enterprise level.

 > A kernel-wide statistic gathering library?

Yes, as a by-product of the specific SCSI requirement, so to speak.
And, why not :)

> If so, why?  What has caused this to be needed?

A clear distinction between code measuring statistics data and
code handling statistics data makes for better code.
There is no point in intermixing algorithms for processing
statistics data and the semantics of statistics data.

So what would you do if you got to write the N-th set of statistic
functions?

To me it looks like the next logical step to fully abstract
statistics code out of a device driver.

 > And if it's needed, would
> putting the stuff in debugfs for _all_ statistics really be a good idea
> (hint, I would say no...)

May I ask you why you think so.

Well, so far I don't see a serious limitation in using debugfs.
I think relayfs entries could be used to cover other requirements,
if they pop up.

And as I have explained, replacing debugfs by something else
shouldn't be too difficult.
But, I don't see a clear direction regarding this discussion.

Or do you suggest that it would make sense to modularise that
part of the code, so as to allow for other user interface code
being "plugged in" and statistics data being shown through
debugfs, procfs, netlink or whatever?

>>>> And what does this mean for relayfs?  Those developers tuned that code
>>>> to the nth degree to get speed and other goodness, and here you go just
>>>> ignoring that stuff and add yet another way to get stats out of the
>>>> kernel.  Why should I use this instead of my own code with relayfs?
>>> Good questions.
>> Relayfs is a nice feature, but not appropriate here.
>>
>> For example, during a performance measurements I have seen
>> SCSI I/O related statistics being updated millions of times while
>> I was just having a short lunch break. Some of them just increased
>> a counter, which is pretty fast if done immediately in the kernel.
>> If all these updates update would have to be relayed to user space
>> to just increase a counter maintained in user space.. urgh, surely
>> more expensive and not the way to go.
>>
>> And what if user space isn't interested at all? Would we keep
>> pumping zillions of unused updates into buffers instead of
>> discarding them right away?
> 
> Yes, for simple counters, relayfs is overkill.  But so is an indirect
> function call through a pointer for every simple counter update :)

Got it.

>> Profile.c, taskstats, genhd and all the other statistics listed
>> above... they all maintain their counters in the kernel and
>> show aggregated statistics to users.
> 
> Yes, but will you be allowed to port the existing users over to your new
> framework without breaking any userspace stuff?  I don't see that
> happening :(

Would it be me porting...? ;-)

I see this library as an offering to anybody who is looking
for a comfortable and established way to dump statistic data,
including me.

>>>> And is the need for the in-kernel parser really necessary?  I know it
>>>> makes the userspace tools simpler (cat and echo), but should we be
>>>> telling the kernel how to filter and adjust the data?  Shouldn't we just
>>>> dump it all to userspace and use tools there to manipulate it?
>>> I agree again.
>> Assumimg we can agree on in-kernel counters, histograms etc.
>> allowing for attributes being adjusted by users makes sense.
>>
>> The parser stuff required for these attributes is implemented
>> using match_token() & friends, which should be acceptible.
>> But, I think that the standard way of using match_token() and
>> strsep() needs improvement (strsep is destructive to strings
>> parsed, which is painful).
> 
> Yeah, the parser isn't as bad as I originally thought it was.  But
> overall, I'm still not sold on the real need for this kind of
> subsystem/library.

In my eyes, there are several indications that a library makes sense:

We want statistics for various components.
Many of the reinvent-the-wheel statistics have similar programming interfaces
(e.g. compare disk_stat_add(), dasd_profile_counter(), profile_hit()).
There is unnecessary code duplication.
There is no need to have statistics user interface code spread throughout
the kernel.
A library can achieve a common output format, simplyfing user space.
A defined programming interface makes it much easier to get a general
idea of the statistics being around. An API gives more control and
might help to avoid introducing redundant statistics or statistics of
lesser importance.

I am not saying that such a library has to look exactly like the
proposed patches. I think that these patches contain some concepts
worth considering.

Thanks, Martin

