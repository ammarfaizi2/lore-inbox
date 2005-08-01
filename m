Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVHAHJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVHAHJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVHAHJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:09:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57998 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262020AbVHAHJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:09:32 -0400
Date: Mon, 1 Aug 2005 09:09:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP 600X))
Message-ID: <20050801070926.GI27580@elf.ucw.cz>
References: <20050730103034.GC1942@elf.ucw.cz> <1122879094.3285.2.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122879094.3285.2.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you think it is a linux bug, can you produce small test case doing 
> > just the sigwait, and post it on l-k with big title "sigwait() breaks 
> > when straced, and on suspend"?
> > 
> > That way it is going to get some attetion, and you'll get either 
> > documentation or kernel fixed. 
> Looks like a linux bug to me. The refrigerator fake signal waked the
> task up and without restart for the sigwait case. How about below
> patch:

Is there chance to fix strace case, too? sigwait() is broken in more
than one way it seems...
								Pavel


>  linux-2.6.13-rc4-root/kernel/signal.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff -puN kernel/signal.c~sigwait-suspend-resume kernel/signal.c
> --- linux-2.6.13-rc4/kernel/signal.c~sigwait-suspend-resume	2005-08-01 14:00:39.089460688 +0800
> +++ linux-2.6.13-rc4-root/kernel/signal.c	2005-08-01 14:30:13.821660384 +0800
> @@ -2188,6 +2188,7 @@ sys_rt_sigtimedwait(const sigset_t __use
>  	struct timespec ts;
>  	siginfo_t info;
>  	long timeout = 0;
> +	int recover = 0;
>  
>  	/* XXX: Don't preclude handling different sized sigset_t's.  */
>  	if (sigsetsize != sizeof(sigset_t))
> @@ -2225,15 +2226,23 @@ sys_rt_sigtimedwait(const sigset_t __use
>  			 * be awakened when they arrive.  */
>  			current->real_blocked = current->blocked;
>  			sigandsets(&current->blocked, &current->blocked, &these);
> +do_recover:
>  			recalc_sigpending();
>  			spin_unlock_irq(&current->sighand->siglock);
>  
>  			current->state = TASK_INTERRUPTIBLE;
>  			timeout = schedule_timeout(timeout);
>  
> -			try_to_freeze();
> +			if (try_to_freeze())
> +				recover = 1;

Can't you just goto do_recover here?

>  			spin_lock_irq(&current->sighand->siglock);
>  			sig = dequeue_signal(current, &these, &info);
> +			if (!sig && recover) {
> +				if (timeout == 0)
> +					timeout = MAX_SCHEDULE_TIMEOUT;
> +				recover = 0;
> +				goto do_recover;
> +			}
>  			current->blocked = current->real_blocked;
>  			siginitset(&current->real_blocked, 0);
>  			recalc_sigpending();
> _
> 

-- 
if you have sharp zaurus hardware you don't need... you know my address
