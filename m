Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWINM3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWINM3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 08:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWINM3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 08:29:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38792 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751273AbWINM3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 08:29:23 -0400
Subject: [PATCH] zoran: Implement pcipci failure check
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mchehab@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Sep 2006 13:53:03 +0100
Message-Id: <1158238383.21860.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should be doing this on all devices doing PCI<->PCI DMA. We only set
the _FAIL ones when the DMA will fail or may cause crashes. This relies
on the PCIAGP_FAIL patch I sent to Andrew already

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c linux-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c	2006-09-11 17:00:12.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/zoran_card.c	2006-09-13 11:56:42.000000000 +0100
@@ -1620,10 +1620,10 @@
 	dprintk(5, KERN_DEBUG "Jotti is een held!\n");
 
 	/* some mainboards might not do PCI-PCI data transfer well */
-	if (pci_pci_problems & PCIPCI_FAIL) {
+	if (pci_pci_problems & (PCIPCI_FAIL|PCIAGP_FAIL|PCIPCI_ALIMAGIK)) {
 		dprintk(1,
 			KERN_WARNING
-			"%s: chipset may not support reliable PCI-PCI DMA\n",
+			"%s: chipset does not support reliable PCI-PCI DMA\n",
 			ZORAN_NAME);
 	}
 
@@ -1631,7 +1631,7 @@
 	for (i = 0; i < zoran_num; i++) {
 		struct zoran *zr = &zoran[i];
 
-		if (pci_pci_problems & PCIPCI_NATOMA && zr->revision <= 1) {
+		if ((pci_pci_problems & PCIPCI_NATOMA) && zr->revision <= 1) {
 			zr->jpg_buffers.need_contiguous = 1;
 			dprintk(1,
 				KERN_INFO
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zoran_driver.c linux-2.6.18-rc6-mm1/drivers/media/video/zoran_driver.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zoran_driver.c	2006-09-11 17:00:12.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/zoran_driver.c	2006-09-13 12:21:39.000000000 +0100
@@ -1511,6 +1511,13 @@
 	/* (Ronald) v4l/v4l2 guidelines */
 	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
+		
+	/* Don't allow frame buffer overlay if PCI or AGP is buggy, or on
+	   ALi Magik (that needs very low latency while the card needs a 
+	   higher value always) */
+	
+	if (pci_pci_problems & (PCIPCI_FAIL | PCIAGP_FAIL | PCIPCI_ALIMAGIK))
+		return -ENXIO;
 
 	/* we need a bytesperline value, even if not given */
 	if (!bytesperline)

