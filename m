Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTFZAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbTFZAgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:36:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34283 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265229AbTFZAfG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10565884954057@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <10565884951291@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:15 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.8, 2003/06/25 17:24:47-07:00, greg@kroah.com

PCI Hotplug: add fake PCI hotplug driver.

Useful for testing hotplug issues with pci drivers.


 drivers/pci/hotplug/Kconfig   |   25 ++++
 drivers/pci/hotplug/Makefile  |    1 
 drivers/pci/hotplug/fakephp.c |  232 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)


diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	Wed Jun 25 17:37:39 2003
+++ b/drivers/pci/hotplug/Kconfig	Wed Jun 25 17:37:39 2003
@@ -21,6 +21,31 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_FAKE
+	tristate "Fake PCI Hotplug driver"
+	depends on HOTPLUG_PCI
+	help
+	  Say Y here if you want to use the fake PCI hotplug driver. It can
+	  be used to simulate PCI hotplug events if even if your system is
+	  not PCI hotplug capable.
+
+	  This driver will "emulate" removing PCI devices from the system.
+	  If the "power" file is written to with "0" then the specified PCI
+	  device will be completely removed from the kernel.
+
+	  WARNING, this does NOT turn off the power to the PCI device.
+	  This is a "logical" removal, not a physical or electrical
+	  removal.
+
+	  Use this module at your own risk.  You have been warned!
+
+	  This code is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called fakephp. If you want to compile it
+	  as a module, say M here and read <file:Documentation/modules.txt>.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_COMPAQ
 	tristate "Compaq PCI Hotplug driver"
 	depends on HOTPLUG_PCI && X86
diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Wed Jun 25 17:37:39 2003
+++ b/drivers/pci/hotplug/Makefile	Wed Jun 25 17:37:39 2003
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
+obj-$(CONFIG_HOTPLUG_PCI_FAKE)		+= fakephp.o 
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
diff -Nru a/drivers/pci/hotplug/fakephp.c b/drivers/pci/hotplug/fakephp.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/fakephp.c	Wed Jun 25 17:37:39 2003
@@ -0,0 +1,232 @@
+/*
+ * Fake PCI Hot Plug Controller Driver
+ *
+ * Copyright (c) 2003 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (c) 2003 IBM Corp.
+ * Copyright (c) 2003 Rolf Eike Beer <eike-kernel@sf-tec.de>
+ *
+ * Based on ideas and code from:
+ * 	Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+ *	Rolf Eike Beer <eike-kernel@sf-tec.de>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * Send feedback to <greg@kroah.com>
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
+ * Enabling PCI devices is left as an exercise for the reader...
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include "pci_hotplug.h"
+#include "../pci.h"
+
+#if !defined(CONFIG_HOTPLUG_PCI_FAKE_MODULE)
+	#define MY_NAME	"fakephp"
+#else
+	#define MY_NAME	THIS_MODULE->name
+#endif
+
+#define dbg(format, arg...)					\
+	do {							\
+		if (debug)					\
+			printk(KERN_DEBUG "%s: " format,	\
+				MY_NAME , ## arg); 		\
+	} while (0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
+
+#define DRIVER_AUTHOR	"Greg Kroah-Hartman <greg@kroah.com>"
+#define DRIVER_DESC	"Fake PCI Hot Plug Controller Driver"
+
+struct dummy_slot {
+	struct list_head node;
+	struct hotplug_slot *slot;
+	struct pci_dev *dev;
+};
+
+static int debug;
+static LIST_HEAD(slot_list);
+
+static int enable_slot (struct hotplug_slot *slot);
+static int disable_slot (struct hotplug_slot *slot);
+
+static struct hotplug_slot_ops dummy_hotplug_slot_ops = {
+	.owner			= THIS_MODULE,
+	.enable_slot		= enable_slot,
+	.disable_slot		= disable_slot,
+};
+
+static void dummy_release(struct hotplug_slot *slot)
+{
+	struct dummy_slot *dslot = slot->private;
+
+	list_del(&dslot->node);
+	kfree(dslot->slot->info);
+	kfree(dslot->slot);
+	pci_dev_put(dslot->dev);
+	kfree(dslot);
+}
+
+static int add_slot(struct pci_dev *dev)
+{
+	struct dummy_slot *dslot;
+	struct hotplug_slot *slot;
+	int retval = -ENOMEM;
+
+	slot = kmalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
+	if (!slot)
+		goto error;
+	memset(slot, 0, sizeof(*slot));
+
+	slot->info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
+	if (!slot->info)
+		goto error_slot;
+	memset(slot->info, 0, sizeof(struct hotplug_slot_info));
+
+	slot->info->power_status = 1;
+	slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
+	slot->info->cur_bus_speed = PCI_SPEED_UNKNOWN;
+
+	slot->name = &dev->dev.bus_id[0];
+	dbg("slot->name = %s\n", slot->name);
+
+	dslot = kmalloc(sizeof(struct dummy_slot), GFP_KERNEL);
+	if (!dslot)
+		goto error_info;
+
+	slot->ops = &dummy_hotplug_slot_ops;
+	slot->release = &dummy_release;
+	slot->private = dslot;
+
+	retval = pci_hp_register(slot);
+	if (retval) {
+		err("pci_hp_register failed with error %d\n", retval);
+		goto error_dslot;
+	}
+
+	dslot->slot = slot;
+	dslot->dev = pci_dev_get(dev);
+	list_add (&dslot->node, &slot_list);
+	return retval;
+
+error_dslot:
+	kfree(dslot);
+error_info:
+	kfree(slot->info);
+error_slot:
+	kfree(slot);
+error:
+	return retval;
+}
+
+static int __init pci_scan_buses(void)
+{
+	struct pci_dev *dev = NULL;
+	int retval = 0;
+
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		retval = add_slot(dev);
+		if (retval) {
+			pci_dev_put(dev);
+			break;
+		}
+	}
+
+	return retval;
+}
+
+static void remove_slot(struct dummy_slot *dslot)
+{
+	int retval;
+
+	dbg("removing slot %s\n", dslot->slot->name);
+	retval = pci_hp_deregister(dslot->slot);
+	if (retval)
+		err("Problem unregistering a slot %s\n", dslot->slot->name);
+}
+
+static int enable_slot(struct hotplug_slot *hotplug_slot)
+{
+	return -ENODEV;
+}
+
+static int disable_slot(struct hotplug_slot *slot)
+{
+	struct dummy_slot *dslot;
+
+	if (!slot)
+		return -ENODEV;
+	dslot = slot->private;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, slot->name);
+
+	/* don't disable bridged devices just yet, we can't handle them easily... */
+	if (dslot->dev->subordinate) {
+		err("Can't remove PCI devices with other PCI devices behind it yet.\n");
+		return -ENODEV;
+	}
+
+	/* remove the device from the pci core */
+	pci_remove_bus_device(dslot->dev);
+
+	/* blow away this sysfs entry and other parts. */
+	remove_slot(dslot);
+
+	return 0;
+}
+
+static void cleanup_slots (void)
+{
+	struct list_head *tmp;
+	struct list_head *next;
+	struct dummy_slot *dslot;
+
+	list_for_each_safe (tmp, next, &slot_list) {
+		dslot = list_entry (tmp, struct dummy_slot, node);
+		remove_slot(dslot);
+	}
+	
+}
+
+static int __init dummyphp_init(void)
+{
+	info(DRIVER_DESC "\n");
+
+	return pci_scan_buses();
+}
+
+
+static void __exit dummyphp_exit(void)
+{
+	cleanup_slots();
+}
+
+module_init(dummyphp_init);
+module_exit(dummyphp_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
+

