Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUKQIrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUKQIrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbUKQIrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:47:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29666 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262238AbUKQIrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:47:37 -0500
Date: Wed, 17 Nov 2004 03:47:03 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, drepper@redhat.com
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041117084703.GL10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115132218.GB25502@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 01:22:18PM +0000, Jamie Lokier wrote:
>   1. A lost wakeup.
> 
>      wait_A is woken, but wait_B is not, even though the second
>      pthread_cond_signal is "observably" after wait_B.
> 
>      The operation order is observable in sense that wait_B could
>      update the data structure which is protected by cond+mutex, and
>      wake_Y could read that update prior to deciding to signal.
> 
>      _Logically_, what happens is that wait_A is woken by wake_X, but
>      it does not immediately re-acquire the mutex.  In this time
>      window, wait_B and wake_Y both run, and then wait_A acquires the
>      mutex.  During this window, wait_A is able to absorb the second
>      signal.
> 
>      It's not clear to me if POSIX requires wait_B to be signalled or
>      not in this case.
> 
>   2. Future lost wakeups.
> 
>      Future calls to pthread_cond_signal(cond) fail to wake wait_B,
>      even much later, because cond's NPTL data structure is
>      inconsistent.  It's invariant is broken.
> 
>      This is a bug in NPTL and it's easy to fix.  Never increment wake
>      unconditionally.  Instead, increment it conditionally when (a)
>      FUTEX_WAKE returns 1, and also (b) when FUTEX_WAIT returns -EAGAIN.

If you think it is fixable in userland, please write at least the pseudo
code that you believe should work.  We have spent quite a lot of time
on that code and don't believe this is solvable in userland.
E.g. the futex IMHO must be incremented before FUTEX_WAKE, as otherwise
the woken tasks wouldn't see the effect.

I believe the only place this is solvable in is the kernel, by ensuring
atomicity (i.e. queuing task iff curval == expected_val operation atomic
wrt. futex_wake/futex_requeue in other tasks).  In the RHEL3 2.4.x backport
this is easy, as spinlock is held around the user access (the page is first
pinned, then lock taken, then value compared (but that is guaranteed to
be non-blocking) and if equal queued, then unlocked and unpinned.
In 2.6.x this is harder if the kernel cannot allow some spinlock to be
taken while doing user access, but I guess the kernel needs to cope
with this, e.g. by queueing the task early but mark it as maybe queued
only.  If futex_wake sees such a bit, it would wait until futex_wait
notifies it it has decided whether that one should be queued or not.
Or something else, whatever, as long as the right semantics is ensured.

Just FYI, current pseudo code is (not mentioning cancellation stuff here,
code/data to deal with pthread_cond_destroy semantics, timedwait and
pshared condvars):

typedef struct { int lock, futex; uint64_t total_seq, wakeup_seq, woken_seq;
		 void *mutex; uint32_t broadcast_seq; } pthread_cond_t;
pthread_cond_signal (cond)
{
  mutex_lock (lock);
  if (total_seq > wakeup_seq) {
    ++wakeup_seq, ++futex;
    futex (&futex, FUTEX_WAKE, 1);
  }
  mutex_unlock (lock);
}
pthread_cond_wait (cond, mtx)
{
  mutex_lock (lock);
  mutex_unlock (mtx->lock);
  ++total_seq;
  ++futex;
  mutex = mtx;
  bc_seq = broadcast_seq;
  seq = wakeup_seq;
  do {
    val = futex;
    mutex_unlock (lock);
    futex (&futex, FUTEX_WAIT, val);
    mutex_lock (lock);
    if (bc_seq != broadcast_seq)
      goto out;
  } while (wakeup_seq == seq || woken_seq == wakeup_seq);
  ++woken_seq;
out:
  mutex_unlock (lock);
  mutex_lock (mtx->lock);
}
pthread_cond_broadcast (cond)
{
  mutex_lock (lock);
  if (total_seq > wakeup_seq) {
    woken_seq = wakeup_seq = total_seq;
    futex = 2 * total_seq;
    ++broadcast_seq;
    val = futex;
    mutex_unlock (lock);
    if (futex (&futex, FUTEX_CMP_REQUEUE, 1, INT_MAX, &mutex->lock, val) < 0)
      futex (&futex, FUTEX_WAKE, INT_MAX);
    return;
  }
  mutex_unlock (lock);
}

	Jakub
