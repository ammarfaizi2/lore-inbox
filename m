Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVJaADw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVJaADw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJaADw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:03:52 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:4828 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932407AbVJaADv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:03:51 -0500
Date: Mon, 31 Oct 2005 00:03:49 +0000
From: Willem Riede <wrlk@riede.org>
Reply-To: wrlk@riede.org
Subject: [PATCH] ide-scsi fails to call idescsi_check_condition for things
 like "Medium not present"
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Balsa 2.3.5
Message-Id: <1130717029l.3354l.18l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch started life as a response to fedora specific ide subsystem changes 
that made error handling of my ATAPI tape drive fail; the specifics are in

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=160868

The insertion of the statement rq->errors = err; near the end of 
ide_end_drive_cmd() in drivers/ide/ide-io.c means that rq->errors does not 
contain what it needs to in idescsi_end_request() in drivers/scsi/ide-scsi.c 
anymore. Recent mainline kernels now also have this change.

The patch below makes ide-scsi whole.

Signed-off-by: Willem Riede <wrlk@riede.org>

--- linux-2.6.14/drivers/scsi/ide-scsi.c	2005-10-27 20:02:08.000000000
-0400
+++ linux-2.6.14w/drivers/scsi/ide-scsi.c	2005-10-29 09:22:47.000000000
-0400
@@ -389,6 +389,7 @@
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	struct Scsi_Host *host;
 	u8 *scsi_buf;
+	int errors = rq->errors;
 	unsigned long flags;
 
 	if (!(rq->flags & (REQ_SPECIAL|REQ_SENSE))) {
@@ -415,11 +416,11 @@
 			printk (KERN_WARNING "ide-scsi: %s: timed out for
%lu\n",
 					drive->name, pc->scsi_cmd->serial_number);
 		pc->scsi_cmd->result = DID_TIME_OUT << 16;
-	} else if (rq->errors >= ERROR_MAX) {
+	} else if (errors >= ERROR_MAX) {
 		pc->scsi_cmd->result = DID_ERROR << 16;
 		if (log)
 			printk ("ide-scsi: %s: I/O error for %lu\n",
drive->name, pc->scsi_cmd->serial_number);
-	} else if (rq->errors) {
+	} else if (errors) {
 		if (log)
 			printk ("ide-scsi: %s: check condition for %lu\n",
drive->name, pc->scsi_cmd->serial_number);
 		if (!idescsi_check_condition(drive, rq))


