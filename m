Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVBFXCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVBFXCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 18:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVBFXCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 18:02:22 -0500
Received: from pv106075.reshsg.uci.edu ([128.195.106.75]:13029 "EHLO
	alpha.blx4.net") by vger.kernel.org with ESMTP id S261295AbVBFXCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 18:02:09 -0500
Message-ID: <4206A1F5.6050305@blx4.net>
Date: Sun, 06 Feb 2005 15:02:13 -0800
From: Mathias Kretschmer <mathias@blx4.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041218
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA VT610 IDE support for 2.4.28 (trivial) - now for 2.4.29/via82cxxx
References: <41A2E581.2010305@blx4.net> <41A38128.90305@pobox.com> <41A3A238.3070003@blx4.net>
In-Reply-To: <41A3A238.3070003@blx4.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020805020602080501060606"
X-Sanitizer: This message has been sanitized!
X-Sanitizer-URL: http://mailtools.anomy.net/
X-Sanitizer-Rev: $Id: Sanitizer.pm,v 1.83 2004/03/23 12:33:48 bre Exp $
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020805020602080501060606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mathias Kretschmer wrote:
> Jeff Garzik wrote:
> 
>> Mathias Kretschmer wrote:
>>
>>> hi,
>>>
>>> I found an older version of this patch (against 2.4.22) on some 
>>> website. After a little bit of editing it applied cleanly to 2.4.27 
>>> (and now 2.4.28). It works fine for me on a ASUS P4P800-Deluxe with 
>>> 4x 300GB disks.
>>>
>>> Maybe someone finds this patch helpful. Any reason why the original 
>>> patch did not make it into the kernel ?
>>
>>
>>
>> Why not add it to the existing via82cxxx driver, and get better 
>> performance and device tuning?

OK, the attached patch adds support for the VIA 6410 chip to the 
via82cxxx driver (instead of the generic driver).
I've tested it on the board mentioned above. Works fine for me.

Cheers,

Mathias

--------------020805020602080501060606
Content-Type: text/plain;
 name="2.4.29-vt6410.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.29-vt6410.patch"

diff -aurN linux-2.4.29/drivers/ide/pci/via82cxxx.c linux-2.4.29-vanilla/drivers/ide/pci/via82cxxx.c
--- linux-2.4.29/drivers/ide/pci/via82cxxx.c	2003-08-25 04:44:41.000000000 -0700
+++ linux-2.4.29-vanilla/drivers/ide/pci/via82cxxx.c	2005-02-06 14:45:20.000000000 -0800
@@ -74,6 +74,7 @@
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
+	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -641,6 +642,7 @@
 static struct pci_device_id via_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_6410,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 	{ 0, },
 };
 
diff -aurN linux-2.4.29/drivers/ide/pci/via82cxxx.h linux-2.4.29-vanilla/drivers/ide/pci/via82cxxx.h
--- linux-2.4.29/drivers/ide/pci/via82cxxx.h	2003-06-13 07:51:33.000000000 -0700
+++ linux-2.4.29-vanilla/drivers/ide/pci/via82cxxx.h	2005-02-06 14:45:16.000000000 -0800
@@ -56,6 +56,19 @@
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+        },{     /* 2 */
+                .vendor         = PCI_VENDOR_ID_VIA,
+                .device         = PCI_DEVICE_ID_VIA_6410,
+                .name           = "VP_IDE",
+                .init_chipset   = init_chipset_via82cxxx,
+                .init_iops      = NULL,
+                .init_hwif      = init_hwif_via82cxxx,
+                .init_dma       = init_dma_via82cxxx,
+                .channels       = 2,
+                .autodma        = AUTODMA,
+                .enablebits     = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+                .bootable       = ON_BOARD,
+                .extra          = 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,
diff -aurN linux-2.4.29/include/linux/pci_ids.h linux-2.4.29-vanilla/include/linux/pci_ids.h
--- linux-2.4.29/include/linux/pci_ids.h	2005-01-19 06:10:12.000000000 -0800
+++ linux-2.4.29-vanilla/include/linux/pci_ids.h	2005-02-06 14:46:48.000000000 -0800
@@ -1136,6 +1136,7 @@
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_P4M266	0x3148
 #define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
+#define PCI_DEVICE_ID_VIA_6410          0x3164
 #define PCI_DEVICE_ID_VIA_P4X333	0x3168
 #define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189

--------------020805020602080501060606--
