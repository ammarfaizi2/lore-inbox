Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbUJ1SnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUJ1SnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUJ1Sjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:39:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57244 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263038AbUJ1Sha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:37:30 -0400
Date: Thu, 28 Oct 2004 20:38:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Message-ID: <20041028183836.GF2951@elte.hu>
References: <OF167DB04B.77CF149C-ON86256F3B.00529EAD-86256F3B.00529EE5@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF167DB04B.77CF149C-ON86256F3B.00529EAD-86256F3B.00529EE5@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> It did not take long to collect this information. These may be false
> positives, here is the start of one example (note 00000000 for preempt
> count in some of the lines).
> 
> preemption latency trace v1.0.7 on 2.6.9-mm1-RT-V0.5.1
> -------------------------------------------------------
>  latency: 1976 us, entries: 2148 (2148)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
>     -----------------
>     | task: get_ltrace.sh/3673, uid:0 nice:0 policy:1 rt_prio:50
>     -----------------
>  => started at: try_to_wake_up+0x1cc/0x330 <c011c1cc>
>  => ended at:   finish_task_switch+0x41/0xc0 <c011c7e1>
> =======>
> 80000000 0.000ms (+0.000ms): _spin_unlock (try_to_wake_up)
> 80000000 0.000ms (+0.000ms): (105) ((140))
> 80000000 0.000ms (+0.000ms): (6) ((0))

here pid 6 got woken up and it's about to preempt pid 0 [the idle task].

> 80000000 0.000ms (+0.000ms): resched_task (try_to_wake_up)
> 80000000 0.001ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
> 80000000 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
> 00000000 0.001ms (+0.000ms): preempt_schedule (cpu_idle)
> 80000000 0.002ms (+0.000ms): __sched_text_start (preempt_schedule)
> 80000000 0.002ms (+0.000ms): sched_clock (__sched_text_start)
> 80000000 0.002ms (+0.000ms): _spin_lock_irq (__sched_text_start)
> 80000000 0.003ms (+0.000ms): _spin_lock_irqsave (__sched_text_start)
> 80000000 0.003ms (+0.000ms): dequeue_task (__sched_text_start)
> 80000000 0.004ms (+0.000ms): recalc_task_prio (__sched_text_start)
> 80000000 0.004ms (+0.000ms): effective_prio (recalc_task_prio)
> 80000000 0.004ms (+0.000ms): enqueue_task (__sched_text_start)
> 80000000 0.005ms (+0.000ms): __switch_to (__sched_text_start)
> 80000000 0.005ms (+0.000ms): (0) ((6))
> 80000000 0.005ms (+0.000ms): (140) ((105))
> 80000000 0.006ms (+0.000ms): finish_task_switch (__sched_text_start)
> 80000000 0.006ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
> 80000000 0.006ms (+0.000ms): (6) ((105))
> 80000000 0.006ms (+0.000ms): _spin_lock (trace_stop_sched_switched)

the trace should have stopped here! We just successfully switched from
pid 0 to pid 6 and called trace_stop_sched_switched() - the tracer
should really have noticed it. But the trace goes on for eternity:

> 00000000 1.862ms (+0.001ms): follow_mount (link_path_walk)
> 00000000 1.863ms (+33179.004ms): dput (link_path_walk)

which is just wrong.

i think the tracer is more broken on SMP systems than i thought. If we
start tracing on one CPU and it goes over to another CPU [which might
have happened in the above case - another task on another CPU took
precedence over pid 6 on this CPU] ... but the tracing timestamp is
per-CPU.

what needs to happen is some sort of 'handover' whenever the
highest-prio task is migrated from one CPU to another. Until this is
fixed i'd not suggest to use the wakeup latency tracer on SMP :-|

	Ingo
