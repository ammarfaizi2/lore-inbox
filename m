Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUAaV7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUAaV7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:59:23 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:43513 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265114AbUAaV7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:59:04 -0500
Date: Sat, 31 Jan 2004 16:59:02 -0500
From: Willem Riede <wrlk@riede.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The survival of ide-scsi in 2.6.x [PATCH 3/3]
Message-ID: <20040131215902.GA23308@serve.riede.org>
Reply-To: wrlk@riede.org
References: <1072809890.2839.24.camel@mulgrave> <20040103190857.GY5523@suse.de> <20040128132400.GA23308@serve.riede.org> <200401302356.59401.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200401302356.59401.bzolnier@elka.pw.edu.pl> (from B.Zolnierkiewicz@elka.pw.edu.pl on Fri, Jan 30, 2004 at 17:56:59 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.01.30 17:56, Bartlomiej Zolnierkiewicz wrote:
> 
> Can you split your patch and drop cosmetic changes?

Changes in this third patch: 
- introduce idescsi_expiry, a timeout routine for the ide subsystem,
  which simply flags the fact that the command timed out, but postpones
  any other action until either the command still finishes on its own
  (unlikely?) or the scsi error handler kicks in;
- introduce idescsi_atapi_error and idescsi_atapi_abort, error routines
  for the ide subsystem, which are modeled after those of ide-cd, but
  take only minimal effort to recover, leaving the heavy lifting for
  the scsi error handler;
- rewrite (and rename for clarity) idescsi_eh_abort and idescsi_eh_error,
  the abort/error routines to be called by the scsi error handler --
  this redesign should not have the scheduling while atomic problems
  of the old implementation.

> I have troubles with reading/understanding it,

Please let me know if you want me to elaborate further on the changes.

Regards, Willem Riede.

--- p2/drivers/scsi/ide-scsi.c	2004-01-31 15:57:08.000000000 -0500
+++ p3/drivers/scsi/ide-scsi.c	2004-01-31 15:48:41.000000000 -0500
@@ -29,9 +29,11 @@
  * Ver 0.9   Jul 04 99   Fix a bug in SG_SET_TRANSFORM.
  * Ver 0.91  Jun 10 02   Fix "off by one" error in transforms
  * Ver 0.92  Dec 31 02   Implement new SCSI mid level API
+ * Ver 0.93  Sep 25 03   New error handling implementation.
+ * Ver 0.94  Dec xx 03   Improvements on error handling.
  */
 
-#define IDESCSI_VERSION "0.92"
+#define IDESCSI_VERSION "0.94WR"
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -80,6 +82,7 @@
 #define PC_DMA_IN_PROGRESS		0	/* 1 while DMA in progress */
 #define PC_WRITING			1	/* Data direction */
 #define PC_TRANSFORM			2	/* transform SCSI commands */
+#define PC_TIMEDOUT			3	/* FIXME - WR command timed out */
 #define PC_DMA_OK			4	/* Use DMA */
 
 /*
@@ -309,6 +312,89 @@
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
+/* FIXME - WR - code derived from ide_cdrom_error()/abort() -- see ide-cd.c */
+
+/*
+ * Error reporting, in human readable form (luxurious, but a memory hog).
+ */
+byte idescsi_dump_status (ide_drive_t *drive, const char *msg, byte stat)
+{
+	unsigned long flags;
+
+	atapi_status_t status;
+	atapi_error_t error;
+
+	status.all = stat;
+	local_irq_set(flags);
+	printk(KERN_WARNING "ide-scsi: %s: %s: status=0x%02x", drive->name, msg, stat);
+#if IDESCSI_DEBUG_LOG
+	printk(" { ");
+	if (status.b.bsy)
+	       printk("Busy ");
+	else {
+	       if (status.b.drdy)      printk("DriveReady ");
+	       if (status.b.df)        printk("DeviceFault ");
+	       if (status.b.dsc)       printk("SeekComplete ");
+	       if (status.b.drq)       printk("DataRequest ");
+	       if (status.b.corr)      printk("CorrectedError ");
+	       if (status.b.idx)       printk("Index ");
+	       if (status.b.check)     printk("Error ");
+	}
+	printk("}");
+#endif  /* IDESCSI_DEBUG_LOG */
+	printk("\n");
+	if ((status.all & (status.b.bsy|status.b.check)) == status.b.check) {
+	       error.all = HWIF(drive)->INB(IDE_ERROR_REG);
+	       printk(KERN_WARNING "ide-scsi: %s: %s: error=0x%02x", drive->name, msg, error.all);
+#if IDESCSI_DEBUG_LOG
+	       if (error.b.ili)        printk("IllegalLengthIndication ");
+	       if (error.b.eom)        printk("EndOfMedia ");
+	       if (error.b.abrt)       printk("Aborted Command ");
+	       if (error.b.mcr)        printk("MediaChangeRequested ");
+	       if (error.b.sense_key)  printk("LastFailedSense 0x%02x ",
+					   error.b.sense_key);
+#endif  /* IDESCSI_DEBUG_LOG */
+	       printk("\n");
+	}
+	local_irq_restore(flags);
+	return error.all;
+}
+
+ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
+{
+	struct request *rq;
+	byte err;
+
+	err = idescsi_dump_status(drive, msg, stat);
+
+	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+		return ide_stopped;
+
+	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
+		/* force an abort */
+		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+
+	rq->errors++;
+	DRIVER(drive)->end_request(drive, 0, 0);
+	return ide_stopped;
+}
+ 
+ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
+{
+	struct request *rq;
+ 
+	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+	       return ide_stopped;
+
+#if IDESCSI_DEBUG_LOG
+	printk(IDESCSI_DEBUG "idescsi_atapi_abort called for %lu\n",
+			((idescsi_pc_t *) rq->special)->scsi_cmd->serial_number);
+#endif
+	rq->errors |= ERROR_MAX;
+	DRIVER(drive)->end_request(drive, 0, 0);
+	return ide_stopped;
+}
+
 static int idescsi_end_request (ide_drive_t *drive, int uptodate, int nrsecs)
 {
 	idescsi_scsi_t   *scsi = drive_to_idescsi(drive);
@@ -338,7 +424,14 @@
 		kfree(rq);
 		pc = opc;
 		rq = pc->rq;
-		pc->scsi_cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
+		pc->scsi_cmd->result = (CHECK_CONDITION << 1) |
+					 ((test_bit(PC_TIMEDOUT, &pc->flags)?DID_TIME_OUT:DID_OK) << 16);
+	}
+	else if (test_bit(PC_TIMEDOUT, &pc->flags)) {
+		if (log)
+			printk (IDESCSI_LOG "ide-scsi: %s: timed out for %lu\n",
+					drive->name, pc->scsi_cmd->serial_number);
+		pc->scsi_cmd->result = DID_TIME_OUT << 16;
 	}
 	else if (rq->errors >= ERROR_MAX) {
 		if (log)
@@ -385,6 +478,19 @@
 	return IDE_MAX(WAIT_CMD, pc->timeout - jiffies);
 }
 
+static int idescsi_expiry(ide_drive_t *drive)
+{
+	idescsi_scsi_t *scsi = drive->driver_data;
+	idescsi_pc_t   *pc   = scsi->pc;
+
+#if IDESCSI_DEBUG_LOG
+	printk(IDESCSI_DEBUG "idescsi_expiry called for %lu at %lu\n", pc->scsi_cmd->serial_number, jiffies);
+#endif
+	set_bit(PC_TIMEDOUT, &pc->flags);
+
+	return 0;					/* we do not want the ide subsystem to retry */
+}
+
 /*
  *	Our interrupt handler.
  */
@@ -404,6 +510,15 @@
 	printk (IDESCSI_DEBUG "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
 #endif /* IDESCSI_DEBUG_LOG */
 
+	if (test_bit(PC_TIMEDOUT, &pc->flags)){
+#if IDESCSI_DEBUG_LOG
+		printk(IDESCSI_DEBUG "idescsi_pc_intr: got timed out packet  %lu at %lu\n",
+				pc->scsi_cmd->serial_number, jiffies);
+#endif
+		/* end this request now - scsi should retry it*/
+		idescsi_end_request (drive, 1, 0);
+		return ide_stopped;
+	}
 	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
 #if IDESCSI_DEBUG_LOG
 		printk (IDESCSI_DEBUG "ide-scsi: %s: DMA complete\n", drive->name);
@@ -454,7 +569,7 @@
 				pc->actually_transferred += temp;
 				pc->current_position += temp;
 				idescsi_discard_data(drive, bcount.all - temp);
-				ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
+				ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 				return ide_started;
 			}
 #if IDESCSI_DEBUG_LOG
@@ -480,7 +595,8 @@
 	pc->actually_transferred += bcount.all;
 	pc->current_position += bcount.all;
 
-	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);	/* And set the interrupt handler again */
+	/* And set the interrupt handler again */
+	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 	return ide_started;
 }
 
@@ -505,7 +621,7 @@
 	if (HWGROUP(drive)->handler != NULL)
 		BUG();
 	/* Set the interrupt routine */
-	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
+	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 	/* Send the actual packet */
 	atapi_output_bytes(drive, scsi->pc->c, 12);
 	if (test_bit (PC_DMA_OK, &pc->flags)) {
@@ -550,7 +666,7 @@
 		set_bit(PC_DMA_OK, &pc->flags);
 
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
-		ide_execute_command(drive, WIN_PACKETCMD, &idescsi_transfer_pc, get_timeout(pc), NULL);
+		ide_execute_command(drive, WIN_PACKETCMD, &idescsi_transfer_pc, get_timeout(pc), idescsi_expiry);
 		return ide_started;
 	} else {
 		/* Issue the packet command */
@@ -643,6 +759,8 @@
 	.cleanup		= idescsi_cleanup,
 	.do_request		= idescsi_do_request,
 	.end_request		= idescsi_end_request,
+	.error                  = idescsi_atapi_error,
+	.abort                  = idescsi_atapi_abort,
 	.drives			= LIST_HEAD_INIT(idescsi_driver.drives),
 };
 
@@ -864,66 +982,132 @@
 	return 1;
 }
 
-static int idescsi_abort (Scsi_Cmnd *cmd)
+static int idescsi_eh_abort (Scsi_Cmnd *cmd)
 {
-	int countdown = 8;
-	unsigned long flags;
-	idescsi_scsi_t *scsi = scsihost_to_idescsi(cmd->device->host);
-	ide_drive_t *drive = scsi->drive;
+	idescsi_scsi_t *scsi  = scsihost_to_idescsi(cmd->device->host);
+	ide_drive_t    *drive = scsi->drive;
+	int		busy;
+	int             ret   = FAILED;
 
-	printk (KERN_ERR "ide-scsi: abort called for %lu\n", cmd->serial_number);
-	while (countdown--) {
-		/* is cmd active?
-		 *  need to lock so this stuff doesn't change under us */
-		spin_lock_irqsave(&ide_lock, flags);
-		if (scsi->pc && scsi->pc->scsi_cmd && 
-				scsi->pc->scsi_cmd->serial_number == cmd->serial_number) {
-			/* yep - let's give it some more time - 
-			 * we can do that, we're in _our_ error kernel thread */
-			spin_unlock_irqrestore(&ide_lock, flags);
-			scsi_sleep(HZ);
-			continue;
-		}
-		/* no, but is it queued in the ide subsystem? */
-		if (elv_queue_empty(drive->queue)) {
-			spin_unlock_irqrestore(&ide_lock, flags);
-			return SUCCESS;
-		}
-		spin_unlock_irqrestore(&ide_lock, flags);
-		schedule_timeout(HZ/10);
+	/* In idescsi_eh_abort we try to gently pry our command from the ide subsystem */
+
+	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
+		printk (IDESCSI_LOG "ide-scsi: abort called for %lu\n", cmd->serial_number);
+
+	if (!drive) {
+		BUG();
+		goto no_drive;
 	}
-	return FAILED;
+
+	/* First give it some more time, how much is "right" is hard to say :-( */
+
+	busy = ide_wait_not_busy(HWIF(drive), 100);	/* FIXME - uses mdelay which causes latency? */
+	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
+		printk (IDESCSI_LOG "ide-scsi: drive did%s become ready\n", busy?" not":"");
+
+	spin_lock_irq(&ide_lock);
+
+	/* If there is no pc running we're done (our interrupt took care of it) */
+	if (!scsi->pc) {
+		ret = SUCCESS;
+		goto ide_unlock;
+	}
+
+	/* It's somewhere in flight. Does ide subsystem agree? */
+	if (scsi->pc->scsi_cmd->serial_number == cmd->serial_number && !busy &&
+	    elv_queue_empty(drive->queue) && HWGROUP(drive)->rq != scsi->pc->rq) {
+		/*
+		 * FIXME - not sure this condition can ever occur 
+		 */
+		printk (KERN_ERR "ide-scsi: cmd aborted!\n");
+
+		idescsi_free_bio(scsi->pc->rq->bio);
+		if (scsi->pc->rq->flags & REQ_SENSE)
+			kfree(scsi->pc->buffer);
+		kfree(scsi->pc->rq);
+		kfree(scsi->pc);
+		scsi->pc = NULL;
+
+		ret = SUCCESS;
+	}
+
+ide_unlock:
+	spin_unlock_irq(&ide_lock);
+no_drive:
+	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
+		printk (IDESCSI_LOG "ide-scsi: abort returns %s\n", ret == SUCCESS?"success":"failed");
+
+	return ret;
 }
 
-static int idescsi_reset (Scsi_Cmnd *cmd)
+static int idescsi_eh_reset (Scsi_Cmnd *cmd)
 {
-	unsigned long flags;
 	struct request *req;
-	idescsi_scsi_t *idescsi = scsihost_to_idescsi(cmd->device->host);
-	ide_drive_t *drive = idescsi->drive;
+	idescsi_scsi_t *scsi  = scsihost_to_idescsi(cmd->device->host);
+	ide_drive_t    *drive = scsi->drive;
+	int             ready = 0;
+	int             ret   = SUCCESS;
+
+	/* In idescsi_eh_reset we forcefully remove the command from the ide subsystem and reset the device. */
 
-	printk (KERN_ERR "ide-scsi: reset called for %lu\n", cmd->serial_number);
-	/* first null the handler for the drive and let any process
-	 * doing IO (on another CPU) run to (partial) completion
-	 * the lock prevents processing new requests */
-	spin_lock_irqsave(&ide_lock, flags);
-	while (HWGROUP(drive)->handler) {
-		HWGROUP(drive)->handler = NULL;
-		schedule_timeout(1);
+	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
+		printk (IDESCSI_DEBUG "ide-scsi: reset called for %lu\n", cmd->serial_number);
+
+	if (!drive) {
+		BUG();
+		return FAILED;
 	}
+
+	spin_lock_irq(&ide_lock);
+
+	if (!scsi->pc || (req = scsi->pc->rq) != HWGROUP(drive)->rq || !HWGROUP(drive)->handler) {
+		BUG();
+		spin_unlock(&ide_lock);
+		return FAILED;
+	}
+
+	/* kill current request */
+	blkdev_dequeue_request(req);
+	end_that_request_last(req);
+	idescsi_free_bio(req->bio);
+	if (req->flags & REQ_SENSE)
+		kfree(scsi->pc->buffer);
+	kfree(scsi->pc);
+	scsi->pc = NULL;
+	kfree(req);
+
 	/* now nuke the drive queue */
 	while ((req = elv_next_request(drive->queue))) {
 		blkdev_dequeue_request(req);
 		end_that_request_last(req);
 	}
-	/* FIXME - this will probably leak memory */
+
 	HWGROUP(drive)->rq = NULL;
-	if (drive_to_idescsi(drive))
-		drive_to_idescsi(drive)->pc = NULL;
-	spin_unlock_irqrestore(&ide_lock, flags);
-	/* finally, reset the drive (and its partner on the bus...) */
-	ide_do_reset (drive);	
-	return SUCCESS;
+	HWGROUP(drive)->handler = NULL;
+	HWGROUP(drive)->busy = 1;		/* will set this to zero when ide reset finished */
+	spin_unlock_irq(&ide_lock);
+
+	ide_do_reset(drive);
+
+	spin_unlock_irq(cmd->device->host->host_lock);
+
+	/* ide_do_reset starts a polling handler which restarts itself every 50ms until the reset finishes */
+
+	do
+		/* There should be no locks taken at this point */
+		schedule_timeout(HZ/20);
+	while ( HWGROUP(drive)->handler );
+
+	ready = drive_is_ready(drive);
+	HWGROUP(drive)->busy--;
+	if (!ready) {
+		printk (KERN_ERR "ide-scsi: reset failed!\n");
+		ret = FAILED;
+	}
+		
+	spin_lock_irq(cmd->device->host->host_lock);
+
+	return ret;
 }
 
 static int idescsi_bios(struct scsi_device *sdev, struct block_device *bdev,
@@ -947,8 +1131,8 @@
 	.slave_configure        = idescsi_slave_configure,
 	.ioctl			= idescsi_ioctl,
 	.queuecommand		= idescsi_queue,
-	.eh_abort_handler	= idescsi_abort,
-	.eh_device_reset_handler = idescsi_reset,
+	.eh_abort_handler	= idescsi_eh_abort,
+	.eh_host_reset_handler  = idescsi_eh_reset,
 	.bios_param		= idescsi_bios,
 	.can_queue		= 40,
 	.this_id		= -1,
