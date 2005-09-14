Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVINTdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVINTdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVINTdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:33:53 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:53729 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964803AbVINTdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:33:52 -0400
Subject: Re: [2.6.14-rc1] sym scsi boot hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Anton Blanchard <anton@samba.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stern@rowland.harvard.edu
In-Reply-To: <20050914080629.GB19051@krispykreme>
References: <20050913124804.GA5008@in.ibm.com>
	 <20050913131739.GD26162@krispykreme> <20050913142939.GE26162@krispykreme>
	 <1126629345.4809.36.camel@mulgrave>  <20050914080629.GB19051@krispykreme>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 12:57:42 -0400
Message-Id: <1126717062.4584.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 18:06 +1000, Anton Blanchard wrote:
> And in particular it looks like the scsi_unprep_request in
> scsi_queue_insert is causing it. The following patch fixes the boot
> problems on the vscsi machine:

OK, my fault.  Your fix is almost correct .. I was going to do this
eventually, honest, because there's no need to unprep and reprep a
command that comes in through scsi_queue_insert().

However, I decided to leave it in to exercise the scsi_unprep_request()
path just to make sure it was working.  What's happening, I think, is
that we also use this path for retries.  Since we kill and reget the
command each time, the retries decrement is never seen, so we're
retrying forever.

This should be the correct reversal.

James
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -140,14 +140,12 @@ static void scsi_unprep_request(struct r
  *              commands.
  * Notes:       This could be called either from an interrupt context or a
  *              normal process context.
- * Notes:	Upon return, cmd is a stale pointer.
  */
 int scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct scsi_device *device = cmd->device;
 	struct request_queue *q = device->request_queue;
-	struct request *req = cmd->request;
 	unsigned long flags;
 
 	SCSI_LOG_MLQUEUE(1,
@@ -188,9 +186,8 @@ int scsi_queue_insert(struct scsi_cmnd *
 	 * function.  The SCSI request function detects the blocked condition
 	 * and plugs the queue appropriately.
          */
-	scsi_unprep_request(req);
 	spin_lock_irqsave(q->queue_lock, flags);
-	blk_requeue_request(q, req);
+	blk_requeue_request(q, cmd->request);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	scsi_run_queue(q);


