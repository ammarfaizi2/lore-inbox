Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUD2Be4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUD2Be4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUD2Bez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:34:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:10118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262932AbUD2BdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:33:24 -0400
Date: Wed, 28 Apr 2004 18:33:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040428183315.T22989@build.pdx.osdl.net>
References: <20040419224940.GY31589@devserv.devel.redhat.com> <20040420141319.GB13259@logos.cnet> <20040420130439.23fae566.akpm@osdl.org> <20040420231351.GB13826@logos.cnet> <20040420163443.7347da48.akpm@osdl.org> <20040421203456.GC16891@logos.cnet> <40875944.4060405@colorfullife.com> <20040427145424.GA10530@logos.cnet> <408EA1DF.6050303@colorfullife.com> <20040428170932.GA14993@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040428170932.GA14993@logos.cnet>; from marcelo.tosatti@cyclades.com on Wed, Apr 28, 2004 at 02:09:32PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti (marcelo.tosatti@cyclades.com) wrote:
> This should be OK for inclusion into -mm now, if no other comment is made.

This patch doesn't account for sigqueue bits properly.  The allocations
aren't always made in task context.  So, it's trivial to illegitimately
drain off the new signal_pending counter, leaving the potential for the
original DoS unfixed.  And the setuid issues still seem to be there,
right?

Couple other nits below:

Some bits need to be converted to tabs from spaces.

> diff -Nur --show-c-function a/linux-2.6.5/include/asm-s390/resource.h linux-2.6.5/include/asm-s390/resource.h
> --- a/linux-2.6.5/include/asm-s390/resource.h	2004-04-04 00:36:55.000000000 -0300
> +++ linux-2.6.5/include/asm-s390/resource.h	2004-04-27 08:32:46.000000000 -0300
> @@ -24,7 +24,9 @@
>  #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
>  #define RLIMIT_AS	9		/* address space limit */
>  #define RLIMIT_LOCKS	10		/* maximum file locks held */
> -  
> +#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
> +#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
> +
>  #define RLIM_NLIMITS	11

Missed this one.

> diff -Nur --show-c-function a/linux-2.6.5/include/asm-sparc/resource.h linux-2.6.5/include/asm-sparc/resource.h
> --- a/linux-2.6.5/include/asm-sparc/resource.h	2004-04-04 00:36:18.000000000 -0300
> +++ linux-2.6.5/include/asm-sparc/resource.h	2004-04-27 08:32:46.000000000 -0300
> @@ -22,8 +22,10 @@
>  #define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
>  #define RLIMIT_AS       9               /* address space limit */
>  #define RLIMIT_LOCKS	10		/* maximum file locks held */
> +#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
> +#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
>  
> -#define RLIM_NLIMITS	11
> +#define RLIM_NLIMITS	13
>  
>  /*
>   * SuS says limits have to be unsigned.
> @@ -45,6 +47,9 @@
>      {RLIM_INFINITY, RLIM_INFINITY},	\
>      {RLIM_INFINITY, RLIM_INFINITY},	\
>      {RLIM_INFINITY, RLIM_INFINITY}	\
> +    {MAX_USER_SIGNALS, MAX_USER_SIGNALS}, \
> +    {MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\

Won't compile.

> diff -Nur --show-c-function a/linux-2.6.5/include/asm-sparc64/resource.h linux-2.6.5/include/asm-sparc64/resource.h
> --- a/linux-2.6.5/include/asm-sparc64/resource.h	2004-04-04 00:36:15.000000000 -0300
> +++ linux-2.6.5/include/asm-sparc64/resource.h	2004-04-27 08:32:46.000000000 -0300
> @@ -22,8 +22,10 @@
>  #define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
>  #define RLIMIT_AS       9               /* address space limit */
>  #define RLIMIT_LOCKS	10		/* maximum file locks held */
> +#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
> +#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
>  
> -#define RLIM_NLIMITS	11
> +#define RLIM_NLIMITS	13
>  
>  /*
>   * SuS says limits have to be unsigned.
> @@ -44,6 +46,8 @@
>      {RLIM_INFINITY, RLIM_INFINITY},	\
>      {RLIM_INFINITY, RLIM_INFINITY},	\
>      {RLIM_INFINITY, RLIM_INFINITY}	\
> +    {MAX_USER_SIGNALS, MAX_USER_SIGNALS}, \
> +    {MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\

Ditto.

> +++ linux-2.6.5/include/linux/signal.h	2004-04-27 08:32:46.000000000 -0300
> @@ -7,6 +7,10 @@
>  #include <asm/siginfo.h>
>  
>  #ifdef __KERNEL__
> +
> +#define MAX_QUEUED_SIGNALS	4096

Besides right below, is this really used anymore?

> +#define MAX_USER_SIGNALS	(MAX_QUEUED_SIGNALS/4)

here.

> diff -Nur --show-c-function a/linux-2.6.5/kernel/signal.c linux-2.6.5/kernel/signal.c
> --- a/linux-2.6.5/kernel/signal.c	2004-04-27 09:53:24.000000000 -0300
> +++ linux-2.6.5/kernel/signal.c	2004-04-27 11:05:08.000000000 -0300
> @@ -31,8 +31,7 @@
>  
>  static kmem_cache_t *sigqueue_cachep;
>  
> -atomic_t nr_queued_signals;
> -int max_queued_signals = 1024;
> +int max_queued_signals = MAX_QUEUED_SIGNALS;

and here, but max_queued_signals is no longer really relevant, right?
Should we removed both nr_queued_signals and max_queued_signals and the
associated sysctl's?  Or leave it, and give CAP_SYS_RESOURCE the ability
to do a full override?  I chose the latter, although I'm inclined to
drop that bit.

>  static void flush_sigqueue(struct sigpending *queue)
> @@ -700,11 +707,13 @@ static int send_signal(int sig, struct s
>  	   make sure at least one signal gets delivered and don't
>  	   pass on the info struct.  */
>  
> -	if (atomic_read(&nr_queued_signals) < max_queued_signals)
> +	if (atomic_read(&current->user->signal_pending) <=

current may not be valid here.

I have a diff between your patch and what I'm testing, but it's
cluttered a bit by the fact that I've also merged it up to 2.6.6-rc3
I can send you the full patch if that's easier.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
