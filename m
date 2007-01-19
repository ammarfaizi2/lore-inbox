Return-Path: <linux-kernel-owner+w=401wt.eu-S932811AbXASA2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbXASA2G (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbXASA2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:28:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675AbXASA2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:28:01 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=Imb3r2twStZvdMdyvGgT5IpSEpFuMWJaXVj1fBlDQzeXCSxGTCETTBktl4tG9F6TFS6k6NNuXPw1sC2pHra+ejrTg0+nq9eoiSEfb9r2sCAity7qogNeuCQhi42pJ6sp9mX20LNmGN4AuNzq4b2KYLjXCsf2hFLjInY8EudQj9c=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2007 01:32:00 +0100
Message-Id: <20070119003200.14846.55029.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Subject: [PATCH 9/15] sgiioc4: fix sgiioc4_ide_dma_check() to enable/disable DMA properly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sgiioc4: fix sgiioc4_ide_dma_check() to enable/disable DMA properly

* use sgiioc4_ide_dma_{on,off_quietly}() instead of changing
  drive->using_dma directly
* fix warning message
* add FIXME

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/sgiioc4.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -275,21 +275,6 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 }
 
 static int
-sgiioc4_ide_dma_check(ide_drive_t * drive)
-{
-	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0) {
-		printk(KERN_INFO
-		       "Couldnot set %s in Multimode-2 DMA mode | "
-			   "Drive %s using PIO instead\n",
-		       drive->name, drive->name);
-		drive->using_dma = 0;
-	} else
-		drive->using_dma = 1;
-
-	return 0;
-}
-
-static int
 sgiioc4_ide_dma_on(ide_drive_t * drive)
 {
 	drive->using_dma = 1;
@@ -305,6 +290,17 @@ sgiioc4_ide_dma_off_quietly(ide_drive_t 
 	return HWIF(drive)->ide_dma_host_off(drive);
 }
 
+static int sgiioc4_ide_dma_check(ide_drive_t *drive)
+{
+	/* FIXME: check for available DMA modes */
+	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0) {
+		printk(KERN_WARNING "%s: couldn't set MWDMA2 mode, "
+				    "using PIO instead\n", drive->name);
+		return sgiioc4_ide_dma_off_quietly(drive);
+	} else
+		return sgiioc4_ide_dma_on(drive);
+}
+
 /* returns 1 if dma irq issued, 0 otherwise */
 static int
 sgiioc4_ide_dma_test_irq(ide_drive_t * drive)
