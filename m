Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbUL0PGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbUL0PGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbUL0PGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:06:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34971 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261893AbUL0PFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:05:52 -0500
Subject: PATCH: 2.6.10 - Add support for CSB6 RAID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104156116.20898.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:01:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serverworks chips include a raid variant that the 2.6 driver didn't
support. This enables support for this and removes a pile of #if and
other pointless obfuscations. This removes the need to use various
vendor binary only drivers for CSB6 RAID

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/ide/pci/serverworks.c linux-2.6.10/drivers/ide/pci/serverworks.c
--- linux.vanilla-2.6.10/drivers/ide/pci/serverworks.c	2004-12-25 21:15:34.000000000 +0000
+++ linux-2.6.10/drivers/ide/pci/serverworks.c	2004-12-26 18:50:17.058127504 +0000
@@ -359,11 +359,9 @@
 	else if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ||
 		 (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 		 (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
-//		u32 pioreg = 0, dmareg = 0;
 
 		/* Third Channel Test */
 		if (!(PCI_FUNC(dev->devfn) & 1)) {
-#if 1
 			struct pci_dev * findev = NULL;
 			u32 reg4c = 0;
 			findev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
@@ -375,19 +373,11 @@
 				reg4c |=  0x00000020;
 				pci_write_config_dword(findev, 0x4C, reg4c);
 			}
-#endif
 			outb_p(0x06, 0x0c00);
 			dev->irq = inb_p(0x0c01);
 #if 0
-			/* WE need to figure out how to get the correct one */
-			printk("%s: interrupt %d\n", name, dev->irq);
-			if (dev->irq != 0x0B)
-				dev->irq = 0x0B;
-#endif
-#if 0
 			printk("%s: device class (0x%04x)\n",
 				name, dev->class);
-#else
 			if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
 				dev->class &= ~0x000F0F00;
 		//		dev->class |= ~0x00000400;
@@ -413,7 +403,8 @@
 			 * interrupt pin to be set, and it is a compatibility
 			 * mode issue.
 			 */
-			dev->irq = 0;
+			if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE)
+				dev->irq = 0;
 		}
 //		pci_read_config_dword(dev, 0x40, &pioreg)
 //		pci_write_config_dword(dev, 0x40, 0x99999999);
@@ -577,9 +568,6 @@
 		d->bootable = NEVER_BOARD;
 		if (dev->resource[0].start == 0x01f1)
 			d->bootable = ON_BOARD;
-	} else {
-		if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
-			return;
 	}
 #if 0
 	if ((IDE_PCI_DEVID_EQ(d->devid, DEVID_CSB6) &&
@@ -625,10 +613,6 @@
 	.name		= "Serverworks_IDE",
 	.id_table	= svwks_pci_tbl,
 	.probe		= svwks_init_one,
-#if 0	/* FIXME: implement */
-	.suspend	= ,
-	.resume		= ,
-#endif
 };
 
 static int svwks_ide_init(void)

