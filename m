Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVBEKfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVBEKfg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbVBEKdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:33:13 -0500
Received: from [211.58.254.17] ([211.58.254.17]:35985 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266340AbVBEK2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:28:53 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 04/09] ide: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
References: <42049F20.7020706@home-tj.org>
Message-Id: <20050205102843.93952132701@htj.dyndns.org>
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


04_ide_taskfile_flush.patch

	All REQ_DRIVE_TASK users except ide_task_ioctl() converted
	to use REQ_DRIVE_TASKFILE.
	1. idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
	   This and the changes in ide_get_error_location() remove a
	   possible race condition between ide_get_error_location()
	   and other requests.
	2. ide_queue_flush_cmd() converted to use REQ_DRIVE_TASKFILE.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-disk.c	2005-02-05 19:26:51.166394831 +0900
+++ linux-ide-series2-export/drivers/ide/ide-disk.c	2005-02-05 19:27:08.735540988 +0900
@@ -705,24 +705,17 @@ static int idedisk_issue_flush(request_q
 {
 	ide_drive_t *drive = q->queuedata;
 	struct request *rq;
+	ide_task_t args;
 	int ret;
 
 	if (!drive->wcache)
 		return 0;
 
-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
-
-	memset(rq->cmd, 0, sizeof(rq->cmd));
+	ide_init_flush_task(drive, &args);
 
-	if (ide_id_has_flush_cache_ext(drive->id) &&
-	    (drive->capacity64 >= (1UL << 28)))
-		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
-	else
-		rq->cmd[0] = WIN_FLUSH_CACHE;
-
-
-	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
-	rq->buffer = rq->cmd;
+	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq->flags |= REQ_DRIVE_TASKFILE | REQ_SOFTBARRIER;
+	rq->special = &args;
 
 	ret = blk_execute_rq(q, disk, rq);
 
@@ -730,8 +723,9 @@ static int idedisk_issue_flush(request_q
 	 * if we failed and caller wants error offset, get it
 	 */
 	if (ret && error_sector)
-		*error_sector = ide_get_error_location(drive, rq->cmd);
+		*error_sector = ide_get_error_location(drive, &args);
 
+	rq->special = NULL;	/* just in case */
 	blk_put_request(rq);
 	return ret;
 }
Index: linux-ide-series2-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-io.c	2005-02-05 19:27:08.308610336 +0900
+++ linux-ide-series2-export/drivers/ide/ide-io.c	2005-02-05 19:27:08.736540825 +0900
@@ -55,22 +55,19 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
-static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
+void ide_init_flush_task(ide_drive_t *drive, ide_task_t *args)
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
+	memset(args, 0, sizeof(*args));
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28)))
-		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
+	else
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
+
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+	args->data_phase = TASKFILE_NO_DATA;
+	args->handler = task_no_data_intr;
 }
 
 /*
@@ -80,7 +77,9 @@ static void ide_fill_flush_cmd(ide_drive
 static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
 					   struct request *rq, int post)
 {
-	struct request *flush_rq = &HWGROUP(drive)->wrq;
+	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
+	struct request *flush_rq = &hwgroup->flush_rq;
+	ide_task_t *args = &hwgroup->flush_args;
 
 	/*
 	 * write cache disabled, clear the barrier bit and treat it like
@@ -92,10 +91,12 @@ static struct request *ide_queue_flush_c
 	}
 
 	ide_init_drive_cmd(flush_rq);
-	ide_fill_flush_cmd(drive, flush_rq);
-
-	flush_rq->special = rq;
+	flush_rq->flags |= REQ_STARTED;
 	flush_rq->nr_sectors = rq->nr_sectors;
+	flush_rq->special = args;
+	hwgroup->flush_real_rq = rq;
+
+	ide_init_flush_task(drive, args);
 
 	if (!post) {
 		drive->doing_barrier = 1;
@@ -105,7 +106,7 @@ static struct request *ide_queue_flush_c
 		flush_rq->flags |= REQ_BAR_POSTFLUSH;
 
 	__elv_add_request(drive->queue, flush_rq, ELEVATOR_INSERT_FRONT, 0);
-	HWGROUP(drive)->rq = NULL;
+	hwgroup->rq = NULL;
 	return flush_rq;
 }
 
@@ -162,12 +163,13 @@ static int __ide_end_request(ide_drive_t
 
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
@@ -175,7 +177,7 @@ int ide_end_request (ide_drive_t *drive,
 	if (!blk_barrier_rq(rq) || !drive->wcache)
 		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 	else {
-		struct request *flush_rq = &HWGROUP(drive)->wrq;
+		struct request *flush_rq = &hwgroup->flush_rq;
 
 		flush_rq->nr_sectors -= nr_sectors;
 		if (!flush_rq->nr_sectors) {
@@ -221,41 +223,37 @@ static void ide_complete_pm_request (ide
 /*
  * FIXME: probably move this somewhere else, name is bad too :)
  */
-u64 ide_get_error_location(ide_drive_t *drive, char *args)
+u64 ide_get_error_location(ide_drive_t *drive, ide_task_t *args)
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
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28)))
+		high = (args->hobRegister[IDE_HCYL_OFFSET] << 16) |
+		       (args->hobRegister[IDE_LCYL_OFFSET] << 8 ) |
+			args->hobRegister[IDE_SECTOR_OFFSET];
+	else
+		high = 0;
+
+	hcyl = args->tfRegister[IDE_HCYL_OFFSET];
+	lcyl = args->tfRegister[IDE_LCYL_OFFSET];
+	sect = args->tfRegister[IDE_SECTOR_OFFSET];
+
+	if (args->tfRegister[IDE_SELECT_OFFSET] & 0x40)
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
 
@@ -302,7 +300,7 @@ static void ide_complete_barrier(ide_dri
 		 */
 		good_sectors = 0;
 		if (blk_barrier_postflush(rq)) {
-			sector = ide_get_error_location(drive, rq->buffer);
+			sector = ide_get_error_location(drive, rq->special);
 
 			if ((sector >= real_rq->hard_sector) &&
 			    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
Index: linux-ide-series2-export/include/linux/ide.h
===================================================================
--- linux-ide-series2-export.orig/include/linux/ide.h	2005-02-05 19:27:08.104643467 +0900
+++ linux-ide-series2-export/include/linux/ide.h	2005-02-05 19:27:08.737540663 +0900
@@ -930,6 +930,25 @@ typedef ide_startstop_t (ide_pre_handler
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 typedef int (ide_expiry_t)(ide_drive_t *);
 
+typedef struct ide_task_s {
+/*
+ *	struct hd_drive_task_hdr	tf;
+ *	task_struct_t		tf;
+ *	struct hd_drive_hob_hdr		hobf;
+ *	hob_struct_t		hobf;
+ */
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
@@ -955,8 +974,12 @@ typedef struct hwgroup_s {
 	struct request *rq;
 		/* failsafe timer */
 	struct timer_list timer;
-		/* local copy of current write rq */
-	struct request wrq;
+		/* rq used for flushing */
+	struct request flush_rq;
+		/* task used for flushing */
+	ide_task_t flush_args;
+		/* real_rq for flushing */
+	struct request *flush_real_rq;
 		/* timeout value during long polls */
 	unsigned long poll_timeout;
 		/* queried upon timeouts */
@@ -1201,9 +1224,14 @@ extern ide_startstop_t ide_do_reset (ide
 extern void ide_init_drive_cmd (struct request *rq);
 
 /*
+ * This function initializes @task to WIN_FLUSH_CACHE[_EXT] command.
+ */
+void ide_init_flush_task(ide_drive_t *drive, ide_task_t *args);
+
+/*
  * this function returns error location sector offset in case of a write error
  */
-extern u64 ide_get_error_location(ide_drive_t *, char *);
+u64 ide_get_error_location(ide_drive_t *, ide_task_t *);
 
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
@@ -1260,25 +1288,6 @@ extern void ide_end_drive_cmd(ide_drive_
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
 
-typedef struct ide_task_s {
-/*
- *	struct hd_drive_task_hdr	tf;
- *	task_struct_t		tf;
- *	struct hd_drive_hob_hdr		hobf;
- *	hob_struct_t		hobf;
- */
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
