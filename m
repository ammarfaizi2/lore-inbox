Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272865AbRISVc4>; Wed, 19 Sep 2001 17:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274197AbRISVcq>; Wed, 19 Sep 2001 17:32:46 -0400
Received: from [195.223.140.107] ([195.223.140.107]:23547 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S272865AbRISVc3>;
	Wed, 19 Sep 2001 17:32:29 -0400
Date: Wed, 19 Sep 2001 23:28:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010919232818.T720@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109191850370.1133-100000@localhost.localdomain> <Pine.LNX.4.21.0109192026280.1502-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109192026280.1502-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Sep 19, 2001 at 08:42:39PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:42:39PM +0100, Hugh Dickins wrote:
> --- 2.4.10-pre12/mm/swap_state.c	Wed Sep 19 14:05:54 2001
> +++ linux/mm/swap_state.c	Mon Sep 17 06:30:26 2001
> @@ -23,6 +23,17 @@
>   */
>  static int swap_writepage(struct page *page)
>  {
> +	/* One for the page cache, one for this user, one for page->buffers */
> +	if (page_count(page) > 2 + !!page->buffers)

this is racy, you have to spin_lock(&pagecache_lock) before you can
expect the page_count() stays constant. then after you checked the page
has count == 1, you must atomically drop it from the pagecache so it's
not visible anymore to the swapin lookups.

Another way to fix the race is to change lookup_swap_cache to do
find_lock_page instead of find_get_page, and then check the page is
still a swapcachepage after you got it locked (that was the old way,
somebody changed it and introduced the race, I like lookup_swap_cache to
use find_get_page so I dropped such check to fix it, it was a minor
optimization but yes probably worthwhile to reintroduce after addressing
this race in one of the two ways described).

It is also buggy, if something it should be "page_count(page) != 1" (not
!= 2).

> +		goto in_use;
> +	if (swap_count(page) > 1)
> +		goto in_use;
> +
> +	delete_from_swap_cache_nolock(page);
> +	UnlockPage(page);
> +	return 0;
> +
> +in_use:
>  	rw_swap_page(WRITE, page);
>  	return 0;
>  }


Andrea
