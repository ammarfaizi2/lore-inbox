Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWDQVe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWDQVe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDQVe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:34:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:57825 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751320AbWDQVe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:34:57 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Mike Miller <mikem@beardog.cca.cpqcorp.net>,
       Mike Miller <mike.miller@hp.com>,
       Stephen Cameron <steve.cameron@hp.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/5] cciss: bug fix for crash when running hpacucli
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 17 Apr 2006 14:33:38 -0700
Message-Id: <11453096192073-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.0.rc4.ge6bf
In-Reply-To: <11453096191057-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Miller <mikem@beardog.cca.cpqcorp.net>

Fix a crash when running hpacucli with multiple logical volumes on a cciss
controller.  We were not properly initializing the disk->queue and causing
a fault.

Thanks to Hasso Tepper for reporting the problem.  Thanks to Steve Cameron
for root causing the problem.  Most of the patch just moves things around.
The fix is a one-liner.

Signed-off-by: Mike Miller <mike.miller@hp.com>
Signed-off-by: Stephen Cameron <steve.cameron@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/cciss.c |   96 +++++++++++++++++++++++++------------------------
 1 files changed, 49 insertions(+), 47 deletions(-)

ca1e0484d9fe8a9048ac32b0f9894545f43704e8
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 1b0fd31..1319d8f 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1180,6 +1180,53 @@ static int revalidate_allvol(ctlr_info_t
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
@@ -1248,6 +1295,8 @@ static void cciss_update_drive_info(int 
 
 		blk_queue_max_sectors(disk->queue, 512);
 
+		blk_queue_softirq_done(disk->queue, cciss_softirq_done);
+
 		disk->queue->queuedata = hba[ctlr];
 
 		blk_queue_hardsect_size(disk->queue,
@@ -2147,20 +2196,6 @@ static void start_io( ctlr_info_t *h)
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
@@ -2178,39 +2213,6 @@ static inline void resend_cciss_cmd( ctl
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
-- 
1.2.6

