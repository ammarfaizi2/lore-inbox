Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbVIOWgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbVIOWgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbVIOWgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:36:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39676 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965294AbVIOWga
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:36:30 -0400
Message-ID: <4329F733.2090604@mvista.com>
Date: Thu, 15 Sep 2005 15:35:31 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: john stultz <johnstul@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: 2.6.13-rt6, ktimer subsystem
References: <20050913100040.GA13103@elte.hu>  <43287C52.7050002@mvista.com> <1126751140.6509.474.camel@tglx.tec.linutronix.de>
In-Reply-To: <1126751140.6509.474.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Wed, 2005-09-14 at 12:38 -0700, George Anzinger wrote:
> 
> 
>>Well, having spent a bit of time looking at the code it appears that a 
>>lot of the ideas we looked at and discarded (see 
>>high-res-timers-discourse@lists.sourceforge.net) are in this.  Shame it 
>>was all done with out reference or comment to that list, anyone on it or 
>>even the lkml.
> 
> 
> Well, I'm considering to wear sackcloth and ashes. But this seems like
> the pot calling the kettle back as I don't remember a single relevant
> reference/comment from you on the UTIME/KURT mailing list after your
> UTIME->HRT fork.

Hm...All the work has been on HRT mailing list.  In the early days the 
UTIME/KURT folks were on the list, still may be for all I know.

Still, as much as sackcloth and ashes might become you or me, I would 
rather try to learn how to be more open about what we are doing so that 
what results is the best possible for the linux community.
> 
> 
>>A few of the top issues:
>>
>>time in nanoseconds 64-bits, requires a divide to do much of anything 
>>with it.  Divides are slow and should be avoided if possible.  
> 
> 
> The divides are rare and definitely not in the hot paths. I'm sure that
> they can be replaced by some intelligent scaled math algorithm if it
> turns out to be necessary. The hot path instructions are simple
> add/sub/cmp which are less/equal expensive on a 32bit machine to an
> operation on struct timespec or an jiffies/arch_cycles pair. The non
> nsec based implementation gives a burden to 64bit machines and is
> provable wrong in the aspect of summing rounding errors of interval
> timers. 

With out arguing with your "provable wrong", I will admit that the 
64-bit LOOKS good and easy.  At the same time I think we can abstract 
all the required actions on the "nstime" thing and set it up so we can 
use either a timespec or a s64 depending on the machine (or some such). 
  I have such a patch nearly ready...
> 
> 
~
> 
>>The rbtree is a high overhead tree.  I suspect performance problems 
>>here.  
> 
> 
> 1. rbtree is available out of the box

True.
> 
> 2. rbtree is proven to be efficient - at least there are a couple of
> performance relevant users relying on it e.g. mm, ext3
> 
> 3. I did insertion/removal tests with 10k entries (<2us on a 1GHz box in
> user space). This is way below the experienced and reproducible trouble
> of recascading. The penalty is completely on the thread which owns the
> timer for non signal related functions. For signal related functions
> only the removal on expiry is a penalty for the complete system (in the
> softirq)

Well, I never was a cascade fan.

In the early HRT patches the whole timer list was replaced with a hashed 
list.  It was O(N/M) on insertion where we could easily choose M (for a 
while it was even a config option).  Removal was just an unlink, same as 
the cascade list.

To be clear on my take on this, as I understand it the rblist is 
something like O(N*somelog 2).  What is left out here is the fixed 
overhead of F which is there even if N = 1.  So we have something like 
(F+O(f(N)) for a list.  For the most part we don't look at F, but as 
list complexity grows, it gets larger thus pushing out the cross over 
point to a higher "N" when comparing two lists.  I considered the rbtree 
when doing the secondary list for HRT and concluded that "N" was small 
enough that a simple O(N/2) list would do just fine as it would only 
contain timers set to expire in the next jiffie.

I don't think an O(N/2) list is right for all timers (as in the 
ktimers), but I still wonder if there isn't something better than and 
rblist.  Note, "wonder".  I don't have such a list structure in hand.
> 
> The cascading is a penalty for the complete system all the time.
> 
> Performance is a straw man argument here. You know very well that > 90%
> of the timers are inaccurate "timeout" timers related to I/O,
> networking, devices. Most of those never expire (the positive feedback
> removes the timer before expiry) and those timers have no constraint to
> be accurate, except for the fact that they have to detect an
> device/network problem at some time. In this case it is completely
> irrelevant whether the timeout occurs n msecs earlier or later.

I agree, but it not accuracy that I am arguing, but cpu cycles.  Those 
we use in the kernel are not available for the user.
> 
> 
>>If it is the right answer here, then why not use it for normal 
>>timers?  A list of timers is a rather unique thing and, I think, 
>>deserves a management structure that accounts for the fact that the 
>>elements in the tree are perishable.
> 
> 
> The first goal was to separate out the timers from the timeout API and I
> believe that this separation is necessary. 
> 
> The implementation of ktimers is not at all restricted to the timers we
> addressed for now, it can also be utilized for the timeout API without
> much effort. 
> 
> The performance improvement is enormous despite the alleged 64bit math
> overhead.
> 
> Testcase on a 600MHz CeleronM, 512MB RAM:
> 
> 16 cyclic SCHED_FIFO tasks using clock_nanosleep(ABSTIME)
> base interval = 1000 us, offset per task = 50 us 
> tracing each latency value to disk
> 
> 16 cyclic SCHED_OTHER tasks using clock_nanosleep(ABSTIME)
> base interval = 1000 us, offset per task = 500 us
> tracing each latency value to disk
> 
> while true; do hackbench 50; done
> cat /dev/hda | nc atlas 4711
> 
> This injects a (insane) load avg of >600 permantely
> 
> 2.6.13-rt4 (cascade based implementation)
> 16 cyclic SCHED_FIFO tasks using clock_nanosleep(ABSTIME)
> 
> task	loops		min	max	average	sigma	prio
> 0	      999999	5	869	19	20	80
> 1	      999999	9	883	18	22	79
> 2	      999999	9	927	19	23	78
> 3	      999999	5	908	21	28	77
> 4	      999999	0	1056	22	33	76
> 5	      999999	0	973	23	33	75
> 6	      999999	0	926	23	33	74
> 7	      999999	1	893	24	33	73
> 8	      999999	2	942	23	34	72
> 9	      999999	1	868	24	34	71
> 10	      999999	0	912	23	34	70
> 11	      999999	0	911	28	46	69
> 12	      999999	0	912	28	46	68
> 13	      999999	9	967	28	46	67
> 14	      999999	9	954	28	46	66
> 15	      999999	9	946	28	46	65
> 
> 
> 2.6.13-rt11 (ktimers based implementation)
> 16 cyclic SCHED_FIFO tasks using clock_nanosleep(ABSTIME)
> 
> task	loops		min	max	average	sigma	prio
> 0	      999999	9	76	20	4	80
> 1	      999999	8	84	20	4	79
> 2	      999999	8	98	21	4	78
> 3	      999999	9	121	20	4	77
> 4	      999999	8	124	20	4	76
> 5	      999999	9	140	20	4	75
> 6	      999999	10	103	22	5	74
> 7	      999999	9	99	21	5	73
> 8	      999999	8	95	21	5	72
> 9	      999999	9	148	21	5	71
> 10	      999999	9	141	22	6	70
> 11	      999999	9	143	22	5	69
> 12	      999999	8	129	20	4	68
> 13	      999999	9	149	21	5	67
> 14	      999999	9	135	21	5	66
> 15	      999999	8	230	22	5	65

I confess I don't understand the above numbers.  What are min and max 
and in what units?  Are you saying the large max numbers are caused by 
the cascade?
> 
> 
> 
>>It appears that the "monotonic_clock" is being used to drive ktimers. 
>>The "monotonic_clock" was NEVER meant to poke outside of the kernel.  It 
>>is a raw kernel clock that is only required to be monotonic with nothing 
>>said about accuracy.  It should NOT be confused with CLOCK_MONOTONIC 
>>which is directly tied to xtime and therefor is ntp corrected.
> 
> 
> I'm well aware of that and this is a completely different playground. 
> 
> The ktimers implementation is _independent_ of the clock sources. The
> current clock source implementation may suck, but thats not a problem of
> ktimers at all. Its a problem of arch/XXX/timeYY and kernel/time.c. I
> did not spend too much time on that as John Stultz is working on the
> timesource and timeofday stuff and I really hope that this gets
> accepted.
> 
> The relation ship of clock sources and their accuracy is also a
> worthwhile field of discussion.
> 
> 
>>These are only the concerns I have from having a rather quick look at 
>>the code.  I am sure that there are other issues...
> 
> 
> It would be hubristic to deny that :)
> 
> OTH, 
> 
> - The posix timer tests run all successful, except the broken 2timertest
> which fails on any other HRT kernel too and the sleep to long for real
> timers when the clock is set backwards, which is easily solvable
> (working on that).

Your mileage seems to differ from mine.  Here is what I get from ./do_test:
The following tests failed:
clock_nanosleeptest
abs_timer_test
4-1
clock_settimetest
clock_gettimetest2
2timer_test 



Then, on the second run, it crashed in an attempt to get the monotonic 
clock (a divide error).  System is a dual PIII, 800Mhz.  This from the 
rt11 patch.
> 
> - The performance improvements in combination with simpler code is an
> argument of itself

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
