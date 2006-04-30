Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWD3LHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWD3LHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 07:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWD3LHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 07:07:07 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:8814 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751092AbWD3LHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 07:07:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=rsz5lEF7p6+PrgsC0HW2+i7nikHJL4hQ6VyGOdSOjc8pdkvKcgAFqSCO588nyPYCYLnAX66UJoODanSX9Pg99aV6UUs39YSBQUk9HOSfp4R83HdhqvFOwi1SolxfC5mJbdazwuXhSyVoRvgt7HEUy2OdTom3/vE+e7qge12DLEU=  ;
Message-ID: <44548834.5050204@yahoo.com.au>
Date: Sun, 30 Apr 2006 19:49:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: Christoph Lameter <clameter@sgi.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com> <20060426114737.239806a2.akpm@osdl.org> <20060426184945.GL5002@suse.de> <Pine.LNX.4.64.0604261330310.20897@schroedinger.engr.sgi.com> <20060428140146.GA4657648@melbourne.sgi.com>
In-Reply-To: <20060428140146.GA4657648@melbourne.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------000607070605020506000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607070605020506000408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

Forgive my selective quoting...

David Chinner wrote:
> Take a large file - say Size = 5x RAM or so - and then start
> N threads runnnning at offset (n / Size) where n = the thread
> number. They each read (Size / N) and so typically don't overlap. 
> 
> Throughput with increasing numbers of threads on a 24p altix
> on an XFS filesystem on 2.6.15-rc5 looks like:
> 
> Loads      tput
> -----   -------
>   1      789.59
>   2     1191.56
>   4     1724.63
>   8     1213.63
>   16    1057.03
>   32     744.73
> 
> Basically,  we hit a scaling limitation at b/t 4 and 8 threads. This was
> consistent across I/O sizes from 4KB to 4MB. I took a simple 30s PC sample
> profile:

> Percent  Routine
> --------------------------
>   63.62  _write_lock_irqsave
>   15.66  _read_unlock_irq

> So read_unlock_irq looks to be triggered by the mapping->tree_lock.
> 
> I think that the write_lock_irqsave() contention is from memory
> reclaim (shrink_list()->try_to_release_page()-> ->releasepage()->
> xfs_vm_releasepage()-> try_to_free_buffers()->clear_page_dirty()->
> test_clear_page_dirty()-> write_lock_irqsave(&mapping->tree_lock...))
> because page cache memory was full of this one file and demand is
> causing them to be constantly recycled.

I'd say you're right.

tree_lock contention will be coming from a number of sources. reclaim,
as you say, will be a big one. mpage_readpages (from readahead) will
be another.

Then the read lock in find_get_page in generic_mapping_read will start
contending heavily on the writers and not get much concurrency.

I'm sure lockless (read-side) pagecache will help... not only will it
eliminate read_lock costs, but the reduced read contention should also
decrease write_lock contention and bouncing.

As well as lockless pagecache, I think we can batch tree_lock operations
in readahead. Would be interesting to see how much this patch helps.

-- 
SUSE Labs, Novell Inc.

--------------000607070605020506000408
Content-Type: text/plain;
 name="mm-batch-ra-pagecache-add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-batch-ra-pagecache-add.patch"

Index: linux-2.6/fs/mpage.c
===================================================================
--- linux-2.6.orig/fs/mpage.c	2006-04-30 19:19:14.000000000 +1000
+++ linux-2.6/fs/mpage.c	2006-04-30 19:23:08.000000000 +1000
@@ -26,6 +26,7 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/swap.h>
 
 /*
  * I/O completion handler for multipage BIOs.
@@ -389,31 +390,57 @@
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
--- linux-2.6.orig/mm/filemap.c	2006-04-30 19:19:14.000000000 +1000
+++ linux-2.6/mm/filemap.c	2006-04-30 19:20:01.000000000 +1000
@@ -394,6 +394,21 @@
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
@@ -407,19 +422,10 @@
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
-		write_lock_irq(&mapping->tree_lock);
-		error = radix_tree_insert(&mapping->page_tree, offset, page);
-		if (!error) {
-			page_cache_get(page);
-			SetPageLocked(page);
-			page->mapping = mapping;
-			page->index = offset;
-			mapping->nrpages++;
-			pagecache_acct(1);
-		}
-		write_unlock_irq(&mapping->tree_lock);
+		error = __add_to_page_cache(page, mapping, offset);
 		radix_tree_preload_end();
 	}
+
 	return error;
 }
 
Index: linux-2.6/mm/readahead.c
===================================================================
--- linux-2.6.orig/mm/readahead.c	2006-04-30 19:19:14.000000000 +1000
+++ linux-2.6/mm/readahead.c	2006-04-30 19:23:19.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/swap.h>
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -164,37 +165,60 @@
 
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
--- linux-2.6.orig/include/linux/pagemap.h	2006-04-30 19:19:14.000000000 +1000
+++ linux-2.6/include/linux/pagemap.h	2006-04-30 19:20:01.000000000 +1000
@@ -97,6 +97,8 @@
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
 
+int __add_to_page_cache(struct page *page, struct address_space *mapping,
+				unsigned long index);
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 				unsigned long index, gfp_t gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,

--------------000607070605020506000408--
Send instant messages to your online friends http://au.messenger.yahoo.com 
