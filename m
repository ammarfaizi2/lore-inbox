Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267337AbUG1X0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267337AbUG1X0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUG1XUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:20:11 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:1231 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266780AbUG1XMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:12:51 -0400
Date: Wed, 28 Jul 2004 19:12:41 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728231241.GE6685@yoda.timesys>
References: <20040727225040.GA4370@yoda.timesys> <20040728081005.GA20100@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728081005.GA20100@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 10:10:05AM +0200, Ingo Molnar wrote:
> i'm wondering about a couple of details. Why were the changes to
> note_interrupt() necessary?

The intent was to defer the calling of note_interrupt() until after
all handlers (threaded and non-threaded) had run.  However, it's
probably not strictly necessary, as it requires the vast majority of
IRQs to be unhandled (whereas threads will only give you 50%).

It might be nice to add a note_interrupt() to the no-action case as
well, in case an interrupt with no handlers at all fails to be masked
properly.

Oh, and the calling of report_bad_irq() seems to have disappeared
from run_irq_thread in that patch; there should be a:

if (!noirqdebug) {
	if (retval == IRQ_HANDLED)
		desc->status &= ~IRQ_UNHANDLED;
	else
		report_bad_irq(irq, desc, retval);
}

before the "desc->status &= ~IRQ_THREADRUNNING;" line in
kernel/irq.c.

> Also, why the enable_irq() change? 

If you mean the do_startup_irq() change, it was mainly to manage the
IRQ_DELAYEDSTARTUP flag, which prevents an IRQ from being unmasked
before the thread has been created (or more accurately, reminds
run_irq_thread to call do_startup_irq()).

> What do you think about the simpler approach in my patch which
> keeps the irq masked until the thread runs?

That way works as well (the desc would just have IRQ_THREADPENDING
marked until the thread runs for the first time, if an IRQ does
happen before the thread starts).

I've attached a new version of the patch that eliminates the
note_interrupt() and startup/shutdown changes, adds the missing
note_interrupt to run_irq_thread(), and makes in_interrupt respond
positively to IRQ threads (it didn't do so in 2.4 because a lot of
places used in_interrupt as in_atomic, but that shouldn't be a
problem now, at least in core code).

Signed-off-by: Scott Wood <scott.wood@timesys.com> under TS0058.

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
+++ linux-2.6.8-rc2-irq-threads/arch/i386/kernel/irq.c	2004-07-28 18:35:26.000000000 -0400
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
@@ -268,7 +275,7 @@
 	}
 }
 
-static int noirqdebug;
+int noirqdebug;
 
 static int __init noirqdebug_setup(char *str)
 {
@@ -289,7 +296,7 @@
  *
  * Called under desc->lock
  */
-static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
 {
 	if (action_ret != IRQ_HANDLED) {
 		desc->irqs_unhandled++;
@@ -395,7 +402,14 @@
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
@@ -408,12 +422,7 @@
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
@@ -425,27 +434,11 @@
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
@@ -461,7 +454,8 @@
 	 * use the action we have.
 	 */
 	action = NULL;
-	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
+	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS |
+	                       IRQ_THREADPENDING | IRQ_THREADRUNNING)))) {
 		action = desc->action;
 		status &= ~IRQ_PENDING; /* we commit to handling */
 		status |= IRQ_INPROGRESS; /* we are handling it */
@@ -487,89 +481,111 @@
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
 
+#ifdef CONFIG_IRQ_THREADS
+		if (desc->status & IRQ_THREAD) {
+			desc->status |= IRQ_THREADPENDING;
+			
+			if (desc->thread)
+				wake_up_process(desc->thread);
+		}
+		
+		if (desc->status & IRQ_NOTHREAD)
+#endif
+		{
+			spin_unlock(&desc->lock);
+			action_ret = handle_IRQ_event(irq, regs, action);
+			spin_lock(&desc->lock);
 
+			if (!noirqdebug)
+				note_interrupt(irq, desc, action_ret);
 		}
-		spin_lock(&desc->lock);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
-		if (curctx != irqctx)
-			irqctx->tinfo.task = NULL;
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
+	if (!(desc->status & (IRQ_THREADPENDING | IRQ_THREADRUNNING)))
+		desc->handler->end(irq);
+	spin_unlock(&desc->lock);
+}
 
-		spin_unlock(&desc->lock);
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
 
-		action_ret = handle_IRQ_event(irq, &regs, action);
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+	/* Debugging check for stack overflow: is there less than 1KB free? */
+	{
+		long esp;
 
-		spin_lock(&desc->lock);
-		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
-		if (likely(!(desc->status & IRQ_PENDING)))
-			break;
-		desc->status &= ~IRQ_PENDING;
+		asm volatile("andl %%esp,%0" :
+		             "=r" (esp) : "0" (THREAD_SIZE - 1));
+
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
@@ -943,6 +959,8 @@
 		rand_initialize_irq(irq);
 	}
 
+	setup_irq_spawn_thread(irq, new);
+
 	/*
 	 * The following block of code has to be executed atomically
 	 */
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
+++ linux-2.6.8-rc2-irq-threads/include/asm-i386/hardirq.h	2004-07-28 18:30:48.000000000 -0400
@@ -64,10 +64,19 @@
  * Are we doing bottom half or hardware interrupt processing?
  * Are we in a softirq context? Interrupt context?
  */
+#ifdef CONFIG_IRQ_THREADS
+#define in_irq() (hardirq_count() || (current->flags & PF_IRQHANDLER))
+#else
 #define in_irq()		(hardirq_count())
+#endif
+
 #define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
 
+#ifdef CONFIG_IRQ_THREADS
+#define in_interrupt() (irq_count() || (current->flags & PF_IRQHANDLER))
+#else
+#define in_interrupt()		(irq_count())
+#endif
 
 #define hardirq_trylock()	(!in_interrupt())
 #define hardirq_endlock()	do { } while (0)
@@ -92,7 +101,7 @@
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
+++ linux-2.6.8-rc2-irq-threads/include/linux/interrupt.h	2004-07-28 18:40:19.000000000 -0400
@@ -51,7 +51,7 @@
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
-#ifndef CONFIG_SMP
+#if !defined(CONFIG_SMP) && !defined(CONFIG_IRQ_THREADS)
 # define cli()			local_irq_disable()
 # define sti()			local_irq_enable()
 # define save_flags(x)		local_save_flags(x)
@@ -247,4 +247,15 @@
 extern int probe_irq_off(unsigned long);	/* returns 0 or negative on failure */
 extern unsigned int probe_irq_mask(unsigned long);	/* returns mask of ISA interrupts */
 
+#ifdef CONFIG_IRQ_THREADS
+
+/* This is under CONFIG_IRQ_THREADS for now, so it doesn't break other
+   architectures where it's still static.  It has to be here rather
+   than in irq.h, because it depends on irqreturn_t, and including
+   this file from irq.h apparently causes a loop. */
+
+void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret);
+extern int noirqdebug;
+
+#endif
 #endif
diff -urN linux-2.6.8-rc2/include/linux/irq.h linux-2.6.8-rc2-irq-threads/include/linux/irq.h
--- linux-2.6.8-rc2/include/linux/irq.h	2004-06-16 01:19:17.000000000 -0400
+++ linux-2.6.8-rc2-irq-threads/include/linux/irq.h	2004-07-28 18:40:29.000000000 -0400
@@ -23,15 +23,19 @@
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
 
 /*
  * Interrupt controller descriptor. This is all we need
@@ -65,6 +69,10 @@
 	unsigned int irq_count;		/* For detecting broken interrupts */
 	unsigned int irqs_unhandled;
 	spinlock_t lock;
+#ifdef CONFIG_IRQ_THREADS
+	struct task_struct *thread;
+	wait_queue_head_t sync;
+#endif
 } ____cacheline_aligned irq_desc_t;
 
 extern irq_desc_t irq_desc [NR_IRQS];
@@ -75,6 +83,24 @@
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
 
+#ifdef CONFIG_IRQ_THREADS
+
+void spawn_irq_threads(void);
+void setup_irq_spawn_thread(unsigned int irq, struct irqaction *new);
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
+++ linux-2.6.8-rc2-irq-threads/kernel/irq.c	2004-07-28 18:41:03.000000000 -0400
@@ -0,0 +1,179 @@
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
+		if (!(status & IRQ_DISABLED))	{
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
+		if (!noirqdebug)
+			note_interrupt(irq, desc, retval);
+		
+		desc->status &= ~IRQ_THREADRUNNING;
+		if (!(desc->status & (IRQ_THREADPENDING | IRQ_THREADRUNNING)))
+			desc->handler->end(irq);
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
