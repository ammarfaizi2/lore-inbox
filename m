Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269272AbUICQOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269272AbUICQOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUICQOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:14:50 -0400
Received: from pD9E0EAE4.dip.t-dialin.net ([217.224.234.228]:32387 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S269272AbUICQOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:14:32 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
In-Reply-To: <20040903114949.GA29493@elte.hu>
References: <1094181447.4815.6.camel@orbiter>
	 <1094192788.19760.47.camel@krustophenia.net>
	 <20040903063658.GA11801@elte.hu>
	 <1094194157.19760.71.camel@krustophenia.net>
	 <20040903070500.GB13100@elte.hu>
	 <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org>
	 <1094198755.19760.133.camel@krustophenia.net>
	 <20040903092547.GA18594@elte.hu> <1094211218.5453.3.camel@localhost>
	 <20040903114949.GA29493@elte.hu>
Content-Type: text/plain
Message-Id: <1094228060.5492.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 18:14:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> this is a pretty weird one. First it shows an apparently non-monotonic
> RDTSC: the jump forward and backward in time around profile_hit. I
> suspect the real RDTSC value was lower than the previous one and caused
> an underflow. What is your cpu_khz in /proc/cpuinfo?
> 
> the other weird one is the +0.595 usec entry at notifier_call_chain(). 
> That code is just a couple of instructions, so no real for any overhead 
> there.
> 
> could you try the attached robust-get-cycles.patch ontop of your current
> tree and see whether it impacts these weirdnesses? The patch makes sure
> that the cycle counter is sane: two subsequent readings of it were
> monotonic and less than 1000 cycles apart.
> 
> this patch probably wont remove the +0.595 msec latency though - the
> RDTSC value jumped forward there permanently. Maybe the RDTSC value is
> somehow corrupted by NMIs - could you turn off the NMI watchdog to
> check?

Here are more traces with robust-get-cycles applied. So far no
non-monotonic issue.

preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
--------------------------------------------------
 latency: 626 us, entries: 25 (25)
    -----------------
    | task: ksoftirqd/0/2, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: preempt_schedule+0x3b/0x60
 => ended at:   schedule+0x2e4/0x570
=======>
04000000 0.000ms (+0.000ms): preempt_schedule (need_resched)
04000000 0.000ms (+0.000ms): schedule (preempt_schedule)
04000001 0.000ms (+0.620ms): sched_clock (schedule)
04010001 0.620ms (+0.000ms): do_nmi (sched_clock)
04010001 0.621ms (+0.000ms): profile_tick (nmi_watchdog_tick)
04010001 0.622ms (+0.000ms): profile_hook (profile_tick)
04010002 0.622ms (+0.000ms): notifier_call_chain (profile_hook)
04010001 0.622ms (+0.000ms): preempt_schedule (profile_tick)
04010001 0.622ms (+0.000ms): profile_hit (nmi_watchdog_tick)
04000001 0.623ms (+0.000ms): smp_apic_timer_interrupt (sched_clock)
04010001 0.623ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
04010001 0.623ms (+0.000ms): profile_hook (profile_tick)
04010002 0.623ms (+0.000ms): notifier_call_chain (profile_hook)
04010001 0.624ms (+0.000ms): preempt_schedule (profile_tick)
04010001 0.624ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
04000002 0.624ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
04000002 0.624ms (+0.000ms): __do_softirq (do_softirq)
04000002 0.625ms (+0.000ms): dequeue_task (schedule)
04000002 0.625ms (+0.000ms): recalc_task_prio (schedule)
04000002 0.625ms (+0.000ms): effective_prio (recalc_task_prio)
04000002 0.625ms (+0.000ms): enqueue_task (schedule)
00000002 0.626ms (+0.000ms): __switch_to (schedule)
00000002 0.626ms (+0.000ms): finish_task_switch (schedule)
00000001 0.626ms (+0.000ms): sub_preempt_count (schedule)
00000001 0.627ms (+0.000ms): update_max_trace (check_preempt_timing)

preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
--------------------------------------------------
 latency: 460 us, entries: 38 (38)
    -----------------
    | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x190
 => ended at:   do_IRQ+0x14a/0x190
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (default_idle)
00010000 0.000ms (+0.000ms): do_IRQ (<00000000>)
00010001 0.000ms (+0.444ms): mask_and_ack_8259A (do_IRQ)
00020002 0.444ms (+0.000ms): do_nmi (mask_and_ack_8259A)
00020002 0.445ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00020002 0.446ms (+0.000ms): profile_hook (profile_tick)
00020003 0.446ms (+0.000ms): notifier_call_chain (profile_hook)
00020002 0.446ms (+0.001ms): profile_hit (nmi_watchdog_tick)
00010001 0.448ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010000 0.448ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 0.448ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 0.448ms (+0.005ms): mark_offset_tsc (timer_interrupt)
00010001 0.454ms (+0.000ms): do_timer (timer_interrupt)
00010001 0.454ms (+0.000ms): update_process_times (do_timer)
00010001 0.454ms (+0.000ms): update_one_process (update_process_times)
00010001 0.455ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.455ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.455ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.455ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.456ms (+0.000ms): update_wall_time (do_timer)
00010001 0.456ms (+0.000ms): update_wall_time_one_tick
(update_wall_time)
00010001 0.456ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010001 0.456ms (+0.000ms): end_8259A_irq (do_IRQ)
00010001 0.457ms (+0.001ms): enable_8259A_irq (do_IRQ)
00000001 0.458ms (+0.000ms): do_softirq (do_IRQ)
00000001 0.458ms (+0.000ms): __do_softirq (do_softirq)
00000001 0.458ms (+0.000ms): wake_up_process (do_softirq)
00000001 0.458ms (+0.000ms): try_to_wake_up (wake_up_process)
00000001 0.458ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000002 0.459ms (+0.000ms): activate_task (try_to_wake_up)
00000002 0.459ms (+0.000ms): sched_clock (activate_task)
00000002 0.459ms (+0.000ms): recalc_task_prio (activate_task)
00000002 0.459ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 0.459ms (+0.000ms): enqueue_task (activate_task)
00000001 0.460ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.460ms (+0.000ms): sub_preempt_count (do_IRQ)
00000001 0.460ms (+0.000ms): update_max_trace (check_preempt_timing)

preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
--------------------------------------------------
 latency: 557 us, entries: 39 (39)
    -----------------
    | task: evolution-1.4/5492, uid:1000 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: fget+0x32/0x80
 => ended at:   fget+0x58/0x80
=======>
00000001 0.000ms (+0.537ms): fget (do_pollfd)
00010001 0.537ms (+0.000ms): do_nmi (sub_preempt_count)
00010001 0.538ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.538ms (+0.000ms): profile_hook (profile_tick)
00010002 0.539ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.539ms (+0.001ms): profile_hit (nmi_watchdog_tick)
00010001 0.540ms (+0.000ms): do_IRQ (sub_preempt_count)
00010001 0.540ms (+0.000ms): do_IRQ (<00000000>)
00010002 0.541ms (+0.002ms): mask_and_ack_8259A (do_IRQ)
00010002 0.543ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 0.543ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 0.543ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010002 0.544ms (+0.005ms): mark_offset_tsc (timer_interrupt)
00010002 0.549ms (+0.000ms): do_timer (timer_interrupt)
00010002 0.550ms (+0.000ms): update_process_times (do_timer)
00010002 0.550ms (+0.000ms): update_one_process (update_process_times)
00010002 0.550ms (+0.000ms): run_local_timers (update_process_times)
00010002 0.550ms (+0.000ms): raise_softirq (update_process_times)
00010002 0.551ms (+0.000ms): scheduler_tick (update_process_times)
00010002 0.551ms (+0.000ms): sched_clock (scheduler_tick)
00010003 0.551ms (+0.000ms): task_timeslice (scheduler_tick)
00010002 0.552ms (+0.000ms): update_wall_time (do_timer)
00010002 0.552ms (+0.000ms): update_wall_time_one_tick
(update_wall_time)
00010002 0.552ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 0.553ms (+0.000ms): end_8259A_irq (do_IRQ)
00010002 0.553ms (+0.001ms): enable_8259A_irq (do_IRQ)
00000002 0.554ms (+0.000ms): do_softirq (do_IRQ)
00000002 0.554ms (+0.000ms): __do_softirq (do_softirq)
00000002 0.554ms (+0.000ms): wake_up_process (do_softirq)
00000002 0.555ms (+0.000ms): try_to_wake_up (wake_up_process)
00000002 0.555ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000003 0.555ms (+0.000ms): activate_task (try_to_wake_up)
00000003 0.555ms (+0.000ms): sched_clock (activate_task)
00000003 0.555ms (+0.000ms): recalc_task_prio (activate_task)
00000003 0.556ms (+0.000ms): effective_prio (recalc_task_prio)
00000003 0.556ms (+0.000ms): enqueue_task (activate_task)
00000002 0.556ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.557ms (+0.000ms): sub_preempt_count (fget)
00000001 0.557ms (+0.000ms): update_max_trace (check_preempt_timing)

I had similar problems affecting apparently random code paths before
enabling nmi_watchdog, but if you feel it can be useful, I can do some
more tests with robust-get-cycles and without nmi.

Thomas


