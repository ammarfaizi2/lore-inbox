Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310412AbSCPP25>; Sat, 16 Mar 2002 10:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310400AbSCPP2r>; Sat, 16 Mar 2002 10:28:47 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:64453 "EHLO
	starship") by vger.kernel.org with ESMTP id <S310405AbSCPP2f>;
	Sat, 16 Mar 2002 10:28:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Date: Sat, 16 Mar 2002 16:24:03 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020313085217.GA11658@krispykreme> <E16la2m-0000SX-00@starship> <a6te11$si7$1@penguin.transmeta.com>
In-Reply-To: <a6te11$si7$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mG2N-0000d7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2002 07:20 pm, Linus Torvalds wrote:
> In article <E16la2m-0000SX-00@starship>,
> Daniel Phillips  <phillips@bonn-fries.net> wrote:
> >On March 14, 2002 02:21 pm, Momchil Velikov wrote:
> >> 
> >> Out of curiousity, why there's a need to update the linux page tables ?
> >> Doesn't pte/pmd/pgd family functions provide enough abstraction in
> >> order to maintain _only_ the hashed page table ?
> >
> >No, it's hardwired to the x86 tree view of page translation.
> 
> No no no.
> 
> If you think that, then you don't see the big picture.

The statement itself is correct, however as for negative connotations, there 
aren't any intended.

I meant that the functions are hardwired to the tree structure, which they 
certainly are - each flavor of traversal is written out in full as a series 
of nested loops across the various tree levels.  Taking inventory of the 
existing abstractions:

  - Low level page table entry operations are per-architecture

  - Sizes of tables and entries are per-architecture

  - Two-level tables are cleverly made to appear as three-level tables

  - Hooks are sprinkled through the code as necessary to accommodate
    special per-architecture requirements, including possibly mapping 
    operations on the generic (x86-style) page table onto the arch's
    hardware page tables if necessary.

It could be a lot more abstract than that.  Chuck Cranor's UVM (which seems 
to bear some sort of filial relationship to the FreeBSD VM) buries all 
accesses to the page table behind a 'pmap' API, and implements the standard 
Unix VM semantics at the 'memory object' level.  In UVM the page table is 
just a cache of state encoded in memory objects and a means of communicating 
with the hardware.

In contrast, your design dives exuberantly straight into the page table tree 
to manipulate it directly, and relies on it as the primary repository of VM 
state information.  Unix VM semantics are implemented by a seemingly-naive 
combination of pte-copying and reference counting.  This approach is simple 
and robust, and in some cases outperforms UVM's structured high level 
approach, e.g,, since there is less structural manipulation to do at fork 
time, Linux forking is faster, at least in the case that there are not too 
many mapped pages tables in the parent.

When we get into forks from large memory processes the UVM approach beats us, 
as page table copying costs start to predominate.  At this point your 
approach of letting VM state live in the page table comes to the rescue, as I 
was able to extend it into a new way of implementing unix VM semantics 
efficiently, by sharing page tables instead of relying on memory objects.  
This is far simpler than the (to my mind, terrifying) memory object approach. 
I would probably not have had this insight if it were not for the way you 
designed the page table abstraction.  Or should I say, nonabstraction, 
because it's precisely the simplicity that allowed it to be extended in an 
interesting way.

So yes, I appreciate the elegance of the existing design.

> In fact, when I did the 3-level page tables for Linux, no x86 chips that
> could _use_ three levels actually existed.
> 
> The Linux MM was actually _designed_ for portability when I did the port
> to alpha (oh, that's a long time ago). I even wrote my masters thesis on
> why it was done the way it was done (the only actual academic use I ever
> got out of the whole Linux exercise ;)

Honorary doctorates don't count I suppose ;)

> Yes a tree-based page table matches a lot of hardware architectures very
> well.  And it's _not_ just x86: it also matches soft-fill TLB's better
> than alternatives (newer sparcs and MIPS), and matches a number of other
> architecture specifications (eg alpha, m68k). 
> 
> So on about 50% of architectures (and 99.9% of machines), the Linux MM
> data structures can be made to map 1:1 to the hardware constructs, so
> that you avoid duplicate information. 
> 
> But more importantly than that, the whole point really is that the page
> table tree as far as Linux is concerned is nothing but an _abstraction_
> of the VM mapping hardware. It so happens that a tree format is the only
> sane format to keep full VM information that works well with real loads.
> 
> Whatever the hardware actually does, Linux considers that to be noting
> but an extended TLB.  When you can make the MM software tree map 1:1
> with the extended TLB (as on x86), you win in memory usage and in
> cheaper TLB invalidates, but you _could_ (if you wanted to) just keep
> two separate trees.  In fact, with the rmap patches, that's exactly what
> you see: the software tree is _not_ 1:1 with the hardare tree any more
> (but it _is_ a proper superset, so that you can still get partial
> sharing and still get the cheaper TLB updates). 

I don't quite get your point.  Rmap is just an inverted index on the page 
table tree, not a separate tree.

> Are there machines where the sharing between the software abstraction
> and the hardware isn't as total? Sure. But if you actually know how
> hashed page tables work on ppc, you'd be aware of the fact that they
> aren't actually able to do a full VM mapping - when a hash chain gets too
> long, the hardware is no longer able to look it up ("too long" being 16
> entries on a PPC, for example).

And I suppose you have to take extra faults then to sort this out, and evict 
something to make room in the address space.  But if more than seven 
colliding entries are in the working set, ick.

I hadn't looked at PPC VM architecture before, and now I've taken a cursory 
look.  I understand the motivation for hashed page tables, that is, to 
restrict the mapping overhead to what is actually mapped, flattening out the 
structure and speeding up tlb reloads.

In ten years when terabyte memories are common at the high end (fifteen years 
for Joe Average's PC) we really will have to worry about such things, not so 
much because it won't fit into the existing model - it will - but because the 
existing model is not necessarily optimal.  Somehow I don't think hashing is 
either, personally I hold out more hope for an extent-based approach as the 
ultimate winner.

The problem being solved in any case is: how to massage the page table tree 
without hitting too many cache lines.  I guess we've got a few years to think 
about that one, and for the time being, the current approach is perfectly 
serviceable.

> And that's a common situation with non-tree VM representations - they
> aren't actually VM representations, they are just caches of what the
> _real_ representation is.  And what do we call such caches? Right: they
> are nothing but a TLB. 
> 
> So the fact is, the Linux tree-based VM has _nothing_ to do with x86
> tree-basedness, and everything to do with the fact that it's the only
> sane way to keep VM information. 
> 
> The fact that it maps 1:1 to the x86 trees with the "folding" of the mid
> layer was a design consideration, for sure.  Being efficient and clever
> is always good.  But the basic reason for tree-ness lies elsewhere. 
> (The basic reasons for tree-ness is why so many architectures _do_ use a
> tree-based page table - you should think of PPC and ia64 as the sick
> puppies who didn't understand.  Read the PPC documentation on virtual
> memory, and you'll see just _how_ sick they are). 
>
> 			Linus

/me adds 'read the PPC VM specs' to his too-long list of things to do

-- 
Daniel
