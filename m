Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273779AbRIRACO>; Mon, 17 Sep 2001 20:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273781AbRIRACF>; Mon, 17 Sep 2001 20:02:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24434 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273779AbRIRAB5>; Mon, 17 Sep 2001 20:01:57 -0400
Date: Tue, 18 Sep 2001 02:01:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dhowells@redhat.com, Ulrich.Weigand@de.ibm.com, manfred@colorfullife.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010918020139.B698@athlon.random>
In-Reply-To: <001701c13fc2$cda19a90$010411ac@local> <200109172339.f8HNd5W13244@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109172339.f8HNd5W13244@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Sep 17, 2001 at 04:39:05PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 04:39:05PM -0700, Linus Torvalds wrote:
> [ David, Andrea - can you check this out? ]
> 
> In article <001701c13fc2$cda19a90$010411ac@local>,
> Manfred Spraul <manfred@colorfullife.com> wrote:
> >> What happens is that proc_pid_read_maps grabs the mmap_sem as a
> >> reader, and *while it holds the lock*, does a copy_to_user.  This can
> >> of course page-fault, and the handler will also grab the mmap_sem
> >> (if it is the same task).
> >
> >Ok, that's a bug.
> >You must not call copy_to_user with the mmap semaphore acquired - linux
> >semaphores are not recursive.
> 
> No, that's not the bug.

agreed.

> The mmap semaphore is a read-write semaphore, and it _is_ permissible to
> call "copy_to_user()" and friends while holding the read lock.
> 
> The bug appears to be in the implementation of the write semaphore -
> down_write() doesn't undestand that blocked writes must not block new
> readers, exactly because of this situation. 

Exactly, same reason for which we need the same property from the rw
spinlocks (to be allowed to read_lock without clearing irqs). Thanks so
much for reminding me about this! Unfortunately my rwsemaphores are
blocking readers at the first down_write (for the better fairness
property issuse, but I obviously forgotten that doing so I would
introduce such a deadlock). The fix is a few liner for my
implementation, here it is:

--- 2.4.10pre10aa2/lib/rwsem_spinlock.c.~1~	Mon Sep 17 19:17:24 2001
+++ 2.4.10pre10aa2/lib/rwsem_spinlock.c	Tue Sep 18 01:59:06 2001
@@ -73,11 +73,13 @@
 
 void down_read(struct rw_semaphore *sem)
 {
+	int count;
 	CHECK_MAGIC(sem->__magic);
 
 	spin_lock(&sem->lock);
+	count = sem->count;
 	sem->count += RWSEM_READ_BIAS;
-	if (__builtin_expect(sem->count, 0) < 0)
+	if (__builtin_expect(count < 0 && !(count & RWSEM_READ_MASK), 0))
 		rwsem_down_failed(sem, RWSEM_READ_BLOCKING_BIAS);
 	spin_unlock(&sem->lock);
 }

it will be applied to next -aa. For the mainline semaphores I assume
David will take care of that.

For the record, I'm using spinlock based rwsemphores. Last time I
checked my asm semaphores I found a small race in up_write, I didn't
checked if the mainlines semaphores were affected too but I just
preferred to stay safe with the spinlock in the meantime (in the
microbenchmark the spinlock based rwsems weren't that much slower
[and my optimized version is much faster than the mainline spinlock
based rwsem] so using asm it's not a noticeable improvement in the macro
real life benchmarks and the robustness of the spinlock is quite
unvaluable, even more now that allowed me to do a bugfix without
panicing in doing those changes).  I think I will return to the asm
rwsem only after proofing my implementation with math or after writing
an automated simulation that checks their correctness in all possible
race combinations (assuming they're mutex and with a variable number of
threads).

Andrea
