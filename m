Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWAEAzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWAEAzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWAEAue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:63161 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750701AbWAEAtx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:53 -0500
Cc: stern@rowland.harvard.edu
Subject: [PATCH] Hold the device's parent's lock during probe and remove
In-Reply-To: <11364221692430@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:30 -0800
Message-Id: <11364221701993@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Hold the device's parent's lock during probe and remove

This patch (as604) makes the driver core hold a device's parent's lock
as well as the device's lock during calls to the probe and remove
methods in a driver.  This facility is needed by USB device drivers,
owing to the peculiar way USB devices work:

	A device provides multiple interfaces, and drivers are bound
	to interfaces rather than to devices;

	Nevertheless a reset, reset-configuration, suspend, or resume
	affects the entire device and requires the caller to hold the
	lock for the device, not just a lock for one of the interfaces.

Since a USB driver's probe method is always called with the interface
lock held, the locking order rules (always lock parent before child)
prevent these methods from acquiring the device lock.  The solution
provided here is to call all probe and remove methods, for all devices
(not just USB), with the parent lock already acquired.

Although currently only the USB subsystem requires these changes, people
have mentioned in prior discussion that the overhead of acquiring an
extra semaphore in all the prove/remove sequences is not overly large.

Up to now, the USB core has been using its own set of private
semaphores.  A followup patch will remove them, relying entirely on the
device semaphores provided by the driver core.

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

I have not tested this patch for conflicts with other subsystems.  As
far as I can see, the only possibility of conflict would lie in the
bus_rescan_devices pathway, and it seems pretty remote.  Nevertheless,
it would be good for this to get a lot of testing in -mm.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bf74ad5bc41727d5f2f1c6bedb2c1fac394de731
tree 1e46f41550a9fe6df40fedeace23f5aff656b478
parent 6d20b035dee4300e9786c6e1cb77a765c7f9460a
author Alan Stern <stern@rowland.harvard.edu> Thu, 17 Nov 2005 16:54:12 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:08 -0800

 drivers/base/bus.c |   15 ++++++++++++++-
 drivers/base/dd.c  |   15 ++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index fa601b0..e3f915a 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
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
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3b419c9..2b90501 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
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

