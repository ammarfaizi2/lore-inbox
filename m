Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUF1FrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUF1FrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUF1FmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:42:21 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:48785 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264728AbUF1FZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:25:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 17/19] serio use bus' default driver/device attributes
Date: Mon, 28 Jun 2004 00:25:52 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280023.21998.dtor_core@ameritech.net> <200406280024.53717.dtor_core@ameritech.net>
In-Reply-To: <200406280024.53717.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280025.54154.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1791, 2004-06-27 19:39:04-05:00, dtor_core@ameritech.net
  Input: Switch to use bus' default device and driver attributes to
         manage serio sysfs attributes
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-27 21:23:42 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-27 21:23:42 -05:00
@@ -245,14 +245,12 @@
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%s\n", serio->name);
 }
-static DEVICE_ATTR(description, S_IRUGO, serio_show_description, NULL);
 
 static ssize_t serio_show_legacy_position(struct device *dev, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%s\n", serio->phys);
 }
-static DEVICE_ATTR(legacy_position, S_IRUGO, serio_show_legacy_position, NULL);
 
 static ssize_t serio_show_driver(struct device *dev, char *buf)
 {
@@ -290,7 +288,14 @@
 
 	return retval;
 }
-static DEVICE_ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver);
+
+static struct device_attribute serio_device_attrs[] = {
+	__ATTR(description, S_IRUGO, serio_show_description, NULL),
+	__ATTR(legacy_position, S_IRUGO, serio_show_legacy_position, NULL),
+	__ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver),
+	__ATTR_NULL
+};
+
 
 static void serio_release_port(struct device *dev)
 {
@@ -312,9 +317,6 @@
 	if (serio->parent)
 		serio->dev.parent = &serio->parent->dev;
 	device_register(&serio->dev);
-	device_create_file(&serio->dev, &dev_attr_description);
-	device_create_file(&serio->dev, &dev_attr_legacy_position);
-	device_create_file(&serio->dev, &dev_attr_driver);
 }
 
 /*
@@ -489,7 +491,11 @@
 	struct serio_driver *driver = to_serio_driver(drv);
 	return sprintf(buf, "%s\n", driver->description ? driver->description : "(none)");
 }
-static DRIVER_ATTR(description, S_IRUGO, serio_driver_show_description, NULL);
+
+static struct driver_attribute serio_driver_attrs[] = {
+	__ATTR(description, S_IRUGO, serio_driver_show_description, NULL),
+	__ATTR_NULL
+};
 
 void serio_register_driver(struct serio_driver *drv)
 {
@@ -501,7 +507,6 @@
 
 	drv->driver.bus = &serio_bus;
 	driver_register(&drv->driver);
-	driver_create_file(&drv->driver, &driver_attr_description);
 
 	if (drv->manual_bind)
 		goto out;
@@ -607,6 +612,8 @@
 		return -1;
 	}
 
+	serio_bus.dev_attrs = serio_device_attrs;
+	serio_bus.drv_attrs = serio_driver_attrs;
 	bus_register(&serio_bus);
 
 	return 0;
