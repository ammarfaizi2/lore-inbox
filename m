Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVKHVE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVKHVE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVKHVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:04:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:22184 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030355AbVKHVEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:04:46 -0500
Date: Tue, 8 Nov 2005 13:04:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051108210417.31330.72381.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 6/8] Direct Migration V2: Avoid writeback / page_migrate() method
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

V1->V2:
- Fix CONFIG_MIGRATION handling

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/include/linux/fs.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/fs.h	2005-11-07 11:48:46.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/fs.h	2005-11-08 10:18:51.000000000 -0800
@@ -332,6 +332,8 @@ struct address_space_operations {
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
+	/* migrate the contents of a page to the specified target */
+	int (*migrate_page) (struct page *, struct page *);
 };
 
 struct backing_dev_info;
@@ -1679,6 +1681,12 @@ extern void simple_release_fs(struct vfs
 
 extern ssize_t simple_read_from_buffer(void __user *, size_t, loff_t *, const void *, size_t);
 
+#ifdef CONFIG_MIGRATION
+extern int buffer_migrate_page(struct page *, struct page *);
+#else
+#define buffer_migrate_page(a,b) NULL
+#endif
+
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int __must_check inode_setattr(struct inode *, struct iattr *);
 
Index: linux-2.6.14-mm1/mm/swap_state.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/swap_state.c	2005-11-07 11:48:49.000000000 -0800
+++ linux-2.6.14-mm1/mm/swap_state.c	2005-11-08 10:18:51.000000000 -0800
@@ -26,6 +26,7 @@ static struct address_space_operations s
 	.writepage	= swap_writepage,
 	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
+	.migrate_page	= migrate_page,
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
Index: linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/xfs/linux-2.6/xfs_aops.c	2005-11-07 11:48:07.000000000 -0800
+++ linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_aops.c	2005-11-08 10:18:51.000000000 -0800
@@ -1348,4 +1348,5 @@ struct address_space_operations linvfs_a
 	.commit_write		= generic_commit_write,
 	.bmap			= linvfs_bmap,
 	.direct_IO		= linvfs_direct_IO,
+	.migrate_page		= buffer_migrate_page,
 };
Index: linux-2.6.14-mm1/fs/buffer.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/buffer.c	2005-11-07 11:48:25.000000000 -0800
+++ linux-2.6.14-mm1/fs/buffer.c	2005-11-08 10:18:51.000000000 -0800
@@ -3026,6 +3026,70 @@ asmlinkage long sys_bdflush(int func, lo
 }
 
 /*
+ * Migration function for pages with buffers. This function can only be used
+ * if the underlying filesystem guarantees that no other references to "page"
+ * exist.
+ */
+#ifdef CONFIG_MIGRATION
+int buffer_migrate_page(struct page *newpage, struct page *page)
+{
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
+	return 0;
+}
+#endif
+
+/*
  * Buffer-head allocation
  */
 static kmem_cache_t *bh_cachep;
Index: linux-2.6.14-mm1/fs/ext3/inode.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/ext3/inode.c	2005-11-07 11:48:24.000000000 -0800
+++ linux-2.6.14-mm1/fs/ext3/inode.c	2005-11-08 10:18:51.000000000 -0800
@@ -1562,6 +1562,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
+	.migrate_page	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_writeback_aops = {
@@ -1575,6 +1576,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
+	.migrate_page	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_journalled_aops = {
Index: linux-2.6.14-mm1/fs/ext2/inode.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/ext2/inode.c	2005-11-07 11:48:07.000000000 -0800
+++ linux-2.6.14-mm1/fs/ext2/inode.c	2005-11-08 10:18:51.000000000 -0800
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
Index: linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-11-07 11:48:07.000000000 -0800
+++ linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_buf.c	2005-11-08 10:18:51.000000000 -0800
@@ -1568,6 +1568,7 @@ xfs_mapping_buftarg(
 	struct address_space	*mapping;
 	static struct address_space_operations mapping_aops = {
 		.sync_page = block_sync_page,
+		.migrate_page = fail_migrate_page,
 	};
 
 	inode = new_inode(bdev->bd_inode->i_sb);
Index: linux-2.6.14-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/vmscan.c	2005-11-08 10:16:58.000000000 -0800
+++ linux-2.6.14-mm1/mm/vmscan.c	2005-11-08 10:19:30.000000000 -0800
@@ -571,6 +571,15 @@ keep:
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
@@ -905,6 +914,11 @@ redo:
 		if (!mapping)
 			goto unlock_both;
 
+		if (mapping->a_ops->migrate_page) {
+			rc = mapping->a_ops->migrate_page(newpage, page);
+			goto unlock_both;
+                }
+
 		/*
 		 * Trigger writeout if page is dirty
 		 */
Index: linux-2.6.14-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/swap.h	2005-11-08 10:16:58.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/swap.h	2005-11-08 10:18:51.000000000 -0800
@@ -186,6 +186,11 @@ extern int migrate_pages(struct list_hea
 extern int migrate_page(struct page *, struct page *);
 extern int migrate_page_remove_references(struct page *, struct page *, int);
 extern void migrate_page_copy(struct page *, struct page *);
+extern int fail_migrate_page(struct page *, struct page *);
+#else
+/* Possible settings for the migrate_page() method in address_operations */
+#define migrate_page(a,b) NULL
+#define fail_migrate_page(a,b) NULL
 #endif
 
 #ifdef CONFIG_MMU
