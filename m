Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbTLZSN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 13:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTLZSN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 13:13:29 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:13752 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265198AbTLZSMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 13:12:44 -0500
Date: Fri, 26 Dec 2003 13:12:42 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: The survival of ide-scsi in 2.6.x
Message-ID: <20031226181242.GE1277@linnie.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I know that many feel that ide-scsi is useless, and should go away.
And you are probably tired of message threads talking about it.
Yet I ask respectfully that you hear me out, and give me feedback.

I need ide-scsi to survive. Why? I maintain osst, a driver for
OnStream tape drives, which need special handling. These drives
exist in SCSI, ATAPI, USB and IEEE1394 versions.

One high-level driver, osst, handles all of them, and that's how
it should be, right? For ATAPI, it relies on ide-scsi.

(By the way, ide-tape contains code for the ATAPI version, the 
DI-30, but that code is old and has serveral known problems - 
I'd like to see it removed - or at least deprecated - I will do 
that myself later if people want me to.)

So can we agree to keep ide-scsi? I know it is not desired any
more for cd writers. To avoid the problem reports from people who
don't realize that and select ide-scsi anyway, we can refuse to
attach to a cd-type device (today it just warns). And/or make a 
new explicit module parameter to tell ide-scsi exactly which 
drives to attach to.

Today, ide-scsi is buggy, and that needs fixing. The underlying
problem is that ide-scsi stands with one leg in the IDE world and
one leg in the SCSI world, which creates the challenge to make
the IDE error recovery work in sync with, and under the direction of 
the SCSI error handler.

Example bug reports are [1], [2], [3], [4], [5], and [6].

A recurring problem is scheduling while atomic, see [1], [5], [7].
Linus points bluntly to the problem in [7]. I plead guilty to
having introduced that code segment in [8]. I later attempted to
improve on the error handling in [9], but that patch was not
accepted (and wouldn't have fixed that particular problem).

[6] is different, and has me baffled - what can evoke a page fault
in idescsi_transfer_pc?

In the spirit of cleaning up one's own mess, I am working on a new
patch, to hopefully alleviate the problems. I've made liberal use 
of the attachments to the osdl bug reports [1]-[4] created by 
Mike Christie and a patch from Philip Auld [10], to give credit
where it is due. I've also looked at ide-cd to see what it does 
differently.

Please look at the attachment (looking past the touch-ups that I
made while I was at it...). Am I moving in the right direction?
Specific changes I need advise on:
1) timer expiry
   attachments to [1]-[4] and [10] suggest using it. Is it useful to
   buy some more time? I don't see the point to wait longer.
   By returning 0, I let ide_timer_expiry do its thing to handle lost
   (dma) interrupts. By seeting the PC_TIMEDOUT flag, I tell our
   end_request function to return DID_TIME_OUT to the scsi system.
2) ide (atapi) abort/error
   By providing ide-scsi's own error/abort functions, I defer all
   errror handling to the scsi error handlers. I have nagging doubts
   about totally removing ide_do_reset() calls from them though :-(
3) scsi (eh) abort/error
   These take much inspiration from Mike Christie's work on [1]-[4]
   The eh_abort gets called first, and takes an opportunistic approach
   (if the problem resolves itslf, great). The eh_error pulls the
   carpet from under the request, and does the ide_do_reset().
   I hope I've not introduced any new locking/scheduling issues :-)

I've tested the patched ide-scsi with 2.6.0 - and it works fine.
Too good actually, meaning the new error routines have not been
adequately exercised. Any hints as to how to simulate errors at
the ide subsystem level? Something like Stephen Tweedie's testdrive
[11] perhaps (if applicable to char device), but for 2.6?

Linus states in [7] that ide-scsi needs a maintainer. I haven't seen 
anyone step forward, so that leads me to believe I may be the only 
person that depends enough on ide-scsi to be motivated?

If people will have me, I am prepared to take on that responsibility.
I am just concerned that I may not have enough of a variety of devices
to be able to thoroughly test it (unless the DI-30 is the only one :-)).
What do people see as the requirements to be able to maintain ide-scsi?

OK, let me have it... Thanks, Willem Riede.

References:
[1]  http://bugme.osdl.org/show_bug.cgi?id=393
[2]  http://bugme.osdl.org/show_bug.cgi?id=829
[3]  http://bugme.osdl.org/show_bug.cgi?id=1335
[4]  http://bugme.osdl.org/show_bug.cgi?id=1381
[5]  http://marc.theaimsgroup.com/?l=linux-kernel&m=107103475609592&w=2
[6]  http://marc.theaimsgroup.com/?l=linux-scsi&m=105334942001271&w=2
[7]  http://marc.theaimsgroup.com/?l=linux-kernel&m=107150176124047&w=2
[8]  http://marc.theaimsgroup.com/?l=linux-scsi&m=104051080518591&w=2
[9]  http://marc.theaimsgroup.com/?l=linux-scsi&m=104361480527780&w=2
[10] http://marc.theaimsgroup.com/?l=linux-scsi&m=107115248030218&w=2
[11] http://people.redhat.com/sct/patches/testdrive/

--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename="ide-scsi-patch.txt"

--- ide-scsi.c-l260	2003-12-23 13:01:01.000000000 -0500
+++ ide-scsi.c	2003-12-26 12:18:17.000000000 -0500
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
@@ -54,7 +56,9 @@
 #include "hosts.h"
 #include <scsi/sg.h>
 
-#define IDESCSI_DEBUG_LOG		0
+#define IDESCSI_DEBUG_LOG	0
+#define IDESCSI_DEBUG		KERN_NOTICE
+#define IDESCSI_LOG		KERN_INFO
 
 typedef struct idescsi_pc_s {
 	u8 c[12];				/* Actual packet bytes */
@@ -78,6 +82,7 @@
 #define PC_DMA_IN_PROGRESS		0	/* 1 while DMA in progress */
 #define PC_WRITING			1	/* Data direction */
 #define PC_TRANSFORM			2	/* transform SCSI commands */
+#define PC_TIMEDOUT			3	/* FIXME - WR command timed out */
 #define PC_DMA_OK			4	/* Use DMA */
 
 /*
@@ -270,7 +275,7 @@
 	printk("]\n");
 }
 
-static int idescsi_check_condition(ide_drive_t *drive, struct request *failed_command)
+static int idescsi_check_condition(ide_drive_t *drive, idescsi_pc_t *failed_command)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	idescsi_pc_t   *pc;
@@ -298,34 +303,119 @@
 	rq->flags = REQ_SENSE;
 	pc->timeout = jiffies + WAIT_READY;
 	/* NOTE! Save the failed packet command in "rq->buffer" */
-	rq->buffer = (void *) failed_command->special;
-	pc->scsi_cmd = ((idescsi_pc_t *) failed_command->special)->scsi_cmd;
+	rq->buffer = (void *) failed_command;
+	pc->scsi_cmd = failed_command->scsi_cmd;
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
-		printk ("ide-scsi: %s: queue cmd = ", drive->name);
+		printk (IDESCSI_LOG "ide-scsi: %s: queue cmd = ", drive->name);
 		hexdump(pc->c, 6);
 	}
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
-	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
-	struct request *rq = HWGROUP(drive)->rq;
-	idescsi_pc_t *pc = (idescsi_pc_t *) rq->special;
-	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
+	idescsi_scsi_t   *scsi = drive_to_idescsi(drive);
+	struct request   *rq  = HWGROUP(drive)->rq;
+	idescsi_pc_t     *pc  = (idescsi_pc_t *) rq->special;
+	int               log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	struct Scsi_Host *host;
-	u8 *scsi_buf;
-	unsigned long flags;
+	u8               *scsi_buf;
+	unsigned long     flags;
 
 	if (!(rq->flags & (REQ_SPECIAL|REQ_SENSE))) {
 		ide_end_request(drive, uptodate, nrsecs);
 		return 0;
 	}
 	ide_end_drive_cmd (drive, 0, 0);
+
 	if (rq->flags & REQ_SENSE) {
 		idescsi_pc_t *opc = (idescsi_pc_t *) rq->buffer;
 		if (log) {
-			printk ("ide-scsi: %s: wrap up check %lu, rst = ", drive->name, opc->scsi_cmd->serial_number);
+			printk (IDESCSI_LOG "ide-scsi: %s: wrap up check %lu, rst = ",
+					drive->name, opc->scsi_cmd->serial_number);
 			hexdump(pc->buffer,16);
 		}
 		memcpy((void *) opc->scsi_cmd->sense_buffer, pc->buffer, SCSI_SENSE_BUFFERSIZE);
@@ -334,24 +424,38 @@
 		kfree(rq);
 		pc = opc;
 		rq = pc->rq;
-		pc->scsi_cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-	} else if (rq->errors >= ERROR_MAX) {
-		pc->scsi_cmd->result = DID_ERROR << 16;
+		pc->scsi_cmd->result = (CHECK_CONDITION << 1) |
+					 ((test_bit(PC_TIMEDOUT, &pc->flags)?DID_TIME_OUT:DID_OK) << 16);
+	}
+	else if (test_bit(PC_TIMEDOUT, &pc->flags)) {
+		if (log)
+			printk (IDESCSI_LOG "ide-scsi: %s: timed out for %lu\n",
+					drive->name, pc->scsi_cmd->serial_number);
+		pc->scsi_cmd->result = DID_TIME_OUT << 16;
+	}
+	else if (rq->errors >= ERROR_MAX) {
 		if (log)
-			printk ("ide-scsi: %s: I/O error for %lu\n", drive->name, pc->scsi_cmd->serial_number);
-	} else if (rq->errors) {
+			printk (IDESCSI_LOG "ide-scsi: %s: I/O error for %lu\n",
+					drive->name, pc->scsi_cmd->serial_number);
+		pc->scsi_cmd->result = DID_ERROR << 16;
+	}
+	else if (rq->errors) {
 		if (log)
-			printk ("ide-scsi: %s: check condition for %lu\n", drive->name, pc->scsi_cmd->serial_number);
-		if (!idescsi_check_condition(drive, rq))
+			printk (IDESCSI_LOG "ide-scsi: %s: check condition for %lu\n",
+					drive->name, pc->scsi_cmd->serial_number);
+		if (!idescsi_check_condition(drive, pc))
 			/* we started a request sense, so we'll be back, exit for now */
 			return 0;
 		pc->scsi_cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-	} else {
+	}
+	else {
 		pc->scsi_cmd->result = DID_OK << 16;
 		idescsi_transform_pc2 (drive, pc);
 		if (log) {
-			printk ("ide-scsi: %s: suc %lu", drive->name, pc->scsi_cmd->serial_number);
-			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred && pc->actually_transferred <= 1024 && pc->buffer) {
+			printk (IDESCSI_LOG "ide-scsi: %s: success %lu",
+					drive->name, pc->scsi_cmd->serial_number);
+			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred &&
+			    pc->actually_transferred <= 1024 && pc->buffer) {
 				printk(", rst = ");
 				scsi_buf = pc->scsi_cmd->request_buffer;
 				hexdump(scsi_buf, IDE_MIN(16, pc->scsi_cmd->request_bufflen));
@@ -374,6 +478,19 @@
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
@@ -390,12 +507,21 @@
 	unsigned int temp;
 
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
+	printk (IDESCSI_DEBUG "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
 #endif /* IDESCSI_DEBUG_LOG */
 
+	if (test_bit(PC_TIMEDOUT, &pc->flags)){
+#if IDESCSI_DEBUG_LOG
+		printk(IDESCSI_DEBUG "idescsi_pc_intr: got timed out packet %lu at %lu\n",
+				pc->scsi_cmd->serial_number, jiffies);
+#endif
+		/* end this request now - scsi should retry it*/
+		idescsi_end_request (drive, 1, 0);
+		return ide_stopped;
+	}
 	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: DMA complete\n", drive->name);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: DMA complete\n", drive->name);
 #endif /* IDESCSI_DEBUG_LOG */
 		pc->actually_transferred=pc->request_transfer;
 		(void) HWIF(drive)->ide_dma_end(drive);
@@ -408,7 +534,8 @@
 	if (!status.b.drq) {
 		/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
-			printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
+			printk (IDESCSI_LOG "Packet command completed, %d bytes transferred\n",
+					pc->actually_transferred);
 		local_irq_enable();
 		if (status.b.check)
 			rq->errors++;
@@ -442,11 +569,12 @@
 				pc->actually_transferred += temp;
 				pc->current_position += temp;
 				idescsi_discard_data(drive, bcount.all - temp);
-				ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
+				ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 				return ide_started;
 			}
 #if IDESCSI_DEBUG_LOG
-			printk (KERN_NOTICE "ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
+			printk (IDESCSI_LOG
+				"ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
 #endif /* IDESCSI_DEBUG_LOG */
 		}
 	}
@@ -467,7 +595,8 @@
 	pc->actually_transferred += bcount.all;
 	pc->current_position += bcount.all;
 
-	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);	/* And set the interrupt handler again */
+	/* And set the interrupt handler again */
+	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 	return ide_started;
 }
 
@@ -480,10 +609,10 @@
 
 	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk(KERN_ERR "ide-scsi: Strange, packet command "
-			"initiated yet DRQ isn't asserted\n");
+				"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
 	if (!ireason.b.cod || ireason.b.io) {
 		printk(KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while "
 				"issuing a packet command\n");
@@ -492,7 +621,7 @@
 	if (HWGROUP(drive)->handler != NULL)
 		BUG();
 	/* Set the interrupt routine */
-	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
+	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 	/* Send the actual packet */
 	atapi_output_bytes(drive, scsi->pc->c, 12);
 	if (test_bit (PC_DMA_OK, &pc->flags)) {
@@ -537,12 +666,7 @@
 		set_bit(PC_DMA_OK, &pc->flags);
 
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
-		ide_set_handler(drive, &idescsi_transfer_pc,
-				get_timeout(pc), NULL);
-		/* Issue the packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		ide_execute_command(drive, WIN_PACKETCMD, &idescsi_transfer_pc, get_timeout(pc), idescsi_expiry);
 		return ide_started;
 	} else {
 		/* Issue the packet command */
@@ -557,8 +681,10 @@
 static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "rq_status: %d, dev: %s, cmd: %x, errors: %d\n",rq->rq_status, rq->rq_disk->disk_name,rq->cmd[0],rq->errors);
-	printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
+	printk (IDESCSI_DEBUG "rq_status: %d, dev: %s, cmd: %x, errors: %d\n",
+			rq->rq_status, rq->rq_disk->disk_name,rq->cmd[0],rq->errors);
+	printk (IDESCSI_DEBUG "sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",
+			rq->sector,rq->nr_sectors,rq->current_nr_sectors);
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (rq->flags & (REQ_SPECIAL|REQ_SENSE)) {
@@ -633,6 +759,8 @@
 	.cleanup		= idescsi_cleanup,
 	.do_request		= idescsi_do_request,
 	.end_request		= idescsi_end_request,
+	.error                  = idescsi_atapi_error,
+	.abort                  = idescsi_atapi_abort,
 	.drives			= LIST_HEAD_INIT(idescsi_driver.drives),
 };
 
@@ -744,7 +872,8 @@
 		if ((first_bh = bh = idescsi_kmalloc_bio (segments)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB total\n", drive->name, segments, pc->request_transfer >> 10);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: building DMA table, %d segments, %dkB total\n",
+				drive->name, segments, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		while (segments--) {
 			bh->bi_io_vec[0].bv_page = sg->page;
@@ -758,7 +887,8 @@
 		if ((first_bh = bh = idescsi_kmalloc_bio (1)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table for a single buffer (%dkB)\n", drive->name, pc->request_transfer >> 10);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: building DMA table for a single buffer (%dkB)\n",
+				drive->name, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		bh->bi_io_vec[0].bv_page = virt_to_page(pc->scsi_cmd->request_buffer);
 		bh->bi_io_vec[0].bv_offset = offset_in_page(pc->scsi_cmd->request_buffer);
@@ -788,16 +918,16 @@
 
 static int idescsi_queue (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
-	idescsi_scsi_t *scsi = scsihost_to_idescsi(cmd->device->host);
-	ide_drive_t *drive = scsi->drive;
-	struct request *rq = NULL;
-	idescsi_pc_t *pc = NULL;
+	idescsi_scsi_t *scsi  = scsihost_to_idescsi(cmd->device->host);
+	ide_drive_t    *drive = scsi->drive;
+	struct request *rq    = NULL;
+	idescsi_pc_t   *pc    = NULL;
 
 	if (!drive) {
 		printk (KERN_ERR "ide-scsi: drive id %d not present\n", cmd->device->id);
 		goto abort;
 	}
-	scsi = drive_to_idescsi(drive);
+//	scsi = drive_to_idescsi(drive);				scsi already initialized above!
 	pc = kmalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
 	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
 	if (rq == NULL || pc == NULL) {
@@ -827,10 +957,10 @@
 	idescsi_transform_pc1 (drive, pc);
 
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
-		printk ("ide-scsi: %s: que %lu, cmd = ", drive->name, cmd->serial_number);
+		printk (IDESCSI_LOG "ide-scsi: %s: que %lu, cmd = ", drive->name, cmd->serial_number);
 		hexdump(cmd->cmnd, cmd->cmd_len);
 		if (memcmp(pc->c, cmd->cmnd, cmd->cmd_len)) {
-			printk ("ide-scsi: %s: que %lu, tsl = ", drive->name, cmd->serial_number);
+			printk (IDESCSI_LOG "ide-scsi: %s: que %lu, tsl = ", drive->name, cmd->serial_number);
 			hexdump(pc->c, 12);
 		}
 	}
@@ -851,73 +981,139 @@
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
+	}
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
 	}
-	return FAILED;
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
+
+	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
+		printk (IDESCSI_DEBUG "ide-scsi: reset called for %lu\n", cmd->serial_number);
+
+	if (!drive) {
+		BUG();
+		return FAILED;
+	}
 
-	printk (KERN_ERR "ide-scsi: reset called for %lu\n", cmd->serial_number);
-	/* first null the handler for the drive and let any process
-	 * doing IO (on another CPU) run to (partial) completion
-	 * the lock prevents processing new requests */
-	spin_lock_irqsave(&ide_lock, flags);
-	while (HWGROUP(drive)->handler) {
-		HWGROUP(drive)->handler = NULL;
-		schedule_timeout(1);
+	spin_lock_irq(&ide_lock);
+
+	if (!scsi->pc || (req = scsi->pc->rq) != HWGROUP(drive)->rq || !HWGROUP(drive)->handler) {
+		BUG();
+		spin_unlock(&ide_lock);
+		return FAILED;
 	}
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
 		sector_t capacity, int *parm)
 {
-	idescsi_scsi_t *idescsi = scsihost_to_idescsi(sdev->host);
-	ide_drive_t *drive = idescsi->drive;
+	idescsi_scsi_t *scsi = scsihost_to_idescsi(sdev->host);
+	ide_drive_t *drive = scsi->drive;
 
 	if (drive->bios_cyl && drive->bios_head && drive->bios_sect) {
 		parm[0] = drive->bios_head;
@@ -934,8 +1130,8 @@
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
@@ -949,7 +1145,7 @@
 
 static int idescsi_attach(ide_drive_t *drive)
 {
-	idescsi_scsi_t *idescsi;
+	idescsi_scsi_t *scsi;
 	struct Scsi_Host *host;
 	static int warned;
 	int err;
@@ -968,12 +1164,12 @@
 	host->max_id = 1;
 	host->max_lun = 1;
 	drive->driver_data = host;
-	idescsi = scsihost_to_idescsi(host);
-	idescsi->drive = drive;
+	scsi = scsihost_to_idescsi(host);
+	scsi->drive = drive;
 	err = ide_register_subdriver (drive, &idescsi_driver,
 				      IDE_SUBDRIVER_VERSION);
 	if (!err) {
-		idescsi_setup (drive, idescsi);
+		idescsi_setup (drive, scsi);
 		drive->disk->fops = &idescsi_ops;
 		err = scsi_add_host(host, &drive->gendev);
 		if (!err) {

--J5MfuwkIyy7RmF4Q--
