Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266493AbRGLSSm>; Thu, 12 Jul 2001 14:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266496AbRGLSSb>; Thu, 12 Jul 2001 14:18:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27178 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266493AbRGLSSV>; Thu, 12 Jul 2001 14:18:21 -0400
Date: Thu, 12 Jul 2001 20:18:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: lvm-devel@sistina.com, Andi Kleen <ak@suse.de>,
        Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010712201819.C19011@athlon.random>
In-Reply-To: <20010712114512.J779@athlon.random> <200107121704.f6CH4d6j027383@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107121704.f6CH4d6j027383@webber.adilger.int>; from adilger@turbolinux.com on Thu, Jul 12, 2001 at 11:04:39AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 11:04:39AM -0600, Andreas Dilger wrote:
> Andrea writes:
> > > Wouldn't a single semaphore be enough BTW to cover both? 
> > 
> > Actually the _pe_lock is global and it's hold for a short time so it
> > can make some sense. And if you look closely you'll see that _pe_lock
> > should _definitely_ be a rw_spinlock not a rw_semaphore. I didn't
> > changed that though just to keep the patch smaller and to avoid changing
> > the semantics of the lock, the only thing that matters for us is to
> > never block and to have a fast read fast path which is provided just
> > fine by the rwsem (i'll left the s/sem/spinlock/ to the CVS).
> 
> Actually, I have already fixed the _pe_lock problem in LVM CVS, so that
> it is not acquired on the fast path.  The cases where a PV is being moved

ok, btw if you care to write correct C code you should also declare
.lock as volatile or gcc has the rights to miscompile your code.

> is very rare and only affects the write path, so I check rw == WRITE
> and pe_lock_req.lock == LOCK_PE, before getting _pe_lock and re-checking
> pe_lock_req.lock.  This does not affect the semantics of the operation.
> 
> Note also that the current kernel LVM code holds the _pe_lock for the
> entire time it is flushing write requests from the queue, when it does
> not need to do so.  My changes (also in LVM CVS) fix this as well.
> I have attached the patch which should take beta7 to current CVS in
> this regard.  Please take a look.

Ok, I will thanks.

> Note that your current patch is broken by the use of rwsems, because
> _pe_lock also protects the _pe_requests list, which you modify under
> up_read() (you can't upgrade a read lock to a write lock, AFAIK), so
> you always need a write lock whenever you get _pe_lock.  With my changes
> there will be very little contention on _pe_lock, as it is off the fast
> path and only held for a few asm instructions at a time.

Yes, there's a race condition when people moves PV around, thanks for
noticing it.

> It is also a good thing that you fixed up lv_snapshot_sem, which was
> also on the fast path, but at least that was a per-LV semaphore, unlike
> _pe_lock which was global.  But I don't think you can complain about it,
> because I think you were the one that added it ;-).

Definitely wrong, I added it only to the snapshot case, it wasn't
definitely in the fast path hitten by Oracle. Somebody (not me) moved it
into the main fast path of lvm, and as said in the earlier email when I
found it used that way I was scared as soon as I seen it.  Incidentally
infact it is still called lv_snapshot_sem because it wasn't renamed yet.

Go back into the old releases (or back to 2.2) and you will see where I
put the lv_snapshot_sem.

So definitely don't complain at me if the lv_snapshot_sem was hurting
the fast path.

> Note, how does this all apply to 2.2 kernels?  I don't think rwsems
> existed then, nor rwspinlocks, did they?

2.2 have no semaphores in the fast path so this doesn't apply to 2.2 at
all (it may have race conditions though). 2.2 only had the
lv_snapshot_sem in the snapshot I/O code, which is the one I added to
fix the race conditions, but it wasn't at all related to the fast path
hitten by Oracle as said above.

Andrea
