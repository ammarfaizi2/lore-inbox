Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbULKFqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbULKFqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 00:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbULKFqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 00:46:39 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:3774 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261842AbULKFpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 00:45:23 -0500
Date: Sat, 11 Dec 2004 00:45:09 -0500
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rml@ximian.com, mochel@digitalimplant.org,
       len.brown@intel.com, shaohua.li@intel.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [RFC] Device Resource Management
Message-ID: <20041211054509.GA2661@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com, linux-kernel@vger.kernel.org,
	greg@kroah.com, rml@ximian.com, mochel@digitalimplant.org,
	len.brown@intel.com, shaohua.li@intel.com,
	Bjorn Helgaas <bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

This patch is a draft for the core infustructure of driver model based
resource management.  Buses capable of dynamically allocating resources (such
as PCI or pcmcia), and recent developments with linux ACPI support have
incited the need for the kernel to keep track of system resources, and assist
in the allocation process.  Eventually I'd like to move on to more complex
problems like resource rebalancing.  This patch simply lays out some
foundation.

We currently have some infustructure, but it is more or less incomplete.  For
example, it doesn't show how resources and the devices that consume them are
related.  Also it isn't flexable enough to track all types of bus resources.
ACPI, PnP, and PCI have to allocate interrupts somewhat blindly because
request_irq happens too late in the game, and really is used to register
interrupt handlers, not track interrupt usage.

My implementation is not based on the existing "struct resource" stuff because
quite frankly, even making small changes would break a large number of
drivers.  Instead it uses "struct iores"  My hope is that we can gradually
phase the old implementation out.

With that in mind, I'd like to work out a solid new API, and would appreciate
any comments or suggestions, both on the code in this patch and the overall
design of the API.

A few issues need to be discussed.  The most important is probably how sysfs
will display resource usage?  "struct kobject" is actually larger then "struct
iores" so I don't feel very comfortable embedding it.  But, if a kobject based
sysfs resource tree would be needed, then I'd be happy to implement it.  If
not what would be a good alternative?  Does the user have to read resources
from each device like one would with this current patch?

Thanks,
Adam

This patch was only tested for compilation so it may have a few bugs/typos.
Once again I'd really appreciate any comments or suggestions.


diff -urN a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	2004-10-18 17:54:55.000000000 -0400
+++ b/drivers/base/Makefile	2004-12-10 14:55:46.000000000 -0500
@@ -3,7 +3,7 @@
 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o
-obj-y			+= power/
+obj-y			+= power/ resource/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
 
diff -urN a/drivers/base/resource/bars.c b/drivers/base/resource/bars.c
--- a/drivers/base/resource/bars.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/base/resource/bars.c	2004-12-10 15:56:11.000000000 -0500
@@ -0,0 +1,42 @@
+/*
+ * bars.c - functions for manipulating device resource sets
+ *
+ * Copyright (c) 2004 Adam Belay
+ *
+ * This file is released under the GPLv2
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+
+struct iores * device_get_iores(struct device *dev, unsigned int idx)
+{
+	if (idx < dev->num_resources)
+		return &dev->res[idx];
+	else
+		return NULL;
+}
+
+EXPORT_SYMBOL(device_get_iores);
+
+struct iores * device_find_iores(struct device *dev, unsigned int type,
+				 unsigned int n)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct iores *slot = &dev->res[i];
+
+		if (slot->type == type) {
+			if (n-- == 0) {
+				if (iores_disabled(slot))
+					return NULL;
+				else
+					return slot;
+			}
+		}
+	}
+	return NULL;
+}
+
+EXPORT_SYMBOL(device_find_iores);
diff -urN a/drivers/base/resource/base.h b/drivers/base/resource/base.h
--- a/drivers/base/resource/base.h	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/base/resource/base.h	2004-12-10 17:28:16.000000000 -0500
@@ -0,0 +1,19 @@
+/*
+ * base.h - internal resource management header
+ *
+ * Copyright (c) 2004 Adam Belay
+ *
+ * This file is released under the GPLv2
+ */
+
+struct iores_type {
+	char			*name;
+	spinlock_t		lock;
+	struct iores		*default_root;
+
+	struct iores * (*conflict) (struct iores *new, struct iores *root, 
+				    struct iores *from); 
+};
+
+extern struct iores_type * iores_get_type(struct iores *res);
+
diff -urN a/drivers/base/resource/device.c b/drivers/base/resource/device.c
--- a/drivers/base/resource/device.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/base/resource/device.c	2004-12-10 22:47:18.000000000 -0500
@@ -0,0 +1,69 @@
+/*
+ * device.c - device resource configuration
+ *
+ * Copyright (c) 2004 Adam Belay
+ *
+ * This file is released under the GPLv2
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+
+static DECLARE_MUTEX(device_state_mutex);
+
+int device_assign_resources(struct device *dev)
+{
+	int ret;
+
+	down(&device_state_mutex);
+	if (dev->resource_state != DEVICE_DISABLED) {
+		up(&device_state_mutex);
+		return -EBUSY;
+	}
+	ret = dev->bus->assign(dev);
+	up(&device_state_mutex);
+	
+	if (ret)
+		printk(KERN_ERR "RES: unable to assign resource for '%s:%s'\n",
+		       dev->bus ? dev->bus->name : "no-bus", dev->kobj.name);
+	return ret;		
+}
+
+int device_enable(struct device *dev)
+{
+	int ret;
+
+	down(&device_state_mutex);
+	ret = dev->bus->enable(dev);
+	if (!ret)
+		dev->resource_state = DEVICE_ENABLED;
+	up(&device_state_mutex);
+
+	if (ret)
+		printk(KERN_ERR "RES: unable to enable '%s:%s'\n",
+		 dev->bus ? dev->bus->name : "no-bus", dev->kobj.name);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(device_enable);
+
+int device_disable(struct device *dev)
+{
+	int ret;
+
+	down(&device_state_mutex);
+	ret = dev->bus->disable(dev);
+	if (!ret)
+		dev->resource_state = DEVICE_DISABLED;
+	up(&device_state_mutex);
+
+	if (ret)
+		printk(KERN_ERR "RES: unable to disable '%s:%s'\n",
+		 dev->bus ? dev->bus->name : "no-bus", dev->kobj.name);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(device_disable);
diff -urN a/drivers/base/resource/iores.c b/drivers/base/resource/iores.c
--- a/drivers/base/resource/iores.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/base/resource/iores.c	2004-12-10 22:46:04.000000000 -0500
@@ -0,0 +1,306 @@
+/*
+ * iores.c - core resource management infustructure
+ *
+ * Copyright (c) 2004 Adam Belay
+ *
+ * This file is released under the GPLv2
+ *
+ * based on "kernel/resource.c"
+ * Copyright (c) 1999 Linus Torvalds and Martin Mares
+ */
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/iores.h>
+#include <linux/spinlock.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+
+#include "base.h"
+
+
+/* 
+ * Resource Types
+ */
+
+struct iores io_root = {
+	.type = IORES_TYPE_IO,
+	.start = 0x0000,
+	.end = IO_SPACE_LIMIT,
+};
+
+static struct iores * 
+io_detect_conflict(struct iores *new, struct iores *root, struct iores *from)
+{
+	unsigned long start, end, mask;
+	struct iores *tmp, **p;
+
+	mask = 0xffff;
+
+	if ((new->flags & IORES_IO_10DECODE))
+		mask = 0x03ff;
+	else if ((new->flags & IORES_IO_12DECODE))
+		mask = 0x0fff;
+
+	start = (new->start & mask);
+	end = (new->end & mask);
+
+	if ((start < root->start) || (end > root->end))
+		return root;
+
+	if (from)
+		p = &from->sibling;
+	else
+		p = &root->child;
+
+	for (;;) {
+		tmp = *p;
+		if (!tmp || tmp->start > end)
+			break;
+		p = &tmp->sibling;
+		if (tmp->end < start)
+			continue;
+		return tmp;
+	}
+
+	new->sibling = tmp;
+	new->start = start;
+	new->end = end;
+	*p = new;
+
+	return NULL;
+}
+
+struct iores mem_root = {
+	.type = IORES_TYPE_MEM,
+	.start = 0UL,
+	.end = ~0UL,
+};
+
+struct iores irq_root = {
+	.type = IORES_TYPE_IRQ,
+	.start = 0,
+	.end = NR_IRQS,
+};
+
+struct iores dma_root = {
+	.type = IORES_TYPE_DMA,
+	.start = 0,
+	.end = MAX_DMA_CHANNELS,
+};
+
+static struct iores_type iores_type_table[] = {
+	{ .name = "io", .default_root = &io_root,
+	  .lock = SPIN_LOCK_UNLOCKED, .conflict = io_detect_conflict },
+	{ .name = "mem", .default_root = &mem_root,
+	  .lock = SPIN_LOCK_UNLOCKED },
+	{ .name = "irq", .default_root = &irq_root,
+	  .lock = SPIN_LOCK_UNLOCKED },
+	{ .name = "dma", .default_root = &dma_root,
+	  .lock = SPIN_LOCK_UNLOCKED },
+	{ .name = "busnr", .default_root = NULL,
+	  .lock = SPIN_LOCK_UNLOCKED },
+	{}
+};
+
+#define NR_TYPES	5
+
+struct iores_type * iores_get_type(struct iores *res)
+{
+	if (res->type > (NR_TYPES - 1))
+		return NULL;
+
+	return &iores_type_table[res->type];
+}
+
+static struct iores * 
+iores_detect_conflict(struct iores *new, struct iores *root, struct iores *from)
+{
+	unsigned long start, end;
+	struct iores *tmp, **p;
+
+	start = new->start;
+	end = new->end;
+
+	if ((start < root->start) || (end > root->end))
+		return root;
+
+	if (from)
+		p = &from->sibling;
+	else
+		p = &root->child;
+
+	for (;;) {
+		tmp = *p;
+		if (!tmp || tmp->start > end)
+			break;
+		p = &tmp->sibling;
+		if (tmp->end < start)
+			continue;
+		return tmp;
+	}
+
+	new->sibling = tmp;
+	*p = new;
+
+	return NULL;
+}
+
+
+/*
+ * Resource Registration
+ */
+
+static int iores_init(struct iores *res, struct iores_type *type)
+{
+        if (!res->parent) {
+		if (type->default_root)
+			res->parent = type->default_root;
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct iores * 
+__iores_register(struct iores *res, struct iores_type *type, struct iores *from)
+{
+	if (type->conflict)
+		return type->conflict(res, res->parent, from);
+	else
+		return iores_detect_conflict(res, res->parent, from);
+}
+
+int iores_register(struct iores *res)
+{
+	struct iores_type *type;
+	struct iores *conflict;
+
+	if (!(type = iores_get_type(res)))
+		return -EINVAL;
+
+	if (iores_init(res, type))
+		return -EINVAL;
+
+	spin_lock(&type->lock);
+	conflict = __iores_register(res, type, NULL);
+	spin_unlock(&type->lock);
+
+	return conflict ? -EBUSY : 0;
+
+}
+
+EXPORT_SYMBOL(iores_register);
+
+void iores_unregister(struct iores *res)
+{
+	struct iores_type *type;
+	struct iores *tmp, **p;
+
+	if (!(type = iores_get_type(res)))
+		return;
+
+	spin_lock(&type->lock);
+	p = &res->parent->child;
+	for (;;) {
+		tmp = *p;
+		if (!tmp)
+			break;
+		if (tmp == res) {
+			*p = tmp->sibling;
+			res->parent = NULL;
+			break;
+		}
+		p = &tmp->sibling;
+	}
+	spin_unlock(&type->lock);
+}
+
+EXPORT_SYMBOL(iores_unregister);
+
+
+/*
+ * Resource Allocation
+ */
+
+int
+iores_assign_range(struct iores *res, unsigned long min, unsigned long max,
+		   unsigned long length, unsigned long align)
+{
+	struct iores *conflict;
+	struct iores_type *type;
+	
+	conflict = NULL;
+	
+	if (!(type = iores_get_type(res)))
+		return -EINVAL;		
+	if (iores_init(res, type))
+		return -EINVAL;
+		
+	res->start = min;
+	
+	spin_lock(&type->lock);
+
+	for (;;) {
+		res->end = res->start + length - 1;
+		
+		if (res->end > max)
+			break;
+		
+		if (!(conflict = __iores_register(res, type, conflict))) {
+			spin_unlock(&type->lock);
+			return 0;
+		}
+				
+                res->start = conflict->end + 1;
+		res->start = (res->start + align - 1) & ~(align - 1);
+	}
+	
+	spin_unlock(&type->lock);
+
+	return -EBUSY;
+}
+
+EXPORT_SYMBOL(iores_assign_range);
+
+int
+iores_assign_mask(struct iores *res, __u32 *p,  unsigned int count)
+{
+	int i;
+	struct iores *conflict;
+	struct iores_type *type;
+
+	conflict = NULL;
+	
+	if (!(type = iores_get_type(res)))
+		return -EINVAL;
+	if (iores_init(res, type))
+		return -EINVAL;
+
+	spin_lock(type->lock);
+	
+	while (--count) {
+		for (i = 0; i < 32; i++) {
+			if (*p & (1<<i)) {
+				res->start = res->end = i + count * 32;
+				conflict = __iores_register(res, type, conflict);
+
+				if (!conflict) {
+					spin_unlock(type->lock);
+					return 0;
+				}
+				
+			}
+		}
+		p += sizeof(__u32);
+	}
+
+	spin_unlock(type->lock);
+	
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL(iores_assign_mask);
diff -urN a/drivers/base/resource/Makefile b/drivers/base/resource/Makefile
--- a/drivers/base/resource/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/base/resource/Makefile	2004-12-07 03:01:45.000000000 -0500
@@ -0,0 +1,9 @@
+#
+# Makefile for Linux Resource Management.
+#
+
+obj-y := bars.o device.o iores.o sysfs.o
+
+ifeq ($(CONFIG_DEBUG_DRIVER),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -urN a/drivers/base/resource/sysfs.c b/drivers/base/resource/sysfs.c
--- a/drivers/base/resource/sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/base/resource/sysfs.c	2004-12-10 17:55:51.000000000 -0500
@@ -0,0 +1,145 @@
+/*
+ * sysfs.c - sysfs interface for userspace resource management.
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (c) 2004 Adam Belay
+ *
+ * Based on drivers/base/power/sysfs.c
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/ctype.h>
+
+#include "base.h"
+
+static ssize_t state_show(struct device * dev, char * buf)
+{
+	char * state = dev->resource_state ? "enabled" : "disabled";
+	return sprintf(buf, "%s\n", state);
+}
+
+static ssize_t state_store(struct device * dev, const char * buf, size_t n)
+{
+	int ret = 0;
+
+	if (!strnicmp(buf,"enable",6)) {
+		ret = device_enable(dev);
+		goto done;
+	}
+
+	if (!strnicmp(buf,"disable",7))
+		ret = device_disable(dev);
+
+done:
+	return ret ? ret : n;
+}
+
+static DEVICE_ATTR(state, 0644, state_show, state_store);
+
+static ssize_t resources_show(struct device * dev, char * buf)
+{
+	char * str = buf;
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct iores *res = &dev->res[i];
+		struct iores_type *type = iores_get_type(res);
+
+		if (!type)
+			continue;
+		
+		str += sprintf(str, "%u %s ", i+1, type->name);
+		if (res->flags & IORESOURCE_UNSET)
+			str += sprintf(str, "unset\n");
+		else if (res->flags & IORESOURCE_DISABLED)
+			str += sprintf(str, "disabled\n");
+		else
+			str += sprintf(str, "0x%016lx-0x%016lx 0x%016lx\n",
+				       res->start, res->end, res->flags);
+	}
+
+	return (str - buf);
+}
+
+static ssize_t resources_store(struct device * dev, const char * buf, size_t n)
+{
+	int index;
+	char * rest;
+	int err = 0, registered;
+	struct iores *res;
+
+	index = simple_strtoul(buf, &rest, 10);
+	if (!index || index > dev->num_resources) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	res = &dev->res[index-1];
+	registered = (res->flags & IORES_REGISTERED);
+
+	while (isspace(*buf))
+		++buf;
+
+	if (!strnicmp(buf,"disable",7)) {
+		if (registered)
+			iores_unregister(res);
+		res->flags |= IORES_DISABLED;
+		goto done;
+	}
+
+	if (!strnicmp(buf,"unset",5)) {
+		if (registered)
+			iores_unregister(res);
+		res->flags &= ~IORES_DISABLED;
+		goto done;
+	}
+
+	res->start = simple_strtoul(rest, &rest, 0);
+
+	while (isspace(*buf))
+		++buf;
+	if(*buf == '-') {
+		buf += 1;
+		while (isspace(*buf))
+			++buf;
+		res->end = simple_strtoul(rest, &rest, 0);
+	} else
+		res->end = res->start;
+
+	while (isspace(*buf))
+		++buf;
+	res->flags = simple_strtoul(rest, &rest, 0);
+
+	res->flags &= ~(IORES_DISABLED);
+	err = iores_register(res);
+
+done:
+	return err ? err : n;
+}
+
+static DEVICE_ATTR(resources, 0644, resources_show, resources_store);
+
+
+static struct attribute * resource_attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_resources.attr,
+	NULL,
+};
+
+static struct attribute_group res_attr_group = {
+	.name	= "resource",
+	.attrs	= resource_attrs,
+};
+
+int res_sysfs_add(struct device * dev)
+{
+	return sysfs_create_group(&dev->kobj, &res_attr_group);
+}
+
+void res_sysfs_remove(struct device * dev)
+{
+	sysfs_remove_group(&dev->kobj, &res_attr_group);
+}
--- a/include/linux/device.h	2004-10-18 17:55:07.000000000 -0400
+++ b/include/linux/device.h	2004-12-10 17:54:22.000000000 -0500
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 #include <linux/ioport.h>
+#include <linux/iores.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
@@ -41,6 +42,11 @@
 	RESUME_ENABLE,
 };
 
+enum {
+	DEVICE_DISABLED,
+	DEVICE_ENABLED,
+};
+
 struct device;
 struct device_driver;
 struct class;
@@ -63,6 +69,10 @@
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
+
+	int		(*enable)(struct device *dev);
+	int		(*disable)(struct device *dev);
+	int		(*assign)(struct device *dev);
 };
 
 extern int bus_register(struct bus_type * bus);
@@ -282,6 +292,11 @@
 					     64 bit addresses for consistent
 					     allocations such descriptors. */
 
+	int		resource_state;	/* specifies whether the device is
+					   decoding resources */
+	unsigned int	num_resources;	/* number of resources in res */
+	struct iores	*res;		/* a table of resources */
+	
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
--- a/include/linux/iores.h	1969-12-31 19:00:00.000000000 -0500
+++ b/include/linux/iores.h	2004-12-10 17:56:01.000000000 -0500
@@ -0,0 +1,148 @@
+/*
+ * busres.h - hardware resource management for the driver model
+ *
+ * Copyright (c) 2004 Adam Belay <abelay@novell.com>
+ */
+
+#ifndef _LINUX_IORES_H
+#define _LINUX_IORES_H
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+
+/*
+ * I/O Resources
+ */
+
+struct iores {
+	unsigned int type;	/* a resource class identifier that specifies a location
+				   in the resource type array, */
+	unsigned long start;	/* the starting vector */
+	unsigned long end;	/* the last vector in the range (inclusive) */
+	unsigned long flags;	/* flags (general and bus specific) */
+
+	struct iores *parent;	/* the parent resource */
+	struct iores *child;	/* the first consumer */
+	struct iores *sibling;	/* the next sibling consumer of this producer */
+	struct device *dev;	/* the device that owns this resource */
+};
+
+#define IORES_REGISTERED		0x00000001
+#define IORES_DISABLED			0x00000002
+#define IORES_SHARABLE			0x00000004
+
+static inline int iores_disabled(struct iores *res)
+{
+	return (res->flags & IORES_DISABLED);
+}
+
+static inline unsigned long iores_start(struct iores *res)
+{
+	return res->start;
+}
+
+static inline unsigned long iores_end(struct iores *res)
+{
+	return res->end;
+}
+
+static inline unsigned long iores_length(struct iores *res)
+{
+	return res->end - res->start + 1;
+}
+
+
+/*
+ * Resource Types
+ */
+
+enum {
+        IORES_TYPE_IO = 0,
+        IORES_TYPE_MEM,
+        IORES_TYPE_IRQ,
+        IORES_TYPE_DMA,
+	IORES_TYPE_BUSNR,
+};
+
+/* I/O Port */
+extern struct iores io_root;
+
+#define IORES_IO_10DECODE		0x00000100
+#define IORES_IO_12DECODE		0x00000200
+
+/* I/O Mem */
+extern struct iores mem_root;
+
+#define IORES_MEM_WIDTH_8		0x00000100
+#define IORES_MEM_WIDTH_16		0x00000200
+#define IORES_MEM_WIDTH_32		0x00000400
+#define IORES_MEM_WIDTH_64		0x00000800
+#define IORES_MEM_PREFETCH		0x00001000
+#define IORES_MEM_READONLY		0x00002000
+#define IORES_MEM_CACHEABLE		0x00004000
+
+/* Interrupts */
+extern struct iores irq_root;
+
+#define IORES_IRQ_EDGE_HIGH		0x00000100
+#define IORES_IRQ_EDGE_LOW		0x00000200
+#define IORES_IRQ_LEVEL_HIGH		0x00000400
+#define IORESOURCE_IRQ_LEVEL_LOW	0x00000800
+
+/* legacy DMA */
+extern struct iores dma_root;
+
+#define IORES_DMA_ISA_COMPAT		0x00000100
+#define IORES_DMA_TYPEA			0x00000200
+#define IORES_DMA_TYPEB			0x00000400
+#define IORES_DMA_TYPEF			0x00000800
+#define IORES_DMA_TRANS_8		0x00001000
+#define IORES_DMA_TRANS_8_16		0x00002000
+#define IORES_DMA_TRANS_16		0x00004000
+#define IORES_DMA_BUS_MASTER		0x00008000
+
+
+/*
+ * Resource Registration
+ */
+
+extern int iores_register(struct iores *res);
+extern void iores_unregister(struct iores *res);
+
+
+/*
+ * Resource Assignment Helpers
+ */
+
+extern int iores_assign_ranged(struct iores *res, unsigned long min,
+			       unsigned long max, unsigned long length,
+			       unsigned long align);
+extern int iores_assign_masked(struct iores *res, __u32 *p, 
+			       unsigned int count);
+
+
+/*
+ * Driver Utilities
+ */
+
+extern struct iores * device_get_iores(struct device *dev, unsigned int idx);
+extern struct iores * device_find_iores(struct device *dev, unsigned int type,
+				        unsigned int n);
+
+
+/*
+ * Device Control
+ */
+
+extern int device_assign_resources(struct device *dev);
+extern int device_enable(struct device *dev);
+extern int device_disable(struct device *dev);
+
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_IORES_H */
+
