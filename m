Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSHYSZE>; Sun, 25 Aug 2002 14:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSHYSZE>; Sun, 25 Aug 2002 14:25:04 -0400
Received: from verein.lst.de ([212.34.181.86]:32774 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S317462AbSHYSZB>;
	Sun, 25 Aug 2002 14:25:01 -0400
Date: Sun, 25 Aug 2002 20:29:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove b_inode & assorted cleanups
Message-ID: <20020825202906.A2685@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The b_inode field of struct buffer head is only ever used as boolean
flag, so we don't need a full pointer for it.  Replace it by a
BH_Attached bit in b_flags.

This allows some other cleanups: buffer_insert_inode_queue() and
buffer_insert_inode_data_queue() are replaced by a new routine,
buffer_insert_list() that operates on a struct list_head instead
of a full inode, allowing the fake inode in reiserfs' journal to
be removed.  Inline wrapper for the old functions are provided.
fsync_buffers_list() doesn't need an inode on the stack anymore,
we can use a simple list_head instead.

In addition to the cleanups this shrinks struct buffer_head by
4/8 bytes and thus makes place for the filesystem-private pointer
that will be needed for ext3/lvm2 interaction very soon.

A similar cleanup went into early 2.5, but current 2.5 doesn't have
an b_inode equivalent anymore at all.


diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/buffer.c linux/fs/buffer.c
--- linux-2.4.20-pre4/fs/buffer.c	Tue Aug 13 15:56:00 2002
+++ linux/fs/buffer.c	Sun Aug 25 19:28:55 2002
@@ -583,37 +583,29 @@ struct buffer_head * get_hash_table(kdev
 	return bh;
 }
 
-void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
+void buffer_insert_list(struct buffer_head *bh, struct list_head *list)
 {
 	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
+	if (buffer_attached(bh))
 		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
+	set_buffer_attached(bh);
+	list_add(&bh->b_inode_buffers, list);
 	spin_unlock(&lru_list_lock);
 }
 
-void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
-{
-	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
-	spin_unlock(&lru_list_lock);
-}
-
-/* The caller must have the lru_list lock before calling the 
-   remove_inode_queue functions.  */
+/*
+ * The caller must have the lru_list lock before calling the 
+ * remove_inode_queue functions.
+ */
 static void __remove_inode_queue(struct buffer_head *bh)
 {
-	bh->b_inode = NULL;
 	list_del(&bh->b_inode_buffers);
+	clear_buffer_attached(bh);
 }
 
 static inline void remove_inode_queue(struct buffer_head *bh)
 {
-	if (bh->b_inode)
+	if (buffer_attached(bh))
 		__remove_inode_queue(bh);
 }
 
@@ -827,10 +819,10 @@ inline void set_buffer_async_io(struct b
 int fsync_buffers_list(struct list_head *list)
 {
 	struct buffer_head *bh;
-	struct inode tmp;
+	struct list_head tmp;
 	int err = 0, err2;
 	
-	INIT_LIST_HEAD(&tmp.i_dirty_buffers);
+	INIT_LIST_HEAD(&tmp);
 	
 	spin_lock(&lru_list_lock);
 
@@ -838,10 +830,10 @@ int fsync_buffers_list(struct list_head 
 		bh = BH_ENTRY(list->next);
 		list_del(&bh->b_inode_buffers);
 		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = NULL;
+			clear_buffer_attached(bh);
 		else {
-			bh->b_inode = &tmp;
-			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
+			set_buffer_attached(bh);
+			list_add(&bh->b_inode_buffers, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(&lru_list_lock);
@@ -861,8 +853,8 @@ int fsync_buffers_list(struct list_head 
 		}
 	}
 
-	while (!list_empty(&tmp.i_dirty_buffers)) {
-		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
+	while (!list_empty(&tmp)) {
+		bh = BH_ENTRY(tmp.prev);
 		remove_inode_queue(bh);
 		get_bh(bh);
 		spin_unlock(&lru_list_lock);
@@ -1134,7 +1126,7 @@ struct buffer_head * bread(kdev_t dev, i
  */
 static void __put_unused_buffer_head(struct buffer_head * bh)
 {
-	if (bh->b_inode)
+	if (unlikely(buffer_attached(bh)))
 		BUG();
 	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
 		kmem_cache_free(bh_cachep, bh);
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
--- linux-2.4.20-pre4/fs/reiserfs/inode.c	Tue Aug 13 15:56:01 2002
+++ linux/fs/reiserfs/inode.c	Tue Aug 20 11:39:48 2002
@@ -102,9 +102,9 @@ inline void make_le_item_head (struct it
 }
 
 static void add_to_flushlist(struct inode *inode, struct buffer_head *bh) {
-    struct inode *jinode = &(SB_JOURNAL(inode->i_sb)->j_dummy_inode) ;
+    struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb) ;
 
-    buffer_insert_inode_queue(bh, jinode) ;
+    buffer_insert_list(bh, &j->j_dirty_buffers) ;
 }
 
 //
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/reiserfs/journal.c linux/fs/reiserfs/journal.c
--- linux-2.4.20-pre4/fs/reiserfs/journal.c	Sat Aug 17 14:54:39 2002
+++ linux/fs/reiserfs/journal.c	Tue Aug 20 11:39:48 2002
@@ -1937,7 +1937,7 @@ int journal_init(struct super_block *p_s
   memset(journal_writers, 0, sizeof(char *) * 512) ; /* debug code */
 
   INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
-  INIT_LIST_HEAD(&(SB_JOURNAL(p_s_sb)->j_dummy_inode.i_dirty_buffers)) ;
+  INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_dirty_buffers) ;
   reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
                                  SB_BMAP_NR(p_s_sb)) ;
   allocate_bitmap_nodes(p_s_sb) ;
@@ -2933,7 +2933,7 @@ printk("journal-2020: do_journal_end: BA
   SB_JOURNAL_LIST_INDEX(p_s_sb) = jindex ;
 
   /* write any buffers that must hit disk before this commit is done */
-  fsync_inode_buffers(&(SB_JOURNAL(p_s_sb)->j_dummy_inode)) ;
+  fsync_buffers_list(&(SB_JOURNAL(p_s_sb)->j_dirty_buffers)) ;
 
   /* honor the flush and async wishes from the caller */
   if (flush) {
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.20-pre4/include/linux/fs.h	Tue Aug 20 11:37:00 2002
+++ linux/include/linux/fs.h	Sun Aug 25 19:20:22 2002
@@ -219,6 +219,7 @@ enum bh_state_bits {
 	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
 	BH_Launder,	/* 1 if we can throttle on this buffer */
+	BH_Attached,	/* 1 if b_inode_buffers is linked into a list */
 	BH_JBD,		/* 1 if it has an attached journal_head */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
@@ -266,7 +267,6 @@ struct buffer_head {
 	unsigned long b_rsector;	/* Real buffer location on disk */
 	wait_queue_head_t b_wait;
 
-	struct inode *	     b_inode;
 	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
 };
 
@@ -1167,8 +1167,18 @@ static inline void mark_buffer_clean(str
 extern void FASTCALL(__mark_dirty(struct buffer_head *bh));
 extern void FASTCALL(__mark_buffer_dirty(struct buffer_head *bh));
 extern void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
-extern void FASTCALL(buffer_insert_inode_queue(struct buffer_head *, struct inode *));
-extern void FASTCALL(buffer_insert_inode_data_queue(struct buffer_head *, struct inode *));
+
+extern void FASTCALL(buffer_insert_list(struct buffer_head *, struct list_head *));
+
+static inline void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
+{
+	buffer_insert_list(bh, &inode->i_dirty_buffers);
+}
+
+static inline void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
+{
+	buffer_insert_list(bh, &inode->i_dirty_data_buffers);
+}
 
 static inline int atomic_set_buffer_dirty(struct buffer_head *bh)
 {
@@ -1183,6 +1193,21 @@ static inline void mark_buffer_async(str
 		clear_bit(BH_Async, &bh->b_state);
 }
 
+static inline void set_buffer_attached(struct buffer_head *bh)
+{
+	__set_bit(BH_Attached, &bh->b_state);
+}
+
+static inline void clear_buffer_attached(struct buffer_head *bh)
+{
+	clear_bit(BH_Attached, &bh->b_state);
+}
+
+static inline int buffer_attached(struct buffer_head *bh)
+{
+	return test_bit(BH_Attached, &bh->b_state);
+}
+
 /*
  * If an error happens during the make_request, this function
  * has to be recalled. It marks the buffer as clean and not
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/include/linux/reiserfs_fs_sb.h linux/include/linux/reiserfs_fs_sb.h
--- linux-2.4.20-pre4/include/linux/reiserfs_fs_sb.h	Tue Aug 13 15:56:04 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Tue Aug 20 15:26:38 2002
@@ -312,7 +312,7 @@ struct reiserfs_journal {
   int j_free_bitmap_nodes ;
   int j_used_bitmap_nodes ;
   struct list_head j_bitmap_nodes ;
-  struct inode j_dummy_inode ;
+  struct list_head j_dirty_buffers ;
   struct reiserfs_list_bitmap j_list_bitmap[JOURNAL_NUM_BITMAPS] ;	/* array of bitmaps to record the deleted blocks */
   struct reiserfs_journal_list j_journal_list[JOURNAL_LIST_COUNT] ;	    /* array of all the journal lists */
   struct reiserfs_journal_cnode *j_hash_table[JOURNAL_HASH_SIZE] ; 	    /* hash table for real buffer heads in current trans */ 
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.20-pre4/kernel/ksyms.c	Tue Aug 13 15:56:05 2002
+++ linux/kernel/ksyms.c	Sun Aug 25 19:32:04 2002
@@ -525,8 +527,7 @@ EXPORT_SYMBOL(get_hash_table);
 EXPORT_SYMBOL(get_empty_inode);
 EXPORT_SYMBOL(insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
-EXPORT_SYMBOL(buffer_insert_inode_queue);
-EXPORT_SYMBOL(buffer_insert_inode_data_queue);
+EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
