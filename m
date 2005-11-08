Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVKHUhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVKHUhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKHUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:37:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965005AbVKHUhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:37:42 -0500
Date: Tue, 8 Nov 2005 12:36:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: paulmck@us.ibm.com, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       suzannew@cs.pdx.edu, Chris Wright <chrisw@osdl.org>, torvalds@osdl.org
Subject: Re: [PATCH] fix de_thread() vs send_group_sigqueue() race
Message-ID: <20051108203621.GS5856@shell0.pdx.osdl.net>
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru> <436F991B.97AFC4C5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436F991B.97AFC4C5@tv-sign.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Oleg Nesterov (oleg@tv-sign.ru) wrote:
> When non-leader thread does exec, de_thread calls release_task(leader) before
> calling exit_itimers(). If local timer interrupt happens in between, it can
> oops in send_group_sigqueue() while taking ->sighand->siglock == NULL.
> 
> However, we can't change send_group_sigqueue() to check p->signal != NULL,
> because sys_timer_create() does get_task_struct() only in SIGEV_THREAD_ID
> case. So it is possible that this task_struct was already freed and we can't
> trust p->signal.
> 
> This patch changes de_thread() so that leader released after exit_itimers()
> call.

Nice catch.  As soon as Linus picks it up we'll put it in -stable as
well.

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-by: Chris Wright <chrisw@osdl.org>

> --- 2.6.14/fs/exec.c~	2005-09-21 21:08:33.000000000 +0400
> +++ 2.6.14/fs/exec.c	2005-11-07 23:54:42.000000000 +0300
> @@ -593,6 +593,7 @@ static inline int de_thread(struct task_
>  	struct signal_struct *sig = tsk->signal;
>  	struct sighand_struct *newsighand, *oldsighand = tsk->sighand;
>  	spinlock_t *lock = &oldsighand->siglock;
> +	struct task_struct *leader = NULL;
>  	int count;
>  
>  	/*
> @@ -668,7 +669,7 @@ static inline int de_thread(struct task_
>  	 * and to assume its PID:
>  	 */
>  	if (!thread_group_leader(current)) {
> -		struct task_struct *leader = current->group_leader, *parent;
> +		struct task_struct *parent;
>  		struct dentry *proc_dentry1, *proc_dentry2;
>  		unsigned long exit_state, ptrace;
>  
> @@ -677,6 +678,7 @@ static inline int de_thread(struct task_
>  		 * It should already be zombie at this point, most
>  		 * of the time.
>  		 */
> +		leader = current->group_leader;
>  		while (leader->exit_state != EXIT_ZOMBIE)
>  			yield();
>  
> @@ -736,7 +738,6 @@ static inline int de_thread(struct task_
>  		proc_pid_flush(proc_dentry2);
>  
>  		BUG_ON(exit_state != EXIT_ZOMBIE);
> -		release_task(leader);
>          }
>  
>  	/*
> @@ -746,8 +747,11 @@ static inline int de_thread(struct task_
>  	sig->flags = 0;
>  
>  no_thread_group:
> -	BUG_ON(atomic_read(&sig->count) != 1);
>  	exit_itimers(sig);
> +	if (leader)
> +		release_task(leader);
> +
> +	BUG_ON(atomic_read(&sig->count) != 1);
>  
>  	if (atomic_read(&oldsighand->count) == 1) {
>  		/*
