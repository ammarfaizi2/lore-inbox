Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVEFTjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVEFTjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVEFTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 15:39:23 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:1408 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261279AbVEFTik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 15:38:40 -0400
Date: Fri, 6 May 2005 15:38:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Roman Kagan <rkagan@mail.ru>, Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH as517] driver core: Fix races in driver_detach()
Message-ID: <Pine.LNX.4.44L0.0505041630210.5392-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

This patch is intended for your "driver" tree.  It fixes several subtle
races in driver_detach() and device_release_driver() in the driver-model 
core.

The major change is to use klist_remove() rather than klist_del() when
taking a device off its driver's list.  There's no other way to guarantee
that the list pointers will be updated before some other driver binds to
the device.  For this to work driver_detach() can't use a klist iterator,
so the loop over the devices must be written out in full.  In addition the
patch protects against the possibility that, when a driver and a device
are unregistered at the same time, one may be unloaded from memory before
the other is finished using it.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: driver-2.6/drivers/base/dd.c
===================================================================
--- driver-2.6.orig/drivers/base/dd.c
+++ driver-2.6/drivers/base/dd.c
@@ -184,44 +184,67 @@ void driver_attach(struct device_driver 
  *	@dev:	device.
  *
  *	Manually detach device from driver.
- *	Note that this is called without incrementing the bus
- *	reference count nor taking the bus's rwsem. Be sure that
- *	those are accounted for before calling this function.
+ *
+ *	__device_release_driver() must be called with @dev->sem held.
  */
 
-void device_release_driver(struct device * dev)
+static void __device_release_driver(struct device * dev)
 {
 	struct device_driver * drv;
 
-	down(&dev->sem);
-	if (dev->driver) {
-		drv = dev->driver;
+	drv = dev->driver;
+	if (drv) {
+		get_driver(drv);
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
-		klist_del(&dev->knode_driver);
+		klist_remove(&dev->knode_driver);
 
 		device_detach_shutdown(dev);
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
+		put_driver(drv);
 	}
-	up(&dev->sem);
 }
 
-
-static int __remove_driver(struct device * dev, void * unused)
+void device_release_driver(struct device * dev)
 {
-	device_release_driver(dev);
-	return 0;
+	/*
+	 * If anyone calls device_release_driver() recursively from
+	 * within their ->remove callback for the same device, they
+	 * will deadlock right here.
+	 */
+	down(&dev->sem);
+	__device_release_driver(dev);
+	up(&dev->sem);
 }
 
+
 /**
  * driver_detach - detach driver from all devices it controls.
  * @drv: driver.
  */
 void driver_detach(struct device_driver * drv)
 {
-	driver_for_each_device(drv, NULL, NULL, __remove_driver);
+	struct device * dev;
+
+	for (;;) {
+		spin_lock_irq(&drv->klist_devices.k_lock);
+		if (list_empty(&drv->klist_devices.k_list)) {
+			spin_unlock_irq(&drv->klist_devices.k_lock);
+			break;
+		}
+		dev = list_entry(drv->klist_devices.k_list.prev,
+				struct device, knode_driver.n_node);
+		get_device(dev);
+		spin_unlock_irq(&drv->klist_devices.k_lock);
+
+		down(&dev->sem);
+		if (dev->driver == drv)
+			__device_release_driver(dev);
+		up(&dev->sem);
+		put_device(dev);
+	}
 }
 
 

