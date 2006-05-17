Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWEQAPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWEQAPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWEQAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:15:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7888 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932080AbWEQAPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:35 -0400
Date: Wed, 17 May 2006 02:15:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 04/50] genirq: cleanup: misc code cleanups
Message-ID: <20060517001524.GE12877@elte.hu>
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

From: Ingo Molnar <mingo@elte.hu>

assorted code cleanups to the generic IRQ code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h    |   54 +++++++++++++++++++++++++++++--------------------
 kernel/irq/autoprobe.c |   16 ++++++--------
 kernel/irq/handle.c    |    4 +--
 kernel/irq/manage.c    |   29 ++++++++++----------------
 kernel/irq/spurious.c  |   27 ++++++++++++------------
 5 files changed, 67 insertions(+), 63 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -1,5 +1,5 @@
-#ifndef __irq_h
-#define __irq_h
+#ifndef _LINUX_IRQ_H
+#define _LINUX_IRQ_H
 
 /*
  * Please do not include this file in generic code.  There is currently
@@ -12,7 +12,7 @@
 #include <linux/config.h>
 #include <linux/smp.h>
 
-#if !defined(CONFIG_S390)
+#ifndef CONFIG_S390
 
 #include <linux/linkage.h>
 #include <linux/cache.h>
@@ -33,7 +33,7 @@
 #define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
 #define IRQ_LEVEL	64	/* IRQ level triggered */
 #define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
-#if defined(ARCH_HAS_IRQ_PER_CPU)
+#ifdef ARCH_HAS_IRQ_PER_CPU
 # define IRQ_PER_CPU	256	/* IRQ is per CPU */
 # define CHECK_IRQ_PER_CPU(var) ((var) & IRQ_PER_CPU)
 #else
@@ -45,7 +45,7 @@
  * to describe about the low-level hardware. 
  */
 struct hw_interrupt_type {
-	const char * typename;
+	const char *typename;
 	unsigned int (*startup)(unsigned int irq);
 	void (*shutdown)(unsigned int irq);
 	void (*enable)(unsigned int irq);
@@ -80,7 +80,7 @@ typedef struct irq_desc {
 #ifdef CONFIG_SMP
 	cpumask_t affinity;
 #endif
-#if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
+#if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
 	unsigned int move_irq;		/* Flag need to re-target intr dest*/
 #endif
 } ____cacheline_aligned irq_desc_t;
@@ -89,9 +89,10 @@ extern irq_desc_t irq_desc [NR_IRQS];
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
-extern int setup_irq(unsigned int irq, struct irqaction * new);
+extern int setup_irq(unsigned int irq, struct irqaction *new);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
+
 #ifdef CONFIG_SMP
 static inline void set_native_irq_info(int irq, cpumask_t mask)
 {
@@ -105,7 +106,7 @@ static inline void set_native_irq_info(i
 
 #ifdef CONFIG_SMP
 
-#if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
+#if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
 extern cpumask_t pending_irq_cpumask[NR_IRQS];
 
 void set_pending_irq(unsigned int irq, cpumask_t mask);
@@ -127,7 +128,7 @@ static inline void set_irq_info(int irq,
 {
 }
 
-#else // CONFIG_PCI_MSI
+#else /* CONFIG_PCI_MSI */
 
 static inline void move_irq(int irq)
 {
@@ -138,26 +139,36 @@ static inline void set_irq_info(int irq,
 {
 	set_native_irq_info(irq, mask);
 }
-#endif // CONFIG_PCI_MSI
 
-#else	// CONFIG_GENERIC_PENDING_IRQ || CONFIG_IRQBALANCE
+#endif /* CONFIG_PCI_MSI */
+
+#else /* CONFIG_GENERIC_PENDING_IRQ || CONFIG_IRQBALANCE */
+
+static inline void move_irq(int irq)
+{
+}
+
+static inline void move_native_irq(int irq)
+{
+}
+
+static inline void set_pending_irq(unsigned int irq, cpumask_t mask)
+{
+}
 
-#define move_irq(x)
-#define move_native_irq(x)
-#define set_pending_irq(x,y)
 static inline void set_irq_info(int irq, cpumask_t mask)
 {
 	set_native_irq_info(irq, mask);
 }
 
-#endif // CONFIG_GENERIC_PENDING_IRQ
+#endif /* CONFIG_GENERIC_PENDING_IRQ */
 
-#else // CONFIG_SMP
+#else /* CONFIG_SMP */
 
 #define move_irq(x)
 #define move_native_irq(x)
 
-#endif // CONFIG_SMP
+#endif /* CONFIG_SMP */
 
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
@@ -179,17 +190,16 @@ extern void init_irq_proc(void);
 #ifdef CONFIG_AUTO_IRQ_AFFINITY
 extern int select_smp_affinity(unsigned int irq);
 #else
-static inline int
-select_smp_affinity(unsigned int irq)
+static inline int select_smp_affinity(unsigned int irq)
 {
 	return 1;
 }
 #endif
 
-#endif
+#endif /* CONFIG_GENERIC_HARDIRQS */
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
 
-#endif
+#endif /* !CONFIG_S390 */
 
-#endif /* __irq_h */
+#endif /* _LINUX_IRQ_H */
Index: linux-genirq.q/kernel/irq/autoprobe.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/autoprobe.c
+++ linux-genirq.q/kernel/irq/autoprobe.c
@@ -27,7 +27,7 @@ static DECLARE_MUTEX(probe_sem);
  */
 unsigned long probe_irq_on(void)
 {
-	unsigned long val;
+	unsigned long mask;
 	irq_desc_t *desc;
 	unsigned int i;
 
@@ -40,8 +40,8 @@ unsigned long probe_irq_on(void)
 		desc = irq_desc + i;
 
 		spin_lock_irq(&desc->lock);
-		if (!irq_desc[i].action)
-			irq_desc[i].handler->startup(i);
+		if (!desc->action)
+			desc->handler->startup(i);
 		spin_unlock_irq(&desc->lock);
 	}
 
@@ -73,11 +73,11 @@ unsigned long probe_irq_on(void)
 	/*
 	 * Now filter out any obviously spurious interrupts
 	 */
-	val = 0;
+	mask = 0;
 	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
 		unsigned int status;
 
+		desc = irq_desc + i;
 		spin_lock_irq(&desc->lock);
 		status = desc->status;
 
@@ -88,14 +88,13 @@ unsigned long probe_irq_on(void)
 				desc->handler->shutdown(i);
 			} else
 				if (i < 32)
-					val |= 1 << i;
+					mask |= 1 << i;
 		}
 		spin_unlock_irq(&desc->lock);
 	}
 
-	return val;
+	return mask;
 }
-
 EXPORT_SYMBOL(probe_irq_on);
 
 /**
@@ -183,6 +182,5 @@ int probe_irq_off(unsigned long val)
 		irq_found = -irq_found;
 	return irq_found;
 }
-
 EXPORT_SYMBOL(probe_irq_off);
 
Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -18,7 +18,7 @@
  * Linux has a controller-independent interrupt architecture.
  * Every controller has a 'controller-template', that is used
  * by the main code to do the right thing. Each driver-visible
- * interrupt source is transparently wired to the apropriate
+ * interrupt source is transparently wired to the appropriate
  * controller. Thus drivers need not be aware of the
  * interrupt-controller.
  *
@@ -110,7 +110,7 @@ int handle_IRQ_event(unsigned int irq, s
 fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
 	irq_desc_t *desc = irq_desc + irq;
-	struct irqaction * action;
+	struct irqaction *action;
 	unsigned int status;
 
 	kstat_this_cpu.irqs[irq]++;
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -40,7 +40,6 @@ void synchronize_irq(unsigned int irq)
 	while (desc->status & IRQ_INPROGRESS)
 		cpu_relax();
 }
-
 EXPORT_SYMBOL(synchronize_irq);
 
 #endif
@@ -71,7 +70,6 @@ void disable_irq_nosync(unsigned int irq
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
-
 EXPORT_SYMBOL(disable_irq_nosync);
 
 /**
@@ -97,7 +95,6 @@ void disable_irq(unsigned int irq)
 	if (desc->action)
 		synchronize_irq(irq);
 }
-
 EXPORT_SYMBOL(disable_irq);
 
 /**
@@ -139,7 +136,6 @@ void enable_irq(unsigned int irq)
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
-
 EXPORT_SYMBOL(enable_irq);
 
 /*
@@ -166,7 +162,7 @@ int can_request_irq(unsigned int irq, un
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
  */
-int setup_irq(unsigned int irq, struct irqaction * new)
+int setup_irq(unsigned int irq, struct irqaction *new)
 {
 	struct irq_desc *desc = irq_desc + irq;
 	struct irqaction *old, **p;
@@ -198,9 +194,10 @@ int setup_irq(unsigned int irq, struct i
 	/*
 	 * The following block of code has to be executed atomically
 	 */
-	spin_lock_irqsave(&desc->lock,flags);
+	spin_lock_irqsave(&desc->lock, flags);
 	p = &desc->action;
-	if ((old = *p) != NULL) {
+	old = *p;
+	if (old) {
 		/* Can't share interrupts unless both agree to */
 		if (!(old->flags & new->flags & SA_SHIRQ))
 			goto mismatch;
@@ -233,7 +230,7 @@ int setup_irq(unsigned int irq, struct i
 		else
 			desc->handler->enable(irq);
 	}
-	spin_unlock_irqrestore(&desc->lock,flags);
+	spin_unlock_irqrestore(&desc->lock, flags);
 
 	new->irq = irq;
 	register_irq_proc(irq);
@@ -276,10 +273,10 @@ void free_irq(unsigned int irq, void *de
 		return;
 
 	desc = irq_desc + irq;
-	spin_lock_irqsave(&desc->lock,flags);
+	spin_lock_irqsave(&desc->lock, flags);
 	p = &desc->action;
 	for (;;) {
-		struct irqaction * action = *p;
+		struct irqaction *action = *p;
 
 		if (action) {
 			struct irqaction **pp = p;
@@ -304,7 +301,7 @@ void free_irq(unsigned int irq, void *de
 				else
 					desc->handler->disable(irq);
 			}
-			spin_unlock_irqrestore(&desc->lock,flags);
+			spin_unlock_irqrestore(&desc->lock, flags);
 			unregister_handler_proc(irq, action);
 
 			/* Make sure it's not being used on another CPU */
@@ -312,12 +309,11 @@ void free_irq(unsigned int irq, void *de
 			kfree(action);
 			return;
 		}
-		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
+		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
+		spin_unlock_irqrestore(&desc->lock, flags);
 		return;
 	}
 }
-
 EXPORT_SYMBOL(free_irq);
 
 /**
@@ -351,9 +347,9 @@ EXPORT_SYMBOL(free_irq);
  */
 int request_irq(unsigned int irq,
 		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		unsigned long irqflags, const char * devname, void *dev_id)
+		unsigned long irqflags, const char *devname, void *dev_id)
 {
-	struct irqaction * action;
+	struct irqaction *action;
 	int retval;
 
 	/*
@@ -388,6 +384,5 @@ int request_irq(unsigned int irq,
 
 	return retval;
 }
-
 EXPORT_SYMBOL(request_irq);
 
Index: linux-genirq.q/kernel/irq/spurious.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/spurious.c
+++ linux-genirq.q/kernel/irq/spurious.c
@@ -16,22 +16,18 @@ static int irqfixup;
 /*
  * Recovery handler for misrouted interrupts.
  */
-
 static int misrouted_irq(int irq, struct pt_regs *regs)
 {
-	int i;
-	irq_desc_t *desc;
-	int ok = 0;
-	int work = 0;	/* Did we do work for a real IRQ */
+	int i, ok = 0, work = 0;
 
-	for(i = 1; i < NR_IRQS; i++) {
+	for (i = 1; i < NR_IRQS; i++) {
+		struct irq_desc *desc = irq_desc + i;
 		struct irqaction *action;
 
 		if (i == irq)	/* Already tried */
 			continue;
-		desc = &irq_desc[i];
+
 		spin_lock(&desc->lock);
-		action = desc->action;
 		/* Already running on another processor */
 		if (desc->status & IRQ_INPROGRESS) {
 			/*
@@ -45,7 +41,9 @@ static int misrouted_irq(int irq, struct
 		}
 		/* Honour the normal IRQ locking */
 		desc->status |= IRQ_INPROGRESS;
+		action = desc->action;
 		spin_unlock(&desc->lock);
+
 		while (action) {
 			/* Only shared IRQ handlers are safe to call */
 			if (action->flags & SA_SHIRQ) {
@@ -62,9 +60,8 @@ static int misrouted_irq(int irq, struct
 
 		/*
 		 * While we were looking for a fixup someone queued a real
-		 * IRQ clashing with our walk
+		 * IRQ clashing with our walk:
 		 */
-
 		while ((desc->status & IRQ_PENDING) && action) {
 			/*
 			 * Perform real IRQ processing for the IRQ we deferred
@@ -80,7 +77,7 @@ static int misrouted_irq(int irq, struct
 		 * If we did actual work for the real IRQ line we must let the
 		 * IRQ controller clean up too
 		 */
-		if(work)
+		if (work)
 			desc->handler->end(i);
 		spin_unlock(&desc->lock);
 	}
@@ -113,6 +110,7 @@ __report_bad_irq(unsigned int irq, irq_d
 	}
 	dump_stack();
 	printk(KERN_ERR "handlers:\n");
+
 	action = desc->action;
 	while (action) {
 		printk(KERN_ERR "[<%p>]", action->handler);
@@ -123,7 +121,8 @@ __report_bad_irq(unsigned int irq, irq_d
 	}
 }
 
-static void report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
+static void
+report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
 {
 	static int count = 100;
 
@@ -134,7 +133,7 @@ static void report_bad_irq(unsigned int 
 }
 
 void note_interrupt(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret,
-			struct pt_regs *regs)
+		    struct pt_regs *regs)
 {
 	if (action_ret != IRQ_HANDLED) {
 		desc->irqs_unhandled++;
@@ -177,6 +176,7 @@ int __init noirqdebug_setup(char *str)
 {
 	noirqdebug = 1;
 	printk(KERN_INFO "IRQ lockup detection disabled\n");
+
 	return 1;
 }
 
@@ -187,6 +187,7 @@ static int __init irqfixup_setup(char *s
 	irqfixup = 1;
 	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
 	printk(KERN_WARNING "This may impact system performance.\n");
+
 	return 1;
 }
 
