Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRGYECH>; Wed, 25 Jul 2001 00:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbRGYEB6>; Wed, 25 Jul 2001 00:01:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58123 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266158AbRGYEBs>; Wed, 25 Jul 2001 00:01:48 -0400
Date: Tue, 24 Jul 2001 23:31:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <01072405473005.00301@starship>
Message-ID: <Pine.LNX.4.21.0107242320110.2515-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 24 Jul 2001, Daniel Phillips wrote:

> --- ../2.4.5.clean/mm/vmscan.c	Sat May 26 02:00:18 2001
> +++ ./mm/vmscan.c	Mon Jul 23 17:25:27 2001
> @@ -359,10 +359,10 @@
>  		}
>  
>  		/* Page is or was in use?  Move it to the active list. */
> -		if (PageReferenced(page) || page->age > 0 ||
> -				(!page->buffers && page_count(page) > 1)) {
> +		if (PageReferenced(page) || (!page->buffers && page_count(page) > 1)) {
>  			del_page_from_inactive_clean_list(page);
>  			add_page_to_active_list(page);
> +			page->age = PAGE_AGE_START;
>  			continue;
>  		}
>  
> @@ -462,11 +462,11 @@
>  		}
>  
>  		/* Page is or was in use?  Move it to the active list. */
> -		if (PageReferenced(page) || page->age > 0 ||
> -				(!page->buffers && page_count(page) > 1) ||
> +		if (PageReferenced(page) || (!page->buffers && page_count(page) > 1) ||
>  				page_ramdisk(page)) {
>  			del_page_from_inactive_dirty_list(page);
>  			add_page_to_active_list(page);
> +			page->age = PAGE_AGE_START;
>  			continue;
>  		}

That change will cause problems: we indicate that a page is young due to a
young mapped pte by increasing its age (at swap_out()).

With the current way of doing things, if you don't move higher aged pages
from the inactive lists to the active list you'll have severe problems
because of that (inactive list full of unfreeable pages due to mapped
pte's).

I suggest you to change

	if (!page->buffers && page_count(page) > 1) 
to 
	if ((page_count(page) - !!page->buffers) > 1)

at page_launder/reclaim_page to fix that problem. 

This way we end up moving all pages with additional references ignoring
the buffers to the active list. 

We have to unmap all references to a page before being able to make it
reclaimable clean cache anyway, so there is no real point keeping those
pages at the inactive list.

