Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUIJWht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUIJWht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUIJWhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:37:18 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:19914 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268003AbUIJW1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:27:41 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][1/6] add sg_init_one() helper and teach ide about it
Date: Sat, 11 Sep 2004 00:26:23 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409110026.23714.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] add sg_init_one() helper and teach ide about it

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk16-bzolnier/arch/cris/arch-v10/drivers/ide.c |    8 +----
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/arm/icside.c         |    6 +---
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-dma.c            |   11 ++-----
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ppc/pmac.c           |   11 ++-----
 linux-2.6.9-rc1-bk16-bzolnier/include/linux/scatterlist.h      |   14 ++++++++++
 5 files changed, 24 insertions(+), 26 deletions(-)

diff -puN arch/cris/arch-v10/drivers/ide.c~sg_init_one arch/cris/arch-v10/drivers/ide.c
--- linux-2.6.9-rc1-bk16/arch/cris/arch-v10/drivers/ide.c~sg_init_one	2004-09-10 23:08:58.664856736 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/arch/cris/arch-v10/drivers/ide.c	2004-09-10 23:14:20.366950584 +0200
@@ -30,6 +30,7 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/init.h>
+#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/arch/svinto.h>
@@ -624,12 +625,7 @@ static int e100_ide_build_dmatable (ide_
 	ata_tot_size = 0;
 
 	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
-		u8 *virt_addr = rq->buffer;
-		int sector_count = rq->nr_sectors;
-		memset(&sg[0], 0, sizeof(*sg));
-		sg[0].page = virt_to_page(virt_addr);
-		sg[0].offset = offset_in_page(virt_addr);
-		sg[0].length =  sector_count  * SECTOR_SIZE;
+		sg_init_one(&sg[0], rq->buffer, rq->nr_sectors * SECTOR_SIZE);
 		hwif->sg_nents = i = 1;
 	}
 	else
diff -puN drivers/ide/arm/icside.c~sg_init_one drivers/ide/arm/icside.c
--- linux-2.6.9-rc1-bk16/drivers/ide/arm/icside.c~sg_init_one	2004-09-10 23:03:38.788485336 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/arm/icside.c	2004-09-10 23:14:45.172179616 +0200
@@ -16,6 +16,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/scatterlist.h>
 
 #include <asm/dma.h>
 #include <asm/ecard.h>
@@ -225,10 +226,7 @@ static void icside_build_sglist(ide_driv
 		else
 			hwif->sg_dma_direction = DMA_FROM_DEVICE;
 
-		memset(sg, 0, sizeof(*sg));
-		sg->page   = virt_to_page(rq->buffer);
-		sg->offset = offset_in_page(rq->buffer);
-		sg->length = rq->nr_sectors * SECTOR_SIZE;
+		sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
 		nents = 1;
 	} else {
 		nents = blk_rq_map_sg(drive->queue, rq, sg);
diff -puN drivers/ide/ide-dma.c~sg_init_one drivers/ide/ide-dma.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-dma.c~sg_init_one	2004-09-10 23:03:38.790485032 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-dma.c	2004-09-10 23:15:02.592531320 +0200
@@ -85,6 +85,7 @@
 #include <linux/init.h>
 #include <linux/ide.h>
 #include <linux/delay.h>
+#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -256,18 +257,12 @@ int ide_raw_build_sglist(ide_drive_t *dr
 #else
 	while (sector_count > 128) {
 #endif
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = offset_in_page(virt_addr);
-		sg[nents].length = 128  * SECTOR_SIZE;
+		sg_init_one(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
-	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = offset_in_page(virt_addr);
-	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	sg_init_one(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
 	nents++;
 
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
diff -puN drivers/ide/ppc/pmac.c~sg_init_one drivers/ide/ppc/pmac.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ppc/pmac.c~sg_init_one	2004-09-10 23:03:38.793484576 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ppc/pmac.c	2004-09-10 23:15:28.155645136 +0200
@@ -34,6 +34,7 @@
 #include <linux/pci.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/scatterlist.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -1611,18 +1612,12 @@ pmac_ide_raw_build_sglist(ide_drive_t *d
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	
 	if (sector_count > 128) {
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = offset_in_page(virt_addr);
-		sg[nents].length = 128  * SECTOR_SIZE;
+		sg_init_one(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
-	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = offset_in_page(virt_addr);
-	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	sg_init_one(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
 	nents++;
    
 	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
diff -puN /dev/null include/linux/scatterlist.h
--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6.9-rc1-bk16-bzolnier/include/linux/scatterlist.h	2004-09-10 23:20:54.718000112 +0200
@@ -0,0 +1,14 @@
+#ifndef _LINUX_SCATTERLIST_H
+#define _LINUX_SCATTERLIST_H
+
+static inline void sg_init_one(struct scatterlist *sg,
+			       u8 *buf, unsigned int buflen)
+{
+	memset(sg, 0, sizeof(*sg));
+
+	sg->page = virt_to_page(buf);
+	sg->offset = offset_in_page(buf);
+	sg->length = buflen;
+}
+
+#endif /* _LINUX_SCATTERLIST_H */
_
