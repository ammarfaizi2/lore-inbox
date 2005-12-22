Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVLVLnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVLVLnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVLVLnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:43:00 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27810 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932216AbVLVLm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:42:58 -0500
Subject: [PATCH] Debug shared irqs.
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 22 Dec 2005 11:42:46 +0000
Message-Id: <1135251766.3557.13.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers registering IRQ handlers with SA_SHIRQ really ought to be able
to handle an interrupt happening before request_irq() returns. They also
ought to be able to handle an interrupt happening during the start of
their call to free_irq(). Let's test that hypothesis....

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

I'm not wonderfully happy with the faked pt_regs, but I think it ought
to be OK like that.

--- linux-2.6.14/lib//Kconfig.debug~	2005-12-19 00:57:18.000000000 +0000
+++ linux-2.6.14/lib//Kconfig.debug	2005-12-22 11:37:27.000000000 +0000
@@ -176,6 +176,15 @@ config DEBUG_VM
 
 	  If unsure, say N.
 
+config SHARE_ME_HARDER
+       bool "Debug shared IRQ handlers"
+       depends on GENERIC_HARDIRQS
+       help
+         Enable this to generate a spurious interrupt as soon as a shared interrupt
+	 handler is registered, and just before one is deregistered. Drivers ought
+	 to be able to handle interrupts coming in at those some; some don't and
+	 need to be caught.
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML)
--- linux-2.6.14/kernel/irq/manage.c~	2005-12-19 00:57:18.000000000 +0000
+++ linux-2.6.14/kernel/irq/manage.c	2005-12-22 11:24:40.000000000 +0000
@@ -238,6 +238,10 @@ int setup_irq(unsigned int irq, struct i
 	return 0;
 }
 
+#ifdef CONFIG_SHARE_ME_HARDER
+static struct pt_regs shirq_fakeregs;
+#endif
+
 /**
  *	free_irq - free an interrupt
  *	@irq: Interrupt line to free
@@ -257,6 +261,7 @@ void free_irq(unsigned int irq, void *de
 	struct irq_desc *desc;
 	struct irqaction **p;
 	unsigned long flags;
+	irqreturn_t (*handler)(int, void *, struct pt_regs *) = NULL;
 
 	if (irq >= NR_IRQS)
 		return;
@@ -295,6 +300,8 @@ void free_irq(unsigned int irq, void *de
 
 			/* Make sure it's not being used on another CPU */
 			synchronize_irq(irq);
+			if (action->flags & SA_SHIRQ)
+				handler = action->handler;
 			kfree(action);
 			return;
 		}
@@ -302,6 +309,15 @@ void free_irq(unsigned int irq, void *de
 		spin_unlock_irqrestore(&desc->lock,flags);
 		return;
 	}
+#ifdef CONFIG_SHARE_ME_HARDER
+	if (handler) {
+		/* It's a shared IRQ -- the driver ought to be prepared for it to happen
+		   even now it's being freed, so let's make sure.... 
+		   We do this after actually deregistering it, to make sure that a 'real'
+		   IRQ doesn't run in parallel with our fake. */
+		handler(irq, dev_id, &shirq_fakeregs);
+	}
+#endif
 }
 
 EXPORT_SYMBOL(free_irq);
@@ -366,6 +382,16 @@ int request_irq(unsigned int irq,
 	action->next = NULL;
 	action->dev_id = dev_id;
 
+#ifdef CONFIG_SHARE_ME_HARDER
+	if (irqflags & SA_SHIRQ) {
+		/* It's a shared IRQ -- the driver ought to be prepared for it to happen
+		   immediately, so let's make sure.... 
+		   We do this before actually registering it, to make sure that a 'real'
+		   IRQ doesn't run in parallel with our fake. */
+		handler(irq, dev_id, &shirq_fakeregs);
+	}
+#endif
+
 	retval = setup_irq(irq, action);
 	if (retval)
 		kfree(action);


-- 
dwmw2

