Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315385AbSEBTiE>; Thu, 2 May 2002 15:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315386AbSEBTiD>; Thu, 2 May 2002 15:38:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12816 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315385AbSEBTh7>; Thu, 2 May 2002 15:37:59 -0400
Message-ID: <3CD186E2.9070209@evision-ventures.com>
Date: Thu, 02 May 2002 20:35:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12: hpt34x.c:259: too few arguments to function `ide_dmaproc'
In-Reply-To: <Pine.NEB.4.44.0205022054460.21679-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: multipart/mixed;
 boundary="------------030700050205060103020404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030700050205060103020404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Uz.ytkownik Adrian Bunk napisa?:
> Just FYI:
> 
> The ide_dmaproc changes in 2.5.12 broke the compilation of hpt34x.c (I
> tried 2.5.12-dj1 but this shouldn't make a difference):


The following should do the trick.

--------------030700050205060103020404
Content-Type: text/plain;
 name="hpt34x.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpt34x.diff"

diff -ur linux-2.5.12/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.12/drivers/ide/hpt34x.c	2002-05-01 02:08:47.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-05-02 21:28:02.000000000 +0200
@@ -249,14 +249,14 @@
 						     ide_dma_off_quietly);
 }
 
-static int config_drive_xfer_rate (ide_drive_t *drive)
+static int config_drive_xfer_rate(struct ata_device *drive, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
+		if (ide_dmaproc(ide_dma_bad_drive, drive, rq)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -278,7 +278,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive)) {
+		} else if (ide_dmaproc(ide_dma_good_drive, drive, rq)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -301,7 +301,7 @@
 		dma_func = ide_dma_off;
 #endif /* CONFIG_HPT34X_AUTODMA */
 
-	return drive->channel->dmaproc(dma_func, drive);
+	return drive->channel->udma(dma_func, drive, rq);
 }
 
 /*
@@ -312,7 +312,7 @@
  * by HighPoint|Triones Technologies, Inc.
  */
 
-int hpt34x_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
+int hpt34x_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
@@ -321,7 +321,7 @@
 
 	switch (func) {
 		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
+			return config_drive_xfer_rate(drive, rq);
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
@@ -347,7 +347,7 @@
 		default:
 			break;
 	}
-	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
+	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
@@ -423,7 +423,7 @@
 		else
 			hwif->autodma = 0;
 
-		hwif->dmaproc = &hpt34x_dmaproc;
+		hwif->udma = &hpt34x_dmaproc;
 		hwif->highmem = 1;
 	} else {
 		hwif->drives[0].autotune = 1;

--------------030700050205060103020404--

