Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWHDCLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWHDCLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWHDCLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:11:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:60422 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030285AbWHDCLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:11:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rO0rCjVJLHdY+ALG0gDSnAAmZxJiuexri/o1OPpwJqZKbE07MYu+Mi9b3rRsTe/Cx79Q+w9iDsWTtaomzGm5D7x/1MD+v7Wjx8naDhEPlGZV12Sa2xcu1YbJ1b21JqEVaEEb7wCXnJ1s1VcOuuT/SUssB4VL1y6zkG684NyviAY=
Message-ID: <5c49b0ed0608031911id21b112t7f0c350a7f10a99@mail.gmail.com>
Date: Thu, 3 Aug 2006 19:11:01 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>
Subject: [PATCH -mm] [1/3] add elv_extended_request call to iosched API
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the Elevator iosched would prefer to be unconditionally notified of a
merge, but the current API calls only one 'merge' notifier
(elv_merge_requests or elv_merged_requests), even if both front and
back merges happened.

elv_extended_request satisfies this requirement in conjunction with
elv_merge_requests.

Signed-off-by: Nate Diller <nate.diller@gmail.com>

---
 block/elevator.c         |    9 +++++++++
 block/ll_rw_blk.c        |    2 ++
 include/linux/elevator.h |    4 ++++
 3 files changed, 15 insertions(+)
---

diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/elevator.c
linux-dput/block/elevator.c
--- linux-2.6.18-rc1-mm2/block/elevator.c	2006-07-18 14:52:29.000000000 -0700
+++ linux-dput/block/elevator.c	2006-08-03 18:42:00.000000000 -0700
@@ -287,6 +287,15 @@ void elv_merged_request(request_queue_t
 	q->last_merge = rq;
 }

+void elv_extended_request(request_queue_t *q, struct request *rq,
+			int direction, int nr_sectors)
+{
+	elevator_t *e = q->elevator;
+
+	if (e->ops->elevator_extended_req_fn)
+		e->ops->elevator_extended_req_fn(q, rq, direction, nr_sectors);
+}
+
 void elv_merge_requests(request_queue_t *q, struct request *rq,
 			     struct request *next)
 {
diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/ll_rw_blk.c
linux-dput/block/ll_rw_blk.c
--- linux-2.6.18-rc1-mm2/block/ll_rw_blk.c	2006-07-18 15:00:44.000000000 -0700
+++ linux-dput/block/ll_rw_blk.c	2006-08-03 18:42:00.000000000 -0700
@@ -2895,6 +2895,7 @@ static int __make_request(request_queue_
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 			req->ioprio = ioprio_best(req->ioprio, prio);
 			drive_stat_acct(req, nr_sectors, 0);
+			elv_extended_request(q, req, el_ret, nr_sectors);
 			if (!attempt_back_merge(q, req))
 				elv_merged_request(q, req);
 			goto out;
@@ -2922,6 +2923,7 @@ static int __make_request(request_queue_
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 			req->ioprio = ioprio_best(req->ioprio, prio);
 			drive_stat_acct(req, nr_sectors, 0);
+			elv_extended_request(q, req, el_ret, nr_sectors);
 			if (!attempt_front_merge(q, req))
 				elv_merged_request(q, req);
 			goto out;
diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/include/linux/elevator.h
linux-dput/include/linux/elevator.h
--- linux-2.6.18-rc1-mm2/include/linux/elevator.h	2006-06-17
18:49:35.000000000 -0700
+++ linux-dput/include/linux/elevator.h	2006-08-03 18:42:00.000000000 -0700
@@ -6,6 +6,8 @@ typedef int (elevator_merge_fn) (request

 typedef void (elevator_merge_req_fn) (request_queue_t *, struct
request *, struct request *);

+typedef void (elevator_extended_req_fn) (request_queue_t *, struct
request *, int, int);
+
 typedef void (elevator_merged_fn) (request_queue_t *, struct request *);

 typedef int (elevator_dispatch_fn) (request_queue_t *, int);
@@ -28,6 +30,7 @@ struct elevator_ops
 {
 	elevator_merge_fn *elevator_merge_fn;
 	elevator_merged_fn *elevator_merged_fn;
+	elevator_extended_req_fn *elevator_extended_req_fn;
 	elevator_merge_req_fn *elevator_merge_req_fn;

 	elevator_dispatch_fn *elevator_dispatch_fn;
@@ -94,6 +97,7 @@ extern void elv_insert(request_queue_t *
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
+extern void elv_extended_request(request_queue_t *, struct request *,
int, int);
 extern void elv_merged_request(request_queue_t *, struct request *);
 extern void elv_dequeue_request(request_queue_t *, struct request *);
 extern void elv_requeue_request(request_queue_t *, struct request *);
