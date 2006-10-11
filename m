Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030650AbWJKGLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030650AbWJKGLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030655AbWJKGLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:11:14 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:4894 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1030650AbWJKGLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:11:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAFonLEWMCCw
Message-Id: <20061011061030.382045208.dtor@insightbb.com>
References: <20061011060138.920913139.dtor@insightbb.com>
Date: Wed, 11 Oct 2006 02:01:41 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-pm@lists.osdl.org
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, pavel@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: [RFC/PATCH 3/3] add class_devices to power management list
Content-Disposition: inline; filename=class_device-to-dpm-tree.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PM: add class_devices to power management list

pause() and restart() methods are added to struct class. These
methods are called for each class_device that belongs to class
that has them defined. pause() is called at suspend time and
restart() at resume time.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c         |    9 +++++++++
 drivers/base/power/main.c    |   33 +++++++++++++++++++++++++++++++++
 drivers/base/power/power.h   |   14 ++++++++++++++
 drivers/base/power/resume.c  |   31 +++++++++++++++++++++++++++++++
 drivers/base/power/suspend.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h       |    6 ++++++
 6 files changed, 135 insertions(+)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include "base.h"
+#include "power/power.h"
 
 extern struct subsystem devices_subsys;
 
@@ -612,6 +613,10 @@ int class_device_add(struct class_device
 	if (error)
 		goto out8;
 
+	error = class_device_pm_add(class_dev);
+	if (error)
+		goto out9;
+
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
 	/* notify any interfaces this device is now here */
@@ -625,6 +630,8 @@ int class_device_add(struct class_device
 
 	goto out1;
 
+ out9:
+	class_device_remove_groups(class_dev);
  out8:
 	if (class_dev->dev)
 		sysfs_remove_link(&class_dev->kobj, class_name);
@@ -734,6 +741,8 @@ void class_device_del(struct class_devic
 		up(&parent_class->sem);
 	}
 
+	class_device_pm_remove(class_dev);
+
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev->class->name,
 					     &class_dev->kobj);
Index: work/drivers/base/power/main.c
===================================================================
--- work.orig/drivers/base/power/main.c
+++ work/drivers/base/power/main.c
@@ -112,4 +112,37 @@ void device_pm_remove(struct device * de
 	dpm_delete_object(&dev->power);
 }
 
+static const struct dev_pm_ops class_device_pm_ops = {
+	.suspend	= suspend_class_device,
+	.resume		= resume_class_device,
+};
+
+int class_device_pm_add(struct class_device *dev)
+{
+	int error;
+
+	pr_debug("PM: Adding info for %s:%s\n",
+		 dev->class ? dev->class->name : "No Class",
+		 kobject_name(&dev->kobj));
+
+	dev->power.pm_object = &dev->kobj;
+	dev->power.pm_ops = &class_device_pm_ops;
+	if (dev->parent)
+		dpm_set_parent(&dev->power, &dev->parent->power);
+	error = dpm_add_object(&dev->power);
+	if (error)
+		return error;
+
+	return error;
+}
+
+void class_device_pm_remove(struct class_device * dev)
+{
+	pr_debug("PM: Removing info for %s:%s\n",
+		 dev->class ? dev->class->name : "No Class",
+		 kobject_name(&dev->kobj));
+
+	dpm_delete_object(&dev->power);
+}
+
 
Index: work/drivers/base/power/power.h
===================================================================
--- work.orig/drivers/base/power/power.h
+++ work/drivers/base/power/power.h
@@ -59,6 +59,9 @@ static inline struct device * to_device(
 extern int device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
 
+extern int class_device_pm_add(struct class_device *);
+extern void class_device_pm_remove(struct class_device *);
+
 /*
  * sysfs.c
  */
@@ -74,12 +77,14 @@ extern void dpm_resume(void);
 extern void dpm_power_up(void);
 extern int resume_device(struct dev_pm_info *);
 extern int resume_device_early(struct dev_pm_info *);
+extern int resume_class_device(struct dev_pm_info *);
 
 /*
  * suspend.c
  */
 extern int suspend_device(struct dev_pm_info *, pm_message_t);
 extern int suspend_device_late(struct dev_pm_info *, pm_message_t);
+extern int suspend_class_device(struct dev_pm_info *, pm_message_t);
 
 
 /*
@@ -98,4 +103,13 @@ static inline void device_pm_remove(stru
 
 }
 
+static inline int class_device_pm_add(struct class_device * dev)
+{
+	return 0;
+}
+static inline void class_device_pm_remove(struct class_device * dev)
+{
+
+}
+
 #endif
Index: work/drivers/base/power/suspend.c
===================================================================
--- work.orig/drivers/base/power/suspend.c
+++ work/drivers/base/power/suspend.c
@@ -120,6 +120,48 @@ int suspend_device_late(struct dev_pm_in
 }
 
 /**
+ *	suspend_class_device - Save state of one device.
+ *	@dev:	Device.
+ *	@state:	Power state device is entering.
+ */
+
+int suspend_class_device(struct dev_pm_info *dpm, pm_message_t state)
+{
+	int error = 0;
+	struct class_device *dev = container_of(dpm, struct class_device,
+						power);
+	struct dev_pm_info *dpm_parent;
+
+	if (dpm->power_state.event)
+		pm_dbg(dpm, "PM: suspend %d-->%d\n",
+			dpm->power_state.event, state.event);
+
+	dpm_parent = dev->power.pm_parent;
+	if (dpm_parent && dpm_parent->power_state.event)
+		pm_err(dpm, "PM: suspend %d->%d, parent %s already %d\n",
+			dpm->power_state.event, state.event,
+			kobject_name(dpm_parent->pm_object),
+			dpm_parent->power_state.event);
+
+	dpm->prev_state = dpm->power_state;
+
+	if (dev->class && dev->class->pause && !dpm->power_state.event) {
+		pm_dbg(dpm, "%s%s\n",
+			suspend_verb(state.event),
+			((state.event == PM_EVENT_SUSPEND)
+					&& device_may_wakeup(dev))
+				? ", may wakeup"
+				: ""
+			);
+		error = dev->class->pause(dev);
+		suspend_report_result(dev->class->pause, error);
+	}
+
+	return error;
+}
+
+
+/**
  *	device_suspend - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -171,6 +171,9 @@ struct class {
 
 	int	(*suspend)(struct device *, pm_message_t state);
 	int	(*resume)(struct device *);
+
+	int	(*pause)(struct class_device *dev);
+	int	(*restart)(struct class_device *dev);
 };
 
 extern int __must_check class_register(struct class *);
@@ -241,9 +244,12 @@ struct class_device {
 	struct class_device	*parent;	/* parent of this child device, if there is one */
 	struct attribute_group  ** groups;	/* optional groups */
 
+	struct dev_pm_info	power;
+
 	void	(*release)(struct class_device *dev);
 	int	(*uevent)(struct class_device *dev, char **envp,
 			   int num_envp, char *buffer, int buffer_size);
+
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
 };
 
Index: work/drivers/base/power/resume.c
===================================================================
--- work.orig/drivers/base/power/resume.c
+++ work/drivers/base/power/resume.c
@@ -64,6 +64,37 @@ int resume_device_early(struct dev_pm_in
 	return error;
 }
 
+/**
+ *	resume_class_device - Restore state for one device.
+ *	@dev:	Device.
+ *
+ */
+
+int resume_class_device(struct dev_pm_info *dpm)
+{
+	int error = 0;
+	struct class_device *dev = container_of(dpm, struct class_device,
+						power);
+	struct dev_pm_info *pm_parent = dpm->pm_parent;
+
+	TRACE_DEVICE(dpm);
+	TRACE_RESUME(0);
+
+	if (pm_parent && pm_parent->power_state.event) {
+		pm_err(dpm, "resume from %d, parent %s still %d\n",
+			dpm->power_state.event,
+			kobject_name(pm_parent->pm_object),
+			pm_parent->power_state.event);
+	}
+
+	if (dev->class && dev->class->restart) {
+		pm_dbg(dpm, "class restart\n");
+		error = dev->class->restart(dev);
+	}
+
+	TRACE_RESUME(error);
+	return error;
+}
 
 /*
  * Resume the devices that have either not gone through
