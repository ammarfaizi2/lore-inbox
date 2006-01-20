Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWATJ4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWATJ4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWATJ4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:56:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6296 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750777AbWATJ4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:56:49 -0500
Date: Fri, 20 Jan 2006 01:56:43 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: akpm@osdl.org, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [TEST PATCH 3/3] lib bitmap region restructure
Message-Id: <20060120015643.11e8707c.pj@sgi.com>
In-Reply-To: <20060120081305.GB3918@linux-sh.org>
References: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com>
	<20060120020808.19584.3859.sendpatchset@jackhammer.engr.sgi.com>
	<20060120081305.GB3918@linux-sh.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul - I told Andrew in a side discussion that he can ignore us until we
finished hashing this out.

Once you have something you like, then could you send lkml and Andrew
and the rest of us on the cc list one full set of these patches, in
nicely cleaned up ready to publish form, asking Andrew to take them?

I'll almost certainly agree with any of the variations you are
considering now, and chime in with my "signed-off-by" to your
post.  If you want to get fancy, you can put, on exactly line
one at the top of the patch "From Paul Jackson <pj@sgi.com>"
for those patches that you'd rather I get blamed for than you.

If you decide to change the alignment to at most word boundaries,
instead of the (1 << order) I had for all sizes, then probably best to
redo my patch 3/3 to your choice.  No sense sending in 4 patches,
where patch 4 just reverses a rejected design decision of patch 3.

Paul Mundt wrote:
> bitmap_find_free_region() switches to walking the bitmap in 1 << order
> steps, as opposed to nbitsperlong, which causes it to skip over more
> space than it needs to and we end up fragmenting the bitmap pretty
> quickly

Ah - I guess my problem is that I believed James code comment:

 * This is used to allocate a memory region from a bitmap.  The idea is
 * that the region has to be 1<<order sized and 1<<order aligned (this
 * makes the search algorithm much faster).

I thought this meant that it was a design requirement (the "idea")
to have the alignment always be (1 << order).  Apparently it was
just a useful performance tweak, for the sub-word sizes.

Apparently for the multiword case you are adding, you recommend going
for tighter packing of the allocated regions, rather than extending
the alignment constraint past a single word.

> ... causes it to skip over more
> space than it needs to and we end up fragmenting the bitmap pretty
> quickly.

Just guessing here, since I've no clue what your typical access
pattern is.  But it might actually be that you got less fragmentation
over the long haul with a uniform alignment to (1 << order), than with
an alignment to at most a word boundary.  Certainly as you observed the
early allocations will take more space, but the (1 << order) alignment
seems to nicely mimic a buddy heap, which over an extended period of
insertions and deletions (allocs and frees or whatever) resists
fragmentation rather well.

I actually don't care either way, however.

If you are going with the alignment to at most a word boundary,
rather than uniformly to (1 << order) bits, then could you fix one
more comment, my rephrasing of James initial comment:

 * A region of a bitmap is a sequence of bits in the bitmap, of
 * some size '1 << order' (a power of two), alligned to that same
 * '1 << order' power of two.

After the spelling error you caught, and this restatement of
alignment, this comment should become something like:

 * A region of a bitmap is a sequence of bits in the bitmap, of
 * some size '1 << order' (a power of two).  For regions smaller
 * than one word (namely, if ((1 << order) < BITS_PER_LONG), then
 * the region is aligned to that same '1 << order' power of two.
 * For regions one word or longer in size, the region is aligned
 * to a word boundary ("word" being unsigned long).

Hmmm ... one more comment needs the same treatment.

My comment:

 * Find a region of free (zero) bits in a @bitmap of @bits bits and
 * allocate them (set them to one).  Only consider regions of length
 * a power (@order) of two, alligned to that power of two, which
 * makes the search algorithm much faster.

would become something like:

 * Find a region of free (zero) bits in a @bitmap of @bits bits and
 * allocate them (set them to one).  Only consider regions of length
 * a power (@order) of two, aligned to either that power of two, or to
 * word boundaries, whichever is smaller.

If you're going to change this alignment to be at most to a word
boundary, then read over my code carefully, in patch 3/3, looking
for any other places where I assumed the (1 << order) alignment.

There is one possible performance hit with this changed alignment.

The performance of bitmap_find_free_region() becomes essentially
O(N**2) rather than O(Log2 N).  The search loop would scan forward
with REG_OP_ISFREE from each word in succession, until it found
the requested sequence of free words, rather than scanning just
from the words on (1 << order) bits alignment.  Since it looks in
more places, the worst case times are longer.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
