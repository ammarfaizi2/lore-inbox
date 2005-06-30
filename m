Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVF3TIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVF3TIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVF3TIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:08:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:28136 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262942AbVF3THz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:07:55 -0400
Subject: Re: [patch 1/] timers: tsc using for cpu scheduling
From: john stultz <johnstul@us.ibm.com>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>
In-Reply-To: <6EDC9204B3704C4C8522539D5C1185E5019D060F@mssmsx403.ccr.corp.intel.com>
References: <6EDC9204B3704C4C8522539D5C1185E5019D060F@mssmsx403.ccr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 12:07:48 -0700
Message-Id: <1120158468.24889.150.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 15:43 +0400, Ananiev, Leonid I wrote:
> 		Patch for using TSC but not PMT in cpu scheduler.
> 
> 	It was noted that under high memory load the process which
> generates a lot page faults does not lose own priority at all if
> processor has Power Management Timer (PMT) and for this reason Linux
> uses jiffies_64 for process priority calculation instead of Time Stamp
> Clock (TSC). As a result time is measured with 1000000 nsec granularity:

[snip]

> 	If process regularly uses processor much less than 1 msec
> scheduler does not see processor using by this process and does not
> decrease priority of process as it is performed on platforms which have
> not PMT or PMT using is suppressed in .config file. The "list of timers,
> ordered by preference" in linux kernel dictates to use Power Management
> timer, if it is on processor and measure process run time in
> milliseconds (jiffies) actually but not in nanoseconds. As a result the
> process which provoke to memory threshing and bad cpu and cash using has
> much higher priority than regular interactive process. You can see that
> cpu using time grows (it is measured by other way - not by function
> sched_clock()) but priority is not bring down and the process is
> considered as high priority interactive one.


So let me try to restate the problem, and you can let me know if I'm
misunderstanding you.

When the TSC is not used for timekeeping, sched_clock() uses jiffies to
measure time. This results in very course 1ms (or really 1/HZ)
granularity from sched_clock().

This course granularity is causing issues in the scheduler, as best that
I can understand, where processes that cause lots of pagefaults are not
properly dinged for their time.

Is that about right?


> It is known that TSC is incorrect according to astronomical real time as
> a result of PM throttling. But for scheduler purposes the value of work
> executed for each process but not real time spent on cpu makes sense.
> The scheduler actually does not consider process run time as a real
> time: it uses division of variable run_time  on CURRENT_BONUS before
> comparison it with sleep average time:
> 			run_time /= CURRENT_BONUS;
> 			task->sleep_avg -= run_time;
> 	So run_time is not a real time but some measure of cpu work
> which is performed for current process and we have the right and have to
> use TSC for scheduler purpose if TSC is there on processor and does
> function. 


Well, not quite. First of all, I believe (Dominik would know better)
that not all CPUs that support frequency scaling actually modify their
TSC frequency. So in some cases the TSC is time and in others it is
work.

Further, there are other cases where the TSC cannot be used for
sched_clock, such as on systems that do not have TSCs, and NUMA systems
where the TSCs are not synched. 



> Proposed patch makes corresponding modifications. The
> multiplier value which is used for converting TSC ticks to nanoseconds
> in function cycles_2_ns() may be corrected when cpu frequency is changed
> and so scheduler will use ajusted time.  


You're patch removes any fallback for the case where the TSC cannot be
used.



> But it is not necessarily if we
> agree to measure processor work but not processor time for scheduling.
> If CPU clock speed is variable (PM throttling) it is more correctly to
> use TSC for processor work performed for each process measuring.
> If PMT and jiffies is used for scheduler, some times run_time will be
> increased by 1,000,000 nanoseconds if between begin and end scheduler
> time marks the variable jiffies_64 is increased. It seams that run_time
> will be correct on average. It is not so because the events 'mark begin
> run' and 'jiffies increase' are not independent. They are very
> dependant. Task gets CPU just after jiffies modification.


For i386 sched_clock() is quite broken on cpufreq scaling systems
anyway, as it uses the cyc2ns code (which was borrowed from the TSC's
monotonic_clock interface) against the raw TSC value. When the cyc2ns
multiplier changes it applys the new value to the full TSC count, rather
then just the interval at which the cpu has been running at the new
frequency. This can cause sched_clock to jump forwards and backwards in
time. 

I'm not a scheduler head, but my understanding was that sched_clock()
wasn't given *too* much weight in scheduling decisions, as it is
expected to give crazy values every once in a while.

If sched_clock()'s semantics need to change, that's fine with me, but it
should probably be consistent across all the arches, so this would need
to be discussed with other arches that have cpufreq scaling.

Maybe is there not a better way other then using sched_clock to ding
processes that are causing pagefaults?


> The patch for using TSC in sched_clock() function is divided on two
> parts: first part moves duplicated code lines from  timer_tsc.c and
> timer_hpet.c to common.c. 

Removing the duplicated code probably isn't a bad idea. 


> Second patch deletes global variable use_tsc;
> makes function sched_clock() to use TSC only. . Now the variable
> cyc2ns_scale may be used instead of use_tsc because this variable is not
> 0 if kernel had tested TSC successfully.

This I don't agree with because there are situations where we cannot use
the TSC.

thanks
-john



