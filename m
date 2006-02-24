Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWBXSEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWBXSEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWBXSEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:04:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30620 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932383AbWBXSEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:04:08 -0500
Date: Fri, 24 Feb 2006 10:04:36 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 4/4] rename __exit_sighand to cleanup_sighand
Message-ID: <20060224180436.GC1735@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43F9E890.B8550676@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9E890.B8550676@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 07:04:32PM +0300, Oleg Nesterov wrote:
> Cosmetic, rename __exit_sighand to cleanup_sighand and move
> it close to copy_sighand().
> 
> This matches copy_signal/cleanup_signal naming, and I think
> it is easier to follow.

Passes steamroller, looks sane, but defer to others on the relative
desireability of the names.  (Yes, I am a philistine!)

Acked-by: <paulmck@us.ibm.com>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.16-rc3/include/linux/sched.h~4_ESGH	2006-02-20 02:01:27.000000000 +0300
> +++ 2.6.16-rc3/include/linux/sched.h	2006-02-20 21:00:09.000000000 +0300
> @@ -1142,8 +1142,8 @@ extern void exit_thread(void);
>  
>  extern void exit_files(struct task_struct *);
>  extern void __cleanup_signal(struct signal_struct *);
> +extern void cleanup_sighand(struct task_struct *);
>  extern void __exit_signal(struct task_struct *);
> -extern void __exit_sighand(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
>  extern NORET_TYPE void do_group_exit(int);
> --- 2.6.16-rc3/kernel/fork.c~4_ESGH	2006-02-20 02:02:38.000000000 +0300
> +++ 2.6.16-rc3/kernel/fork.c	2006-02-20 21:14:25.000000000 +0300
> @@ -801,6 +801,16 @@ static inline int copy_sighand(unsigned 
>  	return 0;
>  }
>  
> +void cleanup_sighand(struct task_struct *tsk)
> +{
> +	struct sighand_struct * sighand = tsk->sighand;
> +
> +	/* Ok, we're done with the signal handlers */
> +	tsk->sighand = NULL;
> +	if (atomic_dec_and_test(&sighand->count))
> +		kmem_cache_free(sighand_cachep, sighand);
> +}
> +
>  static inline int copy_signal(unsigned long clone_flags, struct task_struct * tsk)
>  {
>  	struct signal_struct *sig;
> @@ -1212,7 +1222,7 @@ bad_fork_cleanup_mm:
>  bad_fork_cleanup_signal:
>  	cleanup_signal(p);
>  bad_fork_cleanup_sighand:
> -	__exit_sighand(p);
> +	cleanup_sighand(p);
>  bad_fork_cleanup_fs:
>  	exit_fs(p); /* blocking */
>  bad_fork_cleanup_files:
> --- 2.6.16-rc3/kernel/signal.c~4_ESGH	2006-02-20 20:55:50.000000000 +0300
> +++ 2.6.16-rc3/kernel/signal.c	2006-02-20 21:06:49.000000000 +0300
> @@ -310,9 +310,7 @@ static void flush_sigqueue(struct sigpen
>  /*
>   * Flush all pending signals for a task.
>   */
> -
> -void
> -flush_signals(struct task_struct *t)
> +void flush_signals(struct task_struct *t)
>  {
>  	unsigned long flags;
>  
> @@ -326,19 +324,6 @@ flush_signals(struct task_struct *t)
>  /*
>   * This function expects the tasklist_lock write-locked.
>   */
> -void __exit_sighand(struct task_struct *tsk)
> -{
> -	struct sighand_struct * sighand = tsk->sighand;
> -
> -	/* Ok, we're done with the signal handlers */
> -	tsk->sighand = NULL;
> -	if (atomic_dec_and_test(&sighand->count))
> -		kmem_cache_free(sighand_cachep, sighand);
> -}
> -
> -/*
> - * This function expects the tasklist_lock write-locked.
> - */
>  void __exit_signal(struct task_struct *tsk)
>  {
>  	struct signal_struct *sig = tsk->signal;
> @@ -386,7 +371,7 @@ void __exit_signal(struct task_struct *t
>  	}
>  
>  	tsk->signal = NULL;
> -	__exit_sighand(tsk);
> +	cleanup_sighand(tsk);
>  	spin_unlock(&sighand->siglock);
>  	rcu_read_unlock();
