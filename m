Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315263AbSD3XCP>; Tue, 30 Apr 2002 19:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315264AbSD3XCN>; Tue, 30 Apr 2002 19:02:13 -0400
Received: from dsl-213-023-038-192.arcor-ip.net ([213.23.38.192]:57232 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315263AbSD3XBr>;
	Tue, 30 Apr 2002 19:01:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Tue, 30 Apr 2002 01:02:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172K9n-0001Yv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 April 2002 15:35, Andrea Arcangeli wrote:
> On Sun, Apr 28, 2002 at 12:10:20AM +0200, Daniel Phillips wrote:
> > On Friday 26 April 2002 20:27, Russell King wrote:
> > > Hi,
> > > 
> > > I've been looking at some of the ARM discontigmem implementations, and
> > > have come across a nasty bug.  To illustrate this, I'm going to take
> > > part of the generic kernel, and use the Alpha implementation to
> > > illustrate the problem we're facing on ARM.
> > > 
> > > I'm going to argue here that virt_to_page() can, in the discontigmem
> > > case, produce rather a nasty bug when used with non-direct mapped
> > > kernel memory arguments.
> > 
> > It's tough to follow, even when you know the code.  While cooking my
> > config_nonlinear patch I noticed the line you're concerned about and
> > regarded it with deep suspicion.  My patch does this:
> > 
> > -               page = virt_to_page(__va(phys_addr));
> > +               page = phys_to_page(phys_addr);
> > 
> > And of course took care that phys_to_page does the right thing in all
> > cases.
> 
> The problem remains the same also going from phys to page, the problem
> is that it's not a contigous mem_map and it choked when the phys addr
> was above the max ram physaddr. The patch I posted a few days ago will
> fix it (modulo for ununused ram space, but attempting to map into the
> address space unused ram space is a bug in the first place).

My config_nonlinear patch does not suffer from the above problem.  Here's the
code:

unsigned long vsection[MAX_SECTIONS];

static inline unsigned long phys_to_ordinal(phys_t p)
{
	return vsection[p >> SECTION_SHIFT] + ((p & SECTION_MASK) >> PAGE_SHIFT);
}

static inline struct page *phys_to_page(unsigned long p)
{
	return mem_map + phys_to_ordinal(p);
}

Nothing can go out of range.  Sensible, no?

> > <plug>
> > The new config_nonlinear was designed as a cleaner, more powerful
> > replacement for all non-numa uses of config_discontigmem.
> > </plug>
> 
> I maybe wrong because I only had a short look at it so far, but the
> "non-numa" is what I noticed too and that's what renders it not a very
> interesting option IMHO. Most discontigmem needs numa too.

I am, first and foremost, presenting config_nonlinear as a replacement for
config_discontig for *non-numa* uses of config_discontig.  (Sorry if I'm
repeating myself here.)

There are also applications in numa.  Please see the lse-tech archives for
details.  I expect that, by taking a fresh look at numa code in the light
of new work, that the numa code can be cleaned up and simplififed
considerably.  But that's "further work".  Config_nonlinear stands on its
own quite nicely.

> If it cannot
> handle numa it doesn't worth to add the complexity there,

It does not add complexity, it removes complexity.  Please read the patch
more closely.  It's very simple.  It's also more powerful than
config_discontig.

> with numa we must view those chunks differently, not linearly.

Correct.  Now, if you want to extend my patch to handle multiple mem_map
vectors, you do it by defining an ordinal_to_page and page_to_ordinal pair
of mappings.[1]  Don't you think this is a nicer way to organize things?

> Also there's nothing
> magic that says mem_map must have a magical meaning, doesn't worth to
> preserve the mem_map thing, virt_to_page is a much cleaner abstraction
> than doing mem_map + pfn by hand.

True.  The upcoming iteration of config_nonlinear moves all uses of
mem_map inside the per-arch page.h headers, so that mem_map need not
exist at all in configurations where there is no single mem_map.

[1] Since allocation needs to be aware of the separate zones,
_alloc_pages stays much as it is, but if we change all non-numa users
of config_discontig over to config_nonlinear then we can get rid of the
#ifdef CONFIG_NUMA's, by way of cleanup.

-- 
Daniel
