Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVBBDWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVBBDWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVBBDUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:20:24 -0500
Received: from [211.58.254.17] ([211.58.254.17]:5259 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262225AbVBBDHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:07:34 -0500
Date: Wed, 2 Feb 2005 12:07:27 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 22/29] ide: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE
Message-ID: <20050202030727.GG1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 22_ide_taskfile_flush.patch
> 
> 	All REQ_DRIVE_TASK users except ide_task_ioctl() converted
> 	to use REQ_DRIVE_TASKFILE.
> 	1. idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
> 	   This and the changes in ide_get_error_location() remove a
> 	   possible race condition between ide_get_error_location()
> 	   and other requests.
> 	2. ide_queue_flush_cmd() converted to use REQ_DRIVE_TASKFILE.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-disk.c	2005-02-02 10:28:06.272027942 +0900
+++ linux-ide-export/drivers/ide/ide-disk.c	2005-02-02 10:28:06.527986413 +0900
@@ -705,24 +705,26 @@ static int idedisk_issue_flush(request_q
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
+	memset(&args, 0, sizeof(args));
 
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >= (1UL << 28)))
-		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
+		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
 	else
-		rq->cmd[0] = WIN_FLUSH_CACHE;
+		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
 
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.handler = task_no_data_intr;
 
-	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
-	rq->buffer = rq->cmd;
+	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq->flags |= REQ_DRIVE_TASKFILE | REQ_SOFTBARRIER;
+	rq->special = &args;
 
 	ret = blk_execute_rq(q, disk, rq);
 
@@ -730,8 +732,9 @@ static int idedisk_issue_flush(request_q
 	 * if we failed and caller wants error offset, get it
 	 */
 	if (ret && error_sector)
-		*error_sector = ide_get_error_location(drive, rq->cmd);
+		*error_sector = ide_get_error_location(drive, &args);
 
+	rq->special = NULL;	/* just in case */
 	blk_put_request(rq);
 	return ret;
 }
Index: linux-ide-export/drivers/ide/ide-io.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-io.c	2005-02-02 10:28:06.273027780 +0900
+++ linux-ide-export/drivers/ide/ide-io.c	2005-02-02 10:28:06.528986250 +0900
@@ -55,24 +55,6 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
-static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
-{
-	char *buf = rq->cmd;
-
-	/*
-	 * reuse cdb space for ata command
-	 */
-	memset(buf, 0, sizeof(rq->cmd));
-
-	rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
-	rq->buffer = buf;
-	rq->buffer[0] = WIN_FLUSH_CACHE;
-
-	if (ide_id_has_flush_cache_ext(drive->id) &&
-	    (drive->capacity64 >= (1UL << 28)))
-		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
-}
-
 /*
  * preempt pending requests, and store this cache flush for immediate
  * execution
@@ -80,7 +62,8 @@ static void ide_fill_flush_cmd(ide_drive
 static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
 					   struct request *rq, int post)
 {
-	struct request *flush_rq = &HWGROUP(drive)->wrq;
+	struct request *flush_rq = &HWGROUP(drive)->flush_rq;
+	ide_task_t *args = &HWGROUP(drive)->flush_args;
 
 	/*
 	 * write cache disabled, clear the barrier bit and treat it like
@@ -92,10 +75,22 @@ static struct request *ide_queue_flush_c
 	}
 
 	ide_init_drive_cmd(flush_rq);
-	ide_fill_flush_cmd(drive, flush_rq);
-
-	flush_rq->special = rq;
+	flush_rq->flags = REQ_DRIVE_TASKFILE | REQ_STARTED;
 	flush_rq->nr_sectors = rq->nr_sectors;
+	flush_rq->special = args;
+	HWGROUP(drive)->flush_real_rq = rq;
+
+	memset(args, 0, sizeof(*args));
+
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28)))
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
+	else
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
+
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+	args->data_phase = TASKFILE_NO_DATA;
+	args->handler = task_no_data_intr;
 
 	if (!post) {
 		drive->doing_barrier = 1;
@@ -175,7 +170,7 @@ int ide_end_request (ide_drive_t *drive,
 	if (!blk_barrier_rq(rq) || !drive->wcache)
 		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 	else {
-		struct request *flush_rq = &HWGROUP(drive)->wrq;
+		struct request *flush_rq = &HWGROUP(drive)->flush_rq;
 
 		flush_rq->nr_sectors -= nr_sectors;
 		if (!flush_rq->nr_sectors) {
@@ -221,41 +216,37 @@ static void ide_complete_pm_request (ide
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
+	struct request *real_rq = HWGROUP(drive)->flush_real_rq;
 	int good_sectors, bad_sectors;
 	sector_t sector;
 
@@ -302,7 +293,7 @@ static void ide_complete_barrier(ide_dri
 		 */
 		good_sectors = 0;
 		if (blk_barrier_postflush(rq)) {
-			sector = ide_get_error_location(drive, rq->buffer);
+			sector = ide_get_error_location(drive, rq->special);
 
 			if ((sector >= real_rq->hard_sector) &&
 			    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
Index: linux-ide-export/include/linux/ide.h
===================================================================
--- linux-ide-export.orig/include/linux/ide.h	2005-02-02 10:28:06.274027617 +0900
+++ linux-ide-export/include/linux/ide.h	2005-02-02 10:28:06.529986088 +0900
@@ -930,6 +930,39 @@ typedef ide_startstop_t (ide_pre_handler
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
+typedef struct pkt_task_s {
+/*
+ *	struct hd_drive_task_hdr	pktf;
+ *	task_struct_t		pktf;
+ *	u8			pkcdb[12];
+ */
+	task_ioreg_t		tfRegister[8];
+	int			data_phase;
+	int			command_type;
+	ide_handler_t		*handler;
+	struct request		*rq;		/* copy of request */
+	void			*special;
+} pkt_task_t;
+
 typedef struct hwgroup_s {
 		/* irq handler, if active */
 	ide_startstop_t	(*handler)(ide_drive_t *);
@@ -955,8 +988,12 @@ typedef struct hwgroup_s {
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
@@ -1203,7 +1240,7 @@ extern void ide_init_drive_cmd (struct r
 /*
  * this function returns error location sector offset in case of a write error
  */
-extern u64 ide_get_error_location(ide_drive_t *, char *);
+extern u64 ide_get_error_location(ide_drive_t *, ide_task_t *);
 
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
@@ -1260,39 +1297,6 @@ extern void ide_end_drive_cmd(ide_drive_
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
-typedef struct pkt_task_s {
-/*
- *	struct hd_drive_task_hdr	pktf;
- *	task_struct_t		pktf;
- *	u8			pkcdb[12];
- */
-	task_ioreg_t		tfRegister[8];
-	int			data_phase;
-	int			command_type;
-	ide_handler_t		*handler;
-	struct request		*rq;		/* copy of request */
-	void			*special;
-} pkt_task_t;
-
 extern u32 ide_read_24(ide_drive_t *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
