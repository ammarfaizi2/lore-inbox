Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbULBVJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbULBVJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbULBVJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:09:12 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:57637 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261770AbULBVGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:06:45 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Date: Thu, 2 Dec 2004 15:01:27 -0600
Message-ID: <OFE7DEB319.5B6EC51D-ON86256F5E.00737D5C-86256F5E.00737D96@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/02/2004 03:05:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some results with -20.

[1] Had another crash where the serial console had incomplete output.
Unfortunately, I still had
  dmesg -n 0
so there were no messages prior to the failure. This was with -20PK
(and not RT) so CONFIG_RT does not seem to be the culprit. Will send
the serial console output separately. Did not stream messages, just the
one incomplete one.

[2] Still getting the odd behavior of the audio output. Seeing both
  /dev/dsp is busy
messages as well as the
  - "too short" duration alternating with
  - "wide variation" in duration
symptoms. No apparent pattern that I can see to cause these symptoms.
May have to resurrect the latencytest variant that I can trigger the
user tracing to track this down.

[3] The cpu_delay program is still getting > 1000 usec delays in the
CPU loop. The latency traces are not consistent either (though I have not
had any of the truncated ones either...). The following summarizes one
set of results with the -RT kernel.
   cpu_delay    latency_trace
     usec          usec
00   1855          2208
01   1790          1792 (OK)
02   2795          2785 (OK)
03   1543          1544 (OK)
04   1907          3078
05   1858         11322
06   1974          2519
07   1065          8411

The traces where the times don't match up also seem to have non RT
tasks included in the traces. I assume this means the trace did not
follow the task to the other CPU. It also is really annoying that the
non RT task was activated far faster than the RT one. Here's an
example trace (00 - 1855 usec; note non RT tasks in this trace)...

preemption latency trace v1.1.1 on 2.6.10-rc2-mm3-V0.7.31-20RT
-------------------------------------------------------
 latency: 2208 us, entries: 3738 (3738)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: cpu_delay/8656, uid:0 nice:0 policy:1 rt_prio:30
    -----------------
 => started at: <00000000>
 => ended at:   __up_mutex+0x495/0x500 <c013b705>
=======>
cpu_dela-8656  ........ 0.000ms (+0.000ms): (0): [ 00000000 00000000
00000000 ]
cpu_dela-8656  08000001 0.000ms (+0.000ms): user_trace_start
(sys_gettimeofday)
cpu_dela-8656  08000000 0.000ms (+0.000ms): preempt_schedule
(user_trace_start)
cpu_dela-8656  98000000 0.001ms (+0.000ms): __sched_text_start
(preempt_schedule)
cpu_dela-8656  98000001 0.001ms (+0.000ms): sched_clock
(__sched_text_start)
cpu_dela-8656  98000001 0.002ms (+0.000ms): _raw_spin_lock_irq
(__sched_text_start)
cpu_dela-8656  98000001 0.002ms (+0.001ms): _raw_spin_lock_irqsave
(__sched_text_start)
cpu_dela-8656  80000002 0.004ms (+0.001ms): trace_array
(__sched_text_start)
cpu_dela-8656  ........ 0.005ms (+0.001ms): ->    IRQ 0-2 [ 00000000
00000001 ]: __sched_text_start
cpu_dela-8656  ........ 0.007ms (+0.001ms): -> cpu_dela-8656 [ 00000045
00000046 ]: __sched_text_start
cpu_dela-8656  ........ 0.008ms (+0.000ms): ->        X-2845 [ 00000074
00000078 ]: __sched_text_start
cpu_dela-8656  ........ 0.008ms (+0.000ms): ->  kdeinit-3207 [ 00000074
00000078 ]: __sched_text_start
cpu_dela-8656  ........ 0.008ms (+0.000ms): ->  kdeinit-3215 [ 00000074
00000078 ]: __sched_text_start
cpu_dela-8656  80000002 0.009ms (+0.003ms): trace_array
(__sched_text_start)
   IRQ 0-2     80000002 0.013ms (+0.001ms): __switch_to
(__sched_text_start)
   IRQ 0-2     ........ 0.014ms (+0.000ms): -> cpu_dela-8656 [ 00000045
00000000 ]: schedule
   IRQ 0-2     80000002 0.015ms (+0.000ms): finish_task_switch
(__sched_text_start)
   IRQ 0-2     80000002 0.015ms (+0.000ms): get_next_rt_task
(finish_task_switch)
   IRQ 0-2     80000002 0.015ms (+0.000ms): find_next_bit
(get_next_rt_task)
   IRQ 0-2     80000002 0.016ms (+0.000ms): get_task_struct
(get_next_rt_task)
   IRQ 0-2     80000002 0.016ms (+0.000ms): _raw_spin_unlock
(finish_task_switch)
   IRQ 0-2     80000001 0.017ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)
   IRQ 0-2     80000001 0.018ms (+0.000ms): wake_rt (finish_task_switch)
   IRQ 0-2     ........ 0.018ms (+0.000ms): ->    IRQ 0-2 [ 00000000
00000005 ]: finish_task_switch
   IRQ 0-2     80000001 0.019ms (+0.001ms): find_next_bit (wake_rt)
   IRQ 0-2     ........ 0.020ms (+0.000ms): -> <unknown-9714 [ 00000076
00000001 ]: finish_task_switch
   IRQ 0-2     80000001 0.020ms (+0.001ms): __migrate_task
(finish_task_switch)
   IRQ 0-2     80000001 0.021ms (+0.000ms): double_rq_lock (__migrate_task)
   IRQ 0-2     80000001 0.021ms (+0.000ms): _raw_spin_lock (double_rq_lock)
   IRQ 0-2     80000002 0.022ms (+0.000ms): _raw_spin_lock (__migrate_task)
   IRQ 0-2     80000003 0.023ms (+0.000ms): trace_change_sched_cpu
(__migrate_task)
   IRQ 0-2     80000003 0.023ms (+0.000ms): deactivate_task
(__migrate_task)
   IRQ 0-2     80000003 0.023ms (+0.000ms): dequeue_task (deactivate_task)
   IRQ 0-2     80000003 0.024ms (+0.000ms): activate_task (__migrate_task)
   IRQ 0-2     80000003 0.024ms (+0.000ms): sched_clock (activate_task)
   IRQ 0-2     80000003 0.024ms (+0.000ms): recalc_task_prio
(activate_task)
   IRQ 0-2     80000003 0.025ms (+0.000ms): effective_prio
(recalc_task_prio)
   IRQ 0-2     ........ 0.025ms (+0.000ms): -> cpu_dela-8656 [ 00000045
00000001 ]: __migrate_task
   IRQ 0-2     80000003 0.026ms (+0.001ms): enqueue_task (activate_task)
   IRQ 0-2     80000003 0.027ms (+0.001ms): resched_task (__migrate_task)
   IRQ 0-2     80000003 0.028ms (+0.001ms): smp_send_reschedule
(__migrate_task)
   IRQ 0-2     80000003 0.030ms (+0.000ms): send_IPI_mask
(smp_send_reschedule)
   IRQ 0-2     80000003 0.030ms (+0.001ms): send_IPI_mask_bitmask
(smp_send_reschedule)
   IRQ 0-2     80000003 0.032ms (+0.000ms): double_rq_unlock
(__migrate_task)
   IRQ 0-2     80000003 0.032ms (+0.000ms): _raw_spin_unlock
(double_rq_unlock)
   IRQ 0-2     80000002 0.032ms (+0.001ms): _raw_spin_unlock
(__migrate_task)
   IRQ 0-2     80000001 0.033ms (+0.000ms): put_task_struct_delayed
(finish_task_switch)
   IRQ 0-2     ........ 0.034ms (+0.001ms): reschedule_interrupt: [
c032d150 00000000 00000000 ]
   IRQ 0-2     00000000 0.036ms (+0.000ms): kthread_should_stop (do_irqd)
   IRQ 0-2     00000000 0.036ms (+0.000ms): do_hardirq (do_irqd)
   IRQ 0-2     80000000 0.037ms (+0.000ms): _raw_spin_lock (do_hardirq)
   IRQ 0-2     80000001 0.038ms (+0.000ms): _raw_spin_unlock (do_hardirq)
   IRQ 0-2     80000000 0.038ms (+0.000ms): handle_IRQ_event (do_hardirq)
   IRQ 0-2     00000000 0.039ms (+0.000ms): timer_interrupt
(handle_IRQ_event)
   IRQ 0-2     00000000 0.039ms (+0.000ms): _spin_lock (timer_interrupt)
   IRQ 0-2     00000000 0.039ms (+0.000ms): __spin_lock (_spin_lock)
   IRQ 0-2     00000000 0.039ms (+0.000ms): __might_sleep (__spin_lock)
   IRQ 0-2     00000000 0.040ms (+0.000ms): _down_mutex (__spin_lock)
   IRQ 0-2     00000000 0.040ms (+0.000ms): __down_mutex (__spin_lock)
   IRQ 0-2     00000000 0.041ms (+0.000ms): __might_sleep (__down_mutex)
   IRQ 0-2     80000000 0.042ms (+0.001ms): _raw_spin_lock (__down_mutex)
   IRQ 0-2     80000001 0.043ms (+0.000ms): _raw_spin_lock (__down_mutex)
   IRQ 0-2     80000002 0.044ms (+0.000ms): _raw_spin_lock (__down_mutex)
   IRQ 0-2     80000003 0.044ms (+0.000ms): set_new_owner (__down_mutex)
   IRQ 0-2     ........ 0.044ms (+0.000ms): ->    IRQ 0-2 [ 00000000
00000000 ]: __down_mutex
   IRQ 0-2     80000003 0.045ms (+0.000ms): _raw_spin_unlock (__down_mutex)
   IRQ 0-2     80000002 0.046ms (+0.000ms): _raw_spin_unlock (__down_mutex)
   IRQ 0-2     80000001 0.046ms (+0.000ms): _raw_spin_unlock (__down_mutex)
   IRQ 0-2     00000000 0.047ms (+0.000ms): mark_offset_tsc
(timer_interrupt)
   IRQ 0-2     00000000 0.047ms (+0.000ms): _spin_lock (mark_offset_tsc)
   IRQ 0-2     00000000 0.048ms (+0.000ms): __spin_lock (_spin_lock)
   IRQ 0-2     00000000 0.048ms (+0.000ms): __might_sleep (__spin_lock)
   IRQ 0-2     00000000 0.048ms (+0.000ms): _down_mutex (__spin_lock)
   IRQ 0-2     00000000 0.049ms (+0.000ms): __down_mutex (__spin_lock)
   IRQ 0-2     00000000 0.049ms (+0.000ms): __might_sleep (__down_mutex)
   IRQ 0-2     80000000 0.050ms (+0.000ms): _raw_spin_lock (__down_mutex)
   IRQ 0-2     80000001 0.050ms (+0.000ms): _raw_spin_lock (__down_mutex)
   IRQ 0-2     80000002 0.051ms (+0.000ms): _raw_spin_lock (__down_mutex)
   IRQ 0-2     80000003 0.051ms (+0.000ms): set_new_owner (__down_mutex)
   IRQ 0-2     ........ 0.051ms (+0.000ms): ->    IRQ 0-2 [ 00000000
00000000 ]: __down_mutex
   IRQ 0-2     80000003 0.052ms (+0.000ms): _raw_spin_unlock (__down_mutex)
   IRQ 0-2     80000002 0.052ms (+0.000ms): _raw_spin_unlock (__down_mutex)
   IRQ 0-2     80000001 0.053ms (+0.000ms): _raw_spin_unlock (__down_mutex)
   IRQ 0-2     00000000 0.053ms (+0.006ms): _raw_spin_lock_irqsave
(mark_offset_tsc)
   IRQ 0-2     80000001 0.060ms (+0.000ms): _raw_spin_unlock_irqrestore
(mark_offset_tsc)
   IRQ 0-2     00000000 0.061ms (+0.000ms): _spin_unlock (mark_offset_tsc)
   IRQ 0-2     00000000 0.061ms (+0.000ms): up_mutex (mark_offset_tsc)
   IRQ 0-2     00000000 0.062ms (+0.000ms): __up_mutex (up_mutex)
   IRQ 0-2     80000000 0.062ms (+0.000ms): _raw_spin_lock (__up_mutex)
   IRQ 0-2     80000001 0.062ms (+0.000ms): _raw_spin_lock (__up_mutex)
   IRQ 0-2     80000002 0.063ms (+0.000ms): _raw_spin_lock (__up_mutex)
   IRQ 0-2     80000003 0.063ms (+0.000ms): mutex_getprio (__up_mutex)
   IRQ 0-2     ........ 0.063ms (+0.000ms): ->    IRQ 0-2 [ 00000000
00000000 ]: __up_mutex
   IRQ 0-2     80000003 0.064ms (+0.000ms): _raw_spin_unlock (__up_mutex)
   IRQ 0-2     80000002 0.064ms (+0.000ms): _raw_spin_unlock (__up_mutex)
   IRQ 0-2     80000001 0.065ms (+0.000ms): _raw_spin_unlock (__up_mutex)
   IRQ 0-2     00000000 0.065ms (+0.004ms): _raw_spin_lock_irqsave
(timer_interrupt)
   IRQ 0-2     80000001 0.070ms (+0.000ms): _raw_spin_unlock_irqrestore
(timer_interrupt)
   IRQ 0-2     00000000 0.070ms (+0.000ms): _spin_unlock (timer_interrupt)
   IRQ 0-2     00000000 0.070ms (+0.000ms): up_mutex (timer_interrupt)
   IRQ 0-2     00000000 0.071ms (+0.000ms): __up_mutex (up_mutex)
   IRQ 0-2     80000000 0.071ms (+0.000ms): _raw_spin_lock (__up_mutex)
   IRQ 0-2     80000001 0.072ms (+0.000ms): _raw_spin_lock (__up_mutex)
   IRQ 0-2     80000002 0.072ms (+0.000ms): _raw_spin_lock (__up_mutex)
   IRQ 0-2     80000003 0.073ms (+0.000ms): mutex_getprio (__up_mutex)
   IRQ 0-2     ........ 0.073ms (+0.000ms): ->    IRQ 0-2 [ 00000000
00000000 ]: __up_mutex
   IRQ 0-2     80000003 0.073ms (+0.000ms): _raw_spin_unlock (__up_mutex)
   IRQ 0-2     80000002 0.074ms (+0.000ms): _raw_spin_unlock (__up_mutex)
   IRQ 0-2     80000001 0.074ms (+0.000ms): _raw_spin_unlock (__up_mutex)
   IRQ 0-2     00000000 0.075ms (+0.000ms): cond_resched_all (do_hardirq)
   IRQ 0-2     00000000 0.075ms (+0.000ms): cond_resched (do_hardirq)
   IRQ 0-2     00000000 0.075ms (+0.000ms): _raw_spin_lock_irq (do_hardirq)
   IRQ 0-2     00000000 0.076ms (+0.000ms): _raw_spin_lock_irqsave
(do_hardirq)
   IRQ 0-2     80000001 0.076ms (+0.000ms): note_interrupt (do_hardirq)
   IRQ 0-2     80000001 0.077ms (+0.000ms): end_edge_ioapic_irq
(do_hardirq)
   IRQ 0-2     80000001 0.077ms (+0.000ms): _raw_spin_unlock (do_hardirq)
   IRQ 0-2     00000000 0.078ms (+0.000ms): cond_resched_all (do_irqd)
   IRQ 0-2     00000000 0.078ms (+0.000ms): cond_resched (do_irqd)
   IRQ 0-2     00000000 0.078ms (+0.000ms): __do_softirq (do_irqd)
   IRQ 0-2     00000000 0.079ms (+0.000ms): schedule (do_irqd)
   IRQ 0-2     00000000 0.079ms (+0.000ms): __sched_text_start (schedule)
   IRQ 0-2     00000001 0.080ms (+0.000ms): sched_clock
(__sched_text_start)
   IRQ 0-2     00000001 0.081ms (+0.000ms): _raw_spin_lock_irq
(__sched_text_start)
   IRQ 0-2     00000001 0.081ms (+0.000ms): _raw_spin_lock_irqsave
(__sched_text_start)
   IRQ 0-2     80000002 0.082ms (+0.000ms): deactivate_task
(__sched_text_start)
   IRQ 0-2     80000002 0.082ms (+0.000ms): dequeue_task (deactivate_task)
   IRQ 0-2     80000002 0.083ms (+0.002ms): trace_array
(__sched_text_start)
   IRQ 0-2     ........ 0.085ms (+0.000ms): ->        X-2845 [ 00000074
00000078 ]: __sched_text_start
   IRQ 0-2     ........ 0.085ms (+0.000ms): ->  kdeinit-3207 [ 00000074
00000078 ]: __sched_text_start
   IRQ 0-2     ........ 0.086ms (+0.000ms): ->  kdeinit-3215 [ 00000074
00000078 ]: __sched_text_start
   IRQ 0-2     80000002 0.086ms (+0.003ms): trace_array
(__sched_text_start)
       X-2845  80000002 0.090ms (+0.000ms): __switch_to
(__sched_text_start)
       X-2845  ........ 0.091ms (+0.000ms): ->    IRQ 0-2 [ 00000000
00000074 ]: preempt_schedule_irq
       X-2845  80000002 0.091ms (+0.000ms): finish_task_switch
(__sched_text_start)
       X-2845  80000002 0.091ms (+0.000ms): _raw_spin_unlock
(finish_task_switch)
       X-2845  80000001 0.092ms (+0.000ms): trace_stop_sched_switched
(finish_task_switch)
       X-2845  00000000 0.093ms (+0.000ms): tty_ldisc_deref (tty_poll)
       X-2845  00000000 0.094ms (+0.000ms): _spin_unlock_irqrestore
(tty_ldisc_deref)
       X-2845  00000000 0.094ms (+0.000ms): up_mutex (tty_ldisc_deref)
       X-2845  00000000 0.095ms (+0.000ms): __up_mutex (up_mutex)
       X-2845  80000000 0.095ms (+0.000ms): _raw_spin_lock (__up_mutex)
       X-2845  80000001 0.095ms (+0.000ms): _raw_spin_lock (__up_mutex)
       X-2845  80000002 0.096ms (+0.000ms): _raw_spin_lock (__up_mutex)
       X-2845  80000003 0.097ms (+0.000ms): mutex_getprio (__up_mutex)
       X-2845  ........ 0.097ms (+0.000ms): ->        X-2845 [ 00000074
00000074 ]: __up_mutex
       X-2845  80000003 0.097ms (+0.000ms): _raw_spin_unlock (__up_mutex)
       X-2845  80000002 0.098ms (+0.000ms): _raw_spin_unlock (__up_mutex)
       X-2845  80000001 0.098ms (+0.000ms): _raw_spin_unlock (__up_mutex)
       X-2845  00000000 0.099ms (+0.000ms): fput (do_select)
       X-2845  00000000 0.099ms (+0.000ms): cond_resched (do_select)
       X-2845  00000000 0.100ms (+0.000ms): fget (do_select)
... traces of X, ksoftrirq (RT), X, IRQ 14 (RT), X, IRQ 0 (RT), X,
    kdeinit, ksoftirq (RT), kdeinit [cpu_delay (RT) starts on untraced
CPU],
    IRQ 0 (RT), kdeinit, cpu_delay (RT) back in this trace ...

It may be annoying, but it might be good on a small SMP system like mine
to trace what's going on both CPU's during a user trace. Add a column for
the CPU number. That would show the interaction between the CPU's and
see why cpu_delay got stuck for so long in this instance. If you wanted
to follow a single CPU, just grep for that column. Would probably have to
increase the max trace table size (16K traces?). Not sure how to do that
though.

I'll send the traces separately for the cpu_delay symptoms and see if I
can somehow recreate the crash (w/ dmesg -n 8 active).
  --Mark

