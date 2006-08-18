Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWHRASt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHRASt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHRASt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:18:49 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:11405 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932309AbWHRASs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:18:48 -0400
Date: Fri, 18 Aug 2006 09:21:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: pj@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       acahalan@gmail.com, jdelvare@suse.de
Subject: Re: [RFC] ps command race fix
Message-Id: <20060818092139.b308825a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m1fyfvzdl2.fsf@ebiederm.dsl.xmission.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
	<20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
	<m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
	<20060813103434.17804d52.akpm@osdl.org>
	<m1zme8v4u9.fsf@ebiederm.dsl.xmission.com>
	<20060813121222.8210ccc2.pj@sgi.com>
	<20060816102344.b393aee6.kamezawa.hiroyu@jp.fujitsu.com>
	<m11wrg0xfd.fsf@ebiederm.dsl.xmission.com>
	<20060817153258.8dfe5973.kamezawa.hiroyu@jp.fujitsu.com>
	<m1fyfvzdl2.fsf@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 07:39:05 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> > static struct task_struct *next_tgid(unsigned int tgid)
> > {
> > 	struct task_struct *task;
> > 	struct pid *pid;
> > 
> > 	task = NULL;
> > 	rcu_read_lock();
> > retry:
> > 	pid = find_next_pid(tgid);
> > 	if (pid) {
> > 		tgid = pid->nr + 1;
> > 		task = pid_task(pid, PIDTYPE_PID);
> > 		if (!task || !thread_group_leader(task))
> > 			goto retry;
> > 		get_task_struct(task);
> > 	}
> > 	rcu_read_unlock();
> > 	return task;
> > 	
> > }
> 
> Seeking should now just work.
> 

Above function looks good. Is this patch based on 'struct pid' patch ?

BTW, the whole story is..
==
last_read_pid = find_next_pid(x);
possible_next_pid = last_read_pid + 1;
find_next_pid( possible_next_pid)
<call>-> if ( find_pid(possible_next_pid) == 0) {
		next = next_pidmap(maybe_next_pid + 1);
	 } else {
		next = maybe_next_pid;
	}
==

Why just do this by
==
next = next_pidmap(last_read_pid) ?
==

I don't think existing pids are contiguous in usual system.

-Kame


> ---
>  fs/proc/base.c      |   89 +++++++++++++---------------------------------------
>  include/linux/pid.h |    1 
>  kernel/pid.c        |   35 ++++++++++++++++++++
>  3 files changed, 59 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9943527..05dc244 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1813,70 +1813,28 @@ out:
>  }
>  
>  /*
> - * Find the first tgid to return to user space.
> + * Find the first task with tgid >= tgid
>   *
> - * Usually this is just whatever follows &init_task, but if the users
> - * buffer was too small to hold the full list or there was a seek into
> - * the middle of the directory we have more work to do.
> - *
> - * In the case of a short read we start with find_task_by_pid.
> - *
> - * In the case of a seek we start with &init_task and walk nr
> - * threads past it.
>   */
> -static struct task_struct *first_tgid(int tgid, unsigned int nr)
> +static struct task_struct *next_tgid(unsigned int tgid)
>  {
> -	struct task_struct *pos;
> -	rcu_read_lock();
> -	if (tgid && nr) {
> -		pos = find_task_by_pid(tgid);
> -		if (pos && thread_group_leader(pos))
> -			goto found;
> -	}
> -	/* If nr exceeds the number of processes get out quickly */
> -	pos = NULL;
> -	if (nr && nr >= nr_processes())
> -		goto done;
> -
> -	/* If we haven't found our starting place yet start with
> -	 * the init_task and walk nr tasks forward.
> -	 */
> -	for (pos = next_task(&init_task); nr > 0; --nr) {
> -		pos = next_task(pos);
> -		if (pos == &init_task) {
> -			pos = NULL;
> -			goto done;
> -		}
> -	}
> -found:
> -	get_task_struct(pos);
> -done:
> -	rcu_read_unlock();
> -	return pos;
> -}
> +	struct task_struct *task;
> +	struct pid *pid;
>  
> -/*
> - * Find the next task in the task list.
> - * Return NULL if we loop or there is any error.
> - *
> - * The reference to the input task_struct is released.
> - */
> -static struct task_struct *next_tgid(struct task_struct *start)
> -{
> -	struct task_struct *pos;
> +	task = NULL;
>  	rcu_read_lock();
> -	pos = start;
> -	if (pid_alive(start))
> -		pos = next_task(start);
> -	if (pid_alive(pos) && (pos != &init_task)) {
> -		get_task_struct(pos);
> -		goto done;
> +retry:
> +	pid = find_next_pid(tgid);
> +	if (pid) {
> +		tgid = pid->nr + 1;
> +		task = pid_task(pid, PIDTYPE_PID);
> +		if (!task || !thread_group_leader(task))
> +			goto retry;
> +		get_task_struct(task);
>  	}
> -	pos = NULL;
> -done:
>  	rcu_read_unlock();
> -	put_task_struct(start);
> -	return pos;
> +	return task;
> +	
>  }
>  
>  static int proc_pid_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
> @@ -1888,6 +1846,8 @@ static int proc_pid_fill_cache(struct fi
>  				proc_pid_instantiate, task, NULL);
>  }
>  
> +#define TGID_OFFSET (FIRST_PROCESS_ENTRY + ARRAY_SIZE(proc_base_stuff) - 1)
> +
>  /* for the /proc/ directory itself, after non-process stuff has been done */
>  int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
>  {
> @@ -1906,23 +1866,20 @@ int proc_pid_readdir(struct file * filp,
>  	}
>  	nr -= ARRAY_SIZE(proc_base_stuff) - 1;
>  
> -	/* f_version caches the tgid value that the last readdir call couldn't
> -	 * return. lseek aka telldir automagically resets f_version to 0.
> -	 */
> -	tgid = filp->f_version;
> -	filp->f_version = 0;
> -	for (task = first_tgid(tgid, nr);
> +	tgid = filp->f_pos - TGID_OFFSET;
> +	for (task = next_tgid(tgid);
>  	     task;
> -	     task = next_tgid(task), filp->f_pos++) {
> +	     task = next_tgid(tgid + 1)) {
>  		tgid = task->pid;
> +		filp->f_pos = tgid + TGID_OFFSET;
>  		if (proc_pid_fill_cache(filp, dirent, filldir, task, tgid) < 0) {
>  			/* returning this tgid failed, save it as the first
>  			 * pid for the next readir call */
> -			filp->f_version = tgid;
>  			put_task_struct(task);
> -			break;
> +			goto out;
>  		}
>  	}
> +	filp->f_pos = PID_MAX_LIMIT + TGID_OFFSET;
>  out:
>  	put_task_struct(reaper);
>  out_no_task:
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 9fd547f..d06d4ba 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -89,6 +89,7 @@ extern struct pid *FASTCALL(find_pid(int
>   * Lookup a PID in the hash table, and return with it's count elevated.
>   */
>  extern struct pid *find_get_pid(int nr);
> +extern struct pid *find_next_pid(int nr);
>  
>  extern struct pid *alloc_pid(void);
>  extern void FASTCALL(free_pid(struct pid *pid));
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 40e8e4d..112ff2a 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -145,6 +145,23 @@ static int alloc_pidmap(void)
>  	return -1;
>  }
>  
> +static int next_pidmap(int last)
> +{
> +	int offset;
> +	pidmap_t *map;
> +
> +	offset = (last + 1) & BITS_PER_PAGE_MASK;
> +	map = &pidmap_array[(last + 1)/BITS_PER_PAGE];
> +	for (; map < &pidmap_array[PIDMAP_ENTRIES]; map++, offset = 0) {
> +		if (unlikely(!map->page))
> +			continue;
> +		offset = find_next_bit((map)->page, BITS_PER_PAGE, offset);
> +		if (offset < BITS_PER_PAGE) 
> +			return mk_pid(map, offset);
> +	}
> +	return -1;
> +}
> +
>  fastcall void put_pid(struct pid *pid)
>  {
>  	if (!pid)
> @@ -307,6 +324,24 @@ struct pid *find_get_pid(pid_t nr)
>  EXPORT_SYMBOL_GPL(find_get_pid);
>  
>  /*
> + * Used by proc to find the pid with the next greater number.
> + * Specifying nr is used to handle the seek case.
> + */
> +struct pid *find_next_pid(int nr)
> +{
> +	struct pid *next;
> +
> +	next = find_pid(nr);
> +	while (!next) {
> +		nr = next_pidmap(nr);
> +		if (nr <= 0)
> +			break;
> +		next = find_pid(nr);
> +	}
> +	return next;
> +}
> +
> +/*
>   * The pid hash table is scaled according to the amount of memory in the
>   * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
>   * more.
> 

