Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWHYPpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWHYPpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWHYPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:45:11 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:13092 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422727AbWHYPov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:44:51 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Indan Zupancic <indan@nul.nu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Fri, 25 Aug 2006 17:40:07 +0200
Message-Id: <20060825154007.24271.4560.sendpatchset@twins>
In-Reply-To: <20060825153946.24271.42758.sendpatchset@twins>
References: <20060825153946.24271.42758.sendpatchset@twins>
Subject: [PATCH 2/4] blkdev: iosched selection for queue creation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Provide an block queue init function that allows to set an elevator.
And a function to pin the current elevator.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>
---
 block/elevator.c       |    5 +++++
 block/ll_rw_blk.c      |   12 ++++++++++--
 include/linux/blkdev.h |    9 +++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

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
@@ -861,6 +861,11 @@ ssize_t elv_iosched_store(request_queue_
 	size_t len;
 	struct elevator_type *e;
 
+	if (test_bit(QUEUE_FLAG_ELVPINNED, &q->queue_flags)) {
+		printk(KERN_NOTICE "elevator: cannot switch elevator, pinned\n");
+		return count;
+	}
+
 	elevator_name[sizeof(elevator_name) - 1] = '\0';
 	strncpy(elevator_name, name, sizeof(elevator_name) - 1);
 	len = strlen(elevator_name);
