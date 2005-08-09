Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVHIOgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVHIOgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVHIOgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:36:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:15080 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964786AbVHIOgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:36:09 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.61.0508091145570.11660@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
	 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
	 <20050809080853.A25492@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0508091012480.10693@goblin.wat.veritas.com>
	 <42F88514.9080104@yahoo.com.au>
	 <Pine.LNX.4.61.0508091145570.11660@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 16:28:23 +0200
Message-Id: <1123597704.30257.200.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Who can tell?  rmk's mail sugggests it should work on some valid RAM.

Not really. If I understand Russell here, that RAM has been "put aside"
for use by fancy stuff and is de-facto out of control of the normal page
allocator and refcounting. In this case, I see no reason why it couldn't
be considered as MMIO and ioremap'able :)

> ioremap is making a similar check to the one remap_pfn_range used
> to make; but I see no good reason for it at all.  ioremap should be
> allowed to map whatever the caller asked, just as memset is allowed
> to set whatever the caller asked.

This is dodgy actually. memset can't be guaranteed to work on IOs or
other non-cacheable memory (including real RAM that has been mapped
non-cacheable, typically RAM that has been "set aside" for other uses as
described above, wether it's for AGP, or for some weird processor DMA
bounce buffers or whatever ..., that is RAM that is out of the normal
kernel control).

>   It's up to the caller to get it
> right, not for the function to demand the added reassurance of some
> mysterious page flag being set.
> 
> (But in what I said earlier about VM_RESERVE making sure wrong pages
> not freed, I was confused and confusing ioremap with remap_pfn_range.)
> 
> > I thought the fact that it *won't* bail out when encountering
> > kernel text or remap_pfn_range'ed pages was only due to PG_reserved
> > being the proverbial jack of all trades, master of none.
> > 
> > I could be wrong here though.
> > 
> > But in either case: I agree that it is probably not a great loss
> > to remove the check, although considering it will be needed for
> > swsusp anyway...
> 
> swsusp (and I think crashdump has a similar need) is a very different
> case: it's approaching memory from the zone/mem_map end, with no(?) idea
> of how the different pages are used: needs to save all the info while
> avoiding those areas which would give trouble.  I can well imagine it
> needs either a page flag or a table lookup to decide that.
> 
> But ioremap and remap_pfn_range are coming from drivers which (we hope)
> know what they're mapping these particular areas for.  If it's provable
> that the meaning which swsusp needs is equally usable for a little sanity
> check in ioremap, okay, but I'm sceptical.
> 
> Hugh

