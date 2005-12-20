Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVLTUmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLTUmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVLTUmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:42:45 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:65188 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932086AbVLTUmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:42:44 -0500
Date: Tue, 20 Dec 2005 21:42:07 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
Subject: Re: Recursion bug in -rt
In-Reply-To: <1135107232.13138.348.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10512202042300.1720-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Steven Rostedt wrote:

> On Tue, 2005-12-20 at 18:43 +0100, Esben Nielsen wrote:
> > 
> > On Tue, 20 Dec 2005, Dinakar Guniguntala wrote:
> > 
> > > On Tue, Dec 20, 2005 at 02:19:56PM +0100, Ingo Molnar wrote:
> > > > 
> > > > hm, i'm looking at -rf4 - these changes look fishy:
> > > > 
> > > > -       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> > > > +       if (current != lock_owner(lock)->task)
> > > > +               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> > > > 
> > > > why is this done?
> > > >
> > >  
> > > Ingo, this is to prevent a kernel hang due to application error.
> > > 
> > > Basically when an application does a pthread_mutex_lock twice on a
> > > _nonrecursive_ mutex with robust/PI attributes the whole system hangs.
> > > Ofcourse the application clearly should not be doing anything like
> > > that, but it should not end up hanging the system either
> > >
> > 
> > Hmm, reading the comment on the function, wouldn't it be more natural to
> > use 
> >     if(task != lock_owner(lock)->task)
> > as it assumes that task->pi_lock is locked, not that current->pi_lock is
> > locked.
> > 
> > By the way:
> >  task->pi_lock is taken. lock_owner(lock)->task->pi_lock will be taken.
> > What if the task lock_owner(lock)->task tries to lock another futex,
> > (lock2) with which has lock_owner(lock2)->task==task.
> > Can't you promote a user space futex deadlock into a kernel spin deadlock 
> > this way?
> 
> Yes!
> 
> The locking code of the pi locks in the rt.c code is VERY dependent on
> the order of locks taken.  It works by assuming the order of locks taken
> will not themselves cause a deadlock.  I just recently submitted a patch
> to Ingo because I found that mutex_trylock can cause a deadlock, since
> it is not bound to the order of locks.
> 
> So, to answer your question more formal this time.  If the futex code
> uses the pi_lock code in rt.c and the futex causes a deadlock, then the
> kernel can deadlock too.
> 
This is ok for kernel mutexes, which are supposed not to cause deadlocks.
But user space deadlocks must not cause kernel deadlocks. Therefore the
robust futex code _must_ be fixed.

> The benefit of this locking order is that we got rid of the global
> pi_lock, and that was worth the problems you face today.
>

I believe this problem can be solved in the pi_lock code - but it will
require quite a bit of recoding. I started on it a little while ago but
didn't at all get the time to get into anything to even compile :-(
I don't have time to finish any code at all but I guess I can plant an
the idea instead:

When resolving the mutex chain (task A locks mutex 1 owned by B blocked
on 2 owned by C etc) for PI boosting and also when finding deadlocks,
release _all_ locks before going to the next step in the chain. Use
get_task_struct on the next task in the chain, release the locks,
take the pi_locks in a fixed order (sort by address forinstance), do the
PI boosting, get_task_struct on the next lock, release all the locks, do
the put_task_struct() on the previous task etc.
This a lot more expensive approach as it involves double as many spinlock
operations and get/put_task_struct() calls , but it has the added benifit
of reducing the overall system latency for long locking chains as there
are spots where interrupts and preemption will be enabled for each step in
the chain. Remember also that deep locking chains should be considered an
exeption so the code doesn't have to be optimal wrt. performance. 

I added my feeble attempts to implement this below. I have no chance of
ever getting time finish it :-(

> -- Steve
> 
> 

This is a "near" replacement for task_blocks_on_lock(). It leaves with all
spinlocks unlocked. A lot of other code needs to be changed as well to
accept the new right order of locking.

static void
task_blocks_on_lock2(struct rt_mutex_waiter *waiter, struct thread_info *ti,
		    struct rt_mutex *lock __EIP_DECL__)
{
	task_t *owner, *blocked_task = ti->task;

#ifdef CONFIG_RT_DEADLOCK_DETECT
	/* mark the current thread as blocked on the lock */
	waiter->eip = eip;
#endif
	
	blocked_task->blocked_on = waiter;
	waiter->lock = lock;
	waiter->ti = blocked_task->thread_info;
	waiter->on_pi_waiters = 0;
	plist_init(&waiter->pi_list, blocked_task->prio);
	plist_init(&waiter->list, blocked_task->prio);

	SMP_TRACE_BUG_ON_LOCKED(!spin_is_locked(&blocked_task->pi_lock));
	SMP_TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));

	plist_add(&waiter->list, &lock->wait_list);
	set_lock_owner_pending(lock);

	owner = lock_owner_task(lock);
	/* Put code to grab the lock and return on success here */
	
	/* Code for waiting: */
	get_task_struct(owner);
	get_task_struct(blocked_task);
	blocked_task->blocked_on = waiter;
	
	_raw_spin_unlock(&lock->wait_lock);
	_raw_spin_unlock(&current->pi_lock);
	
	while(owner) {
		/* No spin-locks held here! */
		
		struct rt_mutex *this_lock;
		task_t *next_owner = NULL;
		
		if(owner-blocked_task<0) {
			_raw_spin_lock(&owner->pi_lock);
			_raw_spin_lock(&blocked_task->pi_lock);
		}
		else {
			_raw_spin_lock(&blocked_task->pi_lock);
			_raw_spin_lock(&owner->pi_lock);
		}

		if(!blocked_task->blocked_on ||
		   !blocked_task->blocked_on->ti) {
			/* The lock have been released!! */
			_raw_spin_unlock(&blocked_task->pi_lock);
			_raw_spin_unlock(&owner->pi_lock);
			put_task_struct(owner);
			break;			
		}
 		waiter = blocked_task->blocked_on;
		this_lock = waiter->lock;
		_raw_spin_lock(&this_lock->wait_lock);
		if(lock_owner_task(this_lock)!=owner) {
			/* Ups, owner have changed 
			   redo it with the new owner */
			next_owner = lock_owner_task(this_lock);
			if(next_owner)
				get_task_struct(next_owner);
			_raw_spin_unlock(&this_lock->wait_lock);
			_raw_spin_unlock(&blocked_task->pi_lock);
			_raw_spin_unlock(&owner->pi_lock);
			put_task_struct(owner);
			owner = next_owner;
			continue;
		}

		/* Prio might have changed - it does so in the
		   previous loop. So the lists needs to be resorted 
		*/
		plist_del(&waiter->list, &lock->wait_list);
		plist_init(&waiter->list, blocked_task->prio);
		plist_add(&waiter->list, &lock->wait_list);

		if(waiter->on_pi_waiters) {
			plist_del(&waiter->pi_list,
				  &owner->pi_waiters);
			waiter->on_pi_waiters = 0;
		}

		/* We only need the highest priority waiter on 
		   owner->pi_list  */
		if(plist_first_entry(&lock->wait_list,
				      struct rt_mutex_waiter, pi_list) 
		   == waiter) {
			plist_init(&waiter->pi_list, blocked_task->prio);
			plist_add(&waiter->pi_list, 
				  &owner->pi_waiters);
			waiter->on_pi_waiters = 1;
		}

		_raw_spin_unlock(&this_lock->wait_lock);
		_raw_spin_unlock(&blocked_task->pi_lock);
		if(DEADLOCK_DETECT || owner->prio > blocked_task->prio) {
			if(owner->prio > blocked_task->prio)
				mutex_setprio(owner,blocked_task->prio);
			if(owner->blocked_on) {
				waiter = owner->blocked_on;
				_raw_spin_lock(&waiter->lock->wait_lock);
				next_owner = lock_owner_task(waiter->lock);
				if(next_owner)
					get_task_struct(next_owner);
                                _raw_spin_unlock(&waiter->lock->wait_lock);
			}
		}
		put_task_struct(blocked_task);
		blocked_task = owner;
		owner = next_owner;
        }
	BUG_ON(!blocked_task);
	put_task_struct(blocked_task);
}


