Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUDOVXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUDOVXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:23:36 -0400
Received: from fmr06.intel.com ([134.134.136.7]:57498 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263372AbUDOVTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:19:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] PCI MSI Kconfig consolidation
Date: Thu, 15 Apr 2004 13:49:58 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058251@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PCI MSI Kconfig consolidation
Thread-Index: AcQjJ/7DJhk6IGxuSwWNniTYefMJBAAAJK6g
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, "Andi Kleen" <ak@suse.de>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Grant Grundler" <iod00d@hp.com>
X-OriginalArrivalTime: 15 Apr 2004 20:49:59.0219 (UTC) FILETIME=[37566030:01C4232B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 1:16 pm, Nguyen, Tom L wrote:
>> On Tuesday, April 13, Bjorn Helgaas wrote:
>> 
>> > This consolidates the PCI MSI configuration into drivers/pci/Kconfig,
>> > removing it from the i386, x86_64, and ia64 Kconfig.
>> >
>> > It also changes the default for ia64 from "y" to "n".  The default on
>> > i386 is "n" already, and I'm not sure why ia64 should be different.
>> 
>> It looks good; however, it may create a confusion on ia64 because ia64 
>> is already vector-based indexing. 
>
>No.  This is one reason why I think the MSI configuration symbol
>should be CONFIG_PCI_MSI, not CONFIG_PCI_USE_VECTOR.

Based on your PCI MSI Kconfig consolidation patch, the below patch converts the
use of CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI. Please let us know your comments.

Thanks,
Long 


--------------------------------------------------------------------------------

diff -urN 2.6.5-bk2/arch/i386/defconfig 2.6.5-bk2-msi-patch/arch/i386/defconfig
--- 2.6.5-bk2/arch/i386/defconfig	2004-04-03 22:37:36.000000000 -0500
+++ 2.6.5-bk2-msi-patch/arch/i386/defconfig	2004-04-15 11:59:24.000000000 -0400
@@ -167,7 +167,7 @@
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
 CONFIG_PCI_MMCONFIG=y
-# CONFIG_PCI_USE_VECTOR is not set
+# CONFIG_PCI_MSI is not set
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
 CONFIG_ISA=y
diff -urN 2.6.5-bk2/arch/i386/Kconfig 2.6.5-bk2-msi-patch/arch/i386/Kconfig
--- 2.6.5-bk2/arch/i386/Kconfig	2004-04-15 12:26:28.100805158 -0400
+++ 2.6.5-bk2-msi-patch/arch/i386/Kconfig	2004-04-15 11:59:24.000000000 -0400
@@ -1095,25 +1095,6 @@
 	select ACPI_BOOT
 	default y
 
-config PCI_USE_VECTOR
-	bool "Vector-based interrupt indexing (MSI)"
-	depends on X86_LOCAL_APIC && X86_IO_APIC
-	default n
-	help
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
-
-	   If you don't know what to do here, say N.
-
 source "drivers/pci/Kconfig"
 
 config ISA
diff -urN 2.6.5-bk2/arch/i386/kernel/io_apic.c 2.6.5-bk2-msi-patch/arch/i386/kernel/io_apic.c
--- 2.6.5-bk2/arch/i386/kernel/io_apic.c	2004-04-15 12:26:28.120336408 -0400
+++ 2.6.5-bk2-msi-patch/arch/i386/kernel/io_apic.c	2004-04-15 11:59:24.000000000 -0400
@@ -77,7 +77,7 @@
 } irq_2_pin[PIN_MAP_SIZE];
 
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
 #else
@@ -1149,7 +1149,7 @@
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 int assign_irq_vector(int irq)
 #else
 int __init assign_irq_vector(int irq)
@@ -1917,7 +1917,7 @@
 	}
 }
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static unsigned int startup_edge_ioapic_vector(unsigned int vector)
 {
 	int irq = vector_to_irq(vector);
diff -urN 2.6.5-bk2/arch/i386/pci/irq.c 2.6.5-bk2-msi-patch/arch/i386/pci/irq.c
--- 2.6.5-bk2/arch/i386/pci/irq.c	2004-04-15 12:26:28.134008282 -0400
+++ 2.6.5-bk2-msi-patch/arch/i386/pci/irq.c	2004-04-15 11:59:24.000000000 -0400
@@ -810,7 +810,7 @@
 		    	if ( dev2->irq && dev2->irq != irq && \
 			(!(pci_probe & PCI_USE_PIRQ_MASK) || \
 			((1 << dev2->irq) & mask)) ) {
-#ifndef CONFIG_PCI_USE_VECTOR
+#ifndef CONFIG_PCI_MSI
 		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
 				       pci_name(dev2), dev2->irq, irq);
 #endif
@@ -977,7 +977,7 @@
 				}
 				dev = temp_dev;
 				if (irq >= 0) {
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 					if (!platform_legacy_irq(irq))
 						irq = IO_APIC_VECTOR(irq);
 #endif
diff -urN 2.6.5-bk2/arch/ia64/Kconfig 2.6.5-bk2-msi-patch/arch/ia64/Kconfig
--- 2.6.5-bk2/arch/ia64/Kconfig	2004-04-15 12:26:28.134984845 -0400
+++ 2.6.5-bk2-msi-patch/arch/ia64/Kconfig	2004-04-15 11:59:24.000000000 -0400
@@ -361,16 +361,6 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
-config PCI_USE_VECTOR
-	bool
-	default y if IA64
-	help
-	   This enables MSI, Message Signaled Interrupt, on specific
-	   MSI capable device functions detected upon requests from the
-	   device drivers. Message Signal Interrupt enables an MSI-capable
-	   hardware device to send an inbound Memory Write on its PCI bus
-	   instead of asserting IRQ signal on device IRQ pin.
-
 config PCI_DOMAINS
 	bool
 	default PCI
diff -urN 2.6.5-bk2/arch/x86_64/Kconfig 2.6.5-bk2-msi-patch/arch/x86_64/Kconfig
--- 2.6.5-bk2/arch/x86_64/Kconfig	2004-04-15 12:26:28.459203591 -0400
+++ 2.6.5-bk2-msi-patch/arch/x86_64/Kconfig	2004-04-15 11:59:24.000000000 -0400
@@ -338,26 +338,6 @@
 	depends on PCI
 	select ACPI_BOOT
 
-# the drivers/pci/msi.c code needs to be fixed first before enabling
-config PCI_USE_VECTOR
-	bool "Vector-based interrupt indexing"
-	depends on X86_LOCAL_APIC && NOTWORKING
-	default n
-	help
-	   This replaces the current existing IRQ-based index interrupt scheme
-	   with the vector-base index scheme. The advantages of vector base
-	   over IRQ base are listed below:
-	   1) Support MSI implementation.
-	   2) Support future IOxAPIC hotplug
-
-	   Note that this enables MSI, Message Signaled Interrupt, on all
-	   MSI capable device functions detected if users also install the
-	   MSI patch. Message Signal Interrupt enables an MSI-capable
-	   hardware device to send an inbound Memory Write on its PCI bus
-	   instead of asserting IRQ signal on device IRQ pin.
-
-	   If you don't know what to do here, say N.
-
 source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
diff -urN 2.6.5-bk2/arch/x86_64/kernel/io_apic.c 2.6.5-bk2-msi-patch/arch/x86_64/kernel/io_apic.c
--- 2.6.5-bk2/arch/x86_64/kernel/io_apic.c	2004-04-15 12:26:28.467016091 -0400
+++ 2.6.5-bk2-msi-patch/arch/x86_64/kernel/io_apic.c	2004-04-15 11:59:24.000000000 -0400
@@ -67,7 +67,7 @@
 	short apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
@@ -654,7 +654,7 @@
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifndef CONFIG_PCI_USE_VECTOR
+#ifndef CONFIG_PCI_MSI
 int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
@@ -1394,7 +1394,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static unsigned int startup_edge_ioapic_vector(unsigned int vector)
 {
 	int irq = vector_to_irq(vector);
diff -urN 2.6.5-bk2/Documentation/MSI-HOWTO.txt 2.6.5-bk2-msi-patch/Documentation/MSI-HOWTO.txt
--- 2.6.5-bk2/Documentation/MSI-HOWTO.txt	2004-04-03 22:36:13.000000000 -0500
+++ 2.6.5-bk2-msi-patch/Documentation/MSI-HOWTO.txt	2004-04-15 12:05:53.000000000 -0400
@@ -4,6 +4,8 @@
 	Revised Feb 12, 2004 by Martine Silbermann
 		email: Martine.Silbermann@hp.com
 
+	Revised Apr 15, 2004 by Tom L Nguyen
+
 1. About this guide
 
 This guide describes the basics of Message Signaled Interrupts(MSI), the
@@ -92,18 +94,18 @@
 5. Configuring a driver to use MSI/MSI-X
 
 By default, the kernel will not enable MSI/MSI-X on all devices that
-support this capability. The CONFIG_PCI_USE_VECTOR kernel option
-must be selected to enable MSI/MSI-X support.
+support this capability. The CONFIG_PCI_MSI kernel option must be 
+selected to enable MSI/MSI-X support.
 
 5.1 Including MSI support into the kernel
 
 To allow MSI-Capable device drivers to selectively enable MSI (using
 pci_enable_msi as described below), the VECTOR based scheme needs to
-be enabled by setting CONFIG_PCI_USE_VECTOR.
+be enabled by setting CONFIG_PCI_MSI.
 
 Since the target of the inbound message is the local APIC, providing
-CONFIG_PCI_USE_VECTOR is dependent on whether CONFIG_X86_LOCAL_APIC
-is enabled or not.
+CONFIG_PCI_MSI is dependent on whether CONFIG_X86_LOCAL_APIC is 
+enabled or not.
 
 int pci_enable_msi(struct pci_dev *)
 
@@ -229,9 +231,9 @@
 In SMP environment, CONFIG_X86_LOCAL_APIC is automatically set;
 however, in UP environment, users must manually set
 CONFIG_X86_LOCAL_APIC. Once CONFIG_X86_LOCAL_APIC=y, setting
-CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and
-the option for MSI-capable device drivers to selectively enable
-MSI (using pci_enable_msi as described below).
+CONFIG_PCI_MSI enables the VECTOR based scheme and the option 
+for MSI-capable device drivers to selectively enable MSI 
+(using pci_enable_msi as described below).
 
 Note that CONFIG_X86_IO_APIC setting is irrelevant because MSI
 vector is allocated new during runtime and MSI support does not
diff -urN 2.6.5-bk2/drivers/acpi/osl.c 2.6.5-bk2-msi-patch/drivers/acpi/osl.c
--- 2.6.5-bk2/drivers/acpi/osl.c	2004-04-03 22:37:44.000000000 -0500
+++ 2.6.5-bk2-msi-patch/drivers/acpi/osl.c	2004-04-15 11:59:49.000000000 -0400
@@ -249,7 +249,7 @@
 	 */
 	irq = acpi_fadt.sci_int;
 
-#if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
+#if defined(CONFIG_IA64) || defined(CONFIG_PCI_MSI)
 	irq = acpi_irq_to_vector(irq);
 	if (irq < 0) {
 		printk(KERN_ERR PREFIX "SCI (ACPI interrupt %d) not registered\n",
@@ -272,7 +272,7 @@
 acpi_os_remove_interrupt_handler(u32 irq, OSD_HANDLER handler)
 {
 	if (irq) {
-#if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
+#if defined(CONFIG_IA64) || defined(CONFIG_PCI_MSI)
 		irq = acpi_irq_to_vector(irq);
 #endif
 		free_irq(irq, acpi_irq);
diff -urN 2.6.5-bk2/drivers/pci/hotplug/pciehp_hpc.c 2.6.5-bk2-msi-patch/drivers/pci/hotplug/pciehp_hpc.c
--- 2.6.5-bk2/drivers/pci/hotplug/pciehp_hpc.c	2004-04-03 22:37:36.000000000 -0500
+++ 2.6.5-bk2-msi-patch/drivers/pci/hotplug/pciehp_hpc.c	2004-04-15 11:59:49.000000000 -0400
@@ -1359,7 +1359,7 @@
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-#ifdef CONFIG_PCI_USE_VECTOR 
+#ifdef CONFIG_PCI_MSI 
 		rc = pci_enable_msi(pdev);
 		if (rc) {
 			err("Can't get msi for the hotplug controller\n");
diff -urN 2.6.5-bk2/drivers/pci/hotplug/shpchp_hpc.c 2.6.5-bk2-msi-patch/drivers/pci/hotplug/shpchp_hpc.c
--- 2.6.5-bk2/drivers/pci/hotplug/shpchp_hpc.c	2004-04-03 22:36:54.000000000 -0500
+++ 2.6.5-bk2-msi-patch/drivers/pci/hotplug/shpchp_hpc.c	2004-04-15 11:59:49.000000000 -0400
@@ -1547,7 +1547,7 @@
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-#ifdef CONFIG_PCI_USE_VECTOR 
+#ifdef CONFIG_PCI_MSI 
 		rc = pci_enable_msi(pdev);
 		if (rc) {
 			err("Can't get msi for the hotplug controller\n");
diff -urN 2.6.5-bk2/drivers/pci/Kconfig 2.6.5-bk2-msi-patch/drivers/pci/Kconfig
--- 2.6.5-bk2/drivers/pci/Kconfig	2004-04-03 22:36:54.000000000 -0500
+++ 2.6.5-bk2-msi-patch/drivers/pci/Kconfig	2004-04-15 11:59:49.000000000 -0400
@@ -1,6 +1,26 @@
 #
 # PCI configuration
 #
+config PCI_MSI
+	bool "PCI MSI support"
+	depends on (X86_LOCAL_APIC && X86_IO_APIC && !X86_64) || IA64
+	default n
+	help
+	   This replaces the current existing IRQ-based index interrupt 
+	   scheme of x86/x86_64 platform with the vector-based index 
+	   interrupt scheme. The advantages of vector-based indexing over
+	   IRQ-based indexing are listed below:
+	   1) Support Message Signaled Interrupt (MSI) implementation.
+	   2) Support future IOxAPIC hotplug
+
+	   Note that this allows MSI capable device driver to selectively 
+	   enable MSI on its device by calling pci_enable_msi(). A 
+	   successful return enables its hardware device to send an 
+	   inbound Memory Write on its PCI bus instead of asserting IRQ 
+	   signal on device IRQ pin.
+
+	   If you don't know what to do here, say N.
+
 config PCI_LEGACY_PROC
 	bool "Legacy /proc/pci interface"
 	depends on PCI
diff -urN 2.6.5-bk2/drivers/pci/Makefile 2.6.5-bk2-msi-patch/drivers/pci/Makefile
--- 2.6.5-bk2/drivers/pci/Makefile	2004-04-03 22:38:14.000000000 -0500
+++ 2.6.5-bk2-msi-patch/drivers/pci/Makefile	2004-04-15 11:59:49.000000000 -0400
@@ -27,7 +27,7 @@
 obj-$(CONFIG_SGI_IP27) += setup-irq.o
 obj-$(CONFIG_SGI_IP32) += setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
-obj-$(CONFIG_PCI_USE_VECTOR) += msi.o
+obj-$(CONFIG_PCI_MSI) += msi.o
 
 # Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) += setup-bus.o
diff -urN 2.6.5-bk2/include/asm-i386/io_apic.h 2.6.5-bk2-msi-patch/include/asm-i386/io_apic.h
--- 2.6.5-bk2/include/asm-i386/io_apic.h	2004-04-03 22:37:36.000000000 -0500
+++ 2.6.5-bk2-msi-patch/include/asm-i386/io_apic.h	2004-04-15 11:59:49.000000000 -0400
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
 static inline void mask_and_ack_level_ioapic_vector(unsigned int vector) { }
diff -urN 2.6.5-bk2/include/asm-i386/mach-default/irq_vectors_limits.h 2.6.5-bk2-msi-patch/include/asm-i386/mach-default/irq_vectors_limits.h
--- 2.6.5-bk2/include/asm-i386/mach-default/irq_vectors_limits.h	2004-04-15 12:26:31.144750433 -0400
+++ 2.6.5-bk2-msi-patch/include/asm-i386/mach-default/irq_vectors_limits.h	2004-04-15 11:59:49.000000000 -0400
@@ -1,7 +1,7 @@
 #ifndef _ASM_IRQ_VECTORS_LIMITS_H
 #define _ASM_IRQ_VECTORS_LIMITS_H
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 #define NR_IRQS FIRST_SYSTEM_VECTOR
 #define NR_IRQ_VECTORS NR_IRQS
 #else
diff -urN 2.6.5-bk2/include/asm-x86_64/io_apic.h 2.6.5-bk2-msi-patch/include/asm-x86_64/io_apic.h
--- 2.6.5-bk2/include/asm-x86_64/io_apic.h	2004-04-03 22:36:24.000000000 -0500
+++ 2.6.5-bk2-msi-patch/include/asm-x86_64/io_apic.h	2004-04-15 11:59:49.000000000 -0400
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_X86_IO_APIC
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 static inline int use_pci_vector(void)	{return 1;}
 static inline void disable_edge_ioapic_vector(unsigned int vector) { }
 static inline void mask_and_ack_level_ioapic_vector(unsigned int vector) { }
diff -urN 2.6.5-bk2/include/asm-x86_64/irq.h 2.6.5-bk2-msi-patch/include/asm-x86_64/irq.h
--- 2.6.5-bk2/include/asm-x86_64/irq.h	2004-04-15 12:26:31.201391057 -0400
+++ 2.6.5-bk2-msi-patch/include/asm-x86_64/irq.h	2004-04-15 11:59:49.000000000 -0400
@@ -31,7 +31,7 @@
 
 #define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
 
-#ifdef CONFIG_PCI_USE_VECTOR
+#ifdef CONFIG_PCI_MSI
 #define NR_IRQS FIRST_SYSTEM_VECTOR
 #define NR_IRQ_VECTORS NR_IRQS
 #else
diff -urN 2.6.5-bk2/include/linux/pci.h 2.6.5-bk2-msi-patch/include/linux/pci.h
--- 2.6.5-bk2/include/linux/pci.h	2004-04-15 12:26:31.343969181 -0400
+++ 2.6.5-bk2-msi-patch/include/linux/pci.h	2004-04-15 11:59:49.635980989 -0400
@@ -707,7 +707,7 @@
 extern struct pci_dev *isa_bridge;
 #endif
 
-#ifndef CONFIG_PCI_USE_VECTOR
+#ifndef CONFIG_PCI_MSI
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
