Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263866AbTCUTdh>; Fri, 21 Mar 2003 14:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263860AbTCUTcy>; Fri, 21 Mar 2003 14:32:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59524
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263838AbTCUTb6>; Fri, 21 Mar 2003 14:31:58 -0500
Date: Fri, 21 Mar 2003 20:47:14 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212047.h2LKlEEh026491@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove lots of now dead code (no features though!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also add abort functionality

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-io.c linux-2.5.65-ac2/drivers/ide/ide-io.c
--- linux-2.5.65/drivers/ide/ide-io.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-io.c	2003-03-20 18:19:39.000000000 +0000
@@ -330,10 +330,7 @@
 		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
 	}
 	if (rq->errors >= ERROR_MAX) {
-		if (drive->driver != NULL)
-			DRIVER(drive)->end_request(drive, 0, 0);
-		else
-	 		ide_end_request(drive, 0, 0);
+		DRIVER(drive)->end_request(drive, 0, 0);
 	} else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
 			++rq->errors;
@@ -349,6 +346,49 @@
 EXPORT_SYMBOL(ide_error);
 
 /**
+ *	ide_abort	-	abort pending IDE operatins
+ *	@drive: drive the error occurred on
+ *	@msg: message to report
+ *
+ *	ide_abort kills and cleans up when we are about to do a 
+ *	host initiated reset on active commands. Longer term we
+ *	want handlers to have sensible abort handling themselves
+ *
+ *	This differs fundamentally from ide_error because in 
+ *	this case the command is doing just fine when we
+ *	blow it away.
+ */
+ 
+ide_startstop_t ide_abort(ide_drive_t *drive, const char *msg)
+{
+	ide_hwif_t *hwif;
+	struct request *rq;
+
+	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+		return ide_stopped;
+
+	hwif = HWIF(drive);
+	/* retry only "normal" I/O: */
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+		rq->errors = 1;
+		ide_end_drive_cmd(drive, BUSY_STAT, 0);
+		return ide_stopped;
+	}
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
+		rq->errors = 1;
+		ide_end_drive_cmd(drive, BUSY_STAT, 0);
+//		ide_end_taskfile(drive, BUSY_STAT, 0);
+		return ide_stopped;
+	}
+
+	rq->errors |= ERROR_RESET;
+	DRIVER(drive)->end_request(drive, 0, 0);
+	return ide_stopped;
+}
+
+EXPORT_SYMBOL(ide_abort);
+
+/**
  *	ide_cmd		-	issue a simple drive command
  *	@drive: drive the command is for
  *	@cmd: command byte
@@ -399,7 +439,7 @@
 			udelay(100);
 	}
 
-	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
+	if (!OK_STAT(stat, READY_STAT, BAD_STAT) && DRIVER(drive) != NULL)
 		return DRIVER(drive)->error(drive, "drive_cmd", stat);
 		/* calls ide_end_drive_cmd */
 	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
@@ -428,13 +468,10 @@
 		s->b.set_tune = 0;
 		if (HWIF(drive)->tuneproc != NULL)
 			HWIF(drive)->tuneproc(drive, drive->tune_req);
-	} else if (drive->driver != NULL) {
-		return DRIVER(drive)->special(drive);
-	} else if (s->all) {
-		printk(KERN_ERR "%s: bad special flag: 0x%02x\n", drive->name, s->all);
-		s->all = 0;
+		return ide_stopped;
 	}
-	return ide_stopped;
+	else
+		return DRIVER(drive)->special(drive);
 }
 
 EXPORT_SYMBOL(do_special);
@@ -589,42 +626,17 @@
 			return execute_drive_cmd(drive, rq);
 		else if (rq->flags & REQ_DRIVE_TASKFILE)
 			return execute_drive_cmd(drive, rq);
-
-		if (drive->driver != NULL) {
-			return (DRIVER(drive)->do_request(drive, rq, block));
-		}
-		printk(KERN_ERR "%s: media type %d not supported\n", drive->name, drive->media);
-		goto kill_rq;
+		return (DRIVER(drive)->do_request(drive, rq, block));
 	}
 	return do_special(drive);
 kill_rq:
-	if (drive->driver != NULL)
-		DRIVER(drive)->end_request(drive, 0, 0);
-	else
-		ide_end_request(drive, 0, 0);
+	DRIVER(drive)->end_request(drive, 0, 0);
 	return ide_stopped;
 }
 
 EXPORT_SYMBOL(start_request);
 
 /**
- *	restart_request		-	reissue an IDE request
- *	@drive: drive for request
- *	@rq: request to reissue
- *
- *	Reissue a request. See start_request for details and for
- *	FIXME
- */
- 
-int restart_request (ide_drive_t *drive, struct request *rq)
-{
-	(void) start_request(drive, rq);
-	return 0;
-}
-
-EXPORT_SYMBOL(restart_request);
-
-/**
  *	ide_stall_queue		-	pause an IDE device
  *	@drive: drive to stall
  *	@timeout: time to stall for (jiffies)
@@ -742,8 +754,8 @@
 	/* for atari only: POSSIBLY BROKEN HERE(?) */
 	ide_get_lock(ide_intr, hwgroup);
 
-	/* necessary paranoia: ensure IRQs are masked on local CPU */
-	local_irq_disable();
+	/* caller must own ide_lock */
+	BUG_ON(!irqs_disabled());
 
 	while (!hwgroup->busy) {
 		hwgroup->busy = 1;
