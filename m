Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315286AbSEACXF>; Tue, 30 Apr 2002 22:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSEACXE>; Tue, 30 Apr 2002 22:23:04 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29490 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315286AbSEACXD>; Tue, 30 Apr 2002 22:23:03 -0400
Date: Wed, 1 May 2002 04:23:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020501042341.G11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 01:02:05AM +0200, Daniel Phillips wrote:
> My config_nonlinear patch does not suffer from the above problem.  Here's the
> code:
>
> unsigned long vsection[MAX_SECTIONS];
> 
> static inline unsigned long phys_to_ordinal(phys_t p)
> {
> 	return vsection[p >> SECTION_SHIFT] + ((p & SECTION_MASK) >> PAGE_SHIFT);
> }
> 
> static inline struct page *phys_to_page(unsigned long p)
> {
> 	return mem_map + phys_to_ordinal(p);
> }
> 
> Nothing can go out of range.  Sensible, no?

Really the above vsection[p >> SECTION_SHIFT] will overflow in the very
same case I fixed a few days ago for numa-alpha. The whole point is that
p isn't a ram page and you assumed that (the alpha code was also assuming
that and that's why it overflowed the same way as yours).  Either that
or you're wasting some huge tons of ram with vsection on a 64bit arch.

After the above out of range bug is fixed in practice it is the same as
the current discontigmem, except that with the current way you can take
the page structures in the right node with numa. And again I cannot see
any advantage in having a contigous mem_map even for archs with only
discontigmem and non-numa (I think only ARM falls in such category, btw).

> > > <plug>
> > > The new config_nonlinear was designed as a cleaner, more powerful
> > > replacement for all non-numa uses of config_discontigmem.
> > > </plug>
> > 
> > I maybe wrong because I only had a short look at it so far, but the
> > "non-numa" is what I noticed too and that's what renders it not a very
> > interesting option IMHO. Most discontigmem needs numa too.
> 
> I am, first and foremost, presenting config_nonlinear as a replacement for
> config_discontig for *non-numa* uses of config_discontig.  (Sorry if I'm
> repeating myself here.)
> 
> There are also applications in numa.  Please see the lse-tech archives for
> details.  I expect that, by taking a fresh look at numa code in the light
> of new work, that the numa code can be cleaned up and simplififed
> considerably.  But that's "further work".  Config_nonlinear stands on its
> own quite nicely.

Tell me how an ARM machine will run faster with nonlinear, it is doing
nearly the same thing except it's a lesser abstraction that forces a
contiguous mem_map. Current code is much more powerful and it carries
more information (the pgdat describes the whole memory topology to the
common code), and it's not going to be slower, so I don't see why should
we complicate the code with nonlinear. Personally I hate more than one
way of doing the same thing if there's no need of it, the less ways the
less you have to keep in mind, the simpler to understand, the better
(partly offtopic but for the very same reason when I work in userspace I
much prefer coding in python than in perl).

> > If it cannot
> > handle numa it doesn't worth to add the complexity there,
> 
> It does not add complexity, it removes complexity.  Please read the patch
> more closely.  It's very simple.  It's also more powerful than
> config_discontig.

How? I may be overlooking something but I would say it's all but more
powerful. I don't see any "power" point in trying to keep the mem_map
contigous. please don't tell me it's more powerful, just tell me why.

> > with numa we must view those chunks differently, not linearly.
> 
> Correct.  Now, if you want to extend my patch to handle multiple mem_map
> vectors, you do it by defining an ordinal_to_page and page_to_ordinal pair
> of mappings.[1]  Don't you think this is a nicer way to organize things?

What's the advantage? And after you can have more than one mem_map,
after you added this "vector", then each mem_map will match a
discontigmem pgdat. Tell me a numa machine where there's an hole in the
middle of a node. The holes are always intra-node, never within the
nodes themself. So the nonlinear-numa should fallback to the stright
mem_map array pointed by the pgdat all the time like it is just right now.

The only advantage of nonlinear I can see could be a machine with an
huge hole in a node, then with nonlinear you could avoid wasting mem_map
for this hole but without having to add another pgdat that would
otherwise break numa assumptions on the pgdat, but I'm not aware of any
machine with huge holes of the order of the gigabytes in the middle of a
node, at the very least if that happens it means the hardware of the
machine is misconfigured.

The very same problem would happen right now in x86 if there would be an
huge hole in the physical ram, so you have 128M of ram and then an hole
of 63G and then the other phusical 900M at offset 63G+128M, it will
never happen, that's broken hardware if you see anything like that.

at the very least I would wait somebody to ask with a so weird hardware
that intentionally does like the above instead of overdesigning common
code abstractions, and there would be also other ways to deal with such
situation without requiring a contigous mem_map.

> > Also there's nothing
> > magic that says mem_map must have a magical meaning, doesn't worth to
> > preserve the mem_map thing, virt_to_page is a much cleaner abstraction
> > than doing mem_map + pfn by hand.
> 
> True.  The upcoming iteration of config_nonlinear moves all uses of
> mem_map inside the per-arch page.h headers, so that mem_map need not
> exist at all in configurations where there is no single mem_map.

That's fine, and all correct kernel code just does that correctly,
nonbody is allowed to use mem_map in any common code anywhere (besides
the mm proper internals when discontigmem is disabled).

Andrea
