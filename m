Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTEVVvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTEVVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:51:05 -0400
Received: from granite.he.net ([216.218.226.66]:42763 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263309AbTEVVu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:50:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10536411602454@kroah.com>
Subject: Re: [PATCH] PCI changes for 2.5.69
In-Reply-To: <10536411604060@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 22 May 2003 15:06:01 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1210, 2003/05/22 10:30:35-07:00, greg@kroah.com

PCI: add pci_get_dev() and pci_put_dev()

Move the PCI core to start using these, enabling proper reference counting
on struct pci_dev.


 drivers/pci/bus.c        |    2 +-
 drivers/pci/hotplug.c    |    2 +-
 drivers/pci/pci-driver.c |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c      |   18 ++++++++++++++++++
 include/linux/pci.h      |    2 ++
 5 files changed, 63 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Thu May 22 14:50:44 2003
+++ b/drivers/pci/bus.c	Thu May 22 14:50:44 2003
@@ -92,7 +92,7 @@
 		if (!list_empty(&dev->global_list))
 			continue;
 
-		device_register(&dev->dev);
+		device_add(&dev->dev);
 		list_add_tail(&dev->global_list, &pci_devices);
 #ifdef CONFIG_PROC_FS
 		pci_proc_attach_device(dev);
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Thu May 22 14:50:44 2003
+++ b/drivers/pci/hotplug.c	Thu May 22 14:50:44 2003
@@ -275,7 +275,7 @@
 	pci_proc_detach_device(dev);
 #endif
 
-	kfree(dev);
+	pci_put_dev(dev);
 }
 
 /**
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu May 22 14:50:44 2003
+++ b/drivers/pci/pci-driver.c	Thu May 22 14:50:44 2003
@@ -199,6 +199,45 @@
 	return 0;
 }
 
+/**
+ * pci_get_dev - increments the reference count of the pci device structure
+ * @dev: the device being referenced
+ *
+ * Each live reference to a device should be refcounted.
+ *
+ * Drivers for PCI devices should normally record such references in
+ * their probe() methods, when they bind to a device, and release
+ * them by calling pci_put_dev(), in their disconnect() methods.
+ *
+ * A pointer to the device with the incremented reference counter is returned.
+ */
+struct pci_dev *pci_get_dev (struct pci_dev *dev)
+{
+	struct device *tmp;
+
+	if (!dev)
+		return NULL;
+
+	tmp = get_device(&dev->dev);
+	if (tmp)        
+		return to_pci_dev(tmp);
+	else
+		return NULL;
+}
+
+/**
+ * pci_put_dev - release a use of the pci device structure
+ * @dev: device that's been disconnected
+ *
+ * Must be called when a user of a device is finished with it.  When the last
+ * user of the device calls this function, the memory of the device is freed.
+ */
+void pci_put_dev(struct pci_dev *dev)
+{
+	if (dev)
+		put_device(&dev->dev);
+}
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -217,3 +256,5 @@
 EXPORT_SYMBOL(pci_unregister_driver);
 EXPORT_SYMBOL(pci_dev_driver);
 EXPORT_SYMBOL(pci_bus_type);
+EXPORT_SYMBOL(pci_get_dev);
+EXPORT_SYMBOL(pci_put_dev);
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu May 22 14:50:44 2003
+++ b/drivers/pci/probe.c	Thu May 22 14:50:44 2003
@@ -462,6 +462,21 @@
 	return 0;
 }
 
+/**
+ * pci_release_dev - free a pci device structure when all users of it are finished.
+ * @dev: device that's been disconnected
+ *
+ * Will be called only by the device core when all users of this pci device are
+ * done.
+ */
+static void pci_release_dev(struct device *dev)
+{
+	struct pci_dev *pci_dev;
+
+	pci_dev = to_pci_dev(dev);
+	kfree(pci_dev);
+}
+
 /*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
@@ -506,6 +521,9 @@
 		kfree(dev);
 		return NULL;
 	}
+	device_initialize(&dev->dev);
+	dev->dev.release = pci_release_dev;
+	pci_get_dev(dev);
 
 	pci_name_device(dev);
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu May 22 14:50:44 2003
+++ b/include/linux/pci.h	Thu May 22 14:50:44 2003
@@ -556,6 +556,8 @@
 struct resource *pci_find_parent_resource(const struct pci_dev *dev, struct resource *res);
 int pci_setup_device(struct pci_dev *dev);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
+extern struct pci_dev *pci_get_dev(struct pci_dev *dev);
+extern void pci_put_dev(struct pci_dev *dev);
 
 /* Generic PCI functions exported to card drivers */
 

