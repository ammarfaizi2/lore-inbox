Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422841AbWBNWby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbWBNWby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422844AbWBNWby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:31:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:11496 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422841AbWBNWby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:31:54 -0500
Date: Tue, 14 Feb 2006 14:32:14 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix kill_proc_info() vs copy_process() race
Message-ID: <20060214223214.GG1400@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43E77D3C.C967A275@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E77D3C.C967A275@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 07:45:48PM +0300, Oleg Nesterov wrote:
> kill_proc_info() takes taskllist_lock only for sig_kernel_stop()
> case nowadays. I beleive it races with copy_process().

For SIGCONT as well as well as sig_kernel_stop(), but yes, tasklist_lock
is now acquired only sometimes.  (And please accept my apologies for 
the late reply -- trouble with my local email system that I could not
fix from 8,000 miles away...)

> The first race is simple, copy_process:
> 
> 	/*
> 	 * Check for pending SIGKILL! The new thread should not be allowed
> 	 * to slip out of an OOM kill. (or normal SIGKILL.)
> 	 */
> 	if (sigismember(&current->pending.signal, SIGKILL))
> 		return EINTR;
> 
> This relies on tasklist_lock and is racy now.

Agreed, but is the race any worse than it was before?  Since SIGKILL is
fatal, the bit can be set but never cleared.  My belief, quite possibly
mistaken, is that this is a performance issue rather than a correctness
issue -- we would like to avoid the overhead of a fork() for a "walking
dead" process.

If my belief is incorrect, one fix would be to add SIGKILL to the checks
in kill_proc_info().

> The second race is more tricky, copy_process:
> 
> 	attach_pid(p, PIDTYPE_PID, p->pid);
> 	attach_pid(p, PIDTYPE_TGID, p->tgid);
> 
> This means that we can find a task in kill_proc_info()->find_task_by_pid()
> which is not registered as part of thread group yet. Various bad things can
> happen, note that handle_stop_signal(SIGCONT) and __group_complete_signal()
> iterate over threads list. But p->pids[PIDTYPE_TGID] is a copy of current's
> 'struct pid' from dup_task_struct(), and if we don't have CLONE_THREAD here
> we will use completely unreleated (parent's) thread list.

But handle_stop_signal() will not do anything except for sig_kernel_stop(),
SIGCONT, and SIGKILL.  The first two will have tasklist_lock held just
as before.  The latter (SIGKILL) does not iterate over anything, instead
it only sets p->signal->flags to zero.

On __group_complete_signal(), just to make sure I understand...  For this
to happen, we would have to kill() a child process while it was being
fork()ed, but before the parent was aware what the child's pid was, right?
And the race you are noting is that we might find the embryo process just
as it is checking for thread_group_leader(p), but before p->signal->tty,
p->signal_pgrp, and p->signal->session are initialized?

> I think we can solve these problems by enlarging a ->siglock's scope in
> copy_process(), but I don't know how to test this patch.

I have not convinced myself that this is a bug, but it might well
be.  The reason I am unconvinced is that if we have not done all the
attach_pid()s, the signal should not be able to find us.  Yes, we do
have a copy of the parent's p->pids[PIDTYPE_TGID], but this process is
not linked into the lists -- the process can find the parent, but not
vice versa.

But I could easily be missing something, still a bit jetlagged.  Could
you please lay out the exact sequence of events in the scenario that you
are thinking of?

And if there is a real problem, is it possible to fix it by changing
the order of the attach_pid() calls?

> NOTE: release_task()->__unhash_process() path is safe, we already have
> ->sighand == NULL while detaching PIDTYPE_PID/PIDTYPE_TGID nonatomically.

Agreed.

							Thanx, Paul

> Unless I missed something, I personally think this is a 2.6.16 material.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- RC-1/kernel/fork.c~	2006-02-06 22:04:40.000000000 +0300
> +++ RC-1/kernel/fork.c	2006-02-06 22:11:51.000000000 +0300
> @@ -1050,7 +1050,7 @@ static task_t *copy_process(unsigned lon
>  	sched_fork(p, clone_flags);
>  
>  	/* Need tasklist lock for parent etc handling! */
> -	write_lock_irq(&tasklist_lock);
> +	write_lock(&tasklist_lock);
>  
>  	/*
>  	 * The task hasn't been attached yet, so its cpus_allowed mask will
> @@ -1066,33 +1066,34 @@ static task_t *copy_process(unsigned lon
>  			!cpu_online(task_cpu(p))))
>  		set_task_cpu(p, smp_processor_id());
>  
> +	/* CLONE_PARENT re-uses the old parent */
> +	if (clone_flags & (CLONE_PARENT|CLONE_THREAD))
> +		p->real_parent = current->real_parent;
> +	else
> +		p->real_parent = current;
> +	p->parent = p->real_parent;
> +
> +	spin_lock_irq(&current->sighand->siglock);
>  	/*
>  	 * Check for pending SIGKILL! The new thread should not be allowed
>  	 * to slip out of an OOM kill. (or normal SIGKILL.)
>  	 */
>  	if (sigismember(&current->pending.signal, SIGKILL)) {
> -		write_unlock_irq(&tasklist_lock);
> +		spin_unlock_irq(&current->sighand->siglock);
> +		write_unlock(&tasklist_lock);
>  		retval = -EINTR;
>  		goto bad_fork_cleanup_namespace;
>  	}
>  
> -	/* CLONE_PARENT re-uses the old parent */
> -	if (clone_flags & (CLONE_PARENT|CLONE_THREAD))
> -		p->real_parent = current->real_parent;
> -	else
> -		p->real_parent = current;
> -	p->parent = p->real_parent;
> -
>  	if (clone_flags & CLONE_THREAD) {
> -		spin_lock(&current->sighand->siglock);
>  		/*
>  		 * Important: if an exit-all has been started then
>  		 * do not create this new thread - the whole thread
>  		 * group is supposed to exit anyway.
>  		 */
>  		if (current->signal->flags & SIGNAL_GROUP_EXIT) {
> -			spin_unlock(&current->sighand->siglock);
> -			write_unlock_irq(&tasklist_lock);
> +			spin_unlock_irq(&current->sighand->siglock);
> +			write_unlock(&tasklist_lock);
>  			retval = -EAGAIN;
>  			goto bad_fork_cleanup_namespace;
>  		}
> @@ -1122,8 +1123,6 @@ static task_t *copy_process(unsigned lon
>  			 */
>  			p->it_prof_expires = jiffies_to_cputime(1);
>  		}
> -
> -		spin_unlock(&current->sighand->siglock);
>  	}
>  
>  	/*
> @@ -1151,7 +1150,9 @@ static task_t *copy_process(unsigned lon
>  
>  	nr_threads++;
>  	total_forks++;
> -	write_unlock_irq(&tasklist_lock);
> +	spin_unlock_irq(&current->sighand->siglock);
> +	write_unlock(&tasklist_lock);
> +
>  	proc_fork_connector(p);
>  	return p;
> 
