Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVBATEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVBATEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVBATE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:04:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5591 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262093AbVBATCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:02:18 -0500
Date: Tue, 1 Feb 2005 11:01:55 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock in
 handle_mm_fault
In-Reply-To: <41FF00CE.8060904@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
 <20050114043944.GB41559@muc.de> <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
 <20050114170140.GB4634@muc.de> <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
 <41FF00CE.8060904@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Nick Piggin wrote:

> >  	pte_unmap(page_table);
> > +	page_table_atomic_stop(mm);
> >
> >  	/*
> >  	 * Ok, we need to copy. Oh, well..
> >  	 */
> >  	if (!PageReserved(old_page))
> >  		page_cache_get(old_page);
> > -	spin_unlock(&mm->page_table_lock);
> >
>
> I don't think you can do this unless you have done something funky that I
> missed. And that kind of shoots down your lockless COW too, although it
> looks like you can safely have the second part of do_wp_page without the
> lock. Basically - your lockless COW patch itself seems like it should be
> OK, but this hunk does not.

See my comment at the end of this message.

> I would be very interested if you are seeing performance gains with your
> lockless COW patches, BTW.

So far I have not had time to focus on benchmarking that.

> Basically, getting a reference on a struct page was the only thing I found
> I wasn't able to do lockless with pte cmpxchg. Because it can race with
> unmapping in rmap.c and reclaim and reuse, which probably isn't too good.
> That means: the only operations you are able to do lockless is when there
> is no backing page (ie. the anonymous unpopulated->populated case).
>
> A per-pte lock is sufficient for this case, of course, which is why the
> pte-locked system is completely free of the page table lock.

Introducing pte locking would allow us to go further with parallelizing
this but its another invasive procedure. I think parallelizing COW is only
possible to do reliable with some pte locking scheme. But then the
question is if the pte locking is really faster than obtaining a spinlock.
I suspect this may not be the case.

> Although I may have some fact fundamentally wrong?

The unmapping in rmap.c would change the pte. This would be discovered
after acquiring the spinlock later in do_wp_page. Which would then lead to
the operation being abandoned.

