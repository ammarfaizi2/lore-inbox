Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbWBUCMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWBUCMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWBUCMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:12:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37539 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161277AbWBUCMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:12:32 -0500
Date: Mon, 20 Feb 2006 18:13:02 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] introduce sig_needs_tasklist() helper
Message-ID: <20060221021302.GR1480@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43F76374.EDA3ED9D@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F76374.EDA3ED9D@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 09:12:04PM +0300, Oleg Nesterov wrote:
> In my opinion this patch cleanups the code. Please
> say 'nack' if you think differently.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.16-rc3/kernel/signal.c~4_SNT	2006-02-18 23:26:51.000000000 +0300
> +++ 2.6.16-rc3/kernel/signal.c	2006-02-18 23:43:23.000000000 +0300
> @@ -147,6 +147,9 @@ static kmem_cache_t *sigqueue_cachep;
>  #define sig_kernel_stop(sig) \
>  		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))
>  
> +#define sig_needs_tasklist(sig) \
> +		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK | M(SIGCONT)))
> +
>  #define sig_user_defined(t, signr) \
>  	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
>  	 ((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_IGN))
> @@ -1202,7 +1205,7 @@ kill_proc_info(int sig, struct siginfo *
>  	struct task_struct *p;
>  
>  	rcu_read_lock();
> -	if (unlikely(sig_kernel_stop(sig) || sig == SIGCONT)) {
> +	if (unlikely(sig_needs_tasklist(sig))) {
>  		read_lock(&tasklist_lock);
>  		acquired_tasklist_lock = 1;
>  	}

Seems to me to be an improvement, but why not also encapsulate the
lock acquisition, something like:

	static inline int sig_tasklist_lock(int sig)
	{
		if (unlikely(sig_needs_tasklist(sig)) {
			read_lock(&tasklist_lock);
			return 1;
		}
		return 0;
	}

	static inline void sig_tasklist_unlock(int acquired_tasklist_lock)
	{
		if (acquired_tasklist_lock)
			read_unlock(&tasklist_lock);
	}

	...

	rcu_read_lock();
	acquired_tasklist_lock = sig_tasklist_lock(sig);

	...

	sig_tasklist_unlock(acquired_tasklist_lock);

Seem reasonable?

						Thanx, Paul
