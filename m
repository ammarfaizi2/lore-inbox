Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVBWUT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVBWUT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVBWUT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:19:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:58774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261558AbVBWUTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:19:22 -0500
Date: Wed, 23 Feb 2005 12:19:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Roland McGrath <roland@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Always send siginfo for synchronous signals
Message-ID: <20050223201903.GF21662@shell0.pdx.osdl.net>
References: <421C25BE.1090700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421C25BE.1090700@goop.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Valgrind is critically dependent on getting siginfo with its synchronous
> (caused by an instruction fault) signals; if it gets, say, a SIGSEGV
> which doesn't have siginfo, it must terminate ASAP because it really
> can't make any more progress without knowing what caused the SIGSEGV.
> 
> The trouble is that if some other completely unrelated program the user
> is running at the time builds up a large queue of pending signals for
> some reason (as KDE seems to on SuSE 9.2), it will cause Valgrind to
> fail for that user, apparently inexplicably.

It's not quite inexplicable.  It means that task has hit its limit for
pending signals ;-)  But I agree, this should be fixed.  I think I had
tested this with broken test cases, thanks for catching.

> --- local-2.6.orig/kernel/signal.c	2005-02-22 20:35:30.000000000 -0800
> +++ local-2.6/kernel/signal.c	2005-02-22 20:43:16.000000000 -0800
> @@ -136,6 +136,10 @@ static kmem_cache_t *sigqueue_cachep;
>  #define SIG_KERNEL_IGNORE_MASK (\
>          M(SIGCONT)   |  M(SIGCHLD)   |  M(SIGWINCH)  |  M(SIGURG)    )
>  
> +#define SIG_KERNEL_SYNC_MASK (\
> +	M(SIGSEGV)   |  M(SIGBUS)    | M(SIGILL)     |  M(SIGFPE)    | \
> +	M(SIGTRAP) )
> +
>  #define sig_kernel_only(sig) \
>  		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_ONLY_MASK))
>  #define sig_kernel_coredump(sig) \
> @@ -144,6 +148,8 @@ static kmem_cache_t *sigqueue_cachep;
>  		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_IGNORE_MASK))
>  #define sig_kernel_stop(sig) \
>  		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))
> +#define sig_kernel_sync(sig) \
> +		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_SYNC_MASK))
>  
>  #define sig_user_defined(t, signr) \
>  	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
> @@ -260,11 +266,12 @@ next_signal(struct sigpending *pending, 
>  	return sig;
>  }
>  
> -static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags)
> +static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags, int always)

maybe force_info instead of always?

>  {
>  	struct sigqueue *q = NULL;
>  
> -	if (atomic_read(&t->user->sigpending) <
> +	if (always || 
> +	    atomic_read(&t->user->sigpending) <
>  			t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
>  		q = kmem_cache_alloc(sigqueue_cachep, flags);
>  	if (q) {
> @@ -777,6 +784,7 @@ static int send_signal(int sig, struct s
>  {
>  	struct sigqueue * q = NULL;
>  	int ret = 0;
> +	int always;

Could we call it force_info?

>  	/*
>  	 * fast-pathed signals for kernel-internal things like SIGSTOP
> @@ -785,6 +793,13 @@ static int send_signal(int sig, struct s
>  	if ((unsigned long)info == 2)
>  		goto out_set;
>  
> +	/* Always attempt to send siginfo with an unblocked
> +	   fault-generated signal. */
> +	always = sig_kernel_sync(sig) &&
> +		!sigismember(&t->blocked, sig) &&

Aren't these already unblocked?

> +		(unsigned long)info > 2 &&
> +		info->si_code > SI_USER;

In what case is != SI_KERNEL OK?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
