Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSHKH2l>; Sun, 11 Aug 2002 03:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSHKH2C>; Sun, 11 Aug 2002 03:28:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34310 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317978AbSHKHZY>;
	Sun, 11 Aug 2002 03:25:24 -0400
Message-ID: <3D561496.66498087@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/21] batched LRU movement of written back pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Makes mpage_writepages() move pages around on the LRU sixteen-at-a-time
rather than one-at-a-time.



 mpage.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

--- 2.5.31/fs/mpage.c~mpage_writepages-batch	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/fs/mpage.c	Sun Aug 11 00:21:02 2002
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/prefetch.h>
 #include <linux/mpage.h>
+#include <linux/pagevec.h>
 
 /*
  * The largest-sized BIO which this code will assemble, in bytes.  Set this
@@ -522,12 +523,14 @@ mpage_writepages(struct address_space *m
 	sector_t last_block_in_bio = 0;
 	int ret = 0;
 	int done = 0;
+	struct pagevec pvec;
 	int (*writepage)(struct page *);
 
 	writepage = NULL;
 	if (get_block == NULL)
 		writepage = mapping->a_ops->writepage;
 
+	pagevec_init(&pvec);
 	write_lock(&mapping->page_lock);
 
 	list_splice_init(&mapping->dirty_pages, &mapping->io_pages);
@@ -557,29 +560,25 @@ mpage_writepages(struct address_space *m
 
 		if (page->mapping && !PageWriteback(page) &&
 					TestClearPageDirty(page)) {
-			/* FIXME: batch this up */
-			if (!PageActive(page) && PageLRU(page)) {
-				spin_lock(&pagemap_lru_lock);
-				if (!PageActive(page) && PageLRU(page)) {
-					list_del(&page->lru);
-					list_add(&page->lru, &inactive_list);
-				}
-				spin_unlock(&pagemap_lru_lock);
-			}
-
 			if (writepage) {
 				ret = (*writepage)(page);
 			} else {
 				bio = mpage_writepage(bio, page, get_block,
 						&last_block_in_bio, &ret);
 			}
+			if (!PageActive(page) && PageLRU(page)) {
+				if (!pagevec_add(&pvec, page))
+					pagevec_deactivate_inactive(&pvec);
+				page = NULL;
+			}
 			if (ret || (nr_to_write && --(*nr_to_write) <= 0))
 				done = 1;
 		} else {
 			unlock_page(page);
 		}
 
-		page_cache_release(page);
+		if (page)
+			page_cache_release(page);
 		write_lock(&mapping->page_lock);
 	}
 	/*
@@ -587,6 +586,7 @@ mpage_writepages(struct address_space *m
 	 */
 	list_splice_init(&mapping->io_pages, mapping->dirty_pages.prev);
 	write_unlock(&mapping->page_lock);
+	pagevec_deactivate_inactive(&pvec);
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
 	return ret;

.
