Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbRG3Tjo>; Mon, 30 Jul 2001 15:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbRG3Tjf>; Mon, 30 Jul 2001 15:39:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61198 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267632AbRG3TjU>; Mon, 30 Jul 2001 15:39:20 -0400
Date: Mon, 30 Jul 2001 15:09:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <3B5E554E.86FDA41F@zip.com.au>
Message-ID: <Pine.LNX.4.21.0107301501510.7432-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Wed, 25 Jul 2001, Andrew Morton wrote:

> Marcelo Tosatti wrote:
> > 
> > Daniel's patch adds "drop behind" (that is, adding swapcache
> > pages to the inactive dirty) behaviour to swapcache pages.
> 
> In some *brief* testing here, it appears that the use-once changes
> make an improvement for light-medium workloads.  With swap-intensive
> workloads, the (possibly accidental) changes to swapcache aging
> in fact improve things a lot, and use-once makes things a little worse.
> 
> This is a modified Galbraith test: 64 megs of RAM, `make -j12
> bzImage', dual CPU:
> 
> 2.4.7:			6:54
> 2.4.7+Daniel's patch	6:06
> 2.4.7+the below patch	5:56
> 
> --- mm/swap.c	2001/01/23 08:37:48	1.3
> +++ mm/swap.c	2001/07/25 04:08:59
> @@ -234,8 +234,8 @@
>  	DEBUG_ADD_PAGE
>  	add_page_to_active_list(page);
>  	/* This should be relatively rare */
> -	if (!page->age)
> -		deactivate_page_nolock(page);
> +	deactivate_page_nolock(page);
> +	page->age = 0;
>  	spin_unlock(&pagemap_lru_lock);
>  }
> 
> This change to lru_cache_add() is the only change made to 2.4.7,
> and it provides the 17% speedup for this swap-intensive load.

After some thoughs I think this is due to swapin readahead.

We add "drop behind" behaviour to swap readahead, so we have less impact
on the system due to swap readahead "misses". 

That is nice but dangerous under swap IO intensive loads: 

We start swapin readahead, bring the first page of the "cluster" in
memory, block on the next swap page's IO (the one's we are doing
readahead) and in the meantime the first page we read is reclaimed by
someone else.

Then we'll have to reread the first page at at the direct
read_swap_cache_async() called by do_swap_page().

I really want to confirm if this is happening right now. Hope to do it
soon.

