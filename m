Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVAMSEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVAMSEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVAMSDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:03:48 -0500
Received: from colin2.muc.de ([193.149.48.15]:40711 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261382AbVAMSCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:02:07 -0500
Date: 13 Jan 2005 19:02:05 +0100
Date: Thu, 13 Jan 2005 19:02:05 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-ID: <20050113180205.GA17600@muc.de>
References: <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com> <20050112104326.69b99298.akpm@osdl.org> <41E5AFE6.6000509@yahoo.com.au> <20050112153033.6e2e4c6e.akpm@osdl.org> <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com> <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 09:11:29AM -0800, Christoph Lameter wrote:
> On Wed, 13 Jan 2005, Andi Kleen wrote:
> 
> > Alternatively you can use a lazy load, checking for changes.
> > (untested)
> >
> > pte_t read_pte(volatile pte_t *pte)
> > {
> > 	pte_t n;
> > 	do {
> > 		n.pte_low = pte->pte_low;
> > 		rmb();
> > 		n.pte_high = pte->pte_high;
> > 		rmb();
> > 	} while (n.pte_low != pte->pte_low);
> > 	return pte;

It should be return n; here of course.

> > }
> >
> > No atomic operations, I bet it's actually faster than the cmpxchg8.
> > There is a small risk for livelock, but not much worse than with an
> > ordinary spinlock.
> 
> Hmm.... This may replace the get of a 64 bit value. But here could still
> be another process that is setting the pte in a non-atomic way.

The rule in i386/x86-64 is that you cannot set the PTE in a non atomic way
when its present bit is set (because the hardware could asynchronously 
change bits in the PTE that would get lost). Atomic way means clearing
first and then replacing in an atomic operation.

This helps you because you shouldn't be looking at the pte anyways
when pte_present is false. When it is not false it is always updated
atomically.

-Andi
