Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUGHBmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUGHBmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUGHBmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:42:44 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:49776 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265399AbUGHBm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:42:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [RESEND][PATCH 2/4] Driver core updates (needed for serio)
Date: Wed, 7 Jul 2004 20:40:00 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407072038.27158.dtor_core@ameritech.net>
In-Reply-To: <200407072038.27158.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407072040.01818.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1820, 2004-07-07 18:15:23-05:00, dtor_core@ameritech.net
  Driver core: add default driver attributes to struct bus_type
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/bus.c     |   37 +++++++++++++++++++++++++++++++++++--
 include/linux/device.h |    1 +
 2 files changed, 36 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-07-07 18:56:42 -05:00
+++ b/drivers/base/bus.c	2004-07-07 18:56:42 -05:00
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
--- a/include/linux/device.h	2004-07-07 18:56:42 -05:00
+++ b/include/linux/device.h	2004-07-07 18:56:42 -05:00
@@ -56,6 +56,7 @@
 
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
+	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	struct device * (*add)	(struct device * parent, char * bus_id);
