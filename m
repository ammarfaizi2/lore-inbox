Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUHNFfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUHNFfr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 01:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHNFfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 01:35:47 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:38298 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265973AbUHNFeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 01:34:50 -0400
Message-ID: <20040814053449.35464.qmail@web14928.mail.yahoo.com>
Date: Fri, 13 Aug 2004 22:34:49 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Martin Mares <mj@ucw.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040813181725.GD5685@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-886903179-1092461689=:25339"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-886903179-1092461689=:25339
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

New version 16 addressing some of the issues below...

--- Martin Mares <mj@ucw.cz> wrote:
> Hello!
> 
> Just a couple of notes about your patch:
> 
> +unsigned char *
> +pci_map_rom(struct pci_dev *dev, size_t *size) {
> +	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
> +	loff_t start;
> +	unsigned char *rom;
> +	
> +	if (res->flags & PCI_ROM_SHADOW) {	/* PCI_ROM_SHADOW only set on
> x86 */
> +		start = (loff_t)0xC0000; 	/* primary video rom always starts here
> */
> +		*size = 0x20000;		/* cover C000:0 through E000:0 */
> 
> Shouldn't we do this only if we find that the device has a ROM
> resource?

pci_map_rom() is called from two places, a driver that wants to map
it's own ROM so it knows it has one or during startup. The startup call
has a check to see if there is a ROM resource before calling
pci_map_rom().

> 
> +	} else if (res->flags & PCI_ROM_COPY) {
> +		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
> +		return (unsigned char *)pci_resource_start(dev, PCI_ROM_RESOURCE);
> +	} else {
> +		start = pci_resource_start(dev, PCI_ROM_RESOURCE);
> +		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
> +		if (*size == 0)
> +			return NULL;
> +		
> +		/* Enable ROM space decodes */
> +		pci_enable_rom(dev);
> +	}
> 
> This seems to be wrong -- before enabling a resource, you must call
> request_resource() on it and make sure that the ROM (1) has an
> address allocated, and (2) the address is not used by anything 
> else.

I sent this out before and didn't get any replies....

Any ideas on how to solve this problem...

Originally I had this in the enable ROM routine
/* assign the ROM an address if it doesn't have one */
if (r->parent == NULL)
   pci_assign_resource(dev->pdev, PCI_ROM_RESOURCE);

I removed the call to pci_assign_resource(). The sysfs attribute code
builds the attributes before the pci subsystem is fully initialized.
specifically before arch pcibios_init() has been called. If
pci_assign_resource() is called for the ROM before pcibios_init() the
kernel's resource maps have not been built yet. This will result in the
ROM being assigned a location on top of the framebuffer; as soon as it
is enabled the system will lock. Right now the code relies on the BIOS
getting the ROM address set up right. If we can figure out how to
initialize the sysfs attributes after pcibios_init() then I can put the
assign call back.

> 
> +	/* If the device has a ROM, try to expose it in sysfs. */
> +	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
> +		unsigned char *rom;
> +		struct bin_attribute *rom_attr;
> +		
> +		pdev->rom_attr = NULL;
> +		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
> +		if (rom_attr) {
> +			/* set default size */
> +			rom_attr->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
> +			/* get true size if possible */
> +			rom = pci_map_rom(pdev, &rom_attr->size);
> 
> As we can never be sure about the decoder sharing, it is very wise
> not to touch the ROM BAR until somebody accesses the sysfs file.
Using
> size according to the PCI config space (i.e., the resource) does not
> harm anybody.
> 
This code is running before any device drivers are loaded so they can
be using the ROM. The other possibility is the boot video device but
for that ROM we use the shadow copy.

I think the decoder sharing problem is being blown out of proportion
there are very few boards with this problem. The only conceivable
problem I can see is booting off from a SCSI controller ROM where the
controller has this problem. In this case there will be a copy shadow
copy of the ROM. If anyone has hardware that fits this scenario, let me
know and I can adjust the shadow code for it.

Also, one card I have has a 256MB PCI window over a 48KB ROM. If I use
the window size instead of true size for a copy I would waste a lot of
memory.

> +	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> +		res = &dev->resource[PCI_ROM_RESOURCE];
> +		if (res->flags & PCI_ROM_COPY) {
> +			kfree((void*)res->start);
> +			res->flags &= !PCI_ROM_COPY;
> 
> ~, not !
You're right. I fixed it.
> 
> +			res->start = 0;
> +			res->end = 0;
> +		}
> +	}
> 
> This should better be handled in a separate function in the same
> source file as the rest of the ROM handling code.
I moved it.
> 
> Also, what about ROMs in the other header types? Wouldn't it be
> better to scan all resources for the COPY flag instead?

I adjusted everything to use dev->rom_base_reg instead is
PCI_ROM_RESOURCE.

> 
>  #define PCI_SUBSYSTEM_ID	0x2e  
>  #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1
> reserved */
>  #define  PCI_ROM_ADDRESS_ENABLE	0x01
> +#define  PCI_ROM_SHADOW		0x02	/* resource flag, ROM is copy at
> C000:0 */
> +#define  PCI_ROM_COPY		0x04	/* resource flag, ROM is alloc'd copy */
>  #define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
> 
> This does not belong here! This part of pci.h describes the
> configuration space, not stuff internal to the kernel. Better 
> introduce a new resource flag in <linux/ioport.h>.

I added new flags in ioport.h. Historically PCI_ROM_ADDRESS_ENABLE has
been used instead of the new IORESOURCE_ROM_ENABLE define I just
created.
 
> 
> 				Have a nice fortnight
> -- 
> Martin `MJ' Mares   <mj@ucw.cz>  
> http://atrey.karlin.mff.cuni.cz/~mj/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep.,
> Earth
> "Oh no, not again!"  -- The bowl of petunias
> 

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
--0-886903179-1092461689=:25339
Content-Type: text/x-patch; name="pci-sysfs-rom-16.patch"
Content-Description: pci-sysfs-rom-16.patch
Content-Disposition: inline; filename="pci-sysfs-rom-16.patch"

===== arch/i386/pci/fixup.c 1.19 vs edited =====
--- 1.19/arch/i386/pci/fixup.c	Thu Jun  3 10:58:17 2004
+++ edited/arch/i386/pci/fixup.c	Sat Aug 14 01:27:01 2004
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
+	pdev->resource[pdev->rom_base_reg].flags |= IORESOURCE_ROM_SHADOW;
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
+++ edited/drivers/pci/pci-sysfs.c	Sat Aug 14 01:31:14 2004
@@ -5,6 +5,8 @@
  * (C) Copyright 2002-2004 IBM Corp.
  * (C) Copyright 2003 Matthew Wilcox
  * (C) Copyright 2003 Hewlett-Packard
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  *
  * File attributes for PCI devices
  *
@@ -164,6 +166,211 @@
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
+	struct resource *res = &pdev->resource[pdev->rom_base_reg];
+	loff_t start;
+	unsigned char *rom;
+	
+	if (res->flags & IORESOURCE_ROM_SHADOW) {	/* IORESOURCE_ROM_SHADOW only set on x86 */
+		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
+		*size = 0x20000;		/* cover C000:0 through E000:0 */
+	} else if (res->flags & IORESOURCE_ROM_COPY) {
+		*size = pci_resource_len(pdev, pdev->rom_base_reg);
+		return (unsigned char *)pci_resource_start(pdev, pdev->rom_base_reg);
+	} else {
+		start = pci_resource_start(pdev, pdev->rom_base_reg);
+		*size = pci_resource_len(pdev, pdev->rom_base_reg);
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
+	struct resource *res = &pdev->resource[pdev->rom_base_reg];
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
+	struct resource *res = &pdev->resource[pdev->rom_base_reg];
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
+	struct resource *res = &pdev->resource[pdev->rom_base_reg];
+	
+	if (pci_resource_len(pdev, pdev->rom_base_reg))
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
+	struct resource *res = &pdev->resource[pdev->rom_base_reg];
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
@@ -193,6 +400,57 @@
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, pdev->rom_base_reg)) {
+		unsigned char *rom;
+		struct bin_attribute *rom_attr;
+		
+		pdev->rom_attr = NULL;
+		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
+		if (rom_attr) {
+			/* set default size */
+			rom_attr->size = pci_resource_len(pdev, pdev->rom_base_reg);
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
+	if (pci_resource_len(pdev, pdev->rom_base_reg)) {
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
+++ edited/drivers/pci/probe.c	Sat Aug 14 01:02:04 2004
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
+++ edited/drivers/pci/remove.c	Sat Aug 14 01:29:05 2004
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
+++ edited/drivers/pci/setup-res.c	Sat Aug 14 01:02:01 2004
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

--0-886903179-1092461689=:25339--
