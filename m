Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTJAPX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbTJAPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:23:56 -0400
Received: from fmr06.intel.com ([134.134.136.7]:40115 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262345AbTJAPVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:21:34 -0400
Date: Wed, 1 Oct 2003 08:37:02 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200310011537.h91Fb2am002628@snoqualmie.dp.intel.com>
To: jun.nakajima@intel.com, linux-kernel@vger.kernel.org,
       linux-pci@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Updated MSI Patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an updated version of the MSI patch based on kernel linux-2.6.0-test5.
Thanks for all the input received from the community, below patches include
the following changes from the previous patches, which are based on kernel
linux-2.6.0-test2:

- Reconstructing a vector-base patch.
- Adding a new API "int pci_enable_msi(struct pci_dev *dev)" based on the
input from the community to handle buggy PCI/PCI-X hardware when MSI is 
enabled. Any MSI/MSI-X capable device driver, which wants to have MSI enabled
on its hardware device, must call this API to request for MSI mode.
- Adding a set_msi_affinity feature.
- Adding a feature, which dynamically detects any MSI/MSI-X capable devices 
and establishes a reserved policy to ensure that no MSI-X device driver can
claim all available vectors.
- Resolving issue with kernel build when configuring system in UP mode without
setting CONFIG_X86_LOCAL_APIC to 'Y'. This solution provides MSI support
independent from IOxAPICs (IOxAPIC free).
- Renaming pci_msi.c to msi.c and moving this file under ../drivers/pci to 
have code share as much as possible across all Linux architectures.
- Replacing all direct memory access with readl/writel.
- Using kmem_cache instead of kmalloc to allocate msi_desc entries.
- Putting the EXPORT_SYMBOL in the file msi.c
- Removing boot parameters "pci_nomsi", "device_msi=", and "device_nomsi=".

Thanks,
Long

----------------------------------------------------------------------------
diff -urN linux-2.6.0-test5/arch/i386/Kconfig linux-260t5-vectorbase-testbox/arch/i386/Kconfig
--- linux-2.6.0-test5/arch/i386/Kconfig	2003-09-08 15:49:53.000000000 -0400
+++ linux-260t5-vectorbase-testbox/arch/i386/Kconfig	2003-09-24 08:11:43.000000000 -0400
@@ -1086,6 +1086,17 @@
  	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS)
 	default y
 
+config PCI_USE_VECTOR
+	bool "PCI_USE_VECTOR"
+	default n
+	help
+	   This replaces the current existing IRQ-based index interrupt scheme
+	   with the vector-base index scheme. The advantages of vector base over	   IRQ base are listed below:
+	   1) Support MSI implementation.
+	   2) Support future IOxAPIC hotplug
+
+	   If you don't know what to do here, say N.
+
 source "drivers/pci/Kconfig"
 
 config ISA
diff -urN linux-2.6.0-test5/arch/i386/kernel/i8259.c linux-260t5-vectorbase-testbox/arch/i386/kernel/i8259.c
--- linux-2.6.0-test5/arch/i386/kernel/i8259.c	2003-09-08 15:50:28.000000000 -0400
+++ linux-260t5-vectorbase-testbox/arch/i386/kernel/i8259.c	2003-09-24 08:11:43.000000000 -0400
@@ -419,8 +419,10 @@
 	 * us. (some of these will be overridden and become
 	 * 'special' SMP interrupts)
 	 */
-	for (i = 0; i < NR_IRQS; i++) {
+	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
+		if (i >= NR_IRQS)
+			break;
 		if (vector != SYSCALL_VECTOR) 
 			set_intr_gate(vector, interrupt[i]);
 	}
diff -urN linux-2.6.0-test5/arch/i386/kernel/io_apic.c linux-260t5-vectorbase-testbox/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test5/arch/i386/kernel/io_apic.c	2003-09-08 15:50:01.000000000 -0400
+++ linux-260t5-vectorbase-testbox/arch/i386/kernel/io_apic.c	2003-09-25 07:29:13.000000000 -0400
@@ -76,6 +76,14 @@
 	int apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
+#ifdef CONFIG_PCI_USE_VECTOR
+int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
+#define vector_to_irq(vector) 	\
+	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
+#else
+#define vector_to_irq(vector)	(vector)
+#endif
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -249,7 +257,7 @@
 			clear_IO_APIC_pin(apic, pin);
 }
 
-static void set_ioapic_affinity(unsigned int irq, cpumask_t cpumask)
+static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t cpumask)
 {
 	unsigned long flags;
 	int pin;
@@ -670,13 +678,13 @@
 
 __setup("noirqbalance", irqbalance_disable);
 
-static void set_ioapic_affinity(unsigned int irq, cpumask_t mask);
+static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask);
 
 static inline void move_irq(int irq)
 {
 	/* note - we hold the desc->lock */
 	if (unlikely(!cpus_empty(pending_irq_balance_cpumask[irq]))) {
-		set_ioapic_affinity(irq, pending_irq_balance_cpumask[irq]);
+		set_ioapic_affinity_irq(irq, pending_irq_balance_cpumask[irq]);
 		cpus_clear(pending_irq_balance_cpumask[irq]);
 	}
 }
@@ -853,7 +861,7 @@
 			if (irq_entry == -1)
 				continue;
 			irq = pin_2_irq(irq_entry, ioapic, pin);
-			set_ioapic_affinity(irq, mask);
+			set_ioapic_affinity_irq(irq, mask);
 		}
 
 	}
@@ -1143,8 +1151,10 @@
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	if (IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
+	int vector;
+
+	if ((vector = IO_APIC_VECTOR(irq)) > 0)
+		return vector;
 next:
 	current_vector += 8;
 	if (current_vector == SYSCALL_VECTOR)
@@ -1155,12 +1165,40 @@
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
+#ifdef CONFIG_PCI_USE_VECTOR
+	vector_irq[current_vector] = irq;
+#endif
+	
 	IO_APIC_VECTOR(irq) = current_vector;
+
 	return current_vector;
 }
 
-static struct hw_interrupt_type ioapic_level_irq_type;
-static struct hw_interrupt_type ioapic_edge_irq_type;
+static struct hw_interrupt_type ioapic_level_type;
+static struct hw_interrupt_type ioapic_edge_type;
+
+#define IOAPIC_AUTO	-1
+#define IOAPIC_EDGE	0
+#define IOAPIC_LEVEL	1
+
+static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
+{
+	if (use_pci_vector() && !platform_legacy_irq(irq)) {
+		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
+				trigger == IOAPIC_LEVEL)
+			irq_desc[vector].handler = &ioapic_level_type;
+		else
+			irq_desc[vector].handler = &ioapic_edge_type;
+		set_intr_gate(vector, interrupt[vector]);
+	} else	{
+		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
+				trigger == IOAPIC_LEVEL)
+			irq_desc[irq].handler = &ioapic_level_type;
+		else
+			irq_desc[irq].handler = &ioapic_edge_type;
+		set_intr_gate(vector, interrupt[irq]);
+	}
+}
 
 void __init setup_IO_APIC_irqs(void)
 {
@@ -1218,13 +1256,7 @@
 		if (IO_APIC_IRQ(irq)) {
 			vector = assign_irq_vector(irq);
 			entry.vector = vector;
-
-			if (IO_APIC_irq_trigger(irq))
-				irq_desc[irq].handler = &ioapic_level_irq_type;
-			else
-				irq_desc[irq].handler = &ioapic_edge_irq_type;
-
-			set_intr_gate(vector, interrupt[irq]);
+			ioapic_register_intr(irq, vector, IOAPIC_AUTO);
 		
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
@@ -1271,7 +1303,7 @@
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
-	irq_desc[0].handler = &ioapic_edge_irq_type;
+	irq_desc[0].handler = &ioapic_edge_type;
 
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -1757,9 +1789,6 @@
  * that was delayed but this is now handled in the device
  * independent code.
  */
-#define enable_edge_ioapic_irq unmask_IO_APIC_irq
-
-static void disable_edge_ioapic_irq (unsigned int irq) { /* nothing */ }
 
 /*
  * Starting up a edge-triggered IO-APIC interrupt is
@@ -1770,7 +1799,6 @@
  * This is not complete - we should be able to fake
  * an edge even if it isn't on the 8259A...
  */
-
 static unsigned int startup_edge_ioapic_irq(unsigned int irq)
 {
 	int was_pending = 0;
@@ -1788,8 +1816,6 @@
 	return was_pending;
 }
 
-#define shutdown_edge_ioapic_irq	disable_edge_ioapic_irq
-
 /*
  * Once we have recorded IRQ_PENDING already, we can mask the
  * interrupt for real. This prevents IRQ storms from unhandled
@@ -1804,9 +1830,6 @@
 	ack_APIC_irq();
 }
 
-static void end_edge_ioapic_irq (unsigned int i) { /* nothing */ }
-
-
 /*
  * Level triggered interrupts can just be masked,
  * and shutting down and starting up the interrupt
@@ -1828,10 +1851,6 @@
 	return 0; /* don't check for pending */
 }
 
-#define shutdown_level_ioapic_irq	mask_IO_APIC_irq
-#define enable_level_ioapic_irq		unmask_IO_APIC_irq
-#define disable_level_ioapic_irq	mask_IO_APIC_irq
-
 static void end_level_ioapic_irq (unsigned int irq)
 {
 	unsigned long v;
@@ -1858,6 +1877,7 @@
  * The idea is from Manfred Spraul.  --macro
  */
 	i = IO_APIC_VECTOR(irq);
+
 	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
 
 	ack_APIC_irq();
@@ -1892,7 +1912,57 @@
 	}
 }
 
-static void mask_and_ack_level_ioapic_irq (unsigned int irq) { /* nothing */ }
+#ifdef CONFIG_PCI_USE_VECTOR
+static unsigned int startup_edge_ioapic_vector(unsigned int vector)
+{
+	int irq = vector_to_irq(vector);
+
+	return startup_edge_ioapic_irq(irq);
+}
+
+static void ack_edge_ioapic_vector(unsigned int vector)
+{
+	int irq = vector_to_irq(vector);
+	
+	ack_edge_ioapic_irq(irq);
+}
+
+static unsigned int startup_level_ioapic_vector (unsigned int vector)
+{
+	int irq = vector_to_irq(vector);
+
+	return startup_level_ioapic_irq (irq);
+}
+
+static void end_level_ioapic_vector (unsigned int vector)
+{
+	int irq = vector_to_irq(vector);
+
+	end_level_ioapic_irq(irq);
+}
+
+static void mask_IO_APIC_vector (unsigned int vector)
+{
+	int irq = vector_to_irq(vector);
+
+	mask_IO_APIC_irq(irq);
+}
+
+static void unmask_IO_APIC_vector (unsigned int vector)
+{
+	int irq = vector_to_irq(vector);
+	
+	unmask_IO_APIC_irq(irq);
+}
+
+static void set_ioapic_affinity_vector (unsigned int vector, 
+					unsigned long cpu_mask)
+{
+	int irq = vector_to_irq(vector);
+
+	set_ioapic_affinity_irq(irq, cpu_mask);
+}
+#endif
 
 /*
  * Level and edge triggered IO-APIC interrupts need different handling,
@@ -1902,26 +1972,25 @@
  * edge-triggered handler, without risking IRQ storms and other ugly
  * races.
  */
-
-static struct hw_interrupt_type ioapic_edge_irq_type = {
+static struct hw_interrupt_type ioapic_edge_type = {
 	.typename 	= "IO-APIC-edge",
-	.startup 	= startup_edge_ioapic_irq,
-	.shutdown 	= shutdown_edge_ioapic_irq,
-	.enable 	= enable_edge_ioapic_irq,
-	.disable 	= disable_edge_ioapic_irq,
-	.ack 		= ack_edge_ioapic_irq,
-	.end 		= end_edge_ioapic_irq,
+	.startup 	= startup_edge_ioapic,
+	.shutdown 	= shutdown_edge_ioapic,
+	.enable 	= enable_edge_ioapic,
+	.disable 	= disable_edge_ioapic,
+	.ack 		= ack_edge_ioapic,
+	.end 		= end_edge_ioapic,
 	.set_affinity 	= set_ioapic_affinity,
 };
 
-static struct hw_interrupt_type ioapic_level_irq_type = {
+static struct hw_interrupt_type ioapic_level_type = {
 	.typename 	= "IO-APIC-level",
-	.startup 	= startup_level_ioapic_irq,
-	.shutdown 	= shutdown_level_ioapic_irq,
-	.enable 	= enable_level_ioapic_irq,
-	.disable 	= disable_level_ioapic_irq,
-	.ack 		= mask_and_ack_level_ioapic_irq,
-	.end 		= end_level_ioapic_irq,
+	.startup 	= startup_level_ioapic,
+	.shutdown 	= shutdown_level_ioapic,
+	.enable 	= enable_level_ioapic,
+	.disable 	= disable_level_ioapic,
+	.ack 		= mask_and_ack_level_ioapic,
+	.end 		= end_level_ioapic,
 	.set_affinity 	= set_ioapic_affinity,
 };
 
@@ -1941,7 +2010,13 @@
 	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
 	 */
 	for (irq = 0; irq < NR_IRQS ; irq++) {
-		if (IO_APIC_IRQ(irq) && !IO_APIC_VECTOR(irq)) {
+		int tmp = irq;
+		if (use_pci_vector()) {
+			if (!platform_legacy_irq(tmp))  
+				if ((tmp = vector_to_irq(tmp)) == -1)
+					continue;
+		}
+		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
 			/*
 			 * Hmm.. We don't have an entry for this,
 			 * so default to an old-fashioned 8259
@@ -2373,10 +2448,12 @@
 		"IRQ %d Mode:%i Active:%i)\n", ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq, edge_level, active_high_low);
 
+ 	if (use_pci_vector() && !platform_legacy_irq(irq))
+		irq = IO_APIC_VECTOR(irq);
 	if (edge_level) {
-	irq_desc[irq].handler = &ioapic_level_irq_type;
+		irq_desc[irq].handler = &ioapic_level_type;
 	} else {
-		irq_desc[irq].handler = &ioapic_edge_irq_type;
+		irq_desc[irq].handler = &ioapic_edge_type;
 	}
 
 	set_intr_gate(entry.vector, interrupt[irq]);
diff -urN linux-2.6.0-test5/arch/i386/kernel/mpparse.c linux-260t5-vectorbase-testbox/arch/i386/kernel/mpparse.c
--- linux-2.6.0-test5/arch/i386/kernel/mpparse.c	2003-09-08 15:50:00.000000000 -0400
+++ linux-260t5-vectorbase-testbox/arch/i386/kernel/mpparse.c	2003-09-25 08:09:21.749936480 -0400
@@ -1131,15 +1131,19 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			printk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-			entry->irq = irq;
+ 			if (use_pci_vector() && !platform_legacy_irq(irq))
+ 				irq = IO_APIC_VECTOR(irq);
+ 			entry->irq = irq;
 			continue;
 		}
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low))
-			entry->irq = irq;
-
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low)) {
+ 			if (use_pci_vector() && !platform_legacy_irq(irq))
+ 				irq = IO_APIC_VECTOR(irq);
+ 			entry->irq = irq;
+ 		}
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
 			entry->id.segment, entry->id.bus, 
 			entry->id.device, ('A' + entry->pin), 
diff -urN linux-2.6.0-test5/arch/i386/pci/irq.c linux-260t5-vectorbase-testbox/arch/i386/pci/irq.c
--- linux-2.6.0-test5/arch/i386/pci/irq.c	2003-09-08 15:50:43.000000000 -0400
+++ linux-260t5-vectorbase-testbox/arch/i386/pci/irq.c	2003-09-24 08:11:43.000000000 -0400
@@ -745,6 +745,10 @@
 							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
 				}
 				if (irq >= 0) {
+					if (use_pci_vector() && 
+						!platform_legacy_irq(irq))
+						irq = IO_APIC_VECTOR(irq);
+
 					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
 						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
 					dev->irq = irq;
diff -urN linux-2.6.0-test5/include/asm-i386/hw_irq.h linux-260t5-vectorbase-testbox/include/asm-i386/hw_irq.h
--- linux-2.6.0-test5/include/asm-i386/hw_irq.h	2003-09-08 15:50:41.000000000 -0400
+++ linux-260t5-vectorbase-testbox/include/asm-i386/hw_irq.h	2003-09-24 08:11:43.000000000 -0400
@@ -41,6 +41,7 @@
 asmlinkage void error_interrupt(void);
 asmlinkage void spurious_interrupt(void);
 asmlinkage void thermal_interrupt(struct pt_regs);
+#define platform_legacy_irq(irq)	((irq) < 16)
 #endif
 
 void mask_irq(unsigned int irq);
diff -urN linux-2.6.0-test5/include/asm-i386/io_apic.h linux-260t5-vectorbase-testbox/include/asm-i386/io_apic.h
--- linux-2.6.0-test5/include/asm-i386/io_apic.h	2003-09-08 15:50:13.000000000 -0400
+++ linux-260t5-vectorbase-testbox/include/asm-i386/io_apic.h	2003-09-24 10:48:47.000000000 -0400
@@ -13,6 +13,46 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
+#ifdef CONFIG_PCI_USE_VECTOR
+static inline int use_pci_vector(void)	{return 1;}
+static inline void disable_edge_ioapic_vector(unsigned int vector) { }
+static inline void mask_and_ack_level_ioapic_vector(unsigned int vector) { }
+static inline void end_edge_ioapic_vector (unsigned int vector) { }
+#define startup_level_ioapic	startup_level_ioapic_vector
+#define shutdown_level_ioapic	mask_IO_APIC_vector
+#define enable_level_ioapic	unmask_IO_APIC_vector
+#define disable_level_ioapic	mask_IO_APIC_vector
+#define mask_and_ack_level_ioapic mask_and_ack_level_ioapic_vector	
+#define end_level_ioapic	end_level_ioapic_vector
+#define set_ioapic_affinity	set_ioapic_affinity_vector
+
+#define startup_edge_ioapic 	startup_edge_ioapic_vector
+#define shutdown_edge_ioapic 	disable_edge_ioapic_vector
+#define enable_edge_ioapic 	unmask_IO_APIC_vector
+#define disable_edge_ioapic 	disable_edge_ioapic_vector
+#define ack_edge_ioapic 	ack_edge_ioapic_vector
+#define end_edge_ioapic 	end_edge_ioapic_vector
+#else
+static inline int use_pci_vector(void)	{return 0;}
+static inline void disable_edge_ioapic_irq(unsigned int irq) { }
+static inline void mask_and_ack_level_ioapic_irq(unsigned int irq) { }
+static inline void end_edge_ioapic_irq (unsigned int irq) { }
+#define startup_level_ioapic	startup_level_ioapic_irq
+#define shutdown_level_ioapic	mask_IO_APIC_irq
+#define enable_level_ioapic	unmask_IO_APIC_irq
+#define disable_level_ioapic	mask_IO_APIC_irq
+#define mask_and_ack_level_ioapic mask_and_ack_level_ioapic_irq	
+#define end_level_ioapic	end_level_ioapic_irq
+#define set_ioapic_affinity	set_ioapic_affinity_irq
+
+#define startup_edge_ioapic 	startup_edge_ioapic_irq
+#define shutdown_edge_ioapic 	disable_edge_ioapic_irq
+#define enable_edge_ioapic 	unmask_IO_APIC_irq
+#define disable_edge_ioapic 	disable_edge_ioapic_irq
+#define ack_edge_ioapic 	ack_edge_ioapic_irq
+#define end_edge_ioapic 	end_edge_ioapic_irq
+#endif
+
 #define APIC_MISMATCH_DEBUG
 
 #define IO_APIC_BASE(idx) \
diff -urN linux-2.6.0-test5/include/asm-i386/mach-default/irq_vectors.h linux-260t5-vectorbase-testbox/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.0-test5/include/asm-i386/mach-default/irq_vectors.h	2003-09-08 15:49:58.000000000 -0400
+++ linux-260t5-vectorbase-testbox/include/asm-i386/mach-default/irq_vectors.h	2003-09-24 08:11:43.000000000 -0400
@@ -76,11 +76,21 @@
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
  * the usable vector space is 0x20-0xff (224 vectors)
  */
+/*
+ * The maximum number of vectors supported by i386 processors
+ * is limited to 256. For processors other than i386, NR_VECTORS
+ * should be changed accordingly. 
+ */
+#define NR_VECTORS 256
+#ifdef CONFIG_PCI_USE_VECTOR
+#define NR_IRQS FIRST_SYSTEM_VECTOR
+#else
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
 #else
 #define NR_IRQS 16
 #endif
+#endif
 
 #define FPU_IRQ			13
 
diff -urN linux-260t5-vectorbase-testbox/arch/i386/Kconfig linux-260t5-msi-testbox/arch/i386/Kconfig
--- linux-260t5-vectorbase-testbox/arch/i386/Kconfig	2003-09-24 08:11:43.000000000 -0400
+++ linux-260t5-msi-testbox/arch/i386/Kconfig	2003-09-22 12:08:56.000000000 -0400
@@ -1088,6 +1088,7 @@
 
 config PCI_USE_VECTOR
 	bool "PCI_USE_VECTOR"
+	depends on X86_LOCAL_APIC
 	default n
 	help
 	   This replaces the current existing IRQ-based index interrupt scheme
@@ -1095,6 +1096,12 @@
 	   1) Support MSI implementation.
 	   2) Support future IOxAPIC hotplug
 
+	   Note that this enables MSI, Message Signaled Interrupt, on all
+	   MSI capable device functions detected if users also install the 
+	   MSI patch. Message Signal Interrupt enables an MSI-capable
+	   hardware device to send an inbound Memory Write on its PCI bus
+	   instead of asserting IRQ signal on device IRQ pin.
+
 	   If you don't know what to do here, say N.
 
 source "drivers/pci/Kconfig"
diff -urN linux-260t5-vectorbase-testbox/arch/i386/kernel/io_apic.c linux-260t5-msi-testbox/arch/i386/kernel/io_apic.c
--- linux-260t5-vectorbase-testbox/arch/i386/kernel/io_apic.c	2003-09-25 07:29:13.000000000 -0400
+++ linux-260t5-msi-testbox/arch/i386/kernel/io_apic.c	2003-09-25 11:51:49.000000000 -0400
@@ -296,7 +296,7 @@
 
 extern cpumask_t irq_affinity[NR_IRQS];
 
-static cpumask_t __cacheline_aligned pending_irq_balance_cpumask[NR_IRQS];
+cpumask_t __cacheline_aligned pending_irq_balance_cpumask[NR_IRQS];
 
 #define IRQBALANCE_CHECK_ARCH -999
 static int irqbalance_disabled = IRQBALANCE_CHECK_ARCH;
@@ -1148,6 +1148,7 @@
 
 int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
 
+#ifndef CONFIG_PCI_USE_VECTOR
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
@@ -1165,14 +1166,13 @@
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-#ifdef CONFIG_PCI_USE_VECTOR
-	vector_irq[current_vector] = irq;
-#endif
-	
 	IO_APIC_VECTOR(irq) = current_vector;
 
 	return current_vector;
 }
+#else
+extern int assign_irq_vector(int irq);
+#endif
 
 static struct hw_interrupt_type ioapic_level_type;
 static struct hw_interrupt_type ioapic_edge_type;
diff -urN linux-260t5-vectorbase-testbox/arch/i386/pci/irq.c linux-260t5-msi-testbox/arch/i386/pci/irq.c
--- linux-260t5-vectorbase-testbox/arch/i386/pci/irq.c	2003-09-24 08:11:43.000000000 -0400
+++ linux-260t5-msi-testbox/arch/i386/pci/irq.c	2003-09-22 12:08:56.000000000 -0400
@@ -680,8 +680,10 @@
 		    	if ( dev2->irq && dev2->irq != irq && \
 			(!(pci_probe & PCI_USE_PIRQ_MASK) || \
 			((1 << dev2->irq) & mask)) ) {
+#ifndef CONFIG_PCI_USE_VECTOR
 		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
 				       pci_name(dev2), dev2->irq, irq);
+#endif
 		    		continue;
 		    	}
 			dev2->irq = irq;
diff -urN linux-260t5-vectorbase-testbox/Documentation/MSI-HOWTO.txt linux-260t5-msi-testbox/Documentation/MSI-HOWTO.txt
--- linux-260t5-vectorbase-testbox/Documentation/MSI-HOWTO.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-260t5-msi-testbox/Documentation/MSI-HOWTO.txt	2003-09-22 12:08:56.000000000 -0400
@@ -0,0 +1,275 @@
+		The MSI Driver Guide HOWTO
+	Tom L Nguyen tom.l.nguyen@intel.com
+			09/18/2003
+
+1. About this guide
+
+This guide describes the basics of Message Signaled Interrupts(MSI), the 
+advantages of using MSI over traditional interrupt mechanisms, and how 
+to enable your driver to use MSI or MSI-X. Also included is a Frequently 
+Asked Questions.
+
+2. Copyright 2003 Intel Corporation 
+
+3. What is MSI/MSI-X?
+
+Message Signaled Interrupt (MSI), as described in the PCI Local Bus 
+Specification Revision 2.3 or latest, is an optional feature, and a 
+required feature for PCI Express devices. MSI enables a device function
+to request service by sending an Inbound Memory Write on its PCI bus to
+the FSB as a Message Signal Interrupt transaction. Because MSI is 
+generated in the form of a Memory Write, all transaction conditions, 
+such as a Retry, Master-Abort, Target-Abort or normal completion, are 
+supported.
+
+A PCI device that supports MSI must also support pin IRQ assertion 
+interrupt mechanism to provide backward compatibility for systems that
+do not support MSI. In Systems, which support MSI, the bus driver is
+responsible for initializing the message address and message data of
+the device function's MSI/MSI-X capability structure during device
+initial configuration. 
+
+An MSI capable device function indicates MSI support by implementing 
+the MSI/MSI-X capability structure in its PCI capability list. The 
+device function may implement both the MSI capability structure and 
+the MSI-X capability structure; however, the bus driver should not 
+enable both, but instead enable only the MSI-X capability structure.
+
+The MSI capability structure contains Message Control register,
+Message Address register and Message Data register. These registers
+provide the bus driver control over MSI. The Message Control register
+indicates the MSI capability supported by the device. The Message
+Address register specifies the target address and the Message Data
+register specifies the characteristics of the message. To request
+service, the device function writes the content of the Message Data
+register to the target address. The device and its software driver 
+are prohibited from writing to these registers.
+
+The MSI-X capability structure is an optional extension to MSI. It 
+uses an independent and separate capability structure. There are 
+some key advantages to implementing the MSI-X capability structure 
+over the MSI capability structure as described below.
+
+	- Support a larger maximum number of vectors per function.
+
+	- Provide the ability for system software to configure 
+	each vector with an independent message address and message 
+	data, specified by a table that resides in Memory Space. 
+
+        - MSI and MSI-X both support per-vector masking. Per-vector
+	masking is an optional extension of MSI but a required
+	feature for MSI-X. Per-vector masking provides the kernel
+	the ability to mask/unmask MSI when servicing its software
+	interrupt service routing handler. If per-vector masking is
+	not supported, then the device driver should provide the 
+	hardware/software synchronization to ensure that the device
+	generates MSI when the driver wants it to do so. 
+
+4. Why use MSI? 
+
+As a benefit the simplification of board design, MSI allows board 
+designers to remove out of band interrupt routing. MSI is another 
+step towards a legacy-free environment.
+
+Due to increasing pressure on chipset and processor packages to 
+reduce pin count, the need for interrupt pins is expected to 
+diminish over time. Devices, due to pin constraints, may implement
+messages to increase performance. 
+
+PCI Express endpoints uses INTx emulation (in-band messages) instead
+of IRQ pin assertion. Using INTx emulation requires interrupt 
+sharing among devices connected to the same node (PCI bridge) while
+MSI is unique (non-shared) and does not require BIOS configuration
+support. As a result, the PCI Express technology requires MSI 
+support for better interrupt performance.
+ 
+Using MSI enables the device functions to support two or more 
+vectors, which can be configure to target different CPU's to 
+increase scalability. 
+
+5. Configuring a driver to use MSI/MSI-X
+
+By default, the kernel will not enable MSI/MSI-X on all devices that
+support this capability once the patch is installed. A kernel 
+configuration option must be selected to enable MSI/MSI-X support.
+
+5.1 Including MSI support into the kernel
+
+To include MSI support into the kernel requires users to patch the
+VECTOR-base patch first and then the MSI patch because the MSI 
+support needs VECTOR based scheme. Once these patches are installed,
+setting CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and 
+the option for MSI-capable device drivers to selectively enable MSI
+(using pci_enable_msi as desribed below).
+
+Since the target of the inbound message is the local APIC, providing
+CONFIG_PCI_USE_VECTOR is dependent on whether CONFIG_X86_LOCAL_APIC
+is enabled or not.
+
+int pci_enable_msi(struct pci_dev *)
+ 
+With this new API, any existing device driver, which like to have 
+MSI enabled on its device function, must call this explicitly. A 
+successful call will initialize the MSI/MSI-X capability structure
+with ONE vector, regardless of whether the device function is 
+capable of supporting multiple messages. This vector replaces the
+pre-assigned dev->irq with a new MSI vector if reclaiming the 
+pre-assigned vector is impossible. To avoid the conflict of new 
+assigned vector with existing pre-assigned vector requires the 
+device driver to call this API before calling request_irq(...).
+
+5.2 Configuring for MSI support
+
+Due to the non-contiguous fashion in vector assignment of the 
+existing Linux kernel, this patch does not support multiple 
+messages regardless of the device function is capable of supporting
+more than one vector. The bus driver initializes only entry 0 of
+this capability if pci_enable_msi(...) is called successfully by 
+the device driver.
+
+5.3 Configuring for MSI-X support
+
+Both the MSI capability structure and the MSI-X capability structure
+share the same above semantics; however, due to the ability of the
+system software to configure each vector of the MSI-X capability
+structure with an independent message address and message data, the
+non-contiguous fashion in vector assignment of the existing Linux 
+kernel has no impact on supporting multiple messages on an MSI-X 
+capable device functions. By default, as mentioned above, ONE vector
+should be always allocated to the MSI-X capability structure at 
+entry 0. The bus driver does not initialize other entries of the 
+MSI-X table.
+ 
+Note that the PCI subsystem should have full control of a MSI-X 
+table that resides in Memory Space. The software device driver 
+should not access this table. 
+
+To request for additional vectors, the device software driver should
+call function msi_alloc_vectors(). It is recommended that the 
+software driver should call this function once during the 
+initialization phase of the device driver.
+
+The function msi_alloc_vectors(), once invoked, enables either 
+all or nothing, depending on the current availability of vector 
+resources. If no vector resources are available, the device function
+still works with ONE vector. If the vector resources are available
+for the number of vectors requested by the driver, this function 
+will reconfigure the MSI-X capability structure of the device with
+additional messages, starting from entry 1. To emphasize this
+reason, for example, the device may be capable for supporting the 
+maximum of 32 vectors while its software driver usually may request
+4 vectors.
+
+For each vector, after this successful call, the device driver is 
+responsible to call other functions like request_irq(), enable_irq(),
+etc. to enable this vector with its corresponding interrupt service
+handler. It is the device driver's choice to have all vectors shared
+the same interrupt service handler or each vector with a unique 
+interrupt service handler. 
+
+In addition to the function msi_alloc_vectors(), another function 
+msi_free_vectors() is provided to allow the software driver to 
+release a number of vectors back to the vector resources. Once 
+invoked, the PCI subsystem disables (masks) each vector released. 
+These vectors are no longer valid for the hardware device and its
+software driver to use.
+
+int msi_alloc_vectors(struct pci_dev *dev, int *vector, int nvec)
+
+This API enables the software driver to request the PCI subsystem 
+for additional messages. Depending on the number of vectors 
+available, the PCI subsystem enables either all or nothing. 
+
+Argument dev points to the device (pci_dev) structure.
+Argument vector is a pointer of integer type. The number of 
+elements is indicated in argument nvec.
+Argument nvec is an integer indicating the number of messages 
+requested.
+A return of zero indicates that the number of allocated vector is 
+successfully allocated. Otherwise, indicate resources not 
+available.
+
+int msi_free_vectors(struct pci_dev* dev, int *vector, int nvec)
+
+This API enables the software driver to inform the PCI subsystem
+that it is willing to release a number of vectors back to the 
+MSI resource pool. Once invoked, the PCI subsystem disables each
+MSI-X entry associated with each vector stored in the argument 2.
+These vectors are no longer valid for the hardware device and 
+its software driver to use.
+
+Argument dev points to the device (pci_dev) structure.
+Argument vector is a pointer of integer type. The number of 
+elements is indicated in argument nvec.
+Argument nvec is an integer indicating the number of messages 
+released. 
+A return of zero indicates that the number of allocated vectors 
+is successfully released. Otherwise, indicates a failure.
+
+5.4 How to tell whether MSI is enabled on device function
+
+At the driver level, a return of zero from pci_enable_msi(...) 
+indicates to the device driver that its device function is 
+initialized successfully and ready to run in MSI mode.
+
+At the user level, users can use command 'cat /proc/interrupts' 
+to display the vector allocated for the device and its interrupt
+mode, as shown below. 
+
+           CPU0       CPU1       
+  0:     324639          0    IO-APIC-edge  timer
+  1:       1186          0    IO-APIC-edge  i8042
+  2:          0          0          XT-PIC  cascade
+ 12:       2797          0    IO-APIC-edge  i8042
+ 14:       6543          0    IO-APIC-edge  ide0
+ 15:          1          0    IO-APIC-edge  ide1
+169:          0          0   IO-APIC-level  uhci-hcd
+185:          0          0   IO-APIC-level  uhci-hcd
+193:        138         10         PCI MSI  aic79xx
+201:         30          0         PCI MSI  aic79xx
+225:         30          0   IO-APIC-level  aic7xxx
+233:         30          0   IO-APIC-level  aic7xxx
+NMI:          0          0 
+LOC:     324553     325068 
+ERR:          0
+MIS:          0
+
+6. FAQ
+
+Q1. Are there any limitations on using the MSI?
+
+A1. If the PCI device supports MSI and conforms to the
+specification and the platform supports the APIC local bus,
+then using MSI should work.
+
+Q2. Will it work on all the Pentium processors (P3, P4, Xeon,
+AMD processors)? In P3 IPI's are transmitted on the APIC local
+bus and in P4 and Xeon they are transmitted on the system
+bus. Are there any implications with this?
+
+A2. MSI support enables a PCI device sending an inbound
+memory write (0xfeexxxxx as target address) on its PCI bus
+directly to the FSB. Since the message address has a
+redirection hint bit cleared, it should work.
+
+Q3. The target address 0xfeexxxxx will be translated by the
+Host Bridge into an interrupt message. Are there any
+limitations on the chipsets such as Intel 8xx, Intel e7xxx,
+or VIA?
+
+A3. If these chipsets support an inbound memory write with
+target address set as 0xfeexxxxx, as conformed to PCI 
+specification 2.3 or latest, then it should work.
+
+Q4. From the driver point of view, if the MSI is lost because
+of the errors occur during inbound memory write, then it may
+wait for ever. Is there a mechanism for it to recover?
+
+A4. Since the target of the transaction is an inbound memory
+write, all transaction termination conditions (Retry,
+Master-Abort, Target-Abort, or normal completion) are
+supported. A device sending an MSI must abide by all the PCI
+rules and conditions regarding that inbound memory write. So,
+if a retry is signaled it must retry, etc... We believe that
+the recommendation for Abort is also a retry (refer to PCI
+specification 2.3 or latest).
diff -urN linux-260t5-vectorbase-testbox/drivers/acpi/pci_irq.c linux-260t5-msi-testbox/drivers/acpi/pci_irq.c
--- linux-260t5-vectorbase-testbox/drivers/acpi/pci_irq.c	2003-09-24 08:38:09.000000000 -0400
+++ linux-260t5-msi-testbox/drivers/acpi/pci_irq.c	2003-09-22 12:08:56.000000000 -0400
@@ -234,7 +234,7 @@
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
 
-static int
+int
 acpi_pci_irq_lookup (struct pci_bus *bus, int device, int pin)
 {
 	struct acpi_prt_entry	*entry = NULL;
diff -urN linux-260t5-vectorbase-testbox/drivers/pci/Makefile linux-260t5-msi-testbox/drivers/pci/Makefile
--- linux-260t5-vectorbase-testbox/drivers/pci/Makefile	2003-09-08 15:50:27.000000000 -0400
+++ linux-260t5-msi-testbox/drivers/pci/Makefile	2003-09-22 12:08:56.000000000 -0400
@@ -28,6 +28,7 @@
 obj-$(CONFIG_SGI_IP27) += setup-irq.o
 obj-$(CONFIG_SGI_IP32) += setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
+obj-$(CONFIG_PCI_USE_VECTOR) += msi.o
 
 # Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) += setup-bus.o
diff -urN linux-260t5-vectorbase-testbox/drivers/pci/msi.c linux-260t5-msi-testbox/drivers/pci/msi.c
--- linux-260t5-vectorbase-testbox/drivers/pci/msi.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-260t5-msi-testbox/drivers/pci/msi.c	2003-09-25 13:55:23.101339672 -0400
@@ -0,0 +1,1041 @@
+/*
+ * linux/drivers/pci/msi.c
+ */
+
+#include <linux/mm.h>
+#include <linux/irq.h>		
+#include <linux/interrupt.h>
+#include <linux/init.h>		
+#include <linux/config.h>      	
+#include <linux/ioport.h>       
+#include <linux/smp_lock.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/acpi.h>
+
+#include <asm/errno.h>
+#include <asm/io.h>		
+#include <asm/smp.h>
+#include <asm/desc.h>		
+#include <mach_apic.h>
+
+#include <linux/pci_msi.h>
+
+_DEFINE_DBG_BUFFER
+
+static spinlock_t msi_lock = SPIN_LOCK_UNLOCKED;
+static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
+static kmem_cache_t* msi_cachep;
+
+static int pci_msi_enable = 1;
+static int nr_alloc_vectors = 0;
+static int nr_released_vectors = 0;
+static int nr_reserved_vectors = NR_HP_RESERVED_VECTORS;
+static int nr_msix_devices = 0;
+
+#ifndef CONFIG_X86_IO_APIC
+int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
+int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
+#endif
+
+static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
+{
+	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
+}
+
+static int msi_cache_init(void)
+{
+	msi_cachep = kmem_cache_create("msi_cache", 
+			NR_IRQS * sizeof(struct msi_desc),
+		       	0, SLAB_HWCACHE_ALIGN, msi_cache_ctor, NULL);
+	if (!msi_cachep)
+		return -ENOMEM;
+	
+	return 0;
+}
+
+static void msi_set_mask_bit(unsigned int vector, int flag)
+{
+	struct msi_desc *entry;
+	
+	entry = (struct msi_desc *)msi_desc[vector];
+	if (!entry || !entry->dev || !entry->mask_base)
+		return;
+	switch (entry->msi_attrib.type) {
+	case PCI_CAP_ID_MSI:
+	{
+		int		pos;
+		unsigned int	mask_bits;
+
+		pos = entry->mask_base;
+	        entry->dev->bus->ops->read(entry->dev->bus, entry->dev->devfn, 
+				pos, 4, &mask_bits);
+		mask_bits &= ~(1);
+		mask_bits |= flag;
+	        entry->dev->bus->ops->write(entry->dev->bus, entry->dev->devfn, 
+				pos, 4, mask_bits);
+		break;
+	}
+	case PCI_CAP_ID_MSIX:
+	{
+		int offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET;
+		writel(flag, entry->mask_base + offset);
+		break;
+	}
+	default:
+		break;
+	} 
+}
+
+#ifdef CONFIG_SMP
+static void set_msi_affinity(unsigned int vector, unsigned long cpu_mask)
+{
+	struct msi_desc *entry;
+	struct msg_address address;	
+
+	entry = (struct msi_desc *)msi_desc[vector];
+	if (!entry || !entry->dev) 
+		return;
+	
+	switch (entry->msi_attrib.type) {
+	case PCI_CAP_ID_MSI:
+	{
+		int pos;
+
+   		if (!(pos = pci_find_capability(entry->dev, PCI_CAP_ID_MSI)))
+			return;
+	       	
+	        entry->dev->bus->ops->read(entry->dev->bus, entry->dev->devfn, 
+			msi_lower_address_reg(pos), 4, 
+			&address.lo_address.value);
+		address.lo_address.u.dest_id = cpu_mask_to_apicid(cpu_mask); 
+		entry->msi_attrib.current_cpu = address.lo_address.u.dest_id; 
+		entry->dev->bus->ops->write(entry->dev->bus, entry->dev->devfn, 
+			msi_lower_address_reg(pos), 4, 
+			address.lo_address.value);
+		break;
+	}
+	case PCI_CAP_ID_MSIX:
+	{
+		int offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
+
+		address.lo_address.value = readl(entry->mask_base + offset);
+		address.lo_address.u.dest_id = cpu_mask_to_apicid(cpu_mask); 
+		entry->msi_attrib.current_cpu = address.lo_address.u.dest_id; 
+		writel(address.lo_address.value, entry->mask_base + offset);
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static inline void move_msi(int vector)
+{
+	if (unlikely(pending_irq_balance_cpumask[vector])) {
+		set_msi_affinity(vector, pending_irq_balance_cpumask[vector]);
+		pending_irq_balance_cpumask[vector] = 0;
+	}
+}
+#endif
+
+static void mask_MSI_irq(unsigned int vector)
+{
+	msi_set_mask_bit(vector, 1);
+}
+
+static void unmask_MSI_irq(unsigned int vector)
+{
+	msi_set_mask_bit(vector, 0);
+}
+
+static unsigned int startup_msi_irq_wo_maskbit(unsigned int vector) 
+{
+	return 0;	/* never anything pending */
+}
+
+static void pci_disable_msi(unsigned int vector);
+static void shutdown_msi_irq(unsigned int vector) 
+{
+	pci_disable_msi(vector);
+}
+
+#define shutdown_msi_irq_wo_maskbit	shutdown_msi_irq 
+static void enable_msi_irq_wo_maskbit(unsigned int vector) {}
+static void disable_msi_irq_wo_maskbit(unsigned int vector) {}
+static void act_msi_irq_wo_maskbit(unsigned int vector) {}
+static void end_msi_irq_wo_maskbit(unsigned int vector) 
+{
+	move_msi(vector);
+	ack_APIC_irq();	
+}
+
+static unsigned int startup_msi_irq_w_maskbit(unsigned int vector)
+{ 
+	unmask_MSI_irq(vector);
+	return 0;	/* never anything pending */
+}
+
+#define shutdown_msi_irq_w_maskbit	shutdown_msi_irq
+#define enable_msi_irq_w_maskbit	unmask_MSI_irq
+#define disable_msi_irq_w_maskbit	mask_MSI_irq
+#define act_msi_irq_w_maskbit		mask_MSI_irq
+
+static void end_msi_irq_w_maskbit(unsigned int vector) 
+{
+	move_msi(vector);
+	unmask_MSI_irq(vector);	
+	ack_APIC_irq();
+}
+
+/*
+ * Interrupt Type for MSI-X PCI/PCI-X/PCI-Express Devices,
+ * which implement the MSI-X Capability Structure. 
+ */
+static struct hw_interrupt_type msix_irq_type = {
+	"PCI MSI-X",
+	startup_msi_irq_w_maskbit,
+	shutdown_msi_irq_w_maskbit,
+	enable_msi_irq_w_maskbit,
+	disable_msi_irq_w_maskbit,
+	act_msi_irq_w_maskbit,		
+	end_msi_irq_w_maskbit,	
+	set_msi_irq_affinity
+};
+
+/*
+ * Interrupt Type for MSI PCI/PCI-X/PCI-Express Devices,
+ * which implement the MSI Capability Structure with 
+ * Mask-and-Pending Bits. 
+ */
+static struct hw_interrupt_type msi_irq_w_maskbit_type = {
+	"PCI MSI",
+	startup_msi_irq_w_maskbit,
+	shutdown_msi_irq_w_maskbit,
+	enable_msi_irq_w_maskbit,
+	disable_msi_irq_w_maskbit,
+	act_msi_irq_w_maskbit,		
+	end_msi_irq_w_maskbit,	
+	set_msi_irq_affinity
+};
+
+/*
+ * Interrupt Type for MSI PCI/PCI-X/PCI-Express Devices,
+ * which implement the MSI Capability Structure without 
+ * Mask-and-Pending Bits. 
+ */
+static struct hw_interrupt_type msi_irq_wo_maskbit_type = {
+	"PCI MSI",
+	startup_msi_irq_wo_maskbit,
+	shutdown_msi_irq_wo_maskbit,
+	enable_msi_irq_wo_maskbit,
+	disable_msi_irq_wo_maskbit,
+	act_msi_irq_wo_maskbit,		
+	end_msi_irq_wo_maskbit,	
+	set_msi_irq_affinity
+};
+
+static void msi_data_init(struct msg_data *msi_data, 
+			  unsigned int vector)
+{
+	memset(msi_data, 0, sizeof(struct msg_data));
+	msi_data->vector = (u8)vector;
+	msi_data->delivery_mode = MSI_DELIVERY_MODE;
+	msi_data->level = MSI_LEVEL_MODE;
+	msi_data->trigger = MSI_TRIGGER_MODE;	
+}
+
+static void msi_address_init(struct msg_address *msi_address)
+{
+	memset(msi_address, 0, sizeof(struct msg_address));
+	msi_address->hi_address = (u32)0;
+	msi_address->lo_address.u.header = MSI_ADDRESS_HEADER;
+	msi_address->lo_address.u.dest_mode = MSI_LOGICAL_MODE;
+	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
+	msi_address->lo_address.u.dest_id = MSI_TARGET_CPU; 
+}
+
+static int pci_vector_resources(void) 					
+{	
+	static int res = -EINVAL;
+	int nr_free_vectors;
+	
+	if (res == -EINVAL) {
+		int i, repeat;
+		for (i = NR_REPEATS; i > 0; i--) {				
+			if ((FIRST_DEVICE_VECTOR + i * 8) > FIRST_SYSTEM_VECTOR)
+				continue; 					
+			break; 							
+		} 								
+		i++; 								
+		repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i; 	
+		res = i * repeat - NR_RESERVED_VECTORS + 1; 
+	}
+
+	nr_free_vectors = res + nr_released_vectors - nr_alloc_vectors;	
+
+	return nr_free_vectors;
+}
+
+int assign_irq_vector(int irq)
+{
+	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	
+	if (irq != MSI_AUTO && IO_APIC_VECTOR(irq) > 0)
+		return IO_APIC_VECTOR(irq);
+next:
+	current_vector += 8;
+	if (current_vector == SYSCALL_VECTOR)
+		goto next;
+
+	if (current_vector > FIRST_SYSTEM_VECTOR) {
+		offset++;
+		current_vector = FIRST_DEVICE_VECTOR + offset;
+	}
+
+	if (current_vector == FIRST_SYSTEM_VECTOR) 
+		return -ENOSPC;
+	
+	vector_irq[current_vector] = irq;
+	if (irq != MSI_AUTO) 
+		IO_APIC_VECTOR(irq) = current_vector;
+
+	nr_alloc_vectors++;
+
+	return current_vector;
+}
+
+static int assign_msi_vector(void)
+{
+	static int new_vector_avail = 1; 	
+	int vector;
+	unsigned long flags;
+	
+	/* 
+	 * msi_lock is provided to ensure that successful allocation of MSI
+	 * vector is assigned unique among drivers.
+	 */
+	spin_lock_irqsave(&msi_lock, flags);
+	if (!(pci_vector_resources() > 0)) {
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EBUSY;
+	}
+
+	if (!new_vector_avail) {
+		/*
+	 	 * vector_irq[] = -1 indicates that this specific vector is:
+	 	 * - assigned for MSI (since MSI have no associated IRQ) or
+	 	 * - assigned for legacy if less than 16, or
+	 	 * - having no corresponding 1:1 vector-to-IOxAPIC IRQ mapping
+	 	 * vector_irq[] = 0 indicates that this vector, previously 
+		 * assigned for MSI, is freed by hotplug removed operations. 
+		 * This vector will be reused for any subsequent hotplug added 
+		 * operations.
+	 	 * vector_irq[] > 0 indicates that this vector is assigned for 
+		 * IOxAPIC IRQs. This vector and its value provides a 1-to-1 
+		 * vector-to-IOxAPIC IRQ mapping.
+	 	 */   
+		for (vector = FIRST_DEVICE_VECTOR; vector < NR_IRQS; vector++) {
+			if (vector_irq[vector] != 0) 
+				continue;
+			vector_irq[vector] = -1;	
+			nr_released_vectors--;
+			spin_unlock_irqrestore(&msi_lock, flags);
+			return vector;
+		}
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EBUSY;
+	}	
+
+	vector = assign_irq_vector(MSI_AUTO);
+	if (vector  == (FIRST_SYSTEM_VECTOR - 8))  
+		new_vector_avail = 0;
+
+	spin_unlock_irqrestore(&msi_lock, flags);
+	return vector;
+}
+
+static int get_new_vector(void)
+{
+	int vector;
+	
+	if ((vector = assign_msi_vector()) > 0)
+		set_intr_gate(vector, interrupt[vector]);
+
+	return vector;
+}
+
+static int msi_init(void)
+{
+	static int status = -ENOMEM;
+	
+	if (!status)
+		return status;
+
+	if ((status = msi_cache_init()) < 0) {
+		pci_msi_enable = 0;
+		printk(KERN_INFO "WARNING: MSI INIT FAILURE\n");
+		return status;
+	}
+	printk(KERN_INFO "MSI INIT SUCCESS\n");
+	
+	return status;
+}
+	
+static int get_msi_vector(struct pci_dev *dev)
+{
+	return get_new_vector();
+}
+
+static struct msi_desc* alloc_msi_entry(void)
+{
+	struct msi_desc *entry;
+
+	entry = (struct msi_desc*) kmem_cache_alloc(msi_cachep, SLAB_KERNEL);
+	if (!entry)
+		return NULL;
+
+	memset(entry, 0, sizeof(struct msi_desc));
+	entry->link.tail = entry->link.head = 0;	/* single message */
+	entry->dev = NULL;
+	
+	return entry;
+}
+
+static void attach_msi_entry(struct msi_desc *entry, int vector)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&msi_lock, flags);
+	msi_desc[vector] = entry;
+	spin_unlock_irqrestore(&msi_lock, flags);
+}
+
+static void irq_handler_init(int cap_id, int pos, int mask)
+{
+	spin_lock(&irq_desc[pos].lock);
+	if (cap_id == PCI_CAP_ID_MSIX)
+		irq_desc[pos].handler = &msix_irq_type;
+	else {
+		if (!mask)
+			irq_desc[pos].handler = &msi_irq_wo_maskbit_type;
+		else
+			irq_desc[pos].handler = &msi_irq_w_maskbit_type;
+	}
+	spin_unlock(&irq_desc[pos].lock);
+}
+
+static void enable_msi_mode(struct pci_dev *dev, int pos, int type)
+{
+	u32 control;
+			
+	dev->bus->ops->read(dev->bus, dev->devfn, 
+		msi_control_reg(pos), 2, &control);
+	if (type == PCI_CAP_ID_MSI) {
+		/* Set enabled bits to single MSI & enable MSI_enable bit */
+		msi_enable(control, 1);
+	        dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_control_reg(pos), 2, control);
+	} else {
+		msix_enable(control);
+	        dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_control_reg(pos), 2, control);
+	}
+    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
+		/* PCI Express Endpoint device detected */
+		u32 cmd;
+	        dev->bus->ops->read(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
+		cmd |= PCI_COMMAND_INTX_DISABLE;
+	        dev->bus->ops->write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);
+	}
+}
+
+static void disable_msi_mode(struct pci_dev *dev, int pos, int type)
+{
+	u32 control;
+	
+	dev->bus->ops->read(dev->bus, dev->devfn, 
+		msi_control_reg(pos), 2, &control);
+	if (type == PCI_CAP_ID_MSI) {
+		/* Set enabled bits to single MSI & enable MSI_enable bit */
+		msi_disable(control);
+	        dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_control_reg(pos), 2, control);
+	} else {
+		msix_disable(control);
+	        dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_control_reg(pos), 2, control);
+	}
+    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
+		/* PCI Express Endpoint device detected */
+		u32 cmd;
+	        dev->bus->ops->read(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
+		cmd &= ~PCI_COMMAND_INTX_DISABLE;
+	        dev->bus->ops->write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);
+	}
+}
+
+static int msi_lookup_vector(struct pci_dev *dev)
+{
+	int vector;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msi_lock, flags);
+	for (vector = FIRST_DEVICE_VECTOR; vector < NR_IRQS; vector++) {
+		if (!msi_desc[vector] || msi_desc[vector]->dev != dev ||
+			msi_desc[vector]->msi_attrib.entry_nr ||
+			msi_desc[vector]->msi_attrib.default_vector != dev->irq)
+			continue;	/* not entry 0, skip */
+		spin_unlock_irqrestore(&msi_lock, flags);
+		/* This pre-assigned entry-0 MSI vector for this device 
+		   already exits. Override dev->irq with this vector */ 
+		dev->irq = vector;	
+		return 0;
+	}
+	spin_unlock_irqrestore(&msi_lock, flags);
+
+	return -EACCES;
+}
+
+void pci_scan_msi_device(struct pci_dev *dev)
+{
+	if (!dev)
+		return;
+
+   	if (pci_find_capability(dev, PCI_CAP_ID_MSIX) > 0) {
+		nr_reserved_vectors++;
+		nr_msix_devices++;
+	} else if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0)
+		nr_reserved_vectors++;
+}
+
+/*
+ * msi_capability_init: configure device's MSI capability structure
+ * argument: dev of struct pci_dev type
+ * 
+ * description: called to configure the device's MSI capability structure with 
+ * a single MSI, regardless of device is capable of handling multiple messages.
+ *
+ * return:
+ * -EINVAL	: Invalid device type
+ * -ENOMEM	: Memory Allocation Error
+ * -EBUSY	: No MSI resource 
+ * 0		: Successfully allocate vector for entry 0
+ **/
+static int msi_capability_init(struct pci_dev *dev) 
+{
+	struct msi_desc *entry;
+	struct msg_address address; 
+	struct msg_data data;
+	int pos, vector;
+	u32 control;
+	
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (!pos)
+		return -EINVAL; 
+
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 
+		2, &control);
+	if (control & PCI_MSI_FLAGS_ENABLE)
+		return 0;
+	
+	vector = dev->irq;
+	if (vector > 0 && !msi_lookup_vector(dev)) {
+		/* Lookup Sucess */
+		enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+		return 0;
+	}
+	/* MSI Entry Initialization */
+	if (!(entry = alloc_msi_entry()))
+		return -ENOMEM;
+	
+	if ((vector = get_msi_vector(dev)) < 0) {
+		kmem_cache_free(msi_cachep, entry);
+		return -EBUSY;
+	}
+	entry->msi_attrib.type = PCI_CAP_ID_MSI;
+	entry->msi_attrib.entry_nr = 0;
+	entry->msi_attrib.maskbit = is_mask_bit_support(control);
+	entry->msi_attrib.default_vector = dev->irq;
+	dev->irq = vector;	/* save default pre-assigned ioapic vector */
+	entry->dev = dev;
+	if (is_mask_bit_support(control)) { 
+		entry->mask_base = msi_mask_bits_reg(pos, 
+				is_64bit_address(control));
+	}
+	/* Replace with MSI handler */
+	irq_handler_init(PCI_CAP_ID_MSI, vector, entry->msi_attrib.maskbit);
+	/* Configure MSI capability structure */
+	msi_address_init(&address);
+	msi_data_init(&data, vector);
+	entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+	dev->bus->ops->write(dev->bus, dev->devfn, msi_lower_address_reg(pos), 
+				4, address.lo_address.value);
+	if (is_64bit_address(control)) {
+		dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_upper_address_reg(pos), 4, address.hi_address);
+		dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_data_reg(pos, 1), 2, *((u32*)&data));
+	} else
+		dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_data_reg(pos, 0), 2, *((u32*)&data));
+	if (entry->msi_attrib.maskbit) {
+		unsigned int maskbits, temp;
+		/* All MSIs are unmasked by default, Mask them all */
+	        dev->bus->ops->read(dev->bus, dev->devfn, 
+			msi_mask_bits_reg(pos, is_64bit_address(control)), 4,
+			&maskbits);
+		temp = (1 << multi_msi_capable(control));
+		temp = ((temp - 1) & ~temp);
+		maskbits |= temp;
+		dev->bus->ops->write(dev->bus, dev->devfn, 
+			msi_mask_bits_reg(pos, is_64bit_address(control)), 4,
+			maskbits);
+	}
+	attach_msi_entry(entry, vector);
+	/* Set MSI enabled bits	 */
+	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+
+	return 0;
+}
+
+/**
+ * msix_capability_init: configure device's MSI-X capability structure
+ * argument: dev of struct pci_dev type
+ * 
+ * description: called to configure the device's MSI-X capability structure 
+ * with a single MSI. To request for additional MSI vectors, the device drivers
+ * are required to utilize the following supported APIs:
+ * 1) msi_alloc_vectors(...) for requesting one or more MSI
+ * 2) msi_free_vectors(...) for releasing one or more MSI back to PCI subsystem
+ *
+ * return:
+ * -EINVAL	: Invalid device type
+ * -ENOMEM	: Memory Allocation Error
+ * -EBUSY	: No MSI resource 
+ * 0		: Successfully allocate vector for entry 0
+ **/
+static int msix_capability_init(struct pci_dev	*dev) 
+{
+	struct msi_desc *entry;
+	struct msg_address address; 
+	struct msg_data data;
+	int vector, pos, dev_msi_cap;
+	u32 phys_addr, table_offset;
+	u32 control;
+	u8 bir;
+	void *base;
+	
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (!pos)
+		return -EINVAL;  
+
+	/* Request & Map MSI-X table region */
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 2, 
+		&control);
+	if (control & PCI_MSIX_FLAGS_ENABLE)
+		return 0;
+
+	vector = dev->irq;
+	if (vector > 0 && !msi_lookup_vector(dev)) {
+		/* Lookup Sucess */
+		enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+		return 0;
+	}
+
+	dev_msi_cap = multi_msix_capable(control);
+	dev->bus->ops->read(dev->bus, dev->devfn, 
+		msix_table_offset_reg(pos), 4, &table_offset);
+	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+	phys_addr = pci_resource_start (dev, bir);
+	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
+	if (!request_mem_region(phys_addr, 
+		dev_msi_cap * PCI_MSIX_ENTRY_SIZE,
+		"MSI-X iomap Failure"))
+		return -ENOMEM;
+	base = ioremap_nocache(phys_addr, dev_msi_cap * PCI_MSIX_ENTRY_SIZE);
+	if (base == NULL) 
+		goto free_region; 
+	/* MSI Entry Initialization */
+	entry = alloc_msi_entry();
+	if (!entry) 
+		goto free_iomap; 
+	if ((vector = get_msi_vector(dev)) < 0)
+		goto free_entry;
+       	
+	entry->msi_attrib.type = PCI_CAP_ID_MSIX;
+	entry->msi_attrib.entry_nr = 0;
+	entry->msi_attrib.maskbit = 1;
+	entry->msi_attrib.default_vector = dev->irq;
+	dev->irq = vector;	/* save default pre-assigned ioapic vector */
+	entry->dev = dev;
+	entry->mask_base = (unsigned long)base; 
+	/* Replace with MSI handler */
+	irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
+	/* Configure MSI-X capability structure */
+	msi_address_init(&address);
+	msi_data_init(&data, vector);
+	entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+	writel(address.lo_address.value, base + PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+	writel(address.hi_address, base + PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+	writel(*(u32*)&data, base + PCI_MSIX_ENTRY_DATA_OFFSET);
+	/* Initialize all entries from 1 up to 0 */
+	for (pos = 1; pos < dev_msi_cap; pos++) {
+		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_DATA_OFFSET);
+	}
+	attach_msi_entry(entry, vector);
+	/* Set MSI enabled bits	 */
+	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+
+	return 0;
+
+free_entry:
+	kmem_cache_free(msi_cachep, entry);
+free_iomap:
+	iounmap(base);
+free_region: 
+	release_mem_region(phys_addr, dev_msi_cap * PCI_MSIX_ENTRY_SIZE);
+
+	return ((vector < 0) ? -EBUSY : -ENOMEM);
+}
+
+/** 
+ * pci_enable_msi: configure MSI/MSI-X capability structure
+ * argument: struct pci_dev *dev 
+ * 
+ * description: called by device driver to request MSI mode on its device.
+ * The decision of enabling MSI on this function requires that all 
+ * of the following conditions must be satisfied:
+ * -	Kernel configuration parameter CONFIG_PCI_USE_VECTOR is set to 'Y'. 
+ * -	The function indicates MSI support by implementing MSI/MSI-X 
+ *	capability structure in its capability list.
+ * -	The MSI resource pool is available.
+ *
+ * return:
+ * -EINVAL	: Invalid device type
+ * -ENOMEM	: Memory Allocation Error
+ * -EBUSY	: No MSI resource 
+ * 0		: Sucessfully allocate MSI vector for entry 0
+ **/
+int pci_enable_msi(struct pci_dev* dev)
+{
+	int status = -EINVAL;
+
+	if (!pci_msi_enable || !dev)
+ 		return status;	
+	
+	if (msi_init() < 0)
+		return -ENOMEM;
+		
+	if ((status = msix_capability_init(dev)) == -EINVAL)
+		status = msi_capability_init(dev);
+	if (!status)
+		nr_reserved_vectors--;
+
+	return status;
+}
+
+static int msi_free_vector(struct pci_dev* dev, int vector);
+static void pci_disable_msi(unsigned int vector)
+{
+	int head, tail, type, default_vector;
+	struct msi_desc *entry;
+	struct pci_dev *dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msi_lock, flags);
+	entry = msi_desc[vector];
+	if (!entry || !entry->dev) {
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return;
+	}
+	dev = entry->dev;
+	type = entry->msi_attrib.type;
+	head = entry->link.head;
+	tail = entry->link.tail;
+	default_vector = entry->msi_attrib.default_vector;
+	spin_unlock_irqrestore(&msi_lock, flags);
+
+	disable_msi_mode(dev, pci_find_capability(dev, type), type);
+	/* Restore dev->irq to its default pin-assertion vector */
+	dev->irq = default_vector;
+	if (type == PCI_CAP_ID_MSIX && head != tail) {
+		/* Bad driver, which do not call msi_free_vectors before exit. 
+		   We must do a cleanup here */
+		while (1) {
+			spin_lock_irqsave(&msi_lock, flags);
+			entry = msi_desc[vector];
+			head = entry->link.head;
+			tail = entry->link.tail;
+			spin_unlock_irqrestore(&msi_lock, flags);
+			if (tail == head)
+				break;
+			if (msi_free_vector(dev, entry->link.tail))
+				break;
+		}
+	}
+}
+
+static int msi_alloc_vector(struct pci_dev* dev, int head)
+{
+	struct msi_desc *entry;
+	struct msg_address address; 
+	struct msg_data data;
+	int i, offset, pos, dev_msi_cap, vector;
+	u32 low_address, control;
+	unsigned long base = 0L;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msi_lock, flags);
+	entry = msi_desc[dev->irq];
+	if (!entry) {
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EINVAL;
+	}
+	base = entry->mask_base; 
+	spin_unlock_irqrestore(&msi_lock, flags);
+
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),	
+		2, &control);
+	dev_msi_cap = multi_msix_capable(control);
+	for (i = 1; i < dev_msi_cap; i++) {
+		if (!(low_address = readl(base + i * PCI_MSIX_ENTRY_SIZE)))
+			 break;
+	}
+	if (i >= dev_msi_cap) 
+		return -EINVAL;
+	
+	/* MSI Entry Initialization */
+	if (!(entry = alloc_msi_entry()))
+		return -ENOMEM;
+		
+	if ((vector = get_new_vector()) < 0) {
+		kmem_cache_free(msi_cachep, entry);
+		return vector;
+	}
+	entry->msi_attrib.type = PCI_CAP_ID_MSIX;
+	entry->msi_attrib.entry_nr = i;
+	entry->msi_attrib.maskbit = 1;
+	entry->dev = dev;
+	entry->link.head = head;
+	entry->mask_base = base; 
+	irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
+	/* Configure MSI-X capability structure */
+	msi_address_init(&address);
+	msi_data_init(&data, vector);
+	entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+	offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+	writel(address.lo_address.value, base + offset + 
+		PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+	writel(address.hi_address, base + offset +
+		PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+	writel(*(u32*)&data, base + offset + PCI_MSIX_ENTRY_DATA_OFFSET);
+	writel(1, base + offset + PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
+	attach_msi_entry(entry, vector);
+	
+	return vector;
+}
+
+static int msi_free_vector(struct pci_dev* dev, int vector)
+{
+	struct msi_desc *entry;
+	int entry_nr, type;
+	unsigned long base = 0L;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msi_lock, flags);
+	entry = msi_desc[vector];
+	if (!entry || entry->dev != dev) {
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EINVAL;
+	}
+	type = entry->msi_attrib.type;
+	entry_nr = entry->msi_attrib.entry_nr;
+	base = entry->mask_base;
+	if (entry->link.tail != entry->link.head) {
+		msi_desc[entry->link.head]->link.tail = entry->link.tail;
+		if (entry->link.tail) 
+			msi_desc[entry->link.tail]->link.head = entry->link.head; 
+	}
+	entry->dev = NULL;
+	vector_irq[vector] = 0;	
+	nr_released_vectors++;
+	msi_desc[vector] = NULL;
+	spin_unlock_irqrestore(&msi_lock, flags);
+
+	kmem_cache_free(msi_cachep, entry);
+	if (type == PCI_CAP_ID_MSIX) {
+		int offset;
+
+		offset = entry_nr * PCI_MSIX_ENTRY_SIZE;
+		writel(1, base + offset + PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
+		writel(0, base + offset + PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+	}
+	
+	return 0;
+}
+
+int msi_alloc_vectors(struct pci_dev* dev, int *vector, int nvec)
+{
+	struct msi_desc *entry;
+	int i, head, pos, vec, free_vectors, alloc_vectors;
+	int *vectors = (int *)vector;
+	u32 control;
+	unsigned long flags;
+
+	if (!pci_msi_enable || !dev)
+ 		return -EINVAL;
+
+   	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)))
+ 		return -EINVAL;
+
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 			2, &control);
+	if (nvec > multi_msix_capable(control))
+		return -EINVAL;
+
+	spin_lock_irqsave(&msi_lock, flags);
+	entry = msi_desc[dev->irq];
+	if (!entry || entry->dev != dev ||		/* legal call */
+	   entry->msi_attrib.type != PCI_CAP_ID_MSIX || /* must be MSI-X */ 
+	   entry->link.head != entry->link.tail) {	/* already multi */ 
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EINVAL;
+	}
+	/*
+	 * msi_lock is provided to ensure that enough vectors resources are
+	 * available before granting.
+	 */
+	free_vectors = pci_vector_resources(); 
+	/* Ensure that each MSI/MSI-X device has one vector reserved by 
+	   default to avoid any MSI-X driver to take all available 
+ 	   resources */
+	free_vectors -= nr_reserved_vectors;
+	/* Find the average of free vectors among MSI-X devices */
+	if (nr_msix_devices > 0)
+		free_vectors /= nr_msix_devices;
+	spin_unlock_irqrestore(&msi_lock, flags);
+
+	if (nvec > free_vectors) 
+		return -EBUSY;
+
+	alloc_vectors = 0;
+	head = dev->irq;
+	for (i = 0; i < nvec; i++) {
+		if ((vec = msi_alloc_vector(dev, head)) < 0) 
+			break;
+		*(vectors + i) = vec;
+		head = vec;
+		alloc_vectors++;
+	}
+	if (alloc_vectors != nvec) {
+		for (i = 0; i < alloc_vectors; i++) {
+			vec = *(vectors + i);
+			msi_free_vector(dev, vec);
+		}
+		spin_lock_irqsave(&msi_lock, flags);
+		msi_desc[dev->irq]->link.tail = msi_desc[dev->irq]->link.head;
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EBUSY;
+	}
+	if (nr_msix_devices > 0)
+		nr_msix_devices--;
+
+	return 0;
+}
+
+int msi_free_vectors(struct pci_dev* dev, int *vector, int nvec)
+{
+	struct msi_desc *entry;
+	int i;
+	unsigned long flags;
+
+	if (!pci_msi_enable)
+ 		return -EINVAL;
+	
+	spin_lock_irqsave(&msi_lock, flags);
+	entry = msi_desc[dev->irq];
+	if (!entry || entry->dev != dev || 
+	   	entry->msi_attrib.type != PCI_CAP_ID_MSIX || 
+		entry->link.head == entry->link.tail) {	/* Nothing to free */
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EINVAL;
+	}
+	spin_unlock_irqrestore(&msi_lock, flags);
+
+	for (i = 0; i < nvec; i++) {
+		if (*(vector + i) == dev->irq)
+			continue;/* Don't free entry 0 if mistaken by driver */
+		msi_free_vector(dev, *(vector + i)); 
+	}
+
+	return 0;
+}
+
+/**
+ * msi_remove_pci_irq_vectors: reclaim all MSI previous assigned to this device
+ * argument: device pointer of type struct pci_dev 
+ *
+ * description: used during hotplug removed, from which device is hot-removed;
+ * PCI subsystem reclaims associated MSI to unused state, which may be used 
+ * later on.
+ **/ 
+void msi_remove_pci_irq_vectors(struct pci_dev* dev)
+{
+	struct msi_desc *entry;
+	int type;
+	unsigned long flags;
+
+	if (!pci_msi_enable)
+ 		return;
+	
+	spin_lock_irqsave(&msi_lock, flags);
+	entry = msi_desc[dev->irq];
+	if (!entry || entry->dev != dev) {
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return;
+	}
+	type = entry->msi_attrib.type;
+	spin_unlock_irqrestore(&msi_lock, flags);
+		
+	msi_free_vector(dev, dev->irq);
+	if (type == PCI_CAP_ID_MSIX) {
+		int i, pos, dev_msi_cap;
+		u32 phys_addr, table_offset;
+		u32 control;
+		u8 bir;
+
+   		pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+		dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 			2, &control);
+		dev_msi_cap = multi_msix_capable(control);
+		dev->bus->ops->read(dev->bus, dev->devfn, 
+			msix_table_offset_reg(pos), 4, &table_offset);
+		bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+		phys_addr = pci_resource_start (dev, bir);
+		phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
+		for (i = FIRST_DEVICE_VECTOR; i < NR_IRQS; i++) {
+			spin_lock_irqsave(&msi_lock, flags);
+			if (!msi_desc[i] || msi_desc[i]->dev != dev) {
+				spin_unlock_irqrestore(&msi_lock, flags);
+				continue;
+			}
+			spin_unlock_irqrestore(&msi_lock, flags);
+			msi_free_vector(dev, i);
+		}
+		writel(1, entry->mask_base + PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
+		iounmap((void*)entry->mask_base);
+		release_mem_region(phys_addr, dev_msi_cap * PCI_MSIX_ENTRY_SIZE);
+	} 
+	nr_reserved_vectors++;
+}
+
+EXPORT_SYMBOL(pci_enable_msi);
+EXPORT_SYMBOL(msi_alloc_vectors);
+EXPORT_SYMBOL(msi_free_vectors);
diff -urN linux-260t5-vectorbase-testbox/drivers/pci/probe.c linux-260t5-msi-testbox/drivers/pci/probe.c
--- linux-260t5-vectorbase-testbox/drivers/pci/probe.c	2003-09-08 15:50:17.000000000 -0400
+++ linux-260t5-msi-testbox/drivers/pci/probe.c	2003-09-22 12:08:56.000000000 -0400
@@ -552,6 +552,7 @@
 		struct pci_dev *dev;
 
 		dev = pci_scan_device(bus, devfn);
+		pci_scan_msi_device(dev);
 		if (func == 0) {
 			if (!dev)
 				break;
@@ -564,6 +565,9 @@
 		/* Fix up broken headers */
 		pci_fixup_device(PCI_FIXUP_HEADER, dev);
 
+		/* Fix up broken MSI hardware */
+		pci_fixup_device(PCI_FIXUP_MSI, dev);
+
 		/*
 		 * Add the device to our list of discovered devices
 		 * and the bus list for fixup functions, etc.
diff -urN linux-260t5-vectorbase-testbox/drivers/pci/remove.c linux-260t5-msi-testbox/drivers/pci/remove.c
--- linux-260t5-vectorbase-testbox/drivers/pci/remove.c	2003-09-08 15:49:57.000000000 -0400
+++ linux-260t5-msi-testbox/drivers/pci/remove.c	2003-09-22 12:08:56.000000000 -0400
@@ -14,6 +14,8 @@
 {
 	int i;
 
+ 	msi_remove_pci_irq_vectors(dev);
+ 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *res = dev->resource + i;
 		if (res->parent)
diff -urN linux-260t5-vectorbase-testbox/include/linux/pci.h linux-260t5-msi-testbox/include/linux/pci.h
--- linux-260t5-vectorbase-testbox/include/linux/pci.h	2003-09-08 15:50:03.000000000 -0400
+++ linux-260t5-msi-testbox/include/linux/pci.h	2003-09-22 12:08:56.000000000 -0400
@@ -36,6 +36,7 @@
 #define  PCI_COMMAND_WAIT 	0x80	/* Enable address/data stepping */
 #define  PCI_COMMAND_SERR	0x100	/* Enable SERR */
 #define  PCI_COMMAND_FAST_BACK	0x200	/* Enable back-to-back writes */
+#define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
 
 #define PCI_STATUS		0x06	/* 16 bits */
 #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
@@ -198,6 +199,8 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
+#define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
+#define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
 #define PCI_CAP_SIZEOF		4
@@ -275,11 +278,13 @@
 #define  PCI_MSI_FLAGS_QSIZE	0x70	/* Message queue size configured */
 #define  PCI_MSI_FLAGS_QMASK	0x0e	/* Maximum queue size available */
 #define  PCI_MSI_FLAGS_ENABLE	0x01	/* MSI feature enabled */
+#define  PCI_MSI_FLAGS_MASKBIT	0x100	/* 64-bit mask bits allowed */
 #define PCI_MSI_RFU		3	/* Rest of capability flags */
 #define PCI_MSI_ADDRESS_LO	4	/* Lower 32 bits */
 #define PCI_MSI_ADDRESS_HI	8	/* Upper 32 bits (if PCI_MSI_FLAGS_64BIT set) */
 #define PCI_MSI_DATA_32		8	/* 16 bits of data for 32-bit devices */
 #define PCI_MSI_DATA_64		12	/* 16 bits of data for 64-bit devices */
+#define PCI_MSI_MASK_BIT	16	/* Mask bits register */
 
 /* CompactPCI Hotswap Register */
 
@@ -696,6 +701,18 @@
 extern struct pci_dev *isa_bridge;
 #endif
 
+#ifndef CONFIG_PCI_USE_VECTOR
+static inline void pci_scan_msi_device(struct pci_dev *dev) {}
+static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
+static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
+#else
+extern void pci_scan_msi_device(struct pci_dev *dev);
+extern int pci_enable_msi(struct pci_dev *dev);
+extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+extern int msi_alloc_vectors(struct pci_dev* dev, int *vector, int nvec);
+extern int msi_free_vectors(struct pci_dev* dev, int *vector, int nvec);
+#endif
+
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
@@ -866,6 +883,7 @@
 
 #define PCI_FIXUP_HEADER	1		/* Called immediately after reading configuration header */
 #define PCI_FIXUP_FINAL		2		/* Final phase of device fixups */
+#define PCI_FIXUP_MSI		3		/* Fixup for MSI buggy hardware */
 
 void pci_fixup_device(int pass, struct pci_dev *dev);
 
diff -urN linux-260t5-vectorbase-testbox/include/linux/pci_msi.h linux-260t5-msi-testbox/include/linux/pci_msi.h
--- linux-260t5-vectorbase-testbox/include/linux/pci_msi.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-260t5-msi-testbox/include/linux/pci_msi.h	2003-09-25 10:51:35.000000000 -0400
@@ -0,0 +1,170 @@
+/*
+ *	../include/linux/pci_msi.h
+ *
+ */
+
+#ifndef _ASM_PCI_MSI_H
+#define _ASM_PCI_MSI_H
+
+#include <linux/pci.h>
+
+#define MSI_AUTO -1
+#define NR_REPEATS	23
+#define NR_RESERVED_VECTORS 3 /*FIRST_DEVICE_VECTOR,FIRST_SYSTEM_VECTOR,0x80 */	
+
+/* 
+ * Assume the maximum number of hot plug slots supported by the system is about
+ * ten. The worstcase is that each of these slots is hot-added with a device, 
+ * which has two MSI/MSI-X capable functions. To avoid any MSI-X driver, which
+ * attempts to request all available vectors, NR_HP_RESERVED_VECTORS is defined
+ * as below to ensure at least one message is assigned to each detected MSI/
+ * MSI-X device function.
+ */
+#define NR_HP_RESERVED_VECTORS 	20
+
+extern int vector_irq[NR_IRQS];
+extern cpumask_t pending_irq_balance_cpumask[NR_IRQS];
+extern void (*interrupt[NR_IRQS])(void);
+
+#ifdef CONFIG_SMP
+#define set_msi_irq_affinity	set_msi_affinity
+#else
+#define set_msi_irq_affinity	NULL
+static inline void move_msi(int vector) {}
+#endif
+
+#ifndef CONFIG_X86_IO_APIC
+static inline int get_ioapic_vector(struct pci_dev *dev) { return -1;}
+static inline void restore_ioapic_irq_handler(int irq) {}
+#else
+extern void restore_ioapic_irq_handler(int irq);
+#endif
+
+/*
+ * MSI-X Address Register
+ */
+#define PCI_MSIX_FLAGS_QSIZE		0x7FF
+#define PCI_MSIX_FLAGS_ENABLE		(1 << 15)
+#define PCI_MSIX_FLAGS_BIRMASK		(7 << 0)
+#define PCI_MSIX_FLAGS_BITMASK		(1 << 0)
+
+#define PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET	0
+#define PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET	4
+#define PCI_MSIX_ENTRY_DATA_OFFSET		8
+#define PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET	12
+#define PCI_MSIX_ENTRY_SIZE			16
+
+#define msi_control_reg(base)		(base + PCI_MSI_FLAGS)
+#define msi_lower_address_reg(base)	(base + PCI_MSI_ADDRESS_LO)
+#define msi_upper_address_reg(base)	(base + PCI_MSI_ADDRESS_HI)
+#define msi_data_reg(base, is64bit)	\
+	( (is64bit == 1) ? base+PCI_MSI_DATA_64 : base+PCI_MSI_DATA_32 )
+#define msi_mask_bits_reg(base, is64bit) \
+	( (is64bit == 1) ? base+PCI_MSI_MASK_BIT : base+PCI_MSI_MASK_BIT-4)
+#define msi_disable(control)		control &= ~PCI_MSI_FLAGS_ENABLE
+#define multi_msi_capable(control) \
+	(1 << ((control & PCI_MSI_FLAGS_QMASK) >> 1))
+#define multi_msi_enable(control, num) \
+	control |= (((num >> 1) << 4) & PCI_MSI_FLAGS_QSIZE);
+#define is_64bit_address(control)	(control & PCI_MSI_FLAGS_64BIT)	
+#define is_mask_bit_support(control)	(control & PCI_MSI_FLAGS_MASKBIT)
+#define msi_enable(control, num) multi_msi_enable(control, num); \
+	control |= PCI_MSI_FLAGS_ENABLE
+ 
+#define msix_control_reg		msi_control_reg
+#define msix_table_offset_reg(base)	(base + 0x04)
+#define msix_pba_offset_reg(base)	(base + 0x08)
+#define msix_enable(control)	 	control |= PCI_MSIX_FLAGS_ENABLE
+#define msix_disable(control)	 	control &= ~PCI_MSIX_FLAGS_ENABLE
+#define msix_table_size(control) 	((control & PCI_MSIX_FLAGS_QSIZE)+1)
+#define multi_msix_capable		msix_table_size
+#define msix_unmask(address)	 	(address & ~PCI_MSIX_FLAGS_BITMASK)
+#define msix_mask(address)		(address | PCI_MSIX_FLAGS_BITMASK)  
+#define msix_is_pending(address) 	(address & PCI_MSIX_FLAGS_PENDMASK)
+
+extern char __dbg_str_buf[256];
+#define _DEFINE_DBG_BUFFER	char __dbg_str_buf[256];
+#define _DBG_K_TRACE_ENTRY	((unsigned int)0x00000001)
+#define _DBG_K_TRACE_EXIT	((unsigned int)0x00000002)
+#define _DBG_K_INFO		((unsigned int)0x00000004)
+#define _DBG_K_ERROR		((unsigned int)0x00000008)
+#define _DBG_K_TRACE	(_DBG_K_TRACE_ENTRY | _DBG_K_TRACE_EXIT)
+
+#define _DEBUG_LEVEL	(_DBG_K_INFO | _DBG_K_ERROR | _DBG_K_TRACE)
+#define _DBG_PRINT( dbg_flags, args... )		\
+if ( _DEBUG_LEVEL & (dbg_flags) )			\
+{							\
+	int len;					\
+	len = sprintf(__dbg_str_buf, "%s:%d: %s ", 	\
+		__FILE__, __LINE__, __FUNCTION__ ); 	\
+	sprintf(__dbg_str_buf + len, args);		\
+	printk(KERN_INFO "%s\n", __dbg_str_buf);	\
+}
+
+#define MSI_FUNCTION_TRACE_ENTER	\
+	_DBG_PRINT (_DBG_K_TRACE_ENTRY, "%s", "[Entry]");
+#define MSI_FUNCTION_TRACE_EXIT		\
+	_DBG_PRINT (_DBG_K_TRACE_EXIT, "%s", "[Entry]");
+	
+/*
+ * MSI Defined Data Structures
+ */
+#define MSI_ADDRESS_HEADER		0xfee
+#define MSI_DELIVERY_MODE		0
+#define MSI_LEVEL_MODE			1	/* Edge always assert */
+#define MSI_TRIGGER_MODE		0	/* MSI is edge sensitive */
+#define MSI_LOGICAL_MODE		1
+#define MSI_REDIRECTION_HINT_MODE	0
+#ifdef CONFIG_SMP
+#define MSI_TARGET_CPU			logical_smp_processor_id()
+#else
+#define MSI_TARGET_CPU			TARGET_CPUS
+#endif
+struct msg_data {	
+	__u32	vector	:  8,		
+	delivery_mode	:  3,	/*	000b: FIXED
+			 		001b: lowest priority
+			 	 	111b: ExtINT */	
+	reserved_1	:  3,
+	level		:  1,	/* 0: deassert, 1: assert */	
+	trigger		:  1,	/* 0: edge, 1: level */	
+	reserved_2	: 16;
+} __attribute__ ((packed));
+
+struct msg_address {
+	union {
+		struct { __u32
+			reserved_1		:  2,		
+			dest_mode		:  1,	/* 0: physical, 
+							   1: logical */	
+			redirection_hint        :  1,  	/* 0: dedicated CPU 
+							   1: lowest priority */
+			reserved_2		:  8,   	
+ 			dest_id			:  8,	/* Destination ID */	
+			header			: 12;	/* FEEH */
+      	}u;
+       	__u32  value;
+	}lo_address;
+	__u32 	hi_address;
+} __attribute__ ((packed));
+
+struct msi_desc {
+	struct {
+		__u32	type	: 5, /* {0: unused, 5h:MSI, 11h:MSI-X} 	  */
+			maskbit	: 1, /* mask-pending bit supported ?      */
+			reserved: 2, /* reserved			  */
+			entry_nr: 8, /* specific enabled entry 		  */
+			default_vector: 8, /* default pre-assigned vector */ 
+			current_cpu: 8; /* current destination cpu	  */
+	}msi_attrib;
+
+	struct {
+		__u32	head	: 16, 
+			tail	: 16; 
+	}link;
+
+	unsigned long mask_base;
+	struct pci_dev *dev;
+};
+
+#endif /* _ASM_PCI_MSI_H */
