Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWCHUB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWCHUB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWCHUB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:01:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46057 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932562AbWCHUBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:01:55 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH rc5-mm] pids: kill PIDTYPE_TGID
References: <440DEADB.72C3A8A6@tv-sign.ru>
	<m11wxd27wx.fsf@ebiederm.dsl.xmission.com>
	<440EED04.57FF5594@tv-sign.ru>
	<m1slpsx61f.fsf@ebiederm.dsl.xmission.com>
	<440F2F4A.3E91C272@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Mar 2006 13:00:58 -0700
In-Reply-To: <440F2F4A.3E91C272@tv-sign.ru> (Oleg Nesterov's message of
 "Wed, 08 Mar 2006 22:23:54 +0300")
Message-ID: <m1irqovh8l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Changes:
> 	s/tgrp/thread_group/
>
> 	make it rcu-safe
>
> [PATCH rc5-mm] pids: kill PIDTYPE_TGID
>
> depends on pidhash-dont-count-idle-threads.patch
>
> This patch kills PIDTYPE_TGID pid_type thus saving one hash table
> in kernel/pid.c and speeding up subthreads create/destroy a bit.
> It is also a preparation for the further tref/pids rework.
>
> This patch adds 'struct list_head thread_group' to 'struct task_struct'
> instead.
>
> We don't detach group leader from PIDTYPE_PID namespace until another
> thread inherits it's ->pid == ->tgid, so we are safe wrt premature
> free_pidmap(->tgid) call.
>
> Currently there are no users of find_task_by_pid_type(PIDTYPE_TGID).
> Should the need arise, we can use find_task_by_pid()->group_leader.

Looks good.  I have one final nit.

> --- 2.6.16-rc5/kernel/fork.c~1_TGID	2006-03-09 00:17:24.000000000 +0300
> +++ 2.6.16-rc5/kernel/fork.c	2006-03-09 00:41:35.000000000 +0300
> @@ -1100,6 +1100,7 @@ static task_t *copy_process(unsigned lon
>  	 * We dont wake it up yet.
>  	 */
>  	p->group_leader = p;
> +	INIT_LIST_HEAD(&p->thread_group);
>  	INIT_LIST_HEAD(&p->ptrace_children);
>  	INIT_LIST_HEAD(&p->ptrace_list);
>  
> @@ -1153,7 +1154,9 @@ static task_t *copy_process(unsigned lon
>  			retval = -EAGAIN;
>  			goto bad_fork_cleanup_namespace;
>  		}
> +
>  		p->group_leader = current->group_leader;
> +		list_add_tail_rcu(&p->thread_group, &current->thread_group);
Can this be:
		list_add_tail_rcu(&p->thread_group, &current->group_leader->thread_group);

That way at least the odds of missing a new task_struct when doing an
rcu traversal are reduced almost to 0.

>  
>  		if (current->signal->group_stop_count > 0) {
>  			/*
> @@ -1201,7 +1204,6 @@ static task_t *copy_process(unsigned lon
>  			list_add_tail(&p->tasks, &init_task.tasks);
>  			__get_cpu_var(process_counts)++;
>  		}
> -		attach_pid(p, PIDTYPE_TGID, p->tgid);
>  		attach_pid(p, PIDTYPE_PID, p->pid);
>  		nr_threads++;
>  	}


Eric
