Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbTIEX7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTIEX7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:59:37 -0400
Received: from lidskialf.net ([62.3.233.115]:1229 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S265029AbTIEX67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:58:59 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] 2.6.0-test4 ACPI fixes series (1/4)
Date: Sat, 6 Sep 2003 01:57:25 +0100
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
In-Reply-To: <3F590E28.6090101@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309060157.25423.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows ACPI to drop back to PIC mode if ACPI mode setup fails.


--- linux-2.6.0-test4.orig/arch/i386/kernel/mpparse.c	2003-08-23 00:53:52.000000000 +0100
+++ linux-2.6.0-test4.picmode/arch/i386/kernel/mpparse.c	2003-09-06 00:23:10.609735224 +0100
@@ -1073,10 +1073,11 @@
 
 #ifdef CONFIG_ACPI_PCI
 
-void __init mp_parse_prt (void)
+int __init mp_parse_prt (void)
 {
 	struct list_head	*node = NULL;
 	struct acpi_prt_entry	*entry = NULL;
+ 	struct acpi_prt_list	*prt_list = NULL;
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
 	int			irq = 0;
@@ -1084,16 +1085,31 @@
 	int			edge_level = 0;
 	int			active_high_low = 0;
 
+ 	/* Get the current PRT */
+ 	prt_list = acpi_pci_get_prt_list();
+   
+ 	if (!prt_list->count) {
+ 		acpi_pci_destroy_prt_list(prt_list);
+ 		printk(KERN_WARNING PREFIX "ACPI tables contain no IO-APIC PCI IRQ "
+ 			"routing entries\n");
+ 		return_VALUE(-ENODEV);
+ 	}
+   
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
 	 * routing for all entries.
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &prt_list->entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
 			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+		   
 			if (!irq)
 				continue;
 		}
@@ -1115,6 +1131,7 @@
 
 		if (!ioapic && (irq < 16))
 			irq += 16;
+
 		/* 
 		 * Avoid pin reprogramming.  PRTs typically include entries  
 		 * with redundant pin->irq mappings (but unique PCI devices);
@@ -1146,6 +1163,11 @@
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, 
 			entry->irq);
 	}
+   
+ 	/* if we get here, the PRT was fine. commit it */
+ 	acpi_pci_commit_prt_list(prt_list);
+   
+	return 0;
 }
 
 #endif /*CONFIG_ACPI_PCI*/
--- linux-2.6.0-test4.orig/arch/i386/kernel/acpi/pic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test4.picmode/arch/i386/kernel/acpi/pic.c	2003-09-06 00:20:15.818307560 +0100
@@ -0,0 +1,102 @@
+/* ----------------------------------------------------------------------- *
+ *   
+ *   Copyright 2003 Andrew de Quincey - All Rights Reserved
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version; incorporated herein by reference.
+ *
+ * ----------------------------------------------------------------------- */
+
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/config.h>
+#include <linux/bootmem.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/acpi.h>
+
+#ifdef CONFIG_ACPI_PCI
+
+extern void eisa_set_level_irq(unsigned int irq);
+
+int __init pic_parse_prt (void)
+{
+	struct list_head	*node = NULL;
+	struct acpi_prt_entry	*entry = NULL;
+	struct acpi_prt_list	*prt_list = NULL;
+	int			edge_level = 0;
+	int			active_high_low = 0;
+	int			irq = 0;
+	int			programmed[16];
+
+	/* Get the current PRT */
+	prt_list = acpi_pci_get_prt_list();
+   
+	if (!prt_list->count) {
+		acpi_pci_destroy_prt_list(prt_list);
+		printk(KERN_WARNING PREFIX "ACPI tables contain no PIC PCI IRQ "
+			"routing entries\n");
+		return_VALUE(-ENODEV);
+	}
+
+	/* mark all IRQs as unprogrammed */
+	memset(programmed, 0, sizeof(programmed));
+   
+	/*
+	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
+	 * IRQs if necessary.
+	 */
+	list_for_each(node, &prt_list->entries) {
+		entry = list_entry(node, struct acpi_prt_entry, node);
+
+		/* Need to get irq for dynamic entry */
+		if (entry->link.handle) {
+			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+ 			if (!irq) 
+				continue;
+		}
+	   
+		/* sanity check + update entry */
+		if ((irq < 0) || (irq > 15)) {
+			printk(KERN_ERR "Invalid IRQ (%i) passed to PIC programming code\n", irq);
+			entry->irq = 0;
+			continue;
+		}
+		entry->irq = irq;
+
+		/* check if it has already been dealt with */
+		if (programmed[irq]) {
+			printk(KERN_DEBUG "PIC: IRQ (%i) already programmed\n", irq);
+			continue;
+		}
+		programmed[irq] = 1;
+
+		/* program it */
+		if (edge_level) {
+			eisa_set_level_irq(irq);
+		}
+	   
+		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> IRQ %d Mode %d Trigger %d\n",
+			entry->id.segment, entry->id.bus, 
+			entry->id.device, ('A' + entry->pin), 
+			entry->irq, edge_level, active_high_low);
+	}
+	
+	/* if we get here, the PRT was fine. commit it */
+	acpi_pci_commit_prt_list(prt_list);
+   
+	return 0;
+}
+
+#endif /*CONFIG_ACPI_PCI*/
--- linux-2.6.0-test4.orig/arch/i386/kernel/acpi/Makefile	2003-08-23 00:55:40.000000000 +0100
+++ linux-2.6.0-test4.picmode/arch/i386/kernel/acpi/Makefile	2003-09-06 00:20:15.818307560 +0100
@@ -1,3 +1,3 @@
-obj-$(CONFIG_ACPI_BOOT)		:= boot.o
+obj-$(CONFIG_ACPI_BOOT)		:= boot.o pic.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup.o
 
--- linux-2.6.0-test4.orig/include/asm-i386/mpspec.h	2003-08-23 00:50:21.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/asm-i386/mpspec.h	2003-09-06 00:20:15.819307408 +0100
@@ -37,7 +37,7 @@
 extern void mp_register_ioapic (u8 id, u32 address, u32 irq_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 global_irq);
 extern void mp_config_acpi_legacy_irqs (void);
-extern void mp_parse_prt (void);
+extern int mp_parse_prt (void);
 
 #ifdef CONFIG_X86_IO_APIC
 extern void mp_config_ioapic_for_sci(int irq);
--- linux-2.6.0-test4.orig/include/asm-i386/acpi.h	2003-08-23 00:59:31.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/asm-i386/acpi.h	2003-09-06 00:20:15.819307408 +0100
@@ -151,6 +151,9 @@
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
 
+/* ACPI-based PIC initialisation */
+extern int pic_parse_prt (void);
+
 #endif /*CONFIG_ACPI_SLEEP*/
 
 #endif /*__KERNEL__*/
--- linux-2.6.0-test4.orig/arch/x86_64/kernel/mpparse.c	2003-08-23 00:53:53.000000000 +0100
+++ linux-2.6.0-test4.picmode/arch/x86_64/kernel/mpparse.c	2003-09-06 00:20:15.820307256 +0100
@@ -889,16 +889,31 @@
 	int			edge_level = 0;
 	int			active_high_low = 0;
 
+ 	/* Get the current PRT */
+ 	prt_list = acpi_pci_get_prt_list();
+   
+ 	if (!prt_list->count) {
+ 		acpi_pci_destroy_prt_list(prt_list);
+ 		printk(KERN_WARNING PREFIX "ACPI tables contain no IO-APIC PCI IRQ "
+ 			"routing entries\n");
+ 		return_VALUE(-ENODEV);
+ 	}
+   
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
 	 * routing for all static (IOAPIC-direct) entries.
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &acpi_prt->entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
 			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+
 			if (!irq)
 				continue;
 		} else {
@@ -949,8 +964,11 @@
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin, vector, 
 			entry->irq);
 	}
+   
+ 	/* if we get here, the PRT was fine. commit it */
+ 	acpi_pci_commit_prt_list(prt_list);
 	
-	return;
+	return 0;
 }
 
 #endif /*CONFIG_ACPI_PCI*/
--- linux-2.6.0-test4.orig/arch/x86_64/kernel/acpi/pic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test4.picmode/arch/x86_64/kernel/acpi/pic.c	2003-09-06 00:20:15.820307256 +0100
@@ -0,0 +1,102 @@
+/* ----------------------------------------------------------------------- *
+ *   
+ *   Copyright 2003 Andrew de Quincey - All Rights Reserved
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version; incorporated herein by reference.
+ *
+ * ----------------------------------------------------------------------- */
+
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/config.h>
+#include <linux/bootmem.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/acpi.h>
+
+#ifdef CONFIG_ACPI_PCI
+
+extern void eisa_set_level_irq(unsigned int irq);
+
+int __init pic_parse_prt (void)
+{
+	struct list_head	*node = NULL;
+	struct acpi_prt_entry	*entry = NULL;
+	struct acpi_prt_list	*prt_list = NULL;
+	int			edge_level = 0;
+	int			active_high_low = 0;
+	int			irq = 0;
+	int			programmed[16];
+
+	/* Get the current PRT */
+	prt_list = acpi_pci_get_prt_list();
+   
+	if (!prt_list->count) {
+		acpi_pci_destroy_prt_list(prt_list);
+		printk(KERN_WARNING PREFIX "ACPI tables contain no PIC PCI IRQ "
+			"routing entries\n");
+		return_VALUE(-ENODEV);
+	}
+
+	/* mark all IRQs as unprogrammed */
+	memset(programmed, 0, sizeof(programmed));
+   
+	/*
+	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
+	 * IRQs if necessary.
+	 */
+	list_for_each(node, &prt_list->entries) {
+		entry = list_entry(node, struct acpi_prt_entry, node);
+
+		/* Need to get irq for dynamic entry */
+		if (entry->link.handle) {
+			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+			if (irq < 0) {
+				acpi_pci_destroy_prt_list(prt_list);
+				return -ENODEV;
+			}
+ 			if (!irq) 
+				continue;
+		}
+	   
+		/* sanity check + update entry */
+		if ((irq < 0) || (irq > 15)) {
+			printk(KERN_ERR "Invalid IRQ (%i) passed to PIC programming code\n", irq);
+			entry->irq = 0;
+			continue;
+		}
+		entry->irq = irq;
+
+		/* check if it has already been dealt with */
+		if (programmed[irq]) {
+			printk(KERN_DEBUG "PIC: IRQ (%i) already programmed\n", irq);
+			continue;
+		}
+		programmed[irq] = 1;
+
+		/* program it */
+		if (edge_level) {
+			eisa_set_level_irq(irq);
+		}
+	   
+		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> IRQ %d Mode %d Trigger %d\n",
+			entry->id.segment, entry->id.bus, 
+			entry->id.device, ('A' + entry->pin), 
+			entry->irq, edge_level, active_high_low);
+	}
+	
+	/* if we get here, the PRT was fine. commit it */
+	acpi_pci_commit_prt_list(prt_list);
+   
+	return 0;
+}
+
+#endif /*CONFIG_ACPI_PCI*/
--- linux-2.6.0-test4.orig/arch/x86_64/kernel/acpi/Makefile	2003-08-23 00:56:20.000000000 +0100
+++ linux-2.6.0-test4.picmode/arch/x86_64/kernel/acpi/Makefile	2003-09-06 00:20:15.833305280 +0100
@@ -1,3 +1,3 @@
-obj-$(CONFIG_ACPI_BOOT)		:= boot.o
+obj-$(CONFIG_ACPI_BOOT)		:= boot.o pic.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup.o
 
--- linux-2.6.0-test4.orig/include/asm-x86_64/mpspec.h	2003-08-23 00:55:14.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/asm-x86_64/mpspec.h	2003-09-06 00:20:15.833305280 +0100
@@ -190,7 +190,7 @@
 extern void mp_register_ioapic (u8 id, u32 address, u32 irq_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 global_irq);
 extern void mp_config_acpi_legacy_irqs (void);
-extern void mp_parse_prt (void);
+extern int mp_parse_prt (void);
 #endif /*CONFIG_X86_IO_APIC*/
 #endif
 
--- linux-2.6.0-test4.orig/include/asm-x86_64/acpi.h	2003-08-23 00:57:46.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/asm-x86_64/acpi.h	2003-09-06 00:20:15.834305128 +0100
@@ -146,6 +146,9 @@
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002
 
+/* ACPI-based PIC initialisation */
+extern int pic_parse_prt (void);
+
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
--- linux-2.6.0-test4.orig/arch/ia64/kernel/iosapic.c	2003-08-23 00:55:37.000000000 +0100
+++ linux-2.6.0-test4.picmode/arch/ia64/kernel/iosapic.c	2003-09-06 00:20:15.839304368 +0100
@@ -680,7 +680,7 @@
 
 #ifdef CONFIG_ACPI_PCI
 
-void __init
+int __init
 iosapic_parse_prt (void)
 {
 	struct acpi_prt_entry *entry;
@@ -690,8 +690,19 @@
 	char pci_id[16];
 	struct hw_interrupt_type *irq_type = &irq_type_iosapic_level;
 	irq_desc_t *idesc;
+ 	struct acpi_prt_list	*prt_list = NULL;
 
-	list_for_each(node, &acpi_prt.entries) {
+ 	/* Get the current PRT */
+ 	prt_list = acpi_pci_get_prt_list();
+   
+ 	if (!prt_list->count) {
+ 		acpi_pci_destroy_prt_list(prt_list);
+ 		printk(KERN_WARNING PREFIX "ACPI tables contain no IO-APIC PCI IRQ "
+ 			"routing entries\n");
+ 		return_VALUE(-ENODEV);
+ 	}
+   
+	list_for_each(node, &prt_list->entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 
 		/* We're only interested in static (non-link) entries.  */
@@ -729,6 +740,10 @@
 				      IOSAPIC_LEVEL);
 
 	}
+   
+ 	/* if we get here, the PRT was fine. commit it */
+ 	acpi_pci_commit_prt_list(prt_list);
+	return 0;
 }
 
 #endif /* CONFIG_ACPI */
--- linux-2.6.0-test4.orig/include/asm-ia64/iosapic.h	2003-08-23 00:56:34.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/asm-ia64/iosapic.h	2003-09-06 00:20:15.840304216 +0100
@@ -57,7 +57,7 @@
 				    unsigned int gsi_base);
 extern int gsi_to_vector (unsigned int gsi);
 extern int gsi_to_irq (unsigned int gsi);
-extern void __init iosapic_parse_prt (void);
+extern int __init iosapic_parse_prt (void);
 extern void iosapic_enable_intr (unsigned int vector);
 extern int iosapic_register_intr (unsigned int gsi, unsigned long polarity,
 				  unsigned long trigger);
--- linux-2.6.0-test4.orig/include/asm-ia64/acpi.h	2003-08-23 00:59:27.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/asm-ia64/acpi.h	2003-09-06 00:20:15.840304216 +0100
@@ -112,6 +112,9 @@
 extern int __initdata nid_to_pxm_map[NR_NODES];
 #endif
 
+/* ia64 machines don't have PIC controllers */
+static inline int pic_parse_prt(void) { return -1; }
+
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
--- linux-2.6.0-test4.orig/drivers/acpi/pci_irq.c	2003-08-23 00:55:13.000000000 +0100
+++ linux-2.6.0-test4.picmode/drivers/acpi/pci_irq.c	2003-09-06 00:20:15.841304064 +0100
@@ -48,7 +48,22 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME		("pci_irq")
 
-struct acpi_prt_list		acpi_prt;
+struct acpi_prt_list*		acpi_prt = NULL;
+
+struct acpi_prt_ref {
+	struct list_head	node;
+	struct acpi_device	*device;
+	acpi_handle		handle;
+	int segment;
+	int bus;
+};
+
+struct acpi_prt_ref_list {
+	int			count;
+	struct list_head	entries;
+};				
+
+struct acpi_prt_ref_list acpi_prt_ref_list;
 
 #ifdef CONFIG_X86
 extern void eisa_set_level_irq(unsigned int irq);
@@ -71,13 +86,19 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_find_prt_entry");
 
+	/* ensure we're not called before the routing table has been determined */
+	if (acpi_prt == NULL) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Called before acpi_prt determined"));
+		return_PTR(NULL);
+ 	}
+
 	/*
 	 * Parse through all PRT entries looking for a match on the specified
 	 * PCI device's segment, bus, device, and pin (don't care about func).
 	 *
 	 * TBD: Acquire/release lock
 	 */
-	list_for_each(node, &acpi_prt.entries) {
+	list_for_each(node, &acpi_prt->entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 		if ((segment == entry->id.segment) 
 			&& (bus == entry->id.bus) 
@@ -93,6 +114,7 @@
 
 static int
 acpi_pci_irq_add_entry (
+	struct acpi_prt_list*		prt_list,
 	acpi_handle			handle,
 	int				segment,
 	int				bus,
@@ -149,34 +171,137 @@
 		('A' + entry->pin), prt->source, entry->link.index));
 
 	/* TBD: Acquire/release lock */
-	list_add_tail(&entry->node, &acpi_prt.entries);
-	acpi_prt.count++;
+	list_add_tail(&entry->node, &prt_list->entries);
+	prt_list->count++;
 
 	return_VALUE(0);
 }
 
 
+struct acpi_prt_list*
+acpi_pci_get_prt_list (void)
+{
+	acpi_status			status = AE_OK;
+	struct acpi_buffer		buffer = {0, NULL};
+	struct acpi_pci_routing_table	*prt = NULL;
+	struct acpi_pci_routing_table	*entry = NULL;
+	struct acpi_prt_list		*prt_list = NULL;
+	struct acpi_prt_ref		*prt_ref_entry = NULL;
+	struct list_head		*node = NULL;
+   
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_get_prt_list");
+   
+	/* Create a brand new acpi_prt_list */
+	prt_list = kmalloc(sizeof(struct acpi_prt_list), GFP_KERNEL);
+	if (!prt_list)
+		return_PTR(NULL);
+	memset(prt_list, 0, sizeof(struct acpi_prt_list));
+   
+	prt_list->count = 0;
+	INIT_LIST_HEAD(&prt_list->entries);
+   
+	/* iterate over all entries in acpi_prt_ref_list, extracting the current _PRT entries */
+	list_for_each(node, &acpi_prt_ref_list.entries) {
+		prt_ref_entry = list_entry(node, struct acpi_prt_ref, node);
+   
+		/* 
+		 * Evaluate this _PRT and add its entries to our local list (prt_list).
+		 */
+
+		buffer.length = 0;
+		buffer.pointer = NULL;
+		status = acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
+		if (status != AE_BUFFER_OVERFLOW) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
+				acpi_format_exception(status)));
+			kfree(prt_list);
+			return_PTR(NULL);
+		}
+
+		prt = kmalloc(buffer.length, GFP_KERNEL);
+		if (!prt) {
+			kfree(prt_list);
+			return_VALUE(NULL);
+		}
+		memset(prt, 0, buffer.length);
+		buffer.pointer = prt;
+
+		status = acpi_get_irq_routing_table(prt_ref_entry->handle, &buffer);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
+				acpi_format_exception(status)));
+			kfree(buffer.pointer);
+			kfree(prt_list);
+			return_PTR(NULL);
+		}
+
+		entry = prt;
+
+		while (entry && (entry->length > 0)) {
+			acpi_pci_irq_add_entry(prt_list, prt_ref_entry->handle, prt_ref_entry->segment, 
+				prt_ref_entry->bus, entry);
+			entry = (struct acpi_pci_routing_table *)
+				((unsigned long) entry + entry->length);
+		}
+
+		kfree(prt);
+	}
+
+	return_PTR(prt_list);
+}
+
+int 
+acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list) {
+	struct list_head	*node = NULL;
+	struct list_head	*tmp = NULL;
+	struct acpi_prt_entry	*entry = NULL;
+   
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_destroy_prt_list");
+
+	list_for_each_safe(node, tmp, &prt_list->entries) {
+		entry = list_entry(node, struct acpi_prt_entry, node);
+		list_del(node);
+		kfree(entry);
+	}
+	kfree(prt_list);
+   
+	return_VALUE(0);
+}	  
+  
+int
+acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list) {
+
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_commit_prt_list");
+   
+	if (acpi_prt != NULL) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Attempt to commit acpi_prt twice\n"));
+		return_VALUE(-ENODEV);
+	}
+
+	acpi_prt = prt_list;
+	return_VALUE(0);
+}
+
 int
 acpi_pci_irq_add_prt (
 	acpi_handle		handle,
 	int			segment,
 	int			bus)
 {
-	acpi_status			status = AE_OK;
-	char				pathname[ACPI_PATHNAME_MAX] = {0};
-	struct acpi_buffer		buffer = {0, NULL};
-	struct acpi_pci_routing_table	*prt = NULL;
-	struct acpi_pci_routing_table	*entry = NULL;
-	static int			first_time = 1;
+	static int		first_time = 1;
+	struct acpi_prt_ref	*entry = NULL;
+	struct acpi_buffer	buffer = {0, NULL};
+	char			pathname[ACPI_PATHNAME_MAX] = {0};
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_add_prt");
 
 	if (first_time) {
-		acpi_prt.count = 0;
-		INIT_LIST_HEAD(&acpi_prt.entries);
+		acpi_prt_ref_list.count = 0;
+		INIT_LIST_HEAD(&acpi_prt_ref_list.entries);
 		first_time = 0;
 	}
 
+   
 	/* 
 	 * NOTE: We're given a 'handle' to the _PRT object's parent device
 	 *       (either a PCI root bridge or PCI-PCI bridge).
@@ -189,42 +314,19 @@
 	printk(KERN_DEBUG "ACPI: PCI Interrupt Routing Table [%s._PRT]\n",
 		pathname);
 
-	/* 
-	 * Evaluate this _PRT and add its entries to our global list (acpi_prt).
-	 */
-
-	buffer.length = 0;
-	buffer.pointer = NULL;
-	status = acpi_get_irq_routing_table(handle, &buffer);
-	if (status != AE_BUFFER_OVERFLOW) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-			acpi_format_exception(status)));
-		return_VALUE(-ENODEV);
-	}
-
-	prt = kmalloc(buffer.length, GFP_KERNEL);
-	if (!prt)
+   
+   
+	entry = kmalloc(sizeof(struct acpi_prt_ref), GFP_KERNEL);
+	if (!entry)
 		return_VALUE(-ENOMEM);
-	memset(prt, 0, buffer.length);
-	buffer.pointer = prt;
-
-	status = acpi_get_irq_routing_table(handle, &buffer);
-	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRT [%s]\n",
-			acpi_format_exception(status)));
-		kfree(buffer.pointer);
-		return_VALUE(-ENODEV);
-	}
-
-	entry = prt;
-
-	while (entry && (entry->length > 0)) {
-		acpi_pci_irq_add_entry(handle, segment, bus, entry);
-		entry = (struct acpi_pci_routing_table *)
-			((unsigned long) entry + entry->length);
-	}
+	memset(entry, 0, sizeof(struct acpi_prt_ref));
+   
+	entry->handle = handle;
+	entry->segment = segment;
+	entry->bus = bus;
 
-	kfree(prt);
+	list_add_tail(&entry->node, &acpi_prt_ref_list.entries);
+	acpi_prt_ref_list.count++;
 
 	return_VALUE(0);
 }
@@ -383,6 +485,14 @@
 	return_VALUE(dev->irq);
 }
 
+static void __init acpi_irq_pic_mode(void)
+{
+	acpi_irq_model = ACPI_IRQ_MODEL_PIC;
+	acpi_bus_init_irq();
+   
+        /* recalculate penalties */
+ 	acpi_pci_link_calc_penalties();
+}
 
 int __init
 acpi_pci_irq_init (void)
@@ -391,27 +501,27 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_init");
 
-	if (!acpi_prt.count) {
-		printk(KERN_WARNING PREFIX "ACPI tables contain no PCI IRQ "
-			"routing entries\n");
-		return_VALUE(-ENODEV);
-	}
 
-	/* Make sure all link devices have a valid IRQ. */
-	if (acpi_pci_link_check()) {
-		return_VALUE(-ENODEV);
-	}
+ 	/* Calculate IRQ penalties for each link device */
+ 	acpi_pci_link_calc_penalties();
 
 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC)
-		mp_parse_prt();
+ 		if (mp_parse_prt()) 
+ 			acpi_irq_pic_mode();
 #endif
 #ifdef CONFIG_IOSAPIC
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOSAPIC)
-		iosapic_parse_prt();
+ 		if (iosapic_parse_prt())
+			return_VALUE(-ENODEV);
 #endif
-
+   
+ 	/* This one is last, as a catchall */
+ 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC)
+ 		if (pic_parse_prt()) 
+ 			return_VALUE(-ENODEV);
+   
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 		acpi_pci_irq_enable(dev);
 
--- linux-2.6.0-test4.orig/drivers/acpi/pci_link.c	2003-08-23 00:52:08.000000000 +0100
+++ linux-2.6.0-test4.picmode/drivers/acpi/pci_link.c	2003-09-06 00:24:06.666213344 +0100
@@ -279,7 +279,6 @@
 	return_VALUE(result);
 }
 
-
 static int
 acpi_pci_link_set (
 	struct acpi_pci_link	*link,
@@ -316,13 +315,13 @@
 			return_VALUE(-EINVAL);
 		}
 	}
-
+   
 	memset(&resource, 0, sizeof(resource));
 
 	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
 	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
 	   parameters */
-	if (irq <= 15) {
+	if (irq <= 15) {	
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.irq.edge_level = link->irq.edge_level;
@@ -401,23 +400,26 @@
  * as 'best bets' for PCI use.
  */
 
-static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
+static int acpi_irq_default_penalty[ACPI_MAX_IRQS] = {
 	1000000,  1000000,  1000000,    10000, 
 	  10000,        0,    10000,    10000,
 	  10000,        0,        0,        0, 
 	  10000,   100000,   100000,   100000,
 };
 
+static int acpi_irq_penalty[ACPI_MAX_IRQS] = { 0 };
 
 int
-acpi_pci_link_check (void)
+acpi_pci_link_calc_penalties (void)
 {
 	struct list_head	*node = NULL;
 	struct acpi_pci_link    *link = NULL;
 	int			i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_check");
+	ACPI_FUNCTION_TRACE("acpi_pci_link_calc_penalties");
 
+	memcpy(&acpi_irq_penalty, &acpi_irq_default_penalty, sizeof(acpi_irq_default_penalty));
+   
 	/*
 	 * Update penalties to facilitate IRQ balancing.
 	 */
@@ -428,6 +430,7 @@
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
 			continue;
 		}
+		link->irq.setonboot = 0;
 
 		if (link->irq.active)
 			acpi_irq_penalty[link->irq.active] += 100;
@@ -458,18 +461,18 @@
 		irq = link->irq.possible[0];
 	}
 
-		/* 
-		 * Select the best IRQ.  This is done in reverse to promote 
-		 * the use of IRQs 9, 10, 11, and >15.
-		 */
-		for (i=(link->irq.possible_count-1); i>0; i--) {
-			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-				irq = link->irq.possible[i];
-		}
+	/* 
+	 * Select the best IRQ.  This is done in reverse to promote 
+	 * the use of IRQs 9, 10, 11, and >15.
+	 */
+	for (i=(link->irq.possible_count-1); i>0; i--) {
+		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+			irq = link->irq.possible[i];
+	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {
-		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off\n",
+		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS, please report to acpi-devel!)\n",
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device));
 		return_VALUE(-ENODEV);
--- linux-2.6.0-test4.orig/drivers/acpi/bus.c	2003-08-23 00:57:08.000000000 +0100
+++ linux-2.6.0-test4.picmode/drivers/acpi/bus.c	2003-09-06 00:20:15.843303760 +0100
@@ -536,7 +536,7 @@
                              Initialization/Cleanup
    -------------------------------------------------------------------------- */
 
-static int __init
+int
 acpi_bus_init_irq (void)
 {
 	acpi_status		status = AE_OK;
--- linux-2.6.0-test4.orig/include/acpi/acpi_drivers.h	2003-08-23 00:58:03.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/acpi/acpi_drivers.h	2003-09-06 00:20:15.843303760 +0100
@@ -26,6 +26,9 @@
 #ifndef __ACPI_DRIVERS_H__
 #define __ACPI_DRIVERS_H__
 
+/* forward definitions */
+struct acpi_prt_list;
+
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
@@ -59,12 +62,15 @@
 
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
-int acpi_pci_link_check (void);
+int acpi_pci_link_calc_penalties (void);
 int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
 int acpi_pci_irq_add_prt (acpi_handle handle, int segment, int bus);
+int acpi_pci_commit_prt_list (struct acpi_prt_list* prt_list);
+int acpi_pci_destroy_prt_list (struct acpi_prt_list* prt_list);
+struct acpi_prt_list* acpi_pci_get_prt_list (void);
 
 /* ACPI PCI Device Binding (pci_bind.c) */
 
--- linux-2.6.0-test4.orig/include/linux/acpi.h	2003-08-23 00:50:23.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/linux/acpi.h	2003-09-06 00:20:15.844303608 +0100
@@ -399,7 +399,7 @@
 	struct list_head	entries;
 };
 
-extern struct acpi_prt_list	acpi_prt;
+extern struct acpi_prt_list*	acpi_prt;
 
 struct pci_dev;
 
--- linux-2.6.0-test4.orig/include/acpi/acpi_bus.h	2003-08-23 00:54:33.000000000 +0100
+++ linux-2.6.0-test4.picmode/include/acpi/acpi_bus.h	2003-09-06 00:20:15.844303608 +0100
@@ -308,6 +308,8 @@
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
+int acpi_bus_init_irq (void);
+
 #endif /*CONFIG_ACPI_BUS*/
 
 #endif /*__ACPI_BUS_H__*/

