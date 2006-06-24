Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752201AbWFXI0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbWFXI0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933319AbWFXIZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:25:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:2007 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S933314AbWFXIXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:23:06 -0400
Message-ID: <351137384.24594@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060624082312.833976992@localhost.localdomain>
References: <20060624082006.574472632@localhost.localdomain>
Date: Sat, 24 Jun 2006 16:20:13 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 7/7] iosched: introduce deadline_kick_page()
Content-Disposition: inline; filename=iosched-kick-page-deadline.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce deadline_kick_page() to
	- find the request containing the page
	- remove its BIO_RW_AHEAD flag
	- reschedule if it was of type READA

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 block/deadline-iosched.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc6-mm2.orig/block/deadline-iosched.c
+++ linux-2.6.17-rc6-mm2/block/deadline-iosched.c
@@ -317,6 +317,44 @@ deadline_add_request(struct request_queu
 }
 
 /*
+ * We have a pending read on @page,
+ * find the corresponding request of type READA,
+ * promote it to READ, and reschedule it.
+ */
+static int
+deadline_kick_page(struct request_queue *q, struct page *page)
+{
+	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_rq *drq;
+	struct request *rq;
+	struct list_head *pos;
+	struct bio_vec *bvec;
+	struct bio *bio;
+	int i;
+
+	list_for_each(pos, &dd->fifo_list[READ]) {
+		drq = list_entry_fifo(pos);
+		rq = drq->request;
+		if (rq->flags & (1 << BIO_RW_AHEAD)) {
+			rq_for_each_bio(bio, rq) {
+				bio_for_each_segment(bvec, bio, i) {
+					if (page == bvec->bv_page)
+						goto found;
+				}
+			}
+		}
+	}
+
+	return -1;
+
+found:
+	rq->flags &= ~(1 << BIO_RW_AHEAD);
+	list_del(&drq->fifo);
+	deadline_add_drq_fifo(dd, rq);
+	return 0;
+}
+
+/*
  * remove rq from rbtree, fifo, and hash
  */
 static void deadline_remove_request(request_queue_t *q, struct request *rq)
@@ -794,6 +832,7 @@ static struct elevator_type iosched_dead
 		.elevator_merge_req_fn =	deadline_merged_requests,
 		.elevator_dispatch_fn =		deadline_dispatch_requests,
 		.elevator_add_req_fn =		deadline_add_request,
+		.elevator_kick_page_fn =	deadline_kick_page,
 		.elevator_queue_empty_fn =	deadline_queue_empty,
 		.elevator_former_req_fn =	deadline_former_request,
 		.elevator_latter_req_fn =	deadline_latter_request,

--
