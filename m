Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWBYBsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWBYBsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWBYBsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:48:17 -0500
Received: from lead.cat.pdx.edu ([131.252.208.91]:4026 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S964845AbWBYBsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:48:17 -0500
Date: Fri, 24 Feb 2006 17:48:02 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200602250148.k1P1m2ce001979@adara.cs.pdx.edu>
To: oleg@tv-sign.ru
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH 3/4] cleanup __exit_signal()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The extent of the rcu readside critical section is determined 
by the corresponding placements of rcu_read_lock() and 
rcu_read_unlock().  Your recent [PATCH] convert sighand_cache 
to use SLAB_DESTROY_BY_RCU uncovered a comment that elicits 
this request for clarification.  (The initial motivation was in
seeing the introduction of an rcu_assign_pointer() and
looking for the corresponding rcu_dereference().)

Jul 13 2004 [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU (and 
consistent with slab.c in linux-2.6.16-rc3), struct slab_rcu 
is described:
 * struct slab_rcu
 *
 * slab_destroy on a SLAB_DESTROY_BY_RCU cache uses this structure to
 * arrange for kmem_freepages to be called via RCU.  This is useful if
 * we need to approach a kernel structure obliquely, from its address
 * obtained without the usual locking.  We can lock the structure to
 * stabilize it and check it's still at the given address, only if we
 * can be sure that the memory has not been meanwhile reused for some
 * other kind of object (which our subsystem's lock might corrupt).
 *
 * rcu_read_lock before reading the address, then rcu_read_unlock after
 * taking the spinlock within the structure expected at that address.

Does this mean that the rcu_read_lock() can safely occur just 
after the spin_lock(&sighand->siglock)?  Since I don't find an 
example that follows this interpretation of the comment, what 
is the intention?  Or, if so, what is the particular context?  
Looks like all kernel occurrences of rcu_dereference() 
with sighand arguments have, within the function definition, 
rcu_read_lock/unlock() pairs enclosing spin lock and unlock 
pairs except that in group_send_sig_info() with a comment on 
requiring rcu_read_lock or tasklist_lock.

An example is attached in your patch to move __exit_signal().  
It appears that the rcu readside critical section is in place to 
provide persistence of the task_struct.  __exit_sighand() calls
sighand_free(sighand) -- proposed to be renamed cleanup_sighand(tsk) 
to call kmem_cache_free(sighand_cachep, sighand) -- before 
spin_unlock(&sighand->siglock) is called in __exit_signal().

Thank you for any suggestions.

> Subject:    [PATCH 1/3] move __exit_signal() to kernel/exit.c
> From:       Oleg Nesterov
> Date:       2006-02-22 22:32:54
> 
> __exit_signal() is private to release_task() now.
> I think it is better to make it static in kernel/exit.c
> and export flush_sigqueue() instead - this function is
> much more simple and straightforward.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.16-rc3/include/linux/sched.h~1_MOVE	2006-02-20 21:00:09.000000000 +0300
> +++ 2.6.16-rc3/include/linux/sched.h	2006-02-23 00:23:40.000000000 +0300
> @@ -1143,7 +1143,6 @@ extern void exit_thread(void);
>  extern void exit_files(struct task_struct *);
>  extern void __cleanup_signal(struct signal_struct *);
>  extern void cleanup_sighand(struct task_struct *);
> -extern void __exit_signal(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
>  extern NORET_TYPE void do_group_exit(int);
> --- 2.6.16-rc3/include/linux/signal.h~1_MOVE	2006-01-19 18:13:07.000000000 +0300
> +++ 2.6.16-rc3/include/linux/signal.h	2006-02-23 00:36:27.000000000 +0300
> @@ -249,6 +249,8 @@ static inline void init_sigpending(struc
>  	INIT_LIST_HEAD(&sig->list);
>  }
>  
> +extern void flush_sigqueue(struct sigpending *queue);
> +
>  /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
>  static inline int valid_signal(unsigned long sig)
>  {
> --- 2.6.16-rc3/kernel/exit.c~1_MOVE	2006-02-17 00:05:25.000000000 +0300
> +++ 2.6.16-rc3/kernel/exit.c	2006-02-23 00:32:46.000000000 +0300
> @@ -29,6 +29,7 @@
>  #include <linux/cpuset.h>
>  #include <linux/syscalls.h>
>  #include <linux/signal.h>
> +#include <linux/posix-timers.h>
>  #include <linux/cn_proc.h>
>  #include <linux/mutex.h>
>  
> @@ -60,6 +61,68 @@ static void __unhash_process(struct task
>  	remove_parent(p);
>  }
>  
> +/*
> + * This function expects the tasklist_lock write-locked.
> + */
> +static void __exit_signal(struct task_struct *tsk)
> +{
> +	struct signal_struct *sig = tsk->signal;
> +	struct sighand_struct *sighand;
> +
> +	BUG_ON(!sig);
> +	BUG_ON(!atomic_read(&sig->count));
> +
> +	rcu_read_lock();
> +	sighand = rcu_dereference(tsk->sighand);
> +	spin_lock(&sighand->siglock);
> +
> +	posix_cpu_timers_exit(tsk);
> +	if (atomic_dec_and_test(&sig->count))
> +		posix_cpu_timers_exit_group(tsk);
> +	else {
> +		/*
> +		 * If there is any task waiting for the group exit
> +		 * then notify it:
> +		 */
> +		if (sig->group_exit_task && atomic_read(&sig->count) == sig->notify_count) {
> +			wake_up_process(sig->group_exit_task);
> +			sig->group_exit_task = NULL;
> +		}
> +		if (tsk == sig->curr_target)
> +			sig->curr_target = next_thread(tsk);
> +		/*
> +		 * Accumulate here the counters for all threads but the
> +		 * group leader as they die, so they can be added into
> +		 * the process-wide totals when those are taken.
> +		 * The group leader stays around as a zombie as long
> +		 * as there are other threads.  When it gets reaped,
> +		 * the exit.c code will add its counts into these totals.
> +		 * We won't ever get here for the group leader, since it
> +		 * will have been the last reference on the signal_struct.
> +		 */
> +		sig->utime = cputime_add(sig->utime, tsk->utime);
> +		sig->stime = cputime_add(sig->stime, tsk->stime);
> +		sig->min_flt += tsk->min_flt;
> +		sig->maj_flt += tsk->maj_flt;
> +		sig->nvcsw += tsk->nvcsw;
> +		sig->nivcsw += tsk->nivcsw;
> +		sig->sched_time += tsk->sched_time;
> +		sig = NULL; /* Marker for below. */
> +	}
> +
> +	tsk->signal = NULL;
> +	cleanup_sighand(tsk);
> +	spin_unlock(&sighand->siglock);
> +	rcu_read_unlock();
> +
> +	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
> +	flush_sigqueue(&tsk->pending);
> +	if (sig) {
> +		flush_sigqueue(&sig->shared_pending);
> +		__cleanup_signal(sig);
> +	}
> +}

