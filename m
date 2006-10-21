Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWJUM6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWJUM6W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161482AbWJUM6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:58:22 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:17722 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S2993007AbWJUM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:58:20 -0400
Subject: [Patch 3/5] I/O statistics through request queues: small SCSI
	cleanup
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 21 Oct 2006 14:58:16 +0200
Message-Id: <1161435496.3054.115.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

improving readability of code by using a local struct scsi_device
pointer in scsi_dispatch_cmd()

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 scsi.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff -urp a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	2006-10-03 16:25:51.000000000 +0200
+++ b/drivers/scsi/scsi.c	2006-10-08 22:28:01.000000000 +0200
@@ -481,25 +481,26 @@ static inline void scsi_cmd_get_serial(s
  */
 int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 {
-	struct Scsi_Host *host = cmd->device->host;
+	struct scsi_device *sdev = cmd->device;
+	struct Scsi_Host *host = sdev->host;
 	unsigned long flags = 0;
 	unsigned long timeout;
 	int rtn = 0;
 
 	/* check if the device is still usable */
-	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
+	if (unlikely(sdev->sdev_state == SDEV_DEL)) {
 		/* in SDEV_DEL we error all commands. DID_NO_CONNECT
 		 * returns an immediate error upwards, and signals
 		 * that the device is no longer present */
 		cmd->result = DID_NO_CONNECT << 16;
-		atomic_inc(&cmd->device->iorequest_cnt);
+		atomic_inc(&sdev->iorequest_cnt);
 		__scsi_done(cmd);
 		/* return 0 (because the command has been processed) */
 		goto out;
 	}
 
 	/* Check to see if the scsi lld put this device into state SDEV_BLOCK. */
-	if (unlikely(cmd->device->sdev_state == SDEV_BLOCK)) {
+	if (unlikely(sdev->sdev_state == SDEV_BLOCK)) {
 		/* 
 		 * in SDEV_BLOCK, the command is just put back on the device
 		 * queue.  The suspend state has already blocked the queue so
@@ -517,14 +518,9 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 		goto out;
 	}
 
-	/* 
-	 * If SCSI-2 or lower, store the LUN value in cmnd.
-	 */
-	if (cmd->device->scsi_level <= SCSI_2 &&
-	    cmd->device->scsi_level != SCSI_UNKNOWN) {
-		cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) |
-			       (cmd->device->lun << 5 & 0xe0);
-	}
+	/* If SCSI-2 or lower, store the LUN value in cmnd. */
+	if (sdev->scsi_level <= SCSI_2 && sdev->scsi_level != SCSI_UNKNOWN)
+		cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) | (sdev->lun << 5 & 0xe0);
 
 	/*
 	 * We will wait MIN_RESET_DELAY clock ticks after the last reset so
@@ -560,17 +556,16 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	 * We will use a queued command if possible, otherwise we will
 	 * emulate the queuing and calling of completion function ourselves.
 	 */
-	atomic_inc(&cmd->device->iorequest_cnt);
+	atomic_inc(&sdev->iorequest_cnt);
 
 	/*
 	 * Before we queue this command, check if the command
 	 * length exceeds what the host adapter can handle.
 	 */
-	if (CDB_SIZE(cmd) > cmd->device->host->max_cmd_len) {
+	if (CDB_SIZE(cmd) > host->max_cmd_len) {
 		SCSI_LOG_MLQUEUE(3,
 				printk("queuecommand : command too long.\n"));
 		cmd->result = (DID_ABORT << 16);
-
 		scsi_done(cmd);
 		goto out;
 	}
@@ -587,7 +582,7 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	spin_unlock_irqrestore(host->host_lock, flags);
 	if (rtn) {
 		if (scsi_delete_timer(cmd)) {
-			atomic_inc(&cmd->device->iodone_cnt);
+			atomic_inc(&sdev->iodone_cnt);
 			scsi_queue_insert(cmd,
 					  (rtn == SCSI_MLQUEUE_DEVICE_BUSY) ?
 					  rtn : SCSI_MLQUEUE_HOST_BUSY);
@@ -651,6 +646,7 @@ static void scsi_done(struct scsi_cmnd *
  * isn't running --- used by scsi_times_out */
 void __scsi_done(struct scsi_cmnd *cmd)
 {
+	struct scsi_device *sdev = cmd->device;
 	struct request *rq = cmd->request;
 
 	/*
@@ -658,9 +654,9 @@ void __scsi_done(struct scsi_cmnd *cmd)
 	 */
 	cmd->serial_number = 0;
 
-	atomic_inc(&cmd->device->iodone_cnt);
+	atomic_inc(&sdev->iodone_cnt);
 	if (cmd->result)
-		atomic_inc(&cmd->device->ioerr_cnt);
+		atomic_inc(&sdev->ioerr_cnt);
 
 	BUG_ON(!rq);
 



