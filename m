Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUBTTUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUBTTKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:10:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:65253 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261280AbUBTTGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:24 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039802021@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:20 -0800
Message-Id: <10773039801571@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.58.7, 2004/02/18 12:57:30-08:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug : add DLPAR driver for PPC64 PCI Hotplug slots

Please consider the following patch for submission.  This patch contains the
implementation of the I/O Slot DLPAR Drivers for PPC64 RISC Platform
Architecture.  This module depends on the RPA PCI Hotplug Module in the
previous post.  The patch is made against kernel version 2.6.3-rc2.

The Dynamic Logical Partitioning Module allows the runtime movement of I/O
Slots between logical partitions.  An administrator can logically add/remove
PCI Buses to/from a PPC64 partition at runtime.  These operations are initiated
using interface files located at:
/sys/bus/pci/pci_hotplug_slots/control/
Development contact for this module is John Rose (johnrose@austin.ibm.com).


 drivers/pci/hotplug/Kconfig          |   12 +
 drivers/pci/hotplug/Makefile         |    4 
 drivers/pci/hotplug/rpadlpar.h       |   24 ++
 drivers/pci/hotplug/rpadlpar_core.c  |  343 +++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/rpadlpar_sysfs.c |  151 +++++++++++++++
 5 files changed, 534 insertions(+)


diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	Fri Feb 20 10:44:50 2004
+++ b/drivers/pci/hotplug/Kconfig	Fri Feb 20 10:44:50 2004
@@ -200,5 +200,17 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_RPA_DLPAR
+	tristate "RPA Dynamic Logical Partitioning for I/O slots"
+	depends on HOTPLUG_PCI_RPA
+	help
+	  Say Y here if your system supports Dynamic Logical Partitioning
+	  for I/O slots.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rpadlpar_io.
+ 
+ 	  When in doubt, say N.
+
 endmenu
 
diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Fri Feb 20 10:44:50 2004
+++ b/drivers/pci/hotplug/Makefile	Fri Feb 20 10:44:50 2004
@@ -12,6 +12,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_PCIE)		+= pciehp.o
 obj-$(CONFIG_HOTPLUG_PCI_SHPC)		+= shpchp.o
 obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
+obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o
 
@@ -38,6 +39,9 @@
 
 rpaphp-objs		:=	rpaphp_core.o	\
 				rpaphp_pci.o	
+
+rpadlpar_io-objs	:=	rpadlpar_core.o \
+				rpadlpar_sysfs.o
 
 pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
diff -Nru a/drivers/pci/hotplug/rpadlpar.h b/drivers/pci/hotplug/rpadlpar.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpadlpar.h	Fri Feb 20 10:44:50 2004
@@ -0,0 +1,24 @@
+/*
+ * Interface for Dynamic Logical Partitioning of I/O Slots on
+ * RPA-compliant PPC64 platform.
+ *
+ * John Rose <johnrose@austin.ibm.com>
+ * October 2003
+ *
+ * Copyright (C) 2003 IBM.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+#ifndef _RPADLPAR_IO_H_
+#define _RPADLPAR_IO_H_
+
+extern int dlpar_sysfs_init(void);
+extern void dlpar_sysfs_exit(void);
+
+extern int dlpar_add_slot(char *drc_name);
+extern int dlpar_remove_slot(char *drc_name);
+
+#endif
diff -Nru a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpadlpar_core.c	Fri Feb 20 10:44:50 2004
@@ -0,0 +1,343 @@
+/*
+ * Interface for Dynamic Logical Partitioning of I/O Slots on
+ * RPA-compliant PPC64 platform.
+ *
+ * John Rose <johnrose@austin.ibm.com>
+ * Linda Xie <lxie@us.ibm.com>
+ *
+ * October 2003
+ *
+ * Copyright (C) 2003 IBM.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/pci-bridge.h>
+#include <asm/semaphore.h>
+#include "../pci.h"
+#include "rpaphp.h"
+#include "rpadlpar.h"
+
+static DECLARE_MUTEX(rpadlpar_sem);
+
+static inline int is_hotplug_capable(struct device_node *dn)
+{
+	unsigned char *ptr = get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL);
+
+	return (int) (ptr != NULL);
+}
+
+static char *get_node_drc_name(struct device_node *dn)
+{
+	char *ptr = NULL;
+	int *drc_names;
+
+	drc_names = (int *) get_property(dn, "ibm,drc-names", NULL);
+	if (drc_names)
+		ptr = (char *) &drc_names[1];
+
+	return ptr;
+}
+
+static struct device_node *find_php_slot_node(char *drc_name)
+{
+	struct device_node *np = NULL;
+	char *name;
+
+	while ((np = of_find_node_by_type(np, "pci")))
+		if (is_hotplug_capable(np)) {
+			name = get_node_drc_name(np);
+			if (name && (!strcmp(drc_name, name)))
+				break;
+		}
+
+	return np;
+}
+
+static inline struct hotplug_slot *find_php_slot(char *drc_name)
+{
+	struct kobject *k;
+
+	k = kset_find_obj(&pci_hotplug_slots_subsys.kset, drc_name);
+	if (!k)
+		return NULL;
+
+	return to_hotplug_slot(k);
+}
+
+static struct slot *find_slot(char *drc_name)
+{
+	struct hotplug_slot *php_slot = find_php_slot(drc_name);
+	
+	if (!php_slot)
+		return NULL;
+
+	return (struct slot *) php_slot->private;
+}
+
+static void rpadlpar_claim_one_bus(struct pci_bus *b)
+{
+	struct list_head *ld;
+	struct pci_bus *child_bus;
+
+	for (ld = b->devices.next; ld != &b->devices; ld = ld->next) {
+		struct pci_dev *dev = pci_dev_b(ld);
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *r = &dev->resource[i];
+
+			if (r->parent || !r->start || !r->flags)
+				continue;
+			rpaphp_claim_resource(dev, i);
+		}
+	}
+
+	list_for_each_entry(child_bus, &b->children, node)
+		rpadlpar_claim_one_bus(child_bus);
+}
+
+static int pci_add_secondary_bus(struct device_node *dn,
+		struct pci_dev *bridge_dev)
+{
+	struct pci_controller *hose = dn->phb;
+	struct pci_bus *child;
+	u8 sec_busno;
+
+	/* Get busno of downstream bus */
+	pci_read_config_byte(bridge_dev, PCI_SECONDARY_BUS, &sec_busno);
+
+	/* Allocate and add to children of bridge_dev->bus */
+	child = pci_add_new_bus(bridge_dev->bus, bridge_dev, sec_busno);
+	if (!child) {
+		printk(KERN_ERR "%s: could not add secondary bus\n", __FUNCTION__);
+		return 1;
+	}
+
+	sprintf(child->name, "PCI Bus #%02x", child->number);
+
+	/* Fixup subordinate bridge bases and resources */
+	pcibios_fixup_bus(child);
+
+	/* Claim new bus resources */
+	rpadlpar_claim_one_bus(bridge_dev->bus);
+
+	if (hose->last_busno < child->number)
+	    	hose->last_busno = child->number;
+
+	dn->bussubno = child->number;
+
+	/* ioremap() for child bus */
+	if (remap_bus_range(child)) {
+		printk(KERN_ERR "%s: could not ioremap() child bus\n",
+				__FUNCTION__);
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct pci_dev *dlpar_pci_add_bus(struct device_node *dn)
+{
+	struct pci_controller *hose = dn->phb;
+	struct pci_dev *dev = NULL;
+
+	/* Scan phb bus for EADS device, adding new one to bus->devices */
+	if (!pci_scan_single_device(hose->bus, dn->devfn)) {
+		printk(KERN_ERR "%s: found no device on bus\n", __FUNCTION__);
+		return NULL;
+	}
+
+	/* Add new devices to global lists.  Register in proc, sysfs. */
+	pci_bus_add_devices(hose->bus);
+
+	/* Confirm new bridge dev was created */
+	dev = rpaphp_find_pci_dev(dn);
+	if (!dev) {
+		printk(KERN_ERR "%s: failed to add pci device\n", __FUNCTION__);
+		return NULL;
+	}
+
+	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)  {
+		printk(KERN_ERR "%s: unexpected header type %d\n",
+				__FUNCTION__, dev->hdr_type);
+		return NULL;
+	}
+
+	if (pci_add_secondary_bus(dn, dev))
+		return NULL;
+
+	return dev;
+}
+
+static int dlpar_pci_remove_bus(struct pci_dev *bridge_dev)
+{
+	struct pci_bus *secondary_bus;
+
+	if (!bridge_dev) {
+		printk(KERN_ERR "%s: unexpected null device\n",
+				__FUNCTION__);
+		return 1;
+	}
+
+	secondary_bus = bridge_dev->subordinate;
+
+	if (unmap_bus_range(secondary_bus)) {
+		printk(KERN_ERR "%s: failed to unmap bus range\n",
+				__FUNCTION__);
+		return 1;
+	}
+
+	pci_remove_bus_device(bridge_dev);
+
+	return 0;
+}
+
+/**
+ * dlpar_add_slot - DLPAR add an I/O Slot
+ * @drc_name: drc-name of newly added slot
+ *
+ * Make the hotplug module and the kernel aware
+ * of a newly added I/O Slot.
+ * Return Codes -
+ * 0			Success
+ * -ENODEV		Not a valid drc_name
+ * -EINVAL		Slot already added
+ * -ERESTARTSYS		Signalled before obtaining lock
+ * -EIO			Internal PCI Error
+ */
+int dlpar_add_slot(char *drc_name)
+{
+	struct device_node *dn = find_php_slot_node(drc_name);
+	struct pci_dev *dev;
+	int rc = 0;
+
+	if (down_interruptible(&rpadlpar_sem))
+		return -ERESTARTSYS;
+
+	if (!dn) {
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	/* Check for existing hotplug slot */
+	if (find_slot(drc_name)) {
+		rc = -EINVAL;
+		goto exit;
+	}
+
+	/* Add pci bus */
+	dev = dlpar_pci_add_bus(dn);
+	if (!dev) {
+		printk(KERN_ERR "%s: unable to add bus %s\n", __FUNCTION__,
+				drc_name);
+		rc = -EIO;
+		goto exit;
+	}
+
+	/* Add hotplug slot for new bus */
+	if (rpaphp_add_slot(drc_name)) {
+		printk(KERN_ERR "%s: unable to add hotplug slot %s\n",
+				__FUNCTION__, drc_name);
+		rc = -EIO;
+	}
+exit:
+	up(&rpadlpar_sem);
+	return rc;
+}
+
+/**
+ * dlpar_remove_slot - DLPAR remove an I/O Slot
+ * @drc_name: drc-name of newly added slot
+ *
+ * Remove the kernel and hotplug representations
+ * of an I/O Slot.
+ * Return Codes:
+ * 0			Success
+ * -ENODEV		Not a valid drc_name
+ * -EINVAL		Slot already removed
+ * -ERESTARTSYS		Signalled before obtaining lock
+ * -EIO			Internal PCI Error
+ */
+int dlpar_remove_slot(char *drc_name)
+{
+	struct device_node *dn = find_php_slot_node(drc_name);
+	struct slot *slot;
+	struct pci_dev *bridge_dev;
+	int rc = 0;
+
+	if (down_interruptible(&rpadlpar_sem))
+		return -ERESTARTSYS;
+
+	if (!dn) {
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	slot = find_slot(drc_name);
+	if (!slot) {
+		rc = -EINVAL;
+		goto exit;
+	}
+
+	bridge_dev = slot->bridge;
+	if (!bridge_dev) {
+		printk(KERN_ERR "%s: unexpected null bridge device\n",
+				__FUNCTION__);
+		rc = -EIO;
+		goto exit;
+	}
+
+	/* Remove hotplug slot */
+	if (rpaphp_remove_slot(slot)) {
+		printk(KERN_ERR "%s: unable to remove hotplug slot %s\n",
+				__FUNCTION__, drc_name);
+		rc = -EIO;
+		goto exit;
+	}
+
+	/* Remove pci bus */
+	if (dlpar_pci_remove_bus(bridge_dev)) {
+		printk(KERN_ERR "%s: unable to remove pci bus %s\n",
+				__FUNCTION__, drc_name);
+		rc = -EIO;
+	}
+exit:
+	up(&rpadlpar_sem);
+	return rc;
+}
+
+static inline int is_dlpar_capable(void)
+{
+	int rc = rtas_token("ibm,configure-connector");
+
+	return (int) (rc != RTAS_UNKNOWN_SERVICE);
+}
+
+int __init rpadlpar_io_init(void)
+{
+	int rc = 0;
+
+	if (!is_dlpar_capable()) {
+		printk(KERN_WARNING "%s: partition not DLPAR capable\n",
+				__FUNCTION__);
+		return -EPERM;
+	}
+
+	rc = dlpar_sysfs_init();
+	return rc;
+}
+
+void rpadlpar_io_exit(void)
+{
+	dlpar_sysfs_exit();
+	return;
+}
+
+module_init(rpadlpar_io_init);
+module_exit(rpadlpar_io_exit);
+MODULE_LICENSE("GPL");
diff -Nru a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c	Fri Feb 20 10:44:50 2004
@@ -0,0 +1,151 @@
+/*
+ * Interface for Dynamic Logical Partitioning of I/O Slots on
+ * RPA-compliant PPC64 platform.
+ *
+ * John Rose <johnrose@austin.ibm.com>
+ * October 2003
+ *
+ * Copyright (C) 2003 IBM.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include "pci_hotplug.h"
+#include "rpadlpar.h"
+
+#define DLPAR_KOBJ_NAME       "control"
+#define ADD_SLOT_ATTR_NAME    "add_slot"
+#define REMOVE_SLOT_ATTR_NAME "remove_slot"
+
+#define MAX_DRC_NAME_LEN 64
+
+/* Store return code of dlpar operation in attribute struct */
+struct dlpar_io_attr {
+	int rc;
+	struct attribute attr;
+	ssize_t (*store)(struct dlpar_io_attr *dlpar_attr, const char *buf,
+		size_t nbytes);
+};
+
+/* Common show callback for all attrs, display the return code
+ * of the dlpar op */
+static ssize_t
+dlpar_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
+{
+	struct dlpar_io_attr *dlpar_attr = container_of(attr,
+						struct dlpar_io_attr, attr);
+	return sprintf(buf, "%d\n", dlpar_attr->rc);
+}
+
+static ssize_t
+dlpar_attr_store(struct kobject * kobj, struct attribute * attr,
+		 const char *buf, size_t nbytes)
+{
+	struct dlpar_io_attr *dlpar_attr = container_of(attr,
+						struct dlpar_io_attr, attr);
+	return dlpar_attr->store ?
+		dlpar_attr->store(dlpar_attr, buf, nbytes) : 0;
+}
+
+static struct sysfs_ops dlpar_attr_sysfs_ops = {
+	.show = dlpar_attr_show,
+	.store = dlpar_attr_store,
+};
+
+static ssize_t add_slot_store(struct dlpar_io_attr *dlpar_attr,
+				const char *buf, size_t nbytes)
+{
+	char drc_name[MAX_DRC_NAME_LEN];
+	char *end;
+
+	if (nbytes > MAX_DRC_NAME_LEN)
+		return 0;
+
+	memcpy(drc_name, buf, nbytes);
+
+	end = strchr(drc_name, '\n');
+	if (!end)
+		end = &drc_name[nbytes];
+	*end = '\0';
+
+	dlpar_attr->rc = dlpar_add_slot(drc_name);
+
+	return nbytes;
+}
+
+static ssize_t remove_slot_store(struct dlpar_io_attr *dlpar_attr,
+		 		const char *buf, size_t nbytes)
+{
+	char drc_name[MAX_DRC_NAME_LEN];
+	char *end;
+
+	if (nbytes > MAX_DRC_NAME_LEN)
+		return 0;
+
+	memcpy(drc_name, buf, nbytes);
+
+	end = strchr(drc_name, '\n');
+	if (!end)
+		end = &drc_name[nbytes];
+	*end = '\0';
+
+	dlpar_attr->rc = dlpar_remove_slot(drc_name);
+
+	return nbytes;
+}
+
+static struct dlpar_io_attr add_slot_attr = {
+	.rc = 0,
+	.attr = { .name = ADD_SLOT_ATTR_NAME, .mode = 0644, },
+	.store = add_slot_store,
+};
+
+static struct dlpar_io_attr remove_slot_attr = {
+	.rc = 0,
+	.attr = { .name = REMOVE_SLOT_ATTR_NAME, .mode = 0644},
+	.store = remove_slot_store,
+};
+
+static struct attribute *default_attrs[] = {
+	&add_slot_attr.attr,
+	&remove_slot_attr.attr,
+	NULL,
+};
+
+static void dlpar_io_release(struct kobject *kobj)
+{
+	/* noop */
+	return;
+}
+
+struct kobj_type ktype_dlpar_io = {
+	.release = dlpar_io_release,
+	.sysfs_ops = &dlpar_attr_sysfs_ops,
+	.default_attrs = default_attrs,
+};
+
+struct kset dlpar_io_kset = {
+	.subsys = &pci_hotplug_slots_subsys,
+	.kobj = {.name = DLPAR_KOBJ_NAME, .ktype=&ktype_dlpar_io,},
+	.ktype = &ktype_dlpar_io,
+};
+
+int dlpar_sysfs_init(void)
+{
+	if (kset_register(&dlpar_io_kset)) {
+		printk(KERN_ERR "rpadlpar_io: cannot register kset for %s\n",
+				dlpar_io_kset.kobj.name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void dlpar_sysfs_exit(void)
+{
+	kset_unregister(&dlpar_io_kset);
+}

