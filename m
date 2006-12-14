Return-Path: <linux-kernel-owner+w=401wt.eu-S1751928AbWLNB3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWLNB3a (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWLNB3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:29:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37506 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbWLNB33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:29:29 -0500
Date: Wed, 13 Dec 2006 17:29:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] nfs: fix NR_FILE_DIRTY underflow
Message-Id: <20061213172921.0c4a2809.akpm@osdl.org>
In-Reply-To: <1166035714.32332.159.camel@twins>
References: <1166011958.32332.97.camel@twins>
	<1166012781.5695.18.camel@lade.trondhjem.org>
	<1166022082.32332.126.camel@twins>
	<1166031601.9127.1.camel@lade.trondhjem.org>
	<1166035714.32332.159.camel@twins>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 19:48:34 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> --- linux-2.6-git.orig/mm/truncate.c	2006-12-13 19:41:09.000000000 +0100
> +++ linux-2.6-git/mm/truncate.c	2006-12-13 19:42:56.000000000 +0100
> @@ -306,19 +306,14 @@ invalidate_complete_page2(struct address
>  	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
>  		return 0;
>  
> +	test_clear_page_dirty(page);
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
> @@ -350,7 +345,6 @@ int invalidate_inode_pages2_range(struct
>  		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  			pgoff_t page_index;
> -			int was_dirty;
>  
>  			lock_page(page);
>  			if (page->mapping != mapping) {
> @@ -386,12 +380,8 @@ int invalidate_inode_pages2_range(struct
>  					  PAGE_CACHE_SIZE, 0);
>  				}
>  			}
> -			was_dirty = test_clear_page_dirty(page);
> -			if (!invalidate_complete_page2(mapping, page)) {
> -				if (was_dirty)
> -					set_page_dirty(page);
> +			if (!invalidate_complete_page2(mapping, page))
>  				ret = -EIO;
> -			}
>  			unlock_page(page);
>  		}
>  		pagevec_release(&pvec);

a) we're now calling try_to_release_page() with a potentially-dirty
   page, whereas it was previously clean.

   I wouldn't expect ->releasepage() implementations to go looking at
   PG_Dirty, because that's not what they're suppoed to be interested in. 
   But they might do, dunno.

b) If invalidate_complete_page2() failed due to, say, dirty buffer_heads
   then we now have a clean page with dirty buffers.  That is an illegal
   state and the page will leak permanently.

   I _think_ that's what the was_dirty logic is in there for: to
   preserve the correct page-vs-buffers dirtiness coherency.  But I'd need
   to do some 2.5.x changelog-dumpster-diving to be sure.

Sigh.  I don't know what invalidate_inode_pages2() is *supposed to do*. 

What are its semantics wrt unfreeable page metadata?  Against page
dirtiness?

It was written for direct-io and had one set of semantics for that, then
NFS came along and seemed to require a slightly different set of semantics,
even though the earlier semantics weren't really defined, leading to a
belief that the present semantics are "wrong", without a definition of what
semantics NFS actually desires.


So let's start again.

Trond, please define precisely and completely and without reference to
the existing implementation: what behaviour does NFS want?

