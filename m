Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUKHQEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUKHQEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUKHQEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:04:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5059 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261867AbUKHOfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:10 -0500
Date: Mon, 8 Nov 2004 14:34:18 GMT
Message-Id: <200411081434.iA8EYIZY023556@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 10/20] FRV: Fujitsu FR-V CPU arch implementation part 8
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 8 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_8-2610rc1mm3.diff
 Makefile  |    5 
 pci-dma.c |  124 ++++++++++++++++
 pci-frv.c |  363 ++++++++++++++++++++++++++++++++++++++++++++++++
 pci-frv.h |   47 ++++++
 pci-irq.c |   70 +++++++++
 pci-vdk.c |  462 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1071 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/Makefile linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/Makefile	2004-11-05 14:13:03.327544420 +0000
@@ -0,0 +1,5 @@
+#
+# Makefile for the MB93090-MB00 motherboard stuff
+#
+
+obj-$(CONFIG_PCI) := pci-frv.o pci-dma.o pci-irq.o pci-vdk.o
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-dma.c linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-dma.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-dma.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-dma.c	2004-11-05 14:13:03.331544082 +0000
@@ -0,0 +1,124 @@
+/*
+ * Dynamic DMA mapping support.
+ *
+ * On i386 there is no hardware dynamic DMA address translation,
+ * so consistent alloc/free are merely page allocation/freeing.
+ * The rest of the dynamic DMA mapping interface is implemented
+ * in asm/pci.h.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_MMU
+
+void *dma_alloc_coherent(struct device *hwdev, size_t size, dma_addr_t *dma_handle, int gfp)
+{
+	void *ret;
+
+	ret = consistent_alloc(gfp, size, dma_handle);
+	if (ret)
+		memset(ret, 0, size);
+
+	return ret;
+}
+
+void dma_free_coherent(struct device *hwdev, size_t size, void *vaddr, dma_addr_t dma_handle)
+{
+	consistent_free(vaddr);
+}
+
+
+#else /* CONFIG_MMU */
+
+#if 1
+#define DMA_SRAM_START	dma_coherent_mem_start
+#define DMA_SRAM_END	dma_coherent_mem_end
+#else // Use video RAM on Matrox
+#define DMA_SRAM_START	0xe8900000
+#define DMA_SRAM_END	0xe8a00000
+#endif
+
+struct dma_alloc_record {
+	struct list_head	list;
+	unsigned long		ofs;
+	unsigned long		len;
+};
+
+static spinlock_t dma_alloc_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(dma_alloc_list);
+
+void *dma_alloc_coherent(struct device *hwdev, size_t size, dma_addr_t *dma_handle, int gfp)
+{
+	struct dma_alloc_record *new;
+	struct list_head *this = &dma_alloc_list;
+	unsigned long flags;
+	unsigned long start = DMA_SRAM_START;
+	unsigned long end;
+
+	if (!DMA_SRAM_START) {
+		printk("%s called without any DMA area reserved!\n", __func__);
+		return NULL;
+	}
+
+	new = kmalloc(sizeof (*new), GFP_ATOMIC);
+	if (!new)
+		return NULL;
+
+	/* Round up to a reasonable alignment */
+	new->len = (size + 31) & ~31;
+
+	spin_lock_irqsave(&dma_alloc_lock, flags);
+	
+	list_for_each (this, &dma_alloc_list) {
+		struct dma_alloc_record *this_r = list_entry(this, struct dma_alloc_record, list);
+		end = this_r->ofs;
+
+		if (end - start >= size)
+			goto gotone;
+
+		start = this_r->ofs + this_r->len;
+	}
+	/* Reached end of list. */
+	end = DMA_SRAM_END;
+	this = &dma_alloc_list;
+
+	if (end - start >= size) {
+	gotone:
+		new->ofs = start;
+		list_add_tail(&new->list, this);
+		spin_unlock_irqrestore(&dma_alloc_lock, flags);
+
+		*dma_handle = start;
+		return (void *)start;
+	}
+
+	kfree(new);
+	spin_unlock_irqrestore(&dma_alloc_lock, flags);
+	return NULL;
+}
+
+void dma_free_coherent(struct device *hwdev, size_t size, void *vaddr, dma_addr_t dma_handle)
+{
+	struct dma_alloc_record *rec;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dma_alloc_lock, flags);
+
+	list_for_each_entry(rec, &dma_alloc_list, list) {
+		if (rec->ofs == dma_handle) {
+			list_del(&rec->list);
+			kfree(rec);
+			spin_unlock_irqrestore(&dma_alloc_lock, flags);
+			return;
+		}
+	}
+	spin_unlock_irqrestore(&dma_alloc_lock, flags);
+	BUG();
+}
+
+#endif /* CONFIG_MMU */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-frv.c linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-frv.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-frv.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-frv.c	2004-11-05 14:13:03.337543575 +0000
@@ -0,0 +1,363 @@
+/*
+ *	Low-Level PCI Access for FRV machines
+ *
+ * Copyright 1993, 1994 Drew Eckhardt
+ *      Visionary Computing
+ *      (Unix and Linux consulting and custom programming)
+ *      Drew@Colorado.EDU
+ *      +1 (303) 786-7975
+ *
+ * Drew's work was sponsored by:
+ *	iX Multiuser Multitasking Magazine
+ *	Hannover, Germany
+ *	hm@ix.de
+ *
+ * Copyright 1997--2000 Martin Mares <mj@ucw.cz>
+ *
+ * For more information, please consult the following manuals (look at
+ * http://www.pcisig.com/ for how to get them):
+ *
+ * PCI BIOS Specification
+ * PCI Local Bus Specification
+ * PCI to PCI Bridge Specification
+ * PCI System Design Guide
+ *
+ *
+ * CHANGELOG :
+ * Jun 17, 1994 : Modified to accommodate the broken pre-PCI BIOS SPECIFICATION
+ *	Revision 2.0 present on <thys@dennis.ee.up.ac.za>'s ASUS mainboard.
+ *
+ * Jan 5,  1995 : Modified to probe PCI hardware at boot time by Frederic
+ *     Potter, potter@cao-vlsi.ibp.fr
+ *
+ * Jan 10, 1995 : Modified to store the information about configured pci
+ *      devices into a list, which can be accessed via /proc/pci by
+ *      Curtis Varner, cvarner@cs.ucr.edu
+ *
+ * Jan 12, 1995 : CPU-PCI bridge optimization support by Frederic Potter.
+ *	Alpha version. Intel & UMC chipset support only.
+ *
+ * Apr 16, 1995 : Source merge with the DEC Alpha PCI support. Most of the code
+ *	moved to drivers/pci/pci.c.
+ *
+ * Dec 7, 1996  : Added support for direct configuration access of boards
+ *      with Intel compatible access schemes (tsbogend@alpha.franken.de)
+ *
+ * Feb 3, 1997  : Set internal functions to static, save/restore flags
+ *	avoid dead locks reading broken PCI BIOS, werner@suse.de 
+ *
+ * Apr 26, 1997 : Fixed case when there is BIOS32, but not PCI BIOS
+ *	(mj@atrey.karlin.mff.cuni.cz)
+ *
+ * May 7,  1997 : Added some missing cli()'s. [mj]
+ * 
+ * Jun 20, 1997 : Corrected problems in "conf1" type accesses.
+ *      (paubert@iram.es)
+ *
+ * Aug 2,  1997 : Split to PCI BIOS handling and direct PCI access parts
+ *	and cleaned it up...     Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+ *
+ * Feb 6,  1998 : No longer using BIOS to find devices and device classes. [mj]
+ *
+ * May 1,  1998 : Support for peer host bridges. [mj]
+ *
+ * Jun 19, 1998 : Changed to use spinlocks, so that PCI configuration space
+ *	can be accessed from interrupts even on SMP systems. [mj]
+ *
+ * August  1998 : Better support for peer host bridges and more paranoid
+ *	checks for direct hardware access. Ugh, this file starts to look as
+ *	a large gallery of common hardware bug workarounds (watch the comments)
+ *	-- the PCI specs themselves are sane, but most implementors should be
+ *	hit hard with \hammer scaled \magstep5. [mj]
+ *
+ * Jan 23, 1999 : More improvements to peer host bridge logic. i450NX fixup. [mj]
+ *
+ * Feb 8,  1999 : Added UM8886BF I/O address fixup. [mj]
+ *
+ * August  1999 : New resource management and configuration access stuff. [mj]
+ *
+ * Sep 19, 1999 : Use PCI IRQ routing tables for detection of peer host bridges.
+ *		  Based on ideas by Chris Frantz and David Hinds. [mj]
+ *
+ * Sep 28, 1999 : Handle unreported/unassigned IRQs. Thanks to Shuu Yamaguchi
+ *		  for a lot of patience during testing. [mj]
+ *
+ * Oct  8, 1999 : Split to pci-i386.c, pci-pc.c and pci-visws.c. [mj]
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+
+#include "pci-frv.h"
+
+#if 0
+void
+pcibios_update_resource(struct pci_dev *dev, struct resource *root,
+			struct resource *res, int resource)
+{
+	u32 new, check;
+	int reg;
+
+	new = res->start | (res->flags & PCI_REGION_FLAG_MASK);
+	if (resource < 6) {
+		reg = PCI_BASE_ADDRESS_0 + 4*resource;
+	} else if (resource == PCI_ROM_RESOURCE) {
+		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		new |= PCI_ROM_ADDRESS_ENABLE;
+		reg = dev->rom_base_reg;
+	} else {
+		/* Somebody might have asked allocation of a non-standard resource */
+		return;
+	}
+	
+	pci_write_config_dword(dev, reg, new);
+	pci_read_config_dword(dev, reg, &check);
+	if ((new ^ check) & ((new & PCI_BASE_ADDRESS_SPACE_IO) ? PCI_BASE_ADDRESS_IO_MASK : PCI_BASE_ADDRESS_MEM_MASK)) {
+		printk(KERN_ERR "PCI: Error while updating region "
+		       "%s/%d (%08x != %08x)\n", dev->slot_name, resource,
+		       new, check);
+	}
+}
+#endif
+
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ *
+ * Why? Because some silly external IO cards only decode
+ * the low 10 bits of the IO address. The 0x00-0xff region
+ * is reserved for motherboard devices that decode all 16
+ * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
+ * but we want to try to avoid allocating at 0x2900-0x2bff
+ * which might have be mirrored at 0x0100-0x03ff..
+ */
+void
+pcibios_align_resource(void *data, struct resource *res,
+		       unsigned long size, unsigned long align)
+{
+	if (res->flags & IORESOURCE_IO) {
+		unsigned long start = res->start;
+
+		if (start & 0x300) {
+			start = (start + 0x3ff) & ~0x3ff;
+			res->start = start;
+		}
+	}
+}
+
+
+/*
+ *  Handle resources of PCI devices.  If the world were perfect, we could
+ *  just allocate all the resource regions and do nothing more.  It isn't.
+ *  On the other hand, we cannot just re-allocate all devices, as it would
+ *  require us to know lots of host bridge internals.  So we attempt to
+ *  keep as much of the original configuration as possible, but tweak it
+ *  when it's found to be wrong.
+ *
+ *  Known BIOS problems we have to work around:
+ *	- I/O or memory regions not configured
+ *	- regions configured, but not enabled in the command register
+ *	- bogus I/O addresses above 64K used
+ *	- expansion ROMs left enabled (this may sound harmless, but given
+ *	  the fact the PCI specs explicitly allow address decoders to be
+ *	  shared between expansion ROMs and other resource regions, it's
+ *	  at least dangerous)
+ *
+ *  Our solution:
+ *	(1) Allocate resources for all buses behind PCI-to-PCI bridges.
+ *	    This gives us fixed barriers on where we can allocate.
+ *	(2) Allocate resources for all enabled devices.  If there is
+ *	    a collision, just mark the resource as unallocated. Also
+ *	    disable expansion ROMs during this step.
+ *	(3) Try to allocate resources for disabled devices.  If the
+ *	    resources were assigned correctly, everything goes well,
+ *	    if they weren't, they won't disturb allocation of other
+ *	    resources.
+ *	(4) Assign new addresses to resources which were either
+ *	    not configured at all or misconfigured.  If explicitly
+ *	    requested by the user, configure expansion ROM address
+ *	    as well.
+ */
+
+static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+{
+	struct list_head *ln;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+	int idx;
+	struct resource *r, *pr;
+
+	/* Depth-First Search on bus tree */
+	for (ln=bus_list->next; ln != bus_list; ln=ln->next) {
+		bus = pci_bus_b(ln);
+		if ((dev = bus->self)) {
+			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
+				r = &dev->resource[idx];
+				if (!r->start)
+					continue;
+				pr = pci_find_parent_resource(dev, r);
+				if (!pr || request_resource(pr, r) < 0)
+					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, dev->slot_name);
+			}
+		}
+		pcibios_allocate_bus_resources(&bus->children);
+	}
+}
+
+static void __init pcibios_allocate_resources(int pass)
+{
+	struct pci_dev *dev = NULL;
+	int idx, disabled;
+	u16 command;
+	struct resource *r, *pr;
+
+	while (dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev),
+	       dev != NULL
+	       ) {
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		for(idx = 0; idx < 6; idx++) {
+			r = &dev->resource[idx];
+			if (r->parent)		/* Already allocated */
+				continue;
+			if (!r->start)		/* Address not assigned at all */
+				continue;
+			if (r->flags & IORESOURCE_IO)
+				disabled = !(command & PCI_COMMAND_IO);
+			else
+				disabled = !(command & PCI_COMMAND_MEMORY);
+			if (pass == disabled) {
+				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
+				    r->start, r->end, r->flags, disabled, pass);
+				pr = pci_find_parent_resource(dev, r);
+				if (!pr || request_resource(pr, r) < 0) {
+					printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, pci_name(dev));
+					/* We'll assign a new address later */
+					r->end -= r->start;
+					r->start = 0;
+				}
+			}
+		}
+		if (!pass) {
+			r = &dev->resource[PCI_ROM_RESOURCE];
+			if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+				/* Turn the ROM off, leave the resource region, but keep it unregistered. */
+				u32 reg;
+				DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
+				r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
+				pci_read_config_dword(dev, dev->rom_base_reg, &reg);
+				pci_write_config_dword(dev, dev->rom_base_reg, reg & ~PCI_ROM_ADDRESS_ENABLE);
+			}
+		}
+	}
+}
+
+static void __init pcibios_assign_resources(void)
+{
+	struct pci_dev *dev = NULL;
+	int idx;
+	struct resource *r;
+
+	while (dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev),
+	       dev != NULL
+	       ) {
+		int class = dev->class >> 8;
+
+		/* Don't touch classless devices and host bridges */
+		if (!class || class == PCI_CLASS_BRIDGE_HOST)
+			continue;
+
+		for(idx=0; idx<6; idx++) {
+			r = &dev->resource[idx];
+
+			/*
+			 *  Don't touch IDE controllers and I/O ports of video cards!
+			 */
+			if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) ||
+			    (class == PCI_CLASS_DISPLAY_VGA && (r->flags & IORESOURCE_IO)))
+				continue;
+
+			/*
+			 *  We shall assign a new address to this resource, either because
+			 *  the BIOS forgot to do so or because we have decided the old
+			 *  address was unusable for some reason.
+			 */
+			if (!r->start && r->end)
+				pci_assign_resource(dev, idx);
+		}
+
+		if (pci_probe & PCI_ASSIGN_ROMS) {
+			r = &dev->resource[PCI_ROM_RESOURCE];
+			r->end -= r->start;
+			r->start = 0;
+			if (r->end)
+				pci_assign_resource(dev, PCI_ROM_RESOURCE);
+		}
+	}
+}
+
+void __init pcibios_resource_survey(void)
+{
+	DBG("PCI: Allocating resources\n");
+	pcibios_allocate_bus_resources(&pci_root_buses);
+	pcibios_allocate_resources(0);
+	pcibios_allocate_resources(1);
+	pcibios_assign_resources();
+}
+
+int pcibios_enable_resources(struct pci_dev *dev, int mask)
+{
+	u16 cmd, old_cmd;
+	int idx;
+	struct resource *r;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+	for(idx=0; idx<6; idx++) {
+		/* Only set up the requested stuff */
+		if (!(mask & (1<<idx)))
+			continue;
+			
+		r = &dev->resource[idx];
+		if (!r->start && r->end) {
+			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
+			return -EINVAL;
+		}
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+	if (dev->resource[PCI_ROM_RESOURCE].start)
+		cmd |= PCI_COMMAND_MEMORY;
+	if (cmd != old_cmd) {
+		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
+/*
+ *  If we set up a device for bus mastering, we need to check the latency
+ *  timer as certain crappy BIOSes forget to set it properly.
+ */
+unsigned int pcibios_max_latency = 255;
+
+void pcibios_set_master(struct pci_dev *dev)
+{
+	u8 lat;
+	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
+	if (lat < 16)
+		lat = (64 <= pcibios_max_latency) ? 64 : pcibios_max_latency;
+	else if (lat > pcibios_max_latency)
+		lat = pcibios_max_latency;
+	else
+		return;
+	printk(KERN_DEBUG "PCI: Setting latency timer of device %s to %d\n", pci_name(dev), lat);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-frv.h linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-frv.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-frv.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-frv.h	2004-11-05 14:13:03.340543322 +0000
@@ -0,0 +1,47 @@
+/*
+ *	Low-Level PCI Access for FRV machines.
+ *
+ *	(c) 1999 Martin Mares <mj@ucw.cz>
+ */
+
+#include <asm/sections.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+#define PCI_PROBE_BIOS		0x0001
+#define PCI_PROBE_CONF1		0x0002
+#define PCI_PROBE_CONF2		0x0004
+#define PCI_NO_SORT		0x0100
+#define PCI_BIOS_SORT		0x0200
+#define PCI_NO_CHECKS		0x0400
+#define PCI_ASSIGN_ROMS		0x1000
+#define PCI_BIOS_IRQ_SCAN	0x2000
+#define PCI_ASSIGN_ALL_BUSSES	0x4000
+
+extern unsigned int __nongpreldata pci_probe;
+
+/* pci-frv.c */
+
+extern unsigned int pcibios_max_latency;
+
+void pcibios_resource_survey(void);
+int pcibios_enable_resources(struct pci_dev *, int);
+
+/* pci-vdk.c */
+
+extern int __nongpreldata pcibios_last_bus;
+extern struct pci_bus *__nongpreldata pci_root_bus;
+extern struct pci_ops *__nongpreldata pci_root_ops;
+
+/* pci-irq.c */
+extern unsigned int pcibios_irq_mask;
+
+void pcibios_irq_init(void);
+void pcibios_fixup_irqs(void);
+void pcibios_enable_irq(struct pci_dev *dev);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-irq.c linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-irq.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-irq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-irq.c	2004-11-05 14:13:03.344542984 +0000
@@ -0,0 +1,70 @@
+/* pci-irq.c: PCI IRQ routing on the FRV motherboard
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * derived from: arch/i386/kernel/pci-irq.c: (c) 1999--2000 Martin Mares <mj@suse.cz>
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/irq-routing.h>
+
+#include "pci-frv.h"
+
+/*
+ *	DEVICE	DEVNO	INT#A	INT#B	INT#C	INT#D
+ *	=======	=======	=======	=======	=======	=======
+ *	MB86943	0	fpga.10	-	-	-
+ *	RTL8029	16	fpga.12	-	-	-
+ *	SLOT 1	19	fpga.6	fpga.5	fpga.4	fpga.3
+ *	SLOT 2	18	fpga.5	fpga.4	fpga.3	fpga.6
+ *	SLOT 3	17	fpga.4	fpga.3	fpga.6	fpga.5
+ *
+ */
+
+static const uint8_t __initdata pci_bus0_irq_routing[32][4] = {
+	[0 ] {	IRQ_FPGA_MB86943_PCI_INTA },
+	[16] {	IRQ_FPGA_RTL8029_INTA },
+	[17] {	IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD, IRQ_FPGA_PCI_INTA, IRQ_FPGA_PCI_INTB },
+	[18] {	IRQ_FPGA_PCI_INTB, IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD, IRQ_FPGA_PCI_INTA },
+	[19] {	IRQ_FPGA_PCI_INTA, IRQ_FPGA_PCI_INTB, IRQ_FPGA_PCI_INTC, IRQ_FPGA_PCI_INTD },
+};
+
+void __init pcibios_irq_init(void)
+{
+}
+
+void __init pcibios_fixup_irqs(void)
+{
+	struct pci_dev *dev = NULL;
+	uint8_t line, pin;
+
+	while (dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev),
+	       dev != NULL
+	       ) {
+		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+		if (pin) {
+			dev->irq = pci_bus0_irq_routing[PCI_SLOT(dev->devfn)][pin - 1];
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		}
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
+	}
+}
+
+void __init pcibios_penalize_isa_irq(int irq)
+{
+}
+
+void pcibios_enable_irq(struct pci_dev *dev)
+{
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-vdk.c linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-vdk.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mb93090-mb00/pci-vdk.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mb93090-mb00/pci-vdk.c	2004-11-05 14:13:03.352542308 +0000
@@ -0,0 +1,462 @@
+/* pci-vdk.c: MB93090-MB00 (VDK) PCI support
+ *
+ * Copyright (C) 2003, 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include <asm/segment.h>
+#include <asm/io.h>
+#include <asm/mb-regs.h>
+#include <asm/mb86943a.h>
+#include "pci-frv.h"
+
+unsigned int __nongpreldata pci_probe = 1;
+
+int  __nongpreldata pcibios_last_bus = -1;
+struct pci_bus *__nongpreldata pci_root_bus;
+struct pci_ops *__nongpreldata pci_root_ops;
+
+/*
+ * Functions for accessing PCI configuration space
+ */
+
+#define CONFIG_CMD(bus, dev, where) \
+	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
+
+#define __set_PciCfgAddr(A) writel((A), (volatile void __iomem *) __region_CS1 + 0x80)
+
+#define __get_PciCfgDataB(A) readb((volatile void __iomem *) __region_CS1 + 0x88 + ((A) & 3))
+#define __get_PciCfgDataW(A) readw((volatile void __iomem *) __region_CS1 + 0x88 + ((A) & 2))
+#define __get_PciCfgDataL(A) readl((volatile void __iomem *) __region_CS1 + 0x88)
+
+#define __set_PciCfgDataB(A,V) writeb((V), (volatile void __iomem *) __region_CS1 + 0x88 + ((A) & 3))
+#define __set_PciCfgDataW(A,V) writew((V), (volatile void __iomem *) __region_CS1 + 0x88 + ((A) & 2))
+#define __set_PciCfgDataL(A,V) writel((V), (volatile void __iomem *) __region_CS1 + 0x88)
+
+#define __get_PciBridgeDataB(A) readb((volatile void __iomem *) __region_CS1 + 0x800 + (A))
+#define __get_PciBridgeDataW(A) readw((volatile void __iomem *) __region_CS1 + 0x800 + (A))
+#define __get_PciBridgeDataL(A) readl((volatile void __iomem *) __region_CS1 + 0x800 + (A))
+
+#define __set_PciBridgeDataB(A,V) writeb((V), (volatile void __iomem *) __region_CS1 + 0x800 + (A))
+#define __set_PciBridgeDataW(A,V) writew((V), (volatile void __iomem *) __region_CS1 + 0x800 + (A))
+#define __set_PciBridgeDataL(A,V) writel((V), (volatile void __iomem *) __region_CS1 + 0x800 + (A))
+
+static inline int __query(const struct pci_dev *dev)
+{
+//	return dev->bus->number==0 && (dev->devfn==PCI_DEVFN(0,0));
+//	return dev->bus->number==1;
+//	return dev->bus->number==0 &&
+//		(dev->devfn==PCI_DEVFN(2,0) || dev->devfn==PCI_DEVFN(3,0));
+	return 0;
+}
+
+/*****************************************************************************/
+/*
+ *
+ */
+static int pci_frv_read_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
+			       u32 *val)
+{
+	u32 _value;
+
+	if (bus->number == 0 && devfn == PCI_DEVFN(0, 0)) {
+		_value = __get_PciBridgeDataL(where & ~3);
+	}
+	else {
+		__set_PciCfgAddr(CONFIG_CMD(bus, devfn, where));
+		_value = __get_PciCfgDataL(where & ~3);
+	}
+
+	switch (size) {
+	case 1:
+		_value = _value >> ((where & 3) * 8);
+		break;
+
+	case 2:
+		_value = _value >> ((where & 2) * 8);
+		break;
+
+	case 4:
+		break;
+
+	default:
+		BUG();
+	}
+
+	*val = _value;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int pci_frv_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
+				u32 value)
+{
+	switch (size) {
+	case 1:
+		if (bus->number == 0 && devfn == PCI_DEVFN(0, 0)) {
+			__set_PciBridgeDataB(where, value);
+		}
+		else {
+			__set_PciCfgAddr(CONFIG_CMD(bus, devfn, where));
+			__set_PciCfgDataB(where, value);
+		}
+		break;
+
+	case 2:
+		if (bus->number == 0 && devfn == PCI_DEVFN(0, 0)) {
+			__set_PciBridgeDataW(where, value);
+		}
+		else {
+			__set_PciCfgAddr(CONFIG_CMD(bus, devfn, where));
+			__set_PciCfgDataW(where, value);
+		}
+		break;
+
+	case 4:
+		if (bus->number == 0 && devfn == PCI_DEVFN(0, 0)) {
+			__set_PciBridgeDataL(where, value);
+		}
+		else {
+			__set_PciCfgAddr(CONFIG_CMD(bus, devfn, where));
+			__set_PciCfgDataL(where, value);
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops pci_direct_frv = {
+	pci_frv_read_config,
+	pci_frv_write_config,
+};
+
+/*
+ * Before we decide to use direct hardware access mechanisms, we try to do some
+ * trivial checks to ensure it at least _seems_ to be working -- we just test
+ * whether bus 00 contains a host bridge (this is similar to checking
+ * techniques used in XFree86, but ours should be more reliable since we
+ * attempt to make use of direct access hints provided by the PCI BIOS).
+ *
+ * This should be close to trivial, but it isn't, because there are buggy
+ * chipsets (yes, you guessed it, by Intel and Compaq) that have no class ID.
+ */
+static int __init pci_sanity_check(struct pci_ops *o)
+{
+	struct pci_bus bus;		/* Fake bus and device */
+	u32 id;
+
+	bus.number	= 0;
+
+	if (o->read(&bus, 0, PCI_VENDOR_ID, 4, &id) == PCIBIOS_SUCCESSFUL) {
+		printk("PCI: VDK Bridge device:vendor: %08x\n", id);
+		if (id == 0x200e10cf)
+			return 1;
+	}
+
+	printk("PCI: VDK Bridge: Sanity check failed\n");
+	return 0;
+}
+
+static struct pci_ops * __init pci_check_direct(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/* check if access works */
+	if (pci_sanity_check(&pci_direct_frv)) {
+		local_irq_restore(flags);
+		printk("PCI: Using configuration frv\n");
+//		request_mem_region(0xBE040000, 256, "FRV bridge");
+//		request_mem_region(0xBFFFFFF4, 12, "PCI frv");
+		return &pci_direct_frv;
+	}
+
+	local_irq_restore(flags);
+	return NULL;
+}
+
+/*
+ * Several buggy motherboards address only 16 devices and mirror
+ * them to next 16 IDs. We try to detect this `feature' on all
+ * primary buses (those containing host bridges as they are
+ * expected to be unique) and remove the ghost devices.
+ */
+
+static void __init pcibios_fixup_ghosts(struct pci_bus *b)
+{
+	struct list_head *ln, *mn;
+	struct pci_dev *d, *e;
+	int mirror = PCI_DEVFN(16,0);
+	int seen_host_bridge = 0;
+	int i;
+
+	for (ln=b->devices.next; ln != &b->devices; ln=ln->next) {
+		d = pci_dev_b(ln);
+		if ((d->class >> 8) == PCI_CLASS_BRIDGE_HOST)
+			seen_host_bridge++;
+		for (mn=ln->next; mn != &b->devices; mn=mn->next) {
+			e = pci_dev_b(mn);
+			if (e->devfn != d->devfn + mirror ||
+			    e->vendor != d->vendor ||
+			    e->device != d->device ||
+			    e->class != d->class)
+				continue;
+			for(i=0; i<PCI_NUM_RESOURCES; i++)
+				if (e->resource[i].start != d->resource[i].start ||
+				    e->resource[i].end != d->resource[i].end ||
+				    e->resource[i].flags != d->resource[i].flags)
+					continue;
+			break;
+		}
+		if (mn == &b->devices)
+			return;
+	}
+	if (!seen_host_bridge)
+		return;
+	printk("PCI: Ignoring ghost devices on bus %02x\n", b->number);
+
+	ln = &b->devices;
+	while (ln->next != &b->devices) {
+		d = pci_dev_b(ln->next);
+		if (d->devfn >= mirror) {
+			list_del(&d->global_list);
+			list_del(&d->bus_list);
+			kfree(d);
+		} else
+			ln = ln->next;
+	}
+}
+
+/*
+ * Discover remaining PCI buses in case there are peer host bridges.
+ * We use the number of last PCI bus provided by the PCI BIOS.
+ */
+static void __init pcibios_fixup_peer_bridges(void)
+{
+	struct pci_bus bus;
+	struct pci_dev dev;
+	int n;
+	u16 l;
+
+	if (pcibios_last_bus <= 0 || pcibios_last_bus >= 0xff)
+		return;
+	printk("PCI: Peer bridge fixup\n");
+	for (n=0; n <= pcibios_last_bus; n++) {
+		if (pci_find_bus(0, n))
+			continue;
+		bus.number = n;
+		bus.ops = pci_root_ops;
+		dev.bus = &bus;
+		for(dev.devfn=0; dev.devfn<256; dev.devfn += 8)
+			if (!pci_read_config_word(&dev, PCI_VENDOR_ID, &l) &&
+			    l != 0x0000 && l != 0xffff) {
+				printk("Found device at %02x:%02x [%04x]\n", n, dev.devfn, l);
+				printk("PCI: Discovered peer bus %02x\n", n);
+				pci_scan_bus(n, pci_root_ops, NULL);
+				break;
+			}
+	}
+}
+
+/*
+ * Exceptions for specific devices. Usually work-arounds for fatal design flaws.
+ */
+
+static void __init pci_fixup_umc_ide(struct pci_dev *d)
+{
+	/*
+	 * UM8886BF IDE controller sets region type bits incorrectly,
+	 * therefore they look like memory despite of them being I/O.
+	 */
+	int i;
+
+	printk("PCI: Fixing base address flags for device %s\n", d->slot_name);
+	for(i=0; i<4; i++)
+		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
+}
+
+static void __init pci_fixup_ide_bases(struct pci_dev *d)
+{
+	int i;
+
+	/*
+	 * PCI IDE controllers use non-standard I/O port decoding, respect it.
+	 */
+	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
+		return;
+	printk("PCI: IDE base address fixup for %s\n", d->slot_name);
+	for(i=0; i<4; i++) {
+		struct resource *r = &d->resource[i];
+		if ((r->start & ~0x80) == 0x374) {
+			r->start |= 2;
+			r->end = r->start;
+		}
+	}
+}
+
+static void __init pci_fixup_ide_trash(struct pci_dev *d)
+{
+	int i;
+
+	/*
+	 * There exist PCI IDE controllers which have utter garbage
+	 * in first four base registers. Ignore that.
+	 */
+	printk("PCI: IDE base address trash cleared for %s\n", d->slot_name);
+	for(i=0; i<4; i++)
+		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
+}
+
+static void __devinit  pci_fixup_latency(struct pci_dev *d)
+{
+	/*
+	 *  SiS 5597 and 5598 chipsets require latency timer set to
+	 *  at most 32 to avoid lockups.
+	 */
+	DBG("PCI: Setting max latency to 32\n");
+	pcibios_max_latency = 32;
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, pci_fixup_umc_ide);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5597, pci_fixup_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5598, pci_fixup_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
+
+/*
+ *  Called after each bus is probed, but before its children
+ *  are examined.
+ */
+
+void __init pcibios_fixup_bus(struct pci_bus *bus)
+{
+#if 0
+	printk("### PCIBIOS_FIXUP_BUS(%d)\n",bus->number);
+#endif
+	pcibios_fixup_ghosts(bus);
+	pci_read_bridge_bases(bus);
+
+	if (bus->number == 0) {
+		struct list_head *ln;
+		struct pci_dev *dev;
+		for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
+			dev = pci_dev_b(ln);
+			if (dev->devfn == 0) {
+				dev->resource[0].start = 0;
+				dev->resource[0].end = 0;
+			}
+		}
+	}
+}
+
+/*
+ * Initialization. Try all known PCI access methods. Note that we support
+ * using both PCI BIOS and direct access: in such cases, we use I/O ports
+ * to access config space, but we still keep BIOS order of cards to be
+ * compatible with 2.0.X. This should go away some day.
+ */
+
+int __init pcibios_init(void)
+{
+	struct pci_ops *dir = NULL;
+
+	if (!mb93090_mb00_detected)
+		return -ENXIO;
+
+	__reg_MB86943_sl_ctl |= MB86943_SL_CTL_DRCT_MASTER_SWAP | MB86943_SL_CTL_DRCT_SLAVE_SWAP;
+
+	__reg_MB86943_ecs_base(1)	= ((__region_CS2 + 0x01000000) >> 9) | 0x08000000;
+	__reg_MB86943_ecs_base(2)	= ((__region_CS2 + 0x00000000) >> 9) | 0x08000000;
+
+	*(volatile uint32_t *) (__region_CS1 + 0x848) = 0xe0000000;
+	*(volatile uint32_t *) (__region_CS1 + 0x8b8) = 0x00000000;
+
+	__reg_MB86943_sl_pci_io_base	= (__region_CS2 + 0x04000000) >> 9;
+	__reg_MB86943_sl_pci_mem_base	= (__region_CS2 + 0x08000000) >> 9;
+	__reg_MB86943_pci_sl_io_base	= __region_CS2 + 0x04000000;
+	__reg_MB86943_pci_sl_mem_base	= __region_CS2 + 0x08000000;
+	mb();
+
+	*(volatile unsigned long *)(__region_CS2+0x01300014) == 1;
+
+	ioport_resource.start	= (__reg_MB86943_sl_pci_io_base << 9) & 0xfffffc00;
+	ioport_resource.end	= (__reg_MB86943_sl_pci_io_range << 9) | 0x3ff;
+	ioport_resource.end	+= ioport_resource.start;
+
+	printk("PCI IO window:  %08lx-%08lx\n", ioport_resource.start, ioport_resource.end);
+
+	iomem_resource.start	= (__reg_MB86943_sl_pci_mem_base << 9) & 0xfffffc00;
+
+	/* Reserve somewhere to write to flush posted writes. */
+	iomem_resource.start += 0x400;
+
+	iomem_resource.end	= (__reg_MB86943_sl_pci_mem_range << 9) | 0x3ff;
+	iomem_resource.end	+= iomem_resource.start;
+
+	printk("PCI MEM window: %08lx-%08lx\n", iomem_resource.start, iomem_resource.end);
+	printk("PCI DMA memory: %08lx-%08lx\n", dma_coherent_mem_start, dma_coherent_mem_end);
+
+	if (!pci_probe)
+		return -ENXIO;
+
+	dir = pci_check_direct();
+	if (dir)
+		pci_root_ops = dir;
+	else {
+		printk("PCI: No PCI bus detected\n");
+		return -ENXIO;
+	}
+
+	printk("PCI: Probing PCI hardware\n");
+	pci_root_bus = pci_scan_bus(0, pci_root_ops, NULL);
+
+	pcibios_irq_init();
+	pcibios_fixup_peer_bridges();
+	pcibios_fixup_irqs();
+	pcibios_resource_survey();
+
+	return 0;
+}
+
+arch_initcall(pcibios_init);
+
+char * __init pcibios_setup(char *str)
+{
+	if (!strcmp(str, "off")) {
+		pci_probe = 0;
+		return NULL;
+	} else if (!strncmp(str, "lastbus=", 8)) {
+		pcibios_last_bus = simple_strtol(str+8, NULL, 0);
+		return NULL;
+	}
+	return str;
+}
+
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	int err;
+
+	if ((err = pcibios_enable_resources(dev, mask)) < 0)
+		return err;
+	pcibios_enable_irq(dev);
+	return 0;
+}
