Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUF1FbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUF1FbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUF1FbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:31:02 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:12406 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264693AbUF1FTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:19:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 11/19] add platform_device_register_simple
Date: Mon, 28 Jun 2004 00:19:00 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280017.05202.dtor_core@ameritech.net> <200406280017.56654.dtor_core@ameritech.net>
In-Reply-To: <200406280017.56654.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280019.04030.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1785, 2004-06-27 15:57:46-05:00, dtor_core@ameritech.net
  sysfs: add platform_device_register_simple to register platform devices
         requiring minimal resource and memory management. The device will
         have standard release function that just frees memory occupied by
         the platform device. By having release function in the driver core
         modules using such devices can be unloaded without waiting for the
         last reference to the device to be dropped.
  
         Suggested by Russell King
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/platform.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h  |    2 +
 2 files changed, 70 insertions(+)


===================================================================



diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-06-27 17:50:23 -05:00
+++ b/drivers/base/platform.c	2004-06-27 17:50:23 -05:00
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/err.h>
 
 struct device platform_bus = {
 	.bus_id		= "platform",
@@ -131,6 +132,13 @@
 	return ret;
 }
 
+/**
+ *	platform_device_unregister - remove a platform-level device
+ *	@dev:	platform device we're removing
+ *
+ *	Note that this function will also release all memory- and port-based
+ *	resources owned by the device (@dev->resource).
+ */
 void platform_device_unregister(struct platform_device * pdev)
 {
 	int i;
@@ -146,6 +154,65 @@
 	}
 }
 
+struct platform_object {
+        struct platform_device pdev;
+        struct resource resources[0];
+};
+
+static void platform_device_release_simple(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	kfree(container_of(pdev, struct platform_object, pdev));
+}
+
+/**
+ *	platform_device_register_simple
+ *	@name:  base name of the device we're adding
+ *	@id:    instance id
+ *	@res:   set of resources that needs to be allocated for the device
+ *	@num:	number of resources
+ *
+ *	This function creates a simple platform device that requires minimal
+ *	resource and memory management. Canned release function freeing
+ *	memory allocated for the device allows drivers using such devices
+ *	to be unloaded iwithout waiting for the last reference to the device
+ *	to be dropped.
+ */
+struct platform_device *platform_device_register_simple(char *name, unsigned int id,
+							struct resource *res, unsigned int num)
+{
+	struct platform_object *pobj;
+	int retval;
+
+	pobj = kmalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
+	if (!pobj) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	memset(pobj, 0, sizeof(*pobj));
+	pobj->pdev.name = name;
+	pobj->pdev.id = id;
+	pobj->pdev.dev.release = platform_device_release_simple;
+
+	if (num) {
+		memcpy(pobj->resources, res, sizeof(struct resource) * num);
+		pobj->pdev.resource = pobj->resources;
+		pobj->pdev.num_resources = num;
+	}
+
+	retval = platform_device_register(&pobj->pdev);
+	if (retval)
+		goto error;
+
+	return &pobj->pdev;
+
+error:
+	kfree(pobj);
+	return ERR_PTR(retval);
+}
+
 
 /**
  *	platform_match - bind platform device to platform driver.
@@ -213,6 +280,7 @@
 EXPORT_SYMBOL(platform_bus);
 EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
+EXPORT_SYMBOL(platform_device_register_simple);
 EXPORT_SYMBOL(platform_device_unregister);
 EXPORT_SYMBOL(platform_get_irq);
 EXPORT_SYMBOL(platform_get_resource);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-06-27 17:50:23 -05:00
+++ b/include/linux/device.h	2004-06-27 17:50:23 -05:00
@@ -381,6 +381,8 @@
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_add_devices(struct platform_device **, int);
 
+extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);
+
 /* drivers/base/power.c */
 extern void device_shutdown(void);
 
