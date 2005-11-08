Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbVKHOV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbVKHOV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbVKHOV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:21:29 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:41105 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965217AbVKHOV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:21:28 -0500
Subject: Re: 2.6.14-mm1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, neilb@suse.de,
       linux-kernel@vger.kernel.org, n@suse.de,
       Alan Stern <stern@rowland.harvard.edu>, linux-scsi@vger.kernel.org
In-Reply-To: <20051107105257.333248c0.akpm@osdl.org>
References: <20051106182447.5f571a46.akpm@osdl.org>
	 <436F2452.9020207@reub.net> <20051107020905.69c0b6dc.akpm@osdl.org>
	 <17263.11214.992300.34384@cse.unsw.edu.au>
	 <20051107023723.5cf63393.akpm@osdl.org> <436F3020.1040209@reub.net>
	 <20051107105257.333248c0.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 09:21:07 -0500
Message-Id: <1131459667.3270.8.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 10:52 -0800, Andrew Morton wrote:
> sd_issue_flush() has been altered to run scsi_disk_get_from_dev(), which
> takes a semaphore.  It does this from within spinlock and, as we see here,
> from within softirq.
> 
> Methinks the people who developed and tested that patch forgot to enable
> CONFIG_PREEMPT, CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SLAB,
> CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP.

Actually, I do too (as far as I can on non-x86).  I assume you also need
a filesystem that excites this, though.

Try the attached: We can probably rely on the block device having opened
the sd device, so there should already be a reference held on the
scsi_disk ... well that's my theory and I'm sticking to it.

James

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -769,20 +769,16 @@ static void sd_end_flush(request_queue_t
 static int sd_prepare_flush(request_queue_t *q, struct request *rq)
 {
 	struct scsi_device *sdev = q->queuedata;
-	struct scsi_disk *sdkp = scsi_disk_get_from_dev(&sdev->sdev_gendev);
-	int ret = 0;
+	struct scsi_disk *sdkp = dev_get_drvdata(&sdev->sdev_gendev);
 
-	if (sdkp) {
-		if (sdkp->WCE) {
-			memset(rq->cmd, 0, sizeof(rq->cmd));
-			rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
-			rq->timeout = SD_TIMEOUT;
-			rq->cmd[0] = SYNCHRONIZE_CACHE;
-			ret = 1;
-		}
-		scsi_disk_put(sdkp);
-	}
-	return ret;
+	if (!sdkp || !sdkp->WCE)
+		return 0;
+
+	memset(rq->cmd, 0, sizeof(rq->cmd));
+	rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
+	rq->timeout = SD_TIMEOUT;
+	rq->cmd[0] = SYNCHRONIZE_CACHE;
+	return 1;
 }
 
 static void sd_rescan(struct device *dev)



