Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWBXRew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWBXRew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBXRew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:34:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:53146 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932404AbWBXRev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:34:51 -0500
Date: Fri, 24 Feb 2006 09:35:19 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] copy_process: cleanup bad_fork_cleanup_sighand
Message-ID: <20060224173519.GA1735@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43F9E841.FD560455@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9E841.FD560455@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 07:03:13PM +0300, Oleg Nesterov wrote:
> The only caller of exit_sighand(tsk) is copy_process's error path.
> We can call __exit_sighand() directly and kill exit_sighand().
> 
> This 'tsk' was not yet registered in pid_hash[] or init_task.tasks,
> it has no external references, nobody can see it, and
> 
> 	IF (clone_flags & CLONE_SIGHAND)
> 		At least 'current' has a reference to ->sighand, this
> 		means atomic_dec_and_test(sighand->count) can't be true.
> 
> 	ELSE
> 		Nobody can see this ->sighand, this means we can free it
> 		without any locking.

This passes steamroller tests (which now work on ppc64, but that is another
story).  Looks good to me!

						Thanx, Paul

Acked-by: <paulmck@us.ibm.com>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.16-rc3/include/linux/sched.h~1_SIGH	2006-02-18 22:13:44.000000000 +0300
> +++ 2.6.16-rc3/include/linux/sched.h	2006-02-20 00:38:57.000000000 +0300
> @@ -1143,7 +1143,6 @@ extern void exit_thread(void);
>  extern void exit_files(struct task_struct *);
>  extern void exit_signal(struct task_struct *);
>  extern void __exit_signal(struct task_struct *);
> -extern void exit_sighand(struct task_struct *);
>  extern void __exit_sighand(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
> --- 2.6.16-rc3/kernel/signal.c~1_SIGH	2006-02-19 21:08:23.000000000 +0300
> +++ 2.6.16-rc3/kernel/signal.c	2006-02-20 00:37:34.000000000 +0300
> @@ -336,20 +336,6 @@ void __exit_sighand(struct task_struct *
>  		kmem_cache_free(sighand_cachep, sighand);
>  }
>  
> -void exit_sighand(struct task_struct *tsk)
> -{
> -	write_lock_irq(&tasklist_lock);
> -	rcu_read_lock();
> -	if (tsk->sighand != NULL) {
> -		struct sighand_struct *sighand = rcu_dereference(tsk->sighand);
> -		spin_lock(&sighand->siglock);
> -		__exit_sighand(tsk);
> -		spin_unlock(&sighand->siglock);
> -	}
> -	rcu_read_unlock();
> -	write_unlock_irq(&tasklist_lock);
> -}
> -
>  /*
>   * This function expects the tasklist_lock write-locked.
>   */
> --- 2.6.16-rc3/kernel/fork.c~1_SIGH	2006-02-18 01:11:59.000000000 +0300
> +++ 2.6.16-rc3/kernel/fork.c	2006-02-20 00:38:39.000000000 +0300
> @@ -1196,7 +1196,8 @@ bad_fork_cleanup_mm:
>  bad_fork_cleanup_signal:
>  	exit_signal(p);
>  bad_fork_cleanup_sighand:
> -	exit_sighand(p);
> +	if (p->sighand)
> +		__exit_sighand(p);
>  bad_fork_cleanup_fs:
>  	exit_fs(p); /* blocking */
>  bad_fork_cleanup_files:
