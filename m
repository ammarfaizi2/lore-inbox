Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbTJPNce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJPNce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:32:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34998
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262921AbTJPNcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:32:32 -0400
Date: Thu, 16 Oct 2003 15:33:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Strange dcache memory pressure when highmem enabled
Message-ID: <20031016133304.GC1348@velociraptor.random>
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au> <20031014224352.0171e971.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014224352.0171e971.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 10:43:52PM -0700, Andrew Morton wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > I noticed that shrink_caches calls shrink_dcache_memory independant
> >   of the classzone that is being shrunk.  So if we are trying to
> >   shrink ZONE_HIGHMEM, the dentry_cache is shrunk, even though the
> >   dentry_cache doesn't live in highmem.  However I'm not sure if I have
> >   understood the classzones well enough for that observation even to
> >   make sense.
> 
> Makes heaps of sense.  Here's an instabackport of what we did in 2.6:
> 
>  mm/vmscan.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff -puN mm/vmscan.c~a mm/vmscan.c
> --- 24/mm/vmscan.c~a	2003-10-14 22:41:34.000000000 -0700
> +++ 24-akpm/mm/vmscan.c	2003-10-14 22:42:22.000000000 -0700
> @@ -640,11 +640,17 @@ int try_to_free_pages_zone(zone_t *class
>  			nr_pages = shrink_caches(classzone, gfp_mask, nr_pages, &failed_swapout);
>  			if (nr_pages <= 0)
>  				return 1;
> -			shrink_dcache_memory(vm_vfs_scan_ratio, gfp_mask);
> -			shrink_icache_memory(vm_vfs_scan_ratio, gfp_mask);
> +			if (classzone - classzone->zone_pgdat->node_zones <
> +						ZONE_HIGHMEM) {
> +				shrink_dcache_memory(vm_vfs_scan_ratio,
> +							gfp_mask);
> +				shrink_icache_memory(vm_vfs_scan_ratio,
> +							gfp_mask);
>  #ifdef CONFIG_QUOTA
> -			shrink_dqcache_memory(vm_vfs_scan_ratio, gfp_mask);
> +				shrink_dqcache_memory(vm_vfs_scan_ratio,
> +							gfp_mask);
>  #endif
> +			}
>  			if (!failed_swapout)
>  				failed_swapout = !swap_out(classzone);
>  		} while (--tries);

An highmem user can make use of lowmem too. Think a 1G box, it looks
wrong to disallow highmem to shrink the 800M of dcache in the normal/dma
zones.

I wonder if what he's suffering from is a reduced normal zone due the
mem_map_t being larger. The reduced normal zone will trigger the dcache
shrinking more frequently. But he may want to try again with 2.4.23pre7
with a classzone aware refill_inactive that will ensure the inactive
list has enough lowmem pages before shrink_caches claims failure.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
