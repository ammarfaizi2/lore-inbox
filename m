Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274171AbRI1ADu>; Thu, 27 Sep 2001 20:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274161AbRI1ADk>; Thu, 27 Sep 2001 20:03:40 -0400
Received: from [195.223.140.107] ([195.223.140.107]:25852 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274164AbRI1ADX>;
	Thu, 27 Sep 2001 20:03:23 -0400
Date: Fri, 28 Sep 2001 02:03:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928020334.B14277@athlon.random>
In-Reply-To: <E15mkaf-0000ms-00@mail.tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15mkaf-0000ms-00@mail.tv-sign.ru>; from oleg@tv-sign.ru on Fri, Sep 28, 2001 at 03:29:13AM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 03:29:13AM +0400, Oleg Nesterov wrote:
> --- 2.4.10-softirq-A7/kernel/softirq.c.orig	Thu Sep 27 22:31:06 2001
> +++ 2.4.10-softirq-A7/kernel/softirq.c	Thu Sep 27 22:54:37 2001
> @@ -85,7 +85,7 @@
>  {
>  	int max_restart = MAX_SOFTIRQ_RESTART;
>  	int cpu = smp_processor_id();
> -	__u32 pending, mask;
> +	__u32 pending;
>  	long flags;
>  
>  	if (in_interrupt())
> @@ -98,7 +98,6 @@
>  	if (pending) {
>  		struct softirq_action *h;
>  
> -		mask = ~pending;
>  		local_bh_disable();
>  restart:
>  		/* Reset the pending bitmask before enabling irqs */

correct.

> @@ -381,26 +380,22 @@
>  #endif
>  
>  	current->nice = 19;
> -	schedule();
> -	__set_current_state(TASK_INTERRUPTIBLE);

buggy (check cpus_allowed).

>  	for (;;) {
> -back:
> +		schedule();
> +		__set_current_state(TASK_INTERRUPTIBLE);
> +
>  		do {
>  			do_softirq();
>  			if (current->need_resched)
>  				goto preempt;
>  		} while (softirq_pending(cpu));
> -		schedule();
> -		__set_current_state(TASK_INTERRUPTIBLE);
> -	}
>  
> +		continue;
>  preempt:
> -	__set_current_state(TASK_RUNNING);
> -	schedule();
> -	__set_current_state(TASK_INTERRUPTIBLE);
> -	goto back;
> +		__set_current_state(TASK_RUNNING);
> +	}
>  }

you dropped Ingo's optimization (but you resurrected the strictier /proc
statistics).

Andrea
