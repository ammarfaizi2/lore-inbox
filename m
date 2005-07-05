Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVGERKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVGERKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 13:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVGERKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 13:10:36 -0400
Received: from petasus.ims.intel.com ([62.118.80.130]:63210 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S261893AbVGERIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 13:08:18 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/] timers: tsc using for cpu scheduling
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 5 Jul 2005 21:08:01 +0400
Message-ID: <6EDC9204B3704C4C8522539D5C1185E501A349FA@mssmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/] timers: tsc using for cpu scheduling
Thread-Index: AcV9pwj+N3v51impToeRbZ6QbPtxKAD1vahQ
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "john stultz" <johnstul@us.ibm.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.de>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       "Semenikhin, Sergey V" <sergey.v.semenikhin@intel.com>
X-OriginalArrivalTime: 05 Jul 2005 17:08:03.0195 (UTC) FILETIME=[1A9ADCB0:01C58184]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

	Not only page faults may increase process priority. Someone can
write two threads with mutexes so that each thread will spent much less
than 1 msec for calculations on cpu than lock-unlock mutexes and yield
cpu to brother which wait mutex unlock and will do the same. Both
threads will have high priority according to other threads during
infinite time. The scheduler will not see the time spent by both
considered threads on cpu.
	The cpu scheduler does not need in real time value. It is need
the number of cpu clocks spent for considered task/thread for priority
calculation. It is not need to modify TSC tick rate for cpu scheduling.
	The TSC can be used for priority calculation in NUMA because we
do not compare TSCs of different cpu's. 

> there are other cases where the TSC cannot be used for
> sched_clock, such as on systems that do not have TSCs...

> You're patch removes any fallback for the case where the TSC cannot be
used.
No. Now there is two global kernel values: cyc2ns_scale and use_tsc.
We may say that
 	use_tsc = (cyc2ns_scale != 0);
Now instead of 
 'if (use_tsc) than ...'
					I propose to write
 'if ((cyc2ns_scale != 0) than...'

> This I don't agree with because there are situations where we cannot
use
the TSC.

The patch says that if there are PMT and TSC timers concurrently than
Linux will use TSC for CPU scheduler priority calculatin.
1 millisecond jiffies on the base of PMT were used patch in Linux before
this. So user can see that if CPU has TSC it is worst than CPU which has
not TSC because Linux choose slightly more precise but exactly 1000000
times more gross variant in this case.

Leonid


-----Original Message-----
From: john stultz [mailto:johnstul@us.ibm.com] 
Sent: Thursday, June 30, 2005 11:08 PM
To: Ananiev, Leonid I
Cc: lkml; Dominik Brodowski
Subject: Re: [patch 1/] timers: tsc using for cpu scheduling

On Thu, 2005-06-30 at 15:43 +0400, Ananiev, Leonid I wrote:
> 		Patch for using TSC but not PMT in cpu scheduler.
> 
> 	It was noted that under high memory load the process which
> generates a lot page faults does not lose own priority at all if
> processor has Power Management Timer (PMT) and for this reason Linux
> uses jiffies_64 for process priority calculation instead of Time Stamp
> Clock (TSC). As a result time is measured with 1000000 nsec
granularity:

[snip]

> 	If process regularly uses processor much less than 1 msec
> scheduler does not see processor using by this process and does not
> decrease priority of process as it is performed on platforms which
have
> not PMT or PMT using is suppressed in .config file. The "list of
timers,
> ordered by preference" in linux kernel dictates to use Power
Management
> timer, if it is on processor and measure process run time in
> milliseconds (jiffies) actually but not in nanoseconds. As a result
the
> process which provoke to memory threshing and bad cpu and cash using
has
> much higher priority than regular interactive process. You can see
that
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


> It is known that TSC is incorrect according to astronomical real time
as
> a result of PM throttling. But for scheduler purposes the value of
work
> executed for each process but not real time spent on cpu makes sense.
> The scheduler actually does not consider process run time as a real
> time: it uses division of variable run_time  on CURRENT_BONUS before
> comparison it with sleep average time:
> 			run_time /= CURRENT_BONUS;
> 			task->sleep_avg -= run_time;
> 	So run_time is not a real time but some measure of cpu work
> which is performed for current process and we have the right and have
to
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
> in function cycles_2_ns() may be corrected when cpu frequency is
changed
> and so scheduler will use ajusted time.  


You're patch removes any fallback for the case where the TSC cannot be
used.



> But it is not necessarily if we
> agree to measure processor work but not processor time for scheduling.
> If CPU clock speed is variable (PM throttling) it is more correctly to
> use TSC for processor work performed for each process measuring.
> If PMT and jiffies is used for scheduler, some times run_time will be
> increased by 1,000,000 nanoseconds if between begin and end scheduler
> time marks the variable jiffies_64 is increased. It seams that
run_time
> will be correct on average. It is not so because the events 'mark
begin
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
> cyc2ns_scale may be used instead of use_tsc because this variable is
not
> 0 if kernel had tested TSC successfully.

This I don't agree with because there are situations where we cannot use
the TSC.

thanks
-john



