Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSFEUsA>; Wed, 5 Jun 2002 16:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFEUr7>; Wed, 5 Jun 2002 16:47:59 -0400
Received: from air-2.osdl.org ([65.201.151.6]:30601 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316309AbSFEUr4>;
	Wed, 5 Jun 2002 16:47:56 -0400
Date: Wed, 5 Jun 2002 13:43:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with new driver model?
In-Reply-To: <1023308709.791.8.camel@diemos.microgate.com>
Message-ID: <Pine.LNX.4.33.0206051336170.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Jun 2002, Paul Fulghum wrote:

> When testing the drivers I maintain on 2.5.20, I hit the
> BUG_ON in include/linux/devices.txt:115.

There is a patch that should fix this in Linus's tree. 

If you're using bitkeeper, you can pull it from 
linux.bkbits.net/linux-2.5. 

If not, it's appended here.

	-pat

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Wed Jun  5 13:43:20 2002
+++ b/drivers/base/core.c	Wed Jun  5 13:43:20 2002
@@ -5,6 +5,8 @@
  *		 2002 Open Source Development Lab
  */
 
+#define DEBUG 0
+
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -118,9 +120,8 @@
 	return bus_for_each_dev(drv->bus,drv,do_driver_bind);
 }
 
-static int do_driver_unbind(struct device * dev, void * data)
+static int do_driver_unbind(struct device * dev, struct device_driver * drv)
 {
-	struct device_driver * drv = (struct device_driver *)data;
 	lock_device(dev);
 	if (dev->driver == drv) {
 		dev->driver = NULL;
@@ -134,7 +135,31 @@
 
 void driver_unbind(struct device_driver * drv)
 {
-	driver_for_each_dev(drv,drv,do_driver_unbind);
+	struct device * next;
+	struct device * dev = NULL;
+	struct list_head * node;
+	int error = 0;
+
+	read_lock(&drv->lock);
+	node = drv->devices.next;
+	while (node != &drv->devices) {
+		next = list_entry(node,struct device,driver_list);
+		get_device(next);
+		read_unlock(&drv->lock);
+
+		if (dev)
+			put_device(dev);
+		dev = next;
+		if ((error = do_driver_unbind(dev,drv))) {
+			put_device(dev);
+			break;
+		}
+		read_lock(&drv->lock);
+		node = dev->driver_list.next;
+	}
+	read_unlock(&drv->lock);
+	if (dev)
+		put_device(dev);
 }
 
 /**
@@ -178,8 +203,8 @@
 	}
 	spin_unlock(&device_lock);
 
-	DBG("DEV: registering device: ID = '%s', name = %s\n",
-	    dev->bus_id, dev->name);
+	pr_debug("DEV: registering device: ID = '%s', name = %s\n",
+		 dev->bus_id, dev->name);
 
 	if ((error = device_make_dir(dev)))
 		goto register_done;
@@ -212,8 +237,8 @@
 	list_del_init(&dev->g_list);
 	spin_unlock(&device_lock);
 
-	DBG("DEV: Unregistering device. ID = '%s', name = '%s'\n",
-	    dev->bus_id,dev->name);
+	pr_debug("DEV: Unregistering device. ID = '%s', name = '%s'\n",
+		 dev->bus_id,dev->name);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Wed Jun  5 13:43:20 2002
+++ b/drivers/base/driver.c	Wed Jun  5 13:43:20 2002
@@ -3,6 +3,8 @@
  *
  */
 
+#define DEBUG 0
+
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -67,6 +69,7 @@
 	get_bus(drv->bus);
 	atomic_set(&drv->refcount,2);
 	rwlock_init(&drv->lock);
+	INIT_LIST_HEAD(&drv->devices);
 	write_lock(&drv->bus->lock);
 	list_add(&drv->bus_list,&drv->bus->drivers);
 	write_unlock(&drv->bus->lock);
@@ -76,16 +79,8 @@
 	return 0;
 }
 
-/**
- * put_driver - decrement driver's refcount and clean up if necessary
- * @drv:	driver in question
- */
-void put_driver(struct device_driver * drv)
+static void __remove_driver(struct device_driver * drv)
 {
-	if (!atomic_dec_and_lock(&drv->refcount,&device_lock))
-		return;
-	spin_unlock(&device_lock);
-
 	if (drv->bus) {
 		pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
 
@@ -101,6 +96,28 @@
 		drv->release(drv);
 }
 
+void remove_driver(struct device_driver * drv)
+{
+	spin_lock(&device_lock);
+	atomic_set(&drv->refcount,0);
+	spin_unlock(&device_lock);
+	__remove_driver(drv);
+}
+
+/**
+ * put_driver - decrement driver's refcount and clean up if necessary
+ * @drv:	driver in question
+ */
+void put_driver(struct device_driver * drv)
+{
+	if (!atomic_dec_and_lock(&drv->refcount,&device_lock))
+		return;
+	spin_unlock(&device_lock);
+
+	__remove_driver(drv);
+}
+
 EXPORT_SYMBOL(driver_for_each_dev);
 EXPORT_SYMBOL(driver_register);
 EXPORT_SYMBOL(put_driver);
+EXPORT_SYMBOL(remove_driver);
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Wed Jun  5 13:43:20 2002
+++ b/drivers/pci/pci-driver.c	Wed Jun  5 13:43:20 2002
@@ -38,23 +38,35 @@
 static int pci_device_probe(struct device * dev)
 {
 	int error = 0;
+	struct pci_driver *drv;
+	struct pci_dev *pci_dev;
 
-	struct pci_driver * drv = list_entry(dev->driver,struct pci_driver,driver);
-	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	drv = list_entry(dev->driver, struct pci_driver, driver);
+	pci_dev = list_entry(dev, struct pci_dev, dev);
+
+	if (drv->probe) {
+		const struct pci_device_id *id;
 
-	if (drv->probe)
-		error = drv->probe(pci_dev,drv->id_table);
-	return error > 0 ? 0 : -ENODEV;
+		id = pci_match_device(drv->id_table, pci_dev);
+		if (id)
+			error = drv->probe(pci_dev, id);
+		if (error >= 0) {
+			pci_dev->driver = drv;
+			error = 0;
+		}
+	}
+	return error;
 }
 
 static int pci_device_remove(struct device * dev)
 {
 	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	struct pci_driver * drv = pci_dev->driver;
 
-	if (dev->driver) {
-		struct pci_driver * drv = list_entry(dev->driver,struct pci_driver,driver);
+	if (drv) {
 		if (drv->remove)
 			drv->remove(pci_dev);
+		pci_dev->driver = NULL;
 	}
 	return 0;
 }
@@ -124,7 +136,7 @@
 void
 pci_unregister_driver(struct pci_driver *drv)
 {
-	put_driver(&drv->driver);
+	remove_driver(&drv->driver);
 }
 
 static struct pci_driver pci_compat_driver = {
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Wed Jun  5 13:43:20 2002
+++ b/include/linux/device.h	Wed Jun  5 13:43:20 2002
@@ -118,6 +118,7 @@
 }
 
 extern void put_driver(struct device_driver * drv);
+extern void remove_driver(struct device_driver * drv);
 
 extern int driver_for_each_dev(struct device_driver * drv, void * data, 
 			       int (*callback)(struct device * dev, void * data));

