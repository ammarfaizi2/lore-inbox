Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVFTDj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVFTDj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 23:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVFTDj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 23:39:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:7832 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261404AbVFTDjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 23:39:46 -0400
Message-ID: <42B63A7F.70300@pobox.com>
Date: Sun, 19 Jun 2005 23:39:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x urgent scsi fixes
Content-Type: multipart/mixed;
 boundary="------------050106070008070104040407"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050106070008070104040407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'scsi-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to receive corrections for mistakes that I made...

(diffstat/changelog/patch attached)


--------------050106070008070104040407
Content-Type: text/plain;
 name="misc-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.txt"

 drivers/fc4/fc.c                   |    6 ++----
 drivers/scsi/aic7xxx/aic79xx_osm.c |    8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)


Jeff Garzik:
  aic7xxx/aic79xx_osm: revert completely bogus ahd_linux_queue() patch
  fc4/fc: fix warnings and errors related to recent SCSI EH updates


diff --git a/drivers/fc4/fc.c b/drivers/fc4/fc.c
--- a/drivers/fc4/fc.c
+++ b/drivers/fc4/fc.c
@@ -765,8 +765,6 @@ void fcp_release(fc_channel *fcchain, in
 
 static void fcp_scsi_done (Scsi_Cmnd *SCpnt)
 {
-	unsigned long flags;
-
 	if (FCP_CMND(SCpnt)->done)
 		FCP_CMND(SCpnt)->done(SCpnt);
 }
@@ -907,8 +905,6 @@ int fcp_scsi_abort(Scsi_Cmnd *SCpnt)
 	 */
 
 	if (++fc->abort_count < (fc->can_queue >> 1)) {
-		unsigned long flags;
-
 		SCpnt->result = DID_ABORT;
 		fcmd->done(SCpnt);
 		printk("FC: soft abort\n");
@@ -931,6 +927,7 @@ void fcp_scsi_reset_done(Scsi_Cmnd *SCpn
 
 int fcp_scsi_dev_reset(Scsi_Cmnd *SCpnt)
 {
+	unsigned long flags;
 	fcp_cmd *cmd;
 	fcp_cmnd *fcmd;
 	fc_channel *fc = FC_SCMND(SCpnt);
@@ -1028,6 +1025,7 @@ static int __fcp_scsi_host_reset(Scsi_Cm
 
 int fcp_scsi_host_reset(Scsi_Cmnd *SCpnt)
 {
+	unsigned long flags;
 	int rc;
 
 	spin_lock_irqsave(SCpnt->device->host->host_lock, flags);
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -941,7 +941,7 @@ ahd_linux_queue(Scsi_Cmnd * cmd, void (*
 	 */
 	cmd->scsi_done = scsi_done;
 
-	ahd_lock(ahd, &flags);
+	ahd_midlayer_entrypoint_lock(ahd, &flags);
 
 	/*
 	 * Close the race of a command that was in the process of
@@ -955,7 +955,7 @@ ahd_linux_queue(Scsi_Cmnd * cmd, void (*
 		ahd_cmd_set_transaction_status(cmd, CAM_REQUEUE_REQ);
 		ahd_linux_queue_cmd_complete(ahd, cmd);
 		ahd_schedule_completeq(ahd);
-		ahd_unlock(ahd, &flags);
+		ahd_midlayer_entrypoint_unlock(ahd, &flags);
 		return (0);
 	}
 	dev = ahd_linux_get_device(ahd, cmd->device->channel,
@@ -965,7 +965,7 @@ ahd_linux_queue(Scsi_Cmnd * cmd, void (*
 		ahd_cmd_set_transaction_status(cmd, CAM_RESRC_UNAVAIL);
 		ahd_linux_queue_cmd_complete(ahd, cmd);
 		ahd_schedule_completeq(ahd);
-		ahd_unlock(ahd, &flags);
+		ahd_midlayer_entrypoint_unlock(ahd, &flags);
 		printf("%s: aic79xx_linux_queue - Unable to allocate device!\n",
 		       ahd_name(ahd));
 		return (0);
@@ -979,7 +979,7 @@ ahd_linux_queue(Scsi_Cmnd * cmd, void (*
 		dev->flags |= AHD_DEV_ON_RUN_LIST;
 		ahd_linux_run_device_queues(ahd);
 	}
-	ahd_unlock(ahd, &flags);
+	ahd_midlayer_entrypoint_unlock(ahd, &flags);
 	return (0);
 }
 

--------------050106070008070104040407--
