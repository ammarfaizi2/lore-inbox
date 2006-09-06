Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWIFNnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWIFNnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWIFNme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:42:34 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:18666 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750945AbWIFNid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:33 -0400
Message-Id: <20060906133954.673752000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:40 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Jens Axboe <axboe@suse.de>,
       Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 10/21] block: elevator selection and pinning
Content-Disposition: inline; filename=block_queue_init_elv.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an block queue init function that allows to set an elevator. And a 
function to pin the current elevator.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>
CC: Jens Axboe <axboe@suse.de>
CC: Pavel Machek <pavel@ucw.cz>
---
 block/elevator.c         |   56 ++++++++++++++++++++++++++++++++++++-----------
 block/ll_rw_blk.c        |   12 ++++++++--
 include/linux/blkdev.h   |    9 +++++++
 include/linux/elevator.h |    1 
 4 files changed, 63 insertions(+), 15 deletions(-)

Index: linux-2.6/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/block/ll_rw_blk.c
+++ linux-2.6/block/ll_rw_blk.c
@@ -1899,6 +1899,14 @@ EXPORT_SYMBOL(blk_init_queue);
 request_queue_t *
 blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
 {
+	return blk_init_queue_node_elv(rfn, lock, node_id, NULL);
+}
+EXPORT_SYMBOL(blk_init_queue_node);
+
+request_queue_t *
+blk_init_queue_node_elv(request_fn_proc *rfn, spinlock_t *lock, int node_id,
+		char *elv_name)
+{
 	request_queue_t *q = blk_alloc_queue_node(GFP_KERNEL, node_id);
 
 	if (!q)
@@ -1939,7 +1947,7 @@ blk_init_queue_node(request_fn_proc *rfn
 	/*
 	 * all done
 	 */
-	if (!elevator_init(q, NULL)) {
+	if (!elevator_init(q, elv_name)) {
 		blk_queue_congestion_threshold(q);
 		return q;
 	}
@@ -1947,7 +1955,7 @@ blk_init_queue_node(request_fn_proc *rfn
 	blk_put_queue(q);
 	return NULL;
 }
-EXPORT_SYMBOL(blk_init_queue_node);
+EXPORT_SYMBOL(blk_init_queue_node_elv);
 
 int blk_get_queue(request_queue_t *q)
 {
Index: linux-2.6/include/linux/blkdev.h
===================================================================
--- linux-2.6.orig/include/linux/blkdev.h
+++ linux-2.6/include/linux/blkdev.h
@@ -444,6 +444,12 @@ struct request_queue
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 #define QUEUE_FLAG_ELVSWITCH	8	/* don't use elevator, just do FIFO */
+#define QUEUE_FLAG_ELVPINNED	9	/* pin the current elevator */
+
+static inline void blk_queue_pin_elevator(struct request_queue *q)
+{
+	set_bit(QUEUE_FLAG_ELVPINNED, &q->queue_flags);
+}
 
 enum {
 	/*
@@ -696,6 +702,9 @@ static inline void elv_dispatch_add_tail
 /*
  * Access functions for manipulating queue properties
  */
+extern request_queue_t *blk_init_queue_node_elv(request_fn_proc *rfn,
+					spinlock_t *lock, int node_id,
+					char *elv_name);
 extern request_queue_t *blk_init_queue_node(request_fn_proc *rfn,
 					spinlock_t *lock, int node_id);
 extern request_queue_t *blk_init_queue(request_fn_proc *, spinlock_t *);
Index: linux-2.6/block/elevator.c
===================================================================
--- linux-2.6.orig/block/elevator.c
+++ linux-2.6/block/elevator.c
@@ -856,11 +856,33 @@ fail_register:
 	return 0;
 }
 
+int elv_iosched_switch(request_queue_t *q, const char *elevator_name)
+{
+	struct elevator_type *e;
+
+	if (test_bit(QUEUE_FLAG_ELVPINNED, &q->queue_flags))
+		return -EPERM;
+
+	e = elevator_get(elevator_name);
+	if (!e)
+		return -EINVAL;
+
+	if (!strcmp(elevator_name, q->elevator->elevator_type->elevator_name)) {
+		elevator_put(e);
+		return -EEXIST;
+	}
+
+	if (!elevator_switch(q, e))
+		return -ENOMEM;
+
+	return 0;
+}
+
 ssize_t elv_iosched_store(request_queue_t *q, const char *name, size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
 	size_t len;
-	struct elevator_type *e;
+	int error;
 
 	elevator_name[sizeof(elevator_name) - 1] = '\0';
 	strncpy(elevator_name, name, sizeof(elevator_name) - 1);
@@ -869,20 +891,27 @@ ssize_t elv_iosched_store(request_queue_
 	if (len && elevator_name[len - 1] == '\n')
 		elevator_name[len - 1] = '\0';
 
-	e = elevator_get(elevator_name);
-	if (!e) {
-		printk(KERN_ERR "elevator: type %s not found\n", elevator_name);
-		return -EINVAL;
-	}
-
-	if (!strcmp(elevator_name, q->elevator->elevator_type->elevator_name)) {
-		elevator_put(e);
-		return count;
+	error = elv_iosched_switch(q, elevator_name);
+	switch (error) {
+		case -EPERM:
+			printk(KERN_NOTICE
+				"elevator: cannot switch elevator, pinned\n");
+			break;
+
+		case -EINVAL:
+			printk(KERN_ERR "elevator: type %s not found\n",
+					elevator_name);
+			break;
+
+		case -ENOMEM:
+			printk(KERN_ERR "elevator: switch to %s failed\n",
+					elevator_name);
+		default:
+			error = 0;
+			break;
 	}
 
-	if (!elevator_switch(q, e))
-		printk(KERN_ERR "elevator: switch to %s failed\n",elevator_name);
-	return count;
+	return error ?: count;
 }
 
 ssize_t elv_iosched_show(request_queue_t *q, char *name)
@@ -914,5 +943,6 @@ EXPORT_SYMBOL(__elv_add_request);
 EXPORT_SYMBOL(elv_next_request);
 EXPORT_SYMBOL(elv_dequeue_request);
 EXPORT_SYMBOL(elv_queue_empty);
+EXPORT_SYMBOL(elv_iosched_switch);
 EXPORT_SYMBOL(elevator_exit);
 EXPORT_SYMBOL(elevator_init);
Index: linux-2.6/include/linux/elevator.h
===================================================================
--- linux-2.6.orig/include/linux/elevator.h
+++ linux-2.6/include/linux/elevator.h
@@ -107,6 +107,7 @@ extern int elv_may_queue(request_queue_t
 extern void elv_completed_request(request_queue_t *, struct request *);
 extern int elv_set_request(request_queue_t *, struct request *, struct bio *, gfp_t);
 extern void elv_put_request(request_queue_t *, struct request *);
+extern int elv_iosched_switch(request_queue_t *, const char *);
 
 /*
  * io scheduler registration

--
