Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760121AbWLFFPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760121AbWLFFPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760123AbWLFFPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:15:11 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:35685 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760121AbWLFFPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:15:08 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: parisc-linux@parisc-linux.org, Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH 3/3] Convert parisc to generic irq handling
Date: Tue,  5 Dec 2006 22:15:07 -0700
Message-Id: <11653821072923-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165382107889-git-send-email-matthew@wil.cx>
References: <11653821071704-git-send-email-matthew@wil.cx> <1165382107889-git-send-email-matthew@wil.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also make use of the specific ability to template interrupts for the
timer and IPI interrupts.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

Updated for pt_regs changes

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 arch/parisc/kernel/irq.c          |   23 ++++++++++-------------
 drivers/parisc/iosapic.c          |    7 +++----
 include/asm-parisc/irq-handlers.h |   15 +++++++++++++++
 include/asm-parisc/irq.h          |   21 +++++++++++++++++++--
 4 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index b39c5b9..2a929a2 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -35,9 +35,6 @@
 
 #undef PARISC_IRQ_CR16_COUNTS
 
-extern irqreturn_t timer_interrupt(int, void *);
-extern irqreturn_t ipi_interrupt(int, void *);
-
 #define EIEM_MASK(irq)       (1UL<<(CPU_IRQ_MAX - irq))
 
 /* Bits in EIEM correlate with cpu_irq_action[].
@@ -88,7 +85,7 @@ static unsigned int cpu_startup_irq(unsi
 void no_ack_irq(unsigned int irq) { }
 void no_end_irq(unsigned int irq) { }
 
-void cpu_ack_irq(unsigned int irq)
+void cpu_ack_irq(struct irq_desc *dummy, unsigned int irq)
 {
 	unsigned long mask = EIEM_MASK(irq);
 	int cpu = smp_processor_id();
@@ -105,7 +102,7 @@ void cpu_ack_irq(unsigned int irq)
 	mtctl(mask, 23);
 }
 
-void cpu_end_irq(unsigned int irq)
+void cpu_end_irq(struct irq_desc *dummy, unsigned int irq)
 {
 	unsigned long mask = EIEM_MASK(irq);
 	int cpu = smp_processor_id();
@@ -155,8 +152,6 @@ static struct hw_interrupt_type cpu_inte
 	.shutdown	= cpu_disable_irq,
 	.enable		= cpu_enable_irq,
 	.disable	= cpu_disable_irq,
-	.ack		= cpu_ack_irq,
-	.end		= cpu_end_irq,
 #ifdef CONFIG_SMP
 	.set_affinity	= cpu_set_affinity_irq,
 #endif
@@ -253,8 +248,8 @@ int cpu_claim_irq(unsigned int irq, stru
 		return -EBUSY;
 
 	if (type) {
-		irq_desc[irq].chip = type;
-		irq_desc[irq].chip_data = data;
+		set_irq_chip(irq, type);
+		set_irq_chip_data(irq, data);
 		cpu_interrupt_type.enable(irq);
 	}
 	return 0;
@@ -377,7 +372,7 @@ void do_cpu_irq_mask(struct pt_regs *reg
 		goto set_out;
 	}
 #endif
-	__do_IRQ(irq);
+	generic_handle_irq(irq);
 
  out:
 	irq_exit();
@@ -406,15 +401,17 @@ static struct irqaction ipi_action = {
 static void claim_cpu_irqs(void)
 {
 	int i;
-	for (i = CPU_IRQ_BASE; i <= CPU_IRQ_MAX; i++) {
-		irq_desc[i].chip = &cpu_interrupt_type;
-	}
+	for (i = CPU_IRQ_BASE; i <= CPU_IRQ_MAX; i++)
+		set_irq_chip_and_handler(i, &cpu_interrupt_type,
+					 handle_level_irq_chip);
 
 	irq_desc[TIMER_IRQ].action = &timer_action;
 	irq_desc[TIMER_IRQ].status |= IRQ_PER_CPU;
+	set_irq_handler(TIMER_IRQ, handle_specific_irq_timer);
 #ifdef CONFIG_SMP
 	irq_desc[IPI_IRQ].action = &ipi_action;
 	irq_desc[IPI_IRQ].status = IRQ_PER_CPU;
+	set_irq_handler(IPI_IRQ, handle_specific_irq_ipi);
 #endif
 }
 
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 12bab64..4e9f660 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -686,13 +686,13 @@ printk("\n");
  * i386/ia64 support ISA devices and have to deal with
  * edge-triggered interrupts too.
  */
-static void iosapic_end_irq(unsigned int irq)
+void iosapic_end_irq(struct irq_desc *dummy, unsigned int irq)
 {
 	struct vector_info *vi = iosapic_get_vector(irq);
 	DBG(KERN_DEBUG "end_irq(%d): eoi(%p, 0x%x)\n", irq,
 			vi->eoi_addr, vi->eoi_data);
 	iosapic_eoi(vi->eoi_addr, vi->eoi_data);
-	cpu_end_irq(irq);
+	cpu_end_irq(NULL, irq);
 }
 
 static unsigned int iosapic_startup_irq(unsigned int irq)
@@ -729,8 +729,6 @@ static struct hw_interrupt_type iosapic_
 	.shutdown =	iosapic_disable_irq,
 	.enable =	iosapic_enable_irq,
 	.disable =	iosapic_disable_irq,
-	.ack =		cpu_ack_irq,
-	.end =		iosapic_end_irq,
 #ifdef CONFIG_SMP
 	.set_affinity =	iosapic_set_affinity_irq,
 #endif
@@ -819,6 +817,7 @@ int iosapic_fixup_irq(void *isi_obj, str
 	vi->eoi_data = cpu_to_le32(vi->txn_data);
 
 	cpu_claim_irq(vi->txn_irq, &iosapic_interrupt_type, vi);
+	set_irq_handler(vi->txn_irq, handle_level_irq_iosapic);
 
  out:
 	pcidev->irq = vi->txn_irq;
diff --git a/include/asm-parisc/irq-handlers.h b/include/asm-parisc/irq-handlers.h
new file mode 100644
index 0000000..95a9d1b
--- /dev/null
+++ b/include/asm-parisc/irq-handlers.h
@@ -0,0 +1,8 @@
+HANDLE_LEVEL_IRQ(_chip, cpu_ack_irq, cpu_end_irq)
+HANDLE_SPECIFIC_IRQ(_timer, cpu_ack_irq, cpu_end_irq, timer_interrupt)
+#ifdef CONFIG_SMP
+HANDLE_SPECIFIC_IRQ(_ipi, cpu_ack_irq, cpu_end_irq, ipi_interrupt)
+#endif
+#ifdef CONFIG_IOSAPIC
+HANDLE_LEVEL_IRQ(_iosapic, cpu_ack_irq, iosapic_end_irq)
+#endif
diff --git a/include/asm-parisc/irq.h b/include/asm-parisc/irq.h
index 399c819..ae29629 100644
--- a/include/asm-parisc/irq.h
+++ b/include/asm-parisc/irq.h
@@ -8,6 +8,7 @@
 #define _ASM_PARISC_IRQ_H
 
 #include <linux/cpumask.h>
+#include <linux/irqreturn.h>
 #include <asm/types.h>
 
 #define NO_IRQ		(-1)
@@ -26,6 +27,17 @@
 
 #define NR_IRQS		(CPU_IRQ_MAX + 1)
 
+#define ARCH_HAS_IRQ_HANDLERS
+
+struct irq_desc;
+
+void fastcall handle_level_irq_chip(unsigned int irq, struct irq_desc *desc);
+void fastcall handle_level_irq_iosapic(unsigned int irq, struct irq_desc *desc);
+void fastcall handle_percpu_irq_chip(unsigned int irq, struct irq_desc *desc);
+void fastcall handle_specific_irq_timer(unsigned int irq,
+					struct irq_desc *desc);
+void fastcall handle_specific_irq_ipi(unsigned int irq, struct irq_desc *desc);
+
 static __inline__ int irq_canonicalize(int irq)
 {
 	return (irq == 2) ? 9 : irq;
@@ -39,8 +51,9 @@ struct irq_chip;
  */
 void no_ack_irq(unsigned int irq);
 void no_end_irq(unsigned int irq);
-void cpu_ack_irq(unsigned int irq);
-void cpu_end_irq(unsigned int irq);
+void cpu_ack_irq(struct irq_desc *, unsigned int irq);
+void cpu_end_irq(struct irq_desc *, unsigned int irq);
+void iosapic_end_irq(struct irq_desc *, unsigned int irq);
 
 extern int txn_alloc_irq(unsigned int nbits);
 extern int txn_claim_irq(int);
@@ -51,6 +64,10 @@ extern unsigned long txn_affinity_addr(u
 extern int cpu_claim_irq(unsigned int irq, struct irq_chip *, void *);
 extern int cpu_check_affinity(unsigned int irq, cpumask_t *dest);
 
+/* Prototypes for the two directly called interrupts */
+extern irqreturn_t timer_interrupt(int, void *);
+extern irqreturn_t ipi_interrupt(int, void *);
+
 /* soft power switch support (power.c) */
 extern struct tasklet_struct power_tasklet;
 
-- 
1.4.3.3

