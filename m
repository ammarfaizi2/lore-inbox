Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbUJYODC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUJYODC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUJYODB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:03:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58514 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261819AbUJYN7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:59:16 -0400
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20041022162433.509341e4.akpm@osdl.org>
References: <1098393346.7157.112.camel@localhost>
	 <20041021144531.22dd0d54.akpm@osdl.org>
	 <20041021223613.GA8756@dualathlon.random>
	 <20041021160233.68a84971.akpm@osdl.org>
	 <20041021232059.GE8756@dualathlon.random>
	 <20041021164245.4abec5d2.akpm@osdl.org>
	 <20041022003004.GA14325@dualathlon.random>
	 <20041022012211.GD14325@dualathlon.random>
	 <20041021190320.02dccda7.akpm@osdl.org>
	 <20041022161744.GF14325@dualathlon.random>
	 <20041022162433.509341e4.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1098712703.7260.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 08:58:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
This patch does fix the oops I was seeing.

Shaggy

On Fri, 2004-10-22 at 18:24, Andrew Morton wrote:
> Something like this...
> 
> 
> 
> 
> - When invalidating pages, take care to shoot down any ptes which map them
>   as well.
> 
>   This ensures that the next mmap access to the page will generate a major
>   fault, so NFS's server-side modifications are picked up.
> 
>   This also allows us to call invalidate_complete_page() on all pages, so
>   filesytems such as ext3 get a chance to invalidate the buffer_heads.
> 
> - Don't mark in-pagetable pages as non-uptodate any more.  That broke a
>   previous guarantee that mapped-into-user-process pages are always uptodate.
> 
> - Check the return value of invalidate_complete_page().  It can fail if
>   someone redirties a page after generic_file_direct_IO() write it back.
> 
> But we still have a problem.  If invalidate_inode_pages2() calls
> unmap_mapping_range(), that can cause zap_pte_range() to dirty the pagecache
> pages.  That will redirty the page's buffers and will cause
> invalidate_complete_page() to fail.
> 
> So, in generic_file_direct_IO() we do a complete pte shootdown on the file
> up-front, prior to writing back dirty pagecache.  This is only done for
> O_DIRECT writes.  It _could_ be done for O_DIRECT reads too, providing full
> mmap-vs-direct-IO coherency for both O_DIRECT reads and O_DIRECT writes, but
> permitting the pte shootdown on O_DIRECT reads trivially allows people to nuke
> other people's mapped pagecache.
> 
> NFS also uses invalidate_inode_pages2() for handling server-side modification
> notifications.  But in the NFS case the clear_page_dirty() in
> invalidate_inode_pages2() is sufficient, because NFS doesn't have to worry
> about the "dirty buffers against a clean page" problem.  (I think)
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  25-akpm/include/linux/fs.h |    2 -
>  25-akpm/mm/filemap.c       |   19 ++++++++++---
>  25-akpm/mm/truncate.c      |   63 +++++++++++++++++++++++++++------------------
>  3 files changed, 55 insertions(+), 29 deletions(-)
> 
> diff -puN mm/truncate.c~invalidate_inode_pages-mmap-coherency-fix mm/truncate.c
> --- 25/mm/truncate.c~invalidate_inode_pages-mmap-coherency-fix	Fri Oct 22 15:40:26 2004
> +++ 25-akpm/mm/truncate.c	Fri Oct 22 16:05:26 2004
> @@ -65,6 +65,8 @@ truncate_complete_page(struct address_sp
>   * be marked dirty at any time too.  So we re-check the dirtiness inside
>   * ->tree_lock.  That provides exclusion against the __set_page_dirty
>   * functions.
> + *
> + * Returns non-zero if the page was successfully invalidated.
>   */
>  static int
>  invalidate_complete_page(struct address_space *mapping, struct page *page)
> @@ -281,50 +283,63 @@ unsigned long invalidate_inode_pages(str
>  EXPORT_SYMBOL(invalidate_inode_pages);
>  
>  /**
> - * invalidate_inode_pages2 - remove all unmapped pages from an address_space
> + * invalidate_inode_pages2 - remove all pages from an address_space
>   * @mapping - the address_space
>   *
> - * invalidate_inode_pages2() is like truncate_inode_pages(), except for the case
> - * where the page is seen to be mapped into process pagetables.  In that case,
> - * the page is marked clean but is left attached to its address_space.
> - *
> - * The page is also marked not uptodate so that a subsequent pagefault will
> - * perform I/O to bringthe page's contents back into sync with its backing
> - * store.
> + * Any pages which are found to be mapped into pagetables are unmapped prior to
> + * invalidation.
>   *
> - * FIXME: invalidate_inode_pages2() is probably trivially livelockable.
> + * Returns -EIO if any pages could not be invalidated.
>   */
> -void invalidate_inode_pages2(struct address_space *mapping)
> +int invalidate_inode_pages2(struct address_space *mapping)
>  {
>  	struct pagevec pvec;
>  	pgoff_t next = 0;
>  	int i;
> +	int ret = 0;
> +	int did_full_unmap = 0;
>  
>  	pagevec_init(&pvec, 0);
> -	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
> -		for (i = 0; i < pagevec_count(&pvec); i++) {
> +	while (!ret && pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
> +		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
>  			lock_page(page);
> -			if (page->mapping == mapping) {	/* truncate race? */
> -				wait_on_page_writeback(page);
> -				next = page->index + 1;
> -				if (page_mapped(page)) {
> -					clear_page_dirty(page);
> -					ClearPageUptodate(page);
> +			if (page->mapping != mapping) {	/* truncate race? */
> +				unlock_page(page);
> +				continue;
> +			}
> +			wait_on_page_writeback(page);
> +			next = page->index + 1;
> +			while (page_mapped(page)) {
> +				if (!did_full_unmap) {
> +					/*
> +					 * Zap the rest of the file in one hit.
> +					 * FIXME: invalidate_inode_pages2()
> +					 * should take start/end offsets.
> +					 */
> +					unmap_mapping_range(mapping,
> +						page->index << PAGE_CACHE_SHIFT,
> +					  	-1, 0);
> +					did_full_unmap = 1;
>  				} else {
> -					if (!invalidate_complete_page(mapping,
> -								      page)) {
> -						clear_page_dirty(page);
> -						ClearPageUptodate(page);
> -					}
> +					/*
> +					 * Just zap this page
> +					 */
> +					unmap_mapping_range(mapping,
> +					  page->index << PAGE_CACHE_SHIFT,
> +					  (page->index << PAGE_CACHE_SHIFT)+1,
> +					  0);
>  				}
>  			}
> +			clear_page_dirty(page);
> +			if (!invalidate_complete_page(mapping, page))
> +				ret = -EIO;
>  			unlock_page(page);
>  		}
>  		pagevec_release(&pvec);
>  		cond_resched();
>  	}
> +	return ret;
>  }
> -
>  EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
> diff -puN include/linux/fs.h~invalidate_inode_pages-mmap-coherency-fix include/linux/fs.h
> --- 25/include/linux/fs.h~invalidate_inode_pages-mmap-coherency-fix	Fri Oct 22 15:54:50 2004
> +++ 25-akpm/include/linux/fs.h	Fri Oct 22 15:54:58 2004
> @@ -1404,7 +1404,7 @@ static inline void invalidate_remote_ino
>  	    S_ISLNK(inode->i_mode))
>  		invalidate_inode_pages(inode->i_mapping);
>  }
> -extern void invalidate_inode_pages2(struct address_space *mapping);
> +extern int invalidate_inode_pages2(struct address_space *mapping);
>  extern void write_inode_now(struct inode *, int);
>  extern int filemap_fdatawrite(struct address_space *);
>  extern int filemap_flush(struct address_space *);
> diff -puN mm/filemap.c~invalidate_inode_pages-mmap-coherency-fix mm/filemap.c
> --- 25/mm/filemap.c~invalidate_inode_pages-mmap-coherency-fix	Fri Oct 22 15:55:06 2004
> +++ 25-akpm/mm/filemap.c	Fri Oct 22 16:17:19 2004
> @@ -2214,7 +2214,8 @@ ssize_t generic_file_writev(struct file 
>  EXPORT_SYMBOL(generic_file_writev);
>  
>  /*
> - * Called under i_sem for writes to S_ISREG files
> + * Called under i_sem for writes to S_ISREG files.   Returns -EIO if something
> + * went wrong during pagecache shootdown.
>   */
>  ssize_t
>  generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
> @@ -2224,14 +2225,24 @@ generic_file_direct_IO(int rw, struct ki
>  	struct address_space *mapping = file->f_mapping;
>  	ssize_t retval;
>  
> +	/*
> +	 * If it's a write, unmap all mmappings of the file up-front.  This
> +	 * will cause any pte dirty bits to be propagated into the pageframes
> +	 * for the subsequent filemap_write_and_wait().
> +	 */
> +	if (rw == WRITE && mapping_mapped(mapping))
> +		unmap_mapping_range(mapping, 0, -1, 0);
> +
>  	retval = filemap_write_and_wait(mapping);
>  	if (retval == 0) {
>  		retval = mapping->a_ops->direct_IO(rw, iocb, iov,
>  						offset, nr_segs);
> -		if (rw == WRITE && mapping->nrpages)
> -			invalidate_inode_pages2(mapping);
> +		if (rw == WRITE && mapping->nrpages) {
> +			int err = invalidate_inode_pages2(mapping);
> +			if (err)
> +				retval = err;
> +		}
>  	}
>  	return retval;
>  }
> -
>  EXPORT_SYMBOL_GPL(generic_file_direct_IO);
> _

