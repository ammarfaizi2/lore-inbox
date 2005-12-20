Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVLTIyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVLTIyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVLTIyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:54:35 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15803 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750876AbVLTIye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:54:34 -0500
Date: Tue, 20 Dec 2005 17:53:16 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: [Patch] New zone ZONE_EASY_RECLAIM take 4. (disable gfp_easy_reclaim bit)[5/8]
Cc: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20051220173013.1B10.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to disable __GFP_EASY_RECLAIM at some part.
The parts are followings.

  1) add_to_page_cache()
  2) pipe_writev()
  3) shmem_dir_alloc()
  4) page_symlink()


1) If this patch is not applied, cache_grow() checks and call BUG(),
   at here. 

	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
		BUG();

  This patch is to solve it.

2) This page is allocated by alloc_pages(GFP_HIGHUSER) directly, and 
   it is kmapped when it is accessed as inode.
   But, it is not reclaimed by anyone.

3) This page is used for directory for shmem. So, it is very hard
   to reclaim.

4) Same with 2).


take3 -> take 4:
  Add disable part to pipe, shmem, and symlink.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: zone_reclaim/mm/filemap.c
===================================================================
--- zone_reclaim.orig/mm/filemap.c	2005-12-16 18:36:20.000000000 +0900
+++ zone_reclaim/mm/filemap.c	2005-12-16 19:15:35.000000000 +0900
@@ -395,7 +395,7 @@ int filemap_write_and_wait_range(struct 
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 		pgoff_t offset, gfp_t gfp_mask)
 {
-	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	int error = radix_tree_preload(gfp_mask & ~(__GFP_HIGHMEM | __GFP_EASY_RECLAIM));
 
 	if (error == 0) {
 		write_lock_irq(&mapping->tree_lock);
Index: zone_reclaim/fs/pipe.c
===================================================================
--- zone_reclaim.orig/fs/pipe.c	2005-12-16 18:36:20.000000000 +0900
+++ zone_reclaim/fs/pipe.c	2005-12-16 19:15:35.000000000 +0900
@@ -284,7 +284,7 @@ pipe_writev(struct file *filp, const str
 			int error;
 
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGHUSER & ~__GFP_EASY_RECLAIM);
 				if (unlikely(!page)) {
 					ret = ret ? : -ENOMEM;
 					break;
Index: zone_reclaim/mm/shmem.c
===================================================================
--- zone_reclaim.orig/mm/shmem.c	2005-12-16 18:36:20.000000000 +0900
+++ zone_reclaim/mm/shmem.c	2005-12-16 19:15:35.000000000 +0900
@@ -89,6 +89,7 @@ static inline struct page *shmem_dir_all
 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
 	 */
+	gfp_mask &= ~__GFP_EASY_RECLAIM;
 	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
 }
 
Index: zone_reclaim/fs/namei.c
===================================================================
--- zone_reclaim.orig/fs/namei.c	2005-12-16 18:36:20.000000000 +0900
+++ zone_reclaim/fs/namei.c	2005-12-16 19:30:49.000000000 +0900
@@ -2502,10 +2502,12 @@ void page_put_link(struct dentry *dentry
 int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page = grab_cache_page(mapping, 0);
+	struct page *page;
 	int err = -ENOMEM;
 	char *kaddr;
 
+	mapping_set_gfp_mask(mapping, mapping_gfp_mask(mapping) & ~__GFP_EASY_RECLAIM);
+	page = grab_cache_page(mapping, 0);
 	if (!page)
 		goto fail;
 	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);

-- 
Yasunori Goto 


