Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUL1RCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUL1RCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUL1RCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:02:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40094 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261183AbUL1RCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:02:43 -0500
Subject: PATCH: 2.6.10 - Misrouted IRQ recovery for review
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104249508.22366.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 15:58:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ported to the new kernel/irq code.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/kernel/irq/handle.c linux-2.6.10/kernel/irq/handle.c
--- linux.vanilla-2.6.10/kernel/irq/handle.c	2004-12-25 21:15:46.000000000 +0000
+++ linux-2.6.10/kernel/irq/handle.c	2004-12-26 23:20:04.000000000 +0000
@@ -130,7 +130,7 @@
 		desc->handler->ack(irq);
 		action_ret = handle_IRQ_event(irq, regs, desc->action);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
+			note_interrupt(irq, desc, action_ret, regs);
 		desc->handler->end(irq);
 		return 1;
 	}
@@ -184,7 +184,7 @@
 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
+			note_interrupt(irq, desc, action_ret, regs);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/kernel/irq/spurious.c linux-2.6.10/kernel/irq/spurious.c
--- linux.vanilla-2.6.10/kernel/irq/spurious.c	2004-12-25 21:15:46.000000000 +0000
+++ linux-2.6.10/kernel/irq/spurious.c	2004-12-26 23:26:55.000000000 +0000
@@ -11,6 +11,77 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 
+static int irqfixup;
+
+/*
+ *	Recovery handler for misrouted interrupts. 
+ */
+
+static int misrouted_irq(int irq, struct pt_regs *regs)
+{
+	int i;
+	irq_desc_t *desc;
+	int ok = 0;
+	int work = 0;	/* Did we do work for a real IRQ */
+	for(i = 1; i < NR_IRQS; i++)
+	{
+		struct irqaction *action;
+		if(i == irq)	/* Already tried */
+			continue;
+		desc = &irq_desc[i];
+		spin_lock(&desc->lock);
+		action = desc->action;
+		/* Already running on another processor */
+		if(desc->status & IRQ_INPROGRESS)
+		{
+			/* Already running: If it is shared get the other
+			   CPU to go looking for our mystery interrupt too */
+			if(desc->action && (desc->action->flags & SA_SHIRQ))
+				desc->status |= IRQ_PENDING;
+			spin_unlock(&desc->lock);
+			continue;
+		}
+		/* Honour the normal IRQ locking */
+		desc->status |= IRQ_INPROGRESS;
+		spin_unlock(&desc->lock);
+		while(action)
+		{
+			/* Only shared IRQ handlers are safe to call */
+			if(action->flags & SA_SHIRQ)
+			{
+				if(action->handler(i, action->dev_id, regs) == IRQ_HANDLED)
+					ok = 1;
+			}
+			action = action->next;
+		}
+		local_irq_disable();
+		/* Now clean up the flags */
+		spin_lock(&desc->lock);
+		action = desc->action;
+
+		/* While we were looking for a fixup someone queued a real
+		   IRQ clashing with our walk */
+
+		while((desc->status & IRQ_PENDING) && action)
+		{
+			/* Perform real IRQ processing for the IRQ we deferred */
+			work = 1;
+			spin_unlock(&desc->lock);
+			handle_IRQ_event(i, regs, action);
+			spin_lock(&desc->lock);
+			desc->status &= ~IRQ_PENDING;
+		}
+		desc->status &= ~IRQ_INPROGRESS;
+		/* If we did actual work for the real IRQ line we must
+		   let the IRQ controller clean up too */
+		if(work)
+			desc->handler->end(i);
+		spin_unlock(&desc->lock);
+	}
+	/* So the caller can adjust the irq error counts */
+	return ok;
+}
+
 /*
  * If 99,900 of the previous 100,000 interrupts have not been handled
  * then assume that the IRQ is stuck in some manner. Drop a diagnostic
@@ -31,7 +102,7 @@
 		printk(KERN_ERR "irq event %d: bogus return value %x\n",
 				irq, action_ret);
 	} else {
-		printk(KERN_ERR "irq %d: nobody cared!\n", irq);
+		printk(KERN_ERR "irq %d: nobody cared (try booting with the \"irqpoll\" option.\n", irq);
 	}
 	dump_stack();
 	printk(KERN_ERR "handlers:\n");
@@ -55,7 +126,7 @@
 	}
 }
 
-void note_interrupt(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
+void note_interrupt(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret, struct pt_regs *regs)
 {
 	if (action_ret != IRQ_HANDLED) {
 		desc->irqs_unhandled++;
@@ -63,6 +134,15 @@
 			report_bad_irq(irq, desc, action_ret);
 	}
 
+	if(unlikely(irqfixup)) { /* Don't punish working computers */
+		if((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE) {
+			int ok;
+			ok = misrouted_irq(irq, regs);
+			if(action_ret == IRQ_NONE)
+				desc->irqs_unhandled -= ok;
+		}
+	}
+
 	desc->irq_count++;
 	if (desc->irq_count < 100000)
 		return;
@@ -94,3 +174,22 @@
 
 __setup("noirqdebug", noirqdebug_setup);
 
+static int __init irqfixup_setup(char *str)
+{
+	irqfixup = 1;
+	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
+	printk(KERN_WARNING "This may impact system performance.\n");
+	return 1;
+}
+
+__setup("irqfixup", irqfixup_setup);
+
+static int __init irqpoll_setup(char *str)
+{
+	irqfixup = 2;
+	printk(KERN_WARNING "Misrouted IRQ fixup and polling support enabled.\n");
+	printk(KERN_WARNING "This may significantly impact system performance.\n");
+	return 1;
+}
+
+__setup("irqpoll", irqpoll_setup);

