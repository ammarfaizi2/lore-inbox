Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbUKRTvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUKRTvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbUKRTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:49:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262926AbUKRTsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:48:11 -0500
Date: Thu, 18 Nov 2004 14:47:27 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041118194726.GX10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041118072058.GA19965@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118072058.GA19965@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 07:20:58AM +0000, Jamie Lokier wrote:
> Do you have an answer for whether the behaviour of (a) is a bug or
> not?  I don't know if it's a bug, or if that part of NPTL behaviour is
> acceptable under POSIX.  Even if it's acceptable, you might decide
> it's not acceptable quality to do that.

Not sure what you mean by (a) there, so assuming you meant 1.
If pthread_cond_{signal,broadcast} is called with the condvar's associated
mutex held, then the standard is pretty clear when a thread is considered
blocked in pthread_cond_*wait on the condvar, as releasing the mutex and
getting blocked on the condvar in pthread_cond_*wait shall be observed as
atomic by other threads.  If pthread_cond_{signal,broadcast} is called
without the mutex held, it is not that clear.
Anyway, pthread_cond_signal is supposed to wake at least one thread
blocked in pthread_cond_*wait (if there are any).

The scenario described in futex_wait-fix.patch IMHO can happen even
if all calls to pthread_cond_signal are done with mutex held around it, i.e.
A		B		X		Y
pthread_mutex_lock (&mtx);
pthread_cond_wait (&cv, &mtx);
  - mtx release *)
  total++ [1/0/0] (0) {}
				pthread_mutex_lock (&mtx);
				pthread_cond_signal (&cv);
				  - wake++ [1/1/0] (1) {}
				  FUTEX_WAKE, 1 (returns, nothing is queued)
				pthread_mutex_unlock (&mtx);
		pthread_mutex_lock (&mtx);
		pthread_cond_wait (&cv, &mtx);
		  - mtx release *)
		  total++ [2/1/0] (1) {}
  FUTEX_WAIT, 0
  queue_me [2/1/0] (1) {A}
  0 != 1
		FUTEX_WAIT, 1
		queue_me [2/1/0] (1) {A,B}
		1 == 1
						pthread_mutex_lock (&mtx);
						pthread_cond_signal (&cv);
						  - wake++ [2/2/0] (2) {A,B}
						  FUTEX_WAKE, 1 (unqueues incorrectly A)
						  [2/2/0] (2) {B}
						pthread_mutex_unlock (&mtx);
  try to dequeue but already dequeued
  would normally return EWOULDBLOCK here
  but as unqueue_me failed, returns 0
  woken++ [2/2/1] (2) {B}
		schedule_timeout (forever)
  - mtx reacquire
  pthread_cond_wait returns
pthread_mutex_unlock (&mtx);

		-------------------
		the code would like to say pthread_mutex_unlock (&mtx);
		and pthread_exit here, but never reaches there.

Now, if at this point say A pthread_join's B, Y pthread_join's A and
X pthread_join's Y, the program should eventually finish, as B must have
been woken up according to the standard.  Whether signal in X means
pthread_cond_wait in A returning first or pthread_cond_wait in B returning
first is I believe not defined unless special scheduling policy is used,
as both A and B are supposed to contend for mtx lock.
But I believe both A and B must be awaken, assuming no other thread attempts
to acquire mtx afterwards.

*) therefore other threads that acquire mtx can now consider A blocked on
   the condvar

	Jakub
