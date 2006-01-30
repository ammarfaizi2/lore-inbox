Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWA3EPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWA3EPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 23:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWA3EPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 23:15:16 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:51926 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750878AbWA3EPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 23:15:14 -0500
Date: Sun, 29 Jan 2006 20:14:36 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, lock validator] fix uidhash_lock <-> RCU deadlock
Message-ID: <20060130041436.GD16585@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060125142307.GA5427@elte.hu> <20060126111352.GF4953@us.ibm.com> <Pine.LNX.4.64.0601271920000.3192@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601271920000.3192@evo.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 07:22:15PM -0500, Linus Torvalds wrote:
> 
> 
> On Thu, 26 Jan 2006, Paul E. McKenney wrote:
> >
> > On Wed, Jan 25, 2006 at 03:23:07PM +0100, Ingo Molnar wrote:
> > > RCU task-struct freeing can call free_uid(), which is taking 
> > > uidhash_lock - while other users of uidhash_lock are softirq-unsafe.
> > 
> > I guess I get to feel doubly stupid today.  Good catch, great tool!!!
> 
> I wonder if the right fix wouldn't be to free the user struct early, 
> instead of freeing it from RCU. Hmm?

OK, I finally dug through this, and, unless I am missing something,
no can do...  :-/

Here is the situation that seems to me to make freeing the user struct
early to be problematic:

1.	Concurrently, task B running on CPU 1 sends a signal to task A.
	Execution eventually reaches kill_proc_info(), which does an
	rcu_read_lock(), finds Task A via find_task_by_pid(), and invokes
	group_send_sig_info().

	Then group_send_sig_info() checks permissions, obtains a reference
	to task A's sighand struct, and invokes __group_send_sig_info.

	Task B then is delayed, perhaps by an interrupt, perhaps by
	an ECC memory error, or by whatever.

2.	Task A on CPU 0 executes do_exit(), eventually entering the
	scheduler.

3.	Task A's parent running on CPU 0 does a wait, eventually calling
	release_task().  If we were to release user struct early,
	put_task_struct() (called from release_task()) would be the
	latest reasonable place to do it.
	
	So CPU 0 calls free_uid(), and if this is the last task
	owned by the user in question, frees the user_struct.

4.	Task B continues executing, with __group_send_sig_info()
	invoking send_signal().

	send_signal() does some checks, then invokes __sigqueue_alloc()
	to get some memory with which to queue up the signal.

	The first thing that __sigqueue_alloc() does is to atomically
	increment the now-freed &t->user->sigpending of task A, which
	could be a life-changing religious experience for whatever CPU
	might have allocated the newly freed user structure.

Thoughts?  Am I missing something here?

See below for my rough notes while digging through the code, should
you be sufficiently masochistic.  More on one of the issues in a
separate email...

						Thanx, Paul

------------------------------------------------------------------------

Can the user struct be freed early when exiting, so that free_uid()
always acquires the uidhash_lock from process context?

o	Code on signal-RCU path -- does it reference struct user_struct?

	o	exit_sighand() does its rcu_read_lock() operations
		under a write-acquisition of tasklist_lock.  It acquires
		sighand->siglock, then invokes __exit_sighand().

		__exit_sighand NULLs out tsk->sighand, then
		decrements the reference count, and, if zero,
		invokes sighand_free().

		sighand_free() is a wrapper for call_rcu().

		No user_struct access here.

	o	__exit_signal() is called from the exit path
		(release_task()) and also from any operation (such
		as exec()) that disassociates a task from its current
		signal handlers.  Note that tasklist_lock is write-held
		across the call from release_task().  Ditto the call
		from exit_signal().

		After the rcu_read_lock(), __exit_signal() picks
		up a reference to task->sighand, acquires the siglock,
		and then calls posix_cpu_timers_exit().

		posix_cpu_timers_exit() does not reference the user
		structure, nor does posix_cpu_timers_exit_group().

		__exit_signal() can also call flush_sigqueue(),
		which in turn can invoke __sigqueue_free(), which
		in turn does a free_uid() -- which manipulates
		the user struct.  But it does so from process
		context and presumably has its own reference,
		so should be OK.

		The call to wake_up_process() should also be OK,
		since if both tasks share the user struct, the
		reference count must have been non-zero, and we
		must still have it around.

		__exit_sighand() was covered earlier.

	o	kill_proc_info() calls find_task_by_pid(), which
		in turn calls down through find_pid(), and does not
		touch the user struct.

		group_send_sig_info() calls check_kill_permission(),
		which in turn invokes capable() and security_task_kill(),
		which might want to look at things in the user structure.
		But which does not currently appear to do.

		group_send_sig_info() calls __group_send_sig_info(),
		which calls send_signal(), which calls __sigqueue_alloc(),
		which manipulates the user_struct of the target task.

		@@@  So we most definitely may -not- move free_uid()
		out of the RCU callback!!!!!!!

o	Dependencies on exit() path:

	o	Can we get rid of user_struct before getting rid
		of sighand_struct?

o	Uses of "struct user_struct" -- is there anywhere else that
	accesses this from non-process context?

	The task_struct contains a field named "user", which is of
	type "struct user_struct".  It contains a reference count,
	an atomic count of the number of processes, files, and
	signals pending, along with atomic counts of inotify watches
	and devices.  It contains mqueue and mlocked-shm limits,
	UID and session keyrings, a struct list_head for the
	uidhash_list, and finally the actual uid itself.

	o	the uidhash_list field is manipulated in uid_hash_insert(),
		uid_hash_remove(), and uid_hash_find().

		uid_hash_insert() is always protected by uid_hash_lock(),
		called from either uid_cache_init() (which inserts the
		entry for root) or from alloc_uid().  Despite its name,
		alloc_uid() either allocates a new user_struct or finds
		an existing one.  This appears to be called solely from
		process context.  Sharing of user_struct among tasks
		is accommodated by the reference count.

		uid_hash_remove() is always protected by uidhash_lock,
		and is called from free_uid().

		uid_hash_find() is called from alloc_uid(), covered
		earlier, and by find_user(), which also protects
		with uidhash_lock.  The find_user() primitive is
		always invoked from a system call, and thus from
		process context.

	o	The sigpending field is a count of the number of signals
		pending against all processes owned by the corresponding
		user.  This seems to be most likely to be affected by
		RCU usage.  This field is used in the following places:

		include/linux/sched.h <global> 383 struct sigpending shared_pending;
		include/linux/sched.h <global> 499 atomic_t sigpending;
		include/linux/sched.h <global> 812 struct sigpending pending;
		fs/proc/array.c task_sig 267 qsize = atomic_read(&p->user->sigpending);
		kernel/signal.c __sigqueue_alloc 271 atomic_inc(&t->user->sigpending);
		kernel/signal.c __sigqueue_alloc 273 atomic_read(&t->user->sigpending) <=
		kernel/signal.c __sigqueue_alloc 277 atomic_dec(&t->user->sigpending);
		kernel/signal.c __sigqueue_free 290 atomic_dec(&q->user->sigpending);
		kernel/user.c alloc_uid 122 atomic_set(&new->sigpending, 0);

o	The /proc entries seem to be protected by acquiring a reference
	to the corresponding task structure.  [Not sure what locking
	dance protects an exiting task in this case.]

If it turns out to be OK, how to fix the code?

o	Move the free_uid() from __put_task_struct() to put_task_struct().

	o	Need to check callers to __put_task_struct() and also
		to __put_task_struct_cb()!!!

		o	__put_task_struct() is called only from
			__put_task_struct_cb(), so is OK.

		o	In the mainline tree, __put_task_struct_cb() is
			only used by passing to call_rcu() in
			put_task_struct().  However, it is also
			subject to EXPORT_SYMBOL_GPL()!!!

			Options:

			1.	Rename the current __put_task_struct_cb()
				to __put_task_struct_rcu().  Make a new
				__put_task_struct_cb(), which is still
				EXPORT_SYMBOL_GPL(), that invokes
				free_uid() and whatever else is needed,
				then calls __put_task_struct_rcu().
				Add __put_task_struct_cb() on the
				features_removal_schedule.txt list
				with a one-year timeout.

			2.	Just do nothing -- people calling the
				exported __put_task_struct_cb() get
				hit, perhaps.

				Check to see where the export came
				from -- did I add it???

	o	Need to verify that audit_free() and security_free()
		do not need user_struct.  Or, if they do, need to check
		whether they can also move into put_task_struct().

		o	audit_free() invokes audit_get_context()
			under task_lock().  The audit_get_context()
			primitive invokes audit_filter_syscall(),
			but otherwise just hands back a struct
			containing copies of task_struct fields.

			audit_filter_syscall() loops through the
			AUDIT_FILTER_EXIT header of the audit_filter_list
			array, invoking audit_filter_rules() on
			matches.

			audit_filter_rules() does not access the user struct.

		@@@ Seems safest to move the contents of __put_task_struct()
		down to and including put_group_info() to put_task_struct().
		The WARN_ON() calls may be duplicated, -except- for
		the check on whether self is exiting, since it looks
		to be possible to get there via "state == EXIT_DEAD"
		in exit_notify().  Though this would really mess up
		do_exit()!!!

		o	exit_notify() can set EXIT_DEAD if the
			task's exit_signal is -1, the task is not
			ptraced, and the task's parent is undergoing
			signal-group exit.

		o	exit_notify() will then do a release_task()
			just before returning, possibly to do_exit().

		o	do_exit() does not preempt_disable() until
			a few statements later, so it could hand
			the scheduler a task structure with a lit
			fuse!!!

		So, should the preempt_disable() in do_exit() move
		to precede the exit_notify() call?  Or does some
		sort of locking prevent a child from doing an exit()
		while its parent is catching a group signal?  How
		about the case where the child is process-group leader
		of its own process?  Or does the setting of
		SIGNAL_GROUP_EXIT and the reparenting happen under
		the same acquisition of tasklist_lock?  This does
		-not- appear to be the case when some process other
		than the parent in the parent's group receives a
		fatal group signal -- the parent is awakened to
		kill itself in that case.  @@@

		@@@	mpol_free() seems to tolerate being called
			under preempt_disable().  But it takes locks,
			which would cause problems in -rt.

		@@@	Ditto for mutex_debug_check_no_locks_held().

			Could do rcu_read_lock() inside exit_notify(),
			and rcu_read_unlock() just after the
			preempt_disable().  But this fails,
			since proc_pid_flush, called from
			release_task(), can sleep.

		@@@ Alternative approach would be to push the
		EXIT_DEAD release_task into a work queue -- or
		back to init().

		Could probably -only- move free_uid(), but...
