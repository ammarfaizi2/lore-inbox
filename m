Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVCUV5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVCUV5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVCUVAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:00:40 -0500
Received: from digitalimplant.org ([64.62.235.95]:14988 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261875AbVCUUsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:48:42 -0500
Date: Mon, 21 Mar 2005 12:48:32 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [1/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211243090.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2230, 2005-03-21 10:41:04-08:00, mochel@digitalimplant.org
  [driver core] Add a semaphore to struct device to synchronize calls to its driver.

  This adds a per-device semaphore that is taken before every call from the core to a
  driver method. This prevents e.g. simultaneous calls to the ->suspend() or ->resume()
  and ->probe() or ->release(), potentially saving a whole lot of headaches.

  It also moves us a step closer to removing the bus rwsem, since it protects the fields
  in struct device that are modified by the core.



  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-03-21 12:30:51 -08:00
+++ b/drivers/base/bus.c	2005-03-21 12:30:51 -08:00
@@ -283,18 +283,22 @@
  */
 int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
+	int error = 0;
+
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		return -ENODEV;

+	down(&dev->sem);
 	dev->driver = drv;
 	if (drv->probe) {
-		int error = drv->probe(dev);
+		error = drv->probe(dev);
 		if (error) {
 			dev->driver = NULL;
+			up(&dev->sem);
 			return error;
 		}
 	}
-
+	up(&dev->sem);
 	device_bind_driver(dev);
 	return 0;
 }
@@ -385,7 +389,10 @@

 void device_release_driver(struct device * dev)
 {
-	struct device_driver * drv = dev->driver;
+	struct device_driver * drv;
+
+	down(&dev->sem);
+	drv = dev->driver;
 	if (drv) {
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
@@ -395,6 +402,7 @@
 			drv->remove(dev);
 		dev->driver = NULL;
 	}
+	up(&dev->sem);
 }


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2005-03-21 12:30:51 -08:00
+++ b/drivers/base/core.c	2005-03-21 12:30:51 -08:00
@@ -215,6 +215,7 @@
 	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->bus_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
+	init_MUTEX(&dev->sem);
 }

 /**
diff -Nru a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c	2005-03-21 12:30:51 -08:00
+++ b/drivers/base/power/resume.c	2005-03-21 12:30:51 -08:00
@@ -22,9 +22,13 @@

 int resume_device(struct device * dev)
 {
+	int error = 0;
+
+	down(&dev->sem);
 	if (dev->bus && dev->bus->resume)
-		return dev->bus->resume(dev);
-	return 0;
+		error = dev->bus->resume(dev);
+	up(&dev->sem);
+	return error;
 }


diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	2005-03-21 12:30:51 -08:00
+++ b/drivers/base/power/suspend.c	2005-03-21 12:30:51 -08:00
@@ -41,11 +41,11 @@

 	dev_dbg(dev, "suspending\n");

+	down(&dev->sem);
 	dev->power.prev_state = dev->power.power_state;
-
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
 		error = dev->bus->suspend(dev, state);
-
+	up(&dev->sem);
 	return error;
 }

diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-21 12:30:51 -08:00
+++ b/include/linux/device.h	2005-03-21 12:30:51 -08:00
@@ -265,6 +265,10 @@
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */

+	struct semaphore	sem;	/* semaphore to synchronize calls to
+					 * its driver.
+					 */
+
 	struct bus_type	* bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
