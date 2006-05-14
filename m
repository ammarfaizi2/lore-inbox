Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWENDLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWENDLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 23:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWENDLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 23:11:37 -0400
Received: from xenotime.net ([66.160.160.81]:60341 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750921AbWENDLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 23:11:37 -0400
Date: Sat, 13 May 2006 20:14:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document futex PI design
Message-Id: <20060513201402.68c2b205.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com>
	<20060510101729.GB31504@elte.hu>
	<Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,

I have some corrections/suggestions for you if you want them.


On Wed, 10 May 2006 06:59:49 -0400 (EDT) Steven Rostedt wrote:

> Done, thanks.
> 
> Andrew, could you use this patch instead.
> 
> Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt	2006-05-10 06:56:11.000000000 -0400
> @@ -0,0 +1,767 @@
> +
> +Unbounded Priority Inversion
> +----------------------------
> +
> +The classic example of unbounded priority inversion is were you have three
> +processes, lets call them processes A, B, and C, where A is the highest priority

              let's
> +process, C is the lowest, and B is in between. A tries to grab a lock that C
> +owns and must wait and lets C run to release the lock. But in the meantime,
> +B executes, and since B is of a higher priority than C, it preempts C, but
> +by doing so, it is in fact preempting A which is a higher priority process.
> +Now there's no way of knowing how long A will be sleeping waiting for C
> +to release the lock, because for all we know, B is a CPU hog and will
> +never give C a chance to release the lock.  This is called unbounded priority
> +inversion.
> +
> +Here's a little ascii art to show the problem.
                   ASCII

> +Priority Inheritance (PI)
> +-------------------------
> +
> +PI is where a process inherits the priority of another process if the other
> +process blocks on a lock owned by the current process.  To make this easier
> +to understand, lets use the previous example, with processes A, B, and C again.
                  let's

> +This time, when A blocks on the lock owned by C, C would inherit the priority
> +of A.  So now if B becomes runnable, it would not preempt C, since C now has
> +the high priority of A.  As soon as C releases the lock, it loses its
> +inherited priority, and A then can continue with the resource that C had.
> +
> +Terminology
> +-----------
> +
> +waiter   - A waiter is a struct that is stored on the stack of a blocked
> +	   process.  Since the scope of the waiter is within the code for
> +	   a process being blocked on the mutex, it is fine to allocate
> +	   the waiter on the process' stack (local variable).  This
                             process's

> +	   structure holds a pointer to the task, as well as the mutex that
> +	   the task is blocked on.  It also has the plist node structures to
> +	   place the task in the waiter_list of a mutex as well as the
> +	   pi_list of a mutex owner task (described below).
> +
> +	   waiter is sometimes used in reference to the task that is waiting
> +	   on a mutex. This is the same as waiter->task.
> +
> +top pi waiter - The highest priority process waiting on one of the mutexes
> +                that a specific process owns.

  top PI waiter (throughout)

> +Note:  task and process are used interchangeably in this document.  Mostly to
s/.  Mostly/, mostly/

> +       differentiate between two processes that are being described together.
> +
> +
> +PI chain
> +--------
> +
> +To show where two chains merge, we could add another process F and
> +another mutex L5 where B owns L5 and F is blocked on mutex L5
* add period.

> +For PI to work, the processes at the right end of these chains (or we may
> +also call the Top of the chain), must be equal to or higher in priority
        call it the Top of the chain)
* drop the comma

> +than the processes to the left or below in the chain.
> +
> +Also since a mutex may have more than one process blocked on it, we can
> +have multiple chains merge at mutexes.  If we add another process G that is
> +blocked on mutex L2.
s/L2./L2:/

> +  G->L2->B->L1->A
> +
> +Plist
> +-----
> +
> +There are a few differences between plist and list, the most important one
> +is that plist is a priority sorted link list.  This means that the priorities
s/is/being/
s/link/linked/

> +of the plist are sorted, such that it takes O(1) to retrieve the highest
> +priority item in the list.  Obviously this is useful to store processes
> +based on their priorities.
> +
> +Depth of the PI Chain
> +---------------------
> +
> +The maximum depth of the PI chain is not dynamic, and could actually be
> +defined.  But is very complex to figure it out, since it depends on all
> +the nesting of mutexes.  Lets look at the example where we have 3 mutexes,
                            Let's
> +L1, L2, and L3, and four separate functions func1, func2, func3 and func4.
> +The following shows a locking order of L1->L2->L3, but may not actually
> +be directly nested that way.

It would be good to use kernel coding style for these 4 functions....

> +void func1 () {
> +     mutex_lock(L1);
> +
> +     /* do anything */
> +
> +     mutex_unlock(L1);
> +}
> +
> +Mutex owner and flags
> +---------------------
> +
> +The mutex structure contains a pointer to the owner of the mutex.  If the
> +mutex is not owned, this owner is set to NULL.  Since all architectures
> +have the task structure on at least a four byte alignment (and if this is
> +not true, the rtmutex.c code will be broken!), this allows for the least
> +two significant bits to be used as flags.  This part is also described
s/least two/two least/
> +in Documentation/rt-mutex.txt, but will also be briefly descried here.
s/descried/described/

> +Priority adjustments
> +--------------------
> +
> +rt_mutex_getprio returns the priority that the task should have.  Either the
> +tasks own normal priority, or if a process of a higher priority is waiting on
   task's
> +a mutex owned by the task, then that higher priority should be returned.
> +Since the pi_list of a task holds an order by priority list of all the top
> +waiters of all the mutexes that the task owns, rt_mutex_getprio simply needs
> +to compare the top pi waiter to its own normal priority, and return the higher
> +priority back.
> +
> +(Note:  if looking at the code, you will notice that the lower number of
> +        prio is returned.  This is because the prio field in the task structure
> +	is an inverse order of the actual priority.  So a "prio" of 5 is
> +	of higher priority than a "prio" of 10).
* move period before ')'

> +It is interesting to note that __rt_mutex_adjust_prio can either increase
> +or decrease the priority of the task.  In the case that a higher priority
> +process has just blocked on a mutex owned by the task, __rt_mutex_adjust_prio
> +would increase/boost the task's priority.  But if a higher priority task
> +were for some reason leave the mutex (timeout or signal), this same function
s/leave/to leave/

> +would decrease/unboost the priority of the task.  That is because the pi_list
> +always contains the highest priority task that is waiting on a mutex owned
> +by the task, so we only need to compare the priority of that top pi waiter
> +to the normal priority of the given task.
> +
> +
> +High level overview of the PI chain walk
> +----------------------------------------
> +
> +The rt_mutex_adjust_prio_chain can be used to both boost processes to higher
   either to boost or lower process priorities.
and drop the next line.
> +priorities, or sometimes it is used to lower priorities.

> +The rt_mutex_adjust_prio_chain is called with a task to be checked for
* drop "The"

> +PI (de)boosting (the owner of a mutex that a process is blocking on), a flag to
> +check for deadlocking, the mutex that the task owns, and a pointer to a waiter
> +that is the process' waiter struct that is blocked on the mutex (although this
               process's
> +parameter may be NULL for deboosting).
> +

> +A check is now done to see if the original waiter (the process that is blocked
> +on the current mutex), is the top pi waiter of the task.  That is, is this
* drop first comma

> +waiter on the top of the task's pi_list.  If it is not, it either means that
> +there is another process higher in priority that is blocked on one of the
> +mutexes that the task owns, or that the waiter has just woken up via a signal
> +or timeout and has left the PI chain.  In either case, the loop is exited, since
> +we don't need to do any more changes to the priority of the current task, or any
> +task that owns a mutex that this current task is waiting on.  A priority chain
> +walk is only needed when a new top pi waiter is made to a task.
> +

> +Now that we have both the pi_lock of the task, as well as the wait_lock of
* drop comma

> +the mutex the task is blocked on, we update the task's waiter's plist node
> +that is located on the mutex's wait_list.
> +
> +Now we release the pi_lock of the task.
> +
> +Next the owner of the mutex has its pi_lock taken, so we can update the
> +task's entry in the owner's pi_list.  If the task is the highest priority
> +process on the mutex's wait_list, then we remove the previous top waiter
> +from the owner's pi_list, and replace it with the task.
> +
> +Note: It is possible that the task was the current top waiter on the mutex
* add comma after "mutex"

> +      in which case, the task is not yet on the pi_list of the waiter.  This
* drop comma

> +      is OK, since plist_del does nothing if the plist node is not on any
> +      list.
> +
> +If the task was not the top waiter of the mutex, but it was before we
> +did the priority updates, that means we are deboosting/lowering the
> +task.  In this case, the task is removed from the pi_list of the owner,
> +and the new top waiter is added.
> +
> +Lastly, we unlock both the pi_lock of the task, as well as the mutex's
> +wait_lock, and continue the loop again, this time the task is the owner
s/this time/but this time/ (?)
> +of the previous mutex.
> +
> +
> +Note: One might think that the owner of this mutex might have changed
> +      since we just grab the mutex's wait_lock. And one could be right.
> +      The important thing to remember, is that the owner could not have
* drop comma

> +      become the task that is being processed in the PI chain, since
> +      we have taken that task's pi_lock at the beginning of the loop.
> +      So as long as there is an owner of this mutex, that is not the same
* drop comma

> +      process as the tasked being worked on, we are OK.
> +
> +Pending Owners and Lock stealing
> +--------------------------------
> +
> +There's no reason a high priority process that gives up a mutex, should be
* drop comma

> +penalized if it tries to take that mutex again.  If the new owner of the
> +mutex has not woken up yet, there's no reason that the higher priority process
> +could not take that mutex away.
> +
> +Taking of a mutex (The walk through)
> +------------------------------------
> +
> +OK, now lets take a look at the detailed walk through of what happens when
           let's

> +taking a mutex.
> +
> +
> +1) Has owner that is pending
> +----------------------------
* insert blank line to be consistent

> +If there is waiters on this mutex, and we just stole the ownership, we need
s/there is/there are/

> +to take the top waiter, remove it from the pi_list of the pending owner, and
> +add it to the current pi_list.  Note that at this moment, the pending owner
> +is no longer on the list of waiters.  This is fine, since the pending owner
> +would add itself back when it realizes that it had the ownership stolen
> +from itself.

How does a pending owner realize that ownership was stolen?

> +3) Failed to grab ownership
> +---------------------------
> +
> +Once again we try to take the mutex.  This will usually fail the first time
> +in the loop, but not usually the second.

A "why" here would be nice (why fail the first time but not the second
time -- usually ?).

> +If the mutex is TASK_INTERRUPTIBLE a check for signals and timeout is done
> +here.
> +
> +Task blocks on mutex
> +--------------------
> +
> +Since the wait_lock was taken at the entry of the slow lock, we can safely
> +add the waiter to the wait_list.  If the current process is the highest
> +priority process currently waiting on this mutex, then we remove the
> +previous top waiter process (if it exists) from the pi_list of the owner,
> +and add the current process to that list.  Since the pi_list of the owner
> +has changed, we call rt_mutex_adjust_prio on the owner to see if the owner
> +should adjust it's priority accordingly.
                 its

> +If the owner is also blocked on a lock, and had it's pi_list changed
                                                   its

> +(or deadlock checking is on), we unlock the wait_lock of the mutex and go ahead
> +and run rt_mutex_adjust_prio_chain on the owner, as described earlier.
> +

> +Unlocking the Mutex
> +-------------------
> +
> +If the owner field has the "Has Waiters" bit set, (or CMPXCHG is not available)
* move comma to after the ')'

> +the slow unlock path is taken.
> +
> +The first thing done in the slow unlock path is to take the wait_lock of the
> +mutex.  This synchronizes the locking and unlocking of the mutex.
> +
> +A check is made to see if the mutex has waiters or not, this can be the case for
> +architectures without CMPXCHG, or a waiter had hit the timeout or signal and
> +removed itself between the time the "Has Waiters" bit was checked and this
> +check.  If there are no waiters than the mutex owner field is set to NULL,
> +the wait_lock is released and nothing more is needed.

First sentence of paragraph above needs some work, but I can't tell
what is intended so I can't fix it.

> +Finally we unlock the pi_lock of the pending owner, and wake it up.
* drop comma

> +Reviewers:  Ingo Molnar, Thomas Gleixner, and Thomas Duetsch.
Randy Dunlap

---
~Randy
