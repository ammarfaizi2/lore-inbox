Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVKITRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVKITRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVKITRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:17:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28607 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030339AbVKITRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:17:06 -0500
Date: Wed, 9 Nov 2005 11:14:25 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nikita Danilov <nikita@clusterfs.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/8] Direct Migration V2: Avoid writeback / page_migrate()
 method
In-Reply-To: <17266.12228.657758.358807@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.62.0511091105490.4103@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
 <20051108210417.31330.72381.sendpatchset@schroedinger.engr.sgi.com>
 <17265.55057.438316.467289@gargle.gargle.HOWL>
 <Pine.LNX.4.62.0511090907260.3607@schroedinger.engr.sgi.com>
 <17266.12228.657758.358807@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Nikita Danilov wrote:

> buffer_migrate_page is a pointer to function.
> 
> buffer_migrate_page(a, b) is a value of type int (or void *).

Yup that is wrong. It must be

#define buffer_migrate_page NULL

While investigating that I found a name clash and some issues with #ifdef 
CONFIG_MIGRATION for direct migration. Sigh.

===

Fix UP compile

- Remove parameters from macro definitions for migration function
  if CONFIG_MIGRATION is off.

- Avoid name clash between migrate_page macro and the address operations
  field names migrate_page by renaming it to migratepage.

- Adjust #ifdef CONFIG_MIGRATION in vmscan.c to include
  fail_migrate_page (provide by macro if !CONFIG_MIGRATION and
  surround putback_lru_pages() with #ifdef CONFIG_MIGRATION

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/vmscan.c	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/mm/vmscan.c	2005-11-09 11:08:31.000000000 -0800
@@ -572,6 +572,7 @@ keep:
 	return reclaimed;
 }
 
+#ifdef CONFIG_MIGRATION
 /*
  * Non migratable page
  */
@@ -580,8 +581,6 @@ int fail_migrate_page(struct page *newpa
 	return -EIO;
 }
 
-
-#ifdef CONFIG_MIGRATION
 /*
  * swapout a single page
  * page is locked upon entry, unlocked on exit
@@ -916,8 +916,8 @@ redo:
 		if (!mapping)
 			goto unlock_both;
 
-		if (mapping->a_ops->migrate_page) {
-			rc = mapping->a_ops->migrate_page(newpage, page);
+		if (mapping->a_ops->migratepage) {
+			rc = mapping->a_ops->migratepage(newpage, page);
 			goto unlock_both;
                 }
 
@@ -1142,6 +1142,7 @@ done:
 	pagevec_release(&pvec);
 }
 
+#ifdef CONFIG_MIGRATION
 /*
  * Add isolated pages on the list back to the LRU
  *
@@ -1159,6 +1160,7 @@ int putback_lru_pages(struct list_head *
 	}
 	return count;
 }
+#endif
 
 /*
  * This moves pages from the active list to the inactive list.
Index: linux-2.6.14-mm1/include/linux/fs.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/fs.h	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/fs.h	2005-11-09 10:54:03.000000000 -0800
@@ -333,7 +333,7 @@ struct address_space_operations {
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
 	/* migrate the contents of a page to the specified target */
-	int (*migrate_page) (struct page *, struct page *);
+	int (*migratepage) (struct page *, struct page *);
 };
 
 struct backing_dev_info;
@@ -1684,7 +1684,7 @@ extern ssize_t simple_read_from_buffer(v
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct page *, struct page *);
 #else
-#define buffer_migrate_page(a,b) NULL
+#define buffer_migrate_page NULL
 #endif
 
 extern int inode_change_ok(struct inode *, struct iattr *);
Index: linux-2.6.14-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/swap.h	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/swap.h	2005-11-09 10:54:03.000000000 -0800
@@ -189,8 +189,8 @@ extern void migrate_page_copy(struct pag
 extern int fail_migrate_page(struct page *, struct page *);
 #else
 /* Possible settings for the migrate_page() method in address_operations */
-#define migrate_page(a,b) NULL
-#define fail_migrate_page(a,b) NULL
+#define migrate_page NULL
+#define fail_migrate_page NULL
 #endif
 
 #ifdef CONFIG_MMU
Index: linux-2.6.14-mm1/mm/swap_state.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/swap_state.c	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/mm/swap_state.c	2005-11-09 10:54:03.000000000 -0800
@@ -26,7 +26,7 @@ static struct address_space_operations s
 	.writepage	= swap_writepage,
 	.sync_page	= block_sync_page,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
-	.migrate_page	= migrate_page,
+	.migratepage	= migrate_page,
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
Index: linux-2.6.14-mm1/fs/ext2/inode.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/ext2/inode.c	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/fs/ext2/inode.c	2005-11-09 10:54:03.000000000 -0800
@@ -706,7 +706,7 @@ struct address_space_operations ext2_aop
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
-	.migrate_page		= buffer_migrate_page,
+	.migratepage		= buffer_migrate_page,
 };
 
 struct address_space_operations ext2_aops_xip = {
@@ -724,7 +724,7 @@ struct address_space_operations ext2_nob
 	.bmap			= ext2_bmap,
 	.direct_IO		= ext2_direct_IO,
 	.writepages		= ext2_writepages,
-	.migrate_page		= buffer_migrate_page,
+	.migratepage		= buffer_migrate_page,
 };
 
 /*
Index: linux-2.6.14-mm1/fs/ext3/inode.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/ext3/inode.c	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/fs/ext3/inode.c	2005-11-09 10:54:03.000000000 -0800
@@ -1562,7 +1562,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
-	.migrate_page	= buffer_migrate_page,
+	.migratepage	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_writeback_aops = {
@@ -1576,7 +1576,7 @@ static struct address_space_operations e
 	.invalidatepage	= ext3_invalidatepage,
 	.releasepage	= ext3_releasepage,
 	.direct_IO	= ext3_direct_IO,
-	.migrate_page	= buffer_migrate_page,
+	.migratepage	= buffer_migrate_page,
 };
 
 static struct address_space_operations ext3_journalled_aops = {
Index: linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/xfs/linux-2.6/xfs_aops.c	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_aops.c	2005-11-09 10:54:03.000000000 -0800
@@ -1348,5 +1348,5 @@ struct address_space_operations linvfs_a
 	.commit_write		= generic_commit_write,
 	.bmap			= linvfs_bmap,
 	.direct_IO		= linvfs_direct_IO,
-	.migrate_page		= buffer_migrate_page,
+	.migratepage		= buffer_migrate_page,
 };
Index: linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.14-mm1.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-11-09 10:54:03.000000000 -0800
+++ linux-2.6.14-mm1/fs/xfs/linux-2.6/xfs_buf.c	2005-11-09 10:59:39.000000000 -0800
@@ -1568,7 +1568,7 @@ xfs_mapping_buftarg(
 	struct address_space	*mapping;
 	static struct address_space_operations mapping_aops = {
 		.sync_page = block_sync_page,
-		.migrate_page = fail_migrate_page,
+		.migratepage = fail_migrate_page,
 	};
 
 	inode = new_inode(bdev->bd_inode->i_sb);
