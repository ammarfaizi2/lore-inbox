Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUFVSHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUFVSHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUFVSEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:04:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:43701 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265065AbUFVRn3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:29 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261084005@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:49 -0700
Message-Id: <1087926109433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.85.6, 2004/06/03 17:37:14-07:00, mochel@digitalimplant.org

[Driver Model] Add default device attributes to struct bus_type.

- Add struct bus_type::dev_attrs, which is an array of device 
  attributes that are added to each device as they are registered.

 - Also make sure that we don't hang when removing bus attributes
   if adding one failed.. 


 drivers/base/bus.c     |   36 +++++++++++++++++++++++++++++++++++-
 include/linux/device.h |    1 +
 2 files changed, 36 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Tue Jun 22 09:48:35 2004
+++ b/drivers/base/bus.c	Tue Jun 22 09:48:35 2004
@@ -392,6 +392,38 @@
 	
 }
 
+static int device_add_attrs(struct bus_type * bus, struct device * dev)
+{
+	int error = 0;
+	int i;
+
+	if (bus->dev_attrs) {
+		for (i = 0; attr_name(bus->dev_attrs[i]); i++) {
+			error = device_create_file(dev,&bus->dev_attrs[i]);
+			if (error)
+				goto Err;
+		}
+	}
+ Done:
+	return error;
+ Err:
+	while (--i >= 0)
+		device_remove_file(dev,&bus->dev_attrs[i]);
+	goto Done;
+}
+
+
+static void device_remove_attrs(struct bus_type * bus, struct device * dev)
+{
+	int i;
+	
+	if (bus->dev_attrs) {
+		for (i = 0; attr_name(bus->dev_attrs[i]); i++)
+			device_remove_file(dev,&bus->dev_attrs[i]);
+	}
+}
+
+
 /**
  *	bus_add_device - add device to bus
  *	@dev:	device being added
@@ -411,6 +443,7 @@
 		list_add_tail(&dev->bus_list,&dev->bus->devices.list);
 		device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
+		device_add_attrs(bus,dev);
 		sysfs_create_link(&bus->devices.kobj,&dev->kobj,dev->bus_id);
 	}
 	return error;
@@ -429,6 +462,7 @@
 {
 	if (dev->bus) {
 		sysfs_remove_link(&dev->bus->devices.kobj,dev->bus_id);
+		device_remove_attrs(dev->bus,dev);
 		down_write(&dev->bus->subsys.rwsem);
 		pr_debug("bus %s: remove device %s\n",dev->bus->name,dev->bus_id);
 		device_release_driver(dev);
@@ -569,7 +603,7 @@
  Done:
 	return error;
  Err:
-	while (i >= 0)
+	while (--i >= 0)
 		bus_remove_file(bus,&bus->bus_attrs[i]);
 	goto Done;
 }
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Jun 22 09:48:35 2004
+++ b/include/linux/device.h	Tue Jun 22 09:48:35 2004
@@ -55,6 +55,7 @@
 	struct kset		devices;
 
 	struct bus_attribute	* bus_attrs;
+	struct device_attribute	* dev_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	struct device * (*add)	(struct device * parent, char * bus_id);

