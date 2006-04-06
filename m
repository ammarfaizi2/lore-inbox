Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWDFXAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWDFXAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDFXAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:00:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61621 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932227AbWDFXAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:00:34 -0400
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
References: <20060406220403.GA205@oleg>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 06 Apr 2006 16:58:58 -0600
In-Reply-To: <20060406220403.GA205@oleg> (Oleg Nesterov's message of "Fri, 7
 Apr 2006 02:04:03 +0400")
Message-ID: <m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On top of
> 	task-make-task-list-manipulations-rcu-safe.patch
> 	
> This patch
> 	pidhash-kill-switch_exec_pids.patch
>
> changed de_thread() so that it doesn't remove 'leader' from it's thread group.
> However de_thread() still adds current to init_task.tasks without removing
> 'leader' from this list. What if another CLONE_VM task starts do_coredump()
> after de_thread() drops tasklist_lock but before it calls release_task(leader) ?
>
> do_coredump()->zap_threads() will find this thread group twice on
> init_task.tasks
> list. And it will increment mm->core_waiters twice for the new leader (current
> in
> de_thread). So, exit_mm()->complete(mm->core_startup_done) doesn't happen, and
> we
> have a deadlock.

Ack.  The evils of de_thread!

We need this to keep from seeing the same task twice in
do_each_thread.

This bug is in 2.6.17-rc1 so this code needs to go to Linus
sometime soon.

Eric


> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
> --- MM/fs/exec.c~0_DET	2006-04-06 22:37:33.000000000 +0400
> +++ MM/fs/exec.c	2006-04-06 22:51:51.000000000 +0400
> @@ -713,7 +713,7 @@ static int de_thread(struct task_struct 
>  		attach_pid(current, PIDTYPE_PID,  current->pid);
>  		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
>  		attach_pid(current, PIDTYPE_SID,  current->signal->session);
> -		list_add_tail_rcu(&current->tasks, &init_task.tasks);
> +		list_replace_rcu(&leader->tasks, &current->tasks);
>  
>  		current->parent = current->real_parent = leader->real_parent;
>  		leader->parent = leader->real_parent = child_reaper;
> --- MM/kernel/exit.c~0_DET	2006-03-23 23:02:53.000000000 +0300
> +++ MM/kernel/exit.c	2006-04-06 23:01:37.000000000 +0400
> @@ -55,7 +55,9 @@ static void __unhash_process(struct task
>  		detach_pid(p, PIDTYPE_PGID);
>  		detach_pid(p, PIDTYPE_SID);
>  
> -		list_del_rcu(&p->tasks);
> +		/* see de_thread()->list_replace_rcu() */
> +		if (likely(p->tasks.prev != LIST_POISON2))
> +			list_del_rcu(&p->tasks);
>  		__get_cpu_var(process_counts)--;
>  	}
>  	list_del_rcu(&p->thread_group);
