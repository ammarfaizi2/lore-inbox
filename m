Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263672AbVCECXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbVCECXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbVCECJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:09:57 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:2452 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263637AbVCEBsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:references:in-reply-to:message-id:date;
        b=jBUTFlQRO8kgc0iO+KjAgMMqU6VdYxk1Nu5ZGWM1pzB2kHUG4JGjdMvMpOiFGTc0n/7KEVmgRuq1hCGli9FY5SgPq+tARLiT+VPkVaFDOHzFCSOJkJT20IJ1p3hbYnnjZqOsVX86bCBPXpTLalOZqywxzWcaEofy4sYMOTJds9M=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 02/08] ide: convert __ide_do_rw_disk() to use ide_load_taskfile()
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
References: <20050305014758.4EDB4992@htj.dyndns.org>
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Message-ID: <20050305014803.3C048CBA@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:48:08 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


02_ide_use_load_taskfile_in_do_rw_disk.patch

	Reimplements __ide_do_rw_disk() using ide_load_taskfile().
	While at it, clean up the function a little bit.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-disk.c |  163 ++++++++++++++++++++++++-------------------------------------
 1 files changed, 65 insertions(+), 98 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide-disk.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-disk.c	2005-03-05 10:46:58.305078940 +0900
+++ linux-taskfile-ng/drivers/ide/ide-disk.c	2005-03-05 10:46:58.762007508 +0900
@@ -158,114 +158,80 @@ static int lba_capacity_is_ok (struct hd
  */
 ide_startstop_t __ide_do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	unsigned int dma	= drive->using_dma;
-	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
-	ata_nsector_t		nsectors;
-
-	nsectors.all		= (u16) rq->nr_sectors;
-
-	if (hwif->no_lba48_dma && lba48 && dma) {
-		if (block + rq->nr_sectors > 1ULL << 28)
-			dma = 0;
-	}
-
-	if (!dma) {
-		ide_init_sg_cmd(drive, rq);
-		ide_map_sg(drive, rq);
-	}
+	ide_hwif_t *hwif = drive->hwif;
+	int lba48 = (drive->addressing == 1) ? 1 : 0;
+	ide_task_t task;
+	struct ata_taskfile *tf = &task.tf;
+	u8 command;
 
+	/* ALL Command Block Executions SHALL clear nIEN. */
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-
 	/* FIXME: SELECT_MASK(drive, 0) ? */
 
-	if (drive->select.b.lba) {
-		if (drive->addressing == 1) {
-			task_ioreg_t tasklets[10];
-
-			pr_debug("%s: LBA=0x%012llx\n", drive->name, block);
+	memset(&task, 0, sizeof(task));
 
-			tasklets[0] = 0;
-			tasklets[1] = 0;
-			tasklets[2] = nsectors.b.low;
-			tasklets[3] = nsectors.b.high;
-			tasklets[4] = (task_ioreg_t) block;
-			tasklets[5] = (task_ioreg_t) (block>>8);
-			tasklets[6] = (task_ioreg_t) (block>>16);
-			tasklets[7] = (task_ioreg_t) (block>>24);
-			if (sizeof(block) == 4) {
-				tasklets[8] = (task_ioreg_t) 0;
-				tasklets[9] = (task_ioreg_t) 0;
-			} else {
-				tasklets[8] = (task_ioreg_t)((u64)block >> 32);
-				tasklets[9] = (task_ioreg_t)((u64)block >> 40);
-			}
-#ifdef DEBUG
-			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
-				drive->name, tasklets[3], tasklets[2],
-				tasklets[9], tasklets[8], tasklets[7],
-				tasklets[6], tasklets[5], tasklets[4]);
-#endif
-			hwif->OUTB(tasklets[1], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[3], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[7], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[8], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[9], IDE_HCYL_REG);
-
-			hwif->OUTB(tasklets[0], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[2], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[4], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[5], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[6], IDE_HCYL_REG);
-			hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
-		} else {
-			hwif->OUTB(0x00, IDE_FEATURE_REG);
-			hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-			hwif->OUTB(block, IDE_SECTOR_REG);
-			hwif->OUTB(block>>=8, IDE_LCYL_REG);
-			hwif->OUTB(block>>=8, IDE_HCYL_REG);
-			hwif->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
-		}
+	if (drive->select.b.lba) {
+		/* LBA28/LBA48 */
+		tf->flags	|= ATA_TFLAG_OUT_ADDR | ATA_TFLAG_OUT_DEVICE;
+		tf->nsect	= rq->nr_sectors;
+		tf->lbal	= block;
+		tf->lbam	= block >> 8;
+		tf->lbah	= block >> 16;
+
+		if (lba48) {
+			tf->flags	|= ATA_TFLAG_OUT_LBA48;
+			tf->hob_nsect	= rq->nr_sectors >> 8;
+			tf->hob_lbal	= block >> 24;
+			tf->hob_lbam	= block >> 32;
+			tf->hob_lbah	= block >> 40;
+		} else
+			tf->device	= (block >> 24) & 0xf;
 	} else {
-		unsigned int sect,head,cyl,track;
-		track = (int)block / drive->sect;
-		sect  = (int)block % drive->sect + 1;
-		hwif->OUTB(sect, IDE_SECTOR_REG);
-		head  = track % drive->head;
-		cyl   = track / drive->head;
-
-		pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
-
-		hwif->OUTB(0x00, IDE_FEATURE_REG);
-		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-		hwif->OUTB(cyl, IDE_LCYL_REG);
-		hwif->OUTB(cyl>>8, IDE_HCYL_REG);
-		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
-	}
-
-	if (dma) {
-		if (!hwif->dma_setup(drive)) {
-			if (rq_data_dir(rq)) {
-				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-				if (drive->vdma)
-					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
-			} else {
-				command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
-				if (drive->vdma)
-					command = lba48 ? WIN_READ_EXT: WIN_READ;
-			}
-			hwif->dma_exec_cmd(drive, command);
-			hwif->dma_start(drive);
-			return ide_started;
+		/* CHS */
+		int track	= (int)block / drive->sect;
+		int cyl		= track / drive->head;
+		int head	= track % drive->head;
+		int sect	= (int)block % drive->sect + 1;
+
+		tf->flags	|= ATA_TFLAG_OUT_ADDR | ATA_TFLAG_OUT_DEVICE;
+		tf->nsect	= rq->nr_sectors;
+		tf->lbal	= sect;
+		tf->lbam	= cyl;
+		tf->lbah	= cyl >> 8;
+		tf->device	= head;
+	}
+
+	tf->device |= drive->select.all;
+
+	ide_load_taskfile(drive, &task);
+
+	if (drive->using_dma &&
+	    !(hwif->no_lba48_dma && block + rq->nr_sectors > 1ULL << 28)) {
+		/* DMA */
+		if (hwif->dma_setup(drive))
+			goto fallback_to_pio;
+		if (rq_data_dir(rq) == READ) {
+			command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
+			if (drive->vdma)
+				command = lba48 ? WIN_READ_EXT : WIN_READ;
+		} else {
+			command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+			if (drive->vdma)
+				command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 		}
-		/* fallback to PIO */
-		ide_init_sg_cmd(drive, rq);
+		hwif->dma_exec_cmd(drive, command);
+		hwif->dma_start(drive);
+		return ide_started;
 	}
 
-	if (rq_data_dir(rq) == READ) {
+	/* PIO */
+	ide_map_sg(drive, rq);
+	/* dma_setup() has already done ide_map_sg(). */
+ fallback_to_pio:
+	ide_init_sg_cmd(drive, rq);
 
+	if (rq_data_dir(rq) == READ) {
 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_IN;
 			command = lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
@@ -274,7 +240,8 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 			command = lba48 ? WIN_READ_EXT : WIN_READ;
 		}
 
-		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
+		ide_execute_command(drive, command, &task_in_intr,
+				    WAIT_CMD, NULL);
 		return ide_started;
 	} else {
 		if (drive->mult_count) {
