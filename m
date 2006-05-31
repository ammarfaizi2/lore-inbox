Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWEaGOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWEaGOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWEaGOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:14:39 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59577 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932482AbWEaGOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:14:39 -0400
Date: Wed, 31 May 2006 08:15:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] genirq MSI fixes
Message-ID: <20060531061500.GA20609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

this is a fixed up and cleaned up replacement for 
genirq-msi-fixes.patch, which should solve the i386 4KSTACKS problem. I 
also added Ben's idea of pushing the __do_IRQ() check into 
generic_handle_irq().

i booted this with MSI enabled, but i only have MSI devices, not MSI-X 
devices. I'd still expect MSI-X to work now.

--------------
Subject: genirq-msi-fixes
From: Ingo Molnar <mingo@elte.hu>

irqchip migration helper: call __do_IRQ() if a descriptor is attached
to an irqtype-style controller. This also fixes MSI-X IRQ handling on
i386 and x86_64.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---

 arch/i386/kernel/irq.c |    5 +++++
 include/linux/irq.h    |   27 ++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

Index: linux/arch/i386/kernel/irq.c
===================================================================
--- linux.orig/arch/i386/kernel/irq.c
+++ linux/arch/i386/kernel/irq.c
@@ -77,6 +77,10 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	if (!irq_desc[irq].handle_irq) {
+		__do_IRQ(irq, regs);
+		goto out_exit;
+	}
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
@@ -109,6 +113,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 #endif
 		desc->handle_irq(irq, desc, regs);
 
+out_exit:
 	irq_exit();
 
 	return 1;
Index: linux/include/linux/irq.h
===================================================================
--- linux.orig/include/linux/irq.h
+++ linux/include/linux/irq.h
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
@@ -324,6 +313,22 @@ handle_irq_name(void fastcall (*handle)(
  */
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 
+/*
+ * Architectures call this to let the generic IRQ layer
+ * handle an interrupt. If the descriptor is attached to an
+ * irqchip-style controller then we call the ->handle_irq() handler,
+ * and it calls __do_IRQ() if it's attached to an irqtype-style controller.
+ */
+static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
+{
+	struct irq_desc *desc = irq_desc + irq;
+
+	if (likely(desc->handle_irq))
+		desc->handle_irq(irq, desc, regs);
+	else
+		__do_IRQ(irq, regs);
+}
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   int action_ret, struct pt_regs *regs);
