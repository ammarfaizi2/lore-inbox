Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSHFVN4>; Tue, 6 Aug 2002 17:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSHFVN4>; Tue, 6 Aug 2002 17:13:56 -0400
Received: from [63.204.6.12] ([63.204.6.12]:44433 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S316213AbSHFVNu>;
	Tue, 6 Aug 2002 17:13:50 -0400
Date: Tue, 6 Aug 2002 17:16:30 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFC: PCI hotplug resource reservation
Message-ID: <Pine.LNX.4.33.0208061714560.16357-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been working for a while now on a CompactPCI driver that uses
the PCI hotplug infrastructure.  Based on some of the ideas/code from
what MontaVista released on SourceForge a while ago, as well as Greg's
skeleton PCI hotplug driver, I now have a reasonably functional core
cPCI driver API with a board-specific driver for the ZiaTech ZT5550.
However, in my quest to avoid duplicating the piles of resource
manipulation code in the Compaq and IBM hotplug drivers, and use the
PCI API in the fashion of the Cardbus driver, I've had to implement an
idea mentioned to me by David Woodhouse at OLS, namely boot-time PCI
resource reservation.  When I described the problem and my
implementation of the reservation idea on the pcihpd-discuss list,
Greg said:

> I don't really know of any other way to do this either.  For the current
> pci hotplug systems, the BIOS knows enough to reserve this information
> at boot time.  With cPCI, you don't have that ability, so it makes sense
> that you have to tell the kernel somehow.
>
> You might want to ask this question on LKML, where there are a lot of
> other PCI knowledgeable people.  They might be able to propose a
> "cleaner" solution.

So here I am.  Last week, I took the time to clean up my code for this
and strip it down to the bare essentials.  I'm attaching a patch below,
which implements a new kernel parameter, pci_hp_reserve, which is
specified as:

pci_hp_reserve=<bus>:<slot>,<io>,<mem>,<prefetch mem>

<bus>      - the PCI bus number of the bridge to the reservee bus
<slot>     - the PCI slot number of the bridge to the reservee bus
<io>       - the amount of I/O port space to reserve, in KiB
<mem>      - the amount of memory space to reserve, in MiB
<prefetch> - the amount of prefetchable memory space to reserve, in MiB

I've been using this for several weeks now, and it allows me to hot
insert new devices quite well.  However, my goal for my CompactPCI work
is to get it into the mainline kernel so people can add drivers for
other boards and chassis on top of it.  If this resource reservation
scheme is too distasteful, or there is indeed a "cleaner" way, I'd
really like comments or suggestions before I push on much further.

Thanks,

Scott



diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4.19/arch/i386/kernel/pci-pc.c linux-2.4.19-cpci/arch/i386/kernel/pci-pc.c
--- linux-2.4.19/arch/i386/kernel/pci-pc.c	Tue Aug  6 12:55:53 2002
+++ linux-2.4.19-cpci/arch/i386/kernel/pci-pc.c	Tue Aug  6 14:17:19 2002
@@ -1273,6 +1273,9 @@
 	pci_read_bridge_bases(b);
 }

+void __init pcibios_fixup_pbus_ranges(struct pci_bus *bus, struct pbus_set_ranges_data *ranges)
+{
+}

 void __devinit pcibios_config_init(void)
 {
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4.19/drivers/pci/Makefile linux-2.4.19-cpci/drivers/pci/Makefile
--- linux-2.4.19/drivers/pci/Makefile	Tue Aug  6 12:56:05 2002
+++ linux-2.4.19-cpci/drivers/pci/Makefile	Tue Aug  6 14:17:23 2002
@@ -15,6 +15,7 @@

 obj-$(CONFIG_PCI) += pci.o quirks.o compat.o names.o
 obj-$(CONFIG_PROC_FS) += proc.o
+obj-$(CONFIG_HOTPLUG_PCI) += setup-hp.o setup-bus.o

 ifndef CONFIG_SPARC64
 obj-$(CONFIG_PCI) += setup-res.o
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4.19/drivers/pci/pci.c linux-2.4.19-cpci/drivers/pci/pci.c
--- linux-2.4.19/drivers/pci/pci.c	Tue Aug  6 12:56:05 2002
+++ linux-2.4.19-cpci/drivers/pci/pci.c	Tue Aug  6 14:17:26 2002
@@ -724,7 +724,7 @@
 	pci_announce_device_to_drivers(dev);
 }

-static void
+void
 pci_free_resources(struct pci_dev *dev)
 {
 	int i;
@@ -2031,6 +2031,10 @@
 	struct pci_dev *dev;

 	pcibios_init();
+
+#ifdef CONFIG_HOTPLUG_PCI
+	pci_hp_reserve_resources();
+#endif

 	pci_for_each_dev(dev) {
 		pci_fixup_device(PCI_FIXUP_FINAL, dev);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4.19/drivers/pci/setup-bus.c linux-2.4.19-cpci/drivers/pci/setup-bus.c
--- linux-2.4.19/drivers/pci/setup-bus.c	Tue Aug  6 12:56:05 2002
+++ linux-2.4.19-cpci/drivers/pci/setup-bus.c	Tue Aug  6 14:17:29 2002
@@ -121,7 +121,7 @@
 }

 /* Initialize bridges with base/limit values we have collected */
-static void __init
+void __devinit
 pci_setup_bridge(struct pci_bus *bus)
 {
 	struct pbus_set_ranges_data ranges;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4.19/drivers/pci/setup-hp.c linux-2.4.19-cpci/drivers/pci/setup-hp.c
--- linux-2.4.19/drivers/pci/setup-hp.c	Wed Dec 31 19:00:00 1969
+++ linux-2.4.19-cpci/drivers/pci/setup-hp.c	Tue Aug  6 14:17:44 2002
@@ -0,0 +1,255 @@
+/*
+ *	drivers/pci/setup-hp.c
+ *
+ * Support routines for reserving resources for PCI hotplug.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/cache.h>
+#include <linux/slab.h>
+
+#define DEBUG_CONFIG 0
+#if DEBUG_CONFIG
+# define DBGC(args)     printk args
+#else
+# define DBGC(args)
+#endif
+
+/* Resource reservation limits in KiB, MiB, and MiB, respectively */
+#define IO_RESERVE_LIMIT	8UL
+#define MEM_RESERVE_LIMIT	64UL
+#define PFMEM_RESERVE_LIMIT	64UL
+
+struct pci_reservation {
+	unsigned int  used;
+	unsigned char busnr;
+	unsigned int  devfn;
+	unsigned long reserve[3];
+};
+#define MAX_BUS_RESERVATIONS 4
+static struct pci_reservation __initdata pci_reservations[MAX_BUS_RESERVATIONS];
+
+int __init pci_write_bridge_bases(struct pci_bus* bus)
+{
+	int i;
+	int rc;
+	struct pci_dev* dev = bus->self;
+
+	pci_free_resources(dev);
+	for(i = 0; i < 3; i++) {
+		if(pci_resource_len(dev, PCI_BRIDGE_RESOURCES + i)) {
+			rc = pci_assign_resource(dev, PCI_BRIDGE_RESOURCES + i);
+			if(rc) {
+				printk(KERN_ERR "PCI: Could not reassign resource %d of bus %02x\n",
+				       i, bus->number);
+				return rc;
+			}
+		}
+	}
+
+	pci_setup_bridge(bus);
+	return 0;
+}
+
+static int __init pci_reassign_resources(struct pci_dev* dev)
+{
+	int i;
+	int rc;
+
+	pci_free_resources(dev);
+	if(dev->hdr_type & PCI_HEADER_TYPE_BRIDGE) {
+		struct pci_bus* bus = dev->subordinate;
+		struct list_head* ln;
+		struct resource* r;
+		struct resource* dr;
+		struct resource* parent;
+		unsigned long size;
+
+		for(i = 0; i < 3; i++) {
+			dr = &dev->resource[PCI_BRIDGE_RESOURCES + i];
+			DBGC(("%s - device resource %d start=0x%08lx, end=0x%08lx\n",
+			      __FUNCTION__, PCI_BRIDGE_RESOURCES + i, dr->start, dr->end));
+
+			r = bus->resource[i];
+			if(r && dr->start < dr->end) {
+				parent = dev->bus->resource[i];
+				DBGC(("%s - parent resource %d start=0x%08lx, end=0x%08lx\n",
+				      __FUNCTION__, i, parent->start, parent->end));
+				DBGC(("%s - resource %d start=0x%08lx, end=0x%08lx\n",
+				      __FUNCTION__, i, r->start, r->end));
+				size = r->end - r->start;
+				if(size) {
+					r->start = parent->start + (r->start - parent->start);
+					r->end = r->start + size;
+					DBGC(("%s - resource %d new start=0x%08lx, end=0x%08lx\n",
+					       __FUNCTION__, i, r->start, r->end));
+				}
+			}
+			else {
+				dr->start = dr->end = 0;
+				bus->resource[i] = dr;
+			}
+		}
+
+		rc = pci_write_bridge_bases(bus);
+		if(rc) {
+			printk(KERN_ERR "PCI: Could not write bus %02x bases\n",
+			       bus->number);
+			return rc;
+		}
+
+		list_for_each(ln, &bus->devices) {
+			rc = pci_reassign_resources(pci_dev_b(ln));
+			if(rc) {
+				return rc;
+			}
+		}
+	}
+
+	for(i = 0; i < 6; i++) {
+		if(!pci_resource_start(dev, i))
+			continue;
+		rc = pci_assign_resource(dev, i);
+		if(rc) {
+			printk(KERN_ERR "PCI: Could not reassign resource %d of device %02x:%02x\n",
+			       i, dev->bus->number, PCI_SLOT(dev->devfn));
+			return rc;
+		}
+	}
+	return 0;
+}
+
+void __init pci_hp_reserve_resources(void)
+{
+	int i, j;
+	struct pci_bus* bus;
+	struct pci_dev* dev;
+	struct resource* r;
+	struct list_head* ln;
+	unsigned long size;
+	unsigned long units[3] = { 1024UL, 1048576UL, 1048576UL };
+	unsigned long flags[3] = \
+		{ IORESOURCE_IO, IORESOURCE_MEM, IORESOURCE_MEM | IORESOURCE_PREFETCH };
+
+	for(i = 0; i < MAX_BUS_RESERVATIONS && pci_reservations[i].used; i++) {
+		dev = pci_find_slot(pci_reservations[i].busnr, pci_reservations[i].devfn);
+		if(!dev) {
+			printk(KERN_ERR "PCI: Device %02x:%02x.%x does not exist\n",
+			       pci_reservations[i].busnr,
+			       PCI_SLOT(pci_reservations[i].devfn),
+			       PCI_FUNC(pci_reservations[i].devfn));
+			continue;
+		}
+		bus = dev->subordinate;
+		if(!bus) {
+			printk(KERN_ERR "PCI: Device %02x:%02x.%x is not a bridge\n",
+			       pci_reservations[i].busnr,
+			       PCI_SLOT(pci_reservations[i].devfn),
+			       PCI_FUNC(pci_reservations[i].devfn));
+			continue;
+		}
+
+		for(j = 0; j < 3; j++) {
+			if(!pci_reservations[i].reserve[j])
+				continue;
+			r = &dev->resource[PCI_BRIDGE_RESOURCES + j];
+			size = pci_reservations[i].reserve[j] * units[j] - 1;
+			if(r->end - r->start > size) {
+				printk(KERN_WARNING \
+				       "PCI: bridge %02x:%02x.%x resource %d is already larger than 0x%08lx\n",
+				       pci_reservations[i].busnr,
+				       PCI_SLOT(pci_reservations[i].devfn),
+				       PCI_FUNC(pci_reservations[i].devfn),
+				       j,
+				       size);
+				continue;
+			}
+			r->start = 0;
+			r->end = size;
+			r->flags |= flags[j];
+			if(!r->name) {
+				r->name = bus->name;
+			}
+			bus->resource[j] = r;
+			DBGC(("%s - resource %d new start=0x%04lx, end=0x%04lx\n",
+			      __FUNCTION__ , j, r->start, r->end));
+		}
+
+		if(pci_write_bridge_bases(bus)) {
+			printk(KERN_ERR "PCI: Could not write bridge %02x:%02x.%x bases\n",
+			       pci_reservations[i].busnr,
+			       PCI_SLOT(pci_reservations[i].devfn),
+			       PCI_FUNC(pci_reservations[i].devfn));
+			continue;
+		}
+
+		list_for_each(ln, &bus->devices) {
+			pci_reassign_resources(pci_dev_b(ln));
+		}
+	}
+}
+
+static int __init pci_hp_reserve_setup(char* str)
+{
+	int r, i;
+	unsigned long busnr, n;
+	unsigned int slot;
+	unsigned long limits[3] = \
+		{ IO_RESERVE_LIMIT, MEM_RESERVE_LIMIT, PFMEM_RESERVE_LIMIT };
+	char* p;
+
+	for(r = 0; r < MAX_BUS_RESERVATIONS && pci_reservations[r].used; r++);
+	if(r == MAX_BUS_RESERVATIONS) {
+		printk(KERN_ERR "PCI: Ignoring resource reservation, only %d allowed\n",
+		       MAX_BUS_RESERVATIONS);
+		return 1;
+	}
+
+	if (!(*str && (p = strchr(str, ','))))
+		return 1;
+	busnr = simple_strtoul(str, &p, 16);
+	if(p == str || busnr > 0xff) {
+		printk(KERN_ERR "PCI: Invalid reservation device bus number\n");
+		return 1;
+	}
+	if(*p != ':') {
+		printk(KERN_ERR "PCI: Invalid reservation device name\n");
+		return 1;
+	}
+	str = p + 1;
+	slot = simple_strtoul(str, &p, 16);
+	if(p == str || (busnr && slot) || slot > 0x1f) {
+		printk(KERN_ERR "PCI: Invalid reservation device slot number\n");
+		return 1;
+	}
+
+	str = p + 1;
+	for(i = 0; i < 3; i++) {
+		if (!(*str && *p == ','))
+			return 1;
+		n = simple_strtoul(str, &p, 10);
+		if(n > limits[i]) {
+			printk(KERN_ERR "PCI: Invalid reservation resource size\n");
+			return 1;
+		}
+		pci_reservations[r].reserve[i] = n;
+		str = p + 1;
+	}
+
+	/* Only complete the reservation if there is a non-zero resource */
+	for(i = 0; i < 3 && !pci_reservations[r].reserve[i]; i++);
+	if(i == 3) {
+		printk(KERN_ERR "PCI: Ignoring empty reservation\n");
+		return 1;
+	}
+	pci_reservations[r].used = 1;
+	pci_reservations[r].busnr = busnr;
+	pci_reservations[r].devfn = PCI_DEVFN(slot, 0);
+	return 0;
+}
+
+__setup("pci_hp_reserve=", pci_hp_reserve_setup);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4.19/include/linux/pci.h linux-2.4.19-cpci/include/linux/pci.h
--- linux-2.4.19/include/linux/pci.h	Tue Aug  6 12:56:15 2002
+++ linux-2.4.19-cpci/include/linux/pci.h	Tue Aug  6 14:17:31 2002
@@ -536,10 +536,15 @@
 int pci_proc_detach_bus(struct pci_bus *bus);
 void pci_name_device(struct pci_dev *dev);
 char *pci_class_name(u32 class);
+void pci_setup_bridge(struct pci_bus *bus);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev, struct resource *res);
 int pci_setup_device(struct pci_dev *dev);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
+void pci_free_resources(struct pci_dev *dev);
+#ifdef CONFIG_HOTPLUG_PCI
+void pci_hp_reserve_resources(void);
+#endif

 /* Generic PCI functions exported to card drivers */



-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com




