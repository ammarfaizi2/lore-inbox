Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293417AbSCBOu2>; Sat, 2 Mar 2002 09:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310388AbSCBOuT>; Sat, 2 Mar 2002 09:50:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64426 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293417AbSCBOuI>; Sat, 2 Mar 2002 09:50:08 -0500
Date: Sat, 2 Mar 2002 09:50:31 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020302095031.A1381@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au> <20020225100025.A1163@elinux01.watson.ibm.com> <20020227112417.3a302d31.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227112417.3a302d31.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Feb 27, 2002 at 11:24:17AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 11:24:17AM +1100, Rusty Russell wrote:
> OK.  New implementation.  Compiles (PPC), but due to personal reasons,
> UNTESTED.  Thanks especially to Hubertus for his prior work and
> feedback.
>
> 1) Turned into syscalls.
> 2) Added arch-specific sys_futex_region() to enable mutexes on region,
>    and give a chance to detect lack of support via -ENOSYS.
> 3) Just a single atomic_t variable for mutex (thanks Paul M).
> - This means -ENOSYS on SMP 386s, as we need cmpxchg.


> - We can no longer do generic semaphores: mutexes only.
> - Requires arch __update_count atomic op.

    I don't see that, you can use atomic_inc on 386s ..

> 4) Current valid args to sys_futex are -1 and +1: we can implement
>    other lock types by using other values later (eg. rw locks).
>

  (seem below) 

> Size of futex.c dropped from 244 to 161 lines, so it's clearly 40%
> better!
>
> Get your complaints in now...

  (plenty below :-)

> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>


Rusty, as indicated I think there is quite some merit to this solution
and it certainly cuts down on some of the complexity that is inherent in
what I submitted.
First, what I like is the fact that by pinning the page down you avoid the
extra indirection that I went through with the kulock_ref_t objects.

There are some limitations to your approach however.

(a) the hashing is to simple. As a consequence there are two limitations
     -  the total number of locks that can be waited for is 
        (1<< USEM_HASHBITS).
        that is way not enough (as you pointed out).
     - this has to be bumped up to roughly the number of tasks in the
       system.
       since each wait_queue_head_t element has 3 words, MAX_PID = 32K
       this would end up with about 400K of memory for this. This would be
       the worst case scenario, namely that every task in the system is 
       waiting on a different lock (hey shit happens).

more seriously though is the following.
(b) there is no provision to what to do when there is a hash collision?
      this seems too rudimentary that I assume I am missing something, 
      in case not:
      if <page1,offset1> and <page2,offset2> both result in the same
      hash value then they will be both waiting on the same wait queue, 
      which is incorrect.

     A solution to this would be to introduce hash chaining as I have done
     through my access vector cache and allocate the waitqueue objects from 
     the cachep object and link them through it. An alternative solution is
     to provide a sufficiently large queue as described in (a) and on collision
     go for a secondary hash function and if that fails search for an empty 
     bucket. In the current situation, I think the second solution might be
     more appropriate.

(c) your implementation could be easily expanded to include Ben's
    suggestion of multiple queues (which I already implement in my 
    submission), by including the queue index into the hashing mechanism.
    Since you are rewriting the wait routine, the problem can be circumvented
    if we can settle for mutex, semaphores, and rwlocks only. Ben what's your
    take. In rwlocks you signal continuation of the next class of holders.
    Then you wake up one writer or the next set of readers, or based on 
    some other parameter, if the first candidate you find is a reader you
    walk the entire list to wake up all readers. Lot's of stuff that can be
    done here. What you need then is to expand your wait structure in this
    case to indicate why you are sleeping, waiting for read or waiting for
    write.   What do you think.


(d) If (b) is magically solved, then I have no take yet regarding cleanup.
    If not, then given (b), your cleanup will become expensive and you 
    will end up in a similar solution as I have it, namely a callback on 
    vmarea destruction and some ref counting. 

(e) In your solution you use throughout cmpxchg, which limits you from 
    utilizing atomic_inc/dec functions on i386.
    I have based my mutex implementation in user space on atomic_inc
    Spinning versions require cmpxchg though.
    Maybe it might be useful to differentiate these cases and provide at
    least non spinning versions for i386.

(f) Why get away from semaphores and only stick to mutexes. Isn't there
    some value to provide counting semaphores ? Effectively, mutexes are
    a subclass of semaphores with a max-count of 1.

(g) I don't understand the business of rechecking in the kernel. In your
    case it comes cheap as you pinned the page already. In general that's 
    true, since the page was just touched the pinning itself is reasonable
    cheap. Nevertheless, I am concerned that now you need intrinsic knowledge
    how the lock word is used in user space. For instance, I use it in 
    different fashions, dependent whether its a semaphore or rwlock.
    Why can't we keep that separated from the kernel function of waiting
    on an event that is signaled along the lock word, the content of the lock 
    word should not come into play in the kernel. 
    If you want this, you use spinning locks.

(h) how do you deal with signals ? E.g. SIGIO or something like it.

Overall, pinning down the page (assuming that not a lot of tasks are
waiting on a large number of queues at the same time) is acceptable, 
and it cuts out one additional level of indirection that is present 
in my submission.

-- Hubertus Franke (frankeh@watson.ibm.com)


