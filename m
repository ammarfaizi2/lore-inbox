Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVANKq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVANKq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVANKq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:46:29 -0500
Received: from colin2.muc.de ([193.149.48.15]:61969 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261946AbVANKqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:46:23 -0500
Date: 14 Jan 2005 11:46:23 +0100
Date: Fri, 14 Jan 2005 11:46:22 +0100
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-ID: <20050114104622.GA72915@muc.de>
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com> <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com> <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com> <20050114043944.GB41559@muc.de> <1105678499.5402.105.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105678499.5402.105.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 03:54:59PM +1100, Nick Piggin wrote:
> On Fri, 2005-01-14 at 05:39 +0100, Andi Kleen wrote:
> 
> > As you can see cmpxchg is slightly faster for the cache hot case,
> > but incredibly slow for cache cold (probably because it does something
> > nasty on the bus). This is pretty consistent to Intel and AMD CPUs.
> > Given that page tables are likely more often cache cold than hot 
> > I would use the lazy variant. 
> > 
> 
> I have a question about your trickery with the read_pte function ;)
> 
> pte_t read_pte(volatile pte_t *pte)
> {
> 	pte_t n;
> 	do {
> 		n.pte_low = pte->pte_low;
> 		rmb();
> 		n.pte_high = pte->pte_high;
> 		rmb();
> 	} while (n.pte_low != pte->pte_low);
> 	return pte;
> }
> 
> Versus the existing set_pte function. Presumably the order here
> can't be changed otherwise you could set the present bit before
> the high bit, and race with the hardware MMU?

The hardware MMU only ever adds some bits (D etc.). Never changes
the address. It won't clear P bits.  The page fault handler also doesn't 
clear them, only the swapper does. With that knowledge you could probably 
do some optimizations.


> So I think you can get a non atomic result. Are you relying on
> assumptions about the value of pte_low not causing any problems
> in the page fault handler?

I don't know. You have to ask Christopher L. I only commented
on one subthread where he asked about atomic pte reading, 
but haven't studied his patches in detail.

-Andi
