Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968000AbWLEBkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968000AbWLEBkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 20:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968003AbWLEBkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 20:40:21 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:58821 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S968000AbWLEBkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 20:40:18 -0500
Message-ID: <365282812.05573@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 5 Dec 2006 09:40:11 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [rfc] possible page manipulation simplifications?
Message-ID: <20061205014011.GA6806@mail.ustc.edu.cn>
Mail-Followup-To: Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@skynet.ie>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
References: <20061202121519.GA20670@wotan.suse.de> <20061204144005.GA22233@skynet.ie> <20061204145552.GB14383@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204145552.GB14383@wotan.suse.de>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 03:55:52PM +0100, Nick Piggin wrote:
> Hi Mel,
> 
> I think you're right about the leakage, thanks for catching it.

Yeah, it caused oom storm here.

The pagevec simplification looks nice.

I've ported it to -mm, hope it is useful.
I'm prepared to test your revised patch :)

Fengguang Wu
---

--- linux-2.6.19-rc6-mm2.orig/mm/filemap.c
+++ linux-2.6.19-rc6-mm2/mm/filemap.c
@@ -708,26 +708,18 @@ EXPORT_SYMBOL(find_lock_page);
 struct page *find_or_create_page(struct address_space *mapping,
 		unsigned long index, gfp_t gfp_mask)
 {
-	struct page *page, *cached_page = NULL;
+	struct page *page;
 	int err;
 repeat:
 	page = find_lock_page(mapping, index);
 	if (!page) {
-		if (!cached_page) {
-			cached_page = alloc_page(gfp_mask);
-			if (!cached_page)
-				return NULL;
-		}
-		err = add_to_page_cache_lru(cached_page, mapping,
-					index, gfp_mask);
-		if (!err) {
-			page = cached_page;
-			cached_page = NULL;
-		} else if (err == -EEXIST)
+		page = alloc_page(gfp_mask);
+		if (!page)
+			return NULL;
+		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
+		if (err == -EEXIST)
 			goto repeat;
 	}
-	if (cached_page)
-		page_cache_release(cached_page);
 	return page;
 }
 EXPORT_SYMBOL(find_or_create_page);
@@ -922,11 +914,9 @@ void do_generic_mapping_read(struct addr
 	unsigned long next_index;
 	unsigned long prev_index;
 	loff_t isize;
-	struct page *cached_page;
 	int error;
 	struct file_ra_state ra = *_ra;
 
-	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
 	prev_index = ra.prev_page;
@@ -1107,14 +1097,12 @@ no_cached_page:
 		 * Ok, it wasn't cached, so we need to create a new
 		 * page..
 		 */
-		if (!cached_page) {
-			cached_page = page_cache_alloc_cold(mapping);
-			if (!cached_page) {
-				desc->error = -ENOMEM;
-				goto out;
-			}
+		page = page_cache_alloc_cold(mapping);
+		if (!page) {
+			desc->error = -ENOMEM;
+			goto out;
 		}
-		error = add_to_page_cache_lru(cached_page, mapping,
+		error = add_to_page_cache_lru(page, mapping,
 						index, GFP_KERNEL);
 		if (error) {
 			if (error == -EEXIST)
@@ -1122,8 +1110,6 @@ no_cached_page:
 			desc->error = error;
 			goto out;
 		}
-		page = cached_page;
-		cached_page = NULL;
 		goto readpage;
 	}
 
@@ -1133,8 +1119,6 @@ out:
 		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
-	if (cached_page)
-		page_cache_release(cached_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1826,35 +1810,28 @@ static inline struct page *__read_cache_
 				int (*filler)(void *,struct page*),
 				void *data)
 {
-	struct page *page, *cached_page = NULL;
+	struct page *page;
 	int err;
 repeat:
 	page = find_get_page(mapping, index);
 	if (!page) {
-		if (!cached_page) {
-			cached_page = page_cache_alloc_cold(mapping);
-			if (!cached_page)
-				return ERR_PTR(-ENOMEM);
-		}
-		err = add_to_page_cache_lru(cached_page, mapping,
-					index, GFP_KERNEL);
+		page = page_cache_alloc_cold(mapping);
+		if (!page)
+			return ERR_PTR(-ENOMEM);
+		err = add_to_page_cache_lru(page, mapping, index, GFP_KERNEL);
 		if (err == -EEXIST)
 			goto repeat;
 		if (err < 0) {
 			/* Presumably ENOMEM for radix tree node */
-			page_cache_release(cached_page);
+			page_cache_release(page);
 			return ERR_PTR(err);
 		}
-		page = cached_page;
-		cached_page = NULL;
 		err = filler(data, page);
 		if (err < 0) {
 			page_cache_release(page);
 			page = ERR_PTR(err);
 		}
 	}
-	if (cached_page)
-		page_cache_release(cached_page);
 	return page;
 }
 
@@ -1905,40 +1882,6 @@ retry:
 EXPORT_SYMBOL(read_cache_page);
 
 /*
- * If the page was newly created, increment its refcount and add it to the
- * caller's lru-buffering pagevec.  This function is specifically for
- * generic_file_write().
- */
-static inline struct page *
-__grab_cache_page(struct address_space *mapping, unsigned long index,
-			struct page **cached_page, struct pagevec *lru_pvec)
-{
-	int err;
-	struct page *page;
-repeat:
-	page = find_lock_page(mapping, index);
-	if (!page) {
-		if (!*cached_page) {
-			*cached_page = page_cache_alloc(mapping);
-			if (!*cached_page)
-				return NULL;
-		}
-		err = add_to_page_cache(*cached_page, mapping,
-					index, GFP_KERNEL);
-		if (err == -EEXIST)
-			goto repeat;
-		if (err == 0) {
-			page = *cached_page;
-			page_cache_get(page);
-			if (!pagevec_add(lru_pvec, page))
-				__pagevec_lru_add(lru_pvec);
-			*cached_page = NULL;
-		}
-	}
-	return page;
-}
-
-/*
  * The logic we want is
  *
  *	if suid or (sgid and xgrp)
@@ -2143,15 +2086,11 @@ generic_file_buffered_write(struct kiocb
 	struct inode 	*inode = mapping->host;
 	long		status = 0;
 	struct page	*page;
-	struct page	*cached_page = NULL;
 	size_t		bytes;
-	struct pagevec	lru_pvec;
 	const struct iovec *cur_iov = iov; /* current iovec */
 	size_t		iov_base = 0;	   /* offset in the current iovec */
 	char __user	*buf;
 
-	pagevec_init(&lru_pvec, 0);
-
 	/*
 	 * handle partial DIO write.  Adjust cur_iov if needed.
 	 */
@@ -2189,10 +2128,23 @@ generic_file_buffered_write(struct kiocb
 		 */
 		fault_in_pages_readable(buf, bytes);
 
-		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
-		if (!page) {
-			status = -ENOMEM;
-			break;
+
+repeat:
+		page = find_lock_page(mapping, index);
+		if (unlikely(!page)) {
+			page = page_cache_alloc(mapping);
+			if (!page) {
+				status = -ENOMEM;
+				break;
+			}
+			status = add_to_page_cache_lru(page, mapping,
+						index, GFP_KERNEL);
+			if (status) {
+				page_cache_release(page);
+				if (status == -EEXIST)
+					goto repeat;
+				break;
+			}
 		}
 
 		if (unlikely(bytes == 0)) {
@@ -2264,9 +2216,6 @@ zero_length_segment:
 	} while (count);
 	*ppos = pos;
 
-	if (cached_page)
-		page_cache_release(cached_page);
-
 	/*
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
 	 */
@@ -2286,7 +2235,6 @@ zero_length_segment:
 	if (unlikely(file->f_flags & O_DIRECT) && written)
 		status = filemap_write_and_wait(mapping);
 
-	pagevec_lru_add(&lru_pvec);
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
--- linux-2.6.19-rc6-mm2.orig/fs/mpage.c
+++ linux-2.6.19-rc6-mm2/fs/mpage.c
@@ -389,33 +389,27 @@ mpage_readpages(struct address_space *ma
 	struct bio *bio = NULL;
 	unsigned page_idx;
 	sector_t last_block_in_bio = 0;
-	struct pagevec lru_pvec;
 	struct buffer_head map_bh;
 	unsigned long first_logical_block = 0;
 
 	clear_buffer_mapped(&map_bh);
-	pagevec_init(&lru_pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, lru);
 
 		prefetchw(&page->flags);
 		list_del(&page->lru);
-		if (!add_to_page_cache(page, mapping,
+		if (!add_to_page_cache_lru(page, mapping,
 					page->index, GFP_KERNEL)) {
 			bio = do_mpage_readpage(bio, page,
 					nr_pages - page_idx,
 					&last_block_in_bio, &map_bh,
 					&first_logical_block,
 					get_block);
-			if (!pagevec_add(&lru_pvec, page)) {
-				cond_resched();
-				__pagevec_lru_add(&lru_pvec);
-			}
+			cond_resched();
 		} else {
 			page_cache_release(page);
 		}
 	}
-	pagevec_lru_add(&lru_pvec);
 	BUG_ON(!list_empty(pages));
 	if (bio)
 		mpage_bio_submit(READ, bio);
--- linux-2.6.19-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc6-mm2/mm/readahead.c
@@ -230,30 +230,24 @@ int read_cache_pages(struct address_spac
 			int (*filler)(void *, struct page *), void *data)
 {
 	struct page *page;
-	struct pagevec lru_pvec;
 	int ret = 0;
 
-	pagevec_init(&lru_pvec, 0);
-
 	while (!list_empty(pages)) {
 		page = list_to_page(pages);
 		list_del(&page->lru);
-		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
+		if (add_to_page_cache_lru(page, mapping,
+					page->index, GFP_KERNEL)) {
 			page_cache_release(page);
 			continue;
 		}
 		ret = filler(data, page);
-		if (!pagevec_add(&lru_pvec, page)) {
-			cond_resched();
-			__pagevec_lru_add(&lru_pvec);
-		}
-		if (ret) {
+		if (unlikely(ret)) {
 			put_pages_list(pages);
 			break;
 		}
 		task_io_account_read(PAGE_CACHE_SIZE);
+		cond_resched();
 	}
-	pagevec_lru_add(&lru_pvec);
 	return ret;
 }
 
@@ -263,7 +257,6 @@ static int read_pages(struct address_spa
 		struct list_head *pages, unsigned nr_pages)
 {
 	unsigned page_idx;
-	struct pagevec lru_pvec;
 	int ret;
 
 	if (mapping->a_ops->readpages) {
@@ -273,21 +266,16 @@ static int read_pages(struct address_spa
 		goto out;
 	}
 
-	pagevec_init(&lru_pvec, 0);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_to_page(pages);
 		list_del(&page->lru);
-		if (!add_to_page_cache(page, mapping,
+		if (!add_to_page_cache_lru(page, mapping,
 					page->index, GFP_KERNEL)) {
 			mapping->a_ops->readpage(filp, page);
-			if (!pagevec_add(&lru_pvec, page)) {
-				cond_resched();
-				__pagevec_lru_add(&lru_pvec);
-			}
+			cond_resched();
 		} else
 			page_cache_release(page);
 	}
-	pagevec_lru_add(&lru_pvec);
 	ret = 0;
 out:
 	return ret;
