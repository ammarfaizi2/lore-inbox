Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWFJKb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWFJKb7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWFJKb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:31:59 -0400
Received: from www.osadl.org ([213.239.205.134]:54163 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751470AbWFJKb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:31:59 -0400
Message-Id: <20060610085435.599849000@cruncher.tec.linutronix.de>
References: <20060610085428.366868000@cruncher.tec.linutronix.de>
Date: Sat, 10 Jun 2006 10:15:12 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 2/2] genirq: Add reentrancy warning messages
Content-Disposition: inline; filename=genirq-add-reentrancy-messages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The simple and level irq handlers prevent reentrancy. For those irq types
reentrancy should not happen. Instead of silently going back omit a warning
message. Also do not reenable the interrupt in that case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 kernel/irq/chip.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc6-mm/kernel/irq/chip.c
===================================================================
--- linux-2.6.17-rc6-mm.orig/kernel/irq/chip.c	2006-06-10 10:32:49.000000000 +0200
+++ linux-2.6.17-rc6-mm/kernel/irq/chip.c	2006-06-10 10:42:40.000000000 +0200
@@ -208,8 +208,11 @@
 
 	spin_lock(&desc->lock);
 
-	if (unlikely(desc->status & IRQ_INPROGRESS))
+	if (unlikely(desc->status & IRQ_INPROGRESS)) {
+		printk(KERN_ERR "handle_simple_irq reentered while "
+		       "processing irq %d\n", irq);
 		goto out_unlock;
+	}
 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
 	kstat_cpu(cpu).irqs[irq]++;
 
@@ -251,8 +254,11 @@
 	spin_lock(&desc->lock);
 	mask_ack_irq(desc, irq);
 
-	if (unlikely(desc->status & IRQ_INPROGRESS))
+	if (unlikely(desc->status & IRQ_INPROGRESS)) {
+		printk(KERN_ERR "handle_level_irq reentered while "
+		       "processing irq %d\n", irq);
 		goto out;
+	}
 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
 	kstat_cpu(cpu).irqs[irq]++;
 
@@ -273,9 +279,9 @@
 
 	spin_lock(&desc->lock);
 	desc->status &= ~IRQ_INPROGRESS;
-out:
 	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
 		desc->chip->unmask(irq);
+out:
 	spin_unlock(&desc->lock);
 }
 

--

