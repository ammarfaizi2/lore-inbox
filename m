Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267781AbUG3Szl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267781AbUG3Szl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267788AbUG3Szl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:55:41 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:34210 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267781AbUG3Szd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:55:33 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 11:49:39 -0700
User-Agent: KMail/1.6.2
Cc: Matthew Wilcox <willy@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk> <200407301112.10361.jbarnes@engr.sgi.com>
In-Reply-To: <200407301112.10361.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DhpCBjbBgyeskGd"
Message-Id: <200407301149.39256.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_DhpCBjbBgyeskGd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, July 30, 2004 11:12 am, Jesse Barnes wrote:
> On Friday, July 30, 2004 11:12 am, Matthew Wilcox wrote:
> > How about reading the contents of the ROM at pci_scan_bus() time?  It'd
> > waste a bunch of memory, but hey, people love sysfs.
>
> That might be a good solution, actually.  Then it would be cached for
> devices that don't want you to look at it after they've been POSTed too.

Here's a version that actually works, but without the caching (i.e. don't 
access it after a driver starts using the card).  If we go that route, should 
we hang a copy of the ROM off of the pci_dev in a pointer or somewhere else?

Thanks,
Jesse

--Boundary-00=_DhpCBjbBgyeskGd
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci-sysfs-rom-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci-sysfs-rom-3.patch"

===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	2004-06-04 06:23:04 -07:00
+++ edited/drivers/pci/pci-sysfs.c	2004-07-30 11:47:26 -07:00
@@ -164,6 +164,60 @@
 	return count;
 }
 
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
@@ -186,12 +240,27 @@
 	.write = pci_write_config,
 };
 
+static struct bin_attribute pci_rom_attr = {
+	.attr =	{
+		.name = "rom",
+		.mode = S_IRUSR,
+		.owner = THIS_MODULE,
+	},
+	.read = pci_read_rom,
+};
+
 void pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
 	if (pdev->cfg_size < 4096)
 		sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+
+	/* If the device has a ROM, map it */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		pci_rom_attr.size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		sysfs_create_bin_file(&pdev->dev.kobj, &pci_rom_attr);
+	}
 
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);

--Boundary-00=_DhpCBjbBgyeskGd--
