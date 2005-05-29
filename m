Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVE2Nph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVE2Nph (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 09:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVE2Nph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 09:45:37 -0400
Received: from smtpout.mac.com ([17.250.248.87]:30199 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261307AbVE2NpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 09:45:13 -0400
In-Reply-To: <17049.32899.239673.489434@gargle.gargle.HOWL>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <17049.32899.239673.489434@gargle.gargle.HOWL>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E7EFFD8-D295-4B06-B9AD-CEC736738B1B@mac.com>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
Date: Sun, 29 May 2005 09:45:02 -0400
To: Nikita Danilov <nikita@clusterfs.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2005, at 04:42:43, Nikita Danilov wrote:
> Kyle Moffett writes:
>
> [...]
>
>
>>
>> struct spinaphore {
>>      atomic_t queued;
>>      atomic_t hold_time;
>>      spinlock_t spinlock;
>>      unsigned long acquire_time;
>> };
>>
>> void spinaphore_lock (struct spinaphore *sph) {
>>      unsigned long start_time = fast_monotonic_count();
>>
>
> fast_monotonic_count() should be per-cpu, otherwise spinaphore_lock()
> would require two atomic operations in the best case (and be twice as
> expensive as a spin-lock). Per-cpu counter is OK, as long as thread is
> not allowed to schedule with spinaphore held.

Absolutely.  I agree on all points (And that's why I added the function
spinaphore_lock_atomic() so that they could be nested a little bit.

>
>>      int queue_me = 1;
>>      until (likely(spin_trylock(&sph->spinlock))) {
>>
>>          /* Get the queue count (And ensure we're queued in the
>> process) */
>>          unsigned int queued = queue_me ?
>>                  atomic_inc_return(&sph->queued) :
>>                  queued = atomic_get(&sph->queued);
>>          queue_me = 0;
>>
>>          /* Figure out if we should switch away */
>>          if (unlikely(CONFIG_SPINAPHORE_CONTEXT_SWITCH <
>>                  ( queued*atomic_get(&sph->hold_time) -
>>                    fast_monotonic_count() - start_time
>>                  ))) {
>>              /* Remove ourselves from the wait pool (remember to re-
>> add later) */
>>              atomic_dec(&sph->queued);
>>              queue_me = 1;
>>
>>              /* Go to sleep */
>>              cond_resched();
>>          }
>>      }
>>
>>      /* Dequeue ourselves and update the acquire time */
>>      atomic_dec(&sph->queued);
>>
>
> atomic_dec() should only be done if atomic_inc_return() above was,  
> i.e.,
> not in contentionless fast-path, right?

Oops, agreed, see other email for a fix.

>>
>> void spinaphore_unlock (struct spinaphore *sph) {
>>      /* Update the running average hold time */
>>      atomic_set(&sph->hold_time, (4*atomic_get(&sph->hold_time) +
>>              (fast_monotonic_count() - sph->acquire_time))/5);
>>
>>      /* Actually unlock the spinlock */
>>      spin_unlock(&sph->spinlock);
>> }
>>
>
> It is not good that unlock requires additional atomic operation. Why
> ->hold_time is atomic in the first place? It is only updated by the  
> lock
> holder, and as it is approximate statistics anyway, non-atomic  
> reads in
> spinaphore_lock() would be fine.

The reason for the atomic reads there is so that the value is updated,
instead of cached in a register.

In an assembly implementation, this would be optimized such that it all
fits in one cacheline and uses a minimum number of atomic operations and
cache flushes.  This is a naive C implementation based on existing
primitives.




Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



