Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUHIPyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUHIPyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUHIPwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:52:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17100 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266717AbUHIPuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:50:22 -0400
Message-Id: <200408091550.i79FoDat359564@westrelay02.boulder.ibm.com>
Subject: [PATCH 2/2] blk_queue_tags_resize_failure
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Mon, 09 Aug 2004 10:50:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes blk_queue_resize_tags to properly handle allocation failures. Currently,
if a memory allocation failure occurs during blk_queue_resize_tags, the tag map
ends up getting freed, which should not happen. The old tag map should be preserved
and only the resize should fail.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.8-rc3-bjking1/drivers/block/ll_rw_blk.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~blk_queue_tags_resize_failure drivers/block/ll_rw_blk.c
--- linux-2.6.8-rc3/drivers/block/ll_rw_blk.c~blk_queue_tags_resize_failure	2004-08-09 10:26:38.000000000 -0500
+++ linux-2.6.8-rc3-bjking1/drivers/block/ll_rw_blk.c	2004-08-09 10:29:30.000000000 -0500
@@ -532,6 +532,8 @@ static int
 init_tag_map(request_queue_t *q, struct blk_queue_tag *tags, int depth)
 {
 	int bits, i;
+	struct request **tag_index;
+	unsigned long *tag_map;
 
 	if (depth > q->nr_requests * 2) {
 		depth = q->nr_requests * 2;
@@ -539,29 +541,31 @@ init_tag_map(request_queue_t *q, struct 
 				__FUNCTION__, depth);
 	}
 
-	tags->tag_index = kmalloc(depth * sizeof(struct request *), GFP_ATOMIC);
-	if (!tags->tag_index)
+	tag_index = kmalloc(depth * sizeof(struct request *), GFP_ATOMIC);
+	if (!tag_index)
 		goto fail;
 
 	bits = (depth / BLK_TAGS_PER_LONG) + 1;
-	tags->tag_map = kmalloc(bits * sizeof(unsigned long), GFP_ATOMIC);
-	if (!tags->tag_map)
+	tag_map = kmalloc(bits * sizeof(unsigned long), GFP_ATOMIC);
+	if (!tag_map)
 		goto fail;
 
-	memset(tags->tag_index, 0, depth * sizeof(struct request *));
-	memset(tags->tag_map, 0, bits * sizeof(unsigned long));
+	memset(tag_index, 0, depth * sizeof(struct request *));
+	memset(tag_map, 0, bits * sizeof(unsigned long));
 	tags->max_depth = depth;
 	tags->real_max_depth = bits * BITS_PER_LONG;
+	tags->tag_index = tag_index;
+	tags->tag_map = tag_map;
 
 	/*
 	 * set the upper bits if the depth isn't a multiple of the word size
 	 */
 	for (i = depth; i < bits * BLK_TAGS_PER_LONG; i++)
-		__set_bit(i, tags->tag_map);
+		__set_bit(i, tag_map);
 
 	return 0;
 fail:
-	kfree(tags->tag_index);
+	kfree(tag_index);
 	return -ENOMEM;
 }
 
_
