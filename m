Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314093AbSEAXMv>; Wed, 1 May 2002 19:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSEAXMu>; Wed, 1 May 2002 19:12:50 -0400
Received: from dsl-213-023-038-139.arcor-ip.net ([213.23.38.139]:53400 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314093AbSEAXMr>;
	Wed, 1 May 2002 19:12:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 01:12:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172gnj-0001pS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 May 2002 04:23, Andrea Arcangeli wrote:
> On Tue, Apr 30, 2002 at 01:02:05AM +0200, Daniel Phillips wrote:
> > My config_nonlinear patch does not suffer from the above problem.  Here's the
> > code:
> >
> > unsigned long vsection[MAX_SECTIONS];
> > 
> > static inline unsigned long phys_to_ordinal(phys_t p)
> > {
> > 	return vsection[p >> SECTION_SHIFT] + ((p & SECTION_MASK) >> PAGE_SHIFT);
> > }
> > 
> > static inline struct page *phys_to_page(unsigned long p)
> > {
> > 	return mem_map + phys_to_ordinal(p);
> > }
> > 
> > Nothing can go out of range.  Sensible, no?
> 
> Really the above vsection[p >> SECTION_SHIFT] will overflow in the very
> same case I fixed a few days ago for numa-alpha.

No it will not.  Note however that you do want to choose SECTION_SHIFT so
that the vsection table is not too large.

> The whole point is that
> p isn't a ram page and you assumed that (the alpha code was also assuming
> that and that's why it overflowed the same way as yours).  Either that
> or you're wasting some huge tons of ram with vsection on a 64bit arch.

No and no.  In fact, the vsection table for my current project is only 32
elements long.

> After the above out of range bug is fixed in practice it is the same as
> the current discontigmem, except that with the current way you can take
> the page structures in the right node with numa. And again I cannot see
> any advantage in having a contiguous mem_map even for archs with only
> discontigmem and non-numa

> (I think only ARM falls in such category, btw).

You would be wrong about that.

It's clear that you have not looked at the config_nonlinear patch closely,
and are not familiar with it.  I'll try to provide some help, by enumerating
some similarities and differences below.  I'll apologize in advance for not
replying to your email point by point.  Sorry, there were just too many
points ;-)

Config_discontigmem
-------------------

Has exactly one purpose: to eliminate memory wastage due to struct pages
that refer to unpopulated regions of memory.  It does this by dividing
memory regions up into 'nodes', and each node is handled separately by
the memory manager, which attempts to balance allocations between them.

Config_discontig replicates however many zones there are across however
many discontiguous regions there are, so for purposes of allocation, we
end up with a two-dimensional array of zones, (MAX_NR_ZONES * MAX_NR_NODES).

Config_discontigmem uses a table mapping in one direction: given an
address, find a struct page in a one of several ->mem_map array indexed
by the address, or compute a physical memory address by finding a base
physical address in an array indexed by the virtual address.  Conversion
from physical address to struct page also requires a table lookup, to
locate the desired ->mem_map array.

Config_nonlinear
----------------

Config_nonlinear introduces a new, logical address space, and uses a pair
of tables, indexed by a few high bits of the address, one to map sections
of logical address space to sections of physical address space, and the
other to perform the reverse mapping.  This pair of tables is used to
define the usual set of address translation functions used to maintain
the process page tables, including the kernel virtual page tables.  The
real work of doing this translation is, of course, performed by the
address translation hardware - otherwise the bookkeeping cost of
config_nonlinear is comparable to or slightly better than
config_discontigmem.

Such things as bootmem allocations and VALID_PAGE checks are carried out
in the logical address space, which constitutes a considerable
simplification vs config_discontigmem.

Config_nonlinear was not designed as a replacement for numa address
management, however, it is compatible with it and there are numa
applications where config_nonlinear can create efficiencies that
config_discontigmem cannot.  That said, the rest of this discussion is
concerned with non-numa applications of config_nonlinear.

In the non-numa case, config_nonlinear does what config_discontigmem
does, that is, eliminates struct page memory wastage due to unpopulated
regions of memory, and in addition:

  - Can map a large range of physical memory into a small range of
    kernel virtual memory.  This becomes important when physical memory
    is installed at widely separated intervals

  - Does not artificially divide memory into nodes, instead, joins it
    together in one homogeneous pool, which the memory manager divides
    into zones as *necessary* (for example, for highmem).

  - Sharply reduces number of zones needing balancing is sharply reduced vs
    config_discontigmem.  Please take a look at the non-numa code in
    _alloc_pages that attempts to balance between the 'artificial' nodes
    created by config_discontigmem.  It just cycles between round robin
    between the nodes on each allocation, ignoring the relative
    availability of memory in the nodes.  This obvious deficiency could be
    fixed by adding more (finicky) code, or the problem can be eliminated
    completely, using config_nonlinear.

  - Has better locality of reference in the mapping tables, because the
    tables are compact (and could easily be made yet more compact than in
    the posted patch).  That is, each table entry in a config_discontig
    node array is 796 bytes, as opposed to 4 (or possibly 2 or 1) with
    config_nonlinear.

  - Eliminates two levels of procedure calls from the alloc_pages call
    chain.

  - Provides a simple model that is easily implemented across *all*
    architectures.  Please look at the config_discontigmem option and see
    how many architectures support it.  Hint: it is not enough just to
    add the option to config.in.

  - Leads forward to interesting possibilities such as hot plug memory.
    (Because pinned kernel memory can be remapped to an alternative
    region of physical memory if desired)

  - Cleans things up considerably.  It eliminates the unholy marriage of
    config_discontig-for-the-purpose of working around physical memory
    holes and config_discontig-for-the-purpose of numa allocation.  For
    example, eliminates a number of #ifdefs from the numa code, allowing 
    the numa code to be developed in the way that is best for numa,
    instead of being hobbled by the need to serve a dual purpose.

It's easy to wave your hands at the idea that code should ever be cleaned up.
As an example of just how much the config_nonlinear patch cleans things up,
let's look at the ARM definition of VALID_PAGE, with config_discontigmem:

    #define KVADDR_TO_NID(addr) \
                    (((unsigned long)(addr) - 0xc0000000) >> 27)

    #define NODE_DATA(nid)          (&discontig_node_data[nid])

    #define NODE_MEM_MAP(nid)       (NODE_DATA(nid)->node_mem_map)

    #define VALID_PAGE(page) \
    ({ unsigned int node = KVADDR_TO_NID(page); \
       ( (node < NR_NODES) && \
         ((unsigned)((page) - NODE_MEM_MAP(node)) < NODE_DATA(node)->node_size) ); \
    })

With config_nonlinear (which does the same job as config_discontigmem in this
case) we get:

    static inline int VALID_PAGE(struct page *page)
    {
            return page - mem_map < max_mapnr;
    }

Isn't that nice?

-- 
Daniel
