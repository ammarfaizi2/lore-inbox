Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282348AbRK2Djz>; Wed, 28 Nov 2001 22:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282343AbRK2Djs>; Wed, 28 Nov 2001 22:39:48 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:17169 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282348AbRK2Dji>; Wed, 28 Nov 2001 22:39:38 -0500
Message-ID: <3C05ADC8.23503BFC@zip.com.au>
Date: Wed, 28 Nov 2001 19:38:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] remove buffer_head.b_inode
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's only ever used as a boolean, so we can use the list_emptiness
of buffer_head.b_inode_buffers for the same thing.

This code does assume that a list_del on an empty list_head
is safe - I think Red Hat kernels have a list_head poisoning
trick which will explode over this.  Easily fixed, if desired.



--- linux-2.5.1-pre3/fs/buffer.c	Wed Nov 28 15:54:42 2001
+++ 25/fs/buffer.c	Wed Nov 28 19:26:19 2001
@@ -574,38 +574,32 @@ struct buffer_head * get_hash_table(kdev
 	return bh;
 }
 
-void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
+static inline void
+__buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
 {
-	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
+	list_del(&bh->b_inode_buffers);
 	list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
-	spin_unlock(&lru_list_lock);
 }
 
-void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
+void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
 {
 	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
+	__buffer_insert_inode_queue(bh, inode);
 	spin_unlock(&lru_list_lock);
 }
 
-/* The caller must have the lru_list lock before calling the 
-   remove_inode_queue functions.  */
-static void __remove_inode_queue(struct buffer_head *bh)
+void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
 {
-	bh->b_inode = NULL;
+	spin_lock(&lru_list_lock);
 	list_del(&bh->b_inode_buffers);
+	list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
+	spin_unlock(&lru_list_lock);
 }
 
-static inline void remove_inode_queue(struct buffer_head *bh)
+/* lru_list_lock must be held */
+static inline void __remove_inode_queue(struct buffer_head *bh)
 {
-	if (bh->b_inode)
-		__remove_inode_queue(bh);
+	list_del_init(&bh->b_inode_buffers);
 }
 
 int inode_has_buffers(struct inode *inode)
@@ -690,7 +684,7 @@ void invalidate_bdev(struct block_device
 				printk("invalidate: dirty buffer\n");
 			if (!atomic_read(&bh->b_count)) {
 				if (destroy_dirty_buffers || !buffer_dirty(bh)) {
-					remove_inode_queue(bh);
+					__remove_inode_queue(bh);
 				}
 			} else
 				printk("invalidate: busy buffer\n");
@@ -831,12 +825,9 @@ int fsync_inode_buffers(struct inode *in
 
 	while (!list_empty(&inode->i_dirty_buffers)) {
 		bh = BH_ENTRY(inode->i_dirty_buffers.next);
-		list_del(&bh->b_inode_buffers);
-		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = NULL;
-		else {
-			bh->b_inode = &tmp;
-			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
+		__remove_inode_queue(bh);
+		if (buffer_dirty(bh) || buffer_locked(bh)) {
+			__buffer_insert_inode_queue(bh, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(&lru_list_lock);
@@ -849,7 +840,7 @@ int fsync_inode_buffers(struct inode *in
 
 	while (!list_empty(&tmp.i_dirty_buffers)) {
 		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
-		remove_inode_queue(bh);
+		__remove_inode_queue(bh);
 		get_bh(bh);
 		spin_unlock(&lru_list_lock);
 		wait_on_buffer(bh);
@@ -880,12 +871,9 @@ int fsync_inode_data_buffers(struct inod
 
 	while (!list_empty(&inode->i_dirty_data_buffers)) {
 		bh = BH_ENTRY(inode->i_dirty_data_buffers.next);
-		list_del(&bh->b_inode_buffers);
-		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = NULL;
-		else {
-			bh->b_inode = &tmp;
-			list_add(&bh->b_inode_buffers, &tmp.i_dirty_data_buffers);
+		__remove_inode_queue(bh);
+		if (buffer_dirty(bh) || buffer_locked(bh)) {
+			__buffer_insert_inode_queue(bh, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(&lru_list_lock);
@@ -898,7 +886,7 @@ int fsync_inode_data_buffers(struct inod
 
 	while (!list_empty(&tmp.i_dirty_data_buffers)) {
 		bh = BH_ENTRY(tmp.i_dirty_data_buffers.prev);
-		remove_inode_queue(bh);
+		__remove_inode_queue(bh);
 		get_bh(bh);
 		spin_unlock(&lru_list_lock);
 		wait_on_buffer(bh);
@@ -998,9 +986,9 @@ void invalidate_inode_buffers(struct ino
 	
 	spin_lock(&lru_list_lock);
 	while ((entry = inode->i_dirty_buffers.next) != &inode->i_dirty_buffers)
-		remove_inode_queue(BH_ENTRY(entry));
+		__remove_inode_queue(BH_ENTRY(entry));
 	while ((entry = inode->i_dirty_data_buffers.next) != &inode->i_dirty_data_buffers)
-		remove_inode_queue(BH_ENTRY(entry));
+		__remove_inode_queue(BH_ENTRY(entry));
 	spin_unlock(&lru_list_lock);
 }
 
@@ -1126,7 +1114,7 @@ static void __refile_buffer(struct buffe
 		__remove_from_lru_list(bh);
 		bh->b_list = dispose;
 		if (dispose == BUF_CLEAN)
-			remove_inode_queue(bh);
+			__remove_inode_queue(bh);
 		__insert_into_lru_list(bh, dispose);
 	}
 }
@@ -1189,7 +1177,7 @@ struct buffer_head * bread(kdev_t dev, i
  */
 static void __put_unused_buffer_head(struct buffer_head * bh)
 {
-	if (bh->b_inode)
+	if (!list_empty(&bh->b_inode_buffers))
 		BUG();
 	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
 		kmem_cache_free(bh_cachep, bh);
@@ -1219,7 +1207,7 @@ EXPORT_SYMBOL(put_unused_buffer_head);
  */ 
 struct buffer_head * get_unused_buffer_head(int async)
 {
-	struct buffer_head * bh;
+	struct buffer_head *bh;
 
 	spin_lock(&unused_list_lock);
 	if (nr_unused_buffer_heads > NR_RESERVED) {
@@ -1227,7 +1215,7 @@ struct buffer_head * get_unused_buffer_h
 		unused_list = bh->b_next_free;
 		nr_unused_buffer_heads--;
 		spin_unlock(&unused_list_lock);
-		return bh;
+		goto ret_bh;
 	}
 	spin_unlock(&unused_list_lock);
 
@@ -1238,7 +1226,7 @@ struct buffer_head * get_unused_buffer_h
 	if((bh = kmem_cache_alloc(bh_cachep, SLAB_NOFS)) != NULL) {
 		bh->b_blocknr = -1;
 		bh->b_this_page = NULL;
-		return bh;
+		goto ret_bh;
 	}
 
 	/*
@@ -1251,12 +1239,15 @@ struct buffer_head * get_unused_buffer_h
 			unused_list = bh->b_next_free;
 			nr_unused_buffer_heads--;
 			spin_unlock(&unused_list_lock);
-			return bh;
+			goto ret_bh;
 		}
 		spin_unlock(&unused_list_lock);
 	}
 
 	return NULL;
+ret_bh:
+	INIT_LIST_HEAD(&bh->b_inode_buffers);
+	return bh;
 }
 EXPORT_SYMBOL(get_unused_buffer_head);
 
@@ -2390,7 +2381,7 @@ cleaned_buffers_try_again:
 
 		if (p->b_dev == B_FREE) BUG();
 
-		remove_inode_queue(p);
+		__remove_inode_queue(p);
 		__remove_from_queues(p);
 		__put_unused_buffer_head(p);
 	} while (tmp != bh);
--- linux-2.5.1-pre3/include/linux/fs.h	Wed Nov 28 15:54:42 2001
+++ 25/include/linux/fs.h	Wed Nov 28 19:26:19 2001
@@ -261,8 +261,9 @@ struct buffer_head {
 
 	wait_queue_head_t b_wait;
 
-	struct inode *	     b_inode;
-	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
+	/* Dirty buffers against an inode.  Must be in list_empty()
+	 * state when this buffer is not on an inode's i_dirty_buffers */
+	struct list_head     b_inode_buffers;
 };
 
 typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
