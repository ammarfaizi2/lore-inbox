Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWG0VGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWG0VGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWG0VBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:01:11 -0400
Received: from mx2.redhat.com ([66.187.237.31]:19170 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1751048AbWG0Uxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:45 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 24/30] FS-Cache: Release page->private in failed readahead [try #11]
Date: Thu, 27 Jul 2006 21:53:20 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205320.8443.50130.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch causes read_cache_pages() to release page-private data on a
page for which add_to_page_cache() fails or the filler function fails. This
permits pages with caching references associated with them to be cleaned up.

Further changes [try #9] that have been made:

 (*) The try_to_release_page() is called instead of calling the releasepage()
     op directly.

 (*) The page is locked before try_to_release_page() is called.

 (*) The call to try_to_release_page() and page_cache_release() have been
     abstracted out into a helper function as this bit of code occurs twice..

Further changes [try #10] that have been made:

 (*) The comment header on the helper function is much expanded.  This states
     why there's a need to call the releasepage() op in the event of an error.

 (*) BUG() if the page is already locked when we try and lock it.

 (*) Don't set the page mapping pointer until we've locked the page.

 (*) The page is unlocked after try_to_release_page() is called.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/readahead.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index aa7ec42..54d3393 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -14,6 +14,7 @@ #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/buffer_head.h>
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -117,6 +118,26 @@ static inline unsigned long get_next_ra_
 
 #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
 
+/*
+ * see if a page needs releasing upon read_cache_pages() failure
+ * - the caller of read_cache_pages() may have set PG_private before calling,
+ *   such as the NFS fs marking pages that are cached locally on disk, thus we
+ *   need to give the fs a chance to clean up in the event of an error
+ */
+static void read_cache_pages_release_page(struct address_space *mapping,
+					  struct page *page)
+{
+	if (PagePrivate(page)) {
+		if (TestSetPageLocked(page))
+			BUG();
+		page->mapping = mapping;
+		try_to_release_page(page, GFP_KERNEL);
+		page->mapping = NULL;
+		unlock_page(page);
+	}
+	page_cache_release(page);
+}
+
 /**
  * read_cache_pages - populate an address space with some pages & start reads against them
  * @mapping: the address_space
@@ -140,7 +161,7 @@ int read_cache_pages(struct address_spac
 		page = list_to_page(pages);
 		list_del(&page->lru);
 		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
-			page_cache_release(page);
+			read_cache_pages_release_page(mapping, page);
 			continue;
 		}
 		ret = filler(data, page);
@@ -152,7 +173,7 @@ int read_cache_pages(struct address_spac
 
 				victim = list_to_page(pages);
 				list_del(&victim->lru);
-				page_cache_release(victim);
+				read_cache_pages_release_page(mapping, victim);
 			}
 			break;
 		}
