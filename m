Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267429AbUIJO64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267429AbUIJO64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUIJO6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:58:55 -0400
Received: from lax-gate1.raytheon.com ([199.46.200.230]:51564 "EHLO
	lax-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S267429AbUIJO5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:57:30 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, Free Ekanayaka <free@agnula.org>,
       free78@tin.it, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>, luke@audioslack.com,
       nando@ccrma.stanford.edu,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
From: Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Fri, 10 Sep 2004 09:28:23 -0500
Message-ID: <OF9E4403BE.E78B47A0-ON86256F0B.004F80E5-86256F0B.004F80F7@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/10/2004 09:28:31 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>does 'hdparm -X udma2 /dev/hda' work?

Yes it does and quite well actually. For comparison
  -R1 on September 7 - over 100 traces > 500 usec
  -R8 on September 10 - 38 traces > 200 usec, only 3 > 500 usec

This was with the full test suite (latencytest active, all different
types of operations).

In addition to what I already reported today, there were a few additional
types of traces:

network poll - Traces 00 01 02 03 04 06 07 08 16 17 29 32
twkill_work  - Trace  05
VL kswapd0   - Trace  12
spin lock/nmi- Trace  15
do_IRQ       - Trace  25 26 27
the previously reported symptoms...
exit mmap    - Traces 09 18 19 20 21 22 23 24 28 30 31 33 34 35 36 37
kswapd0      - Traces 10 11 13 14

Network Poll
============
preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 332 us, entries: 198 (198)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: ksoftirqd/1/5, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   rtl8139_rx+0x219/0x340
=======>
00000001 0.000ms (+0.000ms): spin_lock (rtl8139_poll)
00000001 0.000ms (+0.001ms): spin_lock (<00000000>)
00000001 0.001ms (+0.003ms): rtl8139_rx (rtl8139_poll)
... we've been down this path before ...
No individual traces > 10 usec; just the number of traces involved.

twkill_work
===========

I have not seen this one before....

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 499 us, entries: 1858 (1858)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: events/0/6, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: twkill_work+0xb5/0xe0
 => ended at:   twkill_work+0xb5/0xe0
=======>
00000101 0.000ms (+0.000ms): touch_preempt_timing (twkill_work)
00000101 0.000ms (+0.000ms): smp_apic_timer_interrupt
(touch_preempt_timing)
00010101 0.000ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010101 0.000ms (+0.000ms): profile_hook (profile_tick)
00010101 0.000ms (+0.000ms): read_lock (profile_hook)
00010102 0.001ms (+0.000ms): read_lock (<00000000>)
00010102 0.001ms (+0.000ms): notifier_call_chain (profile_hook)
00010102 0.001ms (+0.000ms): _read_unlock (profile_tick)
00010101 0.002ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010101 0.002ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010101 0.002ms (+0.000ms): update_one_process (update_process_times)
00010101 0.003ms (+0.000ms): run_local_timers (update_process_times)
00010101 0.003ms (+0.000ms): raise_softirq (update_process_times)
00010101 0.003ms (+0.000ms): scheduler_tick (update_process_times)
00010101 0.004ms (+0.000ms): sched_clock (scheduler_tick)
00010101 0.005ms (+0.000ms): rcu_check_callbacks (scheduler_tick)
00010101 0.005ms (+0.001ms): idle_cpu (rcu_check_callbacks)
00010101 0.006ms (+0.000ms): spin_lock (scheduler_tick)
00010102 0.006ms (+0.000ms): spin_lock (<00000000>)
00010102 0.007ms (+0.000ms): task_timeslice (scheduler_tick)
00010102 0.007ms (+0.001ms): __bitmap_weight (scheduler_tick)
00010102 0.009ms (+0.000ms): _spin_unlock (scheduler_tick)
00010101 0.010ms (+0.001ms): rebalance_tick (scheduler_tick)
00010101 0.011ms (+0.000ms): do_IRQ (touch_preempt_timing)
00010101 0.011ms (+0.000ms): do_IRQ (<00000000>)
00010101 0.012ms (+0.000ms): spin_lock (do_IRQ)
00010102 0.012ms (+0.000ms): spin_lock (<00000000>)
00010102 0.012ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010102 0.013ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010102 0.013ms (+0.000ms): _spin_unlock (do_IRQ)
... Look at this next sequence ...
00010102 0.033ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010102 0.033ms (+0.000ms): _spin_unlock (do_IRQ)
00000101 0.034ms (+0.000ms): tcp_do_twkill_work (twkill_work)
00000101 0.035ms (+0.000ms): _spin_unlock (tcp_do_twkill_work)
00000100 0.035ms (+0.000ms): tcp_timewait_kill (tcp_do_twkill_work)
00000100 0.035ms (+0.000ms): write_lock (tcp_timewait_kill)
00000101 0.036ms (+0.000ms): write_lock (<00000000>)
00000101 0.037ms (+0.000ms): _write_unlock (tcp_timewait_kill)
00000100 0.037ms (+0.000ms): spin_lock (tcp_timewait_kill)
00000101 0.037ms (+0.000ms): spin_lock (<00000000>)
00000101 0.038ms (+0.000ms): tcp_bucket_destroy (tcp_timewait_kill)
00000101 0.038ms (+0.000ms): kmem_cache_free (tcp_bucket_destroy)
00000101 0.038ms (+0.000ms): cache_flusharray (kmem_cache_free)
... or this one ...
00000100 0.050ms (+0.000ms): spin_lock (tcp_do_twkill_work)
00000101 0.051ms (+0.000ms): spin_lock (<00000000>)
00000101 0.051ms (+0.000ms): _spin_unlock (tcp_do_twkill_work)
00000100 0.051ms (+0.000ms): tcp_timewait_kill (tcp_do_twkill_work)
00000100 0.051ms (+0.000ms): write_lock (tcp_timewait_kill)
00000101 0.052ms (+0.000ms): write_lock (<00000000>)
00000101 0.052ms (+0.000ms): _write_unlock (tcp_timewait_kill)
00000100 0.053ms (+0.000ms): spin_lock (tcp_timewait_kill)
00000101 0.053ms (+0.000ms): spin_lock (<00000000>)
00000101 0.053ms (+0.000ms): tcp_bucket_destroy (tcp_timewait_kill)
00000101 0.053ms (+0.000ms): kmem_cache_free (tcp_bucket_destroy)
00000101 0.054ms (+0.000ms): _spin_unlock (tcp_timewait_kill)
00000100 0.054ms (+0.000ms): kmem_cache_free (tcp_do_twkill_work)
00000100 0.054ms (+0.000ms): spin_lock (tcp_do_twkill_work)
00000101 0.054ms (+0.000ms): spin_lock (<00000000>)
00000101 0.054ms (+0.000ms): _spin_unlock (tcp_do_twkill_work)
00000100 0.055ms (+0.000ms): tcp_timewait_kill (tcp_do_twkill_work)
... and ends like this ...
00000101 0.496ms (+0.000ms): _write_unlock (tcp_timewait_kill)
00000100 0.496ms (+0.000ms): preempt_schedule (tcp_timewait_kill)
00000100 0.496ms (+0.000ms): spin_lock (tcp_timewait_kill)
00000101 0.496ms (+0.000ms): spin_lock (<00000000>)
00000101 0.497ms (+0.000ms): tcp_bucket_destroy (tcp_timewait_kill)
00000101 0.497ms (+0.000ms): kmem_cache_free (tcp_bucket_destroy)
00000101 0.497ms (+0.000ms): _spin_unlock (tcp_timewait_kill)
00000100 0.497ms (+0.000ms): preempt_schedule (tcp_timewait_kill)
00000100 0.498ms (+0.000ms): kmem_cache_free (tcp_do_twkill_work)
00000100 0.498ms (+0.000ms): spin_lock (tcp_do_twkill_work)
00000101 0.498ms (+0.000ms): spin_lock (<00000000>)
00000101 0.499ms (+0.000ms): touch_preempt_timing (twkill_work)
00000101 0.499ms (+0.000ms): update_max_trace (check_preempt_timing)

I looked briefly at the -R8 patch and see the change in condition for
breaking the lock, but from this trace, it may not be enough.

VL kswapd0
==========

An extremely long latency (> 6 msec) appears to be a combination of
effects, perhaps tracing related. It starts like this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 6776 us, entries: 548 (548)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (page_referenced_file)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.001ms (+0.001ms): prio_tree_first (vma_prio_tree_next)
00000001 0.002ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.002ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.003ms (+0.001ms): spin_lock (<00000000>)
00000002 0.004ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.004ms (+0.000ms): page_address (page_referenced_one)
00000003 0.005ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.005ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.005ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.006ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.006ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.007ms (+0.000ms): spin_lock (<00000000>)
... looks like the typical kswapd0 cycle until this point ...
00000001 0.126ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.127ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.127ms (+0.000ms): spin_lock (<00000000>)
00000002 0.128ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.128ms (+0.000ms): page_address (page_referenced_one)
00000003 0.129ms (+0.000ms): flush_tlb_page (page_referenced_one)
00000004 0.129ms (+0.000ms): flush_tlb_others (flush_tlb_page)
00000004 0.130ms (+0.000ms): spin_lock (flush_tlb_others)
00000005 0.130ms (+0.000ms): spin_lock (<00000000>)
00000005 0.131ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000005 0.132ms (+0.790ms): send_IPI_mask_bitmask (flush_tlb_others)
00010005 0.922ms (+0.000ms): do_nmi (flush_tlb_others)
00010005 0.923ms (+0.003ms): do_nmi (touch_preempt_timing)
00010005 0.926ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010005 0.926ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010005 0.926ms (+0.000ms): profile_hook (profile_tick)
00010005 0.927ms (+0.000ms): read_lock (profile_hook)
00010006 0.927ms (+0.000ms): read_lock (<00000000>)
00010006 0.927ms (+0.000ms): notifier_call_chain (profile_hook)
00010006 0.928ms (+0.000ms): _read_unlock (profile_tick)
00010005 0.928ms (+0.027ms): profile_hit (nmi_watchdog_tick)
00000005 0.955ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
00010005 0.955ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010005 0.956ms (+0.000ms): profile_hook (profile_tick)
00010005 0.956ms (+0.000ms): read_lock (profile_hook)
00010006 0.956ms (+0.000ms): read_lock (<00000000>)
00010006 0.956ms (+0.000ms): notifier_call_chain (profile_hook)
00010006 0.956ms (+0.000ms): _read_unlock (profile_tick)
00010005 0.956ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010005 0.957ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010005 0.957ms (+0.000ms): update_one_process (update_process_times)
00010005 0.957ms (+0.000ms): run_local_timers (update_process_times)
00010005 0.957ms (+0.000ms): raise_softirq (update_process_times)
00010005 0.958ms (+0.000ms): scheduler_tick (update_process_times)
00010005 0.958ms (+0.000ms): sched_clock (scheduler_tick)
00010005 0.958ms (+0.000ms): spin_lock (scheduler_tick)
00010006 0.958ms (+0.000ms): spin_lock (<00000000>)
00010006 0.959ms (+0.000ms): task_timeslice (scheduler_tick)
00010006 0.959ms (+0.000ms): __bitmap_weight (scheduler_tick)
00010006 0.959ms (+0.000ms): _spin_unlock (scheduler_tick)
00010005 0.959ms (+0.000ms): rebalance_tick (scheduler_tick)
00000006 0.960ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000006 0.960ms (+0.000ms): __do_softirq (do_softirq)
00000006 0.960ms (+0.000ms): wake_up_process (do_softirq)
00000006 0.960ms (+0.000ms): try_to_wake_up (wake_up_process)
00000006 0.960ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000006 0.961ms (+0.000ms): spin_lock (task_rq_lock)
00000007 0.961ms (+0.000ms): spin_lock (<00000000>)
00000007 0.961ms (+0.000ms): wake_idle (try_to_wake_up)
00000007 0.961ms (+0.000ms): activate_task (try_to_wake_up)
00000007 0.961ms (+0.000ms): sched_clock (activate_task)
00000007 0.962ms (+0.000ms): recalc_task_prio (activate_task)
00000007 0.962ms (+0.000ms): effective_prio (recalc_task_prio)
00000007 0.962ms (+0.000ms): __activate_task (try_to_wake_up)
00000007 0.962ms (+0.000ms): enqueue_task (__activate_task)
00000007 0.962ms (+0.000ms): sched_info_queued (enqueue_task)
00000007 0.963ms (+0.000ms): resched_task (try_to_wake_up)
00000007 0.963ms (+0.000ms): task_rq_unlock (try_to_wake_up)
00000007 0.963ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
00000006 0.964ms (+0.958ms): preempt_schedule (try_to_wake_up)
00010005 1.922ms (+0.000ms): do_nmi (flush_tlb_others)
00010005 1.922ms (+0.003ms): do_nmi (check_preempt_timing)
00010005 1.926ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010005 1.926ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010005 1.926ms (+0.000ms): profile_hook (profile_tick)
00010005 1.926ms (+0.000ms): read_lock (profile_hook)
00010006 1.927ms (+0.000ms): read_lock (<00000000>)
00010006 1.927ms (+0.000ms): notifier_call_chain (profile_hook)
00010006 1.927ms (+0.000ms): _read_unlock (profile_tick)
00010005 1.927ms (+0.000ms): preempt_schedule (profile_tick)
00010005 1.928ms (+0.027ms): profile_hit (nmi_watchdog_tick)
00000005 1.955ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
00010005 1.955ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010005 1.955ms (+0.000ms): profile_hook (profile_tick)
00010005 1.955ms (+0.000ms): read_lock (profile_hook)
00010006 1.955ms (+0.000ms): read_lock (<00000000>)
00010006 1.956ms (+0.000ms): notifier_call_chain (profile_hook)
00010006 1.956ms (+0.000ms): _read_unlock (profile_tick)
00010005 1.956ms (+0.000ms): preempt_schedule (profile_tick)
00010005 1.956ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010005 1.956ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010005 1.956ms (+0.000ms): update_one_process (update_process_times)
00010005 1.957ms (+0.000ms): run_local_timers (update_process_times)
00010005 1.957ms (+0.000ms): raise_softirq (update_process_times)
00010005 1.957ms (+0.000ms): scheduler_tick (update_process_times)
00010005 1.957ms (+0.000ms): sched_clock (scheduler_tick)
00010005 1.958ms (+0.000ms): spin_lock (scheduler_tick)
00010006 1.958ms (+0.000ms): spin_lock (<00000000>)
00010006 1.958ms (+0.000ms): task_timeslice (scheduler_tick)
00010006 1.958ms (+0.000ms): __bitmap_weight (scheduler_tick)
00010006 1.958ms (+0.000ms): _spin_unlock (scheduler_tick)
00010005 1.959ms (+0.000ms): preempt_schedule (scheduler_tick)
00010005 1.959ms (+0.000ms): rebalance_tick (scheduler_tick)
00000006 1.959ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000006 1.959ms (+0.961ms): __do_softirq (do_softirq)
00010005 2.921ms (+0.000ms): do_nmi (flush_tlb_others)
00010005 2.922ms (+0.001ms): do_nmi (check_preempt_timing)
... looks like we got stuck for milliseconds but finally finished ...
00000006 4.959ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000006 4.959ms (+0.960ms): __do_softirq (do_softirq)
00010005 5.919ms (+0.000ms): do_nmi (flush_tlb_others)
00010005 5.920ms (+0.003ms): do_nmi (__trace)
00010005 5.924ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010005 5.924ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010005 5.924ms (+0.000ms): profile_hook (profile_tick)
00010005 5.924ms (+0.000ms): read_lock (profile_hook)
00010006 5.924ms (+0.000ms): read_lock (<00000000>)
00010006 5.925ms (+0.000ms): notifier_call_chain (profile_hook)
00010006 5.925ms (+0.000ms): _read_unlock (profile_tick)
00010005 5.925ms (+0.000ms): preempt_schedule (profile_tick)
00010005 5.925ms (+0.027ms): profile_hit (nmi_watchdog_tick)
00000005 5.952ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
00010005 5.953ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010005 5.953ms (+0.000ms): profile_hook (profile_tick)
00010005 5.953ms (+0.000ms): read_lock (profile_hook)
00010006 5.953ms (+0.000ms): read_lock (<00000000>)
00010006 5.953ms (+0.000ms): notifier_call_chain (profile_hook)
00010006 5.953ms (+0.000ms): _read_unlock (profile_tick)
00010005 5.954ms (+0.000ms): preempt_schedule (profile_tick)
00010005 5.954ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010005 5.954ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010005 5.954ms (+0.000ms): update_one_process (update_process_times)
00010005 5.954ms (+0.000ms): run_local_timers (update_process_times)
00010005 5.955ms (+0.000ms): raise_softirq (update_process_times)
00010005 5.955ms (+0.000ms): scheduler_tick (update_process_times)
00010005 5.955ms (+0.000ms): sched_clock (scheduler_tick)
00010005 5.955ms (+0.000ms): spin_lock (scheduler_tick)
00010006 5.956ms (+0.000ms): spin_lock (<00000000>)
00010006 5.956ms (+0.000ms): task_timeslice (scheduler_tick)
00010006 5.956ms (+0.000ms): __bitmap_weight (scheduler_tick)
00010006 5.956ms (+0.000ms): _spin_unlock (scheduler_tick)
00010005 5.956ms (+0.000ms): preempt_schedule (scheduler_tick)
00010005 5.957ms (+0.000ms): rebalance_tick (scheduler_tick)
00000006 5.957ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000006 5.957ms (+0.817ms): __do_softirq (do_softirq)
00000005 6.774ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000004 6.775ms (+0.000ms): preempt_schedule (flush_tlb_others)
00000003 6.775ms (+0.000ms): preempt_schedule (flush_tlb_page)
00000003 6.775ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 6.775ms (+0.000ms): preempt_schedule (page_referenced_one)
00000002 6.776ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 6.776ms (+0.000ms): preempt_schedule (page_referenced_one)
00000001 6.776ms (+0.000ms): _spin_unlock (page_referenced_file)
00000001 6.777ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 6.777ms (+0.000ms): update_max_trace (check_preempt_timing)

Spin Lock/nmi
=============

May be an artifact of the test configuration

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 244 us, entries: 17 (17)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: fam/3212, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: __spin_lock_irqsave+0x2b/0xb0
 => ended at:   _spin_unlock_irqrestore+0x32/0x70
=======>
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (avc_has_perm_noaudit)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000001 0.000ms (+0.069ms): avc_insert (avc_has_perm_noaudit)
00010001 0.069ms (+0.000ms): do_nmi (avc_insert)
00010001 0.070ms (+0.002ms): do_nmi (__mcount)
00010001 0.072ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010001 0.073ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.073ms (+0.000ms): profile_hook (profile_tick)
00010001 0.073ms (+0.000ms): read_lock (profile_hook)
00010002 0.073ms (+0.000ms): read_lock (<00000000>)
00010002 0.073ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.074ms (+0.000ms): _read_unlock (profile_tick)
00010001 0.074ms (+0.168ms): profile_hit (nmi_watchdog_tick)
00000001 0.242ms (+0.000ms): memcpy (avc_has_perm_noaudit)
00000001 0.243ms (+0.002ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
00000001 0.245ms (+0.000ms): sub_preempt_count (_spin_unlock_irqrestore)
00000001 0.245ms (+0.000ms): update_max_trace (check_preempt_timing)

Do_IRQ
======

Perhaps an unfortunate series of nested IRQ's?
Starts like this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 240 us, entries: 380 (380)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: cpu_burn/14061, uid:0 nice:10 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x1a0
 => ended at:   do_IRQ+0x14a/0x1a0
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (<08048340>)
00010000 0.000ms (+0.000ms): do_IRQ (<0000000a>)
00010000 0.000ms (+0.000ms): spin_lock (do_IRQ)
00010001 0.000ms (+0.000ms): spin_lock (<00000000>)
00010001 0.001ms (+0.000ms): mask_and_ack_level_ioapic_irq (do_IRQ)
00010001 0.001ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
00010001 0.001ms (+0.000ms): __spin_lock_irqsave (mask_IO_APIC_irq)
00010002 0.002ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00010002 0.002ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
00010002 0.002ms (+0.013ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
00010002 0.016ms (+0.000ms): _spin_unlock_irqrestore (mask_IO_APIC_irq)
00010001 0.016ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 0.016ms (+0.000ms): _spin_unlock (do_IRQ)
00010000 0.017ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 0.017ms (+0.001ms): usb_hcd_irq (generic_handle_IRQ_event)
00010000 0.019ms (+0.001ms): uhci_irq (usb_hcd_irq)
00010000 0.021ms (+0.000ms): spin_lock (uhci_irq)
00010001 0.021ms (+0.000ms): spin_lock (<00000000>)
00010001 0.021ms (+0.001ms): uhci_get_current_frame_number (uhci_irq)
00010001 0.023ms (+0.000ms): uhci_free_pending_qhs (uhci_irq)
00010001 0.023ms (+0.001ms): uhci_free_pending_tds (uhci_irq)
00010001 0.024ms (+0.001ms): uhci_remove_pending_urbps (uhci_irq)
00010001 0.025ms (+0.000ms): uhci_transfer_result (uhci_irq)
00010001 0.026ms (+0.000ms): spin_lock (uhci_transfer_result)
...
00020005 0.134ms (+0.000ms): do_IRQ (_spin_unlock_irqrestore)
00020005 0.134ms (+0.000ms): do_IRQ (<00000000>)
00020005 0.134ms (+0.000ms): spin_lock (do_IRQ)
00020006 0.134ms (+0.000ms): spin_lock (<00000000>)
00020006 0.134ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00020006 0.135ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00020006 0.135ms (+0.000ms): _spin_unlock (do_IRQ)
00020005 0.135ms (+0.000ms): preempt_schedule (do_IRQ)
00020005 0.135ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00020005 0.136ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
... exits like this ...
00010001 0.220ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010001 0.220ms (+0.000ms): end_level_ioapic_irq (do_IRQ)
00010001 0.220ms (+0.000ms): unmask_IO_APIC_irq (do_IRQ)
00010001 0.221ms (+0.000ms): __spin_lock_irqsave (unmask_IO_APIC_irq)
00010002 0.221ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00010002 0.221ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00010002 0.221ms (+0.013ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00010002 0.235ms (+0.000ms): _spin_unlock_irqrestore (unmask_IO_APIC_irq)
00010001 0.235ms (+0.000ms): preempt_schedule (unmask_IO_APIC_irq)
00010001 0.235ms (+0.000ms): _spin_unlock (do_IRQ)
00010000 0.236ms (+0.000ms): preempt_schedule (do_IRQ)
00000001 0.236ms (+0.000ms): do_softirq (do_IRQ)
00000001 0.236ms (+0.000ms): __do_softirq (do_softirq)
00000001 0.236ms (+0.000ms): wake_up_process (do_softirq)
00000001 0.237ms (+0.000ms): try_to_wake_up (wake_up_process)
00000001 0.237ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000001 0.237ms (+0.000ms): spin_lock (task_rq_lock)
00000002 0.237ms (+0.000ms): spin_lock (<00000000>)
00000002 0.237ms (+0.000ms): wake_idle (try_to_wake_up)
00000002 0.238ms (+0.000ms): activate_task (try_to_wake_up)
00000002 0.238ms (+0.000ms): sched_clock (activate_task)
00000002 0.238ms (+0.000ms): recalc_task_prio (activate_task)
00000002 0.238ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 0.239ms (+0.000ms): __activate_task (try_to_wake_up)
00000002 0.239ms (+0.000ms): enqueue_task (__activate_task)
00000002 0.239ms (+0.000ms): sched_info_queued (enqueue_task)
00000002 0.239ms (+0.000ms): resched_task (try_to_wake_up)
00000002 0.240ms (+0.000ms): task_rq_unlock (try_to_wake_up)
00000002 0.240ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
00000001 0.240ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.241ms (+0.000ms): sub_preempt_count (do_IRQ)
00000001 0.242ms (+0.000ms): update_max_trace (check_preempt_timing)

I will send the full traces separately (off list).

  --Mark

