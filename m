Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267004AbUBRQT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267077AbUBRQT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:19:26 -0500
Received: from galileo.bork.org ([66.11.174.156]:41894 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S267004AbUBRQTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:19:20 -0500
Date: Wed, 18 Feb 2004 11:19:11 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __alloc_pages - NUMA and lower zone protection
Message-ID: <20040218161911.GK12142@localhost>
References: <20040213183243.GH12142@localhost> <20040217145812.409855ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217145812.409855ae.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Feb 17, 2004 at 02:58:12PM -0800, Andrew Morton wrote:
> Martin Hicks <mort@wildopensource.com> wrote:
> 
> > ===== include/linux/mmzone.h 1.51 vs edited =====
> > --- 1.51/include/linux/mmzone.h	Wed Feb  4 00:35:17 2004
> > +++ edited/include/linux/mmzone.h	Wed Feb 11 15:17:40 2004
> > @@ -70,6 +70,7 @@
> >  	spinlock_t		lock;
> >  	unsigned long		free_pages;
> >  	unsigned long		pages_min, pages_low, pages_high;
> > +	unsigned long		zone_type;
> 
> This should be called `zone_index' or something, yes?  What, semantically,
> is it supposed to mean?

It's the highest zone number that contains pages.  i.e., on Altix it is
0 (only ZONE_DMA), on an x86 machine with highmem present it is 2 (has
pages in ZONE_HIGHMEM).

> > --- 1.184/mm/page_alloc.c	Wed Feb  4 00:35:18 2004
> > +++ edited/mm/page_alloc.c	Wed Feb 11 15:48:43 2004
> > @@ -41,6 +41,7 @@
> >  int nr_swap_pages;
> >  int numnodes = 1;
> >  int sysctl_lower_zone_protection = 0;
> > +static int max_zone;	/* Highest zone number that contains pages */
> >  
> >  EXPORT_SYMBOL(totalram_pages);
> >  EXPORT_SYMBOL(nr_swap_pages);
> > @@ -557,27 +558,24 @@
> >  		return NULL;
> >  
> >  	/* Go through the zonelist once, looking for a zone with enough free */
> > -	min = 1UL << order;
> >  	for (i = 0; zones[i] != NULL; i++) {
> >  		struct zone *z = zones[i];
> > -		unsigned long local_low;
> > +		unsigned long local_low = z->pages_low;
> >  
> >  		/*
> >  		 * This is the fabled 'incremental min'. We let real-time tasks
> >  		 * dip their real-time paws a little deeper into reserves.
> >  		 */
> > -		local_low = z->pages_low;
> >  		if (rt_task(p))
> >  			local_low >>= 1;
> > -		min += local_low;
> > -
> > +		min = (1UL << order) + local_low;
> > +		min += local_low * sysctl_lower_zone_protection * (max_zone - z->zone_type);
> >  		if (z->free_pages >= min ||
> >  				(!wait && z->free_pages >= z->pages_high)) {
> >  			page = buffered_rmqueue(z, order, cold);
> >  			if (page)
> > -		       		goto got_pg;
> > +				goto got_pg;
> >  		}
> > -		min += z->pages_low * sysctl_lower_zone_protection;
> >  	}
> 
> This does represent an algorithmic change to the zone fallback code. 
> Previously we were using the pages_low value of the higher zones and were
> feeding that forward into decisions about the availablility of pages in the
> lower zones.
> 
> You've changed this so that each zone is considered independently of the
> others, and its offset into the zone list is used in some manner to set the
> decision threshold.  That could work OK; I'd need to go into a deep trance
> to remember why we did it the current way.

Yes.  I realized this after I sent the patch.  Apparently I wasn't in
enough of a VM trance when I wrote the e-mail.

> 
> What you've done here is to make the `zone_type' number represent the index
> of the zone *within its node*, yes?  So for the "highest" zone within a
> node, (max_zone - z->zone_type) is zero, then it is "1", then it is "2", as
> we walk the zonelist, yes?

Correct.

> Why is it safe to assume that all nodes have the same number of zones (via
> max_zone)?   Perhaps this should be a pgdat member.

Perhaps not, but I think the only penalty is to over guess "min" by a
small factor.  Would accessing some field of pgdat on each iteration not
lead to a lot of dirty cachelines as we move through many nodes?

> Apart from the rt_task thing, the code as you have it here can all be
> removed from the fastpath: the thresholds can all be precalculated within
> the sysctl handler (both lower_zone_protection and min_free_kbytes) and the
> only thing which we need to do in the allocator is to handle RT tasks. 
> This would involve moving the lower_zone_protection calculation into
> setup_per_zone_pages_min().  In fact this is a change which we should make
> regardless of your patch.

Agreed.

> This is a significant change you've made here and I'd like to hear (a lot)
> more about the thinking, testing and measurement which went into it please.

I've done some preliminary testing with the patch above.  I'll do some
more work on what you've asked for above and get some better numbers.

thanks for your input,
mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
