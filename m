Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbULIWBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbULIWBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbULIWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:01:14 -0500
Received: from bos-gate3.raytheon.com ([199.46.198.232]:13683 "EHLO
	bos-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261636AbULIWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:00:24 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF8ABCEBAC.0259E37D-ON86256F65.00727E98@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 15:58:39 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 03:58:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>on SMP, latencytest + all IRQ threads (and ksoftirqd) at prio 99 +
>PREEMPT_RT is not comparable to PREEMPT_DESKTOP (with no IRQ threading).
Of course they are comparable. You may not consider it a FAIR
comparison, but they are comparable. I maintain the comparison shows
the increased overhead of IRQ threading - you maintain it is an
"inverse scenario" which I don't buy.

>The -RT kernel will 'split' hardirq and softirq workloads and migrate
>them to different CPUs - giving them a higher total throughput. Also, on
>PREEMPT_DESKTOP the IRQs will most likely go to one CPU only, and most
>softirq processing will be concentrated on that CPU too. Furthermore,
>the -RT kernel will agressively distribute highprio RT tasks.
Now wait a minute, how does -RT do that IRQ splitting? From what I recall
(I don't have RT up right now) taskset indicated all the IRQ tasks were
wired to CPU 0 and the only opportunity for splitting was with
ksoftirqd/0 and /1. I confirmed that by looking at the "last CPU" in top.

When I tried to change the CPU affinity of those IRQ tasks (to use both
CPU's), I got error messages. One of the responses you made at that
time was...
>> If setting it to 3 is REALLY BAD, perhaps we should prevent it.
>
>it's just like setting ksoftirqd's affinity. I agree that it's nasty,
>but there's no easy way right now.
Has this behavior changed in the last three weeks?

For a CONFIG_DESKTOP data point, let's take a look at the latency traces
I just made from -12PK.
  CPU 0 - 10, 14, 16 - 38, 40 - 43,
  CPU 1 - 00 - 09, 11 - 13, 15, 39, 44
let's see - 45 total traces, 29 for CPU 0 and 16 for CPU 1. Not quite
evenly balanced but not all on one CPU either (the data IS bursty though).
The common_interrupt trace appears to show up only on CPU 0, but the
latency traces are definitely on both CPU's.

>latencytest under your priority setup measures an _inverse_ scenario. (a
>CPU hog executing at a lower priority than all IRQ traffic) I'd not be
>surprised at all if it had higher latencies under -RT than under
>PREEMPT_DESKTOP.
Why "higher latencies"? And do you mean
 - more short latencies (I'm counting a lot of just over 100 usec delays)
OR
 - longer overall latencies (which I am not expecting but seeing)
OR
something else?

Let's look at the possible scenarios:
[PK refers to "Preemptible Kernel - PREEMPT_DESKTOP" w/o IRQ threading]
[RT refers to PREEMPT_RT with the IRQ # and ksoftirqd/# threads at RT 99]
 [1] A single interrupt comes in and latencytest is NOT on the CPU
that services the interrupt. In the case of PK, latencytest is
unaffected. In the case of RT, latencytest is affected ONLY if the
IRQ # thread or ksoftidqd/# thread is on the CPU with latencytest.
In that case, latencytest is pushed to the other CPU. That switch
takes some TBD amount of time and is counted by latencytest only if
it exceeds 100 usec.
 [2] A single interrupt comes in and latencytest is on the CPU that
services the interrupt. In the case of PK, latencytest is preempted
for the duration of the interrupt and resumes. In the case of RT,
latencytest is rescheduled on the other CPU (or not) once we reach the
place where we are ready to thread the IRQ. I would think RT should do
better in this case but am not sure.
 [3] A series of interrupts comes in. In PK what I see is several
sequential delays up to 1/2 msec or so (and have traces that show that
behavior). In RT I would expect a shorter latency period (if both CPU's
are busy with IRQ's or not) than PK [though I don't have traces for
this since if I cross CPU's the trace doesn't get recorded].

I don't see how RT should have worse numbers in these scenarios
unless the overhead is more (or I'm counting more trivial latencies)
than in PK. I would expect to see in the RT case a shorter maximum
delay (which alas I do NOT see).

>It's not clear-cut which one 'wins' though: because
>even this inverse scenario will have benefits in the -RT case: due to
>SCHED_OTHER workloads not interfering with this lower-prio RT task as
>much. But i'd expect there to be a constant moving of the 'benchmark
>result' forward and backwards, even if -RT only improves things - this
>is the nature of such an inverse priority setup.

Not quite sure what you mean by this.

>so this setup generates two conflicting parameters which are inverse to
>each other, and the 'sum' of these two parameters ends up fluctuating
>wildly. Pretty much like the results you are getting. The two parameters
>are: latency of the prio 30 task, and latency of the highprio tasks. The
>better the -RT kernel gets, the better the prio 30 tasks's priorities
>get relative to SCHED_OTHER tasks - but the worse they also get, due to
>the better handling of higher-prio tasks. Where the sum ends, whether
>it's a "win" or a "loss" depends on the workload, how much highprio
>activity the lowprio threads generate, etc.
I don't see how this rationale is relevant - the amount of work for IRQ
activities that is generated by each workload should be similar. Its
one of the reasons I run the same tests over and over again.

If I create a 750 Mbyte file (one of the stress test cases), I should be
doing a series of disk writes and interrupts. Both RT and PK should do
about the same work to create that file. So the overhead on latencytest
should be about the same for both RT and PK. If the overhead is
not the same, something is wrong.

If I look at the max latency:
  RT 3.90
  PK 1.91  (both cases nominal is 1.16 msec)
>From the scenarios I described above, I don't see why this result should
have occurred. Certainly nothing that should cause a delay of over
two msec on a roughly one msec task.

If I look at the % within 100 usec measure:
  RT 87% within 100 usec, 97% within 200 usec (360 seconds elapsed)
  PK 67% within 100 usec, 96% within 200 usec (57 seconds elapsed)
[note 250,000 samples in 360 seconds is 694 samples per second]
>From a percentage point of view, this looks bad for PK but if I
factor in the elapsed time I get...
 - PK interrupted latencytest about 13000 times
 - RT interrupted latencytest about 32000 times
I am not sure how much of this is due to the workload (disk writes)
or due to the elapsed time aspects.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

