Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUCLVJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUCLVJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:09:41 -0500
Received: from mail.shareable.org ([81.29.64.88]:7563 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262711AbUCLVJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:09:06 -0500
Date: Fri, 12 Mar 2004 21:08:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312210845.GF18799@mail.shareable.org>
References: <Pine.LNX.4.44.0403121217440.6494-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0403120956370.1045@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403120956370.1045@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> You'd want to allocate contiguous indexes within one "vma", since the
> whole point would be to be able to try to quickly find the vma (and thus
> the page) that contains one particular page, but there are no range
> allocators that I can think of that allow growing the VMA after allocation
> (needed for vma merging on mmap and brk()) and still keep the range of
> indexes down to reasonable numbers.

For growing, they don't have to be contiguous - it's just desirable.

When a vma is grown and the page->offset space it would like to occupy
is already taken, it can be split into two vmas.

Of course that alters mremap() semantics, which depend on vma
boundaries.  (mmap, munmap and mprotect don't care).  So add a vma
flag which indicates that it and the following vma(s) are a single
unit for the purpose of remapping.  Call it the mremap-group flag.
Groups always have the same flags etc.; only the vm_offset varies.

In effect, I'm suggesting that instead of having vmas be the
user-visible unit, and some other finer-grained structures track page
mappings, let _vmas_ be the finer-grained structure, and make the
user-visible unit be whatever multiple consecutive vmas occur with
that flag set.  (This is a good balance if the number of splits is
small; not if there are many).

It shouldn't lead to a proliferation of vmas, provided the
page->offset allocation algorithm is sufficiently sparse.

To keep the number of potential splits small, always allocate some
extra page->offset space so that a vma can grow into it.  Only when it
cannot grow in page->offset space, do you create a new vma.  The new
vma has extra page->offset space allocated too.  That extra space
should be proportional to the size of the entire new mremap() region
(multiple vmas), not the new vma size.

In that way, I think it bounds the number of splits to O(log (n/m))
where n is the total mremap() region size, and m is the original size.
The constant in that expression is determined by the proportion that
is used for reserving extra space.

This has some consequences.

If each vma's page->offset allocation reserves space around it to
grow, then adjacent anonymous vmas won't be mergeable.

If they aren't mergeable, it begs the question of why not have an
address_space per vma, instead of per-mm, other than to save memory on
address_space structures?

Well we like them to be mergeable.  Lots of reasons.  So make initial
mmap() allocations not reserve page->offset space exclusively, but
make allocations done by mremap() reserve the extra space, to get that
O(log (n/m)) property.

Using the mremap-group flag, we are also able to give the appearance
of merged vmas when it would be difficult.  If we want certain
anonymous vmas to be appear merged despite them having incompatible
vm_offset values, we can do that.

So going back to the question of address_space per-mm: you don't need
one, due to the mremap-group flag.  It's good to use as few as
possible, but it's ok to use more than one per process or per
fork-group, when absolutely necessary.

That fixes the address_space limitation of 2^32 pages and makes
page->offset allocation _very_ simple:

    1. Allocate by simply incrementing an address counter.

    2. When it's about to wrap, allocate a new address_space.

    3. When allocating, reserve extra space for growing.
       The extra space should be proportional to the allocation, or
       the total size size of the region after mremap(), and clamped
       to a sane maximum such as 4G minus size, and a sane minimum
       such as 2^22 (room for a million reservations per address_space).

    5. When allocating, look at the nearby preceding or following vma
       in the virtual address space.  If the amount of page->offset space
       reserved by those vmas is large enough, we can claim some of that
       reservation for the new allocation.  If our good neighbour is
       adjacent to the new vma, that means the neighbour vma is simply
       grown.  Otherwise, it means we create a new vma which is
       vm_offset-compatible with its neighbour, allowing them to merge if
       the hole between is filled.

    6. By using large reservations, large regions of the virtual address
       space become covered with vm_offset-compatible vmas that are mergeable
       when the holes are filled.

    4. When trying to merge adjacent anon vmas during ordinary
       mmap/munmap/mprotect/mremap operations, if they are not
       vm_offset-compatible (or their address_spaces aren't equal)
       just use the mremap-group flag to make them appear merged.  The
       user-visible result is a single vma.  The effect on the kernel
       is a rare non-mergeable boundary, which will slow vma searching
       marginally.  The benefit is this simple allocation scheme.

This is like what we have today, with some occasional non-mergeable
vma boundaries (but only very few compared with the total
number of vmas in an mm).  These boundaries are not
user-visible, and only affect the kernel algorithms - and in a
simple way.

Data structure changes required: one flag, VM_GROUP or something; each
vma needs a pointer to _its_ address_space (can share space with
vm_file or such); each vma needs to record how much page->offset space
it has reserved beyond its own size.  VM_GROWSDOWN vmas might want to
record a reservation down rather than up.

-- Jamie
