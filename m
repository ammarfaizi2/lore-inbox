Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUHYUIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUHYUIZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268498AbUHYUIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:08:25 -0400
Received: from web14927.mail.yahoo.com ([216.136.225.85]:6270 "HELO
	web14927.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268457AbUHYUGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:06:39 -0400
Message-ID: <20040825200638.1165.qmail@web14927.mail.yahoo.com>
Date: Wed, 25 Aug 2004 13:06:38 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040825185519.GG30125@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1827147918-1093464398=:98519"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1827147918-1093464398=:98519
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

PCI sysfs and proc were being initialized two different ways. sysfs was
being initialized very early and I couldn't call most pci_xxx calls
from the sysfs code. On the other hand proc was being initialized much
later. I moved pci sysfs initialization to match proc initialization.
Later sysfs initialization lets me assign the ROM an address if it
needs one.

pci_bus_add_devices is marked __devinit not __init so I see that it
wasn't safe to remove the proc_initialized code for the hotplug case.
I'll put that code back in but I needed to build a parallel flag for
sysfs_initialized.

New version attached fixes this and the function documentation.

--- Greg KH <greg@kroah.com> wrote:
> But if you remove those calls, any pci device added later on in a pci
> hotplug (or in a pcmcia) system, would not have their sysfs files, or
> proc files created, right?
> 
> That doesn't seem like a good change, and is unnecessary for this rom
> sysfs feature, right?
> 
> thanks,
> 
> greg k-h
> 

=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
--0-1827147918-1093464398=:98519
Content-Type: text/x-patch; name="pci-sysfs-rom-18-mm.patch"
Content-Description: pci-sysfs-rom-18-mm.patch
Content-Disposition: inline; filename="pci-sysfs-rom-18-mm.patch"

Exposes PCI ROMs via sysfs. Four new routine for drivers to use when 
accessing ROMs: pci_map_rom, pci_map_rom_copy, pci_unmap_rom, pci_remove_rom. 
Handles shadow ROMs for laptops that compress actual ROMs.

Signed-off-by: "Jon Smirl" <jonsmirl@yahoo.com>
===== arch/i386/pci/fixup.c 1.20 vs edited =====
--- 1.20/arch/i386/pci/fixup.c	Mon Aug 23 23:50:21 2004
+++ edited/arch/i386/pci/fixup.c	Wed Aug 25 15:34:33 2004
@@ -255,3 +255,41 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);
 
+/*
+ * Fixup to mark boot BIOS video selected by BIOS before it changes
+ *
+ * From information provided by "Jon Smirl" <jonsmirl@yahoo.com>
+ *
+ * The standard boot ROM sequence for an x86 machine uses the BIOS
+ * to select an initial video card for boot display. This boot video 
+ * card will have it's BIOS copied to C0000 in system RAM. 
+ * IORESOURCE_ROM_SHADOW is used to associate the boot video
+ * card with this copy. On laptops this copy has to be used since
+ * the main ROM may be compressed or combined with another image.
+ * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
+ * is marked here since the boot video device will be the only enabled
+ * video device at this point.
+ *
+ */static void __devinit pci_fixup_video(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	u16 l;
+
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	/* Is VGA routed to us? */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
+			if (!(l & PCI_BRIDGE_CTL_VGA))
+				return;
+		}
+		bus = bus->parent;
+	}
+	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Wed Aug 25 15:43:49 2004
@@ -5,6 +5,8 @@
  * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
  * (C) Copyright 2003 Hewlett-Packard
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  *
  * File attributes for PCI devices
  *
@@ -20,6 +22,8 @@
 
 #include "pci.h"
 
+static int sysfs_initialized;	/* = 0 */
+
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -164,6 +168,221 @@
 	return count;
 }
 
+/**
+ * pci_enable_rom - enable ROM decoding for a PCI device
+ * @dev: PCI device to enable
+ *
+ * Enable ROM decoding on @dev.  This involves simply turning on the last
+ * bit of the PCI ROM BAR.  Note that some cards may share address decoders
+ * between the ROM and other resources, so enabling it may disable access
+ * to MMIO registers or other card memory.
+ */
+static void
+pci_enable_rom(struct pci_dev *pdev)
+{
+	u32 rom_addr;
+	
+	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
+	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
+}
+
+/**
+ * pci_disable_rom - disable ROM decoding for a PCI device
+ * @dev: PCI device to disable
+ *
+ * Disable ROM decoding on a PCI device by turning off the last bit in the
+ * ROM BAR.
+ */
+static void
+pci_disable_rom(struct pci_dev *pdev)
+{
+	u32 rom_addr;
+	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
+	rom_addr &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
+}
+
+/**
+ * pci_map_rom - map a PCI ROM to kernel space
+ * @dev: pointer to pci device struct
+ * @size: pointer to receive size of pci window over ROM
+ * @return: kernel virtual pointer to image of ROM
+ *
+ * Map a PCI ROM into kernel space. If ROM is boot video ROM,
+ * the shadow BIOS copy will be returned instead of the 
+ * actual ROM.
+ */
+unsigned char *
+pci_map_rom(struct pci_dev *pdev, size_t *size)
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+	loff_t start;
+	unsigned char *rom;
+	
+	if (res->flags & IORESOURCE_ROM_SHADOW) {	/* IORESOURCE_ROM_SHADOW only set on x86 */
+		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
+		*size = 0x20000;		/* cover C000:0 through E000:0 */
+	} else {
+		if (res->flags & IORESOURCE_ROM_COPY) {
+			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+			return (unsigned char *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
+		} else {
+			/* assign the ROM an address if it doesn't have one */
+			if (res->parent == NULL)
+				pci_assign_resource(pdev, PCI_ROM_RESOURCE);
+	
+			start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
+			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+			if (*size == 0)
+				return NULL;
+			
+			/* Enable ROM space decodes */
+			pci_enable_rom(pdev);
+		}
+	}
+	
+	rom = ioremap(start, *size);
+	if (!rom) {
+		/* restore enable if ioremap fails */
+		if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | IORESOURCE_ROM_COPY)))
+			pci_disable_rom(pdev);
+		return NULL;
+	}		
+	/* Standard PCI ROMs start out with these three bytes 55 AA size/512 */
+	if ((*rom == 0x55) && (*(rom + 1) == 0xAA))
+		*size = *(rom + 2) * 512;	/* return true ROM size, not PCI window size */
+		
+	return rom;
+}
+
+/**
+ * pci_map_rom_copy - map a PCI ROM to kernel space, create a copy
+ * @dev: pointer to pci device struct
+ * @size: pointer to receive size of pci window over ROM
+ * @return: kernel virtual pointer to image of ROM
+ *
+ * Map a PCI ROM into kernel space. If ROM is boot video ROM,
+ * the shadow BIOS copy will be returned instead of the 
+ * actual ROM.
+ */
+unsigned char *
+pci_map_rom_copy(struct pci_dev *pdev, size_t *size)
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+	unsigned char *rom;
+	
+	rom = pci_map_rom(pdev, size);
+	if (!rom)
+		return NULL;
+		
+	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW))
+		return rom;
+		
+	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
+	if (!res->start) 
+		return rom;
+
+	res->end = res->start + *size; 
+	memcpy((void*)res->start, rom, *size);
+	pci_unmap_rom(pdev, rom);
+	res->flags |= IORESOURCE_ROM_COPY;
+	
+	return (unsigned char *)res->start;
+}
+
+/**
+ * pci_unmap_rom - unmap the ROM from kernel space
+ * @dev: pointer to pci device struct
+ * @rom: virtual address of the previous mapping
+ *
+ * Remove a mapping of a previously mapped ROM
+ */
+void 
+pci_unmap_rom(struct pci_dev *pdev, unsigned char *rom)
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+
+	if (res->flags & IORESOURCE_ROM_COPY)
+		return;
+		
+	iounmap(rom);
+		
+	/* Disable again before continuing, leave enabled if pci=rom */
+	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW)))
+		pci_disable_rom(pdev);
+}
+
+static struct bin_attribute rom_attr;
+
+/**
+ * pci_remove_rom - disable the ROM and remove its sysfs attribute
+ * @dev: pointer to pci device struct
+ *
+ */
+void 
+pci_remove_rom(struct pci_dev *pdev) 
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+	
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
+		sysfs_remove_bin_file(&pdev->dev.kobj, &rom_attr);
+	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | IORESOURCE_ROM_COPY)))
+		pci_disable_rom(pdev);
+}
+
+/**
+ * pci_cleanup_rom - internal routine for freeing the ROM copy created 
+ * by pci_map_rom_copy called from remove.c
+ * @dev: pointer to pci device struct
+ *
+ */
+void 
+pci_cleanup_rom(struct pci_dev *pdev) 
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+	if (res->flags & IORESOURCE_ROM_COPY) {
+		kfree((void*)res->start);
+		res->flags &= ~IORESOURCE_ROM_COPY;
+		res->start = 0;
+		res->end = 0;
+	}
+}
+
+/**
+ * pci_read_rom - read a PCI ROM
+ * @kobj: kernel object handle
+ * @buf: where to put the data we read from the ROM
+ * @off: file offset
+ * @count: number of bytes to read
+ *
+ * Put @count bytes starting at @off into @buf from the ROM in the PCI
+ * device corresponding to @kobj.
+ */
+static ssize_t
+pci_read_rom(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(container_of(kobj, struct device, kobj));
+	unsigned char *rom;
+	size_t size;
+	
+	rom = pci_map_rom(pdev, &size);	/* size starts out as PCI window size */
+	if (!rom)
+		return 0;
+		
+	if (off >= size)
+		count = 0;
+	else {
+		if (off + count > size)
+			count = size - off;
+		
+		memcpy_fromio(buf, rom + off, count);
+	}
+	pci_unmap_rom(pdev, rom);
+		
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -188,11 +407,68 @@
 
 void pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
+	if (!sysfs_initialized)
+		return -EACCES;
+
 	if (pdev->cfg_size < 4096)
 		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		struct bin_attribute *rom_attr;
+		
+		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
+		if (rom_attr) {
+			pdev->rom_attr = rom_attr;
+			rom_attr->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+			rom_attr->attr.name = "rom";
+			rom_attr->attr.mode = S_IRUSR;
+			rom_attr->attr.owner = THIS_MODULE;
+			rom_attr->read = pci_read_rom;
+			sysfs_create_bin_file(&pdev->dev.kobj, rom_attr);
+		}
+	}
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);
 }
+
+/**
+ * pci_remove_sysfs_dev_files - cleanup PCI specific sysfs files
+ * @pdev: device whose entries we should free
+ *
+ * Cleanup when @pdev is removed from sysfs.
+ */
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
+{
+	if (pdev->cfg_size < 4096)
+		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
+	else
+		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		if (pdev->rom_attr) {
+			sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
+			kfree(pdev->rom_attr);
+		}
+	}
+}
+
+static int __init pci_sysfs_init(void)
+{
+	struct pci_dev *pdev = NULL;
+	
+	sysfs_initialized = 1;
+	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
+		pci_create_sysfs_dev_files(pdev);
+
+	return 0;
+}
+
+__initcall(pci_sysfs_init);
+
+EXPORT_SYMBOL(pci_map_rom);
+EXPORT_SYMBOL(pci_map_rom_copy);
+EXPORT_SYMBOL(pci_unmap_rom);
+EXPORT_SYMBOL(pci_remove_rom);
===== drivers/pci/pci.h 1.12 vs edited =====
--- 1.12/drivers/pci/pci.h	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci.h	Wed Aug 25 15:36:32 2004
@@ -3,6 +3,8 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 				  unsigned long size, unsigned long align,
 				  unsigned long min, unsigned int type_mask,
===== drivers/pci/probe.c 1.66 vs edited =====
--- 1.66/drivers/pci/probe.c	Mon Aug 23 23:50:45 2004
+++ edited/drivers/pci/probe.c	Wed Aug 25 15:34:40 2004
@@ -170,7 +170,7 @@
 		if (sz && sz != 0xffffffff) {
 			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
 			if (sz) {
-				res->flags = (l & PCI_ROM_ADDRESS_ENABLE) |
+				res->flags = (l & IORESOURCE_ROM_ENABLE) |
 				  IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
 				res->start = l & PCI_ROM_ADDRESS_MASK;
===== drivers/pci/remove.c 1.3 vs edited =====
--- 1.3/drivers/pci/remove.c	Tue Feb  3 12:17:30 2004
+++ edited/drivers/pci/remove.c	Wed Aug 25 15:34:41 2004
@@ -16,6 +16,7 @@
 
  	msi_remove_pci_irq_vectors(dev);
 
+	pci_cleanup_rom(dev);
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *res = dev->resource + i;
 		if (res->parent)
@@ -26,6 +27,7 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
 
 	/* Remove the device from the device lists, and prevent any further
===== drivers/pci/setup-res.c 1.25 vs edited =====
--- 1.25/drivers/pci/setup-res.c	Thu Mar 18 18:40:56 2004
+++ edited/drivers/pci/setup-res.c	Wed Aug 25 15:34:42 2004
@@ -56,7 +56,7 @@
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
+		new |= res->flags & IORESOURCE_ROM_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */
===== include/linux/ioport.h 1.14 vs edited =====
--- 1.14/include/linux/ioport.h	Thu Dec 18 00:48:57 2003
+++ edited/include/linux/ioport.h	Wed Aug 25 15:34:42 2004
@@ -82,6 +82,11 @@
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
 
+/* PCI ROM control bits (IORESOURCE_BITS) */
+#define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
+#define IORESOURCE_ROM_SHADOW		(1<<1)	/* ROM is copy at C000:0 */
+#define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy, resource field overlaid */
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
===== include/linux/pci.h 1.133 vs edited =====
--- 1.133/include/linux/pci.h	Mon Aug 23 23:51:13 2004
+++ edited/include/linux/pci.h	Wed Aug 25 15:34:42 2004
@@ -537,6 +537,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	
 	u32		saved_config_space[16]; /* config space saved at suspend time */
+	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */
@@ -777,6 +778,12 @@
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
+
+/* ROM control related routines */
+unsigned char *pci_map_rom(struct pci_dev *pdev, size_t *size);
+unsigned char *pci_map_rom_copy(struct pci_dev *pdev, size_t *size);
+void pci_unmap_rom(struct pci_dev *pdev, unsigned char *rom);
+void pci_remove_rom(struct pci_dev *pdev);
 
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);

--0-1827147918-1093464398=:98519--
