Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSFDVip>; Tue, 4 Jun 2002 17:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSFDVio>; Tue, 4 Jun 2002 17:38:44 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:49042 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316835AbSFDVii>; Tue, 4 Jun 2002 17:38:38 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 4 Jun 2002 14:37:55 -0700
Message-Id: <200206042137.OAA00695@adam.yggdrasil.com>
To: zlatko.calusic@iskon.hr
Subject: Re: IDE{,-SCSI} trouble [2.5.20]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I sent Martin Dalecki a patch for a null pointer dereference
problem that the ide-scsi code tripped in the IDE code.  I imagine
Martin will submit it to Linus for 2.5.21.

	The IDE code was receiving some requests where
request->q == NULL and then passing request->q to routine
that dereferenced it.  My patch determined the queue another way,
and now I can read from my IDE DVD-ROM drive.

	Here is a copy of the patch, in case you are would like to
try it in the meantime.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux/include/linux/ide.h	2002-06-03 00:45:25.000000000 -0700
+++ linux-2.5.20/include/linux/ide.h	2002-06-02 18:44:43.000000000 -0700
@@ -799,7 +799,7 @@
 extern void udma_pci_irq_lost(struct ata_device *);
 extern int udma_pci_setup(struct ata_device *);
 
-extern int udma_new_table(struct ata_device *, struct request *);
+extern int udma_new_table(struct ata_channel *, struct request *);
 extern void udma_destroy_table(struct ata_channel *);
 extern void udma_print(struct ata_device *);
 
--- linux/drivers/ide/pcidma.c	2002-06-03 00:47:52.000000000 -0700
+++ linux-2.5.20/drivers/ide/pcidma.c	2002-06-02 18:44:43.000000000 -0700
@@ -58,9 +58,8 @@
  * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
  * FIXME: I agree with Jens --mdcki!
  */
-static int build_sglist(struct ata_device *drive, struct request *rq)
+static int build_sglist(struct ata_channel *ch, struct request *rq)
 {
-	struct ata_channel *ch = drive->channel;
 	struct scatterlist *sg = ch->sg_table;
 	int nents = 0;
 
@@ -70,7 +69,7 @@
 		unsigned char *virt_addr = rq->buffer;
 		int sector_count = rq->nr_sectors;
 #else
-		nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
+		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
 
 		if (nents > rq->nr_segments)
 			printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
@@ -100,7 +99,7 @@
 		sg[nents].length =  sector_count  * SECTOR_SIZE;
 		++nents;
 	} else {
-		nents = blk_rq_map_sg(&drive->queue, rq, ch->sg_table);
+		nents = blk_rq_map_sg(rq->q, rq, ch->sg_table);
 
 		if (rq->q && nents > rq->nr_phys_segments)
 			printk("ide-dma: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
@@ -151,7 +150,7 @@
 		reading = 1 << 3;
 
 	/* try PIO instead of DMA */
-	if (!udma_new_table(drive, rq))
+	if (!udma_new_table(ch, rq))
 		return 1;
 
 	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
@@ -307,9 +306,8 @@
  * This prepares a dma request.  Returns 0 if all went okay, returns 1
  * otherwise.  May also be invoked from trm290.c
  */
-int udma_new_table(struct ata_device *drive, struct request *rq)
+int udma_new_table(struct ata_channel *ch, struct request *rq)
 {
-	struct ata_channel *ch = drive->channel;
 	unsigned int *table = ch->dmatable_cpu;
 #ifdef CONFIG_BLK_DEV_TRM290
 	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
@@ -320,7 +318,7 @@
 	int i;
 	struct scatterlist *sg;
 
-	ch->sg_nents = i = build_sglist(drive, rq);
+	ch->sg_nents = i = build_sglist(ch, rq);
 	if (!i)
 		return 0;
 
--- linux/drivers/ide/hpt34x.c	2002-06-03 00:44:58.000000000 -0700
+++ linux-2.5.20/drivers/ide/hpt34x.c	2002-06-02 18:44:41.000000000 -0700
@@ -253,7 +253,7 @@
 	unsigned int count;
 	u8 cmd;
 
-	if (!(count = udma_new_table(drive, rq)))
+	if (!(count = udma_new_table(ch, rq)))
 		return 1;	/* try PIO instead of DMA */
 
 	if (rq_data_dir(rq) == READ)
--- linux/drivers/ide/trm290.c	2002-06-03 00:44:37.000000000 -0700
+++ linux-2.5.20/drivers/ide/trm290.c	2002-06-02 18:44:43.000000000 -0700
@@ -217,7 +217,7 @@
 		writing = 0;
 	}
 
-	if (!(count = udma_new_table(drive, rq))) {
+	if (!(count = udma_new_table(ch, rq))) {
 		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 		return 1;	/* try PIO instead of DMA */
 	}
--- linux/drivers/ide/icside.c	2002-06-03 00:46:21.000000000 -0700
+++ linux-2.5.20/drivers/ide/icside.c	2002-06-02 18:44:41.000000000 -0700
@@ -275,9 +275,8 @@
 #define NR_ENTRIES 256
 #define TABLE_SIZE (NR_ENTRIES * 8)
 
-static int ide_build_sglist(struct ata_device *drive, struct request *rq)
+static int ide_build_sglist(struct ata_channel *ch, struct request *rq)
 {
-	struct ata_channel *ch = drive->channel;
 	struct scatterlist *sg = ch->sg_table;
 	int nents;
 
@@ -295,7 +294,7 @@
 		sg->length = rq->nr_sectors * SECTOR_SIZE;
 		nents = 1;
 	} else {
-		nents = blk_rq_map_sg(&drive->queue, rq, sg);
+		nents = blk_rq_map_sg(rq->q, rq, sg);
 
 		if (rq->q && nents > rq->nr_phys_segments)
 			printk("icside: received %d segments, build %d\n",

