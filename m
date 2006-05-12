Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWELMts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWELMts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWELMtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:49:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6075 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751155AbWELMtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:49:46 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060510160148.9058.81776.stgit@warthog.cambridge.redhat.com> 
References: <20060510160148.9058.81776.stgit@warthog.cambridge.redhat.com>  <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] FS-Cache: Release page->private in failed readahead [try #9] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 12 May 2006 13:49:30 +0100
Message-ID: <13241.1147438170@warthog.cambridge.redhat.com>
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

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/readahead.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 0f142a4..5e9d183 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -14,6 +14,7 @@ #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/buffer_head.h>
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -117,6 +118,22 @@ static inline unsigned long get_next_ra_
 
 #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
 
+/*
+ * see if a page needs releasing upon read_cache_pages() failure
+ */
+static inline void read_cache_pages_release_page(struct address_space *mapping,
+						 struct page *page)
+{
+	if (PagePrivate(page)) {
+		page->mapping = mapping;
+		SetPageLocked(page);
+		try_to_release_page(page, GFP_KERNEL);
+		page->mapping = NULL;
+	}
+
+	page_cache_release(page);
+}
+
 /**
  * read_cache_pages - populate an address space with some pages, and
  * 			start reads against them.
@@ -141,7 +158,7 @@ int read_cache_pages(struct address_spac
 		page = list_to_page(pages);
 		list_del(&page->lru);
 		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
-			page_cache_release(page);
+			read_cache_pages_release_page(mapping, page);
 			continue;
 		}
 		ret = filler(data, page);
@@ -153,7 +170,7 @@ int read_cache_pages(struct address_spac
 
 				victim = list_to_page(pages);
 				list_del(&victim->lru);
-				page_cache_release(victim);
+				read_cache_pages_release_page(mapping, victim);
 			}
 			break;
 		}
