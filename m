Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWD3NiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWD3NiU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 09:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWD3NiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 09:38:20 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:56171 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751121AbWD3NiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 09:38:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=HBdZVRG7Xn9bc575+6K6+bKGmCuvuwonEZ3R2MS+J4s3VHh8jPYco+Uhj9lMaF35ru7yTz2l8tUs1Lzyp/Cd+6RE4XE0moeR4tWi9dfELvuFX8zmKybvcjC5onfPCkh3UmLxsNm8HtBXAbNxtZP3lSmuhfGk2MAgGpYZ2JHf4so=  ;
Message-ID: <4454A335.7070600@yahoo.com.au>
Date: Sun, 30 Apr 2006 21:44:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: David Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com> <20060426114737.239806a2.akpm@osdl.org> <20060426184945.GL5002@suse.de> <Pine.LNX.4.64.0604261330310.20897@schroedinger.engr.sgi.com> <20060428140146.GA4657648@melbourne.sgi.com> <44548834.5050204@yahoo.com.au> <20060430113905.GF23137@suse.de>
In-Reply-To: <20060430113905.GF23137@suse.de>
Content-Type: multipart/mixed;
 boundary="------------010808020108030103080106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010808020108030103080106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

> You killed a lock too many there. I'm sure it'd help scalability,
> though :-)

Ssshh! That was my secret plan :)

Good catch though, thanks. I'll attach a new patch in case David
has a chance to try it out.

-- 
SUSE Labs, Novell Inc.

--------------010808020108030103080106
Content-Type: text/plain;
 name="mm-batch-ra-pagecache-add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-batch-ra-pagecache-add.patch"

Index: linux-2.6/fs/mpage.c
===================================================================
--- linux-2.6.orig/fs/mpage.c	2006-04-30 19:36:18.000000000 +1000
+++ linux-2.6/fs/mpage.c	2006-04-30 21:42:15.000000000 +1000
@@ -26,6 +26,7 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/swap.h>
 
 /*
  * I/O completion handler for multipage BIOs.
@@ -389,31 +390,57 @@ mpage_readpages(struct address_space *ma
 	struct bio *bio = NULL;
 	unsigned page_idx;
 	sector_t last_block_in_bio = 0;
-	struct pagevec lru_pvec;
+	struct pagevec pvec;
 	struct buffer_head map_bh;
 	unsigned long first_logical_block = 0;
 
 	clear_buffer_mapped(&map_bh);
-	pagevec_init(&lru_pvec, 0);
+	pagevec_init(&pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, lru);
 
 		prefetchw(&page->flags);
 		list_del(&page->lru);
-		if (!add_to_page_cache(page, mapping,
-					page->index, GFP_KERNEL)) {
-			bio = do_mpage_readpage(bio, page,
-					nr_pages - page_idx,
-					&last_block_in_bio, &map_bh,
-					&first_logical_block,
-					get_block);
-			if (!pagevec_add(&lru_pvec, page))
-				__pagevec_lru_add(&lru_pvec);
-		} else {
-			page_cache_release(page);
+
+		if (!pagevec_add(&pvec, page) || page_idx == nr_pages-1) {
+			int i = 0, in_cache;
+
+			if (radix_tree_preload(GFP_KERNEL))
+				goto pagevec_error;
+
+			write_lock_irq(&mapping->tree_lock);
+			for (; i < pagevec_count(&pvec); i++) {
+				struct page *page = pvec.pages[i];
+				unsigned long offset = page->index;
+
+				if (__add_to_page_cache(page, mapping, offset))
+					break; /* error */
+			}
+			write_unlock_irq(&mapping->tree_lock);
+			radix_tree_preload_end();
+
+			in_cache = i;
+			for (i = 0; i < in_cache; i++) {
+				struct page *page = pvec.pages[i];
+
+				bio = do_mpage_readpage(bio, page,
+						nr_pages - page_idx,
+						&last_block_in_bio, &map_bh,
+						&first_logical_block,
+						get_block);
+				lru_cache_add(page);
+			}
+
+pagevec_error:
+			for (; i < pagevec_count(&pvec); i++) {
+				struct page *page = pvec.pages[i];
+				page_cache_release(page);
+			}
+
+			pagevec_reinit(&pvec);
 		}
 	}
-	pagevec_lru_add(&lru_pvec);
+
 	BUG_ON(!list_empty(pages));
 	if (bio)
 		mpage_bio_submit(READ, bio);
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c	2006-04-30 19:36:18.000000000 +1000
+++ linux-2.6/mm/filemap.c	2006-04-30 21:42:42.000000000 +1000
@@ -394,6 +394,21 @@ int filemap_write_and_wait_range(struct 
 	return err;
 }
 
+int __add_to_page_cache(struct page *page, struct address_space *mapping,
+		pgoff_t offset)
+{
+	int error = radix_tree_insert(&mapping->page_tree, offset, page);
+	if (!error) {
+		page_cache_get(page);
+		SetPageLocked(page);
+		page->mapping = mapping;
+		page->index = offset;
+		mapping->nrpages++;
+		pagecache_acct(1);
+	}
+	return error;
+}
+
 /*
  * This function is used to add newly allocated pagecache pages:
  * the page is new, so we can just run SetPageLocked() against it.
@@ -408,18 +423,11 @@ int add_to_page_cache(struct page *page,
 
 	if (error == 0) {
 		write_lock_irq(&mapping->tree_lock);
-		error = radix_tree_insert(&mapping->page_tree, offset, page);
-		if (!error) {
-			page_cache_get(page);
-			SetPageLocked(page);
-			page->mapping = mapping;
-			page->index = offset;
-			mapping->nrpages++;
-			pagecache_acct(1);
-		}
+		error = __add_to_page_cache(page, mapping, offset);
 		write_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
 	}
+
 	return error;
 }
 
Index: linux-2.6/mm/readahead.c
===================================================================
--- linux-2.6.orig/mm/readahead.c	2006-04-30 19:36:18.000000000 +1000
+++ linux-2.6/mm/readahead.c	2006-04-30 21:42:15.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/swap.h>
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -164,37 +165,60 @@ int read_cache_pages(struct address_spac
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static int read_pages(struct address_space *mapping, struct file *filp,
+static void __pagevec_read_pages(struct file *filp,
+		struct address_space *mapping, struct pagevec *pvec)
+{
+	int i = 0, in_cache;
+
+	if (radix_tree_preload(GFP_KERNEL))
+		goto out_error;
+
+	write_lock_irq(&mapping->tree_lock);
+	for (; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		unsigned long offset = page->index;
+
+		if (__add_to_page_cache(page, mapping, offset))
+			break; /* error */
+	}
+	write_unlock_irq(&mapping->tree_lock);
+	radix_tree_preload_end();
+
+	in_cache = i;
+	for (i = 0; i < in_cache; i++) {
+		struct page *page = pvec->pages[i];
+		mapping->a_ops->readpage(filp, page);
+		lru_cache_add(page);
+	}
+
+out_error:
+	for (; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		page_cache_release(page);
+	}
+
+	pagevec_reinit(pvec);
+}
+
+static void read_pages(struct address_space *mapping, struct file *filp,
 		struct list_head *pages, unsigned nr_pages)
 {
-	unsigned page_idx;
-	struct pagevec lru_pvec;
-	int ret;
+	unsigned i;
+	struct pagevec pvec;
 
 	if (mapping->a_ops->readpages) {
-		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
-		goto out;
+		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
+		return;
 	}
 
-	pagevec_init(&lru_pvec, 0);
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
+	pagevec_init(&pvec, 0);
+	for (i = 0; i < nr_pages; i++) {
 		struct page *page = list_to_page(pages);
 		list_del(&page->lru);
-		if (!add_to_page_cache(page, mapping,
-					page->index, GFP_KERNEL)) {
-			ret = mapping->a_ops->readpage(filp, page);
-			if (ret != AOP_TRUNCATED_PAGE) {
-				if (!pagevec_add(&lru_pvec, page))
-					__pagevec_lru_add(&lru_pvec);
-				continue;
-			} /* else fall through to release */
-		}
-		page_cache_release(page);
+
+		if (!pagevec_add(&pvec, page) || i == nr_pages-1)
+			__pagevec_read_pages(filp, mapping, &pvec);
 	}
-	pagevec_lru_add(&lru_pvec);
-	ret = 0;
-out:
-	return ret;
 }
 
 /*
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h	2006-04-30 19:36:18.000000000 +1000
+++ linux-2.6/include/linux/pagemap.h	2006-04-30 21:42:16.000000000 +1000
@@ -97,6 +97,8 @@ extern struct page * read_cache_page(str
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
 
+int __add_to_page_cache(struct page *page, struct address_space *mapping,
+				unsigned long index);
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 				unsigned long index, gfp_t gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,

--------------010808020108030103080106--
Send instant messages to your online friends http://au.messenger.yahoo.com 
