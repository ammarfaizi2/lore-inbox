Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVCYF4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVCYF4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVCYFzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:55:32 -0500
Received: from digitalimplant.org ([64.62.235.95]:3283 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261380AbVCYFym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:42 -0500
Date: Thu, 24 Mar 2005 21:54:31 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [2/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242150330.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2240, 2005-03-24 10:50:24-08:00, mochel@digitalimplant.org
  [driver core] Use bus_for_each_{dev,drv} for driver binding.

  - Now possible, since the lists are locked using the klist lock and not the
    global rwsem.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c	2005-03-24 20:33:53 -08:00
+++ b/drivers/base/dd.c	2005-03-24 20:33:53 -08:00
@@ -85,6 +85,29 @@
 }


+static int __device_attach(struct device_driver * drv, void * data)
+{
+	struct device * dev = data;
+	int error;
+
+	error = driver_probe_device(drv, dev);
+
+	if (error == -ENODEV && error == -ENXIO) {
+		/* Driver matched, but didn't support device
+		 * or device not found.
+		 * Not an error; keep going.
+		 */
+		error = 0;
+	} else {
+		/* driver matched but the probe failed */
+		printk(KERN_WARNING
+		       "%s: probe of %s failed with error %d\n",
+		       drv->name, dev->bus_id, error);
+	}
+	return 0;
+}
+
+
 /**
  *	device_attach - try to attach device to a driver.
  *	@dev:	device.
@@ -95,34 +118,35 @@
  */
 int device_attach(struct device * dev)
 {
- 	struct bus_type * bus = dev->bus;
-	struct list_head * entry;
-	int error;
-
 	if (dev->driver) {
 		device_bind_driver(dev);
 		return 1;
 	}

-	if (bus->match) {
-		list_for_each(entry, &bus->drivers.list) {
-			struct device_driver * drv = to_drv(entry);
-			error = driver_probe_device(drv, dev);
-			if (!error)
-				/* success, driver matched */
-				return 1;
-			if (error != -ENODEV && error != -ENXIO)
+	return bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
+}
+
+
+static int __driver_attach(struct device * dev, void * data)
+{
+	struct device_driver * drv = data;
+	int error = 0;
+
+	if (!dev->driver) {
+		error = driver_probe_device(drv, dev);
+		if (error) {
+			if (error != -ENODEV) {
 				/* driver matched but the probe failed */
 				printk(KERN_WARNING
-				    "%s: probe of %s failed with error %d\n",
-				    drv->name, dev->bus_id, error);
+				       "%s: probe of %s failed with error %d\n",
+				       drv->name, dev->bus_id, error);
+			} else
+				error = 0;
 		}
 	}
-
 	return 0;
 }

-
 /**
  *	driver_attach - try to bind driver to devices.
  *	@drv:	driver.
@@ -137,24 +161,7 @@
  */
 void driver_attach(struct device_driver * drv)
 {
-	struct bus_type * bus = drv->bus;
-	struct list_head * entry;
-	int error;
-
-	if (!bus->match)
-		return;
-
-	list_for_each(entry, &bus->devices.list) {
-		struct device * dev = container_of(entry, struct device, bus_list);
-		if (!dev->driver) {
-			error = driver_probe_device(drv, dev);
-			if (error && (error != -ENODEV))
-				/* driver matched but the probe failed */
-				printk(KERN_WARNING
-				    "%s: probe of %s failed with error %d\n",
-				    drv->name, dev->bus_id, error);
-		}
-	}
+	bus_for_each_dev(drv->bus, NULL, drv, __driver_attach);
 }


