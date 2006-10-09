Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWJIUuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWJIUuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWJIUuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:50:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:15817 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964845AbWJIUuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:50:54 -0400
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Thomas Hellstrom <thomas@tungstengraphics.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061009135254.GA19784@wotan.suse.de>
References: <20061009110007.GA3592@wotan.suse.de>
	 <1160392214.10229.19.camel@localhost.localdomain>
	 <20061009111906.GA26824@wotan.suse.de>
	 <1160393579.10229.24.camel@localhost.localdomain>
	 <20061009114527.GB26824@wotan.suse.de>
	 <1160394571.10229.27.camel@localhost.localdomain>
	 <20061009115836.GC26824@wotan.suse.de>
	 <1160395671.10229.35.camel@localhost.localdomain>
	 <20061009121417.GA3785@wotan.suse.de>
	 <452A50C2.9050409@tungstengraphics.com>
	 <20061009135254.GA19784@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 06:50:36 +1000
Message-Id: <1160427036.7752.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 15:52 +0200, Nick Piggin wrote:
> On Mon, Oct 09, 2006 at 03:38:10PM +0200, Thomas Hellstrom wrote:
> > Nick Piggin wrote:
> > >On Mon, Oct 09, 2006 at 10:07:50PM +1000, Benjamin Herrenschmidt wrote:
> > >
> > >Ok I guess that would work. I was kind of thinking that one needs to
> > >hold the mmap_sem for writing when changing the flags, but so long
> > >as everyone *else* does, then I guess you can get exclusion from just
> > >the read lock. And your per-object mutex would prevent concurrent
> > >nopages from modifying it.
> > 
> > Wouldn't that confuse concurrent readers?
> 
> I think it should be safe so long as the entire mapping has been
> unmapped. After that, there is no read path that should care about
> that flag bit. So long as it is well commented (and maybe done via
> a helper in mm/memory.c), I can't yet see a problem with it.

Should be fine then. Migration does

	- take object mutex
	- unmap_mapping_range() -> remove all PTEs for all mappings to
          that object
	- do whatever is needed for actual migration (copy data etc...)
	- release object mutex

And nopage() does

	- take object mutex
	- check object flags consistency, possibly update VMA
          (also possibly updaet VMA pgprot too while at it for cacheable
           vs. non cacheable, though it's not strictly necessary if we
           use the helper)
	- if object is in ram
		- get struct page
		- drop mutex
		- return struct page
	- else
		- get pfn
		- use helper to install PTE
		- drop mutex
		- return NOPAGE_REFAULT

We don't strictly have to return struct page when the object is in ram
but I feel like it's better for accounting.

Now there is still the question of where that RAM comes from, how it
gets accounted, and wether there is any way we can make it swappable
(which complicates things but would be nice as objects can be fairly big
and we may end up using a significant amount of physical memory with the
graphic objects).

> > Could it be an option to make it safe for the fault handler to 
> > temporarily drop the mmap_sem read lock given that some conditions TBD 
> > are met?
> > In that case it can retake the mmap_sem write lock, do the VMA flags 
> > modifications, downgrade and do the pte modifications using a helper, or 
> > even use remap_pfn_range() during the time the write lock is held?
> 
> When you drop and retake the mmap_sem, you need to start again from
> find_vma. At which point you technically probably want to start again
> from the architecture specfic fault code. It sounds difficult but I
> won't say it can't be done.

I can be done with returning NOPAGE_REFAULT but as you said, I don't
think it's necessary.

Cheers,
Ben.


