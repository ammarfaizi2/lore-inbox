Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUG1Uxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUG1Uxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUG1UwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:52:23 -0400
Received: from av4-2-sn3.vrr.skanova.net ([81.228.9.112]:21176 "EHLO
	av4-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S263778AbUG1Uv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:51:56 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Simplified request size handling in CDRW packet writing
References: <m3llh3uavw.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Jul 2004 22:42:57 +0200
Message-ID: <m3hdrrualq.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplified the code in the pktcdvd driver that ensures that write
requests are not larger than the packet size. This also limits the
read request size, but that doesn't seem cause any measurable
overhead, so it's better to keep the code simple.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |   45 +++++------------------------------
 linux-petero/include/linux/pktcdvd.h |    2 -
 2 files changed, 7 insertions(+), 40 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-limit-request-size drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-limit-request-size	2004-07-28 22:00:20.491858952 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-28 22:00:20.495858344 +0200
@@ -85,25 +85,6 @@ static struct pktcdvd_device *pkt_find_d
 	return NULL;
 }
 
-/*
- * The underlying block device is not allowed to merge write requests. Some
- * CDRW drives can not handle writes larger than one packet, even if the size
- * is a multiple of the packet size.
- */
-static int pkt_lowlevel_elv_merge_fn(request_queue_t *q, struct request **req, struct bio *bio)
-{
-	struct pktcdvd_device *pd = pkt_find_dev(q);
-	BUG_ON(!pd);
-
-	if (bio_data_dir(bio) == WRITE)
-		return ELEVATOR_NO_MERGE;
-
-	if (pd->cdrw.elv_merge_fn)
-		return pd->cdrw.elv_merge_fn(q, req, bio);
-
-	return ELEVATOR_NO_MERGE;
-}
-
 static void pkt_lowlevel_elv_completed_req_fn(request_queue_t *q, struct request *req)
 {
 	struct pktcdvd_device *pd = pkt_find_dev(q);
@@ -119,17 +100,6 @@ static void pkt_lowlevel_elv_completed_r
 		pd->cdrw.elv_completed_req_fn(q, req);
 }
 
-static int pkt_lowlevel_merge_requests_fn(request_queue_t *q, struct request *rq, struct request *next)
-{
-	struct pktcdvd_device *pd = pkt_find_dev(q);
-	BUG_ON(!pd);
-
-	if (rq_data_dir(rq) == WRITE)
-		return 0;
-
-	return pd->cdrw.merge_requests_fn(q, rq, next);
-}
-
 static void pkt_bio_init(struct bio *bio)
 {
 	bio->bi_next = NULL;
@@ -1933,17 +1903,20 @@ static int pkt_open_dev(struct pktcdvd_d
 		}
 	}
 	spin_lock_irq(q->queue_lock);
-	pd->cdrw.elv_merge_fn = q->elevator.elevator_merge_fn;
 	pd->cdrw.elv_completed_req_fn = q->elevator.elevator_completed_req_fn;
-	pd->cdrw.merge_requests_fn = q->merge_requests_fn;
-	q->elevator.elevator_merge_fn = pkt_lowlevel_elv_merge_fn;
 	q->elevator.elevator_completed_req_fn = pkt_lowlevel_elv_completed_req_fn;
-	q->merge_requests_fn = pkt_lowlevel_merge_requests_fn;
 	spin_unlock_irq(q->queue_lock);
 
 	if (write) {
 		if ((ret = pkt_open_write(pd)))
 			goto restore_queue;
+		/*
+		 * Some CDRW drives can not handle writes larger than one packet,
+		 * even if the size is a multiple of the packet size.
+		 */
+		spin_lock_irq(q->queue_lock);
+		blk_queue_max_sectors(q, pd->settings.size);
+		spin_unlock_irq(q->queue_lock);
 		set_bit(PACKET_WRITABLE, &pd->flags);
 	} else {
 		pkt_set_speed(pd, 0xffff, 0xffff);
@@ -1960,9 +1933,7 @@ static int pkt_open_dev(struct pktcdvd_d
 
 restore_queue:
 	spin_lock_irq(q->queue_lock);
-	q->elevator.elevator_merge_fn = pd->cdrw.elv_merge_fn;
 	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
-	q->merge_requests_fn = pd->cdrw.merge_requests_fn;
 	spin_unlock_irq(q->queue_lock);
 out_putdev:
 	blkdev_put(pd->bdev);
@@ -1986,9 +1957,7 @@ static void pkt_release_dev(struct pktcd
 	q = bdev_get_queue(pd->bdev);
 	pkt_set_speed(pd, 0xffff, 0xffff);
 	spin_lock_irq(q->queue_lock);
-	q->elevator.elevator_merge_fn = pd->cdrw.elv_merge_fn;
 	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
-	q->merge_requests_fn = pd->cdrw.merge_requests_fn;
 	spin_unlock_irq(q->queue_lock);
 	blkdev_put(pd->bdev);
 }
diff -puN include/linux/pktcdvd.h~packet-limit-request-size include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-limit-request-size	2004-07-28 22:00:20.492858800 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-07-28 22:00:20.495858344 +0200
@@ -140,9 +140,7 @@ struct packet_cdrw
 	struct list_head	pkt_active_list;
 	spinlock_t		active_list_lock; /* Serialize access to pkt_active_list */
 	struct task_struct	*thread;
-	elevator_merge_fn	*elv_merge_fn;
 	elevator_completed_req_fn *elv_completed_req_fn;
-	merge_requests_fn	*merge_requests_fn;
 };
 
 /*
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
