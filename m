Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUIMOvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUIMOvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUIMOvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:51:01 -0400
Received: from lax-gate3.raytheon.com ([199.46.200.232]:32503 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S266833AbUIMOrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:47:17 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, Free Ekanayaka <free@agnula.org>,
       free78@tin.it, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>, luke@audioslack.com,
       nando@ccrma.stanford.edu,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Mon, 13 Sep 2004 09:44:53 -0500
Message-ID: <OF85F4CCF4.D54BACFC-ON86256F0E.00510311-86256F0E.00510399@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/13/2004 09:44:59 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>most of your remaining latencies seem to be get_swap_page() related -
>the attached (highly experimental) patch might fix that particular
>latency. (ontop of -S0).

Qualitatively, -S0 with this patch is a little worse than what I saw with
-R8.
>From the last message I sent...

> -R8 on September 10 - 38 traces > 200 usec, only 3 > 500 usec
-S0 on September 13 - 78 traces > 200 usec, only 3 > 500 usec

So I have more relatively small delays in the same test period - almost
twice as much with few that I can see are swap related. Most are network
related. One very long trace > 70 msec - this is the third day I've had
a single multiple millisecond trace in a run.

Key contributors seem to be:
 - IRQ sequence         - 00 02 50 64 73 75 76 77
 - modprobe             - 01
 - rtl8139_poll         - 03 04 07 08 09 10 12 13 15 16 17 18 19 21 24 47
                        - 49 72 74
 - tcp_prequeue_process - 05
 - release_sock         - 06 14
 - tcp_copy_to_iovec    - 11
 - do_munmap            - 20 [very long trace]
 - twkill_work          - 22
 - exit_mmap            - 23 25 26 27 28 29 30 31 32 36 37 38 39 40 41 44
                        - 46 48 51 52 53 54 55 57 58 59 60 61 62 66 67 68
                        - 69 70 71
 - kswapd               - 33 34 35 42 63
 - avc_insert           - 43 45 65
 - schedule             - 56

IRQ Sequence
============

Hard to describe - no specific steps that take a long time, just
a long series of activities, appear to be IRQ related that add up to
a > 300 usec time delay. Many I noted have mouse / signal related
activities, see also the "schedule" trace near the end for a similar
condition.

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 342 us, entries: 280 (280)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kjournald/191, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: __spin_lock_irqsave+0x2b/0xb0
 => ended at:   _spin_unlock_irq+0x2e/0x60
=======>
[should look at the full traces for details]

modprobe
========

The shortest trace. I had ran
  system-config-soundcard
to play the test sound before starting the real time test program to
make sure the sound system ran OK. Not something I would expect to do
on a real time system, but something to fix (or document as a limitation).

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 460 us, entries: 9 (9)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: modprobe/2995, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: __spin_lock_irqsave+0x2b/0xb0
 => ended at:   _spin_unlock_irq+0x2e/0x60
=======>
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000001 0.000ms (+0.454ms): __find_symbol (resolve_symbol)
00000001 0.455ms (+0.000ms): use_module (resolve_symbol)
00000001 0.455ms (+0.003ms): already_uses (use_module)
00000001 0.459ms (+0.001ms): kmem_cache_alloc (use_module)
00000001 0.460ms (+0.000ms): _spin_unlock_irq (resolve_symbol)
00000001 0.460ms (+0.000ms): sub_preempt_count (_spin_unlock_irq)
00000001 0.461ms (+0.000ms): update_max_trace (check_preempt_timing)

rtl8139_poll
============

We've talked this one before but still shows up on a regular basis.

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 347 us, entries: 245 (245)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: ksoftirqd/0/3, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   rtl8139_rx+0x219/0x340
=======>
[again - no big steps, just a large number w/o reschedule opportunity]

tcp_prequeue_process
====================

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 271 us, entries: 294 (294)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: rcp/3591, uid:2711 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: tcp_prequeue_process+0x49/0xb0
 => ended at:   tcp_write_xmit+0x249/0x330
=======>
[appears similar to the others - many steps, each one very short]

release_sock
============

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 209 us, entries: 275 (275)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: rcp/3705, uid:2711 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: __spin_lock_irqsave+0x2b/0xb0
 => ended at:   cond_resched_softirq+0x65/0x90
=======>
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_bh)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000101 0.000ms (+0.000ms): __release_sock (release_sock)
00000101 0.000ms (+0.000ms): _spin_unlock (__release_sock)
... long sequence, not long in each step ...

tcp_copy_to_iovec
=================

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 210 us, entries: 243 (243)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: rcp/3894, uid:2711 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: tcp_copy_to_iovec+0x5b/0xb0
 => ended at:   local_bh_enable+0x17/0xa0
=======>
00000100 0.000ms (+0.002ms): tcp_copy_to_iovec (tcp_rcv_established)
00000100 0.002ms (+0.005ms): tcp_event_data_recv (tcp_rcv_established)
00000100 0.007ms (+0.000ms): tcp_send_ack (tcp_rcv_established)
... large number of steps, each one very short in duration ...

do_munmap
=========

The very long trace (> 4000 traces, > 70 msec). Following lists all steps
until we get "stuck" with roughly 1 msec pauses. Note - I don't have the
"how we got out" part of this trace but see previous messages for that
kind of detail.

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 71065 us, entries: 4000 (5343)   |   [VP:1 KP:1 SP:1 HP:1
#CPUS:2]
    -----------------
    | task: latencytest/4408, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   cond_resched_lock+0x1d/0xa0
=======>
00000001 0.000ms (+0.000ms): spin_lock (do_munmap)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): unmap_region (do_munmap)
00000001 0.001ms (+0.000ms): lru_add_drain (unmap_region)
00000002 0.001ms (+0.000ms): __pagevec_lru_add_active (lru_add_drain)
00000002 0.002ms (+0.000ms): spin_lock_irq (__pagevec_lru_add_active)
00000002 0.002ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
00000003 0.002ms (+0.001ms): __spin_lock_irqsave (<00000000>)
00000003 0.003ms (+0.000ms): _spin_unlock_irq (__pagevec_lru_add_active)
00000002 0.003ms (+0.001ms): release_pages (__pagevec_lru_add_active)
00000001 0.004ms (+0.001ms): __bitmap_weight (unmap_region)
00000001 0.006ms (+0.001ms): unmap_vmas (unmap_region)
00000001 0.007ms (+0.000ms): unmap_page_range (unmap_vmas)
00000001 0.007ms (+0.000ms): zap_pmd_range (unmap_page_range)
00000001 0.008ms (+0.000ms): zap_pte_range (zap_pmd_range)
00000001 0.009ms (+0.000ms): kmap_atomic (zap_pte_range)
00000002 0.009ms (+0.001ms): page_address (zap_pte_range)
00000002 0.011ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.012ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.013ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.013ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.013ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.013ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.014ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.014ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.015ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.015ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.015ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.016ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.016ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.016ms (+0.001ms): page_remove_rmap (zap_pte_range)
00000002 0.017ms (+0.000ms): smp_apic_timer_interrupt (zap_pte_range)
00010002 0.018ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010002 0.018ms (+0.000ms): profile_hook (profile_tick)
00010002 0.018ms (+0.000ms): read_lock (profile_hook)
00010003 0.019ms (+0.000ms): read_lock (<00000000>)
00010003 0.019ms (+0.000ms): notifier_call_chain (profile_hook)
00010003 0.019ms (+0.000ms): _read_unlock (profile_tick)
00010002 0.020ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010002 0.021ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010002 0.021ms (+0.000ms): update_one_process (update_process_times)
00010002 0.022ms (+0.000ms): run_local_timers (update_process_times)
00010002 0.022ms (+0.000ms): raise_softirq (update_process_times)
00010002 0.023ms (+0.000ms): scheduler_tick (update_process_times)
00010002 0.023ms (+0.002ms): sched_clock (scheduler_tick)
00010002 0.026ms (+0.000ms): spin_lock (scheduler_tick)
00010003 0.027ms (+0.000ms): spin_lock (<00000000>)
00010003 0.027ms (+0.000ms): _spin_unlock (scheduler_tick)
00010002 0.027ms (+0.001ms): rebalance_tick (scheduler_tick)
00000003 0.028ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000003 0.029ms (+0.001ms): __do_softirq (do_softirq)
00000002 0.030ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.031ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.031ms (+0.001ms): kunmap_atomic (zap_pte_range)
00000001 0.032ms (+0.002ms): flush_tlb_mm (unmap_vmas)
00000002 0.034ms (+0.000ms): flush_tlb_others (flush_tlb_mm)
00000002 0.035ms (+0.000ms): spin_lock (flush_tlb_others)
00000003 0.035ms (+0.000ms): spin_lock (<00000000>)
00000003 0.036ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000003 0.037ms (+0.158ms): send_IPI_mask_bitmask (flush_tlb_others)
00010003 0.195ms (+0.000ms): do_nmi (flush_tlb_others)
00010003 0.195ms (+0.002ms): do_nmi (__trace)
00010003 0.198ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010003 0.199ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010003 0.199ms (+0.000ms): profile_hook (profile_tick)
00010003 0.199ms (+0.000ms): read_lock (profile_hook)
00010004 0.199ms (+0.000ms): read_lock (<00000000>)
00010004 0.199ms (+0.000ms): notifier_call_chain (profile_hook)
00010004 0.200ms (+0.000ms): _read_unlock (profile_tick)
00010003 0.200ms (+0.001ms): profile_hit (nmi_watchdog_tick)
00010003 0.202ms (+0.000ms): do_IRQ (flush_tlb_others)
00010003 0.202ms (+0.000ms): do_IRQ (<00000000>)
00010003 0.202ms (+0.000ms): spin_lock (do_IRQ)
00010004 0.203ms (+0.000ms): spin_lock (<00000000>)
00010004 0.203ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010004 0.203ms (+0.000ms): redirect_hardirq (do_IRQ)
00010004 0.204ms (+0.000ms): _spin_unlock (do_IRQ)
00010003 0.204ms (+0.000ms): handle_IRQ_event (do_IRQ)
00010003 0.204ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010003 0.204ms (+0.000ms): spin_lock (timer_interrupt)
00010004 0.205ms (+0.000ms): spin_lock (<00000000>)
00010004 0.205ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010004 0.205ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010004 0.206ms (+0.000ms): spin_lock (mark_offset_tsc)
00010005 0.206ms (+0.000ms): spin_lock (<00000000>)
00010005 0.206ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 0.206ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 0.206ms (+0.000ms): spin_lock (mark_offset_tsc)
00010006 0.207ms (+0.000ms): spin_lock (<00000000>)
00010006 0.207ms (+0.003ms): mark_offset_tsc (timer_interrupt)
00010006 0.211ms (+0.004ms): mark_offset_tsc (timer_interrupt)
00010006 0.215ms (+0.002ms): mark_offset_tsc (timer_interrupt)
00010006 0.217ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010006 0.217ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010006 0.217ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010005 0.218ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 0.218ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 0.218ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 0.219ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010004 0.219ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010004 0.219ms (+0.000ms): spin_lock (timer_interrupt)
00010005 0.220ms (+0.003ms): spin_lock (<00000000>)
00010005 0.223ms (+0.000ms): _spin_unlock (timer_interrupt)
00010004 0.224ms (+0.000ms): do_timer (timer_interrupt)
00010004 0.224ms (+0.000ms): update_wall_time (do_timer)
00010004 0.225ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010004 0.225ms (+0.000ms): _spin_unlock (timer_interrupt)
00010003 0.226ms (+0.000ms): spin_lock (do_IRQ)
00010004 0.226ms (+0.000ms): spin_lock (<00000000>)
00010004 0.226ms (+0.000ms): note_interrupt (do_IRQ)
00010004 0.227ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010004 0.227ms (+0.000ms): _spin_unlock (do_IRQ)
00000004 0.227ms (+0.000ms): do_softirq (do_IRQ)
00000004 0.227ms (+0.788ms): __do_softirq (do_softirq)
00000003 1.016ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
00010003 1.016ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010003 1.017ms (+0.000ms): profile_hook (profile_tick)
00010003 1.017ms (+0.000ms): read_lock (profile_hook)
00010004 1.017ms (+0.000ms): read_lock (<00000000>)
00010004 1.017ms (+0.000ms): notifier_call_chain (profile_hook)
00010004 1.017ms (+0.000ms): _read_unlock (profile_tick)
00010003 1.018ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010003 1.018ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010003 1.018ms (+0.000ms): update_one_process (update_process_times)
00010003 1.018ms (+0.000ms): run_local_timers (update_process_times)
00010003 1.018ms (+0.000ms): raise_softirq (update_process_times)
00010003 1.019ms (+0.000ms): scheduler_tick (update_process_times)
00010003 1.019ms (+0.000ms): sched_clock (scheduler_tick)
00010003 1.019ms (+0.000ms): spin_lock (scheduler_tick)
00010004 1.019ms (+0.000ms): spin_lock (<00000000>)
00010004 1.019ms (+0.000ms): _spin_unlock (scheduler_tick)
00010003 1.020ms (+0.000ms): rebalance_tick (scheduler_tick)
00000004 1.020ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000004 1.020ms (+0.173ms): __do_softirq (do_softirq)
00010003 1.193ms (+0.000ms): do_nmi (flush_tlb_others)
00010003 1.194ms (+0.001ms): do_nmi (__trace)
00010003 1.195ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010003 1.196ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010003 1.196ms (+0.000ms): profile_hook (profile_tick)
00010003 1.196ms (+0.000ms): read_lock (profile_hook)
00010004 1.196ms (+0.000ms): read_lock (<00000000>)
00010004 1.196ms (+0.000ms): notifier_call_chain (profile_hook)
00010004 1.197ms (+0.000ms): _read_unlock (profile_tick)
00010003 1.197ms (+0.000ms): profile_hit (nmi_watchdog_tick)
00010003 1.198ms (+0.000ms): do_IRQ (flush_tlb_others)
00010003 1.198ms (+0.000ms): do_IRQ (<00000000>)
00010003 1.198ms (+0.000ms): spin_lock (do_IRQ)
00010004 1.198ms (+0.000ms): spin_lock (<00000000>)
00010004 1.198ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010004 1.199ms (+0.000ms): redirect_hardirq (do_IRQ)
00010004 1.199ms (+0.000ms): _spin_unlock (do_IRQ)
00010003 1.199ms (+0.000ms): handle_IRQ_event (do_IRQ)
00010003 1.199ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010003 1.199ms (+0.000ms): spin_lock (timer_interrupt)
00010004 1.200ms (+0.000ms): spin_lock (<00000000>)
00010004 1.200ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010004 1.200ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010004 1.200ms (+0.000ms): spin_lock (mark_offset_tsc)
00010005 1.200ms (+0.000ms): spin_lock (<00000000>)
00010005 1.201ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 1.201ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 1.201ms (+0.000ms): spin_lock (mark_offset_tsc)
00010006 1.201ms (+0.000ms): spin_lock (<00000000>)
00010006 1.201ms (+0.003ms): mark_offset_tsc (timer_interrupt)
00010006 1.205ms (+0.004ms): mark_offset_tsc (timer_interrupt)
00010006 1.209ms (+0.002ms): mark_offset_tsc (timer_interrupt)
00010006 1.212ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010006 1.212ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010006 1.212ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010005 1.212ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 1.213ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 1.213ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010005 1.213ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010004 1.213ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010004 1.213ms (+0.000ms): spin_lock (timer_interrupt)
00010005 1.214ms (+0.003ms): spin_lock (<00000000>)
00010005 1.217ms (+0.000ms): _spin_unlock (timer_interrupt)
00010004 1.218ms (+0.000ms): do_timer (timer_interrupt)
00010004 1.218ms (+0.000ms): update_wall_time (do_timer)
00010004 1.218ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010004 1.218ms (+0.000ms): _spin_unlock (timer_interrupt)
00010003 1.219ms (+0.000ms): spin_lock (do_IRQ)
00010004 1.219ms (+0.000ms): spin_lock (<00000000>)
00010004 1.219ms (+0.000ms): note_interrupt (do_IRQ)
00010004 1.219ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010004 1.219ms (+0.000ms): _spin_unlock (do_IRQ)
00000004 1.220ms (+0.000ms): do_softirq (do_IRQ)
00000004 1.220ms (+0.795ms): __do_softirq (do_softirq)
00000003 2.016ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
... the steps over the last millisecond get repeated for several cycles ...

twkill_work
===========

A very long sequence (> 1500 traces) with non zero preempt values
that end in "00". Does that mean we did not have any locks but could
not schedule for other reasons?

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 429 us, entries: 1531 (1531)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: events/0/6, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: __spin_lock_irqsave+0x2b/0xb0
 => ended at:   twkill_work+0xb5/0xe0
=======>
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_bh)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000101 0.000ms (+0.000ms): tcp_do_twkill_work (twkill_work)
00000101 0.000ms (+0.000ms): _spin_unlock (tcp_do_twkill_work)
00000100 0.001ms (+0.000ms): tcp_timewait_kill (tcp_do_twkill_work)
00000100 0.001ms (+0.000ms): write_lock (tcp_timewait_kill)
00000101 0.001ms (+0.000ms): write_lock (<00000000>)
00000101 0.002ms (+0.000ms): _write_unlock (tcp_timewait_kill)
00000100 0.002ms (+0.000ms): spin_lock (tcp_timewait_kill)
00000101 0.002ms (+0.000ms): spin_lock (<00000000>)
00000101 0.002ms (+0.000ms): tcp_bucket_destroy (tcp_timewait_kill)
00000101 0.003ms (+0.000ms): kmem_cache_free (tcp_bucket_destroy)
00000101 0.003ms (+0.000ms): _spin_unlock (tcp_timewait_kill)
00000100 0.003ms (+0.000ms): kmem_cache_free (tcp_do_twkill_work)
00000100 0.003ms (+0.000ms): spin_lock (tcp_do_twkill_work)
00000101 0.004ms (+0.000ms): spin_lock (<00000000>)
00000101 0.004ms (+0.000ms): _spin_unlock (tcp_do_twkill_work)
00000100 0.004ms (+0.000ms): tcp_timewait_kill (tcp_do_twkill_work)
00000100 0.004ms (+0.000ms): write_lock (tcp_timewait_kill)
...

exit_mmap
=========

This one has a relatively low time delay for clear_page_tables, but
several other traces have 100 to 200 usec delays at this step. [though
if you add the delay handling the nmi_watchdog, it falls in the 100-200
range as well]

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 266 us, entries: 146 (146)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: get_ltrace.sh/5099, uid:0 nice:-9 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (cond_resched_lock)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): __bitmap_weight (unmap_vmas)
00000001 0.000ms (+0.001ms): vm_acct_memory (exit_mmap)
00000001 0.001ms (+0.056ms): clear_page_tables (exit_mmap)
00010001 0.058ms (+0.000ms): do_nmi (clear_page_tables)
00010001 0.058ms (+0.002ms): do_nmi (__mcount)
00010001 0.060ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010001 0.061ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.061ms (+0.000ms): profile_hook (profile_tick)
00010001 0.061ms (+0.000ms): read_lock (profile_hook)
00010002 0.061ms (+0.000ms): read_lock (<00000000>)
00010002 0.061ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.062ms (+0.000ms): _read_unlock (profile_tick)
00010001 0.062ms (+0.091ms): profile_hit (nmi_watchdog_tick)
00010001 0.153ms (+0.000ms): do_IRQ (clear_page_tables)
00010001 0.153ms (+0.000ms): do_IRQ (<0000000a>)
00010001 0.153ms (+0.000ms): spin_lock (do_IRQ)
00010002 0.154ms (+0.000ms): spin_lock (<00000000>)
00010002 0.154ms (+0.000ms): mask_and_ack_level_ioapic_irq (do_IRQ)
00010002 0.154ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
00010002 0.154ms (+0.000ms): __spin_lock_irqsave (mask_IO_APIC_irq)
00010003 0.154ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00010003 0.154ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
00010003 0.155ms (+0.018ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
00010003 0.173ms (+0.000ms): _spin_unlock_irqrestore (mask_IO_APIC_irq)
00010002 0.174ms (+0.000ms): redirect_hardirq (do_IRQ)
00010002 0.174ms (+0.000ms): _spin_unlock (do_IRQ)
00010001 0.174ms (+0.000ms): handle_IRQ_event (do_IRQ)
00010001 0.174ms (+0.000ms): usb_hcd_irq (handle_IRQ_event)
...

kswapd
======

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 557 us, entries: 840 (840)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (page_referenced_file)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.001ms (+0.002ms): prio_tree_first (vma_prio_tree_next)
00000001 0.004ms (+0.002ms): prio_tree_left (prio_tree_first)
00000001 0.006ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.007ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.007ms (+0.001ms): spin_lock (<00000000>)
00000002 0.009ms (+0.001ms): kmap_atomic (page_referenced_one)
00000003 0.011ms (+0.000ms): page_address (page_referenced_one)
00000003 0.012ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.012ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.012ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.013ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.013ms (+0.003ms): spin_lock (page_referenced_one)
00000002 0.017ms (+0.003ms): spin_lock (<00000000>)
00000002 0.020ms (+0.000ms): kmap_atomic (page_referenced_one)

avc_insert
==========

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 266 us, entries: 80 (80)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: fam/2565, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: __spin_lock_irqsave+0x2b/0xb0
 => ended at:   _spin_unlock_irqrestore+0x32/0x70
=======>
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (avc_has_perm_noaudit)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000001 0.000ms (+0.204ms): avc_insert (avc_has_perm_noaudit)
00000001 0.204ms (+0.000ms): memcpy (avc_has_perm_noaudit)
00000001 0.204ms (+0.001ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
00010001 0.205ms (+0.000ms): do_IRQ (_spin_unlock_irqrestore)
00010001 0.206ms (+0.000ms): do_IRQ (<0000000a>)
00010001 0.206ms (+0.000ms): spin_lock (do_IRQ)
00010002 0.206ms (+0.000ms): spin_lock (<00000000>)
...

schedule
========

Have not talked about schedule in a while - this looks like something
different than before. Appears to be some deep nesting of preempt
disabling activities.

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
-------------------------------------------------------
 latency: 237 us, entries: 426 (426)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: latencytest/5314, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: schedule+0x59/0x5b0
 => ended at:   schedule+0x39d/0x5b0
=======>
00000001 0.000ms (+0.000ms): schedule (ksoftirqd)
00000001 0.000ms (+0.000ms): schedule (ksoftirqd)
00000001 0.000ms (+0.000ms): schedule (ksoftirqd)
00000001 0.000ms (+0.000ms): schedule (ksoftirqd)
00000001 0.000ms (+0.000ms): schedule (ksoftirqd)
00000001 0.000ms (+0.000ms): schedule (ksoftirqd)
00000001 0.000ms (+0.000ms): sched_clock (schedule)
00000001 0.001ms (+0.000ms): schedule (ksoftirqd)
00000001 0.001ms (+0.000ms): schedule (ksoftirqd)
00000001 0.001ms (+0.000ms): schedule (ksoftirqd)
00000001 0.001ms (+0.000ms): spin_lock_irq (schedule)
00000001 0.001ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
00000002 0.002ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000002 0.002ms (+0.000ms): schedule (ksoftirqd)
00000002 0.002ms (+0.000ms): deactivate_task (schedule)
00000002 0.002ms (+0.000ms): dequeue_task (deactivate_task)
00000002 0.002ms (+0.000ms): schedule (ksoftirqd)
00000002 0.002ms (+0.000ms): schedule (ksoftirqd)
00000002 0.003ms (+0.000ms): dependent_sleeper (schedule)
00000002 0.003ms (+0.000ms): schedule (ksoftirqd)
00000002 0.003ms (+0.000ms): schedule (ksoftirqd)
00000002 0.003ms (+0.000ms): schedule (ksoftirqd)
00000002 0.003ms (+0.000ms): schedule (ksoftirqd)
00000002 0.003ms (+0.000ms): dummy_switch_tasks (schedule)
00000002 0.003ms (+0.000ms): schedule (ksoftirqd)
00000002 0.004ms (+0.000ms): schedule (ksoftirqd)
00000002 0.004ms (+0.000ms): schedule (ksoftirqd)
00000002 0.004ms (+0.000ms): schedule (ksoftirqd)
00000002 0.004ms (+0.000ms): schedule (ksoftirqd)
00000002 0.004ms (+0.000ms): sched_info_switch (schedule)
00000002 0.004ms (+0.000ms): sched_info_depart (sched_info_switch)
00000002 0.005ms (+0.000ms): sched_info_arrive (schedule)
00000002 0.005ms (+0.000ms): sched_info_dequeued (sched_info_arrive)
00000002 0.005ms (+0.000ms): schedule (ksoftirqd)
00000002 0.005ms (+0.000ms): context_switch (schedule)
00000002 0.005ms (+0.000ms): dummy_cs_entry (context_switch)
00000002 0.005ms (+0.000ms): context_switch (schedule)
00000002 0.006ms (+0.000ms): dummy_cs_switch_mm (context_switch)
00000002 0.006ms (+0.000ms): context_switch (schedule)
00000002 0.006ms (+0.000ms): dummy_cs_unlikely_if (context_switch)
00000002 0.006ms (+0.000ms): context_switch (schedule)
00000002 0.006ms (+0.000ms): dummy_cs_switch_to (context_switch)
00000002 0.006ms (+0.000ms): context_switch (schedule)
04000002 0.007ms (+0.000ms): __switch_to (context_switch)
04000002 0.007ms (+0.000ms): dummy_cs_exit (context_switch)
04000002 0.007ms (+0.000ms): context_switch (schedule)
04000002 0.007ms (+0.000ms): finish_task_switch (schedule)
04000002 0.008ms (+0.000ms): _spin_unlock_irq (finish_task_switch)
04010002 0.008ms (+0.000ms): do_IRQ (_spin_unlock_irq)
04010002 0.008ms (+0.000ms): do_IRQ (<0000000a>)
04010002 0.008ms (+0.000ms): spin_lock (do_IRQ)
04010003 0.009ms (+0.000ms): spin_lock (<00000000>)
04010003 0.009ms (+0.000ms): mask_and_ack_level_ioapic_irq (do_IRQ)
04010003 0.009ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
04010003 0.009ms (+0.000ms): __spin_lock_irqsave (mask_IO_APIC_irq)
04010004 0.009ms (+0.000ms): __spin_lock_irqsave (<00000000>)
04010004 0.009ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
04010004 0.010ms (+0.020ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
04010004 0.030ms (+0.000ms): _spin_unlock_irqrestore (mask_IO_APIC_irq)
04010003 0.030ms (+0.000ms): redirect_hardirq (do_IRQ)
04010003 0.030ms (+0.000ms): _spin_unlock (do_IRQ)
04010002 0.031ms (+0.000ms): handle_IRQ_event (do_IRQ)
04010002 0.031ms (+0.000ms): usb_hcd_irq (handle_IRQ_event)
04010002 0.031ms (+0.001ms): uhci_irq (usb_hcd_irq)
04010002 0.032ms (+0.000ms): spin_lock (uhci_irq)
04010003 0.032ms (+0.000ms): spin_lock (<00000000>)
04010003 0.032ms (+0.000ms): uhci_get_current_frame_number (uhci_irq)
04010003 0.033ms (+0.000ms): uhci_free_pending_qhs (uhci_irq)
04010003 0.033ms (+0.000ms): uhci_free_pending_tds (uhci_irq)
...
gets even deeper nesting with the first value going up to 04010008
while the system appears to send signals based on mouse input. None
of the steps take very long, but with over 400 steps in the sequence
it shows up in the trace record.

  --Mark

