Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUG3RQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUG3RQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUG3RPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:15:43 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:48594 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267749AbUG3RPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:15:30 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 10:10:29 -0700
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com>
In-Reply-To: <20040730165339.76945.qmail@web14929.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FEoCB8O3vJNM4Wt"
Message-Id: <200407301010.29807.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_FEoCB8O3vJNM4Wt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, July 30, 2004 9:53 am, Jon Smirl wrote:
> We talked at OLS about exposing adapter ROMs via sysfs. I have some
> time to work on this but I'm not sure about the right places to hook
> into the kernel.

How about this patch?

> The first problem is recording the boot video device. This is needed
> for laptops that compress their video and system ROMs together into a
> single ROM. When sysfs exposes the ROM for these adapters it needs to
> know the boot video device so that it can return the ROM image at
> C000:0 instead of trying to find an actual ROM. What is the right
> kernel structure for recording the boot video device? Where should this
> code live? It is probably x86 specific but have non-x86 laptops done
> the same trick?

If we have the pci quirks stuff fill in pci_dev->resource[PCI_ROM_RESOURCE] 
with the right addresses, we should be ok.

> What about ISA support. Should we make an attempt to return ROM
> contents from ISA cards?

That's probably more trouble than it's worth, but if someone really wants it 
they could always code it up.

> Note that not just video cards can have ROMs. Disk adapters commonly
> have them too. We probably want to expose these ROMs too.
>
> Do we want to expose the system ROM via sysfs? Where should it appear?
>
> Some Radeon cards have a bug where they forgot to clear a latch which
> makes the ROMs visible. Where should a fix for things like this go? I
> can put it in the radeon driver but if you try to read the ROM before
> the driver is loaded, the ROM won't be visible.

Jesse


--Boundary-00=_FEoCB8O3vJNM4Wt
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci-sysfs-rom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci-sysfs-rom.patch"

===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	2004-06-04 06:23:04 -07:00
+++ edited/drivers/pci/pci-sysfs.c	2004-07-30 10:07:49 -07:00
@@ -164,6 +164,61 @@
 	return count;
 }
 
+static ssize_t
+pci_read_rom(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	loff_t init_off = off;
+	unsigned long start = dev->resource[PCI_ROM_RESOURCE].start;
+	int size = dev->resource[PCI_ROM_RESOURCE].end -
+		dev->resource[PCI_ROM_RESOURCE].start;
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
+	pci_write_config_dword(dev, 1, PCI_ROM_ADDRESS_ENABLE);
+
+	while (off & 3) {
+		unsigned char val;
+		val = readb(start + off);
+		buf[off - init_off] = val;
+		off++;
+		if (--size == 0)
+			break;
+	}
+
+	while (size > 3) {
+		unsigned int val;
+		val = readl(start + off);
+		buf[off - init_off] = val & 0xff;
+		buf[off - init_off + 1] = (val >> 8) & 0xff;
+		buf[off - init_off + 2] = (val >> 16) & 0xff;
+		buf[off - init_off + 3] = (val >> 24) & 0xff;
+		off += 4;
+		size -= 4;
+	}
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
+	pci_write_config_dword(dev, 1, ~PCI_ROM_ADDRESS_ENABLE);
+
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,12 +241,28 @@
 	.write = pci_write_config,
 };
 
+static struct bin_attribute pci_rom_attr = {
+	.attr =	{
+		.name = "rom",
+		.mode = S_IRUGO | S_IWUSR,
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
+	if (pdev->resource[PCI_ROM_RESOURCE].start) {
+		pci_rom_attr.size = pdev->resource[PCI_ROM_RESOURCE].end -
+			pdev->resource[PCI_ROM_RESOURCE].start;
+		sysfs_create_bin_file(&pdev->dev.kobj, &pci_rom_attr);
+	}
 
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);

--Boundary-00=_FEoCB8O3vJNM4Wt--
