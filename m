Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWEaDRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWEaDRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWEaDRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:17:41 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:19441 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751598AbWEaDRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:17:40 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
References: <20060530022925.8a67b613.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 23:17:28 -0400
Message-Id: <1149045448.28264.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh look what I found.  It seems that little driver of Andrew's has come
back to haunt me :)  And I think it has to do with that cute little
disable_irq in vortex_timer again.


============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {in-hardirq-W} -> {hardirq-on-W} usage.
idle/0 [HC0[0]:SC1[2]:HE1:SE0] takes:
 (&vp->lock){++..}, at: [<f8895b44>] vortex_timer+0x414/0x490 [3c59x]
{in-hardirq-W} state was registered at:
  [<c013c759>] lockdep_acquire+0x59/0x70
  [<c031a11d>] _spin_lock+0x3d/0x50
  [<f8898983>] boomerang_interrupt+0x33/0x470 [3c59x]
  [<c0147a11>] handle_IRQ_event+0x31/0x70
  [<c0149304>] handle_level_irq+0xa4/0x100
  [<c0105658>] do_IRQ+0x58/0x90
  [<c010348d>] common_interrupt+0x25/0x2c
  [<c010162d>] cpu_idle+0x4d/0xb0
  [<c01002e5>] rest_init+0x45/0x50
  [<c03f881a>] start_kernel+0x32a/0x460
  [<c0100210>] 0xc0100210
irq event stamp: 220672
hardirqs last  enabled at (220672): [<c031aa45>] _spin_unlock_irqrestore+0x65/00hardirqs last disabled at (220671): [<c031a5d6>] _spin_lock_irqsave+0x16/0x60
softirqs last  enabled at (220658): [<c0124453>] __do_softirq+0xf3/0x110
softirqs last disabled at (220667): [<c01244e5>] do_softirq+0x75/0x80

other info that might help us debug this:
no locks held by idle/0.

stack backtrace:
 <c01052bb> show_trace+0x1b/0x20  <c01052e6> dump_stack+0x26/0x30
 <c013af5d> print_usage_bug+0x22d/0x240  <c013b591> mark_lock+0x621/0x6c0
 <c013b6ff> __lockdep_acquire+0xcf/0xd30  <c013c759> lockdep_acquire+0x59/0x70
 <c031a172> _spin_lock_bh+0x42/0x50  <f8895b44> vortex_timer+0x414/0x490 [3c59x] <c0128cf9> run_timer_softirq+0xc9/0x1a0  <c01243e7> __do_softirq+0x87/0x110
 <c01244e5> do_softirq+0x75/0x80  <c0124650> irq_exit+0x50/0x60
 <c01102a3> smp_apic_timer_interrupt+0x73/0x80  <c010354e> apic_timer_interrupt0 <c010162d> cpu_idle+0x4d/0xb0  <c010f2a5> start_secondary+0x455/0x500
 <00000000> 0x0  <f7f85fb4> 0xf7f85fb4


-- Steve


