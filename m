Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVLPSZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVLPSZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVLPSZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:25:09 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5848 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751325AbVLPSZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:25:07 -0500
Date: Sat, 17 Dec 2005 00:12:09 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: david singleton <dsingleton@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
Message-ID: <20051216184209.GD4732@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051214223912.GA4716@in.ibm.com> <9175126B-6D06-11DA-AA1B-000A959BB91E@mvista.com> <20051215194434.GA4741@in.ibm.com> <43F8915C-6DC7-11DA-A45A-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F8915C-6DC7-11DA-A45A-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 04:02:36PM -0800, david singleton wrote:
> Dinakar,
> 
> 	I believe the problem we have is that the library is not checking
> to see if the mutex is a recursive mutex, and then checking to see
> if the recursive mutex is already owned by the calling thread.  If a 
> recursive mutex
> is owned by the calling thread the library should increment the lock
> count (POSIX says recursive mutexes must be unlocked as
> many times as they are locked) and return 0 (success) to the caller.

Sorry I seem to have confused you. I am _not_ talking about recursive
mutexes here.

I have two testcases. Here is a code snippet of testcase I

        void* test_thread (void* arg)
        {
            pthread_mutex_lock(&child_mutex);
            printf("test_thread got lock\n");

            pthread_mutex_lock(&child_mutex);
            printf("test_thread got lock 2nd time !!\n");

            printf("test_thread exiting\n");
            return NULL;
        }

        main ()
        {
            ...

            if (pthread_mutexattr_init(&mutexattr) != 0) {
              printf("Failed to init mutexattr\n");
            };
            if (pthread_mutexattr_setprotocol(&mutexattr,
                                        PTHREAD_PRIO_INHERIT) != 0) {
              printf("Can't set protocol prio inherit\n");
            }
            if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0) {
              printf("Can't get mutexattr protocol\n");
            } else {
              printf("protocol in mutexattr is %d\n", protocol);
            }
            if ((retc = pthread_mutex_init(&child_mutex, &mutexattr)) != 0) {
              printf("Failed to init mutex: %d\n", retc);
            }

            ...
        }


Clearly what the application is doing here is wrong. However,

1. In the case of normal (non-robust) non recursive mutexes, the
behaviour when we make the second pthread_mutex_lock call is for glibc
to make a futex_wait call which will block forever.
(Which is the right behaviour)

2. In the case of a robust/PI non recursive mutex, the current
behaviour is the glibc makes a futex_wait_robust call (which is right)
The kernel (2.6.15-rc5-rt1) rt_mutex lock is currently unowned and
since we do not call down_try_futex if current == owner_task, we end
up grabbing the lock in __down_interruptible and returning succesfully !

3. Adding the check below in down_futex is also wrong

   if (!owner_task || owner_task == current) {
        up(sem);
        up_read(&current->mm->mmap_sem);
        return -EAGAIN;
   }

   This will result in glibc calling the kernel continuosly in a
   loop and we will end up context switching to death

I guess we need to cleanup this path to ensure that the application
blocks forever.

I also have testcase II which does not do anything illegal as the
above one, instead it exercises the PI boosting code path in the
kernel and that is where I see the system hang up yet again
and this is the race that I am currently investigating

Hope that clearls up things a bit

	-Dinakar


> 
>      I don't see anywhere in the library where the check for a recursive
> mutex is being made.  The mutex_trylock code just does a compare
> and exchange on the lock to see if it can get it.  A recursive mutex
> will fail this test and erroneously enter the kernel.
> 
>     I believe we need the down_futex change and a patch
> to glibc in which recursive mutexes are handled in the library.
> 
>     I'm talking to the library people now to see if that's the way
> it's supposed to work for recursive mutexes.  If it is we'll have
> to provide a new glibc patch along with the kernel patch.
> 
>      I think I'll have to provide a new glibc patch anyways to
> fix the INLINE_SYSCALL problem.
> 
>      Does this make sense?
> 
> David
> 
> On Dec 15, 2005, at 11:44 AM, Dinakar Guniguntala wrote:
> 
> >On Wed, Dec 14, 2005 at 05:03:13PM -0800, david singleton wrote:
> >>Dinakar,
> >>you may be correct, since reverting the change in down_futex seems
> >>to work.
> >
> >Well it did not. It ran for much longer than previously but still
> >hung up.
> >
> >Well we have a very basic problem in the current implementation.
> >
> >Currently if a thread calls pthread_mutex_lock on the same lock
> >(normal, non recursive lock) twice without unlocking in between, the
> >application hangs. Which is the right behaviour.
> >However if the same thing is done with a non recursive robust mutex,
> >it manages to acquire the lock.
> >
> >I see many problems here (I am assuming that the right behaviour
> >with robust mutexes is for application to ultimately block
> >indefinitely in the kernel)
> >
> >1. In down_futex we do the following check
> >
> >	if (owner_task != current)
> >		down_try_futex(lock, owner_task->thread_info __EIP__);
> >
> >   In the above scenario, the thread would have acquired the 
> >uncontended
> >   lock first time around in userspace. The second time it tries to
> >   acquire the same mutex, because of the above check, does not
> >   call down_try_futex and hence will not initialize the lock structure
> >   in the kernel. It then goes to __down_interruptible where it is
> >   granted the lock, which is wrong.
> >
> >   So IMO the above check is not right. However removing this check
> >   is not the end of story.  This time it gets to task_blocks_on_lock
> >   and tries to grab the task->pi_lock of the owvner which is itself
> >   and results in a system hang. (Assuming CONFIG_DEBUG_DEADLOCKS
> >   is not set). So it looks like we need to add some check to
> >   prevent this below in case lock_owner happens to be current.
> >
> >    _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> >
> >
> >>However, I'm  wondering if you've hit a bug that Dave Carlson is
> >>reporting that he's tracked down to an inline in the glibc patch.
> >
> >Yes I noticed that, basically it looks like INLINE_SYSCALL, on error
> >returns -1 with the error code in errno. Whereas we expect the
> >return code to be the same as the kernel return code. Are you referring
> >to this or something else ??
> >
> >However even with all of the above fixes (remove the check in 
> >down_futex
> >as mentioned above, add a check in task_blocks_on_lock and the glibc
> >changes) my test program continues to hang up the system, though it
> >takes a lot longer to recreate the problem now
> >
> >[snip]
> >
> >>1) Why did the library call into the kernel if the calling thread
> >>owned the lock?
> >
> >This is something I still havent figured out and leads me to believe
> >that we still have a tiny race race somewhere
> >
> >	-Dinakar
> 
