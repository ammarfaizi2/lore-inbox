Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbTAORRR>; Wed, 15 Jan 2003 12:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbTAORRR>; Wed, 15 Jan 2003 12:17:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34979 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266720AbTAORRP>;
	Wed, 15 Jan 2003 12:17:15 -0500
Date: Wed, 15 Jan 2003 10:23:29 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <tomlins@cam.org>, <felix-linuxkernel@fefe.de>,
       <linux-kernel@vger.kernel.org>, <greg@kroah.com>
Subject: Re: Patch: linux-2.5.58/drivers/base/bus.c ignored pre-existing
 devices
In-Reply-To: <20030115025256.A8250@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0301151002130.1137-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	device_attach() in linux-2.5.5[78]/drivers/base/bus.c has a
> bug.  Any device that is detected before its driver is loaded is
> forgotten.

> 	Anyhow, getting back to business, the problem arose due to a
> botched change in drivers/base/bus.c that apprently was intended to
> allow a driver->probe function to return an error other than -ENODEV
> and thereby cause the whole binding process to abort.  At least that's
> what I think the extra code was inteded to do.  If not, I could shrink
> the code by making device_attach return void.

The extra code was an attempt at properly handling failure of ->probe(),
and to make sure that an error from ->probe() (e.g. -ENOMEM) is propogated
up.

The cause of the problem you're seeing is that if a device wasn't bound to 
a driver, -ENODEV was returned, causing it to be removed from the bus's 
list of devices. 

To remedy this, I've changed the semantics of bus_match() to return the 
following:

* 1	if device was bound to a driver.
* 0	if it wasn't 
* <0	if drv->probe() returned an error. 

This allows the caller to know if binding happened, as well as bubble the 
error up. 

Greg notified me of this yesterday, and I sent him the following patch. I 
haven't pushed it upward yet, since he hasn't had a chance to test it. If 
you get a chance, please try it and let me know if fixes your problem..

Thanks,

	-pat

===== drivers/base/bus.c 1.38 vs edited =====
--- 1.38/drivers/base/bus.c	Mon Jan 13 10:34:12 2003
+++ edited/drivers/base/bus.c	Tue Jan 14 16:41:22 2003
@@ -256,22 +256,27 @@
  *	
  *	If we find a match, we call @drv->probe(@dev) if it exists, and 
  *	call attach() above.
+ *
+ *	If the deivce is bound to the driver, we return 1. If the bus
+ *	reports that they do not match (bus->match() returns FALSE), we
+ *	return 0. Otherwise, we return the error that drv->probe() 
+ *	returns.
  */
 static int bus_match(struct device * dev, struct device_driver * drv)
 {
-	int error = -ENODEV;
+	int ret = 0;
 	if (dev->bus->match(dev,drv)) {
 		dev->driver = drv;
 		if (drv->probe) {
-			if ((error = drv->probe(dev))) {
+			if ((ret = drv->probe(dev))) {
 				dev->driver = NULL;
-				return error;
+				return ret;
 			}
 		}
 		device_bind_driver(dev);
-		error = 0;
+		ret = 1;
 	}
-	return error;
+	return ret;
 }
 
 
@@ -298,8 +303,11 @@
 
 	list_for_each(entry,&bus->drivers.list) {
 		struct device_driver * drv = to_drv(entry);
-		if (!(error = bus_match(dev,drv)))
+		if ((error = bus_match(dev,drv))) {
+			if (error > 1)
+				error = 0;
 			break;
+		}
 	}
 	return error;
 }
@@ -322,6 +330,7 @@
 {
 	struct bus_type * bus = drv->bus;
 	struct list_head * entry;
+	int error = 0;
 
 	if (!bus->match)
 		return 0;
@@ -329,8 +338,12 @@
 	list_for_each(entry,&bus->devices.list) {
 		struct device * dev = container_of(entry,struct device,bus_list);
 		if (!dev->driver) {
-			if (!bus_match(dev,drv) && dev->driver)
-				devclass_add_device(dev);
+			if ((error = bus_match(dev,drv))) {
+				if (error > 0)
+					error = devclass_add_device(dev);
+				else
+					break;
+			}
 		}
 	}
 	return 0;
@@ -396,7 +409,8 @@
 		if ((error = device_attach(dev)))
 			list_del_init(&dev->bus_list);
 		up_write(&dev->bus->subsys.rwsem);
-		sysfs_create_link(&bus->devices.kobj,&dev->kobj,dev->bus_id);
+		if (!error)
+			sysfs_create_link(&bus->devices.kobj,&dev->kobj,dev->bus_id);
 	}
 	return error;
 }

