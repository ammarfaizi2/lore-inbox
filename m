Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267764AbUG3SC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267764AbUG3SC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267762AbUG3SC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:02:56 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:61825 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267767AbUG3SCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:02:40 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 10:57:12 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <200407301010.29807.jbarnes@engr.sgi.com> <20040730182410.A12171@infradead.org>
In-Reply-To: <20040730182410.A12171@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4voCB+1KGWrV8Fm"
Message-Id: <200407301057.12445.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4voCB+1KGWrV8Fm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, July 30, 2004 10:24 am, Christoph Hellwig wrote:
> On Fri, Jul 30, 2004 at 10:10:29AM -0700, Jesse Barnes wrote:
> > +	unsigned long start = dev->resource[PCI_ROM_RESOURCE].start;
> > +	int size = dev->resource[PCI_ROM_RESOURCE].end -
> > +		dev->resource[PCI_ROM_RESOURCE].start;
>
> pci_resource_start and pci_resource_len please.
>
> > +		.name = "rom",
> > +		.mode = S_IRUGO | S_IWUSR,
>
> do we really want it world readable if a read messes with pci config
> space?
>
> > +	if (pdev->resource[PCI_ROM_RESOURCE].start) {
> > +		pci_rom_attr.size = pdev->resource[PCI_ROM_RESOURCE].end -
> > +			pdev->resource[PCI_ROM_RESOURCE].start;
>
> as above.

Oops, forgot about those macros.  Fixed.  I've also fixed the perms, RO by 
root.

willy brings up a good point though, we may want to disable the rom file 
entirely after its been read, since it can be a source of trouble.  Here's 
the latest patch.

Jesse


--Boundary-00=_4voCB+1KGWrV8Fm
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci-sysfs-rom-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci-sysfs-rom-2.patch"

===== drivers/pci/pci-sysfs.c 1.10 vs edited =====
--- 1.10/drivers/pci/pci-sysfs.c	2004-06-04 06:23:04 -07:00
+++ edited/drivers/pci/pci-sysfs.c	2004-07-30 10:54:06 -07:00
@@ -164,6 +164,73 @@
 	return count;
 }
 
+static void
+pci_enable_rom(struct pci_dev *dev)
+{
+	pci_write_config_dword(dev, PCI_ROM_ADDRESS, PCI_ROM_ADDRESS_ENABLE);
+}
+
+static void
+pci_disable_rom(struct pci_dev *dev)
+{
+	pci_write_config_dword(dev, PCI_ROM_ADDRESS, ~PCI_ROM_ADDRESS_ENABLE);
+}
+
+static ssize_t
+pci_read_rom(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	loff_t init_off = off;
+	unsigned long start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+	int size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+	u32 l;
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
+	pci_disable_rom(dev);
+
+	return count;
+}
+
 static struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
@@ -186,12 +253,27 @@
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
+	if (pdev->resource[PCI_ROM_RESOURCE].start) {
+		pci_rom_attr.size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		sysfs_create_bin_file(&pdev->dev.kobj, &pci_rom_attr);
+	}
 
 	/* add platform-specific attributes */
 	pcibios_add_platform_entries(pdev);

--Boundary-00=_4voCB+1KGWrV8Fm--
