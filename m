Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUETQ1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUETQ1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUETQ1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:27:35 -0400
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:10632 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S265128AbUETQ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:27:32 -0400
Date: Thu, 20 May 2004 12:27:18 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@azure.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 36 mprotect use vma_merge
In-Reply-To: <Pine.LNX.4.44.0405201538220.9220-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0405201200450.23320@azure.engin.umich.edu>
References: <Pine.LNX.4.44.0405201538220.9220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Can adjust_next overflow?  No? I think making adjust_next in
> > PAGE_SIZE units will avoid overflow concerns.
>
> I think I misunderstood you at first.  You're suggesting that, say,
> next->vm_pgoff might be 0 and next->vm_start 0.4GB and end 2.6GB,
> then next->vm_pgoff would get adjusted to -1.8GB >> PAGE_SHIFT, a
> negative number, when it should be 2.2GB >> PAGE_SHIFT, positive.

Yeap. This is case I was concerned about.

> (Other overflows would be vma_merge's responsibility to prohibit
> merging; though they don't occur because, as my old "16TB" comment
> observes, do_mmap_pgoff doesn't allow the pgoff -1UL to be mapped.
> Though I think you were careful to avoid any such restriction in
> your prio_tree work, so I guess we might change that one day, and
> then need to be a little more careful in the can_vma_merges.)

Hmm. I have to read the vma_merge code carefully to understand that.
I am stuck at vma_adjust itself.

> > [snip]
> > >  	if (root) {
> > > +		if (adjust_next) {
> > > +			vma_prio_tree_init(next);
> > > +			vma_prio_tree_insert(next, root);
> > > +		}
> > >  		vma_prio_tree_init(vma);
> > >  		vma_prio_tree_insert(vma, root);
> > >  		flush_dcache_mmap_unlock(mapping);
> > >  	}
> >
> > I think this flush_dcache_mmap_unlock should go down - after
> > __insert_vm_struct call - just before page_table_lock unlock.
>
> Well, you observed later that the intervening calls take that lock
> internally, so we have to unlock there.

I was going forward and backward. Yesterday night I managed to
figure out the split_vma->vma_adjust->__insert_vm_struct vs.
flush_dcache_page race you describe below. Yes. The race is
real. But, compared to the races you fixed with
flush_dcache_mmap_lock, this is a rare race that occurs in
a tiny window.

I got stuct at vma_merge(case 6)->vma_adjust->"goto again;"
for long. Atlast I convinced myself that vma_adjust is correct,
although in vma_merge(case 6)->vma_adjust case we remove/insert
vma twice from/into the prio_tree. If we rearrange the code and
move "goto again;" before dropping the locks, then we can
remove/insert vma only once. I have to read further to convince
myself of this micro-optimization. If/When I am convinced, I
will send you patch for review.

Thanks,
Rajesh

> But you're obviously right that it would seem better to be able to
> flush_dcache_mmap_unlock lower down when it's all over, to keep
> changes atomic as much as possible.
>
> And you're seriously right.  I was preparing a little lecture on
> how flush_dcache_mmap_lock is only a very low level lock to prevent
> the tree from getting rearranged while arm and parisc are searching
> it for the __flush_dcache page, so it only needs to be held across
> the tree manipulations.
>
> But now that argument seems wrong to me: if there's an insert vma,
> that's because split_vma is dividing an existing area into two, we've
> just lowered vm_end on the first half, so if __flush_dcache_page comes
> between that unlock and the lock in __insert_vm_struct's __vma_link_file,
> then pages in the second half will be temporarily invisible to it.
> Which is presumably not good for the data integrity flush_dcach_page
> is striving to preserve.
>
> So I ought to do something about that one too.
>
> I won't rush through a patch for these, neither is likely to strike
> (and it's only a month or so since we realized that flush_dcache_page
> has been operating on the i_mmap list for how long without any locking
> at all), just add them to my list for now.  But good points, thank you.
>
> Hugh
>
>
