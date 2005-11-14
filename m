Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVKNV5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVKNV5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVKNVza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:55:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751283AbVKNVzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:16 -0500
Date: Mon, 14 Nov 2005 21:54:38 GMT
Message-Id: <200511142154.jAELscNf007525@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 6/12] FS-Cache: Add a function to replace a page in the pagecache
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a function by which an existing page in the pagecache
may be traded for a new one at the same location without having to allocate or
free any radix tree nodes.

This permits CacheFS to write to start making a new version of a disk block in
memory for which the old version has not yet been written and journalled.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 replace-in-pagecache-2614mm2.diff
 include/linux/pagemap.h |    3 +++
 mm/filemap.c            |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff -uNrp linux-2.6.14-mm2/include/linux/pagemap.h linux-2.6.14-mm2-cachefs/include/linux/pagemap.h
--- linux-2.6.14-mm2/include/linux/pagemap.h	2005-11-14 16:17:59.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/include/linux/pagemap.h	2005-11-14 16:24:47.000000000 +0000
@@ -96,6 +96,9 @@ int add_to_page_cache(struct page *page,
 				unsigned long index, gfp_t gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				unsigned long index, gfp_t gfp_mask);
+extern struct page *replace_in_page_cache(struct page *page,
+					  struct address_space *mapping,
+					  pgoff_t offset);
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
diff -uNrp linux-2.6.14-mm2/mm/filemap.c linux-2.6.14-mm2-cachefs/mm/filemap.c
--- linux-2.6.14-mm2/mm/filemap.c	2005-11-14 16:18:00.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/mm/filemap.c	2005-11-14 16:23:41.000000000 +0000
@@ -427,6 +427,39 @@ int add_to_page_cache_lru(struct page *p
 EXPORT_SYMBOL(add_to_page_cache_lru);
 
 /*
+ * This function replaces a page already in the page cache for a particular
+ * index with another, but only if there is already such a page in the page
+ * cache
+ */
+struct page *replace_in_page_cache(struct page *page,
+				   struct address_space *mapping,
+				   pgoff_t offset)
+{
+	struct page *old;
+	void **slot;
+
+	write_lock_irq(&mapping->tree_lock);
+
+	slot = radix_tree_lookup_slot(&mapping->page_tree, offset);
+	old = NULL;
+	if (slot) {
+		old = *slot;
+		*slot = page;
+		page_cache_get(page);
+		SetPageLocked(page);
+		page->mapping = mapping;
+		page->index = offset;
+		if (old)
+			old->mapping = NULL;
+	}
+
+	write_unlock_irq(&mapping->tree_lock);
+	return old;
+}
+
+EXPORT_SYMBOL(replace_in_page_cache);
+
+/*
  * In order to wait for pages to become available there must be
  * waitqueues associated with pages. By using a hash table of
  * waitqueues where the bucket discipline is to maintain all
