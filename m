Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVCJAzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVCJAzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVCJAxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:53:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:59807 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262634AbVCJAmf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:35 -0500
Cc: paul.mundt@nokia.com
Subject: [PATCH] Add SuperHyway bus subsystem
In-Reply-To: <20050310003746.GA32473@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:38:29 -0800
Message-Id: <11104151091244@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2027.3.1, 2005/03/09 12:14:18-08:00, paul.mundt@nokia.com

[PATCH] Add SuperHyway bus subsystem

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/sh/Makefile                      |    6 
 drivers/sh/superhyway/Makefile           |    7 +
 drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
 drivers/sh/superhyway/superhyway.c       |  201 +++++++++++++++++++++++++++++++
 include/linux/superhyway.h               |   79 ++++++++++++
 5 files changed, 338 insertions(+)


diff -Nru a/drivers/sh/Makefile b/drivers/sh/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/sh/Makefile	2005-03-09 16:36:31 -08:00
@@ -0,0 +1,6 @@
+#
+# Makefile for the SuperH specific drivers.
+#
+
+obj-$(CONFIG_SUPERHYWAY) += superhyway/
+
diff -Nru a/drivers/sh/superhyway/Makefile b/drivers/sh/superhyway/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/sh/superhyway/Makefile	2005-03-09 16:36:31 -08:00
@@ -0,0 +1,7 @@
+#
+# Makefile for the SuperHyway bus drivers.
+#
+
+obj-$(CONFIG_SUPERHYWAY)	+= superhyway.o
+obj-$(CONFIG_SYSFS)		+= superhyway-sysfs.o
+
diff -Nru a/drivers/sh/superhyway/superhyway-sysfs.c b/drivers/sh/superhyway/superhyway-sysfs.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/sh/superhyway/superhyway-sysfs.c	2005-03-09 16:36:31 -08:00
@@ -0,0 +1,45 @@
+/*
+ * drivers/sh/superhyway/superhyway-sysfs.c
+ *
+ * SuperHyway Bus sysfs interface
+ *
+ * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/superhyway.h>
+
+#define superhyway_ro_attr(name, fmt, field)				\
+static ssize_t name##_show(struct device *dev, char *buf)		\
+{									\
+	struct superhyway_device *s = to_superhyway_device(dev);	\
+	return sprintf(buf, fmt, s->field);				\
+}
+
+/* VCR flags */
+superhyway_ro_attr(perr_flags, "0x%02x\n", vcr.perr_flags);
+superhyway_ro_attr(merr_flags, "0x%02x\n", vcr.merr_flags);
+superhyway_ro_attr(mod_vers, "0x%04x\n", vcr.mod_vers);
+superhyway_ro_attr(mod_id, "0x%04x\n", vcr.mod_id);
+superhyway_ro_attr(bot_mb, "0x%02x\n", vcr.bot_mb);
+superhyway_ro_attr(top_mb, "0x%02x\n", vcr.top_mb);
+
+/* Misc */
+superhyway_ro_attr(resource, "0x%08lx\n", resource.start);
+
+struct device_attribute superhyway_dev_attrs[] = {
+	__ATTR_RO(perr_flags),
+	__ATTR_RO(merr_flags),
+	__ATTR_RO(mod_vers),
+	__ATTR_RO(mod_id),
+	__ATTR_RO(bot_mb),
+	__ATTR_RO(top_mb),
+	__ATTR_RO(resource),
+	__ATTR_NULL,
+};
+
diff -Nru a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/sh/superhyway/superhyway.c	2005-03-09 16:36:31 -08:00
@@ -0,0 +1,201 @@
+/*
+ * drivers/sh/superhyway/superhyway.c
+ *
+ * SuperHyway Bus Driver
+ *
+ * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/superhyway.h>
+
+static int superhyway_devices;
+
+static struct device superhyway_bus_device = {
+	.bus_id = "superhyway",
+};
+
+static void superhyway_device_release(struct device *dev)
+{
+	kfree(to_superhyway_device(dev));
+}
+
+/**
+ * superhyway_add_device - Add a SuperHyway module
+ * @mod_id: Module ID (taken from MODULE.VCR.MOD_ID).
+ * @base: Physical address where module is mapped.
+ * @vcr: VCR value.
+ *
+ * This is responsible for adding a new SuperHyway module. This sets up a new
+ * struct superhyway_device for the module being added. Each one of @mod_id,
+ * @base, and @vcr are registered with the new device for further use
+ * elsewhere.
+ *
+ * Devices are initially added in the order that they are scanned (from the
+ * top-down of the memory map), and are assigned an ID based on the order that
+ * they are added. Any manual addition of a module will thus get the ID after
+ * the devices already discovered regardless of where it resides in memory.
+ *
+ * Further work can and should be done in superhyway_scan_bus(), to be sure
+ * that any new modules are properly discovered and subsequently registered.
+ */
+int superhyway_add_device(unsigned int mod_id, unsigned long base,
+			  unsigned long long vcr)
+{
+	struct superhyway_device *dev;
+
+	dev = kmalloc(sizeof(struct superhyway_device), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	memset(dev, 0, sizeof(struct superhyway_device));
+
+	dev->id.id = mod_id;
+	sprintf(dev->name, "SuperHyway device %04x", dev->id.id);
+
+	dev->vcr		= *((struct vcr_info *)(&vcr));
+	dev->resource.name	= dev->name;
+	dev->resource.start	= base;
+	dev->resource.end	= dev->resource.start + 0x01000000;
+	dev->dev.parent		= &superhyway_bus_device;
+	dev->dev.bus		= &superhyway_bus_type;
+	dev->dev.release	= superhyway_device_release;
+
+	sprintf(dev->dev.bus_id, "%02x", superhyway_devices);
+
+	superhyway_devices++;
+
+	return device_register(&dev->dev);
+}
+
+static int __init superhyway_init(void)
+{
+	device_register(&superhyway_bus_device);
+	return superhyway_scan_bus();
+}
+
+postcore_initcall(superhyway_init);
+
+static const struct superhyway_device_id *
+superhyway_match_id(const struct superhyway_device_id *ids,
+		    struct superhyway_device *dev)
+{
+	while (ids->id) {
+		if (ids->id == dev->id.id)
+			return ids;
+
+		ids++;
+	}
+
+	return NULL;
+}
+
+static int superhyway_device_probe(struct device *dev)
+{
+	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
+	struct superhyway_driver *shyway_drv = to_superhyway_driver(dev->driver);
+
+	if (shyway_drv && shyway_drv->probe) {
+		const struct superhyway_device_id *id;
+
+		id = superhyway_match_id(shyway_drv->id_table, shyway_dev);
+		if (id)
+			return shyway_drv->probe(shyway_dev, id);
+	}
+
+	return -ENODEV;
+}
+
+static int superhyway_device_remove(struct device *dev)
+{
+	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
+	struct superhyway_driver *shyway_drv = to_superhyway_driver(dev->driver);
+
+	if (shyway_drv && shyway_drv->remove) {
+		shyway_drv->remove(shyway_dev);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * superhyway_register_driver - Register a new SuperHyway driver
+ * @drv: SuperHyway driver to register.
+ *
+ * This registers the passed in @drv. Any devices matching the id table will
+ * automatically be populated and handed off to the driver's specified probe
+ * routine.
+ */
+int superhyway_register_driver(struct superhyway_driver *drv)
+{
+	drv->drv.name	= drv->name;
+	drv->drv.bus	= &superhyway_bus_type;
+	drv->drv.probe	= superhyway_device_probe;
+	drv->drv.remove	= superhyway_device_remove;
+
+	return driver_register(&drv->drv);
+}
+
+/**
+ * superhyway_unregister_driver - Unregister a SuperHyway driver
+ * @drv: SuperHyway driver to unregister.
+ *
+ * This cleans up after superhyway_register_driver(), and should be invoked in
+ * the exit path of any module drivers.
+ */
+void superhyway_unregister_driver(struct superhyway_driver *drv)
+{
+	driver_unregister(&drv->drv);
+}
+
+static int superhyway_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
+	struct superhyway_driver *shyway_drv = to_superhyway_driver(drv);
+	const struct superhyway_device_id *ids = shyway_drv->id_table;
+
+	if (!ids)
+		return -EINVAL;
+	if (superhyway_match_id(ids, shyway_dev))
+		return 1;
+
+	return -ENODEV;
+}
+
+struct bus_type superhyway_bus_type = {
+	.name		= "superhyway",
+	.match		= superhyway_bus_match,
+#ifdef CONFIG_SYSFS
+	.dev_attrs	= superhyway_dev_attrs,
+#endif
+};
+
+static int __init superhyway_bus_init(void)
+{
+	return bus_register(&superhyway_bus_type);
+}
+
+static void __exit superhyway_bus_exit(void)
+{
+	device_unregister(&superhyway_bus_device);
+	bus_unregister(&superhyway_bus_type);
+}
+
+core_initcall(superhyway_bus_init);
+module_exit(superhyway_bus_exit);
+
+EXPORT_SYMBOL(superhyway_bus_type);
+EXPORT_SYMBOL(superhyway_add_device);
+EXPORT_SYMBOL(superhyway_register_driver);
+EXPORT_SYMBOL(superhyway_unregister_driver);
+
+MODULE_LICENSE("GPL");
diff -Nru a/include/linux/superhyway.h b/include/linux/superhyway.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/superhyway.h	2005-03-09 16:36:31 -08:00
@@ -0,0 +1,79 @@
+/*
+ * include/linux/superhyway.h
+ *
+ * SuperHyway Bus definitions
+ *
+ * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __LINUX_SUPERHYWAY_H
+#define __LINUX_SUPERHYWAY_H
+
+#include <linux/device.h>
+
+/*
+ * SuperHyway IDs
+ */
+#define SUPERHYWAY_DEVICE_ID_SH5_DMAC	0x0183
+
+struct vcr_info {
+	u8	perr_flags;	/* P-port Error flags */
+	u8	merr_flags;	/* Module Error flags */
+	u16	mod_vers;	/* Module Version */
+	u16	mod_id;		/* Module ID */
+	u8	bot_mb;		/* Bottom Memory block */
+	u8	top_mb;		/* Top Memory block */
+};
+
+struct superhyway_device_id {
+	unsigned int id;
+	unsigned long driver_data;
+};
+
+struct superhyway_device;
+extern struct bus_type superhyway_bus_type;
+
+struct superhyway_driver {
+	char *name;
+
+	const struct superhyway_device_id *id_table;
+	struct device_driver drv;
+
+	int (*probe)(struct superhyway_device *dev, const struct superhyway_device_id *id);
+	void (*remove)(struct superhyway_device *dev);
+};
+
+#define to_superhyway_driver(d)	container_of((d), struct superhyway_driver, drv)
+
+struct superhyway_device {
+	char name[32];
+
+	struct device dev;
+
+	struct superhyway_device_id id;
+	struct superhyway_driver *drv;
+
+	struct resource resource;
+	struct vcr_info vcr;
+};
+
+#define to_superhyway_device(d)	container_of((d), struct superhyway_device, dev)
+
+#define superhyway_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
+#define superhyway_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, (p))
+
+extern int superhyway_scan_bus(void);
+
+/* drivers/sh/superhyway/superhyway.c */
+int superhyway_register_driver(struct superhyway_driver *);
+void superhyway_unregister_driver(struct superhyway_driver *);
+int superhyway_add_device(unsigned int, unsigned long, unsigned long long);
+
+/* drivers/sh/superhyway/superhyway-sysfs.c */
+extern struct device_attribute superhyway_dev_attrs[];
+
+#endif /* __LINUX_SUPERHYWAY_H */
+

