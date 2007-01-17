Return-Path: <linux-kernel-owner+w=401wt.eu-S1751029AbXAQDoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXAQDoX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 22:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbXAQDoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 22:44:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59080 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750698AbXAQDoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 22:44:22 -0500
Date: Wed, 17 Jan 2007 14:43:29 +1100
From: David Chinner <dgc@sgi.com>
To: David Chinner <dgc@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sami Farin <7atbggg02@sneakemail.com>, xfs-masters@oss.sgi.com
Subject: Re: 2.6.20-rc5: known unfixed regressions
Message-ID: <20070117034329.GW44411608@melbourne.sgi.com>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org> <20070113071125.GG7469@stusta.de> <20070116061502.GP44411608@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116061502.GP44411608@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 05:15:02PM +1100, David Chinner wrote:
> On Sat, Jan 13, 2007 at 08:11:25AM +0100, Adrian Bunk wrote:
> > On Fri, Jan 12, 2007 at 02:27:48PM -0500, Linus Torvalds wrote:
> > >...
> > > A lot of developers (including me) will be gone next week for 
> > > Linux.Conf.Au, so you have a week of rest and quiet to test this, and 
> > > report any problems. 
> > > 
> > > Not that there will be any, right? You all behave now!
> > >...
> > 
> > This still leaves the old regressions we have not yet fixed...
> > 
> > 
> > This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19.
> > 
> > 
> > Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
> > References : http://lkml.org/lkml/2007/1/5/308
> > Submitter  : Sami Farin <7atbggg02@sneakemail.com>
> > Handled-By : David Chinner <dgc@sgi.com>
> > Status     : problem is being discussed
> 
> I'm at LCA and been having laptop dramas so the fix is being held up at this
> point. I and trying to test a change right now that adds an optional unmap
> to truncate_inode_pages_range as XFS needs, in some circumstances, to toss
> out dirty pages (with dirty bufferheads) and hence requires truncate semantics
> that are currently missing unmap calls.
> 
> Semi-untested patch attached below.

The patch has run XFSQA for about 24 hours now on my test rig without
triggering any problems.

Cheers,

Dave.

>  fs/xfs/linux-2.6/xfs_fs_subr.c |    6 ++--
>  include/linux/mm.h             |    2 +
>  mm/truncate.c                  |   60 ++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 60 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.19/fs/xfs/linux-2.6/xfs_fs_subr.c
> ===================================================================
> --- linux-2.6.19.orig/fs/xfs/linux-2.6/xfs_fs_subr.c	2006-10-03 23:22:36.000000000 +1000
> +++ linux-2.6.19/fs/xfs/linux-2.6/xfs_fs_subr.c	2007-01-17 01:24:51.771273750 +1100
> @@ -32,7 +32,8 @@ fs_tosspages(
>  	struct inode	*ip = vn_to_inode(vp);
>  
>  	if (VN_CACHED(vp))
> -		truncate_inode_pages(ip->i_mapping, first);
> +		truncate_unmap_inode_pages_range(ip->i_mapping,
> +					     first, last, 1);
>  }
>  
>  void
> @@ -49,7 +50,8 @@ fs_flushinval_pages(
>  		if (VN_TRUNC(vp))
>  			VUNTRUNCATE(vp);
>  		filemap_write_and_wait(ip->i_mapping);
> -		truncate_inode_pages(ip->i_mapping, first);
> +		truncate_unmap_inode_pages_range(ip->i_mapping,
> +					     first, last, 1);
>  	}
>  }
>  
> Index: linux-2.6.19/include/linux/mm.h
> ===================================================================
> --- linux-2.6.19.orig/include/linux/mm.h	2007-01-17 01:21:16.017790000 +1100
> +++ linux-2.6.19/include/linux/mm.h	2007-01-17 01:24:51.775274000 +1100
> @@ -1058,6 +1058,8 @@ extern unsigned long page_unuse(struct p
>  extern void truncate_inode_pages(struct address_space *, loff_t);
>  extern void truncate_inode_pages_range(struct address_space *,
>  				       loff_t lstart, loff_t lend);
> +extern void truncate_unmap_inode_pages_range(struct address_space *,
> +				       loff_t lstart, loff_t lend, int unmap);
>  
>  /* generic vm_area_ops exported for stackable file systems */
>  extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int *);
> Index: linux-2.6.19/mm/truncate.c
> ===================================================================
> --- linux-2.6.19.orig/mm/truncate.c	2007-01-17 01:21:23.074231000 +1100
> +++ linux-2.6.19/mm/truncate.c	2007-01-17 01:24:51.779274250 +1100
> @@ -59,7 +59,7 @@ void cancel_dirty_page(struct page *page
>  
>  		WARN_ON(++warncount < 5);
>  	}
> -		
> +
>  	if (TestClearPageDirty(page)) {
>  		struct address_space *mapping = page->mapping;
>  		if (mapping && mapping_cap_account_dirty(mapping)) {
> @@ -122,16 +122,34 @@ invalidate_complete_page(struct address_
>  	return ret;
>  }
>  
> +/*
> + * This is a helper for truncate_unmap_inode_page. Unmap the page we
> + * are passed. Page must be locked by the caller.
> + */
> +static void
> +unmap_single_page(struct address_space *mapping, struct page *page)
> +{
> +	BUG_ON(!PageLocked(page));
> +	while (page_mapped(page)) {
> +		unmap_mapping_range(mapping,
> +			(loff_t)page->index << PAGE_CACHE_SHIFT,
> +			PAGE_CACHE_SIZE, 0);
> +	}
> +}
> +
>  /**
> - * truncate_inode_pages - truncate range of pages specified by start and
> + * truncate_unmap_inode_pages_range - truncate range of pages specified by
> + * start and end byte offsets and optionally unmap them first.
>   * end byte offsets
>   * @mapping: mapping to truncate
>   * @lstart: offset from which to truncate
>   * @lend: offset to which to truncate
> + * @unmap: unmap whole truncated pages if non-zero
>   *
>   * Truncate the page cache, removing the pages that are between
>   * specified offsets (and zeroing out partial page
> - * (if lstart is not page aligned)).
> + * (if lstart is not page aligned)). If specified, unmap the pages
> + * before they are removed.
>   *
>   * Truncate takes two passes - the first pass is nonblocking.  It will not
>   * block on page locks and it will not block on writeback.  The second pass
> @@ -146,8 +164,8 @@ invalidate_complete_page(struct address_
>   * mapping is large, it is probably the case that the final pages are the most
>   * recently touched, and freeing happens in ascending file offset order.
>   */
> -void truncate_inode_pages_range(struct address_space *mapping,
> -				loff_t lstart, loff_t lend)
> +void truncate_unmap_inode_pages_range(struct address_space *mapping,
> +				loff_t lstart, loff_t lend, int unmap)
>  {
>  	const pgoff_t start = (lstart + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
>  	pgoff_t end;
> @@ -162,6 +180,14 @@ void truncate_inode_pages_range(struct a
>  	BUG_ON((lend & (PAGE_CACHE_SIZE - 1)) != (PAGE_CACHE_SIZE - 1));
>  	end = (lend >> PAGE_CACHE_SHIFT);
>  
> +	/*
> +	 * if unmapping, do a range unmap up front to minimise the
> +	 * overhead of unmapping the pages
> +	 */
> +	if (unmap) {
> +		unmap_mapping_range(mapping, (loff_t)start << PAGE_CACHE_SHIFT,
> +					   (loff_t)end << PAGE_CACHE_SHIFT, 0);
> +	}
>  	pagevec_init(&pvec, 0);
>  	next = start;
>  	while (next <= end &&
> @@ -184,6 +210,8 @@ void truncate_inode_pages_range(struct a
>  				unlock_page(page);
>  				continue;
>  			}
> +			if (unmap)
> +				unmap_single_page(mapping, page);
>  			truncate_complete_page(mapping, page);
>  			unlock_page(page);
>  		}
> @@ -195,6 +223,8 @@ void truncate_inode_pages_range(struct a
>  		struct page *page = find_lock_page(mapping, start - 1);
>  		if (page) {
>  			wait_on_page_writeback(page);
> +			if (unmap)
> +				unmap_single_page(mapping, page);
>  			truncate_partial_page(page, partial);
>  			unlock_page(page);
>  			page_cache_release(page);
> @@ -224,12 +254,30 @@ void truncate_inode_pages_range(struct a
>  			if (page->index > next)
>  				next = page->index;
>  			next++;
> +			if (unmap)
> +				unmap_single_page(mapping, page);
>  			truncate_complete_page(mapping, page);
>  			unlock_page(page);
>  		}
>  		pagevec_release(&pvec);
>  	}
>  }
> +EXPORT_SYMBOL(truncate_unmap_inode_pages_range);
> +
> +/**
> + * truncate_inode_pages_range - truncate range of pages specified by start and
> + * end byte offsets
> + * @mapping: mapping to truncate
> + * @lstart: offset from which to truncate
> + * @lend: offset to which to truncate
> + *
> + * Called under (and serialised by) inode->i_mutex.
> + */
> +void truncate_inode_pages_range(struct address_space *mapping,
> +				loff_t lstart, loff_t lend)
> +{
> +	truncate_unmap_inode_pages_range(mapping, lstart, lend, 0);
> +}
>  EXPORT_SYMBOL(truncate_inode_pages_range);
>  
>  /**
> @@ -241,7 +289,7 @@ EXPORT_SYMBOL(truncate_inode_pages_range
>   */
>  void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
>  {
> -	truncate_inode_pages_range(mapping, lstart, (loff_t)-1);
> +	truncate_unmap_inode_pages_range(mapping, lstart, (loff_t)-1, 0);
>  }
>  EXPORT_SYMBOL(truncate_inode_pages);
>  

-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
