Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUIIWnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUIIWnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUIIWnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:43:23 -0400
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:43488 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S266680AbUIIWm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:42:57 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
From: Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Thu, 9 Sep 2004 17:41:58 -0500
Message-ID: <OFCAA0B4D8.9D90B074-ON86256F0A.007CB13B-86256F0A.007CB14B@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/09/2004 05:42:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>so if these assumptions are true i'd suggest to decrease max_sectors
>from 32K to 16K - that alone should halve these random latencies from
>560 usecs to 280 usecs. Unless you see stability you might want to try
>an 8K setting as well - this will likely decrease your IO rates
>noticeably though. This would reduce the random delays to 140 usecs.

I tried both and still had some long delays. For example:

00000003 0.015ms (+0.000ms): send_IPI_mask (flush_tlb_others)
00000003 0.015ms (+0.137ms): send_IPI_mask_bitmask (flush_tlb_others)
00010003 0.153ms (+0.000ms): do_nmi (flush_tlb_others)
00010003 0.153ms (+0.001ms): do_nmi (ide_outsl)
00010003 0.155ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010003 0.155ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010003 0.155ms (+0.000ms): profile_hook (profile_tick)
00010003 0.156ms (+0.000ms): read_lock (profile_hook)
00010004 0.156ms (+0.000ms): read_lock (<00000000>)
00010004 0.156ms (+0.000ms): notifier_call_chain (profile_hook)
00010004 0.156ms (+0.000ms): _read_unlock (profile_tick)
00010003 0.157ms (+0.290ms): profile_hit (nmi_watchdog_tick)
00000003 0.447ms (+0.000ms): _spin_unlock (flush_tlb_others)
00000001 0.447ms (+0.000ms): free_pages_and_swap_cache (unmap_vmas)

or this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 440 us, entries: 34 (34)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000002 0.000ms (+0.410ms): spin_lock (<00000000>)
00010002 0.411ms (+0.000ms): do_IRQ (get_swap_page)

or this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 548 us, entries: 8 (8)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000002 0.000ms (+0.547ms): spin_lock (<00000000>)
00000002 0.548ms (+0.000ms): _spin_unlock (get_swap_page)
00000001 0.548ms (+0.000ms): _spin_unlock (get_swap_page)
00000001 0.548ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 0.549ms (+0.000ms): update_max_trace (check_preempt_timing)

or this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 422 us, entries: 345 (345)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kblockd/0/12, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x1a0
 => ended at:   do_IRQ+0x14a/0x1a0
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (kthread_should_stop)
00010000 0.000ms (+0.000ms): do_IRQ (<0000000a>)
00010000 0.000ms (+0.000ms): spin_lock (do_IRQ)
00010001 0.000ms (+0.052ms): spin_lock (<00000000>)
00010001 0.053ms (+0.000ms): mask_and_ack_level_ioapic_irq (do_IRQ)
00010001 0.053ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
00010001 0.053ms (+0.000ms): __spin_lock_irqsave (mask_IO_APIC_irq)
00010002 0.053ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00010002 0.053ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
00010002 0.054ms (+0.220ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
00010002 0.274ms (+0.000ms): _spin_unlock_irqrestore (mask_IO_APIC_irq)
00010001 0.274ms (+0.000ms): generic_redirect_hardirq (do_IRQ)

Kswapd0
=======

Not sure I saw this before - may be a side effect of the smaller
transfer sizes...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 500 us, entries: 608 (608)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
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
00000001 0.000ms (+0.000ms): prio_tree_left (prio_tree_first)
00000001 0.000ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.001ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.001ms (+0.000ms): spin_lock (<00000000>)
00000002 0.001ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.001ms (+0.000ms): page_address (page_referenced_one)
00000003 0.002ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.002ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.002ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.002ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.003ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.003ms (+0.000ms): spin_lock (<00000000>)
...
00000001 0.480ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.481ms (+0.001ms): page_referenced_one (page_referenced_file)
00000001 0.483ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.484ms (+0.001ms): spin_lock (<00000000>)
00000002 0.485ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.486ms (+0.001ms): page_address (page_referenced_one)
00000003 0.487ms (+0.000ms): flush_tlb_page (page_referenced_one)
00000003 0.488ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.489ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.489ms (+0.001ms): vma_prio_tree_next (page_referenced_file)
00000001 0.491ms (+0.002ms): page_referenced_one (page_referenced_file)
00000001 0.494ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.494ms (+0.002ms): spin_lock (<00000000>)
00000002 0.497ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.497ms (+0.000ms): page_address (page_referenced_one)
00000003 0.498ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.499ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.499ms (+0.002ms): _spin_unlock (page_referenced_file)
00000001 0.501ms (+0.002ms): sub_preempt_count (_spin_unlock)
00000001 0.503ms (+0.000ms): update_max_trace (check_preempt_timing)

>but the real fix would be to tweak the IDE controller to not do so
>agressive DMA! Are there any BIOS settings that somehow deal with it?
>Try increasing the PCI latency value? Is the disk using UDMA - if yes,
>could you downgrade it to normal IDE DMA? Perhaps that tweaks the
>controller to be 'nice' to the CPU.

I tried
  hdparm -p -X udma2 /dev/hda
(since it was udma4 previously)
and reran the tests. As a side note - that command caused a long latency
Something like...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 2019 us, entries: 2829 (2829)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: hdparm/13753, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched+0xd/0x30
 => ended at:   cond_resched+0xd/0x30
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched)
00000001 0.000ms (+0.007ms): ide_find_setting_by_ioctl (generic_ide_ioctl)
00000001 0.008ms (+0.000ms): ide_write_setting (generic_ide_ioctl)
00000001 0.009ms (+0.001ms): capable (ide_write_setting)
...
00000001 0.064ms (+0.001ms): ide_inb (ide_config_drive_speed)
00000001 0.066ms (+0.000ms): ide_inb (ide_config_drive_speed)
00000001 0.067ms (+0.000ms): ide_inb (ide_config_drive_speed)
...
00000001 1.899ms (+0.000ms): ide_inb (ide_config_drive_speed)
00000001 1.899ms (+0.000ms): ide_inb (ide_config_drive_speed)
00000001 1.900ms (+0.000ms): ide_inb (ide_config_drive_speed)
00000001 1.901ms (+0.000ms): __const_udelay (ide_config_drive_speed)
00000001 1.901ms (+0.000ms): __delay (ide_config_drive_speed)
00000001 1.901ms (+0.001ms): delay_tsc (__delay)
00000001 1.902ms (+0.000ms): ide_inb (ide_config_drive_speed)
...

The results after that change were like this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 536 us, entries: 31 (31)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: IRQ 14/140, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: kmap_atomic+0x23/0xe0
 => ended at:   kunmap_atomic+0x7b/0xa0
=======>
00000001 0.000ms (+0.000ms): kmap_atomic (__ide_do_rw_disk)
00000001 0.000ms (+0.000ms): page_address (__ide_do_rw_disk)
00000001 0.000ms (+0.000ms): ide_set_handler (__ide_do_rw_disk)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (ide_set_handler)
00000002 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000002 0.001ms (+0.000ms): __ide_set_handler (ide_set_handler)
00000002 0.001ms (+0.000ms): __mod_timer (ide_set_handler)
00000002 0.001ms (+0.000ms): __spin_lock_irqsave (__mod_timer)
00000003 0.001ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000003 0.002ms (+0.000ms): spin_lock (__mod_timer)
00000004 0.002ms (+0.000ms): spin_lock (<00000000>)
00000004 0.002ms (+0.000ms): internal_add_timer (__mod_timer)
00000004 0.002ms (+0.000ms): _spin_unlock (__mod_timer)
00000003 0.002ms (+0.000ms): _spin_unlock_irqrestore (__mod_timer)
00000002 0.003ms (+0.000ms): _spin_unlock_irqrestore (ide_set_handler)
00000001 0.003ms (+0.000ms): taskfile_output_data (__ide_do_rw_disk)
00000001 0.003ms (+0.000ms): ata_output_data (taskfile_output_data)
00000001 0.003ms (+0.496ms): ide_outsw (ata_output_data)
00010001 0.500ms (+0.000ms): do_nmi (ide_outsw)
00010001 0.501ms (+0.005ms): do_nmi (<0864d2b2>)
00010001 0.506ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010001 0.506ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.506ms (+0.000ms): profile_hook (profile_tick)
00010001 0.506ms (+0.000ms): read_lock (profile_hook)
00010002 0.507ms (+0.000ms): read_lock (<00000000>)
00010002 0.507ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.507ms (+0.000ms): _read_unlock (profile_tick)
00010001 0.507ms (+0.028ms): profile_hit (nmi_watchdog_tick)
00000001 0.536ms (+0.000ms): kunmap_atomic (__ide_do_rw_disk)
00000001 0.536ms (+0.000ms): sub_preempt_count (kunmap_atomic)
00000001 0.536ms (+0.000ms): sub_preempt_count (kunmap_atomic)
00000001 0.537ms (+0.000ms): update_max_trace (check_preempt_timing)

or this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 497 us, entries: 18 (18)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: IRQ 14/140, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: kmap_atomic+0x23/0xe0
 => ended at:   kunmap_atomic+0x7b/0xa0
=======>
00000001 0.000ms (+0.000ms): kmap_atomic (read_intr)
00000001 0.000ms (+0.000ms): page_address (read_intr)
00000001 0.000ms (+0.000ms): taskfile_input_data (read_intr)
00000001 0.000ms (+0.000ms): ata_input_data (taskfile_input_data)
00000001 0.000ms (+0.066ms): ide_insw (ata_input_data)
00010001 0.067ms (+0.000ms): do_nmi (ide_insw)
00010001 0.067ms (+0.003ms): do_nmi (<0815f06c>)
00010001 0.070ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010001 0.070ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.071ms (+0.000ms): profile_hook (profile_tick)
00010001 0.071ms (+0.000ms): read_lock (profile_hook)
00010002 0.071ms (+0.000ms): read_lock (<00000000>)
00010002 0.071ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.071ms (+0.000ms): _read_unlock (profile_tick)
00010001 0.072ms (+0.424ms): profile_hit (nmi_watchdog_tick)
00000001 0.497ms (+0.000ms): kunmap_atomic (read_intr)
00000001 0.497ms (+0.000ms): sub_preempt_count (kunmap_atomic)
00000001 0.498ms (+0.000ms): update_max_trace (check_preempt_timing)

or this...

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 454 us, entries: 60 (60)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000002 0.001ms (+0.267ms): spin_lock (<00000000>)
00010002 0.268ms (+0.000ms): do_nmi (get_swap_page)
00010002 0.268ms (+0.003ms): do_nmi (ide_outsw)
00010002 0.272ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 0.272ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010002 0.272ms (+0.000ms): profile_hook (profile_tick)
00010002 0.272ms (+0.000ms): read_lock (profile_hook)
00010003 0.273ms (+0.000ms): read_lock (<00000000>)
00010003 0.273ms (+0.000ms): notifier_call_chain (profile_hook)
00010003 0.273ms (+0.000ms): _read_unlock (profile_tick)
00010002 0.274ms (+0.000ms): profile_hit (nmi_watchdog_tick)
00010002 0.274ms (+0.000ms): do_IRQ (get_swap_page)
00010002 0.275ms (+0.000ms): do_IRQ (<00000000>)
00010002 0.275ms (+0.000ms): spin_lock (do_IRQ)
00010003 0.275ms (+0.000ms): spin_lock (<00000000>)
00010003 0.275ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010003 0.275ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010003 0.276ms (+0.000ms): _spin_unlock (do_IRQ)

or this...

reemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 457 us, entries: 8 (8)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000002 0.000ms (+0.456ms): spin_lock (<00000000>)
00000002 0.457ms (+0.000ms): _spin_unlock (get_swap_page)
00000001 0.457ms (+0.000ms): _spin_unlock (get_swap_page)
00000001 0.458ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 0.458ms (+0.000ms): update_max_trace (check_preempt_timing)

So I don't think that particular setting helps.

  --Mark


