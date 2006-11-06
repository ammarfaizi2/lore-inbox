Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753767AbWKFUcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbWKFUcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbWKFUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:32:11 -0500
Received: from palrel12.hp.com ([156.153.255.237]:57064 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1753764AbWKFUcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:32:08 -0500
Date: Mon, 6 Nov 2006 14:32:05 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 12/12] cciss: fix for iostat
Message-ID: <20061106203205.GL17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 12 of 12

This patch replaces complete_buffers with end_that_request_first to fix
programs like iostat. This has been broken for the last few kernel releases.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>


---


---

 drivers/block/cciss.c |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)

diff -puN drivers/block/cciss.c~cciss_update_diskstats_fix drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_update_diskstats_fix	2006-11-06 13:28:53.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:28:53.000000000 -0600
@@ -1156,18 +1156,6 @@ static int cciss_ioctl(struct inode *ino
 	}
 }
 
-static inline void complete_buffers(struct bio *bio, int status)
-{
-	while (bio) {
-		struct bio *xbh = bio->bi_next;
-		int nr_sectors = bio_sectors(bio);
-
-		bio->bi_next = NULL;
-		bio_endio(bio, nr_sectors << 9, status ? 0 : -EIO);
-		bio = xbh;
-	}
-}
-
 static void cciss_check_queues(ctlr_info_t *h)
 {
 	int start_queue = h->next_to_run;
@@ -1236,15 +1224,15 @@ static void cciss_softirq_done(struct re
 		pci_unmap_page(h->pdev, temp64.val, cmd->SG[i].Len, ddir);
 	}
 
-	complete_buffers(rq->bio, rq->errors);
-
 #ifdef CCISS_DEBUG
 	printk("Done with %p\n", rq);
 #endif				/* CCISS_DEBUG */
 
-	add_disk_randomness(rq->rq_disk);
 	spin_lock_irqsave(&h->lock, flags);
-	end_that_request_last(rq, rq->errors);
+	if (!end_that_request_first(rq, rq->errors, rq->nr_sectors)) {
+		add_disk_randomness(rq->rq_disk);
+		end_that_request_last(rq, rq->errors);
+	}
 	cmd_free(h, cmd, 1);
 	cciss_check_queues(h);
 	spin_unlock_irqrestore(&h->lock, flags);
_
