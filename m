Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274323AbRITGLu>; Thu, 20 Sep 2001 02:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274324AbRITGLk>; Thu, 20 Sep 2001 02:11:40 -0400
Received: from [195.223.140.107] ([195.223.140.107]:65533 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274323AbRITGLc>;
	Thu, 20 Sep 2001 02:11:32 -0400
Date: Thu, 20 Sep 2001 08:11:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: 2.4.10pre11 vm rewrite fixes for mainline inclusion and testing
Message-ID: <20010920081151.B719@athlon.random>
In-Reply-To: <20010918224317.E720@athlon.random> <3BA98577.3F0A3D5A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA98577.3F0A3D5A@zip.com.au>; from akpm@zip.com.au on Wed, Sep 19, 2001 at 10:58:15PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 10:58:15PM -0700, Andrew Morton wrote:
> 
> With this patch against -pre12 the BUG()s in shrink_cache()
> go away.
> 
> --- linux-2.4.10-pre12/mm/vmscan.c	Wed Sep 19 20:47:21 2001
> +++ linux-akpm/mm/vmscan.c	Wed Sep 19 22:49:48 2001
> @@ -435,15 +435,20 @@ static int shrink_cache(struct list_head
>  
>  			if (try_to_free_buffers(page, gfp_mask)) {
>  				if (!page->mapping) {
> -					UnlockPage(page);
> -
>  					/*
>  					 * Account we successfully freed a page
>  					 * of buffer cache.
>  					 */
>  					atomic_dec(&buffermem_pages);
>  
> +					/*
> +					 * We must not allow an anon page
> +					 * with no buffers to be visible on
> +					 * the LRU, so we unlock the page after
> +					 * taking the lru lock
> +					 */
>  					spin_lock(&pagemap_lru_lock);
> +					UnlockPage(page);
>  					__lru_cache_del(page);
>  
>  					/* effectively free the page here */

correct, thanks! Please Linus apply.

Andrea
