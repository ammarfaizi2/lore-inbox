Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425432AbWLHLzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425432AbWLHLzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425429AbWLHLxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:53:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52384 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425428AbWLHLwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:52:55 -0500
Message-Id: <200612081152.kB8BqPNK019753@shell0.pdx.osdl.net>
Subject: [patch 02/13] clean up __set_page_dirty_nobuffers()
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Save a tabstop in __set_page_dirty_nobuffers() and __set_page_dirty_buffers()
and a few other places.  No functional changes.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/buffer.c         |   25 +++++------
 mm/page-writeback.c |   88 ++++++++++++++++++++----------------------
 2 files changed, 55 insertions(+), 58 deletions(-)

diff -puN fs/buffer.c~clean-up-__set_page_dirty_nobuffers fs/buffer.c
--- a/fs/buffer.c~clean-up-__set_page_dirty_nobuffers
+++ a/fs/buffer.c
@@ -724,20 +724,19 @@ int __set_page_dirty_buffers(struct page
 	}
 	spin_unlock(&mapping->private_lock);
 
-	if (!TestSetPageDirty(page)) {
-		write_lock_irq(&mapping->tree_lock);
-		if (page->mapping) {	/* Race with truncate? */
-			if (mapping_cap_account_dirty(mapping))
-				__inc_zone_page_state(page, NR_FILE_DIRTY);
-			radix_tree_tag_set(&mapping->page_tree,
-						page_index(page),
-						PAGECACHE_TAG_DIRTY);
-		}
-		write_unlock_irq(&mapping->tree_lock);
-		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-		return 1;
+	if (TestSetPageDirty(page))
+		return 0;
+
+	write_lock_irq(&mapping->tree_lock);
+	if (page->mapping) {	/* Race with truncate? */
+		if (mapping_cap_account_dirty(mapping))
+			__inc_zone_page_state(page, NR_FILE_DIRTY);
+		radix_tree_tag_set(&mapping->page_tree,
+				page_index(page), PAGECACHE_TAG_DIRTY);
 	}
-	return 0;
+	write_unlock_irq(&mapping->tree_lock);
+	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
+	return 1;
 }
 EXPORT_SYMBOL(__set_page_dirty_buffers);
 
diff -puN mm/page-writeback.c~clean-up-__set_page_dirty_nobuffers mm/page-writeback.c
--- a/mm/page-writeback.c~clean-up-__set_page_dirty_nobuffers
+++ a/mm/page-writeback.c
@@ -761,23 +761,22 @@ int __set_page_dirty_nobuffers(struct pa
 		struct address_space *mapping = page_mapping(page);
 		struct address_space *mapping2;
 
-		if (mapping) {
-			write_lock_irq(&mapping->tree_lock);
-			mapping2 = page_mapping(page);
-			if (mapping2) { /* Race with truncate? */
-				BUG_ON(mapping2 != mapping);
-				if (mapping_cap_account_dirty(mapping))
-					__inc_zone_page_state(page,
-								NR_FILE_DIRTY);
-				radix_tree_tag_set(&mapping->page_tree,
-					page_index(page), PAGECACHE_TAG_DIRTY);
-			}
-			write_unlock_irq(&mapping->tree_lock);
-			if (mapping->host) {
-				/* !PageAnon && !swapper_space */
-				__mark_inode_dirty(mapping->host,
-							I_DIRTY_PAGES);
-			}
+		if (!mapping)
+			return 1;
+
+		write_lock_irq(&mapping->tree_lock);
+		mapping2 = page_mapping(page);
+		if (mapping2) { /* Race with truncate? */
+			BUG_ON(mapping2 != mapping);
+			if (mapping_cap_account_dirty(mapping))
+				__inc_zone_page_state(page, NR_FILE_DIRTY);
+			radix_tree_tag_set(&mapping->page_tree,
+				page_index(page), PAGECACHE_TAG_DIRTY);
+		}
+		write_unlock_irq(&mapping->tree_lock);
+		if (mapping->host) {
+			/* !PageAnon && !swapper_space */
+			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 		}
 		return 1;
 	}
@@ -851,27 +850,26 @@ int test_clear_page_dirty(struct page *p
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
 
-	if (mapping) {
-		write_lock_irqsave(&mapping->tree_lock, flags);
-		if (TestClearPageDirty(page)) {
-			radix_tree_tag_clear(&mapping->page_tree,
-						page_index(page),
-						PAGECACHE_TAG_DIRTY);
-			write_unlock_irqrestore(&mapping->tree_lock, flags);
-			/*
-			 * We can continue to use `mapping' here because the
-			 * page is locked, which pins the address_space
-			 */
-			if (mapping_cap_account_dirty(mapping)) {
-				page_mkclean(page);
-				dec_zone_page_state(page, NR_FILE_DIRTY);
-			}
-			return 1;
-		}
+	if (!mapping)
+		return TestClearPageDirty(page);
+
+	write_lock_irqsave(&mapping->tree_lock, flags);
+	if (TestClearPageDirty(page)) {
+		radix_tree_tag_clear(&mapping->page_tree,
+				page_index(page), PAGECACHE_TAG_DIRTY);
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
-		return 0;
+		/*
+		 * We can continue to use `mapping' here because the
+		 * page is locked, which pins the address_space
+		 */
+		if (mapping_cap_account_dirty(mapping)) {
+			page_mkclean(page);
+			dec_zone_page_state(page, NR_FILE_DIRTY);
+		}
+		return 1;
 	}
-	return TestClearPageDirty(page);
+	write_unlock_irqrestore(&mapping->tree_lock, flags);
+	return 0;
 }
 EXPORT_SYMBOL(test_clear_page_dirty);
 
@@ -893,17 +891,17 @@ int clear_page_dirty_for_io(struct page 
 {
 	struct address_space *mapping = page_mapping(page);
 
-	if (mapping) {
-		if (TestClearPageDirty(page)) {
-			if (mapping_cap_account_dirty(mapping)) {
-				page_mkclean(page);
-				dec_zone_page_state(page, NR_FILE_DIRTY);
-			}
-			return 1;
+	if (!mapping)
+		return TestClearPageDirty(page);
+
+	if (TestClearPageDirty(page)) {
+		if (mapping_cap_account_dirty(mapping)) {
+			page_mkclean(page);
+			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
-		return 0;
+		return 1;
 	}
-	return TestClearPageDirty(page);
+	return 0;
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
_
