Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbUKOW1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUKOW1r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKOW1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:27:47 -0500
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:26286 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261478AbUKOW1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:27:44 -0500
Date: Mon, 15 Nov 2004 17:27:42 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@lazuli.engin.umich.edu
To: Werner Almesberger <werner@almesberger.net>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
In-Reply-To: <20041115184240.Y28802@almesberger.net>
Message-ID: <Pine.GSO.4.58.0411151705260.6691@lazuli.engin.umich.edu>
References: <20041114235646.K28802@almesberger.net>
 <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu>
 <20041115175415.X28802@almesberger.net> <Pine.LNX.4.58.0411151559070.30860@red.engin.umich.edu>
 <20041115184240.Y28802@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Werner Almesberger wrote:

> Rajesh Venkatasubramanian wrote:
> > I thought about this, but this will lead to a very intrusive patch.
>
> Possibly yes, unfortunately :-( All places where a node's keys change
> would have to be updated, yes. Are there cases where vm_pgoff,
> vm_start, or vm_end can change without doing a prio_tree_insert or
> vma_prio_tree_insert afterwards ?

No, that's not possible. Whenever we change vm_pgoff, vm_start, or
vm_end, we reshuffle the prio_tree. Check mm/mmap.c:vma_adjust().

> If not, the key update could just
> be moved into vma_prio_tree_insert and vma_prio_tree_add.

Yes. That's possible. But we have to expand the vm_area_struct
by sizeof(unsigned long).

> > We have to change the meaning of vm_start and vm_end or increase
> > the size of vm_area_struct.
>
> Nope :-) We already have space for adding one more long, i.e. h_index.

I don't understand what you are thinking. I reread your last mail
to try to understand, but I don't get it.

If you are thinking vm_set.head or vm_set.parent is free to use
for h_index, then it is incorrect. No field is free. If a vma
is a tree node (and in this discussion we care only about tree
nodes), then every field in vma->shared is used. We cannot reuse
them for storing h_index.

> For r_index, one can use what I've described in the last mail.

Yeah. We can use a "#define vm_pgoff shared.r_index". But, that's
very ugly, so we have to change all accesses of vm_pgoff leading to
a relatively intrusive patch.

> > I am only worried about the micro-performance loss due to
> > get_index in the hot-paths such as vma_prio_tree_insert.
>
> Yes, it starts to look fairly heavy for what it does ...

If we impose that there can be only 2 types of prio_tree, then
we can simply add an if-else condition in the GET_INDEX macro.
IMHO, that will not lead to any noticeable performance drop.

But, I agree with you that changing the layout of vm_area_struct
is a better (but intrusive) approach.

Thanks,
Rajesh
