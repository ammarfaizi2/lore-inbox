Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbUKLXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUKLXor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUKLXn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:43:57 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:63224 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262706AbUKLXWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:54 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301717571@kroah.com>
Date: Fri, 12 Nov 2004 15:21:58 -0800
Message-Id: <11003017181402@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.2, 2004/11/11 16:32:25-08:00, jdittmer@ppp0.net

[PATCH] fakephp: introduce pci_bus_add_device

fakephp needs to add newly discovered devices to the global pci list.
Therefore seperate out the appropriate chunk from pci_bus_add_devices
to pci_bus_add_device to add a single device to sysfs, procfs
and the global device list.

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/bus.c   |   31 +++++++++++++++++++++----------
 include/linux/pci.h |    1 +
 2 files changed, 22 insertions(+), 10 deletions(-)


diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	2004-11-12 15:11:49 -08:00
+++ b/drivers/pci/bus.c	2004-11-12 15:11:49 -08:00
@@ -69,6 +69,25 @@
 }
 
 /**
+ * add a single device
+ * @dev: device to add
+ *
+ * This adds a single pci device to the global
+ * device list and adds sysfs and procfs entries
+ */
+void __devinit pci_bus_add_device(struct pci_dev *dev)
+{
+	device_add(&dev->dev);
+
+	spin_lock(&pci_bus_lock);
+	list_add_tail(&dev->global_list, &pci_devices);
+	spin_unlock(&pci_bus_lock);
+
+	pci_proc_attach_device(dev);
+	pci_create_sysfs_dev_files(dev);
+}
+
+/**
  * pci_bus_add_devices - insert newly discovered PCI devices
  * @bus: bus to check for new devices
  *
@@ -91,16 +110,7 @@
 		 */
 		if (!list_empty(&dev->global_list))
 			continue;
-
-		device_add(&dev->dev);
-
-		spin_lock(&pci_bus_lock);
-		list_add_tail(&dev->global_list, &pci_devices);
-		spin_unlock(&pci_bus_lock);
-
-		pci_proc_attach_device(dev);
-		pci_create_sysfs_dev_files(dev);
-
+		pci_bus_add_device(dev);
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -136,5 +146,6 @@
 }
 
 EXPORT_SYMBOL(pci_bus_alloc_resource);
+EXPORT_SYMBOL_GPL(pci_bus_add_device);
 EXPORT_SYMBOL(pci_bus_add_devices);
 EXPORT_SYMBOL(pci_enable_bridges);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-11-12 15:11:49 -08:00
+++ b/include/linux/pci.h	2004-11-12 15:11:49 -08:00
@@ -715,6 +715,7 @@
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev * pci_scan_single_device(struct pci_bus *bus, int devfn);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
+void pci_bus_add_device(struct pci_dev *dev);
 void pci_bus_add_devices(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);

