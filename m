Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266556AbUA3BtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266510AbUA3BgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:36:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:10204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266511AbUA3BcD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:03 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <1075426306434@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:48 -0800
Message-Id: <10754263082016@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1513, 2004/01/29 14:32:13-08:00, willy@debian.org

[PATCH] PCI: add pci_get_slot() function

tg3.c has a bug where it can find the wrong 5704 peer on a machine with
PCI domains.  The problem is that pci_find_slot() can't distinguish
whether it has the correct domain or not.

This patch fixes that problem by introducing pci_get_slot().


 drivers/pci/search.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    2 ++
 2 files changed, 38 insertions(+)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jan 29 17:24:31 2004
+++ b/drivers/pci/search.c	Thu Jan 29 17:24:31 2004
@@ -104,6 +104,41 @@
 }
 
 /**
+ * pci_get_slot - locate PCI device for a given PCI slot
+ * @bus: PCI bus on which desired PCI device resides
+ * @devfn: encodes number of PCI slot in which the desired PCI 
+ * device resides and the logical device number within that slot 
+ * in case of multi-function devices.
+ *
+ * Given a PCI bus and slot/function number, the desired PCI device 
+ * is located in the list of PCI devices.
+ * If the device is found, its reference count is increased and this
+ * function returns a pointer to its data structure.  The caller must
+ * decrement the reference count by calling pci_dev_put().
+ * If no device is found, %NULL is returned.
+ */
+struct pci_dev * pci_get_slot(struct pci_bus *bus, unsigned int devfn)
+{
+	struct list_head *tmp;
+	struct pci_dev *dev;
+
+	WARN_ON(in_interrupt());
+	spin_lock(&pci_bus_lock);
+
+	list_for_each(tmp, &bus->children) {
+		dev = pci_dev_b(tmp);
+		if (dev->devfn == devfn)
+			goto out;
+	}
+
+	dev = NULL;
+ out:
+	pci_dev_get(dev);
+	spin_unlock(&pci_bus_lock);
+	return dev;
+}
+
+/**
  * pci_find_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
  * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
@@ -319,3 +354,4 @@
 EXPORT_SYMBOL(pci_find_subsys);
 EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
+EXPORT_SYMBOL(pci_get_slot);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jan 29 17:24:31 2004
+++ b/include/linux/pci.h	Thu Jan 29 17:24:31 2004
@@ -614,6 +614,8 @@
 struct pci_dev *pci_get_subsys (unsigned int vendor, unsigned int device,
 				unsigned int ss_vendor, unsigned int ss_device,
 				struct pci_dev *from);
+struct pci_dev *pci_get_slot (struct pci_bus *bus, unsigned int devfn);
+
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
 int pci_bus_read_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 *val);

