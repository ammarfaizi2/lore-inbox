Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274313AbRITFQK>; Thu, 20 Sep 2001 01:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274314AbRITFQA>; Thu, 20 Sep 2001 01:16:00 -0400
Received: from [195.223.140.107] ([195.223.140.107]:12283 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274313AbRITFPr>;
	Thu, 20 Sep 2001 01:15:47 -0400
Date: Thu, 20 Sep 2001 07:12:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920071240.P720@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109191850370.1133-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109191850370.1133-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Sep 19, 2001 at 06:57:20PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 06:57:20PM +0100, Hugh Dickins wrote:
> 3. If exclusive_swap_page, do_swap_page unconditionally makes the pte
>    writable.  I think that's wrong, I think that's the same error Linus
>    corrected in Rik's version there: if it's come in from swap, we know
>    that the page has been dirtied in the past, but that does not imply
>    that writing to it is now permitted.  I think you need something like
> 		if (write_access)
> 			pte = pte_mkwrite(pte);
> 		pte = pte_mkdirty(pte);
> 		delete_from_swap_cache_nolock(page);

when the page is exclusive we definitely can write to it, dropping the
page from the swapcache and lefting the pte wrprotected just asks for a
cow page fault that will simply alloc another page, copy the old one
into the new one and finally free (really free) the old one. so I think
that part is correct.

>    (and please remove that hesitant "#if 1" and "#if 0" from memory.c).

The #if 1 is for the persistence option "the swap waste thing". If you
can afford to waste swap space you can possibly swapout anonymous pages at
no I/Ocost, and also get virtually consecutive addresses more likely to
be physically consecutive on disk too, and I cannot exclude somebody
with very huge swapspace can afford to keep all its anonymous pages in
swapcache as well. This is why I didn't dropped it (yet). But I don't
think it makes an huge difference (the #if is just to make easy to
switch behaviour to give the other one a spin)

> 4. In 2.4.10-pre10, Linus removed the SetPageReferenced(page) from
>    __find_page_nolock, and was adamant on lkml that it's inappropriate
>    at that level.  Later in the day, Linus produced 2.4.10-pre11 from
>    your patches, and that SetPageReferenced(page) reappeared: oversight
>    or intentional?  Linus? more a question for you than Andrea.

Intentional. Really I moved it away even before Linus, I even did a patch
where readahead isn't marked referenced at all with perfect accounting
but from the numbers it seems we don't want to shrink readahead until we
do the cache hit, so I just moved things back waiting for new
experiments on that area :)

> 5. With -pre12 I'm not getting the 0-order allocation failures which
>    interfered with my -pre11 testing, but I did spend a while yesterday
>    looking into that, and the patch I found successful was to move the
>    "int nr_pages = SWAP_CLUSTER_MAX;" in try_to_free_pages from within
>    the loop to the outer level: try_to_free_pages had freed 114 pages
>    of the zone, but never as many as 32 in any one go round the loop.

I see, infact it was originally written that way :). But did you also
checked OOM was still handled gracefully after that?

>    You'll have your own ideas of what's right and wrong here, and I'd

Such change isn't bad, you may want to give it a spin again and check
how oom reacts and how swapout behaviour reacts. I'm not changing
anything in that area at the moment unless(/until? :) somebody complains
about performance.

> --- 2.4.10-pre12/mm/page_alloc.c	Wed Sep 19 14:08:14 2001
> +++ linux/mm/page_alloc.c	Wed Sep 19 16:21:46 2001
> @@ -86,8 +86,7 @@
>  		BUG();
>  	if (PageInactive(page))
>  		BUG();
> -	if (PageDirty(page))
> -		BUG();
> +	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
>  
>  	if (current->flags & PF_FREE_PAGES)
>  		goto local_freelist;
> --- 2.4.10-pre12/mm/swapfile.c	Wed Sep 19 14:08:14 2001
> +++ linux/mm/swapfile.c	Wed Sep 19 16:08:08 2001
> @@ -452,6 +452,7 @@
>  		lock_page(page);
>  		if (PageSwapCache(page))
>  			delete_from_swap_cache_nolock(page);
> +		SetPageDirty(page);
>  		UnlockPage(page);
>  		flush_page_to_ram(page);
>  
> @@ -492,7 +493,6 @@
>  			mmput(start_mm);
>  			start_mm = new_start_mm;
>  		}
> -		ClearPageDirty(page);
>  		page_cache_release(page);

I dislike it but fine with me for now. BTW, I was aware I wasn't really
correct in such change, see the first description of the vm patch:

	I probably have a bug in swapoff but let's ignore it for now, just
	try to run swapoff only before shutting down the machine. The fact
	is that the 2.4 VM is broken freeing physically dirty pages.
	The last owner of the page (usually the VM except in swapoff) has to
	clear the dirty flag before freeing the page, in swapoff it may
	be a little more complicate (we may need to grab the pagecache_lock
	to ensure nobody start using the page while we clear it). And swapoff
	is probably racy anyways as usual (swapoff in 2.2 is racy too).  In
	short I didn't focused on swapoff yet, I just made an hack to make it
	to work while shutting down the machine so far.

:)

Andrea
