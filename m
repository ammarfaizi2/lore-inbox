Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVE2NmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVE2NmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 09:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVE2NmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 09:42:19 -0400
Received: from smtpout.mac.com ([17.250.248.85]:4061 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261305AbVE2NmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 09:42:02 -0400
In-Reply-To: <934f64a205052822253dbdb38e@mail.gmail.com>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <934f64a205052822253dbdb38e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F6607167-A0F8-467D-8502-36FDE7EF2C2A@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
Date: Sun, 29 May 2005 09:41:57 -0400
To: David Nicol <davidnicol@gmail.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2005, at 01:25:15, David Nicol wrote:
> On 5/27/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> "context switch + useful work" time, and goes to sleep if it thinks
>> it has enough
>> time to spare.
>>
>> Problems:
>> You can't nest these.  You also can't take a normal semaphore inside
>> one.  The
>> only useable locking order for these is:
>> ..., semaphore, semaphore, spinaphore, spinlock, spinlock, ...
>>
>
> I don't see why very careful nesting wouldn't work.  Because you
> could get the count up on a locked-out lock?  The problems of VMS
> asynchronous traps :) the outer ones would have higher hold times
> than the inner ones.

No, more due to the nature of sleeping while holding a spinlock :-D
Under my current implementation, I use the literal spinlock code,
which disables preemption, etc.  If someone were to use a semaphore
or a normal spinaphore_lock() (vs spinaphore_lock_atomic()) within
a spinaphore, it would BUG("scheduling while atomic").

>> struct spinaphore {
>>      atomic_t queued;
>>      atomic_t hold_time;
>>      spinlock_t spinlock;
>>      unsigned long acquire_time;
>         unsigned long acceptable_wait_time; /* dynamic tuning */

Uhh, the "aceptable_wait_time" == hold_time, which must be an
atomic_t in the naive C implementation, so that it can be
properly re-read in each loop without getting cached in a register
or something.

>> };
>>
>> void spinaphore_lock (struct spinaphore *sph) {
>>      unsigned long start_time = fast_monotonic_count();
>>      int queue_me = 1;
>>
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
>>
>
> we could subtract the average lock-held time from the time that
> the current lock has been held to find an expected time until
> the lock becomes free, so we only try spinning when the current
> holder of the lock is nearly done.  Hmm what other metrics would
> be easy to gather?

Oops, it should be this:

CONFIG_SPINAPHORE_CONTEXT_SWITCH < queueud * atomic_get(&sph->hold_time)

Basoically, the queued line is 2 * average_wait_time (Because we're
going to wait for 1/2 those to finish on average), so if we would wait
just as long on average (from now, with the current queued and
hold_time) to go do useful work as it would to spin, then go off and
do something useful.

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

>       if(contention)atomic_dec(&sph->queued);
>
> when there was no contention we didn't increment.

Ah, yeah.  How about removing the "contention" variable and using this:
if (!queue_me) atomic_dec(&sph->queued);

>>      sph->acquire_time = fast_monotonic_count();
>> }
>>
>
>> void spinaphore_unlock (struct spinaphore *sph) {
>>      /* Update the running average hold time */
>>      atomic_set(&sph->hold_time, (4*atomic_get(&sph->hold_time) +
>>              (fast_monotonic_count() - sph->acquire_time))/5);
>>
>
> These don't need to be atomic functions, since we haven't released
> the lock yet, or is there a risk that nonatomic gets and sets will get
> deferred? no I'm sorry atomic_[get|set] pertains to operations on
> atomic_t data is that correct?

Yeah.  In the lock functions, we read the data atomically _before_ we've
obtained the lock, so here we must use atomic get/set in order to modify
that data (Because it's in an atomic_t structure).
>
>>      /* Actually unlock the spinlock */
>>      spin_unlock(&sph->spinlock);
>> }
>>
>> Cheers,
>> Kyle Moffett
>
> is there a schedule-that-function-next call?  The spinaphore idea  
> is that
> instead of simply yielding until later (cond_resched) we register  
> ourselves
> with the sph object, with a linked list, an actual queue instead of  
> a count
> of queued threads -- and at unlocking time, if there's a queue, the  
> head of
> the line gets the service next.  Which would scale to a lot of  
> CPUs, still with
> a spinlock around the setting of the head-of-line pointer.

Yeah, that could be a next level implementation more in line with  
what Ingo has
written already.





Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



