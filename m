Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUHNXjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUHNXjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHNXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:39:47 -0400
Received: from web14927.mail.yahoo.com ([216.136.225.85]:3743 "HELO
	web14927.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265722AbUHNXjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:39:23 -0400
Message-ID: <20040814233922.62654.qmail@web14927.mail.yahoo.com>
Date: Sat, 14 Aug 2004 16:39:22 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Martin Mares <mj@ucw.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040814221010.GA18592@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-997375393-1092526762=:61507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-997375393-1092526762=:61507
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Version 16 was broken. I didn't use the rom_reg_base correctly.

Version 17.
fixes rom_reg_base usage.

Moves pci sysfs initialization to the same stage that /proc/bus/pci
initializes. PCI sysfs was originally initialized before the pci
subsystem was completely running.

While fixing sysfs initialization I noticed that /proc initialization
wasn't optimal so I fixed it too.

When initializing the ROM attribute I now just use the PCI window
length instead of reading the true length from the ROM. If the ROM is
copied it will use the true length. This avoids touching the ROM in
case of partial decoders.

> > The system shadow copy is one of the main motivators for this code.
> > On some laptops the system and video ROMs are compressed. On these
> > systems the boot ROM decompresses these ROM into the shadow memory
> > at  C0000-100000.
> 
> Is there any reliable way to find the address and size of such a
> shadow image or we need to stick with the 0xc0000 + 256KB range?

For the size use the (55 AA len) at the front of the ROM. This has to
work since this is how the PC system BIOS finds expansion ROMs.

For the address there are only two reliable addresses, C0000 for the
video ROM and F0000 for the system ROM. There may be other shadow ROMs
in the C0000-10000 range but I don't know of a way to tell what
hardware they belong to.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
--0-997375393-1092526762=:61507
Content-Type: text/x-patch; name="pci-sysfs-rom-17.patch"
Content-Description: pci-sysfs-rom-17.patch
Content-Disposition: inline; filename="pci-sysfs-rom-17.patch"

===== arch/i386/pci/fixup.c 1.19 vs edited =====
--- 1.19/arch/i386/pci/fixup.c	Thu Jun  3 10:58:17 2004
+++ edited/arch/i386/pci/fixup.c	Sat Aug 14 15:44:34 2004
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
+	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
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
===== drivers/pci/bus.c 1.9 vs edited =====
--- 1.9/drivers/pci/bus.c	Sat Apr 10 18:27:59 2004
+++ edited/drivers/pci/bus.c	Sat Aug 14 18:17:40 2004
@@ -97,10 +97,6 @@
 		spin_lock(&pci_bus_lock);
 		list_add_tail(&dev->global_list, &pci_devices);
 		spin_unlock(&pci_bus_lock);
-
-		pci_proc_attach_device(dev);
-		pci_create_sysfs_dev_files(dev);
-
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Sat Aug 14 19:19:17 2004
@@ -5,6 +5,8 @@
  * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
  * (C) Copyright 2003 Hewlett-Packard
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  *
  * File attributes for PCI devices
  *
@@ -164,6 +166,215 @@
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
+pci_map_rom(struct pci_dev *pdev, size_t *size) {
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+	loff_t start;
+	unsigned char *rom;
+	
+	if (res->flags & IORESOURCE_ROM_SHADOW) {	/* IORESOURCE_ROM_SHADOW only set on x86 */
+		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
+		*size = 0x20000;		/* cover C000:0 through E000:0 */
+	} else if (res->flags & IORESOURCE_ROM_COPY) {
+		*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		return (unsigned char *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
+	} else {
+		/* assign the ROM an address if it doesn't have one */
+		if (res->parent == NULL)
+			pci_assign_resource(pdev, PCI_ROM_RESOURCE);
+
+		start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
+		*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		if (*size == 0)
+			return NULL;
+		
+		/* Enable ROM space decodes */
+		pci_enable_rom(pdev);
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
+pci_map_rom_copy(struct pci_dev *pdev, size_t *size) {
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
+pci_unmap_rom(struct pci_dev *pdev, unsigned char *rom) {
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
+ * pci_remove_rom - disable the ROM and remove it's sysfs attribute
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
+ * pci_remove_rom - disable the ROM and remove it's sysfs attribute
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
@@ -192,7 +403,60 @@
 		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
-
+		
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
+++ edited/drivers/pci/pci.h	Sat Aug 14 01:31:34 2004
@@ -3,6 +3,8 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
+void pci_cleanup_rom(struct pci_dev *dev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 				  unsigned long size, unsigned long align,
 				  unsigned long min, unsigned int type_mask,
===== drivers/pci/probe.c 1.65 vs edited =====
--- 1.65/drivers/pci/probe.c	Fri May 21 14:45:27 2004
+++ edited/drivers/pci/probe.c	Sat Aug 14 18:20:35 2004
@@ -170,7 +170,7 @@
 		if (sz && sz != 0xffffffff) {
 			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
 			if (sz) {
-				res->flags = (l & PCI_ROM_ADDRESS_ENABLE) |
+				res->flags = (l & IORESOURCE_ROM_ENABLE) |
 				  IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
 				res->start = l & PCI_ROM_ADDRESS_MASK;
===== drivers/pci/proc.c 1.39 vs edited =====
--- 1.39/drivers/pci/proc.c	Sat May 29 05:12:56 2004
+++ edited/drivers/pci/proc.c	Sat Aug 14 19:25:17 2004
@@ -16,7 +16,6 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
-static int proc_initialized;	/* = 0 */
 
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
@@ -387,9 +386,6 @@
 	struct proc_dir_entry *de, *e;
 	char name[16];
 
-	if (!proc_initialized)
-		return -EACCES;
-
 	if (!(de = bus->procdir)) {
 		if (pci_name_bus(name, bus))
 			return -EEXIST;
@@ -425,9 +421,6 @@
 {
 	struct proc_dir_entry *de = bus->procdir;
 
-	if (!proc_initialized)
-		return -EACCES;
-
 	if (!de) {
 		char name[16];
 		sprintf(name, "%02x", bus->number);
@@ -583,6 +576,7 @@
 {
 	return seq_open(file, &proc_bus_pci_devices_op);
 }
+
 static struct file_operations proc_bus_pci_dev_operations = {
 	.open		= proc_bus_pci_dev_open,
 	.read		= seq_read,
@@ -593,16 +587,20 @@
 static int __init pci_proc_init(void)
 {
 	struct proc_dir_entry *entry;
-	struct pci_dev *dev = NULL;
+	struct pci_dev *pdev = NULL;
+
 	proc_bus_pci_dir = proc_mkdir("pci", proc_bus);
+
 	entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
 	if (entry)
 		entry->proc_fops = &proc_bus_pci_dev_operations;
-	proc_initialized = 1;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		pci_proc_attach_device(dev);
+
+	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+		pci_proc_attach_device(pdev);
 	}
+
 	legacy_proc_init();
+
 	return 0;
 }
 
===== drivers/pci/remove.c 1.3 vs edited =====
--- 1.3/drivers/pci/remove.c	Tue Feb  3 12:17:30 2004
+++ edited/drivers/pci/remove.c	Sat Aug 14 18:18:57 2004
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
+++ edited/drivers/pci/setup-res.c	Sat Aug 14 18:19:44 2004
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
+++ edited/include/linux/ioport.h	Sat Aug 14 00:44:06 2004
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
===== include/linux/pci.h 1.132 vs edited =====
--- 1.132/include/linux/pci.h	Mon Aug  2 04:00:43 2004
+++ edited/include/linux/pci.h	Sat Aug 14 00:56:35 2004
@@ -537,6 +537,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	
 	unsigned int 	saved_config_space[16]; /* config space saved at suspend time */
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

--0-997375393-1092526762=:61507--
