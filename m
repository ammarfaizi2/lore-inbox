Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWFTWcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWFTWcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWFTWbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:31:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43741 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751401AbWFTW3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH 17/25] x86_64 irq: Remove the msi assumption that irq == vector
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:30 -0600
Message-Id: <1150842524755-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <1150842524863-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com>
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
 arch/x86_64/kernel/io_apic.c |  147 +++++++++++++-----------------------------
 include/asm-x86_64/hw_irq.h  |    1 
 include/asm-x86_64/io_apic.h |   40 -----------
 include/asm-x86_64/irq.h     |    5 -
 4 files changed, 45 insertions(+), 148 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 7ad0980..1a63a0e 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -44,6 +44,8 @@ #include <asm/dma.h>
 #include <asm/nmi.h>
 #include <asm/msidef.h>
 
+static int assign_irq_vector(int irq);
+
 #define __apicdebuginit  __init
 
 int sis_apic_bug; /* not actually supported, dummy for compile */
@@ -83,14 +85,6 @@ static struct irq_pin_list {
 	short apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
-int vector_irq[NR_VECTORS] __read_mostly = { [0 ... NR_VECTORS - 1] = -1};
-#ifdef CONFIG_PCI_MSI
-#define vector_to_irq(vector) 	\
-	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
-#else
-#define vector_to_irq(vector)	(vector)
-#endif
-
 #define __DO_ACTION(R, ACTION, FINAL)					\
 									\
 {									\
@@ -135,7 +129,7 @@ static void set_ioapic_affinity_irq(unsi
 
 	spin_lock_irqsave(&ioapic_lock, flags);
 	__DO_ACTION(1, = dest, )
-	set_irq_info(irq, mask);
+	set_native_irq_info(irq, mask);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 #endif
@@ -834,18 +828,14 @@ static inline int IO_APIC_irq_trigger(in
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
@@ -860,10 +850,18 @@ next:
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
+	int vector;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vector_lock, flags);
+	vector = __assign_irq_vector(irq);
 	spin_unlock_irqrestore(&vector_lock, flags);
 
 	return vector;
@@ -879,18 +877,14 @@ #define IOAPIC_LEVEL	1
 
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
@@ -1110,17 +1104,12 @@ void __apicdebuginit print_IO_APIC(void)
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
@@ -1523,42 +1512,8 @@ static unsigned int startup_ioapic_irq(u
 	return was_pending;
 }
 
-static unsigned int startup_ioapic_vector(unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
-	return startup_ioapic_irq(irq);
-}
-
-static void mask_ioapic_vector (unsigned int vector)
+static int ioapic_retrigger_irq(unsigned int irq)
 {
-	int irq = vector_to_irq(vector);
-
-	mask_IO_APIC_irq(irq);
-}
-
-static void unmask_ioapic_vector (unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
-	unmask_IO_APIC_irq(irq);
-}
-
-#ifdef CONFIG_SMP
-static void set_ioapic_affinity_vector (unsigned int vector,
-					cpumask_t cpu_mask)
-{
-	int irq = vector_to_irq(vector);
-
-	set_native_irq_info(vector, cpu_mask);
-	set_ioapic_affinity_irq(irq, cpu_mask);
-}
-#endif // CONFIG_SMP
-
-static int ioapic_retrigger_vector(unsigned int vector)
-{
-	int irq = vector_to_irq(vector);
-
 	send_IPI_self(IO_APIC_VECTOR(irq));
 
 	return 1;
@@ -1605,15 +1560,15 @@ static void ack_apic_level(unsigned int 
 
 static struct irq_chip ioapic_chip __read_mostly = {
 	.name 		= "IO-APIC",
-	.startup 	= startup_ioapic_vector,
-	.mask	 	= mask_ioapic_vector,
-	.unmask	 	= unmask_ioapic_vector,
+	.startup 	= startup_ioapic_irq,
+	.mask	 	= mask_IO_APIC_irq,
+	.unmask	 	= unmask_IO_APIC_irq,
 	.ack 		= ack_apic_edge,
 	.eoi 		= ack_apic_level,
 #ifdef CONFIG_SMP
-	.set_affinity 	= set_ioapic_affinity_vector,
+	.set_affinity 	= set_ioapic_affinity_irq,
 #endif
-	.retrigger	= ioapic_retrigger_vector,
+	.retrigger	= ioapic_retrigger_irq,
 };
 
 static inline void init_IO_APIC_traps(void)
@@ -1633,11 +1588,6 @@ static inline void init_IO_APIC_traps(vo
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
@@ -2014,34 +1964,31 @@ static int __init ioapic_init_sysfs(void
 
 device_initcall(ioapic_init_sysfs);
 
-#ifdef CONFIG_PCI_MSI
 /*
- * Dynamic irq allocate and deallocation for MSI
+ * Dynamic irq allocate and deallocation
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
@@ -2050,17 +1997,13 @@ int create_irq(void)
 void destroy_irq(unsigned int irq)
 {
 	unsigned long flags;
-	unsigned int vector;
 
 	dynamic_irq_cleanup(irq);
 
 	spin_lock_irqsave(&vector_lock, flags);
-	vector = irq_vector[irq];
-	vector_irq[vector] = -1;
 	irq_vector[irq] = 0;
 	spin_unlock_irqrestore(&vector_lock, flags);
 }
-#endif
 
 /*
  * MSI mesage composition
@@ -2216,7 +2159,7 @@ int io_apic_set_pci_routing (int ioapic,
 	spin_lock_irqsave(&ioapic_lock, flags);
 	io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
 	io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
-	set_native_irq_info(use_pci_vector() ?  entry.vector : irq, TARGET_CPUS);
+	set_native_irq_info(irq, TARGET_CPUS);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return 0;
diff --git a/include/asm-x86_64/hw_irq.h b/include/asm-x86_64/hw_irq.h
index f5da94a..1a8dc18 100644
--- a/include/asm-x86_64/hw_irq.h
+++ b/include/asm-x86_64/hw_irq.h
@@ -75,7 +75,6 @@ #define FIRST_SYSTEM_VECTOR	0xef   /* du
 #ifndef __ASSEMBLY__
 extern u8 irq_vector[NR_IRQ_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
-#define AUTO_ASSIGN		-1
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
diff --git a/include/asm-x86_64/io_apic.h b/include/asm-x86_64/io_apic.h
index fb7a090..2885bea 100644
--- a/include/asm-x86_64/io_apic.h
+++ b/include/asm-x86_64/io_apic.h
@@ -12,45 +12,7 @@ #include <asm/mpspec.h>
 
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
 static inline int use_pci_vector(void)	{return 0;}
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
 
 #define APIC_MISMATCH_DEBUG
 
@@ -213,8 +175,6 @@ #else  /* !CONFIG_X86_IO_APIC */
 #define io_apic_assign_pci_irqs 0
 #endif
 
-extern int assign_irq_vector(int irq);
-
 void enable_NMI_through_LVT0 (void * dummy);
 
 extern spinlock_t i8259A_lock;
diff --git a/include/asm-x86_64/irq.h b/include/asm-x86_64/irq.h
index 9db5a1b..0c8d570 100644
--- a/include/asm-x86_64/irq.h
+++ b/include/asm-x86_64/irq.h
@@ -31,13 +31,8 @@ #define NR_VECTORS 256
 
 #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
 
-#ifdef CONFIG_PCI_MSI
-#define NR_IRQS FIRST_SYSTEM_VECTOR
-#define NR_IRQ_VECTORS NR_IRQS
-#else
 #define NR_IRQS 224
 #define NR_IRQ_VECTORS (32 * NR_CPUS)
-#endif
 
 static __inline__ int irq_canonicalize(int irq)
 {
-- 
1.4.0.gc07e

