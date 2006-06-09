Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWFIEBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWFIEBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWFIEBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:01:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965118AbWFIEBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:01:02 -0400
Date: Thu, 8 Jun 2006 21:00:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, marcelo.tosatti@cyclades.com,
       clameter@sgi.com
Subject: Re: [PATCH 01/14] Per zone counter functionality
Message-Id: <20060608210045.62129826.akpm@osdl.org>
In-Reply-To: <20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
	<20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 16:02:44 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Per zone counter infrastructure
> 

Is the use of 8-bit accumulators more efficient than using 32-bit ones? 
Obviously it's better from a cache POV, given that we have a pretty large
array of them.  But is there a downside on some architectures in not using
the natural wordsize?   I assume not, but I don't really know...


> +#ifdef CONFIG_SMP
> +typedef atomic_long_t vm_stat_t;
> +#define VM_STAT_GET(x) atomic_long_read(&(x))
> +#define VM_STAT_ADD(x,v) atomic_long_add(v, &(x))
> +#else
> +typedef unsigned long vm_stat_t;
> +#define VM_STAT_GET(x) (x)
> +#define VM_STAT_ADD(x,v) (x) += (v)
> +#endif

Is there a need to do this?  On !SMP the atomic ops for well-cared-for
architectures use nonatomic RMWs anyway.  For most architectures I'd expect
that we can simply use atomic_long_foo() in both cases with no loss of
efficiency.

> +/*
> + * Update the zone counters for one cpu.
> + */
> +void refresh_cpu_vm_stats(int cpu)
> +{
> +	struct zone *zone;
> +	int i;
> +	unsigned long flags;
> +
> +	for_each_zone(zone) {
> +		struct per_cpu_pageset *pcp;
> +
> +		pcp = zone_pcp(zone, cpu);
> +
> +		for (i = 0; i < NR_STAT_ITEMS; i++)
> +			if (pcp->vm_stat_diff[i]) {
> +				local_irq_save(flags);
> +				zone_page_state_add(pcp->vm_stat_diff[i],
> +					zone, i);
> +				pcp->vm_stat_diff[i] = 0;
> +				local_irq_restore(flags);
> +			}
> +	}
> +}

Note that when this function is called via on_each_cpu(), local interrupts
are already disabled.  So a small efficiency gain would come from changing
the API definition here to "caller must have disabled local interrupts".

> +void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> +				int delta)
> +{
> +	zone_page_state_add(delta, zone, item);
> +}
> +EXPORT_SYMBOL(__mod_zone_page_state);
> +
> +void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> +				int delta)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	zone_page_state_add(delta, zone, item);
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(mod_zone_page_state);
> +
> +void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
> +{
> +	zone_page_state_add(1, page_zone(page), item);
> +}
> +EXPORT_SYMBOL(__inc_zone_page_state);
> +
> +void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
> +{
> +	zone_page_state_add(-1, page_zone(page), item);
> +}
> +EXPORT_SYMBOL(__dec_zone_page_state);
> +
> +void inc_zone_page_state(struct page *page, enum zone_stat_item item)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	zone_page_state_add(1, page_zone(page), item);
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(inc_zone_page_state);
> +
> +void dec_zone_page_state(struct page *page, enum zone_stat_item item)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	zone_page_state_add( -1, page_zone(page), item);
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(dec_zone_page_state);
> +#endif

Now my head is spinning ;)  But it looks sane.

We're sure all these exports are needed?

>  #ifdef CONFIG_NUMA
>  /*
> + * Determine the per node value of a stat item. This is done by cycling
> + * through all the zones of a node.
> + */
> +unsigned long node_page_state(int node, enum zone_stat_item item)
> +{
> +	struct zone *zones = NODE_DATA(node)->node_zones;
> +	int i;
> +	long v = 0;
> +
> +	for (i = 0; i < MAX_NR_ZONES; i++)
> +		v += VM_STAT_GET(zones[i].vm_stat[item]);
> +	if (v < 0)
> +		v = 0;
> +	return v;
> +}
> +EXPORT_SYMBOL(node_page_state);

Well I guess if this doesn't oops then we've finally answered that "Should
this ever happen" in __alloc_pages().

> +#ifdef CONFIG_SMP
> +void refresh_cpu_vm_stats(int);
> +void refresh_vm_stats(void);
> +#else
> +static inline void refresh_cpu_vm_stats(int cpu) { };
> +static inline void refresh_vm_stats(void) { };
> +#endif

do {} while (0), please.  Always.  All other forms (afaik) have problems. 
In this case,

	if (something)
		refresh_vm_stats();
	else
		foo();

will not compile.

Always...



Would it be possible/sensible to move all this stuff into a new .c file? 
page_alloc.c is getting awfully large and multipurpose, and this code is a
single logical chunk.

