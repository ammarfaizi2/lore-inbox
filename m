Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSFDFTi>; Tue, 4 Jun 2002 01:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSFDFTe>; Tue, 4 Jun 2002 01:19:34 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:64007 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316459AbSFDFT3>;
	Tue, 4 Jun 2002 01:19:29 -0400
Date: Mon, 3 Jun 2002 22:17:04 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Kees Bakker <kees.bakker@xs4all.nl>,
        Anton Altaparmakov <aia21@cantab.net>,
        Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
Message-ID: <20020604051704.GA26058@kroah.com>
In-Reply-To: <3CFC0CC2.D69F2C57@zip.com.au> <Pine.LNX.4.33.0206031954180.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 07 May 2002 04:13:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 08:14:25PM -0700, Patrick Mochel wrote:
> 
> 	bk://ldm.bkbits.net/linux-2.5
> 
> Could people could please test it, and let me know if anything is still 
> broken?

These changesets seem to solve the USB controller problems I have been
seeing since 2.4.19, good job.

It looks like you didn't include all of the patch in your message.  I've
attached it here for those without bk to test if they want to.

Now let's talk about why you took away pci_announce_device_to_drivers()...

thanks,

greg k-h


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Mon Jun  3 22:27:50 2002
+++ b/drivers/base/core.c	Mon Jun  3 22:27:50 2002
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
--- a/drivers/base/driver.c	Mon Jun  3 22:27:50 2002
+++ b/drivers/base/driver.c	Mon Jun  3 22:27:50 2002
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
--- a/drivers/pci/pci-driver.c	Mon Jun  3 22:27:50 2002
+++ b/drivers/pci/pci-driver.c	Mon Jun  3 22:27:50 2002
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
--- a/include/linux/device.h	Mon Jun  3 22:27:50 2002
+++ b/include/linux/device.h	Mon Jun  3 22:27:50 2002
@@ -118,6 +118,7 @@
 }
 
 extern void put_driver(struct device_driver * drv);
+extern void remove_driver(struct device_driver * drv);
 
 extern int driver_for_each_dev(struct device_driver * drv, void * data, 
 			       int (*callback)(struct device * dev, void * data));
