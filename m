Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272764AbRIRHzw>; Tue, 18 Sep 2001 03:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272774AbRIRHzn>; Tue, 18 Sep 2001 03:55:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23891 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272764AbRIRHze>; Tue, 18 Sep 2001 03:55:34 -0400
Date: Tue, 18 Sep 2001 09:55:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, dhowells@redhat.com,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010918095549.T698@athlon.random>
In-Reply-To: <001701c13fc2$cda19a90$010411ac@local> <200109172339.f8HNd5W13244@penguin.transmeta.com> <20010918020139.B698@athlon.random> <000901c14014$494f9380$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c14014$494f9380$010411ac@local>; from manfred@colorfullife.com on Tue, Sep 18, 2001 at 09:31:40AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 09:31:40AM +0200, Manfred Spraul wrote:
> From: "Andrea Arcangeli" <andrea@suse.de>
> > > The mmap semaphore is a read-write semaphore, and it _is_
> permissible to
> > > call "copy_to_user()" and friends while holding the read lock.
> > >
> > > The bug appears to be in the implementation of the write semaphore -
> > > down_write() doesn't undestand that blocked writes must not block
> new
> > > readers, exactly because of this situation.
> >
> > Exactly, same reason for which we need the same property from the rw
> > spinlocks (to be allowed to read_lock without clearing irqs). Thanks
> so
> > much for reminding me about this! Unfortunately my rwsemaphores are
> > blocking readers at the first down_write (for the better fairness
> > property issuse, but I obviously forgotten that doing so I would
> > introduce such a deadlock).
> 
> i386 has a fair rwsemaphore, too - probably other archs must be modified
> as well.

yes, actually my patch was against the rwsem patch in -aa, and in -aa
I'm using the generic semaphores for all archs in the tree so it fixes
the race for all them. The mainline semaphores are slightly different.

> > The fix is a few liner for my
> > implementation, here it is:
> >
> 
> Obivously your patch fixes the race, but we could starve down_write() if
> there are many page faults.

Yes.

> IMHO modifying proc_pid_read_maps() is far simpler - I'm not aware of
> another recursive mmap_sem user.

if that's the very only place that could be a viable option but OTOH I
like to be allowed to use recursion on the read locks as with the
spinlocks. I think another option would be to have reacursion allowed on
the default read locks and then make a down_read_fair that will block at
if there's a down_write under us. we can very cleanly implement this,
the same can be done cleanly also for the spinlocks: read_lock_fair. One
can even mix the read_lock/read_lock_fair or the
down_read/down_read_fair together. For example assuming we use the
recursive semaphore fix in proc_pid_read_maps the down_read over there
could be converted to a down_read_fair (but that's just an exercise, if
the page fault isn't fair it doesn't worth to have proc_pid_read_maps
fair either).

Andrea
