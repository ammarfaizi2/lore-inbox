Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUICQ2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUICQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269313AbUICQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:28:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269296AbUICQ1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:27:54 -0400
Date: Fri, 3 Sep 2004 12:27:42 -0400
From: Alan Cox <alan@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: Defence Against IRQ Routing Tables
Message-ID: <20040903162742.GA31398@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the proposed final patch for handling boxes with totally bogus
IRQ tables. If you boot with the new option "irqfixup" then the system will
attempt to handle misrouted interrupts. This also fixes an IRQ accounting
bug in the prototype.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.8.1/arch/i386/kernel/irq.c linux-2.6.8.1.ac/arch/i386/kernel/irq.c
--- linux-2.6.8.1/arch/i386/kernel/irq.c	2004-08-14 11:54:48.000000000 +0100
+++ linux-2.6.8.1.ac/arch/i386/kernel/irq.c	2004-09-04 04:45:33.499899392 +0100
@@ -273,12 +273,59 @@
 static int __init noirqdebug_setup(char *str)
 {
 	noirqdebug = 1;
-	printk("IRQ lockup detection disabled\n");
+	printk(KERN_INFO "IRQ lockup detection disabled\n");
 	return 1;
 }
 
 __setup("noirqdebug", noirqdebug_setup);
 
+static int irqfixup;
+
+static int __init irqfixup_setup(char *str)
+{
+	irqfixup = 1;
+	printk(KERN_WARNING "Misrouted IRQ support enabled.\n");
+	printk(KERN_WARNING "This may significantly impact system performance.\n");
+	return 1;
+}
+
+__setup("irqfixup", irqfixup_setup);
+
+/*
+ *	Recovery handler for misrouted interrupts
+ */
+
+static void misrouted_irq(int irq, irq_desc_t *desc, struct pt_regs *regs)
+{
+	int i;
+	int ok = 0;
+	for(i = 1; i < NR_IRQS; i++)
+	{
+		struct irqaction *action;
+		if(i == irq)	/* Already tried */
+			continue;
+		spin_lock(&irq_desc[i].lock);
+		if(irq_desc[i].status & IRQ_INPROGRESS)
+		{
+			/* Already running */
+			spin_unlock(&irq_desc[i].lock);
+			continue;
+		}
+		action = irq_desc[i].action;
+		while(action)
+		{
+			if(action->flags & SA_SHIRQ)
+			{
+				if(action->handler(irq, action->dev_id, regs) == IRQ_HANDLED)
+					ok = 1;
+			}
+			action = action->next;
+		}
+		spin_unlock(&irq_desc[i].lock);
+	}
+	desc->irqs_unhandled -= ok;
+}
+
 /*
  * If 99,900 of the previous 100,000 interrupts have not been handled then
  * assume that the IRQ is stuck in some manner.  Drop a diagnostic and try to
@@ -289,13 +336,68 @@
  *
  * Called under desc->lock
  */
-static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret, struct pt_regs *regs)
 {
 	if (action_ret != IRQ_HANDLED) {
 		desc->irqs_unhandled++;
 		if (action_ret != IRQ_NONE)
 			report_bad_irq(irq, desc, action_ret);
 	}
+	if(irqfixup)
+	{
+#ifdef CONFIG_4KSTACKS
+		irqreturn_t action_ret;
+		u32 *isp;
+		union irq_ctx * curctx;
+		union irq_ctx * irqctx;
+
+		curctx = (union irq_ctx *) current_thread_info();
+		irqctx = hardirq_ctx[smp_processor_id()];
+
+		spin_unlock(&desc->lock);
+
+		/*
+		 * this is where we switch to the IRQ stack. However, if we are already using
+		 * the IRQ stack (because we interrupted a hardirq handler) we can't do that
+		 * and just have to keep using the current stack (which is the irq stack already
+		 * after all)
+		 */
+
+		if (curctx == irqctx)
+			misrouted_irq(irq, desc, regs);
+		else {
+			/* build the stack frame on the IRQ stack */
+			isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
+			irqctx->tinfo.task = curctx->tinfo.task;
+			irqctx->tinfo.previous_esp = current_stack_pointer();
+
+			*--isp = (u32) regs;
+			*--isp = (u32) desc;
+			*--isp = (u32) irq;
+
+			asm volatile(
+				"       xchgl   %%ebx,%%esp     \n"
+				"       call    misrouted_irq   \n"
+				"       xchgl   %%ebx,%%esp     \n"
+				: "=a"(action_ret)
+				: "b"(isp)
+				: "memory", "cc", "edx", "ecx"
+			);
+
+
+		}
+		spin_lock(&desc->lock);
+		if (curctx != irqctx)
+			irqctx->tinfo.task = NULL;
+#else
+		irqreturn_t action_ret;
+		spin_unlock(&desc->lock);
+
+		misrouted_irq(irq, desc, regs);
+
+		spin_lock(&desc->lock);
+#endif
+	}
 
 	desc->irq_count++;
 	if (desc->irq_count < 100000)
@@ -532,7 +634,7 @@
 		}
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
+			note_interrupt(irq, desc, action_ret, &regs);
 		if (curctx != irqctx)
 			irqctx->tinfo.task = NULL;
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -551,7 +653,7 @@
 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
+			note_interrupt(irq, desc, action_ret, &regs);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
