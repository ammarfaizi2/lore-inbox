Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRKHPWA>; Thu, 8 Nov 2001 10:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273364AbRKHPVv>; Thu, 8 Nov 2001 10:21:51 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:16393 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S273305AbRKHPVk>; Thu, 8 Nov 2001 10:21:40 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] scheduler cache affinity improvement for 2.4 kernels
Date: Thu, 8 Nov 2001 07:22:09 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBEEPMEAAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can think of some circumstances where one would want the *opposite* of
this patch. Consider a "time-sharing" system running both CPU-intensive
"batch" tasks and "interactive" tasks. There is going to be a tradeoff
between efficiency / throughput of the batch tasks and the response times of
interactive ones. From the point of view of the owner of an interactive
task, the CPU-intensive task should be penalized -- forced to load its cache
over and over and over -- rather than being favored by the OS because it's
more "efficient" to reuse the cache. The owner of the CPU-intensive batch
task, on the other hand, will like this patch -- *he* gets his job done
sooner.

The "traditional" way to deal with this issue is to adjust the time slice.
Larger time slices favor the batch jobs and make the system more efficient.
Smaller time slices make the system less efficient and increase context
switching and its associated overhead, but improve interactive response
time. Typically one starts with the default time slice and makes it smaller
gradually until an acceptable interactive response time is obtained.
--
"Suppose that tonight, while you sleep, a miracle happens - you wake up
tomorrow with what you have longed for. How will you discover that a miracle
happened? How will your loved ones? What will be different? What will you
notice? What do you need to explode into tomorrow with grace, power, love,
passion and confidence?" -- Michael Hall, PhD

M. Edward (Ed) Borasky
Relax! Run Your Own Brain with Neuro-Semantics!
http://www.borasky-research.net/Flyer.htm
mailto:znmeb@borasky-research.net
http://groups.yahoo.com/group/pdx-neuro-semantics


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ingo Molnar
> Sent: Thursday, November 08, 2001 6:30 AM
> To: Linus Torvalds
> Cc: linux-kernel@vger.kernel.org; Alan Cox
> Subject: [patch] scheduler cache affinity improvement for 2.4 kernels
>
>
>
> i've attached a patch that fixes a long-time performance problem in the
> Linux scheduler.
>
> it's a fix for a UP and SMP scheduler problem Alan described to me
> recently, the 'CPU intensive process scheduling' problem. The essence of
> the problem: if there are multiple, CPU-intensive processes running,
> intermixed with other scheduling activities such as interactive work or
> network-intensive applications, then the Linux scheduler does a poor job
> of affinizing processes to processor caches. Such scheduler workload is
> common for a large percentage of important application workloads: database
> server workloads, webserver workloads and math-intensive clustered jobs,
> and other applications.
>
> If there are CPU-intensive processes A B and C, and a scheduling-intensive
> X task, then in the stock 2.4 kernels we end up scheduling in the
> following way:
>
>     A X A X A ... [timer tick]
>     B X B X B ... [timer tick]
>     C X C X C ... [timer tick]
>
> ie. we switch between CPU-intensive (and possibly cache-intensive)
> processes every timer tick. The timer tick can be 10 msec or shorter,
> depending on the HZ value.
>
> the intended length of the timeslice of such processes is supposed to be
> dependent on their priority - for typical CPU-intensive processes it's 100
> msecs. But in the above case, the effective timeslice of the
> CPU/cache-intensive process is 10 msec or lower, causing potential cache
> trashing if the working set of A, B and C are larger than the cache size
> of the CPU but the invidivual process' workload fits into cache.
> Repopulating a large processor cache can take many milliseconds (on a 2MB
> on-die cache Xeon CPU it takes more than 10 msecs to repopulate a typical
> cache), so the effect can be significant.
>
> The correct behavior would be:
>
>     A X A X A ... [10 timer ticks]
>     B X B X B ... [10 timer ticks]
>     C X C X C ... [10 timer ticks]
>
> this is in fact what happens if the scheduling acitivity of process 'X'
> does not happen.
>
> solution: i've introduced a new current->timer_ticks field (which is not
> in the scheduler 'hot cacheline', nor does it cause any scheduling
> overhead), which counts the number of timer ticks registered by any
> particular process. If the number of timer ticks reaches the number of
> available timeslices then the timer interrupt marks the process for
> reschedule, clears ->counter and ->timer_ticks. These 'timer ticks' have
> to be correctly administered across fork() and exit(), and some places
> that touch ->counter need to deal with timer_ticks too, but otherwise the
> patch has low impact.
>
> scheduling semantics impact: this causes CPU hogs to be more affine to the
> CPU they were running on, and will 'batch' them more agressively - without
> giving them more CPU time than under the stock scheduler. The change does
> not impact interactive tasks since they grow their ->counter above that of
> CPU hogs anyway. It might cause less 'interactivity' in CPU hogs - but
> this is the intended effect.
>
> performance impact: this field is never used in the scheduler hotpath.
> It's only used by the low frequency timer interrupt, and by the
> fork()/exit() path, which can take an extra variable without any visible
> impact. Also some fringe cases that touch ->counter needed updating too:
> the OOM code and RR RT tasks.
>
> performance results: The cases i've tested appear to work just fine, and
> the change has the cache-affinity effect we are looking for. I've measured
> 'make -j bzImage' execution times on an 8-way, 700 MHz, 2MB cache Xeon
> box. (certainly not a box whose caches are easy to trash.) Here are 6
> successive make -j execution times with and without the patch applied. (To
> avoid pagecache layout and other effects, the box is running a modified
> but functionally equivalent version of the patch which allows runtime
> switching between the old and new scheduler behavior.)
>
> stock scheduler:
>
>   real    1m1.817s
>   real    1m1.871s
>   real    1m1.993s
>   real    1m2.015s
>   real    1m2.049s
>   real    1m2.077s
>
> with the patch applied:
>
>   real    1m0.177s
>   real    1m0.313s
>   real    1m0.331s
>   real    1m0.349s
>   real    1m0.462s
>   real    1m0.792s
>
> ie. stock scheduler is doing it in 62.0 seconds, new scheduler is doing it
> in 60.3 seconds, a ~3% improvement - not bad, considering that compilation
> is exeucting 99% in user-space, and that there was no 'interactive'
> activity during the compilation job.
>
> - to further measure the effects of the patch i've changed HZ to 1024 on a
> single-CPU, 700 MHz, 2MB cache Xeon box, which improved 'make -j' kernel
> compilation times by 4%.
>
> - Compiling just drivers/block/floppy.c (which is a cache-intensive
> operation) in parallel, with a constant single-process Apache network load
> in the background shows a 7% improvement.
>
> This shows the results we expected: with smaller timeslices, the effect of
> cache trashing shows up more visibly.
>
> (NOTE: i used 'make -j' only to create a well-known workload that has a
> high cache footprint. It's not to suggest that 'make -j' makes much sense
> on a single-CPU box.)
>
> (it would be nice if those people who suspect scalability problems in
> their workloads, could further test/verify the effects this patch.)
>
> the patch is against 2.4.15-pre1 and boots/works just fine on both UP and
> SMP systems.
>
> please apply,
>
> 	Ingo
>

