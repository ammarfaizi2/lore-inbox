Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUCGUYe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 15:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbUCGUYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 15:24:34 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:17304 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262329AbUCGUYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 15:24:13 -0500
Date: Sun, 7 Mar 2004 15:24:09 -0500
From: Willem Riede <wrlk@riede.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ide-scsi error handler update (was: ide-scsi patch)
Message-ID: <20040307202409.GO29509@serve.riede.org>
Reply-To: wrlk@riede.org
References: <20040305084001.GA10470@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040305084001.GA10470@suse.de> (from axboe@suse.de on Fri, Mar 05, 2004 at 03:40:02 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.03.05 03:40, Jens Axboe wrote:
> Hi Willem
> 
> Sorry for the (too long) delay. I just looked closer at your patch
> today, and it is an improvement. The code I looked at is the one that is
> merged in 2.6.4-rc1-mm2, jfyi.
> 
> A few comments:
> 
> - Don't even BUG() in error handling. BUG() should only be used for
>   system consistency problems, not a silly tape driver going nuts. Use
>   WARN_ON() and maybe add a printk before that if you need to, and then
>   gracefully leave.
> 
> - You need to set task state before calling schedule_timeout(),
>   otherwise your nice loop turns into a nasty busy loop. So something
>   ala:
> 
> 	do {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		spin_unlock_irq(cmd->device->host->host_lock);
> 		schedule_timeout(HZ / 20);
> 		spin_lock_irq(cmd->device->host->host_lock);
> 	} while (HWGROUP(drive)->handler);
> 
>   (moved the lock as well, for ->handler check)
> 
> - The drive queue nuking code isn't completely correct with the
>   anticipatory io scheduler. I'll get this fixed up, basically we need
>   to mark the queue as dead first to force it to return what it has
>   always (it could return NULL for anticipation issues, while there
>   still are requests in the queue).
> 
> - The expiry() addition is nice.
> 
> - idescsi_dump_status() should probably be in ide-*.c somewhere, called
>   ide_atapi_dump_status() and reused by ide-cd and ide-scsi.
> 
> If you can fix these up, then I think the patch should go into -linus
> right away. Just leave the queue nuking stuff, I'll apply that on top of
> your fix.

I trust the patch below meets your recommendations (it works for me). 

This patch (against 2.6.4-rc1-mm2) does:

- move ide_cdrom_dump_status() from ide-cd.c to ide-lib.c as
  ide_dump_atapi_status() and both ide-cd and ide-scsi call it.

- replaces BUG() by WARN_ON()/printk in the error handling code.

- sets TASK_UNINTERRUPTIBLE before schedule_timeout() and moves the host
  unlock/lock around the while loop inside the loop in idescsi_eh_reset().

Regards, Willem Riede.

diff -ur m0/drivers/ide/ide-cd.c m2/drivers/ide/ide-cd.c
--- m0/drivers/ide/ide-cd.c	2004-03-05 19:53:28.000000000 -0500
+++ m2/drivers/ide/ide-cd.c	2004-03-07 09:54:08.000000000 -0500
@@ -554,53 +554,6 @@
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
-
-/*
- * Error reporting, in human readable form (luxurious, but a memory hog).
- */
-byte ide_cdrom_dump_status (ide_drive_t *drive, const char *msg, byte stat)
-{
-	unsigned long flags;
-
-	atapi_status_t status;
-	atapi_error_t error;
-
-	status.all = stat;
-	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-#if FANCY_STATUS_DUMPS
-	printk(" { ");
-	if (status.b.bsy)
-		printk("Busy ");
-	else {
-		if (status.b.drdy)	printk("DriveReady ");
-		if (status.b.df)	printk("DeviceFault ");
-		if (status.b.dsc)	printk("SeekComplete ");
-		if (status.b.drq)	printk("DataRequest ");
-		if (status.b.corr)	printk("CorrectedError ");
-		if (status.b.idx)	printk("Index ");
-		if (status.b.check)	printk("Error ");
-	}
-	printk("}");
-#endif	/* FANCY_STATUS_DUMPS */
-	printk("\n");
-	if ((status.all & (status.b.bsy|status.b.check)) == status.b.check) {
-		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, error.all);
-#if FANCY_STATUS_DUMPS
-		if (error.b.ili)	printk("IllegalLengthIndication ");
-		if (error.b.eom)	printk("EndOfMedia ");
-		if (error.b.abrt)	printk("Aborted Command ");
-		if (error.b.mcr)	printk("MediaChangeRequested ");
-		if (error.b.sense_key)	printk("LastFailedSense 0x%02x ",
-						error.b.sense_key);
-#endif	/* FANCY_STATUS_DUMPS */
-		printk("\n");
-	}
-	local_irq_restore(flags);
-	return error.all;
-}
-
 /*
  * ide_error() takes action based on the error returned by the drive.
  */
@@ -609,7 +562,7 @@
 	struct request *rq;
 	byte err;
 
-	err = ide_cdrom_dump_status(drive, msg, stat);
+	err = ide_dump_atapi_status(drive, msg, stat);
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 	/* retry only "normal" I/O: */
@@ -3411,7 +3364,7 @@
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
-	.sense			= ide_cdrom_dump_status,
+	.sense			= ide_dump_atapi_status,
 	.error			= ide_cdrom_error,
 	.abort			= ide_cdrom_abort,
 	.capacity		= ide_cdrom_capacity,
diff -ur m0/drivers/ide/ide-lib.c m2/drivers/ide/ide-lib.c
--- m0/drivers/ide/ide-lib.c	2004-02-17 22:59:44.000000000 -0500
+++ m2/drivers/ide/ide-lib.c	2004-03-07 09:52:34.000000000 -0500
@@ -447,3 +447,55 @@
 
 EXPORT_SYMBOL_GPL(ide_set_xfer_rate);
 
+/**
+ *	ide_dump_atapi_status       -       print human readable atapi status
+ *	@drive: drive that status applies to
+ *	@msg: text message to print
+ *	@stat: status byte to decode
+ *
+ *	Error reporting, in human readable form (luxurious, but a memory hog).
+ */
+byte ide_dump_atapi_status (ide_drive_t *drive, const char *msg, byte stat)
+{
+	unsigned long flags;
+
+	atapi_status_t status;
+	atapi_error_t error;
+
+	status.all = stat;
+	local_irq_set(flags);
+	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
+#if FANCY_STATUS_DUMPS
+	printk(" { ");
+	if (status.b.bsy)
+		printk("Busy ");
+	else {
+		if (status.b.drdy)	printk("DriveReady ");
+		if (status.b.df)	printk("DeviceFault ");
+		if (status.b.dsc)	printk("SeekComplete ");
+		if (status.b.drq)	printk("DataRequest ");
+		if (status.b.corr)	printk("CorrectedError ");
+		if (status.b.idx)	printk("Index ");
+		if (status.b.check)	printk("Error ");
+	}
+	printk("}");
+#endif	/* FANCY_STATUS_DUMPS */
+	printk("\n");
+	if ((status.all & (status.b.bsy|status.b.check)) == status.b.check) {
+		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
+		printk("%s: %s: error=0x%02x", drive->name, msg, error.all);
+#if FANCY_STATUS_DUMPS
+		if (error.b.ili)	printk("IllegalLengthIndication ");
+		if (error.b.eom)	printk("EndOfMedia ");
+		if (error.b.abrt)	printk("Aborted Command ");
+		if (error.b.mcr)	printk("MediaChangeRequested ");
+		if (error.b.sense_key)	printk("LastFailedSense 0x%02x ",
+						error.b.sense_key);
+#endif	/* FANCY_STATUS_DUMPS */
+		printk("\n");
+	}
+	local_irq_restore(flags);
+	return error.all;
+}
+
+EXPORT_SYMBOL(ide_dump_atapi_status);
diff -ur m0/drivers/scsi/ide-scsi.c m2/drivers/scsi/ide-scsi.c
--- m0/drivers/scsi/ide-scsi.c	2004-03-05 19:54:33.000000000 -0500
+++ m2/drivers/scsi/ide-scsi.c	2004-03-07 09:57:07.000000000 -0500
@@ -308,60 +308,12 @@
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
-/* Code derived from ide_cdrom_error()/abort() -- see ide-cd.c */
-
-/*
- * Error reporting, in human readable form (luxurious, but a memory hog).
- */
-byte idescsi_dump_status (ide_drive_t *drive, const char *msg, byte stat)
-{
-	unsigned long flags;
-
-	atapi_status_t status;
-	atapi_error_t error;
-
-	status.all = stat;
-	local_irq_set(flags);
-	printk(KERN_WARNING "ide-scsi: %s: %s: status=0x%02x", drive->name, msg, stat);
-#if IDESCSI_DEBUG_LOG
-	printk(" { ");
-	if (status.b.bsy)
-	       printk("Busy ");
-	else {
-	       if (status.b.drdy)      printk("DriveReady ");
-	       if (status.b.df)        printk("DeviceFault ");
-	       if (status.b.dsc)       printk("SeekComplete ");
-	       if (status.b.drq)       printk("DataRequest ");
-	       if (status.b.corr)      printk("CorrectedError ");
-	       if (status.b.idx)       printk("Index ");
-	       if (status.b.check)     printk("Error ");
-	}
-	printk("}");
-#endif  /* IDESCSI_DEBUG_LOG */
-	printk("\n");
-	if ((status.all & (status.b.bsy|status.b.check)) == status.b.check) {
-	       error.all = HWIF(drive)->INB(IDE_ERROR_REG);
-	       printk(KERN_WARNING "ide-scsi: %s: %s: error=0x%02x", drive->name, msg, error.all);
-#if IDESCSI_DEBUG_LOG
-	       if (error.b.ili)        printk("IllegalLengthIndication ");
-	       if (error.b.eom)        printk("EndOfMedia ");
-	       if (error.b.abrt)       printk("Aborted Command ");
-	       if (error.b.mcr)        printk("MediaChangeRequested ");
-	       if (error.b.sense_key)  printk("LastFailedSense 0x%02x ",
-					   error.b.sense_key);
-#endif  /* IDESCSI_DEBUG_LOG */
-	       printk("\n");
-	}
-	local_irq_restore(flags);
-	return error.all;
-}
-
 ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
 {
 	struct request *rq;
 	byte err;
 
-	err = idescsi_dump_status(drive, msg, stat);
+	err = ide_dump_atapi_status(drive, msg, stat);
 
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
@@ -980,7 +932,8 @@
 		printk (KERN_WARNING "ide-scsi: abort called for %lu\n", cmd->serial_number);
 
 	if (!drive) {
-		BUG();
+		printk (KERN_WARNING "ide-scsi: Drive not set in idescsi_eh_abort\n");
+		WARN_ON(1);
 		goto no_drive;
 	}
 
@@ -1039,14 +992,15 @@
 		printk (KERN_WARNING "ide-scsi: reset called for %lu\n", cmd->serial_number);
 
 	if (!drive) {
-		BUG();
+		printk (KERN_WARNING "ide-scsi: Drive not set in idescsi_eh_reset\n");
+		WARN_ON(1);
 		return FAILED;
 	}
 
 	spin_lock_irq(&ide_lock);
 
 	if (!scsi->pc || (req = scsi->pc->rq) != HWGROUP(drive)->rq || !HWGROUP(drive)->handler) {
-		BUG();
+		printk (KERN_WARNING "ide-scsi: No active request in idescsi_eh_reset\n");
 		spin_unlock(&ide_lock);
 		return FAILED;
 	}
@@ -1074,14 +1028,14 @@
 
 	ide_do_reset(drive);
 
-	spin_unlock_irq(cmd->device->host->host_lock);
-
 	/* ide_do_reset starts a polling handler which restarts itself every 50ms until the reset finishes */
 
-	do
-		/* There should be no locks taken at this point */
+	do {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(cmd->device->host->host_lock);
 		schedule_timeout(HZ/20);
-	while ( HWGROUP(drive)->handler );
+		spin_lock_irq(cmd->device->host->host_lock);
+	} while ( HWGROUP(drive)->handler );
 
 	ready = drive_is_ready(drive);
 	HWGROUP(drive)->busy--;
@@ -1090,8 +1044,6 @@
 		ret = FAILED;
 	}
 
-	spin_lock_irq(cmd->device->host->host_lock);
-
 	return ret;
 }
 
diff -ur m0/include/linux/ide.h m2/include/linux/ide.h
--- m0/include/linux/ide.h	2004-03-05 19:54:34.000000000 -0500
+++ m2/include/linux/ide.h	2004-03-07 10:17:30.000000000 -0500
@@ -1614,6 +1614,7 @@
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
+extern byte ide_dump_atapi_status(ide_drive_t *drive, const char *msg, byte stat);
 
 typedef struct ide_pio_timings_s {
 	int	setup_time;	/* Address setup (ns) minimum */
