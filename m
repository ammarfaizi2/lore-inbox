Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSHMPHU>; Tue, 13 Aug 2002 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSHMPGr>; Tue, 13 Aug 2002 11:06:47 -0400
Received: from verein.lst.de ([212.34.181.86]:36875 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S315708AbSHMPGh>;
	Tue, 13 Aug 2002 11:06:37 -0400
Date: Tue, 13 Aug 2002 17:10:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] simplify b_inode usage
Message-ID: <20020813171024.A4365@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current the b_inode of struct buffer_head is a pointer to an inode, but
it only always used as bool value.  This patch changes it to an simple
int (yes, I know some people have ideas for a flag that uses less space,
but that can be easily done ontop of this cleanup).  The advantage is
that we don't have to pass in the inode into buffer_insert_inode_queue/
buffer_insert_inode_data_queue and can merge them into a more general
buffer_insert_list, with inline wrappers around it.  reiserfs can now
use buffer_insert_list directly and embedd a simple list_head instead
of a full static inode into it's journal.

A similar cleanup has already been done in early 2.5, but the b_inode
flag is completly gone there now.


diff -uNr -Xdontdiff -p linux-2.4.20-pre2/fs/buffer.c linux/fs/buffer.c
--- linux-2.4.20-pre2/fs/buffer.c	Tue Aug 13 15:56:00 2002
+++ linux/fs/buffer.c	Tue Aug 13 16:58:48 2002
@@ -583,23 +583,13 @@ struct buffer_head * get_hash_table(kdev
 	return bh;
 }
 
-void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
+void buffer_insert_list(struct buffer_head *bh, struct list_head *list)
 {
 	spin_lock(&lru_list_lock);
 	if (bh->b_inode)
 		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
-	spin_unlock(&lru_list_lock);
-}
-
-void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
-{
-	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
+	bh->b_inode = 1;
+	list_add(&bh->b_inode_buffers, list);
 	spin_unlock(&lru_list_lock);
 }
 
@@ -607,7 +597,7 @@ void buffer_insert_inode_data_queue(stru
    remove_inode_queue functions.  */
 static void __remove_inode_queue(struct buffer_head *bh)
 {
-	bh->b_inode = NULL;
+	bh->b_inode = 0;
 	list_del(&bh->b_inode_buffers);
 }
 
@@ -827,10 +817,10 @@ inline void set_buffer_async_io(struct b
 int fsync_buffers_list(struct list_head *list)
 {
 	struct buffer_head *bh;
-	struct inode tmp;
+	struct list_head tmp;
 	int err = 0, err2;
 	
-	INIT_LIST_HEAD(&tmp.i_dirty_buffers);
+	INIT_LIST_HEAD(&tmp);
 	
 	spin_lock(&lru_list_lock);
 
@@ -838,10 +828,10 @@ int fsync_buffers_list(struct list_head 
 		bh = BH_ENTRY(list->next);
 		list_del(&bh->b_inode_buffers);
 		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = NULL;
+			bh->b_inode = 0;
 		else {
-			bh->b_inode = &tmp;
-			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
+			bh->b_inode = 1;
+			list_add(&bh->b_inode_buffers, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(&lru_list_lock);
@@ -861,8 +851,8 @@ int fsync_buffers_list(struct list_head 
 		}
 	}
 
-	while (!list_empty(&tmp.i_dirty_buffers)) {
-		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
+	while (!list_empty(&tmp)) {
+		bh = BH_ENTRY(tmp.prev);
 		remove_inode_queue(bh);
 		get_bh(bh);
 		spin_unlock(&lru_list_lock);
diff -uNr -Xdontdiff -p linux-2.4.20-pre2/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
--- linux-2.4.20-pre2/fs/reiserfs/inode.c	Tue Aug 13 15:56:01 2002
+++ linux/fs/reiserfs/inode.c	Tue Aug 13 16:08:41 2002
@@ -102,9 +102,9 @@ inline void make_le_item_head (struct it
 }
 
 static void add_to_flushlist(struct inode *inode, struct buffer_head *bh) {
-    struct inode *jinode = &(SB_JOURNAL(inode->i_sb)->j_dummy_inode) ;
+    struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb) ;
 
-    buffer_insert_inode_queue(bh, jinode) ;
+    buffer_insert_list(bh, &j->j_dirty_buffers) ;
 }
 
 //
diff -uNr -Xdontdiff -p linux-2.4.20-pre2/fs/reiserfs/journal.c linux/fs/reiserfs/journal.c
--- linux-2.4.20-pre2/fs/reiserfs/journal.c	Tue Aug 13 15:56:01 2002
+++ linux/fs/reiserfs/journal.c	Tue Aug 13 16:10:01 2002
@@ -1938,7 +1938,7 @@ int journal_init(struct super_block *p_s
   memset(journal_writers, 0, sizeof(char *) * 512) ; /* debug code */
 
   INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
-  INIT_LIST_HEAD(&(SB_JOURNAL(p_s_sb)->j_dummy_inode.i_dirty_buffers)) ;
+  INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_dirty_buffers) ;
   reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
                                  SB_BMAP_NR(p_s_sb)) ;
   allocate_bitmap_nodes(p_s_sb) ;
@@ -2934,7 +2934,7 @@ printk("journal-2020: do_journal_end: BA
   SB_JOURNAL_LIST_INDEX(p_s_sb) = jindex ;
 
   /* write any buffers that must hit disk before this commit is done */
-  fsync_inode_buffers(&(SB_JOURNAL(p_s_sb)->j_dummy_inode)) ;
+  fsync_buffers_list(&(SB_JOURNAL(p_s_sb)->j_dirty_buffers)) ;
 
   /* honor the flush and async wishes from the caller */
   if (flush) {
diff -uNr -Xdontdiff -p linux-2.4.20-pre2/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.20-pre2/include/linux/fs.h	Tue Aug  6 11:29:01 2002
+++ linux/include/linux/fs.h	Tue Aug 13 16:15:56 2002
@@ -265,7 +265,7 @@ struct buffer_head {
 	unsigned long b_rsector;	/* Real buffer location on disk */
 	wait_queue_head_t b_wait;
 
-	struct inode *	     b_inode;
+	int		     b_inode;
 	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
 };
 
@@ -1165,8 +1165,18 @@ static inline void mark_buffer_clean(str
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
diff -uNr -Xdontdiff -p linux-2.4.20-pre2/include/linux/reiserfs_fs_sb.h linux/include/linux/reiserfs_fs_sb.h
--- linux-2.4.20-pre2/include/linux/reiserfs_fs_sb.h	Tue Aug 13 15:56:04 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Tue Aug 13 16:15:56 2002
@@ -312,7 +312,7 @@ struct reiserfs_journal {
   int j_free_bitmap_nodes ;
   int j_used_bitmap_nodes ;
   struct list_head j_bitmap_nodes ;
-  struct inode j_dummy_inode ;
+  struct list_head j_dirty_buffers ;
   struct reiserfs_list_bitmap j_list_bitmap[JOURNAL_NUM_BITMAPS] ;	/* array of bitmaps to record the deleted blocks */
   struct reiserfs_journal_list j_journal_list[JOURNAL_LIST_COUNT] ;	    /* array of all the journal lists */
   struct reiserfs_journal_cnode *j_hash_table[JOURNAL_HASH_SIZE] ; 	    /* hash table for real buffer heads in current trans */ 
diff -uNr -Xdontdiff -p linux-2.4.20-pre2/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.20-pre2/kernel/ksyms.c	Tue Aug 13 15:56:05 2002
+++ linux/kernel/ksyms.c	Tue Aug 13 16:06:12 2002
@@ -525,8 +525,7 @@ EXPORT_SYMBOL(get_hash_table);
 EXPORT_SYMBOL(get_empty_inode);
 EXPORT_SYMBOL(insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
-EXPORT_SYMBOL(buffer_insert_inode_queue);
-EXPORT_SYMBOL(buffer_insert_inode_data_queue);
+EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
