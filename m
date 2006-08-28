Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWH1OXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWH1OXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWH1OXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:23:44 -0400
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:14723 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1750867AbWH1OXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:23:43 -0400
Date: Mon, 28 Aug 2006 22:23:17 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "linux-scsi" <linux-scsi@vger.kernel.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "promise_linux" <promise_linux@promise.com>,
       "james.Bottomley" <james.Bottomley@SteelEye.com>,
       "jeff" <jeff@garzik.org>
Subject: [patch 1/3] stex: adjust command timeout in slave_config routine
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBXDvCeqTPcaWC00000d5d@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 28 Aug 2006 14:22:50.0859 (UTC) FILETIME=[7179ABB0:01C6CAAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ed Lin" <ed.lin@promise.com>

- remove unsuitable waiting code and unnecessary handling code
  from reset routine

- adjust command timeout in slave_config routine to achieve intended
  effect of removed waiting code
---
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index fceae17..cb17415 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -519,6 +519,7 @@ stex_slave_config(struct scsi_device *sd
 {
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
+	sdev->timeout = 60 * HZ;
 	return 0;
 }
 
@@ -938,37 +939,11 @@ static void stex_hard_reset(struct st_hb
 static int stex_reset(struct scsi_cmnd *cmd)
 {
 	struct st_hba *hba;
-	int tag;
-	int i = 0;
 	unsigned long flags;
 	hba = (struct st_hba *) &cmd->device->host->hostdata[0];
 
-wait_cmds:
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
-		if ((hba->tag & (1 << tag)) && hba->ccb[tag].req != NULL)
-			break;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	if (tag < MU_MAX_REQUEST) {
-		ssleep(1);
-		if (++i < 10)
-			goto wait_cmds;
-	}
-
 	hba->mu_status = MU_STATE_RESETTING;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-
-	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
-		if ((hba->tag & (1 << tag)) && hba->ccb[tag].req != NULL) {
-			stex_free_tag((unsigned long *)&hba->tag, tag);
-			stex_unmap_sg(hba, hba->ccb[tag].cmd);
-			hba->ccb[tag].cmd->result = DID_RESET << 16;
-			hba->ccb[tag].cmd->scsi_done(hba->ccb[tag].cmd);
-		}
-
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
 	if (hba->cardtype == st_shasta)
 		stex_hard_reset(hba);
 

