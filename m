Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272774AbRIRIR7>; Tue, 18 Sep 2001 04:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272785AbRIRIRt>; Tue, 18 Sep 2001 04:17:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:31480 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272774AbRIRIRo>; Tue, 18 Sep 2001 04:17:44 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dhowells@redhat.com,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Tue, 18 Sep 2001 09:55:49 +0200." <20010918095549.T698@athlon.random> 
Date: Tue, 18 Sep 2001 09:18:00 +0100
Message-ID: <4182.1000801080@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > i386 has a fair rwsemaphore, too - probably other archs must be modified
> > as well.
> 
> yes, actually my patch was against the rwsem patch in -aa, and in -aa
> I'm using the generic semaphores for all archs in the tree so it fixes
> the race for all them. The mainline semaphores are slightly different.

Wasn't there a problem with unfair rw-semaphores? I can't remember exactly
now...

> > IMHO modifying proc_pid_read_maps() is far simpler - I'm not aware of
> > another recursive mmap_sem user.
> 
> if that's the very only place that could be a viable option but OTOH I
> like to be allowed to use recursion on the read locks as with the
> spinlocks. I think another option would be to have reacursion allowed on
> the default read locks and then make a down_read_fair that will block at
> if there's a down_write under us. we can very cleanly implement this,
> the same can be done cleanly also for the spinlocks: read_lock_fair. One
> can even mix the read_lock/read_lock_fair or the
> down_read/down_read_fair together. For example assuming we use the
> recursive semaphore fix in proc_pid_read_maps the down_read over there
> could be converted to a down_read_fair (but that's just an exercise, if
> the page fault isn't fair it doesn't worth to have proc_pid_read_maps
> fair either).

If this were to be done, I'd prefer to keep down_read() as being fair and add
a down_read_unfair(). This'd have the least impact on the current behaviour,
and I suspect we actually want fairness most of the time.

Of course, I'd personally prefer to avoid recursive semaphore situations where
possible too... it sounds far too much like trouble waiting to happen, but we
can't have everything.

David
