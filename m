Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136182AbRD0TRt>; Fri, 27 Apr 2001 15:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136178AbRD0TRj>; Fri, 27 Apr 2001 15:17:39 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:15001 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S136176AbRD0TR0>; Fri, 27 Apr 2001 15:17:26 -0400
Date: Fri, 27 Apr 2001 19:28:20 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] allow PF_MEMALLOC tasks to directly reclaim pages 
In-Reply-To: <Pine.LNX.4.21.0104270511160.2756-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104271919180.703-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

  Infact, the test can be made even weaker than that.

  We only what to avoid the inactive-clean list when allocating from
within an interrupt (or from a bottom-half handler) to avoid 
deadlock on taking the pagecache_lock and pagemap_lru_lock.
  Note: no allocations are done while holding either of these locks.

  Even GFP_ATOMIC doesn't matter; that simply says if we should block or
not (could be an allocation while holding a spinlock, but not inside an
interrupt).

  I've been doing v heavy load on a 4-way server with;

	if (order == 0 && !in_interrupt())
		direct_reclaim = 1;

without any problems.

  Of course, the in_interrupt() is heavier than (gfp_mask & __GFP_WAIT),
but the benefits outweight the slight fattening.

Mark



On Fri, 27 Apr 2001, Marcelo Tosatti wrote:

> 
> Linus,
> 
> Currently __alloc_pages() does not allow PF_MEMALLOC tasks to free clean
> inactive pages.
> 
> This is senseless --- if the allocation has __GFP_WAIT set, its ok to grab
> the pagemap_lru_lock/pagecache_lock/etc.
> 
> I checked all possible codepaths after reclaim_page() and they are ok.
> 
> The following patch fixes that.
> 
> 
> --- linux/mm/page_alloc.c.orig	Fri Apr 27 05:59:35 2001
> +++ linux/mm/page_alloc.c	Fri Apr 27 05:59:48 2001
> @@ -295,8 +295,7 @@
>  	 * Can we take pages directly from the inactive_clean
>  	 * list?
>  	 */
> -	if (order == 0 && (gfp_mask & __GFP_WAIT) &&
> -			!(current->flags & PF_MEMALLOC))
> +	if (order == 0 && (gfp_mask & __GFP_WAIT))
>  		direct_reclaim = 1;
>  
>  	/*
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

