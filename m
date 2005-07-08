Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVGHWia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVGHWia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVGHWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:35:34 -0400
Received: from unused.mind.net ([69.9.134.98]:15002 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262926AbVGHWef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:34:35 -0400
Date: Fri, 8 Jul 2005 15:33:45 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-17
In-Reply-To: <20050708080359.GA32001@elte.hu>
Message-ID: <Pine.LNX.4.58.0507081524030.31216@echo.lysdexia.org>
References: <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
 <20050707104859.GD22422@elte.hu> <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
 <20050708080359.GA32001@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

More SMT weirdness.  Latency traces aren't looking quite right on -51-17 
with my SMT debug config.

Started jackd, immediately after boot (before logging in to X), then:

[root@manzanita ~]# cat /proc/latency_trace
cat/2149[CPU#1]: BUG in update_out_trace at kernel/latency.c:698
 [<c01041a3>] dump_stack+0x23/0x30 (20)
 [<c012317b>] __WARN_ON+0x6b/0x90 (52)
 [<c0142237>] update_out_trace+0x467/0x4e0 (100)
 [<c0142590>] l_start+0x2e0/0x310 (72)
 [<c019415b>] seq_read+0x7b/0x2d0 (60)
 [<c0170f74>] vfs_read+0xd4/0x140 (36)
 [<c0171250>] sys_read+0x50/0x80 (44)
 [<c01031b0>] sysenter_past_esp+0x61/0x89 (-8116)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c01434dc>] .... add_preempt_count+0x1c/0x20
.....[<c0123137>] ..   ( <= __WARN_ON+0x27/0x90)
.. [<c01434dc>] .... add_preempt_count+0x1c/0x20
.....[<c014454d>] ..   ( <= print_traces+0x1d/0x60)

------------------------------
| showing all locks held by: |  (cat/2149 [dda0e030,  39]):
------------------------------

#001:             [db76afa4] {(struct semaphore *)(&p->sem)}
... acquired at:               seq_read+0x2b/0x2d0

#002:             [c05fe424] {out_mutex.lock}
... acquired at:               l_start+0x1b/0x310

#003:             [c06d4404] {max_mutex.lock}
... acquired at:               l_start+0x2db/0x310

CPU0: 0000003e0d590d0c (0000003e0d593ba8) ... #50 (0000003e0d610158) 0000003e0d611a78
CPU1: 0000003e0d6122c8 (0000003e0d6125b0) ... #4 (0000003e0d612dac) 0000003e0d6136bc
CPU0 entries: 50
first stamp: 0000003e0d6122c8
 last stamp: 0000003e0d6122c8
preemption latency trace v1.1.4 on 2.6.12-RT-V0.7.51-17-debug
--------------------------------------------------------------------
 latency: 159 us, #54/54, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: softirq-timer/0-4 (uid:0 nice:-10 policy:0 rt_prio:0)
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


vim:ft=help


After logging into X:

<15:26:38 root@manzanita ~># cat /proc/latency_trace 
preemption latency trace v1.1.4 on 2.6.12-RT-V0.7.51-17-debug
--------------------------------------------------------------------
 latency: 202 us, #102/102, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: jackd-1929 (uid:500 nice:0 policy:1 rt_prio:60)
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
   <...>-1817  1....    0us : set_palette (redraw_screen)
   IRQ 5-724   0Dnh2    0us : find_next_bit (pull_rt_tasks)
   <...>-1817  1....    0us : is_console_locked (set_palette)
   IRQ 5-724   0Dnh2    0us : dependent_sleeper (__schedule)
   <...>-1817  1....    0us : vgacon_set_palette (set_palette)
   IRQ 5-724   0Dnh2    1us : _raw_spin_unlock (dependent_sleeper)
   <...>-1817  1....    1us : vga_set_palette (vgacon_set_palette)
   IRQ 5-724   0Dnh1    1us : preempt_schedule (dependent_sleeper)
   IRQ 5-724   0Dnh1    1us : _raw_spin_lock (dependent_sleeper)
   IRQ 5-724   0Dnh2    2us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh2    2us : _raw_spin_lock (dependent_sleeper)
   IRQ 5-724   0Dnh3    2us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh3    3us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh3    3us : _raw_spin_unlock (dependent_sleeper)
   IRQ 5-724   0Dnh2    3us : preempt_schedule (dependent_sleeper)
   IRQ 5-724   0Dnh2    3us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh2    4us : trace_array (__schedule)
   IRQ 5-724   0Dnh2    4us : trace_array <<...>-1929> (27 27)
   IRQ 5-724   0Dnh2    5us : trace_array <IRQ 5-724> (31 31)
   IRQ 5-724   0Dnh2    6us : trace_array (__schedule)
   <...>-1929  0Dnh2    8us+: __switch_to (__schedule)
   <...>-1929  0Dnh2   11us : __schedule <IRQ 5-724> (31 27)
   <...>-1929  0Dnh2   11us : finish_task_switch (__schedule)
   <...>-1929  0Dnh2   13us : smp_send_reschedule_allbutself (finish_task_switch)
   <...>-1929  0Dnh2   13us : __bitmap_weight (smp_send_reschedule_allbutself)
   <...>-1929  0Dnh2   13us : __send_IPI_shortcut (smp_send_reschedule_allbutself)
   <...>-1929  0Dnh2   13us : _raw_spin_unlock (finish_task_switch)
   <...>-1929  0Dnh1   15us : trace_stop_sched_switched (finish_task_switch)
   <...>-1929  0Dnh1   15us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-1929  0Dnh2   15us : trace_stop_sched_switched <<...>-1929> (27 0)
   <...>-1817  1Dnh.   15us : smp_reschedule_interrupt (c026c17a 0 0)
   <...>-1929  0Dnh3   16us : _raw_spin_unlock (trace_stop_sched_switched)
   <...>-1817  1Dnh.   16us : preempt_schedule_irq (need_resched)
   <...>-1929  0Dnh2   16us!: trace_stop_sched_switched (finish_task_switch)
   IRQ 5-724   0Dnh2    0us : find_next_bit (pull_rt_tasks)
   IRQ 5-724   0Dnh2    0us : dependent_sleeper (__schedule)
   IRQ 5-724   0Dnh2    1us : _raw_spin_unlock (dependent_sleeper)
   IRQ 5-724   0Dnh1    1us : preempt_schedule (dependent_sleeper)
   IRQ 5-724   0Dnh1    1us : _raw_spin_lock (dependent_sleeper)
   IRQ 5-724   0Dnh2    2us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh2    2us : _raw_spin_lock (dependent_sleeper)
   IRQ 5-724   0Dnh3    2us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh3    3us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh3    3us : _raw_spin_unlock (dependent_sleeper)
   IRQ 5-724   0Dnh2    3us : preempt_schedule (dependent_sleeper)
   IRQ 5-724   0Dnh2    3us : find_next_bit (dependent_sleeper)
   IRQ 5-724   0Dnh2    4us : trace_array (__schedule)
   IRQ 5-724   0Dnh2    4us : trace_array <<...>-1929> (27 27)
   IRQ 5-724   0Dnh2    5us : trace_array <IRQ 5-724> (31 31)
   IRQ 5-724   0Dnh2    6us : trace_array (__schedule)
   <...>-1929  0Dnh2    8us+: __switch_to (__schedule)
   <...>-1929  0Dnh2   11us : __schedule <IRQ 5-724> (31 27)
   <...>-1929  0Dnh2   11us : finish_task_switch (__schedule)
   <...>-1929  0Dnh2   13us : smp_send_reschedule_allbutself (finish_task_switch)
   <...>-1929  0Dnh2   13us : __bitmap_weight (smp_send_reschedule_allbutself)
   <...>-1929  0Dnh2   13us : __send_IPI_shortcut (smp_send_reschedule_allbutself)
   <...>-1929  0Dnh2   13us : _raw_spin_unlock (finish_task_switch)
   <...>-1929  0Dnh1   15us : trace_stop_sched_switched (finish_task_switch)
   <...>-1929  0Dnh1   15us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-1929  0Dnh2   15us : trace_stop_sched_switched <<...>-1929> (27 0)
   <...>-1929  0Dnh3   16us : _raw_spin_unlock (trace_stop_sched_switched)
   <...>-1929  0Dnh2   16us!: trace_stop_sched_switched (finish_task_switch)


vim:ft=help


--ww
