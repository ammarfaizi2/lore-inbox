Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVHREcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVHREcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 00:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVHREcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 00:32:32 -0400
Received: from ozlabs.org ([203.10.76.45]:19868 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751330AbVHREcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 00:32:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17156.3965.483826.692623@cargo.ozlabs.ibm.com>
Date: Thu, 18 Aug 2005 14:33:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
CC: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
       linas@austin.ibm.com
Subject: [PATCH]  Add pci_walk_bus function to PCI core (nonrecursive)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI error recovery infrastructure needs to be able to contact all
the drivers affected by a PCI error event, which may mean traversing
all the devices under a given PCI-PCI bridge.  This patch adds a
function to the PCI core that traverses all the PCI devices on a PCI
bus and under any PCI-PCI bridges on that bus (and so on), calling a
given function for each device.  This provides a way for the error
recovery code to iterate through all devices that are affected by an
error event.

This version is not implemented as a recursive function.  Instead,
when we reach a PCI-PCI bridge, we set the pointers to start doing the
devices on the bus under the bridge, and when we reach the end of a
bus's devices, we use the bus->self pointer to go back up to the next
higher bus and continue doing its devices.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN linux-2.6/drivers/pci/bus.c test-pseries/drivers/pci/bus.c
--- linux-2.6/drivers/pci/bus.c	2005-08-03 10:51:36.000000000 +1000
+++ test-pseries/drivers/pci/bus.c	2005-08-18 14:03:28.000000000 +1000
@@ -150,6 +150,54 @@
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
+void pci_walk_bus(struct pci_bus *top, void (*cb)(struct pci_dev *, void *),
+		  void *userdata)
+{
+	struct pci_dev *dev;
+	struct pci_bus *bus;
+	struct list_head *next;
+
+	bus = top;
+	spin_lock(&pci_bus_lock);
+	next = top->devices.next;
+	for (;;) {
+		if (next == &bus->devices) {
+			/* end of this bus, go up or finish */
+			if (bus == top)
+				break;
+			next = bus->self->bus_list.next;
+			bus = bus->self->bus;
+			continue;
+		}
+		dev = list_entry(next, struct pci_dev, bus_list);
+		pci_dev_get(dev);
+		if (dev->subordinate) {
+			/* this is a pci-pci bridge, do its devices next */
+			next = dev->subordinate->devices.next;
+			bus = dev->subordinate;
+		} else
+			next = dev->bus_list.next;
+		spin_unlock(&pci_bus_lock);
+
+		/* Run device routines with the bus unlocked */
+		cb(dev, userdata);
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
--- linux-2.6/include/linux/pci.h	2005-08-18 12:59:18.000000000 +1000
+++ test-pseries/include/linux/pci.h	2005-08-18 13:54:38.000000000 +1000
@@ -865,6 +865,9 @@
 const struct pci_device_id *pci_match_id(const struct pci_device_id *ids, struct pci_dev *dev);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
 
+void pci_walk_bus(struct pci_bus *top, void (*cb)(struct pci_dev *, void *),
+		  void *userdata);
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/dmapool.h>
