Return-Path: <linux-kernel-owner+w=401wt.eu-S1030496AbXALEYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbXALEYA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbXALEYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:24:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030504AbXALEX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:58 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=WM+eer9DzjXLLDjeZp088HklzY1AsVfR2HaXLwgBMuLHK/PSjlflL54gFeqAeY13xGiCD7A2N2i/xI2IPCA/Y3lUl0o1+vKBHQlhPrD5n1LVGkzVrNqcx5jJYmxA7ha/oUusHL24B5dIS0L/keF46hmXYC9PbmEmkVJRSCLmwmc=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:27:35 +0100
Message-Id: <20070112042735.28794.34617.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 14/19] cs5530: small cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cs5530: small cleanup

* BUG() on unknown DMA mode in cs5530_config_dma()
* there is no need to call hwif->ide_dma_host_{off,on}() in
  cs5530_config_dma() because hwif->ide_dma_host_{off,on}()
  is called by hwif->ide_dma_off_{quietly,on}()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/cs5530.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

Index: a/drivers/ide/pci/cs5530.c
===================================================================
--- a.orig/drivers/ide/pci/cs5530.c
+++ a/drivers/ide/pci/cs5530.c
@@ -103,16 +103,13 @@ static int cs5530_config_dma (ide_drive_
 	int			unit = drive->select.b.unit;
 	ide_drive_t		*mate = &hwif->drives[unit^1];
 	struct hd_driveid	*id = drive->id;
-	unsigned int		reg, timings;
+	unsigned int		reg, timings = 0;
 	unsigned long		basereg;
 
 	/*
 	 * Default to DMA-off in case we run into trouble here.
 	 */
 	hwif->ide_dma_off_quietly(drive);
-	/* turn off DMA while we fiddle */
-	hwif->ide_dma_host_off(drive);
-	/* clear DMA_capable bit */
 
 	/*
 	 * The CS5530 specifies that two drives sharing a cable cannot
@@ -182,9 +179,8 @@ static int cs5530_config_dma (ide_drive_
 		case XFER_MW_DMA_1:	timings = 0x00012121; break;
 		case XFER_MW_DMA_2:	timings = 0x00002020; break;
 		default:
-			printk(KERN_ERR "%s: cs5530_config_dma: huh? mode=%02x\n",
-				drive->name, mode);
-			return 1;	/* failure */
+			BUG();
+			break;
 	}
 	basereg = CS5530_BASEREG(hwif);
 	reg = hwif->INL(basereg+4);		/* get drive0 config register */
@@ -199,8 +195,6 @@ static int cs5530_config_dma (ide_drive_
 		hwif->OUTL(reg,     basereg+4);	/* write drive0 config register */
 		hwif->OUTL(timings, basereg+12);	/* write drive1 config register */
 	}
-	(void) hwif->ide_dma_host_on(drive);
-	/* set DMA_capable bit */
 
 	/*
 	 * Finally, turn DMA on in software, and exit.
