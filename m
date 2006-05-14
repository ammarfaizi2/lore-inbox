Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWENOAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWENOAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWENOAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:00:30 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61340 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751421AbWENOA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:00:29 -0400
Date: Sun, 14 May 2006 10:00:16 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document futex PI design
In-Reply-To: <20060513201402.68c2b205.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.58.0605140812340.12341@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
 <20060513201402.68c2b205.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Randy,

Thanks for taking a look at my document.  I really appreciate it.

Some questions though: (embedded)

On Sat, 13 May 2006, Randy.Dunlap wrote:

> > +----------------------------
> > +
> > +The classic example of unbounded priority inversion is were you have three
> > +processes, lets call them processes A, B, and C, where A is the highest priority
>
>               let's

Not a problem.

> > +process, C is the lowest, and B is in between. A tries to grab a lock that C
> > +owns and must wait and lets C run to release the lock. But in the meantime,
> > +B executes, and since B is of a higher priority than C, it preempts C, but
> > +by doing so, it is in fact preempting A which is a higher priority process.
> > +Now there's no way of knowing how long A will be sleeping waiting for C
> > +to release the lock, because for all we know, B is a CPU hog and will
> > +never give C a chance to release the lock.  This is called unbounded priority
> > +inversion.
> > +
> > +Here's a little ascii art to show the problem.
>                    ASCII

OK, that is the correct way.  Personally, I prefer ascii over ASCII, just
because I like the dots in the 'i's  ;)


> > +
> > +Terminology
> > +-----------
> > +
> > +waiter   - A waiter is a struct that is stored on the stack of a blocked
> > +	   process.  Since the scope of the waiter is within the code for
> > +	   a process being blocked on the mutex, it is fine to allocate
> > +	   the waiter on the process' stack (local variable).  This
>                              process's

OK, although I'm a native speaker, my English isn't that good.  Some of my
German colleagues are even better than I.  I always thought that an
apostrophe 's' after a 's' doesn't add the 's'.  Or should I say, a '\'s'
after a 's' doesn't include the 's'!

> > +
> > +top pi waiter - The highest priority process waiting on one of the mutexes
> > +                that a specific process owns.
>
>   top PI waiter (throughout)

Does this make the document clearer to understand?  I have no problem with
it either way, I mainly want the document to be easy for people to read,
and I tried to use capitals to stress things.  But I would really like an
outside opinion on which reads better. (yours counts as an outside
opinion)

 >
> > +Note:  task and process are used interchangeably in this document.  Mostly to
> s/.  Mostly/, mostly/

No prob.

>
> > +For PI to work, the processes at the right end of these chains (or we may
> > +also call the Top of the chain), must be equal to or higher in priority
>         call it the Top of the chain)
> * drop the comma

OK

> > +have multiple chains merge at mutexes.  If we add another process G that is
> > +blocked on mutex L2.
> s/L2./L2:/

OK

> > +
> > +There are a few differences between plist and list, the most important one
> > +is that plist is a priority sorted link list.  This means that the priorities
> s/is/being/
> s/link/linked/

"being that plist is a priority sorted linked list..."

"being" is fine, but I usually think of link list as a single word.
Although you are correct in that grammically it should be linked.  Again
this isn't a matter of correctness of grammar, but the ease
of understanding.  Though, some may argue that correct grammar makes
understanding easier.

Hmm, doing a search on Google with ("link list" "linked list") shows that
both are used.  Whatever people find easier to understand, I'll use.

>
> > +of the plist are sorted, such that it takes O(1) to retrieve the highest
> > +priority item in the list.  Obviously this is useful to store processes
> > +based on their priorities.
> > +
> > +Depth of the PI Chain
> > +---------------------
> > +
> > +The maximum depth of the PI chain is not dynamic, and could actually be
> > +defined.  But is very complex to figure it out, since it depends on all
> > +the nesting of mutexes.  Lets look at the example where we have 3 mutexes,
>                             Let's
> > +L1, L2, and L3, and four separate functions func1, func2, func3 and func4.
> > +The following shows a locking order of L1->L2->L3, but may not actually
> > +be directly nested that way.
>
> It would be good to use kernel coding style for these 4 functions....

You mean:

void func1(void)
{
	mutex_lock(L1);

	/* do anything */

	mutex_unlock(L1);
}


> > +mutex is not owned, this owner is set to NULL.  Since all architectures
> > +have the task structure on at least a four byte alignment (and if this is
> > +not true, the rtmutex.c code will be broken!), this allows for the least
> > +two significant bits to be used as flags.  This part is also described
> s/least two/two least/

OK,

> > +in Documentation/rt-mutex.txt, but will also be briefly descried here.
> s/descried/described/

Hmm, I wonder how that got by ispell?  oh wait, that is a real word!

> > +
> > +(Note:  if looking at the code, you will notice that the lower number of
> > +        prio is returned.  This is because the prio field in the task structure
> > +	is an inverse order of the actual priority.  So a "prio" of 5 is
> > +	of higher priority than a "prio" of 10).
> * move period before ')'

OK

>
> > +It is interesting to note that __rt_mutex_adjust_prio can either increase
> > +or decrease the priority of the task.  In the case that a higher priority
> > +process has just blocked on a mutex owned by the task, __rt_mutex_adjust_prio
> > +would increase/boost the task's priority.  But if a higher priority task
> > +were for some reason leave the mutex (timeout or signal), this same function
> s/leave/to leave/

OK

>
> > +would decrease/unboost the priority of the task.  That is because the pi_list
> > +always contains the highest priority task that is waiting on a mutex owned
> > +by the task, so we only need to compare the priority of that top pi waiter
> > +to the normal priority of the given task.
> > +
> > +
> > +High level overview of the PI chain walk
> > +----------------------------------------
> > +
> > +The rt_mutex_adjust_prio_chain can be used to both boost processes to higher
>    either to boost or lower process priorities.
> and drop the next line.

OK, if that makes it easier to understand.

> > +priorities, or sometimes it is used to lower priorities.
>
> > +The rt_mutex_adjust_prio_chain is called with a task to be checked for
> * drop "The"

OK

>
> > +PI (de)boosting (the owner of a mutex that a process is blocking on), a flag to
> > +check for deadlocking, the mutex that the task owns, and a pointer to a waiter
> > +that is the process' waiter struct that is blocked on the mutex (although this
>                process's
> > +parameter may be NULL for deboosting).
> > +
>
> > +A check is now done to see if the original waiter (the process that is blocked
> > +on the current mutex), is the top pi waiter of the task.  That is, is this
> * drop first comma

Yep

>
> > +waiter on the top of the task's pi_list.  If it is not, it either means that
> > +there is another process higher in priority that is blocked on one of the
> > +mutexes that the task owns, or that the waiter has just woken up via a signal
> > +or timeout and has left the PI chain.  In either case, the loop is exited, since
> > +we don't need to do any more changes to the priority of the current task, or any
> > +task that owns a mutex that this current task is waiting on.  A priority chain
> > +walk is only needed when a new top pi waiter is made to a task.
> > +
>
> > +Now that we have both the pi_lock of the task, as well as the wait_lock of
> * drop comma

OK

>
> > +the mutex the task is blocked on, we update the task's waiter's plist node
> > +that is located on the mutex's wait_list.
> > +
> > +Now we release the pi_lock of the task.
> > +
> > +Next the owner of the mutex has its pi_lock taken, so we can update the
> > +task's entry in the owner's pi_list.  If the task is the highest priority
> > +process on the mutex's wait_list, then we remove the previous top waiter
> > +from the owner's pi_list, and replace it with the task.
> > +
> > +Note: It is possible that the task was the current top waiter on the mutex
> * add comma after "mutex"

OK

>
> > +      in which case, the task is not yet on the pi_list of the waiter.  This
> * drop comma

OK

>
> > +      is OK, since plist_del does nothing if the plist node is not on any
> > +      list.
> > +
> > +If the task was not the top waiter of the mutex, but it was before we
> > +did the priority updates, that means we are deboosting/lowering the
> > +task.  In this case, the task is removed from the pi_list of the owner,
> > +and the new top waiter is added.
> > +
> > +Lastly, we unlock both the pi_lock of the task, as well as the mutex's
> > +wait_lock, and continue the loop again, this time the task is the owner
> s/this time/but this time/ (?)

How about "the next iteration will have the owner of the previous mutex as
the task"

> > +of the previous mutex.
> > +
> > +
> > +Note: One might think that the owner of this mutex might have changed
> > +      since we just grab the mutex's wait_lock. And one could be right.
> > +      The important thing to remember, is that the owner could not have
> * drop comma

OK

>
> > +      become the task that is being processed in the PI chain, since
> > +      we have taken that task's pi_lock at the beginning of the loop.
> > +      So as long as there is an owner of this mutex, that is not the same
> * drop comma

OK

>
> > +      process as the tasked being worked on, we are OK.
> > +
> > +Pending Owners and Lock stealing
> > +--------------------------------
> > +
> > +There's no reason a high priority process that gives up a mutex, should be
> * drop comma

OK

>
> > +penalized if it tries to take that mutex again.  If the new owner of the
> > +mutex has not woken up yet, there's no reason that the higher priority process
> > +could not take that mutex away.
> > +
> > +Taking of a mutex (The walk through)
> > +------------------------------------
> > +
> > +OK, now lets take a look at the detailed walk through of what happens when
>            let's

Yep

>
> > +taking a mutex.
> > +
> > +
> > +1) Has owner that is pending
> > +----------------------------
> * insert blank line to be consistent
>
> > +If there is waiters on this mutex, and we just stole the ownership, we need
> s/there is/there are/

OK

>
> > +to take the top waiter, remove it from the pi_list of the pending owner, and
> > +add it to the current pi_list.  Note that at this moment, the pending owner
> > +is no longer on the list of waiters.  This is fine, since the pending owner
> > +would add itself back when it realizes that it had the ownership stolen
> > +from itself.
>
> How does a pending owner realize that ownership was stolen?

Ah, I'll add more to explain that.

>
> > +3) Failed to grab ownership
> > +---------------------------
> > +
> > +Once again we try to take the mutex.  This will usually fail the first time
> > +in the loop, but not usually the second.
>
> A "why" here would be nice (why fail the first time but not the second
> time -- usually ?).

OK, I'll add that too.

>
> > +If the mutex is TASK_INTERRUPTIBLE a check for signals and timeout is done
> > +here.
> > +
> > +Task blocks on mutex
> > +--------------------
> > +
> > +Since the wait_lock was taken at the entry of the slow lock, we can safely
> > +add the waiter to the wait_list.  If the current process is the highest
> > +priority process currently waiting on this mutex, then we remove the
> > +previous top waiter process (if it exists) from the pi_list of the owner,
> > +and add the current process to that list.  Since the pi_list of the owner
> > +has changed, we call rt_mutex_adjust_prio on the owner to see if the owner
> > +should adjust it's priority accordingly.
>                  its

I must have been tired here, I'm usually good at its and it's

>
> > +If the owner is also blocked on a lock, and had it's pi_list changed
>                                                    its

Grr

>
> > +(or deadlock checking is on), we unlock the wait_lock of the mutex and go ahead
> > +and run rt_mutex_adjust_prio_chain on the owner, as described earlier.
> > +
>
> > +Unlocking the Mutex
> > +-------------------
> > +
> > +If the owner field has the "Has Waiters" bit set, (or CMPXCHG is not available)
> * move comma to after the ')'

OK

>
> > +the slow unlock path is taken.
> > +
> > +The first thing done in the slow unlock path is to take the wait_lock of the
> > +mutex.  This synchronizes the locking and unlocking of the mutex.
> > +
> > +A check is made to see if the mutex has waiters or not, this can be the case for
> > +architectures without CMPXCHG, or a waiter had hit the timeout or signal and
> > +removed itself between the time the "Has Waiters" bit was checked and this
> > +check.  If there are no waiters than the mutex owner field is set to NULL,
> > +the wait_lock is released and nothing more is needed.
>
> First sentence of paragraph above needs some work, but I can't tell
> what is intended so I can't fix it.

Ah, I don't like that explaination either.  Basically, what I'm trying to
say is that an architecture that doesn't have CMPXCHG will always check
for waiters on a lock here.  But for those archs that do have CMPXCHG, this
case is still needed.  One might think it's not, because the fast path
only goes into the slow path when CMPXCHG fails.  In other words, the
mutex has waiters.  But the check here is still needed, because if the
lock only has one waiter and it woke up by signal or timeout between the
CMPXCHG check and the grabbing of the wait_lock, the slowpath wont have
waiters.

Is something like the above a better description.  I wrote it quick, so I
will even explain it better when I send a patch (and spend more time on
it)

>
> > +Finally we unlock the pi_lock of the pending owner, and wake it up.
> * drop comma

OK

>
> > +Reviewers:  Ingo Molnar, Thomas Gleixner, and Thomas Duetsch.
> Randy Dunlap

Will add.  Thanks a lot!

-- Steve

