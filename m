Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUFSQVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUFSQVD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUFSQT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:19:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264251AbUFSQPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [7/11]
Date: Sat, 19 Jun 2004 18:12:53 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191812.53190.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: add task_multi_sectors() to ide-taskfile.c

Move common code from task_mulin_intr() and task_mulout_intr()
(CONFIG_IDE_TASKFILE_IO=y) to a task_multi_sectors() helper.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |   53 +++++++++---------------
 1 files changed, 22 insertions(+), 31 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_multi_sectors drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_multi_sectors	2004-06-19 02:58:28.592245480 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 02:58:41.830233000 +0200
@@ -512,6 +512,26 @@ EXPORT_SYMBOL(task_mulout_intr);
 
 #else /* !CONFIG_IDE_TASKFILE_IO */
 
+static inline void task_multi_sectors(ide_drive_t *drive,
+				      struct request *rq, int rw)
+{
+	unsigned int nsect, msect = drive->mult_count;
+
+	rq->errors = 0;
+	do {
+		nsect = rq->current_nr_sectors;
+		if (nsect > msect)
+			nsect = msect;
+
+		task_sectors(drive, rq, nsect, rw);
+
+		if (!rq->nr_sectors)
+			msect = 0;
+		else
+			msect -= nsect;
+	} while (msect);
+}
+
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -585,8 +605,6 @@ EXPORT_SYMBOL(task_in_intr);
 ide_startstop_t task_mulin_intr (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	unsigned int msect = drive->mult_count;
-	unsigned int nsect;
 	u8 stat = HWIF(drive)->INB(IDE_STATUS_REG);
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
@@ -610,19 +628,7 @@ finish_rq:
 		return ide_stopped;
 	}
 
-	rq->errors = 0;
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-
-		task_sectors(drive, rq, nsect, IDE_PIO_IN);
-
-		if (!rq->nr_sectors)
-			msect = 0;
-		else
-			msect -= nsect;
-	} while (msect);
+	task_multi_sectors(drive, rq, IDE_PIO_IN);
 
 	/* If it was the last datablock check status and finish transfer. */
 	if (!rq->nr_sectors) {
@@ -712,8 +718,6 @@ EXPORT_SYMBOL(pre_task_out_intr);
 ide_startstop_t task_mulout_intr (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	unsigned int msect = drive->mult_count;
-	unsigned int nsect;
 	u8 stat;
 
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
@@ -748,20 +752,7 @@ ide_startstop_t task_mulout_intr (ide_dr
 
 	/* Still data left to transfer. */
 	ide_set_handler(drive, &task_mulout_intr, WAIT_WORSTCASE, NULL);
-
-	rq->errors = 0;
-	do {
-		nsect = rq->current_nr_sectors;
-		if (nsect > msect)
-			nsect = msect;
-
-		task_sectors(drive, rq, nsect, IDE_PIO_OUT);
-
-		if (!rq->nr_sectors)
-			msect = 0;
-		else
-			msect -= nsect;
-	} while (msect);
+	task_multi_sectors(drive, rq, IDE_PIO_OUT);
 
 	return ide_started;
 }

_

