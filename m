Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSD2Nal>; Mon, 29 Apr 2002 09:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312608AbSD2Nal>; Mon, 29 Apr 2002 09:30:41 -0400
Received: from imladris.infradead.org ([194.205.184.45]:55556 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312590AbSD2Naj>; Mon, 29 Apr 2002 09:30:39 -0400
Date: Mon, 29 Apr 2002 14:30:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill code duplication in buffer handling
Message-ID: <20020429143025.A4726@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loosely spoken this is a backport of a patch from Al that went into
early 2.5, I got into this because a patch (lock_break) changed those
in different ways and thus broke JFS, the only filesystem using the
inodes i_dirty_data_buffers list for normal operation (i.e. not O_DIRECT).

Currently fs/buffer.c contains some functions twice, with the only
difference beein that one uses inode->i_dirty_buffers and the other
inode->i_dirty_data_buffers.

This patch replaces osync_inode_buffers and osync_inode_data_buffers
with osync_buffers_list that takes a struct list_head and is static as
not used outside buffer.c.  Also the bodies of fsync_inode_buffers and
fsync_inode_data_buffers are merged into fsync_buffers_list, but as it
has many external users static inlines in fs.h are added to stay source
compatible.  In addition there is some minor cleanup in the surrounding
area whithout behaviour change.

	Christoph

diff -uNr -Xdontdiff linux-2.4.19-pre7/fs/buffer.c linux/fs/buffer.c
--- linux-2.4.19-pre7/fs/buffer.c	Tue Apr 16 20:46:42 2002
+++ linux/fs/buffer.c	Mon Apr 29 13:20:58 2002
@@ -84,6 +84,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
 
 static int grow_buffers(kdev_t dev, unsigned long block, int size);
+static int osync_buffers_list(struct list_head *);
 static void __refile_buffer(struct buffer_head *);
 
 /* This is used by some architectures to estimate available memory. */
@@ -801,9 +802,10 @@
 	return;
 }
 
-inline void set_buffer_async_io(struct buffer_head *bh) {
-    bh->b_end_io = end_buffer_io_async ;
-    mark_buffer_async(bh, 1);
+inline void set_buffer_async_io(struct buffer_head *bh)
+{
+	bh->b_end_io = end_buffer_io_async;
+	mark_buffer_async(bh, 1);
 }
 
 /*
@@ -825,8 +827,7 @@
  * the osync code to catch these locked, dirty buffers without requeuing
  * any newly dirty buffers for write.
  */
-
-int fsync_inode_buffers(struct inode *inode)
+int fsync_buffers_list(struct list_head *list)
 {
 	struct buffer_head *bh;
 	struct inode tmp;
@@ -836,8 +837,8 @@
 	
 	spin_lock(&lru_list_lock);
 
-	while (!list_empty(&inode->i_dirty_buffers)) {
-		bh = BH_ENTRY(inode->i_dirty_buffers.next);
+	while (!list_empty(list)) {
+		bh = BH_ENTRY(list->next);
 		list_del(&bh->b_inode_buffers);
 		if (!buffer_dirty(bh) && !buffer_locked(bh))
 			bh->b_inode = NULL;
@@ -867,56 +868,7 @@
 	}
 	
 	spin_unlock(&lru_list_lock);
-	err2 = osync_inode_buffers(inode);
-
-	if (err)
-		return err;
-	else
-		return err2;
-}
-
-int fsync_inode_data_buffers(struct inode *inode)
-{
-	struct buffer_head *bh;
-	struct inode tmp;
-	int err = 0, err2;
-	
-	INIT_LIST_HEAD(&tmp.i_dirty_data_buffers);
-	
-	spin_lock(&lru_list_lock);
-
-	while (!list_empty(&inode->i_dirty_data_buffers)) {
-		bh = BH_ENTRY(inode->i_dirty_data_buffers.next);
-		list_del(&bh->b_inode_buffers);
-		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = NULL;
-		else {
-			bh->b_inode = &tmp;
-			list_add(&bh->b_inode_buffers, &tmp.i_dirty_data_buffers);
-			if (buffer_dirty(bh)) {
-				get_bh(bh);
-				spin_unlock(&lru_list_lock);
-				ll_rw_block(WRITE, 1, &bh);
-				brelse(bh);
-				spin_lock(&lru_list_lock);
-			}
-		}
-	}
-
-	while (!list_empty(&tmp.i_dirty_data_buffers)) {
-		bh = BH_ENTRY(tmp.i_dirty_data_buffers.prev);
-		remove_inode_queue(bh);
-		get_bh(bh);
-		spin_unlock(&lru_list_lock);
-		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
-			err = -EIO;
-		brelse(bh);
-		spin_lock(&lru_list_lock);
-	}
-	
-	spin_unlock(&lru_list_lock);
-	err2 = osync_inode_data_buffers(inode);
+	err2 = osync_buffers_list(list);
 
 	if (err)
 		return err;
@@ -930,24 +882,21 @@
  * writes to the disk.
  *
  * To do O_SYNC writes, just queue the buffer writes with ll_rw_block as
- * you dirty the buffers, and then use osync_inode_buffers to wait for
+ * you dirty the buffers, and then use osync_buffers_list to wait for
  * completion.  Any other dirty buffers which are not yet queued for
  * write will not be flushed to disk by the osync.
  */
-
-int osync_inode_buffers(struct inode *inode)
+static int osync_buffers_list(struct list_head *list)
 {
 	struct buffer_head *bh;
-	struct list_head *list;
+	struct list_head *p;
 	int err = 0;
 
 	spin_lock(&lru_list_lock);
 	
  repeat:
-	
-	for (list = inode->i_dirty_buffers.prev; 
-	     bh = BH_ENTRY(list), list != &inode->i_dirty_buffers;
-	     list = bh->b_inode_buffers.prev) {
+	list_for_each_prev(p, list) {
+		bh = BH_ENTRY(p);
 		if (buffer_locked(bh)) {
 			get_bh(bh);
 			spin_unlock(&lru_list_lock);
@@ -964,36 +913,6 @@
 	return err;
 }
 
-int osync_inode_data_buffers(struct inode *inode)
-{
-	struct buffer_head *bh;
-	struct list_head *list;
-	int err = 0;
-
-	spin_lock(&lru_list_lock);
-	
- repeat:
-
-	for (list = inode->i_dirty_data_buffers.prev; 
-	     bh = BH_ENTRY(list), list != &inode->i_dirty_data_buffers;
-	     list = bh->b_inode_buffers.prev) {
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&lru_list_lock);
-			wait_on_buffer(bh);
-			if (!buffer_uptodate(bh))
-				err = -EIO;
-			brelse(bh);
-			spin_lock(&lru_list_lock);
-			goto repeat;
-		}
-	}
-
-	spin_unlock(&lru_list_lock);
-	return err;
-}
-
-
 /*
  * Invalidate any and all dirty buffers on a given inode.  We are
  * probably unmounting the fs, but that doesn't mean we have already
diff -uNr -Xdontdiff linux-2.4.19-pre7/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.19-pre7/include/linux/fs.h	Tue Apr 16 20:48:18 2002
+++ linux/include/linux/fs.h	Mon Apr 29 13:22:55 2002
@@ -1163,9 +1163,13 @@
 extern void FASTCALL(__mark_dirty(struct buffer_head *bh));
 extern void FASTCALL(__mark_buffer_dirty(struct buffer_head *bh));
 extern void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
+extern void FASTCALL(buffer_insert_inode_queue(struct buffer_head *, struct inode *));
 extern void FASTCALL(buffer_insert_inode_data_queue(struct buffer_head *, struct inode *));
 
-#define atomic_set_buffer_dirty(bh) test_and_set_bit(BH_Dirty, &(bh)->b_state)
+static inline int atomic_set_buffer_dirty(struct buffer_head *bh)
+{
+	return test_and_set_bit(BH_Dirty, &bh->b_state);
+}
 
 static inline void mark_buffer_async(struct buffer_head * bh, int on)
 {
@@ -1190,7 +1194,6 @@
 	bh->b_end_io(bh, 0);
 }
 
-extern void buffer_insert_inode_queue(struct buffer_head *, struct inode *);
 static inline void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
 	mark_buffer_dirty(bh);
@@ -1218,10 +1221,15 @@
 extern int fsync_super(struct super_block *);
 extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
-extern int osync_inode_buffers(struct inode *);
-extern int osync_inode_data_buffers(struct inode *);
-extern int fsync_inode_buffers(struct inode *);
-extern int fsync_inode_data_buffers(struct inode *);
+extern int fsync_buffers_list(struct list_head *);
+static inline int fsync_inode_buffers(struct inode *inode)
+{
+	return fsync_buffers_list(&inode->i_dirty_buffers);
+}
+static inline int fsync_inode_data_buffers(struct inode *inode)
+{
+	return fsync_buffers_list(&inode->i_dirty_data_buffers);
+}
 extern int inode_has_buffers(struct inode *);
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
diff -uNr -Xdontdiff linux-2.4.19-pre7/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.19-pre7/kernel/ksyms.c	Tue Apr 16 20:46:39 2002
+++ linux/kernel/ksyms.c	Mon Apr 29 13:22:26 2002
@@ -504,8 +504,7 @@
 /* Added to make file system as module */
 EXPORT_SYMBOL(sys_tz);
 EXPORT_SYMBOL(file_fsync);
-EXPORT_SYMBOL(fsync_inode_buffers);
-EXPORT_SYMBOL(fsync_inode_data_buffers);
+EXPORT_SYMBOL(fsync_buffers_list);
 EXPORT_SYMBOL(clear_inode);
 EXPORT_SYMBOL(___strtok);
 EXPORT_SYMBOL(init_special_inode);
@@ -515,6 +514,7 @@
 EXPORT_SYMBOL(insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
 EXPORT_SYMBOL(buffer_insert_inode_queue);
+EXPORT_SYMBOL(buffer_insert_inode_data_queue);
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
