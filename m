Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUF1FjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUF1FjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUF1FiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:38:10 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:9143 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264686AbUF1FY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:24:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 16/19] add bus' default driver attributes
Date: Mon, 28 Jun 2004 00:24:51 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280022.16273.dtor_core@ameritech.net> <200406280023.21998.dtor_core@ameritech.net>
In-Reply-To: <200406280023.21998.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280024.53717.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1790, 2004-06-27 19:22:44-05:00, dtor_core@ameritech.net
  Driver core: add default driver attributes to struct bus_type
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/bus.c     |   37 +++++++++++++++++++++++++++++++++++--
 include/linux/device.h |    1 +
 2 files changed, 36 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-06-27 19:24:04 -05:00
+++ b/drivers/base/bus.c	2004-06-27 19:24:04 -05:00
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
--- a/include/linux/device.h	2004-06-27 19:24:04 -05:00
+++ b/include/linux/device.h	2004-06-27 19:24:04 -05:00
@@ -56,6 +56,7 @@
 
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
+	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	struct device * (*add)	(struct device * parent, char * bus_id);
