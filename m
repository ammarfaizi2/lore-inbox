Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSESTdq>; Sun, 19 May 2002 15:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314906AbSESTdp>; Sun, 19 May 2002 15:33:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1284 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314938AbSESTdV>;
	Sun, 19 May 2002 15:33:21 -0400
Message-ID: <3CE7FED7.E6B79928@zip.com.au>
Date: Sun, 19 May 2002 12:36:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 3/15] i_dirty_buffers locking fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch fixes a race between try_to_free_buffers' call to
__remove_inode_queue() and other users of b_inode_buffers
(fsync_inode_buffers and mark_buffer_dirty_inode()).  They are
presently taking different locks.

The patch relocates and redefines and clarifies(?) the role of
inode.i_dirty_buffers.

The 2.4 definition of i_dirty_buffers is "a list of random buffers
which is protected by a kernel-wide lock".  This definition needs to be
narrowed in the 2.5 context.  It is now

"a list of buffers from a different mapping, protected by a lock within
that mapping".  This list of buffers is specifically for fsync().

As this is a "data plane" operation, all the structures have been moved
out of the inode and into the address_space.  So address_space now has:

list_head private_list;

     A list, available to the address_space for any purpose.  If
     that address_space chooses to use the helper functions
     mark_buffer_dirty_inode and sync_mapping_buffers() then this list
     will contain buffer_heads, attached via
     buffer_head.b_assoc_buffers.

     If the address_space does not call those helper functions
     then the list is free for other usage.  The only requirement is
     that the list be list_empty() at destroy_inode() time.

     At least, this is the objective.  At present,
     generic_file_write() will call generic_osync_inode(), which
     expects that list to contain buffer_heads.  So private_list isn't
     useful for anything else yet.

spinlock_t private_lock;

     A spinlock, available to the address_space.

     If the address_space is using try_to_free_buffers(),
     mark_inode_dirty_buffers() and fsync_inode_buffers() then this
     lock is used to protect the private_list of *other* mappings which
     have listed buffers from *this* mapping onto themselves.

     That is: for buffer_heads, mapping_A->private_lock does not
     protect mapping_A->private_list!  It protects the b_assoc_buffers
     list from buffers which are backed by mapping_A and it protects
     mapping_B->private_list, mapping_C->private_list, ...

     So what we have here is a cross-mapping association.  S_ISREG
     mappings maintain a list of buffers from the blockdev's
     address_space which they need to know about for a successful
     fsync().  The locking follows the buffers: the lock in in the
     blockdev's mapping, not in the S_ISREG file's mapping.

     For address_spaces which use try_to_free_buffers,
     private_lock is also (and quite unrelatedly) used for protection
     of the buffer ring at page->private.  Exclusion between
     try_to_free_buffers(), __get_hash_table() and
     __set_page_dirty_buffers().  This is in fact its major use.

address_space *assoc_mapping

    Sigh.  This is the address of the mapping which backs the
    buffers which are attached to private_list.  It's here so that
    generic_osync_inode() can locate the lock which protects this
    mapping's private_list.  Will probably go away.


A consequence of all the above is that:

    a) All the buffers at a mapping_A's ->private_list must come
       from the same mapping, mapping_B.  There is no requirement that
       mapping_B be a blockdev mapping, but that's how it's used.

       There is a BUG() check in mark_buffer_dirty_inode() for this.

    b) blockdev mappings never have any buffers on ->private_list. 
       It just never happens, and doesn't make a lot of sense.

reiserfs is using b_inode_buffers for attaching dependent buffers to its
journal and that caused a few problems.  Fixed in reiserfs_releasepage.patch



=====================================

--- 2.5.16/fs/buffer.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/buffer.c	Sun May 19 12:02:59 2002
@@ -35,7 +35,7 @@
 #include <linux/hash.h>
 #include <asm/bitops.h>
 
-#define BH_ENTRY(list) list_entry((list), struct buffer_head, b_inode_buffers)
+#define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
 /* This is used by some architectures to estimate available memory. */
 atomic_t buffermem_pages = ATOMIC_INIT(0);
@@ -392,30 +392,31 @@ out:
 /*
  * Various filesystems appear to want __get_hash_table to be non-blocking.
  * But it's the page lock which protects the buffers.  To get around this,
- * we get exclusion from try_to_free_buffers with the inode's
- * i_bufferlist_lock.
+ * we get exclusion from try_to_free_buffers with the blockdev mapping's
+ * private_lock.
  *
  * Hack idea: for the blockdev mapping, i_bufferlist_lock contention
  * may be quite high.  This code could TryLock the page, and if that
- * succeeds, there is no need to take i_bufferlist_lock. (But if
- * i_bufferlist_lock is contended then so is mapping->page_lock).
+ * succeeds, there is no need to take private_lock. (But if
+ * private_lock is contended then so is mapping->page_lock).
  */
 struct buffer_head *
 __get_hash_table(struct block_device *bdev, sector_t block, int unused)
 {
-	struct inode * const inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev->bd_inode;
+	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct buffer_head *ret = NULL;
 	unsigned long index;
 	struct buffer_head *bh;
 	struct buffer_head *head;
 	struct page *page;
 
-	index = block >> (PAGE_CACHE_SHIFT - inode->i_blkbits);
-	page = find_get_page(inode->i_mapping, index);
+	index = block >> (PAGE_CACHE_SHIFT - bd_inode->i_blkbits);
+	page = find_get_page(bd_mapping, index);
 	if (!page)
 		goto out;
 
-	spin_lock(&inode->i_bufferlist_lock);
+	spin_lock(&bd_mapping->private_lock);
 	if (!page_has_buffers(page))
 		goto out_unlock;
 	head = page_buffers(page);
@@ -430,40 +431,12 @@ __get_hash_table(struct block_device *bd
 	} while (bh != head);
 	buffer_error();
 out_unlock:
-	spin_unlock(&inode->i_bufferlist_lock);
+	spin_unlock(&bd_mapping->private_lock);
 	page_cache_release(page);
 out:
 	return ret;
 }
 
-void buffer_insert_list(spinlock_t *lock,
-		struct buffer_head *bh, struct list_head *list)
-{
-	spin_lock(lock);
-	list_del(&bh->b_inode_buffers);
-	list_add(&bh->b_inode_buffers, list);
-	spin_unlock(lock);
-}
-
-/*
- * i_bufferlist_lock must be held
- */
-static inline void __remove_inode_queue(struct buffer_head *bh)
-{
-	list_del_init(&bh->b_inode_buffers);
-}
-
-int inode_has_buffers(struct inode *inode)
-{
-	int ret;
-	
-	spin_lock(&inode->i_bufferlist_lock);
-	ret = !list_empty(&inode->i_dirty_buffers);
-	spin_unlock(&inode->i_bufferlist_lock);
-	
-	return ret;
-}
-
 /* If invalidate_buffers() will trash dirty buffers, it means some kind
    of fs corruption is going on. Trashing dirty data always imply losing
    information that was supposed to be just stored on the physical layer
@@ -674,6 +647,78 @@ inline void mark_buffer_async_write(stru
 }
 EXPORT_SYMBOL(mark_buffer_async_write);
 
+
+/*
+ * fs/buffer.c contains helper functions for buffer-backed address space's
+ * fsync functions.  A common requirement for buffer-based filesystems is
+ * that certain data from the backing blockdev needs to be written out for
+ * a successful fsync().  For example, ext2 indirect blocks need to be
+ * written back and waited upon before fsync() returns.
+ *
+ * The functions mark_buffer_inode_dirty(), fsync_inode_buffers(),
+ * inode_has_buffers() and invalidate_inode_buffers() are provided for the
+ * management of a list of dependent buffers at ->i_mapping->private_list.
+ *
+ * Locking is a little subtle: try_to_free_buffers() will remove buffers
+ * from their controlling inode's queue when they are being freed.  But
+ * try_to_free_buffers() will be operating against the *blockdev* mapping
+ * at the time, not against the S_ISREG file which depends on those buffers.
+ * So the locking for private_list is via the private_lock in the address_space
+ * which backs the buffers.  Which is different from the address_space 
+ * against which the buffers are listed.  So for a particular address_space,
+ * mapping->private_lock does *not* protect mapping->private_list!  In fact,
+ * mapping->private_list will always be protected by the backing blockdev's
+ * ->private_lock.
+ *
+ * Which introduces a requirement: all buffers on an address_space's
+ * ->private_list must be from the same address_space: the blockdev's.
+ *
+ * address_spaces which do not place buffers at ->private_list via these
+ * utility functions are free to use private_lock and private_list for
+ * whatever they want.  The only requirement is that list_empty(private_list)
+ * be true at clear_inode() time.
+ *
+ * FIXME: clear_inode should not call invalidate_inode_buffers().  The
+ * filesystems should do that.  invalidate_inode_buffers() should just go
+ * BUG_ON(!list_empty).
+ *
+ * FIXME: mark_buffer_dirty_inode() is a data-plane operation.  It should
+ * take an address_space, not an inode.  And it should be called
+ * mark_buffer_dirty_fsync() to clearly define why those buffers are being
+ * queued up.
+ *
+ * FIXME: mark_buffer_dirty_inode() doesn't need to add the buffer to the
+ * list if it is already on a list.  Because if the buffer is on a list,
+ * it *must* already be on the right one.  If not, the filesystem is being
+ * silly.  This will save a ton of locking.  But first we have to ensure
+ * that buffers are taken *off* the old inode's list when they are freed
+ * (presumably in truncate).  That requires careful auditing of all
+ * filesystems (do it inside bforget()).  It could also be done by bringing
+ * b_inode back.
+ */
+
+void buffer_insert_list(spinlock_t *lock,
+		struct buffer_head *bh, struct list_head *list)
+{
+	spin_lock(lock);
+	list_del(&bh->b_assoc_buffers);
+	list_add(&bh->b_assoc_buffers, list);
+	spin_unlock(lock);
+}
+
+/*
+ * The buffer's backing address_space's private_lock must be held
+ */
+static inline void __remove_assoc_queue(struct buffer_head *bh)
+{
+	list_del_init(&bh->b_assoc_buffers);
+}
+
+int inode_has_buffers(struct inode *inode)
+{
+	return !list_empty(&inode->i_mapping->private_list);
+}
+
 /*
  * osync is designed to support O_SYNC io.  It waits synchronously for
  * all already-submitted IO to complete, but does not queue any new
@@ -709,8 +754,50 @@ repeat:
 	return err;
 }
 
+/**
+ * sync_mapping_buffers - write out and wait upon a mapping's "associated"
+ *                        buffers
+ * @buffer_mapping - the mapping which backs the buffers' data
+ * @mapping - the mapping which wants those buffers written
+ *
+ * Starts I/O against the buffers at mapping->private_list, and waits upon
+ * that I/O.
+ *
+ * Basically, this is a convenience function for fsync().  @buffer_mapping is
+ * the blockdev which "owns" the buffers and @mapping is a file or directory
+ * which needs those buffers to be written for a successful fsync().
+ */
+int sync_mapping_buffers(struct address_space *mapping)
+{
+	struct address_space *buffer_mapping = mapping->assoc_mapping;
+
+	if (buffer_mapping == NULL || list_empty(&mapping->private_list))
+		return 0;
+
+	return fsync_buffers_list(&buffer_mapping->private_lock,
+					&mapping->private_list);
+}
+EXPORT_SYMBOL(sync_mapping_buffers);
+
+void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct address_space *buffer_mapping = bh->b_page->mapping;
+
+	mark_buffer_dirty(bh);
+	if (!mapping->assoc_mapping) {
+		mapping->assoc_mapping = buffer_mapping;
+	} else {
+		if (mapping->assoc_mapping != buffer_mapping)
+			BUG();
+	}
+	buffer_insert_list(&buffer_mapping->private_lock,
+			bh, &mapping->private_list);
+}
+EXPORT_SYMBOL(mark_buffer_dirty_inode);
+
 /*
- * Synchronise all the inode's dirty buffers to the disk.
+ * Write out and wait upon a list of buffers.
  *
  * We have conflicting pressures: we want to make sure that all
  * initially dirty buffers get waited on, but that any subsequently
@@ -739,9 +826,9 @@ int fsync_buffers_list(spinlock_t *lock,
 	spin_lock(lock);
 	while (!list_empty(list)) {
 		bh = BH_ENTRY(list->next);
-		list_del_init(&bh->b_inode_buffers);
+		list_del_init(&bh->b_assoc_buffers);
 		if (buffer_dirty(bh) || buffer_locked(bh)) {
-			list_add(&bh->b_inode_buffers, &tmp);
+			list_add(&bh->b_assoc_buffers, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(lock);
@@ -754,7 +841,7 @@ int fsync_buffers_list(spinlock_t *lock,
 
 	while (!list_empty(&tmp)) {
 		bh = BH_ENTRY(tmp.prev);
-		__remove_inode_queue(bh);
+		__remove_assoc_queue(bh);
 		get_bh(bh);
 		spin_unlock(lock);
 		wait_on_buffer(bh);
@@ -776,16 +863,23 @@ int fsync_buffers_list(spinlock_t *lock,
  * Invalidate any and all dirty buffers on a given inode.  We are
  * probably unmounting the fs, but that doesn't mean we have already
  * done a sync().  Just drop the buffers from the inode list.
+ *
+ * NOTE: we take the inode's blockdev's mapping's private_lock.  Which
+ * assumes that all the buffers are against the blockdev.  Not true
+ * for reiserfs.
  */
 void invalidate_inode_buffers(struct inode *inode)
 {
-	struct list_head * entry;
-	
-	spin_lock(&inode->i_bufferlist_lock);
-	while ((entry = inode->i_dirty_buffers.next) !=
-				&inode->i_dirty_buffers)
-		__remove_inode_queue(BH_ENTRY(entry));
-	spin_unlock(&inode->i_bufferlist_lock);
+	if (inode_has_buffers(inode)) {
+		struct address_space *mapping = inode->i_mapping;
+		struct list_head *list = &mapping->private_list;
+		struct address_space *buffer_mapping = mapping->assoc_mapping;
+
+		spin_lock(&buffer_mapping->private_lock);
+		while (!list_empty(list))
+			__remove_assoc_queue(BH_ENTRY(list->next));
+		spin_unlock(&buffer_mapping->private_lock);
+	}
 }
 
 /*
@@ -939,10 +1033,10 @@ grow_dev_page(struct block_device *bdev,
 	 * lock to be atomic wrt __get_hash_table(), which does not
 	 * run under the page lock.
 	 */
-	spin_lock(&inode->i_bufferlist_lock);
+	spin_lock(&inode->i_mapping->private_lock);
 	link_dev_buffers(page, bh);
 	init_page_buffers(page, bdev, block, size);
-	spin_unlock(&inode->i_bufferlist_lock);
+	spin_unlock(&inode->i_mapping->private_lock);
 	return page;
 
 failed:
@@ -1051,7 +1145,7 @@ __getblk(struct block_device *bdev, sect
  * address_space's dirty_pages list and then attach the address_space's
  * inode to its superblock's dirty inode list.
  *
- * mark_buffer_dirty() is atomic.  It takes inode->i_bufferlist_lock,
+ * mark_buffer_dirty() is atomic.  It takes bh->b_page->mapping->private_lock,
  * mapping->page_lock and the global inode_lock.
  */
 void mark_buffer_dirty(struct buffer_head *bh)
@@ -1237,7 +1331,7 @@ EXPORT_SYMBOL(block_flushpage);
 
 /*
  * We attach and possibly dirty the buffers atomically wrt
- * __set_page_dirty_buffers() via i_bufferlist_lock.  try_to_free_buffers
+ * __set_page_dirty_buffers() via private_lock.  try_to_free_buffers
  * is already excluded via the page lock.
  */
 void create_empty_buffers(struct page *page,
@@ -1255,7 +1349,7 @@ void create_empty_buffers(struct page *p
 	} while (bh);
 	tail->b_this_page = head;
 
-	spin_lock(&page->mapping->host->i_bufferlist_lock);
+	spin_lock(&page->mapping->private_lock);
 	if (PageUptodate(page) || PageDirty(page)) {
 		bh = head;
 		do {
@@ -1267,7 +1361,7 @@ void create_empty_buffers(struct page *p
 		} while (bh != head);
 	}
 	__set_page_buffers(page, head);
-	spin_unlock(&page->mapping->host->i_bufferlist_lock);
+	spin_unlock(&page->mapping->private_lock);
 }
 EXPORT_SYMBOL(create_empty_buffers);
 
@@ -1281,6 +1375,11 @@ EXPORT_SYMBOL(create_empty_buffers);
  * unmap_buffer() for such invalidation, but that was wrong. We definitely
  * don't want to mark the alias unmapped, for example - it would confuse
  * anyone who might pick it with bread() afterwards...
+ *
+ * Also..  Note that bforget() doesn't lock the buffer.  So there can
+ * be writeout I/O going on against recently-freed buffers.  We don't
+ * wait on that I/O in bforget() - it's more efficient to wait on the I/O
+ * only if we really need to.  That happens here.
  */
 static void unmap_underlying_metadata(struct buffer_head *bh)
 {
@@ -2209,7 +2308,7 @@ static void check_ttfb_buffer(struct pag
  * are unused, and releases them if so.
  *
  * Exclusion against try_to_free_buffers may be obtained by either
- * locking the page or by holding its inode's i_bufferlist_lock.
+ * locking the page or by holding its mapping's private_lock.
  *
  * If the page is dirty but all the buffers are clean then we need to
  * be sure to mark the page clean as well.  This is because the page
@@ -2220,7 +2319,7 @@ static void check_ttfb_buffer(struct pag
  * The same applies to regular filesystem pages: if all the buffers are
  * clean then we set the page clean and proceed.  To do that, we require
  * total exclusion from __set_page_dirty_buffers().  That is obtained with
- * i_bufferlist_lock.
+ * private_lock.
  *
  * try_to_free_buffers() is non-blocking.
  */
@@ -2252,7 +2351,8 @@ static /*inline*/ int drop_buffers(struc
 	do {
 		struct buffer_head *next = bh->b_this_page;
 
-		__remove_inode_queue(bh);
+		if (!list_empty(&bh->b_assoc_buffers))
+			__remove_assoc_queue(bh);
 		free_buffer_head(bh);
 		bh = next;
 	} while (bh != head);
@@ -2264,18 +2364,17 @@ failed:
 
 int try_to_free_buffers(struct page *page)
 {
-	struct inode *inode;
+	struct address_space * const mapping = page->mapping;
 	int ret = 0;
 
 	BUG_ON(!PageLocked(page));
 	if (PageWriteback(page))
 		return 0;
 
-	if (page->mapping == NULL)	/* swapped-in anon page */
+	if (mapping == NULL)		/* swapped-in anon page */
 		return drop_buffers(page);
 
-	inode = page->mapping->host;
-	spin_lock(&inode->i_bufferlist_lock);
+	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page);
 	if (ret && !PageSwapCache(page)) {
 		/*
@@ -2288,7 +2387,7 @@ int try_to_free_buffers(struct page *pag
 		 */
 		ClearPageDirty(page);
 	}
-	spin_unlock(&inode->i_bufferlist_lock);
+	spin_unlock(&mapping->private_lock);
 	return ret;
 }
 EXPORT_SYMBOL(try_to_free_buffers);
@@ -2331,7 +2430,7 @@ EXPORT_SYMBOL(alloc_buffer_head);
 
 void free_buffer_head(struct buffer_head *bh)
 {
-	BUG_ON(!list_empty(&bh->b_inode_buffers));
+	BUG_ON(!list_empty(&bh->b_assoc_buffers));
 	mempool_free(bh, bh_mempool);
 }
 EXPORT_SYMBOL(free_buffer_head);
@@ -2344,7 +2443,7 @@ static void init_buffer_head(void *data,
 
 		memset(bh, 0, sizeof(*bh));
 		bh->b_blocknr = -1;
-		INIT_LIST_HEAD(&bh->b_inode_buffers);
+		INIT_LIST_HEAD(&bh->b_assoc_buffers);
 	}
 }
 
--- 2.5.16/fs/inode.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/inode.c	Sun May 19 12:02:58 2002
@@ -106,6 +106,7 @@ static struct inode *alloc_inode(struct 
 		inode->i_data.dirtied_when = 0;
 		inode->i_mapping = &inode->i_data;
 		inode->i_data.ra_pages = &default_ra_pages;
+		inode->i_data.assoc_mapping = NULL;
 		if (sb->s_bdev)
 			inode->i_data.ra_pages = sb->s_bdev->bd_inode->i_mapping->ra_pages;
 		memset(&inode->u, 0, sizeof(inode->u));
@@ -139,13 +140,13 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.locked_pages);
 	INIT_LIST_HEAD(&inode->i_data.io_pages);
 	INIT_LIST_HEAD(&inode->i_dentry);
-	INIT_LIST_HEAD(&inode->i_dirty_buffers);
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	rwlock_init(&inode->i_data.page_lock);
 	spin_lock_init(&inode->i_data.i_shared_lock);
-	spin_lock_init(&inode->i_bufferlist_lock);
+	INIT_LIST_HEAD(&inode->i_data.private_list);
+	spin_lock_init(&inode->i_data.private_lock);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
 }
--- 2.5.16/include/linux/buffer_head.h~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/include/linux/buffer_head.h	Sun May 19 12:02:59 2002
@@ -50,7 +50,7 @@ struct buffer_head {
 	struct block_device *b_bdev;
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
-	struct list_head     b_inode_buffers; /* list of inode dirty buffers */
+	struct list_head b_assoc_buffers; /* associated with another mapping */
 };
 
 
@@ -147,6 +147,8 @@ void create_empty_buffers(struct page *,
 void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
 void buffer_insert_list(spinlock_t *lock,
 			struct buffer_head *, struct list_head *);
+int sync_mapping_buffers(struct address_space *mapping);
+void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
 
 void mark_buffer_async_read(struct buffer_head *bh);
 void mark_buffer_async_write(struct buffer_head *bh);
@@ -217,14 +219,6 @@ static inline void put_bh(struct buffer_
         atomic_dec(&bh->b_count);
 }
 
-static inline void
-mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
-{
-	mark_buffer_dirty(bh);
-	buffer_insert_list(&inode->i_bufferlist_lock,
-			bh, &inode->i_dirty_buffers);
-}
-
 /*
  * If an error happens during the make_request, this function
  * has to be recalled. It marks the buffer as clean and not
@@ -243,11 +237,6 @@ static inline void buffer_IO_error(struc
 	bh->b_end_io(bh, buffer_uptodate(bh));
 }
 
-static inline int fsync_inode_buffers(struct inode *inode)
-{
-	return fsync_buffers_list(&inode->i_bufferlist_lock,
-				&inode->i_dirty_buffers);
-}
 
 static inline void brelse(struct buffer_head *buf)
 {
--- 2.5.16/include/linux/fs.h~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/include/linux/fs.h	Sun May 19 12:02:58 2002
@@ -306,6 +306,7 @@ struct address_space_operations {
 };
 
 struct address_space {
+	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
 	rwlock_t		page_lock;	/* and rwlock protecting it */
 	struct list_head	clean_pages;	/* list of clean pages */
@@ -314,13 +315,15 @@ struct address_space {
 	struct list_head	io_pages;	/* being prepared for I/O */
 	unsigned long		nrpages;	/* number of total pages */
 	struct address_space_operations *a_ops;	/* methods */
-	struct inode		*host;		/* owner: inode, block_device */
 	list_t			i_mmap;		/* list of private mappings */
 	list_t			i_mmap_shared;	/* list of private mappings */
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
 	int			gfp_mask;	/* how to allocate the pages */
 	unsigned long 		*ra_pages;	/* device readahead */
+	spinlock_t		private_lock;	/* for use by the address_space */
+	struct list_head	private_list;	/* ditto */
+	struct address_space	*assoc_mapping;	/* ditto */
 };
 
 struct char_device {
@@ -350,10 +353,6 @@ struct inode {
 	struct list_head	i_hash;
 	struct list_head	i_list;
 	struct list_head	i_dentry;
-
-	struct list_head	i_dirty_buffers;   /* uses i_bufferlist_lock */
-	spinlock_t		i_bufferlist_lock;
-
 	unsigned long		i_ino;
 	atomic_t		i_count;
 	kdev_t			i_dev;
--- 2.5.16/mm/filemap.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/mm/filemap.c	Sun May 19 12:02:59 2002
@@ -42,7 +42,7 @@
  *
  *  pagemap_lru_lock
  *  ->i_shared_lock		(vmtruncate)
- *    ->i_bufferlist_lock	(__free_pte->__set_page_dirty_buffers)
+ *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
  *      ->mapping->page_lock
  *      ->inode_lock		(__mark_inode_dirty)
  *        ->sb_lock		(fs/fs-writeback.c)
--- 2.5.16/mm/page-writeback.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/mm/page-writeback.c	Sun May 19 12:02:58 2002
@@ -450,7 +450,7 @@ EXPORT_SYMBOL(write_one_page);
  * It's better to have clean pages accidentally attached to dirty_pages than to
  * leave dirty pages attached to clean_pages.
  *
- * We use i_bufferlist_lock to lock against try_to_free_buffers while using the
+ * We use private_lock to lock against try_to_free_buffers while using the
  * page's buffer list.  Also use this to protect against clean buffers being
  * added to the page after it was set dirty.
  *
@@ -462,18 +462,15 @@ EXPORT_SYMBOL(write_one_page);
  */
 int __set_page_dirty_buffers(struct page *page)
 {
+	struct address_space * const mapping = page->mapping;
 	int ret = 0;
-	struct address_space *mapping = page->mapping;
-	struct inode *inode;
 
 	if (mapping == NULL) {
 		SetPageDirty(page);
 		goto out;
 	}
 
-	inode = mapping->host;
-
-	spin_lock(&inode->i_bufferlist_lock);
+	spin_lock(&mapping->private_lock);
 
 	if (page_has_buffers(page) && !PageSwapCache(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -496,7 +493,7 @@ int __set_page_dirty_buffers(struct page
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
-	spin_unlock(&inode->i_bufferlist_lock);
+	spin_unlock(&mapping->private_lock);
 out:
 	return ret;
 }
--- 2.5.16/mm/swap_state.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/mm/swap_state.c	Sun May 19 12:02:59 2002
@@ -37,11 +37,10 @@ static struct address_space_operations s
 };
 
 /*
- * swapper_inode is needed only for for i_bufferlist_lock. This
- * avoid special-casing in other parts of the kernel.
+ * swapper_inode doesn't do anything much.  It is really only here to
+ * avoid some special-casing in other parts of the kernel.
  */
 static struct inode swapper_inode = {
-	i_bufferlist_lock:	SPIN_LOCK_UNLOCKED,
 	i_mapping:		&swapper_space,
 };
 
@@ -55,6 +54,8 @@ struct address_space swapper_space = {
 	host:		&swapper_inode,
 	a_ops:		&swap_aops,
 	i_shared_lock:	SPIN_LOCK_UNLOCKED,
+	private_lock:	SPIN_LOCK_UNLOCKED,
+	private_list:	LIST_HEAD_INIT(swapper_space.private_list),
 };
 
 #ifdef SWAP_CACHE_INFO
--- 2.5.16/fs/ntfs/super.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/ntfs/super.c	Sun May 19 12:02:58 2002
@@ -1510,6 +1510,13 @@ static int ntfs_fill_super(struct super_
 	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap);
 	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap_shared);
 	spin_lock_init(&vol->mftbmp_mapping.i_shared_lock);
+	/*
+	 * private_lock and private_list are unused by ntfs.  But they
+	 * are available.
+	 */
+	spin_lock_init(&vol->mftbmp_mapping.private_lock);
+	INIT_LIST_HEAD(&vol->mftbmp_mapping.private_list);
+	vol->mftbmp_mapping.assoc_mapping = NULL;
 	vol->mftbmp_mapping.dirtied_when = 0;
 	vol->mftbmp_mapping.gfp_mask = GFP_HIGHUSER;
 	vol->mftbmp_mapping.ra_pages =
--- 2.5.16/fs/ext3/fsync.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/ext3/fsync.c	Sun May 19 11:49:46 2002
@@ -55,13 +55,13 @@ int ext3_sync_file(struct file * file, s
 	J_ASSERT(ext3_journal_current_handle() == 0);
 
 	/*
-	 * fsync_inode_buffers() just walks i_dirty_buffers and waits
+	 * fsync_inode_buffers() just walks private_list and waits
 	 * on them.  It's a no-op for full data journalling because
-	 * i_dirty_buffers will be ampty.
+	 * private_list will be empty.
 	 * Really, we only need to start I/O on the dirty buffers -
 	 * we'll end up waiting on them in commit.
 	 */
-	ret = fsync_inode_buffers(inode);
+	ret = sync_mapping_buffers(inode->i_mapping);
 	ext3_force_commit(inode->i_sb);
 
 	return ret;
--- 2.5.16/fs/ext3/inode.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/ext3/inode.c	Sun May 19 12:02:59 2002
@@ -1078,14 +1078,8 @@ static int commit_write_fn(handle_t *han
  * We need to pick up the new inode size which generic_commit_write gave us
  * `file' can be NULL - eg, when called from block_symlink().
  *
- * ext3 inode->i_dirty_buffers policy:  If we're journalling data we
- * definitely don't want them to appear on the inode at all - instead
- * we need to manage them at the JBD layer and we need to intercept
- * the relevant sync operations and translate them into journal operations.
- *
- * If we're not journalling data then we can just leave the buffers
- * on ->i_dirty_buffers.  If someone writes them out for us then thanks.
- * Otherwise we'll do it in commit, if we're using ordered data.
+ * ext3 never places buffers on inode->i_mapping->private_list.  metadata
+ * buffers are managed internally.
  */
 
 static int ext3_commit_write(struct file *file, struct page *page,
--- 2.5.16/fs/fs-writeback.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/fs-writeback.c	Sun May 19 12:02:58 2002
@@ -467,43 +467,34 @@ void write_inode_now(struct inode *inode
 /**
  * generic_osync_inode - flush all dirty data for a given inode to disk
  * @inode: inode to write
- * @datasync: if set, don't bother flushing timestamps
+ * @what:  what to write and wait upon
  *
  * This can be called by file_write functions for files which have the
- * O_SYNC flag set, to flush dirty writes to disk.  
+ * O_SYNC flag set, to flush dirty writes to disk.
+ *
+ * @what is a bitmask, specifying which part of the inode's data should be
+ * written and waited upon:
+ *
+ *    OSYNC_DATA:     i_mapping's dirty data
+ *    OSYNC_METADATA: the buffers at i_mapping->private_list
+ *    OSYNC_INODE:    the inode itself
  */
 
 int generic_osync_inode(struct inode *inode, int what)
 {
-	int err = 0, err2 = 0, need_write_inode_now = 0;
-	
-	/* 
-	 * WARNING
-	 *
-	 * Currently, the filesystem write path does not pass the
-	 * filp down to the low-level write functions.  Therefore it
-	 * is impossible for (say) __block_commit_write to know if
-	 * the operation is O_SYNC or not.
-	 *
-	 * Ideally, O_SYNC writes would have the filesystem call
-	 * ll_rw_block as it went to kick-start the writes, and we
-	 * could call osync_inode_buffers() here to wait only for
-	 * those IOs which have already been submitted to the device
-	 * driver layer.  As it stands, if we did this we'd not write
-	 * anything to disk since our writes have not been queued by
-	 * this point: they are still on the dirty LRU.
-	 * 
-	 * So, currently we will call fsync_inode_buffers() instead,
-	 * to flush _all_ dirty buffers for this inode to disk on 
-	 * every O_SYNC write, not just the synchronous I/Os.  --sct
-	 */
+	int err = 0;
+	int need_write_inode_now = 0;
+	int err2;
 
 	if (what & OSYNC_DATA)
-		writeback_single_inode(inode, 0, NULL);
-	if (what & (OSYNC_METADATA|OSYNC_DATA))
-		err = fsync_inode_buffers(inode);
+		err = filemap_fdatawrite(inode->i_mapping);
+	if (what & (OSYNC_METADATA|OSYNC_DATA)) {
+		err2 = sync_mapping_buffers(inode->i_mapping);
+		if (!err)
+			err = err2;
+	}
 	if (what & OSYNC_DATA) {
-		err2 = filemap_fdatawrite(inode->i_mapping);
+		err2 = filemap_fdatawait(inode->i_mapping);
 		if (!err)
 			err = err2;
 	}
--- 2.5.16/fs/ext2/fsync.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/ext2/fsync.c	Sun May 19 11:49:46 2002
@@ -37,7 +37,7 @@ int ext2_sync_file(struct file * file, s
 	struct inode *inode = dentry->d_inode;
 	int err;
 	
-	err  = fsync_inode_buffers(inode);
+	err  = sync_mapping_buffers(inode->i_mapping);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.16/fs/ext2/inode.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/ext2/inode.c	Sun May 19 12:02:57 2002
@@ -41,7 +41,8 @@ static int ext2_update_inode(struct inod
  */
 void ext2_put_inode (struct inode * inode)
 {
-	ext2_discard_prealloc (inode);
+	if (atomic_read(&inode->i_count) < 2)
+		ext2_discard_prealloc (inode);
 }
 
 /*
@@ -860,7 +861,7 @@ do_indirects:
 	}
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	if (IS_SYNC(inode)) {
-		fsync_inode_buffers(inode);
+		sync_mapping_buffers(inode->i_mapping);
 		ext2_sync_inode (inode);
 	} else {
 		mark_inode_dirty(inode);
--- 2.5.16/fs/minix/file.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/minix/file.c	Sun May 19 11:49:46 2002
@@ -31,7 +31,7 @@ int minix_sync_file(struct file * file, 
 	struct inode *inode = dentry->d_inode;
 	int err;
 
-	err = fsync_inode_buffers(inode);
+	err = sync_mapping_buffers(inode->i_mapping);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.16/fs/reiserfs/file.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/reiserfs/file.c	Sun May 19 12:02:59 2002
@@ -85,7 +85,7 @@ static int reiserfs_sync_file(
   if (!S_ISREG(p_s_inode->i_mode))
       BUG ();
 
-  n_err = fsync_inode_buffers(p_s_inode) ;
+  n_err = sync_mapping_buffers(p_s_inode->i_mapping) ;
   reiserfs_commit_for_inode(p_s_inode) ;
   unlock_kernel() ;
   return ( n_err < 0 ) ? -EIO : 0;
--- 2.5.16/fs/sysv/file.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/sysv/file.c	Sun May 19 11:49:46 2002
@@ -36,7 +36,7 @@ int sysv_sync_file(struct file * file, s
 	struct inode *inode = dentry->d_inode;
 	int err;
 
-	err = fsync_inode_buffers(inode);
+	err = sync_mapping_buffers(inode->i_mapping);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.16/fs/udf/fsync.c~buffer-list-lock	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/udf/fsync.c	Sun May 19 11:49:46 2002
@@ -44,7 +44,7 @@ int udf_fsync_inode(struct inode *inode,
 {
 	int err;
 
-	err = fsync_inode_buffers(inode);
+	err = sync_mapping_buffers(inode->i_mapping);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))

-
