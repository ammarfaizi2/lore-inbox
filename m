Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbUG0Wwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUG0Wwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUG0Wwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:52:41 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:26800 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266686AbUG0Wuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:50:44 -0400
Date: Tue, 27 Jul 2004 18:50:40 -0400
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: [patch] IRQ threads
Message-ID: <20040727225040.GA4370@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have attached a patch for implementing IRQ handlers in threads, for
latency-reduction purposes.  It requires that softirqs must be run in
threads (or else they could end up running inside the IRQ threads,
which will at the very least trigger bugs due to in_irq() being set). 
I've tested it with Ingo's voluntary-preempt J7 patch, and it should
work with the TimeSys softirq thread patch as well (though you might
get a conflict with the PF_IRQHANDLER definition; just merge them
into one).

Some notes:

1. This may not work properly with some interrupt controller code,
which doesn't do the obvious thing with mask_and_ack() and end(). 
This includes the IO-APIC code, which has an empty end() for edge
triggered interrupts and an empty mask_and_ack() for level-triggered
interrupts.  The mask_and_ack() needs to really mask the interrupt,
as otherwise the hardware will not deliver lower-priority (to it)
interrupts, which may have a higher-priority thread.

2. This patch does not disable local interrupts when running a
threaded handler.  SMP-safe drivers shouldn't be directly bothered by
this (as the interrupt could as easily have happened on another CPU),
but there may be some interactions with softirqs and per-cpu data, if
a softirq thread preempts an IRQ thread, or an IRQ thread gets
migrated to a different CPU.  I'm particularly worried about the
network code.  If possible, I'd like to find and fix such breakages
rather than use local_irq_disable(), as that would prevent IRQ
proritization from working, and prevent IRQ threads from being used
to isolate the rest of the system from long-running IRQs (such as
non-DMA IDE).

3. The i8042 driver had to be marked SA_NOTHREAD, as there are
non-preemptible regions where it spins, waiting for an interrupt.
Ideally, this driver (and others like it) should be fixed to either
do a cond_resched() or use a wait queue.

4. This might be a good time to get around to moving the bulk of the
arch/whatever/kernel/irq.c into generic code, as the code said was
supposed to happen in 2.5.  This patch is currently only for x86
(though we've run IRQ threads on many different platforms in the
past).

5. Is there any reason why an IRQ controller might want to have its
end() called even if IRQ_DISABLED or IRQ_INPROGRESS is set?  It'd be
nice to merge those checks in with the IRQ_THREADPENDING/IRQ_THREADRUNNING 
checks.

6. This patch causes in_irq() to return true if an IRQ thread is
running, as some drivers use it in common code to determine how to
act.  in_interrupt(), however, will return false in such a case.
The exact meaning of these macros in the presence of IRQ threads
isn't very well defined, and I hope this results in sane behavior.

Signed-off-by: Scott Wood <scott.wood@timesys.com> under TS0058

diff -urN linux-2.6.8-rc2/arch/i386/kernel/i386_ksyms.c linux-2.6.8-rc2-irq-threads/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.8-rc2/arch/i386/kernel/i386_ksyms.c	2004-07-27 17:06:24.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/arch/i386/kernel/i386_ksyms.c	2004-07-27 17:08:37.000000000 -0400
@@ -146,7 +146,6 @@
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
 
 /* Global SMP stuff */
-EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(smp_call_function);
 
 /* TLB flushing */
@@ -154,6 +153,10 @@
 EXPORT_SYMBOL_GPL(flush_tlb_all);
 #endif
 
+#if defined(CONFIG_SMP) || defined(CONFIG_IRQ_THREADS) 
+EXPORT_SYMBOL(synchronize_irq);
+#endif
+
 #ifdef CONFIG_X86_IO_APIC
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 #endif
diff -urN linux-2.6.8-rc2/arch/i386/kernel/i8259.c linux-2.6.8-rc2-irq-threads/arch/i386/kernel/i8259.c
--- linux-2.6.8-rc2/arch/i386/kernel/i8259.c	2004-07-27 17:06:24.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/arch/i386/kernel/i8259.c	2004-07-27 17:09:57.000000000 -0400
@@ -332,7 +332,8 @@
  * New motherboards sometimes make IRQ 13 be a PCI interrupt,
  * so allow interrupt sharing.
  */
-static struct irqaction fpu_irq = { math_error_irq, 0, CPU_MASK_NONE, "fpu", NULL, NULL };
+static struct irqaction fpu_irq = 
+	{ math_error_irq, SA_NOTHREAD, CPU_MASK_NONE, "fpu", NULL, NULL };
 
 void __init init_ISA_irqs (void)
 {
diff -urN linux-2.6.8-rc2/arch/i386/kernel/irq.c linux-2.6.8-rc2-irq-threads/arch/i386/kernel/irq.c
--- linux-2.6.8-rc2/arch/i386/kernel/irq.c	2004-07-27 17:06:24.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/arch/i386/kernel/irq.c	2004-07-27 17:08:37.000000000 -0400
@@ -200,8 +200,9 @@
 
 
 
-
-#ifdef CONFIG_SMP
+/* When IRQ threads are enabled, this has to synchronize with the thread.
+   The function to do this is provided in generic code. */
+#if defined(CONFIG_SMP) && !defined(CONFIG_IRQ_THREADS)
 inline void synchronize_irq(unsigned int irq)
 {
 	while (irq_desc[irq].status & IRQ_INPROGRESS)
@@ -226,10 +227,16 @@
 		local_irq_enable();
 
 	do {
-		status |= action->flags;
-		retval |= action->handler(irq, action->dev_id, regs);
+#ifdef CONFIG_IRQ_THREADS
+		if (action->flags & SA_NOTHREAD)
+#endif
+		{
+			status |= action->flags;
+			retval |= action->handler(irq, action->dev_id, regs);
+		}
 		action = action->next;
 	} while (action);
+
 	if (status & SA_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 	local_irq_disable();
@@ -289,13 +296,10 @@
  *
  * Called under desc->lock
  */
-static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+static void note_interrupt(int irq, irq_desc_t *desc)
 {
-	if (action_ret != IRQ_HANDLED) {
+	if (desc->status & IRQ_UNHANDLED)
 		desc->irqs_unhandled++;
-		if (action_ret != IRQ_NONE)
-			report_bad_irq(irq, desc, action_ret);
-	}
 
 	desc->irq_count++;
 	if (desc->irq_count < 100000)
@@ -306,7 +310,7 @@
 		/*
 		 * The interrupt is stuck
 		 */
-		__report_bad_irq(irq, desc, action_ret);
+		__report_bad_irq(irq, desc, IRQ_NONE);
 		/*
 		 * Now kill the IRQ
 		 */
@@ -395,7 +399,14 @@
 			desc->status = status | IRQ_REPLAY;
 			hw_resend_irq(desc->handler,irq);
 		}
-		desc->handler->enable(irq);
+		
+		/* Don't unmask the IRQ if it's in progress, or else you
+		   could re-enter the IRQ handler.  As it is now enabled,
+		   the IRQ will be unmasked when the handler is finished. */
+		
+		if (!(desc->status & (IRQ_INPROGRESS | IRQ_THREADRUNNING |
+		                      IRQ_THREADPENDING)))
+			desc->handler->enable(irq);
 		/* fall-through */
 	}
 	default:
@@ -408,12 +419,7 @@
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-/*
- * do_IRQ handles all normal device IRQ's (the special
- * SMP cross-CPU interrupts have their own specific
- * handlers).
- */
-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
+static void really_do_IRQ(struct pt_regs *regs)
 {	
 	/* 
 	 * We ack quickly, we don't want the irq controller
@@ -425,27 +431,11 @@
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	int irq = regs->orig_eax & 0xff; /* high bits used in ret_from_ code  */
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
 
-	irq_enter();
-
-#ifdef CONFIG_DEBUG_STACKOVERFLOW
-	/* Debugging check for stack overflow: is there less than 1KB free? */
-	{
-		long esp;
-
-		__asm__ __volatile__("andl %%esp,%0" :
-					"=r" (esp) : "0" (THREAD_SIZE - 1));
-		if (unlikely(esp < (sizeof(struct thread_info) + STACK_WARN))) {
-			printk("do_IRQ: stack overflow: %ld\n",
-				esp - sizeof(struct thread_info));
-			dump_stack();
-		}
-	}
-#endif
 	kstat_this_cpu.irqs[irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -454,14 +444,17 @@
 	   WAITING is used by probe to mark irqs that are being tested
 	   */
 	status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-	status |= IRQ_PENDING; /* we _want_ to handle it */
+	status |= IRQ_PENDING |  /* we _want_ to handle it */
+	          IRQ_UNHANDLED; /* This will be cleared after a
+	                            handler that cares. */
 
 	/*
 	 * If the IRQ is disabled for whatever reason, we cannot
 	 * use the action we have.
 	 */
 	action = NULL;
-	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
+	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS |
+	                       IRQ_THREADPENDING | IRQ_THREADRUNNING)))) {
 		action = desc->action;
 		status &= ~IRQ_PENDING; /* we commit to handling */
 		status |= IRQ_INPROGRESS; /* we are handling it */
@@ -487,89 +480,117 @@
 	 * useful for irq hardware that does not mask cleanly in an
 	 * SMP environment.
 	 */
-#ifdef CONFIG_4KSTACKS
-
 	for (;;) {
 		irqreturn_t action_ret;
-		u32 *isp;
-		union irq_ctx * curctx;
-		union irq_ctx * irqctx;
-
-		curctx = (union irq_ctx *) current_thread_info();
-		irqctx = hardirq_ctx[smp_processor_id()];
-
-		spin_unlock(&desc->lock);
-
-		/*
-		 * this is where we switch to the IRQ stack. However, if we are already using
-		 * the IRQ stack (because we interrupted a hardirq handler) we can't do that
-		 * and just have to keep using the current stack (which is the irq stack already
-		 * after all)
-		 */
-
-		if (curctx == irqctx)
-			action_ret = handle_IRQ_event(irq, &regs, action);
-		else {
-			/* build the stack frame on the IRQ stack */
-			isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
-			irqctx->tinfo.task = curctx->tinfo.task;
-			irqctx->tinfo.previous_esp = current_stack_pointer();
-
-			*--isp = (u32) action;
-			*--isp = (u32) &regs;
-			*--isp = (u32) irq;
-
-			asm volatile(
-				"       xchgl   %%ebx,%%esp     \n"
-				"       call    handle_IRQ_event \n"
-				"       xchgl   %%ebx,%%esp     \n"
-				: "=a"(action_ret)
-				: "b"(isp)
-				: "memory", "cc", "edx", "ecx"
-			);
-
 
+#ifdef CONFIG_IRQ_THREADS
+		if (desc->thread) {
+			desc->status |= IRQ_THREADPENDING;
+			wake_up_process(desc->thread);
 		}
-		spin_lock(&desc->lock);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
-		if (curctx != irqctx)
-			irqctx->tinfo.task = NULL;
+		
+		if (!desc->thread || (desc->status & IRQ_NOTHREAD))
+#endif
+		{
+			spin_unlock(&desc->lock);
+			action_ret = handle_IRQ_event(irq, regs, action);
+			spin_lock(&desc->lock);
+
+			if (!noirqdebug) {
+				if (action_ret == IRQ_HANDLED)
+					desc->status &= ~IRQ_UNHANDLED;
+				else if (action_ret != IRQ_NONE)
+					report_bad_irq(irq, desc, action_ret);
+			}
+		}
+			
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
 	}
 
-#else
+	desc->status &= ~IRQ_INPROGRESS;
 
-	for (;;) {
-		irqreturn_t action_ret;
+out:
+	/*
+	 * The ->end() handler has to deal with interrupts which got
+	 * disabled while the handler was running.
+	 */
+	if (!(desc->status & (IRQ_THREADPENDING | IRQ_THREADRUNNING))) {
+		if (!noirqdebug)
+			note_interrupt(irq, desc);
+		
+		desc->handler->end(irq);
+	}
+	spin_unlock(&desc->lock);
+}
+
+/*
+ * do_IRQ handles all normal device IRQ's (the special
+ * SMP cross-CPU interrupts have their own specific
+ * handlers).
+ */
+asmlinkage void do_IRQ(struct pt_regs regs)
+{
+#ifdef CONFIG_4KSTACKS
+	u32 *isp;
+	union irq_ctx *curctx;
+	union irq_ctx *irqctx;
+#endif
+
+	irq_enter();
 
-		spin_unlock(&desc->lock);
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+	/* Debugging check for stack overflow: is there less than 1KB free? */
+	{
+		long esp;
 
-		action_ret = handle_IRQ_event(irq, &regs, action);
+		asm volatile("andl %%esp,%0" :
+		             "=r" (esp) : "0" (THREAD_SIZE - 1));
 
-		spin_lock(&desc->lock);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
-		if (likely(!(desc->status & IRQ_PENDING)))
-			break;
-		desc->status &= ~IRQ_PENDING;
+		if (unlikely(esp < (sizeof(struct thread_info) + STACK_WARN))) {
+			printk("do_IRQ: stack overflow: %ld\n",
+			       esp - sizeof(struct thread_info));
+			dump_stack();
+		}
 	}
 #endif
-	desc->status &= ~IRQ_INPROGRESS;
 
-out:
+#ifdef CONFIG_4KSTACKS
+	curctx = (union irq_ctx *) current_thread_info();
+	irqctx = hardirq_ctx[smp_processor_id()];
+
 	/*
-	 * The ->end() handler has to deal with interrupts which got
-	 * disabled while the handler was running.
+	 * this is where we switch to the IRQ stack. However, if we are already using
+	 * the IRQ stack (because we interrupted a hardirq handler) we can't do that
+	 * and just have to keep using the current stack (which is the irq stack already
+	 * after all)
 	 */
-	desc->handler->end(irq);
-	spin_unlock(&desc->lock);
 
-	irq_exit();
+	if (curctx == irqctx) {
+		really_do_IRQ(&regs);
+	} else {
+		/* build the stack frame on the IRQ stack */
+		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
+		irqctx->tinfo.task = curctx->tinfo.task;
+		irqctx->tinfo.previous_esp = current_stack_pointer();
 
-	return 1;
+		*--isp = (u32) &regs;
+
+		asm volatile("xchgl   %%ebx, %%esp;"
+		             "call    really_do_IRQ;"
+ 		             "xchgl   %%ebx, %%esp;"
+		           : /* no outputs */
+		           : "b" (isp)
+		           : "memory", "cc", "eax", "edx", "ecx");
+
+		irqctx->tinfo.task = NULL;
+	}
+#else
+	really_do_IRQ(&regs);
+#endif
+
+	irq_exit();
 }
 
 int can_request_irq(unsigned int irq, unsigned long irqflags)
@@ -704,7 +725,7 @@
 			*pp = action->next;
 			if (!desc->action) {
 				desc->status |= IRQ_DISABLED;
-				desc->handler->shutdown(irq);
+				do_shutdown_irq(irq);
 			}
 			spin_unlock_irqrestore(&desc->lock,flags);
 
@@ -943,6 +964,8 @@
 		rand_initialize_irq(irq);
 	}
 
+	setup_irq_spawn_thread(irq, new);
+
 	/*
 	 * The following block of code has to be executed atomically
 	 */
@@ -968,7 +991,7 @@
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
-		desc->handler->startup(irq);
+		do_startup_irq(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);
 
diff -urN linux-2.6.8-rc2/arch/i386/mach-default/setup.c linux-2.6.8-rc2-irq-threads/arch/i386/mach-default/setup.c
--- linux-2.6.8-rc2/arch/i386/mach-default/setup.c	2004-07-27 17:06:24.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/arch/i386/mach-default/setup.c	2004-07-27 17:10:42.000000000 -0400
@@ -27,7 +27,8 @@
 /*
  * IRQ2 is cascade interrupt to second interrupt controller
  */
-static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
+static struct irqaction irq2 = 
+	{ no_action, SA_NOTHREAD, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 /**
  * intr_init_hook - post gate setup interrupt initialisation
@@ -71,7 +72,9 @@
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+static struct irqaction irq0  = 
+	{ timer_interrupt, SA_INTERRUPT | SA_NOTHREAD, CPU_MASK_NONE, 
+	  "timer", NULL, NULL};
 
 /**
  * time_init_hook - do any specific initialisations for the system timer.
diff -urN linux-2.6.8-rc2/arch/i386/mach-visws/setup.c linux-2.6.8-rc2-irq-threads/arch/i386/mach-visws/setup.c
--- linux-2.6.8-rc2/arch/i386/mach-visws/setup.c	2004-06-16 01:18:59.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/arch/i386/mach-visws/setup.c	2004-07-27 17:08:46.000000000 -0400
@@ -112,7 +112,7 @@
 
 static struct irqaction irq0 = {
 	.handler =	timer_interrupt,
-	.flags =	SA_INTERRUPT,
+	.flags =	SA_INTERRUPT | SA_NOTHREAD,
 	.name =		"timer",
 };
 
diff -urN linux-2.6.8-rc2/arch/i386/mach-visws/visws_apic.c linux-2.6.8-rc2-irq-threads/arch/i386/mach-visws/visws_apic.c
--- linux-2.6.8-rc2/arch/i386/mach-visws/visws_apic.c	2004-06-16 01:18:57.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/arch/i386/mach-visws/visws_apic.c	2004-07-27 17:08:46.000000000 -0400
@@ -261,11 +261,13 @@
 static struct irqaction master_action = {
 	.handler =	piix4_master_intr,
 	.name =		"PIIX4-8259",
+	.flags =        SA_NOTHREAD,
 };
 
 static struct irqaction cascade_action = {
 	.handler = 	no_action,
 	.name =		"cascade",
+	.flags =        SA_NOTHREAD,
 };
 
 
diff -urN linux-2.6.8-rc2/arch/i386/mach-voyager/setup.c linux-2.6.8-rc2-irq-threads/arch/i386/mach-voyager/setup.c
--- linux-2.6.8-rc2/arch/i386/mach-voyager/setup.c	2004-07-27 17:06:24.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/arch/i386/mach-voyager/setup.c	2004-07-27 17:11:14.000000000 -0400
@@ -17,7 +17,8 @@
 /*
  * IRQ2 is cascade interrupt to second interrupt controller
  */
-static struct irqaction irq2 = { no_action, 0, CPU_MASK_NONE, "cascade", NULL, NULL};
+static struct irqaction irq2 = 
+	{ no_action, SA_NOTHREAD, CPU_MASK_NONE, "cascade", NULL, NULL};
 
 void __init intr_init_hook(void)
 {
@@ -40,7 +41,9 @@
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+static struct irqaction irq0  = 
+	{ timer_interrupt, SA_INTERRUPT | SA_NOTHREAD, 
+	  CPU_MASK_NONE, "timer", NULL, NULL};
 
 void __init time_init_hook(void)
 {
diff -urN linux-2.6.8-rc2/drivers/input/serio/i8042.c linux-2.6.8-rc2-irq-threads/drivers/input/serio/i8042.c
--- linux-2.6.8-rc2/drivers/input/serio/i8042.c	2004-06-16 01:18:57.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/drivers/input/serio/i8042.c	2004-07-27 17:52:11.000000000 -0400
@@ -277,7 +277,7 @@
 			return 0;
 
 	if (request_irq(values->irq, i8042_interrupt,
-			SA_SHIRQ, "i8042", i8042_request_irq_cookie)) {
+			SA_SHIRQ | SA_NOTHREAD, "i8042", i8042_request_irq_cookie)) {
 		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
 		goto irq_fail;
 	}
@@ -571,7 +571,7 @@
  * in trying to detect AUX presence.
  */
 
-	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
+	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ | SA_NOTHREAD,
 				"i8042", &i8042_check_aux_cookie))
                 return -1;
 	free_irq(values->irq, &i8042_check_aux_cookie);
diff -urN linux-2.6.8-rc2/include/asm-i386/hardirq.h linux-2.6.8-rc2-irq-threads/include/asm-i386/hardirq.h
--- linux-2.6.8-rc2/include/asm-i386/hardirq.h	2004-06-16 01:19:43.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/include/asm-i386/hardirq.h	2004-07-27 17:08:46.000000000 -0400
@@ -64,7 +64,12 @@
  * Are we doing bottom half or hardware interrupt processing?
  * Are we in a softirq context? Interrupt context?
  */
+#ifdef CONFIG_IRQ_THREADS
+#define in_irq()     (hardirq_count() || (current->flags & PF_IRQHANDLER))
+#else
 #define in_irq()		(hardirq_count())
+#endif
+
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
 
@@ -92,7 +97,7 @@
 		preempt_enable_no_resched();				\
 } while (0)
 
-#ifndef CONFIG_SMP
+#if !defined(CONFIG_SMP) && !defined(CONFIG_IRQ_THREADS)
 # define synchronize_irq(irq)	barrier()
 #else
   extern void synchronize_irq(unsigned int irq);
diff -urN linux-2.6.8-rc2/include/asm-i386/irq.h linux-2.6.8-rc2-irq-threads/include/asm-i386/irq.h
--- linux-2.6.8-rc2/include/asm-i386/irq.h	2004-06-16 01:19:37.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/include/asm-i386/irq.h	2004-07-27 17:08:46.000000000 -0400
@@ -27,6 +27,8 @@
 extern void release_x86_irqs(struct task_struct *);
 extern int can_request_irq(unsigned int, unsigned long flags);
 
+#define get_irq_desc(irq) (&irq_desc[irq])
+
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
diff -urN linux-2.6.8-rc2/include/asm-i386/signal.h linux-2.6.8-rc2-irq-threads/include/asm-i386/signal.h
--- linux-2.6.8-rc2/include/asm-i386/signal.h	2004-07-27 17:06:26.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/include/asm-i386/signal.h	2004-07-27 17:08:46.000000000 -0400
@@ -122,6 +122,7 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+#define SA_NOTHREAD             0x01000000
 #endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN linux-2.6.8-rc2/include/linux/interrupt.h linux-2.6.8-rc2-irq-threads/include/linux/interrupt.h
--- linux-2.6.8-rc2/include/linux/interrupt.h	2004-07-27 17:06:26.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/include/linux/interrupt.h	2004-07-27 17:08:46.000000000 -0400
@@ -51,7 +51,7 @@
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
-#ifndef CONFIG_SMP
+#if !defined(CONFIG_SMP) && !defined(CONFIG_IRQ_THREADS)
 # define cli()			local_irq_disable()
 # define sti()			local_irq_enable()
 # define save_flags(x)		local_save_flags(x)
diff -urN linux-2.6.8-rc2/include/linux/irq.h linux-2.6.8-rc2-irq-threads/include/linux/irq.h
--- linux-2.6.8-rc2/include/linux/irq.h	2004-06-16 01:19:17.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/include/linux/irq.h	2004-07-27 17:08:46.000000000 -0400
@@ -23,15 +23,31 @@
 /*
  * IRQ line status.
  */
-#define IRQ_INPROGRESS	1	/* IRQ handler active - do not enter! */
-#define IRQ_DISABLED	2	/* IRQ disabled - do not enter! */
-#define IRQ_PENDING	4	/* IRQ pending - replay on enable */
-#define IRQ_REPLAY	8	/* IRQ has been replayed but not acked yet */
-#define IRQ_AUTODETECT	16	/* IRQ is being autodetected */
-#define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
-#define IRQ_LEVEL	64	/* IRQ level triggered */
-#define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
-#define IRQ_PER_CPU	256	/* IRQ is per CPU */
+#define IRQ_INPROGRESS     1    /* IRQ handler active - do not enter! */
+#define IRQ_DISABLED       2    /* IRQ disabled - do not enter! */
+#define IRQ_PENDING        4    /* IRQ pending - replay on enable */
+#define IRQ_REPLAY         8    /* IRQ has been replayed but not acked yet */
+#define IRQ_AUTODETECT     16   /* IRQ is being autodetected */
+#define IRQ_WAITING        32   /* IRQ not yet seen - for autodetection */
+#define IRQ_LEVEL          64   /* IRQ level triggered */
+#define IRQ_MASKED         128  /* IRQ masked - shouldn't be seen again */
+#define IRQ_PER_CPU        256  /* IRQ is per CPU */
+#define IRQ_THREAD         512  /* IRQ has at least one threaded handler */
+#define IRQ_NOTHREAD       1024 /* IRQ has at least one nonthreaded handler */
+#define IRQ_THREADPENDING  2048 /* IRQ thread has been woken */
+#define IRQ_THREADRUNNING  4096 /* IRQ thread is currently running */
+
+/* Nobody has yet handled this IRQ.  This is set when ack() is called,
+   and checked when end() is called.  It is done this way to accomodate
+   threaded and non-threaded IRQs sharing the same IRQ. */
+
+#define IRQ_UNHANDLED      8192
+
+/* The interrupt is supposed to be enabled, but the IRQ thread hasn't
+   been spawned yet.  Call desc->handler->startup() once the thread
+   has been spawned. */
+
+#define IRQ_DELAYEDSTARTUP 16384
 
 /*
  * Interrupt controller descriptor. This is all we need
@@ -65,6 +81,10 @@
 	unsigned int irq_count;		/* For detecting broken interrupts */
 	unsigned int irqs_unhandled;
 	spinlock_t lock;
+#ifdef CONFIG_IRQ_THREADS
+	struct task_struct *thread;
+	wait_queue_head_t sync;
+#endif
 } ____cacheline_aligned irq_desc_t;
 
 extern irq_desc_t irq_desc [NR_IRQS];
@@ -75,6 +95,36 @@
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
 
+#ifdef CONFIG_IRQ_THREADS
+
+void spawn_irq_threads(void);
+void setup_irq_spawn_thread(unsigned int irq, struct irqaction *new);
+unsigned int do_startup_irq(unsigned int irq);
+void do_shutdown_irq(unsigned int irq);
+
+#else
+
+static inline void spawn_irq_threads(void)
+{
+}
+
+static inline void setup_irq_spawn_thread(unsigned int irq,
+                                          struct irqaction *new)
+{
+}
+
+static inline unsigned int do_startup_irq(int irq)
+{
+	return get_irq_desc(irq)->handler->startup(irq);
+}
+
+static inline void do_shutdown_irq(int irq)
+{
+	get_irq_desc(irq)->handler->shutdown(irq);
+}
+
+#endif
+
 #endif
 
 #endif /* __irq_h */
diff -urN linux-2.6.8-rc2/include/linux/sched.h linux-2.6.8-rc2-irq-threads/include/linux/sched.h
--- linux-2.6.8-rc2/include/linux/sched.h	2004-07-27 17:06:26.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/include/linux/sched.h	2004-07-27 17:08:46.000000000 -0400
@@ -555,6 +555,7 @@
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_IRQHANDLER   0x00400000      /* in_irq() should return true */
 
 #ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
diff -urN linux-2.6.8-rc2/init/Kconfig linux-2.6.8-rc2-irq-threads/init/Kconfig
--- linux-2.6.8-rc2/init/Kconfig	2004-07-27 17:06:26.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/init/Kconfig	2004-07-27 17:08:46.000000000 -0400
@@ -294,6 +294,18 @@
 
 	  If unsure, say N.
 
+config IRQ_THREADS
+  bool "Run all IRQs in threads by default"
+  depends on PREEMPT
+  help
+    This option creates a thread for each IRQ, which runs at high
+    real-time priority, unless the SA_NOTHREAD option is passed to
+    request_irq().  This allows these IRQs to be prioritized, so as
+    to avoid preempting very high priority real-time tasks.  This
+    also allows spinlocks used by threaded IRQs to be converted
+    into sleeping mutexes, for further reduction of latency (however,
+    this is not done automatically).
+
 endmenu		# General setup
 
 
diff -urN linux-2.6.8-rc2/init/main.c linux-2.6.8-rc2-irq-threads/init/main.c
--- linux-2.6.8-rc2/init/main.c	2004-07-27 17:06:26.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/init/main.c	2004-07-27 17:08:46.000000000 -0400
@@ -668,6 +668,8 @@
 	smp_init();
 	sched_init_smp();
 
+	spawn_irq_threads();
+
 	/*
 	 * Do this before initcalls, because some drivers want to access
 	 * firmware files.
diff -urN linux-2.6.8-rc2/kernel/Makefile linux-2.6.8-rc2-irq-threads/kernel/Makefile
--- linux-2.6.8-rc2/kernel/Makefile	2004-07-27 17:06:26.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/kernel/Makefile	2004-07-27 17:08:46.000000000 -0400
@@ -23,6 +23,7 @@
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_IRQ_THREADS) += irq.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urN linux-2.6.8-rc2/kernel/irq.c linux-2.6.8-rc2-irq-threads/kernel/irq.c
--- linux-2.6.8-rc2/kernel/irq.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8-rc2-irq-threads/kernel/irq.c	2004-07-27 17:08:46.000000000 -0400
@@ -0,0 +1,232 @@
+/*
+ *	linux/kernel/irq.c -- Generic code for threaded IRQ handling
+ *
+ *	Copyright (C) 2001-2004 TimeSys Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/completion.h>
+#include <linux/syscalls.h>
+#include <linux/random.h>
+
+#include <asm/uaccess.h>
+
+static const int irq_prio = MAX_USER_RT_PRIO - 2;
+
+static inline void synchronize_hard_irq(unsigned int irq)
+{
+#ifdef CONFIG_SMP
+	while (get_irq_desc(irq)->status & IRQ_INPROGRESS)
+		cpu_relax();
+#endif
+}
+
+void synchronize_irq(unsigned int irq)
+{
+	irq_desc_t *desc = get_irq_desc(irq);
+	
+	synchronize_hard_irq(irq);
+	
+	if (desc->thread)
+		wait_event(desc->sync, !(desc->status & IRQ_THREADRUNNING));
+}
+
+typedef struct {
+	struct completion comp;
+	int irq;
+} irq_thread_info;
+
+static int run_irq_thread(void *__info)
+{
+	irq_thread_info *info = __info;
+	int irq = info->irq;
+	struct sched_param param = { .sched_priority = irq_prio };
+	irq_desc_t *desc = get_irq_desc(irq);
+	
+	daemonize("IRQ %d", irq);
+	
+	set_fs(KERNEL_DS);
+	sys_sched_setscheduler(0, SCHED_FIFO, &param);
+	
+	current->flags |= PF_IRQHANDLER | PF_NOFREEZE;
+	
+	init_waitqueue_head(&desc->sync);
+	smp_wmb();
+	desc->thread = current;
+	
+	spin_lock_irq(&desc->lock);
+	
+	if (desc->status & IRQ_DELAYEDSTARTUP) {
+		desc->status &= ~IRQ_DELAYEDSTARTUP;
+		do_startup_irq(irq);
+	}
+	
+	spin_unlock_irq(&desc->lock);
+	
+	/* info is no longer valid after this... */
+	complete(&info->comp);
+	
+	for (;;) {
+		struct irqaction *action;
+		int status, retval;
+		
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		while (!(desc->status & IRQ_THREADPENDING))
+			schedule();
+		
+		set_current_state(TASK_RUNNING);
+
+		spin_lock_irq(&desc->lock);
+		
+		desc->status |= IRQ_THREADRUNNING;
+		desc->status &= ~IRQ_THREADPENDING;
+		status = desc->status;
+		
+		spin_unlock_irq(&desc->lock);
+		
+		retval = 0;
+		
+		if (!(status & IRQ_DISABLED)) {
+			action = desc->action;
+
+			while (action) {
+				if (!(action->flags & SA_NOTHREAD)) {
+					status |= action->flags;
+					retval |= action->handler(irq, action->dev_id, NULL);
+				}
+				
+				action = action->next;
+			}
+		}
+
+		if (status & SA_SAMPLE_RANDOM)
+			add_interrupt_randomness(irq);
+
+		spin_lock_irq(&desc->lock);
+		
+		
+		desc->status &= ~IRQ_THREADRUNNING;
+		if (!(desc->status & (IRQ_DISABLED | IRQ_INPROGRESS |
+				      IRQ_THREADPENDING | IRQ_THREADRUNNING))) {
+		  desc->handler->end(irq);
+		}
+		
+		spin_unlock_irq(&desc->lock);
+		
+		if (waitqueue_active(&desc->sync))
+			wake_up(&desc->sync);
+	}
+}
+
+static int ok_to_spawn_threads;
+
+void do_spawn_irq_thread(int irq)
+{
+	irq_thread_info info;
+	
+	info.irq = irq;
+	init_completion(&info.comp);
+
+	if (kernel_thread(run_irq_thread, &info, CLONE_KERNEL) < 0) {
+		printk(KERN_EMERG "Could not spawn thread for IRQ %d\n", irq);
+	} else {
+		wait_for_completion(&info.comp);
+	}
+}
+
+void setup_irq_spawn_thread(unsigned int irq, struct irqaction *new)
+{
+	irq_desc_t *desc = get_irq_desc(irq);
+	int spawn_thread = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	
+	if (new->flags & SA_NOTHREAD) {
+		desc->status |= IRQ_NOTHREAD;
+	} else {
+		/* Only the first threaded handler should spawn
+		   a thread. */
+
+		if (!(desc->status & IRQ_THREAD)) {
+			spawn_thread = 1;
+			desc->status |= IRQ_THREAD;
+		}
+	}
+
+	spin_unlock_irqrestore(&desc->lock, flags);
+	
+	if (ok_to_spawn_threads && spawn_thread)
+		do_spawn_irq_thread(irq);
+}
+
+
+/* This takes care of interrupts that were requested before the
+   scheduler was ready for threads to be created. */
+
+void spawn_irq_threads(void)
+{
+	int i;
+	
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = get_irq_desc(i);
+	
+		if (desc->action && !desc->thread && (desc->status & IRQ_THREAD))
+			do_spawn_irq_thread(i);
+	}
+	
+	ok_to_spawn_threads = 1;
+}
+
+/*
+ * Workarounds for interrupt types without startup()/shutdown() (ppc, ppc64).
+ * Will be removed some day.
+ */
+
+unsigned int do_startup_irq(unsigned int irq)
+{
+	irq_desc_t *desc = get_irq_desc(irq);
+
+	if ((desc->status & IRQ_THREAD) && !desc->thread) {
+		/* The IRQ threads haven't been spawned yet.  Don't
+		   turn on the IRQ until that happens. */
+		
+		desc->status |= IRQ_DELAYEDSTARTUP;
+		return 0;
+	}
+
+	if (desc->handler->startup)
+		return desc->handler->startup(irq);
+	else if (desc->handler->enable)
+		desc->handler->enable(irq);
+	else 
+		BUG();
+
+	return 0;
+}
+
+void do_shutdown_irq(unsigned int irq)
+{
+	irq_desc_t *desc = get_irq_desc(irq);
+
+	if (desc->status & IRQ_DELAYEDSTARTUP) {
+		desc->status &= ~IRQ_DELAYEDSTARTUP;
+		return;
+	}
+
+	if (desc->handler->shutdown)
+		desc->handler->shutdown(irq);
+	else if (desc->handler->disable)
+		desc->handler->disable(irq);
+	else 
+		BUG();
+}
