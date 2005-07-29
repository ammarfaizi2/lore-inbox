Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVG2UVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVG2UVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVG2UTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:19:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262808AbVG2UTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:19:01 -0400
Date: Fri, 29 Jul 2005 13:18:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net, akpm@osdl.org,
       chrisw@osdl.org
Subject: Re: Broke nice range for RLIMIT NICE
Message-ID: <20050729201836.GH19052@shell0.pdx.osdl.net>
References: <32710.1122563064@www32.gmx.net> <20050729061318.GD7425@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729061318.GD7425@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Thu, Jul 28, 2005 at 05:04:24PM +0200, Michael Kerrisk wrote:
> > In other words, there is an off-by-one mismatch between 
> > these two interfaces: RLIMIT_NICE is expecting to deal 
> > with values in the range 39..0, while [gs]etpriority() 
> > works with the range 40..1.
> > 
> > I suppose that glibc could paper over the cracks here in
> > a wrapper for getrlimit(), but it seems more sensible 
> > to make RLIMIT_NICE consistent with [gs]etpriority() --
> > i.e., change the RLIMIT_NICE interface in 2.6.13 before it 
> > sees wide use in userland.  What do you think?
> 
> Well, it's easy enough to do, but some thought has to be given to the
> corner cases. Specifically, does this do the right thing when the
> rlimit is set to zero? I think it does, as the nice range is nicely
> bound here:

Agreed, it should be fine.  The default rlimit of zero is just as
effective with the adjust by one semantics.

>         nice = PRIO_TO_NICE(current->static_prio) + increment;
>         if (nice < -20)
>                 nice = -20;
>         if (nice > 19)
>                 nice = 19;
> 
>         if (increment < 0 && !can_nice(current, nice))
>                 return -EPERM;
> 
> And we allow task to do negative increment. Chris?

Yes, if the rlimit is permissive enough.  So, for example with default,
there's no chance for any negative increment.  With rlimit of 1 (or 2
with adjust-by-one) you could nice down to 19, then nice back up to a
max of 18.

> The other downside is, this obviously changes any existing configs
> actually using this by one nice level..

Yes, this requires updated pam patch.  Otherwise,

ACK

thanks,
-chris

> Index: l/kernel/sched.c
> ===================================================================
> --- l.orig/kernel/sched.c	2005-06-22 17:55:14.000000000 -0700
> +++ l/kernel/sched.c	2005-07-28 22:55:54.000000000 -0700
> @@ -3231,8 +3231,8 @@ EXPORT_SYMBOL(set_user_nice);
>   */
>  int can_nice(const task_t *p, const int nice)
>  {
> -	/* convert nice value [19,-20] to rlimit style value [0,39] */
> -	int nice_rlim = 19 - nice;
> +	/* convert nice value [19,-20] to rlimit style value [1,40] */
> +	int nice_rlim = 20 - nice;
>  	return (nice_rlim <= p->signal->rlim[RLIMIT_NICE].rlim_cur ||
>  		capable(CAP_SYS_NICE));
>  }
