Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSIHQcZ>; Sun, 8 Sep 2002 12:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSIHQcZ>; Sun, 8 Sep 2002 12:32:25 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:53675 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316971AbSIHQcV>; Sun, 8 Sep 2002 12:32:21 -0400
Date: Sun, 8 Sep 2002 18:59:59 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209081507140.1096-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0209081700460.1096-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a newer (untested) patch incorporating Ingo's suggestions as well 
as adding an extra request_irq flag so that isrs can use isr_unmask_irq() 
to enable their interrupt lines.

Ingo, if i didn't understand you properly please point out where i missed 
what you meant.

Thanks,
	Zwane

Index: linux-2.5.33/include/linux/interrupt.h
===================================================================
RCS file: /home/zwane/source/cvs_rep/linux-2.5.33/include/linux/interrupt.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 interrupt.h
--- linux-2.5.33/include/linux/interrupt.h	2002/09/08 10:48:54	1.1.1.1
+++ linux-2.5.33/include/linux/interrupt.h	2002/09/08 13:57:57
@@ -13,6 +13,8 @@
 #include <asm/system.h>
 #include <asm/ptrace.h>
 
+#define ISR_INPROGRESS	1	/* ISR currently being executed */
+
 struct irqaction {
 	void (*handler)(int, void *, struct pt_regs *);
 	unsigned long flags;
@@ -20,6 +22,7 @@
 	const char *name;
 	void *dev_id;
 	struct irqaction *next;
+	unsigned long status;
 };
 
 
Index: linux-2.5.33/include/linux/irq.h
===================================================================
RCS file: /home/zwane/source/cvs_rep/linux-2.5.33/include/linux/irq.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.h
--- linux-2.5.33/include/linux/irq.h	2002/09/08 10:48:53	1.1.1.1
+++ linux-2.5.33/include/linux/irq.h	2002/09/08 13:52:24
@@ -24,13 +24,12 @@
  */
 #define IRQ_INPROGRESS	1	/* IRQ handler active - do not enter! */
 #define IRQ_DISABLED	2	/* IRQ disabled - do not enter! */
-#define IRQ_PENDING	4	/* IRQ pending - replay on enable */
-#define IRQ_REPLAY	8	/* IRQ has been replayed but not acked yet */
-#define IRQ_AUTODETECT	16	/* IRQ is being autodetected */
-#define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
-#define IRQ_LEVEL	64	/* IRQ level triggered */
-#define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
-#define IRQ_PER_CPU	256	/* IRQ is per CPU */
+#define IRQ_REPLAY	4	/* IRQ has been replayed but not acked yet */
+#define IRQ_AUTODETECT	8	/* IRQ is being autodetected */
+#define IRQ_WAITING	16	/* IRQ not yet seen - for autodetection */
+#define IRQ_LEVEL	32	/* IRQ level triggered */
+#define IRQ_MASKED	64	/* IRQ masked - shouldn't be seen again */
+#define IRQ_PER_CPU	128	/* IRQ is per CPU */
 
 /*
  * Interrupt controller descriptor. This is all we need
@@ -62,6 +61,7 @@
 	struct irqaction *action;	/* IRQ action list */
 	unsigned int depth;		/* nested irq disables */
 	spinlock_t lock;
+	unsigned int pending;
 } ____cacheline_aligned irq_desc_t;
 
 extern irq_desc_t irq_desc [NR_IRQS];
Index: linux-2.5.33/arch/i386/kernel/irq.c
===================================================================
RCS file: /home/zwane/source/cvs_rep/linux-2.5.33/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.33/arch/i386/kernel/irq.c	2002/09/08 10:48:21	1.1.1.1
+++ linux-2.5.33/arch/i386/kernel/irq.c	2002/09/08 15:41:03
@@ -66,7 +66,7 @@
  * Controller mappings for all interrupt sources:
  */
 irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
-	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
+	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED, 0}};
 
 static void register_irq_proc (unsigned int irq);
 
@@ -186,11 +186,33 @@
 #if CONFIG_SMP
 inline void synchronize_irq(unsigned int irq)
 {
+	/* We can still synchronize with IRQ_INPROGRESS even
+	 * with asynchronous handlers since it encapsulates
+	 * the handlers
+	 */
 	while (irq_desc[irq].status & IRQ_INPROGRESS)
 		cpu_relax();
 }
 #endif
 
+/* This should be called from ISRs to enable
+ * their interrupt line once they've acked
+ * the device interrupt they are handling
+ */
+ 
+void inline isr_unmask_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	
+	if (desc->action->flags & SA_UNMASKIRQ)
+		desc->handler->enable(irq);
+#if 0
+	/* APICs require an ack too */
+	if (desc->handler->ack == ack_APIC_irq)
+		desc->handler->ack();
+#endif
+}
+
 /*
  * This should really return information about whether
  * we should do bottom half handling etc. Right now we
@@ -200,21 +222,27 @@
  */
 int handle_IRQ_event(unsigned int irq, struct pt_regs * regs, struct irqaction * action)
 {
-	int status = 1;	/* Force the "do bottom halves" bit */
+	int ret = 1;	/* Force the "do bottom halves" bit */
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
+	/* Ease irq sharing by allowing other handlers to be run instead
+	 * of blocking all with IRQ_INPROGRESS */
+
 	do {
-		status |= action->flags;
-		action->handler(irq, action->dev_id, regs);
+		if (test_and_set_bit(ISR_INPROGRESS, &action->status) == 0) {
+			action->handler(irq, action->dev_id, regs);
+			clear_bit(ISR_INPROGRESS, &action->status);
+		}
+		ret |= action->flags;
 		action = action->next;
 	} while (action);
-	if (status & SA_SAMPLE_RANDOM)
+	if (ret & SA_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 	local_irq_disable();
 
-	return status;
+	return ret;
 }
 
 /*
@@ -289,9 +317,10 @@
 	case 1: {
 		unsigned int status = desc->status & ~IRQ_DISABLED;
 		desc->status = status;
-		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
+		
+		if (!(status & IRQ_REPLAY) && desc->pending) {
 			desc->status = status | IRQ_REPLAY;
-			hw_resend_irq(desc->handler,irq);
+			hw_resend_irq(desc->handler, irq);
 		}
 		desc->handler->enable(irq);
 		/* fall-through */
@@ -338,16 +367,19 @@
 	   WAITING is used by probe to mark irqs that are being tested
 	   */
 	status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-	status |= IRQ_PENDING; /* we _want_ to handle it */
+	desc->pending++;	/* we _want_ to handle it */
 
 	/*
 	 * If the IRQ is disabled for whatever reason, we cannot
-	 * use the action we have.
+	 * use the action we have. Note that we don't check for
+	 * IRQ_INPROGRESS, we allow multiple ISRs from a shared
+	 * interrupt to be run concurrently, but still not allowing
+	 * the same handler to be run asynchronously.
 	 */
 	action = NULL;
-	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
+	if (likely(!(status & IRQ_DISABLED))) {
 		action = desc->action;
-		status &= ~IRQ_PENDING; /* we commit to handling */
+		desc->pending--; /* we commit to handling */
 		status |= IRQ_INPROGRESS; /* we are handling it */
 	}
 	desc->status = status;
@@ -376,9 +408,9 @@
 		handle_IRQ_event(irq, &regs, action);
 		spin_lock(&desc->lock);
 		
-		if (likely(!(desc->status & IRQ_PENDING)))
+		if (likely(!desc->pending))
 			break;
-		desc->status &= ~IRQ_PENDING;
+		desc->pending--;
 	}
 out:
 	desc->status &= ~IRQ_INPROGRESS;
@@ -424,6 +456,7 @@
  *
  *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
  *
+ *	SA_UNMASKIRQ		Unmask irq line whilst processing
  */
  
 int request_irq(unsigned int irq, 
@@ -463,6 +496,7 @@
 	action->mask = 0;
 	action->name = devname;
 	action->next = NULL;
+	action->status = 0;
 	action->dev_id = dev_id;
 
 	retval = setup_irq(irq, action);
@@ -563,14 +597,14 @@
 		desc = irq_desc + i;
 
 		spin_lock_irq(&desc->lock);
-		if (!irq_desc[i].action) 
-			irq_desc[i].handler->startup(i);
+		if (!desc->action) 
+			desc->handler->startup(i);
 		spin_unlock_irq(&desc->lock);
 	}
 
 	/* Wait for longstanding interrupts to trigger. */
 	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
-		/* about 20ms delay */ barrier();
+		/* about 20ms delay */ cpu_relax();
 
 	/*
 	 * enable any unassigned irqs
@@ -584,7 +618,7 @@
 		if (!desc->action) {
 			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
 			if (desc->handler->startup(i))
-				desc->status |= IRQ_PENDING;
+				desc->pending++;
 		}
 		spin_unlock_irq(&desc->lock);
 	}
@@ -593,7 +627,7 @@
 	 * Wait for spurious interrupts to trigger
 	 */
 	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
-		/* about 100ms delay */ barrier();
+		/* about 100ms delay */ cpu_relax();
 
 	/*
 	 * Now filter out any obviously spurious interrupts
@@ -756,6 +790,14 @@
 			return -EBUSY;
 		}
 
+		if (!(old->flags & new->flags & SA_UNMASKIRQ)) {
+			printk(KERN_DEBUG
+				"Unable to unmask irqs with isrs old:%s new:%s",
+				old->name, new->name);
+			old->flags &= ~SA_UNMASKIRQ;
+			new->flags &= ~SA_UNMASKIRQ;
+		}
+		
 		/* add new interrupt at end of irq queue */
 		do {
 			p = &old->next;
Index: linux-2.5.33/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/zwane/source/cvs_rep/linux-2.5.33/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 io_apic.c
--- linux-2.5.33/arch/i386/kernel/io_apic.c	2002/09/08 10:48:21	1.1.1.1
+++ linux-2.5.33/arch/i386/kernel/io_apic.c	2002/09/08 14:43:33
@@ -1292,15 +1292,14 @@
 #define shutdown_edge_ioapic_irq	disable_edge_ioapic_irq
 
 /*
- * Once we have recorded IRQ_PENDING already, we can mask the
+ * Once we have recorded irq pending already, we can mask the
  * interrupt for real. This prevents IRQ storms from unhandled
  * devices.
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
 	balance_irq(irq);
-	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
-					== (IRQ_PENDING | IRQ_DISABLED))
+	if (irq_desc[irq].pending && (irq_desc[irq].status & IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
 	ack_APIC_irq();
 }

-- 
function.linuxpower.ca



