Return-Path: <linux-kernel-owner+w=401wt.eu-S964882AbXADOgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbXADOgK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 09:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbXADOgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 09:36:10 -0500
Received: from brick.kernel.dk ([62.242.22.158]:1616 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964879AbXADOgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 09:36:08 -0500
Date: Thu, 4 Jan 2007 15:39:00 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] 4/4 block: explicit plugging
Message-ID: <20070104143900.GC11203@kernel.dk>
References: <20070103222930.GL11203@kernel.dk> <000001c72f87$5bd8e520$ce34030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c72f87$5bd8e520$ce34030a@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03 2007, Chen, Kenneth W wrote:
> Jens Axboe wrote on Wednesday, January 03, 2007 2:30 PM
> > > We are having some trouble with the patch set that some of our fiber channel
> > > host controller doesn't initialize properly anymore and thus lost whole
> > > bunch of disks (somewhere around 200 disks out of 900) at boot time.
> > > Presumably FC loop initialization command are done through block layer etc.
> > > I haven't looked into the problem closely.
> > > 
> > > Jens, I assume the spin lock bug in __blk_run_queue is fixed in this patch
> > > set?
> > 
> > It is. Are you still seeing problems after the initial mail exchange we
> > had prior to christmas,
> 
> Yes. Not the same kernel panic, but a problem with FC loop reset itself.
> 
> 
> > or are you referencing that initial problem?
> 
> No. we got passed that point thanks for the bug fix patch you give me
> prior to Christmas.  That fixed a kernel panic on boot up.
> 
> 
> > It's not likely to be a block layer issue, more likely the SCSI <->
> > block interactions. If you mail me a new dmesg (if your problem is with
> > the __blk_run_queue() fixups), I can take a look. Otherwise please do
> > test with the __blk_run_queue() fixup, just use the current patchset.
> 
> I will just retake the tip of your plug tree and retest.

That would be great! There's a busy race fixed in the current branch,
make sure that one is included as well.

>From 9174fea2184187209b1f851137bd1612728fae2c Mon Sep 17 00:00:00 2001
From: Jens Axboe <jens.axboe@oracle.com>
Date: Thu, 4 Jan 2007 10:42:33 +0100
Subject: [PATCH] [PATCH] scsi: race in checking sdev->device_busy

Save some code, create a new out label for the path that already checks
the busy count and delays the queue if necessary.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/scsi/scsi_lib.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index fce5e2f..3ffa35d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1509,12 +1509,9 @@ static void scsi_request_fn(struct request_queue *q)
 		 * Dispatch the command to the low-level driver.
 		 */
 		rtn = scsi_dispatch_cmd(cmd);
-		if (rtn) {
-			if (sdev->device_busy == 0)
-				blk_delay_queue(q, SCSI_QUEUE_DELAY);
-			goto out_nolock;
-		}
 		spin_lock_irq(q->queue_lock);
+		if (rtn)
+			goto out_delay;
 	}
 
 	goto out;
@@ -1533,13 +1530,13 @@ static void scsi_request_fn(struct request_queue *q)
 	spin_lock_irq(q->queue_lock);
 	blk_requeue_request(q, req);
 	sdev->device_busy--;
+out_delay:
 	if (sdev->device_busy == 0)
 		blk_delay_queue(q, SCSI_QUEUE_DELAY);
- out:
+out:
 	/* must be careful here...if we trigger the ->remove() function
 	 * we cannot be holding the q lock */
 	spin_unlock_irq(q->queue_lock);
- out_nolock:
 	put_device(&sdev->sdev_gendev);
 	spin_lock_irq(q->queue_lock);
 }
-- 
1.5.0.rc0.gd222


-- 
Jens Axboe

