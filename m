Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUHDGL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUHDGL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUHDGK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:10:57 -0400
Received: from web14923.mail.yahoo.com ([216.136.225.7]:20336 "HELO
	web14923.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267293AbUHDGIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:08:40 -0400
Message-ID: <20040804060840.54760.qmail@web14923.mail.yahoo.com>
Date: Tue, 3 Aug 2004 23:08:40 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200408021002.31117.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-786288203-1091599720=:54120"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-786288203-1091599720=:54120
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

This is a new version of Jesse's PCI ROM patch.

It can read ROMs on x86. Main problem was that the PCI address space is
not part of the kernel address space on the x86 so ioremap() is needed.
I added the parts about assign/release resource but I am not sure that
they are needed.

The patch obviously needs more work for the not_direct case. The quirk
to record the boot video card has not been written.

I wasted a lot of time figuring out why it wouldn't work until I
remembered that my radeon card needs a kernel quirk to fix it's ROM
enabling. Most radeon cards have this problem so if you get FFFF the
code is problem working, I just need to write the quirk to enable the ROM.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
--0-786288203-1091599720=:54120
Content-Type: text/x-patch; name="pci-sysfs-rom-8.patch"
Content-Description: pci-sysfs-rom-8.patch
Content-Disposition: inline; filename="pci-sysfs-rom-8.patch"

===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Wed Aug  4 01:37:15 2004
@@ -164,6 +164,108 @@
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
+
+	pci_read_config_dword(dev, dev->rom_base_reg, &rom_addr);
+	rom_addr &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(dev, dev->rom_base_reg, rom_addr);
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
+	unsigned long start;
+	loff_t i, size;
+	char direct_access = dev->rom_info.rom ? 0 : 1;
+	unsigned char *rom = NULL;
+	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+
+	if (off > size)
+		return 0;
+		
+	if (direct_access) {
+		/* assign the ROM an address if it doesn't have one */
+		if (r->parent == NULL)
+			pci_assign_resource(dev, PCI_ROM_RESOURCE);
+		/* Enable ROM space decodes and do the reads */
+		pci_enable_rom(dev);
+		start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+		size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		rom = ioremap(start, size);
+		
+		printk("read_rom start %lx size %x\n", start, size);
+		printk("rom bytes %02x %02x\n", rom, rom + 1);
+	}
+	if (off + count > size) {
+		size -= off;
+		count = size;
+	} else
+		size = count;
+
+	i = 0;
+	while (size > 0) {
+		unsigned char val;
+		if (direct_access)
+			val = readb(rom + off);
+		else
+			val = *(dev->rom_info.rom + off);
+		buf[i++] = val;
+		off++;
+		--size;
+	}
+	if (direct_access) {
+		iounmap(rom);
+		/* Disable again before continuing */
+		pci_disable_rom(dev);
+		if (r->parent) {
+			release_resource(r);
+			r->end -= r->start;
+			r->start = 0;
+		}
+	}
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,13 +288,51 @@
 	.write = pci_write_config,
 };
 
-void pci_create_sysfs_dev_files (struct pci_dev *pdev)
+void pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (pdev->cfg_size < 4096)
 		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+printk("devfn %x len %lx start %lx\n", pdev->devfn, pci_resource_len(pdev, PCI_ROM_RESOURCE), pci_resource_start(pdev, PCI_ROM_RESOURCE));
+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		struct bin_attribute *rom_attr;
+		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
+
+		pdev->rom_info.rom_attr = NULL;
+		if (!rom_attr)
+			goto out;
+
+		pdev->rom_info.rom_attr = rom_attr;
+		rom_attr->attr.name = "rom";
+		rom_attr->attr.mode = S_IRUSR;
+		rom_attr->attr.owner = THIS_MODULE;
+		rom_attr->read = pci_read_rom;
+		rom_attr->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		sysfs_create_bin_file(&pdev->dev.kobj, rom_attr);
+	}
+ out:
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);
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
+	if (pdev->rom_info.rom_attr) {
+		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_info.rom_attr);
+		kfree(pdev->rom_info.rom_attr);
+	}
 }
===== drivers/pci/pci.h 1.12 vs edited =====
--- 1.12/drivers/pci/pci.h	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci.h	Tue Aug  3 17:05:19 2004
@@ -3,6 +3,7 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 				  unsigned long size, unsigned long align,
 				  unsigned long min, unsigned int type_mask,
===== drivers/pci/probe.c 1.65 vs edited =====
--- 1.65/drivers/pci/probe.c	Fri May 21 14:45:27 2004
+++ edited/drivers/pci/probe.c	Tue Aug  3 17:05:19 2004
@@ -157,6 +157,8 @@
 #endif
 		}
 	}
+
+	dev->rom_info.rom = NULL;
 	if (rom) {
 		dev->rom_base_reg = rom;
 		res = &dev->resource[PCI_ROM_RESOURCE];
===== drivers/pci/remove.c 1.3 vs edited =====
--- 1.3/drivers/pci/remove.c	Tue Feb  3 12:17:30 2004
+++ edited/drivers/pci/remove.c	Tue Aug  3 17:05:20 2004
@@ -26,6 +26,9 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 	pci_proc_detach_device(dev);
+	/* Free the copy of the ROM if we made one */
+	kfree(dev->rom_info.rom);
+	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
 
 	/* Remove the device from the device lists, and prevent any further
===== include/linux/pci.h 1.132 vs edited =====
--- 1.132/include/linux/pci.h	Mon Aug  2 04:00:43 2004
+++ edited/include/linux/pci.h	Tue Aug  3 17:05:21 2004
@@ -471,6 +471,11 @@
 	pci_mmap_mem
 };
 
+struct rom_info {
+	char *rom; /* copy of the ROM if necessary */
+	struct bin_attribute *rom_attr;
+};
+
 /* This defines the direction arg to the DMA mapping routines. */
 #define PCI_DMA_BIDIRECTIONAL	0
 #define PCI_DMA_TODEVICE	1
@@ -537,6 +542,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	
 	unsigned int 	saved_config_space[16]; /* config space saved at suspend time */
+	struct rom_info rom_info; /* How and where to get the ROM info for this device */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */

--0-786288203-1091599720=:54120--
