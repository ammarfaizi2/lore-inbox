Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUE3ATN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUE3ATN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 20:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUE3ATN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 20:19:13 -0400
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:5347 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S261252AbUE3ATE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 20:19:04 -0400
Message-ID: <40B92874.50009@bigpond.net.au>
Date: Sun, 30 May 2004 10:19:00 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired
 with a single array
References: <40B81F24.9080405@bigpond.net.au> <200405292117.56089.kernel@kolivas.org>
In-Reply-To: <200405292117.56089.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sat, 29 May 2004 15:27, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>> > On Fri, 28 May 2004 19:24, Peter Williams wrote:
>> > > Ingo Molnar wrote:
>> > > > just try it - run a task that runs 95% of the time and sleeps 5%
>> > > > of the time, and run a (same prio) task that runs 100% of the
>> > > > time. With the current scheduler the slightly-sleeping task gets
>> > > > 45% of the CPU, the looping one gets 55% of the CPU. With your
>> > > > patch the slightly-sleeping process can easily monopolize 90% of
>> > > > the CPU!
>> > >
>> > > This does, of course, not take into account the interactive bonus.
>> > > If the task doing the shorter CPU bursts manages to earn a larger
>> > > interactivity bonus than the other then it will get more CPU but
>> > > isn't that the intention of the interactivity bonus?
>> >
>> > No. Ideally the interactivity bonus should decide what goes first
>> > every time to decrease the latency of interactive tasks, but the cpu
>> > percentage should remain close to the same for equal "nice" tasks.
>>
>>There are at least two possible ways of viewing "nice": one of these is
>>that it is an indicator of the tasks entitlement to CPU resource (which
>>is more or less the view you describe) and another that it is an
>>indicator of the task's priority with respect to access to CPU resources.
>>
>>If you wish the system to take the first of these views then the
>>appropriate solution to the scheduling problem is to use an entitlement
>>based scheduler such as EBS (see
>><http://sourceforge.net/projects/ebs-linux/>) which is also much simpler
>>than the current O(1) scheduler and has the advantage that it gives
>>pretty good interactive responsiveness without treating interactive
>>tasks specially (although some modification in this regard may be
>>desirable if very high loads are going to be encountered).
>>
>>If you want the second of these then this proposed modification is a
>>simple way of getting it (with the added proviso that starvation be
>>avoided).
>>
>>Of course, there can be other scheduling aims such as maximising
>>throughput where different scheduler paradigms need to be used.  As a
>>matter of interest these tend to have not very good interactive response.
>>
>>If the system is an interactive system then all of these models (or at
>>least two of them) need to be modified to "break the rules" as far as
>>interactive tasks are concerned and give them higher priority in order
>>not to try human patience.
>>
>> > Interactive tasks need low scheduling latency and short bursts of high
>> > cpu usage; not more cpu usage overall. When the cpu percentage
>>
>>differs > significantly from this the logic has failed.
>>
>>The only way this will happen is if the interactive bonus mechanism
>>misidentifies a CPU bound task as an interactive task and gives it a
>>large bonus.  This seems to be the case as tasks with a 95% CPU demand
>>rate are being given a bonus of 9 (out of 10 possible) points.
> 
> 
> This is all a matter of semantics and I have no argument with it.
> 
> I think your aims of simplifying the scheduler are admirable but I hope you 
> don't suffer the quagmire that is manipulating the interactivity stuff. 

As you surmise, this patch is just a starting point and there are some 
parts of it the may need to be fine tuned.

For instance, the current time slice used is set at the average that the 
current mechanism would have dispensed.  Making this smaller would 
lessen the severity of the anomaly under discussion but making it too 
small would increase the context switch rate.  There is evidence from 
our kernbench results that we have room to decrease this value and still 
keep the context switch rate below that of the current scheduler (at 
least, for normal to moderately heavy loads).  If possible I'd like to 
get some statistics on the sleep/wake cycles of tasks on a typical 
system to help make a judgment about what is the best value here.

Another area that needs more consideration is the determination of the 
promotion interval.  At the moment, there's no promotion if there's less 
than 2 runnable tasks on a CPU and the interval is a constant multiplied 
by the number of runnable tasks otherwise.

Another area of investigation is (yet another) bonus intended to 
increase system throughput by minimizing (or at least attempting to) the 
time tasks spend on the run queues.  The principal difficulty here is 
making sure that this doesn't adversely effect interactive 
responsiveness as it's an unfortunate fact of life that what's good for 
interactive response isn't necessarily (and usually isn't) good for 
maximizing throughput and vice versa.

Then, the interactive bonus mechanism might be examined but this is of 
low priority as the current one seems to do a reasonable job.

Lastly, with the simplification of the scheduler I believe that it would 
be possible to make both the interactive response and throughput bonuses 
optional.  An example of why this MIGHT BE desirable is that the 
interactive response bonus adversely effects throughput and turning it 
off on servers where there are no interactive users may be worthwhile.

> Changing one value and saying it has no apparent effect is almost certainly 
> wrong; surely it was put there for a reason - or rather I put it there for a 
> reason.

Out of interest, what was the reason?  What problem were you addressing?

Peter
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

