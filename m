Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269079AbUIHUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269079AbUIHUeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269084AbUIHUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:34:22 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:44984 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S269079AbUIHUeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:34:16 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Lee Revell <rlrevell@joe-job.com>,
       Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Wed, 8 Sep 2004 15:33:10 -0500
Message-ID: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/08/2004 03:33:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>.... Please disable IDE DMA and see
>what happens (after hiding the PIO IDE codepath via
>touch_preempt_timing()).

Not quite sure where to add touch_preempt_timing() calls - somewhere in the
loop in ide_outsl and ide_insl? [so we keep resetting the start /end
times?]

I did collect some initial data - most are of the form:

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8
-------------------------------------------------------
 latency: 545 us, entries: 8 (8)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: IRQ 14/140, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: kmap_atomic+0x23/0xe0
 => ended at:   kunmap_atomic+0x7b/0xa0
=======>
00000001 0.000ms (+0.000ms): kmap_atomic (ide_multwrite)
00000001 0.000ms (+0.001ms): page_address (ide_multwrite)
00000001 0.001ms (+0.000ms): taskfile_output_data (ide_multwrite)
00000001 0.002ms (+0.000ms): ata_output_data (taskfile_output_data)
00000001 0.003ms (+0.542ms): ide_outsl (ata_output_data)
00000001 0.545ms (+0.000ms): kunmap_atomic (ide_multwrite)
00000001 0.545ms (+0.000ms): sub_preempt_count (kunmap_atomic)
00000001 0.546ms (+0.000ms): update_max_trace (check_preempt_timing)

Which I am sure is what you expected.

I did get a couple that looked like this:

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8
-------------------------------------------------------
 latency: 1261 us, entries: 73 (73)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: sleep/4859, uid:0 nice:-9 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (do_wp_page)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): kmap_atomic (do_wp_page)
00000002 0.000ms (+0.000ms): page_address (do_wp_page)
00000002 0.001ms (+0.000ms): page_remove_rmap (do_wp_page)
00000002 0.002ms (+0.001ms): flush_tlb_page (do_wp_page)
00000003 0.003ms (+0.000ms): flush_tlb_others (flush_tlb_page)
00000003 0.003ms (+0.000ms): spin_lock (flush_tlb_others)
00000004 0.004ms (+0.001ms): spin_lock (<00000000>)
00000004 0.005ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000004 0.005ms (+0.321ms): send_IPI_mask_bitmask (flush_tlb_others)
00010004 0.327ms (+0.000ms): do_nmi (flush_tlb_others)
00010004 0.327ms (+0.003ms): do_nmi (kallsyms_lookup)
00010004 0.331ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010004 0.331ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010004 0.331ms (+0.000ms): profile_hook (profile_tick)
00010004 0.332ms (+0.000ms): read_lock (profile_hook)
00010005 0.332ms (+0.000ms): read_lock (<00000000>)
00010005 0.332ms (+0.000ms): notifier_call_chain (profile_hook)
00010005 0.332ms (+0.000ms): _read_unlock (profile_tick)
00010004 0.333ms (+0.091ms): profile_hit (nmi_watchdog_tick)
00000004 0.424ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
...
00000005 0.431ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000005 0.431ms (+0.000ms): __do_softirq (do_softirq)
00000005 0.432ms (+0.000ms): wake_up_process (do_softirq)
00000005 0.432ms (+0.000ms): try_to_wake_up (wake_up_process)
00000005 0.433ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000005 0.433ms (+0.000ms): spin_lock (task_rq_lock)
00000006 0.433ms (+0.000ms): spin_lock (<00000000>)
00000006 0.433ms (+0.000ms): wake_idle (try_to_wake_up)
00000006 0.434ms (+0.000ms): activate_task (try_to_wake_up)
00000006 0.434ms (+0.000ms): sched_clock (activate_task)
00000006 0.434ms (+0.000ms): recalc_task_prio (activate_task)
00000006 0.435ms (+0.000ms): effective_prio (recalc_task_prio)
00000006 0.435ms (+0.000ms): __activate_task (try_to_wake_up)
00000006 0.436ms (+0.000ms): enqueue_task (__activate_task)
00000006 0.436ms (+0.000ms): sched_info_queued (enqueue_task)
00000006 0.437ms (+0.000ms): resched_task (try_to_wake_up)
00000006 0.437ms (+0.000ms): task_rq_unlock (try_to_wake_up)
00000006 0.437ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
00000005 0.437ms (+0.820ms): preempt_schedule (try_to_wake_up)
00000004 1.258ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000003 1.258ms (+0.000ms): preempt_schedule (flush_tlb_others)
00000002 1.258ms (+0.000ms): preempt_schedule (flush_tlb_page)
...

or this

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8
-------------------------------------------------------
 latency: 1210 us, entries: 113 (113)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: get_ltrace.sh/3071, uid:0 nice:-9 policy:0 rt_prio:0
    -----------------
 => started at: flush_tlb_mm+0x1d/0xd0
 => ended at:   flush_tlb_mm+0x52/0xd0
=======>
00000001 0.000ms (+0.001ms): flush_tlb_mm (copy_mm)
00000001 0.001ms (+0.000ms): flush_tlb_others (flush_tlb_mm)
00000001 0.001ms (+0.000ms): spin_lock (flush_tlb_others)
00000002 0.002ms (+0.000ms): spin_lock (<00000000>)
00000002 0.003ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000002 0.003ms (+0.378ms): send_IPI_mask_bitmask (flush_tlb_others)
00000002 0.381ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
...
00010003 0.459ms (+0.000ms): preempt_schedule (timer_interrupt)
00010003 0.460ms (+0.000ms): do_timer (timer_interrupt)
00010003 0.460ms (+0.000ms): update_wall_time (do_timer)
00010003 0.460ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010003 0.460ms (+0.000ms): _spin_unlock (timer_interrupt)
00010002 0.460ms (+0.000ms): preempt_schedule (timer_interrupt)
00010002 0.461ms (+0.000ms): spin_lock (do_IRQ)
00010003 0.461ms (+0.000ms): spin_lock (<00000000>)
00010003 0.461ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010003 0.461ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010003 0.461ms (+0.000ms): _spin_unlock (do_IRQ)
00010002 0.462ms (+0.000ms): preempt_schedule (do_IRQ)
00000003 0.462ms (+0.000ms): do_softirq (do_IRQ)
00000003 0.462ms (+0.747ms): __do_softirq (do_softirq)
00000002 1.209ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000001 1.210ms (+0.000ms): preempt_schedule (flush_tlb_others)
00000001 1.210ms (+0.000ms): sub_preempt_count (flush_tlb_mm)
00000001 1.211ms (+0.000ms): update_max_trace (check_preempt_timing)

where I had > 1 msec latencies w/o any apparent references to the IDE.

  --Mark

