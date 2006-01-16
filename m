Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWAPH3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWAPH3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWAPH3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:29:51 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:13876 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932209AbWAPH3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:29:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=SoZCh8tCgwnJzn9Mix826cEhSe6ZgadRMScUgd2Jn94n0zuw7hXY9wHFaBDggBHyd4I+kcEOh8SdG2U31/iSrNUcCckO7bCnnsbaheDUc16A/20qgQ4DUPWiKIOmE3uZYTIu5vs3tHQQwDU7lRC6CCupEOnS6Pb8xrm6W0jgnmI=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] block: implement elv_insert and use it (fix ordcolor flipping bug)
In-Reply-To: <1137396584971-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Mon, 16 Jan 2006 16:29:44 +0900
Message-Id: <1137396584463-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

q->ordcolor must only be flipped on initial queueing of a hardbarrier
request.  Constructing ordered sequence and requeueing used to pass
through __elv_add_request() which flips q->ordcolor when it sees a
barrier request.  This patch separates out elv_insert() from
__elv_add_request() and uses elv_insert() when constructing ordered
sequence and requeueing.  elv_insert() inserts the given request at
the specified position and does nothing else.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 block/elevator.c         |   70 +++++++++++++++++++++++++---------------------
 block/ll_rw_blk.c        |    4 +--
 include/linux/elevator.h |    1 +
 3 files changed, 41 insertions(+), 34 deletions(-)

c48805c420fd95f32b75b945c4011e5d5220188e
diff --git a/block/elevator.c b/block/elevator.c
index 4c0fe1c..86c62b2 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -304,7 +304,7 @@ void elv_requeue_request(request_queue_t
 
 	rq->flags &= ~REQ_STARTED;
 
-	__elv_add_request(q, rq, ELEVATOR_INSERT_REQUEUE, 0);
+	elv_insert(q, rq, ELEVATOR_INSERT_REQUEUE);
 }
 
 static void elv_drain_elevator(request_queue_t *q)
@@ -321,43 +321,13 @@ static void elv_drain_elevator(request_q
 	}
 }
 
-void __elv_add_request(request_queue_t *q, struct request *rq, int where,
-		       int plug)
+void elv_insert(request_queue_t *q, struct request *rq, int where)
 {
 	struct list_head *pos;
 	unsigned ordseq;
 
 	blk_add_trace_rq(q, rq, BLK_TA_INSERT);
 
-	if (q->ordcolor)
-		rq->flags |= REQ_ORDERED_COLOR;
-
-	if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)) {
-		/*
-		 * toggle ordered color
-		 */
-		if (blk_barrier_rq(rq))
-			q->ordcolor ^= 1;
-
-		/*
-		 * barriers implicitly indicate back insertion
-		 */
-		if (where == ELEVATOR_INSERT_SORT)
-			where = ELEVATOR_INSERT_BACK;
-
-		/*
-		 * this request is scheduling boundary, update end_sector
-		 */
-		if (blk_fs_request(rq)) {
-			q->end_sector = rq_end_sector(rq);
-			q->boundary_rq = rq;
-		}
-	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
-		where = ELEVATOR_INSERT_BACK;
-
-	if (plug)
-		blk_plug_device(q);
-
 	rq->q = q;
 
 	switch (where) {
@@ -438,6 +408,42 @@ void __elv_add_request(request_queue_t *
 	}
 }
 
+void __elv_add_request(request_queue_t *q, struct request *rq, int where,
+		       int plug)
+{
+	if (q->ordcolor)
+		rq->flags |= REQ_ORDERED_COLOR;
+
+	if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)) {
+		/*
+		 * toggle ordered color
+		 */
+		if (blk_barrier_rq(rq))
+			q->ordcolor ^= 1;
+
+		/*
+		 * barriers implicitly indicate back insertion
+		 */
+		if (where == ELEVATOR_INSERT_SORT)
+			where = ELEVATOR_INSERT_BACK;
+
+		/*
+		 * this request is scheduling boundary, update
+		 * end_sector
+		 */
+		if (blk_fs_request(rq)) {
+			q->end_sector = rq_end_sector(rq);
+			q->boundary_rq = rq;
+		}
+	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
+		where = ELEVATOR_INSERT_BACK;
+
+	if (plug)
+		blk_plug_device(q);
+
+	elv_insert(q, rq, where);
+}
+
 void elv_add_request(request_queue_t *q, struct request *rq, int where,
 		     int plug)
 {
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 83687f9..23c1148 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -453,7 +453,7 @@ static void queue_flush(request_queue_t 
 	rq->end_io = end_io;
 	q->prepare_flush_fn(q, rq);
 
-	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	elv_insert(q, rq, ELEVATOR_INSERT_FRONT);
 }
 
 static inline struct request *start_ordered(request_queue_t *q,
@@ -489,7 +489,7 @@ static inline struct request *start_orde
 	else
 		q->ordseq |= QUEUE_ORDSEQ_POSTFLUSH;
 
-	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	elv_insert(q, rq, ELEVATOR_INSERT_FRONT);
 
 	if (q->ordered & QUEUE_ORDERED_PREFLUSH) {
 		queue_flush(q, QUEUE_ORDERED_PREFLUSH);
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 23fe746..18cf1f3 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -82,6 +82,7 @@ struct elevator_queue
 extern void elv_dispatch_sort(request_queue_t *, struct request *);
 extern void elv_add_request(request_queue_t *, struct request *, int, int);
 extern void __elv_add_request(request_queue_t *, struct request *, int, int);
+extern void elv_insert(request_queue_t *, struct request *, int);
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
-- 
1.0.6


