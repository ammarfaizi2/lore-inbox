Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUIBOjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUIBOjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUIBOjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:39:00 -0400
Received: from pD9E0EED0.dip.t-dialin.net ([217.224.238.208]:23940 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S266311AbUIBOiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:38:54 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040902132342.GA8677@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu> <1094130969.5652.13.camel@localhost>
	 <20040902132342.GA8677@elte.hu>
Content-Type: text/plain
Message-Id: <1094135913.5573.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 16:38:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :

> do you have the NMI watchdog enabled? That could help us debugging this. 
> Enabling the APIC/IO_APIC and using nmi_watchdog=1 would be the ideal
> solution - if that doesnt work then nmi_watchdog=2 would be fine too,
> but remove this code from arch/i386/kernel/nmi.c:
> 
> 	if (nmi_watchdog == NMI_LOCAL_APIC)
> 		nmi_hz = 1;
> 
> (otherwise nmi_watchdog=2 would result in one NMI per second, not enough
> to shed light on the above 2.8 msec latency.)
> 
> 	Ingo

nmi_watchdog=1 worked fine.
Here's a trace (there seem to be a counter overflow) :

preemption latency trace v1.0.5 on 2.6.9-rc1-VP-Q9
--------------------------------------------------
 latency: 539 us, entries: 38 (38)
    -----------------
    | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x190
 => ended at:   do_IRQ+0x14a/0x190
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (default_idle)
00010000 0.000ms (+0.000ms): do_IRQ (<00000000>)
00010001 0.000ms (+0.002ms): mask_and_ack_8259A (do_IRQ)
00010001 0.002ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010000 0.002ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 0.002ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 0.003ms (+0.005ms): mark_offset_tsc (timer_interrupt)
00010001 0.008ms (+0.000ms): do_timer (timer_interrupt)
00010001 0.008ms (+0.000ms): update_process_times (do_timer)
00010001 0.008ms (+0.000ms): update_one_process (update_process_times)
00010001 0.009ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.009ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.009ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.009ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.009ms (+0.000ms): update_wall_time (do_timer)
00010001 0.009ms (+0.000ms): update_wall_time_one_tick
(update_wall_time)
00010001 0.010ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010001 0.010ms (+0.000ms): end_8259A_irq (do_IRQ)
00010001 0.010ms (+0.000ms): enable_8259A_irq (do_IRQ)
00000001 0.011ms (+0.524ms): do_softirq (do_IRQ)
00000001 0.535ms (+0.000ms): do_nmi (mcount)
00010001 0.536ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.536ms (+0.000ms): profile_hook (profile_tick)
00010002 0.536ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.537ms (+689953.062ms): profile_hit (nmi_watchdog_tick)
00000002 689953.599ms (+1.523ms): sched_clock (activate_task)
00000001 0.537ms (+0.000ms): wake_up_process (do_softirq)
00000001 0.537ms (+0.000ms): try_to_wake_up (wake_up_process)
00000001 0.537ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000002 0.537ms (+0.000ms): activate_task (try_to_wake_up)
00000002 0.538ms (+0.000ms): sched_clock (activate_task)
00000002 0.538ms (+0.000ms): recalc_task_prio (activate_task)
00000002 0.538ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 0.538ms (+0.000ms): enqueue_task (activate_task)
00000001 0.538ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.539ms (+0.000ms): sub_preempt_count (do_IRQ)
00000001 0.539ms (+0.000ms): update_max_trace (check_preempt_timing)

Thomas


