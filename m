Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUDKO0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 10:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUDKO0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 10:26:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21845 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262365AbUDKO0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 10:26:14 -0400
Date: Sun, 11 Apr 2004 15:26:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 6 swap_unplug page
In-Reply-To: <Pine.LNX.4.44.0404111520210.1923-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404111524240.1923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmap 6 swap_unplug page

Good example of "swapper_space considered harmful": swap_unplug_io_fn
was originally designed for calling via swapper_space.backing_dev_info;
but that way it loses track of which device is to be unplugged, so had
to unplug all swap devices.  But now sync_page tests SwapCache anyway,
can call swap_unplug_io_fn with page, which leads direct to the device.

Reverted -mc4's CONFIG_SWAP=n fix, just add another NOTHING for it.
Reverted -mc3's editorial adjustments to swap_backing_dev_info and
swapper_space initializations: they document the few fields which are
actually used now, as comment above them says (sound of slapped wrist).

 include/linux/swap.h |    5 ++---
 mm/filemap.c         |    2 +-
 mm/nommu.c           |    5 -----
 mm/swap_state.c      |    4 ++--
 mm/swapfile.c        |   23 +++++++++++++++--------
 5 files changed, 20 insertions(+), 19 deletions(-)

--- rmap4/include/linux/swap.h	2004-04-11 07:19:24.105429504 +0100
+++ rmap5/include/linux/swap.h	2004-04-11 10:38:07.223816856 +0100
@@ -181,8 +181,6 @@ extern int vm_swappiness;
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
 #endif /* CONFIG_MMU */
 
-extern void swap_unplug_io_fn(struct backing_dev_info *);
-
 #ifdef CONFIG_SWAP
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct file *, struct page *);
@@ -218,7 +216,7 @@ extern sector_t map_swap_page(struct swa
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
-struct backing_dev_info;
+extern void swap_unplug_io_fn(struct page *);
 
 extern struct swap_list_t swap_list;
 extern spinlock_t swaplock;
@@ -252,6 +250,7 @@ extern spinlock_t swaplock;
 #define move_from_swap_cache(p, i, m)		1
 #define __delete_from_swap_cache(p)		/*NOTHING*/
 #define delete_from_swap_cache(p)		/*NOTHING*/
+#define swap_unplug_io_fn(p)			/*NOTHING*/
 
 static inline int remove_exclusive_swap_page(struct page *p)
 {
--- rmap4/mm/filemap.c	2004-04-11 07:19:24.796324472 +0100
+++ rmap5/mm/filemap.c	2004-04-11 10:38:07.226816400 +0100
@@ -127,7 +127,7 @@ static inline int sync_page(struct page 
 		if (mapping->a_ops && mapping->a_ops->sync_page)
 			return mapping->a_ops->sync_page(page);
 	} else if (PageSwapCache(page)) {
-		swap_unplug_io_fn(NULL);
+		swap_unplug_io_fn(page);
 	}
 	return 0;
 }
--- rmap4/mm/nommu.c	2004-04-11 07:19:24.866313832 +0100
+++ rmap5/mm/nommu.c	2004-04-11 10:38:07.227816248 +0100
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
-#include <linux/backing-dev.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -572,7 +571,3 @@ unsigned long get_unmapped_area(struct f
 void pte_chain_init(void)
 {
 }
-
-void swap_unplug_io_fn(struct backing_dev_info *)
-{
-}
--- rmap4/mm/swap_state.c	2004-04-11 07:19:25.004292856 +0100
+++ rmap5/mm/swap_state.c	2004-04-11 10:38:07.228816096 +0100
@@ -25,13 +25,13 @@ static struct address_space_operations s
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
-	.unplug_io_fn	= swap_unplug_io_fn,
+	.state		= 0,	/* uncongested */
 };
 
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
 	.tree_lock	= SPIN_LOCK_UNLOCKED,
+	.nrpages	= 0,	/* total_swapcache_pages */
 	.a_ops		= &swap_aops,
 	.backing_dev_info = &swap_backing_dev_info,
 };
--- rmap4/mm/swapfile.c	2004-04-11 07:19:24.975297264 +0100
+++ rmap5/mm/swapfile.c	2004-04-11 10:38:07.231815640 +0100
@@ -86,19 +86,26 @@ static void remove_swap_bdev(struct bloc
 	BUG();
 }
 
-void swap_unplug_io_fn(struct backing_dev_info *unused_bdi)
+/*
+ * Unlike a standard unplug_io_fn, swap_unplug_io_fn is never called
+ * through swap's backing_dev_info (which is only used by shrink_list),
+ * but directly from sync_page when PageSwapCache: and takes the page
+ * as argument, so that it can find the right device from swp_entry_t.
+ */
+void swap_unplug_io_fn(struct page *page)
 {
-	int i;
+	swp_entry_t entry;
 
 	down(&swap_bdevs_sem);
-	for (i = 0; i < MAX_SWAPFILES; i++) {
-		struct block_device *bdev = swap_bdevs[i];
+	entry.val = page->private;
+	if (PageSwapCache(page)) {
+		struct block_device *bdev = swap_bdevs[swp_type(entry)];
 		struct backing_dev_info *bdi;
 
-		if (bdev == NULL)
-			break;
-		bdi = bdev->bd_inode->i_mapping->backing_dev_info;
-		(*bdi->unplug_io_fn)(bdi);
+		if (bdev) {
+			bdi = bdev->bd_inode->i_mapping->backing_dev_info;
+			(*bdi->unplug_io_fn)(bdi);
+		}
 	}
 	up(&swap_bdevs_sem);
 }

