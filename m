Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268985AbUIBU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268985AbUIBU25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269022AbUIBU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:27:09 -0400
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:51790 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S268985AbUIBUWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:22:44 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Date: Thu, 2 Sep 2004 15:21:31 -0500
Message-ID: <OF77CAEAC1.5B07194A-ON86256F03.006FD5A2-86256F03.006FD5AB@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/02/2004 03:21:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've released the -Q9 patch:
>...

Built a kernel with -Q9 plus the following additional patches:
... email saved into mark-offset-tsc-mcount.patch ...
... email saved into ens001.patch ...
... own patch to add mcount() calls to sched.c ...

Ran my 25 minute test and collected 71 traces > 500 usec. The following
has a summary of the results.

[1] No cascade traces - several runs with this result - we should be OK
here.

[2] rtl8139 still showing some traces due to my use of
netdev_backlog_granularity = 8. Had severe problems when it is 1.

[3] I read what you said about hardware overhead, but the data seems
to show latencies getting to "__switch_to" may be buried in some
inline functions. A typical trace looks something like this...

00000002 0.003ms (+0.000ms): dummy_switch_tasks (schedule)
00000002 0.003ms (+0.000ms): schedule (worker_thread)
00000002 0.003ms (+0.000ms): schedule (worker_thread)
00000002 0.004ms (+0.000ms): schedule (worker_thread)
00000002 0.004ms (+0.000ms): schedule (worker_thread)
00000002 0.004ms (+0.000ms): schedule (worker_thread)
00000002 0.004ms (+0.274ms): schedule (worker_thread)
04000002 0.279ms (+0.000ms): __switch_to (schedule)

dummy_switch_tasks refers to a function I added / called right after
the label switch_tasks (in sched.c). The mcount() traces that follow
are basically at each step leading up to the call to context_switch.
Since context_switch is static inline, I assume it is not traced -
please confirm. I am considering adding mcount() calls inside
context_switch to see if there is a step that has some long
duration.

[4] The go_idle path is also one that appears to have some long
latencies. The following is an example - the trace of dummy_go_idle
refers to the label named go_idle.

00000002 0.002ms (+0.000ms): dummy_go_idle (schedule)
00000002 0.002ms (+0.060ms): schedule (io_schedule)
00000002 0.063ms (+0.069ms): load_balance_newidle (schedule)
00000002 0.133ms (+0.074ms): find_busiest_group (load_balance_newidle)
00000002 0.207ms (+0.034ms): find_next_bit (find_busiest_group)
00000002 0.242ms (+0.039ms): find_next_bit (find_busiest_group)
00000002 0.281ms (+0.070ms): find_busiest_queue (load_balance_newidle)
00000002 0.351ms (+0.071ms): find_next_bit (find_busiest_queue)
00000002 0.422ms (+0.069ms): double_lock_balance (load_balance_newidle)
00000003 0.492ms (+0.070ms): move_tasks (load_balance_newidle)
00010003 0.563ms (+0.000ms): do_nmi (move_tasks)
00010003 0.563ms (+0.002ms): do_nmi (del_timer_sync)
00010003 0.566ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010003 0.566ms (+0.000ms): profile_hook (profile_tick)
00010003 0.567ms (+0.000ms): read_lock (profile_hook)
00010004 0.567ms (+0.000ms): notifier_call_chain (profile_hook)
00010003 0.567ms (+0.001ms): profile_hit (nmi_watchdog_tick)
00000003 0.569ms (+0.000ms): find_next_bit (move_tasks)
00000003 0.569ms (+0.000ms): dequeue_task (move_tasks)
00000003 0.570ms (+0.000ms): enqueue_task (move_tasks)
00000003 0.570ms (+0.000ms): resched_task (move_tasks)
00000003 0.571ms (+0.000ms): find_next_bit (move_tasks)
00000003 0.571ms (+0.000ms): dequeue_task (move_tasks)
00000003 0.571ms (+0.000ms): enqueue_task (move_tasks)
00000003 0.572ms (+0.000ms): resched_task (move_tasks)
00000002 0.572ms (+0.000ms): preempt_schedule (load_balance_newidle)

We had 500 usec accumulation of latency through several function calls.

[5] mark_tsc_offset - some steps in that sequence are generating
some long latencies. For example:

04010003 0.011ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010003 0.011ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010003 0.011ms (+0.000ms): spin_lock (mark_offset_tsc)
04010004 0.011ms (+0.137ms): mark_offset_tsc (timer_interrupt)
04010004 0.149ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010004 0.149ms (+0.000ms): spin_lock (mark_offset_tsc)
04010005 0.149ms (+0.144ms): mark_offset_tsc (timer_interrupt)
04010005 0.294ms (+0.004ms): mark_offset_tsc (timer_interrupt)
04010005 0.298ms (+0.003ms): mark_offset_tsc (timer_interrupt)
04010005 0.301ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010005 0.301ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010004 0.301ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010004 0.301ms (+0.073ms): mark_offset_tsc (timer_interrupt)
04010004 0.375ms (+0.000ms): mark_offset_tsc (timer_interrupt)
04010003 0.375ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)

I didn't see any feedback from the table I provided previously.
Is this data helpful or should I take out the patch?

[6] spin_lock - may just be an SMP lock problem but here's a trace
I don't recall seeing previously.

00000002 0.008ms (+0.000ms): snd_ensoniq_trigger (snd_pcm_do_stop)
00000002 0.008ms (+0.344ms): spin_lock (snd_ensoniq_trigger)
00010003 0.353ms (+0.015ms): do_nmi (snd_ensoniq_trigger)
00010003 0.368ms (+0.006ms): do_nmi (update_one_process)
00010003 0.375ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010003 0.375ms (+0.000ms): profile_hook (profile_tick)
00010003 0.375ms (+0.121ms): read_lock (profile_hook)
00010004 0.496ms (+0.000ms): notifier_call_chain (profile_hook)
00010003 0.497ms (+0.068ms): profile_hit (nmi_watchdog_tick)
00000002 0.566ms (+0.000ms): snd_pcm_post_stop (snd_pcm_action_single)

[7] Not sure what to call it, I don't recall seeing this type of trace
before either.

 => started at: __spin_lock_irqsave+0x39/0x90
 => ended at:   as_work_handler+0x5c/0xa0
=======>
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
00000001 0.000ms (+0.000ms): generic_enable_irq (ide_do_request)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (generic_enable_irq)
00000002 0.000ms (+0.000ms): unmask_IO_APIC_irq (generic_enable_irq)
00000002 0.000ms (+0.000ms): __spin_lock_irqsave (unmask_IO_APIC_irq)
00000003 0.001ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00000003 0.001ms (+0.066ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00000001 0.067ms (+0.001ms): smp_apic_timer_interrupt (as_work_handler)
00010001 0.069ms (+0.087ms): profile_tick (smp_apic_timer_interrupt)
00010001 0.157ms (+0.000ms): profile_hook (profile_tick)
00010001 0.157ms (+0.069ms): read_lock (profile_hook)
00010002 0.227ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.227ms (+0.069ms): profile_hit (smp_apic_timer_interrupt)
00010001 0.297ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 0.297ms (+0.069ms): update_one_process (update_process_times)
00010001 0.367ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.367ms (+0.069ms): raise_softirq (update_process_times)
00010001 0.437ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.437ms (+0.070ms): sched_clock (scheduler_tick)
00020001 0.507ms (+0.000ms): do_nmi (scheduler_tick)
00020001 0.508ms (+0.002ms): do_nmi (del_timer_sync)
00020001 0.511ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00020001 0.511ms (+0.000ms): profile_hook (profile_tick)
00020001 0.511ms (+0.065ms): read_lock (profile_hook)
00020002 0.577ms (+0.000ms): notifier_call_chain (profile_hook)
00020001 0.577ms (+0.000ms): profile_hit (nmi_watchdog_tick)
00010001 0.578ms (+0.000ms): spin_lock (scheduler_tick)

[8] exit_mmap - there are a few traces referring to code in or
called by exit_mmap. Here's an example.

 => started at: cond_resched_lock+0x6b/0x110
 => ended at:   exit_mmap+0x155/0x1f0
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched_lock)
00000001 0.000ms (+0.000ms): __bitmap_weight (unmap_vmas)
00000001 0.000ms (+0.000ms): vm_acct_memory (exit_mmap)
00000001 0.001ms (+0.629ms): clear_page_tables (exit_mmap)
00000001 0.631ms (+0.000ms): flush_tlb_mm (exit_mmap)
00000001 0.631ms (+0.000ms): free_pages_and_swap_cache (exit_mmap)

I will send the traces separately (not to linux-kernel) for analysis.

  --Mark

