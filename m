Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVAGQdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVAGQdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVAGQdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:33:51 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:35754 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id S261504AbVAGQcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:32:10 -0500
X-Scanned: Fri, 7 Jan 2005 18:31:50 +0200 Nokia Message Protector V1.3.34 2004121512 - RELEASE
Date: Fri, 7 Jan 2005 18:29:45 +0200
From: Paul Mundt <paul.mundt@nokia.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050107162945.GA19043@pointless.research.nokia.com>
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20050107094103.GA7408@pointless.research.nokia.com>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 07 Jan 2005 16:31:34.0839 (UTC) FILETIME=[5A4CFC70:01C4F4D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2005 at 11:41:04AM +0200, Paul Mundt wrote:
> > Also, why have a local list of devices and not just use the list the
> > driver core provides for you?
> >=20
> Probably because I wasn't aware that the driver core provided one. Now th=
at I
> see the bus_for_each_xxx() stuff I'll drop the list and use that instead.
>=20
I dropped this entirely as the release() stuff did what I was looking for..

> Thanks for looking at this, I'll post a cleaned up version shortly.

Here it is against current BK.. let me know if you have any other issues.

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

 drivers/Makefile                         |    1=20
 drivers/sh/Makefile                      |    6=20
 drivers/sh/superhyway/Makefile           |    7 +
 drivers/sh/superhyway/superhyway-sysfs.c |   47 +++++++
 drivers/sh/superhyway/superhyway.c       |  205 ++++++++++++++++++++++++++=
+++++
 5 files changed, 266 insertions(+)

--- linux-2.6/drivers/Makefile	2004-12-31 03:37:37.000000000 +0200
+++ linux-sh64-2.6/drivers/Makefile	2005-01-07 18:18:42.055174960 +0200
@@ -62,3 +62,4 @@
 obj-$(CONFIG_INFINIBAND)	+=3D infiniband/
 obj-y				+=3D firmware/
 obj-$(CONFIG_CRYPTO)		+=3D crypto/
+obj-$(CONFIG_SUPERH)		+=3D sh/
diff -urN linux-2.6/drivers/sh/Makefile linux-sh64-2.6/drivers/sh/Makefile
--- linux-2.6/drivers/sh/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ linux-sh64-2.6/drivers/sh/Makefile	2004-12-07 14:16:02.000000000 +0200
@@ -0,0 +1,6 @@
+#
+# Makefile for the SuperH specific drivers.
+#
+
+obj-$(CONFIG_SUPERHYWAY) +=3D superhyway/
+
diff -urN linux-2.6/drivers/sh/superhyway/Makefile linux-sh64-2.6/drivers/s=
h/superhyway/Makefile
--- linux-2.6/drivers/sh/superhyway/Makefile	1970-01-01 02:00:00.000000000 =
+0200
+++ linux-sh64-2.6/drivers/sh/superhyway/Makefile	2005-01-07 18:19:26.39443=
4368 +0200
@@ -0,0 +1,7 @@
+#
+# Makefile for the SuperHyway bus drivers.
+#
+
+obj-$(CONFIG_SUPERHYWAY)	+=3D superhyway.o
+obj-$(CONFIG_SYSFS)		+=3D superhyway-sysfs.o
+
diff -urN linux-2.6/drivers/sh/superhyway/superhyway.c linux-sh64-2.6/drive=
rs/sh/superhyway/superhyway.c
--- linux-2.6/drivers/sh/superhyway/superhyway.c	1970-01-01 02:00:00.000000=
000 +0200
+++ linux-sh64-2.6/drivers/sh/superhyway/superhyway.c	2005-01-07 18:15:08.1=
02700680 +0200
@@ -0,0 +1,205 @@
+/*
+ * drivers/sh/superhyway/superhyway.c
+ *
+ * SuperHyway Bus Driver
+ *
+ * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
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
+static int superhyway_devices;
+
+static struct device superhyway_bus_device =3D {
+	.bus_id =3D "superhyway",
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
+
+	dev =3D kmalloc(sizeof(struct superhyway_device), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	memset(dev, 0, sizeof(struct superhyway_device));
+
+	dev->id.id =3D mod_id;
+	sprintf(dev->name, "SuperHyway device %04x", dev->id.id);
+
+	dev->vcr		=3D *((struct vcr_info *)(&vcr));
+	dev->resource.name	=3D dev->name;
+	dev->resource.start	=3D base;
+	dev->resource.end	=3D dev->resource.start + 0x01000000;
+	dev->dev.parent		=3D &superhyway_bus_device;
+	dev->dev.bus		=3D &superhyway_bus_type;
+	dev->dev.release	=3D superhyway_device_release;
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
+	extern int superhyway_scan_bus(void);
+
+	device_register(&superhyway_bus_device);
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
+	.name		=3D "superhyway",
+	.match		=3D superhyway_bus_match,
+#ifdef CONFIG_SYSFS
+	.dev_attrs	=3D superhyway_dev_attrs,
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
diff -urN linux-2.6/drivers/sh/superhyway/superhyway-sysfs.c linux-sh64-2.6=
/drivers/sh/superhyway/superhyway-sysfs.c
--- linux-2.6/drivers/sh/superhyway/superhyway-sysfs.c	1970-01-01 02:00:00.=
000000000 +0200
+++ linux-sh64-2.6/drivers/sh/superhyway/superhyway-sysfs.c	2005-01-07 18:0=
8:57.463046472 +0200
@@ -0,0 +1,47 @@
+/*
+ * drivers/sh/superhyway/superhyway-sysfs.c
+ *
+ * SuperHyway Bus sysfs interface
+ *
+ * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
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
+static ssize_t name##_show(struct device *dev, char *buf)		\
+{									\
+	struct superhyway_device *s =3D to_superhyway_device(dev);	\
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
+struct device_attribute superhyway_dev_attrs[] =3D {
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

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB3rj5vfgmmv+NIDsRAt5oAJ4vUT1xv0+v7b2KmTg/AEEF1df0NwCcDB/6
6vXTksdqcQbnklKz+zXOP/A=
=YsoN
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
