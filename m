Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWA1O71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWA1O71 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 09:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWA1O70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 09:59:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40384 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751372AbWA1O70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 09:59:26 -0500
Date: Sat, 28 Jan 2006 16:00:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] warn on release_region() from irq context
Message-ID: <20060128150006.GA10660@elte.hu>
References: <20060128144357.GA6881@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128144357.GA6881@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the rationale for this patch is that the lock validator (which now 
tracks rwlock dependencies too, see output below) noticed that floppy.c 
does a release_region() from softirq context -> ouch. I'm working on the 
floppy.c fix for that.

	Ingo

  ============================
  [ BUG: illegal lock usage! ]
  ----------------------------
  illegal {softirq-on} -> {in-softirq} usage.
  rcu_torture_rea/264 [HC0[0]:SC1[2]:HE1:SE0] takes:
   (resource_lock){+-}, at: [<c0123997>] __release_region+0x37/0xf0
  {softirq-on} state was registered at:
   [<c0122c85>] irq_exit+0x45/0x50
  hardirqs last enabled at: [<c011d39e>] vprintk+0x32e/0x3e0
  softirqs last enabled at: [<c0122c85>] irq_exit+0x45/0x50
  
  other info that might help us debug this:
  no locks held by rcu_torture_rea/264.
  
  stack backtrace:
   [<c010432d>] show_trace+0xd/0x10
   [<c0104347>] dump_stack+0x17/0x20
   [<c0139078>] print_usage_bug+0x1d8/0x230
   [<c0139436>] mark_lock+0x366/0x3a0
   [<c0139903>] debug_lock_chain+0x493/0x1090
   [<c013a53d>] debug_lock_chain_spin+0x3d/0x60
   [<c0268522>] _raw_write_lock+0x32/0x1a0
   [<c04dc158>] _write_lock+0x8/0x10
   [<c0123997>] __release_region+0x37/0xf0
   [<c02f5010>] floppy_release_irq_and_dma+0x140/0x200
   [<c02f3577>] set_dor+0xc7/0x1b0
   [<c02f65e1>] motor_off_callback+0x21/0x30
   [<c01276c5>] run_timer_softirq+0xf5/0x1f0
   [<c0122fc7>] __do_softirq+0x97/0x130
   [<c01054a9>] do_softirq+0x69/0x100
   =======================
   [<c0122c85>] irq_exit+0x45/0x50
   [<c010f504>] smp_apic_timer_interrupt+0x54/0x60
   [<c010393b>] apic_timer_interrupt+0x27/0x2c
   [<c0266b79>] __delay+0x9/0x10
   [<c0266be1>] __udelay+0x31/0x40
   [<c01445e3>] rcu_torture_reader+0x83/0x140
   [<c0131cca>] kthread+0xca/0xd0
   [<c0100ef5>] kernel_thread_helper+0x5/0x10
