Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVCJCkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVCJCkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVCJBPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:15:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:53919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262625AbVCJAma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:30 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] class core: export MAJOR/MINOR to the hotplug env
In-Reply-To: <11104148792069@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:40 -0800
Message-Id: <1110414880513@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2039, 2005/03/09 09:32:38-08:00, kay.sievers@vrfy.org

[PATCH] class core: export MAJOR/MINOR to the hotplug env

Move the creation of the sysfs "dev" file of a class device into the
driver core. The struct class_device contains a dev_t value now.  If set,
the driver core will create the "dev" file containing the major/minor
numbers automatically.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/class.c   |   39 +++++++++++++++++++++++++++++----------
 include/linux/device.h |    1 +
 2 files changed, 30 insertions(+), 10 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2005-03-09 16:29:55 -08:00
+++ b/drivers/base/class.c	2005-03-09 16:29:55 -08:00
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/kdev_t.h>
 #include "base.h"
 
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
@@ -298,9 +299,9 @@
 			 int num_envp, char *buffer, int buffer_size)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
-	int retval = 0;
 	int i = 0;
 	int length = 0;
+	int retval = 0;
 
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
 
@@ -313,26 +314,34 @@
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
@@ -388,6 +397,12 @@
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
@@ -432,6 +447,10 @@
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
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-09 16:29:55 -08:00
+++ b/include/linux/device.h	2005-03-09 16:29:55 -08:00
@@ -184,6 +184,7 @@
 
 	struct kobject		kobj;
 	struct class		* class;	/* required */
+	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
 	struct device		* dev;		/* not necessary, but nice to have */
 	void			* class_data;	/* class-specific data */
 

