Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVBFL2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVBFL2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVBFL2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:28:22 -0500
Received: from [211.58.254.17] ([211.58.254.17]:59326 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261192AbVBFL06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:26:58 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 02/04] ide: __ide_do_rw_disk() rewritten ide_write_taskfile().
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <20050206112628.GA31274@htj.dyndns.org>
References: <20050206112628.GA31274@htj.dyndns.org>
Message-Id: <20050206112655.13A7C132648@htj.dyndns.org>
Date: Sun,  6 Feb 2005 20:26:55 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


02_ide_do_rw_disk_use_write_taskfile.patch

	__ide_do_rw_disk() rewritten using ide_write_taskfile().


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series3-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-series3-export.orig/drivers/ide/ide-disk.c	2005-02-06 19:48:58.744269198 +0900
+++ linux-ide-series3-export/drivers/ide/ide-disk.c	2005-02-06 19:49:19.141955368 +0900
@@ -119,118 +119,80 @@ static int lba_capacity_is_ok (struct hd
 /*
  * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
- * It also takes care of issuing special DRIVE_CMDs.
  */
-ide_startstop_t __ide_do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
+ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block)
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
-
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned long *ports = drive->hwif->io_ports;
+	int lba48 = drive->addressing == 1;
+	ide_task_t task;
+	task_ioreg_t *tf = task.tfRegister, *hob = task.hobRegister;
+	task_ioreg_t command;
+
+	/* ALL Command Block Executions SHALL clear nIEN. */
+	if (ports[IDE_CONTROL_OFFSET])
+		hwif->OUTB(drive->ctl, ports[IDE_CONTROL_OFFSET]);
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
+		tf[IDE_NSECTOR_OFFSET]	= rq->nr_sectors;
+		tf[IDE_SECTOR_OFFSET]	= block;
+		tf[IDE_LCYL_OFFSET]	= block >> 8;
+		tf[IDE_HCYL_OFFSET]	= block >> 16;
+
+		if (lba48) {
+			hob[IDE_NSECTOR_OFFSET]	= rq->nr_sectors >> 8;
+			hob[IDE_SECTOR_OFFSET]	= block >> 24;
+			hob[IDE_LCYL_OFFSET]	= block >> 32;
+			hob[IDE_HCYL_OFFSET]	= block >> 40;
+		} else
+			tf[IDE_SELECT_OFFSET]	= (block >> 24) & 0xf;
 	} else {
-		unsigned int sect,head,cyl,track;
-		track = (int)block / drive->sect;
-		sect  = (int)block % drive->sect + 1;
-		hwif->OUTB(sect, IDE_SECTOR_REG);
-		head  = track % drive->head;
-		cyl   = track / drive->head;
+		/* CHS */
+		task_ioreg_t track	= (int)block / drive->sect;
+		task_ioreg_t cyl	= track / drive->head;
+		task_ioreg_t head	= track % drive->head;
+		task_ioreg_t sect	= (int)block % drive->sect + 1;
 
 		pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
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
+		tf[IDE_NSECTOR_OFFSET]	= rq->nr_sectors;
+		tf[IDE_SECTOR_OFFSET]	= sect;
+		tf[IDE_LCYL_OFFSET]	= cyl;
+		tf[IDE_HCYL_OFFSET]	= cyl >> 8;
+		tf[IDE_SELECT_OFFSET]	= head;
+	}
+
+	ide_write_taskfile(drive, &task);
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
@@ -239,7 +201,8 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 			command = lba48 ? WIN_READ_EXT : WIN_READ;
 		}
 
-		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
+		ide_execute_command(drive, command, &task_in_intr,
+				    WAIT_CMD, NULL);
 		return ide_started;
 	} else {
 		if (drive->mult_count) {
@@ -251,11 +214,11 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		}
 
 		/* FIXME: ->OUTBSYNC ? */
-		hwif->OUTB(command, IDE_COMMAND_REG);
-
+		hwif->OUTB(command, ports[IDE_COMMAND_OFFSET]);
 		return pre_task_out_intr(drive, rq);
 	}
 }
+
 EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
 
 /*
