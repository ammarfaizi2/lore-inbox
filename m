Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVE0Jb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVE0Jb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVE0J3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:29:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52107 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262398AbVE0JRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:17:32 -0400
Date: Fri, 27 May 2005 11:14:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527091432.GB20512@elte.hu>
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <1117184630.6736.415.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117184630.6736.415.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > But keep
> > the basic fundamental operations fast please (at least that used to be one
> > of the Linux mottos that served it very well for many years, although more
> > and more people seem to forget it now) 
> 
> "It has been that way since ages" arguments are not really productive in
> a discussion. [...]

to make sure the wide context has not been lost: no way is IRQ threading 
ever going to be the main or even the preferred mode of operation.

secondly, there's no performance impact on stock kernels, nor any design 
drag. I have done a very quick & dirty separation out of hardirq 
threading from -RT patchset, see the patch below. It's pretty small:

 8 files changed, 375 insertions(+), 53 deletions(-)

no arch level change is needed - if an arch uses GENERIC_HARDIRQS then 
it will be automatically capable to run hardirq threads.

	Ingo

NOT-Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/irq/proc.c.orig
+++ linux/kernel/irq/proc.c
@@ -7,9 +7,12 @@
  */
 
 #include <linux/irq.h>
+#include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
 
+#include "internals.h"
+
 static struct proc_dir_entry *root_irq_dir, *irq_dir[NR_IRQS];
 
 #ifdef CONFIG_SMP
@@ -67,37 +70,6 @@ static int irq_affinity_write_proc(struc
 
 #endif
 
-#define MAX_NAMELEN 128
-
-static int name_unique(unsigned int irq, struct irqaction *new_action)
-{
-	struct irq_desc *desc = irq_desc + irq;
-	struct irqaction *action;
-
-	for (action = desc->action ; action; action = action->next)
-		if ((action != new_action) && action->name &&
-				!strcmp(new_action->name, action->name))
-			return 0;
-	return 1;
-}
-
-void register_handler_proc(unsigned int irq, struct irqaction *action)
-{
-	char name [MAX_NAMELEN];
-
-	if (!irq_dir[irq] || action->dir || !action->name ||
-					!name_unique(irq, action))
-		return;
-
-	memset(name, 0, MAX_NAMELEN);
-	snprintf(name, MAX_NAMELEN, "%s", action->name);
-
-	/* create /proc/irq/1234/handler/ */
-	action->dir = proc_mkdir(name, irq_dir[irq]);
-}
-
-#undef MAX_NAMELEN
-
 #define MAX_NAMELEN 10
 
 void register_irq_proc(unsigned int irq)
@@ -137,10 +109,96 @@ void register_irq_proc(unsigned int irq)
 
 void unregister_handler_proc(unsigned int irq, struct irqaction *action)
 {
+	if (action->threaded)
+		remove_proc_entry(action->threaded->name, action->dir);
 	if (action->dir)
 		remove_proc_entry(action->dir->name, irq_dir[irq]);
 }
 
+#ifndef CONFIG_PREEMPT_RT
+
+static int threaded_read_proc(char *page, char **start, off_t off,
+			      int count, int *eof, void *data)
+{
+	return sprintf(page, "%c\n",
+		((struct irqaction *)data)->flags & SA_NODELAY ? '0' : '1');
+}
+
+static int threaded_write_proc(struct file *file, const char __user *buffer,
+			       unsigned long count, void *data)
+{
+	int c;
+	struct irqaction *action = data;
+	irq_desc_t *desc = irq_desc + action->irq;
+
+	if (get_user(c, buffer))
+		return -EFAULT;
+	if (c != '0' && c != '1')
+		return -EINVAL;
+
+	spin_lock_irq(&desc->lock);
+
+	if (c == '0')
+		action->flags |= SA_NODELAY;
+	if (c == '1')
+		action->flags &= ~SA_NODELAY;
+	recalculate_desc_flags(desc);
+
+	spin_unlock_irq(&desc->lock);
+
+	return 1;
+}
+
+#endif
+
+#define MAX_NAMELEN 128
+
+static int name_unique(unsigned int irq, struct irqaction *new_action)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	struct irqaction *action;
+
+	for (action = desc->action ; action; action = action->next)
+		if ((action != new_action) && action->name &&
+				!strcmp(new_action->name, action->name))
+			return 0;
+	return 1;
+}
+
+void register_handler_proc(unsigned int irq, struct irqaction *action)
+{
+	char name [MAX_NAMELEN];
+
+	if (!irq_dir[irq] || action->dir || !action->name ||
+					!name_unique(irq, action))
+		return;
+
+	memset(name, 0, MAX_NAMELEN);
+	snprintf(name, MAX_NAMELEN, "%s", action->name);
+
+	/* create /proc/irq/1234/handler/ */
+	action->dir = proc_mkdir(name, irq_dir[irq]);
+	if (!action->dir)
+		return;
+#ifndef CONFIG_PREEMPT_RT
+	{
+		struct proc_dir_entry *entry;
+		/* create /proc/irq/1234/handler/threaded */
+		entry = create_proc_entry("threaded", 0600, action->dir);
+		if (!entry)
+			return;
+		entry->nlink = 1;
+		entry->data = (void *)action;
+		entry->read_proc = threaded_read_proc;
+		entry->write_proc = threaded_write_proc;
+		action->threaded = entry;
+	}
+#endif
+}
+
+#undef MAX_NAMELEN
+
+
 void init_irq_proc(void)
 {
 	int i;
@@ -150,6 +208,9 @@ void init_irq_proc(void)
 	if (!root_irq_dir)
 		return;
 
+	/* create /proc/irq/prof_cpu_mask */
+	create_prof_cpu_mask(root_irq_dir);
+
 	/*
 	 * Create entries for all existing IRQs.
 	 */
--- linux/kernel/irq/manage.c.orig
+++ linux/kernel/irq/manage.c
@@ -7,8 +7,10 @@
  */
 
 #include <linux/irq.h>
-#include <linux/module.h>
 #include <linux/random.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/syscalls.h>
 #include <linux/interrupt.h>
 
 #include "internals.h"
@@ -30,8 +32,12 @@ void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_desc + irq;
 
-	while (desc->status & IRQ_INPROGRESS)
-		cpu_relax();
+	if (hardirq_preemption && !(desc->status & IRQ_NODELAY))
+		wait_event(desc->wait_for_handler,
+			!(desc->status & IRQ_INPROGRESS));
+	else
+		while (desc->status & IRQ_INPROGRESS)
+			cpu_relax();
 }
 
 EXPORT_SYMBOL(synchronize_irq);
@@ -127,6 +133,21 @@ void enable_irq(unsigned int irq)
 EXPORT_SYMBOL(enable_irq);
 
 /*
+ * If any action has SA_NODELAY then turn IRQ_NODELAY on:
+ */
+void recalculate_desc_flags(struct irq_desc *desc)
+{
+	struct irqaction *action;
+
+	desc->status &= ~IRQ_NODELAY;
+	for (action = desc->action ; action; action = action->next)
+		if (action->flags & SA_NODELAY)
+			desc->status |= IRQ_NODELAY;
+}
+
+static int start_irq_thread(int irq, struct irq_desc *desc);
+
+/*
  * Internal function that tells the architecture code whether a
  * particular irq has been exclusively allocated or is available
  * for driver use.
@@ -176,6 +197,9 @@ int setup_irq(unsigned int irq, struct i
 		rand_initialize_irq(irq);
 	}
 
+	if (!(new->flags & SA_NODELAY))
+		if (start_irq_thread(irq, desc))
+			return -ENOMEM;
 	/*
 	 * The following block of code has to be executed atomically
 	 */
@@ -198,6 +222,11 @@ int setup_irq(unsigned int irq, struct i
 
 	*p = new;
 
+	/*
+	 * Propagate any possible SA_NODELAY flag into IRQ_NODELAY:
+	 */
+	recalculate_desc_flags(desc);
+
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT |
@@ -211,7 +240,7 @@ int setup_irq(unsigned int irq, struct i
 
 	new->irq = irq;
 	register_irq_proc(irq);
-	new->dir = NULL;
+	new->dir = new->threaded = NULL;
 	register_handler_proc(irq, new);
 
 	return 0;
@@ -262,6 +291,7 @@ void free_irq(unsigned int irq, void *de
 				else
 					desc->handler->disable(irq);
 			}
+			recalculate_desc_flags(desc);
 			spin_unlock_irqrestore(&desc->lock,flags);
 			unregister_handler_proc(irq, action);
 
@@ -347,3 +377,171 @@ int request_irq(unsigned int irq,
 
 EXPORT_SYMBOL(request_irq);
 
+#ifdef CONFIG_PREEMPT_HARDIRQS
+
+int hardirq_preemption = 1;
+
+EXPORT_SYMBOL(hardirq_preemption);
+
+/*
+ * Real-Time Preemption depends on hardirq threading:
+ */
+#ifndef CONFIG_PREEMPT_RT
+
+static int __init hardirq_preempt_setup (char *str)
+{
+	if (!strncmp(str, "off", 3))
+		hardirq_preemption = 0;
+	else
+		get_option(&str, &hardirq_preemption);
+	if (!hardirq_preemption)
+		printk("turning off hardirq preemption!\n");
+
+	return 1;
+}
+
+__setup("hardirq-preempt=", hardirq_preempt_setup);
+
+#endif
+
+static void do_hardirq(struct irq_desc *desc)
+{
+	struct irqaction * action;
+	unsigned int irq = desc - irq_desc;
+
+	local_irq_disable();
+
+	if (desc->status & IRQ_INPROGRESS) {
+		action = desc->action;
+		spin_lock(&desc->lock);
+		for (;;) {
+			irqreturn_t action_ret = 0;
+
+			if (action) {
+				spin_unlock(&desc->lock);
+				action_ret = handle_IRQ_event(irq, NULL,action);
+				local_irq_enable();
+				cond_resched_all();
+				spin_lock_irq(&desc->lock);
+			}
+			if (!noirqdebug)
+				note_interrupt(irq, desc, action_ret);
+			if (likely(!(desc->status & IRQ_PENDING)))
+				break;
+			desc->status &= ~IRQ_PENDING;
+		}
+		desc->status &= ~IRQ_INPROGRESS;
+		/*
+		 * The ->end() handler has to deal with interrupts which got
+		 * disabled while the handler was running.
+		 */
+		desc->handler->end(irq);
+		spin_unlock(&desc->lock);
+	}
+	local_irq_enable();
+	if (waitqueue_active(&desc->wait_for_handler))
+		wake_up(&desc->wait_for_handler);
+}
+
+extern asmlinkage void __do_softirq(void);
+
+static int curr_irq_prio = 49;
+
+static int do_irqd(void * __desc)
+{
+	struct sched_param param = { 0, };
+	struct irq_desc *desc = __desc;
+#ifdef CONFIG_SMP
+	int irq = desc - irq_desc;
+	cpumask_t mask;
+
+	mask = cpumask_of_cpu(any_online_cpu(irq_affinity[irq]));
+	set_cpus_allowed(current, mask);
+#endif
+	current->flags |= PF_NOFREEZE | PF_HARDIRQ;
+
+	/*
+	 * Scale irq thread priorities from prio 50 to prio 25
+	 */
+	param.sched_priority = curr_irq_prio;
+	if (param.sched_priority > 25)
+		curr_irq_prio = param.sched_priority - 1;
+
+	sys_sched_setscheduler(current->pid, SCHED_FIFO, &param);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		do_hardirq(desc);
+		cond_resched_all();
+		__do_softirq();
+		local_irq_enable();
+#ifdef CONFIG_SMP
+		/*
+		 * Did IRQ affinities change?
+		 */
+		if (!cpu_isset(smp_processor_id(), irq_affinity[irq])) {
+			mask = cpumask_of_cpu(any_online_cpu(irq_affinity[irq]));
+			set_cpus_allowed(current, mask);
+		}
+#endif
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static int ok_to_create_irq_threads;
+
+static int start_irq_thread(int irq, struct irq_desc *desc)
+{
+	if (desc->thread || !ok_to_create_irq_threads)
+		return 0;
+
+	desc->thread = kthread_create(do_irqd, desc, "IRQ %d", irq);
+	if (!desc->thread) {
+		printk(KERN_ERR "irqd: could not create IRQ thread %d!\n", irq);
+		return -ENOMEM;
+	}
+
+	/*
+	 * An interrupt may have come in before the thread pointer was
+	 * stored in desc->thread; make sure the thread gets woken up in
+	 * such a case:
+	 */
+	smp_mb();
+	wake_up_process(desc->thread);
+	
+	return 0;
+}
+
+void __init init_hardirqs(void)
+{	
+	int i;
+	ok_to_create_irq_threads = 1;
+
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+
+		if (desc->action && !(desc->status & IRQ_NODELAY))
+			start_irq_thread(i, desc);
+	}
+}
+
+#else
+
+static int start_irq_thread(int irq, struct irq_desc *desc)
+{
+	return 0;
+}
+
+#endif
+
+void __init early_init_hardirqs(void)
+{	
+	int i;
+
+	for (i = 0; i < NR_IRQS; i++)
+		init_waitqueue_head(&irq_desc[i].wait_for_handler);
+}
+
+
--- linux/kernel/irq/handle.c.orig
+++ linux/kernel/irq/handle.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
@@ -32,7 +33,7 @@ irq_desc_t irq_desc[NR_IRQS] __cacheline
 	[0 ... NR_IRQS-1] = {
 		.status = IRQ_DISABLED,
 		.handler = &no_irq_type,
-		.lock = SPIN_LOCK_UNLOCKED
+		.lock = RAW_SPIN_LOCK_UNLOCKED
 	}
 };
 
@@ -74,6 +75,32 @@ irqreturn_t no_action(int cpl, void *dev
 }
 
 /*
+ * Hack - used for development only.
+ */
+int debug_direct_keyboard = 0;
+
+int redirect_hardirq(struct irq_desc *desc)
+{
+	/*
+	 * Direct execution:
+	 */
+	if (!hardirq_preemption || (desc->status & IRQ_NODELAY) ||
+							!desc->thread)
+		return 0;
+
+#ifdef __i386__
+	if (debug_direct_keyboard && (desc - irq_desc == 1))
+		return 0;
+#endif
+		 
+	BUG_ON(!irqs_disabled());
+	if (desc->thread && desc->thread->state != TASK_RUNNING)
+		wake_up_process(desc->thread);
+
+	return 1;
+}
+
+/*
  * Have got an event to handle:
  */
 fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
@@ -81,30 +108,50 @@ fastcall int handle_IRQ_event(unsigned i
 {
 	int ret, retval = 0, status = 0;
 
-	if (!(action->flags & SA_INTERRUPT))
+	/*
+	 * Unconditionally enable interrupts for threaded
+	 * IRQ handlers:
+	 */
+	if (!hardirq_count() || !(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
 	do {
+		unsigned int preempt_count = preempt_count();
+
 		ret = action->handler(irq, action->dev_id, regs);
+		if (preempt_count() != preempt_count) {
+			stop_trace();
+			print_symbol("BUG: unbalanced irq-handler preempt count in %s!\n", (unsigned long) action->handler);
+			printk("entered with %08x, exited with %08x.\n", preempt_count, preempt_count());
+			dump_stack();
+			preempt_count() = preempt_count;
+		}
 		if (ret == IRQ_HANDLED)
 			status |= action->flags;
 		retval |= ret;
 		action = action->next;
 	} while (action);
 
-	if (status & SA_SAMPLE_RANDOM)
+	if (status & SA_SAMPLE_RANDOM) {
+		local_irq_enable();
 		add_interrupt_randomness(irq);
+	}
 	local_irq_disable();
 
 	return retval;
 }
 
+cycles_t irq_timestamp(unsigned int irq)
+{
+	return irq_desc[irq].timestamp;
+}
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
+fastcall notrace unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
@@ -124,6 +171,7 @@ fastcall unsigned int __do_IRQ(unsigned 
 		desc->handler->end(irq);
 		return 1;
 	}
+	desc->timestamp = get_cycles();
 
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -156,6 +204,12 @@ fastcall unsigned int __do_IRQ(unsigned 
 		goto out;
 
 	/*
+	 * hardirq redirection to the irqd process context:
+	 */
+	if (redirect_hardirq(desc))
+		goto out_no_end;
+
+	/*
 	 * Edge triggered interrupts need to remember
 	 * pending events.
 	 * This applies to any hw interrupts that allow a second
@@ -180,13 +234,13 @@ fastcall unsigned int __do_IRQ(unsigned 
 		desc->status &= ~IRQ_PENDING;
 	}
 	desc->status &= ~IRQ_INPROGRESS;
-
 out:
 	/*
 	 * The ->end() handler has to deal with interrupts which got
 	 * disabled while the handler was running.
 	 */
 	desc->handler->end(irq);
+out_no_end:
 	spin_unlock(&desc->lock);
 
 	return 1;
--- linux/kernel/irq/autoprobe.c.orig
+++ linux/kernel/irq/autoprobe.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 
@@ -26,7 +27,7 @@ static DECLARE_MUTEX(probe_sem);
  */
 unsigned long probe_irq_on(void)
 {
-	unsigned long val, delay;
+	unsigned long val;
 	irq_desc_t *desc;
 	unsigned int i;
 
@@ -44,9 +45,10 @@ unsigned long probe_irq_on(void)
 		spin_unlock_irq(&desc->lock);
 	}
 
-	/* Wait for longstanding interrupts to trigger. */
-	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
-		/* about 20ms delay */ barrier();
+	/*
+	 * Wait for longstanding interrupts to trigger, 20 msec delay:
+	 */
+	msleep(HZ/50);
 
 	/*
 	 * enable any unassigned irqs
@@ -66,10 +68,9 @@ unsigned long probe_irq_on(void)
 	}
 
 	/*
-	 * Wait for spurious interrupts to trigger
+	 * Wait for spurious interrupts to trigger, 100 msec delay:
 	 */
-	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
-		/* about 100ms delay */ barrier();
+	msleep(HZ/10);
 
 	/*
 	 * Now filter out any obviously spurious interrupts
--- linux/kernel/irq/internals.h.orig
+++ linux/kernel/irq/internals.h
@@ -4,6 +4,8 @@
 
 extern int noirqdebug;
 
+void recalculate_desc_flags(struct irq_desc *desc);
+
 #ifdef CONFIG_PROC_FS
 extern void register_irq_proc(unsigned int irq);
 extern void register_handler_proc(unsigned int irq, struct irqaction *action);
--- linux/include/linux/interrupt.h.orig
+++ linux/include/linux/interrupt.h
@@ -41,7 +41,7 @@ struct irqaction {
 	void *dev_id;
 	struct irqaction *next;
 	int irq;
-	struct proc_dir_entry *dir;
+	struct proc_dir_entry *dir, *threaded;
 };
 
 extern irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs);
@@ -126,6 +131,7 @@ extern void softirq_init(void);
 #define __raise_softirq_irqoff(nr) do { local_softirq_pending() |= 1UL << (nr); } while (0)
 extern void FASTCALL(raise_softirq_irqoff(unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
+extern void wakeup_irqd(void);
 
 
 /* Tasklets --- multithreaded analogue of BHs.
--- linux/include/linux/hardirq.h.orig
+++ linux/include/linux/hardirq.h
@@ -58,11 +58,13 @@
  * Are we doing bottom half or hardware interrupt processing?
  * Are we in a softirq context? Interrupt context?
  */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
-#define in_interrupt()		(irq_count())
-
-#if defined(CONFIG_PREEMPT) && !defined(CONFIG_PREEMPT_BKL)
+#define in_irq()	(hardirq_count() || (current->flags & PF_HARDIRQ))
+#define in_softirq()	(softirq_count() || (current->flags & PF_SOFTIRQ))
+#define in_interrupt()	(irq_count())
+
+#if defined(CONFIG_PREEMPT) && \
+	!defined(CONFIG_PREEMPT_BKL) && \
+		!defined(CONFIG_PREEMPT_RT)
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 #else
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != 0)
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -791,6 +942,9 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_SOFTIRQ	0x01000000      /* softirq context */
+#define PF_HARDIRQ	0x02000000      /* hardirq context */
+
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other

