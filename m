Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbULHHjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbULHHjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbULHHgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:36:12 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:54154 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262059AbULHHbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:31:03 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: [5/6] Xen VMM #4: split free_irq into teardown_irq
In-reply-to: Your message of "Wed, 08 Dec 2004 07:28:16 GMT."
             <E1CbwFE-0006PZ-00@mta1.cl.cam.ac.uk> 
Date: Wed, 08 Dec 2004 07:31:00 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CbwHs-0006aT-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves the `unregister the irqaction' part of free_irq into
a new function teardown_irq, leaving only the mapping from dev_id to
irqaction and freeing the irqaction in free_irq.  free_irq
calls teardown_irq to unregister the irqaction.  This is similar
to how setup_irq and request_irq work for registering irq's.
We need teardown_irq to allow us to unregister irq's which were
registered early during boot when memory management wasn't ready
yet, i.e. irq's which were registered using setup_irq and use a static
irqaction which cannot be kfree'd.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---
diff -Nurp pristine-linux-2.6.10-rc3/include/linux/irq.h tmp-linux-2.6.10-rc3-xen.patch/include/linux/irq.h
--- pristine-linux-2.6.10-rc3/include/linux/irq.h	2004-12-03 21:55:13.000000000 +0000
+++ tmp-linux-2.6.10-rc3-xen.patch/include/linux/irq.h	2004-12-08 00:52:40.000000000 +0000
@@ -73,6 +73,7 @@ extern irq_desc_t irq_desc [NR_IRQS];
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
 extern int setup_irq(unsigned int irq, struct irqaction * new);
+extern int teardown_irq(unsigned int irq, struct irqaction * old);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
 extern cpumask_t irq_affinity[NR_IRQS];
diff -Nurp pristine-linux-2.6.10-rc3/kernel/irq/manage.c tmp-linux-2.6.10-rc3-xen.patch/kernel/irq/manage.c
--- pristine-linux-2.6.10-rc3/kernel/irq/manage.c	2004-12-03 21:55:12.000000000 +0000
+++ tmp-linux-2.6.10-rc3-xen.patch/kernel/irq/manage.c	2004-12-08 00:52:40.000000000 +0000
@@ -144,9 +144,14 @@ int can_request_irq(unsigned int irq, un
 	return !action;
 }
 
-/*
- * Internal function to register an irqaction - typically used to
- * allocate special interrupts that are part of the architecture.
+/**
+ *	setup_irq - register an irqaction structure
+ *	@irq: Interrupt to register
+ *	@irqaction: The irqaction structure to be registered
+ *
+ *	Normally called by request_irq, this function can be used
+ *	directly to allocate special interrupts that are part of the
+ *	architecture.
  */
 int setup_irq(unsigned int irq, struct irqaction * new)
 {
@@ -215,28 +220,27 @@ int setup_irq(unsigned int irq, struct i
 	return 0;
 }
 
-/**
- *	free_irq - free an interrupt
- *	@irq: Interrupt line to free
- *	@dev_id: Device identity to free
- *
- *	Remove an interrupt handler. The handler is removed and if the
- *	interrupt line is no longer in use by any driver it is disabled.
- *	On a shared IRQ the caller must ensure the interrupt is disabled
- *	on the card it drives before calling this function. The function
- *	does not return until any executing interrupts for this IRQ
- *	have completed.
+/*
+ *	teardown_irq - unregister an irqaction
+ *	@irq: Interrupt line being freed
+ *	@old: Pointer to the irqaction that is to be unregistered
+ *
+ *	This function is called by free_irq and does the actual
+ *	business of unregistering the handler. It exists as a 
+ *	seperate function to enable handlers to be unregistered 
+ *	for irqactions that have been allocated statically at 
+ *	boot time.
  *
  *	This function must not be called from interrupt context.
  */
-void free_irq(unsigned int irq, void *dev_id)
+int teardown_irq(unsigned int irq, struct irqaction * old)
 {
 	struct irq_desc *desc;
 	struct irqaction **p;
 	unsigned long flags;
 
 	if (irq >= NR_IRQS)
-		return;
+		return -ENOENT;
 
 	desc = irq_desc + irq;
 	spin_lock_irqsave(&desc->lock,flags);
@@ -248,7 +252,7 @@ void free_irq(unsigned int irq, void *de
 			struct irqaction **pp = p;
 
 			p = &action->next;
-			if (action->dev_id != dev_id)
+			if (action != old)
 				continue;
 
 			/* Found it - now remove it from the list of entries */
@@ -265,13 +269,52 @@ void free_irq(unsigned int irq, void *de
 
 			/* Make sure it's not being used on another CPU */
 			synchronize_irq(irq);
-			kfree(action);
-			return;
+			return 0;
 		}
-		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
+		printk(KERN_ERR "Trying to teardown free IRQ%d\n",irq);
 		spin_unlock_irqrestore(&desc->lock,flags);
+		return -ENOENT;
+	}
+}
+
+/**
+ *	free_irq - free an interrupt
+ *	@irq: Interrupt line to free
+ *	@dev_id: Device identity to free
+ *
+ *	Remove an interrupt handler. The handler is removed and if the
+ *	interrupt line is no longer in use by any driver it is disabled.
+ *	On a shared IRQ the caller must ensure the interrupt is disabled
+ *	on the card it drives before calling this function. The function
+ *	does not return until any executing interrupts for this IRQ
+ *	have completed.
+ *
+ *	This function must not be called from interrupt context.
+ */
+void free_irq(unsigned int irq, void *dev_id)
+{
+	struct irq_desc *desc;
+	struct irqaction *action;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS)
+		return;
+
+	desc = irq_desc + irq;
+	spin_lock_irqsave(&desc->lock,flags);
+	for (action = desc->action; action != NULL; action = action->next) {
+		if (action->dev_id != dev_id)
+			continue;
+
+		spin_unlock_irqrestore(&desc->lock,flags);
+
+		if (teardown_irq(irq, action) == 0)
+			kfree(action);
 		return;
 	}
+	printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
+	spin_unlock_irqrestore(&desc->lock,flags);
+	return;
 }
 
 EXPORT_SYMBOL(free_irq);
