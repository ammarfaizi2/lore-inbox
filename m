Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVANEjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVANEjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVANEjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:39:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:33808 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261879AbVANEjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:39:45 -0500
Date: 14 Jan 2005 05:39:44 +0100
Date: Fri, 14 Jan 2005 05:39:44 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-ID: <20050114043944.GB41559@muc.de>
References: <41E5AFE6.6000509@yahoo.com.au> <20050112153033.6e2e4c6e.akpm@osdl.org> <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com> <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com> <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 05:09:04PM -0800, Christoph Lameter wrote:
> On Thu, 13 Jan 2005, Andi Kleen wrote:
> 
> > On Thu, Jan 13, 2005 at 09:11:29AM -0800, Christoph Lameter wrote:
> > > On Wed, 13 Jan 2005, Andi Kleen wrote:
> > >
> > > > Alternatively you can use a lazy load, checking for changes.
> > > > (untested)
> > > >
> > > > pte_t read_pte(volatile pte_t *pte)
> > > > {
> > > > 	pte_t n;
> > > > 	do {
> > > > 		n.pte_low = pte->pte_low;
> > > > 		rmb();
> > > > 		n.pte_high = pte->pte_high;
> > > > 		rmb();
> > > > 	} while (n.pte_low != pte->pte_low);
> > > > 	return pte;
> 
> I think this is not necessary. Most IA32 processors do 64
> bit operations in an atomic way in the same way as IA64. We can cut out
> all the stuff we put in to simulate 64 bit atomicity for i386 PAE mode if
> we just use convince the compiler to use 64 bit fetches and stores. 486

That would mean either cmpxchg8 (slow) or using MMX/SSE (even slower
because you would need to save FPU stable and disable 
exceptions). 

I think FPU is far too slow and complicated. I benchmarked lazy read
and cmpxchg 8: 

Athlon64:
readpte hot 42
readpte cold 426
readpte_cmp hot 33
readpte_cmp cold 2693

Nocona:
readpte hot 140
readpte cold 960
readpte_cmp hot 48
readpte_cmp cold 2668

As you can see cmpxchg is slightly faster for the cache hot case,
but incredibly slow for cache cold (probably because it does something
nasty on the bus). This is pretty consistent to Intel and AMD CPUs.
Given that page tables are likely more often cache cold than hot 
I would use the lazy variant. 

-Andi


