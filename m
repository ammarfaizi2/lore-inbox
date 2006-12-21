Return-Path: <linux-kernel-owner+w=401wt.eu-S1423063AbWLUUYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423063AbWLUUYU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423067AbWLUUYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:24:20 -0500
Received: from usea-naimss2.unisys.com ([192.61.61.104]:4307 "EHLO
	usea-naimss2.unisys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423063AbWLUUYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:24:19 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 15:24:19 EST
Subject: [PATCH] PCI Quirk: 1k I/O space IOBL_ADR fix on P64H2
From: Daniel Yeisley <dan.yeisley@unisys.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, akpm@osdl.org
Content-Type: text/plain; charset=utf-8
Date: Thu, 21 Dec 2006 14:34:57 -0500
Message-Id: <1166729698.24861.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Dec 2006 19:54:03.0754 (UTC) FILETIME=[C4260CA0:01C72539]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an existing quirk for the kernel to use 1k IO space granularity
on the Intel P64H2.  It turns out however that pci_setup_bridge() in
drivers/pci/setup-bus.c reads in the IO base and limit address register
masks it off to the nearest 4k, and writes it back.  This causes the
kernel to be on 1k boundaries and the hardware to be 4k aligned.  The
patch below fixes the problem. 

Signed-off-by: Dan Yeisley <dan.yeisley@unisys.com>
---

diff -Naur linux-2.6.19-org/drivers/pci/quirks.c linux-2.6.19-1kio/drivers/pci/quirks.c
--- linux-2.6.19-org/drivers/pci/quirks.c	2006-11-29 16:57:37.000000000 -0500
+++ linux-2.6.19-1kio/drivers/pci/quirks.c	2006-12-21 16:13:05.000000000 -0500
@@ -1645,6 +1645,31 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io);
 
+/* Fix the IOBL_ADR for 1k I/O space granularity on the Intel P64H2 
+ * The IOBL_ADR gets re-written to 4k boundaries in pci_setup_bridge() 
+ * in drivers/pci/setup-bus.c
+ */
+static void __devinit quirk_p64h2_1k_io_fix_iobl(struct pci_dev *dev)
+{
+	u16 en1k, iobl_adr, iobl_adr_1k;
+	struct resource *res = dev->resource + PCI_BRIDGE_RESOURCES;
+
+	pci_read_config_word(dev, 0x40, &en1k);
+
+	if (en1k & 0x200) {
+		pci_read_config_word(dev, PCI_IO_BASE, &iobl_adr);
+	
+		iobl_adr_1k = iobl_adr | (res->start >> 8) | (res->end & 0xfc00);
+
+		if (iobl_adr != iobl_adr_1k) {
+			printk(KERN_INFO "PCI: Fixing P64H2 IOBL_ADR from 0x%x to 0x%x for 1 KB Granularity\n",
+				iobl_adr,iobl_adr_1k);
+			pci_write_config_word(dev, PCI_IO_BASE, iobl_adr_1k);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io_fix_iobl);
+
 /* Under some circumstances, AER is not linked with extended capabilities.
  * Force it to be linked by setting the corresponding control bit in the
  * config space.


