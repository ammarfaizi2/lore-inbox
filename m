Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUGOAmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUGOAmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUGOAhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:37:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:38016 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266065AbUGOAUF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:05 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <10898507033041@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:23 -0700
Message-Id: <1089850703420@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.12.3, 2004/07/08 16:41:56-07:00, dtor_core@ameritech.net

[PATCH] Driver core: add default driver attributes to struct bus_type

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c     |   37 +++++++++++++++++++++++++++++++++++--
 include/linux/device.h |    1 +
 2 files changed, 36 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-07-14 17:11:56 -07:00
+++ b/drivers/base/bus.c	2004-07-14 17:11:56 -07:00
@@ -415,7 +415,7 @@
 static void device_remove_attrs(struct bus_type * bus, struct device * dev)
 {
 	int i;
-	
+
 	if (bus->dev_attrs) {
 		for (i = 0; attr_name(bus->dev_attrs[i]); i++)
 			device_remove_file(dev,&bus->dev_attrs[i]);
@@ -471,6 +471,37 @@
 	}
 }
 
+static int driver_add_attrs(struct bus_type * bus, struct device_driver * drv)
+{
+	int error = 0;
+	int i;
+
+	if (bus->drv_attrs) {
+		for (i = 0; attr_name(bus->drv_attrs[i]); i++) {
+			error = driver_create_file(drv, &bus->drv_attrs[i]);
+			if (error)
+				goto Err;
+		}
+	}
+ Done:
+	return error;
+ Err:
+	while (--i >= 0)
+		driver_remove_file(drv, &bus->drv_attrs[i]);
+	goto Done;
+}
+
+
+static void driver_remove_attrs(struct bus_type * bus, struct device_driver * drv)
+{
+	int i;
+
+	if (bus->drv_attrs) {
+		for (i = 0; attr_name(bus->drv_attrs[i]); i++)
+			driver_remove_file(drv, &bus->drv_attrs[i]);
+	}
+}
+
 
 /**
  *	bus_add_driver - Add a driver to the bus.
@@ -499,6 +530,7 @@
 		driver_attach(drv);
 		up_write(&bus->subsys.rwsem);
 
+		driver_add_attrs(bus, drv);
 	}
 	return error;
 }
@@ -516,6 +548,7 @@
 void bus_remove_driver(struct device_driver * drv)
 {
 	if (drv->bus) {
+		driver_remove_attrs(drv->bus, drv);
 		down_write(&drv->bus->subsys.rwsem);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
@@ -610,7 +643,7 @@
 static void bus_remove_attrs(struct bus_type * bus)
 {
 	int i;
-	
+
 	if (bus->bus_attrs) {
 		for (i = 0; attr_name(bus->bus_attrs[i]); i++)
 			bus_remove_file(bus,&bus->bus_attrs[i]);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-07-14 17:11:56 -07:00
+++ b/include/linux/device.h	2004-07-14 17:11:56 -07:00
@@ -56,6 +56,7 @@
 
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
+	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	struct device * (*add)	(struct device * parent, char * bus_id);

