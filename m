Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVCGXVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVCGXVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVCGXVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:21:15 -0500
Received: from peabody.ximian.com ([130.57.169.10]:13717 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261804AbVCGWep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:34:45 -0500
Subject: [RFC][PATCH] PCI bridge driver rewrite (rev 02)
From: Adam Belay <abelay@novell.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 17:32:21 -0500
Message-Id: <1110234742.2456.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

This is the second release of my PCI bridge driver rewrite.  It is still
in early development.  Before the code can compile and be functional, a
number of resource management changes need to be made.  Also the
PCI<->PCI bridge driver needs to be finished and the root bridge driver
needs to be written.

With that in mind, this release makes significant progress in refining
the PCI bus class API.  Also it adds a few important features.  Any
Comments or suggestions would be appreciated.

I did some experimentation with ACPI, and plan to use it to enumerate
the root bridges.  Also, I plan to handle the ISA_ENABLE and VGA_ENABLE
bits in a future release.

Thanks,
Adam

Changelog:

revision 02
===========
(me):
      * Minor reorganization of the file structure in "/driver/pci".
        Moved probe.c into "/drivers/pci/bus" where it logically
        belongs.  Created "bus-res.c" for resource management and
        "bus-num.c" for assigning bus numbers.
      * Added some skeleton code to "bus-num.c"
      * Use "struct resource" to describe bus numbers.  It occurred to
        me that "resource.c" could be used as a general purpose library
        for assigning ranges.  This will prevent code duplication.
      * Added "struct pci_dev_bridge" to contain data about bridges when
        it is available. (i.e. pci bridge and carbus headers)  Other
        capabilities, such as the PCI power management information could
        also be handled this way.
      * Updated probe code to fill in "struct pci_dev_bridge".
      * Removed "pci_derive_parent", as it was incorrect and not needed.
      * Added functions to "struct pci_bus".  Every bus driver should
        implement these.  They are as follows:

int (*setup_windows) (struct pci_bus *bus);/* allocates resources */
int (*enable) (struct pci_bus *bus);/* enables the bridge */
int (*disable) (struct pci_bus *bus);/* disables the bridge */
int (*set_busnr) (struct pci_bus *bus);	/* records bus number config */

Diffstat:

 include/linux/pci.h                   |   35 -
 linux-pci/drivers/pci/Makefile        |    8
 linux-pci/drivers/pci/bus/Makefile    |    5
 linux-pci/drivers/pci/bus/bus-class.c |  208 +++++++
 linux-pci/drivers/pci/bus/bus-num.c   |   44 +
 linux-pci/drivers/pci/bus/bus-probe.c |  601 +++++++++++++++++++++
 linux-pci/drivers/pci/bus/bus-res.c   |    1
 linux-pci/drivers/pci/bus/p2p.c       |  134 ++++
 linux-pci/drivers/pci/bus/root.c      |    5
 linux-pci/drivers/pci/device.c        |  143 +++++
 linux-pci/drivers/pci/pci.h           |    4
 linux-pci/drivers/pci/probe.c         |  944 ----------------------------------
 linux-pci/drivers/pci/remove.c        |  126 ----
 13 files changed, 1177 insertions(+), 1081 deletions(-)


TODO:
     1. root bridge driver
     2. cardbus bridge driver (YENTA)
     3. update p2p bridge driver
     4. cleanup pci.h and export PCI bus class functions
     5. redesign resource management
     6. handle bus number assignment
     7. export more bus information to sysfs
     8. adapt the API for PCI hotplug
     9. fix "PCI_LEGACY"
    10. tune registration order for optimal resource assignment
    11. sanitize locking
    12. improve debugging

Patch:

diff -urN linux/drivers/pci/bus/bus-class.c linux-pci/drivers/pci/bus/bus-class.c
--- linux/drivers/pci/bus/bus-class.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/bus-class.c	2005-03-06 17:16:40.000000000 -0500
@@ -0,0 +1,208 @@
+/*
+ * bus-class.c - the core of the PCI bus class driver
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/module.h>
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
+ *	pci_register_buses - registers bus or cardbus pci devices
+ *	@bus: the bus
+ */
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
+/**
+ * 	pci_register_devices - registers normal pci devices
+ * 	@bus:	the bus
+ */
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
+
diff -urN linux/drivers/pci/bus/bus-num.c linux-pci/drivers/pci/bus/bus-num.c
--- linux/drivers/pci/bus/bus-num.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/bus-num.c	2005-03-07 16:15:18.000000000 -0500
@@ -0,0 +1,44 @@
+/*
+ * bus-num.c - helper functions for allocating PCI bus numbers
+ */
+
+#include <linux/pci.h>
+#include <linux/module.h>
+
+/**
+ * pci_register_bus_numbers - registers the current busnr config
+ * @bus: the bus
+ *
+ * Returns 0 if the configuration is conflict free, otherwise the it will
+ * fail and pci_assign_bus_numbers must be called.
+ */
+static int pci_register_bus_numbers(struct pci_bus *bus)
+{
+
+}
+
+/**
+ * pci_assign_bus_numbers - assigns bus numbers to a pci bridge
+ * @bus: the bus
+ */
+static int pci_assign_bus_numbers(struct pci_bus *bus)
+{
+
+}
+
+/**
+ * pci_setup_bus_numbers - configures the bus numbers of a pci bridge
+ * @bus: the bus
+ *
+ * It will first attempt to register the current configuration, if available.
+ * If there are conflicts or the first range is invalid, it will attempt to
+ * find a new range.
+ */
+int pci_setup_bus_numbers(struct pci_bus *bus)
+{
+	if (!pci_register_bus_numbers(bus))
+		return pci_assign_bus_numbers(bus);
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_setup_bus_numbers);
diff -urN linux/drivers/pci/bus/bus-probe.c linux-pci/drivers/pci/bus/bus-probe.c
--- linux/drivers/pci/bus/bus-probe.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/bus-probe.c	2005-03-07 16:12:48.000000000 -0500
@@ -0,0 +1,601 @@
+/*
+ * bus-probe.c - PCI device detection and setup code
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/cpumask.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+#define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
+#define CARDBUS_RESERVE_BUSNR	3
+#define PCI_CFG_SPACE_SIZE	256
+#define PCI_CFG_SPACE_EXP_SIZE	4096
+
+/* Ugh.  Need to stop exporting this to modules. */
+LIST_HEAD(pci_root_buses);
+EXPORT_SYMBOL(pci_root_buses);
+
+LIST_HEAD(pci_devices);
+
+
+/*
+ * resource parsing
+ */
+
+/**
+ * pci_calc_resource_flags - converts PCI resource flags to a general form
+ * @flags: a mask of pci resource flags
+ */
+static inline unsigned int pci_calc_resource_flags(unsigned int flags)
+{
+	if (flags & PCI_BASE_ADDRESS_SPACE_IO)
+		return IORESOURCE_IO;
+
+	if (flags & PCI_BASE_ADDRESS_MEM_PREFETCH)
+		return IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
+	return IORESOURCE_MEM;
+}
+
+/**
+ * pci_size - determines the length of a resource
+ */
+static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
+{
+	u32 size = mask & maxbase;	/* Find the significant bits */
+	if (!size)
+		return 0;
+
+	/* Get the lowest of them to find the decode size, and
+	   from that the extent.  */
+	size = (size & ~(size-1)) - 1;
+
+	/* base == maxbase can be valid only if the BAR has
+	   already been programmed with all 1s.  */
+	if (base == maxbase && ((base | size) & mask) != mask)
+		return 0;
+
+	return size;
+}
+
+/**
+ * pci_read_bases - read and store resource information for a device
+ * @dev:	the device
+ * @howmany:	number of bases
+ * @rom:	whether to scan the rom resource
+ */
+static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
+{
+	unsigned int pos, reg, next;
+	u32 l, sz;
+	struct resource *res;
+
+	for(pos=0; pos<howmany; pos = next) {
+		next = pos+1;
+		res = &dev->resource[pos];
+		res->name = pci_name(dev);
+		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
+		pci_read_config_dword(dev, reg, &l);
+		pci_write_config_dword(dev, reg, ~0);
+		pci_read_config_dword(dev, reg, &sz);
+		pci_write_config_dword(dev, reg, l);
+		if (!sz || sz == 0xffffffff)
+			continue;
+		if (l == 0xffffffff)
+			l = 0;
+		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
+			sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
+			if (!sz)
+				continue;
+			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
+			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
+		} else {
+			sz = pci_size(l, sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
+			if (!sz)
+				continue;
+			res->start = l & PCI_BASE_ADDRESS_IO_MASK;
+			res->flags |= l & ~PCI_BASE_ADDRESS_IO_MASK;
+		}
+		res->end = res->start + (unsigned long) sz;
+		res->flags |= pci_calc_resource_flags(l);
+		if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
+		    == (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+			pci_read_config_dword(dev, reg+4, &l);
+			next++;
+#if BITS_PER_LONG == 64
+			res->start |= ((unsigned long) l) << 32;
+			res->end = res->start + sz;
+			pci_write_config_dword(dev, reg+4, ~0);
+			pci_read_config_dword(dev, reg+4, &sz);
+			pci_write_config_dword(dev, reg+4, l);
+			sz = pci_size(l, sz, 0xffffffff);
+			if (sz) {
+				/* This BAR needs > 4GB?  Wow. */
+				res->end |= (unsigned long)sz<<32;
+			}
+#else
+			if (l) {
+				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));
+				res->start = 0;
+				res->flags = 0;
+				continue;
+			}
+#endif
+		}
+	}
+	if (rom) {
+		dev->rom_base_reg = rom;
+		res = &dev->resource[PCI_ROM_RESOURCE];
+		res->name = pci_name(dev);
+		pci_read_config_dword(dev, rom, &l);
+		pci_write_config_dword(dev, rom, ~PCI_ROM_ADDRESS_ENABLE);
+		pci_read_config_dword(dev, rom, &sz);
+		pci_write_config_dword(dev, rom, l);
+		if (l == 0xffffffff)
+			l = 0;
+		if (sz && sz != 0xffffffff) {
+			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
+			if (sz) {
+				res->flags = (l & IORESOURCE_ROM_ENABLE) |
+				  IORESOURCE_MEM | IORESOURCE_PREFETCH |
+				  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
+				res->start = l & PCI_ROM_ADDRESS_MASK;
+				res->end = res->start + (unsigned long) sz;
+			}
+		}
+	}
+}
+
+/**
+ * pci_read_bridge_bases - read and store resource information for a pci bus
+ * @child: the bus
+ */
+void pci_read_bridge_bases(struct pci_bus *child)
+{
+	struct pci_dev *dev = child->self;
+	u8 io_base_lo, io_limit_lo;
+	u16 mem_base_lo, mem_limit_lo;
+	unsigned long base, limit;
+	struct resource *res;
+	int i;
+
+	if (!dev)		/* It's a host bus, nothing to read */
+		return;
+
+	if (dev->transparent) {
+		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
+		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}
+
+	for(i=0; i<3; i++)
+		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+
+	res = child->resource[0];
+	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
+	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
+	base = (io_base_lo & PCI_IO_RANGE_MASK) << 8;
+	limit = (io_limit_lo & PCI_IO_RANGE_MASK) << 8;
+
+	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
+		u16 io_base_hi, io_limit_hi;
+		pci_read_config_word(dev, PCI_IO_BASE_UPPER16, &io_base_hi);
+		pci_read_config_word(dev, PCI_IO_LIMIT_UPPER16, &io_limit_hi);
+		base |= (io_base_hi << 16);
+		limit |= (io_limit_hi << 16);
+	}
+
+	if (base <= limit) {
+		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
+		res->start = base;
+		res->end = limit + 0xfff;
+	}
+
+	res = child->resource[1];
+	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
+	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
+	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
+	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
+	if (base <= limit) {
+		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
+		res->start = base;
+		res->end = limit + 0xfffff;
+	}
+
+	res = child->resource[2];
+	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
+	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
+	base = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
+	limit = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
+
+	if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
+		u32 mem_base_hi, mem_limit_hi;
+		pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &mem_base_hi);
+		pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32, &mem_limit_hi);
+
+		/*
+		 * Some bridges set the base > limit by default, and some
+		 * (broken) BIOSes do not initialize them.  If we find
+		 * this, just assume they are not being used.
+		 */
+		if (mem_base_hi <= mem_limit_hi) {
+#if BITS_PER_LONG == 64
+			base |= ((long) mem_base_hi) << 32;
+			limit |= ((long) mem_limit_hi) << 32;
+#else
+			if (mem_base_hi || mem_limit_hi) {
+				printk(KERN_ERR "PCI: Unable to handle 64-bit address space for bridge %s\n", pci_name(dev));
+				return;
+			}
+#endif
+		}
+	}
+	if (base <= limit) {
+		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
+		res->start = base;
+		res->end = limit + 0xfffff;
+	}
+}
+
+
+/*
+ * PCI device probing
+ */
+
+/**
+ * pci_release_dev - free a pci device structure when all users of it are finished.
+ * @dev: device that's been disconnected
+ *
+ * Will be called only by the device core when all users of this pci device are
+ * done.
+ */
+static void pci_release_dev(struct device *dev)
+{
+	struct pci_dev *pci_dev;
+
+	pci_dev = to_pci_dev(dev);
+
+	if (pci_dev->bridge_data)
+		kfree(pci_dev->bridge_data);
+
+	kfree(pci_dev);
+}
+
+/**
+ * pci_read_irq - determine the device's irq
+ * @dev: the device
+ *
+ * Reads interrupt line and base address registers.
+ * The architecture-dependent code can tweak these, of course.
+ */
+static void pci_read_irq(struct pci_dev *dev)
+{
+	unsigned char irq;
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
+	if (irq)
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	dev->irq = irq;
+}
+
+/**
+ * pci_cfg_space_size - get the configuration space size of the PCI device.
+ *
+ * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
+ * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
+ * access it.  Maybe we don't have a way to generate extended config space
+ * accesses, or the device is behind a reverse Express bridge.  So we try
+ * reading the dword at 0x100 which must either be 0 or a valid extended
+ * capability header.
+ */
+static int pci_cfg_space_size(struct pci_dev *dev)
+{
+	int pos;
+	u32 status;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!pos) {
+		pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+		if (!pos)
+			goto fail;
+
+		pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
+		if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
+			goto fail;
+	}
+
+	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
+		goto fail;
+	if (status == 0xffffffff)
+		goto fail;
+
+	return PCI_CFG_SPACE_EXP_SIZE;
+
+ fail:
+	return PCI_CFG_SPACE_SIZE;
+}
+
+/**
+ * pci_parse_bridge_data - fills in information specific to bridges
+ * @dev: the device
+ */
+static int pci_parse_bridge_data(struct pci_dev *dev)
+{
+	u32 buses;
+	u16 bctl;
+
+	struct pci_dev_bridge *bridge;
+
+	bridge = kmalloc(sizeof(struct pci_dev_bridge), GFP_KERNEL);
+	if (!bridge)
+		return -ENOMEM;
+	
+	memset(bridge, 0, sizeof(struct pci_dev_bridge));
+
+	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
+
+	bridge->primary = buses & 0xFF;
+	bridge->secondary = (buses >> 8) & 0xFF;
+	bridge->subordinate = (buses >> 16) & 0xFF;
+
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
+	
+	bridge->bridge_ctl = bctl;
+
+	dev->bridge_data = bridge;
+	return 0;
+}
+
+/**
+ * pci_setup_device - fill in class and map information of a device
+ * @dev: the device structure to fill
+ *
+ * Initialize the device structure with information about the device's 
+ * vendor,class,memory and IO-space addresses,IRQ lines etc.
+ * Called at initialization of the PCI subsystem and by CardBus services.
+ * Returns 0 on success and -1 if unknown type of device (not normal, bridge
+ * or CardBus).
+ */
+static int pci_setup_device(struct pci_dev * dev)
+{
+	u32 class;
+
+	dev->slot_name = dev->dev.bus_id;
+	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
+		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
+	class >>= 8;				    /* upper 3 bytes */
+	dev->class = class;
+	class >>= 8;
+
+	DBG("Found %02x:%02x [%04x/%04x] %06x %02x\n", dev->bus->number,
+	    dev->devfn, dev->vendor, dev->device, class, dev->hdr_type);
+
+	/* "Unknown power state" */
+	dev->current_state = 4;
+
+	/* Early fixups, before probing the BARs */
+	pci_fixup_device(pci_fixup_early, dev);
+	class = dev->class >> 8;
+
+	switch (dev->hdr_type) {		    /* header type */
+	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
+		if (class == PCI_CLASS_BRIDGE_PCI)
+			goto bad;
+		pci_read_irq(dev);
+		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
+		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
+		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+		break;
+
+	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
+		if (class != PCI_CLASS_BRIDGE_PCI)
+			goto bad;
+
+		if (pci_parse_bridge_data(dev)) {
+		/* The PCI-to-PCI bridge spec requires that subtractive
+		   decoding (i.e. transparent) bridge must have programming
+		   interface code of 0x01. */ 
+			dev->bridge_data->transparent = ((dev->class & 0xff) == 1);
+		}
+		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
+		break;
+
+	case PCI_HEADER_TYPE_CARDBUS:		    /* CardBus bridge header */
+		if (class != PCI_CLASS_BRIDGE_CARDBUS)
+			goto bad;
+		pci_parse_bridge_data(dev);
+		pci_read_irq(dev);
+		pci_read_bases(dev, 1, 0);
+		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
+		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_ID, &dev->subsystem_device);
+		break;
+
+	default:				    /* unknown header */
+		printk(KERN_ERR "PCI: device %s has unknown header type %02x, ignoring.\n",
+			pci_name(dev), dev->hdr_type);
+		return -1;
+
+	bad:
+		printk(KERN_ERR "PCI: %s: class %x doesn't match header type %02x. Ignoring class.\n",
+		       pci_name(dev), class, dev->hdr_type);
+		dev->class = PCI_CLASS_NOT_DEFINED;
+	}
+
+	/* We found a fine healthy device, go go go... */
+	return 0;
+}
+ 
+/*
+ * Read the config data for a PCI device, sanity-check it
+ * and fill in the dev structure...
+ */
+static struct pci_dev *
+pci_scan_device(struct pci_bus *bus, int devfn)
+{
+	struct pci_dev *dev;
+	u32 l;
+	u8 hdr_type;
+	int delay = 1;
+
+	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
+		return NULL;
+
+	/* some broken boards return 0 or ~0 if a slot is empty: */
+	if (l == 0xffffffff || l == 0x00000000 ||
+	    l == 0x0000ffff || l == 0xffff0000)
+		return NULL;
+
+	/* Configuration request Retry Status */
+	while (l == 0xffff0001) {
+		msleep(delay);
+		delay *= 2;
+		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
+			return NULL;
+		/* Card hasn't responded in 60 seconds?  Must be stuck. */
+		if (delay > 60 * 1000) {
+			printk(KERN_WARNING "Device %04x:%02x:%02x.%d not "
+					"responding\n", pci_domain_nr(bus),
+					bus->number, PCI_SLOT(devfn),
+					PCI_FUNC(devfn));
+			return NULL;
+		}
+	}
+
+	if (pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type))
+		return NULL;
+
+	dev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	memset(dev, 0, sizeof(struct pci_dev));
+	dev->bus = bus;
+	dev->sysdata = bus->sysdata;
+	dev->dev.parent = bus->bridge;
+	dev->dev.bus = &pci_bus_type;
+	dev->devfn = devfn;
+	dev->hdr_type = hdr_type & 0x7f;
+	dev->multifunction = !!(hdr_type & 0x80);
+	dev->vendor = l & 0xffff;
+	dev->device = (l >> 16) & 0xffff;
+	dev->cfg_size = pci_cfg_space_size(dev);
+
+	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
+	   set this higher, assuming the system even supports it.  */
+	dev->dma_mask = 0xffffffff;
+	if (pci_setup_device(dev) < 0) {
+		kfree(dev);
+		return NULL;
+	}
+	device_initialize(&dev->dev);
+	dev->dev.release = pci_release_dev;
+	pci_dev_get(dev);
+
+	pci_name_device(dev);
+
+	dev->dev.dma_mask = &dev->dma_mask;
+	dev->dev.coherent_dma_mask = 0xffffffffull;
+
+	return dev;
+}
+
+struct pci_dev * __devinit
+pci_scan_single_device(struct pci_bus *bus, int devfn)
+{
+	struct pci_dev *dev;
+
+	dev = pci_scan_device(bus, devfn);
+	pci_scan_msi_device(dev);
+
+	if (!dev)
+		return NULL;
+	
+	/* Fix up broken headers */
+	pci_fixup_device(pci_fixup_header, dev);
+
+	/*
+	 * Add the device to our list of discovered devices
+	 * and the bus list for fixup functions, etc.
+	 */
+	INIT_LIST_HEAD(&dev->global_list);
+	list_add_tail(&dev->bus_list, &bus->devices);
+
+	return dev;
+}
+
+/**
+ * pci_scan_slot - scan a PCI slot on a bus for devices.
+ * @bus: PCI bus to scan
+ * @devfn: slot number to scan (must have zero function.)
+ *
+ * Scan a PCI slot on the specified PCI bus for devices, adding
+ * discovered devices to the @bus->devices list.  New devices
+ * will have an empty dev->global_list head.
+ */
+int pci_scan_slot(struct pci_bus *bus, int devfn)
+{
+	int func, nr = 0;
+	int scan_all_fns;
+
+	scan_all_fns = pcibios_scan_all_fns(bus, devfn);
+
+	for (func = 0; func < 8; func++, devfn++) {
+		struct pci_dev *dev;
+
+		dev = pci_scan_single_device(bus, devfn);
+		if (dev) {
+			nr++;
+
+			/*
+		 	 * If this is a single function device,
+		 	 * don't scan past the first function.
+		 	 */
+			if (!dev->multifunction) {
+				if (func > 0) {
+					dev->multifunction = 1;
+				} else {
+ 					break;
+				}
+			}
+		} else {
+			if (func == 0 && !scan_all_fns)
+				break;
+		}
+	}
+	return nr;
+}
+
+
+/*
+ * PCI bus probing
+ */
+
+int pci_detect_children(struct pci_bus *bus)
+{
+	unsigned int devfn;
+
+	DBG("Scanning bus %02x\n", bus->number);
+
+	/* Go find them, Rover! */
+	for (devfn = 0; devfn < 0x100; devfn += 8)
+		pci_scan_slot(bus, devfn);
+
+	DBG("Fixups for bus %02x\n", bus->number);
+	pcibios_fixup_bus(bus);
+
+	return 0;
+}
diff -urN linux/drivers/pci/bus/bus-res.c linux-pci/drivers/pci/bus/bus-res.c
--- linux/drivers/pci/bus/bus-res.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/bus-res.c	2005-03-04 17:26:27.000000000 -0500
@@ -0,0 +1 @@
+
diff -urN linux/drivers/pci/bus/Makefile linux-pci/drivers/pci/bus/Makefile
--- linux/drivers/pci/bus/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/Makefile	2005-03-07 16:32:21.000000000 -0500
@@ -0,0 +1,5 @@
+#
+# Makefile for the PCI bus class
+#
+
+obj-y :=  bus-class.o bus-num.o bus-probe.o bus-res.o p2p.o root.o
diff -urN linux/drivers/pci/bus/p2p.c linux-pci/drivers/pci/bus/p2p.c
--- linux/drivers/pci/bus/p2p.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/p2p.c	2005-03-07 16:46:49.000000000 -0500
@@ -0,0 +1,134 @@
+/*
+ * p2p.c - a generic PCI bus driver for PCI<->PCI bridges
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
+
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
+	bus->parent = dev->bus;
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
diff -urN linux/drivers/pci/bus/root.c linux-pci/drivers/pci/bus/root.c
--- linux/drivers/pci/bus/root.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/bus/root.c	2005-03-06 17:06:56.000000000 -0500
@@ -0,0 +1,5 @@
+/*
+ * p2p.c - a PCI bus driver for root bridges
+ *
+ */
+  
diff -urN linux/drivers/pci/device.c linux-pci/drivers/pci/device.c
--- linux/drivers/pci/device.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-pci/drivers/pci/device.c	2005-03-04 17:26:30.000000000 -0500
@@ -0,0 +1,143 @@
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
+
diff -urN linux/drivers/pci/Makefile linux-pci/drivers/pci/Makefile
--- linux/drivers/pci/Makefile	2005-02-11 18:07:09.000000000 -0500
+++ linux-pci/drivers/pci/Makefile	2005-03-07 16:33:38.000000000 -0500
@@ -2,9 +2,8 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
-			names.o pci-driver.o search.o pci-sysfs.o \
-			rom.o
+obj-y		+= access.o bus.o bus-class.o device.o pci.o quirks.o \
+		   names.o pci-driver.o search.o pci-sysfs.o rom.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
@@ -16,6 +15,9 @@
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
+++ linux-pci/drivers/pci/pci.h	2005-03-04 17:26:30.000000000 -0500
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
+++ linux-pci/drivers/pci/probe.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,944 +0,0 @@
-/*
- * probe.c - PCI detection and setup code
- */
-
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/cpumask.h>
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
-#define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
-#define CARDBUS_RESERVE_BUSNR	3
-#define PCI_CFG_SPACE_SIZE	256
-#define PCI_CFG_SPACE_EXP_SIZE	4096
-
-/* Ugh.  Need to stop exporting this to modules. */
-LIST_HEAD(pci_root_buses);
-EXPORT_SYMBOL(pci_root_buses);
-
-LIST_HEAD(pci_devices);
-
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
-
-/*
- * PCI Bus Class
- */
-static void release_pcibus_dev(struct class_device *class_dev)
-{
-	struct pci_bus *pci_bus = to_pci_bus(class_dev);
-
-	if (pci_bus->bridge)
-		put_device(pci_bus->bridge);
-	kfree(pci_bus);
-}
-
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
- */
-static inline unsigned int pci_calc_resource_flags(unsigned int flags)
-{
-	if (flags & PCI_BASE_ADDRESS_SPACE_IO)
-		return IORESOURCE_IO;
-
-	if (flags & PCI_BASE_ADDRESS_MEM_PREFETCH)
-		return IORESOURCE_MEM | IORESOURCE_PREFETCH;
-
-	return IORESOURCE_MEM;
-}
-
-/*
- * Find the extent of a PCI decode..
- */
-static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
-{
-	u32 size = mask & maxbase;	/* Find the significant bits */
-	if (!size)
-		return 0;
-
-	/* Get the lowest of them to find the decode size, and
-	   from that the extent.  */
-	size = (size & ~(size-1)) - 1;
-
-	/* base == maxbase can be valid only if the BAR has
-	   already been programmed with all 1s.  */
-	if (base == maxbase && ((base | size) & mask) != mask)
-		return 0;
-
-	return size;
-}
-
-static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
-{
-	unsigned int pos, reg, next;
-	u32 l, sz;
-	struct resource *res;
-
-	for(pos=0; pos<howmany; pos = next) {
-		next = pos+1;
-		res = &dev->resource[pos];
-		res->name = pci_name(dev);
-		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-		pci_read_config_dword(dev, reg, &l);
-		pci_write_config_dword(dev, reg, ~0);
-		pci_read_config_dword(dev, reg, &sz);
-		pci_write_config_dword(dev, reg, l);
-		if (!sz || sz == 0xffffffff)
-			continue;
-		if (l == 0xffffffff)
-			l = 0;
-		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
-			sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
-			if (!sz)
-				continue;
-			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
-			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
-		} else {
-			sz = pci_size(l, sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
-			if (!sz)
-				continue;
-			res->start = l & PCI_BASE_ADDRESS_IO_MASK;
-			res->flags |= l & ~PCI_BASE_ADDRESS_IO_MASK;
-		}
-		res->end = res->start + (unsigned long) sz;
-		res->flags |= pci_calc_resource_flags(l);
-		if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
-		    == (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
-			pci_read_config_dword(dev, reg+4, &l);
-			next++;
-#if BITS_PER_LONG == 64
-			res->start |= ((unsigned long) l) << 32;
-			res->end = res->start + sz;
-			pci_write_config_dword(dev, reg+4, ~0);
-			pci_read_config_dword(dev, reg+4, &sz);
-			pci_write_config_dword(dev, reg+4, l);
-			sz = pci_size(l, sz, 0xffffffff);
-			if (sz) {
-				/* This BAR needs > 4GB?  Wow. */
-				res->end |= (unsigned long)sz<<32;
-			}
-#else
-			if (l) {
-				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));
-				res->start = 0;
-				res->flags = 0;
-				continue;
-			}
-#endif
-		}
-	}
-	if (rom) {
-		dev->rom_base_reg = rom;
-		res = &dev->resource[PCI_ROM_RESOURCE];
-		res->name = pci_name(dev);
-		pci_read_config_dword(dev, rom, &l);
-		pci_write_config_dword(dev, rom, ~PCI_ROM_ADDRESS_ENABLE);
-		pci_read_config_dword(dev, rom, &sz);
-		pci_write_config_dword(dev, rom, l);
-		if (l == 0xffffffff)
-			l = 0;
-		if (sz && sz != 0xffffffff) {
-			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
-			if (sz) {
-				res->flags = (l & IORESOURCE_ROM_ENABLE) |
-				  IORESOURCE_MEM | IORESOURCE_PREFETCH |
-				  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
-				res->start = l & PCI_ROM_ADDRESS_MASK;
-				res->end = res->start + (unsigned long) sz;
-			}
-		}
-	}
-}
-
-void __devinit pci_read_bridge_bases(struct pci_bus *child)
-{
-	struct pci_dev *dev = child->self;
-	u8 io_base_lo, io_limit_lo;
-	u16 mem_base_lo, mem_limit_lo;
-	unsigned long base, limit;
-	struct resource *res;
-	int i;
-
-	if (!dev)		/* It's a host bus, nothing to read */
-		return;
-
-	if (dev->transparent) {
-		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i];
-		return;
-	}
-
-	for(i=0; i<3; i++)
-		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
-
-	res = child->resource[0];
-	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
-	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
-	base = (io_base_lo & PCI_IO_RANGE_MASK) << 8;
-	limit = (io_limit_lo & PCI_IO_RANGE_MASK) << 8;
-
-	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
-		u16 io_base_hi, io_limit_hi;
-		pci_read_config_word(dev, PCI_IO_BASE_UPPER16, &io_base_hi);
-		pci_read_config_word(dev, PCI_IO_LIMIT_UPPER16, &io_limit_hi);
-		base |= (io_base_hi << 16);
-		limit |= (io_limit_hi << 16);
-	}
-
-	if (base <= limit) {
-		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
-		res->start = base;
-		res->end = limit + 0xfff;
-	}
-
-	res = child->resource[1];
-	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
-	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
-	if (base <= limit) {
-		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
-		res->start = base;
-		res->end = limit + 0xfffff;
-	}
-
-	res = child->resource[2];
-	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
-	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
-
-	if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
-		u32 mem_base_hi, mem_limit_hi;
-		pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &mem_base_hi);
-		pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32, &mem_limit_hi);
-
-		/*
-		 * Some bridges set the base > limit by default, and some
-		 * (broken) BIOSes do not initialize them.  If we find
-		 * this, just assume they are not being used.
-		 */
-		if (mem_base_hi <= mem_limit_hi) {
-#if BITS_PER_LONG == 64
-			base |= ((long) mem_base_hi) << 32;
-			limit |= ((long) mem_limit_hi) << 32;
-#else
-			if (mem_base_hi || mem_limit_hi) {
-				printk(KERN_ERR "PCI: Unable to handle 64-bit address space for bridge %s\n", pci_name(dev));
-				return;
-			}
-#endif
-		}
-	}
-	if (base <= limit) {
-		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
-		res->start = base;
-		res->end = limit + 0xfffff;
-	}
-}
-
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
-
-	return child;
-}
-
-struct pci_bus * __devinit pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr)
-{
-	struct pci_bus *child;
-
-	child = pci_alloc_child_bus(parent, dev, busnr);
-	if (child)
-		list_add_tail(&child->node, &parent->children);
-	return child;
-}
-
-static void pci_enable_crs(struct pci_dev *dev)
-{
-	u16 cap, rpctl;
-	int rpcap = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (!rpcap)
-		return;
-
-	pci_read_config_word(dev, rpcap + PCI_CAP_FLAGS, &cap);
-	if (((cap & PCI_EXP_FLAGS_TYPE) >> 4) != PCI_EXP_TYPE_ROOT_PORT)
-		return;
-
-	pci_read_config_word(dev, rpcap + PCI_EXP_RTCTL, &rpctl);
-	rpctl |= PCI_EXP_RTCTL_CRSSVE;
-	pci_write_config_word(dev, rpcap + PCI_EXP_RTCTL, rpctl);
-}
-
-unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus);
-
-/*
- * If it's a bridge, configure it and scan the bus behind it.
- * For CardBus bridges, we don't scan behind as the devices will
- * be handled by the bridge driver itself.
- *
- * We need to process bridges in two passes -- first we scan those
- * already configured by the BIOS and after we are done with all of
- * them, we proceed to assigning numbers to the remaining buses in
- * order to avoid overlaps between old and new bus numbers.
- */
-int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
-{
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
-
-		if (!is_cardbus) {
-			child->bridge_ctl = PCI_BRIDGE_CTL_NO_ISA;
-
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
-	}
-
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
-
-	sprintf(child->name, (is_cardbus ? "PCI CardBus #%02x" : "PCI Bus #%02x"), child->number);
-
-	return max;
-}
-
-/*
- * Read interrupt line and base address registers.
- * The architecture-dependent code can tweak these, of course.
- */
-static void pci_read_irq(struct pci_dev *dev)
-{
-	unsigned char irq;
-
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
-	if (irq)
-		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	dev->irq = irq;
-}
-
-/**
- * pci_setup_device - fill in class and map information of a device
- * @dev: the device structure to fill
- *
- * Initialize the device structure with information about the device's 
- * vendor,class,memory and IO-space addresses,IRQ lines etc.
- * Called at initialisation of the PCI subsystem and by CardBus services.
- * Returns 0 on success and -1 if unknown type of device (not normal, bridge
- * or CardBus).
- */
-static int pci_setup_device(struct pci_dev * dev)
-{
-	u32 class;
-
-	dev->slot_name = dev->dev.bus_id;
-	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
-		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
-	class >>= 8;				    /* upper 3 bytes */
-	dev->class = class;
-	class >>= 8;
-
-	DBG("Found %02x:%02x [%04x/%04x] %06x %02x\n", dev->bus->number,
-	    dev->devfn, dev->vendor, dev->device, class, dev->hdr_type);
-
-	/* "Unknown power state" */
-	dev->current_state = 4;
-
-	/* Early fixups, before probing the BARs */
-	pci_fixup_device(pci_fixup_early, dev);
-	class = dev->class >> 8;
-
-	switch (dev->hdr_type) {		    /* header type */
-	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
-		if (class == PCI_CLASS_BRIDGE_PCI)
-			goto bad;
-		pci_read_irq(dev);
-		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
-		break;
-
-	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
-		if (class != PCI_CLASS_BRIDGE_PCI)
-			goto bad;
-		/* The PCI-to-PCI bridge spec requires that subtractive
-		   decoding (i.e. transparent) bridge must have programming
-		   interface code of 0x01. */ 
-		dev->transparent = ((dev->class & 0xff) == 1);
-		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
-		break;
-
-	case PCI_HEADER_TYPE_CARDBUS:		    /* CardBus bridge header */
-		if (class != PCI_CLASS_BRIDGE_CARDBUS)
-			goto bad;
-		pci_read_irq(dev);
-		pci_read_bases(dev, 1, 0);
-		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
-		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_ID, &dev->subsystem_device);
-		break;
-
-	default:				    /* unknown header */
-		printk(KERN_ERR "PCI: device %s has unknown header type %02x, ignoring.\n",
-			pci_name(dev), dev->hdr_type);
-		return -1;
-
-	bad:
-		printk(KERN_ERR "PCI: %s: class %x doesn't match header type %02x. Ignoring class.\n",
-		       pci_name(dev), class, dev->hdr_type);
-		dev->class = PCI_CLASS_NOT_DEFINED;
-	}
-
-	/* We found a fine healthy device, go go go... */
-	return 0;
-}
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
-/*
- * Read the config data for a PCI device, sanity-check it
- * and fill in the dev structure...
- */
-static struct pci_dev * __devinit
-pci_scan_device(struct pci_bus *bus, int devfn)
-{
-	struct pci_dev *dev;
-	u32 l;
-	u8 hdr_type;
-	int delay = 1;
-
-	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
-		return NULL;
-
-	/* some broken boards return 0 or ~0 if a slot is empty: */
-	if (l == 0xffffffff || l == 0x00000000 ||
-	    l == 0x0000ffff || l == 0xffff0000)
-		return NULL;
-
-	/* Configuration request Retry Status */
-	while (l == 0xffff0001) {
-		msleep(delay);
-		delay *= 2;
-		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
-			return NULL;
-		/* Card hasn't responded in 60 seconds?  Must be stuck. */
-		if (delay > 60 * 1000) {
-			printk(KERN_WARNING "Device %04x:%02x:%02x.%d not "
-					"responding\n", pci_domain_nr(bus),
-					bus->number, PCI_SLOT(devfn),
-					PCI_FUNC(devfn));
-			return NULL;
-		}
-	}
-
-	if (pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type))
-		return NULL;
-
-	dev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
-
-	memset(dev, 0, sizeof(struct pci_dev));
-	dev->bus = bus;
-	dev->sysdata = bus->sysdata;
-	dev->dev.parent = bus->bridge;
-	dev->dev.bus = &pci_bus_type;
-	dev->devfn = devfn;
-	dev->hdr_type = hdr_type & 0x7f;
-	dev->multifunction = !!(hdr_type & 0x80);
-	dev->vendor = l & 0xffff;
-	dev->device = (l >> 16) & 0xffff;
-	dev->cfg_size = pci_cfg_space_size(dev);
-
-	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
-	   set this higher, assuming the system even supports it.  */
-	dev->dma_mask = 0xffffffff;
-	if (pci_setup_device(dev) < 0) {
-		kfree(dev);
-		return NULL;
-	}
-	device_initialize(&dev->dev);
-	dev->dev.release = pci_release_dev;
-	pci_dev_get(dev);
-
-	pci_name_device(dev);
-
-	dev->dev.dma_mask = &dev->dma_mask;
-	dev->dev.coherent_dma_mask = 0xffffffffull;
-
-	return dev;
-}
-
-struct pci_dev * __devinit
-pci_scan_single_device(struct pci_bus *bus, int devfn)
-{
-	struct pci_dev *dev;
-
-	dev = pci_scan_device(bus, devfn);
-	pci_scan_msi_device(dev);
-
-	if (!dev)
-		return NULL;
-	
-	/* Fix up broken headers */
-	pci_fixup_device(pci_fixup_header, dev);
-
-	/*
-	 * Add the device to our list of discovered devices
-	 * and the bus list for fixup functions, etc.
-	 */
-	INIT_LIST_HEAD(&dev->global_list);
-	list_add_tail(&dev->bus_list, &bus->devices);
-
-	return dev;
-}
-
-/**
- * pci_scan_slot - scan a PCI slot on a bus for devices.
- * @bus: PCI bus to scan
- * @devfn: slot number to scan (must have zero function.)
- *
- * Scan a PCI slot on the specified PCI bus for devices, adding
- * discovered devices to the @bus->devices list.  New devices
- * will have an empty dev->global_list head.
- */
-int __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
-{
-	int func, nr = 0;
-	int scan_all_fns;
-
-	scan_all_fns = pcibios_scan_all_fns(bus, devfn);
-
-	for (func = 0; func < 8; func++, devfn++) {
-		struct pci_dev *dev;
-
-		dev = pci_scan_single_device(bus, devfn);
-		if (dev) {
-			nr++;
-
-			/*
-		 	 * If this is a single function device,
-		 	 * don't scan past the first function.
-		 	 */
-			if (!dev->multifunction) {
-				if (func > 0) {
-					dev->multifunction = 1;
-				} else {
- 					break;
-				}
-			}
-		} else {
-			if (func == 0 && !scan_all_fns)
-				break;
-		}
-	}
-	return nr;
-}
-
-unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
-{
-	unsigned int devfn, pass, max = bus->secondary;
-	struct pci_dev *dev;
-
-	DBG("Scanning bus %02x\n", bus->number);
-
-	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 0x100; devfn += 8)
-		pci_scan_slot(bus, devfn);
-
-	/*
-	 * After performing arch-dependent fixup of the bus, look behind
-	 * all PCI-to-PCI bridges on this bus.
-	 */
-	DBG("Fixups for bus %02x\n", bus->number);
-	pcibios_fixup_bus(bus);
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
-
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
-}
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
--- linux/include/linux/pci.h	2005-02-11 18:07:29.000000000 -0500
+++ linux-pci/include/linux/pci.h	2005-03-07 16:39:58.000000000 -0500
@@ -502,6 +502,16 @@
 #define PCI_D3hot	((pci_power_t __force) 3)
 #define PCI_D3cold	((pci_power_t __force) 4)
 
+struct pci_dev_bridge {
+	unsigned char	primary;	/* number of primary bridge */
+	unsigned char	secondary;	/* number of secondary bridge */
+	unsigned char	subordinate;	/* max number of subordinate buses */
+	unsigned short	bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
+
+	unsigned int	transparent:1;	/* Transparent PCI bridge */
+	unsigned int	configured:1;	/* bridge configured (by BIOS or OS) */
+};
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -536,6 +546,9 @@
 
 	struct	device	dev;		/* Generic device interface */
 
+	/* optional capabilities */
+	struct pci_dev_bridge *bridge_data;
+
 	/* device is compatible with these IDs */
 	unsigned short vendor_compatible[DEVICE_COUNT_COMPATIBLE];
 	unsigned short device_compatible[DEVICE_COUNT_COMPATIBLE];
@@ -552,7 +565,6 @@
 	char *		slot_name;	/* pointer to dev.bus_id */
 
 	/* These fields are used by common fixups */
-	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */
 	/* keep track of device state */
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
@@ -605,24 +617,31 @@
 	void		*sysdata;	/* hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
 
-	unsigned char	number;		/* bus number */
-	unsigned char	primary;	/* number of primary bridge */
-	unsigned char	secondary;	/* number of secondary bridge */
-	unsigned char	subordinate;	/* max number of subordinate buses */
+	struct resource number;		/* secondary bus number */
+	struct resource busnr_range;	/* range from secondary to subordinate */
 
 	char		name[48];
 
-	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
-	unsigned short  pad2;
 	struct device		*bridge;
 	struct class_device	class_dev;
 	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
 	struct bin_attribute	*legacy_mem; /* legacy mem */
+
+	int (*setup_windows) (struct pci_bus *bus);	/* allocates resources */
+	int (*enable) (struct pci_bus *bus);		/* enables the bridge */
+	int (*disable) (struct pci_bus *bus);		/* disables the bridge */
+	int (*set_busnr) (struct pci_bus *bus);		/* records bus number config */
 };
 
 #define pci_bus_b(n)	list_entry(n, struct pci_bus, node)
 #define to_pci_bus(n)	container_of(n, struct pci_bus, class_dev)
 
+static inline unsigned char pci_bus_number(struct pci_bus *bus)
+{
+	return (unsigned char) bus->number.start;
+}
+
+
 /*
  * Error values that may be returned by PCI functions.
  */
@@ -968,7 +987,7 @@
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline int pci_name_bus(char *name, struct pci_bus *bus)
 {
-	sprintf(name, "%02x", bus->number);
+	sprintf(name, "%02x", pci_bus_number(bus));
 	return 0;
 }
 #endif


