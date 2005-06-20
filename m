Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVFUCp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVFUCp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVFUCpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:45:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:23524 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261684AbVFTW7n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:43 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Driver Core: fix bk-driver-core kills ppc64
In-Reply-To: <1119308366638@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <11193083672817@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: fix bk-driver-core kills ppc64

There's no check to see if the device is already bound to a driver, which
could do bad things.  The first thing to go wrong is that it will try to match
a driver with a device already bound to one.  In some cases (it appears with
USB with drivers/usb/core/usb.c::usb_match_id()), some drivers will match a
device based on the class type, so it would be common (especially for HID
devices) to match a device that is already bound.

The fun comes when ->probe() is called, it fails, then
driver_probe_device() does this:

	dev->driver = NULL;

Later on, that pointer could be be dereferenced without checking and cause
hell to break loose.

This problem could be nasty. It's very hardware dependent, since some
devices could have a different set of matching qualifiers than others.

Now, I don't quite see exactly where/how you were getting that crash.
You're dereferencing bad memory, but I'm not sure which pointer was bad
and where it came from, but it could have come from a couple of different
places.

The patch below will hopefully fix it all up for you. It's against
2.6.12-rc2-mm1, and does the following:

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

Signed-off-by: Andrew Morton <akpm@osdl.org>

---
commit 0d3e5a2e39b6ba2974e9e7c2a429018c45de8e76
tree 30e584b73c356adce49dcc9df75332abaef95470
parent b86c1df1f98d16c999423a3907eb40a9423f481e
author Patrick Mochel <mochel@digitalimplant.org> Tue, 05 Apr 2005 23:46:33 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:27 -0700

 drivers/base/dd.c      |  140 +++++++++++++++++++++++++-----------------------
 include/linux/device.h |    1 
 2 files changed, 73 insertions(+), 68 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -35,6 +35,8 @@
  *	nor take the bus's rwsem. Please verify those are accounted
  *	for before calling this. (It is ok to call with no other effort
  *	from a driver's probe() method.)
+ *
+ *	This function must be called with @dev->sem held.
  */
 void device_bind_driver(struct device * dev)
 {
@@ -57,54 +59,56 @@ void device_bind_driver(struct device * 
  *	because we don't know the format of the ID structures, nor what
  *	is to be considered a match and what is not.
  *
- *	If we find a match, we call @drv->probe(@dev) if it exists, and
- *	call device_bind_driver() above.
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
+	ret = 1;
+	pr_debug("%s: Bound Device %s to Driver %s\n",
+		 drv->bus->name, dev->bus_id, drv->name);
+	goto Done;
+
+ ProbeFailed:
+	if (ret == -ENODEV || ret == -ENXIO) {
+		/* Driver matched, but didn't support device
+		 * or device not found.
+		 * Not an error; keep going.
+		 */
+		ret = 0;
+	} else {
+		/* driver matched but the probe failed */
+		printk(KERN_WARNING
+		       "%s: probe of %s failed with error %d\n",
+		       drv->name, dev->bus_id, ret);
+	}
+ Done:
+	return ret;
 }
 
 static int __device_attach(struct device_driver * drv, void * data)
 {
 	struct device * dev = data;
-	int error;
-
-	error = driver_probe_device(drv, dev);
-	if (error) {
-		if ((error == -ENODEV) || (error == -ENXIO)) {
-			/* Driver matched, but didn't support device
-			 * or device not found.
-			 * Not an error; keep going.
-			 */
-			error = 0;
-		} else {
-			/* driver matched but the probe failed */
-			printk(KERN_WARNING
-			       "%s: probe of %s failed with error %d\n",
-			       drv->name, dev->bus_id, error);
-		}
-		return error;
-	}
-	/* stop looking, this device is attached */
-	return 1;
+	return driver_probe_device(drv, dev);
 }
 
 /**
@@ -114,37 +118,43 @@ static int __device_attach(struct device
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
-			return error;
-		}
-		/* stop looking, this driver is attached */
-		return 1;
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
 
@@ -156,9 +166,6 @@ static int __driver_attach(struct device
  *	match the driver with each one.  If driver_probe_device()
  *	returns 0 and the @dev->driver is set, we've found a
  *	compatible pair.
- *
- *	Note that we ignore the -ENODEV error from driver_probe_device(),
- *	since it's perfectly valid for a driver not to bind to any devices.
  */
 void driver_attach(struct device_driver * drv)
 {
@@ -176,19 +183,19 @@ void driver_attach(struct device_driver 
  */
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
-	if (drv->remove)
-		drv->remove(dev);
-	dev->driver = NULL;
+	if (dev->driver) {
+		drv = dev->driver;
+		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+		sysfs_remove_link(&dev->kobj, "driver");
+		klist_del(&dev->knode_driver);
+
+		if (drv->remove)
+			drv->remove(dev);
+		dev->driver = NULL;
+	}
 	up(&dev->sem);
 }
 
@@ -208,7 +215,6 @@ void driver_detach(struct device_driver 
 }
 
 
-EXPORT_SYMBOL_GPL(driver_probe_device);
 EXPORT_SYMBOL_GPL(device_bind_driver);
 EXPORT_SYMBOL_GPL(device_release_driver);
 EXPORT_SYMBOL_GPL(device_attach);
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -325,7 +325,6 @@ extern int device_for_each_child(struct 
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
-extern int  driver_probe_device(struct device_driver * drv, struct device * dev);
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
 extern int  device_attach(struct device * dev);

