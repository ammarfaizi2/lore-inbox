Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVITXDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVITXDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVITXDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:03:24 -0400
Received: from dvhart.com ([64.146.134.43]:12679 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750712AbVITXDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:03:24 -0400
Date: Tue, 20 Sep 2005 16:03:20 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Arrr! Linux v2.6.14-rc2
Message-ID: <635500000.1127257400@flay>
In-Reply-To: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahoy landlubbers!
> 
> Here be t' Linux-2.6.14-rc2 release.
> 
> Not a whole lot o' excitement, ye scurvy dogs, but it has t' ALSA, LSM,
> audit and watchdog merges that be missed from -rc1, and a merge series
> with Andrew. But on t' whole pretty reasonable - you can see t' details in
> the shortlog (appended).
> 
> Arrr!

SCSI is broken in several cases by a lack of the patch below, which means 
some of the regular test boxes can't - James, any chance of getting that
one upstream? (it's cut and pasted, but then you wouldn't want to apply
it anyway without correct "flow" ;-)).

Thanks,

M.

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
