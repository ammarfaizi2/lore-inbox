Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbUKLX2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbUKLX2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbUKLX2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:28:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:56706 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262681AbUKLXWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:41 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017161992@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <1100301717159@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.16, 2004/11/05 15:06:26-08:00, jonsmirl@gmail.com

[PATCH] PCI: add PCI ROMs to sysfs

Linus has requested that the sysfs rom attribute be changed to require
enabling before it works. echo "0" to the attribute to disable,
echoing anything else enables the rom output. The concern is that
something like a file browser could inadvertently read the attribute
and change the state of the hardware without the user's knowledge.

The attached patch includes the previous patch plus the enabling logic.

[root@smirl 0000:02:02.0]#
[root@smirl 0000:02:02.0]# cat rom
cat: rom: Invalid argument
[root@smirl 0000:02:02.0]# echo "1" >rom
[root@smirl 0000:02:02.0]# hexdump -C -n 20 rom
00000000  55 aa 60 e9 d6 01 00 00  00 00 00 00 00 00 00 00  |U.`.............|
00000010  00 00 00 00                                       |....|
00000014
[root@smirl 0000:02:02.0]# echo "0" >rom
[root@smirl 0000:02:02.0]# hexdump -C -n 20 rom
hexdump: rom: Invalid argument
[root@smirl 0000:02:02.0]#




Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/fixup.c   |   38 ++++++++
 drivers/pci/Makefile    |    3 
 drivers/pci/pci-sysfs.c |  120 +++++++++++++++++++++++++
 drivers/pci/pci.h       |    4 
 drivers/pci/probe.c     |    2 
 drivers/pci/remove.c    |    2 
 drivers/pci/rom.c       |  225 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-res.c |    2 
 include/linux/ioport.h  |    5 +
 include/linux/pci.h     |    8 +
 10 files changed, 404 insertions(+), 5 deletions(-)


diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2004-11-12 15:12:58 -08:00
+++ b/arch/i386/pci/fixup.c	2004-11-12 15:12:58 -08:00
@@ -346,3 +346,41 @@
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk );
 
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
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	2004-11-12 15:12:58 -08:00
+++ b/drivers/pci/Makefile	2004-11-12 15:12:58 -08:00
@@ -3,7 +3,8 @@
 #
 
 obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
-			names.o pci-driver.o search.o pci-sysfs.o
+			names.o pci-driver.o search.o pci-sysfs.o \
+			rom.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2004-11-12 15:12:58 -08:00
+++ b/drivers/pci/pci-sysfs.c	2004-11-12 15:12:58 -08:00
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
@@ -164,6 +168,65 @@
 	return count;
 }
 
+/**
+ * pci_write_rom - used to enable access to the PCI ROM display
+ * @kobj: kernel object handle
+ * @buf: user input
+ * @off: file offset
+ * @count: number of byte in input
+ *
+ * writing anything except 0 enables it
+ */
+static ssize_t
+pci_write_rom(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(container_of(kobj, struct device, kobj));
+
+	if ((off ==  0) && (*buf == '0') && (count == 2))
+		pdev->rom_attr_enabled = 0;
+	else
+		pdev->rom_attr_enabled = 1;
+
+	return count;
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
+	void __iomem *rom;
+	size_t size;
+
+	if (!pdev->rom_attr_enabled)
+		return -EINVAL;
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
@@ -186,13 +249,68 @@
 	.write = pci_write_config,
 };
 
-void pci_create_sysfs_dev_files (struct pci_dev *pdev)
+int pci_create_sysfs_dev_files (struct pci_dev *pdev)
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
+			rom_attr->write = pci_write_rom;
+			sysfs_create_bin_file(&pdev->dev.kobj, rom_attr);
+		}
+	}
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);
+	
+	return 0;
+}
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
 }
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
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	2004-11-12 15:12:58 -08:00
+++ b/drivers/pci/pci.h	2004-11-12 15:12:58 -08:00
@@ -2,7 +2,9 @@
 
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
-extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern int pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 				  unsigned long size, unsigned long align,
 				  unsigned long min, unsigned int type_mask,
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2004-11-12 15:12:58 -08:00
+++ b/drivers/pci/probe.c	2004-11-12 15:12:58 -08:00
@@ -170,7 +170,7 @@
 		if (sz && sz != 0xffffffff) {
 			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
 			if (sz) {
-				res->flags = (l & PCI_ROM_ADDRESS_ENABLE) |
+				res->flags = (l & IORESOURCE_ROM_ENABLE) |
 				  IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
 				res->start = l & PCI_ROM_ADDRESS_MASK;
diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c	2004-11-12 15:12:58 -08:00
+++ b/drivers/pci/remove.c	2004-11-12 15:12:58 -08:00
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
diff -Nru a/drivers/pci/rom.c b/drivers/pci/rom.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/pci/rom.c	2004-11-12 15:12:58 -08:00
@@ -0,0 +1,225 @@
+/*
+ * drivers/pci/rom.c
+ *
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
+ *
+ * PCI ROM access routines
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+
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
+void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+	loff_t start;
+	void __iomem *rom;
+	void __iomem *image;
+	int last_image;
+	
+	if (res->flags & IORESOURCE_ROM_SHADOW) {	/* IORESOURCE_ROM_SHADOW only set on x86 */
+		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
+		*size = 0x20000;		/* cover C000:0 through E000:0 */
+	} else {
+		if (res->flags & IORESOURCE_ROM_COPY) {
+			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+			return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
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
+
+	/* Try to find the true size of the ROM since sometimes the PCI window */
+	/* size is much larger than the actual size of the ROM. */
+	/* True size is important if the ROM is going to be copied. */
+	image = rom;
+	do {
+		void __iomem *pds;
+		/* Standard PCI ROMs start out with these bytes 55 AA */
+		if (readb(image) != 0x55)
+			break;
+		if (readb(image + 1) != 0xAA)
+			break;
+		/* get the PCI data structure and check its signature */
+		pds = image + readw(image + 24);
+		if (readb(pds) != 'P')
+			break;
+		if (readb(pds + 1) != 'C')
+			break;
+		if (readb(pds + 2) != 'I')
+			break;
+		if (readb(pds + 3) != 'R')
+			break;
+		last_image = readb(pds + 21) & 0x80;
+		/* this length is reliable */
+		image += readw(pds + 16) * 512;
+	} while (!last_image);
+
+	*size = image - rom;
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
+void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size)
+{
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+	void __iomem *rom;
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
+	memcpy_fromio((void*)res->start, rom, *size);
+	pci_unmap_rom(pdev, rom);
+	res->flags |= IORESOURCE_ROM_COPY;
+	
+	return (void __iomem *)res->start;
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
+pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
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
+		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
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
+EXPORT_SYMBOL(pci_map_rom);
+EXPORT_SYMBOL(pci_map_rom_copy);
+EXPORT_SYMBOL(pci_unmap_rom);
+EXPORT_SYMBOL(pci_remove_rom);
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	2004-11-12 15:12:58 -08:00
+++ b/drivers/pci/setup-res.c	2004-11-12 15:12:58 -08:00
@@ -56,7 +56,7 @@
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
+		new |= res->flags & IORESOURCE_ROM_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */
diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	2004-11-12 15:12:58 -08:00
+++ b/include/linux/ioport.h	2004-11-12 15:12:58 -08:00
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
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-11-12 15:12:58 -08:00
+++ b/include/linux/pci.h	2004-11-12 15:12:58 -08:00
@@ -537,6 +537,8 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	
 	u32		saved_config_space[16]; /* config space saved at suspend time */
+	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
+	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */
@@ -784,6 +786,12 @@
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
+
+/* ROM control related routines */
+void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size);
+void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size);
+void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
+void pci_remove_rom(struct pci_dev *pdev);
 
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);

