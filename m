Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314144AbSEBAq7>; Wed, 1 May 2002 20:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314150AbSEBAq6>; Wed, 1 May 2002 20:46:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12352 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314144AbSEBAq4>; Wed, 1 May 2002 20:46:56 -0400
Date: Thu, 2 May 2002 02:47:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502024740.P11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <E172gnj-0001pS-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 01:12:48AM +0200, Daniel Phillips wrote:
> On Wednesday 01 May 2002 04:23, Andrea Arcangeli wrote:
> > On Tue, Apr 30, 2002 at 01:02:05AM +0200, Daniel Phillips wrote:
> > > My config_nonlinear patch does not suffer from the above problem.  Here's the
> > > code:
> > >
> > > unsigned long vsection[MAX_SECTIONS];
> > > 
> > > static inline unsigned long phys_to_ordinal(phys_t p)
> > > {
> > > 	return vsection[p >> SECTION_SHIFT] + ((p & SECTION_MASK) >> PAGE_SHIFT);
> > > }
> > > 
> > > static inline struct page *phys_to_page(unsigned long p)
> > > {
> > > 	return mem_map + phys_to_ordinal(p);
> > > }
> > > 
> > > Nothing can go out of range.  Sensible, no?
> > 
> > Really the above vsection[p >> SECTION_SHIFT] will overflow in the very
> > same case I fixed a few days ago for numa-alpha.
> 
> No it will not.  Note however that you do want to choose SECTION_SHIFT so
> that the vsection table is not too large.

You cannot choose SECTION_SHIFT, the hardware will define it for you.

A 64bit arch will get discontigous for example in 64G chunks (real world
example actually), so your SECTION_SHIFT will be equal to 36 and you
will overflow as I said in the previous email (just like discontigmem in
mainline did) unless you want to waste some huge ram for the table (with
2^64/64G entries i.e. sizeof(long) * 2^(64-36) bytes).

> > The whole point is that
> > p isn't a ram page and you assumed that (the alpha code was also assuming
> > that and that's why it overflowed the same way as yours).  Either that
> > or you're wasting some huge tons of ram with vsection on a 64bit arch.
> 
> No and no.  In fact, the vsection table for my current project is only 32
> elements long.

See above.

>     created by config_discontigmem.  It just cycles between round robin
>     between the nodes on each allocation, ignoring the relative

Forget mainline. Look at 2.4.19pre7aa3 _only_ when you look into numa,
there are an huge number of fixes in that area also from Samuel Ortiz
and others. Before I even cosnsider pushing those fixes in mainline
(btw, they are cleanly separated in orthogonal patches, not mixed with
teh other stuff), I will need to see the other vm updates that everybody
deals with included (only a limited number of users is affected by numa
issues).

>   - Has better locality of reference in the mapping tables, because the
>     tables are compact (and could easily be made yet more compact than in
>     the posted patch).  That is, each table entry in a config_discontig
>     node array is 796 bytes, as opposed to 4 (or possibly 2 or 1) with
>     config_nonlinear.

Oh yeah, you save 1 microsecond every 10 years of uptime by taking
advantage of the potentially coalesced cacheline between the last page
in a node and the first page of the next node. Before you can care about
this optimizations you should remove from x86 the pgdat loops that are
not needed with discontigmem disabled like in x86 (this has nothing to
do with discontigmem/nonlinear). That wouldn't be measurable too but at
least it would be more worthwhile.

>   - Eliminates two levels of procedure calls from the alloc_pages call
>     chain.

Again, look -aa, not mainline.

>   - Provides a simple model that is easily implemented across *all*

I don't see much simplicity, it's only weaker I think.

>     architectures.  Please look at the config_discontigmem option and see
>     how many architectures support it.  Hint: it is not enough just to
>     add the option to config.in.
> 
>   - Leads forward to interesting possibilities such as hot plug memory.
>     (Because pinned kernel memory can be remapped to an alternative
>     region of physical memory if desired)

You cannot handle hot plug with nonlinear, you cannot take the mem_map
contigous when somebody plugins new memory, you've to allocate the
mem_map in the new node, discontigmem allows that, nonlinear doesn't.
At the very least you should waste some tons of memory of unused mem_map
for all the potential memory that you're going to plugin, if you want to
handle hot-plug with nonlinear.

breaking up the limitation of the contigous mem_map is been one of the
goals achieved with 2.4, there is no significant advantage (but only
the old limitations) to try to coalesce it again.

>   - Cleans things up considerably.  It eliminates the unholy marriage of

It clobbers things considerably because it overlaps another more power
functionality that is needed anyways for hotplug of ram and numa.

>     config_discontig-for-the-purpose of working around physical memory
>     holes and config_discontig-for-the-purpose of numa allocation.  For
>     example, eliminates a number of #ifdefs from the numa code, allowing 
>     the numa code to be developed in the way that is best for numa,
>     instead of being hobbled by the need to serve a dual purpose.
> 
> It's easy to wave your hands at the idea that code should ever be cleaned up.
> As an example of just how much the config_nonlinear patch cleans things up,
> let's look at the ARM definition of VALID_PAGE, with config_discontigmem:
> 
>     #define KVADDR_TO_NID(addr) \
>                     (((unsigned long)(addr) - 0xc0000000) >> 27)
> 
>     #define NODE_DATA(nid)          (&discontig_node_data[nid])
> 
>     #define NODE_MEM_MAP(nid)       (NODE_DATA(nid)->node_mem_map)
> 
>     #define VALID_PAGE(page) \
>     ({ unsigned int node = KVADDR_TO_NID(page); \
>        ( (node < NR_NODES) && \
>          ((unsigned)((page) - NODE_MEM_MAP(node)) < NODE_DATA(node)->node_size) ); \
>     })
> 
> With config_nonlinear (which does the same job as config_discontigmem in this
> case) we get:
> 
>     static inline int VALID_PAGE(struct page *page)
>     {
>             return page - mem_map < max_mapnr;
>     }
> 
> Isn't that nice?

It isn't nicer to my eyes. It cannot handle a non cotigous mem_map,
showstopper for hotplug ram and numa, and secondly VALID_PAGE must go
away since the first place. The rest of the NODE_MEM_MAP(node) is
completly equivalent to your phys_to_ordinal, just in a different place
and capable of handling discontigous mem_map too.

For my tree I'm not going to include it for now. For my current
understanding of the thing the only ones that could ask for it are the
ia64 folks with huge holes in the middle of the ram of the nodes that may
prefer to hide their inter-node-discontigmem stuff behind the numa layer
to avoid confusing the numa heuristics (still I don't know how big those
holes are so it also depends on that if they really need it), so I will
wait them to ask for it before considering an inclusion. If we need to
complicate a lot the MM code I need somebody to ask for it with some
valid reason, your "cleanup" argument doesn't apply here IMHO (this is
not a change of the IDE code that reshapes the code but that remains
completly functional equivalent), until somebody asks for it with valid
arguments this remains an overlapping non needed and complex
functionality to my eyes.

(btw, the 640k-1M hole is due backwards compatibility stuff so it had a
good reason for it at least and it's a very small hole after all that we
don't even care to skip in the mem_map array on a 4M box)

Andrea
