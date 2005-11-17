Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVKQUEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVKQUEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVKQUEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:04:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55004 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964777AbVKQUEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:04:43 -0500
Date: Thu, 17 Nov 2005 15:04:42 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Small fixups to driver core
Message-ID: <Pine.LNX.4.44L0.0511171444400.4452-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

This patch (as603) makes a few small fixes to the driver core:

	Change spin_lock_irq for a klist lock to spin_lock;

	Fix reference count leaks;

	Minor spelling and formatting changes.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Greg, you originally write driver_bind and driver_unbind.  Shame on you
for messing up the refcounting!  :-)


Index: usb-2.6/drivers/base/bus.c
===================================================================
--- usb-2.6.orig/drivers/base/bus.c
+++ usb-2.6/drivers/base/bus.c
@@ -133,7 +133,7 @@ static struct kobj_type ktype_bus = {
 decl_subsys(bus, &ktype_bus, NULL);
 
 
-/* Manually detach a device from it's associated driver. */
+/* Manually detach a device from its associated driver. */
 static int driver_helper(struct device *dev, void *data)
 {
 	const char *name = data;
@@ -151,14 +151,13 @@ static ssize_t driver_unbind(struct devi
 	int err = -ENODEV;
 
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
-	if ((dev) &&
-	    (dev->driver == drv)) {
+	if (dev && dev->driver == drv) {
 		device_release_driver(dev);
 		err = count;
 	}
-	if (err)
-		return err;
-	return count;
+	put_device(dev);
+	put_bus(bus);
+	return err;
 }
 static DRIVER_ATTR(unbind, S_IWUSR, NULL, driver_unbind);
 
@@ -175,16 +174,14 @@ static ssize_t driver_bind(struct device
 	int err = -ENODEV;
 
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
-	if ((dev) &&
-	    (dev->driver == NULL)) {
+	if (dev && dev->driver == NULL) {
 		down(&dev->sem);
 		err = driver_probe_device(drv, dev);
 		up(&dev->sem);
-		put_device(dev);
 	}
-	if (err)
-		return err;
-	return count;
+	put_device(dev);
+	put_bus(bus);
+	return err;
 }
 static DRIVER_ATTR(bind, S_IWUSR, NULL, driver_bind);
 
Index: usb-2.6/drivers/base/dd.c
===================================================================
--- usb-2.6.orig/drivers/base/dd.c
+++ usb-2.6/drivers/base/dd.c
@@ -62,7 +62,6 @@ void device_bind_driver(struct device * 
  *	because we don't know the format of the ID structures, nor what
  *	is to be considered a match and what is not.
  *
- *
  *	This function returns 1 if a match is found, an error if one
  *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
  *
@@ -158,7 +157,6 @@ static int __driver_attach(struct device
 		driver_probe_device(drv, dev);
 	up(&dev->sem);
 
-
 	return 0;
 }
 
@@ -225,15 +223,15 @@ void driver_detach(struct device_driver 
 	struct device * dev;
 
 	for (;;) {
-		spin_lock_irq(&drv->klist_devices.k_lock);
+		spin_lock(&drv->klist_devices.k_lock);
 		if (list_empty(&drv->klist_devices.k_list)) {
-			spin_unlock_irq(&drv->klist_devices.k_lock);
+			spin_unlock(&drv->klist_devices.k_lock);
 			break;
 		}
 		dev = list_entry(drv->klist_devices.k_list.prev,
 				struct device, knode_driver.n_node);
 		get_device(dev);
-		spin_unlock_irq(&drv->klist_devices.k_lock);
+		spin_unlock(&drv->klist_devices.k_lock);
 
 		down(&dev->sem);
 		if (dev->driver == drv)

