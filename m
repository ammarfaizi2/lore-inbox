Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUKVR0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUKVR0C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUKVRY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:24:26 -0500
Received: from bos-gate4.raytheon.com ([199.46.198.233]:13382 "EHLO
	bos-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262247AbUKVRN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:13:58 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Date: Mon, 22 Nov 2004 11:12:32 -0600
Message-ID: <OFCE13B0C3.F777072D-ON86256F54.005E881C-86256F54.005E8856@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/22/2004 11:12:46 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>     http://redhat.com/~mingo/realtime-preempt/
>
After simplifying the test, I have some data on wakeup times that don't
look too good. The set up was...
 - booted / telinit 5
 - did NOT change any IRQ nor system task priorities
 - ran data collection script
 - ran a simple script that exercised the disk (write, copy, read)
Nothing was at RT priority except system tasks & data collection script
[script was RT fifo priority 1].

Symptoms seen include:
 [1] still see occasional truncated latency_trace output (see below)
 [2] variety of long > 1 msec wakeup latencies (see below)
 [3] primary long latencies with ksoftirqd/[01] and IRQ 10 tasks
I have over 30 traces in about 5-10 minutes of testing. Let me know if
you want all of them.

  --Mark

Truncated example:

preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.30-2
-------------------------------------------------------
 latency: 2097 us, entries: 1 (1)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: ksoftirqd/0/4, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x379/0x3e0 <c0118d99>
 => ended at:   finish_task_switch+0x4f/0xc0 <c01192af>
=======>
    4 88000001 0.000ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)

Long trace example [> 2 msec]

preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.30-2
-------------------------------------------------------
 latency: 1537 us, entries: 36 (36)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: ksoftirqd/0/4, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x379/0x3e0 <c0118d99>
 => ended at:   finish_task_switch+0x4f/0xc0 <c01192af>
=======>
    0 88000004 0.000ms (+0.000ms): __trace_start_sched_wakeup
(try_to_wake_up)
    0 88000004 0.000ms (+0.000ms): _raw_spin_unlock (try_to_wake_up)
    0 88000003 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
    0 88000003 0.000ms (+0.000ms): (4) ((0))
    0 88000003 0.001ms (+0.000ms): (105) ((140))
    0 88000003 0.001ms (+0.000ms): try_to_wake_up (wake_up_process)
    0 88000003 0.001ms (+0.000ms): (0) ((1))
    0 88000003 0.001ms (+0.000ms): _raw_spin_unlock (try_to_wake_up)
    0 88000002 0.002ms (+0.000ms): preempt_schedule (try_to_wake_up)
    0 88000002 0.002ms (+0.275ms): wake_up_process (do_softirq)
    0 88010001 0.277ms (+0.207ms): do_nmi (default_idle)
    0 88010001 0.484ms (+0.001ms): do_nmi (__mcount)
    0 88010001 0.486ms (+0.077ms): do_nmi (<00200046>)
    0 88010001 0.563ms (+0.275ms): preempt_schedule (nmi_watchdog_tick)
    0 08000000 0.838ms (+0.000ms): preempt_schedule (cpu_idle)
    0 98000000 0.839ms (+0.000ms): __sched_text_start (preempt_schedule)
    0 98000001 0.839ms (+0.000ms): sched_clock (__sched_text_start)
    0 98000001 0.839ms (+0.000ms): _raw_spin_lock_irq (__sched_text_start)
    0 98000001 0.840ms (+0.000ms): _raw_spin_lock_irqsave
(__sched_text_start)
    0 88000002 0.840ms (+0.000ms): dequeue_task (__sched_text_start)
    0 88000002 0.840ms (+0.000ms): recalc_task_prio (__sched_text_start)
    0 88000002 0.841ms (+0.000ms): effective_prio (recalc_task_prio)
    0 88000002 0.841ms (+0.000ms): enqueue_task (__sched_text_start)
    0 80000002 0.841ms (+0.001ms): trace_array (__sched_text_start)
    0 80000002 0.843ms (+0.000ms): (4) ((105))
    0 80000002 0.843ms (+0.000ms): (0) ((110))
    0 80000002 0.844ms (+0.002ms): trace_array (__sched_text_start)
    4 80000002 0.847ms (+0.000ms): __switch_to (__sched_text_start)
    4 80000002 0.847ms (+0.000ms): (0) ((4))
    4 80000002 0.847ms (+0.000ms): (140) ((105))
    4 80000002 0.847ms (+0.000ms): finish_task_switch (__sched_text_start)
    4 80000002 0.848ms (+0.000ms): _raw_spin_unlock (finish_task_switch)
    4 80000001 0.848ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)
    4 80000001 0.848ms (+0.000ms): (4) ((105))
    4 80000001 0.848ms (+1.318ms): _raw_spin_lock_irqsave
(trace_stop_sched_switched)
    4 80000001 2.167ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)

Another long one...

preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.30-2
-------------------------------------------------------
 latency: 1956 us, entries: 36 (36)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: ksoftirqd/0/4, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x379/0x3e0 <c0118d99>
 => ended at:   finish_task_switch+0x4f/0xc0 <c01192af>
=======>
   28 88000003 0.000ms (+0.000ms): __trace_start_sched_wakeup
(try_to_wake_up)
   28 88000003 0.000ms (+0.000ms): _raw_spin_unlock (try_to_wake_up)
   28 88000002 0.000ms (+0.001ms): preempt_schedule (try_to_wake_up)
   28 88000002 0.001ms (+0.000ms): (4) ((28))
   28 88000002 0.002ms (+0.000ms): (105) ((110))
   28 88000002 0.002ms (+0.000ms): try_to_wake_up (wake_up_process)
   28 88000002 0.002ms (+0.000ms): (0) ((1))
   28 88000002 0.002ms (+0.000ms): _raw_spin_unlock (try_to_wake_up)
   28 88000001 0.003ms (+0.000ms): preempt_schedule (try_to_wake_up)
   28 88000001 0.003ms (+0.000ms): wake_up_process (do_softirq)
   28 88000000 0.003ms (+0.000ms): preempt_schedule_irq (need_resched)
   28 98000000 0.004ms (+0.000ms): __sched_text_start
(preempt_schedule_irq)
   28 98000001 0.004ms (+0.000ms): sched_clock (__sched_text_start)
   28 98000001 0.004ms (+0.000ms): _raw_spin_lock_irq (__sched_text_start)
   28 98000001 0.005ms (+0.000ms): _raw_spin_lock_irqsave
(__sched_text_start)
   28 88000002 0.005ms (+0.000ms): dequeue_task (__sched_text_start)
   28 88000002 0.006ms (+0.000ms): recalc_task_prio (__sched_text_start)
   28 88000002 0.006ms (+0.000ms): effective_prio (recalc_task_prio)
   28 88000002 0.006ms (+0.000ms): enqueue_task (__sched_text_start)
   28 80000002 0.006ms (+0.001ms): trace_array (__sched_text_start)
   28 80000002 0.008ms (+0.000ms): (4) ((105))
   28 80000002 0.009ms (+0.000ms): (0) ((110))
   28 80000002 0.009ms (+0.000ms): (28) ((110))
   28 80000002 0.009ms (+0.000ms): (0) ((115))
   28 80000002 0.009ms (+0.000ms): (4344) ((118))
   28 80000002 0.010ms (+0.000ms): (0) ((120))
   28 80000002 0.010ms (+0.052ms): trace_array (__sched_text_start)
    4 80000002 0.063ms (+1.256ms): __switch_to (__sched_text_start)
    4 80000002 1.319ms (+0.000ms): (28) ((4))
    4 80000002 1.319ms (+0.000ms): (110) ((105))
    4 80000002 1.319ms (+0.000ms): finish_task_switch (__sched_text_start)
    4 80000002 1.319ms (+0.139ms): _raw_spin_unlock (finish_task_switch)
    4 80000001 1.459ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)
    4 80000001 1.460ms (+0.000ms): (4) ((105))
    4 80000001 1.460ms (+0.420ms): _raw_spin_lock_irqsave
(trace_stop_sched_switched)
    4 88000001 1.880ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)

A third long one, note inconsistent header / total time.

preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.30-2
-------------------------------------------------------
 latency: 1000 us, entries: 32 (32)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: ksoftirqd/0/4, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x379/0x3e0 <c0118d99>
 => ended at:   finish_task_switch+0x4f/0xc0 <c01192af>
=======>
    0 88000004 0.000ms (+0.000ms): __trace_start_sched_wakeup
(try_to_wake_up)
    0 88000004 0.000ms (+0.000ms): _raw_spin_unlock (try_to_wake_up)
    0 88000003 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
    0 88000003 0.000ms (+0.000ms): (4) ((0))
    0 88000003 0.001ms (+0.000ms): (105) ((140))
    0 88000003 0.001ms (+0.000ms): try_to_wake_up (wake_up_process)
    0 88000003 0.001ms (+0.000ms): (0) ((1))
    0 88000003 0.001ms (+0.000ms): _raw_spin_unlock (try_to_wake_up)
    0 88000002 0.002ms (+0.000ms): preempt_schedule (try_to_wake_up)
    0 88000002 0.002ms (+0.000ms): wake_up_process (do_softirq)
    0 08000000 0.003ms (+0.000ms): preempt_schedule (cpu_idle)
    0 98000000 0.003ms (+0.000ms): __sched_text_start (preempt_schedule)
    0 98000001 0.004ms (+0.000ms): sched_clock (__sched_text_start)
    0 98000001 0.004ms (+0.000ms): _raw_spin_lock_irq (__sched_text_start)
    0 98000001 0.004ms (+0.000ms): _raw_spin_lock_irqsave
(__sched_text_start)
    0 88000002 0.005ms (+0.000ms): dequeue_task (__sched_text_start)
    0 88000002 0.005ms (+0.000ms): recalc_task_prio (__sched_text_start)
    0 88000002 0.005ms (+0.000ms): effective_prio (recalc_task_prio)
    0 88000002 0.006ms (+0.000ms): enqueue_task (__sched_text_start)
    0 80000002 0.006ms (+0.001ms): trace_array (__sched_text_start)
    0 80000002 0.008ms (+0.000ms): (4) ((105))
    0 80000002 0.008ms (+0.000ms): (0) ((110))
    0 80000002 0.009ms (+0.002ms): trace_array (__sched_text_start)
    4 80000002 0.011ms (+0.000ms): __switch_to (__sched_text_start)
    4 80000002 0.012ms (+0.000ms): (0) ((4))
    4 80000002 0.012ms (+0.000ms): (140) ((105))
    4 80000002 0.012ms (+0.000ms): finish_task_switch (__sched_text_start)
    4 80000002 0.012ms (+0.000ms): _raw_spin_unlock (finish_task_switch)
    4 80000001 0.013ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)
    4 80000001 0.013ms (+0.000ms): (4) ((105))
    4 80000001 0.013ms (+1.307ms): _raw_spin_lock_irqsave
(trace_stop_sched_switched)
    4 80000001 1.321ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)

