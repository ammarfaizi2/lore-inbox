Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVLATh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVLATh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVLATh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:37:28 -0500
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:6920 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S932414AbVLATh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:37:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.15-rc3-mm1] PCI Quirk: 1K I/O Space Granularity on Intel P64H2
Date: Thu, 1 Dec 2005 14:37:03 -0500
Message-ID: <94C8C9E8B25F564F95185BDA64AB05F60298EA04@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15-rc3-mm1] PCI Quirk: 1K I/O Space Granularity on Intel P64H2
Thread-Index: AcX2rpsEvFi0eCaPSLiExGVKIYYfuA==
From: "Yeisley, Dan P." <dan.yeisley@unisys.com>
To: <linux-kernel@vger.kernel.org>
Cc: <gregkh@suse.de>, <akpm@osdl.org>
X-OriginalArrivalTime: 01 Dec 2005 19:37:04.0492 (UTC) FILETIME=[9B9542C0:01C5F6AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've implemented a quirk to take advantage of the 1KB I/O space
granularity option on the Intel P64H2 PCI Bridge.  I had to change
probe.c because it sets the resource start and end to be aligned on 4k
boundaries (after the quirk sets them to 1k boundaries).  I've tested
this patch on a Unisys ES7000-600 both with and without the 1KB option
enabled.  I also tested this on a 2 processor Dell box that doesn't have
a P64H2 to make sure there were no negative affects there.

Signed-off-by: Dan Yeisley <dan.yeisley@unisys.com>
---


diff -Naur linux-a/drivers/pci/probe.c linux-b/drivers/pci/probe.c
--- linux-a/drivers/pci/probe.c	2005-12-01 01:07:30.000000000 -0800
+++ linux-b/drivers/pci/probe.c	2005-11-30 05:13:41.000000000 -0800
@@ -264,8 +264,10 @@
 
 	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) |
IORESOURCE_IO;
-		res->start = base;
-		res->end = limit + 0xfff;
+		if(!res->start)
+			res->start = base;
+		if(!res->end)
+			res->end = limit + 0xfff;
 	}
 
 	res = child->resource[1];
diff -Naur linux-a/drivers/pci/quirks.c linux-b/drivers/pci/quirks.c
--- linux-a/drivers/pci/quirks.c	2005-12-01 01:07:30.000000000
-0800
+++ linux-b/drivers/pci/quirks.c	2005-12-01 01:10:41.000000000
-0800
@@ -1312,6 +1312,35 @@
 	pci_do_fixups(dev, start, end);
 }
 
+/*
+** Intel P64H2 PCI Bridge
+** 	Enable 1k I/O space granularity
+*/
+static void __devinit quirk_p64h2_1k_io(struct pci_dev *dev)
+{
+	u16 en1k;
+	u8 io_base_lo, io_limit_lo;
+	unsigned long base, limit;
+	struct resource *res = dev->resource + PCI_BRIDGE_RESOURCES;
+
+	pci_read_config_word(dev, 0x40, &en1k);
+
+	if(en1k & 0x200) {
+		printk(KERN_INFO "PCI: Enable I/O Space to 1 KB
Granularity\n");
+
+		pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
+		pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
+		base = (io_base_lo & (PCI_IO_RANGE_MASK | 0x0c)) << 8;
+		limit = (io_limit_lo & (PCI_IO_RANGE_MASK | 0x0c)) << 8;
+
+		if(base <= limit) {
+			res->start = base;
+			res->end = limit + 0x3ff;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,
quirk_p64h2_1k_io);
+
 EXPORT_SYMBOL_GPL(pcie_mch_quirk);
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL_GPL(pci_fixup_device);
