Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUHEBix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUHEBix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUHEBix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:38:53 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:48982 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267466AbUHEBij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:38:39 -0400
Message-ID: <20040805013838.25245.qmail@web14922.mail.yahoo.com>
Date: Wed, 4 Aug 2004 18:38:38 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200408041006.18877.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-893694117-1091669918=:25074"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-893694117-1091669918=:25074
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

New version, it's getting smaller.
add a lot of error checking 
uses memcpy_fromio
reuses rom_attr since sysfs copies the length into the dentry
if the ROM was enabled from pci=rom, it leaves it that way

We still need:
quick for radeon bug
quirk for recording boot graphics device

I need to do an x86 architecture specific thing in the boot device
quirk. In order to tell the length of the ROM I need to start with the
55 AA at C000:0. The next byte after the 55 AA is ROM length divided by
512. There is no direct way to query for this length since the ROM
image may have been decompressed and there is no real ROM. Not sure
what the other platforms will do. Does Open Firmware use the same 55 AA
len scheme? PCI report ROM length much larger than they really are, my
radeon ROM is 128KB from PCI but it really is 48KB.

Any ideas on the simplest way to identify the boot video card? I can
scan all of the PCI adapters looking for video ones and then check if
it is enabled since the only one enabled will be the boot device.

I can simplify the patch further if there is a free bit in
resource->flags. The bottom byte looks to be for bus specific use but I
am having trouble determining which bits PCI is using.

With a bit in resource->flags I can remove this structure from pci_dev
struct rom_info {
	char *rom; /* copy of the ROM if necessary */
	size_t size;
};
The bit would indicate that the ROM is being read from the BIOS shadow
copy making it ok to overlay the ROM resource slot. I'd then modify
pci_assign_resource, pci_release_resource to respect the bit. 


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
--0-893694117-1091669918=:25074
Content-Type: text/x-patch; name="pci-sysfs-rom-9.patch"
Content-Description: pci-sysfs-rom-9.patch
Content-Disposition: inline; filename="pci-sysfs-rom-9.patch"

===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Wed Aug  4 20:39:45 2004
@@ -164,6 +164,103 @@
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
+	loff_t start;
+	size_t size;
+	unsigned char *rom;
+
+	if (dev->rom_info.rom) {
+		size = dev->rom_info.size;
+		rom = dev->rom_info.rom;
+		
+		if (off >= size)
+			return 0;
+			
+		if (off + count > size)
+			count = size - off;
+			
+		memcpy(buf, rom + off, count);
+	} else {
+		/* assign the ROM an address if it doesn't have one */
+		struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+		if (res->parent == NULL)
+			pci_assign_resource(dev, PCI_ROM_RESOURCE);
+			
+		start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+		size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		
+		if (off >= size)
+			return 0;
+			
+		if (off + count > size)
+			count = size - off;
+			
+		/* Enable ROM space decodes and do the reads */
+		pci_enable_rom(dev);
+		
+		rom = ioremap(start, size);
+		if (rom) {
+			memcpy_fromio(buf, rom + off, count);
+			iounmap(rom);
+		} else
+			count = 0;
+			
+		/* Disable again before continuing, leave enabled if pci=rom */
+		if (!(res->flags & PCI_ROM_ADDRESS_ENABLE))
+			pci_disable_rom(dev);
+	}
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,13 +283,45 @@
 	.write = pci_write_config,
 };
 
-void pci_create_sysfs_dev_files (struct pci_dev *pdev)
+static struct bin_attribute rom_attr = {
+	.attr =	{
+		.name = "rom",
+		.mode = S_IRUSR,
+		.owner = THIS_MODULE,
+	},
+	/* .size is set individually for each device, sysfs copies it into dentry */
+	.read = pci_read_rom,
+};
+
+void pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (pdev->cfg_size < 4096)
 		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		rom_attr.size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		sysfs_create_bin_file(&pdev->dev.kobj, &rom_attr);
+	}
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
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
+		sysfs_remove_bin_file(&pdev->dev.kobj, &rom_attr);
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
+++ edited/include/linux/pci.h	Wed Aug  4 19:53:26 2004
@@ -471,6 +471,11 @@
 	pci_mmap_mem
 };
 
+struct rom_info {
+	char *rom; /* copy of the ROM if necessary */
+	size_t size;
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

--0-893694117-1091669918=:25074--
