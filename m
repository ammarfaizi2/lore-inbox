Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422940AbWBAV2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422940AbWBAV2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBAV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:28:50 -0500
Received: from rigel.cs.pdx.edu ([131.252.208.59]:39312 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id S932461AbWBAV2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:28:49 -0500
Date: Wed, 1 Feb 2006 13:27:43 -0800
From: Kristen Carlson Accardi <kristenc@cs.pdx.edu>
To: pcihp-discuss@lists.sourceforge.net
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       muneda.takahiro@jp.fujitsu.com, linux-acpi@vger.kernel.org
Subject: [patch] acpiphp: add new bus to acpi
Message-ID: <20060201212743.GB27247@nerpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: kristen.c.accardi@intel.com

If we add a new bridge with subordinate busses, we should call make sure
that acpi is notified so that the PRT (if present) can be read and drivers
who have registered on this bus will be notified when it is started.
Also make sure to use the max reservered bus number for the starting the bus
scan.
 
 
 Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
I broke this out of the dock patches because it is applicable to more
than just docking stations.

 drivers/pci/hotplug/acpiphp_glue.c |  106 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_glue.c
@@ -751,6 +751,101 @@ static int power_off_slot(struct acpiphp
 }
 
 
+
+/**
+ * acpiphp_max_busnr - return the highest reserved bus number under
+ * the given bus.
+ * @bus: bus to start search with
+ *
+ */
+static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
+{
+	struct list_head *tmp;
+	unsigned char max, n;
+
+	/*
+	 * pci_bus_max_busnr will return the highest
+	 * reserved busnr for all these children.
+	 * that is equivalent to the bus->subordinate
+	 * value.  We don't want to use the parent's
+	 * bus->subordinate value because it could have
+	 * padding in it.
+	 */
+	max = bus->secondary;
+
+	list_for_each(tmp, &bus->children) {
+		n = pci_bus_max_busnr(pci_bus_b(tmp));
+		if (n > max)
+			max = n;
+	}
+	return max;
+}
+
+
+
+/**
+ *  get_func - get a pointer to acpiphp_func given a slot, device
+ *  @slot: slot to search
+ *  @dev:  pci_dev struct to match.
+ *
+ *  This function will increase the reference count of pci_dev,
+ *  so callers should call pci_dev_put when complete.
+ *
+ */
+static struct acpiphp_func *
+get_func(struct acpiphp_slot *slot, struct pci_dev *dev)
+{
+	struct acpiphp_func *func = NULL;
+	struct pci_bus *bus = slot->bridge->pci_bus;
+	struct pci_dev *pdev;
+
+	list_for_each_entry(func, &slot->funcs, sibling) {
+		pdev = pci_get_slot(bus, PCI_DEVFN(slot->device,
+					func->function));
+		if (pdev) {
+			if (pdev == dev)
+				break;
+			pci_dev_put(pdev);
+		}
+	}
+	return func;
+}
+
+
+/**
+ * acpiphp_bus_add - add a new bus to acpi subsystem
+ * @func: acpiphp_func of the bridge
+ *
+ */
+static int acpiphp_bus_add(struct acpiphp_func *func)
+{
+	acpi_handle phandle;
+	struct acpi_device *device, *pdevice;
+	int ret_val;
+
+	acpi_get_parent(func->handle, &phandle);
+	if (acpi_bus_get_device(phandle, &pdevice)) {
+		dbg("no parent device, assuming NULL\n");
+		pdevice = NULL;
+	}
+	ret_val = acpi_bus_add(&device, pdevice, func->handle,
+			ACPI_BUS_TYPE_DEVICE);
+	if (ret_val)
+		dbg("cannot add bridge to acpi list\n");
+
+	/*
+	 * try to start anyway.  We could have failed to add
+	 * simply because this bus had previously been added
+	 * on another add.  Don't bother with the return value
+	 * we just keep going.
+	 */
+	ret_val = acpi_bus_start(device);
+
+	return ret_val;
+}
+
+
+
 /**
  * enable_device - enable, configure a slot
  * @slot: slot to be enabled
@@ -788,7 +883,7 @@ static int enable_device(struct acpiphp_
 		goto err_exit;
 	}
 
-	max = bus->secondary;
+	max = acpiphp_max_busnr(bus);
 	for (pass = 0; pass < 2; pass++) {
 		list_for_each_entry(dev, &bus->devices, bus_list) {
 			if (PCI_SLOT(dev->devfn) != slot->device)
@@ -796,8 +891,15 @@ static int enable_device(struct acpiphp_
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 				max = pci_scan_bridge(bus, dev, max, pass);
-				if (pass && dev->subordinate)
+				if (pass && dev->subordinate) {
 					pci_bus_size_bridges(dev->subordinate);
+					func = get_func(slot, dev);
+					if (func) {
+						acpiphp_bus_add(func);
+						/* side effect of get_func */
+						pci_dev_put(dev);
+					}
+				}
 			}
 		}
 	}

