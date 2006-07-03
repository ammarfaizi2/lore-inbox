Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWGCAT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWGCAT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWGCAT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:19:58 -0400
Received: from www.osadl.org ([213.239.205.134]:953 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750817AbWGCAT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:19:57 -0400
Subject: [PATCH] genirq: Fixup ARM devel merge
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 02:22:22 +0200
Message-Id: <1151886142.24611.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARM devel merge introduced new machine functionality which was not
covered by the ARM -> genirq patches. Fix it up and make it compile
again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.git/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-2.6.git.orig/arch/arm/plat-omap/gpio.c	2006-07-03
00:13:24.000000000 +0200
+++ linux-2.6.git/arch/arm/plat-omap/gpio.c	2006-07-03
01:51:27.000000000 +0200
@@ -850,7 +850,8 @@ static void gpio_irq_handler(unsigned in
 			/* Don't run the handler if it's already running
 			 * or was disabled lazely.
 			 */
-			if (unlikely((d->disable_depth || d->running))) {
+			if (unlikely((d->depth ||
+				      (d->status & IRQ_INPROGRESS)))) {
 				irq_mask = 1 <<
 					(gpio_irq - bank->virtual_irq_start);
 				/* The unmasking will be done by
@@ -859,22 +860,22 @@ static void gpio_irq_handler(unsigned in
 				 * it's already running.
 				 */
 				_enable_gpio_irqbank(bank, irq_mask, 0);
-				if (!d->disable_depth) {
+				if (!d->depth) {
 					/* Level triggered interrupts
 					 * won't ever be reentered
 					 */
 					BUG_ON(level_mask & irq_mask);
-					d->pending = 1;
+					d->status |= IRQ_PENDING;
 				}
 				continue;
 			}
-			d->running = 1;
+
 			desc_handle_irq(gpio_irq, d, regs);
-			d->running = 0;
-			if (unlikely(d->pending && !d->disable_depth)) {
+
+			if (unlikely((d->status & IRQ_PENDING) && !d->depth)) {
 				irq_mask = 1 <<
 					(gpio_irq - bank->virtual_irq_start);
-				d->pending = 0;
+				d->status &= ~IRQ_PENDING;
 				_enable_gpio_irqbank(bank, irq_mask, 1);
 				retrigger |= irq_mask;
 			}


