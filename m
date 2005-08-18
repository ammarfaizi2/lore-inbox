Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVHRB6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVHRB6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 21:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVHRB6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 21:58:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932089AbVHRB6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 21:58:02 -0400
Date: Wed, 17 Aug 2005 18:57:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
Subject: Re: [PATCH 2.6.13-rc6 2/2] New Syscall: set rlimits of any process (update)
Message-ID: <20050818015739.GQ7991@shell0.pdx.osdl.net>
References: <1124326652.8359.3.camel@w2> <1124326935.8359.6.camel@w2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124326935.8359.6.camel@w2>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Wieland Gmeiner (e8607062@student.tuwien.ac.at) wrote:
> diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-getprlimit/include/linux/security.h linux-2.6.13-rc6-setprlimit/include/linux/security.h
> --- linux-2.6.13-rc6-getprlimit/include/linux/security.h	2005-08-17 03:11:32.000000000 +0200
> +++ linux-2.6.13-rc6-setprlimit/include/linux/security.h	2005-08-18 01:28:05.000000000 +0200
> @@ -591,6 +591,15 @@ struct swap_info_struct;
>   *	@resource contains the resource whose limit is being set.
>   *	@new_rlim contains the new limits for @resource.
>   *	Return 0 if permission is granted.
> + * @task_setprlimit:
> + *	Check permission before setting the resource limits of process @p
> + *	for @resource to @new_rlim.  The old resource limit values can
> + *	be examined by dereferencing (p->signal->rlim + resource).
> + *	@p contains the task struct of the process whose resource limit is
> + *	being set.
> + *	@resource contains the resource whose limit is being set.
> + *	@new_rlim contains the new limits for @resource.
> + *	Return 0 if permission is granted.
>   * @task_setscheduler:
>   *	Check permission before setting scheduling policy and/or parameters of
>   *	process @p based on @policy and @lp.
> @@ -1157,6 +1166,8 @@ struct security_operations {
>  	int (*task_setgroups) (struct group_info *group_info);
>  	int (*task_setnice) (struct task_struct * p, int nice);
>  	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
> +	int (*task_setprlimit) (struct task_struct * p, unsigned int resource,
> +				struct rlimit * new_rlim);

No need for a new hook.  They do the same thing.  Just collapse into one.

> diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-getprlimit/kernel/sys.c linux-2.6.13-rc6-setprlimit/kernel/sys.c
> --- linux-2.6.13-rc6-getprlimit/kernel/sys.c	2005-08-17 23:56:40.000000000 +0200
> +++ linux-2.6.13-rc6-setprlimit/kernel/sys.c	2005-08-18 01:44:25.000000000 +0200
> @@ -1561,6 +1561,27 @@ asmlinkage long sys_old_getrlimit(unsign
>  
>  #endif
>  
> +static inline void check_process_timer(struct task_struct *task,
> +				       unsigned int resource,
> +				       struct rlimit *new_rlim,
> +				       int holds_lock)
> +{
> +	if (resource == RLIMIT_CPU && new_rlim->rlim_cur != RLIM_INFINITY &&
> +	    (cputime_eq(task->signal->it_prof_expires, cputime_zero) ||
> +	     new_rlim->rlim_cur <= cputime_to_secs(
> +		     task->signal->it_prof_expires))) {
> +		cputime_t cputime = secs_to_cputime(new_rlim->rlim_cur);
> +		if (!holds_lock)
> +			read_lock(&tasklist_lock);

This is not a great idea.  Please rework so that locking isn't
conditional like that.

> +		spin_lock_irq(&task->sighand->siglock);
> +		set_process_cpu_timer(task, CPUCLOCK_PROF,
> +				      &cputime, NULL);
> +		spin_unlock_irq(&task->sighand->siglock);
> +		if (!holds_lock)
> +			read_unlock(&tasklist_lock);
> +	}
> +}
> +
>  asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit __user *rlim)
>  {
>  	struct rlimit new_rlim, *old_rlim;
> @@ -1570,8 +1591,8 @@ asmlinkage long sys_setrlimit(unsigned i
>  		return -EINVAL;
>  	if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
>  		return -EFAULT;
> -       if (new_rlim.rlim_cur > new_rlim.rlim_max)
> -               return -EINVAL;
> +	if (new_rlim.rlim_cur > new_rlim.rlim_max)
> +		return -EINVAL;
>  	old_rlim = current->signal->rlim + resource;
>  	if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
>  	    !capable(CAP_SYS_RESOURCE))
> @@ -1587,18 +1608,7 @@ asmlinkage long sys_setrlimit(unsigned i
>  	*old_rlim = new_rlim;
>  	task_unlock(current->group_leader);
>  
> -	if (resource == RLIMIT_CPU && new_rlim.rlim_cur != RLIM_INFINITY &&
> -	    (cputime_eq(current->signal->it_prof_expires, cputime_zero) ||
> -	     new_rlim.rlim_cur <= cputime_to_secs(
> -		     current->signal->it_prof_expires))) {
> -		cputime_t cputime = secs_to_cputime(new_rlim.rlim_cur);
> -		read_lock(&tasklist_lock);
> -		spin_lock_irq(&current->sighand->siglock);
> -		set_process_cpu_timer(current, CPUCLOCK_PROF,
> -				      &cputime, NULL);
> -		spin_unlock_irq(&current->sighand->siglock);
> -		read_unlock(&tasklist_lock);
> -	}
> +	check_process_timer(current, resource, &new_rlim, 0);
>  
>  	return 0;
>  }
> @@ -1660,6 +1670,62 @@ out_nounlock:
>  	return retval;
>  }
>  
> +asmlinkage long sys_setprlimit(pid_t pid, unsigned int resource,
> +			       struct rlimit __user *rlim)
> +{
> +	struct rlimit new_rlim, *old_rlim;
> +	int retval;
> +	task_t *p;
> +
> +	if (resource >= RLIM_NLIMITS)
> +		return -EINVAL;
> +	if (pid < 0)
> +		return -EINVAL;
> +	if (copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
> +		return -EFAULT;
> +	if (new_rlim.rlim_cur > new_rlim.rlim_max)
> +		return -EINVAL;
> +
> +	retval = -ESRCH;
> +	if (pid == 0) {
> +		p = current;
> +	} else {
> +		read_lock(&tasklist_lock);
> +		p = find_task_by_pid(pid);

Don't do this conditional locking.  Just hold lock in either case.
Makes cleanup on errors easier, and code simpler to read.

> +	}
> +	if (p) {
> +		retval = -EPERM;
> +		if (!prlim_check_perm(p))
> +			goto out_unlock;
> +
> +		old_rlim = p->signal->rlim + resource;
> +		if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
> +		    !capable(CAP_SYS_RESOURCE))
> +			goto out_unlock;
> +		if (resource == RLIMIT_NOFILE && new_rlim.rlim_max > NR_OPEN)
> +			goto out_unlock;
> +
> +		retval = security_task_setprlimit(p, resource, &new_rlim);
> +		if (retval)
> +			goto out_unlock;
> +
> +		task_lock(p->group_leader);
> +		*old_rlim = new_rlim;
> +		task_unlock(p->group_leader);
> +		retval = 0;

Again, rather than duplicate this code, share functionality with the
old setrlimit.  Also, you missed the compat entries.

There have been some patches floating about to do that (at least
for getrlimit) in /proc.  Did you consider that approach?  Oh, btw,
I _thought_ {get,set}prlimit() already existed in BSD with slightly
different parameters.

> +
> +		check_process_timer(p, resource, &new_rlim, 1);
> +	}
> +	if (pid == 0)
> +		goto out_nounlock;
> +
> +out_unlock:
> +	read_unlock(&tasklist_lock);
> +
> +out_nounlock:
> +	return retval;
> +}
> +
>  /*
>   * It would make sense to put struct rusage in the task_struct,
>   * except that would make the task_struct be *really big*.  After
