Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265601AbTFNBsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 21:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbTFNBsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 21:48:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29124
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265601AbTFNBsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 21:48:23 -0400
Date: Sat, 14 Jun 2003 04:02:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ross Biro <rossb@google.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.21 released
Message-ID: <20030614020252.GA1571@dualathlon.random>
References: <200306131453.h5DErX47015940@hera.kernel.org> <20030613211405.16faa9f6.us15@os.inf.tu-dresden.de> <3EEA24E0.7030801@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEA24E0.7030801@google.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 12:24:16PM -0700, Ross Biro wrote:
> Here's a minor patch against 2.4.21 that should help reduce out of 
> memory problems on high ram systems with no swap space.  It's only been 
> minimally tested in 2.4.21, but I've been running something similiar on 
> 2.4.18 for a bit now.

this is the wrong approch IMHO, you shouldn't put those into the LRU
list in the first place if there's no swap, that is the totally wasteful
thing in the first place ;)

see my vm_lru_anon scalability patch in my tree, that patch improves
scalability of some workload in a big smp up to hundred percent and it
does exactly that. 

We should join the sysctl check with an && with the swap_avail().
However since I leave it disabled by default, my tree already works
perfectly w/ or w/o swap until you go tweak the sysctl. So I hope
you will tweak it only when there's effectively swap ;).

The real reason I had to make that change is been primarly for
scalability reasons, no way at all we can take a spinlock for every
anonymous page that is allocated (and of course there's no rmap). That
generates an huge amount of cpu wasted in cacheline bouncing in all
common workloads. It gets all the system time in the pagecache_lru_lock
that way.

The patch I'm talking about is this:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/05_vm_22_vm-anon-lru-1

please try it and let me know. feel free to test with an && between the
sysctl and your swap_avail, I would certainly merge that change.



> 
>    Ross
> 
> 

> diff -urbBd linux-2.4.21/include/linux/swap.h linux-2.4.21-1/include/linux/swap.h
> --- linux-2.4.21/include/linux/swap.h	Fri Jun 13 07:51:39 2003
> +++ linux-2.4.21-1/include/linux/swap.h	Fri Jun 13 10:40:24 2003
> @@ -82,6 +82,7 @@
>  
>  /* Swap 50% full? Release swapcache more aggressively.. */
>  #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
> +#define swap_avail() (nr_swap_pages > 0)
>  
>  extern unsigned int nr_free_pages(void);
>  extern unsigned int nr_free_buffer_pages(void);
> diff -urbBd linux-2.4.21/mm/vmscan.c linux-2.4.21-1/mm/vmscan.c
> --- linux-2.4.21/mm/vmscan.c	Thu Nov 28 15:53:15 2002
> +++ linux-2.4.21-1/mm/vmscan.c	Fri Jun 13 11:26:26 2003
> @@ -474,6 +474,18 @@
>  			spin_unlock(&pagecache_lock);
>  			UnlockPage(page);
>  page_mapped:
> +                        /* if we don't have swap, it doesn't
> +                           do much good to swap things out. */
> +			if (!page->mapping && !swap_avail()) {
> +				/* Let's make the page active since we
> +				   cannot swap it out.  It gets it off
> +				   the inactive list. */
> +				spin_unlock(&pagemap_lru_lock);
> +				activate_page(page);
> +				ClearPageReferenced(page);
> +				spin_lock(&pagemap_lru_lock);
> +				continue;
> +			}
>  			if (--max_mapped >= 0)
>  				continue;
>  



Andrea
