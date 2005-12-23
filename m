Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbVLWWwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbVLWWwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbVLWWwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:52:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:3024 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161108AbVLWWtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:31 -0500
Date: Fri, 23 Dec 2005 14:48:48 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, stefanr@s5r6.in-berlin.de,
       linux-scsi@vger.kernel.org
Subject: [patch 17/19] SCSI: fix transfer direction in sd (kernel panic when ejecting iPod)
Message-ID: <20051223224848.GQ19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="scsi-fix-transfer-direction-in-sd.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stefan Richter <stefanr@s5r6.in-berlin.de>

SCSI: fix transfer direction in sd (kernel panic when ejecting iPod)

sd_init_command could issue WRITE requests with zero buffer length.
This may lead to kernel panic or oops with some SCSI low-level drivers.
Seen with the command "eject /dev/sdX" when disconnecting an iPod:
http://marc.theaimsgroup.com/?l=linux1394-devel&m=113399994920181
http://marc.theaimsgroup.com/?l=linux1394-user&m=112152701817435

Derived from -rc patches from Jens Axboe and James Bottomley.

Patch is reassembled for -stable from patches:
[SCSI] fix panic when ejecting ieee1394 ipod
[SCSI] Consolidate REQ_BLOCK_PC handling path (fix ipod panic)


Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/scsi/scsi_lib.c  |   20 ++++++++++++++++++++
 drivers/scsi/sd.c        |   16 +---------------
 include/scsi/scsi_cmnd.h |    1 +
 3 files changed, 22 insertions(+), 15 deletions(-)

--- linux-2.6.14.4.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6.14.4/drivers/scsi/scsi_lib.c
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
--- linux-2.6.14.4.orig/drivers/scsi/sd.c
+++ linux-2.6.14.4/drivers/scsi/sd.c
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
 
--- linux-2.6.14.4.orig/include/scsi/scsi_cmnd.h
+++ linux-2.6.14.4/include/scsi/scsi_cmnd.h
@@ -150,5 +150,6 @@ extern struct scsi_cmnd *scsi_get_comman
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
+extern void scsi_setup_blk_pc_cmnd(struct scsi_cmnd *cmd, int retries);
 
 #endif /* _SCSI_SCSI_CMND_H */

--
