Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSDXIyp>; Wed, 24 Apr 2002 04:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSDXIxA>; Wed, 24 Apr 2002 04:53:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44049 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293457AbSDXIwb>;
	Wed, 24 Apr 2002 04:52:31 -0400
Message-ID: <3CC6726B.767B5E3E@zip.com.au>
Date: Wed, 24 Apr 2002 01:52:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] remove buffer_head.b_inode
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Removal of buffer_head.b_inode.  The list_emptiness of b_inode_buffers
is used to indicate whether the buffer is on an inode's
i_dirty_buffers.


=====================================

--- 2.5.9/fs/buffer.c~cleanup-030-b_inode	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/buffer.c	Wed Apr 24 01:44:59 2002
@@ -416,9 +416,7 @@ void buffer_insert_list(spinlock_t *lock
 	if (lock == NULL)
 		lock = &global_bufferlist_lock;
 	spin_lock(lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = 1;
+	list_del(&bh->b_inode_buffers);
 	list_add(&bh->b_inode_buffers, list);
 	spin_unlock(lock);
 }
@@ -428,10 +426,7 @@ void buffer_insert_list(spinlock_t *lock
  */
 static inline void __remove_inode_queue(struct buffer_head *bh)
 {
-	if (bh->b_inode) {
-		list_del(&bh->b_inode_buffers);
-		bh->b_inode = 0;
-	}
+	list_del_init(&bh->b_inode_buffers);
 }
 
 int inode_has_buffers(struct inode *inode)
@@ -656,11 +651,8 @@ int fsync_buffers_list(spinlock_t *lock,
 	spin_lock(lock);
 	while (!list_empty(list)) {
 		bh = BH_ENTRY(list->next);
-		list_del(&bh->b_inode_buffers);
-		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = 0;
-		else {
-			bh->b_inode = 1;
+		list_del_init(&bh->b_inode_buffers);
+		if (buffer_dirty(bh) || buffer_locked(bh)) {
 			list_add(&bh->b_inode_buffers, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
@@ -2237,8 +2229,7 @@ EXPORT_SYMBOL(alloc_buffer_head);
 
 void free_buffer_head(struct buffer_head *bh)
 {
-	if (bh->b_inode)
-		BUG();
+	BUG_ON(!list_empty(&bh->b_inode_buffers));
 	mempool_free(bh, bh_mempool);
 }
 EXPORT_SYMBOL(free_buffer_head);
@@ -2253,6 +2244,7 @@ static void init_buffer_head(void *data,
 		bh->b_dev = B_FREE;
 		bh->b_bdev = NULL;
 		bh->b_blocknr = -1;
+		INIT_LIST_HEAD(&bh->b_inode_buffers);
 		init_waitqueue_head(&bh->b_wait);
 	}
 }
--- 2.5.9/include/linux/fs.h~cleanup-030-b_inode	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/include/linux/fs.h	Wed Apr 24 01:44:59 2002
@@ -257,7 +257,6 @@ struct buffer_head {
 
 	wait_queue_head_t b_wait;
 
-	int b_inode;				/* will go away */
 	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
 };
