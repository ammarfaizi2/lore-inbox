Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUKNJBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUKNJBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUKNJBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:01:16 -0500
Received: from mail.shareable.org ([81.29.64.88]:33154 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261264AbUKNJAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:00:50 -0500
Date: Sun, 14 Nov 2004 09:00:23 +0000
From: Emergency Services Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       bert hubert <ahu@ds9a.nl>
Subject: Futex queue_me/get_user ordering (was: 2.6.10-rc1-mm5 [u])
Message-ID: <20041114090023.GA478@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113164048.2f31a8dd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jamie, if you're around: help!

Revert the patch which moves queue_me(); it's buggy.  It is a bug to
move queue_me() after get_user().

It fully explains the blocking threads in Apache and Evolution.

Even if it worked, the patch wouldn't have saved any time, as it's a
rare condition if the caller is using futex properly.

The patch below provides an explanation; I'd appreciate it being
applied.

    ---

>  - According to man of futex:
>      "If the futex was not equal to the expected value, the operation
>       returns -EWOULDBLOCK."
>    but now, here is no description about the rare case:
>      "returns 0 if the futex was not equal to the expected value, but
>       the process was woken by a FUTEX_WAKE call."
>    this behavior on rare case causes the hang which I found.

This case can occur, by design.

Bert, are you still updating the futex man pages?  (Or is anyone else?)

If you are, then:

The patch below might provide some text for use in the manual, but
even if you can't easily explain why, the possibility of FUTEX_WAIT
returning 0 and counting as a wakeup when the memory word doesn't
equal val should be mentioned.

I'd appreciate being added to the authors list while you're there,
thanks :)

I think the man page would be a little clearer if the various E
conditions (ETIMEDOUT etc.) were listed in the errors section (even
though they aren't errors).  Think about consitency with other man
pages which list EINTR and EAGAIN there.  Also, it would be consistent
to say EAGAIN instead of EWOULDBLOCK (they're synonyms in Linux
anyway, but other man pages use EAGAIN as it's the modern name for it).

The phrase "(or other spurious error)" should be removed as it's
actually a kernel bug (but not serious) for that to occur, and
no different to EINTR from other syscalls in that respect.

In the section for FUTEX_WAIT behaviour, you might explain what
"atomically verifies .. and sleeps awaiting FUTEX_WAKE" really means,
perhaps removing the word atomic.  It's not really
atomic-test-conditional-sleep, it's just carefully ordered.  (Though
it's equivalent to atomic-sleep-test followed by conditional-wake).

The difference is precisely that it may return 0 and count as a wakeup
even when the memory word doesn't match prior to the
effectively-atomic region.

    ---

Hidetoshi Seto's example (at the FTP URL with the patch) calls
pthread_cond_signal without mentioning a mutex.  That's the wrong way
to use pthread_cond_signal, as explained in the Glibc documentation.

Note that moving queue_me() after get_user() in futex_wake() does NOT
fix Hidetoshi's observed problem.

Just think about the same 4 threads in "[simulation]", but scheduled
in a slightly different sequence.  Especially, look at splitting up
the sequence _beteen_ get_user() and queue_me(), and _between_ "wake++
and updated futex val" and "FUTEX_WAKE: no one is in waitqueue / A is
in waitqueue".

The basic logical reason why Hidetoshi's patch doesn't fix anything is
that if the get_user() test is done before queue_me() in the kernel,
that is *exactly the same* as if userspace does the word test itself
just before calling FUTEX_WAIT and FUTEX_WAIT doesn't do any test at all.

In Hidetoshi's pseudo-code, the bug is in pthread_cond_signal: it
should test the return value of FUTEX_WAKE and increment the wake
variable conditionally, not unconditionally as it does.  Fix that, and
subsequent signals will wake B.  The reason B is not woken initially
is because mutexes aren't used.  These aren't futex bugs.

    ---

You're right about the double-down_read() problem - I hadn't realised
that could deadlock.  That will require a per-task flag to make the
fault handler not take the semaphore when the fault occurs in these
places.  But that's a separate bug, not addressed here.

    ---

That ->nqueued loop in FUTEX_CMP_REQUEUE is able to return -EAGAIN
even when the memory word does equal the argument - that's quite ugly.

That and the smp_mb() section look dubious.  They're a workaround to
simulate doing something inside the spinlocks, but that is different
to the ordering properties that FUTEX_WAIT offers.

I mention this because it's nearly the same problem as prompted this
patch: that FUTEX_WAIT isn't as atomic as some people think it is, and
most importantly, making it more atomic (by using the spinlocks) does
not fix design problems in the caller.

That suggests to me that the callers of FUTEX_CMP_REQUEUE, if they
depend on that ->nqueued / smb_mb() loop, then they may have a race
which will cause problems.  If they don't depend on it, then it
shouldn't be there.

In fact that whole primitive does not look very conceptually
convincing.  Some kind of requeue-and-test primtive makes sense, but
conceptually, it would make sense to be testing *uaddr2 at the same
time, but it doesn't.

    ---

Signed-off-by: Jamie Lokier <jamie@shareable.org>

Explain why futex waiters must queue the current thread before testing
the memory word, not after.  Consequently, futex_wait() can return 0
and count as a wakeup even if the memory word doesn't match the
value at the start of the syscall.

c.orig	2004-11-03 04:04:50.000000000 +0000
+++ linux-2.6.9/kernel/futex.c	2004-11-14 08:58:27.067607610 +0000
@@ -6,7 +6,7 @@
  *  (C) Copyright 2003 Red Hat Inc, All Rights Reserved
  *
  *  Removed page pinning, fix privately mapped COW pages and other cleanups
- *  (C) Copyright 2003 Jamie Lokier
+ *  (C) Copyright 2003, 2004 Jamie Lokier
  *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
@@ -489,9 +489,24 @@
 	queue_me(&q, -1, NULL);
 
 	/*
-	 * Access the page after the futex is queued.
+	 * Access the page AFTER the futex is queued.
+	 * Order is important:
+	 *
+	 *   Userspace waiter: val = var; if (cond(val)) futex_wait(&var, val);
+	 *   Userspace waker:  if (cond(var)) { var = new; futex_wake(&var); }
+	 *
+	 * The basic logical guarantee of a futex is that it blocks ONLY
+	 * if cond(var) is known to be true at the time of blocking, for
+	 * any cond.  If we queued after testing *uaddr, that would open
+	 * a race condition where we could block indefinitely with
+	 * cond(var) false, which would violate the guarantee.
+	 *
+	 * A consequence is that futex_wait() can return zero and absorb
+	 * a wakeup when *uaddr != val on entry to the syscall.  This is
+	 * rare, but normal.
+	 *
 	 * We hold the mmap semaphore, so the mapping cannot have changed
-	 * since we looked it up.
+	 * since we looked it up in get_futex_key.
 	 */
 	if (get_user(curval, (int __user *)uaddr) != 0) {
 		ret = -EFAULT;
