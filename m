Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUGHBmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUGHBmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUGHBmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:42:35 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:35440 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265232AbUGHBm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:42:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [RESEND][PATCH 1/4] Driver core updates (needed for serio)
Date: Wed, 7 Jul 2004 20:38:25 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407072038.27158.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Could you please take a look at the 4 patches below. I would like to finish
synching up my serio sysfs patches with Vojtech and the rest of my stuff
depends on these patches, so I would like to know if they are acceptable or
I need to redo some of these.

The patches are:

01-platform-device-simple.patch
	- Add platform_device_register_simple() that would register
	  platform device that needs minimal resource management. The device
	  will have release function in driver core so unloading is not
	  a concern.

02-bus-driver-attr.patch
	- Add default driver's attributes, similar to device's default
	  attributes to make driver's and device's API in balance.

03-kset-find-obj-refcount.patch
	- kset_find_obj should increment refcount of the found object,
	  otherwise the object can disappear before caller has a chance to
	  pin it down. Also document that find_bus and device_find now
	  return respective objectw with refcount incremented. Adjust
	  rpaphp_vio to drip the extra reference as it is not needed there. 

04-driver-find.patch
	- implement driver_find() function - the same as device_find but
	  iterates over drivers registered on given bus. It is used by
	  serio core to allow user manually rebind a driver to a port.

Everyhting has been rediffed against today's pull from Linus' tree.

Thanks!

-- 
Dmitry


===================================================================


ChangeSet@1.1819, 2004-07-07 18:08:36-05:00, dtor_core@ameritech.net
  Driver core: add platform_device_register_simple to register platform
               devices requiring minimal resource and memory management.
               The device will have standard release function that just
               frees memory occupied by the platform device. By having
               release function in the driver core modules using such
               devices can be unloaded without waiting for the last
               reference to the device to be dropped.
  
  Suggested by Russell King
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/platform.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h  |    2 +
 2 files changed, 70 insertions(+)


===================================================================



diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-07-07 18:28:03 -05:00
+++ b/drivers/base/platform.c	2004-07-07 18:28:03 -05:00
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
--- a/include/linux/device.h	2004-07-07 18:28:03 -05:00
+++ b/include/linux/device.h	2004-07-07 18:28:03 -05:00
@@ -381,6 +381,8 @@
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_add_devices(struct platform_device **, int);
 
+extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);
+
 /* drivers/base/power.c */
 extern void device_shutdown(void);
 
