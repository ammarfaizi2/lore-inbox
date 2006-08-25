Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWHYDRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWHYDRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 23:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWHYDRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 23:17:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21667 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422675AbWHYDRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 23:17:00 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: 2.6.18-rc4 i386 CONFIG_4KSTACKS does not use the hardirq stack
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 Aug 2006 13:16:37 +1000
Message-ID: <7109.1156475797@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc4 arch/i386/kernel/irq.c::do_IRQ has this code:


	if (!irq_desc[irq].handle_irq) {
		__do_IRQ(irq, regs);
		goto out_exit;
	}
#ifdef CONFIG_4KSTACKS

	curctx = (union irq_ctx *) current_thread_info();
	irqctx = hardirq_ctx[smp_processor_id()];
	...

All registered irqs on my system have a NULL handle_irq so do_IRQ
always calls __do_IRQ on the current stack, it never switches to the
hardirq_ctx stack.  Removing the test is trivial and it boots and runs
without the test for !irq_desc[irq].handle_irq, but why was the test
put there in the first place?

Note: with that test removed, do_IRQ runs on the hardirq stack, but
struct thread_info is not updated accordingly so backtrace is wrong.  I
can fix that as well, but I need to understand the test for handle_irq
first.

