Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbVLWWtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbVLWWtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVLWWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:42703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161095AbVLWWtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:18 -0500
Date: Fri, 23 Dec 2005 14:48:52 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       stefanr@s5r6.in-berlin.de
Subject: [patch 18/19] SCSI: fix transfer direction in scsi_lib and st
Message-ID: <20051223224852.GR19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="scsi-fix-transfer-direction-in-scsi_lib-and-st.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stefan Richter <stefanr@s5r6.in-berlin.de>

SCSI: fix transfer direction in scsi_lib and st

scsi_prep_fn and st_init_command could issue WRITE requests with zero
buffer length. This may lead to kernel panic or oops with some SCSI
low-level drivers.

Derived from -rc patches from Jens Axboe and James Bottomley.

Patch is reassembled for -stable from patches:
[SCSI] fix panic when ejecting ieee1394 ipod
[SCSI] Consolidate REQ_BLOCK_PC handling path (fix ipod panic)

Depends on patch "SCSI: fix transfer direction in sd (kernel panic when
ejecting iPod)". Also modifies the already correct sr_init_command to
fully match the corresponding -rc patch.


Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/scsi/scsi_lib.c |   13 +------------
 drivers/scsi/sr.c       |   20 +++-----------------
 drivers/scsi/st.c       |   19 +------------------
 3 files changed, 5 insertions(+), 47 deletions(-)

--- linux-2.6.14.4.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6.14.4/drivers/scsi/scsi_lib.c
@@ -1284,18 +1284,7 @@ static int scsi_prep_fn(struct request_q
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
--- linux-2.6.14.4.orig/drivers/scsi/sr.c
+++ linux-2.6.14.4/drivers/scsi/sr.c
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
 
--- linux-2.6.14.4.orig/drivers/scsi/st.c
+++ linux-2.6.14.4/drivers/scsi/st.c
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

--
