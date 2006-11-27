Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757577AbWK0Jfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbWK0Jfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610AbWK0JfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:35:05 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:28473 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757591AbWK0Jej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:34:39 -0500
Date: Mon, 27 Nov 2006 10:35:16 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 7/7] driver core: Don't fail attaching the device if it
 cannot be bound.
Message-ID: <20061127103516.212ce75f@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Don't fail bus_attach_device() if the device cannot be bound.

If dev->driver has been specified, reset it to NULL if device_bind_driver()
failed and add the device as an unbound device. As a result, bus_attach_device()
now cannot fail, and we can remove some checking from device_add().

Also remove an unneeded check in bus_rescan_devices_helper().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/base.h |    2 +-
 drivers/base/bus.c  |   13 +++++--------
 drivers/base/core.c |    5 +----
 drivers/base/dd.c   |    6 +++++-
 4 files changed, 12 insertions(+), 14 deletions(-)

--- linux-2.6-CH.orig/drivers/base/dd.c
+++ linux-2.6-CH/drivers/base/dd.c
@@ -230,7 +230,7 @@ static int device_probe_drivers(void *da
  *
  *	Returns 1 if the device was bound to a driver;
  *	0 if no matching device was found or multithreaded probing is done;
- *	error code otherwise.
+ *	-ENODEV if the device is not registered.
  *
  *	When called for a USB interface, @dev->parent->sem must be held.
  */
@@ -244,6 +244,10 @@ int device_attach(struct device * dev)
 		ret = device_bind_driver(dev);
 		if (ret == 0)
 			ret = 1;
+		else {
+			dev->driver = NULL;
+			ret = 0;
+		}
 	} else {
 		if (dev->bus->multithread_probe)
 			probe_task = kthread_run(device_probe_drivers, dev,
--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -595,8 +595,7 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	if ((error = bus_attach_device(dev)))
-		goto AttachError;
+	bus_attach_device(dev);
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -614,8 +613,6 @@ int device_add(struct device *dev)
  Done:
 	put_device(dev);
 	return error;
- AttachError:
-	bus_remove_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:
--- linux-2.6-CH.orig/drivers/base/base.h
+++ linux-2.6-CH/drivers/base/base.h
@@ -16,7 +16,7 @@ extern int cpu_dev_init(void);
 extern int attribute_container_init(void);
 
 extern int bus_add_device(struct device * dev);
-extern int bus_attach_device(struct device * dev);
+extern void bus_attach_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 extern struct bus_type *get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);
--- linux-2.6-CH.orig/drivers/base/bus.c
+++ linux-2.6-CH/drivers/base/bus.c
@@ -420,21 +420,20 @@ out_put:
  *	- Add device to bus's list of devices.
  *	- Try to attach to driver.
  */
-int bus_attach_device(struct device * dev)
+void bus_attach_device(struct device * dev)
 {
 	struct bus_type *bus = dev->bus;
-	int ret = 0;
+	int ret;
 
 	if (bus) {
 		dev->is_registered = 1;
 		ret = device_attach(dev);
-		if (ret >= 0) {
+		WARN_ON(ret < 0);
+		if (ret >= 0)
 			klist_add_tail(&dev->knode_bus, &bus->klist_devices);
-			ret = 0;
-		} else
+		else
 			dev->is_registered = 0;
 	}
-	return ret;
 }
 
 /**
@@ -607,8 +606,6 @@ static int __must_check bus_rescan_devic
 		ret = device_attach(dev);
 		if (dev->parent)
 			up(&dev->parent->sem);
-		if (ret > 0)
-			ret = 0;
 	}
 	return ret < 0 ? ret : 0;
 }
