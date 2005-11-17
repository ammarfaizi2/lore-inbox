Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbVKQVyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbVKQVyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVKQVyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:54:14 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:58070 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751506AbVKQVyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:54:13 -0500
Date: Thu, 17 Nov 2005 16:54:12 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@digitalimplant.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Hold the device's parent's lock during probe and remove
Message-ID: <Pine.LNX.4.44L0.0511171633150.4465-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

This patch (as604) makes the driver core hold a device's parent's lock as 
well as the device's lock during calls to the probe and remove methods in 
a driver.  This facility is needed by USB device drivers, owing to the 
peculiar way USB devices work:

	A device provides multiple interfaces, and drivers are bound
	to interfaces rather than to devices;

	Nevertheless a reset, reset-configuration, suspend, or resume
	affects the entire device and requires the caller to hold the
	lock for the device, not just a lock for one of the interfaces.

Since a USB driver's probe method is always called with the interface lock
held, the locking order rules (always lock parent before child) prevent
these methods from acquiring the device lock.  The solution provided here
is to call all probe and remove methods, for all devices (not just USB),
with the parent lock already acquired.

Although currently only the USB subsystem requires these changes, people 
have mentioned in prior discussion that the overhead of acquiring an extra 
semaphore in all the prove/remove sequences is not overly large.

Up to now, the USB core has been using its own set of private semaphores.  
A followup patch will remove them, relying entirely on the device
semaphores provided by the driver core.

The code paths affected by this patch are:

	device_add and device_del: The USB core already holds the parent
	lock, so no actual change is needed.

	driver_register and driver_unregister: The driver core will now
	lock both the parent and the device before probing or removing.

	driver_bind and driver_unbind (in sysfs): These routines will
	now lock both the parent and the device before binding or
	unbinding.

	bus_rescan_devices: The helper routine will lock the parent
	before probing a device.

I have not tested this patch for conflicts with other subsystems.  As far 
as I can see, the only possibility of conflict would lie in the 
bus_rescan_devices pathway, and it seems pretty remote.  Nevertheless, it 
would be good for this to get a lot of testing in -mm.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/dd.c
===================================================================
--- usb-2.6.orig/drivers/base/dd.c
+++ usb-2.6/drivers/base/dd.c
@@ -65,7 +65,8 @@ void device_bind_driver(struct device * 
  *	This function returns 1 if a match is found, an error if one
  *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
  *
- *	This function must be called with @dev->sem held.
+ *	This function must be called with @dev->sem held.  When called
+ *	for a USB interface, @dev->parent->sem must be held as well.
  */
 int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
@@ -123,6 +124,8 @@ static int __device_attach(struct device
  *
  *	Returns 1 if the device was bound to a driver;
  *	0 if no matching device was found; error code otherwise.
+ *
+ *	When called for a USB interface, @dev->parent->sem must be held.
  */
 int device_attach(struct device * dev)
 {
@@ -152,10 +155,14 @@ static int __driver_attach(struct device
 	 * is an error.
 	 */
 
+	if (dev->parent)	/* Needed for USB */
+		down(&dev->parent->sem);
 	down(&dev->sem);
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
 	up(&dev->sem);
+	if (dev->parent)
+		up(&dev->parent->sem);
 
 	return 0;
 }
@@ -181,6 +188,8 @@ void driver_attach(struct device_driver 
  *	Manually detach device from driver.
  *
  *	__device_release_driver() must be called with @dev->sem held.
+ *	When called for a USB interface, @dev->parent->sem must be held
+ *	as well.
  */
 
 static void __device_release_driver(struct device * dev)
@@ -233,10 +242,14 @@ void driver_detach(struct device_driver 
 		get_device(dev);
 		spin_unlock(&drv->klist_devices.k_lock);
 
+		if (dev->parent)	/* Needed for USB */
+			down(&dev->parent->sem);
 		down(&dev->sem);
 		if (dev->driver == drv)
 			__device_release_driver(dev);
 		up(&dev->sem);
+		if (dev->parent)
+			up(&dev->parent->sem);
 		put_device(dev);
 	}
 }
Index: usb-2.6/drivers/base/bus.c
===================================================================
--- usb-2.6.orig/drivers/base/bus.c
+++ usb-2.6/drivers/base/bus.c
@@ -152,7 +152,11 @@ static ssize_t driver_unbind(struct devi
 
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
 	if (dev && dev->driver == drv) {
+		if (dev->parent)	/* Needed for USB */
+			down(&dev->parent->sem);
 		device_release_driver(dev);
+		if (dev->parent)
+			up(&dev->parent->sem);
 		err = count;
 	}
 	put_device(dev);
@@ -175,9 +179,13 @@ static ssize_t driver_bind(struct device
 
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
 	if (dev && dev->driver == NULL) {
+		if (dev->parent)	/* Needed for USB */
+			down(&dev->parent->sem);
 		down(&dev->sem);
 		err = driver_probe_device(drv, dev);
 		up(&dev->sem);
+		if (dev->parent)
+			up(&dev->parent->sem);
 	}
 	put_device(dev);
 	put_bus(bus);
@@ -484,8 +492,13 @@ void bus_remove_driver(struct device_dri
 /* Helper for bus_rescan_devices's iter */
 static int bus_rescan_devices_helper(struct device *dev, void *data)
 {
-	if (!dev->driver)
+	if (!dev->driver) {
+		if (dev->parent)	/* Needed for USB */
+			down(&dev->parent->sem);
 		device_attach(dev);
+		if (dev->parent)
+			up(&dev->parent->sem);
+	}
 	return 0;
 }
 

