Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315522AbSECBUI>; Thu, 2 May 2002 21:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315523AbSECBUI>; Thu, 2 May 2002 21:20:08 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:23716 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315522AbSECBUG>;
	Thu, 2 May 2002 21:20:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Fri, 3 May 2002 03:19:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E173Pe0-0002Bw-00@starship> <20020503000500.GP32767@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173RjF-0002Ch-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 May 2002 02:05, William Lee Irwin III wrote:
> On Fri, May 03, 2002 at 01:05:45AM +0200, Daniel Phillips wrote:
> > More-or-less equivalently, a tree could be used, with the tradeoff being
> > a little better locality of reference vs more search steps.  The hash
> > structure can also be tweaked to improve locality by making each hash
> > entry map several adjacent memory chunks, and hoping that the chunks tend
> > to occur in groups, which they most probably do.
> > I'm offering the hash table, combined with config_nonlinear as a generic
> > solution.
> 
> Is the virtual remapping for virtual contiguity available at the time
> this remapping table is set up? A 1M-entry table is larger than the
> largest available fragment of physically contiguous memory even at
> 1B/entry. If it's used to direct the virtual remapping you might need
> to perform some arch-specific bootstrapping phases.

Interesting point.  Fortunately, the logical_to_phys table doesn't have to
be a hash, making it considerably smaller.  Then we get to the interesting
part: allocating the phys_to_logical hash table.

The boot loader must have provided at least some contiguous physical
memory in order to load the kernel, the compressed disk image and give
us a little working memory.  (For practical purposes, we're most likely to
have been provided with a full gig, or whatever is appropriate according
to the mem= command line setting, but lets pretend it's a lot less than
that.)  Now, the first thing we need to do is fill in enough of the
vsection table to allocate the table itself.  Fortunately, the bottom part
of the table is the part we need to fill in, and we surely have enough
memory to do that.  We just have to be sure that the process of filling
it in doesn't require any bootmem allocations, which is not so hard - we
the existing memory initialization code already has to obey that
requirement.

Naturally, during initialization of the hash table, we want to be sure
not to perform and phys_to_logical translations, as would be required to 
read values from the page tables during swap-out for example.  Probably
there's already no possibility of that, but it needs a comment at least.

I can't provide any more details than that, because I'm not familiar
with the way the iseries boots.  Anton is the man there.

> Also, what is the
> recourse of a boot-time allocated table when it overflows due to the
> onlining of sufficient physical memory?

We ought to have some clue about the maximum number of physical memory
chunks available to us.  I doubt *every* partition is going to be
provided 256 GB of memory.  In fact, the real amount we need will be
considerably less, and the phys_to_logical table will be smaller than
16 MB, say, 1 MB.  Just allocate the whole thing and be done with it.

> Or are there pointer links
> within the table entries so as to provide collision chains?

For this one I'd think a classic, nonlist, hash table is the way to go.

At 16 bytes, I overestimated the per-entry size, really 8 bytes is more
realistic.  We need 34 bits for the key field (52 bit physical range,
less 18 bits chunk size) and considerably less than 32 bits for the
value field (a logical section) so it works out nicely.

> If so,
> then the memory requirements are even larger... If you limit the size
> of the table to consume an entire hypervisor-allocated memory fragment
> would that not require boot-time allocation of a fresh chunk from the
> hypervisor and virtually mapping the new chunk?

I think that the bootstrapping method described above is sufficiently
simple and robust to obviate this requirement.

> How do you know what
> the size of the table should be if the number of chunks varies
> dramatically?

The most obvious and practical approach is to have the boot loader tell
us, we allocate the maximum size needed, and won't worry about that
again.

-- 
Daniel
