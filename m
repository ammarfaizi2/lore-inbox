Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbREHMef>; Tue, 8 May 2001 08:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbREHMeX>; Tue, 8 May 2001 08:34:23 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:19973 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132392AbREHMeI>; Tue, 8 May 2001 08:34:08 -0400
Date: Tue, 8 May 2001 14:33:45 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <15095.15091.45238.172746@pizda.ninka.net>
Message-ID: <Pine.LNX.3.96.1010508142408.569A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > My point is that its _ok_ for us to check if the page is a dead swap cache
>  > page _without_ the lock since writepage() will recheck again with the page
>  > _locked_. Quoting you two messages back: 
>  > 
>  > "But it is important to re-calculate the deadness after getting the lock.
>  > Before, it was just an informed guess. After the lock, it is knowledge."
>  > 
>  > See ? 
> 
> In fact my patch isn't changing writepage behavior wrt. that page, it
> is changing behavior with respect to laundering policy for that page.
> 
> Here, let's talk code a little bit so there are no misunderstandings,
> I really want to put this to rest:
> 
> +		int dead_swap_page;
> +
>  		page = list_entry(page_lru, struct page, lru);
>  
> +		dead_swap_page =
> +			(PageSwapCache(page) &&
> +			 page_count(page) == (1 + !!page->buffers));
> +
> 
> Calculate dead_swap_page outside of lock.
> 
>  		/* Page is or was in use?  Move it to the active list. */
> -		if (PageTestandClearReferenced(page) || page->age > 0 ||
> -				(!page->buffers && page_count(page) > 1) ||
> -				page_ramdisk(page)) {
			     ^^^^^^^^^^^^^^^^^
> +		if (!dead_swap_page &&
> +		    (PageTestandClearReferenced(page) || page->age > 0 ||
> +		     (!page->buffers && page_count(page) > 1) ||
> +		     page_ramdisk(page))) {
		^^^^^^^^^^^^^^^^^^^^^^
>  			del_page_from_inactive_dirty_list(page);
>  			add_page_to_active_list(page);
>  			continue;

#define page_ramdisk(page) \
        (page->buffers && (MAJOR(page->buffers->b_dev) == RAMDISK_MAJOR))

Are you sure that no one will release buffers under your hands?

Mikulas


