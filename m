Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVHYC4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVHYC4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVHYC4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:56:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29945 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932503AbVHYCz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:55:59 -0400
Date: Wed, 24 Aug 2005 19:55:53 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: PowerOP Take 2 2/3: sysfs UI core
Message-ID: <20050825025553.GC28662@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A sysfs interface for PowerOP that allows operating points to be created
and activated from userspace.

The platform-specific backend provides the code to read and write sysfs
attributes for each power parameter; the core sysfs interface has no
knowledge of the struct powerop_point contents.  This interface could be
used independently of an integrated cpufreq or DPM interface.  It is not
an integral part of PowerOP and is provided in part to facilitate
discussion and experimentation with PowerOP, but could serve as a basis
for a basic userspace power policy management stack.

Operating points are created by writing the name of the operating point
to /sys/powerop/new.  This may be a job for configfs.
/sys/powerop/<op>/ will contain an attribute for each power parameter
that may be written to set the associated parameter for the new
operating point.  An operating point may be activated by writing its
name to /sys/powerop/active.  The hardware power parameters currently
set may be read and written via /sys/powerop/hw/, a special operating
point that reads and writes parameter attribute values immediately,
primarily for diagnostic purposes.

Buried in this interface is also the notion of a registry of "named
operating points", allowing operating points created by some other
interface (such as cpufreq or loading a module with the definitions as
suggested previously by David Brownell) to be activated from userspace
via /sys/powerop/active.

Changing operating points (or other power-policy-based information that
triggers changes in operating points) from userspace is a common
scenario in some embedded systems, where power/performance needs change
based on system state changes that are coordinated by a userspace
process (for example, a mobile phone starting a multimedia application).

Index: linux-2.6.13-rc4/drivers/powerop/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6.13-rc4/drivers/powerop/Kconfig
@@ -0,0 +1,4 @@
+config POWEROP_SYSFS
+	bool "  Enable PowerOP sysfs interface"
+	depends on POWEROP && SYSFS
+	help
Index: linux-2.6.13-rc4/drivers/powerop/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.13-rc4/drivers/powerop/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_POWEROP_SYSFS)	+= powerop_sysfs.o
Index: linux-2.6.13-rc4/drivers/powerop/powerop_sysfs.c
===================================================================
--- /dev/null
+++ linux-2.6.13-rc4/drivers/powerop/powerop_sysfs.c
@@ -0,0 +1,398 @@
+/*
+ * PowerOP sysfs UI
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
+#include <linux/powerop_sysfs.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+
+#include <asm/powerop.h>
+
+int powerop_register_point(const char *id, struct powerop_point *point);
+int powerop_select_point(const char *id);
+
+struct namedop {
+	struct kobject kobj;
+	struct powerop_point *point;
+	struct list_head node;
+	struct completion released;
+};
+
+#define to_namedop(_kobj) container_of(_kobj,\
+	struct namedop,kobj)
+
+static DECLARE_MUTEX(namedop_list_mutex);
+static struct list_head namedop_list;
+static struct namedop *activeop;
+
+struct sysfsop {
+	struct powerop_point point;
+	struct list_head node;
+};
+
+static DECLARE_MUTEX(sysfsop_list_mutex);
+static struct list_head sysfsop_list;
+
+static struct powerop_point *hwop;
+
+#define powerop_attr(_name) \
+static struct subsys_attribute _name##_attr = { \
+	.attr   = {				\
+		.name = __stringify(_name),	\
+		.mode = 0644,			\
+		.owner = THIS_MODULE,		\
+	},					\
+	.show   = _name##_show,                 \
+	.store  = _name##_store,                \
+}
+
+static struct attribute_group param_attr_group;
+
+#define to_powerop_param_attr(_attr) container_of(_attr,\
+	struct powerop_param_attribute,attr)
+
+
+decl_subsys(powerop, NULL, NULL);
+static int subsys_reg;
+static int sysfs_init;
+
+static void namedop_release(struct kobject *kobj)
+{
+	struct namedop *op = to_namedop(kobj);
+
+	complete(&op->released);
+	return;
+}
+
+static struct sysfsop *sysfsop_create(const char *id)
+{
+	struct sysfsop *op;
+	int error;
+
+	if ((op = kmalloc(sizeof(struct sysfsop), GFP_KERNEL)) == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	down(&sysfsop_list_mutex);
+	list_add_tail(&op->node, &sysfsop_list);
+	up(&sysfsop_list_mutex);
+	memset(&op->point, 0, sizeof(struct powerop_point));
+	return (error = powerop_register_point(id, &op->point)) == 0
+		? op : ERR_PTR(error);
+}
+
+static ssize_t
+powerop_param_attr_show(struct kobject * kobj, struct attribute * attr,
+			char * buf)
+{
+	struct powerop_param_attribute * param_attr =
+		to_powerop_param_attr(attr);
+	struct namedop * namedop = to_namedop(kobj);
+	ssize_t ret = 0;
+
+	if (namedop->point == hwop)
+		powerop_get_point(hwop);
+
+	if (param_attr->show)
+		ret = param_attr->show(namedop->point,buf);
+
+	return ret;
+}
+
+static ssize_t
+powerop_param_attr_store(struct kobject * kobj, struct attribute * attr,
+			 const char * buf, size_t count)
+{
+	struct powerop_param_attribute * param_attr =
+		to_powerop_param_attr(attr);
+	struct namedop * namedop = to_namedop(kobj);
+	ssize_t ret = 0;
+
+	if (namedop->point == hwop)
+		powerop_get_point(hwop);
+
+        if (param_attr->store)
+                ret = param_attr->store(namedop->point,buf,count);
+
+	if (namedop->point == hwop)
+		powerop_set_point(hwop);
+
+	return ret;
+}
+
+static struct sysfs_ops namedop_sysfs_ops = {
+	.show	= powerop_param_attr_show,
+	.store	= powerop_param_attr_store,
+};
+
+static struct kobj_type ktype_namedop = {
+	.release        = namedop_release,
+	.sysfs_ops	= &namedop_sysfs_ops,
+};
+
+static ssize_t new_show(struct subsystem * subsys, char * buf)
+{
+	return 0;
+}
+
+static ssize_t new_store(struct subsystem * subsys, const char * buf,
+			 size_t n)
+{
+	struct sysfsop *op;
+
+	return IS_ERR(op = sysfsop_create(buf)) ? PTR_ERR(op) : n;
+}
+
+
+powerop_attr(new);
+
+static ssize_t active_show(struct subsystem * subsys, char * buf)
+{
+	int ret = 0;
+
+	down(&namedop_list_mutex);
+	if (activeop)
+		ret = sprintf(buf, "%s\n", activeop->kobj.name);
+	up(&namedop_list_mutex);
+
+	return ret;
+}
+
+static ssize_t active_store(struct subsystem * subsys, const char * buf,
+			    size_t n)
+{
+	int error;
+
+	return (error = powerop_select_point(buf)) == 0 ? n : error;
+}
+
+powerop_attr(active);
+
+static struct attribute * g[] = {
+	&new_attr.attr,
+	&active_attr.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = g,
+};
+
+
+
+static int create_namedop_attrs(struct namedop *op)
+{
+	int error = 0;
+
+	if (param_attr_group.attrs)
+		if ((error = sysfs_create_group(&op->kobj,
+						&param_attr_group)))
+			printk(KERN_ERR
+			       "sysfs_create_group for op %s failed.\n",
+			       op->kobj.name);
+	return error;
+}
+
+static void remove_namedop_attrs(struct namedop *op)
+{
+	if (param_attr_group.attrs)
+		sysfs_remove_group(&op->kobj, &param_attr_group);
+}
+
+int powerop_register_point(const char *id, struct powerop_point *point)
+{
+	struct namedop *op;
+	int error;
+
+	if ((op = kmalloc(sizeof(struct namedop), GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	memset(op, 0, sizeof(struct namedop));
+	kobject_set_name(&op->kobj, id);
+	op->point = point;
+
+	op->kobj.ktype = &ktype_namedop;
+	op->kobj.kset = &powerop_subsys.kset;
+	init_completion(&op->released);
+
+	if ((error = kobject_register(&op->kobj))) {
+		printk(KERN_ERR
+		       "PowerOP kobject_register for op %s failed.\n",
+		       id);
+		kfree(op);
+		return error;
+	}
+
+	create_namedop_attrs(op);
+	down(&namedop_list_mutex);
+	list_add_tail(&op->node, &namedop_list);
+	up(&namedop_list_mutex);
+	return 0;
+}
+
+
+static void remove_namedop(struct namedop *op)
+{
+	list_del(&op->node);
+	remove_namedop_attrs(op);
+	kobject_unregister(&op->kobj);
+	wait_for_completion(&op->released);
+	kfree(op);
+}
+
+int powerop_unregister_point(const char *id)
+{
+	struct namedop *op, *tmpop;
+	int ret = -EINVAL;
+
+	down(&namedop_list_mutex);
+
+	list_for_each_entry_safe(op, tmpop, &namedop_list, node) {
+		if (strcmp(op->kobj.name, id) == 0) {
+			remove_namedop(op);
+			ret = 0;
+			break;
+		}
+	}
+
+	up(&namedop_list_mutex);
+	return ret;
+}
+
+int powerop_select_point(const char *id)
+{
+	struct namedop *op, *selectedop = NULL;
+	int ret;
+	down(&namedop_list_mutex);
+
+	list_for_each_entry(op, &namedop_list, node) {
+		if (strcmp(op->kobj.name, id) == 0) {
+			selectedop = op;
+			break;
+		}
+	}
+
+	ret = (selectedop == NULL) ?
+		-EINVAL : powerop_set_point(op->point);
+
+	if (ret == 0)
+		activeop = selectedop;
+
+	up(&namedop_list_mutex);
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(powerop_register_point);
+EXPORT_SYMBOL_GPL(powerop_unregister_point);
+EXPORT_SYMBOL_GPL(powerop_select_point);
+
+int powerop_sysfs_register(struct attribute **param_attrs)
+{
+	struct namedop *namedop;
+
+	if (param_attr_group.attrs)
+		return -EBUSY;
+
+	param_attr_group.attrs = param_attrs;
+
+	if (! sysfs_init)
+		return 0;
+
+	down(&namedop_list_mutex);
+	list_for_each_entry(namedop, &namedop_list, node)
+		create_namedop_attrs(namedop);
+        up(&namedop_list_mutex);
+	return 0;
+}
+
+void powerop_sysfs_unregister(struct attribute **param_attrs)
+{
+	struct namedop *namedop;
+
+	if ((param_attr_group.attrs != param_attrs) || !sysfs_init)
+		return;
+
+	down(&namedop_list_mutex);
+	list_for_each_entry(namedop, &namedop_list, node)
+		remove_namedop_attrs(namedop);
+        up(&namedop_list_mutex);
+
+	param_attr_group.attrs = NULL;
+}
+
+EXPORT_SYMBOL_GPL(powerop_sysfs_register);
+EXPORT_SYMBOL_GPL(powerop_sysfs_unregister);
+
+static int __init powerop_sysfs_init(void)
+{
+	struct sysfsop *sysfsop;
+        int error;
+
+	if ((error = subsystem_register(&powerop_subsys))) {
+		printk(KERN_ERR
+		       "PowerOP SysFS subsystem_register failed.\n");
+		return error;
+	}
+
+	subsys_reg = 1;
+
+	if ((error =
+	     sysfs_create_group(&powerop_subsys.kset.kobj,&attr_group))) {
+		printk(KERN_ERR
+		       "PowerOP subsys sysfs_create_group failed.\n");
+		return error;
+	}
+
+	INIT_LIST_HEAD(&namedop_list);
+	INIT_LIST_HEAD(&sysfsop_list);
+
+	if (! IS_ERR(sysfsop = sysfsop_create("hw")))
+		hwop = &sysfsop->point;
+
+	sysfs_init = 1;
+        return 0;
+}
+
+static void __exit powerop_sysfs_exit(void)
+{
+	struct namedop *namedop, *tnamedop;
+	struct sysfsop *sysfsop, *tsysfsop;
+
+	powerop_sysfs_unregister(param_attr_group.attrs);
+
+	down(&namedop_list_mutex);
+	list_for_each_entry_safe(namedop, tnamedop, &namedop_list, node)
+		remove_namedop(namedop);
+        up(&namedop_list_mutex);
+
+	down(&sysfsop_list_mutex);
+	list_for_each_entry_safe(sysfsop, tsysfsop, &sysfsop_list, node) {
+		list_del(&sysfsop->node);
+		kfree(sysfsop);
+	}
+	up(&sysfsop_list_mutex);
+
+	if (subsys_reg) {
+		sysfs_remove_group(&powerop_subsys.kset.kobj,&attr_group);
+		subsystem_unregister(&powerop_subsys);
+	}
+}
+
+module_init(powerop_sysfs_init);
+module_exit(powerop_sysfs_exit);
+
+MODULE_DESCRIPTION("PowerOP Power Management SysFS UI");
+MODULE_LICENSE("GPL");
Index: linux-2.6.13-rc4/drivers/Makefile
===================================================================
--- linux-2.6.13-rc4.orig/drivers/Makefile
+++ linux-2.6.13-rc4/drivers/Makefile
@@ -66,3 +66,4 @@ obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_POWEROP)		+= powerop/
Index: linux-2.6.13-rc4/include/linux/powerop_sysfs.h
===================================================================
--- /dev/null
+++ linux-2.6.13-rc4/include/linux/powerop_sysfs.h
@@ -0,0 +1,41 @@
+/*
+ * PowerOP SysFS UI
+ *
+ * Author: Todd Poynor <tpoynor@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __POWEROP_SYSFS_H__
+#define __POWEROP_SYSFS_H__
+
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <asm/powerop.h>
+
+struct powerop_param_attribute {
+        struct attribute        attr;
+        ssize_t (*show)(struct powerop_point *op, char * buf);
+        ssize_t (*store)(struct powerop_point *op, const char * buf, size_t count);};
+
+#define powerop_param_attr(_name) \
+static struct powerop_param_attribute _name##_attr = { \
+	.attr   = {				\
+		.name = __stringify(_name),	\
+		.mode = 0644,			\
+		.owner = THIS_MODULE,		\
+	},					\
+	.show   = _name##_show,			\
+	.store  = _name##_store,		\
+}
+
+int powerop_register_point(const char *id, struct powerop_point *point);
+int powerop_unregister_point(const char *id);
+int powerop_select_point(const char *id);
+int powerop_sysfs_register(struct attribute **param_attrs);
+void powerop_sysfs_unregister(struct attribute **param_attrs);
+
+#endif /*__POWEROP_SYSFS_H__*/
