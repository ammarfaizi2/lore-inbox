Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUBQXAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbUBQW5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:57:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:20899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266757AbUBQW40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:56:26 -0500
Date: Tue, 17 Feb 2004 14:58:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __alloc_pages - NUMA and lower zone protection
Message-Id: <20040217145812.409855ae.akpm@osdl.org>
In-Reply-To: <20040213183243.GH12142@localhost>
References: <20040213183243.GH12142@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks <mort@wildopensource.com> wrote:
>
> 
> Hi,
> 
> There is a problem with the current __alloc pages on a machine with many
> nodes.  As we go down the zones[] list, we may move onto other nodes.
> Each time we go to the next zone we protect these zones by doing
> "min += local_low".
> 
> This is quite appropriate on a machine with one node, but wrong on
> machines with other nodes.  To illustrate, here is an example.  On a
> 256 node Altix machine, a request on node 0 for 2MB requires just over
> 600MB of free memory on the 256th node in order to fullfil the "min"
> requirements if all other nodes are low on memory.  This could leave
> 73GB of memory unallocated across all nodes.
> 
> This patch keeps the same semantics for lower_zone_protection, but only
> provides protection for higher priority zones in the same node.
> 
> The patch seems to do the right thing on my non-NUMA zx1 ia64 machine
> (which has ZONE_DMA and ZONE_NORMAL) as well as the multi-node Altix.
> 

I appreciate the problem.  We do need to fix this.


> ===== include/linux/mmzone.h 1.51 vs edited =====
> --- 1.51/include/linux/mmzone.h	Wed Feb  4 00:35:17 2004
> +++ edited/include/linux/mmzone.h	Wed Feb 11 15:17:40 2004
> @@ -70,6 +70,7 @@
>  	spinlock_t		lock;
>  	unsigned long		free_pages;
>  	unsigned long		pages_min, pages_low, pages_high;
> +	unsigned long		zone_type;

This should be called `zone_index' or something, yes?  What, semantically,
is it supposed to mean?

> --- 1.184/mm/page_alloc.c	Wed Feb  4 00:35:18 2004
> +++ edited/mm/page_alloc.c	Wed Feb 11 15:48:43 2004
> @@ -41,6 +41,7 @@
>  int nr_swap_pages;
>  int numnodes = 1;
>  int sysctl_lower_zone_protection = 0;
> +static int max_zone;	/* Highest zone number that contains pages */
>  
>  EXPORT_SYMBOL(totalram_pages);
>  EXPORT_SYMBOL(nr_swap_pages);
> @@ -557,27 +558,24 @@
>  		return NULL;
>  
>  	/* Go through the zonelist once, looking for a zone with enough free */
> -	min = 1UL << order;
>  	for (i = 0; zones[i] != NULL; i++) {
>  		struct zone *z = zones[i];
> -		unsigned long local_low;
> +		unsigned long local_low = z->pages_low;
>  
>  		/*
>  		 * This is the fabled 'incremental min'. We let real-time tasks
>  		 * dip their real-time paws a little deeper into reserves.
>  		 */
> -		local_low = z->pages_low;
>  		if (rt_task(p))
>  			local_low >>= 1;
> -		min += local_low;
> -
> +		min = (1UL << order) + local_low;
> +		min += local_low * sysctl_lower_zone_protection * (max_zone - z->zone_type);
>  		if (z->free_pages >= min ||
>  				(!wait && z->free_pages >= z->pages_high)) {
>  			page = buffered_rmqueue(z, order, cold);
>  			if (page)
> -		       		goto got_pg;
> +				goto got_pg;
>  		}
> -		min += z->pages_low * sysctl_lower_zone_protection;
>  	}

This does represent an algorithmic change to the zone fallback code. 
Previously we were using the pages_low value of the higher zones and were
feeding that forward into decisions about the availablility of pages in the
lower zones.

You've changed this so that each zone is considered independently of the
others, and its offset into the zone list is used in some manner to set the
decision threshold.  That could work OK; I'd need to go into a deep trance
to remember why we did it the current way.

What you've done here is to make the `zone_type' number represent the index
of the zone *within its node*, yes?  So for the "highest" zone within a
node, (max_zone - z->zone_type) is zero, then it is "1", then it is "2", as
we walk the zonelist, yes?

Why is it safe to assume that all nodes have the same number of zones (via
max_zone)?   Perhaps this should be a pgdat member.

Apart from the rt_task thing, the code as you have it here can all be
removed from the fastpath: the thresholds can all be precalculated within
the sysctl handler (both lower_zone_protection and min_free_kbytes) and the
only thing which we need to do in the allocator is to handle RT tasks. 
This would involve moving the lower_zone_protection calculation into
setup_per_zone_pages_min().  In fact this is a change which we should make
regardless of your patch.

This is a significant change you've made here and I'd like to hear (a lot)
more about the thinking, testing and measurement which went into it please.


