Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUIITjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUIITjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIIThn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:37:43 -0400
Received: from lax-gate3.raytheon.com ([199.46.200.232]:32313 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S263100AbUIITZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:25:27 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Thu, 9 Sep 2004 14:23:39 -0500
Message-ID: <OF1EEB0481.83AB73CE-ON86256F0A.006A8955-86256F0A.006A8968@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/09/2004 02:23:47 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>would it be possible to test with DMA disabled? (hdparm -d0 /dev/hda) It
>might take some extra work to shun the extra latency reports from the
>PIO IDE path (which is quite slow) but once that is done you should be
>able to see whether these long 0.5 msec delays remain even if all (most)
>DMA activity has been eliminated.

OK. With new patches in hand, I have a set of latency results w/ IDE
DMA turned off. For reference, tests were run with:

# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 64 (on)
 geometry     = 58168/16/63, sectors = 58633344, start = 0

# cat /sys/block/hda/queue/max_sectors_kb
32
# cat /sys/block/hda/queue/read_ahead_kb
32
# cat /proc/sys/net/core/netdev_max_backlog
8
# dmesg -n 1

and all tests run w/ a -R8 kernel plus patches for sched, timer_tsc,
and ide-iops (to add latency trace outputs or suppress known long paths).

No latency traces > 600 usec. These tests were run simply with
  head -c 750000000 /dev/zero >tmpfile  (disk writes)
  cp tmpfile tmpfile2 (disk copy)
  cat tmpfile tmpfile2 >/dev/null
while capturing the latency traces in another process. 72 total traces
captured in 15 minutes of tests.

For reference, the 750 meg file size is about 1.5 x physical memory.
No I/O to the audio card. X was running (to monitor the test) and a
network was connected (but generally idle).

PIO trace
=========

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 369 us, entries: 3 (3)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: IRQ 14/140, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: ide_outsl+0x44/0x50
 => ended at:   ide_outsl+0x44/0x50
=======>
00000001 0.000ms (+0.370ms): touch_preempt_timing (ide_outsl)
00000001 0.370ms (+0.000ms): touch_preempt_timing (ide_outsl)
00000001 0.370ms (+0.000ms): update_max_trace (check_preempt_timing)

which appears to be the PIO path ide_outsl. I had a few similar traces
with ide_insl during the copy / read tests as well.

send_IPI_mask_bitmask
=====================

I have several traces where send_IPI_mask_bitmask (flush_tlb_others)
shows up. For example...

00000002 0.010ms (+0.001ms): kunmap_atomic (zap_pte_range)
00000001 0.011ms (+0.000ms): flush_tlb_mm (unmap_vmas)
00000002 0.012ms (+0.000ms): flush_tlb_others (flush_tlb_mm)
00000002 0.012ms (+0.000ms): spin_lock (flush_tlb_others)
00000003 0.013ms (+0.001ms): spin_lock (<00000000>)
00000003 0.014ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000003 0.014ms (+0.132ms): send_IPI_mask_bitmask (flush_tlb_others)
00010003 0.147ms (+0.000ms): do_nmi (flush_tlb_others)
00010003 0.147ms (+0.001ms): do_nmi (ide_outsl)
00010003 0.149ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010003 0.149ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010003 0.150ms (+0.000ms): profile_hook (profile_tick)
00010003 0.150ms (+0.000ms): read_lock (profile_hook)
00010004 0.150ms (+0.000ms): read_lock (<00000000>)
00010004 0.150ms (+0.000ms): notifier_call_chain (profile_hook)
00010004 0.151ms (+0.000ms): _read_unlock (profile_tick)
00010003 0.151ms (+0.250ms): profile_hit (nmi_watchdog_tick)
00000003 0.401ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000001 0.402ms (+0.000ms): free_pages_and_swap_cache (unmap_vmas)
00000001 0.402ms (+0.000ms): lru_add_drain (free_pages_and_swap_cache)

or this one...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 445 us, entries: 22 (22)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
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
00000001 0.003ms (+0.001ms): prio_tree_left (prio_tree_first)
00000001 0.005ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.005ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.006ms (+0.001ms): spin_lock (<00000000>)
00000002 0.007ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.007ms (+0.001ms): page_address (page_referenced_one)
00000003 0.009ms (+0.000ms): flush_tlb_page (page_referenced_one)
00000004 0.010ms (+0.000ms): flush_tlb_others (flush_tlb_page)
00000004 0.010ms (+0.000ms): spin_lock (flush_tlb_others)
00000005 0.011ms (+0.001ms): spin_lock (<00000000>)
00000005 0.012ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000005 0.012ms (+0.431ms): send_IPI_mask_bitmask (flush_tlb_others)
00000005 0.444ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000003 0.445ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.445ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.445ms (+0.000ms): _spin_unlock (page_referenced_file)
00000001 0.446ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 0.446ms (+0.000ms): update_max_trace (check_preempt_timing)

or this one...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 428 us, entries: 49 (49)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: get_ltrace.sh/5514, uid:0 nice:-9 policy:0 rt_prio:0
    -----------------
 => started at: flush_tlb_mm+0x1d/0xd0
 => ended at:   flush_tlb_mm+0x52/0xd0
=======>
00000001 0.000ms (+0.001ms): flush_tlb_mm (copy_mm)
00000001 0.001ms (+0.000ms): flush_tlb_others (flush_tlb_mm)
00000001 0.002ms (+0.000ms): spin_lock (flush_tlb_others)
00000002 0.002ms (+0.000ms): spin_lock (<00000000>)
00000002 0.003ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000002 0.003ms (+0.415ms): send_IPI_mask_bitmask (flush_tlb_others)
00000002 0.419ms (+0.000ms): smp_apic_timer_interrupt (flush_tlb_others)
00010002 0.419ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010002 0.419ms (+0.000ms): profile_hook (profile_tick)
00010002 0.419ms (+0.000ms): read_lock (profile_hook)
00010003 0.420ms (+0.000ms): read_lock (<00000000>)
00010003 0.420ms (+0.000ms): notifier_call_chain (profile_hook)
00010003 0.420ms (+0.000ms): _read_unlock (profile_tick)
00010002 0.420ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010002 0.420ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
...

or this one...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 330 us, entries: 9 (9)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: get_ltrace.sh/5514, uid:0 nice:-9 policy:0 rt_prio:0
    -----------------
 => started at: flush_tlb_mm+0x1d/0xd0
 => ended at:   flush_tlb_mm+0x52/0xd0
=======>
00000001 0.000ms (+0.001ms): flush_tlb_mm (copy_mm)
00000001 0.001ms (+0.000ms): flush_tlb_others (flush_tlb_mm)
00000001 0.002ms (+0.000ms): spin_lock (flush_tlb_others)
00000002 0.002ms (+0.000ms): spin_lock (<00000000>)
00000002 0.003ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000002 0.004ms (+0.326ms): send_IPI_mask_bitmask (flush_tlb_others)
00000002 0.330ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000001 0.331ms (+0.000ms): sub_preempt_count (flush_tlb_mm)
00000001 0.331ms (+0.000ms): update_max_trace (check_preempt_timing)

try_to_wake_up
==============

Buried inside a pretty long trace in kswapd0, I saw the following...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 426 us, entries: 286 (286)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (page_referenced_file)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.000ms (+0.000ms): prio_tree_first (vma_prio_tree_next)
00000001 0.001ms (+0.000ms): prio_tree_left (prio_tree_first)
00000001 0.001ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.001ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.002ms (+0.000ms): spin_lock (<00000000>)
...
00000006 0.108ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000006 0.108ms (+0.000ms): spin_lock (task_rq_lock)
00000007 0.108ms (+0.000ms): spin_lock (<00000000>)
00000007 0.109ms (+0.000ms): wake_idle (try_to_wake_up)
00000007 0.109ms (+0.000ms): activate_task (try_to_wake_up)
00000007 0.109ms (+0.000ms): sched_clock (activate_task)
00000007 0.109ms (+0.000ms): recalc_task_prio (activate_task)
00000007 0.109ms (+0.000ms): effective_prio (recalc_task_prio)
00000007 0.110ms (+0.000ms): __activate_task (try_to_wake_up)
00000007 0.110ms (+0.000ms): enqueue_task (__activate_task)
00000007 0.110ms (+0.000ms): sched_info_queued (enqueue_task)
00000007 0.110ms (+0.000ms): resched_task (try_to_wake_up)
00000007 0.111ms (+0.000ms): task_rq_unlock (try_to_wake_up)
00000007 0.111ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
00000006 0.111ms (+0.298ms): preempt_schedule (try_to_wake_up)
00000005 0.409ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000004 0.409ms (+0.000ms): preempt_schedule (flush_tlb_others)
00000003 0.410ms (+0.000ms): preempt_schedule (flush_tlb_page)
00000003 0.410ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.410ms (+0.000ms): preempt_schedule (page_referenced_one)
00000002 0.410ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.410ms (+0.000ms): preempt_schedule (page_referenced_one)

There is an almost 300 usec hit there as we unwind the nested layers.

So the long wait on paths through sched and timer_tsc appear to be
eliminated with PIO to the disk.

Is there some "for sure" way to limit the size and/or duration of
DMA transfers so I get reasonable performance from the disk (and
other DMA devices) and reasonable latency?
  --Mark

