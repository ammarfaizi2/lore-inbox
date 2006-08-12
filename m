Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWHLOQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWHLOQg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWHLOQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:16:35 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:50716 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932534AbWHLOPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:15:42 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Indan Zupancic <indan@nul.nu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Sat, 12 Aug 2006 16:14:55 +0200
Message-Id: <20060812141455.30842.41506.sendpatchset@lappy>
In-Reply-To: <20060812141415.30842.78695.sendpatchset@lappy>
References: <20060812141415.30842.78695.sendpatchset@lappy>
Subject: [RFC][PATCH 4/4] deadlock prevention for NBD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use sk_set_memalloc() on the nbd socket.

Limit each request to 1 page, so that the request throttling also limits the
number of in-flight pages and force the IO scheduler to NOOP as anything else
doesn't make sense anyway.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 block/elevator.c       |    5 +++++
 block/ll_rw_blk.c      |   12 ++++++++++--
 drivers/block/nbd.c    |   12 +++++++++++-
 include/linux/blkdev.h |    9 +++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)

Index: linux-2.6/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/block/ll_rw_blk.c	2006-08-12 15:38:01.000000000 +0200
+++ linux-2.6/block/ll_rw_blk.c	2006-08-12 15:38:11.000000000 +0200
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
Index: linux-2.6/drivers/block/nbd.c
===================================================================
--- linux-2.6.orig/drivers/block/nbd.c	2006-08-12 15:38:01.000000000 +0200
+++ linux-2.6/drivers/block/nbd.c	2006-08-12 15:50:33.000000000 +0200
@@ -361,8 +361,13 @@ static void nbd_do_it(struct nbd_device 
 
 	BUG_ON(lo->magic != LO_MAGIC);
 
+	if (sk_set_memalloc(lo->sock->sk))
+		printk(KERN_WARNING
+				"failed to set SO_MEMALLOC on NBD socket\n");
+
 	while ((req = nbd_read_stat(lo)) != NULL)
 		nbd_end_request(req);
+
 	return;
 }
 
@@ -628,11 +633,16 @@ static int __init nbd_init(void)
 		 * every gendisk to have its very own request_queue struct.
 		 * These structs are big so we dynamically allocate them.
 		 */
-		disk->queue = blk_init_queue(do_nbd_request, &nbd_lock);
+		disk->queue = blk_init_queue_node_elv(do_nbd_request,
+				&nbd_lock, -1, "noop");
 		if (!disk->queue) {
 			put_disk(disk);
 			goto out;
 		}
+		blk_queue_pin_elevator(disk->queue);
+		blk_queue_max_segment_size(disk->queue, PAGE_SIZE);
+		blk_queue_max_hw_segments(disk->queue, 1);
+		blk_queue_max_phys_segments(disk->queue, 1);
 	}
 
 	if (register_blkdev(NBD_MAJOR, "nbd")) {
Index: linux-2.6/include/linux/blkdev.h
===================================================================
--- linux-2.6.orig/include/linux/blkdev.h	2006-08-12 15:38:01.000000000 +0200
+++ linux-2.6/include/linux/blkdev.h	2006-08-12 15:38:11.000000000 +0200
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
--- linux-2.6.orig/block/elevator.c	2006-08-12 15:38:01.000000000 +0200
+++ linux-2.6/block/elevator.c	2006-08-12 15:38:11.000000000 +0200
@@ -861,6 +861,11 @@ ssize_t elv_iosched_store(request_queue_
 	size_t len;
 	struct elevator_type *e;
 
+	if (test_bit(QUEUE_FLAG_ELVPINNED, &q->queue_flags)) {
+		printk(KERN_ERR "elevator: cannot switch elevator, pinned\n");
+		return count;
+	}
+
 	elevator_name[sizeof(elevator_name) - 1] = '\0';
 	strncpy(elevator_name, name, sizeof(elevator_name) - 1);
 	len = strlen(elevator_name);
