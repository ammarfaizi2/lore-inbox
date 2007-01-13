Return-Path: <linux-kernel-owner+w=401wt.eu-S1161216AbXAMDZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbXAMDZh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbXAMDZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:25:34 -0500
Received: from ns2.suse.de ([195.135.220.15]:46626 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161225AbXAMDZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:25:26 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20070113011305.9449.77379.sendpatchset@linux.site>
In-Reply-To: <20070113011159.9449.4327.sendpatchset@linux.site>
References: <20070113011159.9449.4327.sendpatchset@linux.site>
Subject: [patch 7/10] mm: cleanup pagecache insertion operations
Date: Sat, 13 Jan 2007 04:25:20 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a bit of code is used in maintaining these "cached pages" that are
probably pretty unlikely to get used. It would require a narrow race where
the page is inserted concurrently while this process is allocating a page
in order to create the spare page. Then a multi-page write into an uncached
part of the file, to make use of it.

Next, the buffered write path (and others) uses its own LRU pagevec when it
should be just using the per-CPU LRU pagevec (which will cut down on both data
and code size cacheline footprint). Also, these private LRU pagevecs are
emptied after just a very short time, in contrast with the per-CPU pagevecs
that are persistent. Net result: 7.3 times fewer lru_lock acquisitions required
to add the pages to pagecache for a bulk write (in 4K chunks).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -686,26 +686,22 @@ EXPORT_SYMBOL(find_lock_page);
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
-			goto repeat;
+		page = alloc_page(gfp_mask);
+		if (!page)
+			return NULL;
+		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
+		if (unlikely(err)) {
+			page_cache_release(page);
+			page = NULL;
+			if (err == -EEXIST)
+				goto repeat;
+		}
 	}
-	if (cached_page)
-		page_cache_release(cached_page);
 	return page;
 }
 EXPORT_SYMBOL(find_or_create_page);
@@ -891,11 +887,9 @@ void do_generic_mapping_read(struct addr
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
@@ -1059,23 +1053,20 @@ no_cached_page:
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
+			page_cache_release(page);
 			if (error == -EEXIST)
 				goto find_page;
 			desc->error = error;
 			goto out;
 		}
-		page = cached_page;
-		cached_page = NULL;
 		goto readpage;
 	}
 
@@ -1083,8 +1074,6 @@ out:
 	*_ra = ra;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
-	if (cached_page)
-		page_cache_release(cached_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1542,35 +1531,28 @@ static inline struct page *__read_cache_
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
-		if (err == -EEXIST)
-			goto repeat;
-		if (err < 0) {
+		page = page_cache_alloc_cold(mapping);
+		if (!page)
+			return ERR_PTR(-ENOMEM);
+		err = add_to_page_cache_lru(page, mapping, index, GFP_KERNEL);
+		if (unlikely(err)) {
+			page_cache_release(page);
+			if (err == -EEXIST)
+				goto repeat;
 			/* Presumably ENOMEM for radix tree node */
-			page_cache_release(cached_page);
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
 
@@ -1621,40 +1603,6 @@ retry:
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
@@ -1848,6 +1796,33 @@ generic_file_direct_write(struct kiocb *
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
+/*
+ * Find or create a page at the given pagecache position. Return the locked
+ * page. This function is specifically for buffered writes.
+ */
+static struct page *__grab_cache_page(struct address_space *mapping,
+							pgoff_t index)
+{
+	int status;
+	struct page *page;
+repeat:
+	page = find_lock_page(mapping, index);
+	if (likely(page))
+		return page;
+
+	page = page_cache_alloc(mapping);
+	if (!page)
+		return NULL;
+	status = add_to_page_cache_lru(page, mapping, index, GFP_KERNEL);
+	if (unlikely(status)) {
+		page_cache_release(page);
+		if (status == -EEXIST)
+			goto repeat;
+		return NULL;
+	}
+	return page;
+}
+
 ssize_t
 generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
 		unsigned long nr_segs, loff_t pos, loff_t *ppos,
@@ -1858,15 +1833,10 @@ generic_file_buffered_write(struct kiocb
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	struct inode 	*inode = mapping->host;
 	long		status = 0;
-	struct page	*page;
-	struct page	*cached_page = NULL;
-	struct pagevec	lru_pvec;
 	const struct iovec *cur_iov = iov; /* current iovec */
 	size_t		iov_offset = 0;	   /* offset in the current iovec */
 	char __user	*buf;
 
-	pagevec_init(&lru_pvec, 0);
-
 	/*
 	 * handle partial DIO write.  Adjust cur_iov if needed.
 	 */
@@ -1878,6 +1848,7 @@ generic_file_buffered_write(struct kiocb
 	}
 
 	do {
+		struct page *page;
 		pgoff_t index;		/* Pagecache index for current page */
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long maxlen;	/* Bytes remaining in current iovec */
@@ -1904,7 +1875,8 @@ generic_file_buffered_write(struct kiocb
 		fault_in_pages_readable(buf, maxlen);
 #endif
 
-		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
+
+		page = __grab_cache_page(mapping, index);
 		if (!page) {
 			status = -ENOMEM;
 			break;
@@ -1977,9 +1949,6 @@ fs_write_aop_error:
 	} while (count);
 	*ppos = pos;
 
-	if (cached_page)
-		page_cache_release(cached_page);
-
 	/*
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
 	 */
@@ -1999,7 +1968,6 @@ fs_write_aop_error:
 	if (unlikely(file->f_flags & O_DIRECT) && written)
 		status = filemap_write_and_wait(mapping);
 
-	pagevec_lru_add(&lru_pvec);
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
Index: linux-2.6/fs/mpage.c
===================================================================
--- linux-2.6.orig/fs/mpage.c
+++ linux-2.6/fs/mpage.c
@@ -389,31 +389,25 @@ mpage_readpages(struct address_space *ma
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
-			if (!pagevec_add(&lru_pvec, page))
-				__pagevec_lru_add(&lru_pvec);
-		} else {
-			page_cache_release(page);
 		}
+		page_cache_release(page);
 	}
-	pagevec_lru_add(&lru_pvec);
 	BUG_ON(!list_empty(pages));
 	if (bio)
 		mpage_bio_submit(READ, bio);
Index: linux-2.6/mm/readahead.c
===================================================================
--- linux-2.6.orig/mm/readahead.c
+++ linux-2.6/mm/readahead.c
@@ -133,28 +133,25 @@ int read_cache_pages(struct address_spac
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
+		page_cache_release(page);
+
 		ret = filler(data, page);
-		if (!pagevec_add(&lru_pvec, page))
-			__pagevec_lru_add(&lru_pvec);
-		if (ret) {
+		if (unlikely(ret)) {
 			put_pages_list(pages);
 			break;
 		}
 		task_io_account_read(PAGE_CACHE_SIZE);
 	}
-	pagevec_lru_add(&lru_pvec);
 	return ret;
 }
 
@@ -164,7 +161,6 @@ static int read_pages(struct address_spa
 		struct list_head *pages, unsigned nr_pages)
 {
 	unsigned page_idx;
-	struct pagevec lru_pvec;
 	int ret;
 
 	if (mapping->a_ops->readpages) {
@@ -174,19 +170,15 @@ static int read_pages(struct address_spa
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
-			if (!pagevec_add(&lru_pvec, page))
-				__pagevec_lru_add(&lru_pvec);
-		} else
-			page_cache_release(page);
+		}
+		page_cache_release(page);
 	}
-	pagevec_lru_add(&lru_pvec);
 	ret = 0;
 out:
 	return ret;
