Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVK3Nxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVK3Nxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVK3Nxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:53:55 -0500
Received: from petasus.ims.intel.com ([62.118.80.130]:47049 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S1751223AbVK3Nxx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:53:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH 1/1] elevator: indirect function calls reducing
Date: Wed, 30 Nov 2005 16:53:43 +0300
Message-ID: <6694B22B6436BC43B429958787E4549892AE56@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] elevator: indirect function calls reducing
Thread-Index: AcX1tXnNU8zEx9coQrCbOZTCfRjM+Q==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 30 Nov 2005 13:53:44.0258 (UTC) FILETIME=[7A794220:01C5F5B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Leonid Ananiev

      The patch eliminates 1 of 3 additional main memory readings
in 17 indirrect io-scheduler function calls.
The "elevator" structure (~100 bytes) is embedded in request queue
structure.

Signed-off-by: Leonid Ananiev leonid.i.ananiev@intel.com
---
This patch is applied and tested kernel 2.6.15-rc2.
Online switching between io schedulers was introduced in
Linux 2.6.10 but performance degradation is marked
on Itanium as a result. A cause of degradation is in more steps
for indirect IO scheduler function calls.

 Sysbench fileio benchmark throughput on IPF was increased by 8% for
noop elevator after patching.
sysbench --test=fileio --file-test-mode=rndrw --num-threads=16 \
 --file-total-size=1500M --max-requests=150000
Main memory size was decreased by kernel boot parameter mem=1G

One of functions object codes before and after patching are
<elv_merge_requests>:       <elv_merge_requests>:   
alloc r36=ar.pfs,9,6,0      adds r3=24,r32
adds r8=24,r32              mov r35=b0
mov r35=b0                  adds r8=740,r32
adds r9=644,r32             mov r37=r1
mov r37=r1                  mov r40=r34;;
mov r40=r34;;               nop.m 0x0
nop.m 0x0                   mov.i ar.pfs=r36
mov.i ar.pfs=r36            nop.b 0x0
nop.b 0x0                   ld8 r2=[r3]
ld8 r3=[r8]                 mov r38=r32
mov r38=r32                 mov r39=r33;;
mov r39=r33                 adds r14=16,r2
adds r16=16,r32             adds r11=16,r32
nop.f 0x0                   mov b0=r35;;
mov b0=r35;;                nop.m 0x0
ld8 r2=[r3];;               ld8 r14=[r14]
adds r14=16,r2              nop.b 0x0;;
nop.i 0x0;;                 nop.m 0x0
ld8 r14=[r14];;             cmp.eq p6,p7=0,r14
nop.m 0x0                   br.cond.dpnt.few
cmp.eq p6,p7=0,r14
nop.b 0x0
nop.b 0x0
br.cond.dpnt.few


diff -urpN -X a/Documentation/dontdiff \
  a/block/as-iosched.c b/block/as-iosched.c
--- a/block/as-iosched.c	2005-11-27 14:46:09.000000000 -0800
+++ b/block/as-iosched.c	2005-11-24 14:45:51.000000000 -0800
@@ -625,7 +625,7 @@ static void as_antic_stop(struct as_data
 static void as_antic_timeout(unsigned long data)
 {
 	struct request_queue *q = (struct request_queue *)data;
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
@@ -968,7 +968,7 @@ static void update_write_batch(struct as
  */
 static void as_completed_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
 	WARN_ON(!list_empty(&rq->queuelist));
@@ -1028,7 +1028,7 @@ static void as_remove_queued_request(req
 {
 	struct as_rq *arq = RQ_DATA(rq);
 	const int data_dir = arq->is_sync;
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 
 	WARN_ON(arq->state != AS_RQ_QUEUED);
 
@@ -1168,7 +1168,7 @@ static void as_move_to_dispatch(struct a
  */
 static int as_dispatch_request(request_queue_t *q, int force)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq;
 	const int reads = !list_empty(&ad->fifo_list[REQ_SYNC]);
 	const int writes = !list_empty(&ad->fifo_list[REQ_ASYNC]);
@@ -1366,7 +1366,7 @@ as_add_aliased_request(struct as_data *a
  */
 static void as_add_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 	struct as_rq *alias;
 	int data_dir;
@@ -1449,7 +1449,7 @@ static void as_deactivate_request(reques
  */
 static int as_queue_empty(request_queue_t *q)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 
 	return list_empty(&ad->fifo_list[REQ_ASYNC])
 		&& list_empty(&ad->fifo_list[REQ_SYNC]);
@@ -1484,7 +1484,7 @@ static struct request *as_latter_request
 static int
 as_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	sector_t rb_key = bio->bi_sector + bio_sectors(bio);
 	struct request *__rq;
 	int ret;
@@ -1527,7 +1527,7 @@ out:
 
 static void as_merged_request(request_queue_t *q, struct request *req)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(req);
 
 	/*
@@ -1568,7 +1568,7 @@ static void as_merged_request(request_qu
 static void as_merged_requests(request_queue_t *q, struct request *req,
 			 	struct request *next)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(req);
 	struct as_rq *anext = RQ_DATA(next);
 
@@ -1656,7 +1656,7 @@ static void as_work_handler(void *data)
 
 static void as_put_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (!arq) {
@@ -1678,7 +1678,7 @@ static void as_put_request(request_queue
 static int as_set_request(request_queue_t *q, struct request *rq,
 			  struct bio *bio, gfp_t gfp_mask)
 {
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);
 
 	if (arq) {
@@ -1700,7 +1700,7 @@ static int as_set_request(request_queue_
 static int as_may_queue(request_queue_t *q, int rw, struct bio *bio)
 {
 	int ret = ELV_MQUEUE_MAY;
-	struct as_data *ad = q->elevator->elevator_data;
+	struct as_data *ad = q->elevator.elevator_data;
 	struct io_context *ioc;
 	if (ad->antic_status == ANTIC_WAIT_REQ ||
 			ad->antic_status == ANTIC_WAIT_NEXT) {
diff -urpN -X a/Documentation/dontdiff \
 a/block/cfq-iosched.c b/block/cfq-iosched.c
--- a/block/cfq-iosched.c	2005-11-27 14:46:09.000000000 -0800
+++ b/block/cfq-iosched.c	2005-11-24 14:45:51.000000000 -0800
@@ -342,7 +342,7 @@ static inline void cfq_schedule_dispatch
 
 static int cfq_queue_empty(request_queue_t *q)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 
 	return !cfqd->busy_queues;
 }
@@ -643,14 +643,14 @@ out:
 
 static void cfq_activate_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 
 	cfqd->rq_in_driver++;
 }
 
 static void cfq_deactivate_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 
 	WARN_ON(!cfqd->rq_in_driver);
 	cfqd->rq_in_driver--;
@@ -668,7 +668,7 @@ static void cfq_remove_request(struct re
 static int
 cfq_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct request *__rq;
 	int ret;
 
@@ -692,7 +692,7 @@ out:
 
 static void cfq_merged_request(request_queue_t *q, struct request *req)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_rq *crq = RQ_DATA(req);
 
 	cfq_del_crq_hash(crq);
@@ -928,7 +928,7 @@ static int cfq_arm_slice_timer(struct cf
 
 static void cfq_dispatch_insert(request_queue_t *q, struct cfq_rq *crq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_queue *cfqq = crq->cfq_queue;
 
 	cfqq->next_crq = cfq_find_next_crq(cfqd, cfqq, crq);
@@ -1128,7 +1128,7 @@ cfq_forced_dispatch(struct cfq_data *cfq
 static int
 cfq_dispatch_requests(request_queue_t *q, int force)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_queue *cfqq;
 
 	if (!cfqd->busy_queues)
@@ -1676,7 +1676,7 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 
 static void cfq_insert_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 	struct cfq_queue *cfqq = crq->cfq_queue;
 
@@ -1842,7 +1842,7 @@ __cfq_may_queue(struct cfq_data *cfqd, s
 
 static int cfq_may_queue(request_queue_t *q, int rw, struct bio *bio)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct task_struct *tsk = current;
 	struct cfq_queue *cfqq;
 
@@ -1865,7 +1865,7 @@ static int cfq_may_queue(request_queue_t
 
 static void cfq_check_waiters(request_queue_t *q, struct cfq_queue *cfqq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct request_list *rl = &q->rq;
 
 	if (cfqq->allocated[READ] <= cfqd->max_queued || cfqd->rq_starved) {
@@ -1886,7 +1886,7 @@ static void cfq_check_waiters(request_qu
  */
 static void cfq_put_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 
 	if (crq) {
@@ -1913,7 +1913,7 @@ static int
 cfq_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
 		gfp_t gfp_mask)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct task_struct *tsk = current;
 	struct cfq_io_context *cic;
 	const int rw = rq_data_dir(rq);
@@ -1986,7 +1986,7 @@ queue_fail:
 static void cfq_kick_queue(void *data)
 {
 	request_queue_t *q = data;
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
diff -urpN -X a/Documentation/dontdiff\
 a/block/deadline-iosched.c b/block/deadline-iosched.c
--- a/block/deadline-iosched.c	2005-11-27 14:46:09.000000000 -0800
+++ b/block/deadline-iosched.c	2005-11-24 14:45:51.000000000 -0800
@@ -276,7 +276,7 @@ deadline_find_first_drq(struct deadline_
 static void
 deadline_add_request(struct request_queue *q, struct request *rq)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	const int data_dir = rq_data_dir(drq->request);
@@ -298,7 +298,7 @@ deadline_add_request(struct request_queu
 static void deadline_remove_request(request_queue_t *q, struct request *rq)
 {
 	struct deadline_rq *drq = RQ_DATA(rq);
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 
 	list_del_init(&drq->fifo);
 	deadline_del_drq_rb(dd, drq);
@@ -308,7 +308,7 @@ static void deadline_remove_request(requ
 static int
 deadline_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 	struct request *__rq;
 	int ret;
 
@@ -352,7 +352,7 @@ out:
 
 static void deadline_merged_request(request_queue_t *q, struct request *req)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 
 	/*
@@ -374,7 +374,7 @@ static void
 deadline_merged_requests(request_queue_t *q, struct request *req,
 			 struct request *next)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 	struct deadline_rq *dnext = RQ_DATA(next);
 
@@ -471,7 +471,7 @@ static inline int deadline_check_fifo(st
  */
 static int deadline_dispatch_requests(request_queue_t *q, int force)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 	const int reads = !list_empty(&dd->fifo_list[READ]);
 	const int writes = !list_empty(&dd->fifo_list[WRITE]);
 	struct deadline_rq *drq;
@@ -567,7 +567,7 @@ dispatch_request:
 
 static int deadline_queue_empty(request_queue_t *q)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 
 	return list_empty(&dd->fifo_list[WRITE])
 		&& list_empty(&dd->fifo_list[READ]);
@@ -659,7 +659,7 @@ static int deadline_init_queue(request_q
 
 static void deadline_put_request(request_queue_t *q, struct request *rq)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	mempool_free(drq, dd->drq_pool);
@@ -670,7 +670,7 @@ static int
 deadline_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
 		     gfp_t gfp_mask)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq;
 
 	drq = mempool_alloc(dd->drq_pool, gfp_mask);
diff -urpN -X a/Documentation/dontdiff\
 a/block/elevator.c b/block/elevator.c
--- a/block/elevator.c	2005-11-27 14:46:09.000000000 -0800
+++ b/block/elevator.c	2005-11-24 20:19:37.000000000 -0800
@@ -121,17 +121,15 @@ static struct elevator_type *elevator_ge
 	return e;
 }
 
-static int elevator_attach(request_queue_t *q, struct elevator_type *e,
-			   struct elevator_queue *eq)
+static int elevator_attach(request_queue_t *q, struct elevator_type *e)
 {
 	int ret = 0;
+	struct elevator_queue *eq;
 
-	memset(eq, 0, sizeof(*eq));
+	eq = &q->elevator;
 	eq->ops = &e->ops;
 	eq->elevator_type = e;
 
-	q->elevator = eq;
-
 	if (eq->ops->elevator_init_fn)
 		ret = eq->ops->elevator_init_fn(q, eq);
 
@@ -170,7 +168,6 @@ __setup("elevator=", elevator_setup);
 int elevator_init(request_queue_t *q, char *name)
 {
 	struct elevator_type *e = NULL;
-	struct elevator_queue *eq;
 	int ret = 0;
 
 	INIT_LIST_HEAD(&q->queue_head);
@@ -187,15 +184,8 @@ int elevator_init(request_queue_t *q, ch
 	if (!e)
 		return -EINVAL;
 
-	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
-	if (!eq) {
-		elevator_put(e);
-		return -ENOMEM;
-	}
-
-	ret = elevator_attach(q, e, eq);
+	ret = elevator_attach(q, e);
 	if (ret) {
-		kfree(eq);
 		elevator_put(e);
 	}
 
@@ -209,7 +199,6 @@ void elevator_exit(elevator_t *e)
 
 	elevator_put(e->elevator_type);
 	e->elevator_type = NULL;
-	kfree(e);
 }
 
 /*
@@ -249,7 +238,7 @@ void elv_dispatch_sort(request_queue_t *
 
 int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 	int ret;
 
 	if (q->last_merge) {
@@ -268,7 +257,7 @@ int elv_merge(request_queue_t *q, struct
 
 void elv_merged_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (e->ops->elevator_merged_fn)
 		e->ops->elevator_merged_fn(q, rq);
@@ -279,7 +268,7 @@ void elv_merged_request(request_queue_t 
 void elv_merge_requests(request_queue_t *q, struct request *rq,
 			     struct request *next)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (e->ops->elevator_merge_req_fn)
 		e->ops->elevator_merge_req_fn(q, rq, next);
@@ -290,7 +279,7 @@ void elv_merge_requests(request_queue_t 
 
 void elv_requeue_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	/*
 	 * it already went through dequeue, we need to decrement the
@@ -318,14 +307,14 @@ void elv_requeue_request(request_queue_t
 static void elv_drain_elevator(request_queue_t *q)
 {
 	static int printed;
-	while (q->elevator->ops->elevator_dispatch_fn(q, 1))
+	while (q->elevator.ops->elevator_dispatch_fn(q, 1))
 		;
 	if (q->nr_sorted == 0)
 		return;
 	if (printed++ < 10) {
 		printk(KERN_ERR "%s: forced dispatching is broken "
 		       "(nr_sorted=%u), please report this\n",
-		       q->elevator->elevator_type->elevator_name, q->nr_sorted);
+		       q->elevator.elevator_type->elevator_name, q->nr_sorted);
 	}
 }
 
@@ -390,7 +379,7 @@ void __elv_add_request(request_queue_t *
 		 * rq cannot be accessed after calling
 		 * elevator_add_req_fn.
 		 */
-		q->elevator->ops->elevator_add_req_fn(q, rq);
+		q->elevator.ops->elevator_add_req_fn(q, rq);
 		break;
 
 	default:
@@ -423,7 +412,7 @@ static inline struct request *__elv_next
 	struct request *rq;
 
 	if (unlikely(list_empty(&q->queue_head) &&
-		     !q->elevator->ops->elevator_dispatch_fn(q, 0)))
+		     !q->elevator.ops->elevator_dispatch_fn(q, 0)))
 		return NULL;
 
 	rq = list_entry_rq(q->queue_head.next);
@@ -450,7 +439,7 @@ struct request *elv_next_request(request
 
 	while ((rq = __elv_next_request(q)) != NULL) {
 		if (!(rq->flags & REQ_STARTED)) {
-			elevator_t *e = q->elevator;
+			elevator_t *e = &q->elevator;
 
 			/*
 			 * This is the first time the device driver
@@ -526,7 +515,7 @@ void elv_dequeue_request(request_queue_t
 
 int elv_queue_empty(request_queue_t *q)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (!list_empty(&q->queue_head))
 		return 0;
@@ -539,7 +528,7 @@ int elv_queue_empty(request_queue_t *q)
 
 struct request *elv_latter_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (e->ops->elevator_latter_req_fn)
 		return e->ops->elevator_latter_req_fn(q, rq);
@@ -548,7 +537,7 @@ struct request *elv_latter_request(reque
 
 struct request *elv_former_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (e->ops->elevator_former_req_fn)
 		return e->ops->elevator_former_req_fn(q, rq);
@@ -558,7 +547,7 @@ struct request *elv_former_request(reque
 int elv_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
 		    gfp_t gfp_mask)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (e->ops->elevator_set_req_fn)
 		return e->ops->elevator_set_req_fn(q, rq, bio, gfp_mask);
@@ -569,7 +558,7 @@ int elv_set_request(request_queue_t *q, 
 
 void elv_put_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (e->ops->elevator_put_req_fn)
 		e->ops->elevator_put_req_fn(q, rq);
@@ -577,7 +566,7 @@ void elv_put_request(request_queue_t *q,
 
 int elv_may_queue(request_queue_t *q, int rw, struct bio *bio)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	if (e->ops->elevator_may_queue_fn)
 		return e->ops->elevator_may_queue_fn(q, rw, bio);
@@ -587,7 +576,7 @@ int elv_may_queue(request_queue_t *q, in
 
 void elv_completed_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	/*
 	 * request is released from the driver, io must be done
@@ -601,7 +590,7 @@ void elv_completed_request(request_queue
 
 int elv_register_queue(struct request_queue *q)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 
 	e->kobj.parent = kobject_get(&q->kobj);
 	if (!e->kobj.parent)
@@ -616,7 +605,7 @@ int elv_register_queue(struct request_qu
 void elv_unregister_queue(struct request_queue *q)
 {
 	if (q) {
-		elevator_t *e = q->elevator;
+		elevator_t *e = &q->elevator;
 		kobject_unregister(&e->kobj);
 		kobject_put(&q->kobj);
 	}
@@ -675,14 +664,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
  */
 static void elevator_switch(request_queue_t *q, struct elevator_type *new_e)
 {
-	elevator_t *old_elevator, *e;
-
-	/*
-	 * Allocate new elevator
-	 */
-	e = kmalloc(sizeof(elevator_t), GFP_KERNEL);
-	if (!e)
-		goto error;
+	elevator_t old_elevator;
 
 	/*
 	 * Turn on BYPASS and drain all requests w/ elevator private data
@@ -713,7 +695,7 @@ static void elevator_switch(request_queu
 	/*
 	 * attach and start new elevator
 	 */
-	if (elevator_attach(q, new_e, e))
+	if (elevator_attach(q, new_e))
 		goto fail;
 
 	if (elv_register_queue(q))
@@ -722,7 +704,7 @@ static void elevator_switch(request_queu
 	/*
 	 * finally exit old elevator and turn off BYPASS.
 	 */
-	elevator_exit(old_elevator);
+	elevator_exit(&old_elevator);
 	clear_bit(QUEUE_FLAG_ELVSWITCH, &q->queue_flags);
 	return;
 
@@ -731,14 +713,11 @@ fail_register:
 	 * switch failed, exit the new io scheduler and reattach the old
 	 * one again (along with re-adding the sysfs dir)
 	 */
-	elevator_exit(e);
-	e = NULL;
+	elevator_exit(&q->elevator);
 fail:
 	q->elevator = old_elevator;
 	elv_register_queue(q);
 	clear_bit(QUEUE_FLAG_ELVSWITCH, &q->queue_flags);
-	kfree(e);
-error:
 	elevator_put(new_e);
 	printk(KERN_ERR "elevator: switch to %s failed\n",new_e->elevator_name);
 }
@@ -762,7 +741,7 @@ ssize_t elv_iosched_store(request_queue_
 		return -EINVAL;
 	}
 
-	if (!strcmp(elevator_name, q->elevator->elevator_type->elevator_name)) {
+	if (!strcmp(elevator_name, q->elevator.elevator_type->elevator_name)) {
 		elevator_put(e);
 		return count;
 	}
@@ -773,7 +752,7 @@ ssize_t elv_iosched_store(request_queue_
 
 ssize_t elv_iosched_show(request_queue_t *q, char *name)
 {
-	elevator_t *e = q->elevator;
+	elevator_t *e = &q->elevator;
 	struct elevator_type *elv = e->elevator_type;
 	struct list_head *entry;
 	int len = 0;
diff -urpN -X a/Documentation/dontdiff\
 a/block/ll_rw_blk.c b/block/ll_rw_blk.c
--- a/block/ll_rw_blk.c	2005-11-27 14:46:09.000000000 -0800
+++ b/block/ll_rw_blk.c	2005-11-24 14:45:51.000000000 -0800
@@ -1612,8 +1612,7 @@ void blk_cleanup_queue(request_queue_t *
 	if (!atomic_dec_and_test(&q->refcnt))
 		return;
 
-	if (q->elevator)
-		elevator_exit(q->elevator);
+	elevator_exit(&q->elevator);
 
 	blk_sync_queue(q);
 
diff -urpN -X a/Documentation/dontdiff\
 a/block/noop-iosched.c b/block/noop-iosched.c
--- a/block/noop-iosched.c	2005-11-27 14:46:09.000000000 -0800
+++ b/block/noop-iosched.c	2005-11-24 20:21:15.000000000 -0800
@@ -19,7 +19,7 @@ static void noop_merged_requests(request
 
 static int noop_dispatch(request_queue_t *q, int force)
 {
-	struct noop_data *nd = q->elevator->elevator_data;
+	struct noop_data *nd = q->elevator.elevator_data;
 
 	if (!list_empty(&nd->queue)) {
 		struct request *rq;
@@ -33,14 +33,14 @@ static int noop_dispatch(request_queue_t
 
 static void noop_add_request(request_queue_t *q, struct request *rq)
 {
-	struct noop_data *nd = q->elevator->elevator_data;
+	struct noop_data *nd = q->elevator.elevator_data;
 
 	list_add_tail(&rq->queuelist, &nd->queue);
 }
 
 static int noop_queue_empty(request_queue_t *q)
 {
-	struct noop_data *nd = q->elevator->elevator_data;
+	struct noop_data *nd = q->elevator.elevator_data;
 
 	return list_empty(&nd->queue);
 }
@@ -48,7 +48,7 @@ static int noop_queue_empty(request_queu
 static struct request *
 noop_former_request(request_queue_t *q, struct request *rq)
 {
-	struct noop_data *nd = q->elevator->elevator_data;
+	struct noop_data *nd = q->elevator.elevator_data;
 
 	if (rq->queuelist.prev == &nd->queue)
 		return NULL;
@@ -58,7 +58,7 @@ noop_former_request(request_queue_t *q, 
 static struct request *
 noop_latter_request(request_queue_t *q, struct request *rq)
 {
-	struct noop_data *nd = q->elevator->elevator_data;
+	struct noop_data *nd = q->elevator.elevator_data;
 
 	if (rq->queuelist.next == &nd->queue)
 		return NULL;
diff -urpN -X a/Documentation/dontdiff\
 a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	2005-11-27 14:46:38.000000000 -0800
+++ b/include/linux/blkdev.h	2005-11-24 14:45:51.000000000 -0800
@@ -316,7 +316,7 @@ struct request_queue
 	 */
 	struct list_head	queue_head;
 	struct request		*last_merge;
-	elevator_t		*elevator;
+	elevator_t		elevator;
 
 	/*
 	 * the queue request freelist, one for reads and one for writes
