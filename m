Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131398AbQKVL5Y>; Wed, 22 Nov 2000 06:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131384AbQKVL5O>; Wed, 22 Nov 2000 06:57:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:10511 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129091AbQKVL5H>;
	Wed, 22 Nov 2000 06:57:07 -0500
Date: Wed, 22 Nov 2000 11:24:18 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>
Subject: [patch] O_SYNC patch 2/3, add per-inode dirty buffer lists
Message-ID: <20001122112418.C6516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second part of my old O_SYNC diffs patched up for
2.4.0-test11.  It adds support for per-inode dirty buffer lists.

In 2.4, we are now generating dirty buffers on a per-page basis for
every write.  For large O_SYNC writes (often databases use around 128K
per write), we obviously don't want to wait synchonously for each page
being written, so we have really only two choices: keep a separate
list of the dirty buffers so that they can be waited on once the
generic_file_write is complete, or search for the dirty buffers
manually.

We do have the ability to do a search based on a particular region of
a file: generic_buffer_fdatasybnc() can in theory do that, but the ide
of walking the whole of the cached image of a multi-GB database file
just looking for the handful of dirty pages after an O_SYNC write
fills me with horror.

This patch simply contains the cache infrastructure changes to allow
us to track dirty buffers against a given inode --- the filesystems
themselves are not touched by this portion of the change.  Generic
osync routines are provided, though, to flush all of an inode's dirty
data to disk.

--Stephen

2.4.0test11.01.bdirty.diff :


--- linux-2.4.0-test11/fs/buffer.c.~1~	Tue Nov 21 15:47:32 2000
+++ linux-2.4.0-test11/fs/buffer.c	Tue Nov 21 15:51:17 2000
@@ -69,6 +69,8 @@
  *	lru_list_lock > hash_table_lock > free_list_lock > unused_list_lock
  */
 
+#define BH_ENTRY(list) list_entry((list), struct buffer_head, b_inode_buffers)
+
 /*
  * Hash table gook..
  */
@@ -567,6 +569,42 @@
 	return 0;
 }
 
+void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
+{
+	spin_lock(&lru_list_lock);
+	if (bh->b_inode)
+		list_del(&bh->b_inode_buffers);
+	bh->b_inode = inode;
+	list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
+	spin_unlock(&lru_list_lock);
+}
+
+/* The caller must have the lru_list lock before calling the 
+   remove_inode_queue functions.  */
+static void __remove_inode_queue(struct buffer_head *bh)
+{
+	bh->b_inode = NULL;
+	list_del(&bh->b_inode_buffers);
+}
+
+static inline void remove_inode_queue(struct buffer_head *bh)
+{
+	if (bh->b_inode)
+		__remove_inode_queue(bh);
+}
+
+int inode_has_buffers(struct inode *inode)
+{
+	int ret;
+	
+	spin_lock(&lru_list_lock);
+	ret = !list_empty(&inode->i_dirty_buffers);
+	spin_unlock(&lru_list_lock);
+	
+	return ret;
+}
+
+
 /* If invalidate_buffers() will trash dirty buffers, it means some kind
    of fs corruption is going on. Trashing dirty data always imply losing
    information that was supposed to be just stored on the physical layer
@@ -615,6 +653,7 @@
 			write_lock(&hash_table_lock);
 			if (!atomic_read(&bh->b_count) &&
 			    (destroy_dirty_buffers || !buffer_dirty(bh))) {
+				remove_inode_queue(bh);
 				__remove_from_queues(bh);
 				put_last_free(bh);
 			}
@@ -679,6 +718,7 @@
 					printk(KERN_WARNING
 					       "set_blocksize: dev %s buffer_dirty %lu size %hu\n",
 					       kdevname(dev), bh->b_blocknr, bh->b_size);
+				remove_inode_queue(bh);
 				__remove_from_queues(bh);
 				put_last_free(bh);
 			} else {
@@ -794,6 +834,136 @@
 }
 
 /*
+ * Synchronise all the inode's dirty buffers to the disk.
+ *
+ * We have conflicting pressures: we want to make sure that all
+ * initially dirty buffers get waited on, but that any subsequently
+ * dirtied buffers don't.  After all, we don't want fsync to last
+ * forever if somebody is actively writing to the file.
+ *
+ * Do this in two main stages: first we copy dirty buffers to a
+ * temporary inode list, queueing the writes as we go.  Then we clean
+ * up, waiting for those writes to complete.
+ * 
+ * During this second stage, any subsequent updates to the file may end
+ * up refiling the buffer on the original inode's dirty list again, so
+ * there is a chance we will end up with a buffer queued for write but
+ * not yet completed on that list.  So, as a final cleanup we go through
+ * the osync code to catch these locked, dirty buffers without requeuing
+ * any newly dirty buffers for write.
+ */
+
+int fsync_inode_buffers(struct inode *inode)
+{
+	struct buffer_head *bh;
+	struct inode tmp;
+	int err = 0, err2;
+	
+	INIT_LIST_HEAD(&tmp.i_dirty_buffers);
+	
+	spin_lock(&lru_list_lock);
+
+	while (!list_empty(&inode->i_dirty_buffers)) {
+		bh = BH_ENTRY(inode->i_dirty_buffers.next);
+		list_del(&bh->b_inode_buffers);
+		if (!buffer_dirty(bh) && !buffer_locked(bh))
+			bh->b_inode = NULL;
+		else {
+			bh->b_inode = &tmp;
+			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
+			atomic_inc(&bh->b_count);
+			if (buffer_dirty(bh)) {
+				spin_unlock(&lru_list_lock);
+				ll_rw_block(WRITE, 1, &bh);
+				spin_lock(&lru_list_lock);
+			}
+		}
+	}
+
+	while (!list_empty(&tmp.i_dirty_buffers)) {
+		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
+		remove_inode_queue(bh);
+		spin_unlock(&lru_list_lock);
+		wait_on_buffer(bh);
+		if (!buffer_uptodate(bh))
+			err = -EIO;
+		brelse(bh);
+		spin_lock(&lru_list_lock);
+	}
+	
+	spin_unlock(&lru_list_lock);
+	err2 = osync_inode_buffers(inode);
+
+	if (err)
+		return err;
+	else
+		return err2;
+}
+
+
+/*
+ * osync is designed to support O_SYNC io.  It waits synchronously for
+ * all already-submitted IO to complete, but does not queue any new
+ * writes to the disk.
+ *
+ * To do O_SYNC writes, just queue the buffer writes with ll_rw_block as
+ * you dirty the buffers, and then use osync_inode_buffers to wait for
+ * completion.  Any other dirty buffers which are not yet queued for
+ * write will not be flushed to disk by the osync.
+ */
+
+int osync_inode_buffers(struct inode *inode)
+{
+	struct buffer_head *bh;
+	struct list_head *list;
+	int err = 0;
+
+	spin_lock(&lru_list_lock);
+	
+ repeat:
+	
+	for (list = inode->i_dirty_buffers.prev; 
+	     bh = BH_ENTRY(list), list != &inode->i_dirty_buffers;
+	     list = bh->b_inode_buffers.prev) {
+		if (buffer_locked(bh)) {
+			atomic_inc(&bh->b_count);
+			spin_unlock(&lru_list_lock);
+			wait_on_buffer(bh);
+			brelse(bh);
+			if (!buffer_uptodate(bh))
+				err = -EIO;
+			spin_lock(&lru_list_lock);
+			goto repeat;
+		}
+	}
+
+	spin_unlock(&lru_list_lock);
+	return err;
+}
+
+
+/*
+ * Invalidate any and all dirty buffers on a given inode.  We are
+ * probably unmounting the fs, but that doesn't mean we have already
+ * done a sync().  Just drop the buffers from the inode list.
+ */
+
+void invalidate_inode_buffers(struct inode *inode)
+{
+	struct list_head *list, *next;
+	
+	spin_lock(&lru_list_lock);
+	list = inode->i_dirty_buffers.next; 
+	while (list != &inode->i_dirty_buffers) {
+		next = list->next;
+		remove_inode_queue(BH_ENTRY(list));
+		list = next;
+	}
+	spin_unlock(&lru_list_lock);
+}
+
+
+/*
  * Ok, this is getblk, and it isn't very clear, again to hinder
  * race-conditions. Most of the code is seldom used, (ie repeating),
  * so it should be much more efficient than it looks.
@@ -941,6 +1111,8 @@
 	if (dispose != bh->b_list) {
 		__remove_from_lru_list(bh, bh->b_list);
 		bh->b_list = dispose;
+		if (dispose == BUF_CLEAN)
+			remove_inode_queue(bh);
 		__insert_into_lru_list(bh, dispose);
 	}
 }
@@ -978,6 +1150,7 @@
 	if (!atomic_dec_and_test(&buf->b_count) || buffer_locked(buf))
 		goto in_use;
 	__hash_unlink(buf);
+	remove_inode_queue(buf);
 	write_unlock(&hash_table_lock);
 	__remove_from_lru_list(buf, buf->b_list);
 	spin_unlock(&lru_list_lock);
@@ -1074,6 +1247,8 @@
  */
 static __inline__ void __put_unused_buffer_head(struct buffer_head * bh)
 {
+	if (bh->b_inode)
+		BUG();
 	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
 		kmem_cache_free(bh_cachep, bh);
 	} else {
@@ -1441,6 +1616,7 @@
 		}
 		set_bit(BH_Uptodate, &bh->b_state);
 		if (!atomic_set_buffer_dirty(bh)) {
+			buffer_insert_inode_queue(bh, inode);
 			__mark_dirty(bh);
 			need_balance_dirty = 1;
 		}
@@ -2313,9 +2489,10 @@
 		/* The buffer can be either on the regular
 		 * queues or on the free list..
 		 */
-		if (p->b_dev != B_FREE)
-			__remove_from_queues(p);
-		else
+		if (p->b_dev != B_FREE) {
+			remove_inode_queue(p);
+			__remove_from_queues(p);
+		} else
 			__remove_from_free_list(p, index);
 		__put_unused_buffer_head(p);
 	} while (tmp != bh);
--- linux-2.4.0-test11/fs/inode.c.~1~	Tue Nov 21 15:47:48 2000
+++ linux-2.4.0-test11/fs/inode.c	Tue Nov 21 15:53:51 2000
@@ -96,6 +96,7 @@
 		INIT_LIST_HEAD(&inode->i_hash);
 		INIT_LIST_HEAD(&inode->i_data.pages);
 		INIT_LIST_HEAD(&inode->i_dentry);
+		INIT_LIST_HEAD(&inode->i_dirty_buffers);
 		sema_init(&inode->i_sem, 1);
 		sema_init(&inode->i_zombie, 1);
 		spin_lock_init(&inode->i_data.i_shared_lock);
@@ -283,6 +284,60 @@
 }
 
 /**
+ * generic_osync_inode - flush all dirty data for a given inode to disk
+ * @inode: inode to write
+ * @datasync: if set, don't bother flushing timestamps
+ *
+ * This can be called by file_write functions for files which have the
+ * O_SYNC flag set, to flush dirty writes to disk.  
+ */
+
+int generic_osync_inode(struct inode *inode, int datasync)
+{
+	int err;
+	
+	/* 
+	 * WARNING
+	 *
+	 * Currently, the filesystem write path does not pass the
+	 * filp down to the low-level write functions.  Therefore it
+	 * is impossible for (say) __block_commit_write to know if
+	 * the operation is O_SYNC or not.
+	 *
+	 * Ideally, O_SYNC writes would have the filesystem call
+	 * ll_rw_block as it went to kick-start the writes, and we
+	 * could call osync_inode_buffers() here to wait only for
+	 * those IOs which have already been submitted to the device
+	 * driver layer.  As it stands, if we did this we'd not write
+	 * anything to disk since our writes have not been queued by
+	 * this point: they are still on the dirty LRU.
+	 * 
+	 * So, currently we will call fsync_inode_buffers() instead,
+	 * to flush _all_ dirty buffers for this inode to disk on 
+	 * every O_SYNC write, not just the synchronous I/Os.  --sct
+	 */
+
+#ifdef WRITERS_QUEUE_IO
+	err = osync_inode_buffers(inode);
+#else
+	err = fsync_inode_buffers(inode);
+#endif
+
+	spin_lock(&inode_lock);
+	if (!(inode->i_state & I_DIRTY))
+		goto out;
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+		goto out;
+	spin_unlock(&inode_lock);
+	write_inode_now(inode, 1);
+	return err;
+
+ out:
+	spin_unlock(&inode_lock);
+	return err;
+}
+
+/**
  * clear_inode - clear an inode
  * @inode: inode to clear
  *
@@ -413,7 +468,8 @@
  *      dispose_list.
  */
 #define CAN_UNUSE(inode) \
-	(((inode)->i_state | (inode)->i_data.nrpages) == 0)
+	((((inode)->i_state | (inode)->i_data.nrpages) == 0)  && \
+	 !inode_has_buffers(inode))
 #define INODE(entry)	(list_entry(entry, struct inode, i_list))
 
 void prune_icache(int goal)
--- linux-2.4.0-test11/include/linux/fs.h.~1~	Tue Nov 21 15:47:48 2000
+++ linux-2.4.0-test11/include/linux/fs.h	Tue Nov 21 15:51:17 2000
@@ -243,6 +243,9 @@
 
 	unsigned long b_rsector;	/* Real buffer location on disk */
 	wait_queue_head_t b_wait;
+
+	struct inode *	     b_inode;
+	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
 };
 
 typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
@@ -382,6 +385,8 @@
 	struct list_head	i_hash;
 	struct list_head	i_list;
 	struct list_head	i_dentry;
+	
+	struct list_head	i_dirty_buffers;
 
 	unsigned long		i_ino;
 	atomic_t		i_count;
@@ -1034,10 +1039,18 @@
 	bh->b_end_io(bh, 0);
 }
 
+extern void buffer_insert_inode_queue(struct buffer_head *, struct inode *);
+static inline void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
+{
+	mark_buffer_dirty(bh);
+	buffer_insert_inode_queue(bh, inode);
+}
+
 extern void balance_dirty(kdev_t);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
 extern void invalidate_inode_pages(struct inode *);
+extern void invalidate_inode_buffers(struct inode *);
 #define invalidate_buffers(dev)	__invalidate_buffers((dev), 0)
 #define destroy_buffers(dev)	__invalidate_buffers((dev), 1)
 extern void __invalidate_buffers(kdev_t dev, int);
@@ -1045,6 +1058,9 @@
 extern void write_inode_now(struct inode *, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern int fsync_inode_buffers(struct inode *);
+extern int osync_inode_buffers(struct inode *);
+extern int inode_has_buffers(struct inode *);
 extern void sync_supers(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
@@ -1258,6 +1274,7 @@
 
 extern int file_fsync(struct file *, struct dentry *, int);
 extern int generic_buffer_fdatasync(struct inode *inode, unsigned long start_idx, unsigned long end_idx);
+extern int generic_osync_inode(struct inode *, int);
 
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern void inode_setattr(struct inode *, struct iattr *);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
