Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271740AbTHHSug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271748AbTHHSuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:50:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:15811 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S271740AbTHHSuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:50:19 -0400
Message-ID: <3F33F03D.7030903@us.ibm.com>
Date: Fri, 08 Aug 2003 13:47:25 -0500
From: Janice M Girouard <janiceg@us.ibm.com>
Organization: IBM Linux Technology Center - Network Device Drivers
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] testing for probe errors in base/bus.c
Content-Type: multipart/mixed;
 boundary="------------090002070607040007070106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002070607040007070106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Currently if an error is detected when probing a device,
this error is not reported.  Generally, an error value from
errno.h will be returned when the driver->probe function
fails.  However these errors are not logged, and the device
fails silently.

I've looked at e1000, tg3, 3c59x, acenic, hp, and many
others... all of whom exibit this behaviour.

The attached patch logs all errors, with the exception
of -ENODEV, since it is normal to receive this error when
matching drivers to devices.



--------------090002070607040007070106
Content-Type: text/plain;
 name="bus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bus.patch"

diff -Naur linux-2.6.0-test2.orig.bus/drivers/base/bus.c linux-2.6.0-test2.my.bus/drivers/base/bus.c
--- linux-2.6.0-test2.orig.bus/drivers/base/bus.c	2003-08-07 16:14:31.000000000 -0500
+++ linux-2.6.0-test2.my.bus/drivers/base/bus.c	2003-08-07 21:14:32.000000000 -0500
@@ -287,6 +287,7 @@
 {
  	struct bus_type * bus = dev->bus;
 	struct list_head * entry;
+	int error;
 
 	if (dev->driver) {
 		device_bind_driver(dev);
@@ -296,8 +297,15 @@
 	if (bus->match) {
 		list_for_each(entry,&bus->drivers.list) {
 			struct device_driver * drv = to_drv(entry);
-			if (!bus_match(dev,drv))
-				return 1;
+			error = bus_match(dev,drv);
+			if (!error )  
+				/* success, driver matched */
+				return 1; 
+			if (error != -ENODEV) 
+				/* driver matched but the probe failed */
+				printk(KERN_WARNING 
+				    "%s: probe of %s failed with error %d\n",
+				    drv->name, dev->bus_id, error);
 		}
 	}
 
@@ -314,13 +322,14 @@
  *	If bus_match() returns 0 and the @dev->driver is set, we've found
  *	a compatible pair.
  *
- *	Note that we ignore the error from bus_match(), since it's perfectly
- *	valid for a driver not to bind to any devices.
+ *	Note that we ignore the -ENODEV error from bus_match(), since it's 
+ *	perfectly valid for a driver not to bind to any devices.
  */
 void driver_attach(struct device_driver * drv)
 {
 	struct bus_type * bus = drv->bus;
 	struct list_head * entry;
+	int error;
 
 	if (!bus->match)
 		return;
@@ -328,7 +337,12 @@
 	list_for_each(entry,&bus->devices.list) {
 		struct device * dev = container_of(entry,struct device,bus_list);
 		if (!dev->driver) {
-			bus_match(dev,drv);
+			error = bus_match(dev,drv);
+			if (error && (error != -ENODEV))
+				/* driver matched but the probe failed */
+				printk(KERN_WARNING 
+				    "%s: probe of %s failed with error %d\n",
+				    drv->name, dev->bus_id, error);
 		}
 	}
 }

--------------090002070607040007070106--

