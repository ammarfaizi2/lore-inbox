Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUIFPS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUIFPS1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUIFPS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:18:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35790 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268128AbUIFPQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:16:18 -0400
Date: Mon, 6 Sep 2004 11:16:08 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, arjanv@redhat.com, akpm@osdl.org
Subject: PATCH: Misrouted IRQ recovery, take 2
Message-ID: <20040906151608.GA2980@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Separate polling with IRQ 0 case from the less costly case
  ["irqpoll" and "irqfixup"]
- Avoid re-entering the same IRQ handler twice
- Handle the fall out of this, which means we may end up doing IRQ
  service work before our return
- Fix an accounting bug
- Correct handling of IRQ running on other CPU that may clear our IRQ to
  fix a race.
- Run the handler with the right IRQ number (the one it expects not the real
  one). 
- Fix regparm case (Arjan van de Ven)
- Optimise arguments to misrouted_irq (Arjan van de Ven)

As before the code is all pulled out of line to avoid impacting working
computers.

There is still one corner case that would need core changes to fix up. If 
you use disable_irq() on a shared IRQ its handlers may get called still. We
can't not call them because disable_irq doesn't currently tell us *which*
handler is the disabled one.

Alan

--- linux-2.6.8.1/arch/i386/kernel/irq.c	2004-08-14 11:54:48.000000000 +0100
+++ linux-2.6.8.1.ac/arch/i386/kernel/irq.c	2004-09-07 06:11:11.000000000 +0100
@@ -273,12 +273,103 @@ static int noirqdebug;
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
+
+/*
+ *	Recovery handler for misrouted interrupts
+ */
+
+static asmlinkage int misrouted_irq(int irq, struct pt_regs *regs)
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
  * If 99,900 of the previous 100,000 interrupts have not been handled then
  * assume that the IRQ is stuck in some manner.  Drop a diagnostic and try to
@@ -289,13 +380,69 @@ __setup("noirqdebug", noirqdebug_setup);
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
+	if(unlikely(irqfixup))	/* Don't punish working computers */
+	{
+		if((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE)
+		{
+#ifdef CONFIG_4KSTACKS
+			u32 *isp;
+			union irq_ctx * curctx;
+			union irq_ctx * irqctx;
+			int ok;
+
+			curctx = (union irq_ctx *) current_thread_info();
+			irqctx = hardirq_ctx[smp_processor_id()];
+
+			spin_unlock(&desc->lock);
+
+			/*
+			 * this is where we switch to the IRQ stack. However, if we are already using
+			 * the IRQ stack (because we interrupted a hardirq handler) we can't do that
+			 * and just have to keep using the current stack (which is the irq stack already
+			 * after all)
+			 */
+
+			if (curctx == irqctx)
+				ok = misrouted_irq(irq, regs);
+			else {
+				/* build the stack frame on the IRQ stack */
+				isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
+				irqctx->tinfo.task = curctx->tinfo.task;
+				irqctx->tinfo.previous_esp = current_stack_pointer();
+
+				*--isp = (u32) regs;
+				*--isp = (u32) irq;
+
+				asm volatile(
+				"       xchgl   %%ebx,%%esp     \n"
+				"       call    misrouted_irq   \n"
+				"       xchgl   %%ebx,%%esp     \n"
+				: "=a"(ok)
+				: "b"(isp)
+				: "memory", "cc", "edx", "ecx"
+				);
+			}
+			spin_lock(&desc->lock);
+			if (curctx != irqctx)
+				irqctx->tinfo.task = NULL;
+#else
+			spin_unlock(&desc->lock);
+
+			ok = misrouted_irq(irq, desc, regs);
+
+			spin_lock(&desc->lock);
+#endif
+			if(action_ret == IRQ_NONE)
+				desc->irqs_unhandled -= ok;
+		}
+	}
 
 	desc->irq_count++;
 	if (desc->irq_count < 100000)
@@ -532,7 +679,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 		}
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
+			note_interrupt(irq, desc, action_ret, &regs);
 		if (curctx != irqctx)
 			irqctx->tinfo.task = NULL;
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -551,7 +698,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
+			note_interrupt(irq, desc, action_ret, &regs);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
