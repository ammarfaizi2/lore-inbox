Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVBGRRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVBGRRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVBGRQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:16:59 -0500
Received: from pv106075.reshsg.uci.edu ([128.195.106.75]:9117 "EHLO
	alpha.blx4.net") by vger.kernel.org with ESMTP id S261200AbVBGRQU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:16:20 -0500
Message-ID: <4207A268.3040804@blx4.net>
Date: Mon, 07 Feb 2005 09:16:24 -0800
From: Mathias Kretschmer <posting@blx4.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: VIA VT6410 IDE support for 2.6.11-rc3/via82cxxx
References: <41A2E581.2010305@blx4.net> <41A38128.90305@pobox.com> <41A3A238.3070003@blx4.net> <4206A1F5.6050305@blx4.net>
In-Reply-To: <4206A1F5.6050305@blx4.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010303050409020909040009"
X-Sanitizer: This message has been sanitized!
X-Sanitizer-URL: http://mailtools.anomy.net/
X-Sanitizer-Rev: $Id: Sanitizer.pm,v 1.83 2004/03/23 12:33:48 bre Exp $
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303050409020909040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mathias Kretschmer wrote:
> Mathias Kretschmer wrote:
> 
>> Jeff Garzik wrote:
>>
>>> Mathias Kretschmer wrote:
>>>
>>>> hi,
>>>>
>>>> I found an older version of this patch (against 2.4.22) on some 
>>>> website. After a little bit of editing it applied cleanly to 2.4.27 
>>>> (and now 2.4.28). It works fine for me on a ASUS P4P800-Deluxe with 
>>>> 4x 300GB disks.
>>>>
>>>> Maybe someone finds this patch helpful. Any reason why the original 
>>>> patch did not make it into the kernel ?
>>>
>>>
>>>
>>>
>>> Why not add it to the existing via82cxxx driver, and get better 
>>> performance and device tuning?
> 
> 
> OK, the attached patch adds support for the VIA 6410 chip to the 
> via82cxxx driver (instead of the generic driver).
> I've tested it on the board mentioned above. Works fine for me.
> 
> Cheers,
> 
> Mathias

as above, but for 2.6.11-rc3

--------------010303050409020909040009
Content-Type: text/plain;
 name="2.6.11-rc3-vt6410.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.11-rc3-vt6410.patch"

diff -ruaN linux-2.6.10/drivers/ide/pci/via82cxxx.c linux-2.6.10-vt6410/drivers/ide/pci/via82cxxx.c
--- linux-2.6.10/drivers/ide/pci/via82cxxx.c	2005-02-07 08:43:05.899657752 -0800
+++ linux-2.6.10-vt6410/drivers/ide/pci/via82cxxx.c	2005-02-07 08:47:24.001420320 -0800
@@ -79,6 +79,7 @@
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
+	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -619,24 +620,35 @@
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
+	{ /* 0 */
+		.name		= "VP_IDE",
+		.init_chipset	= init_chipset_via82cxxx,
+		.init_hwif	= init_hwif_via82cxxx,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
+		.bootable	= ON_BOARD
+	},{ /* 1 */
+                .name           = "VP_IDE",
+                .init_chipset   = init_chipset_via82cxxx,
+                .init_hwif      = init_hwif_via82cxxx,
+                .channels       = 2,
+                .autodma        = AUTODMA,
+                .enablebits     = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+                .bootable       = ON_BOARD,
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
diff -ruaN linux-2.6.10/include/linux/pci_ids.h linux-2.6.10-vt6410/include/linux/pci_ids.h
--- linux-2.6.10/include/linux/pci_ids.h	2005-02-07 08:43:10.560949128 -0800
+++ linux-2.6.10-vt6410/include/linux/pci_ids.h	2005-02-06 17:42:54.836256000 -0800
@@ -1280,6 +1280,7 @@
 #define PCI_DEVICE_ID_VIA_8703_51_0	0x3148
 #define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
 #define PCI_DEVICE_ID_VIA_XN266		0x3156
+#define PCI_DEVICE_ID_VIA_6410          0x3164
 #define PCI_DEVICE_ID_VIA_8754C_0	0x3168
 #define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_P4N333	0x3178

--------------010303050409020909040009--
