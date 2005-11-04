Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVKDXiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVKDXiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVKDXiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:38:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40343 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751144AbVKDXhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:37:54 -0500
Date: Fri, 4 Nov 2005 15:37:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       linux-mm@kvack.org, torvalds@osdl.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051104233743.5459.71557.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
References: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 6/7] Direct Migration V1: Avoid writeback using page_migrate() method
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate a page with buffers without requiring writeback

This introduces a new address space operation migrate_page() that
may be used by a filesystem to implement its own version of page migration.

A version is provided that migrates buffers attached to pages. Some
filesystems (ext2, ext3, xfs) are modified to utilize this feature.

The swapper address space operation are modified so that a regular
migrate_pages() will occur for anonymous pages without writeback
(migrate_pages forces every anonymous page to have a swap entry).

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/include/linux/fs.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/fs.h	2005-10-31 14:11:15.000000000 -0800
+++ linux-2.6.14-rc5-mm1/include/linux/fs.h	2005-11-04 11:50:29.000000000 -0800
@@ -327,6 +327,8 @@ struct address_space_operations {
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
+	/* migrate the contents of a page to the specified target */
+	int (*migrate_page) (struct page *, struct page *);
 };
 
 struct backing_dev_info;
Index: linux-2.6.14-rc5-mm1/mm/swap_state.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/swap_state.c	2005-10-31 14:11:17.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/swap_state.c	2005-11-04 11:50:29.000000000 -0800
@@ -26,6 +26,7 @@ static struct address_space_operations s
 	.writepage	= swap_writepage,
 	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
+	.migrate_page	= migrate_page,
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
Index: linux-2.6.14-rc5-mm1/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/fs/xfs/linux-2.6/xfs_aops.c	2005-10-19 23:23:05.000000000 -0700
+++ linux-2.6.14-rc5-mm1/fs/xfs/linux-2.6/xfs_aops.c	2005-11-04 11:50:29.000000000 -0800
@@ -1356,4 +1356,5 @@ struct address_space_operations linvfs_a
 	.commit_write		= generic_commit_write,
 	.bmap			= linvfs_bmap,
 	.direct_IO		= linvfs_direct_IO,
+	.migrate_page		= buffer_migrate_page,
 };
Index: linux-2.6.14-rc5-mm1/fs/buffer.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/fs/buffer.c	2005-10-31 14:11:00.000000000 -0800
+++ linux-2.6.14-rc5-mm1/fs/buffer.c	2005-11-04 14:43:55.000000000 -0800
@@ -3024,6 +3024,73 @@ asmlinkage long sys_bdflush(int func, lo
 }
 
 /*
+ * Migration function for pages with buffers. This function can only be used
+ * if the underlying filesystem guarantees that no other references to "page"
+ * exist.
+ */
+int buffer_migrate_page(struct page *newpage, struct page *page)
+{
+#ifdef CONFIG_MIGRATION
+	struct address_space *mapping = page->mapping;
+	struct buffer_head *bh, *head;
+
+	if (!mapping)
+		return -EAGAIN;
+
+	if (!page_has_buffers(page))
+		return migrate_page(newpage, page);
+
+	head = page_buffers(page);
+
+	/*
+	 * Remove the mapping so the page can be migrated.
+	 */
+	if (migrate_page_remove_references(newpage, page, 3))
+		return -EAGAIN;
+
+	spin_lock(&mapping->private_lock);
+
+	bh = head;
+	do {
+		get_bh(bh);
+		lock_buffer(bh);
+		bh = bh->b_this_page;
+
+	} while (bh != head);
+
+	ClearPagePrivate(page);
+	set_page_private(newpage, page_private(page));
+	set_page_private(page, 0);
+	put_page(page);
+	get_page(newpage);
+
+	bh = head;
+	do {
+		set_bh_page(bh, newpage, bh_offset(bh));
+		bh = bh->b_this_page;
+
+	} while (bh != head);
+
+	SetPagePrivate(newpage);
+	spin_unlock(&mapping->private_lock);
+
+	migrate_page_copy(newpage, page);
+
+	spin_lock(&mapping->private_lock);
+	bh = head;
+	do {
+		unlock_buffer(bh);
+ 		put_bh(bh);
+		bh = bh->b_this_page;
+
+	} while (bh != head);
+	spin_unlock(&mapping->private_lock);
+
+#endif
+	return 0;
+}
+
+/*
  * Buffer-head allocation
  */
 static kmem_cache_t *bh_cachep;
Index: linux-2.6.14-rc5-mm1/fs/ext3/inode.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/fs/ext3/inode.c	2005-10-31 14:11:03.000000000 -0800
+++ linux-2.6.14-rc5-mm1/fs/ext3/inode.c	2005-11-04 11:50:29.000000000 -0800
@@ -1557,6 +1557,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
+	.migrate_page	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_writeback_aops = {
@@ -1570,6 +1571,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
+	.migrate_page	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_journalled_aops = {
Index: linux-2.6.14-rc5-mm1/fs/ext2/inode.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/fs/ext2/inode.c	2005-10-31 14:11:03.000000000 -0800
+++ linux-2.6.14-rc5-mm1/fs/ext2/inode.c	2005-11-04 11:50:29.000000000 -0800
@@ -706,6 +706,7 @@ struct address_space_operations ext2_aop
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
+	.migrate_page		= buffer_migrate_page,
 };
 
 struct address_space_operations ext2_aops_xip = {
@@ -723,6 +724,7 @@ struct address_space_operations ext2_nob
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
+	.migrate_page		= buffer_migrate_page,
 };
 
 /*
Index: linux-2.6.14-rc5-mm1/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-10-31 14:10:52.000000000 -0800
+++ linux-2.6.14-rc5-mm1/fs/xfs/linux-2.6/xfs_buf.c	2005-11-04 11:50:29.000000000 -0800
@@ -1633,6 +1633,7 @@ xfs_mapping_buftarg(
 	struct address_space	*mapping;
 	static struct address_space_operations mapping_aops = {
 		.sync_page = block_sync_page,
+		.migrate_page = fail_migrate_page,
 	};
 
 	inode = new_inode(bdev->bd_inode->i_sb);
Index: linux-2.6.14-rc5-mm1/include/linux/buffer_head.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/buffer_head.h	2005-10-31 14:10:59.000000000 -0800
+++ linux-2.6.14-rc5-mm1/include/linux/buffer_head.h	2005-11-04 11:50:29.000000000 -0800
@@ -210,6 +210,7 @@ int nobh_truncate_page(struct address_sp
 int nobh_writepage(struct page *page, get_block_t *get_block,
                         struct writeback_control *wbc);
 
+int buffer_migrate_page(struct page *, struct page *);
 
 /*
  * inline definitions
Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-11-04 10:24:57.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-11-04 11:50:29.000000000 -0800
@@ -572,6 +572,15 @@ keep:
 	return reclaimed;
 }
 
+/*
+ * Non migratable page
+ */
+int fail_migrate_page(struct page *newpage, struct page *page)
+{
+	return -EIO;
+}
+
+
 #ifdef CONFIG_MIGRATION
 /*
  * swapout a single page
@@ -885,6 +894,11 @@ redo:
 		 */
 		mapping = page_mapping(page);
 
+		if (mapping->a_ops->migrate_page) {
+			rc = mapping->a_ops->migrate_page(newpage, page);
+			goto unlock_both;
+                }
+
 		/*
 		 * Trigger writeout if page is dirty
 		 */
Index: linux-2.6.14-rc5-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/swap.h	2005-11-04 10:24:09.000000000 -0800
+++ linux-2.6.14-rc5-mm1/include/linux/swap.h	2005-11-04 11:50:29.000000000 -0800
@@ -185,6 +185,7 @@ extern int migrate_pages(struct list_hea
 extern int migrate_page(struct page *, struct page *);
 extern int migrate_page_remove_references(struct page *, struct page *, int);
 extern void migrate_page_copy(struct page *, struct page *);
+extern int fail_migrate_page(struct page *, struct page *);
 #endif
 
 #ifdef CONFIG_MMU
