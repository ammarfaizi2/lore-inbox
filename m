Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVANEzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVANEzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVANEzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:55:21 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:22712 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261897AbVANEzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:55:06 -0500
Subject: Re: page table lock patch V15 [0/7]: overview
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
In-Reply-To: <20050114043944.GB41559@muc.de>
References: <41E5AFE6.6000509@yahoo.com.au>
	 <20050112153033.6e2e4c6e.akpm@osdl.org> <41E5B7AD.40304@yahoo.com.au>
	 <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
	 <41E5BC60.3090309@yahoo.com.au>
	 <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
	 <20050113031807.GA97340@muc.de>
	 <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
	 <20050113180205.GA17600@muc.de>
	 <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
	 <20050114043944.GB41559@muc.de>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 15:54:59 +1100
Message-Id: <1105678499.5402.105.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 05:39 +0100, Andi Kleen wrote:

> As you can see cmpxchg is slightly faster for the cache hot case,
> but incredibly slow for cache cold (probably because it does something
> nasty on the bus). This is pretty consistent to Intel and AMD CPUs.
> Given that page tables are likely more often cache cold than hot 
> I would use the lazy variant. 
> 

I have a question about your trickery with the read_pte function ;)

pte_t read_pte(volatile pte_t *pte)
{
	pte_t n;
	do {
		n.pte_low = pte->pte_low;
		rmb();
		n.pte_high = pte->pte_high;
		rmb();
	} while (n.pte_low != pte->pte_low);
	return pte;
}

Versus the existing set_pte function. Presumably the order here
can't be changed otherwise you could set the present bit before
the high bit, and race with the hardware MMU?

static inline void set_pte(pte_t *ptep, pte_t pte)
{
        ptep->pte_high = pte.pte_high;
        smp_wmb();
        ptep->pte_low = pte.pte_low;
}

Now take the following interleaving:
CPU0 read_pte                        CPU1 set_pte
n.pte_low = pte->pte_low;
rmb();
                                     ptep->pte_high = pte.pte_high;
                                     smp_wmb();
n.pte_high = pte->pte_high;
rmb();
while (n.pte_low != pte->pte_low);
return pte;
                                     ptep->pte_low = pte.pte_low;

So I think you can get a non atomic result. Are you relying on
assumptions about the value of pte_low not causing any problems
in the page fault handler?

Or am I missing something?


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
