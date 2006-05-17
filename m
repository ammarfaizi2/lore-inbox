Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWEQA1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWEQA1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWEQA0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:26:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64720 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932339AbWEQARn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:43 -0400
Date: Wed, 17 May 2006 02:17:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 26/50] genirq: ARM: core: switch irq handling to the generic implementation
Message-ID: <20060517001715.GA12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Switch the ARM irq core handling to the generic implementation. The
ARM specific header files now contain mostly migration stubs and
helper macros. Note that each machine type must be converted after
this step seperately. This was seperated out from the patch for easier
review.

The main changes for the machine type code is the conversion of the
type handlers to a 'type flow' and 'chip' model. This affects only the
multiplex interrupt handlers. A conversion macro needs to be added to
those implementations, which defines the data structure which is
registered by the set_irq_chained_handler() macro.

Some minor fixups of include files and the conversion of data
structure access is necessary all over the place.

The mostly macro based conversion was provided to allow an easy
migration of the existing implementations.

The code compiles on all defconfigs available in arch/arm/configs
except those which were broken also before applying the conversion
patches.

The code has been boot and runtime tested on following platforms:

PXA, EP93XX, IPX2000, IPX400, IMX, CLPS711X, H720X, S3C2410, OMAP.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/Kconfig           |   12 
 arch/arm/kernel/fiq.c      |    1 
 arch/arm/kernel/irq.c      |  959 ++-------------------------------------------
 include/asm-arm/dyntick.h  |    6 
 include/asm-arm/hw_irq.h   |    9 
 include/asm-arm/irq.h      |   26 -
 include/asm-arm/mach/irq.h |  143 +-----
 7 files changed, 128 insertions(+), 1028 deletions(-)

Index: linux-genirq.q/arch/arm/Kconfig
===================================================================
--- linux-genirq.q.orig/arch/arm/Kconfig
+++ linux-genirq.q/arch/arm/Kconfig
@@ -47,6 +47,18 @@ config MCA
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
+config GENERIC_HARDIRQS
+	bool
+	default y
+
+config HARDIRQS_SW_RESEND
+	bool
+	default y
+
+config GENERIC_IRQ_PROBE
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: linux-genirq.q/arch/arm/kernel/fiq.c
===================================================================
--- linux-genirq.q.orig/arch/arm/kernel/fiq.c
+++ linux-genirq.q/arch/arm/kernel/fiq.c
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/seq_file.h>
 
 #include <asm/cacheflush.h>
Index: linux-genirq.q/arch/arm/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/arm/kernel/irq.c
+++ linux-genirq.q/arch/arm/kernel/irq.c
@@ -27,6 +27,7 @@
 #include <linux/signal.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/random.h>
@@ -38,192 +39,19 @@
 #include <linux/kallsyms.h>
 #include <linux/proc_fs.h>
 
-#include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
 /*
- * Maximum IRQ count.  Currently, this is arbitary.  However, it should
- * not be set too low to prevent false triggering.  Conversely, if it
- * is set too high, then you could miss a stuck IRQ.
- *
- * Maybe we ought to set a timer and re-enable the IRQ at a later time?
- */
-#define MAX_IRQ_CNT	100000
-
-static int noirqdebug;
-static volatile unsigned long irq_err_count;
-static DEFINE_SPINLOCK(irq_controller_lock);
-static LIST_HEAD(irq_pending);
-
-struct irqdesc irq_desc[NR_IRQS];
-void (*init_arch_irq)(void) __initdata = NULL;
-
-/*
  * No architecture-specific irq_finish function defined in arm/arch/irqs.h.
  */
 #ifndef irq_finish
 #define irq_finish(irq) do { } while (0)
 #endif
 
-/*
- * Dummy mask/unmask handler
- */
-void dummy_mask_unmask_irq(unsigned int irq)
-{
-}
-
-irqreturn_t no_action(int irq, void *dev_id, struct pt_regs *regs)
-{
-	return IRQ_NONE;
-}
-
-void do_bad_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
-{
-	irq_err_count += 1;
-	printk(KERN_ERR "IRQ: spurious interrupt %d\n", irq);
-}
-
-static struct irqchip bad_chip = {
-	.ack	= dummy_mask_unmask_irq,
-	.mask	= dummy_mask_unmask_irq,
-	.unmask = dummy_mask_unmask_irq,
-};
-
-static struct irqdesc bad_irq_desc = {
-	.chip		= &bad_chip,
-	.handle		= do_bad_IRQ,
-	.pend		= LIST_HEAD_INIT(bad_irq_desc.pend),
-	.disable_depth	= 1,
-};
-
-#ifdef CONFIG_SMP
-void synchronize_irq(unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-
-	while (desc->running)
-		barrier();
-}
-EXPORT_SYMBOL(synchronize_irq);
-
-#define smp_set_running(desc)	do { desc->running = 1; } while (0)
-#define smp_clear_running(desc)	do { desc->running = 0; } while (0)
-#else
-#define smp_set_running(desc)	do { } while (0)
-#define smp_clear_running(desc)	do { } while (0)
-#endif
-
-/**
- *	disable_irq_nosync - disable an irq without waiting
- *	@irq: Interrupt to disable
- *
- *	Disable the selected interrupt line.  Enables and disables
- *	are nested.  We do this lazily.
- *
- *	This function may be called from IRQ context.
- */
-void disable_irq_nosync(unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	desc->disable_depth++;
-	list_del_init(&desc->pend);
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-EXPORT_SYMBOL(disable_irq_nosync);
-
-/**
- *	disable_irq - disable an irq and wait for completion
- *	@irq: Interrupt to disable
- *
- *	Disable the selected interrupt line.  Enables and disables
- *	are nested.  This functions waits for any pending IRQ
- *	handlers for this interrupt to complete before returning.
- *	If you use this function while holding a resource the IRQ
- *	handler may need you will deadlock.
- *
- *	This function may be called - with care - from IRQ context.
- */
-void disable_irq(unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-
-	disable_irq_nosync(irq);
-	if (desc->action)
-		synchronize_irq(irq);
-}
-EXPORT_SYMBOL(disable_irq);
-
-/**
- *	enable_irq - enable interrupt handling on an irq
- *	@irq: Interrupt to enable
- *
- *	Re-enables the processing of interrupts on this IRQ line.
- *	Note that this may call the interrupt handler, so you may
- *	get unexpected results if you hold IRQs disabled.
- *
- *	This function may be called from IRQ context.
- */
-void enable_irq(unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	if (unlikely(!desc->disable_depth)) {
-		printk("enable_irq(%u) unbalanced from %p\n", irq,
-			__builtin_return_address(0));
-	} else if (!--desc->disable_depth) {
-		desc->probing = 0;
-		desc->chip->unmask(irq);
-
-		/*
-		 * If the interrupt is waiting to be processed,
-		 * try to re-run it.  We can't directly run it
-		 * from here since the caller might be in an
-		 * interrupt-protected region.
-		 */
-		if (desc->pending && list_empty(&desc->pend)) {
-			desc->pending = 0;
-			if (!desc->chip->retrigger ||
-			    desc->chip->retrigger(irq))
-				list_add(&desc->pend, &irq_pending);
-		}
-	}
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-EXPORT_SYMBOL(enable_irq);
-
-/*
- * Enable wake on selected irq
- */
-void enable_irq_wake(unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	if (desc->chip->set_wake)
-		desc->chip->set_wake(irq, 1);
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-EXPORT_SYMBOL(enable_irq_wake);
-
-void disable_irq_wake(unsigned int irq)
-{
-	struct irqdesc *desc = irq_desc + irq;
-	unsigned long flags;
+void (*init_arch_irq)(void) __initdata = NULL;
 
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	if (desc->chip->set_wake)
-		desc->chip->set_wake(irq, 0);
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-EXPORT_SYMBOL(disable_irq_wake);
+unsigned long irq_err_count;
 
 int show_interrupts(struct seq_file *p, void *v)
 {
@@ -243,8 +71,8 @@ int show_interrupts(struct seq_file *p, 
 	}
 
 	if (i < NR_IRQS) {
-		spin_lock_irqsave(&irq_controller_lock, flags);
-	    	action = irq_desc[i].action;
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		action = irq_desc[i].action;
 		if (!action)
 			goto unlock;
 
@@ -257,7 +85,7 @@ int show_interrupts(struct seq_file *p, 
 
 		seq_putc(p, '\n');
 unlock:
-		spin_unlock_irqrestore(&irq_controller_lock, flags);
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	} else if (i == NR_IRQS) {
 #ifdef CONFIG_ARCH_ACORN
 		show_fiq_list(p, v);
@@ -271,270 +99,16 @@ unlock:
 	return 0;
 }
 
-/*
- * IRQ lock detection.
- *
- * Hopefully, this should get us out of a few locked situations.
- * However, it may take a while for this to happen, since we need
- * a large number if IRQs to appear in the same jiffie with the
- * same instruction pointer (or within 2 instructions).
- */
-static int check_irq_lock(struct irqdesc *desc, int irq, struct pt_regs *regs)
-{
-	unsigned long instr_ptr = instruction_pointer(regs);
 
-	if (desc->lck_jif == jiffies &&
-	    desc->lck_pc >= instr_ptr && desc->lck_pc < instr_ptr + 8) {
-		desc->lck_cnt += 1;
-
-		if (desc->lck_cnt > MAX_IRQ_CNT) {
-			printk(KERN_ERR "IRQ LOCK: IRQ%d is locking the system, disabled\n", irq);
-			return 1;
-		}
-	} else {
-		desc->lck_cnt = 0;
-		desc->lck_pc  = instruction_pointer(regs);
-		desc->lck_jif = jiffies;
-	}
-	return 0;
-}
-
-static void
-report_bad_irq(unsigned int irq, struct pt_regs *regs, struct irqdesc *desc, int ret)
-{
-	static int count = 100;
-	struct irqaction *action;
-
-	if (noirqdebug)
-		return;
 
-	if (ret != IRQ_HANDLED && ret != IRQ_NONE) {
-		if (!count)
-			return;
-		count--;
-		printk("irq%u: bogus retval mask %x\n", irq, ret);
-	} else {
-		desc->irqs_unhandled++;
-		if (desc->irqs_unhandled <= 99900)
-			return;
-		desc->irqs_unhandled = 0;
-		printk("irq%u: nobody cared\n", irq);
-	}
-	show_regs(regs);
-	dump_stack();
-	printk(KERN_ERR "handlers:");
-	action = desc->action;
-	do {
-		printk("\n" KERN_ERR "[<%p>]", action->handler);
-		print_symbol(" (%s)", (unsigned long)action->handler);
-		action = action->next;
-	} while (action);
-	printk("\n");
-}
-
-static int
-__do_irq(unsigned int irq, struct irqaction *action, struct pt_regs *regs)
-{
-	unsigned int status;
-	int ret, retval = 0;
-
-	spin_unlock(&irq_controller_lock);
-
-#ifdef CONFIG_NO_IDLE_HZ
-	if (!(action->flags & SA_TIMER) && system_timer->dyn_tick != NULL) {
-		write_seqlock(&xtime_lock);
-		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)
-			system_timer->dyn_tick->handler(irq, 0, regs);
-		write_sequnlock(&xtime_lock);
-	}
-#endif
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	status = 0;
-	do {
-		ret = action->handler(irq, action->dev_id, regs);
-		if (ret == IRQ_HANDLED)
-			status |= action->flags;
-		retval |= ret;
-		action = action->next;
-	} while (action);
-
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-
-	spin_lock_irq(&irq_controller_lock);
-
-	return retval;
-}
-
-/*
- * This is for software-decoded IRQs.  The caller is expected to
- * handle the ack, clear, mask and unmask issues.
- */
-void
-do_simple_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
-{
-	struct irqaction *action;
-	const unsigned int cpu = smp_processor_id();
-
-	desc->triggered = 1;
-
-	kstat_cpu(cpu).irqs[irq]++;
-
-	smp_set_running(desc);
-
-	action = desc->action;
-	if (action) {
-		int ret = __do_irq(irq, action, regs);
-		if (ret != IRQ_HANDLED)
-			report_bad_irq(irq, regs, desc, ret);
-	}
-
-	smp_clear_running(desc);
-}
-
-/*
- * Most edge-triggered IRQ implementations seem to take a broken
- * approach to this.  Hence the complexity.
- */
-void
-do_edge_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
-{
-	const unsigned int cpu = smp_processor_id();
-
-	desc->triggered = 1;
-
-	/*
-	 * If we're currently running this IRQ, or its disabled,
-	 * we shouldn't process the IRQ.  Instead, turn on the
-	 * hardware masks.
-	 */
-	if (unlikely(desc->running || desc->disable_depth))
-		goto running;
-
-	/*
-	 * Acknowledge and clear the IRQ, but don't mask it.
-	 */
-	desc->chip->ack(irq);
-
-	/*
-	 * Mark the IRQ currently in progress.
-	 */
-	desc->running = 1;
-
-	kstat_cpu(cpu).irqs[irq]++;
-
-	do {
-		struct irqaction *action;
-
-		action = desc->action;
-		if (!action)
-			break;
-
-		if (desc->pending && !desc->disable_depth) {
-			desc->pending = 0;
-			desc->chip->unmask(irq);
-		}
-
-		__do_irq(irq, action, regs);
-	} while (desc->pending && !desc->disable_depth);
-
-	desc->running = 0;
-
-	/*
-	 * If we were disabled or freed, shut down the handler.
-	 */
-	if (likely(desc->action && !check_irq_lock(desc, irq, regs)))
-		return;
-
- running:
-	/*
-	 * We got another IRQ while this one was masked or
-	 * currently running.  Delay it.
-	 */
-	desc->pending = 1;
-	desc->chip->mask(irq);
-	desc->chip->ack(irq);
-}
-
-/*
- * Level-based IRQ handler.  Nice and simple.
- */
-void
-do_level_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
-{
-	struct irqaction *action;
-	const unsigned int cpu = smp_processor_id();
-
-	desc->triggered = 1;
-
-	/*
-	 * Acknowledge, clear _AND_ disable the interrupt.
-	 */
-	desc->chip->ack(irq);
-
-	if (likely(!desc->disable_depth)) {
-		kstat_cpu(cpu).irqs[irq]++;
-
-		smp_set_running(desc);
-
-		/*
-		 * Return with this interrupt masked if no action
-		 */
-		action = desc->action;
-		if (action) {
-			int ret = __do_irq(irq, desc->action, regs);
-
-			if (ret != IRQ_HANDLED)
-				report_bad_irq(irq, regs, desc, ret);
-
-			if (likely(!desc->disable_depth &&
-				   !check_irq_lock(desc, irq, regs)))
-				desc->chip->unmask(irq);
-		}
-
-		smp_clear_running(desc);
-	}
-}
-
-static void do_pending_irqs(struct pt_regs *regs)
-{
-	struct list_head head, *l, *n;
-
-	do {
-		struct irqdesc *desc;
-
-		/*
-		 * First, take the pending interrupts off the list.
-		 * The act of calling the handlers may add some IRQs
-		 * back onto the list.
-		 */
-		head = irq_pending;
-		INIT_LIST_HEAD(&irq_pending);
-		head.next->prev = &head;
-		head.prev->next = &head;
-
-		/*
-		 * Now run each entry.  We must delete it from our
-		 * list before calling the handler.
-		 */
-		list_for_each_safe(l, n, &head) {
-			desc = list_entry(l, struct irqdesc, pend);
-			list_del_init(&desc->pend);
-			desc_handle_irq(desc - irq_desc, desc, regs);
-		}
-
-		/*
-		 * The list must be empty.
-		 */
-		BUG_ON(!list_empty(&head));
-	} while (!list_empty(&irq_pending));
-}
+/* Handle bad interrupts */
+static struct irq_desc bad_irq_desc = {
+	.handle = handle_bad_irq,
+	.lock = SPIN_LOCK_UNLOCKED
+};
 
 /*
- * do_IRQ handles all hardware IRQ's.  Decoded IRQs should not
+ * asm_do_IRQ handles all hardware IRQ's.  Decoded IRQs should not
  * come via this function.  Instead, they should provide their
  * own 'handler'
  */
@@ -550,95 +124,58 @@ asmlinkage void asm_do_IRQ(unsigned int 
 		desc = &bad_irq_desc;
 
 	irq_enter();
-	spin_lock(&irq_controller_lock);
-	desc_handle_irq(irq, desc, regs);
 
-	/*
-	 * Now re-run any pending interrupts.
-	 */
-	if (!list_empty(&irq_pending))
-		do_pending_irqs(regs);
+	desc_handle_irq(irq, desc, regs);
 
+	/* AT91 specific workaround */
 	irq_finish(irq);
 
-	spin_unlock(&irq_controller_lock);
 	irq_exit();
 }
 
-void __set_irq_handler(unsigned int irq, irq_handler_t handle, int is_chained)
+void
+__set_irq_handler(unsigned int irq,
+		  void (*handle)(unsigned int, irq_desc_t*, struct pt_regs*),
+		  int is_chained)
 {
 	struct irqdesc *desc;
 	unsigned long flags;
 
 	if (irq >= NR_IRQS) {
-		printk(KERN_ERR "Trying to install handler for IRQ%d\n", irq);
+		printk(KERN_ERR
+		       "Trying to install type control for IRQ%d\n", irq);
 		return;
 	}
 
-	if (handle == NULL)
-		handle = do_bad_IRQ;
-
 	desc = irq_desc + irq;
 
-	if (is_chained && desc->chip == &bad_chip)
-		printk(KERN_WARNING "Trying to install chained handler for IRQ%d\n", irq);
+	if (!handle)
+		handle = handle_bad_irq;
 
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	if (handle == do_bad_IRQ) {
-		desc->chip->mask(irq);
-		desc->chip->ack(irq);
-		desc->disable_depth = 1;
+	if (is_chained && desc->handler == &no_irq_chip)
+		printk(KERN_WARNING "Trying to install "
+		       "chained interrupt type for IRQ%d\n", irq);
+
+	spin_lock_irqsave(&desc->lock, flags);
+
+	/* Uninstall ? */
+	if (handle == handle_bad_irq) {
+		if (desc->handler != &no_irq_chip) {
+			desc->handler->mask(irq);
+			desc->handler->ack(irq);
+		}
+		desc->depth = 1;
 	}
 	desc->handle = handle;
-	if (handle != do_bad_IRQ && is_chained) {
-		desc->valid = 0;
-		desc->probe_ok = 0;
-		desc->disable_depth = 0;
-		desc->chip->unmask(irq);
-	}
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-
-void set_irq_chip(unsigned int irq, struct irqchip *chip)
-{
-	struct irqdesc *desc;
-	unsigned long flags;
-
-	if (irq >= NR_IRQS) {
-		printk(KERN_ERR "Trying to install chip for IRQ%d\n", irq);
-		return;
-	}
-
-	if (chip == NULL)
-		chip = &bad_chip;
-
-	desc = irq_desc + irq;
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	desc->chip = chip;
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
 
-int set_irq_type(unsigned int irq, unsigned int type)
-{
-	struct irqdesc *desc;
-	unsigned long flags;
-	int ret = -ENXIO;
-
-	if (irq >= NR_IRQS) {
-		printk(KERN_ERR "Trying to set irq type for IRQ%d\n", irq);
-		return -ENODEV;
+	spin_lock_irqsave(&desc->lock, flags);
+	if (handle != handle_bad_irq && is_chained) {
+		desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE;
+		desc->depth = 0;
+		desc->handler->unmask(irq);
 	}
-
-	desc = irq_desc + irq;
-	if (desc->chip->set_type) {
-		spin_lock_irqsave(&irq_controller_lock, flags);
-		ret = desc->chip->set_type(irq, type);
-		spin_unlock_irqrestore(&irq_controller_lock, flags);
-	}
-
-	return ret;
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
-EXPORT_SYMBOL(set_irq_type);
 
 void set_irq_flags(unsigned int irq, unsigned int iflags)
 {
@@ -651,421 +188,31 @@ void set_irq_flags(unsigned int irq, uns
 	}
 
 	desc = irq_desc + irq;
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	desc->valid = (iflags & IRQF_VALID) != 0;
-	desc->probe_ok = (iflags & IRQF_PROBE) != 0;
-	desc->noautoenable = (iflags & IRQF_NOAUTOEN) != 0;
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-
-int setup_irq(unsigned int irq, struct irqaction *new)
-{
-	int shared = 0;
-	struct irqaction *old, **p;
-	unsigned long flags;
-	struct irqdesc *desc;
-
-	/*
-	 * Some drivers like serial.c use request_irq() heavily,
-	 * so we have to be careful not to interfere with a
-	 * running system.
-	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-	        rand_initialize_irq(irq);
-	}
-
-	/*
-	 * The following block of code has to be executed atomically
-	 */
-	desc = irq_desc + irq;
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	p = &desc->action;
-	if ((old = *p) != NULL) {
-		/*
-		 * Can't share interrupts unless both agree to and are
-		 * the same type.
-		 */
-		if (!(old->flags & new->flags & SA_SHIRQ) ||
-		    (~old->flags & new->flags) & SA_TRIGGER_MASK) {
-			spin_unlock_irqrestore(&irq_controller_lock, flags);
-			return -EBUSY;
-		}
-
-		/* add new interrupt at end of irq queue */
-		do {
-			p = &old->next;
-			old = *p;
-		} while (old);
-		shared = 1;
-	}
-
-	*p = new;
-
-	if (!shared) {
- 		desc->probing = 0;
-		desc->running = 0;
-		desc->pending = 0;
-		desc->disable_depth = 1;
-
-		if (new->flags & SA_TRIGGER_MASK &&
-		    desc->chip->set_type) {
-			unsigned int type = new->flags & SA_TRIGGER_MASK;
-			desc->chip->set_type(irq, type);
-		}
-
-		if (!desc->noautoenable) {
-			desc->disable_depth = 0;
-			desc->chip->unmask(irq);
-		}
-	}
-
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-	return 0;
-}
-
-/**
- *	request_irq - allocate an interrupt line
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device
- *	@dev_id: A cookie passed back to the handler function
- *
- *	This call allocates interrupt resources and enables the
- *	interrupt line and IRQ handling. From the point this
- *	call is made your handler function may be invoked. Since
- *	your handler function must clear any interrupt the board
- *	raises, you must take care both to initialise your hardware
- *	and to set up the interrupt handler in the right order.
- *
- *	Dev_id must be globally unique. Normally the address of the
- *	device data structure is used as the cookie. Since the handler
- *	receives this value it makes sense to use it.
- *
- *	If your interrupt is shared you must pass a non NULL dev_id
- *	as this is required when freeing the interrupt.
- *
- *	Flags:
- *
- *	SA_SHIRQ		Interrupt is shared
- *
- *	SA_INTERRUPT		Disable local interrupts while processing
- *
- *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
- *
- */
-int request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		 unsigned long irq_flags, const char * devname, void *dev_id)
-{
-	unsigned long retval;
-	struct irqaction *action;
-
-	if (irq >= NR_IRQS || !irq_desc[irq].valid || !handler ||
-	    (irq_flags & SA_SHIRQ && !dev_id))
-		return -EINVAL;
-
-	action = (struct irqaction *)kmalloc(sizeof(struct irqaction), GFP_KERNEL);
-	if (!action)
-		return -ENOMEM;
-
-	action->handler = handler;
-	action->flags = irq_flags;
-	cpus_clear(action->mask);
-	action->name = devname;
-	action->next = NULL;
-	action->dev_id = dev_id;
-
-	retval = setup_irq(irq, action);
-
-	if (retval)
-		kfree(action);
-	return retval;
-}
-
-EXPORT_SYMBOL(request_irq);
-
-/**
- *	free_irq - free an interrupt
- *	@irq: Interrupt line to free
- *	@dev_id: Device identity to free
- *
- *	Remove an interrupt handler. The handler is removed and if the
- *	interrupt line is no longer in use by any driver it is disabled.
- *	On a shared IRQ the caller must ensure the interrupt is disabled
- *	on the card it drives before calling this function.
- *
- *	This function must not be called from interrupt context.
- */
-void free_irq(unsigned int irq, void *dev_id)
-{
-	struct irqaction * action, **p;
-	unsigned long flags;
-
-	if (irq >= NR_IRQS || !irq_desc[irq].valid) {
-		printk(KERN_ERR "Trying to free IRQ%d\n",irq);
-		dump_stack();
-		return;
-	}
-
-	spin_lock_irqsave(&irq_controller_lock, flags);
-	for (p = &irq_desc[irq].action; (action = *p) != NULL; p = &action->next) {
-		if (action->dev_id != dev_id)
-			continue;
-
-	    	/* Found it - now free it */
-		*p = action->next;
-		break;
-	}
-	spin_unlock_irqrestore(&irq_controller_lock, flags);
-
-	if (!action) {
-		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
-		dump_stack();
-	} else {
-		synchronize_irq(irq);
-		kfree(action);
-	}
-}
-
-EXPORT_SYMBOL(free_irq);
-
-static DECLARE_MUTEX(probe_sem);
-
-/* Start the interrupt probing.  Unlike other architectures,
- * we don't return a mask of interrupts from probe_irq_on,
- * but return the number of interrupts enabled for the probe.
- * The interrupts which have been enabled for probing is
- * instead recorded in the irq_desc structure.
- */
-unsigned long probe_irq_on(void)
-{
-	unsigned int i, irqs = 0;
-	unsigned long delay;
-
-	down(&probe_sem);
-
-	/*
-	 * first snaffle up any unassigned but
-	 * probe-able interrupts
-	 */
-	spin_lock_irq(&irq_controller_lock);
-	for (i = 0; i < NR_IRQS; i++) {
-		if (!irq_desc[i].probe_ok || irq_desc[i].action)
-			continue;
-
-		irq_desc[i].probing = 1;
-		irq_desc[i].triggered = 0;
-		if (irq_desc[i].chip->set_type)
-			irq_desc[i].chip->set_type(i, IRQT_PROBE);
-		irq_desc[i].chip->unmask(i);
-		irqs += 1;
-	}
-	spin_unlock_irq(&irq_controller_lock);
-
-	/*
-	 * wait for spurious interrupts to mask themselves out again
-	 */
-	for (delay = jiffies + HZ/10; time_before(jiffies, delay); )
-		/* min 100ms delay */;
-
-	/*
-	 * now filter out any obviously spurious interrupts
-	 */
-	spin_lock_irq(&irq_controller_lock);
-	for (i = 0; i < NR_IRQS; i++) {
-		if (irq_desc[i].probing && irq_desc[i].triggered) {
-			irq_desc[i].probing = 0;
-			irqs -= 1;
-		}
-	}
-	spin_unlock_irq(&irq_controller_lock);
-
-	return irqs;
-}
-
-EXPORT_SYMBOL(probe_irq_on);
-
-unsigned int probe_irq_mask(unsigned long irqs)
-{
-	unsigned int mask = 0, i;
-
-	spin_lock_irq(&irq_controller_lock);
-	for (i = 0; i < 16 && i < NR_IRQS; i++)
-		if (irq_desc[i].probing && irq_desc[i].triggered)
-			mask |= 1 << i;
-	spin_unlock_irq(&irq_controller_lock);
-
-	up(&probe_sem);
-
-	return mask;
-}
-EXPORT_SYMBOL(probe_irq_mask);
-
-/*
- * Possible return values:
- *  >= 0 - interrupt number
- *    -1 - no interrupt/many interrupts
- */
-int probe_irq_off(unsigned long irqs)
-{
-	unsigned int i;
-	int irq_found = NO_IRQ;
-
-	/*
-	 * look at the interrupts, and find exactly one
-	 * that we were probing has been triggered
-	 */
-	spin_lock_irq(&irq_controller_lock);
-	for (i = 0; i < NR_IRQS; i++) {
-		if (irq_desc[i].probing &&
-		    irq_desc[i].triggered) {
-			if (irq_found != NO_IRQ) {
-				irq_found = NO_IRQ;
-				goto out;
-			}
-			irq_found = i;
-		}
-	}
-
-	if (irq_found == -1)
-		irq_found = NO_IRQ;
-out:
-	spin_unlock_irq(&irq_controller_lock);
-
-	up(&probe_sem);
-
-	return irq_found;
-}
-
-EXPORT_SYMBOL(probe_irq_off);
-
-#ifdef CONFIG_SMP
-static void route_irq(struct irqdesc *desc, unsigned int irq, unsigned int cpu)
-{
-	pr_debug("IRQ%u: moving from cpu%u to cpu%u\n", irq, desc->cpu, cpu);
-
-	spin_lock_irq(&irq_controller_lock);
-	desc->cpu = cpu;
-	desc->chip->set_cpu(desc, irq, cpu);
-	spin_unlock_irq(&irq_controller_lock);
-}
-
-#ifdef CONFIG_PROC_FS
-static int
-irq_affinity_read_proc(char *page, char **start, off_t off, int count,
-		       int *eof, void *data)
-{
-	struct irqdesc *desc = irq_desc + ((int)data);
-	int len = cpumask_scnprintf(page, count, desc->affinity);
-
-	if (count - len < 2)
-		return -EINVAL;
-	page[len++] = '\n';
-	page[len] = '\0';
-
-	return len;
-}
-
-static int
-irq_affinity_write_proc(struct file *file, const char __user *buffer,
-			unsigned long count, void *data)
-{
-	unsigned int irq = (unsigned int)data;
-	struct irqdesc *desc = irq_desc + irq;
-	cpumask_t affinity, tmp;
-	int ret = -EIO;
-
-	if (!desc->chip->set_cpu)
-		goto out;
-
-	ret = cpumask_parse(buffer, count, affinity);
-	if (ret)
-		goto out;
-
-	cpus_and(tmp, affinity, cpu_online_map);
-	if (cpus_empty(tmp)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	desc->affinity = affinity;
-	route_irq(desc, irq, first_cpu(tmp));
-	ret = count;
-
- out:
-	return ret;
-}
-#endif
-#endif
-
-void __init init_irq_proc(void)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_PROC_FS)
-	struct proc_dir_entry *dir;
-	int irq;
-
-	dir = proc_mkdir("irq", NULL);
-	if (!dir)
-		return;
-
-	for (irq = 0; irq < NR_IRQS; irq++) {
-		struct proc_dir_entry *entry;
-		struct irqdesc *desc;
-		char name[16];
-
-		desc = irq_desc + irq;
-		memset(name, 0, sizeof(name));
-		snprintf(name, sizeof(name) - 1, "%u", irq);
-
-		desc->procdir = proc_mkdir(name, dir);
-		if (!desc->procdir)
-			continue;
-
-		entry = create_proc_entry("smp_affinity", 0600, desc->procdir);
-		if (entry) {
-			entry->nlink = 1;
-			entry->data = (void *)irq;
-			entry->read_proc = irq_affinity_read_proc;
-			entry->write_proc = irq_affinity_write_proc;
-		}
-	}
-#endif
+	spin_lock_irqsave(&desc->lock, flags);
+	desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	if (iflags & IRQF_VALID)
+		desc->status &= ~IRQ_NOREQUEST;
+	if (iflags & IRQF_PROBE)
+		desc->status &= ~IRQ_NOPROBE;
+	if (!(iflags & IRQF_NOAUTOEN))
+		desc->status &= ~IRQ_NOAUTOEN;
+	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
 void __init init_IRQ(void)
 {
-	struct irqdesc *desc;
 	int irq;
 
+	for (irq = 0; irq < NR_IRQS; irq++)
+		irq_desc[irq].status |= IRQ_NOREQUEST;
+
 #ifdef CONFIG_SMP
 	bad_irq_desc.affinity = CPU_MASK_ALL;
 	bad_irq_desc.cpu = smp_processor_id();
 #endif
-
-	for (irq = 0, desc = irq_desc; irq < NR_IRQS; irq++, desc++) {
-		*desc = bad_irq_desc;
-		INIT_LIST_HEAD(&desc->pend);
-	}
-
 	init_arch_irq();
 }
 
-static int __init noirqdebug_setup(char *str)
-{
-	noirqdebug = 1;
-	return 1;
-}
-
-__setup("noirqdebug", noirqdebug_setup);
-
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * The CPU has been marked offline.  Migrate IRQs off this CPU.  If
Index: linux-genirq.q/include/asm-arm/dyntick.h
===================================================================
--- /dev/null
+++ linux-genirq.q/include/asm-arm/dyntick.h
@@ -0,0 +1,6 @@
+#ifndef _ASMARM_DYNTICK_H
+#define _ASMARM_DYNTICK_H
+
+#include <asm/mach/time.h>
+
+#endif /* _ASMARM_DYNTICK_H */
Index: linux-genirq.q/include/asm-arm/hw_irq.h
===================================================================
--- /dev/null
+++ linux-genirq.q/include/asm-arm/hw_irq.h
@@ -0,0 +1,9 @@
+/*
+ * Nothing to see here yet
+ */
+#ifndef _ARCH_ARM_HW_IRQ_H
+#define _ARCH_ARM_HW_IRQ_H
+
+#include <asm/mach/irq.h>
+
+#endif
Index: linux-genirq.q/include/asm-arm/irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-arm/irq.h
+++ linux-genirq.q/include/asm-arm/irq.h
@@ -21,18 +21,13 @@
 
 struct irqaction;
 
-extern void disable_irq_nosync(unsigned int);
-extern void disable_irq(unsigned int);
-extern void enable_irq(unsigned int);
-
 /*
- * These correspond with the SA_TRIGGER_* defines, and therefore the
- * IORESOURCE_IRQ_* defines.
+ * Migration helpers
  */
-#define __IRQT_RISEDGE	(1 << 0)
-#define __IRQT_FALEDGE	(1 << 1)
-#define __IRQT_HIGHLVL	(1 << 2)
-#define __IRQT_LOWLVL	(1 << 3)
+#define __IRQT_FALEDGE	IRQ_TYPE_EDGE_FALLING
+#define __IRQT_RISEDGE	IRQ_TYPE_EDGE_RISING
+#define __IRQT_LOWLVL	IRQ_TYPE_LEVEL_LOW
+#define __IRQT_HIGHLVL	IRQ_TYPE_LEVEL_HIGH
 
 #define IRQT_NOEDGE	(0)
 #define IRQT_RISING	(__IRQT_RISEDGE)
@@ -40,16 +35,7 @@ extern void enable_irq(unsigned int);
 #define IRQT_BOTHEDGE	(__IRQT_RISEDGE|__IRQT_FALEDGE)
 #define IRQT_LOW	(__IRQT_LOWLVL)
 #define IRQT_HIGH	(__IRQT_HIGHLVL)
-#define IRQT_PROBE	(1 << 4)
-
-int set_irq_type(unsigned int irq, unsigned int type);
-void disable_irq_wake(unsigned int irq);
-void enable_irq_wake(unsigned int irq);
-int setup_irq(unsigned int, struct irqaction *);
-
-struct irqaction;
-struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
+#define IRQT_PROBE	IRQ_TYPE_PROBE
 
 extern void migrate_irqs(void);
 #endif
Index: linux-genirq.q/include/asm-arm/mach/irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-arm/mach/irq.h
+++ linux-genirq.q/include/asm-arm/mach/irq.h
@@ -10,95 +10,9 @@
 #ifndef __ASM_ARM_MACH_IRQ_H
 #define __ASM_ARM_MACH_IRQ_H
 
-struct irqdesc;
-struct pt_regs;
-struct seq_file;
-
-typedef void (*irq_handler_t)(unsigned int, struct irqdesc *, struct pt_regs *);
-typedef void (*irq_control_t)(unsigned int);
-
-struct irqchip {
-	/*
-	 * Acknowledge the IRQ.
-	 * If this is a level-based IRQ, then it is expected to mask the IRQ
-	 * as well.
-	 */
-	void (*ack)(unsigned int);
-	/*
-	 * Mask the IRQ in hardware.
-	 */
-	void (*mask)(unsigned int);
-	/*
-	 * Unmask the IRQ in hardware.
-	 */
-	void (*unmask)(unsigned int);
-	/*
-	 * Ask the hardware to re-trigger the IRQ.
-	 * Note: This method _must_ _not_ call the interrupt handler.
-	 * If you are unable to retrigger the interrupt, do not
-	 * provide a function, or if you do, return non-zero.
-	 */
-	int (*retrigger)(unsigned int);
-	/*
-	 * Set the type of the IRQ.
-	 */
-	int (*set_type)(unsigned int, unsigned int);
-	/*
-	 * Set wakeup-enable on the selected IRQ
-	 */
-	int (*set_wake)(unsigned int, unsigned int);
-
-#ifdef CONFIG_SMP
-	/*
-	 * Route an interrupt to a CPU
-	 */
-	void (*set_cpu)(struct irqdesc *desc, unsigned int irq, unsigned int cpu);
-#endif
-};
-
-struct irqdesc {
-	irq_handler_t	handle;
-	struct irqchip	*chip;
-	struct irqaction *action;
-	struct list_head pend;
-	void __iomem	*base;
-	void		*data;
-	unsigned int	disable_depth;
-
-	unsigned int	triggered: 1;		/* IRQ has occurred	      */
-	unsigned int	running  : 1;		/* IRQ is running             */
-	unsigned int	pending  : 1;		/* IRQ is pending	      */
-	unsigned int	probing  : 1;		/* IRQ in use for a probe     */
-	unsigned int	probe_ok : 1;		/* IRQ can be used for probe  */
-	unsigned int	valid    : 1;		/* IRQ claimable	      */
-	unsigned int	noautoenable : 1;	/* don't automatically enable IRQ */
-	unsigned int	unused   :25;
-
-	unsigned int	irqs_unhandled;
-	struct proc_dir_entry *procdir;
-
-#ifdef CONFIG_SMP
-	cpumask_t	affinity;
-	unsigned int	cpu;
-#endif
-
-	/*
-	 * IRQ lock detection
-	 */
-	unsigned int	lck_cnt;
-	unsigned int	lck_pc;
-	unsigned int	lck_jif;
-};
+#include <linux/irq.h>
 
-extern struct irqdesc irq_desc[];
-
-/*
- * Helpful inline function for calling irq descriptor handlers.
- */
-static inline void desc_handle_irq(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
-{
-	desc->handle(irq, desc, regs);
-}
+struct seq_file;
 
 /*
  * This is internal.  Do not use it.
@@ -106,18 +20,30 @@ static inline void desc_handle_irq(unsig
 extern void (*init_arch_irq)(void);
 extern void init_FIQ(void);
 extern int show_fiq_list(struct seq_file *, void *);
-void __set_irq_handler(unsigned int irq, irq_handler_t, int);
+extern void
+__set_irq_handler(unsigned int irq,
+		  void (*handle)(unsigned int, irq_desc_t*, struct pt_regs*),
+		  int is_chained);
+
+/*
+ * Function wrappers
+ */
+#define set_irq_handler(irq, h)		__set_irq_handler(irq, h, 0)
+#define set_irq_chained_handler(irq, h)	__set_irq_handler(irq, h, 1)
+#define set_irq_chipdata(irq, d)	set_irq_chip_data(irq, d)
+#define get_irq_chipdata(irq)		get_irq_chip_data(irq)
 
 /*
- * External stuff.
+ * Helpful inline function for calling irq descriptor handlers.
  */
-#define set_irq_handler(irq,handler)		__set_irq_handler(irq,handler,0)
-#define set_irq_chained_handler(irq,handler)	__set_irq_handler(irq,handler,1)
-#define set_irq_data(irq,d)			do { irq_desc[irq].data = d; } while (0)
-#define set_irq_chipdata(irq,d)			do { irq_desc[irq].base = d; } while (0)
-#define get_irq_chipdata(irq)			(irq_desc[irq].base)
+static inline void desc_handle_irq(unsigned int irq, struct irq_desc *desc,
+				   struct pt_regs *regs)
+{
+	spin_lock(&desc->lock);
+	desc->handle(irq, desc, regs);
+	spin_unlock(&desc->lock);
+}
 
-void set_irq_chip(unsigned int irq, struct irqchip *);
 void set_irq_flags(unsigned int irq, unsigned int flags);
 
 #define IRQF_VALID	(1 << 0)
@@ -125,12 +51,25 @@ void set_irq_flags(unsigned int irq, uns
 #define IRQF_NOAUTOEN	(1 << 2)
 
 /*
- * Built-in IRQ handlers.
+ * This is for easy migration, but should be changed in the source
  */
-void do_level_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs);
-void do_edge_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs);
-void do_simple_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs);
-void do_bad_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs);
-void dummy_mask_unmask_irq(unsigned int irq);
+#define do_level_IRQ	handle_level_irq
+#define do_edge_IRQ	handle_edge_irq
+#define do_simple_IRQ	handle_simple_irq
+#define irqdesc		irq_desc
+#define irqchip		irq_chip
+
+#define do_bad_IRQ(irq,desc,regs)			\
+do {							\
+	spin_lock(&desc->lock);				\
+	handle_bad_irq(irq, desc, regs);		\
+	spin_unlock(&desc->lock);			\
+} while(0)
+
+extern unsigned long irq_err_count;
+static inline void ack_bad_irq(int irq)
+{
+	irq_err_count++;
+}
 
 #endif
