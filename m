Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSESTiZ>; Sun, 19 May 2002 15:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSESThV>; Sun, 19 May 2002 15:37:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9220 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314957AbSESTg5>;
	Sun, 19 May 2002 15:36:57 -0400
Message-ID: <3CE7FFB1.592A60F4@zip.com.au>
Date: Sun, 19 May 2002 12:40:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 7/15] dirty inode management
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix the "race with umount" in __sync_list().  __sync_list() no longer
puts inodes onto a local list while writing them out.

The super_block.sb_dirty list is kept time-ordered.  Mappings which
have the "oldest" ->dirtied_when are kept at sb->s_dirty.prev.

So the time-based writeback (kupdate) can just bale out when it
encounters a not-old-enough mapping, rather than walking the entire
list.

dirtied_when is set on the *first* dirtying of a mapping.  So once the
mapping is marked dirty it strictly retains its place on s_dirty until
it reaches the oldest end and is written out.  So frequently-dirtied
mappings don't stay dirty at the head of the list for all time.

That local inode list was there for livelock avoidance.  Livelock is
instead avoided by looking at each mapping's ->dirtied_when.  If we
encounter one which was dirtied after this invokation of __sync_list(),
then just bale out - the sync functions are only required to write out
data which was dirty at the time when they were called.

Keeping the s_dirty list in time-order is the right thing to do anyway
- so all the various writeback callers always work against the oldest
data.


=====================================

--- 2.5.16/fs/fs-writeback.c~sync_one-fix	Sun May 19 11:49:47 2002
+++ 2.5.16-akpm/fs/fs-writeback.c	Sun May 19 12:02:58 2002
@@ -62,8 +62,14 @@ void __mark_inode_dirty(struct inode *in
 
 	spin_lock(&inode_lock);
 	if ((inode->i_state & flags) != flags) {
+		const int was_dirty = inode->i_state & I_DIRTY;
+		struct address_space *mapping = inode->i_mapping;
+
 		inode->i_state |= flags;
 
+		if (!was_dirty)
+			mapping->dirtied_when = jiffies;
+
 		/*
 		 * If the inode is locked, just update its dirty state. 
 		 * The unlocker will place the inode on the appropriate
@@ -78,10 +84,15 @@ void __mark_inode_dirty(struct inode *in
 		 */
 		if (list_empty(&inode->i_hash) && !S_ISBLK(inode->i_mode))
 			goto same_list;
-		if (inode->i_mapping->dirtied_when == 0)
-			inode->i_mapping->dirtied_when = jiffies;
-		list_del(&inode->i_list);
-		list_add(&inode->i_list, &sb->s_dirty);
+
+		/*
+		 * If the inode was already on s_dirty, don't reposition
+		 * it (that would break s_dirty time-ordering).
+		 */
+		if (!was_dirty) {
+			list_del(&inode->i_list);
+			list_add(&inode->i_list, &sb->s_dirty);
+		}
 	}
 same_list:
 	spin_unlock(&inode_lock);
@@ -116,18 +127,20 @@ static inline void write_inode(struct in
 static void __sync_single_inode(struct inode *inode, int wait, int *nr_to_write)
 {
 	unsigned dirty;
+	unsigned long orig_dirtied_when;
 	struct address_space *mapping = inode->i_mapping;
 
 	list_del(&inode->i_list);
 	list_add(&inode->i_list, &inode->i_sb->s_locked_inodes);
 
-	if (inode->i_state & I_LOCK)
-		BUG();
+	BUG_ON(inode->i_state & I_LOCK);
 
 	/* Set I_LOCK, reset I_DIRTY */
 	dirty = inode->i_state & I_DIRTY;
 	inode->i_state |= I_LOCK;
 	inode->i_state &= ~I_DIRTY;
+	orig_dirtied_when = mapping->dirtied_when;
+	mapping->dirtied_when = 0;	/* assume it's whole-file writeback */
 	spin_unlock(&inode_lock);
 
 	if (wait)
@@ -145,36 +158,26 @@ static void __sync_single_inode(struct i
 	if (wait)
 		filemap_fdatawait(mapping);
 
-	/*
-	 * For non-blocking writeout (wait == 0), we still
-	 * count the inode as being clean.
-	 */
 	spin_lock(&inode_lock);
 
-	/*
-	 * Did we write back all the pages?
-	 */
-	if (nr_to_write && *nr_to_write == 0) {
-		/*
-		 * Maybe not
-		 */
-		if (!list_empty(&mapping->dirty_pages))	/* No lock needed */
-			inode->i_state |= I_DIRTY_PAGES;
-	}
-
 	inode->i_state &= ~I_LOCK;
 	if (!(inode->i_state & I_FREEING)) {
-		struct list_head *to;
-		if (inode->i_state & I_DIRTY)
-			to = &inode->i_sb->s_dirty;
-		else if (atomic_read(&inode->i_count))
-			to = &inode_in_use;
-		else
-			to = &inode_unused;
 		list_del(&inode->i_list);
-		list_add(&inode->i_list, to);
+		if (!list_empty(&mapping->dirty_pages)) {
+		 	/* Not a whole-file writeback */
+			mapping->dirtied_when = orig_dirtied_when;
+			inode->i_state |= I_DIRTY_PAGES;
+			list_add_tail(&inode->i_list, &inode->i_sb->s_dirty);
+		} else if (inode->i_state & I_DIRTY) {
+			list_add(&inode->i_list, &inode->i_sb->s_dirty);
+		} else if (atomic_read(&inode->i_count)) {
+			list_add(&inode->i_list, &inode_in_use);
+		} else {
+			list_add(&inode->i_list, &inode_unused);
+		}
 	}
-	wake_up(&inode->i_wait);
+	if (waitqueue_active(&inode->i_wait))
+		wake_up(&inode->i_wait);
 }
 
 /*
@@ -201,38 +204,34 @@ void writeback_single_inode(struct inode
 }
 
 /*
- * Write out a list of inodes' pages, and the inode itself.
+ * Write out a list of dirty inodes.
  *
- * If `sync' is true, wait on writeout of the last mapping
- * which we write.
+ * If `sync' is true, wait on writeout of the last mapping which we write.
  *
  * If older_than_this is non-NULL, then only write out mappings which
  * had their first dirtying at a time earlier than *older_than_this.
  *
  * Called under inode_lock.
- *
- * FIXME: putting all the inodes on a local list could introduce a
- * race with umount.  Bump the superblock refcount?
  */
 static void __sync_list(struct list_head *head, int sync_mode,
 		int *nr_to_write, unsigned long *older_than_this)
 {
-	struct list_head * tmp;
-	LIST_HEAD(hold);	/* Unready inodes go here */
+	struct list_head *tmp;
+	const unsigned long start = jiffies;	/* livelock avoidance */
 
 	while ((tmp = head->prev) != head) {
 		struct inode *inode = list_entry(tmp, struct inode, i_list);
 		struct address_space *mapping = inode->i_mapping;
 		int really_sync;
 
-		if (older_than_this && *older_than_this) {
-			if (time_after(mapping->dirtied_when,
-						*older_than_this)) {
-				list_del(&inode->i_list);
-				list_add(&inode->i_list, &hold);
-				continue;
-			}
-		}
+		/* Was this inode dirtied after __sync_list was called? */
+		if (time_after(mapping->dirtied_when, start))
+			break;
+
+		if (older_than_this &&
+			time_after(mapping->dirtied_when, *older_than_this))
+			break;
+
 		really_sync = (sync_mode == WB_SYNC_ALL);
 		if ((sync_mode == WB_SYNC_LAST) && (head->prev == head))
 			really_sync = 1;
@@ -240,11 +239,7 @@ static void __sync_list(struct list_head
 		if (nr_to_write && *nr_to_write == 0)
 			break;
 	}
-	/*
-	 * Put the not-ready inodes back
-	 */
-	if (!list_empty(&hold))
-		list_splice(&hold, head);
+	return;
 }
 
 /*
@@ -258,8 +253,7 @@ static void __sync_list(struct list_head
  * inode from superblock lists we are OK.
  *
  * If `older_than_this' is non-zero then only flush inodes which have a
- * flushtime older than *older_than_this.  Unless *older_than_this is
- * zero.  In which case we flush everything, like the old (dumb) wakeup_bdflush.
+ * flushtime older than *older_than_this.
  */
 void writeback_unlocked_inodes(int *nr_to_write, int sync_mode,
 				unsigned long *older_than_this)
@@ -434,11 +428,13 @@ void try_to_writeback_unused_inodes(unsi
 	spin_lock(&inode_lock);
 	spin_lock(&sb_lock);
 	sb = sb_entry(super_blocks.next);
-	for (; nr_inodes && sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
+	for (; nr_inodes && sb != sb_entry(&super_blocks);
+			sb = sb_entry(sb->s_list.next)) {
 		if (list_empty(&sb->s_dirty))
 			continue;
 		spin_unlock(&sb_lock);
-		nr_inodes = __try_to_writeback_unused_list(&sb->s_dirty, nr_inodes);
+		nr_inodes = __try_to_writeback_unused_list(&sb->s_dirty,
+							nr_inodes);
 		spin_lock(&sb_lock);
 	}
 	spin_unlock(&sb_lock);
--- 2.5.16/mm/page-writeback.c~sync_one-fix	Sun May 19 11:49:47 2002
+++ 2.5.16-akpm/mm/page-writeback.c	Sun May 19 12:02:58 2002
@@ -175,10 +175,6 @@ static int wb_writeback_jifs = 5 * HZ;
  * just walks the superblock inode list, writing back any inodes which are
  * older than a specific point in time.
  *
- * Spot the bug: at jiffies wraparound, the attempt to set the inode's dirtying
- * time won't work, because zero means not-dirty.  That's OK. The data will get
- * written out later by the VM (at least).
- *
  * We also limit the number of pages which are written out, to avoid writing
  * huge amounts of data against a single file, which would cause memory
  * allocators to block for too long.
@@ -328,7 +324,6 @@ int generic_writeback_mapping(struct add
 
 	list_splice(&mapping->dirty_pages, &mapping->io_pages);
 	INIT_LIST_HEAD(&mapping->dirty_pages);
-	mapping->dirtied_when = 0;
 
         while (!list_empty(&mapping->io_pages) && !done) {
 		struct page *page = list_entry(mapping->io_pages.prev,


-
