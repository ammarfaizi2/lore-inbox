Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRGLWzK>; Thu, 12 Jul 2001 18:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266416AbRGLWzB>; Thu, 12 Jul 2001 18:55:01 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20035 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261173AbRGLWyx>; Thu, 12 Jul 2001 18:54:53 -0400
Date: Fri, 13 Jul 2001 00:55:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: lvm-devel@sistina.com, Andi Kleen <ak@suse.de>,
        Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010713005501.J19011@athlon.random>
In-Reply-To: <20010712114512.J779@athlon.random> <200107121704.f6CH4d6j027383@webber.adilger.int> <20010712201819.C19011@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010712201819.C19011@athlon.random>; from andrea@suse.de on Thu, Jul 12, 2001 at 08:18:19PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 08:18:19PM +0200, Andrea Arcangeli wrote:
> On Thu, Jul 12, 2001 at 11:04:39AM -0600, Andreas Dilger wrote:
> > Note that your current patch is broken by the use of rwsems, because
> > _pe_lock also protects the _pe_requests list, which you modify under
> > up_read() (you can't upgrade a read lock to a write lock, AFAIK), so
> > you always need a write lock whenever you get _pe_lock.  With my changes
> > there will be very little contention on _pe_lock, as it is off the fast
> > path and only held for a few asm instructions at a time.
> 
> Yes, there's a race condition when people moves PV around, thanks for
> noticing it.

While merging your patch that was supposed to fix the "race" in my
patch, I had a closer look and the whole design behind _pe_lock thing
seems totally broken and it can race since the first place.

With the current design of the pe_lock_req logic when you return from
the ioctl(PE_LOCK) syscall, you never have the guarantee that all the
in-flight writes are commited to disk, the
fsync_dev(pe_lock_req.data.lv_dev) is just worthless, there's an huge
race window between the fsync_dev and the pe_lock_req.lock = LOCK_PE
where whatever I/O can be started without you fiding it later in the
_pe_request list. Even despite of that window we don't even wait the
requests running just after the lock test to complete, the only lock we
have is in lvm_map, but we should really track which of those bh are
been committed successfully to the platter before we can actually copy
the pv under the lvm from userspace.

If the logic would been sane, your patch would also been ok
(besides the C breakage of the missing volatile but we abuse gcc this
way in other parts of the kernel too after all).

Your patch just makes much more obvious how the logic cannot be correct,
since you just do a plain lockless cmpl on a word in a fast path and the
other end (pe_lock()) will never know what's going on with such request
any longer.

Of course the removal of the below crap in your patch was fine too:

-               pe_lock_req = new_lock;
-
-               down(&_pe_lock);
-               pe_lock_req.lock = UNLOCK_PE;
-               up(&_pe_lock);
-

the write of pe_lock_req without a down() was an additional race
condition too per se, the lvm_map side in beta7 is reading uncoherent
informations caming from such unlocked copy.

So in short nobody should ever had moved PV around with lvm beta7 with
writes going on since the first place due various races in beta7.

I think the whole pv_move logic needs to be redesigned and rewritten, if
you could rewrite it and send patches (possibly also against beta7 if
a new lvm release is not scheduled shortly) that would be more than
welcome! At the moment those pv_move races are lower priority for me (I
think it's not a showstopper even if the user is required to stop the db
a few seconds while moving PV around to upgrading its hardware), the lvm
2.4 slowdown during production usage was a showstopper instead but the
slowdown should be just fixed and that was the first prio.

Maybe I'm missing something. Comments?

Andrea
