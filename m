Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbUDRXqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 19:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUDRXqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 19:46:35 -0400
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:50835 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S264210AbUDRXqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 19:46:30 -0400
Date: Sun, 18 Apr 2004 19:46:26 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: "Kevin O'Connor" <kevin@koconnor.net>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Questions on prio_tree
In-Reply-To: <20040418161355.GA1854@ohio.localdomain>
Message-ID: <Pine.GSO.4.58.0404181850300.29771@sapphire.engin.umich.edu>
References: <20040414213613.GA21218@ohio.localdomain> <20040418161355.GA1854@ohio.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kevin,

Thanks for you analysis and comments.

> 1 - Why does prio_tree_expand use the max_heap_index to determine the
> height of the radix tree?  The bits of the radix_index is only ever used
> (never the bits in the heap_index), so shouldn't max_radix_index be used?

In some cases heap_index is also used. As you noted below sometimes
size = heap_index - radix_index is used for indexing the tree. If you
consider radix_index = 0UL, then size == heap_index.

> I understand that using the max_heap_index isn't necessary broken (it is
> guaranteed to be greater than or equal to the max_radix_index), but it
> seems inefficient.  As an example, consider the case where 100 vmas are
> created all starting at address 0 and ending at addresses 0 through 100.
> The current code will force the address part of the tree to a height of 7,
> but since there is only one start address (0) the tree really could have a
> height of just 1.

Good example. Actually, your example is the exact reason why we use
max_heap_index rather than max_radix_index.

It is clear that we cannot store 101 vmas if the height of the tree is
just 1. We need at least 7 levels to store 101 vmas. Yes. The first 7
levels of the tree will be skewed because radix_index (all 0) is used
for indexing first 7 (root->index_bits) levels. From level 8 to 14 the
size (== heap_index because radix_index is always 0) is used for indexing
the tree. So from level 8 to 14 it will be a fully packed (dense) radix
tree where size (== heap_index) is used as the index.

Yes. This is bit inefficient. But, it provides a clean solution for a
corner case where all vmas start from the same pgoff (radix_index)
with different end addresses. This is a rare corner case, so we don't
have to worry much about the performance here.

> 2 - When traversing the tree, after the first root->index_bits levels of
> the tree have been walked, the code starts inspecting the "size" portion of
> the radix key.  Why does the code set the start bit for the size portion to
> root->index_bits?  Shouldn't the code set the start bit to (BITS_PER_LONG -
> PAGE_SHIFT)?
>
> Consider the case where 100 vmas are created all starting at address 0 and
> ending at addresses 0 through 100, followed by the creation of a vma from
> address 100,000 - 100,001.  After the first 100 vmas, the tree will have a
> height of 7 (reasons sited above) for the start address and an additional
> height of 7 for the size portion of the index.

Yeah.

> This will cause the tree to
> have 7 records in the start_address portion of the tree, and the remaining
> 93 will be distributed pretty evenly in the size portion of the radix tree
> that hangs off the zero address.

Agreed.

>  When the 101st vma is added, the start
> address portion of the tree will be expanded to a height of 17.  The
> current code will expand the tree to contain 17 records in the size portion
                                                                 ^^^^
I think it is typo: 17 records in the start_address portion

> of the radix tree and leave the remaining 84 records in the size portion of
> the tree hanging off the zero address.

Right.

> The problem, as I see it, is that new inserts into the tree that start at
> address zero will not be inspecting the same bits that were used when the
> first 100 were inserted.  (When the first 100 were inserted, bits 1-7 were
> used to branch in the size portion of the tree, but inserts 102 and on will
> use bits 1-17.)

Thanks for your analysis. This is the reason why the expand algorithm is
O((log n)^2) algorithm.

Check the prio_tree_remove in prio_tree_expand. If the tree is expanded
more than 1 index_bit, then we start removing nodes from the current tree
and form a new skewed tree.

In your example, the index_bits changes from 7 to 17. So, (17 - 7) - 1
= 9 nodes will be removed from the current tree before adding the 101st
vma. So, at the end of the removal of 9 nodes from the current tree,
there are  91 vmas (7 in the skewed start_address portion and the
remaining 84 in the size portion that hangs of the radix_index zero).
Now, the 9 removed vmas and the newly added vma forms a skewed tree of
height 10. The current tree with 91 vmas is appened at the end of this
10 vma skewed tree forming a 17 vma skewed tree in the start_address
portion and 84 vma dense tree in the size portion.

> I don't think this can cause a "crash", but I think it
> skews the tree ordering and could disturb the O(log n + m) behavior of the
> algorithm.

Even when the tree is skewed we guarantee O(log n + m). Yeah, we hide
the multiplicative constant (2). But then, that is the beauty of big-O
notation, right? Hiding the practical performance issues.

The tree gets skewed only in very rare corner cases. So the performance
issues should not matter much, IMHO.

Thanks,
Rajesh

