Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbUK2Vvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUK2Vvd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUK2Vvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:51:33 -0500
Received: from mail.shareable.org ([81.29.64.88]:7819 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261812AbUK2Vu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:50:57 -0500
Date: Mon, 29 Nov 2004 21:50:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, drepper@redhat.com
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041129215024.GB18791@mail.shareable.org>
References: <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041126170649.GA8188@mail.shareable.org> <20041129112426.GO10340@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129112426.GO10340@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> >       2. futex is 32 bits and can overflow.  If a waiter blocks, then
> >          a waker is called 2^32 times in succession before the waiter
> >          can schedule again, the waiter will remain blocked after the
> >          waker returns.
> > 
> >          This is unlikely, except where it's done deliberately
> >          (e.g. SIGSTOP/CONT), and it's a bug and it only needs two
> >          threads!  It could perhaps be used for denial of service.
> 
> The only problem with the 32-bit overflow is if you get scheduled
> away in between releasing the CV's internal lock, i.e.
> lll_mutex_unlock (cond->__data.__lock);
> and
>         if (get_user(curval, (int __user *)uaddr) != 0) {
> in kernel and don't get scheduled again for enough time to reach
> this place within 2^31 pthread_cond_{*wait,signal,broadcast} calls.

Yes.

> There are no things on the userland side that would block and
> in kernel the only place you can block is down_read on mm's mmap_sem
> (but if the writer lock is held that long, other pthread_cond_*
> calls couldn't get in either) or the short term spinlocks on the hash
> bucket.  SIGSTOP/SIGCONT affect the whole process, so unless you are
> talking about process shared condvars, these signals aren't going to help
> you in exploiting it.

I agree, it is a difficult exploit, and the only consequence is a
thread hangs.  I though it worth mentioning only because Ulrich brings
up a very similar 2^32 issue in "Futexes are tricky".

> But, once you get past that point, current NPTL doesn't care if 2^31 or
> more other cv calls happen, it uses the 64-bit vars to determine what to
> do and they are big enough that overflows on them are just assumed not to
> happen.  And only past that point the thread is blocked in longer-term
> waiting.

About those 64-bit vars: don't the invariants guarantee the following?

     total_seq - wakeup_seq < number of waiters

number of waiters is surely bounded by 2^31 (pid space), so 32-bit
vars would be enough for sure, and using wraparound-safe comparisons
(like time_after() in the kernel) would be strictly correct.

I'm just offering an optimisation here: less memory, smaller code.

> >       3. Why is futex incremented in pthread_cond_wait?
> >          I don't see the reason for it.

I figured this out in a dream at the same time as you were writing
this message!  Then I woke and thought "doh!".  Yes, it's pretty clear
you must increment futex if the broadcast unlocks before requeuing.

> See
> https://www.redhat.com/archives/phil-list/2004-May/msg00023.html
> https://www.redhat.com/archives/phil-list/2004-May/msg00022.html

Examples of problems due to broadcast unlocking before requeueing and
the necessary fixes.

> >       4. In pthread_cond_broadcast, why is the mutex_unlock(lock)
> >          dropped before calling FUTEX_CMP_REQUEUE?  Wouldn't it be
> >          better to drop the lock just after, in which case
> >          FUTEX_REQUEUE would be fine?
> > 
> >          pthread_cond_signal has no problem with holding the lock
> >          across FUTEX_WAKE, and I do not see any reason why that would
> >          be different for pthread_cond_broadcast.
> 
> Holding the internal lock over requeue kills performance of broadcast,
> if you hold the internal lock over the requeue, all the threads you
> wake up will block on the internal lock anyway.

Let's take a closer look.

Do you mean broadcast of process-shared condvars?

When a process-local broadcast requeues, it doesn't wake up lots of
threads; it wakes exactly one thread.  When a process-shared broadcast
requeues, it wakes every waiter (because it doesn't know the address
of the mutex).

First the process-local case.

There are potentially 2 redundant context switches when signalling, and
there would be potentially 2 when broadcasting process-local _if_ the
lock were released after the requeue:

    - switch to the thread just woken (#1 redundant switch)
    - it tries to get the mutex and fails
    - switch back to the signal/broadcast thread (#2 redundant switch)
    - signaller/broadcaster releases mutex
    - switch to the thread just woken (this is not redundant)

I thought this was what you meant, at first, and I wondered why spend
so much effort fixing it for broadcast and not for signal.  Surely
signal is as important.

Then I realised you might mean process-shared wakeups being slow
because broadcast cannot requeue in that case.

Still, the earlier thought revealed a neat solution to those 2
potential context switches that also fixes process-shared broadcast,
while retaining the lock over requeue.

This is worth a look because I think it may turn out to be faster for
the common process-local cases too - precisely because it prevents the
potential 2 context switches after pthread_cond_signal.  (Some
messages indicate that has been observed sometimes).

I'll explain with code.  There may be mistakes, but hopefully the
principle is conveyed.

Something to watch out for is that FUTEX_REQUEUE is used to requeue to
&lock _and_ &mutex->lock in this code.

      pthread_cond_signal (cond)
      {
        mutex_lock (lock);
        if (total_seq > wakeup_seq) {
-         ++wakeup_seq, ++futex;
-         futex (&futex, FUTEX_WAKE, 1);
+         ++futex;
+         if (futex (&futex, FUTEX_REQUEUE, 0, 1, &lock) > 0) {
+           ++wakeup_seq;
+           lock = WHATEVER_MAKES_UNLOCK_CALL_FUTEX_WAKE;
+         }
        }
        mutex_unlock (lock);
      }
      pthread_cond_broadcast (cond)
      {
        mutex_lock (lock);
        if (total_seq > wakeup_seq) {
-         woken_seq = wakeup_seq = total_seq;
-         futex = 2 * total_seq;
-         ++broadcast_seq;
-         val = futex;
-         mutex_unlock (lock);
-         if (process_shared || futex (&futex, FUTEX_CMP_REQUEUE, 1, INT_MAX,
-                                      &mutex->lock, val) < 0)
-           futex (&futex, FUTEX_WAKE, INT_MAX);
-         return;
+         count = total_seq - wakeup_seq;
+         ++futex;
+         if (process_shared) {
+           count = futex (&futex, FUTEX_REQUEUE, 0, count, &lock);
+           wakeup_seq += count;
+           if (count > 0)
+             lock = WHATEVER_MAKES_UNLOCK_CALL_FUTEX_WAKE;
+         } else if (futex (&futex, FUTEX_REQUEUE, 0, 1, &lock) > 0) {
+           count = futex (&futex, FUTEX_REQUEUE, 0, count - 1, &mutex->lock);
+           wakeup_seq += count + 1;
+           lock = WHATEVER_MAKES_UNLOCK_CALL_FUTEX_WAKE;
+         }
        }
        mutex_unlock (lock);
      }
      pthread_cond_wait (cond, mtx)
      {
        mutex_lock (lock);
        mutex_unlock (mtx->lock);
        ++total_seq;
-       ++futex;
        mutex = mtx;
        bc_seq = broadcast_seq;
        seq = wakeup_seq;
        do {
          val = futex;
          mutex_unlock (lock);
-         futex (&futex, FUTEX_WAIT, val);
-         mutex_lock (lock);
-         if (bc_seq != broadcast_seq)
-           goto out;
+         result = futex (&futex, FUTEX_WAIT, val);
+         mutex_lock (lock);
+         if (result < 0 && wakeup_seq < total_seq)
+           wakeup_seq++;
        } while (wakeup_seq == seq || woken_seq == wakeup_seq);
        ++woken_seq;
-     out:
        mutex_unlock (lock);
        mutex_lock (mtx->lock);
      }

(By the way, there's a further optimisation not shown for
process-shared broadcast: if wait is called with a mutex in the same
page as the condvar, the offset within that page is valid for
computing the mutex address in the process-shared broadcast, so it can
requeue to the mutex in that case.)

-- Jamie
