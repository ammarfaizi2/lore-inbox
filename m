Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVLUGAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVLUGAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVLUGAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:00:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:62165 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932246AbVLUGA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:00:29 -0500
Subject: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 01:04:25 -0500
Message-Id: <1135145065.29182.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a 13ms+ trace caused by "netstat -anop".  I noticed that the
preempt count is 0 so there are no locks to drop, would adding a
cond_resched() be acceptable?  Or should this be considered more
evidence of the need for softirq preemption?

preemption latency trace v1.1.5 on 2.6.14-rt22
--------------------------------------------------------------------
 latency: 13824 us, #16533/16533, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
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
 netstat-29157 0D.h2    0us : __trace_start_sched_wakeup (try_to_wake_up)
 netstat-29157 0D.h2    1us : __trace_start_sched_wakeup <<...>-3> (62 0)
 netstat-29157 0D.h.    2us : wake_up_process (wakeup_softirqd)
 netstat-29157 0D.h.    3us : scheduler_tick (update_process_times)
 netstat-29157 0D.h.    3us : sched_clock (scheduler_tick)
 netstat-29157 0D.h1    5us : task_timeslice (scheduler_tick)
 netstat-29157 0D.h.    6us : run_posix_cpu_timers (update_process_times)
 netstat-29157 0D.h1    7us : note_interrupt (__do_IRQ)
 netstat-29157 0D.h1    8us : end_8259A_irq (__do_IRQ)
 netstat-29157 0D.h1    8us+: enable_8259A_irq (end_8259A_irq)
 netstat-29157 0DnH.   10us : irq_exit (do_IRQ) 
 netstat-29157 0Dns.   11us < (608)
 netstat-29157 0.ns.   13us : preempt_schedule (established_get_first)
 netstat-29157 0.ns.   13us : cond_resched_softirq (established_get_first)
 netstat-29157 0.ns.   14us : preempt_schedule (established_get_first)
 netstat-29157 0.ns.   15us : cond_resched_softirq (established_get_first)
 netstat-29157 0.ns.   16us : preempt_schedule (established_get_first)
 netstat-29157 0.ns.   17us : cond_resched_softirq (established_get_first)
 netstat-29157 0.ns.   18us : preempt_schedule (established_get_first)

 [ at about 1ms switches to established_get_next ]

 netstat-29157 0.ns. 13765us : cond_resched_softirq (established_get_next)
 netstat-29157 0.ns. 13766us : preempt_schedule (established_get_next)
 netstat-29157 0.ns. 13767us : cond_resched_softirq (established_get_next)
 netstat-29157 0.ns. 13768us : preempt_schedule (established_get_next)
 netstat-29157 0.ns. 13769us : cond_resched_softirq (established_get_next)
 netstat-29157 0.ns. 13770us : tcp_seq_stop (seq_read)
 netstat-29157 0.ns. 13771us : local_bh_enable (tcp_seq_stop)
 netstat-29157 0.n.1 13772us : do_softirq (local_bh_enable)
 netstat-29157 0D.s. 13774us : __do_softirq (do_softirq)
 netstat-29157 0D.s. 13775us : ___do_softirq (__do_softirq)
 netstat-29157 0..s. 13776us : run_timer_softirq (___do_softirq)
 netstat-29157 0..s. 13778us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13779us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13779us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13780us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13781us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13782us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13783us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13784us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13785us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13786us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13787us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13788us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13789us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13790us : cond_resched_softirq (run_timer_softirq)
 netstat-29157 0..s. 13791us : ktimer_run_queues (run_timer_softirq)
 netstat-29157 0..s. 13792us : get_realtime_clock (ktimer_run_queues)
 netstat-29157 0..s. 13793us : read_tsc (get_realtime_clock)
 netstat-29157 0..s. 13795us : ktime_add_ns (get_realtime_clock)
 netstat-29157 0..s. 13796us : get_monotonic_clock (ktimer_run_queues)
 netstat-29157 0..s. 13797us : read_tsc (get_monotonic_clock)
 netstat-29157 0..s. 13798us+: ktime_add_ns (get_monotonic_clock)
 netstat-29157 0..s. 13802us : __wake_up (run_timer_softirq)
 netstat-29157 0D.s1 13802us : __wake_up_common (__wake_up)
 netstat-29157 0..s. 13804us : cond_resched_all (___do_softirq)
 netstat-29157 0..s. 13804us : cond_resched_softirq (cond_resched_all)
 netstat-29157 0.n.. 13805us : preempt_schedule (local_bh_enable)
 netstat-29157 0Dn.. 13806us : __schedule (preempt_schedule)
 netstat-29157 0Dn.. 13807us : profile_hit (__schedule)
 netstat-29157 0Dn.1 13808us+: sched_clock (__schedule)
   <...>-3     0D..2 13814us+: __switch_to (__schedule)
   <...>-3     0D..2 13820us : __schedule <netstat-29157> (75 62)
   <...>-3     0...1 13821us : trace_stop_sched_switched (__schedule)
   <...>-3     0D..2 13821us+: trace_stop_sched_switched <<...>-3> (62 0)
   <...>-3     0D..2 13824us : trace_stop_sched_switched (__schedule)


