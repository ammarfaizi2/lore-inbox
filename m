Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbUCZL7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbUCZL5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:57:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50224 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264020AbUCZL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:57:25 -0500
Date: Fri, 26 Mar 2004 11:57:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
In-Reply-To: <20040325214529.GJ20019@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403261107100.16019-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Andrea Arcangeli wrote:
> On Wed, Mar 03, 2004 at 08:09:33AM +0100, Andrea Arcangeli wrote:
> > --- sles-objrmap/mm/mmap.c.~1~	2004-03-03 06:45:38.980596736 +0100
> > +++ sles-objrmap/mm/mmap.c	2004-03-03 06:53:46.945414808 +0100
> > @@ -1284,8 +1284,8 @@ int do_munmap(struct mm_struct *mm, unsi
> >  	/*
> >  	 * Remove the vma's, and unmap the actual pages
> >  	 */
> > -	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
> >  	spin_lock(&mm->page_table_lock);
> > +	detach_vmas_to_be_unmapped(mm, mpnt, prev, end);
> >  	unmap_region(mm, mpnt, prev, start, end);
> >  	spin_unlock(&mm->page_table_lock);
> >  
> > --- sles-objrmap/mm/swapfile.c.~1~	2004-03-03 06:45:39.023590200 +0100
> > +++ sles-objrmap/mm/swapfile.c	2004-03-03 07:03:33.128301464 +0100
> > @@ -499,7 +499,6 @@ static int unuse_process(struct mm_struc
> >  	/*
> >  	 * Go through process' page directory.
> >  	 */
> > -	down_read(&mm->mmap_sem);
> >  	spin_lock(&mm->page_table_lock);
> >  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> >  		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
> > @@ -507,7 +506,6 @@ static int unuse_process(struct mm_struc
> >  			break;
> >  	}
> >  	spin_unlock(&mm->page_table_lock);
> > -	up_read(&mm->mmap_sem);
> >  	pte_chain_free(pte_chain);
> >  	return 0;
> >  }
> 
> Martin, I just found I was wrong about the above, I would been right in
> the 2.4 VM, but in 2.6 the above is not needed. So you can delete the
> above part from your tree too. it seems 2.6 really splitted the
> page_table_lock from the mmap_sem and the only way to touch vmas is to
> get the mmap_sem, the page_table_lock is unrelated to the vmas. This
> wasn't the case in 2.4 where readers were allowed to take the
> page_table_lock only.

Yes you were wrong, but no you're not right ;)
Leaving 2.4 out of it, taking it tree by tree:

Linus' 2.6.5-rc2: rmap.c's try_to_unmap_one uses find_vma under
protection of page_table_lock alone, swapfile.c's unuse_process
walks mm->mmap vma list under protection of page_table_lock alone
(other cases of interest? I've not looked further), mmap.c uses
page_table_lock to protect vma list manipulations, mmap_sem also.

Andrew's 2.6.5-rc2-mm3: as Linus.

Martin's 2.6.4-mjb1: unsafe: try_to_unmap_one (only used for anon
in this tree) and unuse_process rely on page_table_lock as in Linus,
but page_table_lock has been removed from some of the vma manipulation
in mmap.c e.g. vma_merge does __vma_unlink without page_table_lock.
Previous -mjb safer in unuse_process (using mmap_sem), unsafer in
detach_vmas_to_be_unmapped (no page_table_lock held).

Andrea's 2.6.5-rc2-aa4 (anon_vma): based on Martin's, but very
likely safe since it does not use find_vma at all in swapout, and
unuse_process downs mmap_sem as Martin's used to before.

Hugh's anobjrmap patches: as Linus (I left out -mjb mmap.c mods).

I believe that Martin should revert all the mmap.c page_table_lock
diffs from Linus in his tree (instead of reverting the patches you
show above), but that you Andrea can probably keep them with yours
(I've not reviewed enough to be sure).

(And of course, perhaps later on Martin will merge yours into
his and do one thing, or merge mine into his and do another.)

Hugh

