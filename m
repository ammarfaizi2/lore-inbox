Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTDQXJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTDQXJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:09:33 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21132 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262687AbTDQXJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:09:12 -0400
Date: Fri, 18 Apr 2003 01:20:43 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304180120030.22161-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tf-ioctls-2.diff:

# Taskfile and flagged Taskfile PIO handlers unification [1/2].
# Incremental to tf-ioctls-1 patch.
#
# Detailed changelog:
# - add request validity checking present in flagged PIO handlers
#   to execute_drive_cmd(), so we now check also not flagged Taskfile
#   and we abort bad requests early
# - add flagged_wait_drive_ready() for wating for non-busy drive status
# - add check for DATA_READY to task_out_intr() and task_mulout_intr()
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac1-tf1/drivers/ide/ide-io.c linux/drivers/ide/ide-io.c
--- linux-2.5.67-ac1-tf1/drivers/ide/ide-io.c	Thu Apr 17 20:03:36 2003
+++ linux/drivers/ide/ide-io.c	Thu Apr 17 21:49:49 2003
@@ -496,7 +496,23 @@

 		if (!args)
 			goto done;
-
+
+		/* Some validity checking. */
+		if (!rq->hard_nr_sectors &&
+		    (args->command_type != IDE_DRIVE_TASK_NO_DATA &&
+		     args->command_type != IDE_DRIVE_TASK_SET_XFER)) {
+			printk(KERN_ERR "%s: %s: no data to transfer\n",
+					drive->name, __FUNCTION__);
+			goto abort;
+		}
+		if (!drive->mult_count &&
+		    (args->data_phase == TASKFILE_MULTI_IN ||
+		     args->data_phase == TASKFILE_MULTI_OUT)) {
+			printk(KERN_ERR "%s: %s: multimode not set\n",
+					drive->name, __FUNCTION__);
+			goto abort;
+		}
+
 		if (args->tf_out_flags.all != 0)
 			return flagged_taskfile(drive, args);
 		return do_rw_taskfile(drive, args);
@@ -559,6 +575,7 @@
 #ifdef DEBUG
  	printk("%s: DRIVE_CMD (null)\n", drive->name);
 #endif
+abort:
  	ide_end_drive_cmd(drive,
 			hwif->INB(IDE_STATUS_REG),
 			hwif->INB(IDE_ERROR_REG));
diff -uNr linux-2.5.67-ac1-tf1/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac1-tf1/drivers/ide/ide-taskfile.c	Thu Apr 17 20:10:59 2003
+++ linux/drivers/ide/ide-taskfile.c	Thu Apr 17 21:17:43 2003
@@ -355,6 +355,20 @@

 EXPORT_SYMBOL(task_no_data_intr);

+static u8 flagged_wait_drive_ready(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	int retries = 5;
+	u8 stat;
+	/*
+	 * (ks) Last sector was transfered, wait until drive is ready.
+	 * This can take up to 10 usec. We willl wait max 50 us.
+	 */
+	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
+		udelay(10);
+	return stat;
+}
+
 #define PIO_IN	0
 #define PIO_OUT	1

@@ -386,11 +400,12 @@
 ide_startstop_t task_in_intr (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
+	ide_task_t *task = (ide_task_t *) rq->special;
 	u8 stat, good_stat;

 	good_stat = DATA_READY;
-check_status:
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
+check_status:
 	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT))
 			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
@@ -417,6 +432,11 @@

 	/* If it was the last datablock check status and finish transfer. */
 	if (!rq->nr_sectors) {
+		/* FIXME: Use for all requests?  --bzolnier */
+		if (!blk_fs_request(rq) && task->tf_out_flags.all != 0)
+			stat = flagged_wait_drive_ready(drive);
+		else
+			stat = HWIF(drive)->INB(IDE_STATUS_REG);
 		good_stat = 0;
 		goto check_status;
 	}
@@ -435,13 +455,14 @@
 ide_startstop_t task_mulin_intr (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
+	ide_task_t *task = (ide_task_t *) rq->special;
 	unsigned int msect = drive->mult_count;
 	unsigned int nsect;
 	u8 stat, good_stat;

 	good_stat = DATA_READY;
-check_status:
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
+check_status:
 	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT))
 			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
@@ -479,6 +500,11 @@

 	/* If it was the last datablock check status and finish transfer. */
 	if (!rq->nr_sectors) {
+		/* FIXME: Use for all requests?  --bzolnier */
+		if (!blk_fs_request(rq) && task->tf_out_flags.all != 0)
+			stat = flagged_wait_drive_ready(drive);
+		else
+			stat = HWIF(drive)->INB(IDE_STATUS_REG);
 		good_stat = 0;
 		goto check_status;
 	}
@@ -513,6 +539,11 @@
 		}
 	}

+	/* Deal with unexpected ATA data phase. */
+	ok_stat = OK_STAT(stat, DATA_READY, drive->bad_wstat);
+	if (!ok_stat && rq->nr_sectors)
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+
 	/*
 	 * Complete previously submitted bios (if any).
 	 * Status was already verifyied.
@@ -577,6 +608,11 @@
 		}
 	}

+	/* Deal with unexpected ATA data phase. */
+	ok_stat = OK_STAT(stat, DATA_READY, drive->bad_wstat);
+	if (!ok_stat && rq->nr_sectors)
+		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+
 	/*
 	 * Complete previously submitted bios (if any).
 	 * Status was already verifyied.
@@ -1619,7 +1655,6 @@
 	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
-	int retries             = 5;

 	if (rq->current_nr_sectors == 0)
 		return DRIVER(drive)->error(drive, "flagged_task_in_intr (no data requested)", stat);
@@ -1650,12 +1685,7 @@
 		ide_set_handler(drive, &flagged_task_in_intr,  WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
-	/*
-	 * (ks) Last sector was transfered, wait until drive is ready.
-	 * This can take up to 10 usec. We willl wait max 50 us.
-	 */
-	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
-		udelay(10);
+	stat = flagged_wait_drive_ready(drive);
 	ide_end_drive_cmd (drive, stat, hwif->INB(IDE_ERROR_REG));

 	return ide_stopped;
@@ -1667,7 +1697,6 @@
 	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
-	int retries             = 5;
 	unsigned int msect, nsect;

 	if (rq->current_nr_sectors == 0)
@@ -1707,13 +1736,7 @@
 		ide_set_handler(drive, &flagged_task_mulin_intr,  WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
-
-	/*
-	 * (ks) Last sector was transfered, wait until drive is ready.
-	 * This can take up to 10 usec. We willl wait max 50 us.
-	 */
-	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
-		udelay(10);
+	stat = flagged_wait_drive_ready(drive);
 	ide_end_drive_cmd (drive, stat, hwif->INB(IDE_ERROR_REG));

 	return ide_stopped;

