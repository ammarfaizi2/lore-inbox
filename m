Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWA0Wxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWA0Wxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWA0WxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:53:22 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:57249 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422662AbWA0Ww5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:52:57 -0500
Date: Sat, 28 Jan 2006 00:52:55 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 7/11] sh: convert voyagergx to platform device, drop sh-bus.
Message-ID: <20060127225255.GH30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	Manuel Lauss <mano@roarinelk.homelinux.net>
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch updating the voyagergx cchip code to reference a
platform device instead, now that the dma mask is taken care
of. Given this, there's no longer any reason to drag around the
SH-bus code, so kill that off entirely.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/cchips/voyagergx/consistent.c |   15 +--
 arch/sh/cchips/voyagergx/irq.c        |    7 +
 arch/sh/kernel/cpu/Makefile           |    2 
 arch/sh/kernel/cpu/bus.c              |  197 ---------------------------------
 include/asm-sh/bus-sh.h               |   66 -----------
 5 files changed, 12 insertions(+), 275 deletions(-)
 delete mode 100644 arch/sh/kernel/cpu/bus.c
 delete mode 100644 include/asm-sh/bus-sh.h

29a11ff14a7ec1409a7e3e8b62e5830d2dd1f080
diff --git a/arch/sh/cchips/voyagergx/consistent.c b/arch/sh/cchips/voyagergx/consistent.c
index 3d9a02c..07e8b9c 100644
--- a/arch/sh/cchips/voyagergx/consistent.c
+++ b/arch/sh/cchips/voyagergx/consistent.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <asm/io.h>
-#include <asm/bus-sh.h>
+
 
 struct voya_alloc_entry {
 	struct list_head list;
@@ -30,12 +30,13 @@ static LIST_HEAD(voya_alloc_list);
 #define OHCI_HCCA_SIZE	0x100
 #define OHCI_SRAM_SIZE	0x10000
 
+#define VOYAGER_OHCI_NAME	"voyager-ohci"
+
 void *voyagergx_consistent_alloc(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t flag)
 {
 	struct list_head *list = &voya_alloc_list;
 	struct voya_alloc_entry *entry;
-	struct sh_dev *shdev = to_sh_dev(dev);
 	unsigned long start, end;
 	unsigned long flags;
 
@@ -46,9 +47,7 @@ void *voyagergx_consistent_alloc(struct 
 	 *
 	 * Everything else goes through consistent_alloc().
 	 */
-	if (!dev || dev->bus != &sh_bus_types[SH_BUS_VIRT] ||
-		   (dev->bus == &sh_bus_types[SH_BUS_VIRT] &&
-		    shdev->dev_id != SH_DEV_ID_USB_OHCI))
+	if (!dev || strcmp(dev->driver->name, VOYAGER_OHCI_NAME))
 		return NULL;
 
 	start = OHCI_SRAM_START + OHCI_HCCA_SIZE;
@@ -98,12 +97,9 @@ int voyagergx_consistent_free(struct dev
 			      void *vaddr, dma_addr_t handle)
 {
 	struct voya_alloc_entry *entry;
-	struct sh_dev *shdev = to_sh_dev(dev);
 	unsigned long flags;
 
-	if (!dev || dev->bus != &sh_bus_types[SH_BUS_VIRT] ||
-		   (dev->bus == &sh_bus_types[SH_BUS_VIRT] &&
-		    shdev->dev_id != SH_DEV_ID_USB_OHCI))
+	if (!dev || strcmp(dev->driver->name, VOYAGER_OHCI_NAME))
 		return -EINVAL;
 
 	spin_lock_irqsave(&voya_list_lock, flags);
@@ -123,4 +119,3 @@ int voyagergx_consistent_free(struct dev
 
 EXPORT_SYMBOL(voyagergx_consistent_alloc);
 EXPORT_SYMBOL(voyagergx_consistent_free);
-
diff --git a/arch/sh/cchips/voyagergx/irq.c b/arch/sh/cchips/voyagergx/irq.c
index 1b6ac52..2ee330b 100644
--- a/arch/sh/cchips/voyagergx/irq.c
+++ b/arch/sh/cchips/voyagergx/irq.c
@@ -163,7 +163,12 @@ int voyagergx_irq_demux(int irq)
 	return irq;
 }
 
-static struct irqaction irq0  = { voyagergx_interrupt, SA_INTERRUPT, 0, "VOYAGERGX", NULL, NULL};
+static struct irqaction irq0  = {
+	.name		= "voyagergx",
+	.handler	= voyagergx_interrupt,
+	.flags		= SA_INTERRUPT,
+	.mask		= CPU_MASK_NONE,
+};
 
 void __init setup_voyagergx_irq(void)
 {
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index 5bfc33b..59d5b74 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the Linux/SuperH CPU-specifc backends.
 #
 
-obj-y	+= irq/ init.o bus.o clock.o
+obj-y	+= irq/ init.o clock.o
 
 obj-$(CONFIG_CPU_SH2)		+= sh2/
 obj-$(CONFIG_CPU_SH3)		+= sh3/
diff --git a/arch/sh/kernel/cpu/bus.c b/arch/sh/kernel/cpu/bus.c
deleted file mode 100644
index fc6c4bd..0000000
--- a/arch/sh/kernel/cpu/bus.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * arch/sh/kernel/cpu/bus.c
- *
- * Virtual bus for SuperH.
- *
- * Copyright (C) 2004 Paul Mundt
- *
- * Shamelessly cloned from arch/arm/mach-omap/bus.c, which was written
- * by:
- *
- *  	Copyright (C) 2003 - 2004 Nokia Corporation
- *  	Written by Tony Lindgren <tony@atomide.com>
- *  	Portions of code based on sa1111.c.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- */
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/bus-sh.h>
-
-static int sh_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct sh_driver *shdrv = to_sh_driver(drv);
-	struct sh_dev *shdev = to_sh_dev(dev);
-
-	return shdev->dev_id == shdrv->dev_id;
-}
-
-static int sh_bus_suspend(struct device *dev, pm_message_t state)
-{
-	struct sh_dev *shdev = to_sh_dev(dev);
-	struct sh_driver *shdrv = to_sh_driver(dev->driver);
-
-	if (shdrv && shdrv->suspend)
-		return shdrv->suspend(shdev, state);
-
-	return 0;
-}
-
-static int sh_bus_resume(struct device *dev)
-{
-	struct sh_dev *shdev = to_sh_dev(dev);
-	struct sh_driver *shdrv = to_sh_driver(dev->driver);
-
-	if (shdrv && shdrv->resume)
-		return shdrv->resume(shdev);
-
-	return 0;
-}
-
-static int sh_device_probe(struct device *dev)
-{
-	struct sh_dev *shdev = to_sh_dev(dev);
-	struct sh_driver *shdrv = to_sh_driver(dev->driver);
-
-	if (shdrv && shdrv->probe)
-		return shdrv->probe(shdev);
-
-	return -ENODEV;
-}
-
-static int sh_device_remove(struct device *dev)
-{
-	struct sh_dev *shdev = to_sh_dev(dev);
-	struct sh_driver *shdrv = to_sh_driver(dev->driver);
-
-	if (shdrv && shdrv->remove)
-		return shdrv->remove(shdev);
-
-	return 0;
-}
-
-static struct device sh_bus_devices[SH_NR_BUSES] = {
-	{
-		.bus_id		= SH_BUS_NAME_VIRT,
-	},
-};
-
-struct bus_type sh_bus_types[SH_NR_BUSES] = {
-	{
-		.name		= SH_BUS_NAME_VIRT,
-		.match		= sh_bus_match,
-		.probe		= sh_bus_probe,
-		.remove		= sh_bus_remove,
-		.suspend	= sh_bus_suspend,
-		.resume		= sh_bus_resume,
-	},
-};
-
-int sh_device_register(struct sh_dev *dev)
-{
-	if (!dev)
-		return -EINVAL;
-
-	if (dev->bus_id < 0 || dev->bus_id >= SH_NR_BUSES) {
-		printk(KERN_ERR "%s: bus_id invalid: %s bus: %d\n",
-		       __FUNCTION__, dev->name, dev->bus_id);
-		return -EINVAL;
-	}
-
-	dev->dev.parent = &sh_bus_devices[dev->bus_id];
-	dev->dev.bus    = &sh_bus_types[dev->bus_id];
-
-	/* This is needed for USB OHCI to work */
-	if (dev->dma_mask)
-		dev->dev.dma_mask = dev->dma_mask;
-	if (dev->coherent_dma_mask)
-		dev->dev.coherent_dma_mask = dev->coherent_dma_mask;
-
-	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%s%u",
-		 dev->name, dev->dev_id);
-
-	printk(KERN_INFO "Registering SH device '%s'. Parent at %s\n",
-	       dev->dev.bus_id, dev->dev.parent->bus_id);
-
-	return device_register(&dev->dev);
-}
-
-void sh_device_unregister(struct sh_dev *dev)
-{
-	device_unregister(&dev->dev);
-}
-
-int sh_driver_register(struct sh_driver *drv)
-{
-	if (!drv)
-		return -EINVAL;
-
-	if (drv->bus_id < 0 || drv->bus_id >= SH_NR_BUSES) {
-		printk(KERN_ERR "%s: bus_id invalid: bus: %d device %d\n",
-		       __FUNCTION__, drv->bus_id, drv->dev_id);
-		return -EINVAL;
-	}
-
-	drv->drv.bus    = &sh_bus_types[drv->bus_id];
-
-	return driver_register(&drv->drv);
-}
-
-void sh_driver_unregister(struct sh_driver *drv)
-{
-	driver_unregister(&drv->drv);
-}
-
-static int __init sh_bus_init(void)
-{
-	int i, ret = 0;
-
-	for (i = 0; i < SH_NR_BUSES; i++) {
-		ret = device_register(&sh_bus_devices[i]);
-		if (ret != 0) {
-			printk(KERN_ERR "Unable to register bus device %s\n",
-			       sh_bus_devices[i].bus_id);
-			continue;
-		}
-
-		ret = bus_register(&sh_bus_types[i]);
-		if (ret != 0) {
-			printk(KERN_ERR "Unable to register bus %s\n",
-			       sh_bus_types[i].name);
-			device_unregister(&sh_bus_devices[i]);
-		}
-	}
-
-	printk(KERN_INFO "SH Virtual Bus initialized\n");
-
-	return ret;
-}
-
-static void __exit sh_bus_exit(void)
-{
-	int i;
-
-	for (i = 0; i < SH_NR_BUSES; i++) {
-		bus_unregister(&sh_bus_types[i]);
-		device_unregister(&sh_bus_devices[i]);
-	}
-}
-
-module_init(sh_bus_init);
-module_exit(sh_bus_exit);
-
-MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
-MODULE_DESCRIPTION("SH Virtual Bus");
-MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(sh_bus_types);
-EXPORT_SYMBOL(sh_device_register);
-EXPORT_SYMBOL(sh_device_unregister);
-EXPORT_SYMBOL(sh_driver_register);
-EXPORT_SYMBOL(sh_driver_unregister);
-
diff --git a/include/asm-sh/bus-sh.h b/include/asm-sh/bus-sh.h
deleted file mode 100644
index e42d63b..0000000
--- a/include/asm-sh/bus-sh.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * include/asm-sh/bus-sh.h
- *
- * Copyright (C) 2004 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef __ASM_SH_BUS_SH_H
-#define __ASM_SH_BUS_SH_H
-
-extern struct bus_type sh_bus_types[];
-
-struct sh_dev {
-	struct device	dev;
-	char		*name;
-	unsigned int	dev_id;
-	unsigned int	bus_id;
-	struct resource	res;
-	void		*mapbase;
-	unsigned int	irq[6];
-	u64		*dma_mask;
-	u64		coherent_dma_mask;
-};
-
-#define to_sh_dev(d)	container_of((d), struct sh_dev, dev)
-
-#define sh_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
-#define sh_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, (p))
-
-struct sh_driver {
-	struct device_driver	drv;
-	unsigned int		dev_id;
-	unsigned int		bus_id;
-	int (*probe)(struct sh_dev *);
-	int (*remove)(struct sh_dev *);
-	int (*suspend)(struct sh_dev *, pm_message_t);
-	int (*resume)(struct sh_dev *);
-};
-
-#define to_sh_driver(d)	container_of((d), struct sh_driver, drv)
-#define sh_name(d)	((d)->dev.driver->name)
-
-/*
- * Device ID numbers for bus types
- */
-enum {
-	SH_DEV_ID_USB_OHCI,
-};
-
-#define SH_NR_BUSES		1
-#define SH_BUS_NAME_VIRT	"shbus"
-
-enum {
-	SH_BUS_VIRT,
-};
-
-/* arch/sh/kernel/cpu/bus.c */
-extern int sh_device_register(struct sh_dev *dev);
-extern void sh_device_unregister(struct sh_dev *dev);
-extern int sh_driver_register(struct sh_driver *drv);
-extern void sh_driver_unregister(struct sh_driver *drv);
-
-#endif /* __ASM_SH_BUS_SH_H */
-
