Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUHEFIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUHEFIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUHEFIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:08:15 -0400
Received: from web14924.mail.yahoo.com ([216.136.225.8]:13690 "HELO
	web14924.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267550AbUHEFF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:05:57 -0400
Message-ID: <20040805050556.9899.qmail@web14924.mail.yahoo.com>
Date: Wed, 4 Aug 2004 22:05:56 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Martin Mares <mj@ucw.cz>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040803213921.GA4585@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-768166646-1091682356=:9582"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-768166646-1091682356=:9582
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Version 10

implements an x86 quirk to record the boot video device. Is the
PCI_ROM_SHADOW flag a safe define? Quirk records boot video device by
looking at how the bridges route to the VGA device. It there some other
way to tell which video card is the boot one? What if there is more
than one VGA card on the PCI bus? I think the BIOS spec is to enable
the one in the lowest slot number. Can someone who own multiple PCI
video cards test this? I tested with one PCI, one AGP.

BenH, this should solve the problem of which video card owns the ROM
copy at C000:0. For the boot device this code returns the shadow copy,
else the real ROM on the card.

I did the x86 quirk, what do the quirks on ia64, ppc, x86_64 need? Can
they just copy the x86 one?

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
--0-768166646-1091682356=:9582
Content-Type: text/x-patch; name="pci-sysfs-rom-10.patch"
Content-Description: pci-sysfs-rom-10.patch
Content-Disposition: inline; filename="pci-sysfs-rom-10.patch"

===== arch/i386/pci/fixup.c 1.19 vs edited =====
--- 1.19/arch/i386/pci/fixup.c	Thu Jun  3 10:58:17 2004
+++ edited/arch/i386/pci/fixup.c	Thu Aug  5 00:20:08 2004
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
+		.pass		= PCI_FIXUP_FINAL,
+		.vendor		= PCI_ANY_ID,
+		.device		= PCI_ANY_ID,
+		.hook		= pci_fixup_video
 	},
 	{ .pass = 0 }
 };
===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	Fri Jun  4 09:23:04 2004
+++ edited/drivers/pci/pci-sysfs.c	Thu Aug  5 00:45:04 2004
@@ -164,6 +164,95 @@
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
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+
+	if (res->flags & PCI_ROM_SHADOW) {	/* PCI_ROM_SHADOW only set on x86 */
+		start = (unsigned char *)0xC0000; /* primary video rom always starts here */
+		size = 0x20000;			/* cover C000:0 through E000:0 */
+	} else {
+		/* assign the ROM an address if it doesn't have one */
+		if (res->parent == NULL)
+			pci_assign_resource(dev, PCI_ROM_RESOURCE);
+			
+		start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+		size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		
+		/* Enable ROM space decodes */
+		pci_enable_rom(dev);
+	}
+	if (off >= size)
+		return 0;
+		
+	if (off + count > size)
+		count = size - off;
+	
+	rom = ioremap(start, size);
+	if (rom) {
+		memcpy_fromio(buf, rom + off, count);
+		iounmap(rom);
+	} else
+		count = 0;
+		
+	/* Disable again before continuing, leave enabled if pci=rom */
+	if (!(res->flags & (PCI_ROM_ADDRESS_ENABLE|PCI_ROM_SHADOW)))
+		pci_disable_rom(dev);
+		
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,13 +275,49 @@
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
+		struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+		if (res->flags & PCI_ROM_SHADOW) {
+			rom_attr.size = 0x20000;	/* cover C000:0 through E000:0 */
+		} else
+			rom_attr.size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
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
+++ edited/drivers/pci/probe.c	Thu Aug  5 00:10:06 2004
@@ -157,6 +157,7 @@
 #endif
 		}
 	}
+
 	if (rom) {
 		dev->rom_base_reg = rom;
 		res = &dev->resource[PCI_ROM_RESOURCE];
===== drivers/pci/remove.c 1.3 vs edited =====
--- 1.3/drivers/pci/remove.c	Tue Feb  3 12:17:30 2004
+++ edited/drivers/pci/remove.c	Thu Aug  5 00:11:05 2004
@@ -26,6 +26,7 @@
 static void pci_destroy_dev(struct pci_dev *dev)
 {
 	pci_proc_detach_device(dev);
+	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
 
 	/* Remove the device from the device lists, and prevent any further
===== include/linux/pci.h 1.132 vs edited =====
--- 1.132/include/linux/pci.h	Mon Aug  2 04:00:43 2004
+++ edited/include/linux/pci.h	Thu Aug  5 00:13:54 2004
@@ -102,6 +102,8 @@
 #define PCI_SUBSYSTEM_ID	0x2e  
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
+#define  PCI_ROM_SHADOW		0x02	/* resource flag, ROM is copy at C000:0 */
+#define  PCI_ROM_COPY		0x04	/* resource flag, ROM is alloc'd copy */
 #define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
 
 #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */

--0-768166646-1091682356=:9582--
