Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUIJWhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUIJWhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUIJWgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:36:54 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:19914 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S267992AbUIJW1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:27:41 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][3/6] ide: sg PIO for taskfile requests
Date: Sat, 11 Sep 2004 00:26:32 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409110026.33043.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch] ide: sg PIO for taskfile requests

Use scatterlist for taskfile based PIO transfers
instead of directly walking rq->bio/cbio list.

This code can be also used for fs requests
but only if CONFIG_IDE_TASKFILE_IO is defined.

ide-taskfile.c:ide_pio_sector() is based on
libata-core.c:ata_pio_sector() so kudos to Jeff!

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-disk.c     |    7 
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-io.c       |   28 ++
 linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-taskfile.c |  144 ++++++---------
 linux-2.6.9-rc1-bk16-bzolnier/include/linux/ide.h        |   36 ---
 4 files changed, 102 insertions(+), 113 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_tf_sg_pio drivers/ide/ide-disk.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-disk.c~ide_tf_sg_pio	2004-09-10 23:22:19.477114768 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-disk.c	2004-09-10 23:44:34.073225320 +0200
@@ -504,6 +504,9 @@ static u8 get_command(ide_drive_t *drive
 			dma = 0;
 	}
 
+	if (!dma)
+		ide_init_sg_cmd(drive, rq);
+
 	if (rq_data_dir(rq) == READ) {
 		task->command_type = IDE_DRIVE_TASK_IN;
 		if (dma)
@@ -767,10 +770,6 @@ ide_startstop_t idedisk_error (ide_drive
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;
 	}
-#ifdef CONFIG_IDE_TASKFILE_IO
-	/* make rq completion pointers new submission pointers */
-	blk_rq_prep_restart(rq);
-#endif
 
 	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) {
 		/* other bits are useless when BUSY */
diff -puN drivers/ide/ide-io.c~ide_tf_sg_pio drivers/ide/ide-io.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-io.c~ide_tf_sg_pio	2004-09-10 23:22:19.479114464 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-io.c	2004-09-10 23:32:45.840893000 +0200
@@ -47,6 +47,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/kmod.h>
+#include <linux/scatterlist.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -672,6 +673,23 @@ ide_startstop_t do_special (ide_drive_t 
 
 EXPORT_SYMBOL(do_special);
 
+void ide_init_sg_cmd(ide_drive_t *drive, struct request *rq)
+{
+	ide_hwif_t *hwif = drive->hwif;
+
+	hwif->nsect = hwif->nleft = rq->nr_sectors;
+	hwif->cursg = hwif->cursg_ofs = 0;
+
+	if (blk_fs_request(rq)) {
+		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, hwif->sg_table);
+	} else {
+		sg_init_one(hwif->sg_table, rq->buffer, rq->nr_sectors);
+		hwif->sg_nents = 1;
+	}
+}
+
+EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
+
 /**
  *	execute_drive_command	-	issue special drive command
  *	@drive: the drive to issue th command on
@@ -695,6 +713,16 @@ ide_startstop_t execute_drive_cmd (ide_d
 
 		hwif->data_phase = args->data_phase;
 
+		switch (hwif->data_phase) {
+		case TASKFILE_MULTI_OUT:
+		case TASKFILE_OUT:
+		case TASKFILE_MULTI_IN:
+		case TASKFILE_IN:
+			ide_init_sg_cmd(drive, rq);
+		default:
+			break;
+		}
+
 		if (args->tf_out_flags.all != 0) 
 			return flagged_taskfile(drive, args);
 		return do_rw_taskfile(drive, args);
diff -puN drivers/ide/ide-taskfile.c~ide_tf_sg_pio drivers/ide/ide-taskfile.c
--- linux-2.6.9-rc1-bk16/drivers/ide/ide-taskfile.c~ide_tf_sg_pio	2004-09-10 23:22:19.482114008 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/drivers/ide/ide-taskfile.c	2004-09-10 23:45:02.347926912 +0200
@@ -5,7 +5,7 @@
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2001-2002	Klaus Smolin
  *					IBM Storage Technology Division
- *  Copyright (C) 2003		Bartlomiej Zolnierkiewicz
+ *  Copyright (C) 2003-2004	Bartlomiej Zolnierkiewicz
  *
  *  The big the bad and the ugly.
  *
@@ -281,73 +281,6 @@ ide_startstop_t task_no_data_intr (ide_d
 
 EXPORT_SYMBOL(task_no_data_intr);
 
-static void task_buffer_sectors(ide_drive_t *drive, struct request *rq,
-				unsigned nsect, unsigned rw)
-{
-	char *buf = rq->buffer + blk_rq_offset(rq);
-
-	rq->sector += nsect;
-	rq->current_nr_sectors -= nsect;
-	rq->nr_sectors -= nsect;
-	__task_sectors(drive, buf, nsect, rw);
-}
-
-static inline void task_buffer_multi_sectors(ide_drive_t *drive,
-					     struct request *rq, unsigned rw)
-{
-	unsigned int msect = drive->mult_count, nsect;
-
-	nsect = rq->current_nr_sectors;
-	if (nsect > msect)
-		nsect = msect;
-
-	task_buffer_sectors(drive, rq, nsect, rw);
-}
-
-#ifdef CONFIG_IDE_TASKFILE_IO
-static void task_sectors(ide_drive_t *drive, struct request *rq,
-			 unsigned nsect, unsigned rw)
-{
-	if (rq->cbio) {	/* fs request */
-		rq->errors = 0;
-		task_bio_sectors(drive, rq, nsect, rw);
-	} else		/* task request */
-		task_buffer_sectors(drive, rq, nsect, rw);
-}
-
-static inline void task_bio_multi_sectors(ide_drive_t *drive,
-					  struct request *rq, unsigned rw)
-{
-	unsigned int nsect, msect = drive->mult_count;
-
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-
-		task_bio_sectors(drive, rq, nsect, rw);
-
-		if (!rq->nr_sectors)
-			msect = 0;
-		else
-			msect -= nsect;
-	} while (msect);
-}
-
-static void task_multi_sectors(ide_drive_t *drive,
-			       struct request *rq, unsigned rw)
-{
-	if (rq->cbio) {	/* fs request */
-		rq->errors = 0;
-		task_bio_multi_sectors(drive, rq, rw);
-	} else		/* task request */
-		task_buffer_multi_sectors(drive, rq, rw);
-}
-#else
-# define task_sectors(d, rq, nsect, rw)	task_buffer_sectors(d, rq, nsect, rw)
-# define task_multi_sectors(d, rq, rw)	task_buffer_multi_sectors(d, rq, rw)
-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -368,16 +301,65 @@ static u8 wait_drive_not_busy(ide_drive_
 	return stat;
 }
 
+static void ide_pio_sector(ide_drive_t *drive, unsigned int write)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct scatterlist *sg = hwif->sg_table;
+	struct page *page;
+#ifdef CONFIG_HIGHMEM
+	unsigned long flags;
+#endif
+	u8 *buf;
+
+	page = sg[hwif->cursg].page;
+#ifdef CONFIG_HIGHMEM
+	local_irq_save(flags);
+#endif
+	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) +
+	      sg[hwif->cursg].offset + (hwif->cursg_ofs * SECTOR_SIZE);
+
+	hwif->nleft--;
+	hwif->cursg_ofs++;
+
+	if ((hwif->cursg_ofs * SECTOR_SIZE) == sg[hwif->cursg].length) {
+		hwif->cursg++;
+		hwif->cursg_ofs = 0;
+	}
+
+	/* do the actual data transfer */
+	if (write)
+		taskfile_output_data(drive, buf, SECTOR_WORDS);
+	else
+		taskfile_input_data(drive, buf, SECTOR_WORDS);
+
+	kunmap_atomic(page, KM_BIO_SRC_IRQ);
+#ifdef CONFIG_HIGHMEM
+	local_irq_restore(flags);
+#endif
+}
+
+static void ide_pio_multi(ide_drive_t *drive, unsigned int write)
+{
+	unsigned int nsect;
+
+	nsect = min_t(unsigned int, drive->hwif->nleft, drive->mult_count);
+	while (nsect--)
+		ide_pio_sector(drive, write);
+}
+
 static inline void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
+	if (rq->bio)	/* fs request */
+		rq->errors = 0;
+
 	switch (drive->hwif->data_phase) {
 	case TASKFILE_MULTI_IN:
 	case TASKFILE_MULTI_OUT:
-		task_multi_sectors(drive, rq, write);
+		ide_pio_multi(drive, write);
 		break;
 	default:
-		task_sectors(drive, rq, 1, write);
+		ide_pio_sector(drive, write);
 		break;
 	}
 }
@@ -387,18 +369,19 @@ static ide_startstop_t task_error(ide_dr
 				  const char *s, u8 stat)
 {
 	if (rq->bio) {
-		int sectors = rq->hard_nr_sectors - rq->nr_sectors;
+		ide_hwif_t *hwif = drive->hwif;
+		int sectors = hwif->nsect - hwif->nleft;
 
-		switch (drive->hwif->data_phase) {
+		switch (hwif->data_phase) {
 		case TASKFILE_IN:
-			if (rq->nr_sectors)
+			if (hwif->nleft)
 				break;
 			/* fall through */
 		case TASKFILE_OUT:
 			sectors--;
 			break;
 		case TASKFILE_MULTI_IN:
-			if (rq->nr_sectors)
+			if (hwif->nleft)
 				break;
 			/* fall through */
 		case TASKFILE_MULTI_OUT:
@@ -435,8 +418,9 @@ static void task_end_request(ide_drive_t
  */
 ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
-	u8 stat = HWIF(drive)->INB(IDE_STATUS_REG);
+	u8 stat = hwif->INB(IDE_STATUS_REG);
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
@@ -449,7 +433,7 @@ ide_startstop_t task_in_intr (ide_drive_
 	ide_pio_datablock(drive, rq, 0);
 
 	/* If it was the last datablock check status and finish transfer. */
-	if (!rq->nr_sectors) {
+	if (!hwif->nleft) {
 		stat = wait_drive_not_busy(drive);
 		if (!OK_STAT(stat, 0, BAD_R_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
@@ -469,18 +453,18 @@ EXPORT_SYMBOL(task_in_intr);
  */
 ide_startstop_t task_out_intr (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = HWGROUP(drive)->rq;
-	u8 stat;
+	u8 stat = hwif->INB(IDE_STATUS_REG);
 
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (!OK_STAT(stat, DRIVE_READY, drive->bad_wstat))
 		return task_error(drive, rq, __FUNCTION__, stat);
 
 	/* Deal with unexpected ATA data phase. */
-	if (((stat & DRQ_STAT) == 0) ^ !rq->nr_sectors)
+	if (((stat & DRQ_STAT) == 0) ^ !hwif->nleft)
 		return task_error(drive, rq, __FUNCTION__, stat);
 
-	if (!rq->nr_sectors) {
+	if (!hwif->nleft) {
 		task_end_request(drive, rq, stat);
 		return ide_stopped;
 	}
diff -puN include/linux/ide.h~ide_tf_sg_pio include/linux/ide.h
--- linux-2.6.9-rc1-bk16/include/linux/ide.h~ide_tf_sg_pio	2004-09-10 23:22:19.484113704 +0200
+++ linux-2.6.9-rc1-bk16-bzolnier/include/linux/ide.h	2004-09-10 23:44:34.077224712 +0200
@@ -934,6 +934,11 @@ typedef struct hwif_s {
 	/* data phase of the active command (currently only valid for PIO/DMA) */
 	int		data_phase;
 
+	unsigned int nsect;
+	unsigned int nleft;
+	unsigned int cursg;
+	unsigned int cursg_ofs;
+
 	int		mmio;		/* hosts iomio (0) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
@@ -1377,35 +1382,6 @@ extern void atapi_output_bytes(ide_drive
 extern void taskfile_input_data(ide_drive_t *, void *, u32);
 extern void taskfile_output_data(ide_drive_t *, void *, u32);
 
-#define IDE_PIO_IN	0
-#define IDE_PIO_OUT	1
-
-static inline void __task_sectors(ide_drive_t *drive, char *buf,
-				  unsigned nsect, unsigned rw)
-{
-	/*
-	 * IRQ can happen instantly after reading/writing
-	 * last sector of the datablock.
-	 */
-	if (rw == IDE_PIO_OUT)
-		taskfile_output_data(drive, buf, nsect * SECTOR_WORDS);
-	else
-		taskfile_input_data(drive, buf, nsect * SECTOR_WORDS);
-}
-
-#ifdef CONFIG_IDE_TASKFILE_IO
-static inline void task_bio_sectors(ide_drive_t *drive, struct request *rq,
-				    unsigned nsect, unsigned rw)
-{
-	unsigned long flags;
-	char *buf = rq_map_buffer(rq, &flags);
-
-	process_that_request_first(rq, nsect);
-	__task_sectors(drive, buf, nsect, rw);
-	rq_unmap_buffer(buf, &flags);
-}
-#endif /* CONFIG_IDE_TASKFILE_IO */
-
 extern int drive_is_ready(ide_drive_t *);
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
 
@@ -1536,6 +1512,8 @@ typedef struct ide_pci_device_s {
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 extern void ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, ide_pci_device_t *);
 
+extern void ide_init_sg_cmd(ide_drive_t *, struct request *);
+
 #define BAD_DMA_DRIVE		0
 #define GOOD_DMA_DRIVE		1
 
_
