Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTIIHE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 03:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbTIIHE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 03:04:27 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:9990
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263628AbTIIHEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 03:04:22 -0400
Message-ID: <3F5D7B6A.70703@cyberone.com.au>
Date: Tue, 09 Sep 2003 17:04:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Badness in as_completed_request warning
References: <20030908164802.GA13441@osdl.org> <3F5D4BC9.6020708@cyberone.com.au> <20030909061214.GA15840@osdl.org>
In-Reply-To: <20030909061214.GA15840@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000202090703040707020506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202090703040707020506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Dave Olien wrote:

>On Tue, Sep 09, 2003 at 01:40:57PM +1000, Nick Piggin wrote:
>
>>Hi Dave,
>>Can you try 2.6.0-test5 with the following patch please. Thanks
>>
>>
>
>I applied this patch, and gave it a shot.  It seems to have made things
>worse.  Instead of the warnings occurring only at the end of the mkfs
>runs, they now occur pretty much constantly, and it finally ends
>with an Bug_On.  Attached is the console output.  There are 20 
>occurrances of Badness in as-iosched.c line 1020.  There is one
>occurrance of Badness in as-iosched.c line 1025.  The Bug_On() is in
>as-iosched.c line 1243.
>
>Console output is attached.
>

Thanks Dave,
Can you try this one? I can't reproduce the problem here as I don't have
enough disks unfortunately. Thanks

Nick

--------------000202090703040707020506
Content-Type: text/plain;
 name="as-warn-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-warn-fix.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |   60 +++++++++++++++++++--------
 1 files changed, 43 insertions(+), 17 deletions(-)

diff -puN drivers/block/as-iosched.c~as-warn-fix drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-warn-fix	2003-09-09 17:02:41.000000000 +1000
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-09-09 17:02:41.000000000 +1000
@@ -373,7 +373,7 @@ static void as_move_to_dispatch(struct a
  * direct IO, then move the alias to the dispatch list and then add the
  * request.
  */
-static void as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
+static int as_add_arq_rb(struct as_data *ad, struct as_rq *arq)
 {
 	struct as_rq *alias;
 	struct request *rq = arq->request;
@@ -381,10 +381,20 @@ static void as_add_arq_rb(struct as_data
 	arq->rb_key = rq_rb_key(rq);
 
 	/* This can be caused by direct IO */
+#if 0
 	while ((alias = __as_add_arq_rb(ad, arq)))
 		as_move_to_dispatch(ad, alias);
+#endif
+	if ((alias = __as_add_arq_rb(ad, arq))) {
+		arq->state = AS_RQ_NEW;
+		list_add_tail(&arq->request->queuelist,
+				&alias->request->queuelist);
+
+		return 1;
+	}
 
 	rb_insert_color(&arq->rb_node, ARQ_RB_ROOT(ad, arq));
+	return 0;
 }
 
 static inline void as_del_arq_rb(struct as_data *ad, struct as_rq *arq)
@@ -1131,7 +1141,21 @@ static void as_move_to_dispatch(struct a
 	 * take it off the sort and fifo list, add to dispatch queue
 	 */
 	as_remove_queued_request(ad->q, arq->request);
+
+	for (;;) {
+		struct list_head *alias = &arq->request->queuelist;
+
+		if (!list_empty(alias)) {
+			struct request *rq;
+			rq = list_entry_rq(alias->next);
+			list_del(&rq->queuelist);
+			list_add_tail(&rq->queuelist, ad->dispatch);
+		} else
+			break;
+	}
+
 	list_add_tail(&arq->request->queuelist, ad->dispatch);
+
 	if (arq->io_context && arq->io_context->aic)
 		atomic_inc(&arq->io_context->aic->nr_dispatched);
 
@@ -1303,22 +1327,22 @@ static void as_add_request(struct as_dat
 		arq->is_sync = 0;
 	data_dir = arq->is_sync;
 
-	arq->io_context = as_get_io_context();
+	if (!as_add_arq_rb(ad, arq)) {
+		arq->io_context = as_get_io_context();
 
-	if (arq->io_context) {
-		atomic_inc(&arq->io_context->aic->nr_queued);
-		as_update_iohist(arq->io_context->aic, arq->request);
-	}
-
-	as_add_arq_rb(ad, arq);
+		if (arq->io_context) {
+			atomic_inc(&arq->io_context->aic->nr_queued);
+			as_update_iohist(arq->io_context->aic, arq->request);
+		}
 
-	/*
-	 * set expire time (only used for reads) and add to fifo list
-	 */
-	arq->expires = jiffies + ad->fifo_expire[data_dir];
-	list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
-	arq->state = AS_RQ_QUEUED;
-	as_update_arq(ad, arq); /* keep state machine up to date */
+		/*
+		 * set expire time (only used for reads) and add to fifo list
+		 */
+		arq->expires = jiffies + ad->fifo_expire[data_dir];
+		list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
+		arq->state = AS_RQ_QUEUED;
+		as_update_arq(ad, arq); /* keep state machine up to date */
+	}
 }
 
 /*
@@ -1495,7 +1519,8 @@ static void as_merged_request(request_qu
 	 */
 	if (rq_rb_key(req) != arq->rb_key) {
 		as_del_arq_rb(ad, arq);
-		as_add_arq_rb(ad, arq);
+		if (as_add_arq_rb(ad, arq))
+			WARN_ON(1);
 		/*
 		 * Note! At this stage of this and the next function, our next
 		 * request may not be optimal - eg the request may have "grown"
@@ -1526,7 +1551,8 @@ as_merged_requests(request_queue_t *q, s
 
 	if (rq_rb_key(req) != arq->rb_key) {
 		as_del_arq_rb(ad, arq);
-		as_add_arq_rb(ad, arq);
+		if (as_add_arq_rb(ad, arq))
+			WARN_ON(1);
 	}
 
 	/*

_

--------------000202090703040707020506--

