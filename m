Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVBNUqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVBNUqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVBNUqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:46:22 -0500
Received: from fmr18.intel.com ([134.134.136.17]:34525 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261455AbVBNUqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:46:13 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: linux-kernel@vger.kernel.org
Subject: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Date: Mon, 14 Feb 2005 12:40:14 -0800
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502141240.14355.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a tweak to the preepmtive soft IRQ implementation using work 
queues and I'm having problems with a BUG assert when trying to queue_work.

Souldn't I be able to call queue_work form ISR context?

--mgross 

---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0140f5d>] .... print_traces+0x1d/0x60
.....[<c01042a3>] ..   ( <= dump_stack+0x23/0x30)

BUG: sleeping function called from invalid context IRQ 20(2039) at kernel/rt.c
in_atomic():0 [00000000], irqs_disabled():1
 [<c01042a3>] dump_stack+0x23/0x30 (20)
 [<c011f315>] __might_sleep+0xe5/0x100 (36)
 [<c013cd19>] __spin_lock+0x39/0x60 (24)
 [<c013cded>] _spin_lock_irqsave+0x1d/0x30 (16)
 [<c0134b32>] __queue_work+0x22/0x70 (28)
 [<c0134bd8>] queue_work+0x58/0xa0 (32)
 [<c01287cd>] __raise_softirq+0x2d/0x50 (12)
 [<f898b944>] e100_intr+0x124/0x170 [e100] (36)
 [<c0147ab9>] handle_IRQ_event+0x69/0xf0 (52)
 [<c0148365>] do_hardirq+0xa5/0x110 (40)
 [<c01484f1>] do_irqd+0x121/0x1f0 (48)
 [<c013990b>] kthread+0xbb/0xc0 (48)
 [<c01013f9>] kernel_thread_helper+0x5/0xc (154181652)
---------------------------

| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0140f5d>] .... print_traces+0x1d/0x60
.....[<c01042a3>] ..   ( <= dump_stack+0x23/0x30)

BUG: sleeping function called from invalid context swapper(0) at kernel/rt.c:1
in_atomic():1 [00010000], irqs_disabled():1
 [<c01042a3>] dump_stack+0x23/0x30 (20)
 [<c011f315>] __might_sleep+0xe5/0x100 (36)
 [<c013cd19>] __spin_lock+0x39/0x60 (24)
 [<c013cded>] _spin_lock_irqsave+0x1d/0x30 (16)
 [<c0134b32>] __queue_work+0x22/0x70 (28)
 [<c0134bd8>] queue_work+0x58/0xa0 (32)
 [<c0128aee>] raise_softirq+0x3e/0xb0 (20)
 [<c012d395>] update_process_times+0x45/0x110 (32)
 [<c01153ba>] smp_apic_timer_interrupt+0xea/0xf0 (36)
 [<c0103e18>] apic_timer_interrupt+0x1c/0x24 (60)
 [<c0101163>] cpu_idle+0x83/0x90 (24)
 [<c0404a8d>] start_kernel+0x19d/0x1e0 (32)
 [<c010020e>] 0xc010020e (1077727247)
---------------------------

