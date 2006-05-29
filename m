Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWE2Jej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWE2Jej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 05:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWE2Jej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 05:34:39 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:8114 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750812AbWE2Jei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 05:34:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type;
  b=yzV4S8UV+ovjv6HX6Dfv8HuCzctuiPsi1r4hZ5ZAwgI+L0EureLlR3J7qPjnq9HSxhEWoPfsIqaaKd2sGzVroUTfZXwCu+0e06fALXWKATO4xFfWpFwBEzWQp/T+s808dqS/8/RWxHIUVBamkK4KH/YF2H8ac32gD6VT0b6Gcqg=  ;
Message-ID: <447AC011.8050708@yahoo.com.au>
Date: Mon, 29 May 2006 19:34:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
CC: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>
Subject: [rfc][patch] remove racy sync_page?
Content-Type: multipart/mixed;
 boundary="------------000805020707080004040802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000805020707080004040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm not completely sure whether this is the bug or not, nor what would be
the performance consequences of my attached fix (wrt the block layer). So
you're probably cc'ed because I've found similar threads with your names
on them.


lock_page (and other waiters on page flags bits) use sync_page when sleeping
on a bit. sync_page, however, requires that the page's mapping be pinned
(which is what we're sometimes trying to lock the page for).

Blatant offender is set_page_dirty_lock, which falls to the race it purports
to fix. Perhaps all callers could be fixed, however it seems that the pinned
mapping lock_page precondition is counter-intuitive and I'd bet other callers
to lock_page or wait_on_page_bit have got it wrong too.

Also: splice can change a page's mapping, so it would have been possible to
use the wrong mapping to "sync" a page.

Can we get rid of the whole thing, confusing memory barriers and all? Nobody
uses anything but the default sync_page, and if block rq plugging is terribly
bad for performance, perhaps it should be reworked anyway? It shouldn't be a
correctness thing, right?

Alternatives include RCU freeing of mappings and other things that increase
in complexity from there (eg. audit and fix all callers). It is so much cooler
to get rid of code though ;)

Comments?

-- 
SUSE Labs, Novell Inc.

--------------000805020707080004040802
Content-Type: text/plain;
 name="fs-remove-sync-page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs-remove-sync-page.patch"

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c	2006-05-19 12:49:07.000000000 +1000
+++ linux-2.6/mm/filemap.c	2006-05-29 18:56:07.000000000 +1000
@@ -134,42 +134,6 @@ void remove_from_page_cache(struct page 
 	write_unlock_irq(&mapping->tree_lock);
 }
 
-static int sync_page(void *word)
-{
-	struct address_space *mapping;
-	struct page *page;
-
-	page = container_of((unsigned long *)word, struct page, flags);
-
-	/*
-	 * page_mapping() is being called without PG_locked held.
-	 * Some knowledge of the state and use of the page is used to
-	 * reduce the requirements down to a memory barrier.
-	 * The danger here is of a stale page_mapping() return value
-	 * indicating a struct address_space different from the one it's
-	 * associated with when it is associated with one.
-	 * After smp_mb(), it's either the correct page_mapping() for
-	 * the page, or an old page_mapping() and the page's own
-	 * page_mapping() has gone NULL.
-	 * The ->sync_page() address_space operation must tolerate
-	 * page_mapping() going NULL. By an amazing coincidence,
-	 * this comes about because none of the users of the page
-	 * in the ->sync_page() methods make essential use of the
-	 * page_mapping(), merely passing the page down to the backing
-	 * device's unplug functions when it's non-NULL, which in turn
-	 * ignore it for all cases but swap, where only page_private(page) is
-	 * of interest. When page_mapping() does go NULL, the entire
-	 * call stack gracefully ignores the page and returns.
-	 * -- wli
-	 */
-	smp_mb();
-	mapping = page_mapping(page);
-	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
-		mapping->a_ops->sync_page(page);
-	io_schedule();
-	return 0;
-}
-
 /**
  * filemap_fdatawrite_range - start writeback against all of a mapping's
  * dirty pages that lie within the byte offsets <start, end>
@@ -456,6 +420,12 @@ struct page *page_cache_alloc_cold(struc
 EXPORT_SYMBOL(page_cache_alloc_cold);
 #endif
 
+static int __sleep_on_page_bit(void *word)
+{
+	io_schedule();
+	return 0;
+}
+
 /*
  * In order to wait for pages to become available there must be
  * waitqueues associated with pages. By using a hash table of
@@ -483,7 +453,7 @@ void fastcall wait_on_page_bit(struct pa
 	DEFINE_WAIT_BIT(wait, &page->flags, bit_nr);
 
 	if (test_bit(bit_nr, &page->flags))
-		__wait_on_bit(page_waitqueue(page), &wait, sync_page,
+		__wait_on_bit(page_waitqueue(page), &wait, __sleep_on_page_bit,
 							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
@@ -529,17 +499,12 @@ EXPORT_SYMBOL(end_page_writeback);
 
 /*
  * Get a lock on the page, assuming we need to sleep to get it.
- *
- * Ugly: running sync_page() in state TASK_UNINTERRUPTIBLE is scary.  If some
- * random driver's requestfn sets TASK_RUNNING, we could busywait.  However
- * chances are that on the second loop, the block layer's plug list is empty,
- * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
 void fastcall __lock_page(struct page *page)
 {
 	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
 
-	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
+	__wait_on_bit_lock(page_waitqueue(page), &wait, __sleep_on_page_bit,
 							TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL(__lock_page);
Index: linux-2.6/fs/block_dev.c
===================================================================
--- linux-2.6.orig/fs/block_dev.c	2006-05-19 12:49:03.000000000 +1000
+++ linux-2.6/fs/block_dev.c	2006-05-29 18:51:56.000000000 +1000
@@ -1080,7 +1080,6 @@ static long block_ioctl(struct file *fil
 struct address_space_operations def_blk_aops = {
 	.readpage	= blkdev_readpage,
 	.writepage	= blkdev_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= blkdev_prepare_write,
 	.commit_write	= blkdev_commit_write,
 	.writepages	= generic_writepages,
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/buffer.c	2006-05-29 18:52:04.000000000 +1000
@@ -3011,16 +3011,6 @@ out:
 }
 EXPORT_SYMBOL(try_to_free_buffers);
 
-void block_sync_page(struct page *page)
-{
-	struct address_space *mapping;
-
-	smp_mb();
-	mapping = page_mapping(page);
-	if (mapping)
-		blk_run_backing_dev(mapping->backing_dev_info, page);
-}
-
 /*
  * There are no bdflush tunables left.  But distributions are
  * still running obsolete flush daemons, so we terminate them here.
@@ -3164,7 +3154,6 @@ EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(block_commit_write);
 EXPORT_SYMBOL(block_prepare_write);
 EXPORT_SYMBOL(block_read_full_page);
-EXPORT_SYMBOL(block_sync_page);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(cont_prepare_write);
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h	2006-04-15 20:19:55.000000000 +1000
+++ linux-2.6/include/linux/buffer_head.h	2006-05-29 18:52:10.000000000 +1000
@@ -203,7 +203,6 @@ int cont_prepare_write(struct page*, uns
 int generic_cont_expand(struct inode *inode, loff_t size);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
-void block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h	2006-05-29 18:42:11.000000000 +1000
+++ linux-2.6/include/linux/fs.h	2006-05-29 18:52:16.000000000 +1000
@@ -351,7 +351,6 @@ struct writeback_control;
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
-	void (*sync_page)(struct page *);
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c	2006-04-15 20:19:59.000000000 +1000
+++ linux-2.6/mm/swap_state.c	2006-05-29 18:52:56.000000000 +1000
@@ -21,12 +21,11 @@
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
- * vmscan's shrink_list, to make sync_page look nicer, and to allow
- * future use of radix_tree tags in the swap cache.
+ * vmscan's shrink_list and to allow future use of radix_tree tags in
+ * the swap cache.
  */
 static struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
-	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.migratepage	= migrate_page,
 };
Index: linux-2.6/fs/adfs/inode.c
===================================================================
--- linux-2.6.orig/fs/adfs/inode.c	2005-03-02 19:38:15.000000000 +1100
+++ linux-2.6/fs/adfs/inode.c	2006-05-29 18:57:32.000000000 +1000
@@ -75,7 +75,6 @@ static sector_t _adfs_bmap(struct addres
 static struct address_space_operations adfs_aops = {
 	.readpage	= adfs_readpage,
 	.writepage	= adfs_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= adfs_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= _adfs_bmap
Index: linux-2.6/fs/affs/file.c
===================================================================
--- linux-2.6.orig/fs/affs/file.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/affs/file.c	2006-05-29 18:57:55.000000000 +1000
@@ -409,7 +409,6 @@ static sector_t _affs_bmap(struct addres
 struct address_space_operations affs_aops = {
 	.readpage = affs_readpage,
 	.writepage = affs_writepage,
-	.sync_page = block_sync_page,
 	.prepare_write = affs_prepare_write,
 	.commit_write = generic_commit_write,
 	.bmap = _affs_bmap
@@ -762,7 +761,6 @@ out:
 struct address_space_operations affs_aops_ofs = {
 	.readpage = affs_readpage_ofs,
 	//.writepage = affs_writepage_ofs,
-	//.sync_page = affs_sync_page_ofs,
 	.prepare_write = affs_prepare_write_ofs,
 	.commit_write = affs_commit_write_ofs
 };
Index: linux-2.6/fs/afs/file.c
===================================================================
--- linux-2.6.orig/fs/afs/file.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/afs/file.c	2006-05-29 18:58:16.000000000 +1000
@@ -37,7 +37,6 @@ struct inode_operations afs_file_inode_o
 
 struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_file_readpage,
-	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.releasepage	= afs_file_releasepage,
 	.invalidatepage	= afs_file_invalidatepage,
Index: linux-2.6/fs/befs/linuxvfs.c
===================================================================
--- linux-2.6.orig/fs/befs/linuxvfs.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/befs/linuxvfs.c	2006-05-29 18:58:01.000000000 +1000
@@ -75,7 +75,6 @@ static struct inode_operations befs_dir_
 
 static struct address_space_operations befs_aops = {
 	.readpage	= befs_readpage,
-	.sync_page	= block_sync_page,
 	.bmap		= befs_bmap,
 };
 
Index: linux-2.6/fs/bfs/file.c
===================================================================
--- linux-2.6.orig/fs/bfs/file.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/bfs/file.c	2006-05-29 18:57:33.000000000 +1000
@@ -156,7 +156,6 @@ static sector_t bfs_bmap(struct address_
 struct address_space_operations bfs_aops = {
 	.readpage	= bfs_readpage,
 	.writepage	= bfs_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= bfs_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= bfs_bmap,
Index: linux-2.6/fs/cifs/file.c
===================================================================
--- linux-2.6.orig/fs/cifs/file.c	2006-04-30 19:23:29.000000000 +1000
+++ linux-2.6/fs/cifs/file.c	2006-05-29 18:58:18.000000000 +1000
@@ -1383,34 +1383,6 @@ int cifs_fsync(struct file *file, struct
 	return rc;
 }
 
-/* static void cifs_sync_page(struct page *page)
-{
-	struct address_space *mapping;
-	struct inode *inode;
-	unsigned long index = page->index;
-	unsigned int rpages = 0;
-	int rc = 0;
-
-	cFYI(1, ("sync page %p",page));
-	mapping = page->mapping;
-	if (!mapping)
-		return 0;
-	inode = mapping->host;
-	if (!inode)
-		return; */
-
-/*	fill in rpages then 
-	result = cifs_pagein_inode(inode, index, rpages); */ /* BB finish */
-
-/*	cFYI(1, ("rpages is %d for sync page of Index %ld ", rpages, index));
-
-#if 0
-	if (rc < 0)
-		return rc;
-	return 0;
-#endif
-} */
-
 /*
  * As file closes, flush all cached write data for this inode checking
  * for write behind errors.
@@ -1952,6 +1924,5 @@ struct address_space_operations cifs_add
 	.prepare_write = cifs_prepare_write,
 	.commit_write = cifs_commit_write,
 	.set_page_dirty = __set_page_dirty_nobuffers,
-	/* .sync_page = cifs_sync_page, */
 	/* .direct_IO = */
 };
Index: linux-2.6/fs/efs/inode.c
===================================================================
--- linux-2.6.orig/fs/efs/inode.c	2004-10-19 17:20:32.000000000 +1000
+++ linux-2.6/fs/efs/inode.c	2006-05-29 18:57:40.000000000 +1000
@@ -23,7 +23,6 @@ static sector_t _efs_bmap(struct address
 }
 static struct address_space_operations efs_aops = {
 	.readpage = efs_readpage,
-	.sync_page = block_sync_page,
 	.bmap = _efs_bmap
 };
 
Index: linux-2.6/fs/ext2/inode.c
===================================================================
--- linux-2.6.orig/fs/ext2/inode.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/ext2/inode.c	2006-05-29 18:57:25.000000000 +1000
@@ -688,7 +688,6 @@ struct address_space_operations ext2_aop
 	.readpage		= ext2_readpage,
 	.readpages		= ext2_readpages,
 	.writepage		= ext2_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= ext2_prepare_write,
 	.commit_write		= generic_commit_write,
 	.bmap			= ext2_bmap,
@@ -706,7 +705,6 @@ struct address_space_operations ext2_nob
 	.readpage		= ext2_readpage,
 	.readpages		= ext2_readpages,
 	.writepage		= ext2_nobh_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= ext2_nobh_prepare_write,
 	.commit_write		= nobh_commit_write,
 	.bmap			= ext2_bmap,
Index: linux-2.6/fs/ext3/inode.c
===================================================================
--- linux-2.6.orig/fs/ext3/inode.c	2006-05-19 12:49:03.000000000 +1000
+++ linux-2.6/fs/ext3/inode.c	2006-05-29 18:57:51.000000000 +1000
@@ -1703,7 +1703,6 @@ static struct address_space_operations e
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_ordered_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_ordered_commit_write,
 	.bmap		= ext3_bmap,
@@ -1717,7 +1716,6 @@ static struct address_space_operations e
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_writeback_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_writeback_commit_write,
 	.bmap		= ext3_bmap,
@@ -1731,7 +1729,6 @@ static struct address_space_operations e
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_journalled_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_journalled_commit_write,
 	.set_page_dirty	= ext3_journalled_set_page_dirty,
Index: linux-2.6/fs/fat/inode.c
===================================================================
--- linux-2.6.orig/fs/fat/inode.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/fat/inode.c	2006-05-29 18:57:44.000000000 +1000
@@ -201,7 +201,6 @@ static struct address_space_operations f
 	.readpages	= fat_readpages,
 	.writepage	= fat_writepage,
 	.writepages	= fat_writepages,
-	.sync_page	= block_sync_page,
 	.prepare_write	= fat_prepare_write,
 	.commit_write	= fat_commit_write,
 	.direct_IO	= fat_direct_IO,
Index: linux-2.6/fs/freevxfs/vxfs_subr.c
===================================================================
--- linux-2.6.orig/fs/freevxfs/vxfs_subr.c	2005-09-02 17:01:44.000000000 +1000
+++ linux-2.6/fs/freevxfs/vxfs_subr.c	2006-05-29 18:57:46.000000000 +1000
@@ -45,7 +45,6 @@ static sector_t		vxfs_bmap(struct addres
 struct address_space_operations vxfs_aops = {
 	.readpage =		vxfs_readpage,
 	.bmap =			vxfs_bmap,
-	.sync_page =		block_sync_page,
 };
 
 inline void
Index: linux-2.6/fs/hfs/inode.c
===================================================================
--- linux-2.6.orig/fs/hfs/inode.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/hfs/inode.c	2006-05-29 18:58:48.000000000 +1000
@@ -117,7 +117,6 @@ static int hfs_writepages(struct address
 struct address_space_operations hfs_btree_aops = {
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfs_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfs_bmap,
@@ -127,7 +126,6 @@ struct address_space_operations hfs_btre
 struct address_space_operations hfs_aops = {
 	.readpage	= hfs_readpage,
 	.writepage	= hfs_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfs_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfs_bmap,
Index: linux-2.6/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.orig/fs/hfsplus/inode.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/hfsplus/inode.c	2006-05-29 18:58:23.000000000 +1000
@@ -112,7 +112,6 @@ static int hfsplus_writepages(struct add
 struct address_space_operations hfsplus_btree_aops = {
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfsplus_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfsplus_bmap,
@@ -122,7 +121,6 @@ struct address_space_operations hfsplus_
 struct address_space_operations hfsplus_aops = {
 	.readpage	= hfsplus_readpage,
 	.writepage	= hfsplus_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= hfsplus_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= hfsplus_bmap,
Index: linux-2.6/fs/hpfs/file.c
===================================================================
--- linux-2.6.orig/fs/hpfs/file.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/hpfs/file.c	2006-05-29 18:57:38.000000000 +1000
@@ -102,7 +102,6 @@ static sector_t _hpfs_bmap(struct addres
 struct address_space_operations hpfs_aops = {
 	.readpage = hpfs_readpage,
 	.writepage = hpfs_writepage,
-	.sync_page = block_sync_page,
 	.prepare_write = hpfs_prepare_write,
 	.commit_write = generic_commit_write,
 	.bmap = _hpfs_bmap
Index: linux-2.6/fs/isofs/compress.c
===================================================================
--- linux-2.6.orig/fs/isofs/compress.c	2005-09-02 17:01:46.000000000 +1000
+++ linux-2.6/fs/isofs/compress.c	2006-05-29 18:57:00.000000000 +1000
@@ -314,7 +314,6 @@ eio:
 
 struct address_space_operations zisofs_aops = {
 	.readpage = zisofs_readpage,
-	/* No sync_page operation supported? */
 	/* No bmap operation supported */
 };
 
Index: linux-2.6/fs/isofs/inode.c
===================================================================
--- linux-2.6.orig/fs/isofs/inode.c	2006-04-15 20:19:49.000000000 +1000
+++ linux-2.6/fs/isofs/inode.c	2006-05-29 18:57:01.000000000 +1000
@@ -1054,7 +1054,6 @@ static sector_t _isofs_bmap(struct addre
 
 static struct address_space_operations isofs_aops = {
 	.readpage = isofs_readpage,
-	.sync_page = block_sync_page,
 	.bmap = _isofs_bmap
 };
 
Index: linux-2.6/fs/jfs/inode.c
===================================================================
--- linux-2.6.orig/fs/jfs/inode.c	2006-04-15 20:19:50.000000000 +1000
+++ linux-2.6/fs/jfs/inode.c	2006-05-29 18:56:52.000000000 +1000
@@ -310,7 +310,6 @@ struct address_space_operations jfs_aops
 	.readpages	= jfs_readpages,
 	.writepage	= jfs_writepage,
 	.writepages	= jfs_writepages,
-	.sync_page	= block_sync_page,
 	.prepare_write	= jfs_prepare_write,
 	.commit_write	= nobh_commit_write,
 	.bmap		= jfs_bmap,
Index: linux-2.6/fs/jfs/jfs_metapage.c
===================================================================
--- linux-2.6.orig/fs/jfs/jfs_metapage.c	2006-05-29 18:42:11.000000000 +1000
+++ linux-2.6/fs/jfs/jfs_metapage.c	2006-05-29 18:56:53.000000000 +1000
@@ -580,7 +580,6 @@ static void metapage_invalidatepage(stru
 struct address_space_operations jfs_metapage_aops = {
 	.readpage	= metapage_readpage,
 	.writepage	= metapage_writepage,
-	.sync_page	= block_sync_page,
 	.releasepage	= metapage_releasepage,
 	.invalidatepage	= metapage_invalidatepage,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
Index: linux-2.6/fs/minix/inode.c
===================================================================
--- linux-2.6.orig/fs/minix/inode.c	2006-04-15 20:19:50.000000000 +1000
+++ linux-2.6/fs/minix/inode.c	2006-05-29 18:57:57.000000000 +1000
@@ -338,7 +338,6 @@ static sector_t minix_bmap(struct addres
 static struct address_space_operations minix_aops = {
 	.readpage = minix_readpage,
 	.writepage = minix_writepage,
-	.sync_page = block_sync_page,
 	.prepare_write = minix_prepare_write,
 	.commit_write = generic_commit_write,
 	.bmap = minix_bmap
Index: linux-2.6/fs/ntfs/aops.c
===================================================================
--- linux-2.6.orig/fs/ntfs/aops.c	2006-04-15 20:19:51.000000000 +1000
+++ linux-2.6/fs/ntfs/aops.c	2006-05-29 18:57:21.000000000 +1000
@@ -1546,8 +1546,6 @@ err_out:
  */
 struct address_space_operations ntfs_aops = {
 	.readpage	= ntfs_readpage,	/* Fill page with data. */
-	.sync_page	= block_sync_page,	/* Currently, just unplugs the
-						   disk request queue. */
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
 #endif /* NTFS_RW */
@@ -1562,8 +1560,6 @@ struct address_space_operations ntfs_aop
  */
 struct address_space_operations ntfs_mst_aops = {
 	.readpage	= ntfs_readpage,	/* Fill page with data. */
-	.sync_page	= block_sync_page,	/* Currently, just unplugs the
-						   disk request queue. */
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
 	.set_page_dirty	= __set_page_dirty_nobuffers,	/* Set the page dirty
Index: linux-2.6/fs/ntfs/inode.c
===================================================================
--- linux-2.6.orig/fs/ntfs/inode.c	2006-04-15 20:19:51.000000000 +1000
+++ linux-2.6/fs/ntfs/inode.c	2006-05-29 18:57:12.000000000 +1000
@@ -1830,7 +1830,7 @@ int ntfs_read_inode_mount(struct inode *
 	/* Need this to sanity check attribute list references to $MFT. */
 	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
 
-	/* Provides readpage() and sync_page() for map_mft_record(). */
+	/* Provides readpage() for map_mft_record(). */
 	vi->i_mapping->a_ops = &ntfs_mst_aops;
 
 	ctx = ntfs_attr_get_search_ctx(ni, m);
Index: linux-2.6/fs/ocfs2/aops.c
===================================================================
--- linux-2.6.orig/fs/ocfs2/aops.c	2006-05-29 18:42:11.000000000 +1000
+++ linux-2.6/fs/ocfs2/aops.c	2006-05-29 18:58:25.000000000 +1000
@@ -672,6 +672,5 @@ struct address_space_operations ocfs2_ao
 	.prepare_write	= ocfs2_prepare_write,
 	.commit_write	= ocfs2_commit_write,
 	.bmap		= ocfs2_bmap,
-	.sync_page	= block_sync_page,
 	.direct_IO	= ocfs2_direct_IO
 };
Index: linux-2.6/fs/qnx4/inode.c
===================================================================
--- linux-2.6.orig/fs/qnx4/inode.c	2006-04-15 20:19:51.000000000 +1000
+++ linux-2.6/fs/qnx4/inode.c	2006-05-29 18:57:59.000000000 +1000
@@ -451,7 +451,6 @@ static sector_t qnx4_bmap(struct address
 static struct address_space_operations qnx4_aops = {
 	.readpage	= qnx4_readpage,
 	.writepage	= qnx4_writepage,
-	.sync_page	= block_sync_page,
 	.prepare_write	= qnx4_prepare_write,
 	.commit_write	= generic_commit_write,
 	.bmap		= qnx4_bmap
Index: linux-2.6/fs/reiserfs/inode.c
===================================================================
--- linux-2.6.orig/fs/reiserfs/inode.c	2006-04-15 20:19:51.000000000 +1000
+++ linux-2.6/fs/reiserfs/inode.c	2006-05-29 18:57:35.000000000 +1000
@@ -3002,7 +3002,6 @@ struct address_space_operations reiserfs
 	.readpages = reiserfs_readpages,
 	.releasepage = reiserfs_releasepage,
 	.invalidatepage = reiserfs_invalidatepage,
-	.sync_page = block_sync_page,
 	.prepare_write = reiserfs_prepare_write,
 	.commit_write = reiserfs_commit_write,
 	.bmap = reiserfs_aop_bmap,
Index: linux-2.6/fs/sysv/itree.c
===================================================================
--- linux-2.6.orig/fs/sysv/itree.c	2005-03-02 19:38:21.000000000 +1100
+++ linux-2.6/fs/sysv/itree.c	2006-05-29 18:57:36.000000000 +1000
@@ -468,7 +468,6 @@ static sector_t sysv_bmap(struct address
 struct address_space_operations sysv_aops = {
 	.readpage = sysv_readpage,
 	.writepage = sysv_writepage,
-	.sync_page = block_sync_page,
 	.prepare_write = sysv_prepare_write,
 	.commit_write = generic_commit_write,
 	.bmap = sysv_bmap
Index: linux-2.6/fs/udf/file.c
===================================================================
--- linux-2.6.orig/fs/udf/file.c	2006-04-15 20:19:52.000000000 +1000
+++ linux-2.6/fs/udf/file.c	2006-05-29 18:57:27.000000000 +1000
@@ -98,7 +98,6 @@ static int udf_adinicb_commit_write(stru
 struct address_space_operations udf_adinicb_aops = {
 	.readpage		= udf_adinicb_readpage,
 	.writepage		= udf_adinicb_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= udf_adinicb_prepare_write,
 	.commit_write		= udf_adinicb_commit_write,
 };
Index: linux-2.6/fs/udf/inode.c
===================================================================
--- linux-2.6.orig/fs/udf/inode.c	2006-04-15 20:19:52.000000000 +1000
+++ linux-2.6/fs/udf/inode.c	2006-05-29 18:57:30.000000000 +1000
@@ -135,7 +135,6 @@ static sector_t udf_bmap(struct address_
 struct address_space_operations udf_aops = {
 	.readpage		= udf_readpage,
 	.writepage		= udf_writepage,
-	.sync_page		= block_sync_page,
 	.prepare_write		= udf_prepare_write,
 	.commit_write		= generic_commit_write,
 	.bmap			= udf_bmap,
Index: linux-2.6/fs/ufs/inode.c
===================================================================
--- linux-2.6.orig/fs/ufs/inode.c	2006-02-26 03:01:30.000000000 +1100
+++ linux-2.6/fs/ufs/inode.c	2006-05-29 18:56:57.000000000 +1000
@@ -534,7 +534,6 @@ static sector_t ufs_bmap(struct address_
 struct address_space_operations ufs_aops = {
 	.readpage = ufs_readpage,
 	.writepage = ufs_writepage,
-	.sync_page = block_sync_page,
 	.prepare_write = ufs_prepare_write,
 	.commit_write = generic_commit_write,
 	.bmap = ufs_bmap
Index: linux-2.6/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_aops.c	2006-04-20 18:55:03.000000000 +1000
+++ linux-2.6/fs/xfs/linux-2.6/xfs_aops.c	2006-05-29 18:58:03.000000000 +1000
@@ -1452,7 +1452,6 @@ struct address_space_operations xfs_addr
 	.readpage		= xfs_vm_readpage,
 	.readpages		= xfs_vm_readpages,
 	.writepage		= xfs_vm_writepage,
-	.sync_page		= block_sync_page,
 	.releasepage		= xfs_vm_releasepage,
 	.invalidatepage		= xfs_vm_invalidatepage,
 	.prepare_write		= xfs_vm_prepare_write,
Index: linux-2.6/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_buf.c	2006-04-20 18:55:03.000000000 +1000
+++ linux-2.6/fs/xfs/linux-2.6/xfs_buf.c	2006-05-29 18:58:05.000000000 +1000
@@ -1521,7 +1521,6 @@ xfs_mapping_buftarg(
 	struct inode		*inode;
 	struct address_space	*mapping;
 	static struct address_space_operations mapping_aops = {
-		.sync_page = block_sync_page,
 		.migratepage = fail_migrate_page,
 	};
 

--------------000805020707080004040802--
Send instant messages to your online friends http://au.messenger.yahoo.com 
