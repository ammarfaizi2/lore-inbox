Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTBFEHO>; Wed, 5 Feb 2003 23:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTBFEFe>; Wed, 5 Feb 2003 23:05:34 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50960 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265382AbTBFEC5>;
	Wed, 5 Feb 2003 23:02:57 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <1044504487837@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044882693@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.8, 2003/02/05 17:19:49+11:00, greg@kroah.com

[PATCH] PCI Hotplug: moved the some stuff into the pci core

Moved functions from drivers/hotplug/pci_hotplug_util.c to
drivers/pci/hotplug.c, which is a better place for them.


diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Thu Feb  6 14:51:53 2003
+++ b/drivers/hotplug/Makefile	Thu Feb  6 14:51:53 2003
@@ -9,8 +9,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
 
-pci_hotplug-objs	:=	pci_hotplug_core.o	\
-				pci_hotplug_util.o
+pci_hotplug-objs	:=	pci_hotplug_core.o
 
 ifdef CONFIG_HOTPLUG_PCI_CPCI
 pci_hotplug-objs	+=	cpci_hotplug_core.o	\
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Thu Feb  6 14:51:52 2003
+++ b/drivers/hotplug/pci_hotplug.h	Thu Feb  6 14:51:52 2003
@@ -142,37 +142,5 @@
 extern int pci_hp_change_slot_info	(struct hotplug_slot *slot,
 					 struct hotplug_slot_info *info);
 
-struct pci_dev_wrapped {
-	struct pci_dev	*dev;
-	void		*data;
-};
-
-struct pci_bus_wrapped {
-	struct pci_bus	*bus;
-	void		*data;
-};
-
-struct pci_visit {
-	int (* pre_visit_pci_bus)	(struct pci_bus_wrapped *,
-					 struct pci_dev_wrapped *);
-	int (* post_visit_pci_bus)	(struct pci_bus_wrapped *,
-					 struct pci_dev_wrapped *);
-
-	int (* pre_visit_pci_dev)	(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-	int (* visit_pci_dev)		(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-	int (* post_visit_pci_dev)	(struct pci_dev_wrapped *,
-					 struct pci_bus_wrapped *);
-};
-
-extern int pci_visit_dev	(struct pci_visit *fn,
-				 struct pci_dev_wrapped *wrapped_dev,
-				 struct pci_bus_wrapped *wrapped_parent);
-
-int pci_is_dev_in_use(struct pci_dev *dev);
-
-int pci_remove_device_safe(struct pci_dev *dev);
-
 #endif
 
diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Thu Feb  6 14:51:53 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,217 +0,0 @@
-/*
- * PCI HotPlug Utility functions
- *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <greg@kroah.com>
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
-#include "pci_hotplug.h"
-
-
-#if !defined(CONFIG_HOTPLUG_PCI_MODULE)
-	#define MY_NAME	"pci_hotplug"
-#else
-	#define MY_NAME	THIS_MODULE->name
-#endif
-
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
-
-
-/* local variables */
-static int debug;
-
-
-/*
- * This is code that scans the pci buses.
- * Every bus and every function is presented to a custom
- * function that can act upon it.
- */
-
-static int pci_visit_bus (struct pci_visit * fn, struct pci_bus_wrapped *wrapped_bus, struct pci_dev_wrapped *wrapped_parent)
-{
-	struct list_head *ln;
-	struct pci_dev *dev;
-	struct pci_dev_wrapped wrapped_dev;
-	int result = 0;
-
-	dbg("scanning bus %02x\n", wrapped_bus->bus->number);
-
-	if (fn->pre_visit_pci_bus) {
-		result = fn->pre_visit_pci_bus(wrapped_bus, wrapped_parent);
-		if (result)
-			return result;
-	}
-
-	ln = wrapped_bus->bus->devices.next; 
-	while (ln != &wrapped_bus->bus->devices) {
-		dev = pci_dev_b(ln);
-		ln = ln->next;
-
-		memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
-		wrapped_dev.dev = dev;
-
-		result = pci_visit_dev(fn, &wrapped_dev, wrapped_bus);
-		if (result)
-			return result;
-	}
-
-	if (fn->post_visit_pci_bus)
-		result = fn->post_visit_pci_bus(wrapped_bus, wrapped_parent);
-
-	return result;
-}
-
-
-static int pci_visit_bridge (struct pci_visit * fn, struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_parent)
-{
-	struct pci_bus *bus;
-	struct pci_bus_wrapped wrapped_bus;
-	int result = 0;
-
-	dbg("scanning bridge %02x, %02x\n", PCI_SLOT(wrapped_dev->dev->devfn),
-	    PCI_FUNC(wrapped_dev->dev->devfn));
-
-	if (fn->visit_pci_dev) {
-		result = fn->visit_pci_dev(wrapped_dev, wrapped_parent);
-		if (result)
-			return result;
-	}
-
-	bus = wrapped_dev->dev->subordinate;
-	if(bus) {
-		memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
-		wrapped_bus.bus = bus;
-
-		result = pci_visit_bus(fn, &wrapped_bus, wrapped_dev);
-	}
-	return result;
-}
-
-
-int pci_visit_dev (struct pci_visit *fn, struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_parent)
-{
-	struct pci_dev* dev = wrapped_dev ? wrapped_dev->dev : NULL;
-	int result = 0;
-
-	if (!dev)
-		return 0;
-
-	if (fn->pre_visit_pci_dev) {
-		result = fn->pre_visit_pci_dev(wrapped_dev, wrapped_parent);
-		if (result)
-			return result;
-	}
-
-	switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_PCI:
-			result = pci_visit_bridge(fn, wrapped_dev,
-						  wrapped_parent);
-			if (result)
-				return result;
-			break;
-		default:
-			dbg("scanning device %02x, %02x\n",
-			    PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-			if (fn->visit_pci_dev) {
-				result = fn->visit_pci_dev (wrapped_dev,
-							    wrapped_parent);
-				if (result)
-					return result;
-			}
-	}
-
-	if (fn->post_visit_pci_dev)
-		result = fn->post_visit_pci_dev(wrapped_dev, wrapped_parent);
-
-	return result;
-}
-
-/**
- * pci_is_dev_in_use - query devices' usage
- * @dev: PCI device to query
- *
- * Queries whether a given PCI device is in use by a driver or not.
- * Returns 1 if the device is in use, 0 if it is not.
- */
-int pci_is_dev_in_use(struct pci_dev *dev)
-{
-	/* 
-	 * dev->driver will be set if the device is in use by a new-style 
-	 * driver -- otherwise, check the device's regions to see if any
-	 * driver has claimed them.
-	 */
-
-	int i;
-	int inuse = 0;
-
-	if (dev->driver) {
-		/* Assume driver feels responsible */
-		return 1;
-	}
-
-	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
-		if (!pci_resource_start(dev, i))
-			continue;
-		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
-			inuse = check_region(pci_resource_start(dev, i),
-					     pci_resource_len(dev, i));
-		} else if (pci_resource_flags(dev, i) & IORESOURCE_MEM) {
-			inuse = check_mem_region(pci_resource_start(dev, i),
-						 pci_resource_len(dev, i));
-		}
-	}
-	return inuse;
-}
-
-/**
- * pci_remove_device_safe - remove an unused hotplug device
- * @dev: the device to remove
- *
- * Delete the device structure from the device lists and 
- * notify userspace (/sbin/hotplug), but only if the device
- * in question is not being used by a driver.
- * Returns 0 on success.
- */
-int pci_remove_device_safe(struct pci_dev *dev)
-{
-	if (pci_is_dev_in_use(dev)) {
-		return -EBUSY;
-	}
-	pci_remove_device(dev);
-	return 0;
-}
-
-EXPORT_SYMBOL(pci_visit_dev);
-EXPORT_SYMBOL(pci_is_dev_in_use);
-EXPORT_SYMBOL(pci_remove_device_safe);
-
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Thu Feb  6 14:51:53 2003
+++ b/drivers/pci/hotplug.c	Thu Feb  6 14:51:53 2003
@@ -2,6 +2,14 @@
 #include <linux/module.h>
 #include "pci.h"
 
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
 
 #ifdef CONFIG_HOTPLUG
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
@@ -57,13 +65,179 @@
 
 	return 0;
 }
-#else
+
+static int pci_visit_bus (struct pci_visit * fn, struct pci_bus_wrapped *wrapped_bus, struct pci_dev_wrapped *wrapped_parent)
+{
+	struct list_head *ln;
+	struct pci_dev *dev;
+	struct pci_dev_wrapped wrapped_dev;
+	int result = 0;
+
+	DBG("scanning bus %02x\n", wrapped_bus->bus->number);
+
+	if (fn->pre_visit_pci_bus) {
+		result = fn->pre_visit_pci_bus(wrapped_bus, wrapped_parent);
+		if (result)
+			return result;
+	}
+
+	ln = wrapped_bus->bus->devices.next; 
+	while (ln != &wrapped_bus->bus->devices) {
+		dev = pci_dev_b(ln);
+		ln = ln->next;
+
+		memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
+		wrapped_dev.dev = dev;
+
+		result = pci_visit_dev(fn, &wrapped_dev, wrapped_bus);
+		if (result)
+			return result;
+	}
+
+	if (fn->post_visit_pci_bus)
+		result = fn->post_visit_pci_bus(wrapped_bus, wrapped_parent);
+
+	return result;
+}
+
+static int pci_visit_bridge (struct pci_visit * fn,
+			     struct pci_dev_wrapped *wrapped_dev,
+			     struct pci_bus_wrapped *wrapped_parent)
+{
+	struct pci_bus *bus;
+	struct pci_bus_wrapped wrapped_bus;
+	int result = 0;
+
+	DBG("scanning bridge %02x, %02x\n", PCI_SLOT(wrapped_dev->dev->devfn),
+	    PCI_FUNC(wrapped_dev->dev->devfn));
+
+	if (fn->visit_pci_dev) {
+		result = fn->visit_pci_dev(wrapped_dev, wrapped_parent);
+		if (result)
+			return result;
+	}
+
+	bus = wrapped_dev->dev->subordinate;
+	if(bus) {
+		memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
+		wrapped_bus.bus = bus;
+
+		result = pci_visit_bus(fn, &wrapped_bus, wrapped_dev);
+	}
+	return result;
+}
+
+/**
+ * pci_visit_dev - scans the pci buses.
+ * Every bus and every function is presented to a custom
+ * function that can act upon it.
+ */
+int pci_visit_dev (struct pci_visit *fn, struct pci_dev_wrapped *wrapped_dev,
+		   struct pci_bus_wrapped *wrapped_parent)
+{
+	struct pci_dev* dev = wrapped_dev ? wrapped_dev->dev : NULL;
+	int result = 0;
+
+	if (!dev)
+		return 0;
+
+	if (fn->pre_visit_pci_dev) {
+		result = fn->pre_visit_pci_dev(wrapped_dev, wrapped_parent);
+		if (result)
+			return result;
+	}
+
+	switch (dev->class >> 8) {
+		case PCI_CLASS_BRIDGE_PCI:
+			result = pci_visit_bridge(fn, wrapped_dev,
+						  wrapped_parent);
+			if (result)
+				return result;
+			break;
+		default:
+			DBG("scanning device %02x, %02x\n",
+			    PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+			if (fn->visit_pci_dev) {
+				result = fn->visit_pci_dev (wrapped_dev,
+							    wrapped_parent);
+				if (result)
+					return result;
+			}
+	}
+
+	if (fn->post_visit_pci_dev)
+		result = fn->post_visit_pci_dev(wrapped_dev, wrapped_parent);
+
+	return result;
+}
+EXPORT_SYMBOL(pci_visit_dev);
+
+/**
+ * pci_is_dev_in_use - query devices' usage
+ * @dev: PCI device to query
+ *
+ * Queries whether a given PCI device is in use by a driver or not.
+ * Returns 1 if the device is in use, 0 if it is not.
+ */
+int pci_is_dev_in_use(struct pci_dev *dev)
+{
+	/* 
+	 * dev->driver will be set if the device is in use by a new-style 
+	 * driver -- otherwise, check the device's regions to see if any
+	 * driver has claimed them.
+	 */
+
+	int i;
+	int inuse = 0;
+
+	if (dev->driver) {
+		/* Assume driver feels responsible */
+		return 1;
+	}
+
+	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
+		if (!pci_resource_start(dev, i))
+			continue;
+		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
+			inuse = check_region(pci_resource_start(dev, i),
+					     pci_resource_len(dev, i));
+		} else if (pci_resource_flags(dev, i) & IORESOURCE_MEM) {
+			inuse = check_mem_region(pci_resource_start(dev, i),
+						 pci_resource_len(dev, i));
+		}
+	}
+	return inuse;
+}
+EXPORT_SYMBOL(pci_is_dev_in_use);
+
+/**
+ * pci_remove_device_safe - remove an unused hotplug device
+ * @dev: the device to remove
+ *
+ * Delete the device structure from the device lists and 
+ * notify userspace (/sbin/hotplug), but only if the device
+ * in question is not being used by a driver.
+ * Returns 0 on success.
+ */
+int pci_remove_device_safe(struct pci_dev *dev)
+{
+	if (pci_is_dev_in_use(dev)) {
+		return -EBUSY;
+	}
+	pci_remove_device(dev);
+	return 0;
+}
+EXPORT_SYMBOL(pci_remove_device_safe);
+
+#else /* CONFIG_HOTPLUG */
+
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
 		 char *buffer, int buffer_size)
 {
 	return -ENODEV;
 }
-#endif
+
+#endif /* CONFIG_HOTPLUG */
 
 /**
  * pci_insert_device - insert a pci device
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Feb  6 14:51:52 2003
+++ b/include/linux/pci.h	Thu Feb  6 14:51:52 2003
@@ -671,6 +671,37 @@
 extern struct pci_dev *isa_bridge;
 #endif
 
+/* Some worker functions that PCI Hotplug drivers find useful */
+struct pci_dev_wrapped {
+	struct pci_dev	*dev;
+	void		*data;
+};
+
+struct pci_bus_wrapped {
+	struct pci_bus	*bus;
+	void		*data;
+};
+
+struct pci_visit {
+	int (* pre_visit_pci_bus)	(struct pci_bus_wrapped *,
+					 struct pci_dev_wrapped *);
+	int (* post_visit_pci_bus)	(struct pci_bus_wrapped *,
+					 struct pci_dev_wrapped *);
+
+	int (* pre_visit_pci_dev)	(struct pci_dev_wrapped *,
+					 struct pci_bus_wrapped *);
+	int (* visit_pci_dev)		(struct pci_dev_wrapped *,
+					 struct pci_bus_wrapped *);
+	int (* post_visit_pci_dev)	(struct pci_dev_wrapped *,
+					 struct pci_bus_wrapped *);
+};
+
+extern int pci_visit_dev(struct pci_visit *fn,
+			 struct pci_dev_wrapped *wrapped_dev,
+			 struct pci_bus_wrapped *wrapped_parent);
+extern int pci_is_dev_in_use(struct pci_dev *dev);
+extern int pci_remove_device_safe(struct pci_dev *dev);
+
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */

