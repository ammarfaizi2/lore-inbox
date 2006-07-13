Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWGMMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWGMMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWGMMqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:46:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36143 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932481AbWGMMoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:07 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 13/15 Add one more pointer to struct request for IO scheduler usage
Date: Thu, 13 Jul 2006 14:46:36 +0200
Message-Id: <11527947992414-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then we have enough room in the request to get rid of the dynamic
allocations in CFQ/AS.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/ll_rw_blk.c      |    2 ++
 include/linux/blkdev.h |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 08c1615..4018254 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -451,6 +451,7 @@ static void queue_flush(request_queue_t 
 	rq_init(q, rq);
 	rq->flags = REQ_HARDBARRIER;
 	rq->elevator_private = NULL;
+	rq->elevator_private2 = NULL;
 	rq->rq_disk = q->bar_rq.rq_disk;
 	rq->rl = NULL;
 	rq->end_io = end_io;
@@ -477,6 +478,7 @@ static inline struct request *start_orde
 	rq->flags = bio_data_dir(q->orig_bar_rq->bio);
 	rq->flags |= q->ordered & QUEUE_ORDERED_FUA ? REQ_FUA : 0;
 	rq->elevator_private = NULL;
+	rq->elevator_private2 = NULL;
 	rq->rl = NULL;
 	init_request_from_bio(rq, q->orig_bar_rq->bio);
 	rq->end_io = bar_end_io;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 78808a0..ba4378f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -151,7 +151,13 @@ struct request {
 	struct hlist_node hash;	/* merge hash */
 	struct rb_node rb_node;	/* sort/lookup */
 
+	/*
+	 * two pointers are available for the IO schedulers, if they need
+	 * more they have to dynamically allocate it.
+	 */
 	void *elevator_private;
+	void *elevator_private2;
+
 	void *completion_data;
 
 	int rq_status;	/* should split this into a few status bits */
-- 
1.4.1.ged0e0

