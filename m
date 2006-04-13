Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWDMXJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWDMXJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWDMXJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:09:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60110 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965016AbWDMXJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:09:50 -0400
Date: Thu, 13 Apr 2006 16:08:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       mikem@beardog.cca.cpqcorp.net, mike.miller@hp.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Cameron <steve.cameron@hp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/22] cciss: bug fix for crash when running hpacucli
Message-ID: <20060413230846.GO5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cciss-bug-fix-for-crash-when-running-hpacucli.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: "Mike Miller" <mikem@beardog.cca.cpqcorp.net>

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
 drivers/block/cciss.c |   96 +++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

--- linux-2.6.16.5.orig/drivers/block/cciss.c
+++ linux-2.6.16.5/drivers/block/cciss.c
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

--
