Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUDOAFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDOAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:05:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35308
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261976AbUDOAFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:05:25 -0400
Date: Thu, 15 Apr 2004 02:05:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <20040415000529.GX2150@dualathlon.random>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain> <Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu> <69200000.1081804458@flay> <Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 04:18:38PM -0400, Rajesh Venkatasubramanian wrote:
> 
> This patch is another attempt at reducing the contention on i_shared_sem.
> The patch converts i_shared_sem from normal semaphore to read-write
> semaphore. The locking rules used are:
> 
>   1) A prio_tree cannot be modified without holding write lock.
>   2) However, vmas can be added and removed from a vm_set list
>      by just holding the read lock and a bit lock (vm_set_lock)
>      in the corresponding prio_tree node.

no way, you cannot bitflip vm_flags unless you own the mmap_sem, this
patch seems very broken to me, it should randomly corrupt memory in
vma->vm_flags while racing against mprotect etc.. or am I missing
something?

>   3) All objrmap functions just hold read lock now. So when we
>      walk a vm_set list we have to hold the corresponding
>      vm_set_lock.
>   4) Since truncate uses write lock (provides exclusion) we don't
>      have to take vm_set_locks.
> 
> Martin! When you get time to test your SDET with this patch, please
> let me know whether this patch helps you at all. The patch applies
> on top of 2.6.5-mjb1+anobjrmap9_prio_tree.

I considered converting it to a rwsem too, details are in the the email
I posted while providing the rwspinlock solution to the parisc cache
flushing code.

As I wrote there, I wasn't convinced in the common case this is going to
gain anything significant (the only thing that sleeps while teh
semaphore is held is truncate and truncate during paging on the same
inode isn't an extremly common case, especially for the big apps), and
it makes it a bit more complicated, but giving it a try will be
interesting. I was mostly interested about having the objrmap code very
rarely failing the trylock during paging (that semaphore is by far the
biggest scalability hit during paging of shm, but the cacheline bouncing
won't be avoided by the rwsem). To make the paging scale better
(something SDET cannot measure) I don't need a safe vm_set_lock, I
believe simply making it a rwsem is the way to go just to make the
paging potentially scale a bit better. I rated implementing the locking
abstraction to fixup the basic parisc race as a bit higher prio, after
that it should be easy to have it implementing a rwsem for all archs w/o
cache flushing, the abstraction will have to expose a read/write
functionality for the rwlock. I'm not convinced your double locking is
going to boost anything even if it would be safe, I'd just take it in
write mode when the tree is being modified, with the only object of
avoiding the paging to block (and potentially to avoid blocking against
big truncates too).
