Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUDODlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 23:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263707AbUDODlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 23:41:06 -0400
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:23980 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263671AbUDODlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 23:41:01 -0400
Date: Wed, 14 Apr 2004 23:40:52 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@sapphire.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <20040415000529.GX2150@dualathlon.random>
Message-ID: <Pine.GSO.4.58.0404142323160.21462@sapphire.engin.umich.edu>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain>
 <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu> <69200000.1081804458@flay>
 <Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu>
 <20040415000529.GX2150@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >   2) However, vmas can be added and removed from a vm_set list
> >      by just holding the read lock and a bit lock (vm_set_lock)
> >      in the corresponding prio_tree node.
>
> no way, you cannot bitflip vm_flags unless you own the mmap_sem, this
> patch seems very broken to me, it should randomly corrupt memory in
> vma->vm_flags while racing against mprotect etc.. or am I missing
> something?

I don't know why bit_spin_lock with vma->vm_flags should be a problem
if it is used without mmap_sem. Can you explain ?

Anyway, in my patch, the only places that use vm_set_lock without
mmap_sem is __vma_prio_tree_first_lock and __vma_prio_tree_next_lock.
If it is really racy to use bit_spin_lock on vm_flags without mmap_sem
(I am not sure and I am not convinced that it is racy), then we can
revert these changes and take down_write on the page out path.

Well. In that case, we can use rwsem as you mentioned below: take
down_write on all modifications and take down_read on pageout. Here, you
allow multiple parallel page_referenced and try_to_unmap on the same
inode, however with only one modification at a time.

Wherease my solution will allow multiple modifications at the same
time (if possible) with only one pageout routine at a time. I chose
this solution because Martin's SDET took big hit in common cases of
adding and removing vmas from the i_mmap{_shared} data structure.

Thanks,
Rajesh

>
> >   3) All objrmap functions just hold read lock now. So when we
> >      walk a vm_set list we have to hold the corresponding
> >      vm_set_lock.
> >   4) Since truncate uses write lock (provides exclusion) we don't
> >      have to take vm_set_locks.
> >
> > Martin! When you get time to test your SDET with this patch, please
> > let me know whether this patch helps you at all. The patch applies
> > on top of 2.6.5-mjb1+anobjrmap9_prio_tree.
>
> I considered converting it to a rwsem too, details are in the the email
> I posted while providing the rwspinlock solution to the parisc cache
> flushing code.
>
> As I wrote there, I wasn't convinced in the common case this is going to
> gain anything significant (the only thing that sleeps while teh
> semaphore is held is truncate and truncate during paging on the same
> inode isn't an extremly common case, especially for the big apps), and
> it makes it a bit more complicated, but giving it a try will be
> interesting. I was mostly interested about having the objrmap code very
> rarely failing the trylock during paging (that semaphore is by far the
> biggest scalability hit during paging of shm, but the cacheline bouncing
> won't be avoided by the rwsem). To make the paging scale better
> (something SDET cannot measure) I don't need a safe vm_set_lock, I
> believe simply making it a rwsem is the way to go just to make the
> paging potentially scale a bit better. I rated implementing the locking
> abstraction to fixup the basic parisc race as a bit higher prio, after
> that it should be easy to have it implementing a rwsem for all archs w/o
> cache flushing, the abstraction will have to expose a read/write
> functionality for the rwlock. I'm not convinced your double locking is
> going to boost anything even if it would be safe, I'd just take it in
> write mode when the tree is being modified, with the only object of
> avoiding the paging to block (and potentially to avoid blocking against
> big truncates too).
>
