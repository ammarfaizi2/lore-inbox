Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVHHI4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVHHI4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVHHI4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:56:13 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:41346 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1750766AbVHHI4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:56:12 -0400
Date: Mon, 8 Aug 2005 12:55:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [patch] VIA VT8235 PCI quirk
Message-ID: <20050808125554.A6318@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like many other southbridges from different manufacturers, VIA VT8235
chip has two non-standard BARs for power management and SMBus
registers (see the datasheet at http://www.via.com.tw).
This new quirk routine fixes boot problem with 2.6.13-rc2/rc6 kernels
on Targa Visionary 811 Athlon64 laptop, as reported by
Mikael Pettersson <mikpe@csd.uu.se>.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

--- 2.6.13-rc6/drivers/pci/quirks.c	Sun Aug  7 12:07:40 2005
+++ linux/drivers/pci/quirks.c	Sun Aug  7 14:37:14 2005
@@ -373,6 +373,25 @@ static void __devinit quirk_vt82c686_acp
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt82c686_acpi );
 
+/*
+ * VIA VT8235 ISA Bridge: Two IO regions pointed to by words at
+ *	0x88 (128 bytes of power management registers)
+ *	0xd0 (16 bytes of SMB registers)
+ */
+static void __devinit quirk_vt8235_acpi(struct pci_dev *dev)
+{
+	u16 pm, smb;
+
+	pci_read_config_word(dev, 0x88, &pm);
+	pm &= PCI_BASE_ADDRESS_IO_MASK;
+	quirk_io_region(dev, pm, 128, PCI_BRIDGE_RESOURCES);
+
+	pci_read_config_word(dev, 0xd0, &smb);
+	smb &= PCI_BASE_ADDRESS_IO_MASK;
+	quirk_io_region(dev, smb, 16, PCI_BRIDGE_RESOURCES + 1);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,	quirk_vt8235_acpi);
+
 
 #ifdef CONFIG_X86_IO_APIC 
 
