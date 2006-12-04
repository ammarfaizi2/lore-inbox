Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936903AbWLDOkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936903AbWLDOkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936914AbWLDOkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:40:11 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:62675 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S936903AbWLDOkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:40:08 -0500
Date: Mon, 4 Dec 2006 14:40:05 +0000
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [rfc] possible page manipulation simplifications?
Message-ID: <20061204144005.GA22233@skynet.ie>
References: <20061202121519.GA20670@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061202121519.GA20670@wotan.suse.de>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/06 13:15), Nick Piggin didst pronounce:
> Hi,
> 
> While working in this area, I noticed a few things we do that may not
> have a positive payoff under the most common conditions. Untested yet,
> and probably needs a bit of instrumentation, but it saves about half a
> K of code, lots of branches, and makes things look nicer. Any thoughts?
> 
> Quite a bit of code is used in maintaining these "cached pages" that are
> probably pretty unlikely to get used.
> 

I think you might be leaking now though. More comments below.

> Also, buffered write path (and others) uses its own LRU pagevec when we should
> be just using the per-CPU LRU pagevec (which will cut down on both data and
> code size cacheline footprint).
> 

Splitting the patch into two could be nice but it's grand for the
moment.

> Index: linux-2.6/mm/filemap.c
> ===================================================================
> --- linux-2.6.orig/mm/filemap.c
> +++ linux-2.6/mm/filemap.c
> @@ -686,26 +686,18 @@ EXPORT_SYMBOL(find_lock_page);
>  struct page *find_or_create_page(struct address_space *mapping,
>  		unsigned long index, gfp_t gfp_mask)
>  {
> -	struct page *page, *cached_page = NULL;
> +	struct page *page;
>  	int err;
>  repeat:
>  	page = find_lock_page(mapping, index);
>  	if (!page) {
> -		if (!cached_page) {
> -			cached_page = alloc_page(gfp_mask);
> -			if (!cached_page)
> -				return NULL;
> -		}
> -		err = add_to_page_cache_lru(cached_page, mapping,
> -					index, gfp_mask);
> -		if (!err) {
> -			page = cached_page;
> -			cached_page = NULL;
> -		} else if (err == -EEXIST)
> +		page = alloc_page(gfp_mask);
> +		if (!page)
> +			return NULL;
> +		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
> +		if (err == -EEXIST)
>  			goto repeat;

Lets say the alloc_page() succeeds, but add_to_page_cache_lru() returns
-EEXIST, we'll jump back to the repeat label which calls page =
find_lock_page(). We've lost the page at that point, right? If
add_to_page_cache_lru() returns any error in fact, the page leaks.

You appear to do the right thing later when you call
page_cache_release() on error adding to the page cache. This is probably
safe to do here. Sure, for non-EEXIST errors, you'll allocate the page
twice but you probably don't care if this path is very rarely executed.

>  	}
> -	if (cached_page)
> -		page_cache_release(cached_page);
>  	return page;
>  }
>  EXPORT_SYMBOL(find_or_create_page);
> @@ -891,11 +883,9 @@ void do_generic_mapping_read(struct addr
>  	unsigned long next_index;
>  	unsigned long prev_index;
>  	loff_t isize;
> -	struct page *cached_page;
>  	int error;
>  	struct file_ra_state ra = *_ra;
>  
> -	cached_page = NULL;
>  	index = *ppos >> PAGE_CACHE_SHIFT;
>  	next_index = index;
>  	prev_index = ra.prev_page;
> @@ -1059,14 +1049,12 @@ no_cached_page:
>  		 * Ok, it wasn't cached, so we need to create a new
>  		 * page..
>  		 */
> -		if (!cached_page) {
> -			cached_page = page_cache_alloc_cold(mapping);
> -			if (!cached_page) {
> -				desc->error = -ENOMEM;
> -				goto out;
> -			}
> +		page = page_cache_alloc_cold(mapping);
> +		if (!page) {
> +			desc->error = -ENOMEM;
> +			goto out;
>  		}
> -		error = add_to_page_cache_lru(cached_page, mapping,
> +		error = add_to_page_cache_lru(page, mapping,
>  						index, GFP_KERNEL);
>  		if (error) {
>  			if (error == -EEXIST)

I think this might be suffering similar problems with leaking pages.

> @@ -1074,8 +1062,6 @@ no_cached_page:
>  			desc->error = error;
>  			goto out;
>  		}
> -		page = cached_page;
> -		cached_page = NULL;
>  		goto readpage;
>  	}
>  
> @@ -1083,8 +1069,6 @@ out:
>  	*_ra = ra;
>  
>  	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
> -	if (cached_page)
> -		page_cache_release(cached_page);
>  	if (filp)
>  		file_accessed(filp);
>  }
> @@ -1545,35 +1529,28 @@ static inline struct page *__read_cache_
>  				int (*filler)(void *,struct page*),
>  				void *data)
>  {
> -	struct page *page, *cached_page = NULL;
> +	struct page *page;
>  	int err;
>  repeat:
>  	page = find_get_page(mapping, index);
>  	if (!page) {
> -		if (!cached_page) {
> -			cached_page = page_cache_alloc_cold(mapping);
> -			if (!cached_page)
> -				return ERR_PTR(-ENOMEM);
> -		}
> -		err = add_to_page_cache_lru(cached_page, mapping,
> -					index, GFP_KERNEL);
> +		page = page_cache_alloc_cold(mapping);
> +		if (!page)
> +			return ERR_PTR(-ENOMEM);
> +		err = add_to_page_cache_lru(page, mapping, index, GFP_KERNEL);
>  		if (err == -EEXIST)
>  			goto repeat;
>  		if (err < 0) {
>  			/* Presumably ENOMEM for radix tree node */
> -			page_cache_release(cached_page);
> +			page_cache_release(page);
>  			return ERR_PTR(err);
>  		}
> -		page = cached_page;
> -		cached_page = NULL;
>  		err = filler(data, page);
>  		if (err < 0) {
>  			page_cache_release(page);
>  			page = ERR_PTR(err);
>  		}
>  	}
> -	if (cached_page)
> -		page_cache_release(cached_page);

I didn't look carefully here but it looks like more of the same.

>  	return page;
>  }
>  
> @@ -1624,40 +1601,6 @@ retry:
>  EXPORT_SYMBOL(read_cache_page);
>  
>  /*
> - * If the page was newly created, increment its refcount and add it to the
> - * caller's lru-buffering pagevec.  This function is specifically for
> - * generic_file_write().
> - */
> -static inline struct page *
> -__grab_cache_page(struct address_space *mapping, unsigned long index,
> -			struct page **cached_page, struct pagevec *lru_pvec)
> -{
> -	int err;
> -	struct page *page;
> -repeat:
> -	page = find_lock_page(mapping, index);
> -	if (!page) {
> -		if (!*cached_page) {
> -			*cached_page = page_cache_alloc(mapping);
> -			if (!*cached_page)
> -				return NULL;
> -		}
> -		err = add_to_page_cache(*cached_page, mapping,
> -					index, GFP_KERNEL);
> -		if (err == -EEXIST)
> -			goto repeat;
> -		if (err == 0) {
> -			page = *cached_page;
> -			page_cache_get(page);
> -			if (!pagevec_add(lru_pvec, page))
> -				__pagevec_lru_add(lru_pvec);
> -			*cached_page = NULL;
> -		}
> -	}
> -	return page;
> -}
> -
> -/*
>   * The logic we want is
>   *
>   *	if suid or (sgid and xgrp)
> @@ -1862,14 +1805,10 @@ generic_file_buffered_write(struct kiocb
>  	struct inode 	*inode = mapping->host;
>  	long		status = 0;
>  	struct page	*page;
> -	struct page	*cached_page = NULL;
> -	struct pagevec	lru_pvec;
>  	const struct iovec *cur_iov = iov; /* current iovec */
>  	size_t		iov_offset = 0;	   /* offset in the current iovec */
>  	char __user	*buf;
>  
> -	pagevec_init(&lru_pvec, 0);
> -
>  	/*
>  	 * handle partial DIO write.  Adjust cur_iov if needed.
>  	 */
> @@ -1911,10 +1850,23 @@ retry_noprogress:
>  			break;
>  #endif
>  
> -		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
> -		if (!page) {
> -			status = -ENOMEM;
> -			break;
> +
> +repeat:
> +		page = find_lock_page(mapping, index);
> +		if (unlikely(!page)) {
> +			page = page_cache_alloc(mapping);
> +			if (!page) {
> +				status = -ENOMEM;
> +				break;
> +			}
> +			status = add_to_page_cache_lru(page, mapping,
> +						index, GFP_KERNEL);
> +			if (status) {
> +				page_cache_release(page);

We don't leak here but might allocate twice.

> +				if (status == -EEXIST)
> +					goto repeat;
> +				break;
> +			}
>  		}
>  

Otherwise, this seems to be a reasonable cleanup.

>  		status = a_ops->prepare_write(file, page, offset, offset+bytes);
> @@ -2027,9 +1979,6 @@ retry_noprogress:
>  	} while (count);
>  	*ppos = pos;
>  
> -	if (cached_page)
> -		page_cache_release(cached_page);
> -
>  	/*
>  	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
>  	 */
> @@ -2049,7 +1998,6 @@ retry_noprogress:
>  	if (unlikely(file->f_flags & O_DIRECT) && written)
>  		status = filemap_write_and_wait(mapping);
>  
> -	pagevec_lru_add(&lru_pvec);
>  	return written ? written : status;
>  }
>  EXPORT_SYMBOL(generic_file_buffered_write);
> Index: linux-2.6/fs/mpage.c
> ===================================================================
> --- linux-2.6.orig/fs/mpage.c
> +++ linux-2.6/fs/mpage.c
> @@ -389,31 +389,26 @@ mpage_readpages(struct address_space *ma
>  	struct bio *bio = NULL;
>  	unsigned page_idx;
>  	sector_t last_block_in_bio = 0;
> -	struct pagevec lru_pvec;
>  	struct buffer_head map_bh;
>  	unsigned long first_logical_block = 0;
>  
>  	clear_buffer_mapped(&map_bh);
> -	pagevec_init(&lru_pvec, 0);
>  	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
>  		struct page *page = list_entry(pages->prev, struct page, lru);
>  
>  		prefetchw(&page->flags);
>  		list_del(&page->lru);
> -		if (!add_to_page_cache(page, mapping,
> +		if (!add_to_page_cache_lru(page, mapping,
>  					page->index, GFP_KERNEL)) {
>  			bio = do_mpage_readpage(bio, page,
>  					nr_pages - page_idx,
>  					&last_block_in_bio, &map_bh,
>  					&first_logical_block,
>  					get_block);
> -			if (!pagevec_add(&lru_pvec, page))
> -				__pagevec_lru_add(&lru_pvec);
>  		} else {
>  			page_cache_release(page);
>  		}
>  	}
> -	pagevec_lru_add(&lru_pvec);
>  	BUG_ON(!list_empty(pages));
>  	if (bio)
>  		mpage_bio_submit(READ, bio);
> Index: linux-2.6/mm/readahead.c
> ===================================================================
> --- linux-2.6.orig/mm/readahead.c
> +++ linux-2.6/mm/readahead.c
> @@ -132,22 +132,18 @@ int read_cache_pages(struct address_spac
>  			int (*filler)(void *, struct page *), void *data)
>  {
>  	struct page *page;
> -	struct pagevec lru_pvec;
>  	int ret = 0;
>  
> -	pagevec_init(&lru_pvec, 0);
> -
>  	while (!list_empty(pages)) {
>  		page = list_to_page(pages);
>  		list_del(&page->lru);
> -		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
> +		if (add_to_page_cache_lru(page, mapping,
> +						page->index, GFP_KERNEL)) {
>  			page_cache_release(page);
>  			continue;
>  		}
>  		ret = filler(data, page);
> -		if (!pagevec_add(&lru_pvec, page))
> -			__pagevec_lru_add(&lru_pvec);
> -		if (ret) {
> +		if (unlikely(ret)) {
>  			while (!list_empty(pages)) {
>  				struct page *victim;
>  
> @@ -158,7 +154,6 @@ int read_cache_pages(struct address_spac
>  			break;
>  		}
>  	}
> -	pagevec_lru_add(&lru_pvec);
>  	return ret;
>  }
>  
> @@ -168,7 +163,6 @@ static int read_pages(struct address_spa
>  		struct list_head *pages, unsigned nr_pages)
>  {
>  	unsigned page_idx;
> -	struct pagevec lru_pvec;
>  	int ret;
>  
>  	if (mapping->a_ops->readpages) {
> @@ -178,19 +172,15 @@ static int read_pages(struct address_spa
>  		goto out;
>  	}
>  
> -	pagevec_init(&lru_pvec, 0);
>  	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
>  		struct page *page = list_to_page(pages);
>  		list_del(&page->lru);
> -		if (!add_to_page_cache(page, mapping,
> +		if (!add_to_page_cache_lru(page, mapping,
>  					page->index, GFP_KERNEL)) {
>  			mapping->a_ops->readpage(filp, page);
> -			if (!pagevec_add(&lru_pvec, page))
> -				__pagevec_lru_add(&lru_pvec);
>  		} else
>  			page_cache_release(page);
>  	}
> -	pagevec_lru_add(&lru_pvec);
>  	ret = 0;
>  out:
>  	return ret;
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
