Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265072AbUETPfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265072AbUETPfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 11:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUETPfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 11:35:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:34098 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265072AbUETPff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 11:35:35 -0400
Date: Thu, 20 May 2004 16:35:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 36 mprotect use vma_merge
In-Reply-To: <Pine.LNX.4.58.0405191515050.16860@rust.engin.umich.edu>
Message-ID: <Pine.LNX.4.44.0405201538220.9220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

Thanks a lot for looking at the patch,
and for forcing me to think these bits through again.

On Wed, 19 May 2004, Rajesh Venkatasubramanian wrote:
> A couple of small clarifications.
> 
> >  void vma_adjust(struct vm_area_struct *vma, unsigned long start,
> > -	unsigned long end, pgoff_t pgoff, struct vm_area_struct *next)
> > +	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
> [snip]
> > +	long adjust_next = 0;
> > +	int remove_next = 0;
> > +
> > +	if (next && !insert) {
> [snip]
> > +			BUG_ON(vma->vm_end != next->vm_start);
> > +			adjust_next = end - next->vm_start;
> > +		}
> > +	}
> 
> Can adjust_next overflow?  No? I think making adjust_next in
> PAGE_SIZE units will avoid overflow concerns.

I think I misunderstood you at first.  You're suggesting that, say,
next->vm_pgoff might be 0 and next->vm_start 0.4GB and end 2.6GB,
then next->vm_pgoff would get adjusted to -1.8GB >> PAGE_SHIFT, a
negative number, when it should be 2.2GB >> PAGE_SHIFT, positive.

Yes, you're right, I should recode that more carefully, thanks.

(Other overflows would be vma_merge's responsibility to prohibit
merging; though they don't occur because, as my old "16TB" comment
observes, do_mmap_pgoff doesn't allow the pgoff -1UL to be mapped.
Though I think you were careful to avoid any such restriction in
your prio_tree work, so I guess we might change that one day, and
then need to be a little more careful in the can_vma_merges.)

> [snip]
> >  	if (root) {
> > +		if (adjust_next) {
> > +			vma_prio_tree_init(next);
> > +			vma_prio_tree_insert(next, root);
> > +		}
> >  		vma_prio_tree_init(vma);
> >  		vma_prio_tree_insert(vma, root);
> >  		flush_dcache_mmap_unlock(mapping);
> >  	}
> 
> I think this flush_dcache_mmap_unlock should go down - after
> __insert_vm_struct call - just before page_table_lock unlock.

Well, you observed later that the intervening calls take that lock
internally, so we have to unlock there.

But you're obviously right that it would seem better to be able to
flush_dcache_mmap_unlock lower down when it's all over, to keep
changes atomic as much as possible.

And you're seriously right.  I was preparing a little lecture on
how flush_dcache_mmap_lock is only a very low level lock to prevent
the tree from getting rearranged while arm and parisc are searching
it for the __flush_dcache page, so it only needs to be held across
the tree manipulations.

But now that argument seems wrong to me: if there's an insert vma,
that's because split_vma is dividing an existing area into two, we've
just lowered vm_end on the first half, so if __flush_dcache_page comes
between that unlock and the lock in __insert_vm_struct's __vma_link_file,
then pages in the second half will be temporarily invisible to it.
Which is presumably not good for the data integrity flush_dcach_page
is striving to preserve.

So I ought to do something about that one too.

I won't rush through a patch for these, neither is likely to strike
(and it's only a month or so since we realized that flush_dcache_page
has been operating on the i_mmap list for how long without any locking
at all), just add them to my list for now.  But good points, thank you.

Hugh

