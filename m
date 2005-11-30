Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbVK3RLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVK3RLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVK3RLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:11:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41604 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751464AbVK3RLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:11:30 -0500
Date: Wed, 30 Nov 2005 09:11:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: lhms-devel@lists.sourceforge.net, Cliff Wickman <cpw@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051130171122.19405.86264.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051130171056.19405.95644.sendpatchset@schroedinger.engr.sgi.com>
References: <20051130171056.19405.95644.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 5/5] Direct Migration V6: Avoid writeback / page_migrate() method
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate a page with buffers without requiring writeback

This introduces a new address space operation migratepage() that
may be used by a filesystem to implement its own version of page migration.

A version is provided that migrates buffers attached to pages. Some
filesystems (ext2, ext3, xfs) are modified to utilize this feature.

The swapper address space operation are modified so that a regular
migrate_page() will occur for anonymous pages without writeback
(migrate_pages forces every anonymous page to have a swap entry).

V2->V3:
- export functions for filesystems that are modules and for modules that
  perform migration by calling migrate_pages().
- Fix macro name clash. Fix build on UP and systems without CONFIG_MIGRATION

V1->V2:
- Fix CONFIG_MIGRATION handling

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc3-mm1/include/linux/fs.h
===================================================================
--- linux-2.6.15-rc3-mm1.orig/include/linux/fs.h	2005-11-30 08:46:39.000000000 -0800
+++ linux-2.6.15-rc3-mm1/include/linux/fs.h	2005-11-30 08:47:00.000000000 -0800
@@ -367,6 +367,8 @@ struct address_space_operations {
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
+	/* migrate the contents of a page to the specified target */
+	int (*migratepage) (struct page *, struct page *);
 };
 
 struct backing_dev_info;
@@ -1722,6 +1724,12 @@ extern void simple_release_fs(struct vfs
 
 extern ssize_t simple_read_from_buffer(void __user *, size_t, loff_t *, const void *, size_t);
 
+#ifdef CONFIG_MIGRATION
+extern int buffer_migrate_page(struct page *, struct page *);
+#else
+#define buffer_migrate_page NULL
+#endif
+
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int __must_check inode_setattr(struct inode *, struct iattr *);
 
Index: linux-2.6.15-rc3-mm1/mm/swap_state.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/mm/swap_state.c	2005-11-30 08:46:40.000000000 -0800
+++ linux-2.6.15-rc3-mm1/mm/swap_state.c	2005-11-30 08:47:00.000000000 -0800
@@ -27,6 +27,7 @@ static struct address_space_operations s
 	.writepage	= swap_writepage,
 	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
+	.migratepage	= migrate_page,
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
Index: linux-2.6.15-rc3-mm1/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/fs/xfs/linux-2.6/xfs_aops.c	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3-mm1/fs/xfs/linux-2.6/xfs_aops.c	2005-11-30 08:47:00.000000000 -0800
@@ -1347,4 +1347,5 @@ struct address_space_operations linvfs_a
 	.commit_write		= generic_commit_write,
 	.bmap			= linvfs_bmap,
 	.direct_IO		= linvfs_direct_IO,
+	.migratepage		= buffer_migrate_page,
 };
Index: linux-2.6.15-rc3-mm1/fs/buffer.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/fs/buffer.c	2005-11-30 08:46:38.000000000 -0800
+++ linux-2.6.15-rc3-mm1/fs/buffer.c	2005-11-30 08:47:00.000000000 -0800
@@ -3051,6 +3051,71 @@ asmlinkage long sys_bdflush(int func, lo
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
+EXPORT_SYMBOL(buffer_migrate_page);
+#endif
+
+/*
  * Buffer-head allocation
  */
 static kmem_cache_t *bh_cachep;
Index: linux-2.6.15-rc3-mm1/fs/ext3/inode.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/fs/ext3/inode.c	2005-11-30 08:46:38.000000000 -0800
+++ linux-2.6.15-rc3-mm1/fs/ext3/inode.c	2005-11-30 08:47:00.000000000 -0800
@@ -1564,6 +1564,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
+	.migratepage	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_writeback_aops = {
@@ -1577,6 +1578,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
+	.migratepage	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_journalled_aops = {
Index: linux-2.6.15-rc3-mm1/fs/ext2/inode.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/fs/ext2/inode.c	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3-mm1/fs/ext2/inode.c	2005-11-30 08:47:00.000000000 -0800
@@ -706,6 +706,7 @@ struct address_space_operations ext2_aop
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
+	.migratepage		= buffer_migrate_page,
 };
 
 struct address_space_operations ext2_aops_xip = {
@@ -723,6 +724,7 @@ struct address_space_operations ext2_nob
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
+	.migratepage		= buffer_migrate_page,
 };
 
 /*
Index: linux-2.6.15-rc3-mm1/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-11-28 19:51:27.000000000 -0800
+++ linux-2.6.15-rc3-mm1/fs/xfs/linux-2.6/xfs_buf.c	2005-11-30 08:47:00.000000000 -0800
@@ -1568,6 +1568,7 @@ xfs_mapping_buftarg(
 	struct address_space	*mapping;
 	static struct address_space_operations mapping_aops = {
 		.sync_page = block_sync_page,
+		.migratepage = fail_migrate_page,
 	};
 
 	inode = new_inode(bdev->bd_inode->i_sb);
Index: linux-2.6.15-rc3-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/mm/vmscan.c	2005-11-30 08:46:52.000000000 -0800
+++ linux-2.6.15-rc3-mm1/mm/vmscan.c	2005-11-30 08:47:00.000000000 -0800
@@ -618,6 +618,15 @@ int putback_lru_pages(struct list_head *
 }
 
 /*
+ * Non migratable page
+ */
+int fail_migrate_page(struct page *newpage, struct page *page)
+{
+	return -EIO;
+}
+EXPORT_SYMBOL(fail_migrate_page);
+
+/*
  * swapout a single page
  * page is locked upon entry, unlocked on exit
  */
@@ -762,6 +771,8 @@ int migrate_page_remove_references(struc
 
 	return 0;
 }
+EXPORT_SYMBOL(swap_page);
+EXPORT_SYMBOL(migrate_page_remove_references);
 
 /*
  * Copy the page to its new location
@@ -801,6 +812,7 @@ void migrate_page_copy(struct page *newp
 	if (PageWriteback(newpage))
 		end_page_writeback(newpage);
 }
+EXPORT_SYMBOL(migrate_page_copy);
 
 /*
  * Common logic to directly migrate a single page suitable for
@@ -819,6 +831,7 @@ int migrate_page(struct page *newpage, s
 
 	return 0;
 }
+EXPORT_SYMBOL(migrate_page);
 
 /*
  * migrate_pages
@@ -918,6 +931,11 @@ redo:
 		if (!mapping)
 			goto unlock_both;
 
+		if (mapping->a_ops->migratepage) {
+			rc = mapping->a_ops->migratepage(newpage, page);
+			goto unlock_both;
+                }
+
 		/*
 		 * Trigger writeout if page is dirty
 		 */
@@ -1030,6 +1048,7 @@ redo:
 	}
 	return rc;
 }
+EXPORT_SYMBOL(migrate_pages);
 #endif
 
 /*
Index: linux-2.6.15-rc3-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc3-mm1.orig/include/linux/swap.h	2005-11-30 08:46:52.000000000 -0800
+++ linux-2.6.15-rc3-mm1/include/linux/swap.h	2005-11-30 08:47:00.000000000 -0800
@@ -183,6 +183,11 @@ extern int migrate_page_remove_reference
 extern void migrate_page_copy(struct page *, struct page *);
 extern int migrate_pages(struct list_head *l, struct list_head *t,
 		struct list_head *moved, struct list_head *failed);
+extern int fail_migrate_page(struct page *, struct page *);
+#else
+/* Possible settings for the migrate_page() method in address_operations */
+#define migrate_page NULL
+#define fail_migrate_page NULL
 #endif
 
 #ifdef CONFIG_MMU
