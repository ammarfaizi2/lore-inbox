Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVAWEWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVAWEWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVAWEWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:22:05 -0500
Received: from soundwarez.org ([217.160.171.123]:57994 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261205AbVAWEVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:21:46 -0500
Date: Sun, 23 Jan 2005 05:21:45 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 1/7] class core: export MAJOR/MINOR to the hotplug env
Message-ID: <20050123042145.GB9209@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the creation of the sysfs "dev" file of a class device into the
driver core. The struct class_device contains a dev_t value now.  If set,
the driver core will create the "dev" file containing the major/minor
numbers automatically.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/base/class.c 1.57 vs edited =====
--- 1.57/drivers/base/class.c	2004-12-22 01:29:34 +01:00
+++ edited/drivers/base/class.c	2005-01-23 01:32:18 +01:00
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/kdev_t.h>
 #include "base.h"
 
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
@@ -298,9 +299,9 @@ static int class_hotplug(struct kset *ks
 			 int num_envp, char *buffer, int buffer_size)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
-	int retval = 0;
 	int i = 0;
 	int length = 0;
+	int retval = 0;
 
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
 
@@ -313,26 +314,34 @@ static int class_hotplug(struct kset *ks
 				    &length, "PHYSDEVPATH=%s", path);
 		kfree(path);
 
-		/* add bus name of physical device */
 		if (dev->bus)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
 					    "PHYSDEVBUS=%s", dev->bus->name);
 
-		/* add driver name of physical device */
 		if (dev->driver)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
 					    "PHYSDEVDRIVER=%s", dev->driver->name);
-
-		/* terminate, set to next free slot, shrink available space */
-		envp[i] = NULL;
-		envp = &envp[i];
-		num_envp -= i;
-		buffer = &buffer[length];
-		buffer_size -= length;
 	}
 
+	if (MAJOR(class_dev->devt)) {
+		add_hotplug_env_var(envp, num_envp, &i,
+				    buffer, buffer_size, &length,
+				    "MAJOR=%u", MAJOR(class_dev->devt));
+
+		add_hotplug_env_var(envp, num_envp, &i,
+				    buffer, buffer_size, &length,
+				    "MINOR=%u", MINOR(class_dev->devt));
+	}
+
+	/* terminate, set to next free slot, shrink available space */
+	envp[i] = NULL;
+	envp = &envp[i];
+	num_envp -= i;
+	buffer = &buffer[length];
+	buffer_size -= length;
+
 	if (class_dev->class->hotplug) {
 		/* have the bus specific function add its stuff */
 		retval = class_dev->class->hotplug (class_dev, envp, num_envp,
@@ -388,6 +397,12 @@ static void class_device_remove_attrs(st
 	}
 }
 
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	return print_dev_t(buf, class_dev->devt);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
 void class_device_initialize(struct class_device *class_dev)
 {
 	kobj_set_kset_s(class_dev, class_obj_subsys);
@@ -432,6 +447,10 @@ int class_device_add(struct class_device
 				class_intf->add(class_dev);
 		up_write(&parent->subsys.rwsem);
 	}
+
+	if (MAJOR(class_dev->devt))
+		class_device_create_file(class_dev, &class_device_attr_dev);
+
 	class_device_add_attrs(class_dev);
 	class_device_dev_link(class_dev);
 	class_device_driver_link(class_dev);
===== include/linux/device.h 1.135 vs edited =====
--- 1.135/include/linux/device.h	2005-01-11 02:29:25 +01:00
+++ edited/include/linux/device.h	2005-01-22 14:56:15 +01:00
@@ -184,6 +184,7 @@ struct class_device {
 
 	struct kobject		kobj;
 	struct class		* class;	/* required */
+	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
 	struct device		* dev;		/* not necessary, but nice to have */
 	void			* class_data;	/* class-specific data */
 

