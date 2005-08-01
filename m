Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVHAS2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVHAS2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVHASXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:23:54 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:6091 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261621AbVHASWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:22:51 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050730160345.GA3584@elte.hu>
References: <20050730160345.GA3584@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 14:22:44 -0400
Message-Id: <1122920564.6759.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

What's with the "BUG: possible soft lockup detected on CPU..."? I'm
getting a bunch of them from the IDE interrupt.  It's not locking up,
but it does things that probably do take some time.  Is this really
necessary? Here's an example dump:

-- Steve

Note: I added the curr=%s:%d,current->comm,current->pid just to see who
was at fault. 

BUG: possible soft lockup detected on CPU#0! 578977-577975(578975)
curr=IRQ 14:713
 [<c010410f>] dump_stack+0x1f/0x30 (20)
 [<c01441e2>] softlockup_tick+0x172/0x1a0 (44)
 [<c0125d32>] update_process_times+0x62/0x140 (28)
 [<c010861d>] timer_interrupt+0x4d/0x100 (20)
 [<c014450f>] handle_IRQ_event+0x6f/0x120 (48)
 [<c014469c>] __do_IRQ+0xdc/0x1a0 (48)
 [<c0105abe>] do_IRQ+0x4e/0x90 (28)
 [<c0103b63>] common_interrupt+0x1f/0x24 (64)
 [<c02bddbe>] ata_input_data+0xbe/0xd0 (36)
 [<c02c29e1>] taskfile_input_data+0x31/0x60 (32)
 [<c02c3178>] ide_pio_sector+0xc8/0xf0 (36)
 [<c02c31f0>] ide_pio_multi+0x50/0x70 (28)
 [<c02c344e>] task_in_intr+0xfe/0x120 (36)
 [<c02bd450>] ide_intr+0x80/0x170 (36)
 [<c014450f>] handle_IRQ_event+0x6f/0x120 (48)
 [<c0144e5d>] do_hardirq+0x6d/0x150 (40)
 [<c0144fa9>] do_irqd+0x69/0xa0 (28)
 [<c013255e>] kthread+0xae/0xc0 (44)
 [<c01011ed>] kernel_thread_helper+0x5/0x18 (1052794908)
---------------------------
| preempt count: 20010003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c013d49a>] .... add_preempt_count+0x1a/0x20
.....[<c01085ec>] ..   ( <= timer_interrupt+0x1c/0x100)
.. [<c013d49a>] .... add_preempt_count+0x1a/0x20
.....[<c0144199>] ..   ( <= softlockup_tick+0x129/0x1a0)
.. [<c013d49a>] .... add_preempt_count+0x1a/0x20
.....[<c013e727>] ..   ( <= print_traces+0x17/0x50)

------------------------------
| showing all locks held by: |  (IRQ 14/713 [c13e2d10,  53]):
------------------------------


