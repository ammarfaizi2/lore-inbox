Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUIJWht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUIJWht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268014AbUIJWhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:37:37 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:22986 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268005AbUIJW2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:28:00 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][2/6] ide: always allocate hwif->sg_table
Date: Sat, 11 Sep 2004 00:26:28 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409110026.28497.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: always allocate hwif->sg_table

Allocate hwif->sg_table in hwif_init() so it can also be used for PIO.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-dma.c   |   11 ++---------
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-probe.c |    7 +++++++
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide.c       |    1 +
 3 files changed, 10 insertions(+), 9 deletions(-)

diff -puN drivers/ide/ide.c~ide_sg_table drivers/ide/ide.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide.c~ide_sg_table	2004-09-10 23:21:51.188415304 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide.c	2004-09-10 23:21:51.200413480 +0200
@@ -900,6 +900,7 @@ void ide_unregister(unsigned int index)
 		hwif->drives[i].disk = NULL;
 		put_disk(disk);
 	}
+	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
 	spin_lock_irq(&ide_lock);
 
diff -puN drivers/ide/ide-dma.c~ide_sg_table drivers/ide/ide-dma.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-dma.c~ide_sg_table	2004-09-10 23:21:51.190415000 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-dma.c	2004-09-10 23:21:51.202413176 +0200
@@ -869,10 +869,6 @@ int ide_release_dma_engine (ide_hwif_t *
 				    hwif->dmatable_dma);
 		hwif->dmatable_cpu = NULL;
 	}
-	if (hwif->sg_table) {
-		kfree(hwif->sg_table);
-		hwif->sg_table = NULL;
-	}
 	return 1;
 }
 
@@ -905,15 +901,12 @@ int ide_allocate_dma_engine (ide_hwif_t 
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
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-probe.c~ide_sg_table	2004-09-10 23:21:51.192414696 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-probe.c	2004-09-10 23:21:51.204412872 +0200
@@ -1255,6 +1255,13 @@ static int hwif_init(ide_hwif_t *hwif)
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
