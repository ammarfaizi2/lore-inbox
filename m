Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVHICwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVHICwB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 22:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVHICwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 22:52:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16629 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932422AbVHICwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 22:52:00 -0400
Date: Mon, 8 Aug 2005 19:51:57 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: PowerOP 1/3: PowerOP core
Message-ID: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PowerOP core provides the struct powerop_point that defines an
operating point, and trivial routines for calling the platform-specific
backend to read and set operating points and for registering a single
machine-dependent backend.

Operating points are an array of 32-bit integer-valued power parameters,
almost entirely interpreted by the platform-specific backend.
Higher-layer software shares information on the power parameters made
available by the backend (that is, the interpretation of the integers in
the array) via header files.  The value -1 is commonly used to denote an
unspecified value, but in situations where all ones is a valid power
parameter value some extra smarts may be needed.

It optionally adds sysfs attributes for reading and writing individual
power parameter values, mainly for diagnostic purposes.  For example,
using the Intel Centrino patch that follows, parameters for frequency
and core voltage for CPU #0 appear:

   # ls /sys/powerop/param/
   cpu0 v0

Index: linux-2.6.12/drivers/Makefile
===================================================================
--- linux-2.6.12.orig/drivers/Makefile	2005-06-30 01:32:17.000000000 +0000
+++ linux-2.6.12/drivers/Makefile	2005-07-29 00:39:44.000000000 +0000
@@ -58,6 +58,7 @@
 obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
+obj-$(CONFIG_POWEROP)		+= powerop/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
Index: linux-2.6.12/drivers/powerop/Kconfig
===================================================================
--- linux-2.6.12.orig/drivers/powerop/Kconfig	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/drivers/powerop/Kconfig	2005-07-28 07:27:26.000000000 +0000
@@ -0,0 +1,17 @@
+#
+# powerop
+#
+
+menu "Platform Core Power Management"
+
+config POWEROP
+	bool "PowerOP Platform Core Power Management"
+	help
+
+config POWEROP_SYSFS
+	bool "  Enable PowerOP sysfs interface"
+	depends on POWEROP && SYSFS
+	help
+
+endmenu
+
Index: linux-2.6.12/drivers/powerop/Makefile
===================================================================
--- linux-2.6.12.orig/drivers/powerop/Makefile	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/drivers/powerop/Makefile	2005-07-28 07:29:04.000000000 +0000
@@ -0,0 +1,2 @@
+obj-$(CONFIG_POWEROP)		+= powerop.o
+
Index: linux-2.6.12/drivers/powerop/powerop.c
===================================================================
--- linux-2.6.12.orig/drivers/powerop/powerop.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/drivers/powerop/powerop.c	2005-08-04 19:50:38.000000000 +0000
@@ -0,0 +1,253 @@
+/*
+ * PowerOP generic core functions
+ *
+ * Author: Todd Poynor <tpoynor@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/powerop.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+
+static struct powerop_driver *powerop_driver;
+static int powerop_subsys_init;
+
+int
+powerop_set_point(struct powerop_point *point)
+{
+	return powerop_driver && powerop_driver->set_point ? 
+		powerop_driver->set_point(point) : -EINVAL;
+}
+
+
+int
+powerop_get_point(struct powerop_point *point)
+{
+	return powerop_driver && powerop_driver->get_point ? 
+		powerop_driver->get_point(point) : -EINVAL;
+}
+
+
+EXPORT_SYMBOL_GPL(powerop_set_point);
+EXPORT_SYMBOL_GPL(powerop_get_point);
+
+#ifdef CONFIG_POWEROP_SYSFS
+decl_subsys(powerop, NULL, NULL);
+
+static void powerop_kobj_release(struct kobject *kobj)
+{
+	return;
+}
+
+struct powerop_param_attribute {
+	int index;
+        struct attribute        attr;
+};
+
+#define to_param_attr(_attr) container_of(_attr,\
+	struct powerop_param_attribute,attr)
+
+static ssize_t
+powerop_param_attr_show(struct kobject * kobj, struct attribute * attr,
+			char * buf)
+{
+	struct powerop_param_attribute * param_attr = to_param_attr(attr);
+	struct powerop_point point;
+	ssize_t ret = 0;
+
+	if ((ret = powerop_get_point(&point)) == 0)
+		ret = sprintf(buf, "%d\n", point.param[param_attr->index]);
+	return ret;
+}
+
+static ssize_t
+powerop_param_attr_store(struct kobject * kobj, struct attribute * attr, 
+			 const char * buf, size_t count)
+{
+	struct powerop_param_attribute * param_attr = to_param_attr(attr);
+	struct powerop_point point;
+	int i;
+	ssize_t ret = 0;
+
+	for (i = 0; i < powerop_driver->nr_params; i++) 
+		if (i == param_attr->index)
+			point.param[i] = simple_strtol(buf,NULL,0);
+		else
+			point.param[i] = -1;
+
+	if ((ret = powerop_set_point(&point)) == 0)
+		ret = count;
+
+	return ret;
+}
+
+static struct sysfs_ops powerop_param_attr_sysfs_ops = {
+	.show	= powerop_param_attr_show,
+	.store	= powerop_param_attr_store,
+};
+
+static struct kobj_type ktype_powerop_driver = {
+	.release        = powerop_kobj_release,
+	.sysfs_ops	= &powerop_param_attr_sysfs_ops,
+};
+
+static struct powerop_param_attribute *param_attr[POWEROP_DRIVER_MAX_PARAMS];
+
+static int powerop_driver_sysfs_register(struct powerop_driver *powerop_driver)
+{
+        int error, i;
+
+	if (! powerop_subsys_init)
+		return 0;
+
+	kobject_set_name(&powerop_driver->kobj, "param");
+	powerop_driver->kobj.ktype = &ktype_powerop_driver;
+	powerop_driver->kobj.kset = &powerop_subsys.kset;
+
+	if ((error = kobject_register(&powerop_driver->kobj))) {
+		printk(KERN_ERR "kobject_register for PowerOP driver failed.\n");
+		return error;
+	}
+
+	for (i = 0; i < powerop_driver->nr_params; i++) {
+		if (! (param_attr[i] = 
+		       kmalloc(sizeof(struct powerop_param_attribute),
+			       GFP_KERNEL))) {
+			printk(KERN_ERR "PowerOP: kmalloc failed.\n");
+			return -ENOMEM;
+		}
+
+		memset(param_attr[i], 0, 
+		       sizeof(struct powerop_param_attribute));
+		param_attr[i]->index = i;
+		param_attr[i]->attr.name = 
+			powerop_driver->param_names[i];
+		param_attr[i]->attr.mode = 0644;
+		if ((error = sysfs_create_file(&powerop_driver->kobj,
+					       &param_attr[i]->attr))) {
+			printk(KERN_ERR "sysfs_create_file for PowerOP param failed.\n");
+			return error;
+		}
+	}
+
+        return error;
+}
+
+static int __init powerop_sysfs_init(void)
+{
+        int error;
+
+	if ((error = subsystem_register(&powerop_subsys)))
+		printk(KERN_ERR "PowerOP subsystem register failed.\n");
+	else
+		powerop_subsys_init = 1;
+	
+
+	if (! error && powerop_driver)
+		error = powerop_driver_sysfs_register(powerop_driver);
+
+
+        return error;
+}
+
+static void powerop_driver_sysfs_unregister(struct powerop_driver *powerop_driver)
+{
+	int i;
+
+	if (! powerop_subsys_init || ! powerop_driver)
+		return;
+
+	for (i = 0; i < powerop_driver->nr_params; i++) {
+		if (param_attr[i]) {
+			sysfs_remove_file(&powerop_driver->kobj,
+					  &param_attr[i]->attr);
+			kfree(param_attr[i]);
+			param_attr[i] = 0;
+		}
+	}
+
+	kobject_unregister(&powerop_driver->kobj);
+}
+
+static void __exit powerop_sysfs_exit(void)
+{
+	powerop_driver_sysfs_unregister(powerop_driver);
+
+	if (powerop_subsys_init)
+		subsystem_unregister(&powerop_subsys);
+}
+
+#else /* CONFIG_POWEROP_SYSFS */
+static int powerop_driver_sysfs_init(struct powerop_driver *powerop_driver)
+{
+	return 0;
+}
+
+static int __init powerop_sysfs_init(void)
+{
+	return 0;
+}
+
+static void powerop_driver_sysfs_unregister(struct powerop_driver *powerop_driver)
+{
+}
+
+static void __exit powerop_sysfs_exit(void)
+{
+}
+#endif /* CONFIG_POWEROP_SYSFS */
+
+int powerop_driver_register(struct powerop_driver *p)
+{
+	int error;
+
+	if (! powerop_driver) {
+		printk(KERN_INFO "PowerOP registering driver %s.\n", p->name);
+		if ((error = powerop_driver_sysfs_register(p)))
+			powerop_driver_sysfs_unregister(p);
+		else
+			powerop_driver = p;
+
+	} else
+		error = -EBUSY;
+
+	return error;
+}
+
+
+void powerop_driver_unregister(struct powerop_driver *p)
+{
+	if (powerop_driver == p) {
+		printk(KERN_INFO "PowerOP unregistering driver %s.\n", p->name);
+		powerop_driver_sysfs_unregister(powerop_driver);
+		powerop_driver = NULL;
+	}
+}
+
+EXPORT_SYMBOL_GPL(powerop_driver_register);
+EXPORT_SYMBOL_GPL(powerop_driver_unregister);
+
+static int __init powerop_init(void)
+{
+        return powerop_sysfs_init();
+}
+
+static void __exit powerop_exit(void)
+{
+	powerop_sysfs_exit();
+}
+
+module_init(powerop_init);
+module_exit(powerop_exit);
+
+MODULE_DESCRIPTION("PowerOP Power Management");
+MODULE_LICENSE("GPL");
Index: linux-2.6.12/include/linux/powerop.h
===================================================================
--- linux-2.6.12.orig/include/linux/powerop.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/include/linux/powerop.h	2005-08-03 01:10:55.000000000 +0000
@@ -0,0 +1,36 @@
+/*
+ * PowerOP core definitions
+ *
+ * Author: Todd Poynor <tpoynor@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __POWEROP_H__
+#define __POWEROP_H__
+
+#include <linux/kobject.h>
+#include <asm/powerop.h>
+
+struct powerop_point {
+	int param[POWEROP_DRIVER_MAX_PARAMS];
+};
+
+struct powerop_driver {
+	char *name;
+	struct kobject kobj;
+	int nr_params;
+	char **param_names;
+	int (*set_point)(struct powerop_point *point);
+	int (*get_point)(struct powerop_point *point);
+};
+
+int powerop_set_point(struct powerop_point *point);
+int powerop_get_point(struct powerop_point *point);
+int powerop_driver_register(struct powerop_driver *p);
+void powerop_driver_unregister(struct powerop_driver *p);
+
+#endif /*__POWEROP_H__*/
