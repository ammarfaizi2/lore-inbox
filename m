Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWEaDjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWEaDjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWEaDjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:39:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:61065 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751603AbWEaDjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:39:07 -0400
Subject: genirq handle helper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 31 May 2006 13:38:48 +1000
Message-Id: <1149046728.766.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas !

This simple pach makes the transition easier. By making
generic_handle_irq() call the old __do_IRQ if no new-style handler exist
for a given irq, the transition from old style to new style is made
easier for me. That is, I can have some PICs use the new handler
mecanism while old ones still get __do_IRQ without having the common
powerpc code caring about the type of PIC (it just does
generic_handle_irq()).

Might be useful to others as well, at least until everybody is ported
over.

Cheers,
Ben.

Index: linux-work/include/linux/irq.h
===================================================================
--- linux-work.orig/include/linux/irq.h	2006-05-31 11:26:45.000000000 +1000
+++ linux-work/include/linux/irq.h	2006-05-31 13:31:11.000000000 +1000
@@ -176,17 +176,6 @@ typedef struct irq_desc		irq_desc_t;
  */
 #include <asm/hw_irq.h>
 
-/*
- * Architectures call this to let the generic IRQ layer
- * handle an interrupt:
- */
-static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
-{
-	struct irq_desc *desc = irq_desc + irq;
-
-	desc->handle_irq(irq, desc, regs);
-}
-
 extern int setup_irq(unsigned int irq, struct irqaction *new);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
@@ -316,6 +305,20 @@ handle_irq_name(void fastcall (*handle)(
  */
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 
+/*
+ * Architectures call this to let the generic IRQ layer
+ * handle an interrupt:
+ */
+static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
+{
+	struct irq_desc *desc = irq_desc + irq;
+
+	if (desc->handle_irq)
+		desc->handle_irq(irq, desc, regs);
+	else
+		__do_IRQ(irq, regs);
+}
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   int action_ret, struct pt_regs *regs);


