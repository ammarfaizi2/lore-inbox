Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSGQFWp>; Wed, 17 Jul 2002 01:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSGQFVp>; Wed, 17 Jul 2002 01:21:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18188 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318223AbSGQFT3>;
	Wed, 17 Jul 2002 01:19:29 -0400
Message-ID: <3D3500E8.9C6B6ACD@zip.com.au>
Date: Tue, 16 Jul 2002 22:30:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 11/13] writeback scalability improvements
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The kernel has a number of problems wrt heavy write traffic to multiple
spindles.  What keeps on happening is that all processes which are
responsible for writeback get blocked on one of the queues and all the
others fall idle.

This happens in the balance_dirty_pages() path (balance_dirty() in 2.4)
and in the page reclaim code, when a dirty page is found on the LRU.

The latter is particularly bad because it causes "innocent" processes
to be suspended for long periods due to the activity of heavy writers.

The general idea is: the primary resource for writeback should be the
process which is dirtying memory.  The secondary resource is the
pdflush pool (although this is mainly for providing async writeback in
the presence of light-moderate loads).  Add the final
oh-gee-we-screwed-up resource for writeback is a caller to
shrink_cache().

This patch addresses the balance_dirty_pages() path.  This code was
initially modelled on the 2.4 writeback scheme: throttled processes
writeback all data regardless of its queue.  Instead, the patch changes
it so that the balance_dirty_pages() caller only writes back pages
which are dirty against the queue which that caller just dirtied.

So the effect is a better allocation of writeback resources across the
queues and increased parallelism.

The per-queue writeback is implemented by using
mapping->backing_dev_info as a search key during the walk across the
superblocks and inodes.

The patch also fixes an initialisation problem in
block_dev.c:do_open(): it was setting up the blockdev's
mapping->backing_dev_info too early, before the queue has been
identified.

Generally, this patch doesn't help much, because of the stalls in the
page allocator.  I have a patch which mostly fixes that up, and taken
together the kernel is achieving almost platter speed against six
spindles, but only when the system has a small amount of memory.  More
work is needed there.



 fs/block_dev.c      |   19 ++++++---
 fs/fs-writeback.c   |  104 +++++++++++++++++++++++++++++++++++++---------------
 mm/page-writeback.c |   13 +++---
 3 files changed, 94 insertions(+), 42 deletions(-)

--- 2.5.26/fs/fs-writeback.c~writeback-scalability-throttling	Tue Jul 16 21:47:18 2002
+++ 2.5.26-akpm/fs/fs-writeback.c	Tue Jul 16 21:47:18 2002
@@ -19,9 +19,12 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/writeback.h>
+#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 
+extern struct super_block *blockdev_superblock;
+
 /**
  *	__mark_inode_dirty -	internal function
  *	@inode: inode to mark
@@ -91,10 +94,8 @@ void __mark_inode_dirty(struct inode *in
 		 * If the inode was already on s_dirty, don't reposition
 		 * it (that would break s_dirty time-ordering).
 		 */
-		if (!was_dirty) {
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, &sb->s_dirty);
-		}
+		if (!was_dirty)
+			list_move(&inode->i_list, &sb->s_dirty);
 	}
 out:
 	spin_unlock(&inode_lock);
@@ -133,8 +134,7 @@ static void __sync_single_inode(struct i
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 
-	list_del(&inode->i_list);
-	list_add(&inode->i_list, &sb->s_locked_inodes);
+	list_move(&inode->i_list, &sb->s_locked_inodes);
 
 	BUG_ON(inode->i_state & I_LOCK);
 
@@ -212,9 +212,19 @@ __writeback_single_inode(struct inode *i
  * that it can be located for waiting on in __writeback_single_inode().
  *
  * Called under inode_lock.
+ *
+ * If `bdi' is non-zero then we're being asked to writeback a specific queue.
+ * This function assumes that the blockdev superblock's inodes are backed by
+ * a variety of queues, so all inodes are searched.  For other superblocks,
+ * assume that all inodes are backed by the same queue.
+ *
+ * FIXME: this linear search could get expensive with many fileystems.  But
+ * how to fix?  We need to go from an address_space to all inodes which share
+ * a queue with that address_space.
  */
-static void sync_sb_inodes(struct super_block *sb, int sync_mode,
-		int *nr_to_write, unsigned long *older_than_this)
+static void
+sync_sb_inodes(struct backing_dev_info *single_bdi, struct super_block *sb,
+	int sync_mode, int *nr_to_write, unsigned long *older_than_this)
 {
 	struct list_head *tmp;
 	struct list_head *head;
@@ -228,7 +238,14 @@ static void sync_sb_inodes(struct super_
 		struct backing_dev_info *bdi;
 		int really_sync;
 
-		/* Was this inode dirtied after __sync_list was called? */
+		if (single_bdi && mapping->backing_dev_info != single_bdi) {
+			if (sb != blockdev_superblock)
+				break;		/* inappropriate superblock */
+			list_move(&inode->i_list, &inode->i_sb->s_dirty);
+			continue;		/* not this blockdev */
+		}
+
+		/* Was this inode dirtied after sync_sb_inodes was called? */
 		if (time_after(mapping->dirtied_when, start))
 			break;
 
@@ -249,8 +266,7 @@ static void sync_sb_inodes(struct super_
 		__writeback_single_inode(inode, really_sync, nr_to_write);
 		if (sync_mode == WB_SYNC_HOLD) {
 			mapping->dirtied_when = jiffies;
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, &inode->i_sb->s_dirty);
+			list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		}
 		if (current_is_pdflush())
 			writeback_release(bdi);
@@ -269,23 +285,16 @@ out:
 }
 
 /*
- * Start writeback of dirty pagecache data against all unlocked inodes.
- *
- * Note:
- * We don't need to grab a reference to superblock here. If it has non-empty
- * ->s_dirty it's hadn't been killed yet and kill_super() won't proceed
- * past sync_inodes_sb() until both ->s_dirty and ->s_locked_inodes are
- * empty. Since __sync_single_inode() regains inode_lock before it finally moves
- * inode from superblock lists we are OK.
- *
- * If `older_than_this' is non-zero then only flush inodes which have a
- * flushtime older than *older_than_this.
- *
- * This is a "memory cleansing" operation, not a "data integrity" operation.
+ * If `bdi' is non-zero then we will scan the first inode against each
+ * superblock until we find the matching ones.  One group will be the dirty
+ * inodes against a filesystem.  Then when we hit the dummy blockdev superblock,
+ * sync_sb_inodes will seekout the blockdev which matches `bdi'.  Maybe not
+ * super-efficient but we're about to do a ton of I/O...
  */
-void writeback_unlocked_inodes(int *nr_to_write,
-			       enum writeback_sync_modes sync_mode,
-			       unsigned long *older_than_this)
+static void
+__writeback_unlocked_inodes(struct backing_dev_info *bdi, int *nr_to_write,
+				enum writeback_sync_modes sync_mode,
+				unsigned long *older_than_this)
 {
 	struct super_block *sb;
 
@@ -295,7 +304,7 @@ void writeback_unlocked_inodes(int *nr_t
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
 		if (!list_empty(&sb->s_dirty)) {
 			spin_unlock(&sb_lock);
-			sync_sb_inodes(sb, sync_mode, nr_to_write,
+			sync_sb_inodes(bdi, sb, sync_mode, nr_to_write,
 					older_than_this);
 			spin_lock(&sb_lock);
 		}
@@ -306,6 +315,43 @@ void writeback_unlocked_inodes(int *nr_t
 	spin_unlock(&inode_lock);
 }
 
+/*
+ * Start writeback of dirty pagecache data against all unlocked inodes.
+ *
+ * Note:
+ * We don't need to grab a reference to superblock here. If it has non-empty
+ * ->s_dirty it's hadn't been killed yet and kill_super() won't proceed
+ * past sync_inodes_sb() until both ->s_dirty and ->s_locked_inodes are
+ * empty. Since __sync_single_inode() regains inode_lock before it finally moves
+ * inode from superblock lists we are OK.
+ *
+ * If `older_than_this' is non-zero then only flush inodes which have a
+ * flushtime older than *older_than_this.
+ *
+ * This is a "memory cleansing" operation, not a "data integrity" operation.
+ */
+void writeback_unlocked_inodes(int *nr_to_write,
+				enum writeback_sync_modes sync_mode,
+				unsigned long *older_than_this)
+{
+	__writeback_unlocked_inodes(NULL, nr_to_write,
+				sync_mode, older_than_this);
+}
+/*
+ * Perform writeback of dirty data against a particular queue.
+ *
+ * This is for writer throttling.  We don't want processes to write back
+ * other process's data, espsecially when the other data belongs to a
+ * different spindle.
+ */
+void writeback_backing_dev(struct backing_dev_info *bdi, int *nr_to_write,
+			enum writeback_sync_modes sync_mode,
+			unsigned long *older_than_this)
+{
+	__writeback_unlocked_inodes(bdi, nr_to_write,
+				sync_mode, older_than_this);
+}
+
 static void __wait_on_locked(struct list_head *head)
 {
 	struct list_head * tmp;
@@ -336,7 +382,7 @@ void sync_inodes_sb(struct super_block *
 	nr_to_write = ps.nr_dirty + ps.nr_dirty / 4;
 
 	spin_lock(&inode_lock);
-	sync_sb_inodes(sb, wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
+	sync_sb_inodes(NULL, sb, wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
 				&nr_to_write, NULL);
 	if (wait)
 		__wait_on_locked(&sb->s_locked_inodes);
--- 2.5.26/mm/page-writeback.c~writeback-scalability-throttling	Tue Jul 16 21:47:18 2002
+++ 2.5.26-akpm/mm/page-writeback.c	Tue Jul 16 21:47:18 2002
@@ -37,7 +37,7 @@
  * will look to see if it needs to force writeback or throttling.  Probably
  * should be scaled by memory size.
  */
-#define RATELIMIT_PAGES		1000
+#define RATELIMIT_PAGES		((512 * 1024) / PAGE_SIZE)
 
 /*
  * When balance_dirty_pages decides that the caller needs to perform some
@@ -45,7 +45,7 @@
  * It should be somewhat larger than RATELIMIT_PAGES to ensure that reasonably
  * large amounts of I/O are submitted.
  */
-#define SYNC_WRITEBACK_PAGES	1500
+#define SYNC_WRITEBACK_PAGES	((RATELIMIT_PAGES * 3) / 2)
 
 
 /* The following parameters are exported via /proc/sys/vm */
@@ -108,6 +108,7 @@ void balance_dirty_pages(struct address_
 	struct page_state ps;
 	int background_thresh, async_thresh, sync_thresh;
 	unsigned long dirty_and_writeback;
+	struct backing_dev_info *bdi;
 
 	get_page_state(&ps);
 	dirty_and_writeback = ps.nr_dirty + ps.nr_writeback;
@@ -115,21 +116,21 @@ void balance_dirty_pages(struct address_
 	background_thresh = (dirty_background_ratio * tot) / 100;
 	async_thresh = (dirty_async_ratio * tot) / 100;
 	sync_thresh = (dirty_sync_ratio * tot) / 100;
+	bdi = mapping->backing_dev_info;
 
 	if (dirty_and_writeback > sync_thresh) {
 		int nr_to_write = SYNC_WRITEBACK_PAGES;
 
-		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_LAST, NULL);
+		writeback_backing_dev(bdi, &nr_to_write, WB_SYNC_LAST, NULL);
 		get_page_state(&ps);
 	} else if (dirty_and_writeback > async_thresh) {
 		int nr_to_write = SYNC_WRITEBACK_PAGES;
 
-		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, NULL);
+		writeback_backing_dev(bdi, &nr_to_write, WB_SYNC_NONE, NULL);
 		get_page_state(&ps);
 	}
 
-	if (!writeback_in_progress(mapping->backing_dev_info) &&
-				ps.nr_dirty > background_thresh)
+	if (!writeback_in_progress(bdi) && ps.nr_dirty > background_thresh)
 		pdflush_operation(background_writeout, 0);
 }
 
--- 2.5.26/fs/block_dev.c~writeback-scalability-throttling	Tue Jul 16 21:47:18 2002
+++ 2.5.26-akpm/fs/block_dev.c	Tue Jul 16 21:47:18 2002
@@ -196,6 +196,7 @@ static struct file_system_type bd_type =
 };
 
 static struct vfsmount *bd_mnt;
+struct super_block *blockdev_superblock;
 
 /*
  * bdev cache handling - shamelessly stolen from inode.c
@@ -251,6 +252,7 @@ void __init bdev_cache_init(void)
 	err = PTR_ERR(bd_mnt);
 	if (IS_ERR(bd_mnt))
 		panic("Cannot create bdev pseudo-fs");
+	blockdev_superblock = bd_mnt->mnt_sb;	/* For writeback */
 }
 
 /*
@@ -567,13 +569,6 @@ static int do_open(struct block_device *
 			}
 		}
 	}
-	if (bdev->bd_inode->i_data.backing_dev_info ==
-				&default_backing_dev_info) {
-		struct backing_dev_info *bdi = blk_get_backing_dev_info(bdev);
-		if (bdi == NULL)
-			bdi = &default_backing_dev_info;
-		inode->i_data.backing_dev_info = bdi;
-	}
 	if (bdev->bd_op->open) {
 		ret = bdev->bd_op->open(inode, file);
 		if (ret)
@@ -594,6 +589,16 @@ static int do_open(struct block_device *
 			bdev->bd_queue =  p->queue(dev);
 		else
 			bdev->bd_queue = &p->request_queue;
+		if (bdev->bd_inode->i_data.backing_dev_info ==
+					&default_backing_dev_info) {
+			struct backing_dev_info *bdi;
+
+			bdi = blk_get_backing_dev_info(bdev);
+			if (bdi == NULL)
+				bdi = &default_backing_dev_info;
+			inode->i_data.backing_dev_info = bdi;
+			bdev->bd_inode->i_data.backing_dev_info = bdi;
+		}
 	}
 	bdev->bd_openers++;
 	unlock_kernel();

.
