Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVBXGbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVBXGbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBXGbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:31:37 -0500
Received: from peabody.ximian.com ([130.57.169.10]:29874 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261891AbVBXGWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:22:49 -0500
Subject: [RFC] PCI bridge driver rewrite
From: Adam Belay <abelay@novell.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 24 Feb 2005 01:22:01 -0500
Message-Id: <1109226122.28403.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

For the past couple weeks I have been reorganizing the PCI subsystem to
better utilize the driver model.  Specifically, the bus detection code
is now using a standard PCI driver.  It turns out to be a major
undertaking, as the PCI probing code is closely tied into a lot of other
PCI components, and is spread throughout various architecture specific
areas.  I'm hoping that these changes will allow for a much cleaner and
more functional PCI implementation.

The basic flow of the new code is as follows:
1.) A standard "driver core" driver binds to a bridge device.
2.) When "*probe" is called it sets up the hardware and allocates a
"struct pci_bus".
3.) The "struct pci_bus" is filled with information about the detected
bridge.
4.) The driver then registers the "struct pci_bus" with the PCI Bus
Class.
5.) The PCI Bus Class makes the bridge available to sysfs.
6.) It then detects hardware attached to the bridge.
7.) Each new PCI bridge device is registered with the driver model.
8.) All remaining PCI devices are registered with the driver model.

Steps 7 and 8 allow for better resource management.


I've attached an early version of my code.  It has most of the new PCI
bus class registration code in place, and an early implementation of the
PCI-to-PCI bridge driver.  The following remains to be done:

1.) refine and cleanup the new PCI Bus API
2.) export the new API in "linux/pci.h", and cleanup any users of the
old code.
3.) fix every PCI hotplug driver.
4.) write a bridge driver for the PCI root bridge
5.) write a bridge driver for Cardbus hardware
6.) refine device registration order
7.) redesign PCI bus number assignment and support bus renumbering
8.) redesign PCI resource management to be compatible with the new code
9.) testing on various architectures
10.) Write "*suspend" and "*resume" routines for PCI bridges.  Any ideas
on what needs to be done?
11.) fix "PCI_LEGACY" (I may have broke it, but it should be trivial)

I look forward to any comments or suggestions.

Thanks,
Adam


diffstat:
 Makefile      |    9
 bus-class.c   |  225 +++++++++++++++++++++++
 bus/Makefile  |    6
 bus/bus-p2p.c |  133 ++++++++++++++
 device.c      |  142 +++++++++++++++
 pci.h         |    4
 probe.c       |  546
++++++++--------------------------------------------------
 remove.c      |  126 -------------
 9 files changed, 598 insertions(+), 593 deletions(-)

Patch is against 2.6.11-RC3.


diff -urN linux/drivers/pci/bus/bus-p2p.c linux-pci/drivers/pci/bus/bus-p2p.c
--- linux/drivers/pci/bus/bus-p2p.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/bus-p2p.c	2005-02-24 00:19:05.000000000 -0500
@@ -0,0 +1,133 @@
+/*
+ * bus-p2p.c - a generic PCI bus driver for PCI<->PCI bridges
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+static struct pci_device_id p2p_id_tbl[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI << 8, 0xffff00) },
+	{ 0 },
+};
+MODULE_DEVICE_TABLE(pci, p2p_id_tbl);
+
+static void p2p_setup_bus_numbers(struct pci_dev *dev, struct pci_bus *bus)
+{
+	u32 buses;
+
+	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
+
+	bus->primary = buses & 0xFF;
+	bus->secondary = (buses >> 8) & 0xFF;
+	bus->subordinate = (buses >> 16) & 0xFF;
+}
+
+static void pci_enable_crs(struct pci_dev *dev)
+{
+	u16 cap, rpctl;
+	int rpcap = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!rpcap)
+		return;
+
+	pci_read_config_word(dev, rpcap + PCI_CAP_FLAGS, &cap);
+	if (((cap & PCI_EXP_FLAGS_TYPE) >> 4) != PCI_EXP_TYPE_ROOT_PORT)
+		return;
+
+	pci_read_config_word(dev, rpcap + PCI_EXP_RTCTL, &rpctl);
+	rpctl |= PCI_EXP_RTCTL_CRSSVE;
+	pci_write_config_word(dev, rpcap + PCI_EXP_RTCTL, rpctl);
+}
+
+static void p2p_prepare_hardware(struct pci_dev *dev, struct pci_bus *bus)
+{
+	u16 bctl;
+
+	/* Disable MasterAbortMode during probing to avoid reporting
+	   of bus errors (in some architectures) */ 
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
+			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
+
+	bus->bridge_ctl = bctl;
+
+	pci_enable_crs(dev);
+}
+
+/* FIXME: these need to be defined in linux/pci.h */
+extern struct pci_bus * pci_alloc_bus(void);
+extern int pci_add_bus(struct pci_bus *bus);
+extern struct pci_bus * pci_derive_parent(struct device *);
+
+static int p2p_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int err, i;
+	struct pci_bus *bus;
+
+	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+		return -ENODEV;
+
+	bus = pci_alloc_bus();
+
+	if (!bus)
+		return -ENOMEM;
+
+	bus->bridge = &dev->dev;
+	bus->parent = pci_derive_parent(&bus->self->dev);
+	if (!bus->parent) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	bus->ops = bus->parent->ops;
+	bus->sysdata = bus->parent->sysdata;
+	bus->bridge = get_device(&dev->dev);
+
+	dev->subordinate = bus;
+
+	/* Set up default resource pointers and names.. */
+	for (i = 0; i < 4; i++) {
+		bus->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+		bus->resource[i]->name = bus->name;
+	}
+
+	p2p_setup_bus_numbers(dev,bus);
+	p2p_prepare_hardware(dev,bus);
+
+	err = pci_add_bus(bus);
+	if (!err)
+		return 0;
+
+	dev->subordinate = NULL;
+
+out:
+	kfree(bus);
+	return err;
+}
+
+static void p2p_remove(struct pci_dev *dev)
+{
+	pci_remove_bus(dev->subordinate);
+}
+
+static struct pci_driver p2p_driver = {
+	.name		= "pci-bridge",
+	.id_table	= p2p_id_tbl,
+	.probe		= p2p_probe,
+	.remove		= p2p_remove,
+	/* FIXME: we need power management support */
+};
+
+static int __init p2p_init(void)
+{
+	return pci_register_driver(&p2p_driver);
+}
+
+static void __exit p2p_exit(void)
+{
+	pci_unregister_driver(&p2p_driver);
+}
+
+module_init(p2p_init);
+module_exit(p2p_exit);
diff -urN linux/drivers/pci/bus/Makefile linux-pci/drivers/pci/bus/Makefile
--- linux/drivers/pci/bus/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/Makefile	2005-02-22 04:22:07.000000000 -0500
@@ -0,0 +1,6 @@
+#
+# Makefile for the PCI bus class
+#
+
+obj-y := bus-p2p.o
+ 
\ No newline at end of file
diff -urN linux/drivers/pci/bus-class.c linux-pci/drivers/pci/bus-class.c
--- linux/drivers/pci/bus-class.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus-class.c	2005-02-24 00:23:03.000000000 -0500
@@ -0,0 +1,225 @@
+/*
+ * bus-class.c - the core of the PCI bus class driver
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/cpumask.h>
+
+#include "pci.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+
+/*
+ * PCI Bus Class
+ */
+
+#ifdef HAVE_PCI_LEGACY
+/**
+ * pci_create_legacy_files - create legacy I/O port and memory files
+ * @b: bus to create files under
+ *
+ * Some platforms allow access to legacy I/O port and ISA memory space on
+ * a per-bus basis.  This routine creates the files and ties them into
+ * their associated read, write and mmap files from pci-sysfs.c
+ */
+static void pci_create_legacy_files(struct pci_bus *b)
+{
+	b->legacy_io = kmalloc(sizeof(struct bin_attribute) * 2,
+			       GFP_ATOMIC);
+	if (b->legacy_io) {
+		memset(b->legacy_io, 0, sizeof(struct bin_attribute) * 2);
+		b->legacy_io->attr.name = "legacy_io";
+		b->legacy_io->size = 0xffff;
+		b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
+		b->legacy_io->attr.owner = THIS_MODULE;
+		b->legacy_io->read = pci_read_legacy_io;
+		b->legacy_io->write = pci_write_legacy_io;
+		class_device_create_bin_file(&b->class_dev, b->legacy_io);
+
+		/* Allocated above after the legacy_io struct */
+		b->legacy_mem = b->legacy_io + 1;
+		b->legacy_mem->attr.name = "legacy_mem";
+		b->legacy_mem->size = 1024*1024;
+		b->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
+		b->legacy_mem->attr.owner = THIS_MODULE;
+		b->legacy_mem->mmap = pci_mmap_legacy_mem;
+		class_device_create_bin_file(&b->class_dev, b->legacy_mem);
+	}
+}
+
+void pci_remove_legacy_files(struct pci_bus *b)
+{
+	class_device_remove_bin_file(&b->class_dev, b->legacy_io);
+	class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
+	kfree(b->legacy_io); /* both are allocated here */
+}
+#else /* !HAVE_PCI_LEGACY */
+static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
+void pci_remove_legacy_files(struct pci_bus *bus) { return; }
+#endif /* HAVE_PCI_LEGACY */
+
+static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
+{
+	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
+	int ret;
+
+	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
+	if (ret < PAGE_SIZE)
+		buf[ret++] = '\n';
+	return ret;
+}
+CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
+
+ 
+static void release_pcibus_dev(struct class_device *class_dev)
+{
+	struct pci_bus *pci_bus = to_pci_bus(class_dev);
+
+	if (pci_bus->bridge)
+		put_device(pci_bus->bridge);
+	kfree(pci_bus);
+}
+
+static struct class pcibus_class = {
+	.name		= "pci_bus",
+	.release	= &release_pcibus_dev,
+};
+
+static int __init pcibus_class_init(void)
+{
+	return class_register(&pcibus_class);
+}
+
+postcore_initcall(pcibus_class_init);
+
+
+/*
+ * Registration
+ */
+
+/**
+ *	pci_alloc_bus - allocates a "pci_bus" structure
+ */
+struct pci_bus * pci_alloc_bus(void)
+{
+	struct pci_bus *b;
+
+	b = kmalloc(sizeof(*b), GFP_KERNEL);
+	if (b) {
+		memset(b, 0, sizeof(*b));
+		INIT_LIST_HEAD(&b->node);
+		INIT_LIST_HEAD(&b->children);
+		INIT_LIST_HEAD(&b->devices);
+	}
+	return b;
+}
+
+EXPORT_SYMBOL(pci_alloc_bus);
+
+/**
+ *	pci_derive_parent - determines the parent of a pci bus
+ *	@dev:	the child device
+ *
+ *	This function will only return a positive match if the parent is a pci
+ *	device.
+ */
+struct pci_bus * pci_derive_bus_parent(struct device *dev)
+{
+	struct device *dmparent = dev->parent;
+	
+	if (!dmparent)
+		return NULL;
+
+	if (dmparent->bus != &pci_bus_type)
+		return NULL;
+	
+	return to_pci_dev(dmparent)->subordinate;
+}
+
+EXPORT_SYMBOL(pci_derive_bus_parent);
+
+static void pci_register_buses(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+			pci_add_device(dev);
+	}
+}
+
+static void pci_register_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+			pci_add_device(dev);
+	}
+}
+
+/**
+ *	pci_add_bus - registers a bus with the pci bus class
+ *	@bus:		the bus
+ *
+ *	This function binds a pci bus device to the pci bus class.  Every pci
+ *	bus driver is expected to register its devices with the pci subsystem
+ *	via this function.
+ */
+int pci_add_bus(struct pci_bus *bus)
+{
+	int ret;
+
+	bus->class_dev.class = &pcibus_class;
+	sprintf(bus->class_dev.class_id, "%04x:%02x", pci_domain_nr(bus), bus->primary);
+	ret = class_device_register(&bus->class_dev);
+	if (ret)
+		return ret;
+
+	class_device_create_file(&bus->class_dev, &class_device_attr_cpuaffinity);
+
+	pci_detect_children(bus);
+	pci_register_buses(bus);
+	pci_register_devices(bus);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_add_bus);
+
+/**
+ *	pci_remove_bus - unregisters a bus with the pci bus class
+ *	@bus:	the bus
+ *
+ *	This function removes a pci bus device from the pci bus class.  Every
+ *	pci bus driver is expected to unregister it's devices with the pci
+ *	subsystem using this function.
+ */
+void pci_remove_bus(struct pci_bus *bus)
+{
+	pci_proc_detach_bus(bus);
+
+	spin_lock(&pci_bus_lock);
+	list_del(&bus->node);
+	spin_unlock(&pci_bus_lock);
+	pci_remove_legacy_files(bus);
+	class_device_remove_file(&bus->class_dev,
+		&class_device_attr_cpuaffinity);
+	sysfs_remove_link(&bus->class_dev.kobj, "bridge");
+	class_device_unregister(&bus->class_dev);
+}
+
+EXPORT_SYMBOL(pci_remove_bus);
diff -urN linux/drivers/pci/device.c linux-pci/drivers/pci/device.c
--- linux/drivers/pci/device.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/device.c	2005-02-24 01:00:17.000000000 -0500
@@ -0,0 +1,142 @@
+/*
+ * device.c - pci device registration
+ *
+ */
+ 
+#include <linux/pci.h>
+#include <linux/module.h>
+#include "pci.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+/**
+ *	pci_add_device - registers a device with the pci subsystem
+ *	@dev:	the device
+ */
+
+int pci_add_device(struct pci_dev *dev)
+{
+	int err;
+
+	err = device_add(&dev->dev);
+	if (err)
+		return err;
+
+	spin_lock(&pci_bus_lock);
+	list_add_tail(&dev->global_list, &pci_devices);
+	spin_unlock(&pci_bus_lock);
+
+	pci_proc_attach_device(dev);
+	pci_create_sysfs_dev_files(dev);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_add_device);
+
+static void pci_free_resources(struct pci_dev *dev)
+{
+	int i;
+
+ 	msi_remove_pci_irq_vectors(dev);
+
+	pci_cleanup_rom(dev);
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *res = dev->resource + i;
+		if (res->parent)
+			release_resource(res);
+	}
+}
+
+static void pci_destroy_dev(struct pci_dev *dev)
+{
+	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
+	device_unregister(&dev->dev);
+
+	/* Remove the device from the device lists, and prevent any further
+	 * list accesses from this device */
+	spin_lock(&pci_bus_lock);
+	list_del(&dev->bus_list);
+	list_del(&dev->global_list);
+	dev->bus_list.next = dev->bus_list.prev = NULL;
+	dev->global_list.next = dev->global_list.prev = NULL;
+	spin_unlock(&pci_bus_lock);
+
+	pci_free_resources(dev);
+	pci_dev_put(dev);
+}
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
+	if (pci_dev_driver(dev))
+		return -EBUSY;
+	pci_destroy_dev(dev);
+	return 0;
+}
+EXPORT_SYMBOL(pci_remove_device_safe);
+
+/**
+ * pci_remove_bus_device - remove a PCI device and any children
+ * @dev: the device to remove
+ *
+ * Remove a PCI device from the device lists, informing the drivers
+ * that the device has been removed.  We also remove any subordinate
+ * buses and children in a depth-first manner.
+ *
+ * For each device we remove, delete the device structure from the
+ * device lists, remove the /proc entry, and notify userspace
+ * (/sbin/hotplug).
+ */
+void pci_remove_bus_device(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		struct pci_bus *b = dev->subordinate;
+
+		pci_remove_behind_bridge(dev);
+		pci_remove_bus(b);
+		dev->subordinate = NULL;
+	}
+
+	pci_destroy_dev(dev);
+}
+
+EXPORT_SYMBOL(pci_remove_bus_device);
+
+/**
+ * pci_remove_behind_bridge - remove all devices behind a PCI bridge
+ * @dev: PCI bridge device
+ *
+ * Remove all devices on the bus, except for the parent bridge.
+ * This also removes any child buses, and any devices they may
+ * contain in a depth-first manner.
+ */
+void pci_remove_behind_bridge(struct pci_dev *dev)
+{
+	struct list_head *l, *n;
+
+	if (dev->subordinate) {
+		list_for_each_safe(l, n, &dev->subordinate->devices) {
+			struct pci_dev *dev = pci_dev_b(l);
+
+			pci_remove_bus_device(dev);
+		}
+	}
+}
+
+EXPORT_SYMBOL(pci_remove_behind_bridge);
diff -urN linux/drivers/pci/Makefile linux-pci/drivers/pci/Makefile
--- linux/drivers/pci/Makefile	2005-02-11 18:07:09.000000000 -0500
+++ linux-pci/drivers/pci/Makefile	2005-02-22 04:21:51.000000000 -0500
@@ -2,9 +2,9 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
-			names.o pci-driver.o search.o pci-sysfs.o \
-			rom.o
+obj-y		+= access.o bus.o bus-class.o probe.o device.o pci.o \
+		   quirks.o names.o pci-driver.o search.o pci-sysfs.o \
+		   rom.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
@@ -16,6 +16,9 @@
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 
+# Build the PCI Bus class
+obj-y += bus/
+
 #
 # Some architectures use the generic PCI setup functions
 #
diff -urN linux/drivers/pci/pci.h linux-pci/drivers/pci/pci.h
--- linux/drivers/pci/pci.h	2005-02-11 18:07:10.000000000 -0500
+++ linux-pci/drivers/pci/pci.h	2005-02-23 20:27:02.000000000 -0500
@@ -11,6 +11,10 @@
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
+
+extern int pci_detect_children(struct pci_bus *bus);
+extern int pci_add_device(struct pci_dev *dev);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
diff -urN linux/drivers/pci/probe.c linux-pci/drivers/pci/probe.c
--- linux/drivers/pci/probe.c	2005-02-11 18:07:10.000000000 -0500
+++ linux-pci/drivers/pci/probe.c	2005-02-23 20:11:37.000000000 -0500
@@ -28,92 +28,14 @@
 
 LIST_HEAD(pci_devices);
 
-#ifdef HAVE_PCI_LEGACY
-/**
- * pci_create_legacy_files - create legacy I/O port and memory files
- * @b: bus to create files under
- *
- * Some platforms allow access to legacy I/O port and ISA memory space on
- * a per-bus basis.  This routine creates the files and ties them into
- * their associated read, write and mmap files from pci-sysfs.c
- */
-static void pci_create_legacy_files(struct pci_bus *b)
-{
-	b->legacy_io = kmalloc(sizeof(struct bin_attribute) * 2,
-			       GFP_ATOMIC);
-	if (b->legacy_io) {
-		memset(b->legacy_io, 0, sizeof(struct bin_attribute) * 2);
-		b->legacy_io->attr.name = "legacy_io";
-		b->legacy_io->size = 0xffff;
-		b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
-		b->legacy_io->attr.owner = THIS_MODULE;
-		b->legacy_io->read = pci_read_legacy_io;
-		b->legacy_io->write = pci_write_legacy_io;
-		class_device_create_bin_file(&b->class_dev, b->legacy_io);
-
-		/* Allocated above after the legacy_io struct */
-		b->legacy_mem = b->legacy_io + 1;
-		b->legacy_mem->attr.name = "legacy_mem";
-		b->legacy_mem->size = 1024*1024;
-		b->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
-		b->legacy_mem->attr.owner = THIS_MODULE;
-		b->legacy_mem->mmap = pci_mmap_legacy_mem;
-		class_device_create_bin_file(&b->class_dev, b->legacy_mem);
-	}
-}
-
-void pci_remove_legacy_files(struct pci_bus *b)
-{
-	class_device_remove_bin_file(&b->class_dev, b->legacy_io);
-	class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
-	kfree(b->legacy_io); /* both are allocated here */
-}
-#else /* !HAVE_PCI_LEGACY */
-static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
-void pci_remove_legacy_files(struct pci_bus *bus) { return; }
-#endif /* HAVE_PCI_LEGACY */
-
-/*
- * PCI Bus Class Devices
- */
-static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
-{
-	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
-	int ret;
-
-	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
-	if (ret < PAGE_SIZE)
-		buf[ret++] = '\n';
-	return ret;
-}
-CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
 
 /*
- * PCI Bus Class
+ * resource parsing
  */
-static void release_pcibus_dev(struct class_device *class_dev)
-{
-	struct pci_bus *pci_bus = to_pci_bus(class_dev);
-
-	if (pci_bus->bridge)
-		put_device(pci_bus->bridge);
-	kfree(pci_bus);
-}
 
-static struct class pcibus_class = {
-	.name		= "pci_bus",
-	.release	= &release_pcibus_dev,
-};
-
-static int __init pcibus_class_init(void)
-{
-	return class_register(&pcibus_class);
-}
-postcore_initcall(pcibus_class_init);
-
-/*
- * Translate the low bits of the PCI base
- * to the resource type
+/**
+ * pci_calc_resource_flags - converts PCI resource flags to a general form
+ * @flags: a mask of pci resource flags
  */
 static inline unsigned int pci_calc_resource_flags(unsigned int flags)
 {
@@ -126,8 +48,8 @@
 	return IORESOURCE_MEM;
 }
 
-/*
- * Find the extent of a PCI decode..
+/**
+ * pci_size - determines the length of a resource
  */
 static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
 {
@@ -147,6 +69,12 @@
 	return size;
 }
 
+/**
+ * pci_read_bases - read and store resource information for a device
+ * @dev:	the device
+ * @howmany:	number of bases
+ * @rom:	whether to scan the rom resource
+ */
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg, next;
@@ -229,7 +157,11 @@
 	}
 }
 
-void __devinit pci_read_bridge_bases(struct pci_bus *child)
+/**
+ * pci_read_bridge_bases - read and store resource information for a pci bus
+ * @child: the bus
+ */
+void pci_read_bridge_bases(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	u8 io_base_lo, io_limit_lo;
@@ -317,222 +249,78 @@
 	}
 }
 
-static struct pci_bus * __devinit pci_alloc_bus(void)
-{
-	struct pci_bus *b;
-
-	b = kmalloc(sizeof(*b), GFP_KERNEL);
-	if (b) {
-		memset(b, 0, sizeof(*b));
-		INIT_LIST_HEAD(&b->node);
-		INIT_LIST_HEAD(&b->children);
-		INIT_LIST_HEAD(&b->devices);
-	}
-	return b;
-}
-
-static struct pci_bus * __devinit
-pci_alloc_child_bus(struct pci_bus *parent, struct pci_dev *bridge, int busnr)
-{
-	struct pci_bus *child;
-	int i;
-
-	/*
-	 * Allocate a new bus, and inherit stuff from the parent..
-	 */
-	child = pci_alloc_bus();
-	if (!child)
-		return NULL;
-
-	child->self = bridge;
-	child->parent = parent;
-	child->ops = parent->ops;
-	child->sysdata = parent->sysdata;
-	child->bridge = get_device(&bridge->dev);
-
-	child->class_dev.class = &pcibus_class;
-	sprintf(child->class_dev.class_id, "%04x:%02x", pci_domain_nr(child), busnr);
-	class_device_register(&child->class_dev);
-	class_device_create_file(&child->class_dev, &class_device_attr_cpuaffinity);
-
-	/*
-	 * Set up the primary, secondary and subordinate
-	 * bus numbers.
-	 */
-	child->number = child->secondary = busnr;
-	child->primary = parent->secondary;
-	child->subordinate = 0xff;
-
-	/* Set up default resource pointers and names.. */
-	for (i = 0; i < 4; i++) {
-		child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
-		child->resource[i]->name = child->name;
-	}
-	bridge->subordinate = child;
 
-	return child;
-}
+/*
+ * PCI device probing
+ */
 
-struct pci_bus * __devinit pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr)
+/**
+ * pci_release_dev - free a pci device structure when all users of it are finished.
+ * @dev: device that's been disconnected
+ *
+ * Will be called only by the device core when all users of this pci device are
+ * done.
+ */
+static void pci_release_dev(struct device *dev)
 {
-	struct pci_bus *child;
+	struct pci_dev *pci_dev;
 
-	child = pci_alloc_child_bus(parent, dev, busnr);
-	if (child)
-		list_add_tail(&child->node, &parent->children);
-	return child;
+	pci_dev = to_pci_dev(dev);
+	kfree(pci_dev);
 }
 
-static void pci_enable_crs(struct pci_dev *dev)
+/**
+ * pci_read_irq - determine the device's irq
+ * @dev: the device
+ *
+ * Reads interrupt line and base address registers.
+ * The architecture-dependent code can tweak these, of course.
+ */
+static void pci_read_irq(struct pci_dev *dev)
 {
-	u16 cap, rpctl;
-	int rpcap = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (!rpcap)
-		return;
-
-	pci_read_config_word(dev, rpcap + PCI_CAP_FLAGS, &cap);
-	if (((cap & PCI_EXP_FLAGS_TYPE) >> 4) != PCI_EXP_TYPE_ROOT_PORT)
-		return;
+	unsigned char irq;
 
-	pci_read_config_word(dev, rpcap + PCI_EXP_RTCTL, &rpctl);
-	rpctl |= PCI_EXP_RTCTL_CRSSVE;
-	pci_write_config_word(dev, rpcap + PCI_EXP_RTCTL, rpctl);
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
+	if (irq)
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	dev->irq = irq;
 }
 
-unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus);
-
-/*
- * If it's a bridge, configure it and scan the bus behind it.
- * For CardBus bridges, we don't scan behind as the devices will
- * be handled by the bridge driver itself.
+/**
+ * pci_cfg_space_size - get the configuration space size of the PCI device.
  *
- * We need to process bridges in two passes -- first we scan those
- * already configured by the BIOS and after we are done with all of
- * them, we proceed to assigning numbers to the remaining buses in
- * order to avoid overlaps between old and new bus numbers.
+ * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
+ * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
+ * access it.  Maybe we don't have a way to generate extended config space
+ * accesses, or the device is behind a reverse Express bridge.  So we try
+ * reading the dword at 0x100 which must either be 0 or a valid extended
+ * capability header.
  */
-int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
+static int pci_cfg_space_size(struct pci_dev *dev)
 {
-	struct pci_bus *child;
-	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
-	u32 buses;
-	u16 bctl;
-
-	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
-
-	DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n",
-	    pci_name(dev), buses & 0xffffff, pass);
-
-	/* Disable MasterAbortMode during probing to avoid reporting
-	   of bus errors (in some architectures) */ 
-	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
-			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
-
-	pci_enable_crs(dev);
-
-	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
-		unsigned int cmax, busnr;
-		/*
-		 * Bus already configured by firmware, process it in the first
-		 * pass and just note the configuration.
-		 */
-		if (pass)
-			return max;
-		busnr = (buses >> 8) & 0xFF;
-
-		/*
-		 * If we already got to this bus through a different bridge,
-		 * ignore it.  This can happen with the i450NX chipset.
-		 */
-		if (pci_find_bus(pci_domain_nr(bus), busnr)) {
-			printk(KERN_INFO "PCI: Bus %04x:%02x already known\n",
-					pci_domain_nr(bus), busnr);
-			return max;
-		}
-
-		child = pci_alloc_child_bus(bus, dev, busnr);
-		if (!child)
-			return max;
-		child->primary = buses & 0xFF;
-		child->subordinate = (buses >> 16) & 0xFF;
-		child->bridge_ctl = bctl;
-
-		cmax = pci_scan_child_bus(child);
-		if (cmax > max)
-			max = cmax;
-		if (child->subordinate > max)
-			max = child->subordinate;
-	} else {
-		/*
-		 * We need to assign a number to this bus which we always
-		 * do in the second pass.
-		 */
-		if (!pass)
-			return max;
-
-		/* Clear errors */
-		pci_write_config_word(dev, PCI_STATUS, 0xffff);
-
-		child = pci_alloc_child_bus(bus, dev, ++max);
-		buses = (buses & 0xff000000)
-		      | ((unsigned int)(child->primary)     <<  0)
-		      | ((unsigned int)(child->secondary)   <<  8)
-		      | ((unsigned int)(child->subordinate) << 16);
-
-		/*
-		 * yenta.c forces a secondary latency timer of 176.
-		 * Copy that behaviour here.
-		 */
-		if (is_cardbus) {
-			buses &= ~0xff000000;
-			buses |= CARDBUS_LATENCY_TIMER << 24;
-		}
-			
-		/*
-		 * We need to blast all three values with a single write.
-		 */
-		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
+	int pos;
+	u32 status;
 
-		if (!is_cardbus) {
-			child->bridge_ctl = PCI_BRIDGE_CTL_NO_ISA;
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!pos) {
+		pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+		if (!pos)
+			goto fail;
 
-			/* Now we can scan all subordinate buses... */
-			max = pci_scan_child_bus(child);
-		} else {
-			/*
-			 * For CardBus bridges, we leave 4 bus numbers
-			 * as cards with a PCI-to-PCI bridge can be
-			 * inserted later.
-			 */
-			max += CARDBUS_RESERVE_BUSNR;
-		}
-		/*
-		 * Set the subordinate bus number to its real value.
-		 */
-		child->subordinate = max;
-		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
+		pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
+		if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
+			goto fail;
 	}
 
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
-
-	sprintf(child->name, (is_cardbus ? "PCI CardBus #%02x" : "PCI Bus #%02x"), child->number);
-
-	return max;
-}
+	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
+		goto fail;
+	if (status == 0xffffffff)
+		goto fail;
 
-/*
- * Read interrupt line and base address registers.
- * The architecture-dependent code can tweak these, of course.
- */
-static void pci_read_irq(struct pci_dev *dev)
-{
-	unsigned char irq;
+	return PCI_CFG_SPACE_EXP_SIZE;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
-	if (irq)
-		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	dev->irq = irq;
+ fail:
+	return PCI_CFG_SPACE_SIZE;
 }
 
 /**
@@ -541,7 +329,7 @@
  *
  * Initialize the device structure with information about the device's 
  * vendor,class,memory and IO-space addresses,IRQ lines etc.
- * Called at initialisation of the PCI subsystem and by CardBus services.
+ * Called at initialization of the PCI subsystem and by CardBus services.
  * Returns 0 on success and -1 if unknown type of device (not normal, bridge
  * or CardBus).
  */
@@ -611,69 +399,12 @@
 	/* We found a fine healthy device, go go go... */
 	return 0;
 }
-
-/**
- * pci_release_dev - free a pci device structure when all users of it are finished.
- * @dev: device that's been disconnected
- *
- * Will be called only by the device core when all users of this pci device are
- * done.
- */
-static void pci_release_dev(struct device *dev)
-{
-	struct pci_dev *pci_dev;
-
-	pci_dev = to_pci_dev(dev);
-	kfree(pci_dev);
-}
-
-/**
- * pci_cfg_space_size - get the configuration space size of the PCI device.
- *
- * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
- * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
- * access it.  Maybe we don't have a way to generate extended config space
- * accesses, or the device is behind a reverse Express bridge.  So we try
- * reading the dword at 0x100 which must either be 0 or a valid extended
- * capability header.
- */
-static int pci_cfg_space_size(struct pci_dev *dev)
-{
-	int pos;
-	u32 status;
-
-	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (!pos) {
-		pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-		if (!pos)
-			goto fail;
-
-		pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
-		if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
-			goto fail;
-	}
-
-	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
-		goto fail;
-	if (status == 0xffffffff)
-		goto fail;
-
-	return PCI_CFG_SPACE_EXP_SIZE;
-
- fail:
-	return PCI_CFG_SPACE_SIZE;
-}
-
-static void pci_release_bus_bridge_dev(struct device *dev)
-{
-	kfree(dev);
-}
-
+ 
 /*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
  */
-static struct pci_dev * __devinit
+static struct pci_dev *
 pci_scan_device(struct pci_bus *bus, int devfn)
 {
 	struct pci_dev *dev;
@@ -776,7 +507,7 @@
  * discovered devices to the @bus->devices list.  New devices
  * will have an empty dev->global_list head.
  */
-int __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
+int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
 	int func, nr = 0;
 	int scan_all_fns;
@@ -809,10 +540,14 @@
 	return nr;
 }
 
-unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
+
+/*
+ * PCI bus probing
+ */
+
+int pci_detect_children(struct pci_bus *bus)
 {
-	unsigned int devfn, pass, max = bus->secondary;
-	struct pci_dev *dev;
+	unsigned int devfn;
 
 	DBG("Scanning bus %02x\n", bus->number);
 
@@ -820,125 +555,8 @@
 	for (devfn = 0; devfn < 0x100; devfn += 8)
 		pci_scan_slot(bus, devfn);
 
-	/*
-	 * After performing arch-dependent fixup of the bus, look behind
-	 * all PCI-to-PCI bridges on this bus.
-	 */
 	DBG("Fixups for bus %02x\n", bus->number);
 	pcibios_fixup_bus(bus);
-	for (pass=0; pass < 2; pass++)
-		list_for_each_entry(dev, &bus->devices, bus_list) {
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
-				max = pci_scan_bridge(bus, dev, max, pass);
-		}
-
-	/*
-	 * We've scanned the bus and so we know all about what's on
-	 * the other side of any bridges that may be on this bus plus
-	 * any devices.
-	 *
-	 * Return how far we've got finding sub-buses.
-	 */
-	DBG("Bus scan for %02x returning with max=%02x\n", bus->number, max);
-	return max;
-}
 
-unsigned int __devinit pci_do_scan_bus(struct pci_bus *bus)
-{
-	unsigned int max;
-
-	max = pci_scan_child_bus(bus);
-
-	/*
-	 * Make the discovered devices available.
-	 */
-	pci_bus_add_devices(bus);
-
-	return max;
+	return 0;
 }
-
-struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
-{
-	int error;
-	struct pci_bus *b;
-	struct device *dev;
-
-	b = pci_alloc_bus();
-	if (!b)
-		return NULL;
-
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev){
-		kfree(b);
-		return NULL;
-	}
-
-	b->sysdata = sysdata;
-	b->ops = ops;
-
-	if (pci_find_bus(pci_domain_nr(b), bus)) {
-		/* If we already got to this bus through a different bridge, ignore it */
-		DBG("PCI: Bus %04:%02x already known\n", pci_domain_nr(b), bus);
-		goto err_out;
-	}
-	list_add_tail(&b->node, &pci_root_buses);
-
-	memset(dev, 0, sizeof(*dev));
-	dev->parent = parent;
-	dev->release = pci_release_bus_bridge_dev;
-	sprintf(dev->bus_id, "pci%04x:%02x", pci_domain_nr(b), bus);
-	error = device_register(dev);
-	if (error)
-		goto dev_reg_err;
-	b->bridge = get_device(dev);
-
-	b->class_dev.class = &pcibus_class;
-	sprintf(b->class_dev.class_id, "%04x:%02x", pci_domain_nr(b), bus);
-	error = class_device_register(&b->class_dev);
-	if (error)
-		goto class_dev_reg_err;
-	error = class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
-	if (error)
-		goto class_dev_create_file_err;
-
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(b);
-
-	error = sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
-	if (error)
-		goto sys_create_link_err;
-
-	b->number = b->secondary = bus;
-	b->resource[0] = &ioport_resource;
-	b->resource[1] = &iomem_resource;
-
-	b->subordinate = pci_scan_child_bus(b);
-
-	pci_bus_add_devices(b);
-
-	return b;
-
-sys_create_link_err:
-	class_device_remove_file(&b->class_dev, &class_device_attr_cpuaffinity);
-class_dev_create_file_err:
-	class_device_unregister(&b->class_dev);
-class_dev_reg_err:
-	device_unregister(dev);
-dev_reg_err:
-	list_del(&b->node);
-err_out:
-	kfree(dev);
-	kfree(b);
-	return NULL;
-}
-EXPORT_SYMBOL(pci_scan_bus_parented);
-
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pci_add_new_bus);
-EXPORT_SYMBOL(pci_do_scan_bus);
-EXPORT_SYMBOL(pci_scan_slot);
-EXPORT_SYMBOL(pci_scan_bridge);
-EXPORT_SYMBOL(pci_scan_single_device);
-EXPORT_SYMBOL_GPL(pci_scan_child_bus);
-#endif
diff -urN linux/drivers/pci/remove.c linux-pci/drivers/pci/remove.c
--- linux/drivers/pci/remove.c	2005-02-11 18:07:10.000000000 -0500
+++ linux-pci/drivers/pci/remove.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,126 +0,0 @@
-#include <linux/pci.h>
-#include <linux/module.h>
-#include "pci.h"
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
-static void pci_free_resources(struct pci_dev *dev)
-{
-	int i;
-
- 	msi_remove_pci_irq_vectors(dev);
-
-	pci_cleanup_rom(dev);
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = dev->resource + i;
-		if (res->parent)
-			release_resource(res);
-	}
-}
-
-static void pci_destroy_dev(struct pci_dev *dev)
-{
-	pci_proc_detach_device(dev);
-	pci_remove_sysfs_dev_files(dev);
-	device_unregister(&dev->dev);
-
-	/* Remove the device from the device lists, and prevent any further
-	 * list accesses from this device */
-	spin_lock(&pci_bus_lock);
-	list_del(&dev->bus_list);
-	list_del(&dev->global_list);
-	dev->bus_list.next = dev->bus_list.prev = NULL;
-	dev->global_list.next = dev->global_list.prev = NULL;
-	spin_unlock(&pci_bus_lock);
-
-	pci_free_resources(dev);
-	pci_dev_put(dev);
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
-	if (pci_dev_driver(dev))
-		return -EBUSY;
-	pci_destroy_dev(dev);
-	return 0;
-}
-EXPORT_SYMBOL(pci_remove_device_safe);
-
-void pci_remove_bus(struct pci_bus *pci_bus)
-{
-	pci_proc_detach_bus(pci_bus);
-
-	spin_lock(&pci_bus_lock);
-	list_del(&pci_bus->node);
-	spin_unlock(&pci_bus_lock);
-	pci_remove_legacy_files(pci_bus);
-	class_device_remove_file(&pci_bus->class_dev,
-		&class_device_attr_cpuaffinity);
-	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
-	class_device_unregister(&pci_bus->class_dev);
-}
-EXPORT_SYMBOL(pci_remove_bus);
-
-/**
- * pci_remove_bus_device - remove a PCI device and any children
- * @dev: the device to remove
- *
- * Remove a PCI device from the device lists, informing the drivers
- * that the device has been removed.  We also remove any subordinate
- * buses and children in a depth-first manner.
- *
- * For each device we remove, delete the device structure from the
- * device lists, remove the /proc entry, and notify userspace
- * (/sbin/hotplug).
- */
-void pci_remove_bus_device(struct pci_dev *dev)
-{
-	if (dev->subordinate) {
-		struct pci_bus *b = dev->subordinate;
-
-		pci_remove_behind_bridge(dev);
-		pci_remove_bus(b);
-		dev->subordinate = NULL;
-	}
-
-	pci_destroy_dev(dev);
-}
-
-/**
- * pci_remove_behind_bridge - remove all devices behind a PCI bridge
- * @dev: PCI bridge device
- *
- * Remove all devices on the bus, except for the parent bridge.
- * This also removes any child buses, and any devices they may
- * contain in a depth-first manner.
- */
-void pci_remove_behind_bridge(struct pci_dev *dev)
-{
-	struct list_head *l, *n;
-
-	if (dev->subordinate) {
-		list_for_each_safe(l, n, &dev->subordinate->devices) {
-			struct pci_dev *dev = pci_dev_b(l);
-
-			pci_remove_bus_device(dev);
-		}
-	}
-}
-
-EXPORT_SYMBOL(pci_remove_bus_device);
-EXPORT_SYMBOL(pci_remove_behind_bridge);


