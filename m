Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWEQAdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWEQAdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWEQAc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:32:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29648 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932308AbWEQAQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:16 -0400
Date: Wed, 17 May 2006 02:16:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 11/50] genirq: add ->retrigger() irq op to consolidate hw_irq_resend()
Message-ID: <20060517001600.GL12877@elte.hu>
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

add ->retrigger() irq op to consolidate hw_irq_resend() implementations.
(Most architectures had it defined to NOP anyway.)

NOTE: ia64 needs testing. i386 and x86_64 tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/i386/kernel/io_apic.c    |    9 +++++++++
 arch/ia64/kernel/irq_lsapic.c |   10 +++++++++-
 arch/ia64/kernel/perfmon.c    |    4 ++--
 arch/parisc/kernel/irq.c      |   11 ++++-------
 arch/x86_64/kernel/io_apic.c  |    9 +++++++++
 include/asm-alpha/hw_irq.h    |    2 --
 include/asm-cris/hw_irq.h     |    2 --
 include/asm-i386/hw_irq.h     |   10 ----------
 include/asm-ia64/hw_irq.h     |    3 +--
 include/asm-m32r/hw_irq.h     |    5 -----
 include/asm-mips/hw_irq.h     |    8 ++++----
 include/asm-parisc/hw_irq.h   |    9 ---------
 include/asm-powerpc/hw_irq.h  |    6 +++---
 include/asm-sh/hw_irq.h       |    5 -----
 include/asm-sh64/hw_irq.h     |    1 -
 include/asm-um/hw_irq.h       |    3 ---
 include/asm-v850/hw_irq.h     |    4 ----
 include/asm-x86_64/hw_irq.h   |    9 ---------
 include/asm-xtensa/hw_irq.h   |    4 ----
 include/linux/irq.h           |    2 ++
 kernel/irq/manage.c           |    3 ++-
 21 files changed, 45 insertions(+), 74 deletions(-)

Index: linux-genirq.q/arch/i386/kernel/io_apic.c
===================================================================
--- linux-genirq.q.orig/arch/i386/kernel/io_apic.c
+++ linux-genirq.q/arch/i386/kernel/io_apic.c
@@ -2053,6 +2053,13 @@ static void set_ioapic_affinity_vector (
 #endif
 #endif
 
+static int ioapic_retrigger(unsigned int irq)
+{
+	send_IPI_self(IO_APIC_VECTOR(irq));
+
+	return 1;
+}
+
 /*
  * Level and edge triggered IO-APIC interrupts need different handling,
  * so we use two separate IRQ descriptors. Edge triggered IRQs can be
@@ -2072,6 +2079,7 @@ static struct hw_interrupt_type ioapic_e
 #ifdef CONFIG_SMP
 	.set_affinity 	= set_ioapic_affinity,
 #endif
+	.retrigger	= ioapic_retrigger,
 };
 
 static struct hw_interrupt_type ioapic_level_type __read_mostly = {
@@ -2085,6 +2093,7 @@ static struct hw_interrupt_type ioapic_l
 #ifdef CONFIG_SMP
 	.set_affinity 	= set_ioapic_affinity,
 #endif
+	.retrigger	= ioapic_retrigger,
 };
 
 static inline void init_IO_APIC_traps(void)
Index: linux-genirq.q/arch/ia64/kernel/irq_lsapic.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/irq_lsapic.c
+++ linux-genirq.q/arch/ia64/kernel/irq_lsapic.c
@@ -26,6 +26,13 @@ lsapic_noop (unsigned int irq)
 	/* nuthing to do... */
 }
 
+static int lsapic_retrigger(unsigned int irq)
+{
+	ia64_resend_irq(irq);
+
+	return 1;
+}
+
 struct hw_interrupt_type irq_type_ia64_lsapic = {
 	.typename =	"LSAPIC",
 	.startup =	lsapic_noop_startup,
@@ -33,5 +40,6 @@ struct hw_interrupt_type irq_type_ia64_l
 	.enable =	lsapic_noop,
 	.disable =	lsapic_noop,
 	.ack =		lsapic_noop,
-	.end =		lsapic_noop
+	.end =		lsapic_noop,
+	.retrigger =	lsapic_retrigger,
 };
Index: linux-genirq.q/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/perfmon.c
+++ linux-genirq.q/arch/ia64/kernel/perfmon.c
@@ -6165,7 +6165,7 @@ pfm_load_regs (struct task_struct *task)
 		/*
 		 * will replay the PMU interrupt
 		 */
-		if (need_irq_resend) hw_resend_irq(NULL, IA64_PERFMON_VECTOR);
+		if (need_irq_resend) ia64_resend_irq(IA64_PERFMON_VECTOR);
 
 		pfm_stats[smp_processor_id()].pfm_replay_ovfl_intr_count++;
 	}
@@ -6305,7 +6305,7 @@ pfm_load_regs (struct task_struct *task)
 		/*
 		 * will replay the PMU interrupt
 		 */
-		if (need_irq_resend) hw_resend_irq(NULL, IA64_PERFMON_VECTOR);
+		if (need_irq_resend) ia64_resend_irq(IA64_PERFMON_VECTOR);
 
 		pfm_stats[smp_processor_id()].pfm_replay_ovfl_intr_count++;
 	}
Index: linux-genirq.q/arch/parisc/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/parisc/kernel/irq.c
+++ linux-genirq.q/arch/parisc/kernel/irq.c
@@ -125,6 +125,10 @@ static struct hw_interrupt_type cpu_inte
 #ifdef CONFIG_SMP
 	.set_affinity	= cpu_set_affinity_irq,
 #endif
+	/* XXX: Needs to be written.  We managed without it so far, but
+	 * we really ought to write it.
+	 */
+	.retrigger	= NULL,
 };
 
 int show_interrupts(struct seq_file *p, void *v)
@@ -404,13 +408,6 @@ void __init init_IRQ(void)
 
 }
 
-void hw_resend_irq(struct hw_interrupt_type *type, unsigned int irq)
-{
-	/* XXX: Needs to be written.  We managed without it so far, but
-	 * we really ought to write it.
-	 */
-}
-
 void ack_bad_irq(unsigned int irq)
 {
 	printk("unexpected IRQ %d\n", irq);
Index: linux-genirq.q/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-genirq.q.orig/arch/x86_64/kernel/io_apic.c
+++ linux-genirq.q/arch/x86_64/kernel/io_apic.c
@@ -1591,6 +1591,13 @@ static void set_ioapic_affinity_vector (
 #endif // CONFIG_SMP
 #endif // CONFIG_PCI_MSI
 
+static int ioapic_retrigger(unsigned int irq)
+{
+	send_IPI_self(IO_APIC_VECTOR(irq));
+
+	return 1;
+}
+
 /*
  * Level and edge triggered IO-APIC interrupts need different handling,
  * so we use two separate IRQ descriptors. Edge triggered IRQs can be
@@ -1611,6 +1618,7 @@ static struct hw_interrupt_type ioapic_e
 #ifdef CONFIG_SMP
 	.set_affinity = set_ioapic_affinity,
 #endif
+	.retrigger	= ioapic_retrigger,
 };
 
 static struct hw_interrupt_type ioapic_level_type __read_mostly = {
@@ -1624,6 +1632,7 @@ static struct hw_interrupt_type ioapic_l
 #ifdef CONFIG_SMP
 	.set_affinity = set_ioapic_affinity,
 #endif
+	.retrigger	= ioapic_retrigger,
 };
 
 static inline void init_IO_APIC_traps(void)
Index: linux-genirq.q/include/asm-alpha/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-alpha/hw_irq.h
+++ linux-genirq.q/include/asm-alpha/hw_irq.h
@@ -3,8 +3,6 @@
 
 #include <linux/config.h>
 
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
-
 extern volatile unsigned long irq_err_count;
 
 #ifdef CONFIG_ALPHA_GENERIC
Index: linux-genirq.q/include/asm-cris/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-cris/hw_irq.h
+++ linux-genirq.q/include/asm-cris/hw_irq.h
@@ -1,7 +1,5 @@
 #ifndef _ASM_HW_IRQ_H
 #define _ASM_HW_IRQ_H
 
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
-
 #endif
 
Index: linux-genirq.q/include/asm-i386/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-i386/hw_irq.h
+++ linux-genirq.q/include/asm-i386/hw_irq.h
@@ -68,14 +68,4 @@ extern atomic_t irq_mis_count;
 
 #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
 
-#if defined(CONFIG_X86_IO_APIC)
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
-{
-	if (IO_APIC_IRQ(i))
-		send_IPI_self(IO_APIC_VECTOR(i));
-}
-#else
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
-#endif
-
 #endif /* _ASM_HW_IRQ_H */
Index: linux-genirq.q/include/asm-ia64/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-ia64/hw_irq.h
+++ linux-genirq.q/include/asm-ia64/hw_irq.h
@@ -86,8 +86,7 @@ extern void free_irq_vector (int vector)
 extern void ia64_send_ipi (int cpu, int vector, int delivery_mode, int redirect);
 extern void register_percpu_irq (ia64_vector vec, struct irqaction *action);
 
-static inline void
-hw_resend_irq (struct hw_interrupt_type *h, unsigned int vector)
+static inline void ia64_resend_irq(unsigned int vector)
 {
 	platform_send_ipi(smp_processor_id(), vector, IA64_IPI_DM_INT, 0);
 }
Index: linux-genirq.q/include/asm-m32r/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-m32r/hw_irq.h
+++ linux-genirq.q/include/asm-m32r/hw_irq.h
@@ -1,9 +1,4 @@
 #ifndef _ASM_M32R_HW_IRQ_H
 #define _ASM_M32R_HW_IRQ_H
 
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
-{
-	/* Nothing to do */
-}
-
 #endif /* _ASM_M32R_HW_IRQ_H */
Index: linux-genirq.q/include/asm-mips/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-mips/hw_irq.h
+++ linux-genirq.q/include/asm-mips/hw_irq.h
@@ -19,9 +19,9 @@ extern void init_8259A(int aeoi);
 
 extern atomic_t irq_err_count;
 
-/* This may not be apropriate for all machines, we'll see ...  */
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
-{
-}
+/*
+ * interrupt-retrigger: NOP for now. This may not be apropriate for all
+ * machines, we'll see ...
+ */
 
 #endif /* __ASM_HW_IRQ_H */
Index: linux-genirq.q/include/asm-parisc/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-parisc/hw_irq.h
+++ linux-genirq.q/include/asm-parisc/hw_irq.h
@@ -3,15 +3,6 @@
 
 /*
  *	linux/include/asm/hw_irq.h
- *
- *	(C) 1992, 1993 Linus Torvalds, (C) 1997 Ingo Molnar
- *
- *	moved some of the old arch/i386/kernel/irq.h to here. VY
- *
- *	IRQ/IPI changes taken from work by Thomas Radke
- *	<tomsoft@informatik.tu-chemnitz.de>
  */
 
-extern void hw_resend_irq(struct hw_interrupt_type *, unsigned int);
-
 #endif
Index: linux-genirq.q/include/asm-powerpc/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-powerpc/hw_irq.h
+++ linux-genirq.q/include/asm-powerpc/hw_irq.h
@@ -103,11 +103,11 @@ static inline void local_irq_save_ptr(un
 			desc->handler->ack(irq);		\
 	})
 
-/* Should we handle this via lost interrupts and IPIs or should we don't care like
- * we do now ? --BenH.
+/*
+ * interrupt-retrigger: should we handle this via lost interrupts and IPIs
+ * or should we not care like we do now ? --BenH.
  */
 struct hw_interrupt_type;
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_HW_IRQ_H */
Index: linux-genirq.q/include/asm-sh/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-sh/hw_irq.h
+++ linux-genirq.q/include/asm-sh/hw_irq.h
@@ -1,9 +1,4 @@
 #ifndef __ASM_SH_HW_IRQ_H
 #define __ASM_SH_HW_IRQ_H
 
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
-{
-	/* Nothing to do */
-}
-
 #endif /* __ASM_SH_HW_IRQ_H */
Index: linux-genirq.q/include/asm-sh64/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-sh64/hw_irq.h
+++ linux-genirq.q/include/asm-sh64/hw_irq.h
@@ -11,6 +11,5 @@
  * Copyright (C) 2000, 2001  Paolo Alberelli
  *
  */
-static __inline__ void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) { /* Nothing to do */ }
 
 #endif /* __ASM_SH64_HW_IRQ_H */
Index: linux-genirq.q/include/asm-um/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-um/hw_irq.h
+++ linux-genirq.q/include/asm-um/hw_irq.h
@@ -4,7 +4,4 @@
 #include "asm/irq.h"
 #include "asm/archparam.h"
 
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
-{}
-
 #endif
Index: linux-genirq.q/include/asm-v850/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-v850/hw_irq.h
+++ linux-genirq.q/include/asm-v850/hw_irq.h
@@ -1,8 +1,4 @@
 #ifndef __V850_HW_IRQ_H__
 #define __V850_HW_IRQ_H__
 
-static inline void hw_resend_irq (struct hw_interrupt_type *h, unsigned int i)
-{
-}
-
 #endif /* __V850_HW_IRQ_H__ */
Index: linux-genirq.q/include/asm-x86_64/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-x86_64/hw_irq.h
+++ linux-genirq.q/include/asm-x86_64/hw_irq.h
@@ -130,15 +130,6 @@ __asm__( \
 	"push $" #nr "-256 ; " \
 	"jmp common_interrupt");
 
-#if defined(CONFIG_X86_IO_APIC)
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
-	if (IO_APIC_IRQ(i))
-		send_IPI_self(IO_APIC_VECTOR(i));
-}
-#else
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
-#endif
-
 #define platform_legacy_irq(irq)	((irq) < 16)
 
 #endif
Index: linux-genirq.q/include/asm-xtensa/hw_irq.h
===================================================================
--- linux-genirq.q.orig/include/asm-xtensa/hw_irq.h
+++ linux-genirq.q/include/asm-xtensa/hw_irq.h
@@ -11,8 +11,4 @@
 #ifndef _XTENSA_HW_IRQ_H
 #define _XTENSA_HW_IRQ_H
 
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
-{
-}
-
 #endif
Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -53,6 +53,8 @@ struct hw_interrupt_type {
 	void		(*ack)(unsigned int irq);
 	void		(*end)(unsigned int irq);
 	void		(*set_affinity)(unsigned int irq, cpumask_t dest);
+	int		(*retrigger)(unsigned int irq);
+
 	/* Currently used only by UML, might disappear one day.*/
 #ifdef CONFIG_IRQ_RELEASE_METHOD
 	void		(*release)(unsigned int irq, void *dev_id);
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -123,7 +123,8 @@ void enable_irq(unsigned int irq)
 		desc->status = status;
 		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
 			desc->status = status | IRQ_REPLAY;
-			hw_resend_irq(desc->handler,irq);
+			if (desc->handler && desc->handler->retrigger)
+				desc->handler->retrigger(irq);
 		}
 		desc->handler->enable(irq);
 		/* fall-through */
