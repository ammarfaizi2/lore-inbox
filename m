Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTE0MZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTE0MZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:25:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263441AbTE0MZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:25:47 -0400
Date: Tue, 27 May 2003 14:39:01 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527123901.GJ845@suse.de>
References: <1053972773.2298.177.camel@mulgrave> <20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave> <20030526190707.GM845@suse.de> <1053976644.2298.194.camel@mulgrave> <20030526193327.GN845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526193327.GN845@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, Jens Axboe wrote:
> On Mon, May 26 2003, James Bottomley wrote:
> > On Mon, 2003-05-26 at 15:07, Jens Axboe wrote:
> > > Alright, so what do you need? Start out with X tags, shrink to Y (based
> > > on repeated queue full conditions)? Anything else?
> > 
> > Actually, it's easier than that: just an API to alter the number of tags
> > in the block layer (really only the size of your internal hash table). 
> > The actual heuristics of when to alter the queue depth is the province
> > of the individual drivers (although Doug Ledford was going to come up
> > with a generic implementation).
> 
> That's actually what I meant, that the SCSI layer would call down into
> the block layer to set the size. I don't/want to know about queue full
> conditions.
> 
> The internal memory requirements for the queue table is small (a bit per
> tag), so I think we can basically get away with just decrementing
> ->max_depth.

James, something like this would be enough then (untested, compiles)?

===== drivers/block/ll_rw_blk.c 1.170 vs edited =====
--- 1.170/drivers/block/ll_rw_blk.c	Thu May  8 11:30:11 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue May 27 14:37:20 2003
@@ -413,11 +413,12 @@
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
-	if (unlikely(bqt == NULL || bqt->max_depth < tag))
+	if (unlikely(bqt == NULL))
 		return NULL;
 
 	return bqt->tag_index[tag];
 }
+
 /**
  * blk_queue_free_tags - release tag maintenance info
  * @q:  the request queue for the device
@@ -448,38 +449,26 @@
 	q->queue_flags &= ~(1 << QUEUE_FLAG_QUEUED);
 }
 
-/**
- * blk_queue_init_tags - initialize the queue tag info
- * @q:  the request queue for the device
- * @depth:  the maximum queue depth supported
- **/
-int blk_queue_init_tags(request_queue_t *q, int depth)
+static int init_tag_map(struct blk_queue_tag *tags, int depth)
 {
-	struct blk_queue_tag *tags;
 	int bits, i;
 
 	if (depth > (queue_nr_requests*2)) {
 		depth = (queue_nr_requests*2);
-		printk("blk_queue_init_tags: adjusted depth to %d\n", depth);
+		printk(KERN_ERR "%s: adjusted depth to %d\n", __FUNCTION__, depth);
 	}
 
-	tags = kmalloc(sizeof(struct blk_queue_tag),GFP_ATOMIC);
-	if (!tags)
-		goto fail;
-
 	tags->tag_index = kmalloc(depth * sizeof(struct request *), GFP_ATOMIC);
 	if (!tags->tag_index)
-		goto fail_index;
+		goto fail;
 
 	bits = (depth / BLK_TAGS_PER_LONG) + 1;
 	tags->tag_map = kmalloc(bits * sizeof(unsigned long), GFP_ATOMIC);
 	if (!tags->tag_map)
-		goto fail_map;
+		goto fail;
 
 	memset(tags->tag_index, 0, depth * sizeof(struct request *));
 	memset(tags->tag_map, 0, bits * sizeof(unsigned long));
-	INIT_LIST_HEAD(&tags->busy_list);
-	tags->busy = 0;
 	tags->max_depth = depth;
 
 	/*
@@ -488,22 +477,89 @@
 	for (i = depth; i < bits * BLK_TAGS_PER_LONG; i++)
 		__set_bit(i, tags->tag_map);
 
+	return 0;
+fail:
+	kfree(tags->tag_index);
+	return -ENOMEM;
+}
+
+
+/**
+ * blk_queue_init_tags - initialize the queue tag info
+ * @q:  the request queue for the device
+ * @depth:  the maximum queue depth supported
+ **/
+int blk_queue_init_tags(request_queue_t *q, int depth)
+{
+	struct blk_queue_tag *tags;
+
+	tags = kmalloc(sizeof(struct blk_queue_tag),GFP_ATOMIC);
+	if (!tags)
+		goto fail;
+
+	if (init_tag_map(tags, depth))
+		goto fail;
+
+	INIT_LIST_HEAD(&tags->busy_list);
+	tags->busy = 0;
+
 	/*
 	 * assign it, all done
 	 */
 	q->queue_tags = tags;
 	q->queue_flags |= (1 << QUEUE_FLAG_QUEUED);
 	return 0;
-
-fail_map:
-	kfree(tags->tag_index);
-fail_index:
-	kfree(tags);
 fail:
+	kfree(tags);
 	return -ENOMEM;
 }
 
 /**
+ * blk_queue_resize_tags - change the queueing depth
+ * @q:  the request queue for the device
+ * @new_depth: the new max command queueing depth
+ *
+ *  Notes:
+ *    Must be called with the queue lock held.
+ **/
+int blk_queue_resize_tags(request_queue_t *q, int new_depth)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+	struct request **tag_index;
+	unsigned long *tag_map;
+	int bits, max_depth;
+
+	if (!bqt)
+		return -ENXIO;
+
+	/*
+	 * don't bother sizing down
+	 */
+	if (new_depth <= bqt->max_depth) {
+		bqt->max_depth = new_depth;
+		return 0;
+	}
+
+	/*
+	 * save the old state info, so we can copy it back
+	 */
+	tag_index = bqt->tag_index;
+	tag_map = bqt->tag_map;
+	max_depth = bqt->max_depth;
+
+	if (init_tag_map(bqt, new_depth))
+		return -ENOMEM;
+
+	memcpy(bqt->tag_index, tag_index, max_depth * sizeof(struct request *));
+	bits = (max_depth / BLK_TAGS_PER_LONG) + 1;
+	memcpy(bqt->tag_map, bqt->tag_map, bits * sizeof(unsigned long));
+
+	kfree(tag_index);
+	kfree(tag_map);
+	return 0;
+}
+
+/**
  * blk_queue_end_tag - end tag operations for a request
  * @q:  the request queue for the device
  * @tag:  the tag that has completed
@@ -523,9 +579,6 @@
 	int tag = rq->tag;
 
 	BUG_ON(tag == -1);
-
-	if (unlikely(tag >= bqt->max_depth))
-		return;
 
 	if (unlikely(!__test_and_clear_bit(tag, bqt->tag_map))) {
 		printk("attempt to clear non-busy tag (%d)\n", tag);
===== include/linux/blkdev.h 1.105 vs edited =====
--- 1.105/include/linux/blkdev.h	Thu May  8 11:30:11 2003
+++ edited/include/linux/blkdev.h	Tue May 27 12:36:53 2003
@@ -452,6 +452,7 @@
 extern void blk_queue_end_tag(request_queue_t *, struct request *);
 extern int blk_queue_init_tags(request_queue_t *, int);
 extern void blk_queue_free_tags(request_queue_t *);
+extern int blk_queue_resize_tags(request_queue_t *, int);
 extern void blk_queue_invalidate_tags(request_queue_t *);
 extern void blk_congestion_wait(int rw, long timeout);
 

-- 
Jens Axboe

