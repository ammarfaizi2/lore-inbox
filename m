Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUIXKe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUIXKe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268669AbUIXKe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:34:57 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:12257 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S268667AbUIXKeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:34:16 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: Is there a user space pci rescan method?
Date: Fri, 24 Sep 2004 12:41:19 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <4152FFA0.9020005@ppp0.net> <200409231905.47279@bilbo.math.uni-mannheim.de>
In-Reply-To: <200409231905.47279@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241241.19654@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 23. September 2004 19:05 schrieb Rolf Eike Beer:
> Jan Dittmer wrote:
> > Rolf Eike Beer wrote:
> > > Just search the archive of pcihpd-discuss@lists.sourceforge.net for
> > > dummyphp, this is the version that works. I'll rediff it soon and hope
> > > Greg will accept it this time.
> > >
> > > Message-Id to search for:
> > > <200403120947.13046@bilbo.math.uni-mannheim.de>
> >
> > You didn't read my p.s. ... I found it and it's working quite nice.
> > Already
>
> Ehm, yes. Sorry, around 1900 local time and no real breakfast until now.
>
> > discovered a bug in dv1394. Just one thing: Can you strip DUMMY- from the
> > name in /sys/bus/pci/slots/ ? It's really ugly and you can't mix
> > different hotplug drivers anyway.
>
> Sounds reasonable.

Ok, here we go. This is my current diff that I use for my tests at home. It adds
dummyphp and cleans up fakephp a lot (read: kills it). Changes from last version:

-removed some dead comments
-removed some unused instructions
-reordered allocation in add_slot to do less memory allocations if there is
 no device in slot
-changed param "usedonly" to "showunused" so it behaves like fakephp at the
 first look: if you load dummyphp without parameters there are only slots with
 devices in it.
-removed "DUMMY-" prefix to entries in /sys/bus/pci/slots/

Please send comments so I can send it for inclusion soon.

Eike

diff -x '*.o' -x '.tmp*' -Naur linux-2.6.8/drivers/pci/hotplug/Kconfig linux-2.6.9-rc2-bk/drivers/pci/hotplug/Kconfig
--- linux-2.6.8/drivers/pci/hotplug/Kconfig 2004-09-23 21:16:49.000000000 +0200
+++ linux-2.6.9-rc2-bk/drivers/pci/hotplug/Kconfig 2004-09-23 21:58:35.000000000 +0200
@@ -19,26 +19,29 @@
 
    When in doubt, say N.
 
-config HOTPLUG_PCI_FAKE
- tristate "Fake PCI Hotplug driver"
+config HOTPLUG_PCI_DUMMY
+ tristate "Dummy PCI Hotplug driver"
  depends on HOTPLUG_PCI
  help
-   Say Y here if you want to use the fake PCI hotplug driver. It can
-   be used to simulate PCI hotplug events if even if your system is
-   not PCI hotplug capable.
+   Say Y here if you want to use the dummy PCI hotplug driver. It can
+   be used to simulate PCI hotplug events even if your system is not
+   PCI hotplug capable.
 
    This driver will "emulate" removing PCI devices from the system.
    If the "power" file is written to with "0" then the specified PCI
-   device will be completely removed from the kernel.
+   device will be completely removed from the kernel. Writing "1" to
+   the power file will bring the device back.
+
+   Be careful: it claims all PCI slots in the system with a device in it.
+   There will be side effects on other hotplug drivers, so do NOT use
+   another hotplug driver at the same time.
 
    WARNING, this does NOT turn off the power to the PCI device.
    This is a "logical" removal, not a physical or electrical
    removal.
 
-   Use this module at your own risk.  You have been warned!
-
-   To compile this driver as a module, choose M here: the
-   module will be called fakephp.
+   To compile this driver as a module, choose M here: the module
+   will be called dummyphp.
 
    When in doubt, say N.
 
diff -x '*.o' -x '.tmp*' -Naur linux-2.6.8/drivers/pci/hotplug/Makefile linux-2.6.9-rc2-bk/drivers/pci/hotplug/Makefile
--- linux-2.6.8/drivers/pci/hotplug/Makefile 2004-09-23 21:16:49.000000000 +0200
+++ linux-2.6.9-rc2-bk/drivers/pci/hotplug/Makefile 2004-09-17 16:30:26.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_HOTPLUG_PCI)  += pci_hotplug.o
-obj-$(CONFIG_HOTPLUG_PCI_FAKE)  += fakephp.o 
+obj-$(CONFIG_HOTPLUG_PCI_DUMMY)  += dummyphp.o
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ) += cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)  += ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)  += acpiphp.o
diff -x '*.o' -x '.tmp*' -Naur linux-2.6.8/drivers/pci/hotplug/dummyphp.c linux-2.6.9-rc2-bk/drivers/pci/hotplug/dummyphp.c
--- linux-2.6.8/drivers/pci/hotplug/dummyphp.c 1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2-bk/drivers/pci/hotplug/dummyphp.c 2004-09-23 23:11:23.000000000 +0200
@@ -0,0 +1,386 @@
+/*
+ * Dummy PCI Hot Plug Controller Driver
+ *
+ * Copyright (c) 2003 Rolf Eike Beer <eike-kernel@sf-tec.de>
+ *
+ * Based on code from:
+ * Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+ * Greg Kroah-Hartman <greg@kroah.com>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * Send feedback to <eike-kernel@sf-tec.de>
+ */
+
+/*
+ *
+ * This driver will "emulate" removing PCI devices from the system.  If
+ * the "power" file is written to with "0" then the specified PCI device
+ * will be completely removed from the kernel.
+ *
+ * WARNING, this does NOT turn off the power to the PCI device.  This is
+ * a "logical" removal, not a physical or electrical removal.
+ *
+ * Use this module at your own risk, you have been warned!
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include "pci_hotplug.h"
+#include "../pci.h"
+
+#define MY_NAME "dummyphp"
+
+#define dbg(format, arg...)     \
+ do {       \
+  if (debug)     \
+   printk(KERN_DEBUG "%s: " format, \
+    MY_NAME , ## arg);   \
+ } while (0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
+
+/* name size which is used for entries in pcihpfs */
+#define SLOT_NAME_SIZE 14  /* {DOMAIN}-{BUS}:{DEV} */
+
+struct dummy_slot {
+ struct list_head node;
+ struct hotplug_slot *slot;
+ struct pci_dev  *dev;
+ struct pci_bus  *bus;
+ int   devfn;
+};
+
+#define DRIVER_DESC "Dummy PCI Hot Plug Controller Driver"
+
+static int debug;
+static int showunused;
+static LIST_HEAD(slot_list);
+
+MODULE_AUTHOR("Rolf Eike Beer <eike-kernel@sf-tec.de>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL v2");
+MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
+module_param(debug, bool, 644);
+MODULE_PARM_DESC(showunused, "Show slots even if there is no device in it");
+module_param(showunused, bool, 644);
+
+static int enable_slot(struct hotplug_slot *slot);
+static int disable_slot(struct hotplug_slot *slot);
+static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value);
+
+static struct hotplug_slot_ops dummy_hotplug_slot_ops = {
+ .owner   = THIS_MODULE,
+ .enable_slot  = enable_slot,
+ .disable_slot  = disable_slot,
+ .get_adapter_status = get_adapter_status
+};
+
+/**
+ * dummy_release - free the memory of a slot
+ * @slot: slot pointer to remove
+ */
+static void dummy_release(struct hotplug_slot *slot)
+{
+ struct dummy_slot *dslot = slot->private;
+
+ list_del(&dslot->node);
+ kfree(dslot->slot->name);
+ kfree(dslot->slot->info);
+ kfree(dslot->slot);
+ if (dslot->dev)
+  pci_dev_put(dslot->dev);
+ kfree(dslot);
+}
+
+/**
+ * get_adapter_status - look if adapter is present in slot
+ * @hotplug_slot: slot to test value
+ * @value: status of the adapter
+ */
+static int get_adapter_status(struct hotplug_slot *slot, u8 *value)
+{
+ struct dummy_slot *dslot;
+
+ dslot = slot->private;
+
+ *value = pci_scan_slot(dslot->bus, dslot->devfn);
+ slot->info->adapter_status = *value;
+
+ return 0;
+}
+
+/**
+ * add_slot - add a new "hotplug" slot
+ * @dev: a struct pci_dev describing this slot (regardless if
+ * there is actually a device in this slot or not)
+ */
+static inline int
+add_slot(const struct pci_dev *dev)
+{
+ struct dummy_slot *dslot;
+ struct hotplug_slot *slot;
+ int retval = -ENOMEM;
+
+ dslot = kmalloc(sizeof(*dslot), GFP_KERNEL);
+ if (!dslot)
+  goto error;
+
+ dslot->bus = dev->bus;
+ dslot->devfn = dev->devfn;
+
+ dslot->dev = pci_get_slot(dslot->bus, dslot->devfn);
+
+ if (showunused || dslot->dev) {
+  retval = 0;
+  goto error_dslot;
+ }
+
+ slot = kmalloc(sizeof(*slot), GFP_KERNEL);
+ if (!slot)
+  goto error_dslot;
+
+ memset(slot, 0, sizeof(*slot));
+
+ slot->info = kmalloc(sizeof(*(slot->info)), GFP_KERNEL);
+ if (!slot->info)
+  goto error_slot;
+
+ memset(slot->info, 0, sizeof(struct hotplug_slot_info));
+
+ slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
+ slot->info->cur_bus_speed = PCI_SPEED_UNKNOWN;
+
+ slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
+ if (!slot->name)
+  goto error_info;
+ slot->info->power_status = (dslot->dev != NULL);
+ slot->info->adapter_status = slot->info->power_status;
+
+ slot->ops = &dummy_hotplug_slot_ops;
+ slot->release = &dummy_release;
+ slot->private = dslot;
+
+ snprintf(slot->name, SLOT_NAME_SIZE, "%04x:%02x:%02x",
+  pci_domain_nr(dev->bus), dslot->bus->number,
+  PCI_SLOT(dslot->devfn));
+
+ retval = pci_hp_register(slot);
+ if (retval) {
+  err("pci_hp_register failed with error %d\n", retval);
+  goto error_name;
+ }
+
+ dslot->slot = slot;
+ list_add(&dslot->node, &slot_list);
+
+ return retval;
+
+error_name:
+ kfree(slot->name);
+error_info:
+ kfree(slot->info);
+error_slot:
+ kfree(slot);
+error_dslot:
+ pci_dev_put(dslot->dev);
+ kfree(dslot);
+error:
+ return retval;
+}
+
+/**
+ * scan_pci_bus - add an entry for every slot on this bus
+ * @bus: bus to scan
+ */
+static inline int
+scan_pci_bus(struct pci_bus *bus)
+{
+ int retval;
+ struct pci_dev dev;
+
+ memset(&dev, 0, sizeof(dev));
+ dev.bus = bus;
+ for (dev.devfn = 0; dev.devfn < 0x100; dev.devfn += 8) {
+  retval = add_slot(&dev);
+  if (retval)
+   break;
+ }
+ return retval;
+}
+
+/**
+ * pci_scan_buses - scan this bus and all child buses for slots
+ * @list: list of buses to scan
+ */
+static int
+pci_scan_buses(struct list_head *list)
+{
+ int retval = 0;
+ const struct list_head *l;
+
+ list_for_each(l, list) {
+  struct list_head *tmp;
+  struct list_head *next;
+  struct pci_bus *b = pci_bus_b(l);
+  int i = 0;
+
+  /* scan the list of slots to see if we have already
+   * a slot on the new bus registered */
+  list_for_each_safe(tmp, next, &slot_list) {
+   if ((list_entry(tmp, struct dummy_slot, node))->bus == b) {
+    i = 1;
+    break;
+   }
+  }
+  if (i)
+   continue;
+
+  retval = scan_pci_bus(b);
+  if (retval)
+   break;
+  retval = pci_scan_buses(&b->children);
+  if (retval)
+   break;
+ }
+ return retval;
+}
+
+/**
+ * enable_slot - power on and enable a slot
+ * @hotplug_slot: slot to enable
+ */
+static int
+enable_slot(struct hotplug_slot *hotplug_slot)
+{
+ struct dummy_slot *dslot = hotplug_slot->private;
+ int num, result = -ENODEV;
+
+ dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+ /* exit if device in slot is already active */
+ if (dslot->dev != NULL)
+  return 0;
+
+ dslot->dev = pci_get_slot(dslot->bus, dslot->devfn);
+
+ /* No pci device, we need to create it then */
+ if (dslot->dev == NULL) {
+  num = pci_scan_slot(dslot->bus, dslot->devfn);
+  if (!num) {
+   dbg("INFO: enable_slot called on empty slot\n");
+   return result;
+  }
+
+  pci_bus_add_devices(dslot->bus);
+
+  dslot->dev = pci_get_slot(dslot->bus, dslot->devfn);
+  /* pci_get_slot fails but we have found devices in this slot before? */
+  WARN_ON(dslot->dev == NULL);
+ }
+
+ if (dslot->dev->subordinate)
+  result = pci_scan_buses(&(dslot->dev->subordinate->node));
+ else
+  result = 0;
+
+ return result;
+}
+
+/**
+ * disable_subordinate - remove hotplug slot entry of device on this bus
+ * @bus: PCI bus to remove (including all children)
+ */
+static void
+disable_subordinate(struct pci_bus *bus)
+{
+ struct list_head *tmp;
+ struct list_head *next;
+ struct dummy_slot *dslot;
+
+	list_for_each_safe(tmp, next, &slot_list) {
+		dslot = list_entry(tmp, struct dummy_slot, node);
+		if (dslot->bus == bus) {
+			if (dslot->dev != NULL)
+				if (dslot->dev->subordinate)
+			/* FIXME: look if this bus can be reached through a
+			   different bridge. If yes, don't disable it */
+					disable_subordinate(dslot->dev->subordinate);
+			/* no need to disable the devices itself, this will be
+			   done by pci_remove_bus_device */
+			pci_hp_deregister(dslot->slot);
+		}
+	}
+}
+
+/**
+ * disable_slot - disable any adapter in this slot
+ * @slot: slot to disable
+ */
+static int
+disable_slot(struct hotplug_slot *slot)
+{
+	struct dummy_slot *dslot = slot->private;
+	struct pci_dev *dev = dslot->dev;
+	int i;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, slot->name);
+
+	if (!dev) {
+		dbg("No device in slot, exiting");
+		return -ENODEV;
+	}
+
+	/* check if this is a PCI bridge and remove devices on
+	   sub-buses first */
+	if (dev->subordinate)
+		disable_subordinate(dev->subordinate);
+
+	dslot->dev = NULL;
+ pci_dev_put(dev);
+
+ /* remove the device from the pci core */
+ info("Slot %s removed\n", pci_name(dev));
+
+ for (i = 0; i < 8; i++) {
+  dev = pci_get_slot(dslot->bus, dslot->devfn + i);
+  if (dev)
+   pci_remove_bus_device(dev);
+ }
+
+ slot->info->power_status = 0;
+
+ return 0;
+}
+
+static int __init
+dummyphp_init(void)
+{
+ info(DRIVER_DESC "\n");
+
+ return pci_scan_buses(&pci_root_buses);
+}
+
+static void __exit
+dummyphp_exit(void)
+{
+ struct list_head *tmp;
+ struct list_head *next;
+ struct dummy_slot *dslot;
+
+ list_for_each_safe(tmp, next, &slot_list) {
+  dslot = list_entry(tmp, struct dummy_slot, node);
+  pci_hp_deregister(dslot->slot);
+ }
+}
+
+module_init(dummyphp_init);
+module_exit(dummyphp_exit);
diff -x '*.o' -x '.tmp*' -Naur linux-2.6.8/drivers/pci/hotplug/fakephp.c linux-2.6.9-rc2-bk/drivers/pci/hotplug/fakephp.c
--- linux-2.6.8/drivers/pci/hotplug/fakephp.c 2004-08-14 07:37:25.000000000 +0200
+++ linux-2.6.9-rc2-bk/drivers/pci/hotplug/fakephp.c 1970-01-01 01:00:00.000000000 +0100
@@ -1,232 +0,0 @@
-/*
- * Fake PCI Hot Plug Controller Driver
- *
- * Copyright (C) 2003 Greg Kroah-Hartman <greg@kroah.com>
- * Copyright (C) 2003 IBM Corp.
- * Copyright (C) 2003 Rolf Eike Beer <eike-kernel@sf-tec.de>
- *
- * Based on ideas and code from:
- *  Vladimir Kondratiev <vladimir.kondratiev@intel.com>
- * Rolf Eike Beer <eike-kernel@sf-tec.de>
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, version 2 of the License.
- *
- * Send feedback to <greg@kroah.com>
- */
-
-/*
- *
- * This driver will "emulate" removing PCI devices from the system.  If
- * the "power" file is written to with "0" then the specified PCI device
- * will be completely removed from the kernel.
- *
- * WARNING, this does NOT turn off the power to the PCI device.  This is
- * a "logical" removal, not a physical or electrical removal.
- *
- * Use this module at your own risk, you have been warned!
- *
- * Enabling PCI devices is left as an exercise for the reader...
- *
- */
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include "pci_hotplug.h"
-#include "../pci.h"
-
-#if !defined(CONFIG_HOTPLUG_PCI_FAKE_MODULE)
- #define MY_NAME "fakephp"
-#else
- #define MY_NAME THIS_MODULE->name
-#endif
-
-#define dbg(format, arg...)     \
- do {       \
-  if (debug)     \
-   printk(KERN_DEBUG "%s: " format, \
-    MY_NAME , ## arg);   \
- } while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
-
-#define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>"
-#define DRIVER_DESC "Fake PCI Hot Plug Controller Driver"
-
-struct dummy_slot {
- struct list_head node;
- struct hotplug_slot *slot;
- struct pci_dev *dev;
-};
-
-static int debug;
-static LIST_HEAD(slot_list);
-
-static int enable_slot (struct hotplug_slot *slot);
-static int disable_slot (struct hotplug_slot *slot);
-
-static struct hotplug_slot_ops dummy_hotplug_slot_ops = {
- .owner   = THIS_MODULE,
- .enable_slot  = enable_slot,
- .disable_slot  = disable_slot,
-};
-
-static void dummy_release(struct hotplug_slot *slot)
-{
- struct dummy_slot *dslot = slot->private;
-
- list_del(&dslot->node);
- kfree(dslot->slot->info);
- kfree(dslot->slot);
- pci_dev_put(dslot->dev);
- kfree(dslot);
-}
-
-static int add_slot(struct pci_dev *dev)
-{
- struct dummy_slot *dslot;
- struct hotplug_slot *slot;
- int retval = -ENOMEM;
-
- slot = kmalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
- if (!slot)
-  goto error;
- memset(slot, 0, sizeof(*slot));
-
- slot->info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
-	if (!slot->info)
-		goto error_slot;
-	memset(slot->info, 0, sizeof(struct hotplug_slot_info));
-
-	slot->info->power_status = 1;
-	slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
-	slot->info->cur_bus_speed = PCI_SPEED_UNKNOWN;
-
-	slot->name = &dev->dev.bus_id[0];
-	dbg("slot->name = %s\n", slot->name);
-
-	dslot = kmalloc(sizeof(struct dummy_slot), GFP_KERNEL);
-	if (!dslot)
-		goto error_info;
-
-	slot->ops = &dummy_hotplug_slot_ops;
-	slot->release = &dummy_release;
-	slot->private = dslot;
-
-	retval = pci_hp_register(slot);
-	if (retval) {
-		err("pci_hp_register failed with error %d\n", retval);
-		goto error_dslot;
-	}
-
-	dslot->slot = slot;
-	dslot->dev = pci_dev_get(dev);
-	list_add (&dslot->node, &slot_list);
-	return retval;
-
-error_dslot:
-	kfree(dslot);
-error_info:
-	kfree(slot->info);
-error_slot:
-	kfree(slot);
-error:
-	return retval;
-}
-
-static int __init pci_scan_buses(void)
-{
-	struct pci_dev *dev = NULL;
-	int retval = 0;
-
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		retval = add_slot(dev);
-		if (retval) {
-			pci_dev_put(dev);
-			break;
-		}
-	}
-
-	return retval;
-}
-
-static void remove_slot(struct dummy_slot *dslot)
-{
-	int retval;
-
-	dbg("removing slot %s\n", dslot->slot->name);
-	retval = pci_hp_deregister(dslot->slot);
-	if (retval)
-		err("Problem unregistering a slot %s\n", dslot->slot->name);
-}
-
-static int enable_slot(struct hotplug_slot *hotplug_slot)
-{
-	return -ENODEV;
-}
-
-static int disable_slot(struct hotplug_slot *slot)
-{
-	struct dummy_slot *dslot;
-
-	if (!slot)
-		return -ENODEV;
-	dslot = slot->private;
-
-	dbg("%s - physical_slot = %s\n", __FUNCTION__, slot->name);
-
-	/* don't disable bridged devices just yet, we can't handle them easily... */
-	if (dslot->dev->subordinate) {
-		err("Can't remove PCI devices with other PCI devices behind it yet.\n");
-		return -ENODEV;
-	}
-
-	/* remove the device from the pci core */
-	pci_remove_bus_device(dslot->dev);
-
-	/* blow away this sysfs entry and other parts. */
-	remove_slot(dslot);
-
-	return 0;
-}
-
-static void cleanup_slots (void)
-{
- struct list_head *tmp;
- struct list_head *next;
- struct dummy_slot *dslot;
-
- list_for_each_safe (tmp, next, &slot_list) {
-  dslot = list_entry (tmp, struct dummy_slot, node);
-  remove_slot(dslot);
- }
- 
-}
-
-static int __init dummyphp_init(void)
-{
- info(DRIVER_DESC "\n");
-
- return pci_scan_buses();
-}
-
-
-static void __exit dummyphp_exit(void)
-{
- cleanup_slots();
-}
-
-module_init(dummyphp_init);
-module_exit(dummyphp_exit);
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
-MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-
