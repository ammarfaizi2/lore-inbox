Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUGOAhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUGOAhS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUGOAg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:36:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:34432 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266063AbUGOAUD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:03 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <10898507032528@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:23 -0700
Message-Id: <10898507033041@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.12.2, 2004/07/08 16:40:09-07:00, dtor_core@ameritech.net

[PATCH] Driver core: add platform_device_register_simple to register platform

Add platform_device_register_simple to register platform devices
requiring minimal resource and memory management.  The device
will have standard release function that just frees memory
occupied by the platform device. By having release function in
the driver core modules using such devices can be unloaded
without waiting for the last reference to the device to be
dropped.


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h  |    2 +
 2 files changed, 70 insertions(+)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-07-14 17:12:11 -07:00
+++ b/drivers/base/platform.c	2004-07-14 17:12:11 -07:00
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/bootmem.h>
+#include <linux/err.h>
 
 struct device platform_bus = {
 	.bus_id		= "platform",
@@ -133,6 +134,13 @@
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
@@ -148,6 +156,65 @@
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
@@ -237,6 +304,7 @@
 EXPORT_SYMBOL(platform_bus);
 EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
+EXPORT_SYMBOL(platform_device_register_simple);
 EXPORT_SYMBOL(platform_device_unregister);
 EXPORT_SYMBOL(platform_get_irq);
 EXPORT_SYMBOL(platform_get_resource);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-07-14 17:12:11 -07:00
+++ b/include/linux/device.h	2004-07-14 17:12:11 -07:00
@@ -381,6 +381,8 @@
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_add_devices(struct platform_device **, int);
 
+extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);
+
 /* drivers/base/power.c */
 extern void device_shutdown(void);
 

