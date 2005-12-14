Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVLNWd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVLNWd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVLNWd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:33:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:28638 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965032AbVLNWdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:33:25 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 14 Dec 2005 23:32:33 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.14.3 1/2] SCSI: fix transfer direction in sd (kernel panic
 when ejecting iPod)
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20051214203859.GA568@kroah.com>
Message-ID: <tkrat.4cb325c7ad591694@s5r6.in-berlin.de>
References: <20051209171922.GW19441@conscoop.ottawa.on.ca>
 <200512101125.jBABP7Z9001085@einhorn.in-berlin.de>
 <20051210232837.GE11094@kroah.com> <439B7A8F.6000209@s5r6.in-berlin.de>
 <43A07C05.90800@s5r6.in-berlin.de> <20051214203859.GA568@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-1.164) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI: fix transfer direction in sd (kernel panic when ejecting iPod)

sd_init_command could issue WRITE requests with zero buffer length.
This may lead to kernel panic or oops with some SCSI low-level drivers.
Seen with the command "eject /dev/sdX" when disconnecting an iPod:
http://marc.theaimsgroup.com/?l=linux1394-devel&m=113399994920181
http://marc.theaimsgroup.com/?l=linux1394-user&m=112152701817435

Derived from -rc patches from Jens Axboe and James Bottomley.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Patch is reassembled for -stable from patches:
[SCSI] fix panic when ejecting ieee1394 ipod
[SCSI] Consolidate REQ_BLOCK_PC handling path (fix ipod panic)

 drivers/scsi/scsi_lib.c  |   20 ++++++++++++++++++++
 drivers/scsi/sd.c        |   16 +---------------
 include/scsi/scsi_cmnd.h |    1 +
 3 files changed, 22 insertions(+), 15 deletions(-)

--- linux-2.6.14.3/drivers/scsi.orig/scsi_lib.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/drivers/scsi/scsi_lib.c	2005-12-14 22:23:13.000000000 +0100
@@ -1129,6 +1129,26 @@ static void scsi_generic_done(struct scs
 	scsi_io_completion(cmd, cmd->result == 0 ? cmd->bufflen : 0, 0);
 }
 
+void scsi_setup_blk_pc_cmnd(struct scsi_cmnd *cmd, int retries)
+{
+	struct request *req = cmd->request;
+
+	BUG_ON(sizeof(req->cmd) > sizeof(cmd->cmnd));
+	memcpy(cmd->cmnd, req->cmd, sizeof(cmd->cmnd));
+	cmd->cmd_len = req->cmd_len;
+	if (!req->data_len)
+		cmd->sc_data_direction = DMA_NONE;
+	else if (rq_data_dir(req) == WRITE)
+		cmd->sc_data_direction = DMA_TO_DEVICE;
+	else
+		cmd->sc_data_direction = DMA_FROM_DEVICE;
+	
+	cmd->transfersize = req->data_len;
+	cmd->allowed = retries;
+	cmd->timeout_per_command = req->timeout;
+}
+EXPORT_SYMBOL_GPL(scsi_setup_blk_pc_cmnd);
+
 static int scsi_prep_fn(struct request_queue *q, struct request *req)
 {
 	struct scsi_device *sdev = q->queuedata;
--- linux-2.6.14.3/drivers/scsi.orig/sd.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/drivers/scsi/sd.c	2005-12-14 22:23:13.000000000 +0100
@@ -231,24 +231,10 @@ static int sd_init_command(struct scsi_c
 	 * SG_IO from block layer already setup, just copy cdb basically
 	 */
 	if (blk_pc_request(rq)) {
-		if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
-			return 0;
-
-		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
-		SCpnt->cmd_len = rq->cmd_len;
-		if (rq_data_dir(rq) == WRITE)
-			SCpnt->sc_data_direction = DMA_TO_DEVICE;
-		else if (rq->data_len)
-			SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-		else
-			SCpnt->sc_data_direction = DMA_NONE;
-
-		this_count = rq->data_len;
+		scsi_setup_blk_pc_cmnd(SCpnt, SD_PASSTHROUGH_RETRIES);
 		if (rq->timeout)
 			timeout = rq->timeout;
 
-		SCpnt->transfersize = rq->data_len;
-		SCpnt->allowed = SD_PASSTHROUGH_RETRIES;
 		goto queue;
 	}
 
--- linux-2.6.14.3/include/scsi.orig/scsi_cmnd.h	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/include/scsi/scsi_cmnd.h	2005-12-14 22:23:14.000000000 +0100
@@ -150,5 +150,6 @@ extern struct scsi_cmnd *scsi_get_comman
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
+extern void scsi_setup_blk_pc_cmnd(struct scsi_cmnd *cmd, int retries);
 
 #endif /* _SCSI_SCSI_CMND_H */


