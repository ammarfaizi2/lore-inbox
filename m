Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUIMAt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUIMAt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIMAt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:49:57 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:23822 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S264571AbUIMAsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:48:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Subject: [PATCH][2.6.8]  Incorrect  PCI interrupt assignment on ES7000
Date: Sun, 12 Sep 2004 19:47:53 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04220260@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6.8]  Incorrect  PCI interrupt assignment on ES7000
Thread-Index: AcSZK01hQqiZPNJtRXiu+TQUtFWocQ==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: <lse-tech@lists.sourceforge.net>, <acpi-devel@lists.sourceforge.net>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 13 Sep 2004 00:47:54.0361 (UTC) FILETIME=[4DF2AE90:01C4992B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
We are experiencing failures on ES7000 that are interrupt initialization
related, when PCI cards on first PCI module won't work. It turned out
that there are two distinct problems with setting up PCI interrupts on
the first IO-APIC when a platform implements IRQ overrides. This is the
case on ES7000, which has PCI range 0-11 on the first IO-APIC, and ISA
range is shifted and starts at 12.

First problem is that in arch/i386/kernel/acpi/boot.c, platform GSI does
not propagate back from mp_register_gsi() to a calling routine which
results in IRQ to be set for wrong GSI. This causes most of the PCI
slots of the first PCI module to fail. More detail on it is in
http://bugme.osdl.org/show_bug.cgi?id=3349.
Below is the code change that fixes the problem:


------------------------------------------------------------------------
---------------
diff -Naur linux-2.6.8/include/asm-i386/mpspec.h
linux8/include/asm-i386/mpspec.h
--- linux-2.6.8/include/asm-i386/mpspec.h	2004-08-14
01:36:10.000000000 -0400
+++ linux8/include/asm-i386/mpspec.h	2004-08-15 06:16:27.000000000
-0400
@@ -33,7 +33,7 @@
 extern void mp_register_ioapic (u8 id, u32 address, u32 gsi_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8
trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
-extern void mp_register_gsi (u32 gsi, int edge_level, int
active_high_low);
+extern int mp_register_gsi (u32 gsi, int edge_level, int
active_high_low);
 #endif /*CONFIG_ACPI_BOOT*/
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_APICS)
diff -Naur linux-2.6.8/arch/i386/kernel/acpi/boot.c
linux8/arch/i386/kernel/acpi/boot.c
--- linux-2.6.8/arch/i386/kernel/acpi/boot.c	2004-08-14
01:37:40.000000000 -0400
+++ linux8/arch/i386/kernel/acpi/boot.c	2004-08-15 06:15:24.000000000
-0400
@@ -442,6 +442,7 @@
 unsigned int acpi_register_gsi(u32 gsi, int edge_level, int
active_high_low)
 {
 	unsigned int irq;
+	unsigned int plat_gsi;
 
 #ifdef CONFIG_PCI
 	/*
@@ -463,10 +464,10 @@
 
 #ifdef CONFIG_X86_IO_APIC
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC) {
-		mp_register_gsi(gsi, edge_level, active_high_low);
+		plat_gsi = mp_register_gsi(gsi, edge_level,
active_high_low);
 	}
 #endif
-	acpi_gsi_to_irq(gsi, &irq);
+	acpi_gsi_to_irq(plat_gsi, &irq);
 	return irq;
 }
 EXPORT_SYMBOL(acpi_register_gsi);
diff -Naur linux-2.6.8/arch/i386/kernel/mpparse.c
linux8/arch/i386/kernel/mpparse.c
--- linux-2.6.8/arch/i386/kernel/mpparse.c	2004-08-14
01:36:44.000000000 -0400
+++ linux8/arch/i386/kernel/mpparse.c	2004-08-15 06:16:18.000000000
-0400
@@ -1051,7 +1051,7 @@
 
 int (*platform_rename_gsi)(int ioapic, int gsi);
 
-void mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
+int mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
 {
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
@@ -1066,7 +1066,7 @@
 	ioapic = mp_find_ioapic(gsi);
 	if (ioapic < 0) {
 		printk(KERN_WARNING "No IOAPIC for GSI %u\n", gsi);
-		return;
+		return gsi;
 	}
 
 	ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_base;
@@ -1085,12 +1085,12 @@
 		printk(KERN_ERR "Invalid reference to IOAPIC pin "
 			"%d-%d\n", mp_ioapic_routing[ioapic].apic_id, 
 			ioapic_pin);
-		return;
+		return gsi;
 	}
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-		return;
+		return gsi;
 	}
 
 	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
@@ -1098,6 +1098,7 @@
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		    edge_level == ACPI_EDGE_SENSITIVE ? 0 : 1,
 		    active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
+	return gsi;
 }
 
 #endif /*CONFIG_X86_IO_APIC && (CONFIG_ACPI_INTERPRETER ||
CONFIG_ACPI_BOOT)*/
------------------------------------------------------------------------
-------------

Second issue is that the ACPI driver uses zero as an error return while
parsing _PRT. On ES7000, pin 0 is used for a PCI device. While zero is a
legitimate GSI, it gets discarded as invalid by the parser. This results
in any device with an interrupt line wired to IRQ 0 will not be assigned
an IRQ for that interrupt line. This causes failure of the slot that
contains device wired to pin 0. More detail on it is in
http://bugme.osdl.org/show_bug.cgi?id=3351. How about using "-1" as an
error return? Below is proposed code change:


------------------------------------------------------------------------
---------------------
diff -Naur linux-2.6.8/drivers/acpi/pci_irq.c
linux8/drivers/acpi/pci_irq.c
--- linux-2.6.8/drivers/acpi/pci_irq.c	2004-08-14 01:36:57.000000000
-0400
+++ linux8/drivers/acpi/pci_irq.c	2004-08-14 13:56:50.000000000
-0400
@@ -249,14 +249,14 @@
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device,
pin); 
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not
found\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 	
 	if (entry->link.handle) {
 		irq = acpi_pci_link_get_irq(entry->link.handle,
entry->link.index, edge_level, active_high_low);
-		if (!irq) {
+		if (irq < 0) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ
link routing entry\n"));
-			return_VALUE(0);
+			return_VALUE(-1);
 		}
 	} else {
 		irq = entry->link.index;
@@ -277,7 +277,7 @@
 	int			*active_high_low)
 {
 	struct pci_dev		*bridge = dev;
-	int			irq = 0;
+	int			irq = -1;
 	u8			bridge_pin = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_derive");
@@ -289,7 +289,7 @@
 	 * Attempt to derive an IRQ for this device from a parent
bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card
bridge).
 	 */
-	while (!irq && bridge->bus->self) {
+	while (irq < 0 && bridge->bus->self) {
 		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
 		bridge = bridge->bus->self;
 
@@ -299,7 +299,7 @@
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 					"No interrupt pin configured for
device %s\n", pci_name(bridge)));
-				return_VALUE(0);
+				return_VALUE(-EINVAL);
 			}
 			/* Pin is from 0 to 3 */
 			bridge_pin --;
@@ -310,9 +310,9 @@
 			pin, edge_level, active_high_low);
 	}
 
-	if (!irq) {
+	if (irq < 0) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to derive IRQ
for device %s\n", pci_name(dev)));
-		return_VALUE(0);
+		return_VALUE(-EINVAL);
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s
from %s\n",
@@ -358,18 +358,18 @@
 	 * If no PRT entry was found, we'll try to derive an IRQ from
the
 	 * device's parent bridge.
 	 */
-	if (!irq)
+	if (irq < 0)
  		irq = acpi_pci_irq_derive(dev, pin, &edge_level,
&active_high_low);
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
 	 */
-	if (!irq) {
+	if (irq < 0) {
 		printk(KERN_WARNING PREFIX "PCI interrupt %s[%c]: no
GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq && (dev->irq <= 0xF)) {
+		if (dev->irq >= 0  && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
 			return_VALUE(dev->irq);
 		}
diff -Naur linux-2.6.8/drivers/acpi/pci_link.c
linux8/drivers/acpi/pci_link.c
--- linux-2.6.8/drivers/acpi/pci_link.c	2004-08-14 01:36:16.000000000
-0400
+++ linux8/drivers/acpi/pci_link.c	2004-08-14 13:56:50.000000000
-0400
@@ -593,27 +593,27 @@
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link
device\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	link = (struct acpi_pci_link *) acpi_driver_data(device);
 	if (!link) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link
context\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid index %d\n",
index));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (acpi_pci_link_allocate(link))
-		return_VALUE(0);
+		return_VALUE(-1);
 	   
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is
0!\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (edge_level) *edge_level = link->irq.edge_level;
------------------------------------------------------------------------
--------

The patches above were tested on ES7000 and also on generic Intel system
and worked OK.
I will appreciate any thoughts and feedback on the above issues and
patches.

Thanks,
--Natalie
