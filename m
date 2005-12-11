Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVLKWhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVLKWhv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 17:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVLKWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 17:37:50 -0500
Received: from hera.kernel.org ([140.211.167.34]:24966 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750893AbVLKWhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 17:37:50 -0500
Date: Sun, 11 Dec 2005 20:36:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 03/16] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051211223646.GB6978@dmt.cnet>
References: <20051207104755.177435000@localhost.localdomain> <20051207104932.630888000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207104932.630888000@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 06:47:58PM +0800, Wu Fengguang wrote:
> The zone aging rates are currently imbalanced, the gap can be as large as 3
> times, which can severely damage read-ahead requests and shorten their
> effective life time.
> 
> This patch adds three variables in struct zone
> 	- aging_total
> 	- aging_milestone
> 	- page_age
> to keep track of page aging rate, and keep it in sync on page reclaim time.
> 
> The aging_total is just a per-zone counter-part to the per-cpu
> pgscan_{kswapd,direct}_{zone name}. But it is not direct comparable between
> zones, so the aging_milestone/page_age are maintained based on aging_total.
> 
> The page_age is a normalized value that can be direct compared between zones
> with the helper macro age_ge/age_gt. The goal of balancing logics are to keep
> this normalized value in sync between zones.
> 
> One can check the balanced aging progress by running:
>                         tar c / | cat > /dev/null &
>                         watch -n1 'grep "age " /proc/zoneinfo'
> 
> Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
> ---
> 
>  include/linux/mmzone.h |   14 ++++++++++++++
>  mm/page_alloc.c        |   11 +++++++++++
>  mm/vmscan.c            |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
> 
> --- linux.orig/include/linux/mmzone.h
> +++ linux/include/linux/mmzone.h
> @@ -149,6 +149,20 @@ struct zone {
>  	unsigned long		pages_scanned;	   /* since last reclaim */
>  	int			all_unreclaimable; /* All pages pinned */
>  
> +	/* Fields for balanced page aging:
> +	 * aging_total     - The accumulated number of activities that may
> +	 *                   cause page aging, that is, make some pages closer
> +	 *                   to the tail of inactive_list.
> +	 * aging_milestone - A snapshot of total_scan every time a full
> +	 *                   inactive_list of pages become aged.
> +	 * page_age        - A normalized value showing the percent of pages
> +	 *                   have been aged.  It is compared between zones to
> +	 *                   balance the rate of page aging.
> +	 */
> +	unsigned long		aging_total;
> +	unsigned long		aging_milestone;
> +	unsigned long		page_age;
> +
>  	/*
>  	 * Does the allocator try to reclaim pages from the zone as soon
>  	 * as it fails a watermark_ok() in __alloc_pages?
> --- linux.orig/mm/vmscan.c
> +++ linux/mm/vmscan.c
> @@ -123,6 +123,53 @@ static long total_memory;
>  static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
> +#ifdef CONFIG_HIGHMEM64G
> +#define		PAGE_AGE_SHIFT  8
> +#elif BITS_PER_LONG == 32
> +#define		PAGE_AGE_SHIFT  12
> +#elif BITS_PER_LONG == 64
> +#define		PAGE_AGE_SHIFT  20
> +#else
> +#error unknown BITS_PER_LONG
> +#endif
> +#define		PAGE_AGE_SIZE   (1 << PAGE_AGE_SHIFT)
> +#define		PAGE_AGE_MASK   (PAGE_AGE_SIZE - 1)
> +
> +/*
> + * The simplified code is:
> + * 	age_ge: (@a->page_age >= @b->page_age)
> + * 	age_gt: (@a->page_age > @b->page_age)
> + * The complexity deals with the wrap-around problem.
> + * Two page ages not close enough(gap >= 1/8) should also be ignored:
> + * they are out of sync and the comparison may be nonsense.
> + *
> + * Return value depends on the position of @a relative to @b:
> + * -1/8       b      +1/8
> + *   |--------|--------|-----------------------------------------------|
> + *       0        1                           0
> + */
> +#define age_ge(a, b) \
> +	(((a->page_age - b->page_age) & PAGE_AGE_MASK) < PAGE_AGE_SIZE / 8)
> +#define age_gt(a, b) \
> +	(((b->page_age - a->page_age) & PAGE_AGE_MASK) > PAGE_AGE_SIZE * 7 / 8)
> +
> +/*
> + * Keep track of the percent of cold pages that have been scanned / aged.
> + * It's not really ##%, but a high resolution normalized value.
> + */
> +static inline void update_zone_age(struct zone *z, int nr_scan)
> +{
> +	unsigned long len = z->nr_inactive | 1;
> +
> +	z->aging_total += nr_scan;
> +
> +	if (z->aging_total - z->aging_milestone > len)
> +		z->aging_milestone += len;
> +
> +	z->page_age = ((z->aging_total - z->aging_milestone)
> +						<< PAGE_AGE_SHIFT) / len;
> +}
> +

Hi Wu,

It is not very clear to me what is the meaning of these numbers and what
you're trying to deduce from them. Please correct me if I'm wrong.

z->aging_total is the sum of all scanned inactive pages for the zone
(sum of scanned pages by shrink_cache).

z->aging_milestone is the number of pages scanned with "nr_inactive"
precision (it is updated in response to a full inactive list scan).

z->page_age is the difference between aging_milestone and aging_total.

The name sounds a bit misleading since "page age" intuitively means
"what is the age of a page".

Anyway, z->page_age is the number of scanned pages since the last full  
scan, shifted left by PAGE_AGE_SHIFT and divided by the number of       
inactive pages.                                                         

IOW, it still means "number of scanned pages since last full scan".

How can that be meaningful? No other code uses this in the patchset
AFAICS.

