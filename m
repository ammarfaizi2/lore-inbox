Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSIKIKw>; Wed, 11 Sep 2002 04:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSIKIKw>; Wed, 11 Sep 2002 04:10:52 -0400
Received: from packet.digeo.com ([12.110.80.53]:2704 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318510AbSIKIKb>;
	Wed, 11 Sep 2002 04:10:31 -0400
Message-ID: <3D7EFF1E.DC85BB1C@digeo.com>
Date: Wed, 11 Sep 2002 01:30:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] struct writeback_control
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 08:15:09.0996 (UTC) FILETIME=[5870DEC0:01C2596B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The writeback code paths which walk the superblocks and inodes are
getting an increasing arguments passed to them.

The patch wraps those args into the new `struct writeback_control',
and uses that instead.  There is no functional change.

The new writeback_control structure is passed down through the
writeback paths in the place where the old `nr_to_write' pointer used
to be.

writeback_control will be used to pass new information up and down the
writeback paths.  Such as whether the writeback should be
non-blocking....


 fs/ext2/inode.c           |    4 -
 fs/ext3/inode.c           |    4 -
 fs/fs-writeback.c         |  112 ++++++++++++++++++----------------------------
 fs/jfs/inode.c            |    5 +-
 fs/mpage.c                |    6 +-
 include/linux/fs.h        |    8 ++-
 include/linux/mpage.h     |    8 ++-
 include/linux/writeback.h |   22 ++++++---
 mm/filemap.c              |    6 ++
 mm/page-writeback.c       |   57 +++++++++++++++--------
 mm/page_io.c              |    4 -
 mm/vmscan.c               |   11 ++--
 12 files changed, 133 insertions(+), 114 deletions(-)

--- 2.5.34/fs/fs-writeback.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/fs/fs-writeback.c	Mon Sep  9 12:24:52 2002
@@ -111,8 +111,7 @@ static void write_inode(struct inode *in
 /*
  * Write a single inode's dirty pages and inode data out to disk.
  * If `sync' is set, wait on the writeout.
- * If `nr_to_write' is not NULL, subtract the number of written pages
- * from *nr_to_write.
+ * Subtract the number of written pages from nr_to_write.
  *
  * Normally it is not legal for a single process to lock more than one
  * page at a time, due to ab/ba deadlock problems.  But writepages()
@@ -127,7 +126,9 @@ static void write_inode(struct inode *in
  *
  * Called under inode_lock.
  */
-static void __sync_single_inode(struct inode *inode, int wait, int *nr_to_write)
+static void
+__sync_single_inode(struct inode *inode, int wait,
+			struct writeback_control *wbc)
 {
 	unsigned dirty;
 	unsigned long orig_dirtied_when;
@@ -144,7 +145,7 @@ static void __sync_single_inode(struct i
 	mapping->dirtied_when = 0;	/* assume it's whole-file writeback */
 	spin_unlock(&inode_lock);
 
-	do_writepages(mapping, nr_to_write);
+	do_writepages(mapping, wbc);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
@@ -181,7 +182,8 @@ static void __sync_single_inode(struct i
  * Write out an inode's dirty pages.  Called under inode_lock.
  */
 static void
-__writeback_single_inode(struct inode *inode, int sync, int *nr_to_write)
+__writeback_single_inode(struct inode *inode, int sync,
+			struct writeback_control *wbc)
 {
 	if (current_is_pdflush() && (inode->i_state & I_LOCK))
 		return;
@@ -193,7 +195,7 @@ __writeback_single_inode(struct inode *i
 		iput(inode);
 		spin_lock(&inode_lock);
 	}
-	__sync_single_inode(inode, sync, nr_to_write);
+	__sync_single_inode(inode, sync, wbc);
 }
 
 /*
@@ -226,8 +228,7 @@ __writeback_single_inode(struct inode *i
  * thrlttled threads: we don't want them all piling up on __wait_on_inode.
  */
 static void
-sync_sb_inodes(struct backing_dev_info *single_bdi, struct super_block *sb,
-	int sync_mode, int *nr_to_write, unsigned long *older_than_this)
+sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
 {
 	struct list_head *tmp;
 	struct list_head *head;
@@ -241,7 +242,7 @@ sync_sb_inodes(struct backing_dev_info *
 		struct backing_dev_info *bdi;
 		int really_sync;
 
-		if (single_bdi && mapping->backing_dev_info != single_bdi) {
+		if (wbc->bdi && mapping->backing_dev_info != wbc->bdi) {
 			if (sb != blockdev_superblock)
 				break;		/* inappropriate superblock */
 			list_move(&inode->i_list, &sb->s_dirty);
@@ -252,23 +253,23 @@ sync_sb_inodes(struct backing_dev_info *
 		if (time_after(mapping->dirtied_when, start))
 			break;
 
-		if (older_than_this &&
-			time_after(mapping->dirtied_when, *older_than_this))
+		if (wbc->older_than_this && time_after(mapping->dirtied_when,
+						*wbc->older_than_this))
 			goto out;
 
 		bdi = mapping->backing_dev_info;
 		if (current_is_pdflush() && !writeback_acquire(bdi))
 			break;
 
-		really_sync = (sync_mode == WB_SYNC_ALL);
-		if ((sync_mode == WB_SYNC_LAST) && (head->prev == head))
+		really_sync = (wbc->sync_mode == WB_SYNC_ALL);
+		if ((wbc->sync_mode == WB_SYNC_LAST) && (head->prev == head))
 			really_sync = 1;
 
 		BUG_ON(inode->i_state & I_FREEING);
 		__iget(inode);
 		list_move(&inode->i_list, &sb->s_dirty);
-		__writeback_single_inode(inode, really_sync, nr_to_write);
-		if (sync_mode == WB_SYNC_HOLD) {
+		__writeback_single_inode(inode, really_sync, wbc);
+		if (wbc->sync_mode == WB_SYNC_HOLD) {
 			mapping->dirtied_when = jiffies;
 			list_move(&inode->i_list, &sb->s_dirty);
 		}
@@ -277,7 +278,7 @@ sync_sb_inodes(struct backing_dev_info *
 		spin_unlock(&inode_lock);
 		iput(inode);
 		spin_lock(&inode_lock);
-		if (nr_to_write && *nr_to_write <= 0)
+		if (wbc->nr_to_write <= 0)
 			break;
 	}
 out:
@@ -288,16 +289,26 @@ out:
 }
 
 /*
+ * Start writeback of dirty pagecache data against all unlocked inodes.
+ *
+ * Note:
+ * We don't need to grab a reference to superblock here. If it has non-empty
+ * ->s_dirty it's hadn't been killed yet and kill_super() won't proceed
+ * past sync_inodes_sb() until both the ->s_dirty and ->s_io lists are
+ * empty. Since __sync_single_inode() regains inode_lock before it finally moves
+ * inode from superblock lists we are OK.
+ *
+ * If `older_than_this' is non-zero then only flush inodes which have a
+ * flushtime older than *older_than_this.
+ *
  * If `bdi' is non-zero then we will scan the first inode against each
  * superblock until we find the matching ones.  One group will be the dirty
  * inodes against a filesystem.  Then when we hit the dummy blockdev superblock,
  * sync_sb_inodes will seekout the blockdev which matches `bdi'.  Maybe not
  * super-efficient but we're about to do a ton of I/O...
  */
-static void
-__writeback_unlocked_inodes(struct backing_dev_info *bdi, int *nr_to_write,
-				enum writeback_sync_modes sync_mode,
-				unsigned long *older_than_this)
+void
+writeback_inodes(struct writeback_control *wbc)
 {
 	struct super_block *sb;
 
@@ -307,11 +318,10 @@ __writeback_unlocked_inodes(struct backi
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
 		if (!list_empty(&sb->s_dirty) || !list_empty(&sb->s_io)) {
 			spin_unlock(&sb_lock);
-			sync_sb_inodes(bdi, sb, sync_mode, nr_to_write,
-					older_than_this);
+			sync_sb_inodes(sb, wbc);
 			spin_lock(&sb_lock);
 		}
-		if (nr_to_write && *nr_to_write <= 0)
+		if (wbc->nr_to_write <= 0)
 			break;
 	}
 	spin_unlock(&sb_lock);
@@ -319,43 +329,6 @@ __writeback_unlocked_inodes(struct backi
 }
 
 /*
- * Start writeback of dirty pagecache data against all unlocked inodes.
- *
- * Note:
- * We don't need to grab a reference to superblock here. If it has non-empty
- * ->s_dirty it's hadn't been killed yet and kill_super() won't proceed
- * past sync_inodes_sb() until both the ->s_dirty and ->s_io lists are
- * empty. Since __sync_single_inode() regains inode_lock before it finally moves
- * inode from superblock lists we are OK.
- *
- * If `older_than_this' is non-zero then only flush inodes which have a
- * flushtime older than *older_than_this.
- *
- * This is a "memory cleansing" operation, not a "data integrity" operation.
- */
-void writeback_unlocked_inodes(int *nr_to_write,
-				enum writeback_sync_modes sync_mode,
-				unsigned long *older_than_this)
-{
-	__writeback_unlocked_inodes(NULL, nr_to_write,
-				sync_mode, older_than_this);
-}
-/*
- * Perform writeback of dirty data against a particular queue.
- *
- * This is for writer throttling.  We don't want processes to write back
- * other process's data, espsecially when the other data belongs to a
- * different spindle.
- */
-void writeback_backing_dev(struct backing_dev_info *bdi, int *nr_to_write,
-			enum writeback_sync_modes sync_mode,
-			unsigned long *older_than_this)
-{
-	__writeback_unlocked_inodes(bdi, nr_to_write,
-				sync_mode, older_than_this);
-}
-
-/*
  * writeback and wait upon the filesystem's dirty inodes.  The caller will
  * do this in two passes - one to write, and one to wait.  WB_SYNC_HOLD is
  * used to park the written inodes on sb->s_dirty for the wait pass.
@@ -366,14 +339,17 @@ void writeback_backing_dev(struct backin
 void sync_inodes_sb(struct super_block *sb, int wait)
 {
 	struct page_state ps;
-	int nr_to_write;
+	struct writeback_control wbc = {
+		.bdi		= NULL,
+		.sync_mode	= wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
+		.older_than_this = NULL,
+		.nr_to_write	= 0,
+	};
 
 	get_page_state(&ps);
-	nr_to_write = ps.nr_dirty + ps.nr_dirty / 4;
-
+	wbc.nr_to_write = ps.nr_dirty + ps.nr_dirty / 4;
 	spin_lock(&inode_lock);
-	sync_sb_inodes(NULL, sb, wait ? WB_SYNC_ALL : WB_SYNC_HOLD,
-				&nr_to_write, NULL);
+	sync_sb_inodes(sb, &wbc);
 	spin_unlock(&inode_lock);
 }
 
@@ -466,8 +442,12 @@ void sync_inodes(int wait)
  
 void write_inode_now(struct inode *inode, int sync)
 {
+	struct writeback_control wbc = {
+		.nr_to_write = LONG_MAX,
+	};
+
 	spin_lock(&inode_lock);
-	__writeback_single_inode(inode, sync, NULL);
+	__writeback_single_inode(inode, sync, &wbc);
 	spin_unlock(&inode_lock);
 	if (sync)
 		wait_on_inode(inode);
--- 2.5.34/include/linux/writeback.h~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/include/linux/writeback.h	Mon Sep  9 12:24:52 2002
@@ -33,16 +33,24 @@ enum writeback_sync_modes {
 	WB_SYNC_HOLD =  3,	/* Hold the inode on sb_dirty for sys_sync() */
 };
 
-void writeback_unlocked_inodes(int *nr_to_write,
-			       enum writeback_sync_modes sync_mode,
-			       unsigned long *older_than_this);
+/*
+ * A control structure which tells the writeback code what to do
+ */
+struct writeback_control {
+	struct backing_dev_info *bdi;	/* If !NULL, only write back this
+					   queue */
+	enum writeback_sync_modes sync_mode;
+	unsigned long *older_than_this;	/* If !NULL, only write back inodes
+					   older than this */
+	long nr_to_write;		/* Write this many pages, and decrement
+					   this for each page written */
+};
+	
+void writeback_inodes(struct writeback_control *wbc);
 void wake_up_inode(struct inode *inode);
 void __wait_on_inode(struct inode * inode);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
-void writeback_backing_dev(struct backing_dev_info *bdi, int *nr_to_write,
-			enum writeback_sync_modes sync_mode,
-			unsigned long *older_than_this);
 
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
@@ -65,7 +73,7 @@ extern int dirty_expire_centisecs;
 void balance_dirty_pages(struct address_space *mapping);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
-int do_writepages(struct address_space *mapping, int *nr_to_write);
+int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 
 /* pdflush.c */
 extern int nr_pdflush_threads;	/* Global so it can be exported to sysctl
--- 2.5.34/mm/page-writeback.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/mm/page-writeback.c	Mon Sep  9 12:24:52 2002
@@ -51,7 +51,7 @@ static long total_pages;
  * It should be somewhat larger than RATELIMIT_PAGES to ensure that reasonably
  * large amounts of I/O are submitted.
  */
-static inline int sync_writeback_pages(void)
+static inline long sync_writeback_pages(void)
 {
 	return ratelimit_pages + ratelimit_pages / 2;
 }
@@ -126,14 +126,24 @@ void balance_dirty_pages(struct address_
 	bdi = mapping->backing_dev_info;
 
 	if (dirty_and_writeback > sync_thresh) {
-		int nr_to_write = sync_writeback_pages();
+		struct writeback_control wbc = {
+			.bdi		= bdi,
+			.sync_mode	= WB_SYNC_LAST,
+			.older_than_this = NULL,
+			.nr_to_write	= sync_writeback_pages(),
+		};
 
-		writeback_backing_dev(bdi, &nr_to_write, WB_SYNC_LAST, NULL);
+		writeback_inodes(&wbc);
 		get_page_state(&ps);
 	} else if (dirty_and_writeback > async_thresh) {
-		int nr_to_write = sync_writeback_pages();
+		struct writeback_control wbc = {
+			.bdi		= bdi,
+			.sync_mode	= WB_SYNC_NONE,
+			.older_than_this = NULL,
+			.nr_to_write	= sync_writeback_pages(),
+		};
 
-		writeback_backing_dev(bdi, &nr_to_write, WB_SYNC_NONE, NULL);
+		writeback_inodes(&wbc);
 		get_page_state(&ps);
 	}
 
@@ -177,7 +187,12 @@ static void background_writeout(unsigned
 {
 	long min_pages = _min_pages;
 	long background_thresh;
-	int nr_to_write;
+	struct writeback_control wbc = {
+		.bdi		= NULL,
+		.sync_mode	= WB_SYNC_NONE,
+		.older_than_this = NULL,
+		.nr_to_write	= 0,
+	};
 
 	CHECK_EMERGENCY_SYNC
 
@@ -185,14 +200,13 @@ static void background_writeout(unsigned
 
 	do {
 		struct page_state ps;
-
 		get_page_state(&ps);
 		if (ps.nr_dirty < background_thresh && min_pages <= 0)
 			break;
-		nr_to_write = MAX_WRITEBACK_PAGES;
-		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, NULL);
-		min_pages -= MAX_WRITEBACK_PAGES - nr_to_write;
-	} while (nr_to_write <= 0);
+		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
+		writeback_inodes(&wbc);
+		min_pages -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
+	} while (wbc.nr_to_write <= 0);
 	blk_run_queues();
 }
 
@@ -230,7 +244,12 @@ static void wb_kupdate(unsigned long arg
 	unsigned long start_jif;
 	unsigned long next_jif;
 	struct page_state ps;
-	int nr_to_write;
+	struct writeback_control wbc = {
+		.bdi		= NULL,
+		.sync_mode	= WB_SYNC_NONE,
+		.older_than_this = &oldest_jif,
+		.nr_to_write	= 0,
+	};
 
 	sync_supers();
 	get_page_state(&ps);
@@ -238,8 +257,8 @@ static void wb_kupdate(unsigned long arg
 	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
 	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
-	nr_to_write = ps.nr_dirty;
-	writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, &oldest_jif);
+	wbc.nr_to_write = ps.nr_dirty;
+	writeback_inodes(&wbc);
 	blk_run_queues();
 	yield();
 
@@ -351,7 +370,7 @@ module_init(page_writeback_init);
  * So.  The proper fix is to leave the page locked-and-dirty and to pass
  * it all the way down.
  */
-int generic_vm_writeback(struct page *page, int *nr_to_write)
+int generic_vm_writeback(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 
@@ -363,7 +382,7 @@ int generic_vm_writeback(struct page *pa
 	unlock_page(page);
 
 	if (inode) {
-		do_writepages(inode->i_mapping, nr_to_write);
+		do_writepages(inode->i_mapping, wbc);
 
 		/*
 		 * This iput() will internally call ext2_discard_prealloc(),
@@ -392,11 +411,11 @@ int generic_vm_writeback(struct page *pa
 }
 EXPORT_SYMBOL(generic_vm_writeback);
 
-int do_writepages(struct address_space *mapping, int *nr_to_write)
+int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	if (mapping->a_ops->writepages)
-		return mapping->a_ops->writepages(mapping, nr_to_write);
-	return generic_writepages(mapping, nr_to_write);
+		return mapping->a_ops->writepages(mapping, wbc);
+	return generic_writepages(mapping, wbc);
 }
 
 /**
--- 2.5.34/include/linux/mpage.h~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/include/linux/mpage.h	Mon Sep  9 12:24:52 2002
@@ -10,14 +10,16 @@
  * nested includes.  Get it right in the .c file).
  */
 
+struct writeback_control;
+
 int mpage_readpages(struct address_space *mapping, struct list_head *pages,
 				unsigned nr_pages, get_block_t get_block);
 int mpage_readpage(struct page *page, get_block_t get_block);
 int mpage_writepages(struct address_space *mapping,
-		int *nr_to_write, get_block_t get_block);
+		struct writeback_control *wbc, get_block_t get_block);
 
 static inline int
-generic_writepages(struct address_space *mapping, int *nr_to_write)
+generic_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
-	return mpage_writepages(mapping, nr_to_write, NULL);
+	return mpage_writepages(mapping, wbc, NULL);
 }
--- 2.5.34/fs/mpage.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/fs/mpage.c	Mon Sep  9 12:24:52 2002
@@ -492,7 +492,7 @@ out:
  * address space and writepage() all of them.
  * 
  * @mapping: address space structure to write
- * @nr_to_write: subtract the number of written pages from *@nr_to_write
+ * @wbc: subtract the number of written pages from *@wbc->nr_to_write
  * @get_block: the filesystem's block mapper function.
  *             If this is NULL then use a_ops->writepage.  Otherwise, go
  *             direct-to-BIO.
@@ -528,7 +528,7 @@ out:
  */
 int
 mpage_writepages(struct address_space *mapping,
-			int *nr_to_write, get_block_t get_block)
+		struct writeback_control *wbc, get_block_t get_block)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -591,7 +591,7 @@ mpage_writepages(struct address_space *m
 				__set_page_dirty_nobuffers(page);
 				ret = 0;
 			}
-			if (ret || (nr_to_write && --(*nr_to_write) <= 0))
+			if (ret || (--(wbc->nr_to_write) <= 0))
 				done = 1;
 		} else {
 			unlock_page(page);
--- 2.5.34/include/linux/fs.h~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/include/linux/fs.h	Mon Sep  9 12:24:52 2002
@@ -279,6 +279,7 @@ struct iattr {
  */
 struct page;
 struct address_space;
+struct writeback_control;
 
 struct address_space_operations {
 	int (*writepage)(struct page *);
@@ -286,10 +287,10 @@ struct address_space_operations {
 	int (*sync_page)(struct page *);
 
 	/* Write back some dirty pages from this mapping. */
-	int (*writepages)(struct address_space *, int *nr_to_write);
+	int (*writepages)(struct address_space *, struct writeback_control *);
 
 	/* Perform a writeback as a memory-freeing operation. */
-	int (*vm_writeback)(struct page *, int *nr_to_write);
+	int (*vm_writeback)(struct page *, struct writeback_control *);
 
 	/* Set a page dirty */
 	int (*set_page_dirty)(struct page *page);
@@ -1259,7 +1260,8 @@ extern loff_t generic_file_llseek(struct
 extern loff_t remote_llseek(struct file *file, loff_t offset, int origin);
 extern int generic_file_open(struct inode * inode, struct file * filp);
 
-extern int generic_vm_writeback(struct page *page, int *nr_to_write);
+extern int generic_vm_writeback(struct page *page,
+				struct writeback_control *wbc);
 
 extern struct file_operations generic_ro_fops;
 
--- 2.5.34/mm/vmscan.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/mm/vmscan.c	Mon Sep  9 12:24:52 2002
@@ -174,15 +174,18 @@ shrink_list(struct list_head *page_list,
 		 */
 		if (PageDirty(page) && is_page_cache_freeable(page) &&
 					mapping && may_enter_fs) {
-			int (*writeback)(struct page *, int *);
+			int (*writeback)(struct page *,
+					struct writeback_control *);
 			const int cluster_size = SWAP_CLUSTER_MAX;
-			int nr_to_write = cluster_size;
+			struct writeback_control wbc = {
+				.nr_to_write = cluster_size,
+			};
 
 			writeback = mapping->a_ops->vm_writeback;
 			if (writeback == NULL)
 				writeback = generic_vm_writeback;
-			(*writeback)(page, &nr_to_write);
-			*max_scan -= (cluster_size - nr_to_write);
+			(*writeback)(page, &wbc);
+			*max_scan -= (cluster_size - wbc.nr_to_write);
 			goto keep;
 		}
 
--- 2.5.34/fs/ext2/inode.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/fs/ext2/inode.c	Mon Sep  9 12:24:52 2002
@@ -627,13 +627,13 @@ ext2_direct_IO(int rw, struct inode *ino
 }
 
 static int
-ext2_writepages(struct address_space *mapping, int *nr_to_write)
+ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
 	int err;
 
 	ret = write_mapping_buffers(mapping);
-	err = mpage_writepages(mapping, nr_to_write, ext2_get_block);
+	err = mpage_writepages(mapping, wbc, ext2_get_block);
 	if (!ret)
 		ret = err;
 	return ret;
--- 2.5.34/fs/ext3/inode.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/fs/ext3/inode.c	Mon Sep  9 12:24:52 2002
@@ -1475,13 +1475,13 @@ struct address_space_operations ext3_aop
 /* For writeback mode, we can use mpage_writepages() */
 
 static int
-ext3_writepages(struct address_space *mapping, int *nr_to_write)
+ext3_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
 	int err;
 
 	ret = write_mapping_buffers(mapping);
-	err = mpage_writepages(mapping, nr_to_write, ext3_get_block);
+	err = mpage_writepages(mapping, wbc, ext3_get_block);
 	if (!ret)
 		ret = err;
 	return ret;
--- 2.5.34/fs/jfs/inode.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/fs/jfs/inode.c	Mon Sep  9 12:24:52 2002
@@ -282,9 +282,10 @@ static int jfs_writepage(struct page *pa
 	return block_write_full_page(page, jfs_get_block);
 }
 
-static int jfs_writepages(struct address_space *mapping, int *nr_to_write)
+static int jfs_writepages(struct address_space *mapping,
+			struct writeback_control *wbc)
 {
-	return mpage_writepages(mapping, nr_to_write, jfs_get_block);
+	return mpage_writepages(mapping, wbc, jfs_get_block);
 }
 
 static int jfs_readpage(struct file *file, struct page *page)
--- 2.5.34/mm/page_io.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/mm/page_io.c	Mon Sep  9 12:24:52 2002
@@ -123,12 +123,12 @@ out:
  * Swap pages are !PageLocked and PageWriteback while under writeout so that
  * memory allocators will throttle against them.
  */
-static int swap_vm_writeback(struct page *page, int *nr_to_write)
+static int swap_vm_writeback(struct page *page, struct writeback_control *wbc)
 {
 	struct address_space *mapping = page->mapping;
 
 	unlock_page(page);
-	return generic_writepages(mapping, nr_to_write);
+	return generic_writepages(mapping, wbc);
 }
 
 struct address_space_operations swap_aops = {
--- 2.5.34/mm/filemap.c~writeback-control	Mon Sep  9 12:24:52 2002
+++ 2.5.34-akpm/mm/filemap.c	Mon Sep  9 12:24:52 2002
@@ -486,9 +486,13 @@ EXPORT_SYMBOL(fail_writepage);
 int filemap_fdatawrite(struct address_space *mapping)
 {
 	int ret;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = mapping->nrpages * 2,
+	};
 
 	current->flags |= PF_SYNC;
-	ret = do_writepages(mapping, NULL);
+	ret = do_writepages(mapping, &wbc);
 	current->flags &= ~PF_SYNC;
 	return ret;
 }

.
