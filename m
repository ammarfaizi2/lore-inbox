Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUKONW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUKONW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 08:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUKONW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 08:22:59 -0500
Received: from mail.shareable.org ([81.29.64.88]:7043 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261589AbUKONWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 08:22:50 -0500
Date: Mon, 15 Nov 2004 13:22:18 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041115132218.GB25502@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41981D4D.9030505@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi Seto wrote:
> I'm not sure but it seems that the pseudo-code could be:
> 
> (mutex must be locked before calling pthread_cond_wait.)
> -A01 pthread_cond_wait {
> +A01 pthread_cond_wait (futex,mutex) {
> +A0*   mutex_unlock(mutex);
>  A02   timeout = 0;
>  A03   lock(counters);

No, it is:

> -A01 pthread_cond_wait {
> +A01 pthread_cond_wait (futex,mutex) {
>  A02   timeout = 0;
>  A03   lock(counters);
> +A0*     mutex_unlock(mutex);

An important difference!

However, I must humbly apologise.  Having studied your failure case
more, I see that the problems you observe can occur even if you do
take the mutex properly.

Consider 4 threads, doing these in parallel (the same as your example
but explicitly mentioning the mutex):

  wait_A: lock mutex; pthread_cond_wait(cond, mutex); unlock mutex
  wake_X: lock mutex; pthread_cond_signal(cond);      unlock mutex
  wait_B: lock mutex; pthread_cond_wait(cond, mutex); unlock mutex
  wake_Y: lock mutex; pthread_cond_signal(cond);      unlock mutex

Then with the code you have posted, it is possible to see the
sequence of events which you described.  The observed problems are:

  1. A lost wakeup.

     wait_A is woken, but wait_B is not, even though the second
     pthread_cond_signal is "observably" after wait_B.

     The operation order is observable in sense that wait_B could
     update the data structure which is protected by cond+mutex, and
     wake_Y could read that update prior to deciding to signal.

     _Logically_, what happens is that wait_A is woken by wake_X, but
     it does not immediately re-acquire the mutex.  In this time
     window, wait_B and wake_Y both run, and then wait_A acquires the
     mutex.  During this window, wait_A is able to absorb the second
     signal.

     It's not clear to me if POSIX requires wait_B to be signalled or
     not in this case.

  2. Future lost wakeups.

     Future calls to pthread_cond_signal(cond) fail to wake wait_B,
     even much later, because cond's NPTL data structure is
     inconsistent.  It's invariant is broken.

     This is a bug in NPTL and it's easy to fix.  Never increment wake
     unconditionally.  Instead, increment it conditionally when (a)
     FUTEX_WAKE returns 1, and also (b) when FUTEX_WAIT returns -EAGAIN.

Both these problem are possible, in exactly the way you described,
even if you do take the mutex properly.

Unfortunately, the kernel patch you tried does not fix these lost
wakeups (in addition to other problems it causes).

This is the sequence which fails (I've added numbers):

> 1. wait_A: calls pthread_cond_wait:
>     total++, prepare to call FUTEX_WAIT with val=0.
>     # status: [1/0/0] (0) queue={}(empty) #
> 
> 2. wake_X: calls pthread_cond_signal:
>     no one in waitqueue, just wake++ and update futex val.
>     # status: [1/1/0] (1) queue={}(empty) #
> 
> 3. wait_B: calls pthread_cond_wait:
>     total++, prepare to call FUTEX_WAIT with val=1.
>     # status: [2/1/0] (1) queue={}(empty) #
> 
> 4. wait_A: calls FUTEX_WAIT with val=0:
>     after queueing, compare val. 0!=1 ... this should be blocked...
>     # status: [2/1/0] (1) queue={A} #
> 
> 5. wait_B: calls FUTEX_WAIT with val=1:
>     after queueing, compare val. 1==1 ... OK, let's schedule()...
>     # status: [2/1/0] (1) queue={A,B} (B=sleeping) #
> 
> 6. wake_Y: calls pthread_cond_signal:
>     A is in waitqueue ... dequeue A, wake++ and update futex val.
>     # status: [2/2/0] (2) queue={B} (B=sleeping) #
> 
> 7. wait_A: end of FUTEX_WAIT with val=0:
>     try to dequeue but already dequeued, return anyway.
>     # status: [2/2/0] (2) queue={B} (B=sleeping) #
> 
> 8. wait_A: end of pthread_cond_wait:
>     woken++.
>     # status: [2/2/1] (2) queue={B} (B=sleeping) #
> 
> This is bug:
>    wait_A: wakeup
>    wait_B: sleeping
>    wake_X: wake A
>    wake_Y: wake A again
> 
> if subsequent wake_Z try to wake B:
> 
> wake_Z: calls pthread_cond_signal:
>     since total==wake, do nothing.
>     # status: [2/2/1] (2) queue={B} (B=sleeping) #
> 
> If wait_C comes, B become to can be woken, but C...

With your kernel patch, the above sequence is prevented.

Unfortunately, a very similar sequence shows the same problems.  I
think the reason you do not see them in testing is because the timing
is changed.

This is the sequence, very similar to your example, which fails in the
same way with your kernel patch:

  1. wait_A: calls pthread_cond_wait:
      total++, prepare to call FUTEX_WAIT with val=0.
+     calls FUTEX_WAIT with val=0.
+     inside futex_wait(), kernel compares val. 0==0, not yet queued.
      # status: [1/0/0] (0) queue={}(empty) #
  
  2. wake_X: calls pthread_cond_signal:
      no one in waitqueue, just wake++ and update futex val.
      # status: [1/1/0] (1) queue={}(empty) #
  
  3. wait_B: calls pthread_cond_wait:
      total++, prepare to call FUTEX_WAIT with val=1.
      # status: [2/1/0] (1) queue={}(empty) #
  
- 4. wait_A: calls FUTEX_WAIT with val=0:
-     after queueing, compare val. 0!=1 ... this should be blocked...
+ 4. wait_A: inside futex_wait(), already compared val. and will block:
+     calls queue_me()... then schedule()...
      # status: [2/1/0] (1) queue={A} #
  
  5. wait_B: calls FUTEX_WAIT with val=1:
      after queueing, compare val. 1==1 ... OK, let's schedule()...
      # status: [2/1/0] (1) queue={A,B} (B=sleeping) #
  
  6. wake_Y: calls pthread_cond_signal:
      A is in waitqueue ... dequeue A, wake++ and update futex val.
      # status: [2/2/0] (2) queue={B} (B=sleeping) #
  
  7. wait_A: end of FUTEX_WAIT with val=0:
-     try to dequeue but already dequeued, return anyway.
+     woken, return.
      # status: [2/2/0] (2) queue={B} (B=sleeping) #
  
  8. wait_A: end of pthread_cond_wait:
      woken++.
      # status: [2/2/1] (2) queue={B} (B=sleeping) #


I hope that explains why this is not fixed by changing the order of
operations in the kernel.

The problem of a wakeup being lost during many concurrent operations
is not easy to fix.  However, the most important property is that at
least one waiter is running and has the mutex at the end of all the
concurrent operations.  That property is satisfied.  So first it is
important to know if this specific lost wakeup is really a bug, or if
it is acceptable POSIX behaviour.

The problem of multiple future wakeups being lost is easy to fix in
NPTL, by updating the state conditionally on the return values from
FUTEX_WAKE and FUTEX_WAIT instead of ignoring the return values.

-- Jamie
