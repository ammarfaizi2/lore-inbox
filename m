Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUKOXEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUKOXEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKOXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:03:25 -0500
Received: from almesberger.net ([63.105.73.238]:39436 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261528AbUKOW77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:59:59 -0500
Date: Mon, 15 Nov 2004 19:59:46 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
Message-ID: <20041115195946.Z28802@almesberger.net>
References: <20041114235646.K28802@almesberger.net> <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu> <20041115175415.X28802@almesberger.net> <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu> <20041115184240.Y28802@almesberger.net> <Pine.GSO.4.58.0411151705260.6691@lazuli.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0411151705260.6691@lazuli.engin.umich.edu>; from vrajesh@umich.edu on Mon, Nov 15, 2004 at 05:27:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian wrote:
> No, that's not possible. Whenever we change vm_pgoff, vm_start, or
> vm_end, we reshuffle the prio_tree. Check mm/mmap.c:vma_adjust().

Excellent, that makes it a lot easier.

> If you are thinking vm_set.head or vm_set.parent is free to use
> for h_index, then it is incorrect. No field is free. If a vma
> is a tree node (and in this discussion we care only about tree
> nodes), then every field in vma->shared is used. We cannot reuse
> them for storing h_index.

Oh, I see. I thought it was that either vm_set or prio_tree_node
was used. (Which I found somewhat confusing, but attributed my
confusion to simply not understanding all the strange ways of MM.)
Sorry about the confusion.

So yes, one more word then :-(

> If we impose that there can be only 2 types of prio_tree, then
> we can simply add an if-else condition in the GET_INDEX macro.
> IMHO, that will not lead to any noticeable performance drop.

Yes, that sounds better. It would also allow for a later transition
of VMA_PRIO_TREE to GENERIC_PRIO_TREE.

Now, if we want to prepare things already now for a later migration,
it would be nice to call the generic one "struct prio_tree_node",
since it would eventually become the only node type anyway.

Perhaps something along these lines:

struct prio_tree_node {
	struct vma_prio_tree_node prio_tree_node;
	unsigned long r_index, h_index;
};

Or would you consider this as premature optimization ?

> But, I agree with you that changing the layout of vm_area_struct
> is a better (but intrusive) approach.

I also wonder how expensive the calculations in HEAP_INDEX are.
Probably not very.

To make the intrusive change a bit more palatable, vm_pgoff could
become #define vm_pgoff(vma) ((vma)->shared.prio_tree_node.r_index)

Okay, so now we only need someone who has meaningful MM tests to
tell us how badly this would hurt performance :-)

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
