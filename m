Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUASEgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 23:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbUASEgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 23:36:13 -0500
Received: from hera.cwi.nl ([192.16.191.8]:2464 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262128AbUASEgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 23:36:06 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 19 Jan 2004 05:35:58 +0100 (MET)
Message-Id: <UTC200401190435.i0J4Zwp26577.aeb@smtp.cwi.nl>
To: akpm@osdl.org
Subject: [PATCH] fix for ide-scsi crash
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A rather reproducible crash with ide-scsi that I reported
yesterday is fixed by the patch below.

(Most of this is just polishing that emacs did while my eyes
looked at the code. The only change is not doing
       ide_do_drive_cmd (drive, rq, ide_end);
       spin_lock_irq(cmd->device->host->host_lock);
since cmd may be freed already.)

Andries

[With this in place I wrote three times 640 MB to floptical and diffed;
no problems occurred. Without it the system would crash each time.]

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2004-01-11 14:20:49.000000000 +0100
+++ b/drivers/ide/ide-io.c	2004-01-19 05:00:47.000000000 +0100
@@ -1300,7 +1300,7 @@
  *	Initialize a request before we fill it in and send it down to
  *	ide_do_drive_cmd. Commands must be set up by this function. Right
  *	now it doesn't do a lot, but if that changes abusers will have a
- *	nasty suprise.
+ *	nasty surprise.
  */
 
 void ide_init_drive_cmd (struct request *rq)
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2003-12-18 03:59:05.000000000 +0100
+++ b/drivers/scsi/ide-scsi.c	2004-01-19 05:30:28.000000000 +0100
@@ -148,7 +148,8 @@
 		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
 		buf = page_address(pc->sg->page) + pc->sg->offset;
 		atapi_input_bytes (drive, buf + pc->b_count, count);
-		bcount -= count; pc->b_count += count;
+		bcount -= count;
+		pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
 			pc->b_count = 0;
@@ -191,8 +192,12 @@
 		return;
 	if (drive->media == ide_cdrom || drive->media == ide_optical) {
 		if (c[0] == READ_6 || c[0] == WRITE_6) {
-			c[8] = c[4];		c[5] = c[3];		c[4] = c[2];
-			c[3] = c[1] & 0x1f;	c[2] = 0;		c[1] &= 0xe0;
+			c[8] = c[4];
+			c[5] = c[3];
+			c[4] = c[2];
+			c[3] = c[1] & 0x1f;
+			c[2] = 0;
+			c[1] &= 0xe0;
 			c[0] += (READ_10 - READ_6);
 		}
 		if (c[0] == MODE_SENSE || c[0] == MODE_SELECT) {
@@ -380,7 +385,7 @@
 static ide_startstop_t idescsi_pc_intr (ide_drive_t *drive)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
-	idescsi_pc_t *pc=scsi->pc;
+	idescsi_pc_t *pc = scsi->pc;
 	struct request *rq = pc->rq;
 	atapi_bcount_t bcount;
 	atapi_status_t status;
@@ -664,8 +669,6 @@
 	.ioctl		= idescsi_ide_ioctl,
 };
 
-static int idescsi_attach(ide_drive_t *drive);
-
 static int idescsi_slave_configure(Scsi_Device * sdp)
 {
 	/* Configure detected device */
@@ -794,7 +797,8 @@
 	idescsi_pc_t *pc = NULL;
 
 	if (!drive) {
-		printk (KERN_ERR "ide-scsi: drive id %d not present\n", cmd->device->id);
+		printk (KERN_ERR "ide-scsi: drive id %d not present\n",
+			cmd->device->id);
 		goto abort;
 	}
 	scsi = drive_to_idescsi(drive);
@@ -827,25 +831,30 @@
 	idescsi_transform_pc1 (drive, pc);
 
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
-		printk ("ide-scsi: %s: que %lu, cmd = ", drive->name, cmd->serial_number);
+		printk ("ide-scsi: %s: que %lu, cmd = ",
+			drive->name, cmd->serial_number);
 		hexdump(cmd->cmnd, cmd->cmd_len);
 		if (memcmp(pc->c, cmd->cmnd, cmd->cmd_len)) {
-			printk ("ide-scsi: %s: que %lu, tsl = ", drive->name, cmd->serial_number);
+			printk("ide-scsi: %s: que %lu, tsl = ",
+			       drive->name, cmd->serial_number);
 			hexdump(pc->c, 12);
 		}
 	}
 
-	ide_init_drive_cmd (rq);
+	ide_init_drive_cmd(rq);
 	rq->special = (char *) pc;
-	rq->bio = idescsi_dma_bio (drive, pc);
+	rq->bio = idescsi_dma_bio(drive, pc);
 	rq->flags = REQ_SPECIAL;
-	spin_unlock_irq(cmd->device->host->host_lock);
-	(void) ide_do_drive_cmd (drive, rq, ide_end);
-	spin_lock_irq(cmd->device->host->host_lock);
+	{
+		struct Scsi_Host *host = cmd->device->host;
+		spin_unlock_irq(host->host_lock);
+		(void) ide_do_drive_cmd(drive, rq, ide_end);
+		spin_lock_irq(host->host_lock);
+	}
 	return 0;
 abort:
-	if (pc) kfree (pc);
-	if (rq) kfree (rq);
+	kfree (pc);
+	kfree (rq);
 	cmd->result = DID_ERROR << 16;
 	done(cmd);
 	return 1;
