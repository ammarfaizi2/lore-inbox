Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933313AbWFXIXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933313AbWFXIXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbWFXIXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:23:14 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:50390 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S933313AbWFXIXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:23:06 -0400
Message-ID: <351137383.24594@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060624082311.912265883@localhost.localdomain>
References: <20060624082006.574472632@localhost.localdomain>
Date: Sat, 24 Jun 2006 16:20:11 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 5/7] iosched: introduce elv_kick_page()
Content-Disposition: inline; filename=iosched-kick-page-elevator.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce elv_kick_page() to turn a possibly READA request into READ.
The underlying elevator_kick_page_fn() should also reschedule the request
if necessary.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 block/ll_rw_blk.c        |    8 ++++++++
 fs/buffer.c              |    5 +++--
 include/linux/elevator.h |    2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc5-mm3.orig/include/linux/elevator.h
+++ linux-2.6.17-rc5-mm3/include/linux/elevator.h
@@ -20,6 +20,7 @@ typedef int (elevator_set_req_fn) (reque
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_activate_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_deactivate_req_fn) (request_queue_t *, struct request *);
+typedef int (elevator_kick_page_fn) (request_queue_t *, struct page *);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (elevator_t *);
@@ -34,6 +35,7 @@ struct elevator_ops
 	elevator_add_req_fn *elevator_add_req_fn;
 	elevator_activate_req_fn *elevator_activate_req_fn;
 	elevator_deactivate_req_fn *elevator_deactivate_req_fn;
+	elevator_kick_page_fn *elevator_kick_page_fn;
 
 	elevator_queue_empty_fn *elevator_queue_empty_fn;
 	elevator_completed_req_fn *elevator_completed_req_fn;
@@ -91,6 +93,7 @@ extern void elv_dispatch_sort(request_qu
 extern void elv_add_request(request_queue_t *, struct request *, int, int);
 extern void __elv_add_request(request_queue_t *, struct request *, int, int);
 extern void elv_insert(request_queue_t *, struct request *, int);
+extern void elv_kick_page(request_queue_t *, struct page *);
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
--- linux-2.6.17-rc5-mm3.orig/block/elevator.c
+++ linux-2.6.17-rc5-mm3/block/elevator.c
@@ -468,6 +468,16 @@ void elv_add_request(request_queue_t *q,
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
+void elv_kick_page(request_queue_t *q, struct page *page)
+{
+	if (page && q->elevator && q->elevator->ops->elevator_kick_page_fn) {
+		spin_lock_irq(q->queue_lock);
+		q->elevator->ops->elevator_kick_page_fn(q, page);
+		spin_unlock_irq(q->queue_lock);
+	}
+
+}
+
 static inline struct request *__elv_next_request(request_queue_t *q)
 {
 	struct request *rq;

--
