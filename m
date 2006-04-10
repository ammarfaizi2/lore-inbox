Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWDJUZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWDJUZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWDJUZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:25:49 -0400
Received: from palrel11.hp.com ([156.153.255.246]:35515 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S932100AbWDJUZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:25:48 -0400
Date: Mon, 10 Apr 2006 15:25:41 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       steve.cameron@hp.com
Subject: [PATCH 1/1] cciss: bug fix for crash when running hpacucli
Message-ID: <20060410202541.GA28328@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1/1

This patch fixes a crash when running hpacucli with multiple logical volumes
on a cciss controller. We were not properly initializing the disk->queue
and causing a fault.
Thanks to Hasso Tepper for reporting the problem. Thanks to Steve Cameron
for root causing the problem.
Most of the patch just moves things around. The fix is a one-liner.

Signed-off-by: Mike Miller <mike.miller@hp.com>
Signed-off-by: Stephen Cameron <steve.cameron@hp.com>

--------------------------------------------------------------------------------
 cciss.c |   96 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 49 insertions(+), 47 deletions(-)

diff -burNp linux-2.6.16.2.orig/drivers/block/cciss.c linux-2.6.16.2/drivers/block/cciss.c
--- linux-2.6.16.2.orig/drivers/block/cciss.c	2006-04-10 10:28:38.000000000 -0500
+++ linux-2.6.16.2/drivers/block/cciss.c	2006-04-10 15:07:12.000000000 -0500
@@ -1181,6 +1181,53 @@ static int revalidate_allvol(ctlr_info_t
         return 0;
 }
 
+static inline void complete_buffers(struct bio *bio, int status)
+{
+	while (bio) {
+		struct bio *xbh = bio->bi_next; 
+		int nr_sectors = bio_sectors(bio);
+
+		bio->bi_next = NULL; 
+		blk_finished_io(len);
+		bio_endio(bio, nr_sectors << 9, status ? 0 : -EIO);
+		bio = xbh;
+	}
+
+} 
+
+static void cciss_softirq_done(struct request *rq)
+{
+	CommandList_struct *cmd = rq->completion_data;
+	ctlr_info_t *h = hba[cmd->ctlr];
+	unsigned long flags;
+	u64bit temp64;
+	int i, ddir;
+
+	if (cmd->Request.Type.Direction == XFER_READ)
+		ddir = PCI_DMA_FROMDEVICE;
+	else
+		ddir = PCI_DMA_TODEVICE;
+
+	/* command did not need to be retried */
+	/* unmap the DMA mapping for all the scatter gather elements */
+	for(i=0; i<cmd->Header.SGList; i++) {
+		temp64.val32.lower = cmd->SG[i].Addr.lower;
+		temp64.val32.upper = cmd->SG[i].Addr.upper;
+		pci_unmap_page(h->pdev, temp64.val, cmd->SG[i].Len, ddir);
+	}
+
+	complete_buffers(rq->bio, rq->errors);
+
+#ifdef CCISS_DEBUG
+	printk("Done with %p\n", rq);
+#endif /* CCISS_DEBUG */ 
+
+	spin_lock_irqsave(&h->lock, flags);
+	end_that_request_last(rq, rq->errors);
+	cmd_free(h, cmd,1);
+	spin_unlock_irqrestore(&h->lock, flags);
+}
+
 /* This function will check the usage_count of the drive to be updated/added.
  * If the usage_count is zero then the drive information will be updated and
  * the disk will be re-registered with the kernel.  If not then it will be
@@ -1249,6 +1296,8 @@ static void cciss_update_drive_info(int 
 
 		blk_queue_max_sectors(disk->queue, 512);
 
+		blk_queue_softirq_done(disk->queue, cciss_softirq_done);
+
 		disk->queue->queuedata = hba[ctlr];
 
 		blk_queue_hardsect_size(disk->queue,
@@ -2148,20 +2197,6 @@ static void start_io( ctlr_info_t *h)
 		addQ (&(h->cmpQ), c); 
 	}
 }
-
-static inline void complete_buffers(struct bio *bio, int status)
-{
-	while (bio) {
-		struct bio *xbh = bio->bi_next; 
-		int nr_sectors = bio_sectors(bio);
-
-		bio->bi_next = NULL; 
-		blk_finished_io(len);
-		bio_endio(bio, nr_sectors << 9, status ? 0 : -EIO);
-		bio = xbh;
-	}
-
-} 
 /* Assumes that CCISS_LOCK(h->ctlr) is held. */
 /* Zeros out the error record and then resends the command back */
 /* to the controller */
@@ -2179,39 +2214,6 @@ static inline void resend_cciss_cmd( ctl
 	start_io(h);
 }
 
-static void cciss_softirq_done(struct request *rq)
-{
-	CommandList_struct *cmd = rq->completion_data;
-	ctlr_info_t *h = hba[cmd->ctlr];
-	unsigned long flags;
-	u64bit temp64;
-	int i, ddir;
-
-	if (cmd->Request.Type.Direction == XFER_READ)
-		ddir = PCI_DMA_FROMDEVICE;
-	else
-		ddir = PCI_DMA_TODEVICE;
-
-	/* command did not need to be retried */
-	/* unmap the DMA mapping for all the scatter gather elements */
-	for(i=0; i<cmd->Header.SGList; i++) {
-		temp64.val32.lower = cmd->SG[i].Addr.lower;
-		temp64.val32.upper = cmd->SG[i].Addr.upper;
-		pci_unmap_page(h->pdev, temp64.val, cmd->SG[i].Len, ddir);
-	}
-
-	complete_buffers(rq->bio, rq->errors);
-
-#ifdef CCISS_DEBUG
-	printk("Done with %p\n", rq);
-#endif /* CCISS_DEBUG */ 
-
-	spin_lock_irqsave(&h->lock, flags);
-	end_that_request_last(rq, rq->errors);
-	cmd_free(h, cmd,1);
-	spin_unlock_irqrestore(&h->lock, flags);
-}
-
 /* checks the status of the job and calls complete buffers to mark all 
  * buffers for the completed job. Note that this function does not need
  * to hold the hba/queue lock.
