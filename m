Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWC3FDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWC3FDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWC3FDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:03:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWC3FDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:03:49 -0500
Date: Wed, 29 Mar 2006 21:03:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/8] Setup
Message-Id: <20060329210333.2994c838.akpm@osdl.org>
In-Reply-To: <442B27DE.3070105@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<442B27DE.3070105@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> delayacct-setup.patch
> 
> Initialization code related to collection of per-task "delay"
> statistics which measure how long it had to wait for cpu,
> sync block io, swapping etc. The collection of statistics and
> the interface are in other patches. This patch sets up the data
> structures and allows the statistics collection to be disabled
> through a  kernel boot paramater.
> 
> ...
>
> +	delayacct	[KNL] Enable per-task delay accounting
> +

Why does this boot parameter exist?

The code is neat-looking.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.16/kernel/delayacct.c	2006-03-29 18:12:57.000000000 -0500
> @@ -0,0 +1,92 @@
> +/* delayacct.c - per-task delay accounting
> + *
> + * Copyright (C) Shailabh Nagar, IBM Corp. 2006
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> + * the GNU General Public License for more details.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/time.h>
> +#include <linux/sysctl.h>
> +#include <linux/delayacct.h>
> +
> +int delayacct_on __read_mostly = 0;	/* Delay accounting turned on/off */

Yes, it should be __read_mostly.  But it shouldn't be initialised to zero.

> +void __delayacct_tsk_init(struct task_struct *tsk)
> +{
> +	tsk->delays = kmem_cache_alloc(delayacct_cache, SLAB_KERNEL);
> +	if (tsk->delays) {
> +		memset(tsk->delays, 0, sizeof(*tsk->delays));
> +		spin_lock_init(&tsk->delays->lock);
> +	}
> +}

We have kmem_cache_zalloc() now.

> +void __delayacct_tsk_exit(struct task_struct *tsk)
> +{
> +	if (tsk->delays) {
> +		kmem_cache_free(delayacct_cache, tsk->delays);
> +		tsk->delays = NULL;
> +	}
> +}

delayacct_tsk_exit() already checked tsk->delays.

> +/*
> + * Finish delay accounting for a statistic using
> + * its timestamps (@start, @end), accumalator (@total) and @count
> + */
> +
> +static inline void delayacct_end(struct timespec *start, struct timespec *end,
> +				u64 *total, u32 *count)
> +{
> +	struct timespec ts;
> +	nsec_t ns;
> +
> +	do_posix_clock_monotonic_gettime(end);
> +	ts.tv_sec = end->tv_sec - start->tv_sec;
> +	ts.tv_nsec = end->tv_nsec - start->tv_nsec;
> +	ns = timespec_to_ns(&ts);
> +	if (ns < 0)
> +		return;
> +
> +	spin_lock(&current->delays->lock);
> +	*total += ns;
> +	(*count)++;
> +	spin_unlock(&current->delays->lock);
> +}

It's strange to have a static inline function at the end of a .c file.  I
guess this gets used in later patches.

It looks rather too big to be inlined.

I'm surprised that we don't already have a timeval_sub() function
somewhere.

The code you have there will cause ts.tv_nsec to go negative half the time.
It looks like timespec_to_ns() will happily fix that up for us, but it's
all a bit fragile.

