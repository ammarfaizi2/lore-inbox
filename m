Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUAaVpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUAaVpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:45:38 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:64402 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265111AbUAaVpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:45:14 -0500
Date: Sat, 31 Jan 2004 16:45:13 -0500
From: Willem Riede <wrlk@riede.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The survival of ide-scsi in 2.6.x [PATCH 2/3]
Message-ID: <20040131214513.GY23308@serve.riede.org>
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

Changes in this second patch:
- some whitespace changes to improve readability
- use consistent printk priorities

Regards, Willem Riede.

--- p1/drivers/scsi/ide-scsi.c	2004-01-31 15:37:31.000000000 -0500
+++ p2/drivers/scsi/ide-scsi.c	2004-01-31 15:57:08.000000000 -0500
@@ -54,7 +54,9 @@
 #include "hosts.h"
 #include <scsi/sg.h>
 
-#define IDESCSI_DEBUG_LOG		0
+#define IDESCSI_DEBUG_LOG	0
+#define IDESCSI_DEBUG		KERN_NOTICE
+#define IDESCSI_LOG		KERN_INFO
 
 typedef struct idescsi_pc_s {
 	u8 c[12];				/* Actual packet bytes */
@@ -301,7 +303,7 @@
 	rq->buffer = (void *) failed_command;
 	pc->scsi_cmd = failed_command->scsi_cmd;
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
-		printk ("ide-scsi: %s: queue cmd = ", drive->name);
+		printk (IDESCSI_LOG "ide-scsi: %s: queue cmd = ", drive->name);
 		hexdump(pc->c, 6);
 	}
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
@@ -309,23 +311,25 @@
 
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
@@ -335,23 +339,30 @@
 		pc = opc;
 		rq = pc->rq;
 		pc->scsi_cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-	} else if (rq->errors >= ERROR_MAX) {
-		pc->scsi_cmd->result = DID_ERROR << 16;
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
+			printk (IDESCSI_LOG "ide-scsi: %s: check condition for %lu\n",
+					drive->name, pc->scsi_cmd->serial_number);
 		if (!idescsi_check_condition(drive, pc))
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
+			printk (IDESCSI_LOG "ide-scsi: %s: suc %lu",
+					drive->name, pc->scsi_cmd->serial_number);
+			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred &&
+			    pc->actually_transferred <= 1024 && pc->buffer) {
 				printk(", rst = ");
 				scsi_buf = pc->scsi_cmd->request_buffer;
 				hexdump(scsi_buf, IDE_MIN(16, pc->scsi_cmd->request_bufflen));
@@ -390,12 +401,12 @@
 	unsigned int temp;
 
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
+	printk (IDESCSI_DEBUG "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: DMA complete\n", drive->name);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: DMA complete\n", drive->name);
 #endif /* IDESCSI_DEBUG_LOG */
 		pc->actually_transferred=pc->request_transfer;
 		(void) HWIF(drive)->ide_dma_end(drive);
@@ -408,7 +419,8 @@
 	if (!status.b.drq) {
 		/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
-			printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
+			printk (IDESCSI_LOG "Packet command completed, %d bytes transferred\n",
+					pc->actually_transferred);
 		local_irq_enable();
 		if (status.b.check)
 			rq->errors++;
@@ -446,7 +458,8 @@
 				return ide_started;
 			}
 #if IDESCSI_DEBUG_LOG
-			printk (KERN_NOTICE "ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
+			printk (IDESCSI_DEBUG
+				"ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
 #endif /* IDESCSI_DEBUG_LOG */
 		}
 	}
@@ -480,10 +493,10 @@
 
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
@@ -552,8 +565,10 @@
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
@@ -739,7 +754,8 @@
 		if ((first_bh = bh = idescsi_kmalloc_bio (segments)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB total\n", drive->name, segments, pc->request_transfer >> 10);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: building DMA table, %d segments, %dkB total\n",
+				drive->name, segments, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		while (segments--) {
 			bh->bi_io_vec[0].bv_page = sg->page;
@@ -753,7 +769,8 @@
 		if ((first_bh = bh = idescsi_kmalloc_bio (1)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table for a single buffer (%dkB)\n", drive->name, pc->request_transfer >> 10);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: building DMA table for a single buffer (%dkB)\n",
+				drive->name, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		bh->bi_io_vec[0].bv_page = virt_to_page(pc->scsi_cmd->request_buffer);
 		bh->bi_io_vec[0].bv_offset = offset_in_page(pc->scsi_cmd->request_buffer);
@@ -823,10 +840,10 @@
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

