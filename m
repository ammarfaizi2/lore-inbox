Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUFCXbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUFCXbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbUFCXbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:31:18 -0400
Received: from fmr05.intel.com ([134.134.136.6]:10893 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264658AbUFCXbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:31:10 -0400
Date: Thu, 3 Jun 2004 18:20:29 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200406040120.i541KT53004130@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH]2.6.7-rc1 Fix and Reenable MSI Support on x86_64
Cc: ak@suse.de, akpm@osdl.org, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MSI support for x86_64 is currently disabled in the kernel 2.6.x.
Below is the patch, which provides a fix and reenable it.

In addition, the patch provides a info message during kernel boot
if configuring vector-base indexing. 

Thanks,
Long

-----------------------------------------------------------------
diff -urN linux-2.6.7-rc1/arch/i386/kernel/io_apic.c 2.6.7-rc1-msi64/arch/i386/kernel/io_apic.c
--- linux-2.6.7-rc1/arch/i386/kernel/io_apic.c	2004-06-01 13:55:42.000000000 -0400
+++ 2.6.7-rc1-msi64/arch/i386/kernel/io_apic.c	2004-06-03 10:22:46.069624128 -0400
@@ -1451,12 +1451,17 @@
 		);
 	}
 	}
+	if (use_pci_vector())  
+		printk(KERN_INFO "Using vector-based indexing\n");
 	printk(KERN_DEBUG "IRQ to pin mappings:\n");
 	for (i = 0; i < NR_IRQS; i++) {
 		struct irq_pin_list *entry = irq_2_pin + i;
 		if (entry->pin < 0)
 			continue;
-		printk(KERN_DEBUG "IRQ%d ", i);
+ 		if (use_pci_vector() && !platform_legacy_irq(i))
+			printk(KERN_DEBUG "IRQ%d ", IO_APIC_VECTOR(i));
+		else
+			printk(KERN_DEBUG "IRQ%d ", i);
 		for (;;) {
 			printk("-> %d:%d", entry->apic, entry->pin);
 			if (!entry->next)
diff -urN linux-2.6.7-rc1/arch/x86_64/kernel/i8259.c 2.6.7-rc1-msi64/arch/x86_64/kernel/i8259.c
--- linux-2.6.7-rc1/arch/x86_64/kernel/i8259.c	2004-05-09 22:32:01.000000000 -0400
+++ 2.6.7-rc1-msi64/arch/x86_64/kernel/i8259.c	2004-06-02 13:21:36.000000000 -0400
@@ -47,6 +47,12 @@
 	BI(x,8) BI(x,9) BI(x,a) BI(x,b) \
 	BI(x,c) BI(x,d) BI(x,e) BI(x,f)
 
+#define BUILD_15_IRQS(x) \
+	BI(x,0) BI(x,1) BI(x,2) BI(x,3) \
+	BI(x,4) BI(x,5) BI(x,6) BI(x,7) \
+	BI(x,8) BI(x,9) BI(x,a) BI(x,b) \
+	BI(x,c) BI(x,d) BI(x,e) 
+
 /*
  * ISA PIC or low IO-APIC triggered (INTA-cycle or APIC) interrupts:
  * (these are usually mapped to vectors 0x20-0x2f)
@@ -68,6 +74,11 @@
 BUILD_16_IRQS(0x4) BUILD_16_IRQS(0x5) BUILD_16_IRQS(0x6) BUILD_16_IRQS(0x7)
 BUILD_16_IRQS(0x8) BUILD_16_IRQS(0x9) BUILD_16_IRQS(0xa) BUILD_16_IRQS(0xb)
 BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
+
+#ifdef CONFIG_PCI_USE_VECTOR
+	BUILD_15_IRQS(0xe)
+#endif
+
 #endif
 
 #undef BUILD_16_IRQS
@@ -83,6 +94,12 @@
 	IRQ(x,8), IRQ(x,9), IRQ(x,a), IRQ(x,b), \
 	IRQ(x,c), IRQ(x,d), IRQ(x,e), IRQ(x,f)
 
+#define IRQLIST_15(x) \
+	IRQ(x,0), IRQ(x,1), IRQ(x,2), IRQ(x,3), \
+	IRQ(x,4), IRQ(x,5), IRQ(x,6), IRQ(x,7), \
+	IRQ(x,8), IRQ(x,9), IRQ(x,a), IRQ(x,b), \
+	IRQ(x,c), IRQ(x,d), IRQ(x,e)
+
 void (*interrupt[NR_IRQS])(void) = {
 	IRQLIST_16(0x0),
 
@@ -91,6 +108,11 @@
 	IRQLIST_16(0x4), IRQLIST_16(0x5), IRQLIST_16(0x6), IRQLIST_16(0x7),
 	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
 	IRQLIST_16(0xc), IRQLIST_16(0xd)
+
+#ifdef CONFIG_PCI_USE_VECTOR
+	, IRQLIST_15(0xe)
+#endif
+
 #endif
 };
 
diff -urN linux-2.6.7-rc1/arch/x86_64/kernel/io_apic.c 2.6.7-rc1-msi64/arch/x86_64/kernel/io_apic.c
--- linux-2.6.7-rc1/arch/x86_64/kernel/io_apic.c	2004-06-01 13:55:42.000000000 -0400
+++ 2.6.7-rc1-msi64/arch/x86_64/kernel/io_apic.c	2004-06-03 10:25:26.742198184 -0400
@@ -67,8 +67,8 @@
 	short apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
+int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
 #ifdef CONFIG_PCI_USE_VECTOR
-int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
 #else
@@ -655,10 +655,14 @@
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifndef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_USE_VECTOR
+int assign_irq_vector(int irq)
+#else
 int __init assign_irq_vector(int irq)
+#endif
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	
 	BUG_ON(irq >= NR_IRQ_VECTORS);
 	if (IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
@@ -667,18 +671,19 @@
 	if (current_vector == IA32_SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
+	if (current_vector >= FIRST_SYSTEM_VECTOR) {
 		offset++;
+		if (!(offset%8))
+			return -ENOSPC;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt sources!");
+	vector_irq[current_vector] = irq;
+	if (irq != AUTO_ASSIGN)
+		IO_APIC_VECTOR(irq) = current_vector;
 
-	IO_APIC_VECTOR(irq) = current_vector;
 	return current_vector;
 }
-#endif
 
 extern void (*interrupt[NR_IRQS])(void);
 static struct hw_interrupt_type ioapic_level_type;
@@ -924,12 +929,17 @@
 		);
 	}
 	}
+	if (use_pci_vector())  
+		printk(KERN_INFO "Using vector-based indexing\n");
 	printk(KERN_DEBUG "IRQ to pin mappings:\n");
 	for (i = 0; i < NR_IRQS; i++) {
 		struct irq_pin_list *entry = irq_2_pin + i;
 		if (entry->pin < 0)
 			continue;
-		printk(KERN_DEBUG "IRQ%d ", i);
+ 		if (use_pci_vector() && !platform_legacy_irq(i))
+			printk(KERN_DEBUG "IRQ%d ", IO_APIC_VECTOR(i));
+		else
+			printk(KERN_DEBUG "IRQ%d ", i);
 		for (;;) {
 			printk("-> %d:%d", entry->apic, entry->pin);
 			if (!entry->next)
diff -urN linux-2.6.7-rc1/drivers/pci/Kconfig 2.6.7-rc1-msi64/drivers/pci/Kconfig
--- linux-2.6.7-rc1/drivers/pci/Kconfig	2004-05-09 22:32:26.000000000 -0400
+++ 2.6.7-rc1-msi64/drivers/pci/Kconfig	2004-06-02 15:52:44.000000000 -0400
@@ -3,7 +3,7 @@
 #
 config PCI_USE_VECTOR
 	bool "Vector-based interrupt indexing (MSI)"
-	depends on (X86_LOCAL_APIC && X86_IO_APIC && !X86_64) || IA64
+	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
 	default n
 	help
 	   This replaces the current existing IRQ-based index interrupt scheme
diff -urN linux-2.6.7-rc1/include/asm-x86_64/hw_irq.h 2.6.7-rc1-msi64/include/asm-x86_64/hw_irq.h
--- linux-2.6.7-rc1/include/asm-x86_64/hw_irq.h	2004-05-09 22:33:20.000000000 -0400
+++ 2.6.7-rc1-msi64/include/asm-x86_64/hw_irq.h	2004-06-02 09:09:20.000000000 -0400
@@ -78,6 +78,7 @@
 #ifndef __ASSEMBLY__
 extern u8 irq_vector[NR_IRQ_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
+#define AUTO_ASSIGN		-1
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
diff -urN linux-2.6.7-rc1/include/asm-x86_64/msi.h 2.6.7-rc1-msi64/include/asm-x86_64/msi.h
--- linux-2.6.7-rc1/include/asm-x86_64/msi.h	2004-05-09 22:33:13.000000000 -0400
+++ 2.6.7-rc1-msi64/include/asm-x86_64/msi.h	2004-06-02 10:24:57.000000000 -0400
@@ -11,11 +11,6 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_DEST_MODE			MSI_LOGICAL_MODE
 #define MSI_TARGET_CPU_SHIFT		12
-
-#ifdef CONFIG_SMP
-#define MSI_TARGET_CPU		logical_smp_processor_id()
-#else
-#define MSI_TARGET_CPU		TARGET_CPUS
-#endif
+#define MSI_TARGET_CPU			TARGET_CPUS
 
 #endif /* ASM_MSI_H */
