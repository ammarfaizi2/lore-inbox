Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVLNWfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVLNWfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVLNWfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:35:01 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:31454 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965037AbVLNWfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:35:00 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 14 Dec 2005 23:34:11 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.14.3] SCSI: fix transfer direction in scsi_lib and st
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <tkrat.4cb325c7ad591694@s5r6.in-berlin.de>
Message-ID: <tkrat.a92b3c0b86f82868@s5r6.in-berlin.de>
References: <20051209171922.GW19441@conscoop.ottawa.on.ca>
 <200512101125.jBABP7Z9001085@einhorn.in-berlin.de>
 <20051210232837.GE11094@kroah.com> <439B7A8F.6000209@s5r6.in-berlin.de>
 <43A07C05.90800@s5r6.in-berlin.de> <20051214203859.GA568@kroah.com>
 <tkrat.4cb325c7ad591694@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-1.168) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI: fix transfer direction in scsi_lib and st

scsi_prep_fn and st_init_command could issue WRITE requests with zero
buffer length. This may lead to kernel panic or oops with some SCSI
low-level drivers.

Derived from -rc patches from Jens Axboe and James Bottomley.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Patch is reassembled for -stable from patches:
[SCSI] fix panic when ejecting ieee1394 ipod
[SCSI] Consolidate REQ_BLOCK_PC handling path (fix ipod panic)

Depends on patch "SCSI: fix transfer direction in sd (kernel panic when
ejecting iPod)". Also modifies the already correct sr_init_command to
fully match the corresponding -rc patch.

 drivers/scsi/scsi_lib.c |   13 +------------
 drivers/scsi/sr.c       |   20 +++-----------------
 drivers/scsi/st.c       |   19 +------------------
 3 files changed, 5 insertions(+), 47 deletions(-)

--- linux-2.6.14.3/drivers/scsi.orig/scsi_lib.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/drivers/scsi/scsi_lib.c	2005-12-14 22:23:13.000000000 +0100
@@ -1284,18 +1304,7 @@ static int scsi_prep_fn(struct request_q
 				goto kill;
 			}
 		} else {
-			memcpy(cmd->cmnd, req->cmd, sizeof(cmd->cmnd));
-			cmd->cmd_len = req->cmd_len;
-			if (rq_data_dir(req) == WRITE)
-				cmd->sc_data_direction = DMA_TO_DEVICE;
-			else if (req->data_len)
-				cmd->sc_data_direction = DMA_FROM_DEVICE;
-			else
-				cmd->sc_data_direction = DMA_NONE;
-			
-			cmd->transfersize = req->data_len;
-			cmd->allowed = 3;
-			cmd->timeout_per_command = req->timeout;
+			scsi_setup_blk_pc_cmnd(cmd, 3);
 			cmd->done = scsi_generic_done;
 		}
 	}
--- linux-2.6.14.3/drivers/scsi.orig/sr.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/drivers/scsi/sr.c	2005-12-14 22:23:13.000000000 +0100
@@ -320,25 +320,11 @@ static int sr_init_command(struct scsi_c
 	 * these are already setup, just copy cdb basically
 	 */
 	if (SCpnt->request->flags & REQ_BLOCK_PC) {
-		struct request *rq = SCpnt->request;
+		scsi_setup_blk_pc_cmnd(SCpnt, MAX_RETRIES);
 
-		if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
-			return 0;
-
-		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
-		SCpnt->cmd_len = rq->cmd_len;
-		if (!rq->data_len)
-			SCpnt->sc_data_direction = DMA_NONE;
-		else if (rq_data_dir(rq) == WRITE)
-			SCpnt->sc_data_direction = DMA_TO_DEVICE;
-		else
-			SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-
-		this_count = rq->data_len;
-		if (rq->timeout)
-			timeout = rq->timeout;
+		if (SCpnt->timeout_per_command)
+			timeout = SCpnt->timeout_per_command;
 
-		SCpnt->transfersize = rq->data_len;
 		goto queue;
 	}
 
--- linux-2.6.14.3/drivers/scsi.orig/st.c	2005-11-24 23:10:21.000000000 +0100
+++ linux-2.6.14.3/drivers/scsi/st.c	2005-12-14 22:23:13.000000000 +0100
@@ -4196,27 +4196,10 @@ static void st_intr(struct scsi_cmnd *SC
  */
 static int st_init_command(struct scsi_cmnd *SCpnt)
 {
-	struct request *rq;
-
 	if (!(SCpnt->request->flags & REQ_BLOCK_PC))
 		return 0;
 
-	rq = SCpnt->request;
-	if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
-		return 0;
-
-	memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
-	SCpnt->cmd_len = rq->cmd_len;
-
-	if (rq_data_dir(rq) == WRITE)
-		SCpnt->sc_data_direction = DMA_TO_DEVICE;
-	else if (rq->data_len)
-		SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-	else
-		SCpnt->sc_data_direction = DMA_NONE;
-
-	SCpnt->timeout_per_command = rq->timeout;
-	SCpnt->transfersize = rq->data_len;
+	scsi_setup_blk_pc_cmnd(SCpnt, 0);
 	SCpnt->done = st_intr;
 	return 1;
 }


