Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264046AbTE0SKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTE0SJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:09:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29917 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263996AbTE0SIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:08:11 -0400
Date: Tue, 27 May 2003 20:21:26 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527182126.GO845@suse.de>
References: <1053972773.2298.177.camel@mulgrave> <20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave> <20030526190707.GM845@suse.de> <1053976644.2298.194.camel@mulgrave> <20030526193327.GN845@suse.de> <20030527123901.GJ845@suse.de> <1054045594.1769.24.camel@mulgrave> <20030527171605.GL845@suse.de> <1054058946.1769.223.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054058946.1769.223.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, James Bottomley wrote:
> On Tue, 2003-05-27 at 13:16, Jens Axboe wrote:
> > If you increase it again, the maps are resized. Is that a problem? Seems
> > ok to me.
> 
> What I mean is that you allocate memory whenever the depth increases. 
> Even if you have an array large enough to accommodate the increase
> (because you don't release when you decrease the tag depth).

Yes I know what you mean, but my question is if it's worth it to keep
track of? No memory is really lost, but we are doing a copy of tag map
and bitmap of course in addition to the extra allocation. Given that
you're not going to change depths 100 times per seconds, I don't think
it's worth it to actually do anything about it. Especially since you'll
quickly settle at the desired depth and stay there. But hey, I'm an
accomodating guy (pfft), so here's the change just for you :)

> On further examination, there's also an invalid tag race:  If a device
> is throttling, it might want to do a big decrease followed fairly
> quickly by a small increase.  When it does the increase, you potentially
> still have outstanding tags above the new depth, which will now run off
> the end of your newly allocated tag array.

Oh yes you are right. How does the attached look? With real_max_depth,
that should work as well since we'll only ever alloc a bigger area.

===== drivers/block/ll_rw_blk.c 1.170 vs edited =====
--- 1.170/drivers/block/ll_rw_blk.c	Thu May  8 11:30:11 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue May 27 20:21:00 2003
@@ -413,11 +413,12 @@
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
-	if (unlikely(bqt == NULL || bqt->max_depth < tag))
+	if (unlikely(bqt == NULL || tag >= bqt->real_max_depth))
 		return NULL;
 
 	return bqt->tag_index[tag];
 }
+
 /**
  * blk_queue_free_tags - release tag maintenance info
  * @q:  the request queue for the device
@@ -448,39 +449,28 @@
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
+	tags->real_max_depth = bits * BITS_PER_LONG;
 
 	/*
 	 * set the upper bits if the depth isn't a multiple of the word size
@@ -488,22 +478,89 @@
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
+	if (new_depth <= bqt->real_max_depth) {
+		bqt->max_depth = new_depth;
+		return 0;
+	}
+
+	/*
+	 * save the old state info, so we can copy it back
+	 */
+	tag_index = bqt->tag_index;
+	tag_map = bqt->tag_map;
+	max_depth = bqt->real_max_depth;
+
+	if (init_tag_map(bqt, new_depth))
+		return -ENOMEM;
+
+	memcpy(bqt->tag_index, tag_index, max_depth * sizeof(struct request *));
+	bits = max_depth / BLK_TAGS_PER_LONG;
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
@@ -524,7 +581,7 @@
 
 	BUG_ON(tag == -1);
 
-	if (unlikely(tag >= bqt->max_depth))
+	if (unlikely(tag >= bqt->real_max_depth))
 		return;
 
 	if (unlikely(!__test_and_clear_bit(tag, bqt->tag_map))) {
===== include/linux/blkdev.h 1.105 vs edited =====
--- 1.105/include/linux/blkdev.h	Thu May  8 11:30:11 2003
+++ edited/include/linux/blkdev.h	Tue May 27 20:15:31 2003
@@ -179,7 +179,8 @@
 	unsigned long *tag_map;		/* bit map of free/busy tags */
 	struct list_head busy_list;	/* fifo list of busy tags */
 	int busy;			/* current depth */
-	int max_depth;
+	int max_depth;			/* what we will send to device */
+	int real_max_depth;		/* what the array can hold */
 };
 
 struct request_queue
@@ -452,6 +453,7 @@
 extern void blk_queue_end_tag(request_queue_t *, struct request *);
 extern int blk_queue_init_tags(request_queue_t *, int);
 extern void blk_queue_free_tags(request_queue_t *);
+extern int blk_queue_resize_tags(request_queue_t *, int);
 extern void blk_queue_invalidate_tags(request_queue_t *);
 extern void blk_congestion_wait(int rw, long timeout);
 

-- 
Jens Axboe

