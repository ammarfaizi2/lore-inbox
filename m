Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUHaT1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUHaT1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268832AbUHaT1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:27:14 -0400
Received: from pD9E0ED8C.dip.t-dialin.net ([217.224.237.140]:48775 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S268963AbUHaTYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:24:07 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040830180011.GA7419@elte.hu>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093875939.5534.9.camel@localhost>
	 <20040830180011.GA7419@elte.hu>
Content-Type: text/plain
Message-Id: <1093980227.8005.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 21:23:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :

(...)
> > and a weird one with do_timer (called from do_IRQ) taking more than 1ms
> > to complete :
> > http://www.undata.org/~thomas/do_irq.trace
> 
> hm, indeed this is a weird one. 1 msec is too close to the timer 
> frequency to be accidental. According to the trace:
> 
>  00010000 0.002ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
>  00010001 0.002ms (+0.000ms): mark_offset_tsc (timer_interrupt)
>  00010001 1.028ms (+1.025ms): do_timer (timer_interrupt)
>  00010001 1.028ms (+0.000ms): update_process_times (do_timer)
> 
> the latency happened between the beginning of mark_offset_tsc() and the
> calling of do_timer() - i.e. the delay happened somewhere within
> mark_offset_tsc() itself. Is this an SMP system?
> 
> 	Ingo

It isn't an SMP system, but here are some other traces that can prove
useful :
preemption latency trace v1.0.2
-------------------------------
 latency: 567 us, entries: 35 (35)
    -----------------
    | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x190
 => ended at:   do_IRQ+0x13d/0x190
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (default_idle)
00010001 0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
00010001 0.002ms (+0.002ms): generic_redirect_hardirq (do_IRQ)
00010000 0.002ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 0.002ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 0.003ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010001 0.562ms (+0.559ms): do_timer (timer_interrupt)
00010001 0.562ms (+0.000ms): update_process_times (do_timer)
00010001 0.562ms (+0.000ms): update_one_process (update_process_times)
00010001 0.562ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.562ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.562ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.562ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.563ms (+0.000ms): update_wall_time (do_timer)
00010001 0.563ms (+0.000ms): update_wall_time_one_tick
(update_wall_time)
00010001 0.563ms (+0.000ms): profile_tick (timer_interrupt)
00010001 0.563ms (+0.000ms): profile_hook (profile_tick)
00010002 0.563ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.564ms (+0.000ms): profile_hit (timer_interrupt)
00010001 0.564ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010001 0.564ms (+0.000ms): end_8259A_irq (do_IRQ)
00010001 0.564ms (+0.000ms): enable_8259A_irq (do_IRQ)
00000001 0.565ms (+0.000ms): do_softirq (do_IRQ)
00000001 0.565ms (+0.000ms): __do_softirq (do_softirq)
00000001 0.565ms (+0.000ms): wake_up_process (do_softirq)
00000001 0.565ms (+0.000ms): try_to_wake_up (wake_up_process)
00000001 0.566ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000002 0.566ms (+0.000ms): activate_task (try_to_wake_up)
00000002 0.566ms (+0.000ms): sched_clock (activate_task)
00000002 0.566ms (+0.000ms): recalc_task_prio (activate_task)
00000002 0.566ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 0.567ms (+0.000ms): enqueue_task (activate_task)
00000001 0.567ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.567ms (+0.000ms): sub_preempt_count (do_IRQ)

preemption latency trace v1.0.2
-------------------------------
 latency: 624 us, entries: 35 (35)
    -----------------
    | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x190
 => ended at:   do_IRQ+0x13d/0x190
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (default_idle)
00010001 0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
00010001 0.613ms (+0.612ms): generic_redirect_hardirq (do_IRQ)
00010000 0.613ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 0.613ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 0.613ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010001 0.619ms (+0.005ms): do_timer (timer_interrupt)
00010001 0.619ms (+0.000ms): update_process_times (do_timer)
00010001 0.619ms (+0.000ms): update_one_process (update_process_times)
00010001 0.619ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.619ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.619ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.619ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.620ms (+0.000ms): update_wall_time (do_timer)
00010001 0.620ms (+0.000ms): update_wall_time_one_tick
(update_wall_time)
00010001 0.620ms (+0.000ms): profile_tick (timer_interrupt)
00010001 0.620ms (+0.000ms): profile_hook (profile_tick)
00010002 0.620ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.621ms (+0.000ms): profile_hit (timer_interrupt)
00010001 0.621ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010001 0.621ms (+0.000ms): end_8259A_irq (do_IRQ)
00010001 0.621ms (+0.000ms): enable_8259A_irq (do_IRQ)
00000001 0.622ms (+0.000ms): do_softirq (do_IRQ)
00000001 0.622ms (+0.000ms): __do_softirq (do_softirq)
00000001 0.622ms (+0.000ms): wake_up_process (do_softirq)
00000001 0.622ms (+0.000ms): try_to_wake_up (wake_up_process)
00000001 0.623ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000002 0.623ms (+0.000ms): activate_task (try_to_wake_up)
00000002 0.623ms (+0.000ms): sched_clock (activate_task)
00000002 0.623ms (+0.000ms): recalc_task_prio (activate_task)
00000002 0.623ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 0.623ms (+0.000ms): enqueue_task (activate_task)
00000001 0.624ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.624ms (+0.000ms): sub_preempt_count (do_IRQ)

As you can see ~1ms was probably an accident, and the latency does not
always come from do_timer. The constant is do_IRQ interrupting the idle
thread.

Thomas


