Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVLPACo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVLPACo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVLPACn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:02:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:6910 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751214AbVLPACn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:02:43 -0500
In-Reply-To: <20051215194434.GA4741@in.ibm.com>
References: <20051214223912.GA4716@in.ibm.com> <9175126B-6D06-11DA-AA1B-000A959BB91E@mvista.com> <20051215194434.GA4741@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <43F8915C-6DC7-11DA-A45A-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: Recursion bug in -rt
Date: Thu, 15 Dec 2005 16:02:36 -0800
To: dino@in.ibm.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar,

	I believe the problem we have is that the library is not checking
to see if the mutex is a recursive mutex, and then checking to see
if the recursive mutex is already owned by the calling thread.  If a 
recursive mutex
is owned by the calling thread the library should increment the lock
count (POSIX says recursive mutexes must be unlocked as
many times as they are locked) and return 0 (success) to the caller.

      I don't see anywhere in the library where the check for a recursive
mutex is being made.  The mutex_trylock code just does a compare
and exchange on the lock to see if it can get it.  A recursive mutex
will fail this test and erroneously enter the kernel.

     I believe we need the down_futex change and a patch
to glibc in which recursive mutexes are handled in the library.

     I'm talking to the library people now to see if that's the way
it's supposed to work for recursive mutexes.  If it is we'll have
to provide a new glibc patch along with the kernel patch.

      I think I'll have to provide a new glibc patch anyways to
fix the INLINE_SYSCALL problem.

      Does this make sense?

David

On Dec 15, 2005, at 11:44 AM, Dinakar Guniguntala wrote:

> On Wed, Dec 14, 2005 at 05:03:13PM -0800, david singleton wrote:
>> Dinakar,
>> you may be correct, since reverting the change in down_futex seems
>> to work.
>
> Well it did not. It ran for much longer than previously but still
> hung up.
>
> Well we have a very basic problem in the current implementation.
>
> Currently if a thread calls pthread_mutex_lock on the same lock
> (normal, non recursive lock) twice without unlocking in between, the
> application hangs. Which is the right behaviour.
> However if the same thing is done with a non recursive robust mutex,
> it manages to acquire the lock.
>
> I see many problems here (I am assuming that the right behaviour
> with robust mutexes is for application to ultimately block
> indefinitely in the kernel)
>
> 1. In down_futex we do the following check
>
> 	if (owner_task != current)
> 		down_try_futex(lock, owner_task->thread_info __EIP__);
>
>    In the above scenario, the thread would have acquired the 
> uncontended
>    lock first time around in userspace. The second time it tries to
>    acquire the same mutex, because of the above check, does not
>    call down_try_futex and hence will not initialize the lock structure
>    in the kernel. It then goes to __down_interruptible where it is
>    granted the lock, which is wrong.
>
>    So IMO the above check is not right. However removing this check
>    is not the end of story.  This time it gets to task_blocks_on_lock
>    and tries to grab the task->pi_lock of the owvner which is itself
>    and results in a system hang. (Assuming CONFIG_DEBUG_DEADLOCKS
>    is not set). So it looks like we need to add some check to
>    prevent this below in case lock_owner happens to be current.
>
>     _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
>
>
>> However, I'm  wondering if you've hit a bug that Dave Carlson is
>> reporting that he's tracked down to an inline in the glibc patch.
>
> Yes I noticed that, basically it looks like INLINE_SYSCALL, on error
> returns -1 with the error code in errno. Whereas we expect the
> return code to be the same as the kernel return code. Are you referring
> to this or something else ??
>
> However even with all of the above fixes (remove the check in 
> down_futex
> as mentioned above, add a check in task_blocks_on_lock and the glibc
> changes) my test program continues to hang up the system, though it
> takes a lot longer to recreate the problem now
>
> [snip]
>
>> 1) Why did the library call into the kernel if the calling thread
>> owned the lock?
>
> This is something I still havent figured out and leads me to believe
> that we still have a tiny race race somewhere
>
> 	-Dinakar

