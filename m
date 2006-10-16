Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWJPPUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWJPPUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWJPPUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:20:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18314 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932143AbWJPPUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:20:04 -0400
Subject: [PATCH] pci: Additional functions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:46:51 +0100
Message-Id: <1161013612.24237.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to finish converting to pci_get_* interfaces we need to add a
couple of bits of missing functionaility

pci_get_bus_and_slot() provides the equivalent to pci_find_slot()
(pci_get_slot is already taken as a name for something similar but not
the same)

pci_get_device_reverse() is the equivalent of pci_find_device_reverse
but refcounting


Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/pci/search.c linux-2.6.19-rc1-mm1/drivers/pci/search.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/pci/search.c	2006-10-13 15:06:44.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/pci/search.c	2006-10-13 17:20:46.000000000 +0100
@@ -140,6 +142,31 @@
 }
 
 /**
+ * pci_get_bus_and_slot - locate PCI device from a given PCI slot
+ * @bus: number of PCI bus on which desired PCI device resides
+ * @devfn: encodes number of PCI slot in which the desired PCI 
+ * device resides and the logical device number within that slot 
+ * in case of multi-function devices.
+ *
+ * Given a PCI bus and slot/function number, the desired PCI device 
+ * is located in system global list of PCI devices.  If the device
+ * is found, a pointer to its data structure is returned.  If no 
+ * device is found, %NULL is returned. The returned device has its
+ * reference count bumped by one.
+ */
+
+struct pci_dev * pci_get_bus_and_slot(unsigned int bus, unsigned int devfn)
+{
+	struct pci_dev *dev = NULL;
+
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		if (dev->bus->number == bus && dev->devfn == devfn)
+			return dev;
+	}
+	return NULL;
+}
+
+/**
  * pci_find_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
  * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
@@ -274,7 +305,46 @@
 	return pci_get_subsys(vendor, device, PCI_ANY_ID, PCI_ANY_ID, from);
 }
 
+/**
+ * pci_get_device_reverse - begin or continue searching for a PCI device by vendor/device id
+ * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI devices in the reverse order of
+ * pci_get_device.
+ * If a PCI device is found with a matching @vendor and @device, the reference
+ * count to the  device is incremented and a pointer to its device structure
+ * is returned Otherwise, %NULL is returned.  A new search is initiated by
+ * passing %NULL as the @from argument.  Otherwise if @from is not %NULL,
+ * searches continue from next device on the global list.  The reference
+ * count for @from is always decremented if it is not %NULL.
+ */
+struct pci_dev *
+pci_get_device_reverse(unsigned int vendor, unsigned int device, struct pci_dev *from)
+{
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	WARN_ON(in_interrupt());
+	down_read(&pci_bus_sem);
+	n = from ? from->global_list.prev : pci_devices.prev;
 
+	while (n && (n != &pci_devices)) {
+		dev = pci_dev_g(n);
+		if ((vendor == PCI_ANY_ID || dev->vendor == vendor) &&
+		    (device == PCI_ANY_ID || dev->device == device))
+			goto exit;
+		n = n->prev;
+	}
+	dev = NULL;
+exit:
+	dev = pci_dev_get(dev);
+	up_read(&pci_bus_sem);
+	pci_dev_put(from);
+	return dev;
+}
+
 /**
  * pci_find_device_reverse - begin or continue searching for a PCI device by vendor/device id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
@@ -382,12 +456,16 @@
 }
 EXPORT_SYMBOL(pci_dev_present);
 
-EXPORT_SYMBOL(pci_find_bus);
-EXPORT_SYMBOL(pci_find_next_bus);
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_device_reverse);
 EXPORT_SYMBOL(pci_find_slot);
+/* For boot time work */
+EXPORT_SYMBOL(pci_find_bus);
+EXPORT_SYMBOL(pci_find_next_bus);
+/* For everyone */
 EXPORT_SYMBOL(pci_get_device);
+EXPORT_SYMBOL(pci_get_device_reverse);
 EXPORT_SYMBOL(pci_get_subsys);
 EXPORT_SYMBOL(pci_get_slot);
+EXPORT_SYMBOL(pci_get_bus_and_slot);
 EXPORT_SYMBOL(pci_get_class);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/include/linux/pci.h linux-2.6.19-rc1-mm1/include/linux/pci.h
--- linux.vanilla-2.6.19-rc1-mm1/include/linux/pci.h	2006-10-13 15:10:15.000000000 +0100
+++ linux-2.6.19-rc1-mm1/include/linux/pci.h	2006-10-13 17:21:50.000000000 +0100
@@ -441,19 +441,22 @@
 
 /* Generic PCI functions exported to card drivers */
 
 struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
+struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
+
+/* Hotplug safe current interfaces */
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_next_capability (struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability (struct pci_dev *dev, int cap);
-struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
-
 struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from);
+struct pci_dev *pci_get_device_reverse (unsigned int vendor, unsigned int device, struct pci_dev *from);
 struct pci_dev *pci_get_subsys (unsigned int vendor, unsigned int device,
 				unsigned int ss_vendor, unsigned int ss_device,
 				struct pci_dev *from);
 struct pci_dev *pci_get_slot (struct pci_bus *bus, unsigned int devfn);
+struct pci_dev *pci_get_bus_and_slot (unsigned int bus, unsigned int devfn);
 struct pci_dev *pci_get_class (unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
 

