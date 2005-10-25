Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVJYTkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVJYTkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 15:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVJYTkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 15:40:11 -0400
Received: from hera.kernel.org ([140.211.167.34]:15266 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932325AbVJYTkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 15:40:10 -0400
Date: Tue, 25 Oct 2005 12:37:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051025143741.GA6604@logos.cnet>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com> <20051022005050.GA27317@logos.cnet> <aec7e5c30510230550j66d6e37fg505fd6041dca9bee@mail.gmail.com> <20051024074418.GC2016@logos.cnet> <aec7e5c30510250437h6c300066s14e39a0c91be772c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30510250437h6c300066s14e39a0c91be772c@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Magnus,

On Tue, Oct 25, 2005 at 08:37:52PM +0900, Magnus Damm wrote:
> On 10/24/05, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > On Sun, Oct 23, 2005 at 09:50:18PM +0900, Magnus Damm wrote:
> > > Maybe SLAB defragmentation code is suitable for page migration too?
> >
> > Free dentries are possible to migrate, but not referenced ones.
> >
> > How are you going to inform users that the address of a dentry has
> > changed?
> 
> Um, not sure, but the idea of defragmenting SLAB entries might be
> similar to moving them, ie migration. But how to solve the per-SLAB
> referencing is another story... =)
> 
> > > > > But I'm probably underestimating the cost of page migration...
> > > >
> > > > The zone balancing issue you describe might be an issue once zone
> > > > said pages can be migrated :)
> > >
> > > My main concern is that we use one LRU per zone, and I suspect that
> > > this design might be suboptimal if the sizes of the zones differs
> > > much. But I have no numbers.
> >
> > Migrating user pages from lowmem to highmem under situations with
> > intense low memory pressure (due to certain important allocations
> > which are restricted to lowmem) might be very useful.
> 
> I patched the kernel on my desktop machine to provide some numbers.
> The zoneinfo file and a small patch is attached.
> 
> $ uname -r
> 2.6.14-rc5-git3
> 
> $ uptime
>  20:27:47 up 1 day,  6:27, 18 users,  load average: 0.01, 0.13, 0.15
> 
> $ cat /proc/zoneinfo | grep present
>         present  4096
>         present  225280
>         present  30342
> 
> $ cat /proc/zoneinfo | grep tscanned
>         tscanned 151352
>         tscanned 3480599
>         tscanned 541466
> 
> "tscanned" counts how many pages that has been scanned in each zone
> since power on. Executive summary assuming that only LRU pages exist
> in the zone:
> 
> DMA: each page has been scanned ~37 times
> Normal: each page has been scanned ~15 times
> HighMem: each page has been scanned ~18 times
> 
> So if your user space page happens to be allocated from the DMA zone,
> it looks like it is more probable that it will be paged out sooner
> than if it was allocated from another zone. And this is on a half year
> old P4 system.

Well the higher relative pressure on a specific zone is a fact you have
to live with.

Even with a global LRU you're going to suffer from the same issue once
you've got different relative pressure on different zones.

Thats the reason for the mechanisms which attempt to avoid allocating
from the lower precious zones (lowmem_reserve and the allocation
fallback logic).

> > > There are probably not that many drivers using the DMA zone on a
> > > modern PC, so instead of bringing performance penalty on the entire
> > > system I think it would be nicer to punish the evil hardware instead.
> >
> > Agreed - the 16MB DMA zone is silly. Would love to see it go away...
> 
> But is the DMA zone itself evil, or just that we have one LRU per zone...?

I agree that per-zone LRU complicates global page aging (you simply don't have 
global aging).

But how to deal with restricted allocation requirements otherwise?
Scanning several GB's worth of pages looking for pages in a specific
small range can't be very promising.

Hope to be useful comments.

> --- from-0002/include/linux/mmzone.h
> +++ to-work/include/linux/mmzone.h	2005-10-24 10:43:13.000000000 +0900
> @@ -151,6 +151,7 @@ struct zone {
>  	unsigned long		nr_active;
>  	unsigned long		nr_inactive;
>  	unsigned long		pages_scanned;	   /* since last reclaim */
> +	unsigned long		pages_scanned_total;
>  	int			all_unreclaimable; /* All pages pinned */
>  
>  	/*
> --- from-0002/mm/page_alloc.c
> +++ to-work/mm/page_alloc.c	2005-10-24 10:51:05.000000000 +0900
> @@ -2101,6 +2101,7 @@ static int zoneinfo_show(struct seq_file
>  			   "\n        active   %lu"
>  			   "\n        inactive %lu"
>  			   "\n        scanned  %lu (a: %lu i: %lu)"
> +			   "\n        tscanned %lu"
>  			   "\n        spanned  %lu"
>  			   "\n        present  %lu",
>  			   zone->free_pages,
> @@ -2111,6 +2112,7 @@ static int zoneinfo_show(struct seq_file
>  			   zone->nr_inactive,
>  			   zone->pages_scanned,
>  			   zone->nr_scan_active, zone->nr_scan_inactive,
> +			   zone->pages_scanned_total,
>  			   zone->spanned_pages,
>  			   zone->present_pages);
>  		seq_printf(m,
> --- from-0002/mm/vmscan.c
> +++ to-work/mm/vmscan.c	2005-10-24 10:44:09.000000000 +0900
> @@ -633,6 +633,7 @@ static void shrink_cache(struct zone *zo
>  					     &page_list, &nr_scan);
>  		zone->nr_inactive -= nr_taken;
>  		zone->pages_scanned += nr_scan;
> +		zone->pages_scanned_total += nr_scan;
>  		spin_unlock_irq(&zone->lru_lock);
>  
>  		if (nr_taken == 0)
> @@ -713,6 +714,7 @@ refill_inactive_zone(struct zone *zone, 
>  	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
>  				    &l_hold, &pgscanned);
>  	zone->pages_scanned += pgscanned;
> +	zone->pages_scanned_total += pgscanned;
>  	zone->nr_active -= pgmoved;
>  	spin_unlock_irq(&zone->lru_lock);
>  

