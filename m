Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUIHTkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUIHTkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUIHTi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:38:27 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:19415 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269319AbUIHT2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:28:22 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][4/9] ide: always allocate hwif->sg_table
Date: Wed, 8 Sep 2004 21:26:53 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082126.53365.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: always allocate hwif->sg_table

Allocate hwif->sg_table in hwif_init() so it can also be used for PIO.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-dma.c   |   11 ++---------
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-probe.c |    7 +++++++
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide.c       |    1 +
 3 files changed, 10 insertions(+), 9 deletions(-)

diff -puN drivers/ide/ide.c~ide_sg_table drivers/ide/ide.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide.c~ide_sg_table	2004-09-05 19:52:40.773452360 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide.c	2004-09-05 19:52:40.785450536 +0200
@@ -870,6 +870,7 @@ void ide_unregister(unsigned int index)
 		hwif->drives[i].disk = NULL;
 		put_disk(disk);
 	}
+	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
 	spin_lock_irq(&ide_lock);
 
diff -puN drivers/ide/ide-dma.c~ide_sg_table drivers/ide/ide-dma.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-dma.c~ide_sg_table	2004-09-05 19:52:40.775452056 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-dma.c	2004-09-05 19:52:40.787450232 +0200
@@ -868,10 +868,6 @@ int ide_release_dma_engine (ide_hwif_t *
 				    hwif->dmatable_dma);
 		hwif->dmatable_cpu = NULL;
 	}
-	if (hwif->sg_table) {
-		kfree(hwif->sg_table);
-		hwif->sg_table = NULL;
-	}
 	return 1;
 }
 
@@ -904,15 +900,12 @@ int ide_allocate_dma_engine (ide_hwif_t 
 	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
 						  PRD_ENTRIES * PRD_BYTES,
 						  &hwif->dmatable_dma);
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
-				GFP_KERNEL);
 
-	if ((hwif->dmatable_cpu) && (hwif->sg_table))
+	if (hwif->dmatable_cpu)
 		return 0;
 
-	printk(KERN_ERR "%s: -- Error, unable to allocate%s%s table(s).\n",
+	printk(KERN_ERR "%s: -- Error, unable to allocate%s DMA table(s).\n",
 		(hwif->dmatable_cpu == NULL) ? " CPU" : "",
-		(hwif->sg_table == NULL) ?  " SG DMA" : " DMA",
 		hwif->cds->name);
 
 	ide_release_dma_engine(hwif);
diff -puN drivers/ide/ide-probe.c~ide_sg_table drivers/ide/ide-probe.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-probe.c~ide_sg_table	2004-09-05 19:52:40.778451600 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-probe.c	2004-09-05 19:52:40.788450080 +0200
@@ -1251,6 +1251,13 @@ static int hwif_init(ide_hwif_t *hwif)
 	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
 
+	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
+				 GFP_KERNEL);
+	if (!hwif->sg_table) {
+		printk(KERN_ERR "%s: unable to allocate SG table.\n", hwif->name);
+		goto out;
+	}
+
 	if (alloc_disks(hwif) < 0)
 		goto out;
 	
_
