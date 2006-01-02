Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWABNOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWABNOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWABNOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:14:38 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:18716 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750717AbWABNOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:14:38 -0500
Message-ID: <43B92706.8010402@gentoo.org>
Date: Mon, 02 Jan 2006 13:13:42 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Jo=E3o_Esteves?= <joao.m.esteves@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via VT 6410 Raid Controller
References: <200601021253.10738.joao.m.esteves@netcabo.pt>
In-Reply-To: <200601021253.10738.joao.m.esteves@netcabo.pt>
Content-Type: multipart/mixed;
 boundary="------------060801030209000802010606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060801030209000802010606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

João Esteves wrote:
> Does anyone knows of a patch to configure VIA VT 6410 Raid controller? I'm 
> using Mandriva 2006 with kernel 2.6.12-12mdksmp and I'm not beeing able to 
> use the PATA Hdd that is connected to VT 6410.

See attachment. This has been merged into the 2.6.15 tree.

Daniel

--------------060801030209000802010606
Content-Type: text/x-patch;
 name="4300_via-vt6410.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4300_via-vt6410.patch"

diff -Naru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	2005-05-06 11:22:48 -07:00
+++ b/drivers/ide/pci/via82cxxx.c	2005-05-06 11:22:48 -07:00
@@ -79,6 +79,7 @@
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
+	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -616,24 +617,35 @@
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static ide_pci_device_t via82cxxx_chipset __devinitdata = {
-	.name		= "VP_IDE",
-	.init_chipset	= init_chipset_via82cxxx,
-	.init_hwif	= init_hwif_via82cxxx,
-	.channels	= 2,
-	.autodma	= NOAUTODMA,
-	.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
-	.bootable	= ON_BOARD,
+static ide_pci_device_t via82cxxx_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "VP_IDE",
+		.init_chipset	= init_chipset_via82cxxx,
+		.init_hwif	= init_hwif_via82cxxx,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
+		.bootable	= ON_BOARD
+	},{	/* 1 */
+		.name		= "VP_IDE",
+		.init_chipset	= init_chipset_via82cxxx,
+		.init_hwif	= init_hwif_via82cxxx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+	}
 };
 
 static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	return ide_setup_pci_device(dev, &via82cxxx_chipset);
+	return ide_setup_pci_device(dev, &via82cxxx_chipsets[id->driver_data]);
 }
 
 static struct pci_device_id via_pci_tbl[] = {
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_6410,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, via_pci_tbl);
diff -Naru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-05-06 11:22:48 -07:00
+++ b/include/linux/pci_ids.h	2005-05-06 11:22:48 -07:00
@@ -1280,6 +1280,7 @@
 #define PCI_DEVICE_ID_VIA_8703_51_0	0x3148
 #define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
 #define PCI_DEVICE_ID_VIA_XN266		0x3156
+#define PCI_DEVICE_ID_VIA_6410		0x3164
 #define PCI_DEVICE_ID_VIA_8754C_0	0x3168
 #define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_P4N333	0x3178
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/11 19:31:17+01:00 bzolnier@trik.(none) 
#   [ide via82cxxx] add VIA VT6410 support
#   
#   From: Mathias Kretschmer <posting@blx4.net>
# 
# drivers/ide/pci/via82cxxx.c
#   2005/02/11 19:31:06+01:00 bzolnier@trik.(none) +21 -9
#   [ide via82cxxx] add VIA VT6410 support
# 
# include/linux/pci_ids.h
#   2005/02/11 19:31:06+01:00 bzolnier@trik.(none) +1 -0
#   [ide via82cxxx] add VIA VT6410 support
# 

--------------060801030209000802010606--
