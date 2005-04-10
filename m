Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVDJGbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVDJGbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 02:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVDJGbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 02:31:46 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:60936 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261435AbVDJGbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 02:31:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=IUnDOd8xlOet2t4s+lnesaabLkfMUtSRNrKnSFMxcqhEd7Pol97LIvX/No7EPbaVNhhIejeDLs9iPVfvuGE/6oBamW7b46pGSHg4bqOuTwrX/bPYfQ6mRfXhgBeYdrZ+FpMRwNlv/Fxyx5k7vyOY42ZOvKKH8eulf+bBwd1TRzk=
Date: Sun, 10 Apr 2005 15:31:32 +0900
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH scsi-misc-2.6] scsi: scsi_send_eh_cmnd() cleanup
Message-ID: <20050410063132.GB24158@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

 This patch makes scsi_send_eh_cmnd() use sdev and shost instead of
referencing them through scmd-> everytime.  Following timer cleanup
patchset assumes this patch is applied.


 Signed-off-by: Tejun Heo <htejun@gmail.com>


Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-10 15:20:09.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-10 15:25:21.000000000 +0900
@@ -485,7 +485,8 @@ static void scsi_eh_done(struct scsi_cmn
  **/
 static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, int timeout)
 {
-	struct Scsi_Host *host = scmd->device->host;
+	struct scsi_device *sdev = scmd->device;
+	struct Scsi_Host *shost = sdev->host;
 	DECLARE_MUTEX_LOCKED(sem);
 	unsigned long flags;
 	int rtn = SUCCESS;
@@ -496,27 +497,27 @@ static int scsi_send_eh_cmnd(struct scsi
 	 */
 	scmd->owner = SCSI_OWNER_LOWLEVEL;
 
-	if (scmd->device->scsi_level <= SCSI_2)
+	if (sdev->scsi_level <= SCSI_2)
 		scmd->cmnd[1] = (scmd->cmnd[1] & 0x1f) |
-			(scmd->device->lun << 5 & 0xe0);
+			(sdev->lun << 5 & 0xe0);
 
 	scsi_add_timer(scmd, timeout, scsi_eh_times_out);
 
 	/*
 	 * set up the semaphore so we wait for the command to complete.
 	 */
-	scmd->device->host->eh_action = &sem;
+	shost->eh_action = &sem;
 	scmd->request->rq_status = RQ_SCSI_BUSY;
 
-	spin_lock_irqsave(scmd->device->host->host_lock, flags);
+	spin_lock_irqsave(shost->host_lock, flags);
 	scsi_log_send(scmd);
-	host->hostt->queuecommand(scmd, scsi_eh_done);
-	spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
+	shost->hostt->queuecommand(scmd, scsi_eh_done);
+	spin_unlock_irqrestore(shost->host_lock, flags);
 
 	down(&sem);
 	scsi_log_completion(scmd, SUCCESS);
 
-	scmd->device->host->eh_action = NULL;
+	shost->eh_action = NULL;
 
 	/*
 	 * see if timeout.  if so, tell the host to forget about it.
@@ -536,10 +537,10 @@ static int scsi_send_eh_cmnd(struct scsi
 		 * abort a timed out command or not.  not sure how
 		 * we should treat them differently anyways.
 		 */
-		spin_lock_irqsave(scmd->device->host->host_lock, flags);
-		if (scmd->device->host->hostt->eh_abort_handler)
-			scmd->device->host->hostt->eh_abort_handler(scmd);
-		spin_unlock_irqrestore(scmd->device->host->host_lock, flags);
+		spin_lock_irqsave(shost->host_lock, flags);
+		if (shost->hostt->eh_abort_handler)
+			shost->hostt->eh_abort_handler(scmd);
+		spin_unlock_irqrestore(shost->host_lock, flags);
 			
 		scmd->request->rq_status = RQ_SCSI_DONE;
 		scmd->owner = SCSI_OWNER_ERROR_HANDLER;
