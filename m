Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315050AbSESTnK>; Sun, 19 May 2002 15:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSESTm1>; Sun, 19 May 2002 15:42:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17156 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314987AbSESTkj>;
	Sun, 19 May 2002 15:40:39 -0400
Message-ID: <3CE8008F.392A2A32@zip.com.au>
Date: Sun, 19 May 2002 12:44:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/15] improved I/O scheduling for indirect blocks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixes a performance problem with many-small-file writeout.

At present, files are written out via their mapping and their indirect
blocks are written out via the blockdev mapping.  As we know that
indirects are disk-adjacent to the data it is better to start I/O
against the indirects at the same time as the data.

The delalloc pathes have code in ext2_writepage() which recognises when
the target page->index was at an indirect boundary and does an explicit
hunt-and-write against the neighbouring indirect block.  Which is
ideal.  (Unless the file was dirtied seekily and the page which is next
to the indirect was not dirtied).

This patch does it the other way: when we start writeback against a
mapping, also start writeback against any dirty buffers which are
attached to mapping->private_list.  Let the elevator take care of the
rest.

The patch makes a number of tuning changes to the writeback path in
fs-writeback.c.  This is very fiddly code: getting the throughput
tuned, getting the data-integrity "sync" operations right, avoiding
most of the livelock opportunities, getting the `kupdate' function
working efficiently, keeping it all least somewhat comprehensible.

An important intent here is to ensure that metadata blocks for inodes
are marked dirty before writeback starts working the blockdev mapping,
so all the inode blocks are efficiently written back.

The patch removes try_to_writeback_unused_inodes(), which became
unreferenced in vm-writeback.patch.

The patch has a tweak in ext2_put_inode() to prevent ext2 from
incorrectly droppping its preallocation window in response to a random
iput().


Generally, many-small-file writeout is a lot faster than 2.5.7 (which
is linux-before-I-futzed-with-it).  The workload which was optimised was

	tar xfz /nfs/mountpoint/linux-2.4.18.tar.gz ; sync

on mem=128M and mem=2048M.

With these patches, 2.5.15 is completing in about 2/3 of the time of
2.5.7.  But it is only a shade faster than 2.4.19-pre7.  Why is 2.5.7
so much slower than 2.4.19?  Not sure yet.

Heavy dbench loads (dbench 32 on mem=128M) are slightly faster than
2.5.7 and significantly slower than 2.4.19.  It appears that the cause
is poor read throughput at the later stages of the run.  Because there
are background writeback threads operating at the same time.

The 2.4.19-pre8 write scheduling manages to stop writeback during the
latter stages of the dbench run in a way which I haven't been able to
sanely emulate yet.  It may not be desirable to do this anyway - it's
optimising for the case where the files are about to be deleted.  But
it would be good to find a way of "pausing" the writeback for a few
seconds to allow readers to get an interval of decent bandwidth.

tiobench throughput is basically the same across all recent kernels. 
CPU load on writes is down maybe 30% in 2.5.15.

=====================================

--- 2.5.16/fs/buffer.c~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/fs/buffer.c	Sun May 19 11:49:49 2002
@@ -210,10 +210,7 @@ int sync_blockdev(struct block_device *b
 	if (bdev) {
 		int err;
 
-		ret = filemap_fdatawait(bdev->bd_inode->i_mapping);
-		err = filemap_fdatawrite(bdev->bd_inode->i_mapping);
-		if (!ret)
-			ret = err;
+		ret = filemap_fdatawrite(bdev->bd_inode->i_mapping);
 		err = filemap_fdatawait(bdev->bd_inode->i_mapping);
 		if (!ret)
 			ret = err;
@@ -229,12 +226,14 @@ EXPORT_SYMBOL(sync_blockdev);
  */
 int fsync_super(struct super_block *sb)
 {
-	sync_inodes_sb(sb);	/* All the inodes */
+	sync_inodes_sb(sb, 0);
 	DQUOT_SYNC(sb);
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
 	unlock_super(sb);
+	sync_blockdev(sb->s_bdev);
+	sync_inodes_sb(sb, 1);
 
 	return sync_blockdev(sb->s_bdev);
 }
@@ -276,10 +275,10 @@ int fsync_dev(kdev_t dev)
  */
 asmlinkage long sys_sync(void)
 {
-	sync_inodes();	/* All mappings and inodes, including block devices */
+	sync_inodes(0);	/* All mappings and inodes, including block devices */
 	DQUOT_SYNC(NULL);
 	sync_supers();	/* Write the superblocks */
-	sync_inodes();	/* All the mappings and inodes, again. */
+	sync_inodes(1);	/* All the mappings and inodes, again. */
 	return 0;
 }
 
@@ -775,6 +774,80 @@ int sync_mapping_buffers(struct address_
 }
 EXPORT_SYMBOL(sync_mapping_buffers);
 
+/**
+ * write_mapping_buffers - Start writeout of a mapping's "associated" buffers.
+ * @mapping - the mapping which wants those buffers written.
+ *
+ * Starts I/O against dirty buffers which are on @mapping->private_list.
+ * Those buffers must be backed by @mapping->assoc_mapping.
+ *
+ * The private_list buffers generally contain filesystem indirect blocks.
+ * The idea is that the filesystem can start I/O against the indirects at
+ * the same time as running generic_writeback_mapping(), so the indirect's
+ * I/O will be merged with the data.
+ *
+ * We sneakliy write the buffers in probable tail-to-head order.  This is
+ * because generic_writeback_mapping writes in probable head-to-tail
+ * order.  If the file is so huge that the data or the indirects overflow
+ * the request queue we will at least get some merging this way.
+ *
+ * Any clean+unlocked buffers are de-listed.  clean/locked buffers must be
+ * left on the list for an fsync() to wait on.
+ *
+ * Couldn't think of a smart way of avoiding livelock, so chose the dumb
+ * way instead.
+ *
+ * FIXME: duplicates fsync_inode_buffers() functionality a bit.
+ */
+int write_mapping_buffers(struct address_space *mapping)
+{
+	spinlock_t *lock;
+	struct address_space *buffer_mapping;
+	unsigned nr_to_write;	/* livelock avoidance */
+	struct list_head *lh;
+	int ret = 0;
+
+	if (list_empty(&mapping->private_list))
+		goto out;
+
+	buffer_mapping = mapping->assoc_mapping;
+	lock = &buffer_mapping->private_lock;
+	spin_lock(lock);
+	nr_to_write = 0;
+	lh = mapping->private_list.next;
+	while (lh != &mapping->private_list) {
+		lh = lh->next;
+		nr_to_write++;
+	}
+	nr_to_write *= 2;	/* Allow for some late additions */
+
+	while (nr_to_write-- && !list_empty(&mapping->private_list)) {
+		struct buffer_head *bh;
+
+		bh = BH_ENTRY(mapping->private_list.prev);
+		list_del_init(&bh->b_assoc_buffers);
+		if (!buffer_dirty(bh) && !buffer_locked(bh))
+			continue;
+		/* Stick it on the far end of the list. Order is preserved. */
+		list_add(&bh->b_assoc_buffers, &mapping->private_list);
+		if (test_set_buffer_locked(bh))
+			continue;
+		get_bh(bh);
+		spin_unlock(lock);
+		if (test_clear_buffer_dirty(bh)) {
+			bh->b_end_io = end_buffer_io_sync;
+			submit_bh(WRITE, bh);
+		} else {
+			unlock_buffer(bh);
+			put_bh(bh);
+		}
+		spin_lock(lock);
+	}
+	spin_unlock(lock);
+out:
+	return ret;
+}
+
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
 	struct address_space *mapping = inode->i_mapping;
--- 2.5.16/include/linux/buffer_head.h~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/include/linux/buffer_head.h	Sun May 19 11:49:49 2002
@@ -29,6 +29,7 @@ enum bh_state_bits {
 struct page;
 struct kiobuf;
 struct buffer_head;
+struct address_space;
 typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
 
 /*
@@ -145,14 +146,19 @@ int try_to_free_buffers(struct page *);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
 void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
+
+/* Things to do with buffers at mapping->private_list */
 void buffer_insert_list(spinlock_t *lock,
 			struct buffer_head *, struct list_head *);
-int sync_mapping_buffers(struct address_space *mapping);
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
+int write_mapping_buffers(struct address_space *mapping);
+int inode_has_buffers(struct inode *);
+void invalidate_inode_buffers(struct inode *);
+int fsync_buffers_list(spinlock_t *lock, struct list_head *);
+int sync_mapping_buffers(struct address_space *mapping);
 
 void mark_buffer_async_read(struct buffer_head *bh);
 void mark_buffer_async_write(struct buffer_head *bh);
-void invalidate_inode_buffers(struct inode *);
 void invalidate_bdev(struct block_device *, int);
 void __invalidate_buffers(kdev_t dev, int);
 int sync_blockdev(struct block_device *bdev);
@@ -163,8 +169,6 @@ int fsync_dev(kdev_t);
 int fsync_bdev(struct block_device *);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
-int fsync_buffers_list(spinlock_t *lock, struct list_head *);
-int inode_has_buffers(struct inode *);
 struct buffer_head *__get_hash_table(struct block_device *, sector_t, int);
 struct buffer_head * __getblk(struct block_device *, sector_t, int);
 void __brelse(struct buffer_head *);
--- 2.5.16/fs/ext2/inode.c~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/fs/ext2/inode.c	Sun May 19 11:49:49 2002
@@ -41,7 +41,7 @@ static int ext2_update_inode(struct inod
  */
 void ext2_put_inode (struct inode * inode)
 {
-	if (atomic_read(&inode->i_count) < 2)
+	if (atomic_read(&inode->i_count) < 2)	/* final iput? */
 		ext2_discard_prealloc (inode);
 }
 
@@ -584,6 +584,20 @@ static int ext2_direct_IO(int rw, struct
 {
 	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, ext2_get_block);
 }
+
+static int
+ext2_writeback_mapping(struct address_space *mapping, int *nr_to_write)
+{
+	int ret;
+	int err;
+
+	ret = write_mapping_buffers(mapping);
+	err = generic_writeback_mapping(mapping, nr_to_write);
+	if (!ret)
+		ret = err;
+	return ret;
+}
+
 struct address_space_operations ext2_aops = {
 	readpage: ext2_readpage,
 	writepage: ext2_writepage,
@@ -592,7 +606,7 @@ struct address_space_operations ext2_aop
 	commit_write: generic_commit_write,
 	bmap: ext2_bmap,
 	direct_IO: ext2_direct_IO,
-	writeback_mapping: generic_writeback_mapping,
+	writeback_mapping: ext2_writeback_mapping,
 	vm_writeback: generic_vm_writeback,
 };
 
--- 2.5.16/fs/fs-writeback.c~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/fs/fs-writeback.c	Sun May 19 11:49:49 2002
@@ -77,14 +77,14 @@ void __mark_inode_dirty(struct inode *in
 		 * superblock list, based upon its state.
 		 */
 		if (inode->i_state & I_LOCK)
-			goto same_list;
+			goto out;
 
 		/*
 		 * Only add valid (hashed) inode to the superblock's
 		 * dirty list.  Add blockdev inodes as well.
 		 */
 		if (list_empty(&inode->i_hash) && !S_ISBLK(inode->i_mode))
-			goto same_list;
+			goto out;
 
 		/*
 		 * If the inode was already on s_dirty, don't reposition
@@ -95,11 +95,11 @@ void __mark_inode_dirty(struct inode *in
 			list_add(&inode->i_list, &sb->s_dirty);
 		}
 	}
-same_list:
+out:
 	spin_unlock(&inode_lock);
 }
 
-static inline void write_inode(struct inode *inode, int sync)
+static void write_inode(struct inode *inode, int sync)
 {
 	if (inode->i_sb->s_op && inode->i_sb->s_op->write_inode &&
 			!is_bad_inode(inode))
@@ -130,9 +130,10 @@ static void __sync_single_inode(struct i
 	unsigned dirty;
 	unsigned long orig_dirtied_when;
 	struct address_space *mapping = inode->i_mapping;
+	struct super_block *sb = inode->i_sb;
 
 	list_del(&inode->i_list);
-	list_add(&inode->i_list, &inode->i_sb->s_locked_inodes);
+	list_add(&inode->i_list, &sb->s_locked_inodes);
 
 	BUG_ON(inode->i_state & I_LOCK);
 
@@ -144,13 +145,7 @@ static void __sync_single_inode(struct i
 	mapping->dirtied_when = 0;	/* assume it's whole-file writeback */
 	spin_unlock(&inode_lock);
 
-	if (wait)
-		filemap_fdatawait(mapping);
-
-	if (mapping->a_ops->writeback_mapping)
-		mapping->a_ops->writeback_mapping(mapping, nr_to_write);
-	else
-		generic_writeback_mapping(mapping, NULL);
+	writeback_mapping(mapping, nr_to_write);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
@@ -164,17 +159,20 @@ static void __sync_single_inode(struct i
 	inode->i_state &= ~I_LOCK;
 	if (!(inode->i_state & I_FREEING)) {
 		list_del(&inode->i_list);
-		if (!list_empty(&mapping->dirty_pages)) {
-		 	/* Not a whole-file writeback */
-			mapping->dirtied_when = orig_dirtied_when;
-			inode->i_state |= I_DIRTY_PAGES;
-			list_add_tail(&inode->i_list, &inode->i_sb->s_dirty);
-		} else if (inode->i_state & I_DIRTY) {
-			list_add(&inode->i_list, &inode->i_sb->s_dirty);
-		} else if (atomic_read(&inode->i_count)) {
-			list_add(&inode->i_list, &inode_in_use);
+		if (inode->i_state & I_DIRTY) {		/* Redirtied */
+			list_add(&inode->i_list, &sb->s_dirty);
 		} else {
-			list_add(&inode->i_list, &inode_unused);
+			if (!list_empty(&mapping->dirty_pages)) {
+			 	/* Not a whole-file writeback */
+				mapping->dirtied_when = orig_dirtied_when;
+				inode->i_state |= I_DIRTY_PAGES;
+				list_add_tail(&inode->i_list,
+						&sb->s_dirty);
+			} else if (atomic_read(&inode->i_count)) {
+				list_add(&inode->i_list, &inode_in_use);
+			} else {
+				list_add(&inode->i_list, &inode_unused);
+			}
 		}
 	}
 	if (waitqueue_active(&inode->i_wait))
@@ -200,37 +198,35 @@ __writeback_single_inode(struct inode *i
 	__sync_single_inode(inode, sync, nr_to_write);
 }
 
-void writeback_single_inode(struct inode *inode, int sync, int *nr_to_write)
-{
-	spin_lock(&inode_lock);
-	__writeback_single_inode(inode, sync, nr_to_write);
-	spin_unlock(&inode_lock);
-}
-
 /*
- * Write out a list of dirty inodes.
- *
- * If `sync' is true, wait on writeout of the last mapping which we write.
+ * Write out a superblock's list of dirty inodes.  A wait will be performed
+ * upon no inodes, all inodes or the final one, depending upon sync_mode.
  *
  * If older_than_this is non-NULL, then only write out mappings which
  * had their first dirtying at a time earlier than *older_than_this.
  *
- * Called under inode_lock.
- *
  * If we're a pdlfush thread, then implement pdlfush collision avoidance
  * against the entire list.
+ *
+ * WB_SYNC_HOLD is a hack for sys_sync(): reattach the inode to sb->s_dirty so
+ * that it can be located for waiting on in __writeback_single_inode().
+ *
+ * Called under inode_lock.
  */
-static void __sync_list(struct list_head *head, int sync_mode,
+static void sync_sb_inodes(struct super_block *sb, int sync_mode,
 		int *nr_to_write, unsigned long *older_than_this)
 {
 	struct list_head *tmp;
+	struct list_head *head;
 	const unsigned long start = jiffies;	/* livelock avoidance */
 
+	list_splice(&sb->s_dirty, &sb->s_io);
+	INIT_LIST_HEAD(&sb->s_dirty);
+	head = &sb->s_io;
 	while ((tmp = head->prev) != head) {
 		struct inode *inode = list_entry(tmp, struct inode, i_list);
 		struct address_space *mapping = inode->i_mapping;
 		struct backing_dev_info *bdi;
-
 		int really_sync;
 
 		/* Was this inode dirtied after __sync_list was called? */
@@ -239,7 +235,7 @@ static void __sync_list(struct list_head
 
 		if (older_than_this &&
 			time_after(mapping->dirtied_when, *older_than_this))
-			break;
+			goto out;
 
 		bdi = mapping->backing_dev_info;
 		if (current_is_pdflush() && !writeback_acquire(bdi))
@@ -248,14 +244,29 @@ static void __sync_list(struct list_head
 		really_sync = (sync_mode == WB_SYNC_ALL);
 		if ((sync_mode == WB_SYNC_LAST) && (head->prev == head))
 			really_sync = 1;
+
 		__writeback_single_inode(inode, really_sync, nr_to_write);
 
+		if (sync_mode == WB_SYNC_HOLD) {
+			mapping->dirtied_when = jiffies;
+			list_del(&inode->i_list);
+			list_add(&inode->i_list, &inode->i_sb->s_dirty);
+		}
+
 		if (current_is_pdflush())
 			writeback_release(bdi);
 
 		if (nr_to_write && *nr_to_write == 0)
 			break;
 	}
+out:
+	if (!list_empty(&sb->s_io)) {
+		/*
+		 * Put the rest back, in the correct order.
+		 */
+		list_splice(&sb->s_io, sb->s_dirty.prev);
+		INIT_LIST_HEAD(&sb->s_io);
+	}
 	return;
 }
 
@@ -277,27 +288,16 @@ static void __sync_list(struct list_head
 void writeback_unlocked_inodes(int *nr_to_write, int sync_mode,
 				unsigned long *older_than_this)
 {
-	struct super_block * sb;
-	static unsigned short writeback_gen;
+	struct super_block *sb;
 
 	spin_lock(&inode_lock);
 	spin_lock(&sb_lock);
-
-	/*
-	 * We could get into livelock here if someone is dirtying
-	 * inodes fast enough.  writeback_gen is used to avoid that.
-	 */
-	writeback_gen++;
-
 	sb = sb_entry(super_blocks.prev);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
-		if (sb->s_writeback_gen == writeback_gen)
-			continue;
-		sb->s_writeback_gen = writeback_gen;
 		if (!list_empty(&sb->s_dirty)) {
 			spin_unlock(&sb_lock);
-			__sync_list(&sb->s_dirty, sync_mode,
-					nr_to_write, older_than_this);
+			sync_sb_inodes(sb, sync_mode, nr_to_write,
+					older_than_this);
 			spin_lock(&sb_lock);
 		}
 		if (nr_to_write && *nr_to_write == 0)
@@ -307,42 +307,6 @@ void writeback_unlocked_inodes(int *nr_t
 	spin_unlock(&inode_lock);
 }
 
-/*
- * Called under inode_lock.
- */
-static int __try_to_writeback_unused_list(struct list_head *head, int nr_inodes)
-{
-	struct list_head *tmp = head;
-	struct inode *inode;
-
-	while (nr_inodes && (tmp = tmp->prev) != head) {
-		inode = list_entry(tmp, struct inode, i_list);
-
-		if (!atomic_read(&inode->i_count)) {
-			struct backing_dev_info *bdi;
-
-			bdi = inode->i_mapping->backing_dev_info;
-			if (current_is_pdflush() && !writeback_acquire(bdi))
-				goto out;
-
-			__sync_single_inode(inode, 0, NULL);
-
-			if (current_is_pdflush())
-				writeback_release(bdi);
-
-			nr_inodes--;
-
-			/* 
-			 * __sync_single_inode moved the inode to another list,
-			 * so we have to start looking from the list head.
-			 */
-			tmp = head;
-		}
-	}
-out:
-	return nr_inodes;
-}
-
 static void __wait_on_locked(struct list_head *head)
 {
 	struct list_head * tmp;
@@ -357,104 +321,95 @@ static void __wait_on_locked(struct list
 }
 
 /*
- * writeback and wait upon the filesystem's dirty inodes.
- * We do it in two passes - one to write, and one to wait.
+ * writeback and wait upon the filesystem's dirty inodes.  The caller will
+ * do this in two passes - one to write, and one to wait.  WB_SYNC_HOLD is
+ * used to park the written inodes on sb->s_dirty for the wait pass.
  */
-void sync_inodes_sb(struct super_block *sb)
+void sync_inodes_sb(struct super_block *sb, int wait)
 {
 	spin_lock(&inode_lock);
-	while (!list_empty(&sb->s_dirty)||!list_empty(&sb->s_locked_inodes)) {
-		__sync_list(&sb->s_dirty, WB_SYNC_NONE, NULL, NULL);
-		__sync_list(&sb->s_dirty, WB_SYNC_ALL, NULL, NULL);
+	sync_sb_inodes(sb, wait ? WB_SYNC_ALL : WB_SYNC_HOLD, NULL, NULL);
+	if (wait)
 		__wait_on_locked(&sb->s_locked_inodes);
-	}
 	spin_unlock(&inode_lock);
 }
 
 /*
- * writeback the dirty inodes for this filesystem
+ * Rather lame livelock avoidance.
  */
-void writeback_inodes_sb(struct super_block *sb)
+static void set_sb_syncing(int val)
 {
-	spin_lock(&inode_lock);
-	while (!list_empty(&sb->s_dirty))
-		__sync_list(&sb->s_dirty, WB_SYNC_NONE, NULL, NULL);
-	spin_unlock(&inode_lock);
+	struct super_block *sb;
+	spin_lock(&sb_lock);
+	sb = sb_entry(super_blocks.prev);
+	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
+		sb->s_syncing = val;
+	}
+	spin_unlock(&sb_lock);
 }
 
 /*
  * Find a superblock with inodes that need to be synced
  */
-
 static struct super_block *get_super_to_sync(void)
 {
-	struct list_head *p;
+	struct super_block *sb;
 restart:
-	spin_lock(&inode_lock);
 	spin_lock(&sb_lock);
-	list_for_each(p, &super_blocks) {
-		struct super_block *s = list_entry(p,struct super_block,s_list);
-		if (list_empty(&s->s_dirty) && list_empty(&s->s_locked_inodes))
+	sb = sb_entry(super_blocks.prev);
+	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
+		if (sb->s_syncing)
 			continue;
-		s->s_count++;
+		sb->s_syncing = 1;
+		sb->s_count++;
 		spin_unlock(&sb_lock);
-		spin_unlock(&inode_lock);
-		down_read(&s->s_umount);
-		if (!s->s_root) {
-			drop_super(s);
+		down_read(&sb->s_umount);
+		if (!sb->s_root) {
+			drop_super(sb);
 			goto restart;
 		}
-		return s;
+		return sb;
 	}
 	spin_unlock(&sb_lock);
-	spin_unlock(&inode_lock);
 	return NULL;
 }
 
 /**
- *	sync_inodes
- *	@dev: device to sync the inodes from.
+ * sync_inodes
  *
- *	sync_inodes goes through the super block's dirty list, 
- *	writes them out, waits on the writeout and puts the inodes
- *	back on the normal list.
+ * sync_inodes() goes through each super block's dirty inode list, writes the
+ * inodes out, waits on the writeout and puts the inodes back on the normal
+ * list.
+ *
+ * This is for sys_sync().  fsync_dev() uses the same algorithm.  The subtle
+ * part of the sync functions is that the blockdev "superblock" is processed
+ * last.  This is because the write_inode() function of a typical fs will
+ * perform no I/O, but will mark buffers in the blockdev mapping as dirty.
+ * What we want to do is to perform all that dirtying first, and then write
+ * back all those inode blocks via the blockdev mapping in one sweep.  So the
+ * additional (somewhat redundant) sync_blockdev() calls here are to make
+ * sure that really happens.  Because if we call sync_inodes_sb(wait=1) with
+ * outstanding dirty inodes, the writeback goes block-at-a-time within the
+ * filesystem's write_inode().  This is extremely slow.
  */
-
-void sync_inodes(void)
+void sync_inodes(int wait)
 {
-	struct super_block * s;
-	/*
-	 * Search the super_blocks array for the device(s) to sync.
-	 */
-	while ((s = get_super_to_sync()) != NULL) {
-		sync_inodes_sb(s);
-		drop_super(s);
-	}
-}
+	struct super_block *sb;
 
-/*
- * FIXME: the try_to_writeback_unused functions look dreadfully similar to
- * writeback_unlocked_inodes...
- */
-void try_to_writeback_unused_inodes(unsigned long unused)
-{
-	struct super_block * sb;
-	int nr_inodes = inodes_stat.nr_unused;
-
-	spin_lock(&inode_lock);
-	spin_lock(&sb_lock);
-	sb = sb_entry(super_blocks.next);
-	for (; nr_inodes && sb != sb_entry(&super_blocks);
-			sb = sb_entry(sb->s_list.next)) {
-		if (list_empty(&sb->s_dirty))
-			continue;
-		spin_unlock(&sb_lock);
-		nr_inodes = __try_to_writeback_unused_list(&sb->s_dirty,
-							nr_inodes);
-		spin_lock(&sb_lock);
+	set_sb_syncing(0);
+	while ((sb = get_super_to_sync()) != NULL) {
+		sync_inodes_sb(sb, 0);
+		sync_blockdev(sb->s_bdev);
+		drop_super(sb);
+	}
+	if (wait) {
+		set_sb_syncing(0);
+		while ((sb = get_super_to_sync()) != NULL) {
+			sync_inodes_sb(sb, 1);
+			sync_blockdev(sb->s_bdev);
+			drop_super(sb);
+		}
 	}
-	spin_unlock(&sb_lock);
-	spin_unlock(&inode_lock);
 }
 
 /**
--- 2.5.16/fs/super.c~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/fs/super.c	Sun May 19 11:49:49 2002
@@ -48,6 +48,7 @@ static struct super_block *alloc_super(v
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
 		INIT_LIST_HEAD(&s->s_dirty);
+		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
@@ -154,6 +155,9 @@ static int grab_super(struct super_block
  *
  *	Associates superblock with fs type and puts it on per-type and global
  *	superblocks' lists.  Should be called with sb_lock held; drops it.
+ *
+ *	NOTE: the super_blocks ordering here is important: writeback wants
+ *	the blockdev superblock to be at super_blocks.next.
  */
 static void insert_super(struct super_block *s, struct file_system_type *type)
 {
--- 2.5.16/include/linux/fs.h~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/include/linux/fs.h	Sun May 19 11:52:27 2002
@@ -618,7 +618,6 @@ struct super_block {
 	kdev_t			s_dev;
 	unsigned long		s_blocksize;
 	unsigned long		s_old_blocksize;
-	unsigned short		s_writeback_gen;/* To avoid writeback livelock */
 	unsigned char		s_blocksize_bits;
 	unsigned char		s_dirt;
 	unsigned long long	s_maxbytes;	/* Max file size */
@@ -632,9 +631,11 @@ struct super_block {
 	struct rw_semaphore	s_umount;
 	struct semaphore	s_lock;
 	int			s_count;
+	int			s_syncing;
 	atomic_t		s_active;
 
 	struct list_head	s_dirty;	/* dirty inodes */
+	struct list_head	s_io;		/* parked for writeback */
 	struct list_head	s_locked_inodes;/* inodes being synced */
 	struct list_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
@@ -1113,7 +1114,6 @@ extern int invalidate_device(kdev_t, int
 extern void invalidate_inode_pages(struct inode *);
 extern void invalidate_inode_pages2(struct address_space *);
 extern void write_inode_now(struct inode *, int);
-extern void sync_inodes_sb(struct super_block *);
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
--- 2.5.16/fs/inode.c~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/fs/inode.c	Sun May 19 11:49:49 2002
@@ -311,6 +311,7 @@ int invalidate_inodes(struct super_block
 	busy = invalidate_list(&inode_in_use, sb, &throw_away);
 	busy |= invalidate_list(&inode_unused, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
+	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_locked_inodes, sb, &throw_away);
 	spin_unlock(&inode_lock);
 
@@ -895,6 +896,11 @@ void remove_dquot_ref(struct super_block
 		inode = list_entry(act_head, struct inode, i_list);
 		if (IS_QUOTAINIT(inode))
 			remove_inode_dquot_ref(inode, type, &tofree_head);
+	}
+	list_for_each(act_head, &sb->s_io) {
+		inode = list_entry(act_head, struct inode, i_list);
+		if (IS_QUOTAINIT(inode))
+			remove_inode_dquot_ref(inode, type, &tofree_head);
 	}
 	list_for_each(act_head, &sb->s_locked_inodes) {
 		inode = list_entry(act_head, struct inode, i_list);
--- 2.5.16/include/linux/writeback.h~write-mapping-buffers	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/include/linux/writeback.h	Sun May 19 11:49:49 2002
@@ -27,15 +27,13 @@ static inline int current_is_pdflush(voi
 #define WB_SYNC_NONE	0	/* Don't wait on anything */
 #define WB_SYNC_LAST	1	/* Wait on the last-written mapping */
 #define WB_SYNC_ALL	2	/* Wait on every mapping */
+#define WB_SYNC_HOLD	3	/* Hold the inode on sb_dirty for sys_sync() */
 
-void try_to_writeback_unused_inodes(unsigned long pexclusive);
-void writeback_single_inode(struct inode *inode,
-				int sync, int *nr_to_write);
 void writeback_unlocked_inodes(int *nr_to_write, int sync_mode,
 				unsigned long *older_than_this);
-void writeback_inodes_sb(struct super_block *);
 void __wait_on_inode(struct inode * inode);
-void sync_inodes(void);
+void sync_inodes_sb(struct super_block *, int wait);
+void sync_inodes(int wait);
 
 static inline void wait_on_inode(struct inode *inode)
 {

-
