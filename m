Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWEQA1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWEQA1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWEQARm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:17:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52688 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932319AbWEQARP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:15 -0400
Date: Wed, 17 May 2006 02:16:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 21/50] genirq: core
Message-ID: <20060517001651.GV12877@elte.hu>
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

core genirq support: add the irq-chip and irq-flow abstractions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h    |   86 ++++++++++++++++++++++++++++++++++++++++---------
 kernel/irq/autoprobe.c |    9 ++++-
 kernel/irq/handle.c    |   14 +++++++
 3 files changed, 93 insertions(+), 16 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -43,8 +43,24 @@
 #define IRQ_NOPROBE	512	/* IRQ is not valid for probing */
 #define IRQ_NOREQUEST	1024	/* IRQ cannot be requested */
 #define IRQ_NOAUTOEN	2048	/* IRQ will not be enabled on request irq */
+
+/*
+ * IRQ types, see also include/linux/interrupt.h
+ */
+#define IRQ_TYPE_NONE		0x0000		/* Default, unspecified type */
+#define IRQ_TYPE_EDGE_RISING	0x0001		/* Edge rising type */
+#define IRQ_TYPE_EDGE_FALLING	0x0002		/* Edge falling type */
+#define IRQ_TYPE_EDGE_BOTH (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
+#define IRQ_TYPE_LEVEL_HIGH	0x0004		/* Level high type */
+#define IRQ_TYPE_LEVEL_LOW	0x0008		/* Level low type */
+#define IRQ_TYPE_SIMPLE		0x0010		/* Simple type */
+#define IRQ_TYPE_PERCPU		0x0020		/* Per CPU type */
+#define IRQ_TYPE_PROBE		0x0040		/* Probing in progress */
+
+struct proc_dir_entry;
+
 /**
- * struct hw_interrupt_type - hardware interrupt type descriptor
+ * struct irq_chip - hardware interrupt chip descriptor
  *
  * @name:		name for /proc/interrupts
  * @startup:		start up the interrupt (defaults to ->enable if NULL)
@@ -65,16 +81,23 @@
  *
  * @release:		release function solely used by UML
  */
-struct hw_interrupt_type {
-	const char	*typename;
+struct irq_chip {
+	const char	*typename; /* will be renamed to 'name' */
 	unsigned int	(*startup)(unsigned int irq);
 	void		(*shutdown)(unsigned int irq);
 	void		(*enable)(unsigned int irq);
 	void		(*disable)(unsigned int irq);
+
 	void		(*ack)(unsigned int irq);
+	void		(*mask)(unsigned int irq);
+	void		(*mask_ack)(unsigned int irq);
+	void		(*unmask)(unsigned int irq);
+
 	void		(*end)(unsigned int irq);
 	void		(*set_affinity)(unsigned int irq, cpumask_t dest);
 	int		(*retrigger)(unsigned int irq);
+	int		(*set_type)(unsigned int irq, unsigned int flow_type);
+	int		(*set_wake)(unsigned int irq, int on);
 
 	/* Currently used only by UML, might disappear one day.*/
 #ifdef CONFIG_IRQ_RELEASE_METHOD
@@ -82,15 +105,15 @@ struct hw_interrupt_type {
 #endif
 };
 
-typedef struct hw_interrupt_type  hw_irq_controller;
-
-struct proc_dir_entry;
-
 /**
  * struct irq_desc - interrupt descriptor
  *
- * @handler:		interrupt type dependent handler functions
- * @handler_data:	data for the type handlers
+ * @handle:		highlevel irq-events handler [if NULL, __do_IRQ()]
+ * @handler:		low level interrupt hardware access
+ *			(this should be renamed to 'chip')
+ * @handler_data:	per-IRQ data for the irq_chip methods
+ * @chip_data:		platform-specific per-chip private data for the chip
+ *			methods, to allow shared chip implementations
  * @action:		the irq action chain
  * @status:		status information
  * @depth:		disable-depth, for nested irq_disable() calls
@@ -106,16 +129,22 @@ struct proc_dir_entry;
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
 struct irq_desc {
-	hw_irq_controller	*handler;
+	void			(*handle)(unsigned int irq,
+					  struct irq_desc *desc,
+					  struct pt_regs *regs);
+	struct irq_chip		*handler;
 	void			*handler_data;
+	void			*chip_data;
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status;		/* IRQ status */
+
 	unsigned int		depth;		/* nested irq disables */
 	unsigned int		irq_count;	/* For detecting broken IRQs */
 	unsigned int		irqs_unhandled;
 	spinlock_t		lock;
 #ifdef CONFIG_SMP
 	cpumask_t		affinity;
+	unsigned int		cpu;
 #endif
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
 	cpumask_t		pending_mask;
@@ -134,6 +163,9 @@ extern struct irq_desc irq_desc[NR_IRQS]
 /*
  * Migration helpers for obsolete names, they will go away:
  */
+#define hw_interrupt_type	irq_chip
+typedef struct irq_chip		hw_irq_controller;
+#define no_irq_type		no_irq_chip
 typedef struct irq_desc		irq_desc_t;
 
 /*
@@ -231,28 +263,52 @@ static inline int select_smp_affinity(un
 #endif
 
 extern int no_irq_affinity;
-extern int noirqdebug_setup(char *str);
 
+/* Handle irq action chains: */
 extern int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 			    struct irqaction *action);
 
 /*
- * Explicit fastcall, because i386 4KSTACKS calls it from assembly:
+ * Built-in IRQ handlers for various IRQ types,
+ * callable via desc->handler->handle_irq()
+ */
+extern void handle_level_irq(unsigned int irq, struct irq_desc *desc,
+			     struct pt_regs *regs);
+extern void handle_edge_irq(unsigned int irq, struct irq_desc *desc,
+			    struct pt_regs *regs);
+extern void handle_simple_irq(unsigned int irq, struct irq_desc *desc,
+			      struct pt_regs *regs);
+extern void handle_percpu_irq(unsigned int irq, struct irq_desc *desc,
+			      struct pt_regs *regs);
+extern void handle_bad_irq(unsigned int irq, struct irq_desc *desc,
+			   struct pt_regs *regs);
+
+/*
+ * Monolithic do_IRQ implementation.
+ * (is an explicit fastcall, because i386 4KSTACKS calls it from assembly)
  */
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 
+/* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   int action_ret, struct pt_regs *regs);
-extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
 /* Resending of interrupts :*/
 void check_irq_resend(struct irq_desc *desc, unsigned int irq);
 
+/* Initialize /proc/irq/ */
 extern void init_irq_proc(void);
 
-#endif /* CONFIG_GENERIC_HARDIRQS */
+/* Enable/disable irq debugging output: */
+extern int noirqdebug_setup(char *str);
+
+/* Checks whether the interrupt can be requested by request_irq(): */
+extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
-extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
+/* Dummy irq-chip implementation: */
+extern struct irq_chip no_irq_chip;
+
+#endif /* CONFIG_GENERIC_HARDIRQS */
 
 #endif /* !CONFIG_S390 */
 
Index: linux-genirq.q/kernel/irq/autoprobe.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/autoprobe.c
+++ linux-genirq.q/kernel/irq/autoprobe.c
@@ -40,8 +40,15 @@ unsigned long probe_irq_on(void)
 		desc = irq_desc + i;
 
 		spin_lock_irq(&desc->lock);
-		if (!desc->action && !(desc->status & IRQ_NOPROBE))
+		if (!desc->action && !(desc->status & IRQ_NOPROBE)) {
+			/*
+			 * Some chips need to know about probing in
+			 * progress:
+			 */
+			if (desc->handler->set_type)
+				desc->handler->set_type(i, IRQ_TYPE_PROBE);
 			desc->handler->startup(i);
+		}
 		spin_unlock_irq(&desc->lock);
 	}
 
Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -18,6 +18,18 @@
 
 #include "internals.h"
 
+/**
+ * handle_bad_irq - handle spurious and unhandled irqs
+ * @irq:	the interrupt number
+ * @desc:	the interrupt description structure for this irq
+ * @regs:	pointer to a register structure
+ */
+void
+handle_bad_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
+{
+	ack_bad_irq(irq);
+}
+
 /*
  * Linux has a controller-independent interrupt architecture.
  * Every controller has a 'controller-template', that is used
@@ -36,7 +48,9 @@ struct irq_desc irq_desc[NR_IRQS] __cach
 	[0 ... NR_IRQS-1] = {
 		.status = IRQ_DISABLED,
 		.handler = &no_irq_type,
+		.handle = handle_bad_irq,
 		.lock = SPIN_LOCK_UNLOCKED,
+		.depth = 1,
 #ifdef CONFIG_SMP
 		.affinity = CPU_MASK_ALL
 #endif
