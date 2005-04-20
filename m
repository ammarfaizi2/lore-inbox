Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVDTLnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDTLnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVDTLmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:42:11 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:16617 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261303AbVDTLlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:41:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=qCI1WTaHuWLgXl+y16xKY0SV3ziz3/UG9aDmssh9meunkY6gpjAskJxKg1LLkd/pzpUf5LUkAD0/ou0Q75mBS1QQlGw1H9YTrxkAXDPkq7Ov9xyDOHqqGqA/RWd+o6WTCi1u+8L/Y7ViwOG7p4/h1XwOJN5yOgfIkR4VajC/PFo=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050420114041.F2FA00DB@htj.dyndns.org>
In-Reply-To: <20050420114041.F2FA00DB@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc2 02/04] blk: remove blk_queue_tag->real_max_depth optimization
Message-ID: <20050420114041.83869E14@htj.dyndns.org>
Date: Wed, 20 Apr 2005 20:41:42 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_tag_map_remove_real_max_depth.patch

	blk_queue_tag->real_max_depth was used to optimize out
	unnecessary allocations/frees on tag resize.  However, the
	whole thing was very broken - tag_map was never allocated to
	real_max_depth resulting in access beyond the end of the map,
	bits in [max_depth..real_max_depth] were set when initializing
	a map and copied when resizing resulting in pre-occupied tags.

	As the gain of the optimization is very small, well, almost
	nill, remove the whole thing.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/block/ll_rw_blk.c |   35 ++++++++++-------------------------
 include/linux/blkdev.h    |    1 -
 2 files changed, 10 insertions(+), 26 deletions(-)

Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-04-20 20:36:36.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-04-20 20:36:37.000000000 +0900
@@ -716,7 +716,7 @@ struct request *blk_queue_find_tag(reque
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
-	if (unlikely(bqt == NULL || tag >= bqt->real_max_depth))
+	if (unlikely(bqt == NULL || tag >= bqt->max_depth))
 		return NULL;
 
 	return bqt->tag_index[tag];
@@ -774,9 +774,9 @@ EXPORT_SYMBOL(blk_queue_free_tags);
 static int
 init_tag_map(request_queue_t *q, struct blk_queue_tag *tags, int depth)
 {
-	int bits, i;
 	struct request **tag_index;
 	unsigned long *tag_map;
+	int nr_ulongs;
 
 	if (depth > q->nr_requests * 2) {
 		depth = q->nr_requests * 2;
@@ -788,24 +788,17 @@ init_tag_map(request_queue_t *q, struct 
 	if (!tag_index)
 		goto fail;
 
-	bits = (depth / BLK_TAGS_PER_LONG) + 1;
-	tag_map = kmalloc(bits * sizeof(unsigned long), GFP_ATOMIC);
+	nr_ulongs = ALIGN(depth, BLK_TAGS_PER_LONG) / BLK_TAGS_PER_LONG;
+	tag_map = kmalloc(nr_ulongs * sizeof(unsigned long), GFP_ATOMIC);
 	if (!tag_map)
 		goto fail;
 
 	memset(tag_index, 0, depth * sizeof(struct request *));
-	memset(tag_map, 0, bits * sizeof(unsigned long));
+	memset(tag_map, 0, nr_ulongs * sizeof(unsigned long));
 	tags->max_depth = depth;
-	tags->real_max_depth = bits * BITS_PER_LONG;
 	tags->tag_index = tag_index;
 	tags->tag_map = tag_map;
 
-	/*
-	 * set the upper bits if the depth isn't a multiple of the word size
-	 */
-	for (i = depth; i < bits * BLK_TAGS_PER_LONG; i++)
-		__set_bit(i, tag_map);
-
 	return 0;
 fail:
 	kfree(tag_index);
@@ -870,32 +863,24 @@ int blk_queue_resize_tags(request_queue_
 	struct blk_queue_tag *bqt = q->queue_tags;
 	struct request **tag_index;
 	unsigned long *tag_map;
-	int bits, max_depth;
+	int max_depth, nr_ulongs;
 
 	if (!bqt)
 		return -ENXIO;
 
 	/*
-	 * don't bother sizing down
-	 */
-	if (new_depth <= bqt->real_max_depth) {
-		bqt->max_depth = new_depth;
-		return 0;
-	}
-
-	/*
 	 * save the old state info, so we can copy it back
 	 */
 	tag_index = bqt->tag_index;
 	tag_map = bqt->tag_map;
-	max_depth = bqt->real_max_depth;
+	max_depth = bqt->max_depth;
 
 	if (init_tag_map(q, bqt, new_depth))
 		return -ENOMEM;
 
 	memcpy(bqt->tag_index, tag_index, max_depth * sizeof(struct request *));
-	bits = max_depth / BLK_TAGS_PER_LONG;
-	memcpy(bqt->tag_map, tag_map, bits * sizeof(unsigned long));
+	nr_ulongs = ALIGN(max_depth, BLK_TAGS_PER_LONG) / BLK_TAGS_PER_LONG;
+	memcpy(bqt->tag_map, tag_map, nr_ulongs * sizeof(unsigned long));
 
 	kfree(tag_index);
 	kfree(tag_map);
@@ -925,7 +910,7 @@ void blk_queue_end_tag(request_queue_t *
 
 	BUG_ON(tag == -1);
 
-	if (unlikely(tag >= bqt->real_max_depth))
+	if (unlikely(tag >= bqt->max_depth))
 		return;
 
 	if (unlikely(!__test_and_clear_bit(tag, bqt->tag_map))) {
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-04-20 20:36:35.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-04-20 20:36:37.000000000 +0900
@@ -294,7 +294,6 @@ struct blk_queue_tag {
 	struct list_head busy_list;	/* fifo list of busy tags */
 	int busy;			/* current depth */
 	int max_depth;			/* what we will send to device */
-	int real_max_depth;		/* what the array can hold */
 	atomic_t refcnt;		/* map can be shared */
 };
 

