Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUG3VKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUG3VKN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267849AbUG3VKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:10:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13701 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267840AbUG3VJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:09:40 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@yahoo.com>
Subject: [PATCH] add PCI ROMs to sysfs
Date: Fri, 30 Jul 2004 14:09:05 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xjrCBJ7sdoP2Dfz"
Message-Id: <200407301409.05638.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_xjrCBJ7sdoP2Dfz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Per a big thread earlier today, this patch adds a 'rom' file to sysfs in the 
same place where we currently have 'config', 'irq', etc.

Note that the ROM is *not* cached, so userspace will have to save the ROM when 
a device is first detected if the card doesn't support address cycles to ROM 
space at the same time as other memory accesses.  (I'm still open to changing 
this if people feel strongly, but as it stands, the 'rom' file is only 
slightly more dangerous than the 'config' file.)

Jon, am I missing something or is it possible for us to cache the ROM in 
userspace when it receives the hotplug event?  I saw your DRM code, and for 
the case of ROMs at a nonstandard address, we can fixup the address for 
pci_dev->resource[PCI_ROM_RESOURCE] in pci-quirks, can't we?

Thoughts?  I've tried to add cleanup code, but I'm not sure how acceptable it 
is and I don't have any way of testing it.

Thanks,
Jesse

--Boundary-00=_xjrCBJ7sdoP2Dfz
Content-Type: text/plain;
  charset="us-ascii";
  name="pci-sysfs-rom-4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci-sysfs-rom-4.patch"

===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	2004-06-04 06:23:04 -07:00
+++ edited/drivers/pci/pci-sysfs.c	2004-07-30 14:04:40 -07:00
@@ -164,6 +164,86 @@
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
+	pci_read_config_dword(dev, PCI_ROM_ADDRESS, &rom_addr);
+	rom_addr |= PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(dev, PCI_ROM_ADDRESS, rom_addr);
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
+	pci_read_config_dword(dev, PCI_ROM_ADDRESS, &rom_addr);
+	rom_addr &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(dev, PCI_ROM_ADDRESS, rom_addr);
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
+	loff_t init_off = off;
+	unsigned long start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+	int size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+
+	if (off > size)
+		return 0;
+	if (off + count > size) {
+		size -= off;
+		count = size;
+	} else {
+		size = count;
+	}
+
+	/* Enable ROM space decodes and do the reads */
+	pci_enable_rom(dev);
+
+	while (size > 0) {
+		unsigned char val;
+		val = readb(start + off);
+		buf[off - init_off] = val;
+		off++;
+		--size;
+	}
+
+	/* Disable again before continuing */
+	pci_disable_rom(dev);
+
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -193,6 +273,39 @@
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		struct bin_attribute *rom_attr;
+		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
+
+		if (!rom_attr)
+			goto out;
+
+		pdev->rom_attr = rom_attr;
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
+	/* Don't need to free config entries since they're static & global */
+
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE) && pdev->rom_attr) {
+		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
+		kfree(pdev->rom_attr);
+	}
 }
===== drivers/pci/remove.c 1.3 vs edited =====
--- 1.3/drivers/pci/remove.c	2004-02-03 09:17:30 -08:00
+++ edited/drivers/pci/remove.c	2004-07-30 13:35:18 -07:00
@@ -26,6 +26,7 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
 
 	/* Remove the device from the device lists, and prevent any further
===== include/linux/pci.h 1.130 vs edited =====
--- 1.130/include/linux/pci.h	2004-06-30 11:21:27 -07:00
+++ edited/include/linux/pci.h	2004-07-30 13:37:09 -07:00
@@ -537,6 +537,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	
 	unsigned int 	saved_config_space[16]; /* config space saved at suspend time */
+	struct bin_attribute *rom_attr; /* ROM attribute (if ROM is present) */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */

--Boundary-00=_xjrCBJ7sdoP2Dfz--
