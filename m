Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUD2U1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUD2U1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUD2U1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:27:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59378 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264959AbUD2U07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:26:59 -0400
Date: Thu, 29 Apr 2004 13:26:54 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Cc: tpoynor@mvista.com
Subject: [PATCH] Hotplug for device power state changes
Message-ID: <20040429202654.GA9971@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch to call a hotplug device-power agent when the power state of a
device is modified at runtime (that is, individually via sysfs or by a
driver call, not as part of a system suspend/resume).  Allows a power
management application to be informed of changes in device power needs.
This can be useful on platforms with dependencies between system
clock/voltage settings and operation of certain devices (such as
PXA27x), or, for example, on a cell phone where voiceband or network
devices going inactive signals an opportunity to lower platform power
levels to conserve battery life.

Implemented via new class device-power, with which all devices register.
I'm interested in comments on this approach and in alternate
suggestions.  Perhaps device-power should be an "opt-in" class, since
power state changes won't be a concern for most devices/platforms/applications.


--- linux-2.6.5-orig/drivers/base/power/runtime.c	2004-03-11 15:02:22.000000000 -0800
+++ linux-2.6.5-pm/drivers/base/power/runtime.c	2004-04-28 16:51:37.000000000 -0700
@@ -33,6 +33,7 @@
 	down(&dpm_sem);
 	runtime_resume(dev);
 	up(&dpm_sem);
+	dpm_notify(dev);
 }
 
 
@@ -53,8 +54,10 @@
 	if (dev->power.power_state)
 		runtime_resume(dev);
 
-	if (!(error = suspend_device(dev,state)))
+	if (!(error = suspend_device(dev,state))) {
 		dev->power.power_state = state;
+		dpm_notify(dev);
+	}
  Done:
 	up(&dpm_sem);
 	return error;

--- linux-2.6.5-orig/drivers/base/power/sysfs.c	2004-03-11 14:57:55.000000000 -0800
+++ linux-2.6.5-pm/drivers/base/power/sysfs.c	2004-04-29 12:41:32.962625032 -0700
@@ -3,6 +3,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/init.h>
 #include "power.h"
 
 
@@ -57,12 +58,81 @@
 	.attrs	= power_attrs,
 };
 
+#ifdef CONFIG_HOTPLUG
+static int
+device_power_hotplug(struct class_device *class_dev, char **envp,
+		     int num_envp, char *buffer, int buffer_size)
+{
+	struct device * dev = (struct device *) class_dev->class_data;
+	int i = 0;
+	int length = 0;
+
+	envp[i++] = buffer;
+	length += scnprintf (buffer, buffer_size - length, "STATE=%d",
+			     dev->power.power_state);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+
+	envp[i] = 0;
+
+	return 0;
+}
+#endif
+
+static void
+device_power_dev_release(struct class_device *class_dev)
+{
+	if (class_dev)
+		kfree(class_dev);
+}
+
+void dpm_notify(struct device * dev)
+{
+#ifdef CONFIG_HOTPLUG
+	kobject_hotplug("state-change", &dev->power.class_dev->kobj);
+#endif
+}
+
+static struct class device_power_class = {
+	.name		= "device-power",
+#ifdef CONFIG_HOTPLUG
+	.hotplug	= device_power_hotplug,
+#endif
+	.release	= device_power_dev_release,
+};
+
+
 int dpm_sysfs_add(struct device * dev)
 {
+	struct class_device *class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+
+	if (class_dev) {
+		memset(class_dev, 0, sizeof (*class_dev));
+		dev->power.class_dev = class_dev;
+		class_dev->class = &device_power_class;
+		class_dev->class_data = dev;
+		strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
+		class_device_register(class_dev);
+	}
+
 	return sysfs_create_group(&dev->kobj,&pm_attr_group);
 }
 
 void dpm_sysfs_remove(struct device * dev)
 {
+	struct class_device *class_dev = dev->power.class_dev;
+
+	if (class_dev) {
+		class_device_unregister(class_dev);
+		dev->power.class_dev = NULL;
+	}
+
 	sysfs_remove_group(&dev->kobj,&pm_attr_group);
 }
+
+int __init dpm_init(void)
+{
+	return class_register(&device_power_class);
+}
+

--- linux-2.6.5-orig/drivers/base/power/power.h	2004-03-11 14:57:55.000000000 -0800
+++ linux-2.6.5-pm/drivers/base/power/power.h	2004-04-28 16:53:52.000000000 -0700
@@ -54,6 +54,7 @@
 
 extern int dpm_sysfs_add(struct device *);
 extern void dpm_sysfs_remove(struct device *);
+extern void dpm_notify(struct device *);
 
 /*
  * resume.c 

--- linux-2.6.5-orig/drivers/base/init.c	2004-03-11 15:02:22.000000000 -0800
+++ linux-2.6.5-pm/drivers/base/init.c	2004-04-28 16:56:25.000000000 -0700
@@ -14,6 +14,7 @@
 extern int buses_init(void);
 extern int classes_init(void);
 extern int firmware_init(void);
+extern int dpm_init(void);
 extern int platform_bus_init(void);
 extern int system_bus_init(void);
 extern int cpu_dev_init(void);
@@ -31,6 +32,7 @@
 	devices_init();
 	buses_init();
 	classes_init();
+	dpm_init();
 	firmware_init();
 
 	/* These are also core pieces, but must come after the 

--- linux-2.6.5-orig/include/linux/pm.h	2004-03-11 14:58:50.000000000 -0800
+++ linux-2.6.5-pm/include/linux/pm.h	2004-04-28 16:55:31.000000000 -0700
@@ -227,6 +227,7 @@
  */
 
 struct device;
+struct class_device;
 
 struct dev_pm_info {
 #ifdef	CONFIG_PM
@@ -234,6 +235,7 @@
 	u8			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;
+	struct class_device	* class_dev;
 	struct list_head	entry;
 #endif
 };


-- 
Todd Poynor
MontaVista Software

