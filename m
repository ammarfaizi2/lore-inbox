Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVE1BEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVE1BEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 21:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVE1BEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 21:04:54 -0400
Received: from smtpout.mac.com ([17.250.248.84]:61910 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261898AbVE1BEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 21:04:46 -0400
In-Reply-To: <934f64a205052715315c21d722@mail.gmail.com>
References: <934f64a205052715315c21d722@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
Date: Fri, 27 May 2005 21:04:37 -0400
To: David Nicol <davidnicol@gmail.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 27, 2005, at 18:31:38, David Nicol wrote:
> On 5/26/05, john cooper <john.cooper@timesys.com> wrote:
>
>> given design.  Clearly we aren't buying anything to trade off
>> a spinlock protecting the update of a single pointer with a
>> blocking lock and associated context switching.
>
> On contention, and only on contention, we are faced with the  
> question of what
> to do.  Do we wait, or do we go away and come back later?  What  
> information is
> available to us to base the decision on?  We can't gather any more  
> information,
> because that would take longer than spin-waiting.  If the  
> "spinaphore" told us,
> on acquisition failure, how many other threads were asking for it, we
> could implement
> a tunable lock, that surrenders context when there are more than N
> threads waiting for
> the resource, and that otherwise waits its turn, or its chance,  as  
> a compromise
> and synthesis.

Here is an example naive implementation which could perhaps be  
optimized further
for architectures based on memory and synchronization requirements.

A quick summary:
Each time the lock is taken and released, a "hold_time" is updated  
which indicates
the average time that the lock is held.  During contention, each CPU  
checks the
current average hold time and the number of CPUs waiting against a  
predefined
"context switch + useful work" time, and goes to sleep if it thinks  
it has enough
time to spare.

Problems:
You can't nest these.  You also can't take a normal semaphore inside  
one.  The
only useable locking order for these is:
..., semaphore, semaphore, spinaphore, spinlock, spinlock, ...

Possible Solution:
If you had a reliable way of determining when it is safe to sleep,  
you could call
a "cond_resched_if_nonatomic()" function instead of cond_resched()  
and allow
nesting of spinaphores within each other and within spinlocks.  I  
_do_ implement a
spinaphore_lock_atomic which is guaranteed not to sleep and could be  
used within
other locks instead.

struct spinaphore {
     atomic_t queued;
     atomic_t hold_time;
     spinlock_t spinlock;
     unsigned long acquire_time;
};

void spinaphore_lock (struct spinaphore *sph) {
     unsigned long start_time = fast_monotonic_count();
     int queue_me = 1;
     until (likely(spin_trylock(&sph->spinlock))) {

         /* Get the queue count (And ensure we're queued in the  
process) */
         unsigned int queued = queue_me ?
                 atomic_inc_return(&sph->queued) :
                 queued = atomic_get(&sph->queued);
         queue_me = 0;

         /* Figure out if we should switch away */
         if (unlikely(CONFIG_SPINAPHORE_CONTEXT_SWITCH <
                 ( queued*atomic_get(&sph->hold_time) -
                   fast_monotonic_count() - start_time
                 ))) {
             /* Remove ourselves from the wait pool (remember to re- 
add later) */
             atomic_dec(&sph->queued);
             queue_me = 1;

             /* Go to sleep */
             cond_resched();
         }
     }

     /* Dequeue ourselves and update the acquire time */
     atomic_dec(&sph->queued);
     sph->acquire_time = fast_monotonic_count();
}

void spinaphore_lock_atomic (struct spinaphore *sph) {
     /* Let the other processes know what we're doing */
     atomic_inc(&sph->queued);

     /* Just get the lock the old fashioned way */
     spin_lock(&sph->spinlock);

     /* Dequeue ourselves and update the acquire time */
     atomic_dec(&sph->queued);
     sph->acquire_time = fast_monotonic_count();
}

int spinaphore_trylock (struct spinaphore *sph) {
     /* Try to get the lock, and if so, update the acquire time */
     if (spin_trylock(&sph->spinlock)) {
         sph->acquire_time = fast_monotonic_count();
}

void spinaphore_unlock (struct spinaphore *sph) {
     /* Update the running average hold time */
     atomic_set(&sph->hold_time, (4*atomic_get(&sph->hold_time) +
             (fast_monotonic_count() - sph->acquire_time))/5);

     /* Actually unlock the spinlock */
     spin_unlock(&sph->spinlock);
}

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



