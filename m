Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWI3IrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWI3IrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWI3IrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:47:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751155AbWI3IrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:47:03 -0400
Date: Sat, 30 Sep 2006 01:46:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 21/23] debugging feature: timer stats
Message-Id: <20060930014633.f90caa13.akpm@osdl.org>
In-Reply-To: <20060929234441.210732000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234441.210732000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:41 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> add /proc/tstats support:

/proc/timer_stats would be a better name.

Is this intended as a mainlineable feature?  If so, some documentation
would be nice.

> debugging feature to profile timer expiration.
> Both the starting site, process/PID and the expiration function is
> captured. This allows the quick identification of timer event sources
> in a system.
> 
> sample output:
> 
>  # echo 1 > /proc/tstats
>  # cat /proc/tstats
>  Timerstats sample period: 3.888770 s
>    12,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
>    15,     1 swapper          hcd_submit_urb (rh_timer_func)
>     4,   959 kedac            schedule_timeout (process_timeout)
>     1,     0 swapper          page_writeback_init (wb_timer_fn)
>    28,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
>    22,  2948 IRQ 4            tty_flip_buffer_push (delayed_work_timer_fn)
>     3,  3100 bash             schedule_timeout (process_timeout)
>     1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
>     1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
>     1,     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
>     1,  2292 ip               __netdev_watchdog_up (dev_watchdog)
>     1,    23 events/1         do_cache_clean (delayed_work_timer_fn)
>  90 total events, 30.0 events/sec
> 
> ...
> 
> @@ -74,6 +74,11 @@ struct hrtimer {
>  	int				cb_mode;
>  	struct list_head		cb_entry;
>  #endif
> +#ifdef CONFIG_TIMER_STATS
> +	void				*start_site;
> +	char				start_comm[16];
> +	int				start_pid;
> +#endif
>  };

Forgot to update this struct's kerneldoc.

> +extern void tstats_update_stats(void *timer, pid_t pid, void *startf,

timer_stats_* would be nicer...

> Index: linux-2.6.18-mm2/include/linux/timer.h
> ===================================================================
> --- linux-2.6.18-mm2.orig/include/linux/timer.h	2006-09-30 01:41:19.000000000 +0200
> +++ linux-2.6.18-mm2/include/linux/timer.h	2006-09-30 01:41:20.000000000 +0200
> @@ -2,6 +2,7 @@
>  #define _LINUX_TIMER_H
>  
>  #include <linux/list.h>
> +#include <linux/ktime.h>
>  #include <linux/spinlock.h>
>  #include <linux/stddef.h>
>  
> @@ -15,6 +16,11 @@ struct timer_list {
>  	unsigned long data;
>  
>  	struct tvec_t_base_s *base;
> +#ifdef CONFIG_TIMER_STATS
> +	void *start_site;
> +	char start_comm[16];
> +	int start_pid;
> +#endif
>  };

hm.  So it's very much a developer thing.

> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18-mm2/kernel/time/timer_stats.c	2006-09-30 01:41:20.000000000 +0200
> @@ -0,0 +1,227 @@
> +/*
> + * kernel/time/timer_stats.c
> + *
> + * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar
> + * Copyright(C) 2006, Thomas Gleixner <tglx@timesys.com>
> + *
> + * Based on: timer_top.c
> + *	Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus
> + *	Written by Daniel Petrini <d.pensator@gmail.com>

We're missing a Signed-off-by:?

> + * Collect timer usage statistics.
> + *
> + * We export the addresses and counting of timer functions being called,
> + * the pid and cmdline from the owner process if applicable.
> + *
> + * Start/stop data collection:
> + * # echo 1[0] >/proc/tstats
> + *
> + * Display the collected information:
> + * # cat /proc/tstats
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/list.h>
> +#include <linux/proc_fs.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/sched.h>
> +#include <linux/seq_file.h>
> +#include <linux/kallsyms.h>
> +
> +#include <asm/uaccess.h>
> +
> +static DEFINE_SPINLOCK(tstats_lock);
> +static int tstats_status;

This is not an integer.  It has type `enum tstats_stat'.

> +static ktime_t tstats_time;
> +
> +enum tstats_stat {
> +	TSTATS_INACTIVE,
> +	TSTATS_ACTIVE,
> +	TSTATS_READOUT,
> +	TSTATS_RESET,
> +};
> +
>
> ...
>
> +static void tstats_reset(void)
> +{
> +	memset(tstats, 0, sizeof(tstats));
> +}

This is called without the lock held, which looks wrong.

> +static ssize_t tstats_write(struct file *file, const char __user *buf,
> +			    size_t count, loff_t *offs)
> +{
> +	char ctl[2];
> +
> +	if (count != 2 || *offs)
> +		return -EINVAL;

Let's hope nobody's echo command does while(n) write(fd, *p++, 1);

> -static void delayed_work_timer_fn(unsigned long __data)
> +void delayed_work_timer_fn(unsigned long __data)
>  {
>  	struct work_struct *work = (struct work_struct *)__data;
>  	struct workqueue_struct *wq = work->wq_data;
>  	int cpu = smp_processor_id();
> +	struct list_head *head;
>  
> +	head = &per_cpu_ptr(wq->cpu_wq, cpu)->more_work.task_list;

This doesn't do anything.

