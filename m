Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVAMUXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVAMUXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVAMUTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:19:31 -0500
Received: from mail.suse.de ([195.135.220.2]:6298 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261669AbVAMURp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:17:45 -0500
Date: Thu, 13 Jan 2005 21:17:41 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-ID: <20050113201741.GE20738@wotan.suse.de>
References: <41E5AFE6.6000509@yahoo.com.au> <20050112153033.6e2e4c6e.akpm@osdl.org> <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com> <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com> <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131005280.19097@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501131005280.19097@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:16:58AM -0800, Christoph Lameter wrote:
> On Thu, 13 Jan 2005, Andi Kleen wrote:
> 
> > The rule in i386/x86-64 is that you cannot set the PTE in a non atomic way
> > when its present bit is set (because the hardware could asynchronously
> > change bits in the PTE that would get lost). Atomic way means clearing
> > first and then replacing in an atomic operation.
> 
> Hmm. I replaced that portion in the swapper with an xchg operation
> and inspect the result later. Clearing a pte and then setting it to
> something would open a window for the page fault handler to set up a new

Yes, it usually assumes page table lock hold.

> pte there since it does not take the page_table_lock. That xchg must be
> atomic for PAE mode to work then.

You can always use cmpxchg8 for that if you want. Just to make
it really atomic you may need a LOCK prefix, and with that the
cost is not much lower than a real spinlock.


> 
> > This helps you because you shouldn't be looking at the pte anyways
> > when pte_present is false. When it is not false it is always updated
> > atomically.
> 
> so pmd_present, pud_none and pgd_none could be considered atomic even if
> the pm/u/gd_t is a multi-word entity? In that case the current approach

The optimistic read function I posted would do this.

But you have to read multiple entries anyways, which could get
non atomic no? (e.g. to do something on a PTE you always need
to read PGD/PUD/PMD)

In theory you could do this lazily with retires too, but it would be probably
somewhat costly and complicated.

> would work for higher level entities and in particular S/390 would be in
> the clear.
> 
> But then the issues of replacing multi-word ptes on i386 PAE remain. If no
> write lock is held on mmap_sem then all writes to pte's must be atomic in

mmap_sem is only for VMAs. The page tables itself are protected by page table 
lock.

> order for the get_pte_atomic operation to work reliably.

-Andi
