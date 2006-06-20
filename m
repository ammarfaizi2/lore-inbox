Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWFTWcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWFTWcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWFTWbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:31:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43997 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751398AbWFTW3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:24 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 18/25] i386 irq: Remove the msi assumption that irq == vector
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:31 -0600
Message-Id: <115084252460-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <1150842524755-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the change in behavior of the irq allocation
code when CONFIG_PCI_MSI is defined.  Removing all instances
of the assumption that irq == vector.

create_irq is rewritten to first allocate a free irq and then to
assign that irq a vector.

assign_irq_vector is made static and the AUTO_ASSIGN case which
allocates an vector not bound to an irq is removed.

The ioapic vector methods are removed, and everything now
works with irqs.

The definition of NR_IRQS no longer depends on CONFIG_PCI_MSI

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/acpi/boot.c                       |    7 -
 arch/i386/kernel/io_apic.c                         |  171 +++++---------------
 arch/i386/pci/irq.c                                |    4 
 include/asm-i386/hw_irq.h                          |    1 
 include/asm-i386/io_apic.h                         |   42 -----
 include/asm-i386/mach-default/irq_vectors_limits.h |    5 -
 include/asm-x86_64/io_apic.h                       |    2 
 7 files changed, 47 insertions(+), 185 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 107018b..6e7edc0 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -459,12 +459,7 @@ void __init acpi_pic_sci_set_trigger(uns
 
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-#ifdef CONFIG_X86_IO_APIC
-	if (use_pci_vector() && !platform_legacy_irq(gsi))
-		*irq = IO_APIC_VECTOR(gsi);
-	else
-#endif
-		*irq = gsi_irq_sharing(gsi);
+	*irq = gsi_irq_sharing(gsi);
 	return 0;
 }
 
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 68af125..18a5c2a 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -89,14 +89,6 @@ static struct irq_pin_list {
 	int apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
-int vector_irq[NR_VECTORS] __read_mostly = { [0 ... NR_VECTORS - 1] = -1};
-#ifdef CONFIG_PCI_MSI
-#define vector_to_irq(vector) 	\
-	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
-#else
-#define vector_to_irq(vector)	(vector)
-#endif
-
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -262,7 +254,7 @@ static void set_ioapic_affinity_irq(unsi
 			break;
 		entry = irq_2_pin + entry->next;
 	}
-	set_irq_info(irq, cpumask);
+	set_native_irq_info(irq, cpumask);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -1163,18 +1155,14 @@ static inline int IO_APIC_irq_trigger(in
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
 
-int assign_irq_vector(int irq)
+static int __assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	unsigned long flags;
 	int vector;
 
-	BUG_ON(irq != AUTO_ASSIGN && (unsigned)irq >= NR_IRQ_VECTORS);
-
-	spin_lock_irqsave(&vector_lock, flags);
+	BUG_ON((unsigned)irq >= NR_IRQ_VECTORS);
 
-	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0) {
-		spin_unlock_irqrestore(&vector_lock, flags);
+	if (IO_APIC_VECTOR(irq) > 0) {
 		return IO_APIC_VECTOR(irq);
 	}
 next:
@@ -1192,15 +1180,22 @@ next:
 	}
 
 	vector = current_vector;
-	vector_irq[vector] = irq;
-	if (irq != AUTO_ASSIGN)
-		IO_APIC_VECTOR(irq) = vector;
+	IO_APIC_VECTOR(irq) = vector;
 
+	return vector;
+}
+
+static int assign_irq_vector(int irq)
+{
+	unsigned long flags;
+	int vector;
+
+	spin_lock_irqsave(&vector_lock, flags);
+	vector = __assign_irq_vector(irq);
 	spin_unlock_irqrestore(&vector_lock, flags);
 
 	return vector;
 }
-
 static struct irq_chip ioapic_chip;
 
 #define IOAPIC_AUTO	-1
@@ -1209,18 +1204,14 @@ #define IOAPIC_LEVEL	1
 
 static void ioapic_register_intr(int irq, int vector, unsigned long trigger)
 {
-	unsigned idx;
-
-	idx = use_pci_vector() && !platform_legacy_irq(irq) ? vector : irq;
-
 	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 			trigger == IOAPIC_LEVEL)
-		set_irq_chip_and_handler(idx, &ioapic_chip,
+		set_irq_chip_and_handler(irq, &ioapic_chip,
 					 handle_fasteoi_irq);
 	else
-		set_irq_chip_and_handler(idx, &ioapic_chip,
+		set_irq_chip_and_handler(irq, &ioapic_chip,
 					 handle_edge_irq);
-	set_intr_gate(vector, interrupt[idx]);
+	set_intr_gate(vector, interrupt[irq]);
 }
 
 static void __init setup_IO_APIC_irqs(void)
@@ -1473,17 +1464,12 @@ void __init print_IO_APIC(void)
 		);
 	}
 	}
-	if (use_pci_vector())
-		printk(KERN_INFO "Using vector-based indexing\n");
 	printk(KERN_DEBUG "IRQ to pin mappings:\n");
 	for (i = 0; i < NR_IRQS; i++) {
 		struct irq_pin_list *entry = irq_2_pin + i;
 		if (entry->pin < 0)
 			continue;
- 		if (use_pci_vector() && !platform_legacy_irq(i))
-			printk(KERN_DEBUG "IRQ%d ", IO_APIC_VECTOR(i));
-		else
-			printk(KERN_DEBUG "IRQ%d ", i);
+		printk(KERN_DEBUG "IRQ%d ", i);
 		for (;;) {
 			printk("-> %d:%d", entry->apic, entry->pin);
 			if (!entry->next)
@@ -1950,7 +1936,7 @@ static unsigned int startup_ioapic_irq(u
 
 static void ack_ioapic_irq(unsigned int irq)
 {
-	move_irq(irq);
+	move_native_irq(irq);
 	ack_APIC_irq();
 }
 
@@ -1959,7 +1945,7 @@ static void ack_ioapic_quirk_irq(unsigne
 	unsigned long v;
 	int i;
 
-	move_irq(irq);
+	move_native_irq(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various
@@ -1994,63 +1980,8 @@ static void ack_ioapic_quirk_irq(unsigne
 	}
 }
 
-static unsigned int startup_ioapic_vector(unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
-	return startup_ioapic_irq(irq);
-}
-
-static void ack_ioapic_vector(unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
-	move_native_irq(vector);
-	ack_ioapic_irq(irq);
-}
-
-static void ack_ioapic_quirk_vector(unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
-	move_native_irq(vector);
-	ack_ioapic_quirk_irq(irq);
-}
-
-static void mask_IO_APIC_vector (unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
-	mask_IO_APIC_irq(irq);
-}
-
-static void unmask_IO_APIC_vector (unsigned int vector)
+static int ioapic_retrigger_irq(unsigned int irq)
 {
-	int irq = vector_to_irq(vector);
-
-	unmask_IO_APIC_irq(irq);
-}
-
-/*
- * Oh just glorious.  If CONFIG_PCI_MSI we've done
- * #define set_ioapic_affinity set_ioapic_affinity_vector
- */
-#if defined (CONFIG_SMP) && defined(CONFIG_X86_IO_APIC) && \
-		defined(CONFIG_PCI_MSI)
-static void set_ioapic_affinity_vector (unsigned int vector,
-					cpumask_t cpu_mask)
-{
-	int irq = vector_to_irq(vector);
-
-	set_native_irq_info(vector, cpu_mask);
-	set_ioapic_affinity_irq(irq, cpu_mask);
-}
-#endif
-
-static int ioapic_retrigger_vector(unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
 	send_IPI_self(IO_APIC_VECTOR(irq));
 
 	return 1;
@@ -2058,15 +1989,15 @@ static int ioapic_retrigger_vector(unsig
 
 static struct irq_chip ioapic_chip __read_mostly = {
 	.name 		= "IO-APIC",
-	.startup 	= startup_ioapic_vector,
-	.mask	 	= mask_IO_APIC_vector,
-	.unmask	 	= unmask_IO_APIC_vector,
-	.ack 		= ack_ioapic_vector,
-	.eoi 		= ack_ioapic_quirk_vector,
+	.startup 	= startup_ioapic_irq,
+	.mask	 	= mask_IO_APIC_irq,
+	.unmask	 	= unmask_IO_APIC_irq,
+	.ack 		= ack_ioapic_irq,
+	.eoi 		= ack_ioapic_quirk_irq,
 #ifdef CONFIG_SMP
-	.set_affinity 	= set_ioapic_affinity,
+	.set_affinity 	= set_ioapic_affinity_irq,
 #endif
-	.retrigger	= ioapic_retrigger_vector,
+	.retrigger	= ioapic_retrigger_irq,
 };
 
 
@@ -2087,11 +2018,6 @@ static inline void init_IO_APIC_traps(vo
 	 */
 	for (irq = 0; irq < NR_IRQS ; irq++) {
 		int tmp = irq;
-		if (use_pci_vector()) {
-			if (!platform_legacy_irq(tmp))
-				if ((tmp = vector_to_irq(tmp)) == -1)
-					continue;
-		}
 		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
 			/*
 			 * Hmm.. We don't have an entry for this,
@@ -2505,28 +2431,26 @@ #ifdef CONFIG_PCI_MSI
  */
 int create_irq(void)
 {
-	/* Hack of the day: irq == vector.
-	 *
-	 * Ultimately this will be be more general,
-	 * and not depend on the irq to vector identity mapping.
-	 * But this version is needed until msi.c can cope with
-	 * the more general form.
-	 */
-	int irq, vector;
+	/* Allocate an unused irq */
+	int irq, new, vector;
 	unsigned long flags;
-	vector = assign_irq_vector(AUTO_ASSIGN);
-	irq = vector;
 
-	if (vector >= 0) {
-		struct irq_desc *desc;
+	irq = -ENOSPC;
+	spin_lock_irqsave(&vector_lock, flags);
+	for (new = (NR_IRQS - 1); new >= 0; new--) {
+		if (platform_legacy_irq(new))
+			continue;
+		if (irq_vector[new] != 0)
+			continue;
+		vector = __assign_irq_vector(new);
+		if (likely(vector > 0))
+			irq = new;
+		break;
+	}
+	spin_unlock_irqrestore(&vector_lock, flags);
 
-		spin_lock_irqsave(&vector_lock, flags);
-		vector_irq[vector] = irq;
-		irq_vector[irq] = vector;
-		spin_unlock_irqrestore(&vector_lock, flags);
-		
+	if (irq >= 0) {
 		set_intr_gate(vector, interrupt[irq]);
-
 		dynamic_irq_init(irq);
 	}
 	return irq;
@@ -2535,13 +2459,10 @@ int create_irq(void)
 void destroy_irq(unsigned int irq)
 {
 	unsigned long flags;
-	unsigned int vector;
 
 	dynmic_irq_cleanup(irq);
 
 	spin_lock_irqsave(&vector_lock, flags);
-	vector = irq_vector[irq];
-	vector_irq[vector] = -1;
 	irq_vector[irq] = 0;
 	spin_unlock_irqrestore(&vector_lock, flags);
 }
@@ -2769,7 +2690,7 @@ int io_apic_set_pci_routing (int ioapic,
 	spin_lock_irqsave(&ioapic_lock, flags);
 	io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
 	io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
-	set_native_irq_info(use_pci_vector() ? entry.vector : irq, TARGET_CPUS);
+	set_native_irq_info(irq, TARGET_CPUS);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return 0;
diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index 768584d..54a72ca 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -982,10 +982,6 @@ #ifdef CONFIG_X86_IO_APIC
 							pci_name(bridge), 'A' + pin, irq);
 				}
 				if (irq >= 0) {
-					if (use_pci_vector() &&
-						!platform_legacy_irq(irq))
-						irq = IO_APIC_VECTOR(irq);
-
 					printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
 						pci_name(dev), 'A' + pin, irq);
 					dev->irq = irq;
diff --git a/include/asm-i386/hw_irq.h b/include/asm-i386/hw_irq.h
index 00988e8..5a72436 100644
--- a/include/asm-i386/hw_irq.h
+++ b/include/asm-i386/hw_irq.h
@@ -26,7 +26,6 @@ #include <asm/sections.h>
 
 extern u8 irq_vector[NR_IRQ_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
-#define AUTO_ASSIGN		-1
 
 extern void (*interrupt[NR_IRQS])(void);
 
diff --git a/include/asm-i386/io_apic.h b/include/asm-i386/io_apic.h
index 5092e81..3909524 100644
--- a/include/asm-i386/io_apic.h
+++ b/include/asm-i386/io_apic.h
@@ -12,46 +12,6 @@ #include <asm/mpspec.h>
 
 #ifdef CONFIG_X86_IO_APIC
 
-#ifdef CONFIG_PCI_MSI
-static inline int use_pci_vector(void)	{return 1;}
-static inline void disable_edge_ioapic_vector(unsigned int vector) { }
-static inline void mask_and_ack_level_ioapic_vector(unsigned int vector) { }
-static inline void end_edge_ioapic_vector (unsigned int vector) { }
-#define startup_level_ioapic	startup_level_ioapic_vector
-#define shutdown_level_ioapic	mask_IO_APIC_vector
-#define enable_level_ioapic	unmask_IO_APIC_vector
-#define disable_level_ioapic	mask_IO_APIC_vector
-#define mask_and_ack_level_ioapic mask_and_ack_level_ioapic_vector
-#define end_level_ioapic	end_level_ioapic_vector
-#define set_ioapic_affinity	set_ioapic_affinity_vector
-
-#define startup_edge_ioapic 	startup_edge_ioapic_vector
-#define shutdown_edge_ioapic 	disable_edge_ioapic_vector
-#define enable_edge_ioapic 	unmask_IO_APIC_vector
-#define disable_edge_ioapic 	disable_edge_ioapic_vector
-#define ack_edge_ioapic 	ack_edge_ioapic_vector
-#define end_edge_ioapic 	end_edge_ioapic_vector
-#else
-static inline int use_pci_vector(void)	{return 0;}
-static inline void disable_edge_ioapic_irq(unsigned int irq) { }
-static inline void mask_and_ack_level_ioapic_irq(unsigned int irq) { }
-static inline void end_edge_ioapic_irq (unsigned int irq) { }
-#define startup_level_ioapic	startup_level_ioapic_irq
-#define shutdown_level_ioapic	mask_IO_APIC_irq
-#define enable_level_ioapic	unmask_IO_APIC_irq
-#define disable_level_ioapic	mask_IO_APIC_irq
-#define mask_and_ack_level_ioapic mask_and_ack_level_ioapic_irq
-#define end_level_ioapic	end_level_ioapic_irq
-#define set_ioapic_affinity	set_ioapic_affinity_irq
-
-#define startup_edge_ioapic 	startup_edge_ioapic_irq
-#define shutdown_edge_ioapic 	disable_edge_ioapic_irq
-#define enable_edge_ioapic 	unmask_IO_APIC_irq
-#define disable_edge_ioapic 	disable_edge_ioapic_irq
-#define ack_edge_ioapic 	ack_edge_ioapic_irq
-#define end_edge_ioapic 	end_edge_ioapic_irq
-#endif
-
 #define IO_APIC_BASE(idx) \
 		((volatile int *)(__fix_to_virt(FIX_IO_APIC_BASE_0 + idx) \
 		+ (mp_ioapics[idx].mpc_apicaddr & ~PAGE_MASK)))
@@ -208,6 +168,4 @@ #else  /* !CONFIG_X86_IO_APIC */
 #define io_apic_assign_pci_irqs 0
 #endif
 
-extern int assign_irq_vector(int irq);
-
 #endif
diff --git a/include/asm-i386/mach-default/irq_vectors_limits.h b/include/asm-i386/mach-default/irq_vectors_limits.h
index b330026..7f161e7 100644
--- a/include/asm-i386/mach-default/irq_vectors_limits.h
+++ b/include/asm-i386/mach-default/irq_vectors_limits.h
@@ -1,10 +1,6 @@
 #ifndef _ASM_IRQ_VECTORS_LIMITS_H
 #define _ASM_IRQ_VECTORS_LIMITS_H
 
-#ifdef CONFIG_PCI_MSI
-#define NR_IRQS FIRST_SYSTEM_VECTOR
-#define NR_IRQ_VECTORS NR_IRQS
-#else
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
 # if (224 >= 32 * NR_CPUS)
@@ -16,6 +12,5 @@ #else
 #define NR_IRQS 16
 #define NR_IRQ_VECTORS NR_IRQS
 #endif
-#endif
 
 #endif /* _ASM_IRQ_VECTORS_LIMITS_H */
diff --git a/include/asm-x86_64/io_apic.h b/include/asm-x86_64/io_apic.h
index 2885bea..06806b1 100644
--- a/include/asm-x86_64/io_apic.h
+++ b/include/asm-x86_64/io_apic.h
@@ -12,8 +12,6 @@ #include <asm/mpspec.h>
 
 #ifdef CONFIG_X86_IO_APIC
 
-static inline int use_pci_vector(void)	{return 0;}
-
 #define APIC_MISMATCH_DEBUG
 
 #define IO_APIC_BASE(idx) \
-- 
1.4.0.gc07e

