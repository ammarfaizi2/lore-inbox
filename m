Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUIHTa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUIHTa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUIHTa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:30:26 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:19415 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269321AbUIHT21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:28:27 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][3/9] ide: add ide_sg_init() helper
Date: Wed, 8 Sep 2004 21:26:49 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082126.49832.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: add ide_sg_init() helper

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/arm/icside.c |    5 +----
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-dma.c    |   10 ++--------
 linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ppc/pmac.c   |   10 ++--------
 linux-2.6.9-rc1-bk10-bzolnier/include/linux/ide.h      |    9 +++++++++
 4 files changed, 14 insertions(+), 20 deletions(-)

diff -puN drivers/ide/arm/icside.c~ide_sg_init drivers/ide/arm/icside.c
--- linux-2.6.9-rc1-bk10/drivers/ide/arm/icside.c~ide_sg_init	2004-09-05 19:51:15.566405800 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/arm/icside.c	2004-09-05 19:51:15.581403520 +0200
@@ -225,10 +225,7 @@ static void icside_build_sglist(ide_driv
 		else
 			hwif->sg_dma_direction = DMA_FROM_DEVICE;
 
-		memset(sg, 0, sizeof(*sg));
-		sg->page   = virt_to_page(rq->buffer);
-		sg->offset = offset_in_page(rq->buffer);
-		sg->length = rq->nr_sectors * SECTOR_SIZE;
+		ide_sg_init(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
 		nents = 1;
 	} else {
 		nents = blk_rq_map_sg(drive->queue, rq, sg);
diff -puN drivers/ide/ide-dma.c~ide_sg_init drivers/ide/ide-dma.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ide-dma.c~ide_sg_init	2004-09-05 19:51:15.568405496 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ide-dma.c	2004-09-05 19:51:15.583403216 +0200
@@ -256,18 +256,12 @@ int ide_raw_build_sglist(ide_drive_t *dr
 #else
 	while (sector_count > 128) {
 #endif
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = offset_in_page(virt_addr);
-		sg[nents].length = 128  * SECTOR_SIZE;
+		ide_sg_init(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
-	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = offset_in_page(virt_addr);
-	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	ide_sg_init(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
 	nents++;
 
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
diff -puN drivers/ide/ppc/pmac.c~ide_sg_init drivers/ide/ppc/pmac.c
--- linux-2.6.9-rc1-bk10/drivers/ide/ppc/pmac.c~ide_sg_init	2004-09-05 19:51:15.570405192 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/drivers/ide/ppc/pmac.c	2004-09-05 19:51:15.585402912 +0200
@@ -1611,18 +1611,12 @@ pmac_ide_raw_build_sglist(ide_drive_t *d
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	
 	if (sector_count > 128) {
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].page = virt_to_page(virt_addr);
-		sg[nents].offset = offset_in_page(virt_addr);
-		sg[nents].length = 128  * SECTOR_SIZE;
+		ide_sg_init(&sg[nents], virt_addr, 128 * SECTOR_SIZE);
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
-	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].page = virt_to_page(virt_addr);
-	sg[nents].offset = offset_in_page(virt_addr);
-	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	ide_sg_init(&sg[nents], virt_addr, sector_count * SECTOR_SIZE);
 	nents++;
    
 	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
diff -puN include/linux/ide.h~ide_sg_init include/linux/ide.h
--- linux-2.6.9-rc1-bk10/include/linux/ide.h~ide_sg_init	2004-09-05 19:51:15.573404736 +0200
+++ linux-2.6.9-rc1-bk10-bzolnier/include/linux/ide.h	2004-09-05 19:51:15.587402608 +0200
@@ -1567,6 +1567,15 @@ typedef struct ide_pci_device_s {
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 extern void ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, ide_pci_device_t *);
 
+static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
+{
+	memset(sg, 0, sizeof(*sg));
+
+	sg->page = virt_to_page(buf);
+	sg->offset = offset_in_page(buf);
+	sg->length = buflen;
+}
+
 #define BAD_DMA_DRIVE		0
 #define GOOD_DMA_DRIVE		1
 
_
