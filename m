Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVBJIob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVBJIob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVBJImi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:42:38 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:55254 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262063AbVBJIit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:38:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:references:in-reply-to:message-id:date;
        b=kOvnN/QQ9IklByyRmmJwNRfWVS4woKSheUxz+HfQ0mPxtiViUHjkZtuAes3FpAeu6D8AfR96+u6y3Lm8SAC2XQuoTwd+90mtdso3rgpR5Q1xAEWIKMH5qMWBzdAk6Yb/lfWZLDPstdu17Udm17Kawib5SWpdcBKlb4ibYwIl48k=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 06/11] ide: make disk flush functions use TASKFILE instead of TASK
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Message-ID: <20050210083834.92D4FB21@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:39 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


06_ide_taskfile_flush.patch

	* idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
	   This and the changes in ide_get_error_location() remove a
	   possible race condition between ide_get_error_location()
	   and other requests.
	* ide_queue_flush_cmd() converted to use REQ_DRIVE_TASKFILE.

	By this change, when WIN_FLUSH_CACHE_EXT is used, full HOB
	registers are written and read.  This isn't optimal but
	shouldn't be noticeable either.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-disk.c |   19 +++-------
 drivers/ide/ide-io.c   |   91 ++++++++++++++++++++++++-------------------------
 include/linux/ide.h    |   52 +++++++++++++++-------------
 3 files changed, 81 insertions(+), 81 deletions(-)

Index: linux-ide/drivers/ide/ide-disk.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-disk.c	2005-02-10 17:38:01.169901379 +0900
+++ linux-ide/drivers/ide/ide-disk.c	2005-02-10 17:38:01.744804960 +0900
@@ -688,24 +688,17 @@ static int idedisk_issue_flush(request_q
 {
 	ide_drive_t *drive = q->queuedata;
 	struct request *rq;
+	ide_task_t task;
 	int ret;
 
 	if (!drive->wcache)
 		return 0;
 
-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
-
-	memset(rq->cmd, 0, sizeof(rq->cmd));
-
-	if (ide_id_has_flush_cache_ext(drive->id) &&
-	    (drive->capacity64 >= (1UL << 28)))
-		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
-	else
-		rq->cmd[0] = WIN_FLUSH_CACHE;
-
+	ide_init_flush_task(drive, &task);
 
-	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
-	rq->buffer = rq->cmd;
+	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq->flags |= REQ_DRIVE_TASKFILE | REQ_SOFTBARRIER;
+	rq->special = &task;
 
 	ret = blk_execute_rq(q, disk, rq);
 
@@ -713,7 +706,7 @@ static int idedisk_issue_flush(request_q
 	 * if we failed and caller wants error offset, get it
 	 */
 	if (ret && error_sector)
-		*error_sector = ide_get_error_location(drive, rq->cmd);
+		*error_sector = ide_get_error_location(drive, &task);
 
 	blk_put_request(rq);
 	return ret;
Index: linux-ide/drivers/ide/ide-io.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-io.c	2005-02-10 17:38:01.171901044 +0900
+++ linux-ide/drivers/ide/ide-io.c	2005-02-10 17:38:01.746804625 +0900
@@ -55,24 +55,25 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
-static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
+void ide_init_flush_task(ide_drive_t *drive, ide_task_t *task)
 {
-	char *buf = rq->cmd;
-
-	/*
-	 * reuse cdb space for ata command
-	 */
-	memset(buf, 0, sizeof(rq->cmd));
-
-	rq->flags = REQ_DRIVE_TASK | REQ_STARTED;
-	rq->buffer = buf;
-	rq->buffer[0] = WIN_FLUSH_CACHE;
+	memset(task, 0, sizeof(*task));
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
-	    (drive->capacity64 >= (1UL << 28)))
-		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
+	    (drive->capacity64 >= (1UL << 28))) {
+		task->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
+		task->flags |= ATA_TFLAG_LBA48;
+	} else {
+		task->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
+	}
+
+	task->command_type = IDE_DRIVE_TASK_NO_DATA;
+	task->data_phase = TASKFILE_NO_DATA;
+	task->handler = task_no_data_intr;
 }
 
+EXPORT_SYMBOL(ide_init_flush_task);
+
 /*
  * preempt pending requests, and store this cache flush for immediate
  * execution
@@ -80,7 +81,9 @@ static void ide_fill_flush_cmd(ide_drive
 static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
 					   struct request *rq, int post)
 {
-	struct request *flush_rq = &HWGROUP(drive)->wrq;
+	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
+	struct request *flush_rq = &hwgroup->flush_rq;
+	ide_task_t *task = &hwgroup->flush_task;
 
 	/*
 	 * write cache disabled, clear the barrier bit and treat it like
@@ -92,10 +95,12 @@ static struct request *ide_queue_flush_c
 	}
 
 	ide_init_drive_cmd(flush_rq);
-	ide_fill_flush_cmd(drive, flush_rq);
-
-	flush_rq->special = rq;
+	flush_rq->flags |= REQ_STARTED;
 	flush_rq->nr_sectors = rq->nr_sectors;
+	flush_rq->special = task;
+	hwgroup->flush_real_rq = rq;
+
+	ide_init_flush_task(drive, task);
 
 	if (!post) {
 		drive->doing_barrier = 1;
@@ -105,7 +110,7 @@ static struct request *ide_queue_flush_c
 		flush_rq->flags |= REQ_BAR_POSTFLUSH;
 
 	__elv_add_request(drive->queue, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-	HWGROUP(drive)->rq = NULL;
+	hwgroup->rq = NULL;
 	return flush_rq;
 }
 
@@ -162,12 +167,13 @@ static int __ide_end_request(ide_drive_t
 
 int ide_end_request (ide_drive_t *drive, int uptodate, int nr_sectors)
 {
+	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
 	struct request *rq;
 	unsigned long flags;
 	int ret = 1;
 
 	spin_lock_irqsave(&ide_lock, flags);
-	rq = HWGROUP(drive)->rq;
+	rq = hwgroup->rq;
 
 	if (!nr_sectors)
 		nr_sectors = rq->hard_cur_sectors;
@@ -175,7 +181,7 @@ int ide_end_request (ide_drive_t *drive,
 	if (!blk_barrier_rq(rq) || !drive->wcache)
 		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 	else {
-		struct request *flush_rq = &HWGROUP(drive)->wrq;
+		struct request *flush_rq = &hwgroup->flush_rq;
 
 		flush_rq->nr_sectors -= nr_sectors;
 		if (!flush_rq->nr_sectors) {
@@ -314,41 +320,36 @@ static void ide_complete_pm_request (ide
 /*
  * FIXME: probably move this somewhere else, name is bad too :)
  */
-u64 ide_get_error_location(ide_drive_t *drive, char *args)
+u64 ide_get_error_location(ide_drive_t *drive, ide_task_t *task)
 {
 	u32 high, low;
 	u8 hcyl, lcyl, sect;
-	u64 sector;
 
-	high = 0;
-	hcyl = args[5];
-	lcyl = args[4];
-	sect = args[3];
-
-	if (ide_id_has_flush_cache_ext(drive->id)) {
-		low = (hcyl << 16) | (lcyl << 8) | sect;
-		HWIF(drive)->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-		high = ide_read_24(drive);
-	} else {
-		u8 cur = HWIF(drive)->INB(IDE_SELECT_REG);
-		if (cur & 0x40)
-			low = (hcyl << 16) | (lcyl << 8) | sect;
-		else {
-			low = hcyl * drive->head * drive->sect;
-			low += lcyl * drive->sect;
-			low += sect - 1;
-		}
-	}
+	if (drive->addressing == 1)
+		high = (task->hobRegister[IDE_HCYL_OFFSET] << 16) |
+			(task->hobRegister[IDE_LCYL_OFFSET] << 8) |
+			task->hobRegister[IDE_SECTOR_OFFSET];
+	else
+		high = 0;
+
+	hcyl = task->tfRegister[IDE_HCYL_OFFSET];
+	lcyl = task->tfRegister[IDE_LCYL_OFFSET];
+	sect = task->tfRegister[IDE_SECTOR_OFFSET];
+
+	if (task->tfRegister[IDE_SELECT_OFFSET] & 0x40)
+		low = (hcyl << 16) | (lcyl << 8 ) | sect;
+	else
+		low = hcyl * drive->head * drive->sect +
+			lcyl * drive->sect + sect - 1;
 
-	sector = ((u64) high << 24) | low;
-	return sector;
+	return ((u64)high << 24) | low; 
 }
 EXPORT_SYMBOL(ide_get_error_location);
 
 static void ide_complete_barrier(ide_drive_t *drive, struct request *rq,
 				 int error)
 {
-	struct request *real_rq = rq->special;
+	struct request *real_rq = drive->hwif->hwgroup->flush_real_rq;
 	int good_sectors, bad_sectors;
 	sector_t sector;
 
@@ -395,7 +396,7 @@ static void ide_complete_barrier(ide_dri
 		 */
 		good_sectors = 0;
 		if (blk_barrier_postflush(rq)) {
-			sector = ide_get_error_location(drive, rq->buffer);
+			sector = ide_get_error_location(drive, rq->special);
 
 			if ((sector >= real_rq->hard_sector) &&
 			    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
Index: linux-ide/include/linux/ide.h
===================================================================
--- linux-ide.orig/include/linux/ide.h	2005-02-10 17:38:01.174900541 +0900
+++ linux-ide/include/linux/ide.h	2005-02-10 17:38:01.745804793 +0900
@@ -926,6 +926,26 @@ typedef ide_startstop_t (ide_pre_handler
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 typedef int (ide_expiry_t)(ide_drive_t *);
 
+typedef struct ide_task_s {
+/*
+ *	struct hd_drive_task_hdr	tf;
+ *	task_struct_t		tf;
+ *	struct hd_drive_hob_hdr		hobf;
+ *	hob_struct_t		hobf;
+ */
+	unsigned long		flags;		/* ATA_TFLAG_xxx */
+	task_ioreg_t		tfRegister[8];
+	task_ioreg_t		hobRegister[8];
+	ide_reg_valid_t		tf_out_flags;
+	ide_reg_valid_t		tf_in_flags;
+	int			data_phase;
+	int			command_type;
+	ide_pre_handler_t	*prehandler;
+	ide_handler_t		*handler;
+	struct request		*rq;		/* copy of request */
+	void			*special;	/* valid_t generally */
+} ide_task_t;
+
 typedef struct hwgroup_s {
 		/* irq handler, if active */
 	ide_startstop_t	(*handler)(ide_drive_t *);
@@ -951,8 +971,12 @@ typedef struct hwgroup_s {
 	struct request *rq;
 		/* failsafe timer */
 	struct timer_list timer;
-		/* local copy of current write rq */
-	struct request wrq;
+		/* rq used for flushing */
+	struct request flush_rq;
+		/* task used for flushing */
+	ide_task_t flush_task;
+		/* real_rq for flushing */
+	struct request *flush_real_rq;
 		/* timeout value during long polls */
 	unsigned long poll_timeout;
 		/* queried upon timeouts */
@@ -1191,10 +1215,12 @@ extern ide_startstop_t ide_do_reset (ide
  */
 extern void ide_init_drive_cmd (struct request *rq);
 
+void ide_init_flush_task(ide_drive_t *, ide_task_t *);
+
 /*
  * this function returns error location sector offset in case of a write error
  */
-extern u64 ide_get_error_location(ide_drive_t *, char *);
+u64 ide_get_error_location(ide_drive_t *, ide_task_t *);
 
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
@@ -1251,26 +1277,6 @@ extern void ide_end_drive_cmd(ide_drive_
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
 
-typedef struct ide_task_s {
-/*
- *	struct hd_drive_task_hdr	tf;
- *	task_struct_t		tf;
- *	struct hd_drive_hob_hdr		hobf;
- *	hob_struct_t		hobf;
- */
-	unsigned long		flags;		/* ATA_TFLAG_xxx */
-	task_ioreg_t		tfRegister[8];
-	task_ioreg_t		hobRegister[8];
-	ide_reg_valid_t		tf_out_flags;
-	ide_reg_valid_t		tf_in_flags;
-	int			data_phase;
-	int			command_type;
-	ide_pre_handler_t	*prehandler;
-	ide_handler_t		*handler;
-	struct request		*rq;		/* copy of request */
-	void			*special;	/* valid_t generally */
-} ide_task_t;
-
 extern u32 ide_read_24(ide_drive_t *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
