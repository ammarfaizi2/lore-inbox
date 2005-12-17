Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVLQEUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVLQEUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 23:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVLQEUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 23:20:34 -0500
Received: from hera.kernel.org ([140.211.167.34]:5859 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751345AbVLQEUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 23:20:33 -0500
Date: Sat, 17 Dec 2005 02:01:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC3 02/14] Basic counter functionality
Message-ID: <20051217040115.GA6975@dmt.cnet>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com> <20051215001425.31405.74009.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215001425.31405.74009.sendpatchset@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Dec 14, 2005 at 04:14:25PM -0800, Christoph Lameter wrote:
> Currently we have various vm counters for the pages in a zone that are split
> per cpu. This arrangement does not allow access to per zone statistics that
> are important to optimize VM behavior for NUMA architectures. All one can say
> from the per cpu differential variables is how much a certain variable was
> changed by this cpu without being able to deduce how many pages in each zone
> are of a certain type.
> 
> This framework here implements differential counters for each processor
> in struct zone. The differential counters are consolidated when a threshold
> is exceeded (like done in the current implementation for nr_pageache), when
> slab reaping occurs or when a consolidation function is called.
> Consolidation uses atomic operations and accumulates counters per zone in
> the zone structure and also globally in the vm_stat array. VM function can
> access the counts by simply indexing a global or zone specific array.
> 
> The arrangement of counters in an array simplifies processing when output
> has to be generated for /proc/*.
> 
> Counter updates can be triggered by calling *_zone_page_state or
> __*_zone_page_state. The second function can be called if it is known that
> interrupts are disabled.
> 
> Specially optimized increment and decrement functions are provided. These
> can avoid certain checks and use increment or decrement instructions that
> an architecture may provide.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-12 15:07:45.000000000 -0800
> +++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 14:57:22.000000000 -0800
> @@ -596,7 +596,281 @@ static int rmqueue_bulk(struct zone *zon
>  	return i;
>  }
>  
> +/*
> + * Manage combined zone based / global counters
> + */
> +#define STAT_THRESHOLD 32
> +
> +atomic_long_t vm_stat[NR_STAT_ITEMS];
> +
> +static inline void zone_page_state_consolidate(long x, struct zone *zone, enum zone_stat_item item)
> +{
> +	atomic_long_add(x, &zone->vm_stat[item]);
> +	atomic_long_add(x, &vm_stat[item]);
> +}
> +
> +#ifdef CONFIG_SMP
> +/*
> + * Determine pointer to currently valid differential byte given a zone and
> + * the item number.
> + *
> + * Preemption must be off
> + */
> +static inline s8 *diff_pointer(struct zone *zone, enum zone_stat_item item)
> +{
> +	return &zone_pcp(zone, raw_smp_processor_id())->vm_stat_diff[item];
> +}
> +
> +/*
> + * For use when we know that interrupts are disabled.
> + */
> +void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
> +{
> +	s8 *p;
> +	long x;
> +
> +	p = diff_pointer(zone, item);
> +	x = delta + *p;
> +
> +	if (unlikely(x > STAT_THRESHOLD || x < -STAT_THRESHOLD)) {
> +		zone_page_state_consolidate(x, zone, item);
> +		x = 0;
> +	}
> +
> +	*p = x;
> +}

There is no need to disable interrupts AFAICS, but only preemption
(which could cause problems as your comment above describes). I suppose
that these counters are not accessed at interrupt time and are not meant
to be, right?

Which means that if an interrupt happens at any point in the code,
the state will be consistent after the IRQ(s) handler(s) finish and
execution restarts where it had been interrupted.

Why not use preempt_disable/preempt_enable? Those would disappear
if !CONFIG_PREEMPT, and could be faster than the interrupt
disabling/enabling (no need to save "flags" on stack, but increment
preempt count, which has a chance to be on cache, I guess).

It would also be nice to have all code related to debugging only
counters selectable at compile time, since it might not be interesting
data for some scenarios (but unnecessary bloat) - seems that was the
original intent by Andrew as you noted.

