Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbULIW73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbULIW73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbULIW73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:59:29 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42392 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261657AbULIW7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:59:14 -0500
Date: Thu, 9 Dec 2004 23:55:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209225555.GA31588@elte.hu>
References: <OF8ABCEBAC.0259E37D-ON86256F65.00727E98@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8ABCEBAC.0259E37D-ON86256F65.00727E98@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> When I tried to change the CPU affinity of those IRQ tasks (to use both
> CPU's), I got error messages. One of the responses you made at that
> time was...
> >> If setting it to 3 is REALLY BAD, perhaps we should prevent it.
> >
> >it's just like setting ksoftirqd's affinity. I agree that it's nasty,
> >but there's no easy way right now.
> Has this behavior changed in the last three weeks?

nope, you are right, PK and RT should be more or less comparable.

the moment we get a proper trace of one such 3msec delay we ought to see
what's happening.

> For a CONFIG_DESKTOP data point, let's take a look at the latency traces
> I just made from -12PK.
>   CPU 0 - 10, 14, 16 - 38, 40 - 43,
>   CPU 1 - 00 - 09, 11 - 13, 15, 39, 44
> let's see - 45 total traces, 29 for CPU 0 and 16 for CPU 1. Not quite
> evenly balanced but not all on one CPU either (the data IS bursty though).
> The common_interrupt trace appears to show up only on CPU 0, but the
> latency traces are definitely on both CPU's.

havent gotten these yet, but from your description i'd guess that the
CPU#1 latencies would be softirq processing latencies (those occur on
both CPUs).

> > latencytest under your priority setup measures an _inverse_ 
> > scenario. (a CPU hog executing at a lower priority than all IRQ 
> > traffic) I'd not be surprised at all if it had higher latencies 
> > under -RT than under PREEMPT_DESKTOP.
>
> Why "higher latencies"? And do you mean
>  - more short latencies (I'm counting a lot of just over 100 usec delays)
> OR
>  - longer overall latencies (which I am not expecting but seeing)
> OR
> something else?

i meant "longer overall latencies" - but this was based on the mistaken
theory of IRQ threads wandering between CPUs, which they dont do.

> Let's look at the possible scenarios:
> [PK refers to "Preemptible Kernel - PREEMPT_DESKTOP" w/o IRQ threading]
> [RT refers to PREEMPT_RT with the IRQ # and ksoftirqd/# threads at RT 99]

>  [1] A single interrupt comes in and latencytest is NOT on the CPU
> that services the interrupt. In the case of PK, latencytest is
> unaffected. In the case of RT, latencytest is affected ONLY if the
> IRQ # thread or ksoftidqd/# thread is on the CPU with latencytest.
> In that case, latencytest is pushed to the other CPU. That switch
> takes some TBD amount of time and is counted by latencytest only if
> it exceeds 100 usec.

i'd say that such a bounce doesnt happen on RT either, because, as
you've found out, all IRQ threads are bound to CPU#0.

>  [2] A single interrupt comes in and latencytest is on the CPU that
> services the interrupt. In the case of PK, latencytest is preempted
> for the duration of the interrupt and resumes. In the case of RT,
> latencytest is rescheduled on the other CPU (or not) once we reach the
> place where we are ready to thread the IRQ. I would think RT should do
> better in this case but am not sure.

yes, in the RT case latencytest should be pushed to the other CPU most 
of the time. (unless a higher-prio [ksoftirqd] task is running on the 
other CPU)

>  [3] A series of interrupts comes in. In PK what I see is several
> sequential delays up to 1/2 msec or so (and have traces that show that
> behavior). In RT I would expect a shorter latency period (if both CPU's
> are busy with IRQ's or not) than PK [though I don't have traces for
> this since if I cross CPU's the trace doesn't get recorded].

wrt. the 'trace doesnt get recorded' issue, it ought to work fine if you
have wakeup_timing enabled. (even when using user-triggered tracing.) 
I.e. your user task should be traced across migrations too. (if not then
it's a tracer bug.)

> I don't see how RT should have worse numbers in these scenarios unless
> the overhead is more (or I'm counting more trivial latencies) than in
> PK. I would expect to see in the RT case a shorter maximum delay
> (which alas I do NOT see).

yep, i'd expect this too.

what i was thinking about wrt. migrations was this: the total throughput
of interrupts could be higher on -RT, because of the better distribution
of RT tasks between CPUs. Higher IRQ throughput means less CPU time left
for the CPU-loop. (and also, consequently, bigger latencies measured in
the CPU-loop.) But since all IRQ threads are in essence bound to CPU#0, 
this scenario cannot occur.

if the CPU overhead of -RT is dramatically higher (especially due to
debugging code that only triggers in the -RT kernels) then we could see
a similar effect: the same amount of SCHED_OTHER processing generates a
higher amount of prio-99 activities than it does under the -PK kernel,
and hence the CPU time left for the CPU loop is lower as well. (and
also, bigger latencies are generated in the CPU loop.)

> If I look at the max latency:
>   RT 3.90
>   PK 1.91  (both cases nominal is 1.16 msec)
>
> From the scenarios I described above, I don't see why this result
> should have occurred. Certainly nothing that should cause a delay of
> over two msec on a roughly one msec task.

well, if IRQ threads and ksoftirqd comes in at the wrong moment, it's
prio 99 and could keep running for a long time. But no, i'd not expect
such a big difference either, it's the same workload after all.

> If I look at the % within 100 usec measure:
>   RT 87% within 100 usec, 97% within 200 usec (360 seconds elapsed)
>   PK 67% within 100 usec, 96% within 200 usec (57 seconds elapsed)

(this is the elapsed time of the prio ~30 CPU-loop, right?)

this smells too. There's one aspect of -RT that could starve lower-prio
RT tasks: if a high-prio RT task blocks on a mutex/semaphore then it
boosts whatever lowprio task is using that mutex currently. But this
means that it's boosted to prio 99 - preempting the prio 30 task. So
this means that depending on the level of contention, roughly the same
amount of time spent

in the PK case the prio 99 task would simply block, and the prio 30 task
could run, and you dont count this in your metrics, you only count the
'bad' effect: that the prio 30 task runs worse, you dont count the
'good' effect: that the prio 99 task runs better. This is why i think
it's unfair to only measure the 'middle priority layer', while not
counting improvements to the 'high priority layer'.

this theory is still a bit weak though to be the sole explanation: if
this were the case then we should see a decrease in total elapsed time
of the SCHED_OTHER workloads, right?

but 360 seconds vs. 57 seconds still sounds like alot... Perhaps we
should add 'CPU usage per priority level' statistics fields to
/proc/stat, or something like that? Perhaps even a 'CPU time spent while
boosted' field, to find out how the effective priority levels shift due
to PI.

	Ingo
