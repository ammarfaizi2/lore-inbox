Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUJGRcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUJGRcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUJGRL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:11:57 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:49317 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S267396AbUJGQ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:56:24 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Date: Thu, 7 Oct 2004 11:55:51 -0500
Message-ID: <OF143B9C54.22D32E1D-ON86256F26.005D0092-86256F26.005D0153@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/07/2004 11:55:55 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've released the -T3 VP patch: [snip]

Thanks. This fixes the USB boot time problem / USB mouse does not work.
I do not have the problem others have reported with audio - audio works
just fine for me.

I've made two runs using latencytest for the real time task / generating
audio. To recap, I have a dual 866 Mhz Pentium III w/ 512 M memory,
Ensonic audio, 8139too network interface, and IDE disk. The IDE is set
to use udma2. Both tests run with both hard IRQ and soft IRQ threads
(except for the audio IRQ).

The first run, I set a limit of 500 usec and had no latencies longer than
that. Very good.

The second run, I set the limit to 200 usec and had 47 traces > 200 usec
in a 20-30 minute period. Two were VERY long, one was about 1.7 msec and
the other was over 50 msec. The material at the end summarizes the types
of traces I had. I will send the detailed traces separately.

  --Mark

To summarize, the symptoms w/ trace numbers following:
[1] VERY long latencies
04 27
[2] Long traces, USB related
00 32 42 43 44
[3] Long traces, network related
03 05... 24 28 46
[4] Pruning icache
25 26
[5] clear_page_tables
01 02 29 30 31 33... 41 45

[1] VERY long latencies

This appears to be disk related, IRQ 14 is ide0.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 53418 us, entries: 226 (226)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: IRQ 14/203, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock_irqsave+0x1f/0x80
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): _spin_lock_irqsave (ide_intr)
00000001 0.000ms (+0.000ms): drive_is_ready (ide_intr)
00000001 0.001ms (+0.000ms): __ide_dma_test_irq (drive_is_ready)
00000001 0.002ms (+0.000ms): ide_inb (__ide_dma_test_irq)
00000001 0.002ms (+0.000ms): del_timer (ide_intr)
00000001 0.003ms (+0.422ms): _spin_lock_irqsave (del_timer)
00010002 0.425ms (+0.000ms): do_nmi (sub_preempt_count)
00010002 0.426ms (+0.003ms): do_nmi (___trace)
00010002 0.429ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 0.430ms (+0.993ms): nmi_watchdog_tick (default_do_nmi)
00010002 1.423ms (+0.000ms): do_nmi (_spin_lock_irqsave)
00010002 1.424ms (+0.001ms): do_nmi (___trace)
00010002 1.425ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 1.425ms (+0.996ms): nmi_watchdog_tick (default_do_nmi)
00010001 2.422ms (+0.000ms): do_nmi (_spin_lock_irqsave)
00010001 2.422ms (+0.001ms): do_nmi (check_preempt_timing)
00010001 2.424ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010001 2.424ms (+0.996ms): nmi_watchdog_tick (default_do_nmi)
00010002 3.420ms (+0.000ms): do_nmi (_spin_lock_irqsave)
00010002 3.420ms (+0.001ms): do_nmi (check_preempt_timing)
00010002 3.422ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 3.422ms (+0.996ms): nmi_watchdog_tick (default_do_nmi)
00010002 4.418ms (+0.000ms): do_nmi (_spin_lock_irqsave)
00010002 4.419ms (+0.003ms): do_nmi (___trace)
00010002 4.422ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 4.422ms (+0.994ms): nmi_watchdog_tick (default_do_nmi)
...
00010001 49.345ms (+0.996ms): nmi_watchdog_tick (default_do_nmi)
00010002 50.341ms (+0.000ms): do_nmi (_spin_lock_irqsave)
00010002 50.341ms (+0.001ms): do_nmi (___trace)
00010002 50.343ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 50.343ms (+0.996ms): nmi_watchdog_tick (default_do_nmi)
00010002 51.339ms (+0.000ms): do_nmi (add_preempt_count)
00010002 51.340ms (+0.003ms): do_nmi (cycles_to_usecs)
00010002 51.343ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 51.343ms (+0.994ms): nmi_watchdog_tick (default_do_nmi)
00010002 52.338ms (+0.000ms): do_nmi (_spin_lock_irqsave)
00010002 52.338ms (+0.003ms): do_nmi (touch_preempt_timing)
00010002 52.342ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 52.342ms (+0.994ms): nmi_watchdog_tick (default_do_nmi)
00010002 53.336ms (+0.000ms): do_nmi (add_preempt_count)
00010002 53.336ms (+0.003ms): do_nmi (check_preempt_timing)
00010002 53.340ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 53.340ms (+0.076ms): nmi_watchdog_tick (default_do_nmi)
00000002 53.417ms (+0.000ms): _spin_unlock_irqrestore (del_timer)
00000001 53.417ms (+0.000ms): _spin_unlock (ide_intr)
00000001 53.418ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 53.419ms (+0.000ms): update_max_trace (check_preempt_timing)

Here is the other one, same basic symptom but just not as long duration.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 1715 us, entries: 18 (18)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: IRQ 14/203, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock_irqsave+0x1f/0x80
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): _spin_lock_irqsave (ide_intr)
00000001 0.000ms (+0.000ms): drive_is_ready (ide_intr)
00000001 0.001ms (+0.000ms): __ide_dma_test_irq (drive_is_ready)
00000001 0.001ms (+0.000ms): ide_inb (__ide_dma_test_irq)
00000001 0.002ms (+0.000ms): del_timer (ide_intr)
00000001 0.002ms (+0.022ms): _spin_lock_irqsave (del_timer)
00010002 0.024ms (+0.000ms): do_nmi (sub_preempt_count)
00010002 0.025ms (+0.001ms): do_nmi (check_preempt_timing)
00010002 0.026ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 0.027ms (+0.996ms): nmi_watchdog_tick (default_do_nmi)
00010002 1.023ms (+0.000ms): do_nmi (sub_preempt_count)
00010002 1.023ms (+0.003ms): do_nmi (check_preempt_timing)
00010002 1.027ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 1.027ms (+0.688ms): nmi_watchdog_tick (default_do_nmi)
00000002 1.715ms (+0.000ms): _spin_unlock_irqrestore (del_timer)
00000001 1.715ms (+0.000ms): _spin_unlock (ide_intr)
00000001 1.716ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 1.716ms (+0.000ms): update_max_trace (check_preempt_timing)

[2] Long traces, USB related

I had several traces with hundreds of lines of tracing data. This set
appear to be related to USB processing (moving the mouse).

This one is typical.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 365 us, entries: 320 (320)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: X/2815, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock_irqsave+0x1f/0x80
 => ended at:   _spin_unlock_irqrestore+0x32/0x70

[3] Long traces, network related

Similar to the previous one, and a symptom I have reported before.
I don't see any obvious fixes for this type of problem and the overhead
of tracing may introduce a significant delay to make the problem look
much worse than it really is.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 203 us, entries: 401 (401)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: ksoftirqd/0/3, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock+0x1f/0x70
 => ended at:   rtl8139_rx+0x217/0x340

OR

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 222 us, entries: 562 (562)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: rcp/7416, uid:2711 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: tcp_prequeue_process+0x49/0xb0
 => ended at:   local_bh_enable+0x3f/0xb0


[4] Pruning icache

Don't recall seeing this one before. It was long enough to have a clock
tick come in, but with only 25 usec overhead, the clock overhead was not
significant.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 274 us, entries: 165 (165)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/72, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock+0x1f/0x70
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.002ms): _spin_lock (prune_icache)
00000001 0.002ms (+0.005ms): inode_has_buffers (prune_icache)
00000001 0.007ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.009ms (+0.002ms): inode_has_buffers (prune_icache)
00000001 0.011ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.013ms (+0.002ms): inode_has_buffers (prune_icache)
...
00000001 0.263ms (+0.002ms): inode_has_buffers (prune_icache)
00000001 0.265ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.266ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.268ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.269ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.271ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.272ms (+0.000ms): inode_has_buffers (prune_icache)
00000001 0.273ms (+0.002ms): _spin_unlock (prune_icache)
00000001 0.275ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 0.276ms (+0.000ms): update_max_trace (check_preempt_timing)

[5] clear_page_tables

Usually short (<50-100 lines) but taking significant time to perform.
You can see the big hit at clear_page_tables in this one.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 234 us, entries: 38 (38)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: get_ltrace.sh/7082, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: unmap_vmas+0x12e/0x280
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (unmap_vmas)
00000001 0.000ms (+0.000ms): __bitmap_weight (unmap_vmas)
00000001 0.000ms (+0.000ms): unmap_page_range (unmap_vmas)
00000001 0.000ms (+0.000ms): zap_pmd_range (unmap_page_range)
00000001 0.000ms (+0.000ms): zap_pte_range (zap_pmd_range)
00000001 0.001ms (+0.000ms): kmap_atomic (zap_pte_range)
00000002 0.001ms (+0.000ms): page_address (zap_pte_range)
00000002 0.001ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.001ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.002ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.002ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.002ms (+0.000ms): kunmap_atomic (zap_pte_range)
00000001 0.003ms (+0.001ms): vm_acct_memory (exit_mmap)
00000001 0.004ms (+0.217ms): clear_page_tables (exit_mmap)
00000001 0.221ms (+0.003ms): flush_tlb_mm (exit_mmap)
00000001 0.225ms (+0.000ms): free_pages_and_swap_cache (exit_mmap)
00000001 0.225ms (+0.000ms): lru_add_drain (free_pages_and_swap_cache)
00000001 0.226ms (+0.000ms): release_pages (free_pages_and_swap_cache)
00000001 0.227ms (+0.000ms): _spin_lock_irq (release_pages)
00000001 0.227ms (+0.001ms): _spin_lock_irqsave (release_pages)
00000002 0.228ms (+0.000ms): _spin_unlock_irq (release_pages)
00000001 0.228ms (+0.000ms): __pagevec_free (release_pages)
00000001 0.228ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.229ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.229ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.230ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.230ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.230ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.231ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.231ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.232ms (+0.000ms): _spin_lock_irq (release_pages)
00000001 0.232ms (+0.000ms): _spin_lock_irqsave (release_pages)
00000002 0.232ms (+0.000ms): _spin_unlock_irq (release_pages)
00000001 0.233ms (+0.000ms): __pagevec_free (release_pages)
00000001 0.233ms (+0.000ms): free_hot_cold_page (__pagevec_free)
00000001 0.233ms (+0.001ms): _spin_unlock (exit_mmap)
00000001 0.235ms (+0.001ms): sub_preempt_count (_spin_unlock)
00000001 0.236ms (+0.000ms): update_max_trace (check_preempt_timing)

