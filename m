Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293041AbSCOSWI>; Fri, 15 Mar 2002 13:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSCOSV7>; Fri, 15 Mar 2002 13:21:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31502 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293041AbSCOSVw>; Fri, 15 Mar 2002 13:21:52 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Date: Fri, 15 Mar 2002 18:20:17 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6te11$si7$1@penguin.transmeta.com>
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020314112725.GA2008@krispykreme> <87wuwfxp25.fsf@fadata.bg> <E16la2m-0000SX-00@starship>
X-Trace: palladium.transmeta.com 1016216498 12133 127.0.0.1 (15 Mar 2002 18:21:38 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Mar 2002 18:21:38 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16la2m-0000SX-00@starship>,
Daniel Phillips  <phillips@bonn-fries.net> wrote:
>On March 14, 2002 02:21 pm, Momchil Velikov wrote:
>> 
>> Out of curiousity, why there's a need to update the linux page tables ?
>> Doesn't pte/pmd/pgd family functions provide enough abstraction in
>> order to maintain _only_ the hashed page table ?
>
>No, it's hardwired to the x86 tree view of page translation.

No no no.

If you think that, then you don't see the big picture.

In fact, when I did the 3-level page tables for Linux, no x86 chips that
could _use_ three levels actually existed.

The Linux MM was actually _designed_ for portability when I did the port
to alpha (oh, that's a long time ago). I even wrote my masters thesis on
why it was done the way it was done (the only actual academic use I ever
got out of the whole Linux exercise ;)

Yes a tree-based page table matches a lot of hardware architectures very
well.  And it's _not_ just x86: it also matches soft-fill TLB's better
than alternatives (newer sparcs and MIPS), and matches a number of other
architecture specifications (eg alpha, m68k). 

So on about 50% of architectures (and 99.9% of machines), the Linux MM
data structures can be made to map 1:1 to the hardware constructs, so
that you avoid duplicate information. 

But more importantly than that, the whole point really is that the page
table tree as far as Linux is concerned is nothing but an _abstraction_
of the VM mapping hardware. It so happens that a tree format is the only
sane format to keep full VM information that works well with real loads.

Whatever the hardware actually does, Linux considers that to be noting
but an extended TLB.  When you can make the MM software tree map 1:1
with the extended TLB (as on x86), you win in memory usage and in
cheaper TLB invalidates, but you _could_ (if you wanted to) just keep
two separate trees.  In fact, with the rmap patches, that's exactly what
you see: the software tree is _not_ 1:1 with the hardare tree any more
(but it _is_ a proper superset, so that you can still get partial
sharing and still get the cheaper TLB updates). 

Are there machines where the sharing between the software abstraction
and the hardware isn't as total? Sure. But if you actually know how
hashed page tables work on ppc, you'd be aware of the fact that they
aren't actualy able to do a full VM mapping - when a hash chain gets too
long, the hardware is no longer able to look it up ("too long" being 16
entries on a PPC, for example).

And that's a common situation with non-tree VM representations - they
aren't actually VM representations, they are just caches of what the
_real_ representation is.  And what do we call such caches? Right: they
are nothing but a TLB. 

So the fact is, the Linux tree-based VM has _nothing_ to do with x86
tree-basedness, and everything to do with the fact that it's the only
sane way to keep VM information. 

The fact that it maps 1:1 to the x86 trees with the "folding" of the mid
layer was a design consideration, for sure.  Being efficient and clever
is always good.  But the basic reason for tree-ness lies elsewhere. 
(The basic reasons for tree-ness is why so many architectures _do_ use a
tree-based page table - you should think of PPC and ia64 as the sick
puppies who didn't understand.  Read the PPC documentation on virtual
memory, and you'll see just _how_ sick they are). 

			Linus
