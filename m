Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUHBREI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUHBREI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUHBREI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:04:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20135 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266661AbUHBRDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:03:37 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Mon, 2 Aug 2004 10:02:31 -0700
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <20040730221528.2702.qmail@web14922.mail.yahoo.com> <200407310859.45769.jbarnes@engr.sgi.com>
In-Reply-To: <200407310859.45769.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nOnDBWVesFCL82I"
Message-Id: <200408021002.31117.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nOnDBWVesFCL82I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday, July 31, 2004 8:59 am, Jesse Barnes wrote:
> On Friday, July 30, 2004 3:15 pm, Jon Smirl wrote:
> > If you set pci_dev->resource[PCI_ROM_RESOURCE] to C000:0 won't this
> > mess up pci_assign_resource()/release_resource()?
>
> Yeah, you're right, that wouldn't be a good thing to do.  I guess I'll have
> to hang a different structure off of the pci_dev so we can tell the sysfs
> rom handling code where to get the rom.  Doing it that way would allow us
> to deal with cards that really need a copy made too, though the default
> behavior would be to read it directly.
>
> How does that sound?

Here's a new patch that implements that suggestion, though without any special 
cases for the various cards that might need the ROM copy (e.g. those with 
shared decoders or whose ROMs are in the system ROM somewhere).  How does it 
look, Greg?  It it suitable for the mainline yet?  I expect those familiar 
with the various cards to add the necessary quirks code as needed.

Thanks,
Jesse

--Boundary-00=_nOnDBWVesFCL82I
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci-sysfs-rom-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci-sysfs-rom-7.patch"

===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	2004-06-04 06:23:04 -07:00
+++ edited/drivers/pci/pci-sysfs.c	2004-08-02 09:57:11 -07:00
@@ -164,6 +164,92 @@
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
+	char direct_access = dev->rom_info.rom ? 0 : 1;
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
+	if (direct_access)
+		pci_enable_rom(dev);
+
+	while (size > 0) {
+		unsigned char val;
+		if (direct_access)
+			val = readb(start + off);
+		else
+			val = *(dev->rom_info.rom + off);
+		buf[off - init_off] = val;
+		off++;
+		--size;
+	}
+
+	/* Disable again before continuing */
+	if (direct_access)
+		pci_disable_rom(dev);
+
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,13 +272,50 @@
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
--- 1.12/drivers/pci/pci.h	2004-06-04 06:23:04 -07:00
+++ edited/drivers/pci/pci.h	2004-08-02 09:41:02 -07:00
@@ -3,6 +3,7 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 				  unsigned long size, unsigned long align,
 				  unsigned long min, unsigned int type_mask,
===== drivers/pci/probe.c 1.65 vs edited =====
--- 1.65/drivers/pci/probe.c	2004-05-21 11:45:27 -07:00
+++ edited/drivers/pci/probe.c	2004-08-02 09:43:21 -07:00
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
--- 1.3/drivers/pci/remove.c	2004-02-03 09:17:30 -08:00
+++ edited/drivers/pci/remove.c	2004-08-02 09:41:52 -07:00
@@ -26,6 +26,9 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 	pci_proc_detach_device(dev);
+	/* Free the copy of the ROM if we made one */
+	kfree(dev->rom_info.rom);
+	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
 
 	/* Remove the device from the device lists, and prevent any further
===== include/linux/pci.h 1.130 vs edited =====
--- 1.130/include/linux/pci.h	2004-06-30 11:21:27 -07:00
+++ edited/include/linux/pci.h	2004-08-02 09:32:08 -07:00
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

--Boundary-00=_nOnDBWVesFCL82I--
