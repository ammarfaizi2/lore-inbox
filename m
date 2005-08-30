Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVH3O1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVH3O1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVH3O1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:27:17 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:5875 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932151AbVH3O1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:27:16 -0400
Message-ID: <43146CC3.4010005@gentoo.org>
Date: Tue, 30 Aug 2005 15:27:15 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bzolnier@gmail.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net,
       vsu@altlinux.ru
Subject: [PATCH] Add VIA VT6410 support
Content-Type: multipart/mixed;
 boundary="------------040009050504060302000608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040009050504060302000608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jeff/Bart,

Can of you please apply this to a git tree and get this included in 2.6.14. 
The patch is about 6 months old and has been included in Gentoo kernels for 
about 3 months, and we've recieved multiple success reports.

I sent a mail to Bart at the end of June asking about this, and Sergey Vlasov 
recently asked the same question on LKML. If the patch isn't acceptable then 
please at least say _something_ :)

Thanks!

--

From: Mathias Kretschmer <posting@blx4.net>

Add VIA VT6410 IDE support

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------040009050504060302000608
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

--------------040009050504060302000608--
