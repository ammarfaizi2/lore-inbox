Return-Path: <linux-kernel-owner+w=401wt.eu-S1751935AbXARH4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXARH4Y (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 02:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXARH4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 02:56:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54369 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbXARH4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 02:56:23 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Roy Huang" <royhuang9@gmail.com>
Cc: linux-kernel@vger.kernel.org, aubreylee@gmail.com, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
Subject: Re: [PATCH] Provide an interface to limit total page cache.
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
Date: Thu, 18 Jan 2007 00:56:05 -0700
In-Reply-To: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
	(Roy Huang's message of "Mon, 15 Jan 2007 17:39:46 +0800")
Message-ID: <m1irf47oq2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Roy Huang" <royhuang9@gmail.com> writes:

> A patch provide a interface to limit total page cache in
> /proc/sys/vm/pagecache_ratio. The default value is 90 percent. Any
> feedback is appreciated.

Anything except a default value of 100% will change the behavior
and probably reduce the performance on most systems.

> -Roy
>
> diff -urp a/include/linux/sysctl.h b/include/linux/sysctl.h
> --- a/include/linux/sysctl.h	2007-01-15 17:18:46.000000000 +0800
> +++ b/include/linux/sysctl.h	2007-01-15 17:03:09.000000000 +0800
> @@ -202,6 +202,7 @@ enum
> 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
> 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
> 	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
> +	VM_PAGECACHE_RATIO=36,  /* Percent memory is used as page cache */
> };
>
>
> diff -urp a/kernel/sysctl.c b/kernel/sysctl.c
> --- a/kernel/sysctl.c	2007-01-15 17:18:46.000000000 +0800
> +++ b/kernel/sysctl.c	2007-01-15 17:03:09.000000000 +0800
> @@ -1035,6 +1035,15 @@ static ctl_table vm_table[] = {
> 		.extra1		= &zero,
> 	},
> #endif
> +	{
> +		.ctl_name	= VM_PAGECACHE_RATIO,
> +		.procname	= "pagecache_ratio",
> +		.data		= &pagecache_ratio,
> +		.maxlen		= sizeof(pagecache_ratio),
> +		.mode		= 0644,
> +		.proc_handler	= &pagecache_ratio_sysctl_handler,
> +		.strategy	= &sysctl_intvec,
> +	},
> 	{ .ctl_name = 0 }
> };

This is broken.

You have allocated a binary number for use with sys_sysctl but
did not test it.

If you need a special proc_handler to take action when the
value is changed you need a special strategy routine.

So since you aren't going to test the binary interface and don't
care about it please don't allocate a number for it and just
use CTL_UNNUMBERED.

And of course please read the top of linux/sysctl.h

Thank you.

Eric
