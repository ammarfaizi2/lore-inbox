Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTFSXcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTFSXar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:30:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:11908 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261985AbTFSXZt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:25:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1056065973528@kroah.com>
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
In-Reply-To: <10560659723370@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jun 2003 16:39:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1363, 2003/06/19 16:14:18-07:00, greg@kroah.com

[PATCH] PCI: rename pci_get_dev() and pci_put_dev() to pci_dev_get() and pci_dev_put()

This makes things more consistant with the other get and put functions in the
driver code.


 drivers/pci/hotplug.c    |    2 +-
 drivers/pci/pci-driver.c |   20 ++++++++++----------
 drivers/pci/probe.c      |    2 +-
 drivers/pci/proc.c       |    4 ++--
 drivers/pci/search.c     |    4 ++--
 include/linux/pci.h      |    4 ++--
 6 files changed, 18 insertions(+), 18 deletions(-)


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Thu Jun 19 16:31:54 2003
+++ b/drivers/pci/hotplug.c	Thu Jun 19 16:31:54 2003
@@ -188,7 +188,7 @@
 	spin_unlock(&pci_bus_lock);
 
 	pci_free_resources(dev);
-	pci_put_dev(dev);
+	pci_dev_put(dev);
 }
 
 /**
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu Jun 19 16:31:54 2003
+++ b/drivers/pci/pci-driver.c	Thu Jun 19 16:31:54 2003
@@ -138,10 +138,10 @@
 
 	drv = to_pci_driver(dev->driver);
 	pci_dev = to_pci_dev(dev);
-	pci_get_dev(pci_dev);
+	pci_dev_get(pci_dev);
 	error = __pci_device_probe(drv, pci_dev);
 	if (error)
-		pci_put_dev(pci_dev);
+		pci_dev_put(pci_dev);
 
 	return error;
 }
@@ -156,7 +156,7 @@
 			drv->remove(pci_dev);
 		pci_dev->driver = NULL;
 	}
-	pci_put_dev(pci_dev);
+	pci_dev_put(pci_dev);
 	return 0;
 }
 
@@ -448,18 +448,18 @@
 }
 
 /**
- * pci_get_dev - increments the reference count of the pci device structure
+ * pci_dev_get - increments the reference count of the pci device structure
  * @dev: the device being referenced
  *
  * Each live reference to a device should be refcounted.
  *
  * Drivers for PCI devices should normally record such references in
  * their probe() methods, when they bind to a device, and release
- * them by calling pci_put_dev(), in their disconnect() methods.
+ * them by calling pci_dev_put(), in their disconnect() methods.
  *
  * A pointer to the device with the incremented reference counter is returned.
  */
-struct pci_dev *pci_get_dev (struct pci_dev *dev)
+struct pci_dev *pci_dev_get(struct pci_dev *dev)
 {
 	struct device *tmp;
 
@@ -474,13 +474,13 @@
 }
 
 /**
- * pci_put_dev - release a use of the pci device structure
+ * pci_dev_put - release a use of the pci device structure
  * @dev: device that's been disconnected
  *
  * Must be called when a user of a device is finished with it.  When the last
  * user of the device calls this function, the memory of the device is freed.
  */
-void pci_put_dev(struct pci_dev *dev)
+void pci_dev_put(struct pci_dev *dev)
 {
 	if (dev)
 		put_device(&dev->dev);
@@ -504,5 +504,5 @@
 EXPORT_SYMBOL(pci_unregister_driver);
 EXPORT_SYMBOL(pci_dev_driver);
 EXPORT_SYMBOL(pci_bus_type);
-EXPORT_SYMBOL(pci_get_dev);
-EXPORT_SYMBOL(pci_put_dev);
+EXPORT_SYMBOL(pci_dev_get);
+EXPORT_SYMBOL(pci_dev_put);
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jun 19 16:31:54 2003
+++ b/drivers/pci/probe.c	Thu Jun 19 16:31:54 2003
@@ -524,7 +524,7 @@
 	}
 	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
-	pci_get_dev(dev);
+	pci_dev_get(dev);
 
 	pci_name_device(dev);
 
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Thu Jun 19 16:31:54 2003
+++ b/drivers/pci/proc.c	Thu Jun 19 16:31:54 2003
@@ -334,7 +334,7 @@
 {
 	if (v) {
 		struct pci_dev *dev = v;
-		pci_put_dev(dev);
+		pci_dev_put(dev);
 	}
 }
 
@@ -471,7 +471,7 @@
 	first_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
 	if (dev == first_dev)
 		seq_puts(m, "PCI devices found:\n");
-	pci_put_dev(first_dev);
+	pci_dev_put(first_dev);
 
 	drv = pci_dev_driver(dev);
 
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jun 19 16:31:54 2003
+++ b/drivers/pci/search.c	Thu Jun 19 16:31:54 2003
@@ -205,8 +205,8 @@
 	}
 	dev = NULL;
 exit:
-	pci_put_dev(from);
-	dev = pci_get_dev(dev);
+	pci_dev_put(from);
+	dev = pci_dev_get(dev);
 	spin_unlock(&pci_bus_lock);
 	return dev;
 }
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun 19 16:31:54 2003
+++ b/include/linux/pci.h	Thu Jun 19 16:31:54 2003
@@ -556,8 +556,8 @@
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev, struct resource *res);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
-extern struct pci_dev *pci_get_dev(struct pci_dev *dev);
-extern void pci_put_dev(struct pci_dev *dev);
+extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
+extern void pci_dev_put(struct pci_dev *dev);
 
 extern void pci_remove_bus_device(struct pci_dev *dev);
 

