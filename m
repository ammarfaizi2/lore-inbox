Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVDFHlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVDFHlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVDFHlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:41:11 -0400
Received: from digitalimplant.org ([64.62.235.95]:1948 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262132AbVDFHjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:39:35 -0400
Date: Wed, 6 Apr 2005 00:39:29 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0504021227440.1311-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.50.0504060032260.17888-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0504021227440.1311-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the delay in responding, there were some bugs to attend to,
some of which you may have inadvertantly caught below.

On Sat, 2 Apr 2005, Alan Stern wrote:

> I looked through the new driver model code a bit more.  There appears to
> be a few problems (unless I'm using out-of-date code).
>
> First, there's a race between adding a new device and registering a new
> driver.  The bus_add_device() routine contains these lines:
>
> 	pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
> 	device_attach(dev);
> 	klist_add_tail(&bus->klist_devices, &dev->knode_bus);
>
> Suppose device_attach() doesn't find a suitable driver, but a new driver
> is registered before the klist_add_tail() executes.  Then the new driver
> won't see the device either, and the device won't be bound at all.  The
> last two lines above should be in the opposite order.

Yes, you're right.

> Second, there's no check in driver_probe_device() or higher up to
> prevent probing a device that's already bound to another driver.  Such a
> check needs to be synchronized with assignments to dev->driver, so it
> should be made while holding dev->sem.

Yes, it should be checked while under the lock. That function is tricky,
as I've been reminded in the last couple of days. It shouldn't be public
for one, but that's cosmetic. The two callers should be holding the lock
when they call it and both check (and act appropriately) if the device is
already bound to a driver.

> Third, why does device_release_driver() call klist_del() instead of
> klist_remove() for dev->knode_driver?  Is that just a simple mistake?
> The klist_node doesn't seem to get unlinked anywhere.

It can be called from driver_for_each_device() when the driver has been
unloaded. Since that increments the reference count for the node when it's
unregistering it, klist_remove() will deadlock. Instead klist_del() is
called, and when the next node is grabbed, that one will be let go and
removed from the list.

> Fourth, in device_release_driver() why isn't most of the work done under
> the protection of dev->sem?  If a driver is unregistered at the same time
> as a device is removed, two threads could end up executing that routine at
> the same time.  Then the question would be which thread calls
> klist_remove() -- not to mention the danger that both of them might.  I
> guess the answer is to call klist_remove() after releasing dev->sem.

Yes, you're right. Also fixed. In fact, by the patch below which has just
made it into the -mm tree.

Thanks,


	Pat


Short summary:

- Move logic to driver_probe_device() and comments uncommon returns:
  1 - If device is bound
  0 - If device not bound, and no error
  error - If there was an error.

- Move locking to caller of that function, since we want to lock a
  device for the entire time we're trying to bind it to a driver (to
  prevent against a driver being loaded at the same time).

- Update __device_attach() and __driver_attach() to do that locking.

- Check if device is already bound in __driver_attach()

- Update the converse device_release_driver() so it locks the device
  around all of the operations.

- Mark driver_probe_device() as static and remove export. It's an
  internal function, it should stay that way, and there are no other
  callers. If there is ever a need to export it, we can audit it as
  necessary.

--- linux-2.6-mm/drivers/base/dd.c.orig	2005-04-05 15:01:05.000000000 -0700
+++ linux-2.6-mm/drivers/base/dd.c	2005-04-05 15:46:01.000000000 -0700
@@ -35,6 +35,8 @@
  *	nor take the bus's rwsem. Please verify those are accounted
  *	for before calling this. (It is ok to call with no other effort
  *	from a driver's probe() method.)
+ *
+ *	This function must be called with @dev->sem held.
  */

 void device_bind_driver(struct device * dev)
@@ -61,50 +63,57 @@
  *
  *	If we find a match, we call @drv->probe(@dev) if it exists, and
  *	call device_bind_driver() above.
+ *
+ *	This function returns 1 if a match is found, an error if one
+ *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
+ *
+ *	This function must be called with @dev->sem held.
  */
-int driver_probe_device(struct device_driver * drv, struct device * dev)
+static int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
-	int error = 0;
+	int ret = 0;

 	if (drv->bus->match && !drv->bus->match(dev, drv))
-		return -ENODEV;
+		goto Done;

-	down(&dev->sem);
+	pr_debug("%s: Matched Device %s with Driver %s\n",
+		 drv->bus->name, dev->bus_id, drv->name);
 	dev->driver = drv;
 	if (drv->probe) {
-		error = drv->probe(dev);
-		if (error) {
+		ret = drv->probe(dev);
+		if (ret) {
 			dev->driver = NULL;
-			up(&dev->sem);
-			return error;
+			goto ProbeFailed;
 		}
 	}
-	up(&dev->sem);
 	device_bind_driver(dev);
-	return 0;
-}
-
+	ret = 1;
+	pr_debug("%s: Bound Device %s to Driver %s\n",
+		 drv->bus->name, dev->bus_id, drv->name);
+	goto Done;

-static int __device_attach(struct device_driver * drv, void * data)
-{
-	struct device * dev = data;
-	int error;
-
-	error = driver_probe_device(drv, dev);
-
-	if (error == -ENODEV && error == -ENXIO) {
+ ProbeFailed:
+	if (ret == -ENODEV || ret == -ENXIO) {
 		/* Driver matched, but didn't support device
 		 * or device not found.
 		 * Not an error; keep going.
 		 */
-		error = 0;
+		ret = 0;
 	} else {
 		/* driver matched but the probe failed */
 		printk(KERN_WARNING
 		       "%s: probe of %s failed with error %d\n",
-		       drv->name, dev->bus_id, error);
+		       drv->name, dev->bus_id, ret);
 	}
-	return 0;
+ Done:
+	return ret;
+}
+
+
+static int __device_attach(struct device_driver * drv, void * data)
+{
+	struct device * dev = data;
+	return driver_probe_device(drv, dev);
 }

 /**
@@ -114,35 +123,44 @@
  *	Walk the list of drivers that the bus has and call
  *	driver_probe_device() for each pair. If a compatible
  *	pair is found, break out and return.
+ *
+ *	Returns 1 if the device was bound to a driver; 0 otherwise.
  */
 int device_attach(struct device * dev)
 {
+	int ret = 0;
+
+	down(&dev->sem);
 	if (dev->driver) {
 		device_bind_driver(dev);
-		return 1;
-	}
-
-	return bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
+		ret = 1;
+	} else
+		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
+	up(&dev->sem);
+	return ret;
 }


 static int __driver_attach(struct device * dev, void * data)
 {
 	struct device_driver * drv = data;
-	int error = 0;

-	if (!dev->driver) {
-		error = driver_probe_device(drv, dev);
-		if (error) {
-			if (error != -ENODEV) {
-				/* driver matched but the probe failed */
-				printk(KERN_WARNING
-				       "%s: probe of %s failed with error %d\n",
-				       drv->name, dev->bus_id, error);
-			} else
-				error = 0;
-		}
-	}
+	/*
+	 * Lock device and try to bind to it. We drop the error
+	 * here and always return 0, because we need to keep trying
+	 * to bind to devices and some drivers will return an error
+	 * simply if it didn't support the device.
+	 *
+	 * driver_probe_device() will spit a warning if there
+	 * is an error.
+	 */
+
+	down(&dev->sem);
+	if (!dev->driver)
+		driver_probe_device(drv, dev);
+	up(&dev->sem);
+
+
 	return 0;
 }

@@ -154,9 +172,6 @@
  *	match the driver with each one.  If driver_probe_device()
  *	returns 0 and the @dev->driver is set, we've found a
  *	compatible pair.
- *
- *	Note that we ignore the -ENODEV error from driver_probe_device(),
- *	since it's perfectly valid for a driver not to bind to any devices.
  */
 void driver_attach(struct device_driver * drv)
 {
@@ -176,27 +191,27 @@

 void device_release_driver(struct device * dev)
 {
-	struct device_driver * drv = dev->driver;
-
-	if (!drv)
-		return;
-
-	sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
-	sysfs_remove_link(&dev->kobj, "driver");
-	klist_del(&dev->knode_driver);
+	struct device_driver * drv;

 	down(&dev->sem);
-	device_detach_shutdown(dev);
-	if (drv->remove)
-		drv->remove(dev);
-	dev->driver = NULL;
+	if (dev->driver) {
+		drv = dev->driver;
+		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+		sysfs_remove_link(&dev->kobj, "driver");
+		klist_del(&dev->knode_driver);
+
+		device_detach_shutdown(dev);
+		if (drv->remove)
+			drv->remove(dev);
+		dev->driver = NULL;
+	}
 	up(&dev->sem);
 }


 static int __remove_driver(struct device * dev, void * unused)
 {
-	device_release_driver(dev);
+	device_release_driver(dev);
 	return 0;
 }

@@ -210,7 +225,6 @@
 	driver_for_each_device(drv, NULL, NULL, __remove_driver);
 }

-EXPORT_SYMBOL_GPL(driver_probe_device);
 EXPORT_SYMBOL_GPL(device_bind_driver);
 EXPORT_SYMBOL_GPL(device_release_driver);
 EXPORT_SYMBOL_GPL(device_attach);
--- linux-2.6-mm/include/linux/device.h.orig	2005-04-05 15:24:35.000000000 -0700
+++ linux-2.6-mm/include/linux/device.h	2005-04-05 15:24:43.000000000 -0700
@@ -330,7 +330,6 @@
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
-extern int  driver_probe_device(struct device_driver * drv, struct device * dev);
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
 extern int  device_attach(struct device * dev);
