Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUGZWQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUGZWQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUGZWQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:16:24 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:37036 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266081AbUGZWPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:15:54 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI
Date: Mon, 26 Jul 2004 16:15:52 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Tom L Nguyen <tom.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407261615.52261.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI.  The "vector"
terminology is architecture-dependent.  The PCI MSI interface
actually deals with Linux IRQ numbers (i.e., things you can
pass to request_irq()), and we shouldn't confuse things by
calling them "vectors" just because we're using MSI rather
than an IOSAPIC.

A similar patch was discussed a few months ago:
    http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&th=92003e5ae290e1de&rnum=1
but it didn't seem to go anywhere.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== Documentation/MSI-HOWTO.txt 1.2 vs edited =====
--- 1.2/Documentation/MSI-HOWTO.txt	2004-02-20 08:44:42 -07:00
+++ edited/Documentation/MSI-HOWTO.txt	2004-07-26 15:24:15 -06:00
@@ -92,17 +92,17 @@
 5. Configuring a driver to use MSI/MSI-X
 
 By default, the kernel will not enable MSI/MSI-X on all devices that
-support this capability. The CONFIG_PCI_USE_VECTOR kernel option
+support this capability. The CONFIG_PCI_MSI kernel option
 must be selected to enable MSI/MSI-X support.
 
 5.1 Including MSI support into the kernel
 
 To allow MSI-Capable device drivers to selectively enable MSI (using
 pci_enable_msi as described below), the VECTOR based scheme needs to
-be enabled by setting CONFIG_PCI_USE_VECTOR.
+be enabled by setting CONFIG_PCI_MSI.
 
 Since the target of the inbound message is the local APIC, providing
-CONFIG_PCI_USE_VECTOR is dependent on whether CONFIG_X86_LOCAL_APIC
+CONFIG_PCI_MSI is dependent on whether CONFIG_X86_LOCAL_APIC
 is enabled or not.
 
 int pci_enable_msi(struct pci_dev *)
@@ -229,7 +229,7 @@
 In SMP environment, CONFIG_X86_LOCAL_APIC is automatically set;
 however, in UP environment, users must manually set
 CONFIG_X86_LOCAL_APIC. Once CONFIG_X86_LOCAL_APIC=y, setting
-CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and
+CONFIG_PCI_MSI enables the VECTOR based scheme and
 the option for MSI-capable device drivers to selectively enable
 MSI (using pci_enable_msi as described below).
 
===== arch/i386/kernel/io_apic.c 1.103 vs edited =====
--- 1.103/arch/i386/kernel/io_apic.c	2004-06-24 02:56:14 -06:00
+++ edited/arch/i386/kernel/io_apic.c	2004-07-26 15:26:50 -06:00
@@ -73,7 +73,7 @@
 } irq_2_pin[PIN_MAP_SIZE];
 
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
 #else
@@ -1114,7 +1114,7 @@
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 int assign_irq_vector(int irq)
 #else
 int __init assign_irq_vector(int irq)
@@ -1868,7 +1868,7 @@
 	}
 }
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static unsigned int startup_edge_ioapic_vector(unsigned int vector)
 {
 	int irq = vector_to_irq(vector);
===== arch/i386/pci/irq.c 1.46 vs edited =====
--- 1.46/arch/i386/pci/irq.c	2004-06-27 01:19:28 -06:00
+++ edited/arch/i386/pci/irq.c	2004-07-26 15:26:51 -06:00
@@ -817,7 +817,7 @@
 		    	if ( dev2->irq && dev2->irq != irq && \
 			(!(pci_probe & PCI_USE_PIRQ_MASK) || \
 			((1 << dev2->irq) & mask)) ) {
-#ifndef CONFIG_PCI_USE_VECTOR
+#ifndef CONFIG_PCI_MSI
 		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
 				       pci_name(dev2), dev2->irq, irq);
 #endif
@@ -1034,7 +1034,7 @@
 				}
 				dev = temp_dev;
 				if (irq >= 0) {
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 					if (!platform_legacy_irq(irq))
 						irq = IO_APIC_VECTOR(irq);
 #endif
===== arch/x86_64/kernel/i8259.c 1.15 vs edited =====
--- 1.15/arch/x86_64/kernel/i8259.c	2004-07-13 07:08:43 -06:00
+++ edited/arch/x86_64/kernel/i8259.c	2004-07-26 15:26:52 -06:00
@@ -75,7 +75,7 @@
 BUILD_16_IRQS(0x8) BUILD_16_IRQS(0x9) BUILD_16_IRQS(0xa) BUILD_16_IRQS(0xb)
 BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd)
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 	BUILD_14_IRQS(0xe)
 #endif
 
@@ -110,7 +110,7 @@
 	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
 	IRQLIST_16(0xc), IRQLIST_16(0xd)
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 	, IRQLIST_14(0xe)
 #endif
 
===== arch/x86_64/kernel/io_apic.c 1.29 vs edited =====
--- 1.29/arch/x86_64/kernel/io_apic.c	2004-06-24 02:55:54 -06:00
+++ edited/arch/x86_64/kernel/io_apic.c	2004-07-26 15:26:52 -06:00
@@ -68,7 +68,7 @@
 } irq_2_pin[PIN_MAP_SIZE];
 
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
 #else
@@ -656,7 +656,7 @@
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 int assign_irq_vector(int irq)
 #else
 int __init assign_irq_vector(int irq)
@@ -1406,7 +1406,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static unsigned int startup_edge_ioapic_vector(unsigned int vector)
 {
 	int irq = vector_to_irq(vector);
===== drivers/pci/Kconfig 1.5 vs edited =====
--- 1.5/drivers/pci/Kconfig	2004-06-24 02:55:54 -06:00
+++ edited/drivers/pci/Kconfig	2004-07-26 15:26:53 -06:00
@@ -1,22 +1,15 @@
 #
 # PCI configuration
 #
-config PCI_USE_VECTOR
-	bool "Vector-based interrupt indexing (MSI)"
+config PCI_MSI
+	bool "Message-signalled interrupts (MSI and MSI-X)"
 	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
 	default n
 	help
-	   This replaces the current existing IRQ-based index interrupt scheme
-	   with the vector-base index scheme. The advantages of vector base
-	   over IRQ base are listed below:
-	   1) Support MSI implementation.
-	   2) Support future IOxAPIC hotplug
-
-	   Note that this allows the device drivers to enable MSI, Message
-	   Signaled Interrupt, on all MSI capable device functions detected.
-	   Message Signal Interrupt enables an MSI-capable hardware device to
-	   send an inbound Memory Write on its PCI bus instead of asserting
-	   IRQ signal on device IRQ pin.
+	   This allows device drivers to enable MSI (Message Signalled
+	   Interrupts).  Message Signalled Interrupts enable a device to
+	   generate an interrupt using an inbound Memory Write on its
+	   PCI bus instead of asserting a device IRQ pin.
 
 	   If you don't know what to do here, say N.
 
===== drivers/pci/Makefile 1.38 vs edited =====
--- 1.38/drivers/pci/Makefile	2004-04-22 02:40:35 -06:00
+++ edited/drivers/pci/Makefile	2004-07-26 15:27:23 -06:00
@@ -26,7 +26,7 @@
 obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
-obj-$(CONFIG_PCI_USE_VECTOR) += msi.o
+obj-$(CONFIG_PCI_MSI) += msi.o
 
 # Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) += setup-bus.o
===== include/asm-i386/io_apic.h 1.16 vs edited =====
--- 1.16/include/asm-i386/io_apic.h	2004-06-18 00:49:30 -06:00
+++ edited/include/asm-i386/io_apic.h	2004-07-26 15:26:53 -06:00
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
 static inline void mask_and_ack_level_ioapic_vector(unsigned int vector) { }
===== include/asm-i386/mach-default/irq_vectors_limits.h 1.1 vs edited =====
--- 1.1/include/asm-i386/mach-default/irq_vectors_limits.h	2004-04-12 11:54:29 -06:00
+++ edited/include/asm-i386/mach-default/irq_vectors_limits.h	2004-07-26 15:26:54 -06:00
@@ -1,7 +1,7 @@
 #ifndef _ASM_IRQ_VECTORS_LIMITS_H
 #define _ASM_IRQ_VECTORS_LIMITS_H
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 #define NR_IRQS FIRST_SYSTEM_VECTOR
 #define NR_IRQ_VECTORS NR_IRQS
 #else
===== include/asm-x86_64/io_apic.h 1.10 vs edited =====
--- 1.10/include/asm-x86_64/io_apic.h	2003-12-31 22:27:45 -07:00
+++ edited/include/asm-x86_64/io_apic.h	2004-07-26 15:26:55 -06:00
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
 static inline void mask_and_ack_level_ioapic_vector(unsigned int vector) { }
===== include/asm-x86_64/irq.h 1.6 vs edited =====
--- 1.6/include/asm-x86_64/irq.h	2004-04-12 11:54:45 -06:00
+++ edited/include/asm-x86_64/irq.h	2004-07-26 15:26:55 -06:00
@@ -31,7 +31,7 @@
 
 #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 #define NR_IRQS FIRST_SYSTEM_VECTOR
 #define NR_IRQ_VECTORS NR_IRQS
 #else
===== include/linux/pci.h 1.130 vs edited =====
--- 1.130/include/linux/pci.h	2004-06-30 12:21:27 -06:00
+++ edited/include/linux/pci.h	2004-07-26 15:26:56 -06:00
@@ -831,7 +831,7 @@
 extern struct pci_dev *isa_bridge;
 #endif
 
-#ifndef CONFIG_PCI_USE_VECTOR
+#ifndef CONFIG_PCI_MSI
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
