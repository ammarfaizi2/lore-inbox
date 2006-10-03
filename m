Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWJCSEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWJCSEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWJCSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:04:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030344AbWJCSET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:04:19 -0400
Date: Tue, 3 Oct 2006 11:03:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chip Coldwell <coldwell@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: direct IO regression in 2.6.18
Message-Id: <20061003110348.c3ce6337.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610031330400.31975@localhost.localdomain>
References: <Pine.LNX.4.64.0610031330400.31975@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 13:51:49 -0400 (EDT)
Chip Coldwell <coldwell@redhat.com> wrote:

> Hi,
> 
> The following commit caused a regression in direct IO:
> 
> commit 016eb4a0ed06a3677d67a584da901f0e9a63c666
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Fri Sep 8 09:48:38 2006 -0700
> 
>      [PATCH] invalidate_complete_page() race fix
> 
> ...
> 
> The issue is that invalidate_complete_page is in two different code
> paths, the normal one (prune_icache calls invalidate_inode_pages calls
> invalidate_mapping_pages calls invalidate_complete_page) and also via
> direct IO (generic_file_direct_write calls generic_file_direct_IO
> calls invalidate_inode_pages2_range calls invalidate_complete_page).
> In the latter case, the page is (usually) not even in the page cache
> and the refcount can legitimately != 2.


The below was merged earlier this week and is tagged for 2.6.18.x.
You just falsified my changelog ;)



From: Andrew Morton <akpm@osdl.org>

The recent fix to invalidate_inode_pages() (git commit 016eb4a) managed to
unfix invalidate_inode_pages2().

The problem is that various bits of code in the kernel can take transient refs
on pages: the page scanner will do this when inspecting a batch of pages, and
the lru_cache_add() batching pagevecs also hold a ref.

Net result is transient failures in invalidate_inode_pages2().  This affects
NFS directory invalidation (observed) and presumably also block-backed
direct-io (not yet reported).

Fix it by reverting invalidate_inode_pages2() back to the old version which
ignores the page refcounts.

We may come up with something more clever later, but for now we need a 2.6.18
fix for NFS.

Cc: Chuck Lever <cel@citi.umich.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/truncate.c |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff -puN mm/truncate.c~invalidate_inode_pages2-ignore-page-refcounts mm/truncate.c
--- a/mm/truncate.c~invalidate_inode_pages2-ignore-page-refcounts
+++ a/mm/truncate.c
@@ -287,9 +287,39 @@ unsigned long invalidate_inode_pages(str
 {
 	return invalidate_mapping_pages(mapping, 0, ~0UL);
 }
-
 EXPORT_SYMBOL(invalidate_inode_pages);
 
+/*
+ * This is like invalidate_complete_page(), except it ignores the page's
+ * refcount.  We do this because invalidate_inode_pages2() needs stronger
+ * invalidation guarantees, and cannot afford to leave pages behind because
+ * shrink_list() has a temp ref on them, or because they're transiently sitting
+ * in the lru_cache_add() pagevecs.
+ */
+static int
+invalidate_complete_page2(struct address_space *mapping, struct page *page)
+{
+	if (page->mapping != mapping)
+		return 0;
+
+	if (PagePrivate(page) && !try_to_release_page(page, 0))
+		return 0;
+
+	write_lock_irq(&mapping->tree_lock);
+	if (PageDirty(page))
+		goto failed;
+
+	BUG_ON(PagePrivate(page));
+	__remove_from_page_cache(page);
+	write_unlock_irq(&mapping->tree_lock);
+	ClearPageUptodate(page);
+	page_cache_release(page);	/* pagecache ref */
+	return 1;
+failed:
+	write_unlock_irq(&mapping->tree_lock);
+	return 0;
+}
+
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_space
  * @mapping: the address_space
@@ -356,7 +386,7 @@ int invalidate_inode_pages2_range(struct
 				}
 			}
 			was_dirty = test_clear_page_dirty(page);
-			if (!invalidate_complete_page(mapping, page)) {
+			if (!invalidate_complete_page2(mapping, page)) {
 				if (was_dirty)
 					set_page_dirty(page);
 				ret = -EIO;
_

