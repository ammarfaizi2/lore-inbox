Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbTCZRJL>; Wed, 26 Mar 2003 12:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbTCZRJL>; Wed, 26 Mar 2003 12:09:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:64937 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261795AbTCZRJJ>; Wed, 26 Mar 2003 12:09:09 -0500
Date: Wed, 26 Mar 2003 17:22:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 13/13 may_enter_fs?
In-Reply-To: <20030325171223.7a2c50ee.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303261649020.1315-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Andrew Morton wrote:
> 
> For example, a memory-backed filesystem may be trying to allocate GFP_NOFS
> memory while holding filesystem locks which are taken by its writepage.
> 
> How about adding a new field to backing_dev_info for this case?  Damned if I
> can think of a name for it though.

I think you're overcomplicating it.  Of the existing memory_backed bdis
(ramdisk, hugetlbfs, ramfs, sysfs, tmpfs, swap) only two have non-NULL
writepage, and both of those two go (indirectly and directly) to swap
(and neither holds FS lock while waiting to allocate memory).

If we were looking for a correct solution, I don't think backing_dev_info
would be the right place: we're talking about GFP_ needed for writepage,
which should be specified in the struct address_space filled in by the
FS: I think it's more a limitation of the FS than its backing device.

But I don't really want to add another obscure gfp_mask initialization
all over the place.  So how about this?  As I say, "swap_backed" is
(for the foreseeable future) unnecessary, but does help to correct
mistaken impressions arising from the term "memory_backed".

I've conceded to your delicate sensibility by using if-else rather
than ?: (I used it rather too compactly there, but see nothing wrong
with the construct in general); but you'll be disgusted at my defiance
in not adding a comment in the place you indicated - what would I say?

Hugh

--- 2.5.66-mm1/mm/shmem.c	Wed Mar 26 11:51:01 2003
+++ swap13/mm/shmem.c	Wed Mar 26 16:35:08 2003
@@ -123,7 +123,8 @@
 
 static struct backing_dev_info shmem_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.memory_backed	= 1,	/* Do not count its dirty pages in nr_dirty */
+	.swap_backed	= 1,	/* Its memory_backed writepage goes to swap */
 };
 
 LIST_HEAD (shmem_inodes);
--- 2.5.66-mm1/mm/swap_state.c	Wed Mar 26 11:51:01 2003
+++ swap13/mm/swap_state.c	Wed Mar 26 16:35:08 2003
@@ -27,7 +27,8 @@
 
 static struct backing_dev_info swap_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.memory_backed	= 1,	/* Do not count its dirty pages in nr_dirty */
+	.swap_backed	= 1,	/* Its memory_backed writepage goes to swap */
 };
 
 extern struct address_space_operations swap_aops;
--- 2.5.66-mm1/mm/vmscan.c	Wed Mar 26 11:51:01 2003
+++ swap13/mm/vmscan.c	Wed Mar 26 16:35:08 2003
@@ -235,7 +235,6 @@
 	pagevec_init(&freed_pvec, 1);
 	while (!list_empty(page_list)) {
 		struct page *page;
-		int may_enter_fs;
 
 		page = list_entry(page_list->prev, struct page, lru);
 		list_del(&page->lru);
@@ -248,8 +247,6 @@
 			(*nr_mapped)++;
 
 		BUG_ON(PageActive(page));
-		may_enter_fs = (gfp_mask & __GFP_FS) ||
-				(PageSwapCache(page) && (gfp_mask & __GFP_IO));
 
 		if (PageWriteback(page))
 			goto keep_locked;
@@ -315,15 +312,23 @@
 		 * See swapfile.c:page_queue_congested().
 		 */
 		if (PageDirty(page)) {
+			struct backing_dev_info *bdi;
+			unsigned int gfp_needed_for_writepage;
+
 			if (!is_page_cache_freeable(page))
 				goto keep_locked;
 			if (!mapping)
 				goto keep_locked;
 			if (mapping->a_ops->writepage == NULL)
 				goto activate_locked;
-			if (!may_enter_fs)
+			bdi = mapping->backing_dev_info;
+			if (bdi->swap_backed)
+				gfp_needed_for_writepage = __GFP_IO;
+			else
+				gfp_needed_for_writepage = __GFP_FS;
+			if (!(gfp_mask & gfp_needed_for_writepage))
 				goto keep_locked;
-			if (!may_write_to_queue(mapping->backing_dev_info))
+			if (!may_write_to_queue(bdi))
 				goto keep_locked;
 			write_lock(&mapping->page_lock);
 			if (test_clear_page_dirty(page)) {
--- 2.5.66-mm1/include/linux/backing-dev.h	Wed Mar 26 11:50:36 2003
+++ swap13/include/linux/backing-dev.h	Wed Mar 26 16:35:08 2003
@@ -23,7 +23,9 @@
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
 	unsigned long state;	/* Always use atomic bitops on this */
-	int memory_backed;	/* Cannot clean pages with writepage */
+	unsigned int
+		memory_backed:1,/* Do not count its dirty pages in nr_dirty */
+		swap_backed:1;	/* Its memory_backed writepage goes to swap */
 };
 
 extern struct backing_dev_info default_backing_dev_info;

