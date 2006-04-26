Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWDZCLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWDZCLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWDZCLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:11:24 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:9356 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932344AbWDZCLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:11:23 -0400
Message-Id: <20060426021121.260553000@localhost.localdomain>
References: <20060426021059.235216000@localhost.localdomain>
Date: Wed, 26 Apr 2006 10:11:00 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>,
       Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>
Subject: [patch 1/3] use kref for blk_queue_tag
Content-Disposition: inline; filename=blk-queue-tag-use-kref.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kref for reference counter of blk_queue_tag.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
CC: Jens Axboe <axboe@suse.de>
CC: Greg KH <greg@kroah.com>

 block/ll_rw_blk.c      |   35 ++++++++++++++++++++---------------
 include/linux/blkdev.h |    2 +-
 2 files changed, 21 insertions(+), 16 deletions(-)

Index: 2.6-git/block/ll_rw_blk.c
===================================================================
--- 2.6-git.orig/block/ll_rw_blk.c
+++ 2.6-git/block/ll_rw_blk.c
@@ -848,6 +848,23 @@ struct request *blk_queue_find_tag(reque
 
 EXPORT_SYMBOL(blk_queue_find_tag);
 
+static void release_blk_queue_tag(struct kref *kref)
+{
+	struct blk_queue_tag *bqt = container_of(kref, struct blk_queue_tag,
+			kref);
+
+	BUG_ON(bqt->busy);
+	BUG_ON(!list_empty(&bqt->busy_list));
+
+	kfree(bqt->tag_index);
+	bqt->tag_index = NULL;
+
+	kfree(bqt->tag_map);
+	bqt->tag_map = NULL;
+
+	kfree(bqt);
+}
+
 /**
  * __blk_queue_free_tags - release tag maintenance info
  * @q:  the request queue for the device
@@ -863,19 +880,7 @@ static void __blk_queue_free_tags(reques
 	if (!bqt)
 		return;
 
-	if (atomic_dec_and_test(&bqt->refcnt)) {
-		BUG_ON(bqt->busy);
-		BUG_ON(!list_empty(&bqt->busy_list));
-
-		kfree(bqt->tag_index);
-		bqt->tag_index = NULL;
-
-		kfree(bqt->tag_map);
-		bqt->tag_map = NULL;
-
-		kfree(bqt);
-	}
-
+	kref_put(&bqt->kref, release_blk_queue_tag);
 	q->queue_tags = NULL;
 	q->queue_flags &= ~(1 << QUEUE_FLAG_QUEUED);
 }
@@ -951,14 +956,14 @@ int blk_queue_init_tags(request_queue_t 
 
 		INIT_LIST_HEAD(&tags->busy_list);
 		tags->busy = 0;
-		atomic_set(&tags->refcnt, 1);
+		kref_init(&tags->kref);
 	} else if (q->queue_tags) {
 		if ((rc = blk_queue_resize_tags(q, depth)))
 			return rc;
 		set_bit(QUEUE_FLAG_QUEUED, &q->queue_flags);
 		return 0;
 	} else
-		atomic_inc(&tags->refcnt);
+		kref_get(&tags->kref);
 
 	/*
 	 * assign it, all done
Index: 2.6-git/include/linux/blkdev.h
===================================================================
--- 2.6-git.orig/include/linux/blkdev.h
+++ 2.6-git/include/linux/blkdev.h
@@ -315,7 +315,7 @@ struct blk_queue_tag {
 	int busy;			/* current depth */
 	int max_depth;			/* what we will send to device */
 	int real_max_depth;		/* what the array can hold */
-	atomic_t refcnt;		/* map can be shared */
+	struct kref kref;		/* map can be shared */
 };
 
 struct request_queue

--
