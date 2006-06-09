Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWFIRGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWFIRGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWFIRGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:06:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751456AbWFIRGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:06:45 -0400
Date: Fri, 9 Jun 2006 10:06:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 01/14] Per zone counter functionality
Message-Id: <20060609100627.5ff14228.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606090845130.31570@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
	<20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
	<20060608210045.62129826.akpm@osdl.org>
	<Pine.LNX.4.64.0606090845130.31570@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006 08:54:39 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 8 Jun 2006, Andrew Morton wrote:
> 
> > Is the use of 8-bit accumulators more efficient than using 32-bit ones? 
> > Obviously it's better from a cache POV, given that we have a pretty large
> > array of them.  But is there a downside on some architectures in not using
> > the natural wordsize?   I assume not, but I don't really know...
> 
> The advantage is that the whole thing fits into one cacheline right with 
> the pcp information. Some architectures need additional cycles but this 
> increases the cache hit rate. The speed of accessing memory is by far 
> worse than that.
> 
> > > +#ifdef CONFIG_SMP
> > > +typedef atomic_long_t vm_stat_t;
> > > +#define VM_STAT_GET(x) atomic_long_read(&(x))
> > > +#define VM_STAT_ADD(x,v) atomic_long_add(v, &(x))
> > > +#else
> > > +typedef unsigned long vm_stat_t;
> > > +#define VM_STAT_GET(x) (x)
> > > +#define VM_STAT_ADD(x,v) (x) += (v)
> > > +#endif
> > 
> > Is there a need to do this?  On !SMP the atomic ops for well-cared-for
> > architectures use nonatomic RMWs anyway.  For most architectures I'd expect
> > that we can simply use atomic_long_foo() in both cases with no loss of
> > efficiency.
> 
> Maybe I am not up to date too much on !SMP. I thought they still needed 
> atomic ops for MMU races.

There's no need for an atomic op - at the most the architecture would need
local_irq_disable() protection, and that's only if it doesn't have an
atomic-wrt-this-cpu add instruction.


> > > +void refresh_cpu_vm_stats(int cpu)
> > > +{
> > > +	struct zone *zone;
> > > +	int i;
> > > +	unsigned long flags;
> > > +
> > > +	for_each_zone(zone) {
> > > +		struct per_cpu_pageset *pcp;
> > > +
> > > +		pcp = zone_pcp(zone, cpu);
> > > +
> > > +		for (i = 0; i < NR_STAT_ITEMS; i++)
> > > +			if (pcp->vm_stat_diff[i]) {
> > > +				local_irq_save(flags);
> > > +				zone_page_state_add(pcp->vm_stat_diff[i],
> > > +					zone, i);
> > > +				pcp->vm_stat_diff[i] = 0;
> > > +				local_irq_restore(flags);
> > > +			}
> > > +	}
> > > +}
> > 
> > Note that when this function is called via on_each_cpu(), local interrupts
> > are already disabled.  So a small efficiency gain would come from changing
> > the API definition here to "caller must have disabled local interrupts".
> 
> Interrupts are enabled for on_each_cpu on IA64.

Not from my reading of arch/ia64/kernel/smp.c:handle_IPI().  And if I've
misread it, ia64 has broken invalidate_bh_lrus() and who knows what else.

> > Well I guess if this doesn't oops then we've finally answered that "Should
> > this ever happen" in __alloc_pages().
> 
> Why would this oops? I thought all the zones are always populated?

That's my point - probably the check in __alloc_pages() isn't needed.

> > Would it be possible/sensible to move all this stuff into a new .c file? 
> > page_alloc.c is getting awfully large and multipurpose, and this code is a
> > single logical chunk.
> 
> Right thought about that one as well. Can we stablize this first before I 
> do another big reorg?

That's unfortunate patch ordering.  Do it (much) later I guess.
