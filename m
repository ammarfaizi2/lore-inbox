Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933381AbWFXPTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933381AbWFXPTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbWFXPRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:17:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:43974 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752300AbWFXPR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:17:28 -0400
Message-ID: <351162245.28395@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625071729.587214182@localhost.localdomain>
References: <20060625071036.241325936@localhost.localdomain>
Date: Sun, 25 Jun 2006 15:10:39 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Fengguang Wu <wfg@mail.ustc.edu.cn>
Subject: [PATCH 3/7] iosched: introduce deadline_add_drq_fifo()
Content-Disposition: inline; filename=iosched-deadline-fifo-enqueue.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

deadline_rq.fifo is now a queue sorted by request expire time.
New requests can be inserted _anywhere_ into deadline_rq.fifo.

Introduce a new function deadline_add_drq_fifo() to do the work.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 block/deadline-iosched.c |   33 ++++++++++++++++++++++++---------
 include/linux/blkdev.h   |    1 +
 2 files changed, 25 insertions(+), 9 deletions(-)

--- linux-2.6.17-rc6-mm2.orig/include/linux/blkdev.h
+++ linux-2.6.17-rc6-mm2/include/linux/blkdev.h
@@ -516,6 +516,7 @@ enum {
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		((rq)->flags & 1)
+#define rq_data_rwa(rq)		((rq)->flags & 3)
 
 static inline int blk_queue_full(struct request_queue *q, int rw)
 {
--- linux-2.6.17-rc6-mm2.orig/block/deadline-iosched.c
+++ linux-2.6.17-rc6-mm2/block/deadline-iosched.c
@@ -30,6 +30,7 @@ static const int deadline_hash_shift = 5
 #define DL_HASH_FN(sec)		(hash_long(DL_HASH_BLOCK((sec)), deadline_hash_shift))
 #define DL_HASH_ENTRIES		(1 << deadline_hash_shift)
 #define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
+#define list_entry_fifo(ptr)	list_entry((ptr), struct deadline_rq, fifo)
 #define ON_HASH(drq)		(!hlist_unhashed(&(drq)->hash))
 
 struct deadline_data {
@@ -264,6 +265,41 @@ deadline_find_first_drq(struct deadline_
 }
 
 /*
+ * set expire time (only used for reads) and add to fifo list
+ */
+static void
+deadline_add_drq_fifo(struct deadline_data *dd, struct request *rq)
+{
+	const int data_dir = rq_data_dir(rq);
+	struct deadline_rq *drq = RQ_DATA(rq);
+	struct list_head *ip; /* insert before me */
+	int expire;
+
+	expire = dd->fifo_expire[rq_data_rwa(rq)];
+	drq->expires = jiffies + expire;
+
+	/*
+	 * Scan forward/backward and insert.
+	 */
+	if (expire > dd->fifo_expire[READ]) {
+		list_for_each(ip, &dd->fifo_list[data_dir]) {
+			if (time_before(drq->expires,
+					list_entry_fifo(ip)->expires))
+				break;
+		}
+		list_add_tail(&drq->fifo, ip);
+	} else {
+		list_for_each_prev(ip, &dd->fifo_list[data_dir]) {
+			if (!time_before(drq->expires,
+					list_entry_fifo(ip)->expires))
+				break;
+		}
+		list_add(&drq->fifo, ip);
+	}
+
+}
+
+/*
  * add drq to rbtree and fifo
  */
 static void
@@ -272,14 +308,8 @@ deadline_add_request(struct request_queu
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
-	const int data_dir = rq_data_dir(drq->request);
-
 	deadline_add_drq_rb(dd, drq);
-	/*
-	 * set expire time (only used for reads) and add to fifo list
-	 */
-	drq->expires = jiffies + dd->fifo_expire[data_dir];
-	list_add_tail(&drq->fifo, &dd->fifo_list[data_dir]);
+	deadline_add_drq_fifo(dd, rq);
 
 	if (rq_mergeable(rq))
 		deadline_add_drq_hash(dd, drq);
@@ -439,8 +469,6 @@ deadline_move_request(struct deadline_da
 	deadline_move_to_dispatch(dd, drq);
 }
 
-#define list_entry_fifo(ptr)	list_entry((ptr), struct deadline_rq, fifo)
-
 /*
  * deadline_check_fifo returns 0 if there are no expired reads on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])

--
