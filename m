Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUAAU7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbUAAU6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:58:07 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:47931 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264889AbUAAUDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:21 -0500
Date: Thu, 1 Jan 2004 21:03:17 +0100
Message-Id: <200401012003.i01K3HH2031850@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 369] Zorro sysfs/driver model
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zorro bus: Add support for sysfs and the new driver model

--- linux-2.6.0/drivers/zorro/Makefile	2003-02-10 21:59:19.000000000 +0100
+++ linux-m68k-2.6.0/drivers/zorro/Makefile	2003-10-26 22:09:06.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for the Zorro bus specific drivers.
 #
 
-obj-$(CONFIG_ZORRO)	+= zorro.o names.o
+obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o names.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 
 host-progs 		:= gen-devlist
--- linux-2.6.0/drivers/zorro/proc.c	2002-11-26 10:41:42.000000000 +0100
+++ linux-m68k-2.6.0/drivers/zorro/proc.c	2003-11-06 21:25:51.000000000 +0100
@@ -3,7 +3,7 @@
  *
  *	Procfs interface for the Zorro bus.
  *
- *	Copyright (C) 1998-2000 Geert Uytterhoeven
+ *	Copyright (C) 1998-2003 Geert Uytterhoeven
  *
  *	Heavily based on the procfs interface for the PCI bus, which is
  *
@@ -49,7 +49,7 @@
 {
 	struct inode *ino = file->f_dentry->d_inode;
 	struct proc_dir_entry *dp = PDE(ino);
-	struct zorro_dev *dev = dp->data;
+	struct zorro_dev *z = dp->data;
 	struct ConfigDev cd;
 	loff_t pos = *ppos;
 
@@ -62,11 +62,11 @@
 
 	/* Construct a ConfigDev */
 	memset(&cd, 0, sizeof(cd));
-	cd.cd_Rom = dev->rom;
-	cd.cd_SlotAddr = dev->slotaddr;
-	cd.cd_SlotSize = dev->slotsize;
-	cd.cd_BoardAddr = (void *)dev->resource.start;
-	cd.cd_BoardSize = dev->resource.end-dev->resource.start+1;
+	cd.cd_Rom = z->rom;
+	cd.cd_SlotAddr = z->slotaddr;
+	cd.cd_SlotSize = z->slotsize;
+	cd.cd_BoardAddr = (void *)zorro_resource_start(z);
+	cd.cd_BoardSize = zorro_resource_len(z);
 
 	if (copy_to_user(buf, &cd, nbytes))
 		return -EFAULT;
@@ -88,11 +88,10 @@
 	int len, cnt;
 
 	for (slot = cnt = 0; slot < zorro_num_autocon && count > cnt; slot++) {
-		struct zorro_dev *dev = &zorro_autocon[slot];
+		struct zorro_dev *z = &zorro_autocon[slot];
 		len = sprintf(buf, "%02x\t%08x\t%08lx\t%08lx\t%02x\n", slot,
-			      dev->id, dev->resource.start,
-			      dev->resource.end-dev->resource.start+1,
-			      dev->rom.er_Type);
+			      z->id, zorro_resource_start(z),
+			      zorro_resource_len(z), z->rom.er_Type);
 		at += len;
 		if (at >= pos) {
 			if (!*start) {
--- linux-2.6.0/drivers/zorro/zorro.c	2002-10-07 22:04:45.000000000 +0200
+++ linux-m68k-2.6.0/drivers/zorro/zorro.c	2003-11-06 21:34:25.000000000 +0100
@@ -3,7 +3,7 @@
  *
  *    Zorro Bus Services
  *
- *    Copyright (C) 1995-2000 Geert Uytterhoeven
+ *    Copyright (C) 1995-2003 Geert Uytterhoeven
  *
  *    This file is subject to the terms and conditions of the GNU General Public
  *    License.  See the file COPYING in the main directory of this archive
@@ -19,6 +19,8 @@
 #include <asm/bitops.h>
 #include <asm/amigahw.h>
 
+#include "zorro.h"
+
 
     /*
      *  Zorro Expansion Devices
@@ -29,21 +31,21 @@
 
 
     /*
-     *  Zorro Bus Resources
-     *  Order _does_ matter! (see code below)
+     *  Single Zorro bus
      */
 
-static struct resource zorro_res[4] = {
-    /* Zorro II regions (on Zorro II/III) */
-    { "Zorro II exp", 0x00e80000, 0x00efffff },
-    { "Zorro II mem", 0x00200000, 0x009fffff },
-    /* Zorro III regions (on Zorro III only) */
-    { "Zorro III exp", 0xff000000, 0xffffffff },
-    { "Zorro III cfg", 0x40000000, 0x7fffffff }
+struct zorro_bus zorro_bus = {\
+    .resources = {
+	/* Zorro II regions (on Zorro II/III) */
+	{ .name = "Zorro II exp", .start = 0x00e80000, .end = 0x00efffff },
+	{ .name = "Zorro II mem", .start = 0x00200000, .end = 0x009fffff },
+	/* Zorro III regions (on Zorro III only) */
+	{ .name = "Zorro III exp", .start = 0xff000000, .end = 0xffffffff },
+	{ .name = "Zorro III cfg", .start = 0x40000000, .end = 0x7fffffff }
+    },
+    .name = "Zorro bus"
 };
 
-static u_int zorro_num_res __initdata = 0;
-
 
     /*
      *  Find Zorro Devices
@@ -51,16 +53,16 @@
 
 struct zorro_dev *zorro_find_device(zorro_id id, struct zorro_dev *from)
 {
-    struct zorro_dev *dev;
+    struct zorro_dev *z;
 
     if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(ZORRO))
 	return NULL;
 
-    for (dev = from ? from+1 : &zorro_autocon[0];
-	 dev < zorro_autocon+zorro_num_autocon;
-	 dev++)
-	if (id == ZORRO_WILDCARD || id == dev->id)
-	    return dev;
+    for (z = from ? from+1 : &zorro_autocon[0];
+	 z < zorro_autocon+zorro_num_autocon;
+	 z++)
+	if (id == ZORRO_WILDCARD || id == z->id)
+	    return z;
     return NULL;
 }
 
@@ -112,10 +114,10 @@
 {
     int i;
 
-    for (i = 0; i < zorro_num_res; i++)
-	if (z->resource.start >= zorro_res[i].start &&
-	    z->resource.end <= zorro_res[i].end)
-		return &zorro_res[i];
+    for (i = 0; i < zorro_bus.num_resources; i++)
+	if (zorro_resource_start(z) >= zorro_bus.resources[i].start &&
+	    zorro_resource_end(z) <= zorro_bus.resources[i].end)
+		return &zorro_bus.resources[i];
     return &iomem_resource;
 }
 
@@ -126,8 +128,8 @@
 
 static int __init zorro_init(void)
 {
-    struct zorro_dev *dev;
-    u_int i;
+    struct zorro_dev *z;
+    unsigned int i;
 
     if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(ZORRO))
 	return 0;
@@ -135,32 +137,43 @@
     printk("Zorro: Probing AutoConfig expansion devices: %d device%s\n",
 	   zorro_num_autocon, zorro_num_autocon == 1 ? "" : "s");
 
+    /* Initialize the Zorro bus */
+    INIT_LIST_HEAD(&zorro_bus.devices);
+    strcpy(zorro_bus.dev.bus_id, "zorro");
+    device_register(&zorro_bus.dev);
+
     /* Request the resources */
-    zorro_num_res = AMIGAHW_PRESENT(ZORRO3) ? 4 : 2;
-    for (i = 0; i < zorro_num_res; i++)
-	request_resource(&iomem_resource, &zorro_res[i]);
+    zorro_bus.num_resources = AMIGAHW_PRESENT(ZORRO3) ? 4 : 2;
+    for (i = 0; i < zorro_bus.num_resources; i++)
+	request_resource(&iomem_resource, &zorro_bus.resources[i]);
+
+    /* Register all devices */
     for (i = 0; i < zorro_num_autocon; i++) {
-	dev = &zorro_autocon[i];
-	dev->id = (dev->rom.er_Manufacturer<<16) | (dev->rom.er_Product<<8);
-	if (dev->id == ZORRO_PROD_GVP_EPC_BASE) {
+	z = &zorro_autocon[i];
+	z->id = (z->rom.er_Manufacturer<<16) | (z->rom.er_Product<<8);
+	if (z->id == ZORRO_PROD_GVP_EPC_BASE) {
 	    /* GVP quirk */
-	    unsigned long magic = dev->resource.start+0x8000;
-	    dev->id |= *(u16 *)ZTWO_VADDR(magic) & GVP_PRODMASK;
+	    unsigned long magic = zorro_resource_start(z)+0x8000;
+	    z->id |= *(u16 *)ZTWO_VADDR(magic) & GVP_PRODMASK;
 	}
-	sprintf(dev->name, "Zorro device %08x", dev->id);
-	zorro_name_device(dev);
-	dev->resource.name = dev->name;
-	if (request_resource(zorro_find_parent_resource(dev), &dev->resource))
+	sprintf(z->name, "Zorro device %08x", z->id);
+	zorro_name_device(z);
+	z->resource.name = z->name;
+	if (request_resource(zorro_find_parent_resource(z), &z->resource))
 	    printk(KERN_ERR "Zorro: Address space collision on device %s "
 		   "[%lx:%lx]\n",
-		   dev->name, dev->resource.start, dev->resource.end);
+		   z->name, zorro_resource_start(z), zorro_resource_end(z));
+	sprintf(z->dev.bus_id, "%02x", i);
+	z->dev.parent = &zorro_bus.dev;
+	z->dev.bus = &zorro_bus_type;
+	device_register(&z->dev);
+	zorro_create_sysfs_dev_files(z);
     }
 
     /* Mark all available Zorro II memory */
-    for (i = 0; i < zorro_num_autocon; i++) {
-	dev = &zorro_autocon[i];
-	if (dev->rom.er_Type & ERTF_MEMLIST)
-	    mark_region(dev->resource.start, dev->resource.end+1, 1);
+    zorro_for_each_dev(z) {
+	if (z->rom.er_Type & ERTF_MEMLIST)
+	    mark_region(zorro_resource_start(z), zorro_resource_end(z)+1, 1);
     }
 
     /* Unmark all used Zorro II memory */
--- linux-2.6.0/include/linux/zorro.h	2003-07-29 18:19:22.000000000 +0200
+++ linux-m68k-2.6.0/include/linux/zorro.h	2003-11-06 21:35:10.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  linux/zorro.h -- Amiga AutoConfig (Zorro) Bus Definitions
  *
- *  Copyright (C) 1995--2000 Geert Uytterhoeven
+ *  Copyright (C) 1995--2003 Geert Uytterhoeven
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive
@@ -13,6 +13,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/device.h>
+
+
     /*
      *  Each Zorro board has a 32-bit ID of the form
      *
@@ -96,17 +99,17 @@
 #define ERTF_MEMLIST	(1<<5)
 
 struct ConfigDev {
-    struct Node 	cd_Node;
-    __u8  		cd_Flags;	/* (read/write) */
-    __u8  		cd_Pad; 	/* reserved */
-    struct ExpansionRom cd_Rom; 	/* copy of board's expansion ROM */
+    struct Node		cd_Node;
+    __u8		cd_Flags;	/* (read/write) */
+    __u8		cd_Pad;		/* reserved */
+    struct ExpansionRom cd_Rom;		/* copy of board's expansion ROM */
     void		*cd_BoardAddr;	/* where in memory the board was placed */
-    __u32 		cd_BoardSize;	/* size of board in bytes */
-    __u16  		cd_SlotAddr;	/* which slot number (PRIVATE) */
-    __u16  		cd_SlotSize;	/* number of slots (PRIVATE) */
+    __u32		cd_BoardSize;	/* size of board in bytes */
+    __u16		cd_SlotAddr;	/* which slot number (PRIVATE) */
+    __u16		cd_SlotSize;	/* number of slots (PRIVATE) */
     void		*cd_Driver;	/* pointer to node of driver */
     struct ConfigDev	*cd_NextCD;	/* linked list of drivers to config */
-    __u32 		cd_Unused[4];	/* for whatever the driver wants */
+    __u32		cd_Unused[4];	/* for whatever the driver wants */
 } __attribute__ ((packed));
 
 #else /* __ASSEMBLY__ */
@@ -157,15 +160,81 @@
 
 #include <asm/zorro.h>
 
+
+    /*
+     *  Zorro devices
+     */
+
 struct zorro_dev {
     struct ExpansionRom rom;
     zorro_id id;
+    struct zorro_driver *driver;	/* which driver has allocated this device */
+    struct device dev;			/* Generic device interface */
     u16 slotaddr;
     u16 slotsize;
     char name[64];
     struct resource resource;
 };
 
+#define	to_zorro_dev(n)	container_of(n, struct zorro_dev, dev)
+
+
+    /*
+     *  Zorro bus
+     */
+
+struct zorro_bus {
+    struct list_head devices;		/* list of devices on this bus */
+    unsigned int num_resources;		/* number of resources */
+    struct resource resources[4];	/* address space routed to this bus */
+    struct device dev;
+    char name[10];
+};
+
+extern struct zorro_bus zorro_bus;	/* single Zorro bus */
+extern struct bus_type zorro_bus_type;
+
+
+    /*
+     *  Zorro device IDs
+     */
+
+struct zorro_device_id {
+	zorro_id id;			/* Device ID or ZORRO_WILDCARD */
+	unsigned long driver_data;	/* Data private to the driver */
+};
+
+
+    /*
+     *  Zorro device drivers
+     */
+
+struct zorro_driver {
+    struct list_head node;
+    char *name;
+    const struct zorro_device_id *id_table;	/* NULL if wants all devices */
+    int (*probe)(struct zorro_dev *z, const struct zorro_device_id *id);	/* New device inserted */
+    void (*remove)(struct zorro_dev *z);	/* Device removed (NULL if not a hot-plug capable driver) */
+    struct device_driver driver;
+};
+
+#define	to_zorro_driver(drv)	container_of(drv, struct zorro_driver, driver)
+
+
+#define zorro_for_each_dev(dev)	\
+	for (dev = &zorro_autocon[0]; dev < zorro_autocon+zorro_num_autocon; dev++)
+
+
+/* New-style probing */
+extern int zorro_register_driver(struct zorro_driver *);
+extern void zorro_unregister_driver(struct zorro_driver *);
+extern const struct zorro_device_id *zorro_match_device(const struct zorro_device_id *ids, const struct zorro_dev *z);
+static inline struct zorro_driver *zorro_dev_driver(const struct zorro_dev *z)
+{
+    return z->driver;
+}
+
+
 extern unsigned int zorro_num_autocon;	/* # of autoconfig devices found */
 extern struct zorro_dev zorro_autocon[ZORRO_NUM_AUTO];
 
@@ -174,17 +243,65 @@
      *  Zorro Functions
      */
 
-extern void zorro_name_device(struct zorro_dev *dev);
-
 extern struct zorro_dev *zorro_find_device(zorro_id id,
 					   struct zorro_dev *from);
 
+#define zorro_resource_start(z)	((z)->resource.start)
+#define zorro_resource_end(z)	((z)->resource.end)
+#define zorro_resource_len(z)	((z)->resource.end-(z)->resource.start+1)
+#define zorro_resource_flags(z)	((z)->resource.flags)
+
 #define zorro_request_device(z, name) \
-    request_mem_region((z)->resource.start, \
-		       (z)->resource.end-(z)->resource.start+1, (name))
+    request_mem_region(zorro_resource_start(z), zorro_resource_len(z), name)
 #define zorro_release_device(z) \
-    release_mem_region((z)->resource.start, \
-		       (z)->resource.end-(z)->resource.start+1)
+    release_mem_region(zorro_resource_start(z), zorro_resource_len(z))
+
+/* Similar to the helpers above, these manipulate per-zorro_dev
+ * driver-specific data.  They are really just a wrapper around
+ * the generic device structure functions of these calls.
+ */
+static inline void *zorro_get_drvdata (struct zorro_dev *z)
+{
+	return dev_get_drvdata(&z->dev);
+}
+
+static inline void zorro_set_drvdata (struct zorro_dev *z, void *data)
+{
+	dev_set_drvdata(&z->dev, data);
+}
+
+
+/*
+ * A helper function which helps ensure correct zorro_driver
+ * setup and cleanup for commonly-encountered hotplug/modular cases
+ *
+ * This MUST stay in a header, as it checks for -DMODULE
+ */
+static inline int zorro_module_init(struct zorro_driver *drv)
+{
+	int rc = zorro_register_driver(drv);
+
+	if (rc > 0)
+		return 0;
+
+	/* iff CONFIG_HOTPLUG and built into kernel, we should
+	 * leave the driver around for future hotplug events.
+	 * For the module case, a hotplug daemon of some sort
+	 * should load a module in response to an insert event. */
+#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
+	if (rc == 0)
+		return 0;
+#else
+	if (rc == 0)
+		rc = -ENODEV;
+#endif
+
+	/* if we get here, we need to clean up Zorro driver instance
+	 * and return some sort of error */
+	zorro_unregister_driver(drv);
+
+	return rc;
+}
 
 
     /*
--- linux-2.6.0/drivers/zorro/zorro-driver.c	2003-09-07 12:27:17.000000000 +0200
+++ linux-m68k-2.6.0/drivers/zorro/zorro-driver.c	2003-11-06 21:13:54.000000000 +0100
@@ -0,0 +1,150 @@
+/*
+ *  Zorro Driver Services
+ *
+ *  Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  Loosely based on drivers/pci/pci-driver.c
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/zorro.h>
+
+
+    /**
+     *  zorro_match_device - Tell if a Zorro device structure has a matching
+     *                       Zorro device id structure
+     *  @ids: array of Zorro device id structures to search in
+     *  @dev: the Zorro device structure to match against
+     *
+     *  Used by a driver to check whether a Zorro device present in the
+     *  system is in its list of supported devices. Returns the matching
+     *  zorro_device_id structure or %NULL if there is no match.
+     */
+
+const struct zorro_device_id *
+zorro_match_device(const struct zorro_device_id *ids,
+		   const struct zorro_dev *z)
+{
+	while (ids->id) {
+		if (ids->id == ZORRO_WILDCARD || ids->id == z->id)
+			return ids;
+		ids++;
+	}
+	return NULL;
+}
+
+
+static int zorro_device_probe(struct device *dev)
+{
+	int error = 0;
+	struct zorro_driver *drv = to_zorro_driver(dev->driver);
+	struct zorro_dev *z = to_zorro_dev(dev);
+
+	if (!z->driver && drv->probe) {
+		const struct zorro_device_id *id;
+
+		id = zorro_match_device(drv->id_table, z);
+		if (id)
+			error = drv->probe(z, id);
+		if (error >= 0) {
+			z->driver = drv;
+			error = 0;
+		}
+	}
+	return error;
+}
+
+
+    /**
+     *  zorro_register_driver - register a new Zorro driver
+     *  @drv: the driver structure to register
+     *
+     *  Adds the driver structure to the list of registered drivers
+     *  Returns the number of Zorro devices which were claimed by the driver
+     *  during registration.  The driver remains registered even if the
+     *  return value is zero.
+     */
+
+int zorro_register_driver(struct zorro_driver *drv)
+{
+	int count = 0;
+
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &zorro_bus_type;
+	drv->driver.probe = zorro_device_probe;
+
+	/* register with core */
+	count = driver_register(&drv->driver);
+	return count ? count : 1;
+}
+
+
+    /**
+     *  zorro_unregister_driver - unregister a zorro driver
+     *  @drv: the driver structure to unregister
+     *
+     *  Deletes the driver structure from the list of registered Zorro drivers,
+     *  gives it a chance to clean up by calling its remove() function for
+     *  each device it was responsible for, and marks those devices as
+     *  driverless.
+     */
+
+void zorro_unregister_driver(struct zorro_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+
+
+    /**
+     *  zorro_bus_match - Tell if a Zorro device structure has a matching Zorro
+     *                    device id structure
+     *  @ids: array of Zorro device id structures to search in
+     *  @dev: the Zorro device structure to match against
+     *
+     *  Used by a driver to check whether a Zorro device present in the
+     *  system is in its list of supported devices.Returns the matching
+     *  zorro_device_id structure or %NULL if there is no match.
+     */
+
+static int zorro_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct zorro_dev *z = to_zorro_dev(dev);
+	struct zorro_driver *zorro_drv = to_zorro_driver(drv);
+	const struct zorro_device_id *ids = zorro_drv->id_table;
+
+	if (!ids)
+		return 0;
+
+	while (ids->id) {
+		if (ids->id == ZORRO_WILDCARD || ids->id == z->id)
+			return 1;
+		ids++;
+	}
+	return 0;
+}
+
+
+struct bus_type zorro_bus_type = {
+	.name	= "zorro",
+	.match	= zorro_bus_match
+};
+
+
+static int __init zorro_driver_init(void)
+{
+	return bus_register(&zorro_bus_type);
+}
+
+postcore_initcall(zorro_driver_init);
+
+EXPORT_SYMBOL(zorro_match_device);
+EXPORT_SYMBOL(zorro_register_driver);
+EXPORT_SYMBOL(zorro_unregister_driver);
+EXPORT_SYMBOL(zorro_dev_driver);
+EXPORT_SYMBOL(zorro_bus_type);
--- linux-2.6.0/drivers/zorro/zorro-sysfs.c	2003-09-07 12:27:17.000000000 +0200
+++ linux-m68k-2.6.0/drivers/zorro/zorro-sysfs.c	2003-11-06 21:07:07.000000000 +0100
@@ -0,0 +1,97 @@
+/*
+ *  File Attributes for Zorro Devices
+ *
+ *  Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  Loosely based on drivers/pci/pci-sysfs.c
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/zorro.h>
+#include <linux/stat.h>
+
+#include "zorro.h"
+
+
+/* show configuration fields */
+#define zorro_config_attr(name, field, format_string)			\
+static ssize_t								\
+show_##name(struct device *dev, char *buf)				\
+{									\
+	struct zorro_dev *z;						\
+									\
+	z = to_zorro_dev(dev);						\
+	return sprintf(buf, format_string, z->field);			\
+}									\
+static DEVICE_ATTR(name, S_IRUGO, show_##name, NULL);
+
+zorro_config_attr(id, id, "0x%08x\n");
+zorro_config_attr(type, rom.er_Type, "0x%02x\n");
+zorro_config_attr(serial, rom.er_SerialNumber, "0x%08x\n");
+zorro_config_attr(slotaddr, slotaddr, "0x%04x\n");
+zorro_config_attr(slotsize, slotsize, "0x%04x\n");
+
+static ssize_t zorro_show_resource(struct device *dev, char *buf)
+{
+	struct zorro_dev *z = to_zorro_dev(dev);
+
+	return sprintf(buf, "0x%08lx 0x%08lx 0x%08lx\n",
+		       zorro_resource_start(z), zorro_resource_end(z),
+		       zorro_resource_flags(z));
+}
+
+static DEVICE_ATTR(resource, S_IRUGO, zorro_show_resource, NULL);
+
+static ssize_t zorro_read_config(struct kobject *kobj, char *buf, loff_t off,
+				 size_t count)
+{
+	struct zorro_dev *z = to_zorro_dev(container_of(kobj, struct device,
+					   kobj));
+	struct ConfigDev cd;
+	unsigned int size = sizeof(cd);
+
+	if (off > size)
+		return 0;
+	if (off+count > size)
+		count = size-off;
+
+	/* Construct a ConfigDev */
+	memset(&cd, 0, sizeof(cd));
+	cd.cd_Rom = z->rom;
+	cd.cd_SlotAddr = z->slotaddr;
+	cd.cd_SlotSize = z->slotsize;
+	cd.cd_BoardAddr = (void *)zorro_resource_start(z);
+	cd.cd_BoardSize = zorro_resource_len(z);
+
+	memcpy(buf, (void *)&cd+off, count);
+	return count;
+}
+
+static struct bin_attribute zorro_config_attr = {
+	.attr =	{
+		.name = "config",
+		.mode = S_IRUGO | S_IWUSR,
+	},
+	.size = sizeof(struct ConfigDev),
+	.read = zorro_read_config,
+};
+
+void zorro_create_sysfs_dev_files(struct zorro_dev *z)
+{
+	struct device *dev = &z->dev;
+
+	/* current configuration's attributes */
+	device_create_file(dev, &dev_attr_id);
+	device_create_file(dev, &dev_attr_type);
+	device_create_file(dev, &dev_attr_serial);
+	device_create_file(dev, &dev_attr_slotaddr);
+	device_create_file(dev, &dev_attr_slotsize);
+	device_create_file(dev, &dev_attr_resource);
+	sysfs_create_bin_file(&dev->kobj, &zorro_config_attr);
+}
+
--- linux-2.6.0/drivers/zorro/zorro.h	2003-09-07 12:27:17.000000000 +0200
+++ linux-m68k-2.6.0/drivers/zorro/zorro.h	2003-11-06 21:10:50.000000000 +0100
@@ -0,0 +1,4 @@
+
+extern void zorro_name_device(struct zorro_dev *z);
+extern void zorro_create_sysfs_dev_files(struct zorro_dev *z);
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
