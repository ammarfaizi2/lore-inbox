Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269499AbUJLGgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269499AbUJLGgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269496AbUJLGeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:34:07 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:40859 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269491AbUJLGdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:33:32 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2/4] Driver core: add driver_probe_device
Date: Tue, 12 Oct 2004 01:31:36 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
References: <200410062354.18885.dtor_core@ameritech.net> <200410120129.59221.dtor_core@ameritech.net> <200410120131.05691.dtor_core@ameritech.net>
In-Reply-To: <200410120131.05691.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120131.38330.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#### AUTHOR dtor_core@ameritech.net
#### COMMENT START
### Comments for ChangeSet
Driver core: rename bus_match into driver_probe_device and export
             it so subsystems can bind an individual device to a
             specific driver without getting involved with driver
             core internals.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
### Comments for drivers/base/bus.c
Rename bus_match() to driver_probe_device() and export it. 
### Comments for include/linux/device.h
Add driver_probe_device()
#### COMMENT END

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/11 00:19:57-05:00 dtor_core@ameritech.net 
#   Driver core: rename bus_match into driver_probe_device and export
#                it so subsystems can bind an individual device to a
#                specific driver without getting involved with driver
#                core internals.
#   
#   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
# 
# include/linux/device.h
#   2004/10/10 23:57:30-05:00 dtor_core@ameritech.net +2 -1
#   Add driver_probe_device()
# 
# drivers/base/bus.c
#   2004/10/10 23:57:30-05:00 dtor_core@ameritech.net +29 -26
#   Rename bus_match() to driver_probe_device() and export it. 
# 
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-10-12 01:28:06 -05:00
+++ b/drivers/base/bus.c	2004-10-12 01:28:06 -05:00
@@ -250,34 +250,35 @@
 
 
 /**
- *	bus_match - check compatibility between device & driver.
- *	@dev:	device.
+ *	driver_probe_device - attempt to bind device & driver.
  *	@drv:	driver.
+ *	@dev:	device.
  *
- *	First, we call the bus's match function, which should compare
- *	the device IDs the driver supports with the device IDs of the
- *	device. Note we don't do this ourselves because we don't know
- *	the format of the ID structures, nor what is to be considered
- *	a match and what is not.
+ *	First, we call the bus's match function, if one present, which
+ *	should compare the device IDs the driver supports with the
+ *	device IDs of the device. Note we don't do this ourselves
+ *	because we don't know the format of the ID structures, nor what
+ *	is to be considered a match and what is not.
  *
  *	If we find a match, we call @drv->probe(@dev) if it exists, and
- *	call attach() above.
+ *	call device_bind_driver() above.
  */
-static int bus_match(struct device * dev, struct device_driver * drv)
+int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
-	int error = -ENODEV;
-	if (dev->bus->match(dev, drv)) {
-		dev->driver = drv;
-		if (drv->probe) {
-			if ((error = drv->probe(dev))) {
-				dev->driver = NULL;
-				return error;
-			}
+	if (drv->bus->match && !drv->bus->match(dev, drv))
+		return -ENODEV;
+
+	dev->driver = drv;
+	if (drv->probe) {
+		int error = drv->probe(dev);
+		if (error) {
+			dev->driver = NULL;
+			return error;
 		}
-		device_bind_driver(dev);
-		error = 0;
 	}
-	return error;
+
+	device_bind_driver(dev);
+	return 0;
 }
 
 
@@ -285,8 +286,9 @@
  *	device_attach - try to attach device to a driver.
  *	@dev:	device.
  *
- *	Walk the list of drivers that the bus has and call bus_match()
- *	for each pair. If a compatible pair is found, break out and return.
+ *	Walk the list of drivers that the bus has and call
+ *	driver_probe_device() for each pair. If a compatible
+ *	pair is found, break out and return.
  */
 int device_attach(struct device * dev)
 {
@@ -302,7 +304,7 @@
 	if (bus->match) {
 		list_for_each(entry, &bus->drivers.list) {
 			struct device_driver * drv = to_drv(entry);
-			error = bus_match(dev, drv);
+			error = driver_probe_device(drv, dev);
 			if (!error)
 				/* success, driver matched */
 				return 1;
@@ -327,8 +329,8 @@
  *	If bus_match() returns 0 and the @dev->driver is set, we've found
  *	a compatible pair.
  *
- *	Note that we ignore the -ENODEV error from bus_match(), since it's
- *	perfectly valid for a driver not to bind to any devices.
+ *	Note that we ignore the -ENODEV error from driver_probe_device(),
+ *	since it's perfectly valid for a driver not to bind to any devices.
  */
 void driver_attach(struct device_driver * drv)
 {
@@ -342,7 +344,7 @@
 	list_for_each(entry, &bus->devices.list) {
 		struct device * dev = container_of(entry, struct device, bus_list);
 		if (!dev->driver) {
-			error = bus_match(dev, drv);
+			error = driver_probe_device(drv, dev);
 			if (error && (error != -ENODEV))
 				/* driver matched but the probe failed */
 				printk(KERN_WARNING
@@ -726,6 +728,7 @@
 EXPORT_SYMBOL_GPL(bus_for_each_dev);
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
+EXPORT_SYMBOL_GPL(driver_probe_device);
 EXPORT_SYMBOL_GPL(device_bind_driver);
 EXPORT_SYMBOL_GPL(device_release_driver);
 EXPORT_SYMBOL_GPL(device_attach);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-10-12 01:28:06 -05:00
+++ b/include/linux/device.h	2004-10-12 01:28:06 -05:00
@@ -322,9 +322,10 @@
 		     int (*fn)(struct device *, void *));
 
 /*
- * Manual binding of a device to driver. See drivers/base/bus.c 
+ * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
+extern int  driver_probe_device(struct device_driver * drv, struct device * dev);
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
 extern int  device_attach(struct device * dev);
