Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266674AbRGYIDw>; Wed, 25 Jul 2001 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266673AbRGYIDl>; Wed, 25 Jul 2001 04:03:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16908 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266652AbRGYIDW>; Wed, 25 Jul 2001 04:03:22 -0400
Date: Wed, 25 Jul 2001 03:33:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <3B5E554E.86FDA41F@zip.com.au>
Message-ID: <Pine.LNX.4.21.0107250325120.2515-100000@freak.distro.conectiva>
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
> 
> With the same setup, running a `grep -r /usr/src' in parallel
> with a `make -j3 bzImage', the `make -j3' takes:
> 
> 2.4.7:			5:13
> 2.4.7+Daniel:		5:03
> 2.4.7+the above patch:	5:16
> 
> With the same setup, running a `grep -r /usr/src' in parallel
> with a `make -j1 bzImage', the `make -j1' takes:
> 
> 2.4.7:			9:25
> 2.4.7+Daniel:		8:55
> 2.4.7+the above patch:	9:35

Ok, now we know what improves the swapping performance. 

I wonder _why_ it improves swapping performance.

> So with lighter loads, use-once is starting to provide benefit, and the
> deactivation is too aggressive.
> 
> > This is a _new_ thing, and I would like to know how that is changing the
> > whole VM behaviour..
> 
> Sure.  Daniel's patch radically changes the aging of swapcache
> and other pages, and with some workloads it appears that it is
> this change which brings about the performance increase, rather
> than the intended use-once stuff.
> 
> I suspect the right balance here is to take use-once, but *not*
> take its changes to lru_cache_add().  That's a separate thing. 

Yep. 

I perfectly agree with Daniel's use-once idea for _file cache_ pages. Its
really nice. 

Now I'm not sure why directly adding swapcache pages to the inactive dirty
lits with 0 zero age improves things. 

It _sounds_ like we avoid moving those swapcache pages to the active list,
then later move them to the inactive list and then writing them out.

That can result in less effective writeout clustering (its just a
guess) and also CPU wastage, as Daniel mentioned previously. 

I'll hopefully going to profile his code tomorrow with the VM stats stuff,
if I have time.

> Seems that lru_cache_add() is making decisions at a too-low level, and
> they are sometimes wrong.  The decision as to what age to give the page
> and whether it should be activated needs to be made at a higher level.

Agreed.

