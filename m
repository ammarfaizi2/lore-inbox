Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUHWX3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUHWX3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUHWX1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:27:34 -0400
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:41106 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S268387AbUHWX0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:26:11 -0400
Date: Mon, 23 Aug 2004 19:25:38 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: Christoph Lameter <christoph@lameter.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>, "David S. Miller" <davem@redhat.com>,
       raybry@sgi.com, ak@muc.de, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for
 8,32     and    512 cpu SMP
In-Reply-To: <Pine.LNX.4.58.0408231456150.17943@server.home>
Message-ID: <Pine.GSO.4.58.0408231916330.21483@sapphire.engin.umich.edu>
References: <2uexw-1Nn-1@gated-at.bofh.it> <2uCTq-2wa-55@gated-at.bofh.it>
 <pan.2004.08.18.23.50.13.562750@umich.edu> <20040819000151.GU11200@holomorphy.com>
 <Pine.GSO.4.58.0408182005080.9340@sapphire.engin.umich.edu>
 <20040819002038.GW11200@holomorphy.com> <Pine.LNX.4.58.0408231456150.17943@server.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Aug 2004, Christoph Lameter wrote:

> Would it not be better if exit_mmap would hold a writelock on
> mm->mmap_sem and the page_table_lock? This would insure that page faults
> would not change pte's. exit_mmap changes the memory map so it seems that
> the wrong lock is used here.

exit_mmap() is only called from kernel/fork.c/mmput(). We call exit_mmap()
only if (atomic_dec_and_lock(&mm->mm_users, &mmlist_lock)).

So there are no other active thread (mm_user) other than the current
exit_mmap() thread. This gives thread exclusion. So we don't need
mm->mmap_sem.

However, we have to lock out truncate()->zap_pmd_range(), rmap.c
functions, and other places from walking the page tables while we
are freeing the page tables in exit_mmap(). The page_table_lock in
exit_mmap() provides that exclusion.

That's my understanding. Correct me if I am wrong.

Thanks,
Rajesh

> On Wed, 18 Aug 2004, William Lee Irwin III wrote:
>
> > On Wed, 18 Aug 2004, William Lee Irwin III wrote:
> > >> exit_mmap() has removed the vma from ->i_mmap and ->mmap prior to
> > >> unmapping the pages, so this should be safe unless that operation
> > >> can be caught while it's in progress.
> >
> > On Wed, Aug 18, 2004 at 08:07:24PM -0400, Rajesh Venkatasubramanian wrote:
> > > No. Unfortunately exit_mmap() removes vmas from ->i_mmap after removing
> > > page table pages. Maybe we can reverse this, though.
> >
> > Something like this?
> >
> >
> > Index: mm1-2.6.8.1/mm/mmap.c
> > ===================================================================
> > --- mm1-2.6.8.1.orig/mm/mmap.c	2004-08-16 23:47:16.000000000 -0700
> > +++ mm1-2.6.8.1/mm/mmap.c	2004-08-18 17:18:26.513559632 -0700
> > @@ -1810,6 +1810,14 @@
> >  	mm->map_count -= unmap_vmas(&tlb, mm, mm->mmap, 0,
> >  					~0UL, &nr_accounted, NULL);
> >  	vm_unacct_memory(nr_accounted);
> > +	/*
> > +	 * Walk the list again, actually closing and freeing it.
> > +	 */
> > +	while (vma) {
> > +		struct vm_area_struct *next = vma->vm_next;
> > +		remove_vm_struct(vma);
> > +		vma = next;
> > +	}
> >  	BUG_ON(mm->map_count);	/* This is just debugging */
> >  	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
> >  	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
> > @@ -1822,16 +1830,6 @@
> >  	mm->locked_vm = 0;
> >
> >  	spin_unlock(&mm->page_table_lock);
> > -
> > -	/*
> > -	 * Walk the list again, actually closing and freeing it
> > -	 * without holding any MM locks.
> > -	 */
> > -	while (vma) {
> > -		struct vm_area_struct *next = vma->vm_next;
> > -		remove_vm_struct(vma);
> > -		vma = next;
> > -	}
> >  }
> >
> >  /* Insert vm structure into process list sorted by address
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
