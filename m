Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUFSQhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUFSQhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUFSQXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:23:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264348AbUFSQQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:16:00 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [10/11]
Date: Sat, 19 Jun 2004 18:14:43 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191814.43195.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: use task_buffer[_multi]_sectors() in ide-taskfile.c

- remove not needed !rq->bio code from ide_[un]map_buffer()
  (it is used only for fs requests which are always bio based)
- update rq counters directly in task_buffer_sectors()
- use task_buffer[_multi]_sectors() in taskfile PIO
  handlers (CONFIG_IDE_TASKFILE_IO=n and flagged ones) so:
  (a) rq->hard_cur_sectors is used for rq mapping
  (b) in case of error valid rq->sector is reported
  (c) we can s/rq->current_nr_sectors/rq->nr_sectors/ later
- uninline task_buffer_sectors()
- remove no longer needed task_rq_offset()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |  102 +++++-------------------
 linux-2.6.7-bzolnier/include/linux/ide.h        |   20 ----
 2 files changed, 26 insertions(+), 96 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_buffer_sectors drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_buffer_sectors	2004-06-19 03:03:38.624113472 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 03:11:57.656249056 +0200
@@ -288,12 +288,14 @@ ide_startstop_t task_no_data_intr (ide_d
 
 EXPORT_SYMBOL(task_no_data_intr);
 
-static inline void task_buffer_sectors(ide_drive_t *drive, struct request *rq,
-				       unsigned nsect, unsigned rw)
+static void task_buffer_sectors(ide_drive_t *drive, struct request *rq,
+				unsigned nsect, unsigned rw)
 {
 	char *buf = rq->buffer + blk_rq_offset(rq);
 
-	process_that_request_first(rq, nsect);
+	rq->sector += nsect;
+	rq->current_nr_sectors -= nsect;
+	rq->nr_sectors -= nsect;
 	__task_sectors(drive, buf, nsect, rw);
 }
 
@@ -321,7 +323,6 @@ ide_startstop_t task_in_intr (ide_drive_
 {
 	struct request *rq	= HWGROUP(drive)->rq;
 	ide_hwif_t *hwif	= HWIF(drive);
-	char *pBuf		= NULL;
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
@@ -334,11 +335,10 @@ ide_startstop_t task_in_intr (ide_drive_
 		}
 	}
 
-	pBuf = rq->buffer + task_rq_offset(rq);
-	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
+	task_buffer_sectors(drive, rq, 1, IDE_PIO_IN);
 
 	/* FIXME: check drive status */
-	if (--rq->current_nr_sectors <= 0)
+	if (!rq->current_nr_sectors)
 		if (!DRIVER(drive)->end_request(drive, 1, 0))
 			return ide_stopped;
 	ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
@@ -354,9 +354,6 @@ ide_startstop_t task_mulin_intr (ide_dri
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-	unsigned int msect	= drive->mult_count;
-	unsigned int nsect;
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),DATA_READY,BAD_R_STAT)) {
@@ -368,21 +365,14 @@ ide_startstop_t task_mulin_intr (ide_dri
 		return ide_started;
 	}
 
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-		pBuf = rq->buffer + task_rq_offset(rq);
-		taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
-		rq->current_nr_sectors -= nsect;
-		msect -= nsect;
+	task_buffer_multi_sectors(drive, rq, IDE_PIO_IN);
+
+	/* FIXME: check drive status */
+	if (!rq->current_nr_sectors) {
+		DRIVER(drive)->end_request(drive, 1, 0);
+		return ide_stopped;
+	}
 
-		/* FIXME: check drive status */
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				return ide_stopped;
-		}
-	} while (msect);
 	ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
 }
@@ -405,8 +395,7 @@ ide_startstop_t pre_task_out_intr (ide_d
 		return startstop;
 	}
 	/* For Write_sectors we need to stuff the first sector */
-	taskfile_output_data(drive, rq->buffer + task_rq_offset(rq), SECTOR_WORDS);
-	rq->current_nr_sectors--;
+	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
 	return ide_started;
 }
 
@@ -421,7 +410,6 @@ ide_startstop_t task_out_intr (ide_drive
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
 	u8 stat;
 
 	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY, drive->bad_wstat)) {
@@ -435,10 +423,7 @@ ide_startstop_t task_out_intr (ide_drive
 		if (!DRIVER(drive)->end_request(drive, 1, 0))
 			return ide_stopped;
 	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
-		rq = HWGROUP(drive)->rq;
-		pBuf = rq->buffer + task_rq_offset(rq);
-		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
-		rq->current_nr_sectors--;
+		task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
 	}
 	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
@@ -485,9 +470,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 	ide_hwif_t *hwif		= HWIF(drive);
 	u8 stat				= hwif->INB(IDE_STATUS_REG);
 	struct request *rq		= HWGROUP(drive)->rq;
-	char *pBuf			= NULL;
-	unsigned int msect		= drive->mult_count;
-	unsigned int nsect;
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT) || !rq->current_nr_sectors) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
@@ -512,15 +494,7 @@ ide_startstop_t task_mulout_intr (ide_dr
 		spin_unlock_irqrestore(&ide_lock, lflags);
 	}
 
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-		pBuf = rq->buffer + task_rq_offset(rq);
-		msect -= nsect;
-		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-		rq->current_nr_sectors -= nsect;
-	} while (msect);
+	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
 	if (HWGROUP(drive)->handler == NULL)
 		ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
@@ -1327,7 +1301,6 @@ ide_startstop_t flagged_task_in_intr (id
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
 	int retries             = 5;
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
@@ -1343,10 +1316,9 @@ ide_startstop_t flagged_task_in_intr (id
 		return DRIVER(drive)->error(drive, "flagged_task_in_intr (unexpected data phase)", stat); 
 	}
 
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
+	task_buffer_sectors(drive, rq, 1, IDE_PIO_IN);
 
-	if (--rq->current_nr_sectors != 0) {
+	if (rq->current_nr_sectors) {
 		/*
                  * (ks) We don't know which command was executed. 
 		 * So, we wait the 'WORSTCASE' value.
@@ -1370,11 +1342,7 @@ ide_startstop_t flagged_task_mulin_intr 
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
 	int retries             = 5;
-	unsigned int msect, nsect;
-
-	msect = drive->mult_count;
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & ERR_STAT) {
@@ -1389,11 +1357,8 @@ ide_startstop_t flagged_task_mulin_intr 
 		return DRIVER(drive)->error(drive, "flagged_task_mulin_intr (unexpected data phase)", stat); 
 	}
 
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
+	task_buffer_multi_sectors(drive, rq, IDE_PIO_IN);
 
-	rq->current_nr_sectors -= nsect;
 	if (rq->current_nr_sectors != 0) {
 		/*
                  * (ks) We don't know which command was executed. 
@@ -1427,8 +1392,7 @@ ide_startstop_t flagged_pre_task_out_int
 		return startstop;
 	}
 
-	taskfile_output_data(drive, rq->buffer, SECTOR_WORDS);
-	--rq->current_nr_sectors;
+	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
 
 	return ide_started;
 }
@@ -1438,7 +1402,6 @@ ide_startstop_t flagged_task_out_intr (i
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
 
 	if (!OK_STAT(stat, DRIVE_READY, BAD_W_STAT)) 
 		return DRIVER(drive)->error(drive, "flagged_task_out_intr", stat);
@@ -1458,9 +1421,7 @@ ide_startstop_t flagged_task_out_intr (i
 		return DRIVER(drive)->error(drive, "flagged_task_out_intr (unexpected data phase)", stat); 
 	}
 
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	taskfile_output_data(drive, pBuf, SECTOR_WORDS);
-	--rq->current_nr_sectors;
+	task_buffer_sectors(drive, rq, 1, IDE_PIO_OUT);
 
 	/*
 	 * (ks) We don't know which command was executed. 
@@ -1473,11 +1434,7 @@ ide_startstop_t flagged_task_out_intr (i
 
 ide_startstop_t flagged_pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
 {
-	char *pBuf		= NULL;
 	ide_startstop_t startstop;
-	unsigned int msect, nsect;
-
-	msect = drive->mult_count;
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
 			BAD_W_STAT, WAIT_DRQ)) {
@@ -1485,11 +1442,7 @@ ide_startstop_t flagged_pre_task_mulout_
 		return startstop;
 	}
 
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-
-	rq->current_nr_sectors -= nsect;
+	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
 
 	return ide_started;
 }
@@ -1499,10 +1452,6 @@ ide_startstop_t flagged_task_mulout_intr
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	struct request *rq	= HWGROUP(drive)->rq;
-	char *pBuf		= NULL;
-	unsigned int msect, nsect;
-
-	msect = drive->mult_count;
 
 	if (!OK_STAT(stat, DRIVE_READY, BAD_W_STAT)) 
 		return DRIVER(drive)->error(drive, "flagged_task_mulout_intr", stat);
@@ -1522,10 +1471,7 @@ ide_startstop_t flagged_task_mulout_intr
 		return DRIVER(drive)->error(drive, "flagged_task_mulout_intr (unexpected data phase)", stat); 
 	}
 
-	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
-	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
-	rq->current_nr_sectors -= nsect;
+	task_buffer_multi_sectors(drive, rq, IDE_PIO_OUT);
 
 	/*
 	 * (ks) We don't know which command was executed. 
diff -puN include/linux/ide.h~ide_tf_buffer_sectors include/linux/ide.h
--- linux-2.6.7/include/linux/ide.h~ide_tf_buffer_sectors	2004-06-19 03:03:38.628112864 +0200
+++ linux-2.6.7-bzolnier/include/linux/ide.h	2004-06-19 03:03:38.638111344 +0200
@@ -833,30 +833,14 @@ typedef struct ide_dma_ops_s {
 #define ide_rq_offset(rq) \
 	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
-/*
- * taskfiles really should use hard_cur_sectors as well!
- */
-#define task_rq_offset(rq) \
-	(((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE)
-
 static inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
 {
-	/*
-	 * fs request
-	 */
-	if (rq->bio)
-		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
-
-	/*
-	 * task request
-	 */
-	return rq->buffer + task_rq_offset(rq);
+	return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
 }
 
 static inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
 {
-	if (rq->bio)
-		bio_kunmap_irq(buffer, flags);
+	bio_kunmap_irq(buffer, flags);
 }
 #endif /* !CONFIG_IDE_TASKFILE_IO */
 

_

