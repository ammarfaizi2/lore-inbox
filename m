Return-Path: <linux-kernel-owner+w=401wt.eu-S932527AbWLMRkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWLMRkQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWLMRkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:40:16 -0500
Received: from pat.uio.no ([129.240.10.15]:47223 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932527AbWLMRkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:40:14 -0500
Subject: Re: [PATCH] nfs: fix NR_FILE_DIRTY underflow
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <1166022082.32332.126.camel@twins>
References: <1166011958.32332.97.camel@twins>
	 <1166012781.5695.18.camel@lade.trondhjem.org>
	 <1166022082.32332.126.camel@twins>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 12:40:01 -0500
Message-Id: <1166031601.9127.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.637, required 12,
	autolearn=disabled, AWL 1.36, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 16:01 +0100, Peter Zijlstra wrote:
> On Wed, 2006-12-13 at 07:26 -0500, Trond Myklebust wrote:
> > On Wed, 2006-12-13 at 13:12 +0100, Peter Zijlstra wrote:
> > > Still testing this patch, but it looks good so far.
> > > 
> > > ---
> > > Just setting PG_dirty can cause NR_FILE_DIRTY to underflow
> > > which is bad (TM).
> > > 
> > > Use set_page_dirty() which will do the right thing.
> > 
> > Actually, I'd prefer to have it do the right thing by getting rid of
> > that call to test_clear_page_dirty() inside
> > invalidate_inode_pages2_range(). That is causing loss of data integrity,
> > and is what is causing us to have to hack NFS in the first place.
> 
> Ah, I think I see what your problem is there.
> How about this totally untested patch:
> 
> ---
> Delay clearing the dirty page state till after removing it from the
> mapping in invalidate_inode_pages2_range(). This will give
> try_to_release_pages() a shot to flush dirty data.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  fs/nfs/file.c              |    2 --
>  include/linux/page-flags.h |    2 ++
>  mm/page-writeback.c        |   17 +++++++++++------
>  mm/truncate.c              |   11 +++--------
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> Index: linux-2.6-git/fs/nfs/file.c
> ===================================================================
> --- linux-2.6-git.orig/fs/nfs/file.c	2006-12-13 15:31:26.000000000 +0100
> +++ linux-2.6-git/fs/nfs/file.c	2006-12-13 15:39:33.000000000 +0100
> @@ -320,8 +320,6 @@ static int nfs_release_page(struct page 
>  	 */
>  	if (!(gfp & __GFP_FS))
>  		return 0;
> -	/* Hack... Force nfs_wb_page() to write out the page */
> -	SetPageDirty(page);
>  	return !nfs_wb_page(page_file_mapping(page)->host, page);
>  }
>  
> Index: linux-2.6-git/include/linux/page-flags.h
> ===================================================================
> --- linux-2.6-git.orig/include/linux/page-flags.h	2006-12-13 15:35:50.000000000 +0100
> +++ linux-2.6-git/include/linux/page-flags.h	2006-12-13 15:36:14.000000000 +0100
> @@ -252,7 +252,9 @@ static inline void SetPageUptodate(struc
>  #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
>  
>  struct page;	/* forward declaration */
> +struct address_space;
>  
> +int __test_clear_page_dirty(struct address_space *mapping, struct page *page);
>  int test_clear_page_dirty(struct page *page);
>  int test_clear_page_writeback(struct page *page);
>  int test_set_page_writeback(struct page *page);
> Index: linux-2.6-git/mm/page-writeback.c
> ===================================================================
> --- linux-2.6-git.orig/mm/page-writeback.c	2006-12-13 15:34:15.000000000 +0100
> +++ linux-2.6-git/mm/page-writeback.c	2006-12-13 15:39:41.000000000 +0100
> @@ -850,13 +850,8 @@ int set_page_dirty_lock(struct page *pag
>  }
>  EXPORT_SYMBOL(set_page_dirty_lock);
>  
> -/*
> - * Clear a page's dirty flag, while caring for dirty memory accounting. 
> - * Returns true if the page was previously dirty.
> - */
> -int test_clear_page_dirty(struct page *page)
> +int __test_clear_page_dirty(struct address_space *mapping, struct page *page)
>  {
> -	struct address_space *mapping = page_mapping(page);
>  	unsigned long flags;
>  
>  	if (!mapping)
> @@ -880,6 +875,16 @@ int test_clear_page_dirty(struct page *p
>  	write_unlock_irqrestore(&mapping->tree_lock, flags);
>  	return 0;
>  }
> +
> +/*
> + * Clear a page's dirty flag, while caring for dirty memory accounting.
> + * Returns true if the page was previously dirty.
> + */
> +int test_clear_page_dirty(struct page *page)
> +{
> +	struct address_space *mapping = page_mapping(page);
> +	return __test_clear_page_dirty(mapping, page);
> +}
>  EXPORT_SYMBOL(test_clear_page_dirty);
>  
>  /*
> Index: linux-2.6-git/mm/truncate.c
> ===================================================================
> --- linux-2.6-git.orig/mm/truncate.c	2006-12-13 15:36:38.000000000 +0100
> +++ linux-2.6-git/mm/truncate.c	2006-12-13 15:44:01.000000000 +0100
> @@ -307,18 +307,12 @@ invalidate_complete_page2(struct address
>  		return 0;
>  
>  	write_lock_irq(&mapping->tree_lock);
> -	if (PageDirty(page))
> -		goto failed;
> -
>  	BUG_ON(PagePrivate(page));
>  	__remove_from_page_cache(page);
>  	write_unlock_irq(&mapping->tree_lock);
>  	ClearPageUptodate(page);
>  	page_cache_release(page);	/* pagecache ref */
>  	return 1;
> -failed:
> -	write_unlock_irq(&mapping->tree_lock);
> -	return 0;
>  }
>  
>  /**
> @@ -386,12 +380,13 @@ int invalidate_inode_pages2_range(struct
>  					  PAGE_CACHE_SIZE, 0);
>  				}
>  			}
> -			was_dirty = test_clear_page_dirty(page);
> +			was_dirty = PageDirty(page);
>  			if (!invalidate_complete_page2(mapping, page)) {
>  				if (was_dirty)
>  					set_page_dirty(page);
                                          ^^^^^^^^^^^^^^^^^^^^^

Why would you still need this?

>  				ret = -EIO;
> -			}
> +			} else
> +				__test_clear_page_dirty(mapping, page);
>  			unlock_page(page);
>  		}
>  		pagevec_release(&pvec);
> 

Cheers
  Trond

