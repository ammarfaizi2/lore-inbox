Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSFEXYu>; Wed, 5 Jun 2002 19:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSFEXYt>; Wed, 5 Jun 2002 19:24:49 -0400
Received: from air-2.osdl.org ([65.201.151.6]:395 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316545AbSFEXYn>;
	Wed, 5 Jun 2002 19:24:43 -0400
Date: Wed, 5 Jun 2002 16:20:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: device model update 1/2
Message-ID: <Pine.LNX.4.33.0206051603500.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This makes three superficial name changes:

- {device,driver}_bind becomes {device,driver}_attach
- {device,driver}_unbind becomes {device,driver}_detach
- struct bus_type::bind becomes struct bus_type::match

as encouraged by Martin Dalecki to avoid further overloading of the name 
'bind'.

Pull from bk://ldm.bkbits.net/linux-2.5 

	-pat

ChangeSet@1.455, 2002-06-05 14:43:23-07:00, mochel@osdl.org
  device model update
  s/{driver,device}_bind/{driver,device}_attach/ and s/{driver,device}_unbind/{driver,device}_detach/
  call bus's match callback instead of bind callback

 drivers/base/base.h      |    4 ++--
 drivers/base/core.c      |   36 ++++++++++++++++++------------------
 drivers/base/driver.c    |    4 ++--
 drivers/pci/pci-driver.c |    6 +++---
 include/linux/device.h   |    2 +-
 5 files changed, 26 insertions, 26 deletions


diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	Wed Jun  5 16:01:43 2002
+++ b/drivers/base/base.h	Wed Jun  5 16:01:43 2002
@@ -18,5 +18,5 @@
 
 extern int device_bus_link(struct device * dev);
 
-extern int driver_bind(struct device_driver * drv);
-extern void driver_unbind(struct device_driver * drv);
+extern int driver_attach(struct device_driver * drv);
+extern void driver_detach(struct device_driver * drv);
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Wed Jun  5 16:01:43 2002
+++ b/drivers/base/core.c	Wed Jun  5 16:01:43 2002
@@ -31,7 +31,7 @@
  * @dev:	device 
  * @drv:	driver
  *
- * We're here because the bus's bind callback returned success for this 
+ * We're here because the bus's match callback returned success for this 
  * pair. We call the driver's probe callback to verify they're really a
  * match made in heaven.
  *
@@ -67,60 +67,60 @@
 }
 
 /**
- * bind_device - try to associated device with a driver
+ * device_attach - try to associated device with a driver
  * @drv:	current driver to try
  * @data:	device in disguise
  *
  * This function is used as a callback to bus_for_each_drv.
- * It calls the bus's ::bind callback to check if the driver supports
+ * It calls the bus's match callback to check if the driver supports
  * the device. If so, it calls the found_match() function above to 
  * take care of all the details.
  */
-static int do_device_bind(struct device_driver * drv, void * data)
+static int do_device_attach(struct device_driver * drv, void * data)
 {
 	struct device * dev = (struct device *)data;
 	int error = 0;
 
 	if (!dev->driver) {
-		if (drv->bus->bind && drv->bus->bind(dev,drv))
+		if (drv->bus->match && drv->bus->match(dev,drv))
 			error = found_match(dev,drv);
 	}
 	return error;
 }
 
-static int device_bind(struct device * dev)
+static int device_attach(struct device * dev)
 {
 	int error = 0;
 	if (dev->bus)
-		error = bus_for_each_drv(dev->bus,dev,do_device_bind);
+		error = bus_for_each_drv(dev->bus,dev,do_device_attach);
 	return error;
 }
 
-static void device_unbind(struct device * dev)
+static void device_detach(struct device * dev)
 {
-	/* unbind from driver */
+	/* detach from driver */
 	if (dev->driver && dev->driver->remove)
 		dev->driver->remove(dev);
 }
 
-static int do_driver_bind(struct device * dev, void * data)
+static int do_driver_attach(struct device * dev, void * data)
 {
 	struct device_driver * drv = (struct device_driver *)data;
 	int error = 0;
 
 	if (!dev->driver) {
-		if (dev->bus->bind && dev->bus->bind(dev,drv))
+		if (dev->bus->match && dev->bus->match(dev,drv))
 			error = found_match(dev,drv);
 	}
 	return error;
 }
 
-int driver_bind(struct device_driver * drv)
+int driver_attach(struct device_driver * drv)
 {
-	return bus_for_each_dev(drv->bus,drv,do_driver_bind);
+	return bus_for_each_dev(drv->bus,drv,do_driver_attach);
 }
 
-static int do_driver_unbind(struct device * dev, struct device_driver * drv)
+static int do_driver_detach(struct device * dev, struct device_driver * drv)
 {
 	lock_device(dev);
 	if (dev->driver == drv) {
@@ -133,7 +133,7 @@
 	return 0;
 }
 
-void driver_unbind(struct device_driver * drv)
+void driver_detach(struct device_driver * drv)
 {
 	struct device * next;
 	struct device * dev = NULL;
@@ -150,7 +150,7 @@
 		if (dev)
 			put_device(dev);
 		dev = next;
-		if ((error = do_driver_unbind(dev,drv))) {
+		if ((error = do_driver_detach(dev,drv))) {
 			put_device(dev);
 			break;
 		}
@@ -212,7 +212,7 @@
 	bus_add_device(dev);
 
 	/* bind to driver */
-	device_bind(dev);
+	device_attach(dev);
 
 	/* notify platform of device entry */
 	if (platform_notify)
@@ -246,7 +246,7 @@
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
 
-	device_unbind(dev);
+	device_detach(dev);
 	bus_remove_device(dev);
 
 	/* remove the driverfs directory */
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Wed Jun  5 16:01:43 2002
+++ b/drivers/base/driver.c	Wed Jun  5 16:01:43 2002
@@ -74,7 +74,7 @@
 	list_add(&drv->bus_list,&drv->bus->drivers);
 	write_unlock(&drv->bus->lock);
 	driver_make_dir(drv);
-	driver_bind(drv);
+	driver_attach(drv);
 	put_driver(drv);
 	return 0;
 }
@@ -84,7 +84,7 @@
 	if (drv->bus) {
 		pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
 
-		driver_unbind(drv);
+		driver_detach(drv);
 		write_lock(&drv->bus->lock);
 		list_del_init(&drv->bus_list);
 		write_unlock(&drv->bus->lock);
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Wed Jun  5 16:01:43 2002
+++ b/drivers/pci/pci-driver.c	Wed Jun  5 16:01:43 2002
@@ -165,7 +165,7 @@
 }
 
 /**
- * pci_bus_bind - Tell if a PCI device structure has a matching PCI device id structure
+ * pci_bus_match - Tell if a PCI device structure has a matching PCI device id structure
  * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
  * 
@@ -173,7 +173,7 @@
  * system is in its list of supported devices.Returns the matching
  * pci_device_id structure or %NULL if there is no match.
  */
-static int pci_bus_bind(struct device * dev, struct device_driver * drv) 
+static int pci_bus_match(struct device * dev, struct device_driver * drv) 
 {
 	struct pci_dev * pci_dev = list_entry(dev, struct pci_dev, dev);
 	struct pci_driver * pci_drv = list_entry(drv,struct pci_driver,driver);
@@ -196,7 +196,7 @@
 
 struct bus_type pci_bus_type = {
 	name:	"pci",
-	bind:	pci_bus_bind,
+	match:	pci_bus_match,
 };
 
 static int __init pci_driver_init(void)
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Wed Jun  5 16:01:43 2002
+++ b/include/linux/device.h	Wed Jun  5 16:01:43 2002
@@ -64,7 +64,7 @@
 	struct driver_dir_entry	device_dir;
 	struct driver_dir_entry	driver_dir;
 
-	int	(*bind)		(struct device * dev, struct device_driver * drv);
+	int	(*match)	(struct device * dev, struct device_driver * drv);
 };
 
 

