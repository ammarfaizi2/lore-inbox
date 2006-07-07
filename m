Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWGGO1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWGGO1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWGGO1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:27:04 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:62218 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751216AbWGGO1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:27:02 -0400
Subject: [RFC][PATCH] swap over NBD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 16:26:38 +0200
Message-Id: <1152282398.12271.30.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With this patch I cannot manage to deadlock the kernel with swapping
over NBD. That is, using the now forced NOOP io-sched for the NBD queue.

If another io-sched (say CFQ) is used (even with the coalescence limited
to PAGE_SIZE) the kernel very quickly locks up with the faulting process
stuck in D state like so:

08927a14:  [<0805f8fc>] switch_to_skas+0x3c/0x90
08927a2c:  [<0805ba59>] _switch_to+0x49/0xa0
08927a50:  [<081fbb02>] schedule+0x2c2/0x590
08927aa0:  [<081fc67e>] io_schedule+0xe/0x20
08927aa8:  [<080a49c9>] sync_page+0x39/0x50
08927ab4:  [<081fc939>] __wait_on_bit_lock+0x49/0x70
08927ad4:  [<080a5213>] __lock_page+0x73/0x80
08927b04:  [<080b40ac>] do_swap_page+0x1ac/0x300
08927b40:  [<080b4867>] __handle_mm_fault+0x107/0x280
08927b78:  [<0805e6d2>] handle_page_fault+0x142/0x280
08927ba8:  [<0805ea07>] segv+0x177/0x2e0
08927c5c:  [<0805e87f>] segv_handler+0x6f/0x80
08927c80:  [<080750e3>] user_signal+0x53/0x70
08927c98:  [<08074470>] userspace+0x1d0/0x370
08927cf8:  [<0805f9fb>] new_thread_handler+0xab/0xc0
08927d1c:  [<ffffe420>] _etext+0xf7dfe403/0x0
        
and occasionally other processes stuck in D state like so:

089d7810:  [<0805f8fc>] switch_to_skas+0x3c/0x90
089d7828:  [<0805ba59>] _switch_to+0x49/0xa0
089d784c:  [<081fbb02>] schedule+0x2c2/0x590
089d789c:  [<081fc67e>] io_schedule+0xe/0x20
089d78a4:  [<0816e647>] get_request_wait+0xf7/0x120
089d78e8:  [<0816f24f>] __make_request+0x9f/0x430
089d792c:  [<0816f771>] generic_make_request+0xf1/0x180
089d7970:  [<0816f853>] submit_bio+0x53/0x140
089d79d0:  [<080bb60e>] swap_writepage+0x9e/0xd0
089d79f4:  [<080aed89>] pageout+0xa9/0x140
089d7a3c:  [<080af19a>] shrink_page_list+0x2ba/0x440
089d7abc:  [<080af4d4>] shrink_inactive_list+0xb4/0x310
089d7b50:  [<080afbfb>] shrink_zone+0x9b/0x100
089d7b78:  [<080b0154>] balance_pgdat+0x264/0x390
089d7be0:  [<080b030d>] kswapd+0x8d/0xc0
089d7c18:  [<08095a86>] kthread+0xb6/0xc0
089d7c48:  [<0806f8e7>] run_kernel_thread+0x37/0x60
089d7cf8:  [<0805f9e1>] new_thread_handler+0x91/0xc0
089d7d1c:  [<ffffe420>] _etext+0xf7dfe403/0x0

I must admit to not having figured out why the faulting process gets
stuck on sync_page() like it does. What I initially thought was that it
might be waiting to lock a page stuck in an elevator plug, however it
does look like sync_page() calls __generic_unplug_device() after some
indirection.

Also note that with all recorded lockups the free page count is larger
than the min watermark, and sometimes even larger than the high
watermark.

(These traces were obtained using UML, real machines give similar
results)

Other than this as of yet unexplained behaviour, the patch does make
sense in that:
 - IO scheduling is best done on the server end of NBD;
 - not coalescing requests keeps the memory needs constant.
   (without this change one very quickly ends up in the classical
    VM deadlock)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

---
 block/elevator.c       |    5 +++++
 block/ll_rw_blk.c      |   12 ++++++++++--
 drivers/block/nbd.c    |    7 ++++++-
 include/linux/blkdev.h |    9 +++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

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
Index: linux-2.6/drivers/block/nbd.c
===================================================================
--- linux-2.6.orig/drivers/block/nbd.c
+++ linux-2.6/drivers/block/nbd.c
@@ -625,11 +625,16 @@ static int __init nbd_init(void)
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
+		printk(KERN_ERR "elevator: cannot switch elevator, pinned\n");
+		return count;
+	}
+
 	elevator_name[sizeof(elevator_name) - 1] = '\0';
 	strncpy(elevator_name, name, sizeof(elevator_name) - 1);
 	len = strlen(elevator_name);


