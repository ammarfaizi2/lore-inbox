Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268719AbUHaPXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268719AbUHaPXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268724AbUHaPXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:23:47 -0400
Received: from lax-gate2.raytheon.com ([199.46.200.231]:14753 "EHLO
	lax-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S268719AbUHaPUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:20:13 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Tue, 31 Aug 2004 10:17:09 -0500
Message-ID: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 08/31/2004 10:19:06 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I will be running some additional tests
>- reducing preempt_max_latency
>- running with sortirq and hardirq_preemption=0
>to see if these uncover any further problems.

Same system / kernel combination as described previously.

With preempt_max_latency=500, I went from a handful of traces to 63 in
a 25 minute test run. Most traces during the last half of the test while
the disk was active (write, copy, read). I will send a copy of the full
traces separately (not to linux-kernel), but here is a summary of the
information gathered. If someone else wants the full traces, please send
an email separately.

Note - I did not repeat the network poll / number of read cycles
problem since we are already working that one.

Cascade
=======
Occurred five times, with latencies of
 latency: 964 us, entries: 285 (285)
 latency: 964 us, entries: 285 (285)
 latency: 1827 us, entries: 454 (454)
 latency: 1111 us, entries: 318 (318)
 latency: 969 us, entries: 279 (279)

Starts / ends at
 => started at: run_timer_softirq+0x12f/0x2a0
 => ended at:   run_timer_softirq+0x10a/0x2a0

For example:
00000001 0.000ms (+0.000ms): run_timer_softirq (___do_softirq)
00000001 0.000ms (+0.000ms): cascade (run_timer_softirq)
00000001 0.005ms (+0.004ms): cascade (run_timer_softirq)
00000001 0.009ms (+0.004ms): cascade (run_timer_softirq)
00000001 0.013ms (+0.004ms): cascade (run_timer_softirq)
00000001 0.018ms (+0.004ms): cascade (run_timer_softirq)
...
00000001 0.891ms (+0.004ms): cascade (run_timer_softirq)
00000001 0.895ms (+0.004ms): cascade (run_timer_softirq)
00000001 0.896ms (+0.000ms): internal_add_timer (cascade)
00010001 0.899ms (+0.003ms): do_IRQ (run_timer_softirq)
00010002 0.899ms (+0.000ms): mask_and_ack_level_ioapic_irq (do_IRQ)
00010002 0.899ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
00010003 0.900ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
00010003 0.900ms (+0.000ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
00010002 0.914ms (+0.013ms): generic_redirect_hardirq (do_IRQ)
...


Long Duration Trace Entries
===========================

Each of these traces had a delay of about 1/2 msec at one step.

#1 - audio driver
 latency: 621 us, entries: 28 (28)
    -----------------
    | task: latencytest/11492, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: snd_ensoniq_playback1_prepare+0x74/0x180
 => ended at:   snd_ensoniq_playback1_prepare+0x11d/0x180
=======>
00000001 0.000ms (+0.000ms): snd_ensoniq_playback1_prepare
(snd_pcm_do_prepare)
00000001 0.014ms (+0.014ms): snd_es1371_dac1_rate
(snd_ensoniq_playback1_prepare)
00000001 0.014ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_dac1_rate)
00000001 0.562ms (+0.548ms): snd_es1371_src_read (snd_es1371_dac1_rate)
00000001 0.562ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_src_read)
00000001 0.578ms (+0.015ms): snd_es1371_wait_src_ready
(snd_es1371_src_read)
00000001 0.585ms (+0.006ms): snd_es1371_src_write (snd_es1371_dac1_rate)
00000001 0.585ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_src_write)
00000001 0.601ms (+0.015ms): snd_es1371_src_write (snd_es1371_dac1_rate)
00000001 0.601ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_src_write)
00000001 0.602ms (+0.001ms): snd_es1371_wait_src_ready
(snd_es1371_dac1_rate)
00000001 0.616ms (+0.013ms): smp_apic_timer_interrupt
(snd_ensoniq_playback1_prepare)

or

 latency: 663 us, entries: 41 (41)
    -----------------
    | task: latencytest/11492, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: snd_ensoniq_playback1_prepare+0x74/0x180
 => ended at:   snd_ensoniq_playback1_prepare+0x11d/0x180
=======>
00000001 0.000ms (+0.000ms): snd_ensoniq_playback1_prepare
(snd_pcm_do_prepare)
00000001 0.004ms (+0.004ms): snd_es1371_dac1_rate
(snd_ensoniq_playback1_prepare)
00000001 0.005ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_dac1_rate)
00000001 0.006ms (+0.001ms): snd_es1371_src_read (snd_es1371_dac1_rate)
00000001 0.006ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_src_read)
00000001 0.019ms (+0.012ms): snd_es1371_wait_src_ready
(snd_es1371_src_read)
00000001 0.607ms (+0.588ms): snd_es1371_src_write (snd_es1371_dac1_rate)
00000001 0.608ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_src_write)
00000001 0.624ms (+0.016ms): snd_es1371_src_write (snd_es1371_dac1_rate)
00000001 0.624ms (+0.000ms): snd_es1371_wait_src_ready
(snd_es1371_src_write)
00000001 0.626ms (+0.001ms): snd_es1371_wait_src_ready
(snd_es1371_dac1_rate)
00000001 0.639ms (+0.013ms): smp_apic_timer_interrupt
(snd_ensoniq_playback1_prepare)

#2 - Scheduler

preemption latency trace v1.0.2
-------------------------------
 latency: 567 us, entries: 48 (48)
    -----------------
    | task: cpu_burn/9444, uid:0 nice:10 policy:0 rt_prio:0
    -----------------
 => started at: schedule+0x51/0x7b0
 => ended at:   schedule+0x35b/0x7b0
=======>
00000001 0.000ms (+0.000ms): schedule (io_schedule)
00000001 0.001ms (+0.001ms): sched_clock (schedule)
00000002 0.001ms (+0.000ms): deactivate_task (schedule)
00000002 0.002ms (+0.000ms): dequeue_task (deactivate_task)
00000002 0.549ms (+0.546ms): __switch_to (schedule)
00000002 0.550ms (+0.001ms): finish_task_switch (schedule)
00000002 0.550ms (+0.000ms): smp_apic_timer_interrupt (finish_task_switch)
00010002 0.551ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010002 0.551ms (+0.000ms): profile_hook (profile_tick)

[I have a LOT more traces where __switch_to has the big time delay]
but also note...

preemption latency trace v1.0.2
-------------------------------
 latency: 591 us, entries: 62 (62)
    -----------------
    | task: fam/4524, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: schedule+0x51/0x7b0
 => ended at:   schedule+0x35b/0x7b0
=======>
00000001 0.000ms (+0.000ms): schedule (io_schedule)
00000001 0.000ms (+0.000ms): sched_clock (schedule)
00000002 0.066ms (+0.066ms): deactivate_task (schedule)
00000002 0.066ms (+0.000ms): dequeue_task (deactivate_task)
00000002 0.475ms (+0.408ms): dequeue_task (schedule)
00000002 0.475ms (+0.000ms): recalc_task_prio (schedule)
00000002 0.475ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 0.475ms (+0.000ms): enqueue_task (schedule)
00000002 0.557ms (+0.081ms): __switch_to (schedule)
00000002 0.558ms (+0.000ms): finish_task_switch (schedule)
00000002 0.558ms (+0.000ms): smp_apic_timer_interrupt (finish_task_switch)
00010002 0.559ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
where dequeue_task can take a while as well or this one

preemption latency trace v1.0.2
-------------------------------
 latency: 591 us, entries: 77 (77)
    -----------------
    | task: ksoftirqd/0/3, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: schedule+0x51/0x7b0
 => ended at:   schedule+0x35b/0x7b0
=======>
00000001 0.000ms (+0.000ms): schedule (io_schedule)
00000001 0.000ms (+0.000ms): sched_clock (schedule)
00000002 0.000ms (+0.000ms): deactivate_task (schedule)
00000002 0.000ms (+0.000ms): dequeue_task (deactivate_task)
00000002 0.480ms (+0.479ms): load_balance_newidle (schedule)
00000002 0.514ms (+0.034ms): find_busiest_group (load_balance_newidle)
00000002 0.554ms (+0.039ms): find_next_bit (find_busiest_group)
00000002 0.555ms (+0.001ms): find_next_bit (find_busiest_group)
00000002 0.555ms (+0.000ms): find_busiest_queue (load_balance_newidle)
00000002 0.556ms (+0.000ms): find_next_bit (find_busiest_queue)
00000002 0.557ms (+0.000ms): double_lock_balance (load_balance_newidle)
00000003 0.557ms (+0.000ms): move_tasks (load_balance_newidle)
00000003 0.559ms (+0.002ms): find_next_bit (move_tasks)
00000003 0.560ms (+0.000ms): find_next_bit (move_tasks)
00000003 0.561ms (+0.000ms): find_next_bit (move_tasks)
04000002 0.563ms (+0.002ms): __switch_to (schedule)
04000002 0.564ms (+0.000ms): finish_task_switch (schedule)

where it appears load balancing takes a long time.

#3 - kmap / kunmap

preemption latency trace v1.0.2
-------------------------------
 latency: 602 us, entries: 53 (53)
    -----------------
    | task: cp/11501, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: kmap_atomic+0x23/0xe0
 => ended at:   kunmap_atomic+0x7b/0xa0
=======>
00000001 0.000ms (+0.000ms): kmap_atomic (file_read_actor)
00000001 0.000ms (+0.000ms): page_address (file_read_actor)
00000001 0.000ms (+0.000ms): __copy_to_user_ll (file_read_actor)
00000001 0.502ms (+0.501ms): smp_apic_timer_interrupt (__copy_to_user_ll)
00010001 0.502ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 0.502ms (+0.000ms): profile_hook (profile_tick)
00010002 0.502ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.570ms (+0.068ms): profile_hit (smp_apic_timer_interrupt)
00010001 0.571ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 0.571ms (+0.000ms): update_one_process (update_process_times)
00010001 0.571ms (+0.000ms): run_local_timers (update_process_times)

or

preemption latency trace v1.0.2
-------------------------------
 latency: 615 us, entries: 75 (75)
    -----------------
    | task: cat/11844, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: kmap_atomic+0x23/0xe0
 => ended at:   kunmap_atomic+0x7b/0xa0
=======>
00000001 0.000ms (+0.000ms): kmap_atomic (file_read_actor)
00000001 0.000ms (+0.000ms): page_address (file_read_actor)
00000001 0.000ms (+0.000ms): __copy_to_user_ll (file_read_actor)
00000001 0.563ms (+0.562ms): smp_apic_timer_interrupt (__copy_to_user_ll)
00010001 0.563ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 0.563ms (+0.000ms): profile_hook (profile_tick)
00010002 0.564ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.564ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 0.564ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 0.564ms (+0.000ms): update_one_process (update_process_times)

#4 - mmap

preemption latency trace v1.0.2
-------------------------------
 latency: 660 us, entries: 48 (48)
    -----------------
    | task: get_ltrace.sh/12120, uid:0 nice:-20 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched_lock+0x7b/0x140
 => ended at:   exit_mmap+0x168/0x210
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched_lock)
00000001 0.000ms (+0.000ms): __bitmap_weight (unmap_vmas)
00000001 0.000ms (+0.000ms): vm_acct_memory (exit_mmap)
00000001 0.001ms (+0.000ms): clear_page_tables (exit_mmap)
00010001 0.520ms (+0.518ms): do_IRQ (clear_page_tables)
00010002 0.564ms (+0.044ms): ack_edge_ioapic_irq (do_IRQ)
00010002 0.564ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 0.564ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 0.564ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010002 0.565ms (+0.001ms): mark_offset_tsc (timer_interrupt)
00010002 0.618ms (+0.052ms): do_timer (timer_interrupt)
00010002 0.618ms (+0.000ms): update_wall_time (do_timer)
00010002 0.618ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 0.619ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 0.619ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00000002 0.619ms (+0.000ms): do_softirq (do_IRQ)

#5 - network poll

preemption latency trace v1.0.2
-------------------------------
 latency: 753 us, entries: 371 (371)
    -----------------
    | task: ksoftirqd/1/5, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: rtl8139_poll+0x3c/0x160
 => ended at:   rtl8139_poll+0x100/0x160
=======>
00000001 0.000ms (+0.000ms): rtl8139_poll (net_rx_action)
00000001 0.000ms (+0.000ms): rtl8139_rx (rtl8139_poll)
00000001 0.002ms (+0.001ms): alloc_skb (rtl8139_rx)
00000001 0.002ms (+0.000ms): kmem_cache_alloc (alloc_skb)
00000001 0.002ms (+0.000ms): __kmalloc (alloc_skb)
00000001 0.004ms (+0.002ms): eth_type_trans (rtl8139_rx)
00000001 0.005ms (+0.000ms): netif_receive_skb (rtl8139_rx)
00000002 0.008ms (+0.002ms): packet_rcv_spkt (netif_receive_skb)
00000002 0.008ms (+0.000ms): skb_clone (packet_rcv_spkt)
00000002 0.009ms (+0.000ms): kmem_cache_alloc (skb_clone)
00000002 0.078ms (+0.069ms): memcpy (skb_clone)
00010002 0.498ms (+0.419ms): do_IRQ (skb_clone)
00010003 0.498ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010003 0.498ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010002 0.499ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010002 0.499ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010003 0.568ms (+0.068ms): mark_offset_tsc (timer_interrupt)
00010003 0.582ms (+0.014ms): do_timer (timer_interrupt)
00010003 0.582ms (+0.000ms): update_wall_time (do_timer)

or

preemption latency trace v1.0.2
-------------------------------
 latency: 752 us, entries: 395 (395)
    -----------------
    | task: ksoftirqd/1/5, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: rtl8139_poll+0x3c/0x160
 => ended at:   rtl8139_poll+0x100/0x160
=======>
00000001 0.000ms (+0.000ms): rtl8139_poll (net_rx_action)
00000001 0.000ms (+0.000ms): rtl8139_rx (rtl8139_poll)
00000001 0.002ms (+0.001ms): alloc_skb (rtl8139_rx)
00000001 0.002ms (+0.000ms): kmem_cache_alloc (alloc_skb)
00000001 0.002ms (+0.000ms): __kmalloc (alloc_skb)
00000001 0.005ms (+0.002ms): eth_type_trans (rtl8139_rx)
00000001 0.146ms (+0.140ms): netif_receive_skb (rtl8139_rx)
00000002 0.566ms (+0.420ms): packet_rcv_spkt (netif_receive_skb)
00000002 0.567ms (+0.000ms): skb_clone (packet_rcv_spkt)
00000002 0.567ms (+0.000ms): kmem_cache_alloc (skb_clone)
00000002 0.568ms (+0.000ms): memcpy (skb_clone)
00000002 0.570ms (+0.001ms): strlcpy (packet_rcv_spkt)

Separately I ran a series of tests with:
  preempt_max_latency=500
  hardirq_preemption=0
  softirq_preemption=0
which should be similar to the configuration I used in 2.4 kernels.
There were > 100 latency traces (my script stops at 100) in the same
25 minute test. In addition to the traces listed above, I had the
following problems.

RT Run Flush
============

preemption latency trace v1.0.2
-------------------------------
 latency: 1592 us, entries: 4000 (6306)
    -----------------
    | task: latencytest/6440, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: smp_apic_timer_interrupt+0x43/0x130
 => ended at:   smp_apic_timer_interrupt+0xaa/0x130

...
00000101 0.041ms (+0.001ms): add_entropy_words (extract_entropy)
00000101 0.042ms (+0.000ms): SHATransform (extract_entropy)
00000101 0.042ms (+0.000ms): memcpy (SHATransform)
00000101 0.044ms (+0.001ms): add_entropy_words (extract_entropy)
00000101 0.045ms (+0.000ms): add_entropy_words (extract_entropy)
00000101 0.046ms (+0.001ms): credit_entropy_store (extract_entropy)
00000102 0.047ms (+0.001ms): __wake_up (extract_entropy)
00000103 0.047ms (+0.000ms): __wake_up_common (__wake_up)
00000101 0.048ms (+0.000ms): SHATransform (extract_entropy)
00000101 0.048ms (+0.000ms): memcpy (SHATransform)
00000101 0.050ms (+0.001ms): add_entropy_words (extract_entropy)
00000101 0.050ms (+0.000ms): SHATransform (extract_entropy)
00000101 0.050ms (+0.000ms): memcpy (SHATransform)
00000101 0.052ms (+0.001ms): add_entropy_words (extract_entropy)
00000201 0.053ms (+0.001ms): local_bh_enable (rt_run_flush)
00000101 0.053ms (+0.000ms): cond_resched_all (rt_run_flush)
00000101 0.053ms (+0.000ms): cond_resched_softirq (rt_run_flush)
00000201 0.054ms (+0.000ms): local_bh_enable (rt_run_flush)
00000101 0.054ms (+0.000ms): cond_resched_all (rt_run_flush)
00000101 0.054ms (+0.000ms): cond_resched_softirq (rt_run_flush)
... the last 3 lines repeat over 1000 times and fill
the trace buffer completely ...

The above sequence occurred twice during testing.

Short But Long
==============

preemption latency trace v1.0.2
-------------------------------
 latency: 549 us, entries: 4 (4)
    -----------------
    | task: kblockd/1/11, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: worker_thread+0x22d/0x3a0
 => ended at:   worker_thread+0x2a2/0x3a0
=======>
00000001 0.000ms (+0.000ms): worker_thread (kthread)
00000001 0.000ms (+0.000ms): __wake_up (worker_thread)
00000002 0.549ms (+0.549ms): __wake_up_common (__wake_up)
00000001 0.550ms (+0.000ms): sub_preempt_count (worker_thread)

or

preemption latency trace v1.0.2
-------------------------------
 latency: 551 us, entries: 4 (4)
    -----------------
    | task: kblockd/1/11, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: worker_thread+0x22d/0x3a0
 => ended at:   worker_thread+0x2a2/0x3a0
=======>
00000001 0.000ms (+0.000ms): worker_thread (kthread)
00000001 0.000ms (+0.000ms): __wake_up (worker_thread)
00000002 0.000ms (+0.000ms): __wake_up_common (__wake_up)
00000001 0.552ms (+0.551ms): sub_preempt_count (worker_thread)

or this one apparently preempting the real time task [why??]
Now that I look, the first set of tests preempted the max priority
real time application six (6) times and the second set of tests
preempted the RT application thirty (30) times.

preemption latency trace v1.0.2
-------------------------------
 latency: 566 us, entries: 13 (13)
    -----------------
    | task: latencytest/7959, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: do_IRQ+0x19/0x290
 => ended at:   do_IRQ+0x1cf/0x290
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (<08049b20>)
00010001 0.000ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010001 0.000ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010000 0.000ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 0.001ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 0.549ms (+0.548ms): mark_offset_tsc (timer_interrupt)
00010001 0.564ms (+0.014ms): do_timer (timer_interrupt)
00010001 0.564ms (+0.000ms): update_wall_time (do_timer)
00010001 0.564ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010001 0.565ms (+0.001ms): generic_note_interrupt (do_IRQ)
00010001 0.566ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00000001 0.566ms (+0.000ms): sub_preempt_count (do_IRQ)

Another Long Time
=================

#1 - kmap / kunmap

Similar stop / end locations to above, but a different cause.

preemption latency trace v1.0.2
-------------------------------
 latency: 696 us, entries: 131 (131)
    -----------------
    | task: sleep/8854, uid:0 nice:-20 policy:0 rt_prio:0
    -----------------
 => started at: kmap_atomic+0x23/0xe0
 => ended at:   kunmap_atomic+0x7b/0xa0
=======>
00000001 0.000ms (+0.000ms): kmap_atomic (do_anonymous_page)
00000001 0.000ms (+0.000ms): page_address (do_anonymous_page)
00010001 0.413ms (+0.413ms): do_IRQ (do_anonymous_page)
00010002 0.452ms (+0.038ms): ack_edge_ioapic_irq (do_IRQ)
00010002 0.452ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 0.454ms (+0.001ms): generic_handle_IRQ_event (do_IRQ)
00010001 0.488ms (+0.034ms): timer_interrupt (generic_handle_IRQ_event)
00010002 0.557ms (+0.069ms): mark_offset_tsc (timer_interrupt)
00010002 0.573ms (+0.015ms): do_timer (timer_interrupt)
00010002 0.574ms (+0.000ms): update_wall_time (do_timer)
00010002 0.574ms (+0.000ms): update_wall_time_one_tick (update_wall_time)

Perhaps the most disturbing finding tat the max priority RT application
can get preempted for a long time, even though there is:
 - only one real time task
 - two CPU's to do work

  --Mark

