Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWHRPgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWHRPgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWHRPgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:36:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1196 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161018AbWHRPgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:36:00 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/7] FS-Cache: Release page->private after failed readahead [try #12]
Date: Fri, 18 Aug 2006 16:35:10 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060818153510.29482.85946.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060818153502.29482.91650.stgit@warthog.cambridge.redhat.com>
References: <20060818153502.29482.91650.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch causes read_cache_pages() to release page-private data on a
page for which add_to_page_cache() fails or the filler function fails. This
permits pages with caching references associated with them to be cleaned up.

The invalidatepage() address space op is called (indirectly) to do the honours.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/readahead.c |   46 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index aa7ec42..b0788ae 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -14,6 +14,7 @@ #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/buffer_head.h>
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -117,6 +118,41 @@ static inline unsigned long get_next_ra_
 
 #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
 
+/*
+ * see if a page needs releasing upon read_cache_pages() failure
+ * - the caller of read_cache_pages() may have set PG_private before calling,
+ *   such as the NFS fs marking pages that are cached locally on disk, thus we
+ *   need to give the fs a chance to clean up in the event of an error
+ */
+static void read_cache_pages_invalidate_page(struct address_space *mapping,
+					     struct page *page)
+{
+	if (PagePrivate(page)) {
+		if (TestSetPageLocked(page))
+			BUG();
+		page->mapping = mapping;
+		do_invalidatepage(page, 0);
+		page->mapping = NULL;
+		unlock_page(page);
+	}
+	page_cache_release(page);
+}
+
+/*
+ * release a list of pages, invalidating them first if need be
+ */
+static void read_cache_pages_invalidate_pages(struct address_space *mapping,
+					      struct list_head *pages)
+{
+	struct page *victim;
+
+	while (!list_empty(pages)) {
+		victim = list_to_page(pages);
+		list_del(&victim->lru);
+		read_cache_pages_invalidate_page(mapping, victim);
+	}
+}
+
 /**
  * read_cache_pages - populate an address space with some pages & start reads against them
  * @mapping: the address_space
@@ -140,20 +176,14 @@ int read_cache_pages(struct address_spac
 		page = list_to_page(pages);
 		list_del(&page->lru);
 		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
-			page_cache_release(page);
+			read_cache_pages_invalidate_page(mapping, page);
 			continue;
 		}
 		ret = filler(data, page);
 		if (!pagevec_add(&lru_pvec, page))
 			__pagevec_lru_add(&lru_pvec);
 		if (ret) {
-			while (!list_empty(pages)) {
-				struct page *victim;
-
-				victim = list_to_page(pages);
-				list_del(&victim->lru);
-				page_cache_release(victim);
-			}
+			read_cache_pages_invalidate_pages(mapping, pages);
 			break;
 		}
 	}
