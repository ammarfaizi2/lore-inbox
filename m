Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268349AbUHLCWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268349AbUHLCWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268353AbUHLCWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:22:50 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:50805 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268349AbUHLCWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:22:30 -0400
Message-ID: <20040812022229.23100.qmail@web14929.mail.yahoo.com>
Date: Wed, 11 Aug 2004 19:22:29 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: RE: [PATCH] add PCI ROMs to sysfs
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600296D33C@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-494658359-1092277349=:22455"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-494658359-1092277349=:22455
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

pci-sysfs-rom-14.patch

switches back to allocating sysfs attr structure
adds jesse copyright
fixes ordering problem with get length out of shadow ROM

pending issues
Alan's concern about copying ROMs for partially decoded hardware
Does quirk need to be added to x86_64
Does this patch break on non-x86 architectures
My concern about relying on bios to set initial address for ROM
please check it on laptops

If a radeon ROM shows as FFFF it is a bug in the radeon hardware. Load
the new radeonfb driver and the ROM will appear.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
--0-494658359-1092277349=:22455
Content-Type: text/x-patch; name="pci-sysfs-rom-14.patch"
Content-Description: pci-sysfs-rom-14.patch
Content-Disposition: inline; filename="pci-sysfs-rom-14.patch"

===== arch/i386/pci/fixup.c 1.19 vs edited =====
--- 1.19/arch/i386/pci/fixup.c	Thu Jun  3 10:58:17 2004
+++ edited/arch/i386/pci/fixup.c	Wed Aug 11 22:14:20 2004
@@ -237,6 +237,29 @@
 	}
 }
 
+static void __devinit pci_fixup_video(struct pci_dev *pdev)
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
+	pdev->resource[PCI_ROM_RESOURCE].flags |= PCI_ROM_SHADOW;
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{
 		.pass		= PCI_FIXUP_HEADER,
@@ -345,6 +368,12 @@
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2,
 		.hook		= pci_fixup_nforce2
+	},
+	{
+		.pass		= PCI_FIXUP_HEADER,
+		.vendor		= PCI_ANY_ID,
+		.device		= PCI_ANY_ID,
+		.hook		= pci_fixup_video
 	},
 	{ .pass = 0 }
 };
===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Wed Aug 11 22:13:46 2004
@@ -5,6 +5,8 @@
  * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
  * (C) Copyright 2003 Hewlett-Packard
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  *
  * File attributes for PCI devices
  *
@@ -164,6 +166,193 @@
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
+pci_enable_rom(struct pci_dev *dev)
+{
+	u32 rom_addr;
+	
+	pci_read_config_dword(dev, dev->rom_base_reg, &rom_addr);
+	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(dev, dev->rom_base_reg, rom_addr);
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
+pci_disable_rom(struct pci_dev *dev)
+{
+	u32 rom_addr;
+	pci_read_config_dword(dev, dev->rom_base_reg, &rom_addr);
+	rom_addr &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(dev, dev->rom_base_reg, rom_addr);
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
+pci_map_rom(struct pci_dev *dev, size_t *size) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+	loff_t start;
+	unsigned char *rom;
+	
+	if (res->flags & PCI_ROM_SHADOW) {	/* PCI_ROM_SHADOW only set on x86 */
+		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
+		*size = 0x20000;		/* cover C000:0 through E000:0 */
+	} else if (res->flags & PCI_ROM_COPY) {
+		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		return (unsigned char *)pci_resource_start(dev, PCI_ROM_RESOURCE);
+	} else {
+		start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		if (*size == 0)
+			return NULL;
+		
+		/* Enable ROM space decodes */
+		pci_enable_rom(dev);
+	}
+	
+	rom = ioremap(start, *size);
+	if (!rom) {
+		/* restore enable if ioremap fails */
+		if (!(res->flags & (PCI_ROM_ADDRESS_ENABLE | PCI_ROM_SHADOW | PCI_ROM_COPY)))
+			pci_disable_rom(dev);
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
+pci_map_rom_copy(struct pci_dev *dev, size_t *size) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+	unsigned char *rom;
+	
+	rom = pci_map_rom(dev, size);
+	if (!rom)
+		return NULL;
+		
+	if (res->flags & (PCI_ROM_COPY | PCI_ROM_SHADOW))
+		return rom;
+		
+	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
+	if (!res->start) 
+		return rom;
+
+	res->end = res->start + *size; 
+	memcpy((void*)res->start, rom, *size);
+	pci_unmap_rom(dev, rom);
+	res->flags |= PCI_ROM_COPY;
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
+pci_unmap_rom(struct pci_dev *dev, unsigned char *rom) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+
+	if (res->flags & PCI_ROM_COPY)
+		return;
+		
+	iounmap(rom);
+		
+	/* Disable again before continuing, leave enabled if pci=rom */
+	if (!(res->flags & (PCI_ROM_ADDRESS_ENABLE | PCI_ROM_SHADOW)))
+		pci_disable_rom(dev);
+}
+
+static struct bin_attribute rom_attr;
+
+/**
+ * pci_remove_rom - disable the ROM and remove it's sysfs attribute
+ * @dev: pointer to pci device struct
+ *
+ */
+void 
+pci_remove_rom(struct pci_dev *dev) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+	
+	if (pci_resource_len(dev, PCI_ROM_RESOURCE))
+		sysfs_remove_bin_file(&dev->dev.kobj, &rom_attr);
+	if (!(res->flags & (PCI_ROM_ADDRESS_ENABLE | PCI_ROM_SHADOW | PCI_ROM_COPY)))
+		pci_disable_rom(dev);
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
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	unsigned char *rom;
+	size_t size;
+	
+	rom = pci_map_rom(dev, &size);	/* size starts out as PCI window size */
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
+	pci_unmap_rom(dev, rom);
+		
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,13 +375,63 @@
 	.write = pci_write_config,
 };
 
-void pci_create_sysfs_dev_files (struct pci_dev *pdev)
+void pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (pdev->cfg_size < 4096)
 		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		unsigned char *rom;
+		struct bin_attribute *rom_attr;
+		
+		pdev->rom_attr = NULL;
+		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
+		if (rom_attr) {
+			/* set default size */
+			rom_attr->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+			/* get true size if possible */
+			rom = pci_map_rom(pdev, &rom_attr->size);
+			if (!rom)
+				kfree(rom_attr);
+			else {
+				pci_unmap_rom(pdev, rom);
+				pdev->rom_attr = rom_attr;
+				rom_attr->attr.name = "rom";
+				rom_attr->attr.mode = S_IRUSR;
+				rom_attr->attr.owner = THIS_MODULE;
+				rom_attr->read = pci_read_rom;
+				sysfs_create_bin_file(&pdev->dev.kobj, rom_attr);
+			}
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
+EXPORT_SYMBOL(pci_map_rom);
+EXPORT_SYMBOL(pci_map_rom_copy);
+EXPORT_SYMBOL(pci_unmap_rom);
===== drivers/pci/pci.h 1.12 vs edited =====
--- 1.12/drivers/pci/pci.h	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci.h	Sun Aug  8 17:20:23 2004
@@ -3,6 +3,7 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 				  unsigned long size, unsigned long align,
 				  unsigned long min, unsigned int type_mask,
===== drivers/pci/remove.c 1.3 vs edited =====
--- 1.3/drivers/pci/remove.c	Tue Feb  3 12:17:30 2004
+++ edited/drivers/pci/remove.c	Sun Aug  8 17:20:23 2004
@@ -12,12 +12,22 @@
 
 static void pci_free_resources(struct pci_dev *dev)
 {
+	struct resource *res;
 	int i;
 
  	msi_remove_pci_irq_vectors(dev);
 
+	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+		res = &dev->resource[PCI_ROM_RESOURCE];
+		if (res->flags & PCI_ROM_COPY) {
+			kfree((void*)res->start);
+			res->flags &= !PCI_ROM_COPY;
+			res->start = 0;
+			res->end = 0;
+		}
+	}
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = dev->resource + i;
+		res = dev->resource + i;
 		if (res->parent)
 			release_resource(res);
 	}
@@ -26,6 +36,7 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
 
 	/* Remove the device from the device lists, and prevent any further
===== include/linux/pci.h 1.132 vs edited =====
--- 1.132/include/linux/pci.h	Mon Aug  2 04:00:43 2004
+++ edited/include/linux/pci.h	Wed Aug 11 21:57:09 2004
@@ -102,6 +102,8 @@
 #define PCI_SUBSYSTEM_ID	0x2e  
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
+#define  PCI_ROM_SHADOW		0x02	/* resource flag, ROM is copy at C000:0 */
+#define  PCI_ROM_COPY		0x04	/* resource flag, ROM is alloc'd copy */
 #define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
 
 #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
@@ -537,6 +539,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	
 	unsigned int 	saved_config_space[16]; /* config space saved at suspend time */
+	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */
@@ -777,6 +780,12 @@
 int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
+
+/* ROM control related routines */
+unsigned char *pci_map_rom(struct pci_dev *dev, size_t *size);
+unsigned char *pci_map_rom_copy(struct pci_dev *dev, size_t *size);
+void pci_unmap_rom(struct pci_dev *dev, unsigned char *rom);
+void pci_remove_rom(struct pci_dev *dev);
 
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
===== kdb/gen-kdb_cmds.c 1.1 vs edited =====
--- 1.1/kdb/gen-kdb_cmds.c	Sun Aug  8 17:19:30 2004
+++ edited/kdb/gen-kdb_cmds.c	Sun Aug  8 17:22:49 2004
@@ -17,16 +17,6 @@
 static __initdata char kdb_cmd15[] = "  -archkdbcommon\n";
 static __initdata char kdb_cmd16[] = "  -bta\n";
 static __initdata char kdb_cmd17[] = "endefcmd\n";
-static __initdata char kdb_cmd18[] = "defcmd archkdbcommon \"\" \"Common arch debugging\"\n";
-static __initdata char kdb_cmd19[] = "  set LINES 2000000\n";
-static __initdata char kdb_cmd20[] = "  set BTAPROMPT 0\n";
-static __initdata char kdb_cmd21[] = "  -summary\n";
-static __initdata char kdb_cmd22[] = "  -id %eip-24\n";
-static __initdata char kdb_cmd23[] = "  -cpu\n";
-static __initdata char kdb_cmd24[] = "  -ps\n";
-static __initdata char kdb_cmd25[] = "  -dmesg 600\n";
-static __initdata char kdb_cmd26[] = "  -bt\n";
-static __initdata char kdb_cmd27[] = "endefcmd\n";
 char __initdata *kdb_cmds[] = {
   kdb_cmd0,
   kdb_cmd1,
@@ -46,15 +36,5 @@
   kdb_cmd15,
   kdb_cmd16,
   kdb_cmd17,
-  kdb_cmd18,
-  kdb_cmd19,
-  kdb_cmd20,
-  kdb_cmd21,
-  kdb_cmd22,
-  kdb_cmd23,
-  kdb_cmd24,
-  kdb_cmd25,
-  kdb_cmd26,
-  kdb_cmd27,
   0
 };

--0-494658359-1092277349=:22455--
