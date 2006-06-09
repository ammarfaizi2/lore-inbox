Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWFIPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWFIPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWFIPy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:54:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38372 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030229AbWFIPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:54:58 -0400
Date: Fri, 9 Jun 2006 08:54:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 01/14] Per zone counter functionality
In-Reply-To: <20060608210045.62129826.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606090845130.31570@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
 <20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
 <20060608210045.62129826.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, Andrew Morton wrote:

> Is the use of 8-bit accumulators more efficient than using 32-bit ones? 
> Obviously it's better from a cache POV, given that we have a pretty large
> array of them.  But is there a downside on some architectures in not using
> the natural wordsize?   I assume not, but I don't really know...

The advantage is that the whole thing fits into one cacheline right with 
the pcp information. Some architectures need additional cycles but this 
increases the cache hit rate. The speed of accessing memory is by far 
worse than that.

> > +#ifdef CONFIG_SMP
> > +typedef atomic_long_t vm_stat_t;
> > +#define VM_STAT_GET(x) atomic_long_read(&(x))
> > +#define VM_STAT_ADD(x,v) atomic_long_add(v, &(x))
> > +#else
> > +typedef unsigned long vm_stat_t;
> > +#define VM_STAT_GET(x) (x)
> > +#define VM_STAT_ADD(x,v) (x) += (v)
> > +#endif
> 
> Is there a need to do this?  On !SMP the atomic ops for well-cared-for
> architectures use nonatomic RMWs anyway.  For most architectures I'd expect
> that we can simply use atomic_long_foo() in both cases with no loss of
> efficiency.

Maybe I am not up to date too much on !SMP. I thought they still needed 
atomic ops for MMU races.

> > +void refresh_cpu_vm_stats(int cpu)
> > +{
> > +	struct zone *zone;
> > +	int i;
> > +	unsigned long flags;
> > +
> > +	for_each_zone(zone) {
> > +		struct per_cpu_pageset *pcp;
> > +
> > +		pcp = zone_pcp(zone, cpu);
> > +
> > +		for (i = 0; i < NR_STAT_ITEMS; i++)
> > +			if (pcp->vm_stat_diff[i]) {
> > +				local_irq_save(flags);
> > +				zone_page_state_add(pcp->vm_stat_diff[i],
> > +					zone, i);
> > +				pcp->vm_stat_diff[i] = 0;
> > +				local_irq_restore(flags);
> > +			}
> > +	}
> > +}
> 
> Note that when this function is called via on_each_cpu(), local interrupts
> are already disabled.  So a small efficiency gain would come from changing
> the API definition here to "caller must have disabled local interrupts".

Interrupts are enabled for on_each_cpu on IA64. The function is also 
called from memory hotplug.

> We're sure all these exports are needed?

Hummm... Maybe some functions are not used right now.

> >  #ifdef CONFIG_NUMA
> >  /*
> > + * Determine the per node value of a stat item. This is done by cycling
> > + * through all the zones of a node.
> > + */
> > +unsigned long node_page_state(int node, enum zone_stat_item item)
> > +{
> > +	struct zone *zones = NODE_DATA(node)->node_zones;
> > +	int i;
> > +	long v = 0;
> > +
> > +	for (i = 0; i < MAX_NR_ZONES; i++)
> > +		v += VM_STAT_GET(zones[i].vm_stat[item]);
> > +	if (v < 0)
> > +		v = 0;
> > +	return v;
> > +}
> > +EXPORT_SYMBOL(node_page_state);
> 
> Well I guess if this doesn't oops then we've finally answered that "Should
> this ever happen" in __alloc_pages().

Why would this oops? I thought all the zones are always populated?

> > +#ifdef CONFIG_SMP
> > +void refresh_cpu_vm_stats(int);
> > +void refresh_vm_stats(void);
> > +#else
> > +static inline void refresh_cpu_vm_stats(int cpu) { };
> > +static inline void refresh_vm_stats(void) { };
> > +#endif
> 
> do {} while (0), please.  Always.  All other forms (afaik) have problems. 
> In this case,

These are inline definitions and not macros.

> Would it be possible/sensible to move all this stuff into a new .c file? 
> page_alloc.c is getting awfully large and multipurpose, and this code is a
> single logical chunk.

Right thought about that one as well. Can we stablize this first before I 
do another big reorg?
