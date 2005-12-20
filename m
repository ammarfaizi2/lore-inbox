Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVLTAiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVLTAiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 19:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVLTAiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 19:38:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23706 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750709AbVLTAiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 19:38:02 -0500
Subject: 2.6.14-rt22 (and mainline) excessive latency
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 19:40:44 -0500
Message-Id: <1135039244.28649.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I captured this 3+ ms latency trace when killing a process with a few
thousand threads.  Can a cond_resched be added to this code path?

preemption latency trace v1.1.5 on 2.6.14-rt22
--------------------------------------------------------------------
 latency: 3321 us, #2830/2830, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: softirq-timer/0-3 (uid:0 nice:0 policy:1 rt_prio:1)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
    bash-17992 0D.h2    1us : __trace_start_sched_wakeup (try_to_wake_up)
    bash-17992 0D.h2    1us : __trace_start_sched_wakeup <<...>-3> (62 0)
    bash-17992 0D.h.    2us : wake_up_process (wakeup_softirqd)
    bash-17992 0D.h.    3us : rcu_check_callbacks (update_process_times)
    bash-17992 0D.h.    3us : idle_cpu (rcu_check_callbacks)
    bash-17992 0D.h.    4us : __tasklet_schedule (rcu_check_callbacks)
    bash-17992 0D.h.    5us : wakeup_softirqd (__tasklet_schedule)
    bash-17992 0D.h.    6us : wake_up_process (wakeup_softirqd)
    bash-17992 0D.h.    6us : try_to_wake_up (wake_up_process)
    bash-17992 0D.h1    7us : activate_task (try_to_wake_up)
    bash-17992 0D.h1    8us : sched_clock (activate_task)
    bash-17992 0D.h1    9us : recalc_task_prio (activate_task)
    bash-17992 0D.h1   10us : __recalc_task_prio (recalc_task_prio)
    bash-17992 0D.h1   10us : __recalc_task_prio <<...>-7> (62 62)
    bash-17992 0D.h1   11us : activate_task <<...>-7> (62 d)
    bash-17992 0D.h1   12us : enqueue_task (activate_task)
    bash-17992 0D.h1   12us : __trace_start_sched_wakeup (try_to_wake_up)
    bash-17992 0D.h.   14us : wake_up_process (wakeup_softirqd)
    bash-17992 0D.h.   14us : scheduler_tick (update_process_times)
    bash-17992 0D.h.   15us : sched_clock (scheduler_tick)
    bash-17992 0D.h1   16us : task_timeslice (scheduler_tick)
    bash-17992 0D.h.   17us : run_posix_cpu_timers (update_process_times)
    bash-17992 0D.h1   19us : note_interrupt (__do_IRQ)
    bash-17992 0D.h1   19us : end_8259A_irq (__do_IRQ)
    bash-17992 0D.h1   20us+: enable_8259A_irq (end_8259A_irq)
    bash-17992 0Dnh1   22us : irq_exit (do_IRQ)
    bash-17992 0Dn.1   23us < (608)
    bash-17992 0.n.1   24us : eligible_child (do_wait)
    bash-17992 0.n.1   25us : eligible_child (do_wait)
    bash-17992 0.n.1   26us : eligible_child (do_wait)
    bash-17992 0.n.1   28us : eligible_child (do_wait)
    bash-17992 0.n.1   29us : eligible_child (do_wait)

    [ 3000+ of these deleted ]

    bash-17992 0.n.1 3296us : eligible_child (do_wait)
    bash-17992 0.n.1 3297us : eligible_child (do_wait)
    bash-17992 0.n.1 3298us : eligible_child (do_wait)
    bash-17992 0.n.1 3299us : eligible_child (do_wait)
    bash-17992 0.n.1 3300us : eligible_child (do_wait)
    bash-17992 0.n.1 3301us : eligible_child (do_wait)
    bash-17992 0.n.1 3303us : eligible_child (do_wait)
    bash-17992 0.n.1 3304us : next_thread (do_wait)
    bash-17992 0.n.. 3305us : preempt_schedule (do_wait)
    bash-17992 0Dn.. 3306us : __schedule (preempt_schedule)
    bash-17992 0Dn.. 3307us : profile_hit (__schedule)
    bash-17992 0Dn.1 3308us+: sched_clock (__schedule)
   <...>-3     0D..2 3314us+: __switch_to (__schedule)
   <...>-3     0D..2 3316us : __schedule <bash-17992> (73 62)
   <...>-3     0...1 3317us : trace_stop_sched_switched (__schedule)
   <...>-3     0D..2 3318us : trace_stop_sched_switched <<...>-3> (62 0)
   <...>-3     0D..2 3320us : trace_stop_sched_switched (__schedule)




