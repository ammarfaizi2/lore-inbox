Return-Path: <linux-kernel-owner+w=401wt.eu-S1030503AbXALEYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbXALEYr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbXALEYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030514AbXALEYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:24:17 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=igzZPVG1lA0x0HR3NtyzmD1mhqDiOz7tzn0aJQHf4ddQWPFKKAwhZz0UoMtw28G6GFaowJAIeUUm3aEUs6qMQo7UjqeN5d/YwfFHe7DixGzxQdQd/dtwAJd9vGC6DsLR4OhLWqPgaxZaUxlK0AJLkQa4Gb2oxI2XzuX7I2Wm3fw=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:53 +0100
Message-Id: <20070112042753.28794.89093.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 17/19] ide: unexport ide_set_xfer_rate()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: unexport ide_set_xfer_rate()

In cmd64x and siimage drivers:
* don't set drive->init_speed as it should be already
  set by successful execution of ide_set_xfer_rate()
* use hwif->speedproc functions directly

Above changes allows removal of EXPORT_SYMBOL_GPL(ide_set_xfer_rate).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide-lib.c     |    2 --
 drivers/ide/pci/cmd64x.c  |    7 ++-----
 drivers/ide/pci/siimage.c |    5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

Index: a/drivers/ide/ide-lib.c
===================================================================
--- a.orig/drivers/ide/ide-lib.c
+++ a/drivers/ide/ide-lib.c
@@ -459,8 +459,6 @@ int ide_set_xfer_rate(ide_drive_t *drive
 		return -1;
 }
 
-EXPORT_SYMBOL_GPL(ide_set_xfer_rate);
-
 static void ide_dump_opcode(ide_drive_t *drive)
 {
 	struct request *rq;
Index: a/drivers/ide/pci/cmd64x.c
===================================================================
--- a.orig/drivers/ide/pci/cmd64x.c
+++ a/drivers/ide/pci/cmd64x.c
@@ -466,11 +466,8 @@ static int config_chipset_for_dma (ide_d
 	if (!speed)
 		return 0;
 
-	if(ide_set_xfer_rate(drive, speed))
-		return 0; 
-
-	if (!drive->init_speed)
-		drive->init_speed = speed;
+	if (cmd64x_tune_chipset(drive, speed))
+		return 0;
 
 	return ide_dma_enable(drive);
 }
Index: a/drivers/ide/pci/siimage.c
===================================================================
--- a.orig/drivers/ide/pci/siimage.c
+++ a/drivers/ide/pci/siimage.c
@@ -397,12 +397,9 @@ static int config_chipset_for_dma (ide_d
 	if (!speed)
 		return 0;
 
-	if (ide_set_xfer_rate(drive, speed))
+	if (siimage_tune_chipset(drive, speed))
 		return 0;
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
-
 	return ide_dma_enable(drive);
 }
 
