Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWCRUKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWCRUKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWCRUKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:10:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWCRUK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:10:29 -0500
Date: Sat, 18 Mar 2006 12:07:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Message-Id: <20060318120728.63cbad54.akpm@osdl.org>
In-Reply-To: <20060318142830.607556000@localhost.localdomain>
References: <20060318142827.419018000@localhost.localdomain>
	<20060318142830.607556000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> 
> According to the specification the timeval must be validated and
> an errorcode -EINVAL returned in case the timeval is not in canonical
> form. Before the hrtimer merge this was silently ignored by the 
> timeval to jiffies conversion. The validation is done inside 
> do_setitimer so all callers are catched.
> 
> ...
> 
> --- linux-2.6.16-rc6-updates.orig/include/linux/time.h
> +++ linux-2.6.16-rc6-updates/include/linux/time.h
> @@ -73,6 +73,12 @@ extern void set_normalized_timespec(stru
>  #define timespec_valid(ts) \
>  	(((ts)->tv_sec >= 0) && (((unsigned long) (ts)->tv_nsec) < NSEC_PER_SEC))
>  
> +/*
> + * Returns true if the timeval is in canonical form
> + */
> +#define timeval_valid(t) \
> +	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
> +
>  extern struct timespec xtime;
>  extern struct timespec wall_to_monotonic;
>  extern seqlock_t xtime_lock;
> Index: linux-2.6.16-rc6-updates/kernel/itimer.c
> ===================================================================
> --- linux-2.6.16-rc6-updates.orig/kernel/itimer.c
> +++ linux-2.6.16-rc6-updates/kernel/itimer.c
> @@ -150,6 +150,14 @@ int do_setitimer(int which, struct itime
>  	ktime_t expires;
>  	cputime_t cval, cinterval, nval, ninterval;
>  
> +	/*
> +	 * Validate the timeval. This catches all users of
> +	 * do_setitimer.
> +	 */
> +	if (!timeval_valid(&value->it_value) ||
> +	    !timeval_valid(&value->it_interval))
> +		return -EINVAL;
> +
>  	switch (which) {
>  	case ITIMER_REAL:
>  again:

>From my reading, 2.4's sys_setitimer() will normalise the incoming timeval
rather than rejecting it.  And I think 2.6.13 did that too.

It would be bad of us to change this behaviour, even if that's what the
spec says we should do - because we can break existing applications.

So I think we're stuck with it - we should normalise and then accept such
timevals.  And we should have a big comment explaining how we differ from
the spec, and why.

