Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUHIUDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUHIUDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUHIUCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:02:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48621 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267170AbUHIUBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:01:18 -0400
Message-Id: <200408092001.i79K16Rl123258@westrelay04.boulder.ibm.com>
Subject: [PATCH 2/3] blk_resize_tags_fix
To: akpm@osdl.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Mon, 09 Aug 2004 15:01:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


init_tag_map should not initialize the busy_list, refcnt, or busy fields
in the tag map since blk_queue_resize_tags can call it while requests are
active. Patch moves this initialization into blk_queue_init_tags.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.8-rc3-mm2-bjking1/drivers/block/ll_rw_blk.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~blk_resize_tags_fix drivers/block/ll_rw_blk.c
--- linux-2.6.8-rc3-mm2/drivers/block/ll_rw_blk.c~blk_resize_tags_fix	2004-08-09 14:51:40.000000000 -0500
+++ linux-2.6.8-rc3-mm2-bjking1/drivers/block/ll_rw_blk.c	2004-08-09 14:51:40.000000000 -0500
@@ -598,9 +598,6 @@ init_tag_map(request_queue_t *q, struct 
 	for (i = depth; i < bits * BLK_TAGS_PER_LONG; i++)
 		__set_bit(i, tags->tag_map);
 
-	INIT_LIST_HEAD(&tags->busy_list);
-	tags->busy = 0;
-	atomic_set(&tags->refcnt, 1);
 	return 0;
 fail:
 	kfree(tags->tag_index);
@@ -626,6 +623,10 @@ int blk_queue_init_tags(request_queue_t 
 
 		if (init_tag_map(q, tags, depth))
 			goto fail;
+
+		INIT_LIST_HEAD(&tags->busy_list);
+		tags->busy = 0;
+		atomic_set(&tags->refcnt, 1);
 	} else if (q->queue_tags) {
 		if ((rc = blk_queue_resize_tags(q, depth)))
 			return rc;
_
