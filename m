Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUINBvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUINBvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 21:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269103AbUINBvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 21:51:09 -0400
Received: from c-24-10-253-213.client.comcast.net ([24.10.253.213]:722 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269102AbUINBuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 21:50:50 -0400
Message-Id: <200409140151.i8E1p4ZE023810@localhost.localdomain>
Subject: [patch 2/2] Incorrect PCI interrupt assignment on ES7000 for pin zero
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Mon, 13 Sep 2004 19:51:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI driver uses zero as an error return while parsing _PRT. On ES7000, pin 0 on the first IO-APIC is used for a PCI device. While zero is a legitimate GSI, it gets discarded as invalid by the parser. This results in any device with an interrupt line wired to IRQ 0 will not be assigned an IRQ for that interrupt line. This causes failure of the slot that contains device wired to pin 0. Below is proposed code change to use "-1" as error return:


Signed-off-by: Natalie Protasevich <Natalie.Protasevich@xxxxxxxxxx>

---

 linux-root/drivers/acpi/pci_irq.c  |   26 +++++++++++++-------------
 linux-root/drivers/acpi/pci_link.c |   10 +++++-----
 2 files changed, 18 insertions(+), 18 deletions(-)

diff -L vers/acpi/pci_irq.c -puN /dev/null /dev/null
diff -puN drivers/acpi/pci_link.c~mypatch1 drivers/acpi/pci_link.c
--- linux/drivers/acpi/pci_link.c~mypatch1	2004-09-13 14:19:32.000000000 -0600
+++ linux-root/drivers/acpi/pci_link.c	2004-09-13 14:30:06.000000000 -0600
@@ -593,27 +593,27 @@ acpi_pci_link_get_irq (
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link device\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	link = (struct acpi_pci_link *) acpi_driver_data(device);
 	if (!link) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid index %d\n", index));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (acpi_pci_link_allocate(link))
-		return_VALUE(0);
+		return_VALUE(-1);
 	   
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is 0!\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (edge_level) *edge_level = link->irq.edge_level;
diff -puN drivers/acpi/pci_irq.c~mypatch1 drivers/acpi/pci_irq.c
--- linux/drivers/acpi/pci_irq.c~mypatch1	2004-09-13 14:19:54.000000000 -0600
+++ linux-root/drivers/acpi/pci_irq.c	2004-09-13 15:23:22.463717712 -0600
@@ -249,14 +249,14 @@ acpi_pci_irq_lookup (
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin); 
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 	
 	if (entry->link.handle) {
 		irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, edge_level, active_high_low);
-		if (!irq) {
+		if (irq < 0) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
-			return_VALUE(0);
+			return_VALUE(-1);
 		}
 	} else {
 		irq = entry->link.index;
@@ -277,7 +277,7 @@ acpi_pci_irq_derive (
 	int			*active_high_low)
 {
 	struct pci_dev		*bridge = dev;
-	int			irq = 0;
+	int			irq = -1;
 	u8			bridge_pin = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_derive");
@@ -289,7 +289,7 @@ acpi_pci_irq_derive (
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (!irq && bridge->bus->self) {
+	while (irq < 0 && bridge->bus->self) {
 		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
 		bridge = bridge->bus->self;
 
@@ -299,7 +299,7 @@ acpi_pci_irq_derive (
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 					"No interrupt pin configured for device %s\n", pci_name(bridge)));
-				return_VALUE(0);
+				return_VALUE(-EINVAL);
 			}
 			/* Pin is from 0 to 3 */
 			bridge_pin --;
@@ -310,9 +310,9 @@ acpi_pci_irq_derive (
 			pin, edge_level, active_high_low);
 	}
 
-	if (!irq) {
+	if (irq < 0) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to derive IRQ for device %s\n", pci_name(dev)));
-		return_VALUE(0);
+		return_VALUE(-EINVAL);
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s from %s\n",
@@ -327,7 +327,7 @@ acpi_pci_irq_enable (
 	struct pci_dev		*dev)
 {
 	int			irq = 0;
-	u8			pin = 0;
+	u8			pin = -1;
 	int			edge_level = ACPI_LEVEL_SENSITIVE;
 	int			active_high_low = ACPI_ACTIVE_LOW;
 
@@ -358,24 +358,24 @@ acpi_pci_irq_enable (
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
-	if (!irq)
+	if (irq < 0)
  		irq = acpi_pci_irq_derive(dev, pin, &edge_level, &active_high_low);
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
 	 */
-	if (!irq) {
+	if (irq < 0) {
 		printk(KERN_WARNING PREFIX "PCI interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq && (dev->irq <= 0xF)) {
+		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
 			return_VALUE(dev->irq);
 		}
 		else {
 			printk("\n");
-			return_VALUE(0);
+			return_VALUE(-EINVAL);
 		}
  	}
 
_
