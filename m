Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVJRX6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVJRX6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVJRX6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:58:23 -0400
Received: from fmr19.intel.com ([134.134.136.18]:9653 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751511AbVJRX6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:58:22 -0400
Subject: Re: [Pcihpd-discuss] RE: [patch 2/2] acpi: add ability to derive
	irq when doing a surpriseremoval of an adapter
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: greg@kroah.com
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <1129053267.15526.9.camel@whizzy>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406>
	 <1129053267.15526.9.camel@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Oct 2005 16:57:57 -0700
Message-Id: <1129679877.30588.5.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 18 Oct 2005 23:58:16.0224 (UTC) FILETIME=[CE7CCA00:01C5D43F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For surprise hotplug removal, the interrupt pin must be guessed, as any
attempts to read it would obviously be invalid.  This patch adds a new
function to cycle through all possible pin values, and tries to either
lookup or derive the right irq to disable.  It also adds a new function
to acpi which can be used to just find the irq, without freeing it, just
in case we guess the wrong pin.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
I fixed this patch so that it compiles without warnings now.

diff -uprN -X linux-2.6.14-rc3/Documentation/dontdiff linux-2.6.14-rc3.orig/drivers/acpi/pci_irq.c linux-2.6.14-rc3/drivers/acpi/pci_irq.c
--- linux-2.6.14-rc3.orig/drivers/acpi/pci_irq.c	2005-10-07 13:37:50.000000000 -0700
+++ linux-2.6.14-rc3/drivers/acpi/pci_irq.c	2005-10-18 16:26:44.000000000 -0700
@@ -298,6 +298,28 @@ acpi_pci_free_irq(struct acpi_prt_entry 
 	return_VALUE(irq);
 }
 
+
+
+static int
+acpi_pci_find_irq(struct acpi_prt_entry *entry,
+		  int *edge_level, int *active_high_low, char **link)
+{
+	int irq;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_find_irq");
+	if (entry->link.handle) {
+		irq = acpi_pci_link_find_irq(entry->link.handle);
+	} else {
+		irq = entry->link.index;
+	}
+
+	*link = (char *)entry;
+
+	return_VALUE(irq);
+}
+
+
+
 /*
  * acpi_pci_irq_lookup
  * success: return IRQ >= 0
@@ -491,6 +513,86 @@ void __attribute__ ((weak)) acpi_unregis
 {
 }
 
+
+
+/*
+ * This function will be called only in the case of
+ * a "surprise" hot plug removal.  For surprise removals,
+ * the card has either already be yanked out of the slot, or
+ * the slot's been powered off, so we have to brute force 
+ * our way through all the possible interrupt pins to derive
+ * the GSI, then we double check with the value stored in the
+ * pci_dev structure to make sure we have the GSI that belongs
+ * to this IRQ.
+ */
+void acpi_pci_irq_disable_nodev(struct pci_dev *dev)
+{
+	int gsi = 0;
+	u8  pin = 0;
+	int edge_level = ACPI_LEVEL_SENSITIVE;
+	int active_high_low = ACPI_ACTIVE_LOW;
+	int irq;
+	struct acpi_prt_entry *entry;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_disable_nodev");
+
+	/*
+	 * since our device is not present, we
+	 * can't just read the interrupt pin
+	 * and use the value to derive the irq.
+	 * in this case, we are going to check
+	 * each returned irq value to make
+	 * sure it matches our already assigned
+	 * irq before we use it.
+	 */
+	for (pin = 0; pin < 4; pin++) {
+		/*
+	 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
+	 	 */
+		gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+				&edge_level, &active_high_low,
+				(char **)&entry,
+				acpi_pci_find_irq);
+
+		/*
+	 	 * If no PRT entry was found, we'll try to derive an IRQ from the
+	 	 * device's parent bridge.
+	 	 */
+		if (gsi < 0)
+ 			gsi = acpi_pci_irq_derive(dev, pin,
+				&edge_level, &active_high_low,
+				(char **)&entry, acpi_pci_find_irq);
+
+		/*
+		 * If we could not derive the IRQ, give up on this pin number
+		 * and try a different one.
+		 */
+		if (gsi < 0)
+		 	continue;
+		
+		if (acpi_gsi_to_irq(gsi, &irq) < 0)
+			continue;
+
+		/*
+		 * make sure we got the right irq
+		 */
+		if (irq == dev->irq) {
+			acpi_pci_free_irq(entry, &edge_level,
+					&active_high_low, NULL);
+			printk(KERN_INFO PREFIX
+				"PCI interrupt for device %s disabled\n",
+	       			pci_name(dev));
+
+			acpi_unregister_gsi(gsi);
+			return_VOID;
+		}
+	}
+	return_VOID;
+}
+
+
+
+
 void acpi_pci_irq_disable(struct pci_dev *dev)
 {
 	int gsi = 0;
@@ -506,6 +608,14 @@ void acpi_pci_irq_disable(struct pci_dev
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin)
 		return_VOID;
+
+	/*
+	 * Check to see if the device was present
+	 */
+	if (pin == 0xff) {
+		acpi_pci_irq_disable_nodev(dev);
+		return_VOID;
+	}
 	pin--;
 
 	/*
diff -uprN -X linux-2.6.14-rc3/Documentation/dontdiff linux-2.6.14-rc3.orig/drivers/acpi/pci_link.c linux-2.6.14-rc3/drivers/acpi/pci_link.c
--- linux-2.6.14-rc3.orig/drivers/acpi/pci_link.c	2005-10-07 13:37:50.000000000 -0700
+++ linux-2.6.14-rc3/drivers/acpi/pci_link.c	2005-10-18 16:17:30.000000000 -0700
@@ -665,6 +665,41 @@ acpi_pci_link_allocate_irq(acpi_handle h
 	return_VALUE(link->irq.active);
 }
 
+
+
+int acpi_pci_link_find_irq(acpi_handle handle)
+{
+	struct acpi_device *device = NULL;
+	struct acpi_pci_link *link = NULL;
+	acpi_status result;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_find_irq");
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link device\n"));
+		return_VALUE(-1);
+	}
+
+	link = (struct acpi_pci_link *)acpi_driver_data(device);
+	if (!link) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+		return_VALUE(-1);
+	}
+
+	down(&acpi_link_lock);
+	if (!link->irq.initialized) {
+		up(&acpi_link_lock);
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link isn't initialized\n"));
+		return_VALUE(-1);
+	}
+
+	up(&acpi_link_lock);
+	return_VALUE(link->irq.active);
+}
+
+
+
 /*
  * We don't change link's irq information here.  After it is reenabled, we
  * continue use the info
diff -uprN -X linux-2.6.14-rc3/Documentation/dontdiff linux-2.6.14-rc3.orig/include/acpi/acpi_drivers.h linux-2.6.14-rc3/include/acpi/acpi_drivers.h
--- linux-2.6.14-rc3.orig/include/acpi/acpi_drivers.h	2005-10-07 13:37:52.000000000 -0700
+++ linux-2.6.14-rc3/include/acpi/acpi_drivers.h	2005-10-18 16:20:08.000000000 -0700
@@ -55,6 +55,7 @@ int acpi_irq_penalty_init(void);
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *edge_level,
 			       int *active_high_low, char **name);
 int acpi_pci_link_free_irq(acpi_handle handle);
+int acpi_pci_link_find_irq(acpi_handle handle);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 

