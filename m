Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbSIZH3i>; Thu, 26 Sep 2002 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbSIZH3i>; Thu, 26 Sep 2002 03:29:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35269 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262235AbSIZH3e>;
	Thu, 26 Sep 2002 03:29:34 -0400
Date: Thu, 26 Sep 2002 09:34:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926073440.GF12862@suse.de>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <3D92B369.7AFD28D4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D92B369.7AFD28D4@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a small problem where hash would not contain the right request
state. Basically we updated the hash too soon, this bug was introduced
when the merge_cleanup stuff was removed.

It's not a bit deal, it just means that the hash didn't catch as many
merges as it should. However for efficiency it needs to be correct, of
course :-)

Current deadline against 2.5.38-BK attached.

===== drivers/block/deadline-iosched.c 1.1 vs edited =====
--- 1.1/drivers/block/deadline-iosched.c	Wed Sep 25 21:16:26 2002
+++ edited/drivers/block/deadline-iosched.c	Thu Sep 26 09:24:39 2002
@@ -25,7 +25,7 @@
  * front fifo request expires.
  */
 static int read_expire = HZ / 2;	/* 500ms start timeout */
-static int fifo_batch = 64;		/* 4 seeks, or 64 contig */
+static int fifo_batch = 32;		/* 4 seeks, or 64 contig */
 static int seek_cost = 16;		/* seek is 16 times more expensive */
 
 /*
@@ -164,7 +164,7 @@
 			*req = __rq;
 			q->last_merge = &__rq->queuelist;
 			ret = ELEVATOR_BACK_MERGE;
-			goto out_ret;
+			goto out;
 		}
 	}
 
@@ -198,16 +198,18 @@
 	}
 
 out:
-	if (ret != ELEVATOR_NO_MERGE) {
-		struct deadline_rq *drq = RQ_DATA(*req);
-
-		deadline_del_rq_hash(drq);
-		deadline_add_rq_hash(dd, drq);
-	}
-out_ret:
 	return ret;
 }
 
+static void deadline_merged_request(request_queue_t *q, struct request *req)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq = RQ_DATA(req);
+
+	deadline_del_rq_hash(drq);
+	deadline_add_rq_hash(dd, drq);
+}
+
 static void
 deadline_merge_request(request_queue_t *q, struct request *req, struct request *next)
 {
@@ -255,6 +257,15 @@
 	sector_t last_sec = dd->last_sector;
 	int batch_count = dd->fifo_batch;
 
+	/*
+	 * if dispatch is non-empty, disregard last_sector and check last one
+	 */
+	if (!list_empty(dd->dispatch)) {
+		struct request *__rq = list_entry_rq(dd->dispatch->prev);
+
+		last_sec = __rq->sector + __rq->nr_sectors;
+	}
+
 	do {
 		struct list_head *nxt = rq->queuelist.next;
 
@@ -544,6 +555,7 @@
 
 elevator_t iosched_deadline = {
 	.elevator_merge_fn = 		deadline_merge,
+	.elevator_merged_fn =		deadline_merged_request,
 	.elevator_merge_req_fn =	deadline_merge_request,
 	.elevator_next_req_fn =		deadline_next_request,
 	.elevator_add_req_fn =		deadline_add_request,
===== drivers/block/elevator.c 1.27 vs edited =====
--- 1.27/drivers/block/elevator.c	Thu Sep 26 08:23:11 2002
+++ edited/drivers/block/elevator.c	Thu Sep 26 09:20:03 2002
@@ -250,6 +250,14 @@
 	return ELEVATOR_NO_MERGE;
 }
 
+void elv_merged_request(request_queue_t *q, struct request *rq)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_merged_fn)
+		e->elevator_merged_fn(q, rq);
+}
+
 void elv_merge_requests(request_queue_t *q, struct request *rq,
 			     struct request *next)
 {
===== drivers/block/ll_rw_blk.c 1.111 vs edited =====
--- 1.111/drivers/block/ll_rw_blk.c	Thu Sep 26 08:23:11 2002
+++ edited/drivers/block/ll_rw_blk.c	Thu Sep 26 09:23:05 2002
@@ -1606,6 +1606,7 @@
 			req->biotail = bio;
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 			drive_stat_acct(req, nr_sectors, 0);
+			elv_merged_request(q, req);
 			attempt_back_merge(q, req);
 			goto out;
 
@@ -1629,6 +1630,7 @@
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 			drive_stat_acct(req, nr_sectors, 0);
+			elv_merged_request(q, req);
 			attempt_front_merge(q, req);
 			goto out;
 
===== include/linux/elevator.h 1.14 vs edited =====
--- 1.14/include/linux/elevator.h	Thu Sep 26 08:23:11 2002
+++ edited/include/linux/elevator.h	Thu Sep 26 09:25:14 2002
@@ -6,6 +6,8 @@
 
 typedef void (elevator_merge_req_fn) (request_queue_t *, struct request *, struct request *);
 
+typedef void (elevator_merged_fn) (request_queue_t *, struct request *);
+
 typedef struct request *(elevator_next_req_fn) (request_queue_t *);
 
 typedef void (elevator_add_req_fn) (request_queue_t *, struct request *, struct list_head *);
@@ -19,6 +21,7 @@
 struct elevator_s
 {
 	elevator_merge_fn *elevator_merge_fn;
+	elevator_merged_fn *elevator_merged_fn;
 	elevator_merge_req_fn *elevator_merge_req_fn;
 
 	elevator_next_req_fn *elevator_next_req_fn;
@@ -42,6 +45,7 @@
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
+extern void elv_merged_request(request_queue_t *, struct request *);
 extern void elv_remove_request(request_queue_t *, struct request *);
 extern int elv_queue_empty(request_queue_t *);
 extern inline struct list_head *elv_get_sort_head(request_queue_t *, struct request *);

-- 
Jens Axboe

