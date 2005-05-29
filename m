Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVE2F0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVE2F0a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVE2F0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:26:30 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:15451 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261253AbVE2FZS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:25:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TdJkPgkfFXR2chU+vVJc3Hr1TmnvBI5SmiApB2oT00uEv2sDQRt7Auvp3LZmEbimJXQ68PUrG4iDqTewEC63gkvHCtyivdXwIgLrQfCtosWbkcfBbf/EVAWh4nBDSKl3wKjMiBswC/eZXtCzMCXJa0aa4ZZAAFXdn+6aIMuy+zs=
Message-ID: <934f64a205052822253dbdb38e@mail.gmail.com>
Date: Sun, 29 May 2005 00:25:15 -0500
From: David Nicol <davidnicol@gmail.com>
Reply-To: David Nicol <davidnicol@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <934f64a205052715315c21d722@mail.gmail.com>
	 <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> Here is an example naive implementation which could perhaps be
> optimized further
> for architectures based on memory and synchronization requirements.

Fantastic!  I have done some slight edits over what are probably typos.

> A quick summary:
> Each time the lock is taken and released, a "hold_time" is updated
> which indicates
> the average time that the lock is held.  During contention, each CPU
> checks the
> current average hold time and the number of CPUs waiting against a
> predefined

per spinaphore instance -- don't know what these are protecting
exactly at lib compile time

> "context switch + useful work" time, and goes to sleep if it thinks
> it has enough
> time to spare.
> 
> Problems:
> You can't nest these.  You also can't take a normal semaphore inside
> one.  The
> only useable locking order for these is:
> ..., semaphore, semaphore, spinaphore, spinlock, spinlock, ...

I don't see why very careful nesting wouldn't work.  Because you could
get the count up on a locked-out lock?  The problems of VMS
asynchronous traps :)
the outer ones would have higher hold times than the inner ones.




> Possible Solution:
> If you had a reliable way of determining when it is safe to sleep,
> you could call
> a "cond_resched_if_nonatomic()" function instead of cond_resched()
> and allow
> nesting of spinaphores within each other and within spinlocks.  I
> _do_ implement a
> spinaphore_lock_atomic which is guaranteed not to sleep and could be
> used within
> other locks instead.
> 
> struct spinaphore {
>      atomic_t queued;
>      atomic_t hold_time;
>      spinlock_t spinlock;
>      unsigned long acquire_time;

        unsigned long acceptable_wait_time; /* dynamic tuning */

> };
> 
> void spinaphore_lock (struct spinaphore *sph) {
>      unsigned long start_time = fast_monotonic_count();
>      int queue_me = 1;
        int contention = 0; /* see below */
>      until (likely(spin_trylock(&sph->spinlock))) {
            contention = 1;
> 
>          /* Get the queue count (And ensure we're queued in the
> process) */
>          unsigned int queued = queue_me ?
>                  atomic_inc_return(&sph->queued) :
>                  queued = atomic_get(&sph->queued);
>          queue_me = 0;
> 
>          /* Figure out if we should switch away */
>          if (unlikely(CONFIG_SPINAPHORE_CONTEXT_SWITCH <
>                  ( queued*atomic_get(&sph->hold_time) -
>                    fast_monotonic_count() - start_time

we could subtract the average lock-held time from the time that
the current lock has been held to find an expected time until
the lock becomes free, so we only try spinning when the current
holder of the lock is nearly done.  Hmm what other metrics would
be easy to gather?

>                  ))) {
>              /* Remove ourselves from the wait pool (remember to re-
> add later) */
>              atomic_dec(&sph->queued);
>              queue_me = 1;
> 
>              /* Go to sleep */
>              cond_resched();
>          }
>      }
> 
>      /* Dequeue ourselves and update the acquire time */
>      atomic_dec(&sph->queued);
      if(contention)atomic_dec(&sph->queued);

when there was no contention we didn't increment.

>      sph->acquire_time = fast_monotonic_count();
> }

[snip]

> void spinaphore_unlock (struct spinaphore *sph) {
>      /* Update the running average hold time */
>      atomic_set(&sph->hold_time, (4*atomic_get(&sph->hold_time) +
>              (fast_monotonic_count() - sph->acquire_time))/5);

These don't need to be atomic functions, since we haven't released
the lock yet, or is there a risk that nonatomic gets and sets will get
deferred? no I'm sorry atomic_[get|set] pertains to operations on
atomic_t data is that correct?

>      /* Actually unlock the spinlock */
>      spin_unlock(&sph->spinlock);
> }
> 
> Cheers,
> Kyle Moffett


is there a schedule-that-function-next call?  The spinaphore idea is that
instead of simply yielding until later (cond_resched) we register ourselves
with the sph object, with a linked list, an actual queue instead of a count
of queued threads -- and at unlocking time, if there's a queue, the head of
the line gets the service next.  Which would scale to a lot of CPUs, still with
a spinlock around the setting of the head-of-line pointer.

I guess I need to look at Ingo's mutexes before wasting more of everyone's time



David L Nicol
