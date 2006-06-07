Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWFGGKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWFGGKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWFGGKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:10:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:51588 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750829AbWFGGKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:10:35 -0400
Subject: genirq: fasteoi change for retrigger
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 16:10:16 +1000
Message-Id: <1149660616.27572.138.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas.

Would you be ok with a small change to the fasteoi handler that

 - If the interrupt happens while disabled, rather than just doing goto
out, also mark it pending
 - In the normal handling code path, clear pending.

That would allow some sort of soft-disable to work with fasteoi.

My issue here is on Cell. I have a very strange interrupt controller
that can't mask interrupts. 

They are all edges though (it's the internal controller of the chip, it
only takes messages from other units, possible level interrupts coming
from devices have to go through a separate cascaded external
controller).

It's also essentially a fasteoi controller: reading the irq number
automatically raises the controller priority to that of that interrupt
and the "EOI" is actually done by pushing the priority back down.

However, I cannot mask those interrupts in hardware. If an interrupt is
disabled with disable_irq(), it will have IRQ_DISABLED set, but may
still happen. In that case, it will be properly "skipped" by the fasteoi
handler. But the current handler won't keep track of the fact that it
happened, thus preventing me from having a re-trigger logic when that
interrupt is later re-enabled.

The patch below implements it.

Also, on another note, both the other handlers and my patch on fasteoi,
when an interrupt happens like that, will mask it as IRQ_PENDING if
disabled _or_ if it has no action. However, in the later case, adding an
action (via request_irq() -> setup_irq() will not test nor clear
IRQ_PENDING. It will be stale. Note sure how much of a problem that is
but worth noticing... 

Cheers,
Ben.

Index: linux-work/kernel/irq/chip.c
===================================================================
--- linux-work.orig/kernel/irq/chip.c	2006-06-05 17:55:31.000000000 +1000
+++ linux-work/kernel/irq/chip.c	2006-06-07 16:01:59.000000000 +1000
@@ -312,10 +312,13 @@ handle_fasteoi_irq(unsigned int irq, str
 	 * keep it masked and get out of here
 	 */
 	action = desc->action;
-	if (unlikely(!action || (desc->status & IRQ_DISABLED)))
+	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
+		desc->status |= IRQ_PENDING;
 		goto out;
+	}
 
 	desc->status |= IRQ_INPROGRESS;
+	desc->status &= ~IRQ_PENDING;
 	spin_unlock(&desc->lock);
 
 	action_ret = handle_IRQ_event(irq, regs, action);


