Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbUJ0HzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbUJ0HzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUJ0HzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:55:00 -0400
Received: from mgw-x2.nokia.com ([131.228.20.22]:36314 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id S262300AbUJ0Hyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:54:35 -0400
X-Scanned: Wed, 27 Oct 2004 10:53:52 +0300 Nokia Message Protector V1.3.31 2004060815 - RELEASE
Date: Wed, 27 Oct 2004 10:52:48 +0300
From: Paul Mundt <paul.mundt@nokia.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SuperHyway bus support
Message-ID: <20041027075248.GA26760@pointless.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 27 Oct 2004 07:53:01.0877 (UTC) FILETIME=[FBC9BE50:01C4BBF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This adds support for the SuperHyway bus currently used by sh64 and also us=
ed
by newer sh4a cores. This just adds the common bus support, with things like
bus scanning being architecture dependent. sh64 presently makes use of this
for its DMAC, with further device support planned.

I've added this under drivers/sh/superhyway/ as there are some other
sh-specific buses that I intend to add under drivers/sh/ at a later point.
Some of the sh dma code is also intended for consolidation there so sh64 can
use it as well.

Against current BK. Comments appreciated.

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

--- linux-2.6/drivers/Makefile	2004-10-27 09:45:42.582996368 +0300
+++ sh64--stable--2.6/drivers/Makefile	2004-10-27 09:10:12.000000000 +0300
@@ -60,3 +59,4 @@
 obj-$(CONFIG_CPU_FREQ)		+=3D cpufreq/
 obj-$(CONFIG_MMC)		+=3D mmc/
 obj-y				+=3D firmware/
+obj-$(CONFIG_SUPERH)		+=3D sh/
--- linux-2.6/drivers/sh/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ sh64--stable--2.6/drivers/sh/Makefile	2004-10-27 09:10:12.000000000 +03=
00
@@ -0,0 +1,6 @@
+#
+# Makefile for the SuperH specific drivers.
+#
+
+obj-$(CONFIG_SUPERHYWAY) +=3D superhyway/
+
--- linux-2.6/drivers/sh/superhyway/Makefile	1970-01-01 02:00:00.000000000 =
+0200
+++ sh64--stable--2.6/drivers/sh/superhyway/Makefile	2004-10-27 09:10:12.00=
0000000 +0300
@@ -0,0 +1,18 @@
+#
+# Makefile for the SuperHyway bus drivers.
+#
+
+obj-$(CONFIG_SUPERHYWAY)	+=3D superhyway.o
+obj-$(CONFIG_SYSFS)		+=3D superhyway-sysfs.o
+
+clean-files :=3D devlist.h
+
+$(obj)/superhyway.o: $(obj)/devlist.h
+
+quiet_cmd_devlist =3D GEN     $@
+      cmd_devlist =3D sed -e 's/^\#.*$$//g;s/^[ ].*$$//g;/^$$/d; \
+		    	    s/\(0x.*\)	/	{ \1, /g;s/$$/ },/' < $< > $@
+
+$(obj)/devlist.h: $(src)/superhyway.ids
+	$(call cmd,devlist)
+
--- linux-2.6/drivers/sh/superhyway/superhyway-sysfs.c	1970-01-01 02:00:00.=
000000000 +0200
+++ sh64--stable--2.6/drivers/sh/superhyway/superhyway-sysfs.c	2004-10-27 0=
9:10:12.000000000 +0300
@@ -0,0 +1,50 @@
+/*
+ * drivers/sh/superhyway/superhyway-sysfs.c
+ *
+ * SuperHyway Bus sysfs interface
+ *
+ * Copyright (C) 2004  Paul Mundt <lethal@linux-sh.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/superhyway.h>
+
+#define superhyway_ro_attr(name, fmt, field)				\
+static ssize_t superhyway_show_##name(struct device *dev, char *buf)	\
+{									\
+	struct superhyway_device *s =3D to_superhyway_device(dev);	\
+	return sprintf(buf, fmt, s->field);				\
+}									\
+static DEVICE_ATTR(name, S_IRUGO, superhyway_show_##name, NULL);
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
+void superhyway_create_sysfs_files(struct superhyway_device *s)
+{
+	struct device *dev =3D &s->dev;
+
+	device_create_file(dev, &dev_attr_perr_flags);
+	device_create_file(dev, &dev_attr_merr_flags);
+	device_create_file(dev, &dev_attr_mod_vers);
+	device_create_file(dev, &dev_attr_mod_id);
+	device_create_file(dev, &dev_attr_bot_mb);
+	device_create_file(dev, &dev_attr_top_mb);
+	device_create_file(dev, &dev_attr_resource);
+}
+
--- linux-2.6/drivers/sh/superhyway/superhyway.c	1970-01-01 02:00:00.000000=
000 +0200
+++ sh64--stable--2.6/drivers/sh/superhyway/superhyway.c	2004-10-27 09:10:1=
2.000000000 +0300
@@ -0,0 +1,234 @@
+/*
+ * drivers/sh/superhyway/superhyway.c
+ *
+ * SuperHyway Bus Driver
+ *
+ * Copyright (C) 2004  Paul Mundt <lethal@linux-sh.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/superhyway.h>
+
+static struct superhyway_device_info {
+	unsigned int id;
+	const char *name;
+} superhyway_device_table[] __initdata =3D {
+#include "devlist.h"
+};
+
+static int superhyway_devices;
+
+static struct superhyway_bus superhyway_bus =3D {
+	.name	=3D "SuperHyway bus",
+};
+
+static void superhyway_name_device(struct superhyway_device *dev)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(superhyway_device_table); i++)
+		if (superhyway_device_table[i].id =3D=3D dev->id.id)
+			sprintf(dev->pretty_name, "%s",
+				superhyway_device_table[i].name);
+}
+
+/**
+ * superhyway_add_device - Add a SuperHyway module
+ * @mod_id: Module ID (taken from MODULE.VCR.MOD_ID).
+ * @base: Physical address where module is mapped.
+ * @vcr: VCR value.
+ *
+ * This is responsible for adding a new SuperHyway module. This sets up a =
new
+ * struct superhyway_device for the module being added. Each one of @mod_i=
d,
+ * @base, and @vcr are registered with the new device for further use
+ * elsewhere.
+ *
+ * Devices are initially added in the order that they are scanned (from the
+ * top-down of the memory map), and are assigned an ID based on the order =
that
+ * they are added. Any manual addition of a module will thus get the ID af=
ter
+ * the devices already discovered regardless of where it resides in memory.
+ *
+ * Further work can and should be done in superhyway_scan_bus(), to be sure
+ * that any new modules are properly discovered and subsequently registere=
d.
+ */
+int superhyway_add_device(unsigned int mod_id, unsigned long base,
+			  unsigned long long vcr)
+{
+	struct superhyway_device *dev;
+	int ret;
+
+	dev =3D kmalloc(sizeof(struct superhyway_device), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	memset(dev, 0, sizeof(struct superhyway_device));
+
+	dev->id.id =3D mod_id;
+	sprintf(dev->name, "SuperHyway device %04x\n", dev->id.id);
+
+	superhyway_name_device(dev);
+
+	dev->vcr		=3D *((struct vcr_info *)(&vcr));
+	dev->resource.name	=3D dev->name;
+	dev->resource.start	=3D base;
+	dev->resource.end	=3D dev->resource.start + 0x01000000;
+	dev->dev.parent		=3D &superhyway_bus.dev;
+	dev->dev.bus		=3D &superhyway_bus_type;
+
+	sprintf(dev->dev.bus_id, "%02x", superhyway_devices);
+
+	pr_info("    0x%04x (%s) control block at 0x%08lx\n",
+		dev->id.id, dev->pretty_name, dev->resource.start);
+
+	superhyway_devices++;
+
+	list_add(&dev->node, &superhyway_bus.devices);
+
+	ret =3D device_register(&dev->dev);
+	superhyway_create_sysfs_files(dev);
+
+	return ret;
+}
+
+static int __init superhyway_init(void)
+{
+	extern int superhyway_scan_bus(void);
+
+	INIT_LIST_HEAD(&superhyway_bus.devices);
+	strcpy(superhyway_bus.dev.bus_id, "superhyway");
+	device_register(&superhyway_bus.dev);
+
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
+		if (ids->id =3D=3D dev->id.id)
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
+	struct superhyway_device *shyway_dev =3D to_superhyway_device(dev);
+	struct superhyway_driver *shyway_drv =3D to_superhyway_driver(dev->driver=
);
+
+	if (shyway_drv && shyway_drv->probe) {
+		const struct superhyway_device_id *id;
+
+		id =3D superhyway_match_id(shyway_drv->id_table, shyway_dev);
+		if (id)
+			return shyway_drv->probe(shyway_dev, id);
+	}
+
+	return -ENODEV;
+}
+
+static int superhyway_device_remove(struct device *dev)
+{
+	struct superhyway_device *shyway_dev =3D to_superhyway_device(dev);
+	struct superhyway_driver *shyway_drv =3D to_superhyway_driver(dev->driver=
);
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
+ * This registers the passed in @drv. Any devices matching the id table wi=
ll
+ * automatically be populated and handed off to the driver's specified pro=
be
+ * routine.
+ */
+int superhyway_register_driver(struct superhyway_driver *drv)
+{
+	drv->drv.name	=3D drv->name;
+	drv->drv.bus	=3D &superhyway_bus_type;
+	drv->drv.probe	=3D superhyway_device_probe;
+	drv->drv.remove	=3D superhyway_device_remove;
+
+	return driver_register(&drv->drv);
+}
+
+/**
+ * superhyway_unregister_driver - Unregister a SuperHyway driver
+ * @drv: SuperHyway driver to unregister.
+ *
+ * This cleans up after superhyway_register_driver(), and should be invoke=
d in
+ * the exit path of any module drivers.
+ */
+void superhyway_unregister_driver(struct superhyway_driver *drv)
+{
+	driver_unregister(&drv->drv);
+}
+
+static int superhyway_bus_match(struct device *dev, struct device_driver *=
drv)
+{
+	struct superhyway_device *shyway_dev =3D to_superhyway_device(dev);
+	struct superhyway_driver *shyway_drv =3D to_superhyway_driver(drv);
+	const struct superhyway_device_id *ids =3D shyway_drv->id_table;
+
+	if (!ids)
+		return -EINVAL;
+	if (superhyway_match_id(ids, shyway_dev))
+		return 1;
+
+	return -ENODEV;
+}
+
+struct bus_type superhyway_bus_type =3D {
+	.name	=3D "superhyway",
+	.match	=3D superhyway_bus_match,
+};
+
+static int __init superhyway_bus_init(void)
+{
+	return bus_register(&superhyway_bus_type);
+}
+
+static void __exit superhyway_bus_exit(void)
+{
+	struct superhyway_device *dev;
+
+	list_for_each_entry(dev, &superhyway_bus.devices, node) {
+		device_unregister(&dev->dev);
+		kfree(dev);
+	}
+
+	device_unregister(&superhyway_bus.dev);
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
+
--- linux-2.6/drivers/sh/superhyway/superhyway.ids	1970-01-01 02:00:00.0000=
00000 +0200
+++ sh64--stable--2.6/drivers/sh/superhyway/superhyway.ids	2004-10-27 09:10=
:12.000000000 +0300
@@ -0,0 +1,13 @@
+#
+# This list is a compilation of SuperHyway module IDs and
+# their associated "pretty" names.
+#
+
+0x0183	"SH-5 DMA controller"
+0x1823	"SH-5 Debug module"
+0x204f	"SH-5 PCI bridge"
+0x2184	"SH-5 External Memory Interface"
+0x2185	"SH-5 Flash ROM Interface"
+0x448f	"SH-5 Peripheral bridge"
+0x51e2	"SH-5 CPU (SH5-101) core"
+=20
--- linux-2.6/include/linux/superhyway.h	1970-01-01 02:00:00.000000000 +0200
+++ sh64--stable--2.6/include/linux/superhyway.h	2004-10-27 09:10:12.000000=
000 +0300
@@ -0,0 +1,96 @@
+/*
+ * include/linux/superhyway.h
+ *
+ * SuperHyway Bus definitions
+ *
+ * Copyright (C) 2004  Paul Mundt <lethal@linux-sh.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
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
+	int (*probe)(struct superhyway_device *dev, const struct superhyway_devic=
e_id *id);
+	void (*remove)(struct superhyway_device *dev);
+};
+
+#define to_superhyway_driver(d)	container_of((d), struct superhyway_driver=
, drv)
+
+struct superhyway_device {
+	struct list_head node;
+
+	char name[32];
+	char pretty_name[64];
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
+#define to_superhyway_device(d)	container_of((d), struct superhyway_device=
, dev)
+
+struct superhyway_bus {
+	struct list_head devices;
+	struct device dev;
+	char name[16];
+};
+
+#define superhyway_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
+#define superhyway_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, (p))
+
+/* drivers/sh/superhyway/superhyway.c */
+int superhyway_register_driver(struct superhyway_driver *);
+void superhyway_unregister_driver(struct superhyway_driver *);
+int superhyway_add_device(unsigned int, unsigned long, unsigned long long);
+
+/* drivers/sh/superhyway/superhyway-sysfs.c */
+#ifdef CONFIG_SYSFS
+void superhyway_create_sysfs_files(struct superhyway_device *);
+#else
+void superhyway_create_sysfs_files(struct superhyway_device *s)
+{
+	/* Nothing to do */
+}
+#endif
+
+#endif /* __LINUX_SUPERHYWAY_H */
+

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBf1PQvfgmmv+NIDsRAtlOAJ9Hr3XVsfckOxkqHrxaI5yfXcHPqQCeMjIq
mCPYWJifMRRFayI/00DvZ6U=
=sgE3
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
