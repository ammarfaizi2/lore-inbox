Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUFSQVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUFSQVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUFSQSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:18:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5028 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264154AbUFSQPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [8/11]
Date: Sat, 19 Jun 2004 18:13:32 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191813.32115.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: split task_sectors() and task_multi_sectors()

- split __task_sectors() out of task_sectors()
- add bio and buffer versions of task[_multi]_sectors()
- use task_bio_sectors() instead of task_sectors() in pdc4030.c
- move task[_buffer]_sectors() to ide-taskfile.c
- uninline task[_multi]_sectors()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c   |   43 ++++++++++++++++++++--
 linux-2.6.7-bzolnier/drivers/ide/legacy/pdc4030.c |    4 +-
 linux-2.6.7-bzolnier/include/linux/ide.h          |   36 ++++++------------
 3 files changed, 56 insertions(+), 27 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_task_sectors drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_task_sectors	2004-06-19 03:00:03.553809128 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 03:00:03.576805632 +0200
@@ -288,6 +288,27 @@ ide_startstop_t task_no_data_intr (ide_d
 
 EXPORT_SYMBOL(task_no_data_intr);
 
+static inline void task_buffer_sectors(ide_drive_t *drive, struct request *rq,
+				       unsigned nsect, unsigned rw)
+{
+	char *buf = rq->buffer + blk_rq_offset(rq);
+
+	process_that_request_first(rq, nsect);
+	__task_sectors(drive, buf, nsect, rw);
+}
+
+static inline void task_buffer_multi_sectors(ide_drive_t *drive,
+					     struct request *rq, unsigned rw)
+{
+	unsigned int msect = drive->mult_count, nsect;
+
+	nsect = rq->current_nr_sectors;
+	if (nsect > msect)
+		nsect = msect;
+
+	task_buffer_sectors(drive, rq, nsect, rw);
+}
+
 /*
  * old taskfile PIO handlers, to be killed as soon as possible.
  */
@@ -512,8 +533,17 @@ EXPORT_SYMBOL(task_mulout_intr);
 
 #else /* !CONFIG_IDE_TASKFILE_IO */
 
-static inline void task_multi_sectors(ide_drive_t *drive,
-				      struct request *rq, int rw)
+static void task_sectors(ide_drive_t *drive, struct request *rq,
+			 unsigned nsect, unsigned rw)
+{
+	if (rq->cbio)	/* fs request */
+		task_bio_sectors(drive, rq, nsect, rw);
+	else		/* task request */
+		task_buffer_sectors(drive, rq, nsect, rw);
+}
+
+static inline void task_bio_multi_sectors(ide_drive_t *drive,
+					  struct request *rq, unsigned rw)
 {
 	unsigned int nsect, msect = drive->mult_count;
 
@@ -532,6 +562,15 @@ static inline void task_multi_sectors(id
 	} while (msect);
 }
 
+static void task_multi_sectors(ide_drive_t *drive,
+			       struct request *rq, unsigned rw)
+{
+	if (rq->cbio)	/* fs request */
+		task_bio_multi_sectors(drive, rq, rw);
+	else		/* task request */
+		task_buffer_multi_sectors(drive, rq, rw);
+}
+
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
diff -puN drivers/ide/legacy/pdc4030.c~ide_tf_task_sectors drivers/ide/legacy/pdc4030.c
--- linux-2.6.7/drivers/ide/legacy/pdc4030.c~ide_tf_task_sectors	2004-06-19 03:00:03.567807000 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/legacy/pdc4030.c	2004-06-19 03:00:03.580805024 +0200
@@ -355,7 +355,7 @@ read_next:
 #endif /* DEBUG_READ */
 
 #ifdef CONFIG_IDE_TASKFILE_IO
-	task_sectors(drive, rq, nsect, IDE_PIO_IN);
+	task_bio_sectors(drive, rq, nsect, IDE_PIO_IN);
 
 	/* FIXME: can we check status after transfer on pdc4030? */
 	/* Complete previously submitted bios. */
@@ -478,7 +478,7 @@ static void promise_multwrite (ide_drive
 		if (nsect > msect)
 			nsect = msect;
 
-		task_sectors(drive, rq, nsect, IDE_PIO_OUT);
+		task_bio_sectors(drive, rq, nsect, IDE_PIO_OUT);
 
 		if (!rq->nr_sectors)
 			msect = 0;
diff -puN include/linux/ide.h~ide_tf_task_sectors include/linux/ide.h
--- linux-2.6.7/include/linux/ide.h~ide_tf_task_sectors	2004-06-19 03:00:03.572806240 +0200
+++ linux-2.6.7-bzolnier/include/linux/ide.h	2004-06-19 03:00:03.582804720 +0200
@@ -1415,42 +1415,32 @@ extern void atapi_output_bytes(ide_drive
 extern void taskfile_input_data(ide_drive_t *, void *, u32);
 extern void taskfile_output_data(ide_drive_t *, void *, u32);
 
-#ifdef CONFIG_IDE_TASKFILE_IO
-
 #define IDE_PIO_IN	0
 #define IDE_PIO_OUT	1
 
-static inline void task_sectors(ide_drive_t *drive, struct request *rq,
-				unsigned nsect, int rw)
+static inline void __task_sectors(ide_drive_t *drive, char *buf,
+				  unsigned nsect, unsigned rw)
 {
-	unsigned long flags;
-	unsigned int bio_rq;
-	char *buf;
-
-	/*
-	 * bio_rq flag is needed because we can call
-	 * rq_unmap_buffer() with rq->cbio == NULL
-	 */
-	bio_rq = rq->cbio ? 1 : 0;
-
-	if (bio_rq)
-		buf = rq_map_buffer(rq, &flags);	/* fs request */
-	else
-		buf = rq->buffer + blk_rq_offset(rq);	/* task request */
-
 	/*
 	 * IRQ can happen instantly after reading/writing
 	 * last sector of the datablock.
 	 */
-	process_that_request_first(rq, nsect);
-
 	if (rw == IDE_PIO_OUT)
 		taskfile_output_data(drive, buf, nsect * SECTOR_WORDS);
 	else
 		taskfile_input_data(drive, buf, nsect * SECTOR_WORDS);
+}
+
+#ifdef CONFIG_IDE_TASKFILE_IO
+static inline void task_bio_sectors(ide_drive_t *drive, struct request *rq,
+				    unsigned nsect, unsigned rw)
+{
+	unsigned long flags;
+	char *buf = rq_map_buffer(rq, &flags);
 
-	if (bio_rq)
-		rq_unmap_buffer(buf, &flags);
+	process_that_request_first(rq, nsect);
+	__task_sectors(drive, buf, nsect, rw);
+	rq_unmap_buffer(buf, &flags);
 }
 #endif /* CONFIG_IDE_TASKFILE_IO */
 

_

