Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSIEFuI>; Thu, 5 Sep 2002 01:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSIEFuI>; Thu, 5 Sep 2002 01:50:08 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:41478 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S317005AbSIEFuH>; Thu, 5 Sep 2002 01:50:07 -0400
Date: Thu, 5 Sep 2002 00:54:42 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: andre@linux-ide.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed
In-Reply-To: <1030635125.7190.116.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209050050120.20228-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch at the end of this text fixes DMA w/ LBA48 problems
on the Promise 202265 controller and probably also the 20267.  This
patch is against 2.4.20-pre5-ac2 but I suspect it should apply cleanly
against anything after 2.4.19-ac4.

Problem: LBA48 DMA stopped working on Promise 20265 some time after
    kernel version 2.4.19-ac4.  This manifested itself on systems with
    large (>137GB) hard drives; addressing above 137GB stopped working
    correctly, leading to file system errors, and after a foolish
    "e2fsck -y" operation, massive corruption.

Cause: The DMA was broken due to a bad if-statement in the function
    init_hwif_pdc202xx() in pdc202xx.c.  Because "!" binds more
    tightly than "==", the check against PCI_DEVICE_ID_PROMISE_20246
    was incorrect, which prevented the Promise controller LBA48 fix
    logic from basically ever being turned on.  Obfuscating this
    further was logic in that same function which disabled LBA48
    addressing mode for devices on the primary channel of the 20265 or
    20267.

Solution: Apply parantheses to get evaluation ordering correct.  Then
    remove duct tape which disabled LBA48 addressing.

Verification: Before this fix, inspecting
    /proc/ide/<host>/<device>/settings would show "0" for the
    "address" attribute, owing to LBA48 being off.  Just removing the
    duct tape causing this however results in a broken system (driver
    DMA completely fails).  After also fixing the if-statement, the
    system comes up successfully, the "address" attribute reads back
    as "1" (confirms LBA48 addressing on), and most importantly,
    fsck'ing the big drive comes back clean!

This problem did not exist in 2.4.19-ac4 because the code had since
then been rearranged / rewritten.  The new code harbored the bug and
the LBA48 regression.  Note: I have not tested this fix against the
Promise 20267, but I suspect (since 2.4.19-ac4 didn't hack up the
20267 either) that the same fix applies there so I deleted the duct
tape rather than just moving it.

  -Mike


diff -u -r linux-2.4.20-pre5-ac2/drivers/ide/pci/pdc202xx.c linux-2.4.20-pre5-ac2.fixed/drivers/ide/pci/pdc202xx.c
--- linux-2.4.20-pre5-ac2/drivers/ide/pci/pdc202xx.c	2002-09-05 00:09:43.000000000 -0500
+++ linux-2.4.20-pre5-ac2.fixed/drivers/ide/pci/pdc202xx.c	2002-09-05 00:16:43.000000000 -0500
@@ -952,7 +952,6 @@
 			break;
 		case PCI_DEVICE_ID_PROMISE_20267:
 		case PCI_DEVICE_ID_PROMISE_20265:
-			hwif->addressing = (hwif->channel) ? 0 : 1;
 		case PCI_DEVICE_ID_PROMISE_20263:
 		case PCI_DEVICE_ID_PROMISE_20262:
 			hwif->busproc   = &pdc202xx_tristate;
@@ -979,7 +978,7 @@
 		if (!(hwif->udma_four))
 			hwif->udma_four = (!(hwif->INB(hwif->dma_vendor3) & 0x04));
 	} else {
-		if (!hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246) {
+		if (!(hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246)) {
 			u16 mask = (hwif->channel) ? (1<<11) : (1<<10);
 			u16 CIS = 0;
 			hwif->ide_dma_begin = &pdc202xx_old_ide_dma_begin;




                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |


