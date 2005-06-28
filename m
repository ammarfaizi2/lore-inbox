Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVF1DOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVF1DOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 23:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVF1DOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 23:14:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262322AbVF1DOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 23:14:12 -0400
Date: Mon, 27 Jun 2005 20:13:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cfq build breakage
Message-Id: <20050627201333.4c7d3d06.akpm@osdl.org>
In-Reply-To: <42C0B39E.7070509@pobox.com>
References: <42C0B39E.7070509@pobox.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> 
> In latest git tree...
> 
>    CC [M]  drivers/block/cfq-iosched.o
> drivers/block/cfq-iosched.c: In function `cfq_put_queue':
> drivers/block/cfq-iosched.c:303: sorry, unimplemented: inlining failed 
> in call to 'cfq_pending_requests': function body not available
> drivers/block/cfq-iosched.c:1080: sorry, unimplemented: called from here
> drivers/block/cfq-iosched.c: In function `__cfq_may_queue':
> drivers/block/cfq-iosched.c:1955: warning: the address of 
> `cfq_cfqq_must_alloc_slice', will always evaluate as `true'
> make[2]: *** [drivers/block/cfq-iosched.o] Error 1
> make[1]: *** [drivers/block] Error 2
> make: *** [drivers] Error 2

hm.  The inline thing is trivial, but the misuse of
cfq_cfqq_must_alloc_slice() means that we now wander into untested
territory.

 drivers/block/cfq-iosched.c |   49 +++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 25 deletions(-)

diff -puN drivers/block/cfq-iosched.c~cfq-build-fix drivers/block/cfq-iosched.c
--- 25/drivers/block/cfq-iosched.c~cfq-build-fix	2005-06-27 20:12:10.000000000 -0700
+++ 25-akpm/drivers/block/cfq-iosched.c	2005-06-27 20:12:10.000000000 -0700
@@ -300,7 +300,6 @@ CFQ_CRQ_FNS(requeued);
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned int, unsigned short);
 static void cfq_dispatch_sort(request_queue_t *, struct cfq_rq *);
 static void cfq_put_cfqd(struct cfq_data *cfqd);
-static inline int cfq_pending_requests(struct cfq_data *cfqd);
 
 #define process_sync(tsk)	((tsk)->flags & PF_SYNCWRITE)
 
@@ -348,6 +347,28 @@ static struct request *cfq_find_rq_hash(
 	return NULL;
 }
 
+static inline int cfq_pending_requests(struct cfq_data *cfqd)
+{
+	return !list_empty(&cfqd->queue->queue_head) || cfqd->busy_queues;
+}
+
+/*
+ * scheduler run of queue, if there are requests pending and no one in the
+ * driver that will restart queueing
+ */
+static inline void cfq_schedule_dispatch(struct cfq_data *cfqd)
+{
+	if (!cfqd->rq_in_driver && cfq_pending_requests(cfqd))
+		kblockd_schedule_work(&cfqd->unplug_work);
+}
+
+static int cfq_queue_empty(request_queue_t *q)
+{
+	struct cfq_data *cfqd = q->elevator->elevator_data;
+
+	return !cfq_pending_requests(cfqd);
+}
+
 /*
  * Lifted from AS - choose which of crq1 and crq2 that is best served now.
  * We choose the request that is closest to the head right now. Distance
@@ -1072,16 +1093,6 @@ cfq_prio_to_maxrq(struct cfq_data *cfqd,
 }
 
 /*
- * scheduler run of queue, if there are requests pending and no one in the
- * driver that will restart queueing
- */
-static inline void cfq_schedule_dispatch(struct cfq_data *cfqd)
-{
-	if (!cfqd->rq_in_driver && cfq_pending_requests(cfqd))
-		kblockd_schedule_work(&cfqd->unplug_work);
-}
-
-/*
  * get next queue for service
  */
 static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd, int force)
@@ -1846,18 +1857,6 @@ cfq_insert_request(request_queue_t *q, s
 	}
 }
 
-static inline int cfq_pending_requests(struct cfq_data *cfqd)
-{
-	return !list_empty(&cfqd->queue->queue_head) || cfqd->busy_queues;
-}
-
-static int cfq_queue_empty(request_queue_t *q)
-{
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-
-	return !cfq_pending_requests(cfqd);
-}
-
 static void cfq_completed_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
@@ -1952,7 +1951,7 @@ __cfq_may_queue(struct cfq_data *cfqd, s
 {
 #if 1
 	if ((cfq_cfqq_wait_request(cfqq) || cfq_cfqq_must_alloc(cfqq)) &&
-	    !cfq_cfqq_must_alloc_slice) {
+	    !cfq_cfqq_must_alloc_slice(cfqq)) {
 		cfq_mark_cfqq_must_alloc_slice(cfqq);
 		return ELV_MQUEUE_MUST;
 	}
@@ -1969,7 +1968,7 @@ __cfq_may_queue(struct cfq_data *cfqd, s
 		 * only allow 1 ELV_MQUEUE_MUST per slice, otherwise we
 		 * can quickly flood the queue with writes from a single task
 		 */
-		if (rw == READ || !cfq_cfqq_must_alloc_slice) {
+		if (rw == READ || !cfq_cfqq_must_alloc_slice(cfqq)) {
 			cfq_mark_cfqq_must_alloc_slice(cfqq);
 			return ELV_MQUEUE_MUST;
 		}
_

