Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVHJBd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVHJBd2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 21:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVHJBd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 21:33:28 -0400
Received: from ozlabs.org ([203.10.76.45]:52609 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751034AbVHJBd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 21:33:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17145.23098.798473.364481@cargo.ozlabs.ibm.com>
Date: Wed, 10 Aug 2005 11:36:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, linas@austin.ibm.com
Subject: [RFC/PATCH] Add pci_walk_bus function to PCI core
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Any comments on this patch?  Would you be amenable to it going in post
2.6.13?

The PCI error recovery infrastructure needs to be able to contact all
the drivers affected by a PCI error event, which may mean traversing
all the devices under a given PCI-PCI bridge.  This patch adds a
function to the PCI core that traverses all the PCI devices on a PCI
bus and under any PCI-PCI bridges on that bus (recursively), calling a
given function for each device.  This provides a way for the error
recovery code to iterate through all devices that are affected by an
error event.  This function was originally written by Linas Vepstas
and moved to drivers/pci/bus.c (and slightly modified) by me.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN linux-2.6/drivers/pci/bus.c test-pseries/drivers/pci/bus.c
--- linux-2.6/drivers/pci/bus.c	2005-08-03 10:51:36.000000000 +1000
+++ test-pseries/drivers/pci/bus.c	2005-08-09 17:05:16.000000000 +1000
@@ -150,6 +150,36 @@
 	}
 }
 
+/** pci_walk_bus - walk devices on/under bus, calling callback.
+ *  @top      bus whose devices should be walked
+ *  @cb       callback to be called for each device found
+ *  @userdata arbitrary pointer to be passed to callback.
+ *
+ *  Walk the given bus, including any bridged devices
+ *  on buses under this bus.  Call the provided callback
+ *  on each device found.
+ */
+void pci_walk_bus(struct pci_bus *top, pci_buswalk_cb cb, void *userdata)
+{
+	struct pci_dev *dev, *tmp;
+
+	spin_lock(&pci_bus_lock);
+	list_for_each_entry_safe (dev, tmp, &top->devices, bus_list) {
+		pci_dev_get(dev);
+		spin_unlock(&pci_bus_lock);
+
+		/* Run device routines with the bus unlocked */
+		cb(dev, userdata);
+		if (dev->subordinate)
+			pci_walk_bus(dev->subordinate, cb, userdata);
+
+		spin_lock(&pci_bus_lock);
+		pci_dev_put(dev);
+	}
+	spin_unlock(&pci_bus_lock);
+}
+EXPORT_SYMBOL_GPL(pci_walk_bus);
+
 EXPORT_SYMBOL(pci_bus_alloc_resource);
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 EXPORT_SYMBOL(pci_bus_add_devices);
diff -urN linux-2.6/include/linux/pci.h test-pseries/include/linux/pci.h
--- linux-2.6/include/linux/pci.h	2005-08-10 10:53:31.000000000 +1000
+++ test-pseries/include/linux/pci.h	2005-08-10 11:25:40.000000000 +1000
@@ -864,6 +864,9 @@
 const struct pci_device_id *pci_match_id(const struct pci_device_id *ids, struct pci_dev *dev);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
 
+typedef void (*pci_buswalk_cb)(struct pci_dev *, void *);
+void pci_walk_bus(struct pci_bus *top, pci_buswalk_cb cb, void *userdata);
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/dmapool.h>
