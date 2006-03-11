Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752291AbWCKBUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbWCKBUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbWCKBUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:20:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:6037 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752290AbWCKBUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:20:30 -0500
Date: Fri, 10 Mar 2006 17:20:59 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove __put_task_struct_cb export again
Message-ID: <20060311012059.GJ1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060310212039.GA16910@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310212039.GA16910@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 10:20:39PM +0100, Christoph Hellwig wrote:
> The patch '[PATCH] RCU signal handling' [1] added an export for
> __put_task_struct_cb, a put_task_struct helper newly introduced in that
> patch.  But the put_task_struct couldn't be used modular previously
> as __put_task_struct wasn't exported.  There are not callers of it in
> modular code, and it shouldn't be exported because we don't want drivers
> to hold references to task_structs.
> 
> This patch removes the export and folds __put_task_struct into
> __put_task_struct_cb as there's no other caller.
> 
> [1] http://www2.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e56d090310d7625ecb43a1eeebd479f04affb48b

Good catch -- I missed the reference to __put_task_struct().

Passes some smoke tests on ppc64.

							Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/kernel/sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched.c	2006-03-09 17:22:08.000000000 +0100
> +++ linux-2.6/kernel/sched.c	2006-03-10 21:15:02.000000000 +0100
> @@ -178,13 +178,6 @@
>  #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
>  				< (long long) (sd)->cache_hot_time)
>  
> -void __put_task_struct_cb(struct rcu_head *rhp)
> -{
> -	__put_task_struct(container_of(rhp, struct task_struct, rcu));
> -}
> -
> -EXPORT_SYMBOL_GPL(__put_task_struct_cb);
> -
>  /*
>   * These are the runqueue data structures:
>   */
> Index: linux-2.6/include/linux/sched.h
> ===================================================================
> --- linux-2.6.orig/include/linux/sched.h	2006-03-04 13:07:15.000000000 +0100
> +++ linux-2.6/include/linux/sched.h	2006-03-10 21:16:10.000000000 +0100
> @@ -892,7 +892,6 @@
>  }
>  
>  extern void free_task(struct task_struct *tsk);
> -extern void __put_task_struct(struct task_struct *tsk);
>  #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
>  
>  extern void __put_task_struct_cb(struct rcu_head *rhp);
> Index: linux-2.6/kernel/fork.c
> ===================================================================
> --- linux-2.6.orig/kernel/fork.c	2006-02-21 20:55:58.000000000 +0100
> +++ linux-2.6/kernel/fork.c	2006-03-10 21:15:39.000000000 +0100
> @@ -108,8 +108,10 @@
>  }
>  EXPORT_SYMBOL(free_task);
>  
> -void __put_task_struct(struct task_struct *tsk)
> +void __put_task_struct_cb(struct rcu_head *rhp)
>  {
> +	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
> +
>  	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
>  	WARN_ON(atomic_read(&tsk->usage));
>  	WARN_ON(tsk == current);
