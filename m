Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWFVTxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWFVTxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWFVTxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:53:30 -0400
Received: from www.osadl.org ([213.239.205.134]:7399 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030368AbWFVTx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:53:29 -0400
Subject: Re: [patch 1/2] genirq: allow usage of no_irq_chip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150966277.25491.49.camel@localhost.localdomain>
References: <20060610085428.366868000@cruncher.tec.linutronix.de>
	 <20060610085435.487020000@cruncher.tec.linutronix.de>
	 <20060621161236.e868284d.akpm@osdl.org>
	 <20060622083516.GB25212@flint.arm.linux.org.uk>
	 <1150966277.25491.49.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 21:55:04 +0200
Message-Id: <1151006104.25491.197.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 10:51 +0200, Thomas Gleixner wrote:
> > Note that dropping it makes the genirq stuff buggy on ARM, so this
> > needs to be resolved before it can go anywhere near Linus' tree.
> 
> I'm aware of that. I'm looking into the problem, which might be resolved
> by Bens outstanding patchset anyway.

No, it is not. The patch was actually one of the brown paperbag
category. 

While Ben helped me to get my brain straight again, he mentioned that he
also could use an global extreme dumb irq_chip.

I came up with the following solution which allows us to keep the ARM
migration path smooth and might be of help for Ben too.

Also integrated into the latest armirq queue on top of 2.6.17: 
http://www.tglx.de/projects/armirq/2.6.17/patch-2.6.17-armirq2.patches.tar.bz2

	tglx


 include/linux/irq.h |    3 ++-
 kernel/irq/chip.c   |   15 ++++++++++++---
 kernel/irq/handle.c |   16 ++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

Index: linux-2.6.17-mm/include/linux/irq.h
===================================================================
--- linux-2.6.17-mm.orig/include/linux/irq.h	2006-06-22 21:36:29.000000000 +0200
+++ linux-2.6.17-mm/include/linux/irq.h	2006-06-22 21:36:30.000000000 +0200
@@ -348,8 +348,9 @@
 /* Checks whether the interrupt can be requested by request_irq(): */
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
-/* Dummy irq-chip implementation: */
+/* Dummy irq-chip implementations: */
 extern struct irq_chip no_irq_chip;
+extern struct irq_chip dummy_irq_chip;
 
 extern void
 set_irq_chip_and_handler(unsigned int irq, struct irq_chip *chip,
Index: linux-2.6.17-mm/kernel/irq/handle.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/irq/handle.c	2006-06-22 21:36:30.000000000 +0200
+++ linux-2.6.17-mm/kernel/irq/handle.c	2006-06-22 21:36:30.000000000 +0200
@@ -93,6 +93,22 @@
 };
 
 /*
+ * Generic dummy implementation which can be used for
+ * real dumb interrupt sources
+ */
+struct irq_chip dummy_irq_chip = {
+	.name		= "dummy",
+	.startup	= noop_ret,
+	.shutdown	= noop,
+	.enable		= noop,
+	.disable	= noop,
+	.ack		= noop,
+	.mask		= noop,
+	.unmask		= noop,
+	.end		= noop,
+};
+
+/*
  * Special, empty irq handler:
  */
 irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs)
Index: linux-2.6.17-mm/kernel/irq/chip.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/irq/chip.c	2006-06-22 21:36:29.000000000 +0200
+++ linux-2.6.17-mm/kernel/irq/chip.c	2006-06-22 21:36:30.000000000 +0200
@@ -459,9 +459,18 @@
 	if (!handle)
 		handle = handle_bad_irq;
 
-	if (is_chained && desc->chip == &no_irq_chip)
-		printk(KERN_WARNING "Trying to install "
-		       "chained interrupt type for IRQ%d\n", irq);
+	if (desc->chip == &no_irq_chip) {
+		printk(KERN_WARNING "Trying to install %sinterrupt handler "
+		       "for IRQ%d\n", is_chained ? "chained " : " ", irq);
+		/*
+		 * Some ARM implementations install a handler for really dumb
+		 * interrupt hardware without setting an irq_chip. This worked
+		 * with the ARM no_irq_chip but the check in setup_irq would
+		 * prevent us to setup the interrupt at all. Switch it to
+		 * dummy_irq_chip for easy transition.
+		 */
+		desc->chip = &dummy_irq_chip;
+	}
 
 	spin_lock_irqsave(&desc->lock, flags);
 





