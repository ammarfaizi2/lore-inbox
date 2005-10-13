Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbVJMQHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbVJMQHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 12:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbVJMQHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 12:07:32 -0400
Received: from petasus.ims.intel.com ([62.118.80.130]:46220 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S1751596AbVJMQHb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 12:07:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 1/1] indirect function calls elimination in IO eliminate
Date: Thu, 13 Oct 2005 20:07:20 +0400
Message-ID: <6694B22B6436BC43B429958787E454988AA6FE@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] indirect function calls elimination in IO eliminate
Thread-Index: AcXQEDCWxt1zY7V/T/OpexaSsgoECw==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 13 Oct 2005 16:07:23.0255 (UTC) FILETIME=[32571870:01C5D010]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Leonid Ananiev

      Fully modular io schedulers and enables online switching between
them was introduced in Linux 2.6.10 but as a result percentage of CPU
using by kernel was increased and performance degradation is marked on
Itanium. A cause of degradation is in more steps for indirect IO
scheduler type specific function calls.
      The patch eliminates 45 indirect function calls in 16 elevator
functions. Sysbench fileio benchmark throughput was increased at 2% for
noop elevator after patching.

Signed-off-by: Leonid Ananiev leonid.i.ananiev@intel.com

---

diff -rup linux-2.6.14-rc2/drivers/block/as-iosched.c
linux-2.6.14-rc2elv1/drivers/block/as-iosched.c

--- linux-2.6.14-rc2/drivers/block/as-iosched.c      2005-09-24
09:13:54.000000000 +0400

+++ linux-2.6.14-rc2elv1/drivers/block/as-iosched.c  2005-10-13
04:18:12.000000000 +0400

@@ -614,7 +614,7 @@ static void as_antic_stop(struct as_data

 static void as_antic_timeout(unsigned long data)

 {

      struct request_queue *q = (struct request_queue *)data;

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      unsigned long flags;

 

      spin_lock_irqsave(q->queue_lock, flags);

@@ -945,7 +945,7 @@ static void update_write_batch(struct as

  */

 static void as_completed_request(request_queue_t *q, struct request
*rq)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct as_rq *arq = RQ_DATA(rq);

 

      WARN_ON(!list_empty(&rq->queuelist));

@@ -1030,7 +1030,7 @@ static void as_remove_queued_request(req

 {

      struct as_rq *arq = RQ_DATA(rq);

      const int data_dir = arq->is_sync;

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

 

      WARN_ON(arq->state != AS_RQ_QUEUED);

 

@@ -1361,7 +1361,7 @@ fifo_expired:

 

 static struct request *as_next_request(request_queue_t *q)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct request *rq = NULL;

 

      /*

@@ -1465,7 +1465,7 @@ static void as_add_request(struct as_dat

 

 static void as_deactivate_request(request_queue_t *q, struct request
*rq)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct as_rq *arq = RQ_DATA(rq);

 

      if (arq) {

@@ -1510,7 +1510,7 @@ static void as_account_queued_request(st

 static void

 as_insert_request(request_queue_t *q, struct request *rq, int where)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct as_rq *arq = RQ_DATA(rq);

 

      if (arq) {

@@ -1563,7 +1563,7 @@ as_insert_request(request_queue_t *q, st

  */

 static int as_queue_empty(request_queue_t *q)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

 

      if (!list_empty(&ad->fifo_list[REQ_ASYNC])

            || !list_empty(&ad->fifo_list[REQ_SYNC])

@@ -1602,7 +1602,7 @@ as_latter_request(request_queue_t *q, st

 static int

 as_merge(request_queue_t *q, struct request **req, struct bio *bio)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      sector_t rb_key = bio->bi_sector + bio_sectors(bio);

      struct request *__rq;

      int ret;

@@ -1657,7 +1657,7 @@ out_insert:

 

 static void as_merged_request(request_queue_t *q, struct request *req)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct as_rq *arq = RQ_DATA(req);

 

      /*

@@ -1702,7 +1702,7 @@ static void

 as_merged_requests(request_queue_t *q, struct request *req,

                   struct request *next)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct as_rq *arq = RQ_DATA(req);

      struct as_rq *anext = RQ_DATA(next);

 

@@ -1789,7 +1789,7 @@ static void as_work_handler(void *data)

 

 static void as_put_request(request_queue_t *q, struct request *rq)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct as_rq *arq = RQ_DATA(rq);

 

      if (!arq) {

@@ -1809,7 +1809,7 @@ static void as_put_request(request_queue

 static int as_set_request(request_queue_t *q, struct request *rq,

                    struct bio *bio, int gfp_mask)

 {

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);

 

      if (arq) {

@@ -1831,7 +1831,7 @@ static int as_set_request(request_queue_

 static int as_may_queue(request_queue_t *q, int rw, struct bio *bio)

 {

      int ret = ELV_MQUEUE_MAY;

-     struct as_data *ad = q->elevator->elevator_data;

+     struct as_data *ad = q->elevator.elevator_data;

      struct io_context *ioc;

      if (ad->antic_status == ANTIC_WAIT_REQ ||

                  ad->antic_status == ANTIC_WAIT_NEXT) {

diff -rup linux-2.6.14-rc2/drivers/block/cfq-iosched.c
linux-2.6.14-rc2elv1/drivers/block/cfq-iosched.c

--- linux-2.6.14-rc2/drivers/block/cfq-iosched.c     2005-09-24
09:13:54.000000000 +0400

+++ linux-2.6.14-rc2elv1/drivers/block/cfq-iosched.c 2005-10-13
04:18:12.000000000 +0400

@@ -364,7 +364,7 @@ static inline void cfq_schedule_dispatch

 

 static int cfq_queue_empty(request_queue_t *q)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

 

      return !cfq_pending_requests(cfqd);

 }

@@ -678,7 +678,7 @@ out:

 

 static void cfq_deactivate_request(request_queue_t *q, struct request
*rq)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct cfq_rq *crq = RQ_DATA(rq);

 

      if (crq) {

@@ -724,7 +724,7 @@ static void cfq_remove_request(request_q

 static int

 cfq_merge(request_queue_t *q, struct request **req, struct bio *bio)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct request *__rq;

      int ret;

 

@@ -756,7 +756,7 @@ out_insert:

 

 static void cfq_merged_request(request_queue_t *q, struct request *req)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct cfq_rq *crq = RQ_DATA(req);

 

      cfq_del_crq_hash(crq);

@@ -999,7 +999,7 @@ static int cfq_arm_slice_timer(struct cf

  */

 static void cfq_dispatch_sort(request_queue_t *q, struct cfq_rq *crq)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct cfq_queue *cfqq = crq->cfq_queue;

      struct list_head *head = &q->queue_head, *entry = head;

      struct request *__rq;

@@ -1196,7 +1196,7 @@ __cfq_dispatch_requests(struct cfq_data 

 static int

 cfq_dispatch_requests(request_queue_t *q, int max_dispatch, int force)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct cfq_queue *cfqq;

 

      if (!cfqd->busy_queues)

@@ -1270,7 +1270,7 @@ cfq_account_completion(struct cfq_queue 

 

 static struct request *cfq_next_request(request_queue_t *q)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct request *rq;

 

      if (!list_empty(&q->queue_head)) {

@@ -1840,7 +1840,7 @@ static void cfq_enqueue(struct cfq_data 

 static void

 cfq_insert_request(request_queue_t *q, struct request *rq, int where)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

 

      switch (where) {

            case ELEVATOR_INSERT_BACK:

@@ -2006,7 +2006,7 @@ __cfq_may_queue(struct cfq_data *cfqd, s

 

 static int cfq_may_queue(request_queue_t *q, int rw, struct bio *bio)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct task_struct *tsk = current;

      struct cfq_queue *cfqq;

 

@@ -2029,7 +2029,7 @@ static int cfq_may_queue(request_queue_t

 

 static void cfq_check_waiters(request_queue_t *q, struct cfq_queue
*cfqq)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct request_list *rl = &q->rq;

 

      if (cfqq->allocated[READ] <= cfqd->max_queued || cfqd->rq_starved)
{

@@ -2050,7 +2050,7 @@ static void cfq_check_waiters(request_qu

  */

 static void cfq_put_request(request_queue_t *q, struct request *rq)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct cfq_rq *crq = RQ_DATA(rq);

 

      if (crq) {

@@ -2077,7 +2077,7 @@ static int

 cfq_set_request(request_queue_t *q, struct request *rq, struct bio
*bio,

            int gfp_mask)

 {

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      struct task_struct *tsk = current;

      struct cfq_io_context *cic;

      const int rw = rq_data_dir(rq);

@@ -2153,7 +2153,7 @@ queue_fail:

 static void cfq_kick_queue(void *data)

 {

      request_queue_t *q = data;

-     struct cfq_data *cfqd = q->elevator->elevator_data;

+     struct cfq_data *cfqd = q->elevator.elevator_data;

      unsigned long flags;

 

      spin_lock_irqsave(q->queue_lock, flags);

@@ -2263,7 +2263,7 @@ static void cfq_put_cfqd(struct cfq_data

      blk_put_queue(q);

 

      cfq_shutdown_timer_wq(cfqd);

-     q->elevator->elevator_data = NULL;

+     q->elevator.elevator_data = NULL;

 

      mempool_destroy(cfqd->crq_pool);

      kfree(cfqd->crq_hash);

diff -rup linux-2.6.14-rc2/drivers/block/deadline-iosched.c
linux-2.6.14-rc2elv1/drivers/block/deadline-iosched.c

--- linux-2.6.14-rc2/drivers/block/deadline-iosched.c      2005-09-24
09:16:32.000000000 +0400

+++ linux-2.6.14-rc2elv1/drivers/block/deadline-iosched.c  2005-10-13
04:18:12.000000000 +0400

@@ -289,7 +289,7 @@ deadline_find_first_drq(struct deadline_

 static inline void

 deadline_add_request(struct request_queue *q, struct request *rq)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

      struct deadline_rq *drq = RQ_DATA(rq);

 

      const int data_dir = rq_data_dir(drq->request);

@@ -317,7 +317,7 @@ static void deadline_remove_request(requ

      struct deadline_rq *drq = RQ_DATA(rq);

 

      if (drq) {

-           struct deadline_data *dd = q->elevator->elevator_data;

+           struct deadline_data *dd = q->elevator.elevator_data;

 

            list_del_init(&drq->fifo);

            deadline_remove_merge_hints(q, drq);

@@ -328,7 +328,7 @@ static void deadline_remove_request(requ

 static int

 deadline_merge(request_queue_t *q, struct request **req, struct bio
*bio)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

      struct request *__rq;

      int ret;

 

@@ -383,7 +383,7 @@ out_insert:

 

 static void deadline_merged_request(request_queue_t *q, struct request
*req)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

      struct deadline_rq *drq = RQ_DATA(req);

 

      /*

@@ -407,7 +407,7 @@ static void

 deadline_merged_requests(request_queue_t *q, struct request *req,

                   struct request *next)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

      struct deadline_rq *drq = RQ_DATA(req);

      struct deadline_rq *dnext = RQ_DATA(next);

 

@@ -599,7 +599,7 @@ dispatch_request:

 

 static struct request *deadline_next_request(request_queue_t *q)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

      struct request *rq;

 

      /*

@@ -620,7 +620,7 @@ dispatch:

 static void

 deadline_insert_request(request_queue_t *q, struct request *rq, int
where)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

 

      /* barriers must flush the reorder queue */

      if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)

@@ -648,7 +648,7 @@ deadline_insert_request(request_queue_t 

 

 static int deadline_queue_empty(request_queue_t *q)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

 

      if (!list_empty(&dd->fifo_list[WRITE])

          || !list_empty(&dd->fifo_list[READ])

@@ -745,7 +745,7 @@ static int deadline_init_queue(request_q

 

 static void deadline_put_request(request_queue_t *q, struct request
*rq)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

      struct deadline_rq *drq = RQ_DATA(rq);

 

      if (drq) {

@@ -758,7 +758,7 @@ static int

 deadline_set_request(request_queue_t *q, struct request *rq, struct bio
*bio,

                 int gfp_mask)

 {

-     struct deadline_data *dd = q->elevator->elevator_data;

+     struct deadline_data *dd = q->elevator.elevator_data;

      struct deadline_rq *drq;

 

      drq = mempool_alloc(dd->drq_pool, gfp_mask);

diff -rup linux-2.6.14-rc2/drivers/block/elevator.c
linux-2.6.14-rc2elv1/drivers/block/elevator.c

--- linux-2.6.14-rc2/drivers/block/elevator.c  2005-09-24
09:13:54.000000000 +0400

+++ linux-2.6.14-rc2elv1/drivers/block/elevator.c    2005-10-13
04:18:12.000000000 +0400

@@ -130,18 +130,17 @@ static struct elevator_type *elevator_ge

      return e;

 }

 

-static int elevator_attach(request_queue_t *q, struct elevator_type *e,

-                    struct elevator_queue *eq)

+static int elevator_attach(request_queue_t *q, struct elevator_type *e)

 {

      int ret = 0;

+     struct elevator_queue *eq;

 

-     memset(eq, 0, sizeof(*eq));

+     eq = &q->elevator;

      eq->ops = &e->ops;

      eq->elevator_type = e;

 

      INIT_LIST_HEAD(&q->queue_head);

      q->last_merge = NULL;

-     q->elevator = eq;

 

      if (eq->ops->elevator_init_fn)

            ret = eq->ops->elevator_init_fn(q, eq);

@@ -183,7 +182,6 @@ __setup("elevator=", elevator_setup);

 int elevator_init(request_queue_t *q, char *name)

 {

      struct elevator_type *e = NULL;

-     struct elevator_queue *eq;

      int ret = 0;

 

      elevator_setup_default();

@@ -195,15 +193,8 @@ int elevator_init(request_queue_t *q, ch

      if (!e)

            return -EINVAL;

 

-     eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);

-     if (!eq) {

-           elevator_put(e->elevator_type);

-           return -ENOMEM;

-     }

-

-     ret = elevator_attach(q, e, eq);

+     ret = elevator_attach(q, e);

      if (ret) {

-           kfree(eq);

            elevator_put(e->elevator_type);

      }

 

@@ -217,12 +208,11 @@ void elevator_exit(elevator_t *e)

 

      elevator_put(e->elevator_type);

      e->elevator_type = NULL;

-     kfree(e);

 }

 

 int elv_merge(request_queue_t *q, struct request **req, struct bio
*bio)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_merge_fn)

            return e->ops->elevator_merge_fn(q, req, bio);

@@ -232,7 +222,7 @@ int elv_merge(request_queue_t *q, struct

 

 void elv_merged_request(request_queue_t *q, struct request *rq)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_merged_fn)

            e->ops->elevator_merged_fn(q, rq);

@@ -241,7 +231,7 @@ void elv_merged_request(request_queue_t 

 void elv_merge_requests(request_queue_t *q, struct request *rq,

                       struct request *next)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (q->last_merge == next)

            q->last_merge = NULL;

@@ -258,7 +248,7 @@ void elv_merge_requests(request_queue_t 

  */

 void elv_deactivate_request(request_queue_t *q, struct request *rq)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      /*

       * it already went through dequeue, we need to decrement the

@@ -296,8 +286,8 @@ void elv_requeue_request(request_queue_t

       * if iosched has an explicit requeue hook, then use that.
otherwise

       * just put the request at the front of the queue

       */

-     if (q->elevator->ops->elevator_requeue_req_fn)

-           q->elevator->ops->elevator_requeue_req_fn(q, rq);

+     if (q->elevator.ops->elevator_requeue_req_fn)

+           q->elevator.ops->elevator_requeue_req_fn(q, rq);

      else

            __elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);

 }

@@ -318,7 +308,7 @@ void __elv_add_request(request_queue_t *

      rq->q = q;

 

      if (!test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {

-           q->elevator->ops->elevator_add_req_fn(q, rq, where);

+           q->elevator.ops->elevator_add_req_fn(q, rq, where);

 

            if (blk_queue_plugged(q)) {

                  int nrq = q->rq.count[READ] + q->rq.count[WRITE]

@@ -348,7 +338,7 @@ void elv_add_request(request_queue_t *q,

 

 static inline struct request *__elv_next_request(request_queue_t *q)

 {

-     struct request *rq = q->elevator->ops->elevator_next_req_fn(q);

+     struct request *rq = q->elevator.ops->elevator_next_req_fn(q);

 

      /*

       * if this is a barrier write and the device has to issue a

@@ -418,7 +408,7 @@ struct request *elv_next_request(request

 

 void elv_remove_request(request_queue_t *q, struct request *rq)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      /*

       * the time frame between a request being removed from the lists

@@ -446,7 +436,7 @@ void elv_remove_request(request_queue_t 

 

 int elv_queue_empty(request_queue_t *q)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_queue_empty_fn)

            return e->ops->elevator_queue_empty_fn(q);

@@ -458,7 +448,7 @@ struct request *elv_latter_request(reque

 {

      struct list_head *next;

 

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_latter_req_fn)

            return e->ops->elevator_latter_req_fn(q, rq);

@@ -474,7 +464,7 @@ struct request *elv_former_request(reque

 {

      struct list_head *prev;

 

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_former_req_fn)

            return e->ops->elevator_former_req_fn(q, rq);

@@ -489,7 +479,7 @@ struct request *elv_former_request(reque

 int elv_set_request(request_queue_t *q, struct request *rq, struct bio
*bio,

                int gfp_mask)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_set_req_fn)

            return e->ops->elevator_set_req_fn(q, rq, bio, gfp_mask);

@@ -500,7 +490,7 @@ int elv_set_request(request_queue_t *q, 

 

 void elv_put_request(request_queue_t *q, struct request *rq)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_put_req_fn)

            e->ops->elevator_put_req_fn(q, rq);

@@ -508,7 +498,7 @@ void elv_put_request(request_queue_t *q,

 

 int elv_may_queue(request_queue_t *q, int rw, struct bio *bio)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      if (e->ops->elevator_may_queue_fn)

            return e->ops->elevator_may_queue_fn(q, rw, bio);

@@ -518,7 +508,7 @@ int elv_may_queue(request_queue_t *q, in

 

 void elv_completed_request(request_queue_t *q, struct request *rq)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      /*

       * request is released from the driver, io must be done

@@ -532,7 +522,7 @@ void elv_completed_request(request_queue

 

 int elv_register_queue(struct request_queue *q)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

 

      e->kobj.parent = kobject_get(&q->kobj);

      if (!e->kobj.parent)

@@ -547,7 +537,7 @@ int elv_register_queue(struct request_qu

 void elv_unregister_queue(struct request_queue *q)

 {

      if (q) {

-           elevator_t *e = q->elevator;

+           elevator_t *e = &q->elevator;

            kobject_unregister(&e->kobj);

            kobject_put(&q->kobj);

      }

@@ -590,12 +580,8 @@ EXPORT_SYMBOL_GPL(elv_unregister);

  */

 static void elevator_switch(request_queue_t *q, struct elevator_type
*new_e)

 {

-     elevator_t *e = kmalloc(sizeof(elevator_t), GFP_KERNEL);

      struct elevator_type *noop_elevator = NULL;

-     elevator_t *old_elevator;

-

-     if (!e)

-           goto error;

+     elevator_t old_elevator;

 

      /*

       * first step, drain requests from the block freelist

@@ -615,7 +601,7 @@ static void elevator_switch(request_queu

       */

      noop_elevator = elevator_get("noop");

      spin_lock_irq(q->queue_lock);

-     elevator_attach(q, noop_elevator, e);

+     elevator_attach(q, noop_elevator);

      spin_unlock_irq(q->queue_lock);

 

      blk_wait_queue_drained(q, 1);

@@ -623,7 +609,7 @@ static void elevator_switch(request_queu

      /*

       * attach and start new elevator

       */

-     if (elevator_attach(q, new_e, e))

+     if (elevator_attach(q, new_e))

            goto fail;

 

      if (elv_register_queue(q))

@@ -632,7 +618,7 @@ static void elevator_switch(request_queu

      /*

       * finally exit old elevator and start queue again

       */

-     elevator_exit(old_elevator);

+     elevator_exit(&old_elevator);

      blk_finish_queue_drain(q);

      elevator_put(noop_elevator);

      return;

@@ -642,14 +628,12 @@ fail_register:

       * switch failed, exit the new io scheduler and reattach the old

       * one again (along with re-adding the sysfs dir)

       */

-     elevator_exit(e);

+     elevator_exit(&q->elevator);

 fail:

      q->elevator = old_elevator;

      elv_register_queue(q);

      blk_finish_queue_drain(q);

-error:

-     if (noop_elevator)

-           elevator_put(noop_elevator);

+     elevator_put(noop_elevator);

      elevator_put(new_e);

      printk(KERN_ERR "elevator: switch to %s
failed\n",new_e->elevator_name);

 }

@@ -671,7 +655,7 @@ ssize_t elv_iosched_store(request_queue_

            return -EINVAL;

      }

 

-     if (!strcmp(elevator_name,
q->elevator->elevator_type->elevator_name))

+     if (!strcmp(elevator_name,
q->elevator.elevator_type->elevator_name))

            return count;

 

      elevator_switch(q, e);

@@ -680,7 +664,7 @@ ssize_t elv_iosched_store(request_queue_

 

 ssize_t elv_iosched_show(request_queue_t *q, char *name)

 {

-     elevator_t *e = q->elevator;

+     elevator_t *e = &q->elevator;

      struct elevator_type *elv = e->elevator_type;

      struct list_head *entry;

      int len = 0;

diff -rup linux-2.6.14-rc2/drivers/block/ll_rw_blk.c
linux-2.6.14-rc2elv1/drivers/block/ll_rw_blk.c

--- linux-2.6.14-rc2/drivers/block/ll_rw_blk.c 2005-09-24
09:16:32.000000000 +0400

+++ linux-2.6.14-rc2elv1/drivers/block/ll_rw_blk.c   2005-10-13
04:18:12.000000000 +0400

@@ -1613,8 +1613,7 @@ void blk_cleanup_queue(request_queue_t *

      if (!atomic_dec_and_test(&q->refcnt))

            return;

 

-     if (q->elevator)

-           elevator_exit(q->elevator);

+     elevator_exit(&q->elevator);

 

      blk_sync_queue(q);

 

diff -rup linux-2.6.14-rc2/include/linux/blkdev.h
linux-2.6.14-rc2elv1/include/linux/blkdev.h

--- linux-2.6.14-rc2/include/linux/blkdev.h    2005-09-24
09:16:47.000000000 +0400

+++ linux-2.6.14-rc2elv1/include/linux/blkdev.h      2005-10-13
04:18:12.000000000 +0400

@@ -312,7 +312,7 @@ struct request_queue

       */

      struct list_head  queue_head;

      struct request          *last_merge;

-     elevator_t        *elevator;

+     elevator_t        elevator;

 

      /*

       * the queue request freelist, one for reads and one for writes
