Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUBYBQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbUBYBQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:16:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:49587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262569AbUBYBPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:15:38 -0500
Subject: [PATCH 2.6.3-mm3] serialize_writeback_fdatawait patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-AVcOYRoZPCOCxjfWzXT5"
Organization: 
Message-Id: <1077671733.1956.247.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Feb 2004 17:15:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AVcOYRoZPCOCxjfWzXT5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

This patch moves the serializing of writebacks up one level to before
where the dirty_pages are moved to the io_pages list.  This prevents
writebacks from missing any pages that are moved back to the
dirty list by an SYNC_NONE writeback.  I have not seen this race in
testing -- just by looking at the code.  It also skips the serialization
for blockdevs.

Also this patch changes filemap_fdatawrite() to leave the page on the
locked_pages list until the i/o has finished.  This prevents
parallel filemap_fdatawait()s from missing a page that should be
waited on.  I have not seen this in testing, either.

Thoughts?

Daniel

--=-AVcOYRoZPCOCxjfWzXT5
Content-Disposition: attachment; filename=2.6.3-mm3.serialize_writeback_fdatawait.patch
Content-Type: text/x-patch; name=2.6.3-mm3.serialize_writeback_fdatawait.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rup linux-2.6.3-mm3.orig/fs/fs-writeback.c linux-2.6.3-mm3/fs/fs-writeback.c
--- linux-2.6.3-mm3.orig/fs/fs-writeback.c	2004-02-24 14:35:57.783234412 -0800
+++ linux-2.6.3-mm3/fs/fs-writeback.c	2004-02-24 15:13:52.482310450 -0800
@@ -139,6 +139,7 @@ __sync_single_inode(struct inode *inode,
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	int wait = wbc->sync_mode == WB_SYNC_ALL;
+	int blkdev = inode->i_sb == blockdev_superblock;
 
 	BUG_ON(inode->i_state & I_LOCK);
 
@@ -146,6 +147,27 @@ __sync_single_inode(struct inode *inode,
 	dirty = inode->i_state & I_DIRTY;
 	inode->i_state |= I_LOCK;
 	inode->i_state &= ~I_DIRTY;
+	spin_unlock(&inode_lock);
+
+	/*
+	 * Serialize writebacks except for blockdevs
+	 */
+	if (!blkdev) {
+		if (wait) {
+			/*
+			 * Only allow 1 SYNC writeback at a time, to be able
+			 * to wait for all i/o without worrying about racing
+			 * WB_SYNC_NONE writers.
+			 */
+			down_write(&mapping->wb_rwsema);
+		} else {
+			if (!down_read_trylock(&mapping->wb_rwsema))
+			/*
+			 * SYNC writeback already in progress
+			 */
+			goto skip_writeback;
+		}
+	}
 
 	/*
 	 * smp_rmb(); note: if you remove write_lock below, you must add this.
@@ -157,10 +179,17 @@ __sync_single_inode(struct inode *inode,
 	if (wait || !wbc->for_kupdate || list_empty(&mapping->io_pages))
 		list_splice_init(&mapping->dirty_pages, &mapping->io_pages);
 	spin_unlock(&mapping->page_lock);
-	spin_unlock(&inode_lock);
 
 	do_writepages(mapping, wbc);
 
+	if (!blkdev) {
+		if (wait)
+			up_write(&mapping->wb_rwsema);
+		else
+			up_read(&mapping->wb_rwsema);
+	}
+
+skip_writeback:
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
 		write_inode(inode, wait);
diff -rup linux-2.6.3-mm3.orig/mm/filemap.c linux-2.6.3-mm3/mm/filemap.c
--- linux-2.6.3-mm3.orig/mm/filemap.c	2004-02-24 12:41:41.290083474 -0800
+++ linux-2.6.3-mm3/mm/filemap.c	2004-02-24 14:34:48.992623430 -0800
@@ -128,6 +128,8 @@ static inline int sync_page(struct page 
 	return 0;
 }
 
+extern struct super_block *blockdev_superblock;
+
 /**
  * filemap_fdatawrite - start writeback against all of a mapping's dirty pages
  * @mapping: address space structure to write
@@ -144,14 +146,39 @@ static int __filemap_fdatawrite(struct a
 		.sync_mode = sync_mode,
 		.nr_to_write = mapping->nrpages * 2,
 	};
+	int blkdev = mapping->host->i_sb == blockdev_superblock;
 
 	if (mapping->backing_dev_info->memory_backed)
 		return 0;
 
+	if (!blkdev) {
+		if (sync_mode == WB_SYNC_NONE) {
+			if (!down_read_trylock(&mapping->wb_rwsema))
+				/*
+				 * SYNC writeback already in progress
+				 */
+				return 0;
+		} else {
+			/*
+			 * Only allow 1 SYNC writeback at a time, to be able
+			 * to wait for all i/o without worrying about racing
+			 * WB_SYNC_NONE writers.
+			 */
+			down_write(&mapping->wb_rwsema);
+		}
+	}
+		
 	spin_lock(&mapping->page_lock);
 	list_splice_init(&mapping->dirty_pages, &mapping->io_pages);
 	spin_unlock(&mapping->page_lock);
 	ret = do_writepages(mapping, &wbc);
+
+	if (!blkdev) {
+		if (sync_mode == WB_SYNC_NONE)
+			up_read(&mapping->wb_rwsema);
+		else
+			up_write(&mapping->wb_rwsema);
+	}
 	return ret;
 }
 
@@ -188,13 +215,24 @@ restart:
 		struct page *page;
 
 		page = list_entry(mapping->locked_pages.next,struct page,list);
-		list_del(&page->list);
-		if (PageDirty(page))
-			list_add(&page->list, &mapping->dirty_pages);
-		else
+		/*
+		 * Leave page on locked list until i/o has finished
+		 * so parallel filemap_fdatawait()s will all see the page.
+		 */
+
+		if (!PageDirty(page) && !PageLocked(page) &&
+		    !PageWriteback(page)) {
+	
+			/*
+			 * The page is checked if locked because it might
+			 * be in process of being setup for writeback with 
+			 * PG_dirty cleared and PG_writeback not set yet.
+			 * The page is not dirty and i/o has finished
+			 * so we can move it to the clean list.
+			 */
+			list_del(&page->list);
 			list_add(&page->list, &mapping->clean_pages);
 
-		if (!PageWriteback(page)) {
 			if (++progress > 32) {
 				if (need_resched()) {
 					spin_unlock(&mapping->page_lock);
@@ -209,10 +247,15 @@ restart:
 		page_cache_get(page);
 		spin_unlock(&mapping->page_lock);
 
-		wait_on_page_writeback(page);
-		if (PageError(page))
-			ret = -EIO;
-
+		lock_page(page);
+		if (PageDirty(page) && mapping->a_ops->writepage) {
+			write_one_page(page, 1);
+		} else {
+			wait_on_page_writeback(page);
+			unlock_page(page);
+		}
+ 		if (PageError(page))
+ 			ret = -EIO;
 		page_cache_release(page);
 		spin_lock(&mapping->page_lock);
 	}
diff -rup linux-2.6.3-mm3.orig/mm/page-writeback.c linux-2.6.3-mm3/mm/page-writeback.c
--- linux-2.6.3-mm3.orig/mm/page-writeback.c	2004-02-24 14:48:41.084633905 -0800
+++ linux-2.6.3-mm3/mm/page-writeback.c	2004-02-24 14:49:20.156550105 -0800
@@ -482,32 +482,9 @@ void __init page_writeback_init(void)
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
-	int ret;
-	if (wbc->sync_mode == WB_SYNC_NONE) {
-		if (!down_read_trylock(&mapping->wb_rwsema))
-			/*
-			 * SYNC writeback in progress
-			 */
-			return 0;
-	} else {
-		/*
-		 * Only allow 1 SYNC writeback at a time, to be able
-		 * to wait for all i/o without worrying about racing
-		 * WB_SYNC_NONE writers.
-		 */
-		down_write(&mapping->wb_rwsema);
-	}
-
 	if (mapping->a_ops->writepages)
-		ret = mapping->a_ops->writepages(mapping, wbc);
-	else
-		ret = generic_writepages(mapping, wbc);
-	if (wbc->sync_mode == WB_SYNC_NONE) {
-		up_read(&mapping->wb_rwsema);
-	} else {
-		up_write(&mapping->wb_rwsema);
-	}
-	return ret;
+		return mapping->a_ops->writepages(mapping, wbc);
+	return generic_writepages(mapping, wbc);
 }
 
 /**

--=-AVcOYRoZPCOCxjfWzXT5--

