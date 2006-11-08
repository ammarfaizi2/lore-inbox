Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWKHQVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWKHQVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWKHQVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:21:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56227 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161169AbWKHQVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:21:10 -0500
Subject: [PATCH] pci quirks: Sort out the VIA mess once and for all
	(hopefully)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 16:25:56 +0000
Message-Id: <1163003156.23956.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perform the VIA fixup only on the devices on the V-Link on the VIA
bridges that have it, and nowhere else.

Doing this we move the PCI_VDEVICE macro to pci.h and document it. We
also add pci_find_present which works like pci_device_present but
returns the matching id and is more useful. pci_device_present becomes a
trivial user of pci_find_present instead.

Boots for me but going by history this wants quite a bit of testing
before anyone can be sure it actually fixes all the cases we have to
deal with. If you have a VIA board (problem or otherwise) try this patch
versus 2.6.19-rc4-mm (and probably rc5-mm once it appears) and let me
know if it sorts out your box.

If you have a system where the onboard devices still fail then please
send me a bug report and include the "dmesg" output, lspci -vvxxx, and
info on any kernels that apparently did work.

[Andrew - please don't merge this yet, I need to fix things like caching
the pci_find_device to work again before its ready for -mm]

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/pci/quirks.c linux-2.6.19-rc4-mm1/drivers/pci/quirks.c
--- linux.vanilla-2.6.19-rc4-mm1/drivers/pci/quirks.c	2006-10-31 21:11:49.000000000 +0000
+++ linux-2.6.19-rc4-mm1/drivers/pci/quirks.c	2006-11-07 10:27:14.000000000 +0000
@@ -641,48 +641,42 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-/*
- * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
- * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
- * when written, it makes an internal connection to the PIC.
- * For these devices, this register is defined to be 4 bits wide.
- * Normally this is fine.  However for IO-APIC motherboards, or
- * non-x86 architectures (yes Via exists on PPC among other places),
- * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
- * interrupts delivered properly.
- *
- * Some of the on-chip devices are actually '586 devices' so they are
- * listed here.
- */
-
-static int via_irq_fixup_needed = -1;
 
 /*
- * As some VIA hardware is available in PCI-card form, we need to restrict
- * this quirk to VIA PCI hardware built onto VIA-based motherboards only.
- * We try to locate a VIA southbridge before deciding whether the quirk
- * should be applied.
- */
-static const struct pci_device_id via_irq_fixup_tbl[] = {
-	{
-		.vendor 	= PCI_VENDOR_ID_VIA,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.class		= PCI_CLASS_BRIDGE_ISA << 8,
-		.class_mask	= 0xffff00,
-	},
+ *	VIA bridges which have VLink
+ */
+ 
+static const struct pci_device_id via_vlink_fixup_tbl[] = {
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233_0), 17},
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233A), 17 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8233C_0), 17 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8235), 16 },
+	/* May not be needed for the 8237 */
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237), 15 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_8237A), 15 },
 	{ 0, },
 };
 
-static void quirk_via_irq(struct pci_dev *dev)
+/**
+ *	quirk_via_vlink		-	VIA VLink IRQ number update
+ *	@dev: PCI device
+ *
+ *	If the device we are dealing with is on a PIC IRQ we need to
+ *	ensure that the IRQ line register which usually is not relevant
+ *	for PCI cards, is actually written so that interrupts get sent
+ *	to the right place
+ */
+
+static void quirk_via_vlink(struct pci_dev *dev)
 {
+	static struct pci_device_id *via_vlink_fixup = NULL;
 	u8 irq, new_irq;
 
-	if (via_irq_fixup_needed == -1)
-		via_irq_fixup_needed = pci_dev_present(via_irq_fixup_tbl);
-
-	if (!via_irq_fixup_needed)
+	/* Check if we have VLink and cache the result */
+	
+	if (via_vlink_fixup == NULL)
+		via_vlink_fixup = pci_find_present(via_vlink_fixup_tbl);
+	if (via_vlink_fixup == NULL)
 		return;
 
 	new_irq = dev->irq;
@@ -691,15 +685,23 @@
 	if (!new_irq || new_irq > 15)
 		return;
 
+	/* Internal device ? */
+	if (dev->bus->number != 0 || PCI_FUNC(dev->devfn) > 18 || 
+		PCI_FUNC(dev->devfn) < via_vlink_fixup->driver_data)
+		return;
+	
+	/* This is an internal VLink device on a PIC interrupt. The BIOS
+	   ought to have set this but may not have, so we redo it */
+	
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
-		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
+		printk(KERN_INFO "PCI: VIA VLink IRQ fixup for %s, from %d to %d\n",
 			pci_name(dev), irq, new_irq);
 		udelay(15);	/* unknown if delay really needed */
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_vlink);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/pci/search.c linux-2.6.19-rc4-mm1/drivers/pci/search.c
--- linux.vanilla-2.6.19-rc4-mm1/drivers/pci/search.c	2006-10-31 21:11:31.000000000 +0000
+++ linux-2.6.19-rc4-mm1/drivers/pci/search.c	2006-11-06 20:30:55.000000000 +0000
@@ -413,30 +413,17 @@
 	return dev;
 }
 
-/**
- * pci_dev_present - Returns 1 if device matching the device list is present, 0 if not.
- * @ids: A pointer to a null terminated list of struct pci_device_id structures
- * that describe the type of PCI device the caller is trying to find.
- *
- * Obvious fact: You do not have a reference to any device that might be found
- * by this function, so if that device is removed from the system right after
- * this function is finished, the value will be stale.  Use this function to
- * find devices that are usually built into a system, or for a general hint as
- * to if another device happens to be present at this specific moment in time.
- */
-int pci_dev_present(const struct pci_device_id *ids)
+struct pci_device_id *pci_find_present(const struct pci_device_id *ids)
 {
 	struct pci_dev *dev;
-	int found = 0;
+	struct pci_device_id * found = NULL;
 
 	WARN_ON(in_interrupt());
 	down_read(&pci_bus_sem);
 	while (ids->vendor || ids->subvendor || ids->class_mask) {
 		list_for_each_entry(dev, &pci_devices, global_list) {
-			if (pci_match_one_device(ids, dev)) {
-				found = 1;
-				goto exit;
-			}
+			if ((found = pci_match_one_device(ids, dev)) != NULL)
+				break;
 		}
 		ids++;
 	}
@@ -444,7 +431,26 @@
 	up_read(&pci_bus_sem);
 	return found;
 }
+
+/**
+ * pci_dev_present - Returns 1 if device matching the device list is present, 0 if not.
+ * @ids: A pointer to a null terminated list of struct pci_device_id structures
+ * that describe the type of PCI device the caller is trying to find.
+ *
+ * Obvious fact: You do not have a reference to any device that might be found
+ * by this function, so if that device is removed from the system right after
+ * this function is finished, the value will be stale.  Use this function to
+ * find devices that are usually built into a system, or for a general hint as
+ * to if another device happens to be present at this specific moment in time.
+ */
+
+int pci_dev_present(const struct pci_device_id *ids)
+{
+	return pci_find_present(ids) == NULL ? 0 : 1;
+}
+
 EXPORT_SYMBOL(pci_dev_present);
+EXPORT_SYMBOL(pci_find_present);
 
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_device_reverse);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/include/linux/libata.h linux-2.6.19-rc4-mm1/include/linux/libata.h
--- linux.vanilla-2.6.19-rc4-mm1/include/linux/libata.h	2006-10-31 21:11:50.000000000 +0000
+++ linux-2.6.19-rc4-mm1/include/linux/libata.h	2006-11-07 10:07:10.000000000 +0000
@@ -109,11 +109,6 @@
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
-/* move to PCI layer? */
-#define PCI_VDEVICE(vendor, device)		\
-	PCI_VENDOR_ID_##vendor, (device),	\
-	PCI_ANY_ID, PCI_ANY_ID, 0, 0
-
 static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
 {
 	return &pdev->dev;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/include/linux/pci.h linux-2.6.19-rc4-mm1/include/linux/pci.h
--- linux.vanilla-2.6.19-rc4-mm1/include/linux/pci.h	2006-10-31 21:11:50.000000000 +0000
+++ linux-2.6.19-rc4-mm1/include/linux/pci.h	2006-11-07 10:07:06.000000000 +0000
@@ -389,6 +390,21 @@
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
+/**
+ * PCI_VDEVICE - macro used to describe a specific pci device in short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ *
+ * This macro is used to create a struct pci_device_id that matches a
+ * specific PCI device.  The vendor, device, subvendor, and subdevice
+ * fields will be set to PCI_ANY_ID. The macro allows the next field
+ * to follow as the device private data.
+ */
+ 
+#define PCI_VDEVICE(vendor, device)		\
+	PCI_VENDOR_ID_##vendor, (device),	\
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0
+
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -461,6 +477,7 @@
 struct pci_dev *pci_get_bus_and_slot (unsigned int bus, unsigned int devfn);
 struct pci_dev *pci_get_class (unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
+struct pci_device_id *pci_find_present(const struct pci_device_id *ids);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
@@ -684,6 +701,7 @@
 { return NULL; }
 
 #define pci_dev_present(ids)	(0)
+#define pci_find_present(ids)	(NULL)
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }

