Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVEQWf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVEQWf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVEQWWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:22:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:41381 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262009AbVEQWMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:12:21 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] Driver Core: remove driver model detach_state
In-Reply-To: <1116367945543@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 15:12:26 -0700
Message-Id: <11163679452255@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: remove driver model detach_state

The driver model has a "detach_state" mechanism that:

 - Has never been used by any in-kernel drive;
 - Is superfluous, since driver remove() methods can do the same thing;
 - Became buggy when the suspend() parameter changed semantics and type;
 - Could self-deadlock when called from certain suspend contexts;
 - Is effectively wasted documentation, object code, and headspace.

This removes that "detach_state" mechanism; net code shrink, as well
as a per-device saving in the driver model and sysfs.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0b405a0f7e4d4d18fd1fe46ddf5ff465443036ab
tree 49d74df6eddfdd095c650e0af34cde7f4548a2d5
parent 82428b62aa6294ea640c7e920a9224ecaf46db65
author David Brownell <david-b@pacbell.net> Thu, 12 May 2005 12:06:27 -0700
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:54:55 -0700

 Documentation/filesystems/sysfs-pci.txt |    6 +--
 Documentation/power/devices.txt         |   21 -------------
 Documentation/powerpc/hvcs.txt          |    4 +-
 drivers/base/Makefile                   |    2 -
 drivers/base/bus.c                      |    1 
 drivers/base/core.c                     |    3 -
 drivers/base/interface.c                |   51 --------------------------------
 drivers/base/power/power.h              |   11 ------
 drivers/base/power/shutdown.c           |   16 ----------
 include/linux/device.h                  |    3 -
 10 files changed, 5 insertions(+), 113 deletions(-)

Index: Documentation/filesystems/sysfs-pci.txt
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/Documentation/filesystems/sysfs-pci.txt  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/Documentation/filesystems/sysfs-pci.txt  (mode:100644)
@@ -7,7 +7,6 @@
      |-- 0000:17:00.0
      |   |-- class
      |   |-- config
-     |   |-- detach_state
      |   |-- device
      |   |-- irq
      |   |-- local_cpus
@@ -19,7 +18,7 @@
      |   |-- subsystem_device
      |   |-- subsystem_vendor
      |   `-- vendor
-     `-- detach_state
+     `-- ...
 
 The topmost element describes the PCI domain and bus number.  In this case,
 the domain number is 0000 and the bus number is 17 (both values are in hex).
@@ -31,7 +30,6 @@
        ----		   --------
        class		   PCI class (ascii, ro)
        config		   PCI config space (binary, rw)
-       detach_state	   connection status (bool, rw)
        device		   PCI device (ascii, ro)
        irq		   IRQ number (ascii, ro)
        local_cpus	   nearby CPU mask (cpumask, ro)
@@ -85,4 +83,4 @@
 
 Legacy resources are protected by the HAVE_PCI_LEGACY define.  Platforms
 wishing to support legacy functionality should define it and provide
-pci_legacy_read, pci_legacy_write and pci_mmap_legacy_page_range functions.
\ No newline at end of file
+pci_legacy_read, pci_legacy_write and pci_mmap_legacy_page_range functions.
Index: Documentation/power/devices.txt
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/Documentation/power/devices.txt  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/Documentation/power/devices.txt  (mode:100644)
@@ -207,27 +207,6 @@
 #READY_AFTER_RESUME
 #
 
-Driver Detach Power Management
-
-The kernel now supports the ability to place a device in a low-power
-state when it is detached from its driver, which happens when its
-module is removed. 
-
-Each device contains a 'detach_state' file in its sysfs directory
-which can be used to control this state. Reading from this file
-displays what the current detach state is set to. This is 0 (On) by
-default. A user may write a positive integer value to this file in the
-range of 1-4 inclusive. 
-
-A value of 1-3 will indicate the device should be placed in that
-low-power state, which will cause ->suspend() to be called for that
-device. A value of 4 indicates that the device should be shutdown, so
-->shutdown() will be called for that device. 
-
-The driver is responsible for reinitializing the device when the
-module is re-inserted during it's ->probe() (or equivalent) method. 
-The driver core will not call any extra functions when binding the
-device to the driver. 
 
 pm_message_t meaning
 
Index: Documentation/powerpc/hvcs.txt
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/Documentation/powerpc/hvcs.txt  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/Documentation/powerpc/hvcs.txt  (mode:100644)
@@ -347,8 +347,8 @@
 looks like the following:
 
 	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # ls
-	.   current_vty   devspec  name          partner_vtys
-	..  detach_state  index    partner_clcs  vterm_state
+	.   current_vty   devspec       name          partner_vtys
+	..  index         partner_clcs  vterm_state
 
 Each entry is provided, by default with a "name" attribute.  Reading the
 "name" attribute will reveal the device type as shown in the following
Index: drivers/base/Makefile
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/Makefile  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/drivers/base/Makefile  (mode:100644)
@@ -1,6 +1,6 @@
 # Makefile for the Linux device tree
 
-obj-y			:= core.o sys.o interface.o bus.o \
+obj-y			:= core.o sys.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
 			   attribute_container.o transport_class.o
Index: drivers/base/bus.c
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/bus.c  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/drivers/base/bus.c  (mode:100644)
@@ -390,7 +390,6 @@
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
 		list_del_init(&dev->driver_list);
-		device_detach_shutdown(dev);
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
Index: drivers/base/core.c
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/core.c  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/drivers/base/core.c  (mode:100644)
@@ -31,8 +31,6 @@
 #define to_dev(obj) container_of(obj, struct device, kobj)
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
-extern struct attribute * dev_default_attrs[];
-
 static ssize_t
 dev_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
 {
@@ -89,7 +87,6 @@
 static struct kobj_type ktype_device = {
 	.release	= device_release,
 	.sysfs_ops	= &dev_sysfs_ops,
-	.default_attrs	= dev_default_attrs,
 };
 
 
Index: drivers/base/interface.c
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/interface.c  (mode:100644)
+++ /dev/null  (tree:49d74df6eddfdd095c650e0af34cde7f4548a2d5)
@@ -1,51 +0,0 @@
-/*
- * drivers/base/interface.c - common driverfs interface that's exported to
- * 	the world for all devices.
- *
- * Copyright (c) 2002-3 Patrick Mochel
- * Copyright (c) 2002-3 Open Source Development Labs
- *
- * This file is released under the GPLv2
- *
- */
-
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/stat.h>
-#include <linux/string.h>
-
-/**
- *	detach_state - control the default power state for the device.
- *
- *	This is the state the device enters when it's driver module is
- *	unloaded. The value is an unsigned integer, in the range of 0-4.
- *	'0' indicates 'On', so no action will be taken when the driver is
- *	unloaded. This is the default behavior.
- *	'4' indicates 'Off', meaning the driver core will call the driver's
- *	shutdown method to quiesce the device.
- *	1-3 indicate a low-power state for the device to enter via the
- *	driver's suspend method.
- */
-
-static ssize_t detach_show(struct device * dev, char * buf)
-{
-	return sprintf(buf, "%u\n", dev->detach_state);
-}
-
-static ssize_t detach_store(struct device * dev, const char * buf, size_t n)
-{
-	u32 state;
-	state = simple_strtoul(buf, NULL, 10);
-	if (state > 4)
-		return -EINVAL;
-	dev->detach_state = state;
-	return n;
-}
-
-static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
-
-
-struct attribute * dev_default_attrs[] = {
-	&dev_attr_detach_state.attr,
-	NULL,
-};
Index: drivers/base/power/power.h
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/power/power.h  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/drivers/base/power/power.h  (mode:100644)
@@ -1,18 +1,7 @@
-
-
-enum {
-	DEVICE_PM_ON,
-	DEVICE_PM1,
-	DEVICE_PM2,
-	DEVICE_PM3,
-	DEVICE_PM_OFF,
-};
-
 /*
  * shutdown.c
  */
 
-extern int device_detach_shutdown(struct device *);
 extern void device_shutdown(void);
 
 
Index: drivers/base/power/shutdown.c
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/power/shutdown.c  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/drivers/base/power/shutdown.c  (mode:100644)
@@ -19,22 +19,6 @@
 extern struct subsystem devices_subsys;
 
 
-int device_detach_shutdown(struct device * dev)
-{
-	if (!dev->detach_state)
-		return 0;
-
-	if (dev->detach_state == DEVICE_PM_OFF) {
-		if (dev->driver && dev->driver->shutdown) {
-			dev_dbg(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-		return 0;
-	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
-}
-
-
 /**
  * We handle system devices differently - we suspend and shut them
  * down last and resume them first. That way, we don't do anything stupid like
Index: include/linux/device.h
===================================================================
--- f9e9bfd1f86f739ee16968378057060417f52bb4/include/linux/device.h  (mode:100644)
+++ 49d74df6eddfdd095c650e0af34cde7f4548a2d5/include/linux/device.h  (mode:100644)
@@ -273,9 +273,6 @@
 					   BIOS data relevant to device) */
 	struct dev_pm_info	power;
 
-	u32		detach_state;	/* State to enter when device is
-					   detached from its driver. */
-
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
 					     alloc_coherent mappings as

