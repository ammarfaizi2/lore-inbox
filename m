Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270993AbTHGVwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTHGVv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:51:59 -0400
Received: from fmr05.intel.com ([134.134.136.6]:43714 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270993AbTHGVu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:50:57 -0400
Date: Thu, 7 Aug 2003 14:25:20 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Updated MSI Patches
Cc: jun.nakajima@intel.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an updated version of the MSI patch I posted for comments
several weeks ago. The patches below are based on kernel version 2.6.0-test2.
The changes from the original patch include:

- Separate the original patch into two patches - a vector base patch and MSI patch based on the vector base. The vector base patch replaces irq index scheme with vector-base index scheme. MSI patch requires the vector base patch to allocate new vectors on the fly.
- Change the interface name from msi_alloc_vectors to msix_alloc_vectors since 
this interface is used for MSI-X device drivers, which request for additional 
messages.
- Change the interface name from msi_free_vectors to msix_free_vectors since 
this interface is used for MSI-X device drivers, which request for releasing 
the number of vector back to the PCI subsystem.
- Change the function name from remove_hotplug_vectors to 
msi_remove_pci_irq_vectors to have a close match with function name 
msi_get_pci_irq_vector.
- Fix a bug in function which processes boot parameter "device_nomsi="
- Add MSI support to PCI hotplug by making MSI support transparent to hotplug 
controller drivers. The original patch required the hotplug controller drivers 
to explicitly call msi_get_pci_irq_vector and msi_remove_pci_irq_vectors 
functions during hot-add/hot-remove operations. This approach is not a good 
idea since it requires changes in the hot plug controller drivers. This patch 
makes MSI support transparent to any hotplug controller drivers.
- Add Documentation/MSI-HOWTO.txt to describe the basics of MSI, the 
advantages of using MSI over traditional interrupt mechanism, and how to 
enable the device drivers to use MSI or MSI-X. Also included is a description 
of debugging features available and Frequently Asked Questions.

I'd appreciate any feedback you have on the patch.   


Thanks,
Tom

diff -X excludes -urN linux-2.6.0-test2/arch/i386/Kconfig linux-2.6.0-test2-create-vectorbase/arch/i386/Kconfig
--- linux-2.6.0-test2/arch/i386/Kconfig	2003-07-27 12:57:48.000000000 -0400
+++ linux-2.6.0-test2-create-vectorbase/arch/i386/Kconfig	2003-08-05 09:25:54.000000000 -0400
@@ -1072,6 +1072,17 @@
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
diff -X excludes -urN linux-2.6.0-test2/arch/i386/kernel/i8259.c linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/i8259.c
--- linux-2.6.0-test2/arch/i386/kernel/i8259.c	2003-07-27 13:09:30.000000000 -0400
+++ linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/i8259.c	2003-08-05 09:25:54.000000000 -0400
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
diff -X excludes -urN linux-2.6.0-test2/arch/i386/kernel/io_apic.c linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test2/arch/i386/kernel/io_apic.c	2003-07-27 13:00:21.000000000 -0400
+++ linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c	2003-08-05 09:25:54.000000000 -0400
@@ -76,6 +76,20 @@
 	int apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
+#ifdef CONFIG_PCI_USE_VECTOR
+int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
+ 
+static int platform_irq(int irq) 	
+{ 	
+	if (platform_legacy_irq(irq))
+		return irq;
+	else
+		return vector_irq[irq];
+}
+#else
+#define platform_irq(irq)	(irq)
+#endif 
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -106,7 +120,7 @@
 				      int oldapic, int oldpin,
 				      int newapic, int newpin)
 {
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	while (1) {
 		if (entry->apic == oldapic && entry->pin == oldpin) {
@@ -123,7 +137,7 @@
 static void __mask_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -143,7 +157,7 @@
 static void __unmask_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -162,7 +176,7 @@
 static void __mask_and_edge_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -182,7 +196,7 @@
 static void __unmask_and_level_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -1140,8 +1154,10 @@
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
@@ -1152,13 +1168,46 @@
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
+#ifdef CONFIG_PCI_USE_VECTOR
+	vector_irq[current_vector] = irq;
+#endif
 	IO_APIC_VECTOR(irq) = current_vector;
+
 	return current_vector;
 }
 
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
+#define IOAPIC_AUTO	-1
+#define IOAPIC_EDGE	0
+#define IOAPIC_LEVEL	1
+
+static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
+{
+#ifdef CONFIG_PCI_USE_VECTOR
+			if (!platform_legacy_irq(irq)) {
+				if ((trigger == IOAPIC_AUTO && 
+				     IO_APIC_irq_trigger(irq)) ||
+				    trigger == IOAPIC_LEVEL)
+					irq_desc[vector].handler = &ioapic_level_irq_type;
+				else
+					irq_desc[vector].handler = &ioapic_edge_irq_type;
+				set_intr_gate(vector, interrupt[vector]);
+
+			} else 
+#endif
+			{
+				if ((trigger == IOAPIC_AUTO && 
+				     IO_APIC_irq_trigger(irq)) ||
+				    trigger == IOAPIC_LEVEL)
+					irq_desc[irq].handler = &ioapic_level_irq_type;
+				else
+					irq_desc[irq].handler = &ioapic_edge_irq_type;
+				set_intr_gate(vector, interrupt[irq]);
+			}
+}
+
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
@@ -1215,13 +1264,7 @@
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
@@ -1848,7 +1891,13 @@
  * operation to prevent an edge-triggered interrupt escaping meanwhile.
  * The idea is from Manfred Spraul.  --macro
  */
+#ifdef CONFIG_PCI_USE_VECTOR
+	if (!platform_legacy_irq(irq))		/* it's already the vector */
+		i = irq;
+	else
+#endif
 	i = IO_APIC_VECTOR(irq);
+
 	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
 
 	ack_APIC_irq();
@@ -1932,7 +1981,15 @@
 	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
 	 */
 	for (irq = 0; irq < NR_IRQS ; irq++) {
+#ifdef CONFIG_PCI_USE_VECTOR
+		int tmp;
+		tmp = platform_irq(irq);
+		if (tmp == -1)
+			continue;
+		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
+#else
 		if (IO_APIC_IRQ(irq) && !IO_APIC_VECTOR(irq)) {
+#endif
 			/*
 			 * Hmm.. We don't have an entry for this,
 			 * so default to an old-fashioned 8259
@@ -2362,9 +2419,7 @@
 		"IRQ %d)\n", ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
 
-	irq_desc[irq].handler = &ioapic_level_irq_type;
-
-	set_intr_gate(entry.vector, interrupt[irq]);
+	ioapic_register_intr(irq, entry.vector, IOAPIC_LEVEL);
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
diff -X excludes -urN linux-2.6.0-test2/arch/i386/kernel/mpparse.c linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/mpparse.c
--- linux-2.6.0-test2/arch/i386/kernel/mpparse.c	2003-07-27 12:59:51.000000000 -0400
+++ linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/mpparse.c	2003-08-05 09:25:54.000000000 -0400
@@ -1124,6 +1124,11 @@
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			printk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
+#ifdef CONFIG_PCI_USE_VECTOR
+			if (!platform_legacy_irq(irq))
+				entry->irq = IO_APIC_VECTOR(irq);
+			else
+#endif
 			entry->irq = irq;
 			continue;
 		}
@@ -1131,6 +1136,11 @@
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
 		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+#ifdef CONFIG_PCI_USE_VECTOR
+			if (!platform_legacy_irq(irq))
+				entry->irq = IO_APIC_VECTOR(irq);
+			else
+#endif
 			entry->irq = irq;
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
diff -X excludes -urN linux-2.6.0-test2/arch/i386/pci/irq.c linux-2.6.0-test2-create-vectorbase/arch/i386/pci/irq.c
--- linux-2.6.0-test2/arch/i386/pci/irq.c	2003-07-27 13:11:50.000000000 -0400
+++ linux-2.6.0-test2-create-vectorbase/arch/i386/pci/irq.c	2003-08-05 09:25:54.000000000 -0400
@@ -743,6 +743,11 @@
 							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
 				}
 				if (irq >= 0) {
+#ifdef CONFIG_PCI_USE_VECTOR
+					if (!platform_legacy_irq(irq))
+						irq = IO_APIC_VECTOR(irq);
+#endif
+
 					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
 						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
 					dev->irq = irq;
diff -X excludes -urN linux-2.6.0-test2/include/asm-i386/hw_irq.h linux-2.6.0-test2-create-vectorbase/include/asm-i386/hw_irq.h
--- linux-2.6.0-test2/include/asm-i386/hw_irq.h	2003-07-27 13:11:11.000000000 -0400
+++ linux-2.6.0-test2-create-vectorbase/include/asm-i386/hw_irq.h	2003-08-05 09:25:54.000000000 -0400
@@ -41,6 +41,7 @@
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(struct pt_regs);
+#define platform_legacy_irq(irq)	((irq) < 16)
 #endif
 
 extern void mask_irq(unsigned int irq);
diff -X excludes -urN linux-2.6.0-test2/include/asm-i386/mach-default/irq_vectors.h linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.0-test2/include/asm-i386/mach-default/irq_vectors.h	2003-07-27 12:58:54.000000000 -0400
+++ linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h	2003-08-05 09:25:54.000000000 -0400
@@ -76,9 +76,14 @@
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
  * the usable vector space is 0x20-0xff (224 vectors)
  */
+#define NR_VECTORS 256
 #ifdef CONFIG_X86_IO_APIC
+#ifndef CONFIG_PCI_USE_VECTOR
 #define NR_IRQS 224
 #else
+#define NR_IRQS FIRST_SYSTEM_VECTOR
+#endif
+#else
 #define NR_IRQS 16
 #endif
 

diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/Kconfig linux-2.6.0-test2-create-msi/arch/i386/Kconfig
--- linux-2.6.0-test2-create-vectorbase/arch/i386/Kconfig	2003-08-05 09:25:54.000000000 -0400
+++ linux-2.6.0-test2-create-msi/arch/i386/Kconfig	2003-08-05 09:45:25.000000000 -0400
@@ -1083,6 +1083,38 @@
 
 	   If you don't know what to do here, say N.
 
+config PCI_MSI
+	bool "ENABLE PCI MSI"
+	depends on PCI_USE_VECTOR
+	default n
+	help
+	   MSI means Message Signaled Interrupt, which allows any MSI-capable
+	   hardware device to send an inbound Memory Write on its PCI bus
+	   instead of asserting IRQ signal on device IRQ pin.
+
+	   This provides PCI MSI support. Enabling PCI MSI support requires 
+	   users set CONFIG_PCI_USE_VECTOR and this parameter since MSI support
+	   requires vector base indexing support.
+
+	   If you don't know what MSI is or enabling MSI does not serve you 
+	   any goods, say N.
+
+config PCI_MSI_ON_SPECIFIC_DEVICES
+	bool "ENABLE MSI ON SPECIFIC DEVICES (DEBUG)"
+	depends on PCI_MSI
+	default y
+	help
+	   This provides users with an option, which enables MSI on specific 
+	   devices instead of all (the default of the configuration parameter
+	   CONFIG_PCI_MSI). This, if set, prohibits the PCI subsystem from
+	   enabling MSI on all MSI capable devices except ones listed in the 
+	   boot parameter "device_msi=".
+
+	   Since some devices, which may have bugs in MSI, may break once MSI
+	   support is invoked in the kernel, this option serves to enable 
+	   specific MSI capable devices, which are fully validated with the 
+	   corresponding software drivers.   
+
 source "drivers/pci/Kconfig"
 
 config ISA
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/i386_ksyms.c linux-2.6.0-test2-create-msi/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/i386_ksyms.c	2003-07-27 13:11:42.000000000 -0400
+++ linux-2.6.0-test2-create-msi/arch/i386/kernel/i386_ksyms.c	2003-08-05 09:45:25.000000000 -0400
@@ -166,6 +166,11 @@
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 #endif
 
+#ifdef CONFIG_PCI_MSI
+EXPORT_SYMBOL(msix_alloc_vectors);
+EXPORT_SYMBOL(msix_free_vectors);
+#endif
+
 #ifdef CONFIG_MCA
 EXPORT_SYMBOL(machine_id);
 #endif
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c linux-2.6.0-test2-create-msi/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c	2003-08-05 09:25:54.000000000 -0400
+++ linux-2.6.0-test2-create-msi/arch/i386/kernel/io_apic.c	2003-08-05 09:45:25.000000000 -0400
@@ -427,6 +427,11 @@
 			/* Is this an active IRQ? */
 			if (!irq_desc[j].action)
 				continue;
+#ifdef CONFIG_PCI_MSI
+			/* Is this an active MSI? */
+			if (msi_desc[j])
+				continue;
+#endif
 			if ( package_index == i )
 				IRQ_DELTA(package_index,j) = 0;
 			/* Determine the total count per processor per IRQ */
@@ -1151,6 +1156,7 @@
 
 int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
 
+#ifndef CONFIG_PCI_MSI
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
@@ -1175,6 +1181,9 @@
 
 	return current_vector;
 }
+#else
+extern int assign_irq_vector(int irq);
+#endif
 
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
@@ -2267,6 +2276,16 @@
 	print_IO_APIC();
 }
 
+void restore_ioapic_irq_handler(int irq)
+{
+	spin_lock(&irq_desc[irq].lock);
+	if (IO_APIC_irq_trigger(irq))
+		irq_desc[irq].handler = &ioapic_level_irq_type;
+	else
+		irq_desc[irq].handler = &ioapic_edge_irq_type;
+	spin_unlock(&irq_desc[irq].lock);
+}
+
 /*
  *	Called after all the initialization is done. If we didnt find any
  *	APIC bugs then we can allow the modify fast path
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/Makefile linux-2.6.0-test2-create-msi/arch/i386/kernel/Makefile
--- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/Makefile	2003-07-27 12:57:50.000000000 -0400
+++ linux-2.6.0-test2-create-msi/arch/i386/kernel/Makefile	2003-08-05 09:45:25.000000000 -0400
@@ -24,6 +24,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_PCI_MSI)		+= pci_msi.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT)	+= summit.o
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c
--- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/pci_msi.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.0-test2-create-msi/arch/i386/kernel/pci_msi.c	2003-08-06 09:47:02.000000000 -0400
@@ -0,0 +1,896 @@
+/*
+ * linux/arch/i386/kernel/pci_msi.c
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
+struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
+
+int pci_msi_enable = 1;
+static int nr_alloc_vectors = 0;
+static int nr_released_vectors = 0;
+
+static int __init pci_msi_clear(char *str)
+{
+	pci_msi_enable = 0;
+	return 1;
+}
+__setup("pci_nomsi", pci_msi_clear);
+
+/**
+ * create_device_nomsi_list - create a list of devices with MSI disabled
+ * argument: none
+ *
+ * description: provide a temperary workaround for a PCI/PCI-X/PCI Express 
+ * hardware device, which may require IHV investigation if there is an issue. 
+ * It would be a good idea not to force MSI at device level, unless 
+ * system-wide boot parameter CONFIG_PCI_MSI is disabled. 
+ * A boot parameter device_nomsi=[HW] can be used for this purpose, where
+ * [HW] is a list of devices requesting for MSI disabled at device level
+ * (apply only for MSI-capable devices).
+ **/
+u32 device_nomsi_list[DRIVER_NOMSI_MAX] = {0, };
+static int __init create_device_nomsi_list(char *str)
+{
+	int i;
+	
+	if (!ENABLE_MSI_ON_ALL) {
+		printk(KERN_INFO "WARNING: boot param device_nomsi= invalid. Ignore!\n");
+		return 1;
+	}
+	
+	str = get_options(str,ARRAY_SIZE(device_nomsi_list), device_nomsi_list);
+	if (!device_nomsi_list[0])  /* first item contains number of entries */
+		return 0;
+
+	for (i = 0;i < device_nomsi_list[0]; i++) 
+		printk(KERN_INFO "User requests no MSI for dev (D%04x-V%04x)\n",
+		(device_nomsi_list[i + 1] >> 16), 
+		(device_nomsi_list[i + 1] & 0xffff));
+
+	return 1;
+}
+__setup("device_nomsi=", create_device_nomsi_list);
+
+u32 device_msi_list[DRIVER_NOMSI_MAX] = {0, };
+static int __init create_device_msi_list(char *str)
+{
+	int i;
+	
+	if (ENABLE_MSI_ON_ALL) {
+		printk(KERN_INFO "WARNING: boot param device_msi= invalid. Ignore!\n");
+		return 1;
+	}
+
+	str = get_options(str,ARRAY_SIZE(device_msi_list), device_msi_list);
+	if (!device_msi_list[0])  /* first item contains number of entries */
+		return 0;
+
+	for (i = 0;i < device_msi_list[0]; i++) 
+		printk(KERN_INFO "User requests MSI for dev (D%04x-V%04x)\n",
+		(device_msi_list[i + 1] >> 16), 
+		(device_msi_list[i + 1] & 0xffff));
+
+	return 1;
+}
+__setup("device_msi=", create_device_msi_list);
+
+static int is_msi_support_for_this_device(struct pci_dev *dev)
+{
+	int		i, enabling_msi = 1; 	
+	u32		did_vid, *list;
+
+	if (!ENABLE_MSI_ON_ALL) {
+		enabling_msi = 0;
+		if (!device_msi_list[0]) 
+			return (enabling_msi);
+		list = &device_msi_list[0];
+	} else {
+		if (!device_nomsi_list[0]) 
+			return (enabling_msi);
+		list = &device_nomsi_list[0];
+	} 
+	did_vid = (dev->device << 16) | dev->vendor;
+	for (i = 0; i < *list; i++) {
+		if (*(list + i + 1) == did_vid) {
+			enabling_msi = !(enabling_msi);	
+			break;
+		}
+	}
+
+	return (enabling_msi);
+}
+
+static void msi_set_mask_bit(unsigned int irq, int flag)
+{
+	struct msi_desc *entry;
+	
+	entry = (struct msi_desc *)msi_desc[irq];
+	if (!entry || !entry->dev || !entry->mask_entry_addr)
+		return;
+	switch (entry->msi_attrib.type) {
+	case PCI_CAP_ID_MSI:
+	{
+		int		pos;
+		unsigned int	mask_bits;
+		pos = *(int *)entry->mask_entry_addr;
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
+		int dw_off = entry->msi_attrib.entry_nr*PCI_MSIX_ENTRY_SIZE - 1;
+		*(u32*)(entry->mask_entry_addr + dw_off) = flag;
+		break;
+	}
+	default:
+		break;
+	} 
+}
+
+static void mask_MSI_irq(unsigned int irq)
+{
+	msi_set_mask_bit(irq, 1);
+}
+
+static void unmask_MSI_irq(unsigned int irq)
+{
+	msi_set_mask_bit(irq, 0);
+}
+
+static unsigned int startup_msi_irq_wo_maskbit(unsigned int irq) 
+{
+	return 0;	/* never anything pending */
+}
+static void shutdown_msi_irq_wo_maskbit(unsigned int irq) {}
+static void enable_msi_irq_wo_maskbit(unsigned int irq) {}
+static void disable_msi_irq_wo_maskbit(unsigned int irq) {}
+static void act_msi_irq_wo_maskbit(unsigned int irq) {}
+static void end_msi_irq_wo_maskbit(unsigned int irq) 
+{
+	ack_APIC_irq();	
+}
+
+static unsigned int startup_msi_irq_w_maskbit(unsigned int irq)
+{ 
+	unmask_MSI_irq(irq);
+	return 0;	/* never anything pending */
+}
+
+#define shutdown_msi_irq_w_maskbit	disable_msi_irq_w_maskbit
+#define enable_msi_irq_w_maskbit	unmask_MSI_irq
+#define disable_msi_irq_w_maskbit	mask_MSI_irq
+#define act_msi_irq_w_maskbit		mask_MSI_irq
+static void end_msi_irq_w_maskbit(unsigned int irq) 
+{
+	unmask_MSI_irq(irq);	
+	ack_APIC_irq();
+}
+
+static struct hw_interrupt_type msi_irq_w_maskbit_type = {
+	"PCI MSI",
+	startup_msi_irq_w_maskbit,
+	shutdown_msi_irq_w_maskbit,
+	enable_msi_irq_w_maskbit,
+	disable_msi_irq_w_maskbit,
+	act_msi_irq_w_maskbit,		
+	end_msi_irq_w_maskbit,	
+	NULL
+};
+
+static struct hw_interrupt_type msi_irq_wo_maskbit_type = {
+	"PCI MSI",
+	startup_msi_irq_wo_maskbit,
+	shutdown_msi_irq_wo_maskbit,
+	enable_msi_irq_wo_maskbit,
+	disable_msi_irq_wo_maskbit,
+	act_msi_irq_wo_maskbit,		
+	end_msi_irq_wo_maskbit,	
+	NULL
+};
+
+static void msi_data_init(struct msg_data *msi_data, 
+			  unsigned int vector)
+{
+	memset(msi_data, 0, sizeof(struct msg_data));
+	msi_data->vector = (u8)vector;
+	msi_data->delivery_mode = INT_DELIVERY_MODE;
+	msi_data->dest_mode = INT_DEST_MODE;
+	msi_data->trigger = 0;	
+	msi_data->delivery_status = 0;	
+}
+
+static void msi_address_init(struct msg_address *msi_address)
+{
+	memset(msi_address, 0, sizeof(struct msg_address));
+	msi_address->hi_address = (u32)0;
+	msi_address->lo_address.value = (u32)mp_lapic_addr;
+	msi_address->lo_address.u.dest_mode = INT_DEST_MODE;
+	msi_address->lo_address.u.redirection_hint = 0; 
+	msi_address->lo_address.u.ext_dest_id = 0;
+	msi_address->lo_address.u.dest_id = TARGET_CPUS;
+}
+
+static int pci_vector_resources(void) 					
+{	
+	static int res = -EINVAL;	
+	
+	if (res == -EINVAL) {
+		int i, repeat;
+		for (i = NR_REPEATS; i > 0; i--) {				
+			if ((FIRST_DEVICE_VECTOR + i*8) > FIRST_SYSTEM_VECTOR)
+				continue; 					
+			break; 							
+		} 								
+		i++; 								
+		repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i; 	
+		res = i*repeat - NR_RESERVED_VECTORS + 1; 
+	}
+
+	return (res + nr_released_vectors - nr_alloc_vectors);	
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
+		panic("ran out of interrupt sources!");
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
+		for (vector = 0; vector < NR_IRQS; vector++) { 
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
+#ifdef CONFIG_ACPI_BOOT
+static int find_prt_ioapic_vector(struct pci_dev *dev)
+{
+	struct list_head *node = NULL;
+	struct acpi_prt_entry *entry = NULL;
+	u32 pin;
+	int shares = 0, vector = 0;
+	
+	dev->bus->ops->read(dev->bus, dev->devfn, PCI_INTERRUPT_PIN, 1, &pin);
+	pin--;
+	vector = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin);
+	if (vector_irq[vector] == -1)
+		return -EBUSY;
+
+	list_for_each(node, &acpi_prt.entries) {
+		entry = list_entry(node, struct acpi_prt_entry, node);
+		if (entry->link.handle)
+			continue;
+		if (entry->id.segment == 0 && entry->irq == vector) 
+			shares++;
+	}
+	if (shares != 1) 
+		return -EBUSY;
+	
+	return vector; 
+}
+#define get_ioapic_vector	find_prt_ioapic_vector
+#else
+static int find_ioapic_vector(struct pci_dev *dev)
+{
+	int 		irq = -1;
+
+	if (io_apic_assign_pci_irqs && IO_APIC_DEFINED) 
+	{
+		u32 		pin = 0;
+		unsigned int 	apic, intin;
+		int 		i = 0, shares = 0;
+		
+		dev->bus->ops->read(dev->bus, dev->devfn, PCI_INTERRUPT_PIN, 1,
+			&pin);
+		if (pin) {
+			pin--; 	
+			irq = IO_APIC_get_PCI_irq_vector(
+				dev->bus->number, PCI_SLOT(dev->devfn), pin);
+			for (apic = 0; apic < nr_ioapics; apic++) {
+				i += nr_ioapic_registers[apic];
+				if (i > irq) break;
+			}
+			intin = irq - (i - nr_ioapic_registers[apic]);	
+		        for (i = 0; i < mp_irq_entries; i++) 
+				if ((mp_ioapics[apic].mpc_apicid == 
+				    mp_irqs[i].mpc_dstapic) && /*MATCH APIC & */
+				   (mp_irqs[i].mpc_dstirq == intin)) /* INTIN */
+					shares++; 
+		}
+		if (shares != 1) 
+			return -EBUSY;
+	}
+	
+	return IO_APIC_VECTOR(irq);
+}
+#define get_ioapic_vector	find_ioapic_vector
+#endif
+
+static int get_msi_vector(struct pci_dev *dev)
+{
+	int vector;
+
+	if ((vector = get_ioapic_vector(dev)) < 0) 
+		vector = get_new_vector();
+	
+	return vector;
+}
+
+static struct msi_desc* alloc_msi_entry(void)
+{
+	struct msi_desc *entry;
+
+	entry=(struct msi_desc*)kmalloc(sizeof(struct msi_desc),GFP_KERNEL);
+	if (!entry)
+		return NULL;
+	entry->mask_entry_addr = NULL;
+	entry->dev = NULL;
+	
+	return entry;
+}
+
+static void irq_handler_init(int pos, int mask)
+{
+	spin_lock(&irq_desc[pos].lock);
+	if (!mask)
+		irq_desc[pos].handler = &msi_irq_wo_maskbit_type;
+	else
+		irq_desc[pos].handler = &msi_irq_w_maskbit_type;
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
+    	if (pci_find_capability(dev, PCI_CAP_ID_PCI_EXPRESS)) {
+		/* PCI Express Endpoint device detected */
+		u32 cmd;
+	        dev->bus->ops->read(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
+		cmd |= PCI_COMMAND_INTX_DISABLE;
+	        dev->bus->ops->write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);
+	}
+}
+
+/**
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
+ * > 0		: vector for entry 0
+ **/
+static int msi_capability_init(struct pci_dev *dev) 
+{
+	struct msi_desc *entry;
+	struct msg_address address; 
+	struct msg_data data;
+	int pos, vector, *mask_reg = NULL;
+	u32 control;
+	
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (!pos)
+		return -EINVAL; 
+
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 
+		2, &control);
+	if (control & PCI_MSI_FLAGS_ENABLE)
+		return dev->irq;
+	
+	if (is_mask_bit_support(control)) {
+		mask_reg = (int*) kmalloc(sizeof(int), GFP_KERNEL);
+		if (!mask_reg)
+			return -ENOMEM;
+		*mask_reg = msi_mask_bits_reg(pos, is_64bit_address(control));
+	}
+	/* MSI Entry Initialization */
+	entry = alloc_msi_entry();
+	if (!entry) {
+		kfree(mask_reg);
+		return -ENOMEM;
+	}
+	if ((vector = get_msi_vector(dev)) < 0) {
+		kfree(entry);
+		kfree(mask_reg);
+		return vector;
+	}
+	entry->msi_attrib.type = PCI_CAP_ID_MSI;
+	entry->msi_attrib.entry_nr = 0;
+	entry->msi_attrib.maskbit = is_mask_bit_support(control);
+	entry->dev = dev;
+	entry->mask_entry_addr = mask_reg; 
+	irq_handler_init(vector, entry->msi_attrib.maskbit);
+	msi_desc[vector] = entry;
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
+	/* Set MSI enabled bits	 */
+	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+	
+	return vector;
+}
+
+/**
+ * msix_capability_init: configure device's MSI-X capability structure
+ * argument: dev of struct pci_dev type
+ * 
+ * description: called to configure the device's MSI-X capability structure 
+ * with a single MSI. To request for additional MSI vectors, the device drivers
+ * are required to utilize the following supported APIs:
+ * 1) msix_alloc_vectors(...) for requesting one or more MSI
+ * 2) msix_free_vectors(...) for releasing one or more MSI back to PCI subsystem
+ *
+ * return:
+ * -EINVAL	: Invalid device type
+ * -ENOMEM	: Memory Allocation Error
+ * -EBUSY	: No MSI resource 
+ * > 0		: vector for entry 0
+ **/
+static int msix_capability_init(struct pci_dev	*dev) 
+{
+	struct msi_desc *entry;
+	struct msg_address address; 
+	struct msg_data data;
+	int vector = 0, pos, dev_msi_cap;
+	u32 phys_addr, table_offset, *base;
+	u32 control;
+	u8 bir;
+	
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (!pos)
+		return -EINVAL;  
+
+	/* Request & Map MSI-X table region */
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 2, 
+		&control);
+	if (control & PCI_MSIX_FLAGS_ENABLE)
+		return dev->irq;
+
+	dev_msi_cap = multi_msix_capable(control);
+	dev->bus->ops->read(dev->bus, dev->devfn, 
+		msix_table_offset_reg(pos), 4, &table_offset);
+	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
+	phys_addr = pci_resource_start (dev, bir);
+	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
+	if (!request_mem_region(phys_addr, 
+		dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32),
+		"MSI-X iomap Failure"))
+		return -ENOMEM;
+	base = (u32*)ioremap_nocache(phys_addr,
+		dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
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
+	entry->dev = dev;
+	entry->mask_entry_addr = base; 
+	irq_handler_init(vector, 1);
+	msi_desc[vector] = entry;
+	/* Configure MSI-X capability structure */
+	msi_address_init(&address);
+	msi_data_init(&data, vector);
+	entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+	*base = address.lo_address.value;
+	*(base + 1) = address.hi_address;
+	*(base + 2) = *((u32*)&data);
+	/* Set MSI enabled bits	 */
+	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+	return vector;
+
+free_entry:
+	kfree(entry);
+free_iomap:
+	iounmap((void *)base);
+free_region: 
+	release_mem_region(phys_addr, 
+	dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
+
+	return ((vector < 0) ? -EBUSY : -ENOMEM);
+}
+
+/** 
+ * msi_get_pci_irq_vector: configure MSI/MSI-X capability structure
+ * argument: unsigned int irq 
+ * 
+ * description: called by PCI bus driver during PCI bus enumeration. The 
+ * decision of enabling MSI vector(s) to the function requires that all of 
+ * the following conditions must be satisfied:
+ * -	The system-wide-level boot parameter CONFIG_PCI_MSI is enabled 
+ *      This boot parameter enables MSI support to all MSI capable functions 
+ *      by default.
+ * -	The function indicates MSI support by implementing MSI/MSI-X capability
+ *	structure in its capability list.
+ * -	The function is not listed in the boot parameter "device_nomsi=". PCI 
+ *	subsystem uses this boot parameter to determine whether users want to 
+ *	have PCI subsystem forcing the function to override its default irq 
+ *	assertion mechanism with PCI MSI mechanism.
+ * -	The MSI resource pool is available.
+ *
+ * return:
+ * -EINVAL	: Invalid device type
+ * -ENOMEM	: Memory Allocation Error
+ * -EBUSY	: No MSI resource 
+ * > 0		: vector for entry 0
+ **/
+int msi_get_pci_irq_vector(struct pci_dev* dev)
+{
+	int vector = -EINVAL;
+
+	if (!pci_msi_enable)
+ 		return vector;	
+	if (!is_msi_support_for_this_device(dev))
+ 		return vector;	
+	if ((vector = msix_capability_init(dev)) == -EINVAL)
+		return (msi_capability_init(dev));
+	
+	return vector;
+}
+
+static int msix_alloc_vector(struct pci_dev* dev)
+{
+	struct msi_desc *entry;
+	struct msg_address address; 
+	struct msg_data data;
+	int i, pos, dev_msi_cap, vector;
+	u32 control;
+	u32 *base = NULL;
+	unsigned long flags;
+
+	vector = get_new_vector();
+	if (vector < 0)
+		return vector;
+
+	entry = msi_desc[dev->irq];
+	base = (u32*)entry->mask_entry_addr;
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),	
+		2, &control);
+	dev_msi_cap = multi_msix_capable(control);
+	for (i = 1; i < dev_msi_cap; i++)
+		if (*(base + i*PCI_MSIX_ENTRY_SIZE) == 0)
+			 break;
+	if (i >= dev_msi_cap) {
+		spin_lock_irqsave(&msi_lock, flags);
+		vector_irq[vector] = 0;
+		nr_released_vectors++;
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EINVAL;
+	}
+	/* MSI Entry Initialization */
+	entry = alloc_msi_entry();
+	if (!entry) {
+		spin_lock_irqsave(&msi_lock, flags);
+		vector_irq[vector] = 0;
+		nr_released_vectors++;
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -ENOMEM;
+	}	
+	entry->msi_attrib.type = PCI_CAP_ID_MSIX;
+	entry->msi_attrib.entry_nr = i;
+	entry->msi_attrib.maskbit = 1;
+	entry->dev = dev;
+	entry->mask_entry_addr = base; 
+	irq_handler_init(vector, 1);
+	msi_desc[vector] = entry;
+	/* Configure MSI-X capability structure */
+	msi_address_init(&address);
+	msi_data_init(&data, vector);
+	entry->msi_attrib.current_cpu = address.lo_address.u.dest_id;
+	base += i*PCI_MSIX_ENTRY_SIZE;
+	*base = address.lo_address.value;
+	*(base + 1) = address.hi_address;
+	*(base + 2) = *((u32*)&data);
+	*(base + 3) = 1; /* ensure to mask it */
+	
+	return vector;
+}
+
+int msix_alloc_vectors(struct pci_dev* dev, int *vector, int nvec)
+{
+	struct msi_desc *entry;
+	int i, pos, vec, alloc_vectors = 0, *vectors = (int *)vector;
+	u32 control;
+	unsigned long flags;
+
+	if (!pci_msi_enable)
+ 		return -EINVAL;
+	
+	entry = msi_desc[dev->irq];
+	if (!entry || entry->dev != dev ||
+	   entry->msi_attrib.type != PCI_CAP_ID_MSIX)
+		return -EINVAL;
+
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 			2, &control);
+	if (nvec > multi_msix_capable(control))
+		return -EINVAL;
+	/*
+	 * msi_lock is provided to ensure that enough vectors resources are
+	 * available before granting.
+	 */ 
+	spin_lock_irqsave(&msi_lock, flags);
+	if (nvec > pci_vector_resources()) {
+		spin_unlock_irqrestore(&msi_lock, flags);
+		return -EBUSY;
+	}
+	spin_unlock_irqrestore(&msi_lock, flags);
+	for (i = 0; i < nvec; i++) {
+		if ((vec = msix_alloc_vector(dev)) < 0)
+			break;
+		*(vectors + i) = vec;
+		alloc_vectors++;
+	}
+	if (alloc_vectors != nvec) {
+		for (i = 0; i < alloc_vectors; i++) {
+			vec = *(vectors + i);
+			spin_lock_irqsave(&msi_lock, flags);
+			vector_irq[vec] = 0;
+			nr_released_vectors++;
+			spin_unlock_irqrestore(&msi_lock, flags);
+			if (msi_desc[vec] != NULL) {
+				msi_desc[vec]->dev = NULL; 
+				msi_desc[vec]->mask_entry_addr = NULL; 
+				kfree(msi_desc[vec]);
+			}
+		}
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int msi_free_vector(struct pci_dev* dev, int vector)
+{
+	struct msi_desc *entry;
+	int offset;
+	u32 *tbl_addr;
+	unsigned long flags;
+
+	entry = msi_desc[vector];
+	if (!entry || entry->dev != dev || 
+	   entry->msi_attrib.type != PCI_CAP_ID_MSIX)
+		return -EINVAL;
+
+	tbl_addr = (u32*)entry->mask_entry_addr;
+	offset = entry->msi_attrib.entry_nr*PCI_MSIX_ENTRY_SIZE - 1;
+	*(tbl_addr + offset) = 1;	/* mask this entry */
+	entry->mask_entry_addr = NULL;
+	entry->dev = NULL;
+	kfree(entry);
+	msi_desc[vector] = NULL;
+	spin_lock_irqsave(&msi_lock, flags);
+	vector_irq[vector] = 0;	
+	nr_released_vectors++;
+	spin_unlock_irqrestore(&msi_lock, flags);
+	
+	return 0;
+}
+
+int msix_free_vectors(struct pci_dev* dev, int *vector, int nvec)
+{
+	struct msi_desc *entry;
+	int i;
+
+	if (!pci_msi_enable)
+ 		return -EINVAL;
+	
+	entry = msi_desc[dev->irq];
+	if (!entry || entry->dev != dev || 
+	   entry->msi_attrib.type != PCI_CAP_ID_MSIX)
+		return -EINVAL;
+
+	for (i = 0; i < nvec; i++) {
+		msi_free_vector(dev, *(vector + i)); 
+	}
+
+	return 0;
+}
+
+/**
+ * msi_hp_free_vectors: reclaim all MSI previous assigned to this device
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
+	void *mask_entry_addr;
+	unsigned long flags;
+
+	if (!pci_msi_enable)
+ 		return;
+	
+	entry = msi_desc[dev->irq];
+	if (!entry || entry->dev != dev)
+		return;
+		
+	if (get_ioapic_vector(dev) > 0)
+		restore_ioapic_irq_handler(dev->irq);
+	type = entry->msi_attrib.type;
+	mask_entry_addr = entry->mask_entry_addr;
+	entry->mask_entry_addr = NULL;
+	entry->dev = NULL;
+	kfree(entry);
+	msi_desc[dev->irq] = NULL;
+	spin_lock_irqsave(&msi_lock, flags);
+	vector_irq[dev->irq] = 0;	
+	nr_released_vectors++;
+	spin_unlock_irqrestore(&msi_lock, flags);
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
+		for (i = 0; i < NR_IRQS; i++) 
+			if (msi_desc[i]->dev == dev)
+				msi_free_vector(dev, i);
+		*(u32*)(mask_entry_addr + 3) = 1;
+		iounmap(mask_entry_addr);
+		release_mem_region(phys_addr, 
+		dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
+	} else
+		kfree(mask_entry_addr);
+}
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/pci/irq.c linux-2.6.0-test2-create-msi/arch/i386/pci/irq.c
--- linux-2.6.0-test2-create-vectorbase/arch/i386/pci/irq.c	2003-08-05 09:25:54.000000000 -0400
+++ linux-2.6.0-test2-create-msi/arch/i386/pci/irq.c	2003-08-05 09:45:25.000000000 -0400
@@ -714,6 +714,18 @@
 
 	dev = NULL;
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		int irq;
+
+#ifdef CONFIG_PCI_MSI
+  		if ((irq = msi_get_pci_irq_vector(dev)) > 0) {
+  		    	dev->irq = irq;
+  		    	printk(KERN_INFO "PCI->MSI vector:(B%d,S%d,F%d)->%d\n", 
+  				dev->bus->number, PCI_SLOT(dev->devfn), 
+  				PCI_FUNC(dev->devfn), irq);
+			continue;
+  		} 
+#endif	
+
 		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 #ifdef CONFIG_X86_IO_APIC
 		/*
@@ -721,8 +733,6 @@
 		 */
 		if (io_apic_assign_pci_irqs)
 		{
-			int irq;
-
 			if (pin) {
 				pin--;		/* interrupt pins are numbered starting from 1 */
 				irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
@@ -812,6 +822,18 @@
 {
 	u8 pin;
 	extern int interrupt_line_quirk;
+	
+#ifdef CONFIG_PCI_MSI
+	int irq;
+	if ((irq = msi_get_pci_irq_vector(dev)) > 0) {
+	    	dev->irq = irq;
+	    	printk(KERN_INFO "PCI->MSI vector:(B%d,S%d,F%d)->%d\n", 
+			dev->bus->number, PCI_SLOT(dev->devfn), 
+			PCI_FUNC(dev->devfn), irq);
+		return 0;
+	} 
+#endif
+	
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
 		char *msg;
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/Documentation/kernel-parameters.txt linux-2.6.0-test2-create-msi/Documentation/kernel-parameters.txt
--- linux-2.6.0-test2-create-vectorbase/Documentation/kernel-parameters.txt	2003-07-27 13:12:45.000000000 -0400
+++ linux-2.6.0-test2-create-msi/Documentation/kernel-parameters.txt	2003-08-05 09:45:25.000000000 -0400
@@ -261,6 +261,22 @@
 			Format: <area>[,<node>]
 			See also Documentation/networking/decnet.txt.
 
+	device_nomsi=	[HW,HW,...]
+			Format: HW = DeviceIDVendorID in hex format with prefix
+			0x to select a list of specific MSI-capable functions
+			requesting no MSI support at function-wide. This
+			option is ignored if either a configured parameter
+			CONFIG_PCI_MSI is set to 'N' or a configured parameter 
+			CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES is set to 'Y'.
+
+	device_msi=	[HW,HW,...]
+			Format: HW = DeviceIDVendorID in hex format with prefix
+			0x to select a list of specific MSI-capable functions
+			requesting MSI support at function-wide. This
+			option is ignored if either a configured parameter 
+			CONFIG_PCI_MSI is set to 'N' or a configured parameter
+			CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES is set to 'N'.
+
 	devfs=		[DEVFS]
 			See Documentation/filesystems/devfs/boot-options.
  
@@ -694,6 +710,11 @@
 			See header of drivers/block/paride/pcd.c.
 			See also Documentation/paride.txt.
 
+	pci_nomsi	If user sets a configured parameter CONFIG_PCI_MSI
+			during kernel built, then he/she can use this append 
+			option to disable MSI system-wide support from PCI 
+			subsystem during boot.
+
 	pci=option[,option...]		[PCI] various PCI subsystem options:
 		off			[IA-32] don't probe for the PCI bus
 		bios			[IA-32] force use of PCI BIOS, don't access
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/Documentation/MSI-HOWTO.txt linux-2.6.0-test2-create-msi/Documentation/MSI-HOWTO.txt
--- linux-2.6.0-test2-create-vectorbase/Documentation/MSI-HOWTO.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.0-test2-create-msi/Documentation/MSI-HOWTO.txt	2003-08-05 14:43:33.000000000 -0400
@@ -0,0 +1,330 @@
+		The MSI Driver Guide HOWTO
+	Tom L Nguyen tom.l.nguyen@intel.com
+			07/15/2003
+
+1. About this guide
+
+This guide describes the basics of Message Signaled Interrupts(MSI), the 
+advantages of using MSI over traditional interrupt mechanisms, and how 
+to enable your driver to use MSI or MSI-X. Also included is a 
+description of debugging features available and Frequently Asked 
+Questions.
+
+2. Copyright 2003 Intel Corporation 
+
+3. What is MSI/MSI-X?
+
+Message Signaled Interrupt (MSI), as described in the PCI Local Bus 
+Specification Revision 2.3 or latest, is an optional feature, and a required 
+feature for PCI Express devices. MSI enables a device function to request 
+service by sending an Inbound Memory Write on its PCI bus to the FSB as a 
+Message Signal Interrupt transaction. Because MSI is generated in the
+form of a Memory Write, all transaction conditions, such as a Retry, 
+Master-Abort, Target-Abort or normal completion, are supported.
+
+A PCI device that supports MSI must also support pin IRQ assertion interrupt 
+mechanism to provide backward compatibility for systems that do not
+support MSI. In Systems, which support MSI, the bus driver is
+responsible for initializing the message address and message data of
+the device function's MSI/MSI-X capability structure during device
+initial configuration. 
+
+An MSI capable device function indicates MSI support by implementing 
+the MSI/MSI-X capability structure in its PCI capability list. The 
+device function may implement both the MSI capability structure and the 
+MSI-X capability structure; however, the bus driver should not enable 
+both, but instead enable only the MSI-X capability structure.
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
+The MSI-X capability structure is an optional extension to MSI. It uses 
+an independent and separate capability structure. There are some key 
+advantages to implementing the MSI-X capability structure over the MSI 
+capability structure as described below.
+
+	- Support a larger maximum number of vectors per function.
+
+	- Provide the ability for system software to configure each
+	  vector with an independent message address and message data,
+	  specified by a table that resides in Memory Space. 
+
+        - MSI and MSI-X both support per-vector masking. Per-vector
+	  masking is an optional extension of MSI but a required
+	  feature for MSI-X. Per-vector masking provides the kernel
+	  the ability to mask/unmask MSI when servicing its software
+	  interrupt service routing handler. If per-vector masking is
+	  not supported, then the device driver should provide the 
+	  hardware/software synchronization to ensure that the device generates
+	  MSI when the driver wants it to do so. 
+
+4. Why use MSI? 
+
+As a benefit the simplification of board design, MSI allows board designers to 
+remove out of band interrupt routing. MSI is another step towards a legacy-free
+environment.
+
+Due to increasing pressure on chipset and processor packages to reduce pin 
+count, the need for interrupt pins is expected to diminish over time. Devices, 
+due to pin constraints, may implement messages to increase performance. 
+
+PCI Express endpoints uses INTx emulation (in-band messages) instead of IRQ pin
+assertion. Using INTx emulation requires interrupt sharing among devices 
+connected to the same node (PCI bridge) while MSI is unique (non-shared) and 
+does not require BIOS configuration support. As a result, the PCI Express 
+technology requires MSI support for better interrupt performance.
+ 
+Using MSI enables the device functions to support two or more vectors,
+which can be configure to target different CPU's to increase scalability. 
+
+5. Configuring a driver to use MSI/MSI-X
+
+By default, the kernel will not enable MSI/MSI-X on all 
+devices that support this capability because some devices. A kernel 
+configuration option must be selected to enable MSI/MSI-X support.
+
+5.1 Including MSI support into the kernel
+
+To include MSI support into the kernel requires users to rebuild 
+the kernel with both the configuration parameters CONFIG_PCI_USE_VECTOR and 
+CONFIG_PCI_MSI set. CONFIG_PCI_USE_VECTOR enables the kernel to
+replace the IRQ-based scheme with VECTOR-based scheme because MSI
+requires a unique vector and no BIOS interrupt-routing
+table. CONFIG_PCI_MSI enables MSI support in the kernel. 
+
+During PCI device enumeration, the bus driver initializes the devices
+MSI/MSI-X capability structure with ONE vector, regardless of whether
+the device function is capable of supporting multiple vectors. 
+
+ONE vector is initially allocated to the device function and the vector is 
+stored in the irq field of the device (pci_dev) structure. This default 
+initialization allows legacy drivers to work without specific modification to 
+support MSI.
+	
+5.2 Configuring for MSI support
+
+Due to the non-contiguous fashion in vector assignment of the 
+existing Linux kernel, this patch does not support multiple 
+messages regardless of the device function is capable of 
+supporting more than one vector. The bus driver initializes only 
+entry 0 of this capability. Existing software drivers of this 
+device function will work without changes if no 
+hardware/software synchronization is required. Otherwise, the 
+device driver should be updated to provide the hardware/software 
+synchronization due to multiple messages generated from the same 
+vector might be lost. In other words, once the device function 
+signals Vector A, it cannot signal Vector A again until it is 
+explicitly enabled to do so by its device driver. It is 
+recommended that IHVs should validate their hardware devices 
+against their existing device drivers once the patch is 
+installed. Please refer section 5.4 Debugging MSI.
+
+5.3 Configuring for MSI-X support
+
+Both the MSI capability structure and the MSI-X capability 
+structure share the same above semantics; however, due to the 
+ability of the system software to configure each vector of the 
+MSI-X capability structure with an independent message address 
+and message data, the non-contiguous fashion in vector assignment 
+of the existing Linux kernel has no impact on supporting multiple 
+messages on an MSI-X capable device functions. By default, as 
+mentioned above, ONE vector should be always allocated to the 
+MSI-X capability structure at entry 0. The bus driver does not 
+initialize other entries of the table during device enumeration. 
+Note that the PCI subsystem should have full control of a MSI-X table that 
+resides in Memory Space. The software device driver should not access this 
+table. 
+
+To request for additional vectors, the device software driver 
+should call function msix_alloc_vectors(). It is recommended that 
+the software driver should call this function once during the 
+initialization phase of the device driver. With this semantics, 
+the existing software device driver may work with one vector if 
+no hardware/software synchronization is required. It is 
+recommended that IHVs should validate their hardware devices 
+against their existing device drivers once the patch is 
+installed. Please refer section 5.4 Debugging MSI.
+
+The function msix_alloc_vectors(), once invoked, enables either 
+all or nothing, depending on the current availability of vector 
+resources. If no vector resources are available, the device 
+function still works with ONE vector. If the vector resources are 
+available for the number of vectors requested by the driver, this 
+function will reconfigure the MSI-X capability structure of the 
+device with additional messages, starting from entry 1. To 
+emphasize this reason, for example, the device may be capable for 
+supporting the maximum of 32 vectors while its software driver 
+usually may request 4 vectors.
+
+For each vector, after this successful call, the device driver is 
+responsible to call other functions like request_irq(), 
+enable_irq(), etc. to enable this vector with its corresponding 
+interrupt service handler. It is the device driver's choice to 
+have all vectors shared the same interrupt service handler or 
+each vector with a unique interrupt service handler. 
+
+In addition to the function msix_alloc_vectors(), another 
+function msix_free_vectors() is provided to allow the software 
+driver to release a number of vectors back to the vector 
+resources. Once invoked, the PCI subsystem disables (masks) each 
+vector released. These vectors are no longer valid for the 
+hardware device and its software driver to use.
+
+int msix_alloc_vectors(struct pci_dev *dev, int *vector, int nvec)
+
+This API enables the software driver to request the PCI
+subsystem for additional messages. Depending on the number of 
+vectors available, the PCI subsystem enables either all or 
+nothing. 
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
+int msix_free_vectors(struct pci_dev* dev, int *vector, int nvec)
+
+This API enables the software driver to inform the PCI subsystem 
+that it is willing to release a number of vectors back to the MSI 
+resource pool.  Once invoked, the PCI subsystem disables each 
+MSI-X entry associated with each vector stored in the argument 2. 
+These vectors are no longer valid for the hardware device and its 
+software driver to use.
+
+Argument dev points to the device (pci_dev) structure.
+Argument vector is a pointer of integer type. The number of 
+elements is indicated in argument nvec.
+Argument nvec is an integer indicating the number of messages 
+released. 
+A return of zero indicates that the number of allocated vectors 
+is successfully released. Otherwise, indicates a failure.
+
+5.4 Debugging MSI
+
+There are some devices that may have some bugs in MSI. These devices may break 
+once MSI support is invoked in the kernel. To debug these devices, the patch 
+provides two configuration parameters, CONFIG_PCI_MSI and 
+CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES. Both of them are not set by default. When 
+users set CONFIG_PCI_MSI, CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES is also set by 
+default. After users rebuild the kernel with this combination, the
+kernel enables MSI on specific devices listed in the boot parameter 
+"device_msi=". Users must explicitly use this boot parameter to
+provide a list of specific devices they would like to have MSI
+support. To emphasize this reason, users can debug on individual MSI
+capable device with its existing software driver until all are fully
+validated since it may be difficult to debug all the same time. The format 
+of "device_msi=" is similar to the format of "device_nomsi=" and will be 
+described in later paragraph. Note that this boot parameter is
+required only if the configuration parameter CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES
+is set. Otherwise, it will be ignored.  
+
+Once users completed validating these devices, they can clear the
+configuration parameter CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES to indicate
+the kernel that MSI should be enabled on all MSI capable devices. The
+boot parameter "device_msi=" is no longer required.
+
+The patch also provides second debug option, which requires users set the 
+configuration parameter CONFIG_PCI_MSI and clear configuration parameter 
+CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES. After users rebuild the kernel with this 
+combination, the kernel enables MSI on all MSI capable devices by default. The 
+boot parameter "device_msi=" will be ignored. To disable MSI on
+specific MSI capable devices, which may show some signs of
+unpredictable behaviors, users must explicitly use the boot parameter 
+"device_nomsi=", which contains a list of specific devices users do
+not want MSI enabled. These devices are default to IRQ pin assertion.
+
+The format of this is "device_nomsi=DWORD1,DWORD2,...". Each 
+DWORD in a list specifies a device function in terms of device ID 
+(higher word) and vendor ID (lower word). DWORD should be in hex 
+format with a prefix 0x.
+
+For example, "device_nomsi=0x80119005,0x10108086" indicates that 
+the bus driver should not enable MSI(X) on two device functions 
+(Device ID = 0x8011 & Vendor ID = 0x9005, and Device ID = 0x1010 
+and Vendor ID = 0x8086). 
+	
+In addition to the boot parameter "device_nomsi=", another boot 
+parameter "pci_nomsi" can be used to prohibit the bus driver from 
+enabling MSI(X) on all MSI capable devices.
+
+At the driver level, the software device driver can tell whether 
+MSI/MSI-X is enabled by reading the MSI enable bit of the 
+MSI/MSI-X capability structure's message control register. If 
+this bit is zero, the device function is default to IRQ pin 
+assertion. If this bit is set, the device function is using MSI 
+as interrupt generated mechanism.
+
+At the user level, users can use command 'cat /proc/interrupts' 
+to display the vector allocated for the device and its interrupt 
+mode, as shown below. 
+
+     CPU0     CPU1    CPU2    CPU3       
+0:   14175    0       17408   0    	IO-APIC-edge  	timer
+1:   123      310     0       37    	IO-APIC-edge  	keyboard
+2:   0        0       0       0     	XT-PIC  	cascade
+8:   1        0       0       0    	IO-APIC-edge  	rtc
+12:  41       0       0       813   	IO-APIC-edge  	PS/2 Mouse
+14:  2744     7017    0       0     	IO-APIC-edge  	ide0
+15:  1515     1       0       418   	IO-APIC-edge  	ide1
+169: 0        0       0       0   	IO-APIC-level  	usb-uhci
+185: 0        0       0       0   	IO-APIC-level  	usb-uhci
+193: 30       0       0       0     	PCI MSI		aic79xx
+201: 30       0       0       0     	PCI MSI		aic79xx
+209: 467      0       0       0   	IO-APIC-level  	eth1
+225: 15       0       0       0   	IO-APIC-level  	aic7xxx
+233: 15       0       0       0   	IO-APIC-level  	aic7xxx
+NMI: 0        0       0       0 
+LOC: 31446    31448   31448   31448 
+ERR: 0
+MIS: 0
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
+target address set as 0xfeexxxxx, as conformed to PCI specification 2.3 or 
+latest, then it should work.
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
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/drivers/acpi/pci_irq.c linux-2.6.0-test2-create-msi/drivers/acpi/pci_irq.c
--- linux-2.6.0-test2-create-vectorbase/drivers/acpi/pci_irq.c	2003-07-27 13:01:22.000000000 -0400
+++ linux-2.6.0-test2-create-msi/drivers/acpi/pci_irq.c	2003-08-05 09:45:25.000000000 -0400
@@ -49,6 +49,9 @@
 extern void eisa_set_level_irq(unsigned int irq);
 #endif
 
+#ifdef CONFIG_PCI_MSI
+extern int msi_get_pci_irq_vector(struct pci_dev *dev);
+#endif
 
 /* --------------------------------------------------------------------------
                          PCI IRQ Routing Table (PRT) Support
@@ -229,7 +232,7 @@
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
 
-static int
+int 
 acpi_pci_irq_lookup (struct pci_bus *bus, int device, int pin)
 {
 	struct acpi_prt_entry	*entry = NULL;
@@ -326,6 +329,15 @@
 		return_VALUE(-ENODEV);
 	}
 
+#ifdef CONFIG_PCI_MSI	
+	if ((irq = msi_get_pci_irq_vector(dev)) > 0) {
+	    	dev->irq = irq;
+	    	printk(KERN_INFO "PCI->MSI VEC transform:(B%d,I%d,P%d)->%d\n", 
+			dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+		return_VALUE(dev->irq);
+	}
+#endif
+	
 	/* 
 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.  PRT
 	 * values override any BIOS-assigned IRQs set during boot.
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/drivers/pci/remove.c linux-2.6.0-test2-create-msi/drivers/pci/remove.c
--- linux-2.6.0-test2-create-vectorbase/drivers/pci/remove.c	2003-07-27 12:58:26.000000000 -0400
+++ linux-2.6.0-test2-create-msi/drivers/pci/remove.c	2003-08-05 10:21:57.000000000 -0400
@@ -14,6 +14,10 @@
 {
 	int i;
 
+#ifdef CONFIG_PCI_MSI
+ 	msi_remove_pci_irq_vectors(dev);
+#endif
+ 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *res = dev->resource + i;
 		if (res->parent)
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/include/asm-i386/hw_irq.h linux-2.6.0-test2-create-msi/include/asm-i386/hw_irq.h
--- linux-2.6.0-test2-create-vectorbase/include/asm-i386/hw_irq.h	2003-08-05 09:25:54.000000000 -0400
+++ linux-2.6.0-test2-create-msi/include/asm-i386/hw_irq.h	2003-08-06 09:43:39.000000000 -0400
@@ -60,6 +60,15 @@
 extern void send_IPI(int dest, int vector);
 extern void setup_ioapic_dest(unsigned long mask);
 
+#ifdef CONFIG_PCI_MSI
+#include <linux/pci_msi.h>
+extern struct msi_desc* msi_desc[NR_IRQS];
+extern int msi_get_pci_irq_vector(struct pci_dev *dev);
+extern int msix_alloc_vectors(struct pci_dev *dev, int *vector, int nvec);
+extern int msix_free_vectors(struct pci_dev *dev, int *vector, int nvec);
+extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+#endif
+
 extern unsigned long io_apic_irqs;
 
 extern atomic_t irq_err_count;
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/include/linux/pci.h linux-2.6.0-test2-create-msi/include/linux/pci.h
--- linux-2.6.0-test2-create-vectorbase/include/linux/pci.h	2003-07-27 13:01:50.000000000 -0400
+++ linux-2.6.0-test2-create-msi/include/linux/pci.h	2003-08-05 09:45:25.000000000 -0400
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
+#define  PCI_CAP_ID_PCI_EXPRESS 0x10
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
 
diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/include/linux/pci_msi.h linux-2.6.0-test2-create-msi/include/linux/pci_msi.h
--- linux-2.6.0-test2-create-vectorbase/include/linux/pci_msi.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.0-test2-create-msi/include/linux/pci_msi.h	2003-08-06 09:44:10.000000000 -0400
@@ -0,0 +1,142 @@
+/*
+ *	linux/include/asm/pci_msi.h
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
+extern int vector_irq[NR_IRQS];
+extern void (*interrupt[NR_IRQS])(void);
+extern void restore_ioapic_irq_handler(int irq);
+extern int acpi_pci_irq_lookup (struct pci_bus *bus, int device, int pin);
+
+#ifndef CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES
+#define ENABLE_MSI_ON_ALL		1
+#else
+#define ENABLE_MSI_ON_ALL		0
+#endif
+
+#ifdef CONFIG_X86_IO_APIC
+#define IO_APIC_DEFINED			1
+#else
+#define IO_APIC_DEFINED			0
+#endif
+
+#define DRIVER_NOMSI_MAX		32
+/*
+ * MSI-X Address Register
+ */
+#define PCI_MSIX_FLAGS_QSIZE		0x7FF
+#define PCI_MSIX_FLAGS_ENABLE		(1 << 15)
+#define PCI_MSIX_FLAGS_BIRMASK		(7 << 0)
+#define PCI_MSIX_FLAGS_BITMASK		(1 << 0)
+
+#define PCI_MSIX_ENTRY_SIZE		4	/* number of dwords */
+
+#define msi_control_reg(base)		(base + PCI_MSI_FLAGS)
+#define msi_lower_address_reg(base)	(base + PCI_MSI_ADDRESS_LO)
+#define msi_upper_address_reg(base)	(base + PCI_MSI_ADDRESS_HI)
+#define msi_data_reg(base, is64bit)	\
+	( (is64bit == 1) ? base+PCI_MSI_DATA_64 : base+PCI_MSI_DATA_32 )
+#define msi_mask_bits_reg(base, is64bit) \
+	( (is64bit == 1) ? base+PCI_MSI_MASK_BIT : base+PCI_MSI_MASK_BIT-4)
+#define msi_disable(control)		(control & ~PCI_MSI_FLAGS_ENABLE)
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
+#define msix_disable(control)	 	(control & ~PCI_MSIX_FLAGS_ENABLE)
+#define msix_table_size(control) 	((control & PCI_MSIX_FLAGS_QSIZE)+1)
+#define multi_msix_capable		msix_table_size
+#define msix_unmask(address)	 	(address & ~PCI_MSIX_FLAGS_BITMASK)
+#define msix_mask(address)		(address | PCI_MSIX_FLAGS_BITMASK)  
+#define msix_is_pending(address) 	(address & PCI_MSIX_FLAGS_PENDMASK)
+
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
+
+/*
+ * MSI Defined Data Structures
+ */
+
+extern unsigned long mp_lapic_addr;
+extern char __dbg_str_buf[256];
+
+struct msg_data {	
+	__u32	vector	:  8,		
+	delivery_mode	:  3,	/*	000b: FIXED
+			 		001b: lowest priority
+			 	 	111b: ExtINT */	
+	dest_mode	:  1,	/* 0: physical, 1: logical */	
+	reserved_1	:  2,
+	trigger		:  1,	/* 0: edge, 1: level */	
+	delivery_status	:  1,	/* 0: idle, 1: pending */	
+	reserved_2	: 16;
+} __attribute__ ((packed));
+
+struct msg_address {
+	union {
+		struct { __u32
+			reserved_1		:  2,		
+			dest_mode		:  1,	/* 0: physical, 
+							   1: logical */	
+			redirection_hint        :  1,  	/* 0: to FSB, 
+							   1: redirection */ 
+			ext_dest_id		:  8,   /* Extended Dest. ID */	
+ 			dest_id			:  8,	/* Destination ID */	
+			reserved_2		: 12;	/* 0xFEE */
+      	}u;
+       	__u32  value;
+	}lo_address;
+	__u32 	hi_address;
+} __attribute__ ((packed));
+
+struct msi_desc {
+	struct {
+		__u32	type	: 5, /* {0: unused, 5h:MSI, 11h:MSI-X} 	*/
+			maskbit	: 1, /* mask-pending bit supported ?    */
+			reserved: 2, /* reserved			*/
+			entry_nr: 8, /* specific enabled entry 		*/
+			current_cpu: 16;/* current destination cpu	*/
+	}msi_attrib;
+	void *mask_entry_addr;
+	struct pci_dev *dev;
+};
+
+#endif /* _ASM_PCI_MSI_H */
