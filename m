Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVL1R1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVL1R1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVL1R1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:27:52 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61357 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932545AbVL1R1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:27:51 -0500
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0512272128040.12225@gandalf.stny.rr.com>
References: <1135145065.29182.10.camel@mindpipe>
	 <1135204629.14810.43.camel@localhost.localdomain>
	 <1135732888.22744.51.camel@mindpipe>
	 <Pine.LNX.4.58.0512272110490.10936@gandalf.stny.rr.com>
	 <1135736563.22744.58.camel@mindpipe>
	 <Pine.LNX.4.58.0512272128040.12225@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 12:33:26 -0500
Message-Id: <1135791206.6183.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 21:30 -0500, Steven Rostedt wrote:
> OK, I did find it though, and it only had one rej. So you probably can
> easily do that change yourself.
> 
> Aw heck, here it is anyway. (look everybody, a patch pulled in with
> pine!).  Complements of quilt.

Nope, does not help.  We still do way too much work in softirq context.

preemption latency trace v1.1.5 on 2.6.15-rc5-rt4
--------------------------------------------------------------------
 latency: 11184 us, #13458/13458, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
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
 netstat-6169  0D.h2    0us : __trace_start_sched_wakeup (try_to_wake_up)
 netstat-6169  0D.h2    1us : __trace_start_sched_wakeup <<...>-3> (62 0)
 netstat-6169  0D.h.    2us : wake_up_process (wakeup_softirqd)
 netstat-6169  0D.h.    3us : scheduler_tick (update_process_times)
 netstat-6169  0D.h.    3us : sched_clock (scheduler_tick)
 netstat-6169  0D.h1    5us : task_timeslice (scheduler_tick)
 netstat-6169  0D.h.    6us : run_posix_cpu_timers (update_process_times)
 netstat-6169  0D.h1    7us : note_interrupt (__do_IRQ)
 netstat-6169  0D.h1    7us : end_8259A_irq (__do_IRQ)
 netstat-6169  0D.h1    8us+: enable_8259A_irq (end_8259A_irq)
 netstat-6169  0DnH1   10us : irq_exit (do_IRQ)
 netstat-6169  0Dns1   11us < (608) 
 netstat-6169  0.ns.   12us : preempt_schedule (established_get_first)
 netstat-6169  0.ns.   13us : find_next_bit (established_get_first)
 netstat-6169  0.ns.   13us : cond_resched_softirq (established_get_first)
 netstat-6169  0.ns.   14us : preempt_schedule (established_get_first)
 netstat-6169  0.ns.   15us : find_next_bit (established_get_first)
 netstat-6169  0.ns.   16us : cond_resched_softirq (established_get_first)
 netstat-6169  0.ns.   17us : preempt_schedule (established_get_first)
 netstat-6169  0.ns.   17us : find_next_bit (established_get_first)
 netstat-6169  0.ns.   18us : cond_resched_softirq (established_get_first)
 netstat-6169  0.ns.   19us : preempt_schedule (established_get_first)
 netstat-6169  0.ns.   20us : find_next_bit (established_get_first)

[...]

 netstat-6169  0.ns. 11098us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11098us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11099us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11100us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11101us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11102us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11103us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11103us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11104us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11105us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11106us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11107us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11107us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11108us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11109us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11110us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11110us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11111us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11112us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11113us : preempt_schedule (established_get_next)
 netstat-6169  0.ns. 11114us : cond_resched_softirq (established_get_next)
 netstat-6169  0.ns. 11115us : tcp_seq_stop (seq_read)
 netstat-6169  0.ns. 11115us : local_bh_enable (tcp_seq_stop)
 netstat-6169  0.n.1 11116us : do_softirq (local_bh_enable)
 netstat-6169  0D.s. 11118us : __do_softirq (do_softirq)
 netstat-6169  0D.s. 11119us : ___do_softirq (__do_softirq)
 netstat-6169  0..s. 11120us : run_timer_softirq (___do_softirq)
 netstat-6169  0..s. 11122us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11123us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11124us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11125us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11126us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11127us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11128us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11129us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11129us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11130us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11131us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11132us : cond_resched_softirq (run_timer_softirq)
 netstat-6169  0..s. 11133us : hrtimer_run_queues (run_timer_softirq)
 netstat-6169  0..s. 11134us : get_realtime_clock (hrtimer_run_queues)
 netstat-6169  0..s. 11136us : read_tsc (get_realtime_clock)
 netstat-6169  0..s. 11137us : get_monotonic_clock (hrtimer_run_queues)
 netstat-6169  0..s. 11138us+: read_tsc (get_monotonic_clock)
 netstat-6169  0..s. 11142us : timeofday_periodic_hook (run_timer_softirq)
 netstat-6169  0D.s1 11143us+: read_tsc (timeofday_periodic_hook)
 netstat-6169  0D.s1 11146us+: ntp_advance (timeofday_periodic_hook)
 netstat-6169  0D.s1 11150us : get_next_clocksource (timeofday_periodic_hook)
 netstat-6169  0D.s1 11152us : tsc_update_callback (timeofday_periodic_hook)
 netstat-6169  0D.s1 11153us : ntp_get_ppm_adjustment (timeofday_periodic_hook)
 netstat-6169  0D.s1 11154us : update_legacy_time_values (timeofday_periodic_hook)
 netstat-6169  0D.s2 11156us : set_normalized_timespec (update_legacy_time_values)
 netstat-6169  0..s. 11157us : mod_timer (timeofday_periodic_hook)
 netstat-6169  0..s. 11158us : __mod_timer (mod_timer)
 netstat-6169  0..s. 11158us : lock_timer_base (__mod_timer)
 netstat-6169  0D.s1 11160us : internal_add_timer (__mod_timer)
 netstat-6169  0..s. 11161us : cond_resched_all (run_timer_softirq)
 netstat-6169  0..s. 11162us : cond_resched_softirq (cond_resched_all)
 netstat-6169  0..s. 11164us : __wake_up (run_timer_softirq)
 netstat-6169  0D.s1 11164us : __wake_up_common (__wake_up)
 netstat-6169  0..s. 11165us : cond_resched_all (___do_softirq)
 netstat-6169  0..s. 11166us : cond_resched_softirq (cond_resched_all)
 netstat-6169  0.n.. 11167us : preempt_schedule (local_bh_enable)
 netstat-6169  0Dn.. 11168us : __schedule (preempt_schedule)
 netstat-6169  0Dn.. 11169us : profile_hit (__schedule)
 netstat-6169  0Dn.1 11170us+: sched_clock (__schedule)
   <...>-3     0D..2 11176us+: __switch_to (__schedule)
   <...>-3     0D..2 11179us : __schedule <netstat-6169> (75 62)
   <...>-3     0...1 11180us : trace_stop_sched_switched (__schedule)
   <...>-3     0D..2 11181us+: trace_stop_sched_switched <<...>-3> (62 0)
   <...>-3     0D..2 11183us : trace_stop_sched_switched (__schedule)

