Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161443AbWJKVMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161443AbWJKVMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161453AbWJKVJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:09:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:50083 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161451AbWJKVJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:30 -0400
Date: Wed, 11 Oct 2006 14:08:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, nickpiggin@yahoo.com.au,
       Chuck Lever <cel@citi.umich.edu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 61/67] invalidate_inode_pages2(): ignore page refcounts
Message-ID: <20061011210856.GJ16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="invalidate_inode_pages2-ignore-page-refcounts.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
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
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 mm/truncate.c |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/mm/truncate.c
+++ linux-2.6.18/mm/truncate.c
@@ -270,9 +270,39 @@ unsigned long invalidate_inode_pages(str
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
@@ -339,7 +369,7 @@ int invalidate_inode_pages2_range(struct
 				}
 			}
 			was_dirty = test_clear_page_dirty(page);
-			if (!invalidate_complete_page(mapping, page)) {
+			if (!invalidate_complete_page2(mapping, page)) {
 				if (was_dirty)
 					set_page_dirty(page);
 				ret = -EIO;

--
