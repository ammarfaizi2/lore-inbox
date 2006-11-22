Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161767AbWKVCLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161767AbWKVCLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967012AbWKVCLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:11:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:65196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967013AbWKVCLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:11:33 -0500
Date: Tue, 21 Nov 2006 18:11:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH] Add do_not_call_when_idle option to timer and
 workqueue
Message-Id: <20061121181114.b9d923bd.akpm@osdl.org>
In-Reply-To: <20061121162845.A24791@unix-os.sc.intel.com>
References: <20061121162845.A24791@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 16:28:45 -0800
Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:

> 
> Add a new flag to timers to allow "Do not call when Idle" mode.
> Export this sort of soft timer over workqueues and use it in ondemand governor.
> 
> This patch avoids the periodic ondemand timer invocations in
> Dynamic Tick kernels.
> 
> This can be used in various other kernel timers that end up setting up
> unnecessary timers during idle.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.19-rc-mm/include/linux/timer.h
> ===================================================================
> --- linux-2.6.19-rc-mm.orig/include/linux/timer.h	2006-11-13 15:06:26.000000000 -0800
> +++ linux-2.6.19-rc-mm/include/linux/timer.h	2006-11-13 16:01:03.000000000 -0800
> @@ -8,6 +8,8 @@
>  
>  struct tvec_t_base_s;
>  
> +#define TIMER_FLAG_NOT_IN_IDLE	(0x1)
> +
>  struct timer_list {
>  	struct list_head entry;
>  	unsigned long expires;
> @@ -16,6 +18,7 @@
>  	unsigned long data;
>  
>  	struct tvec_t_base_s *base;
> +	int	flags;
>  #ifdef CONFIG_TIMER_STATS

Adding a new field to the timer_list is somewhat of a hit - this is going
to make an awful lot of data structures a bit larger.  Some of which we
allocate a large number of.

I think we could justfy getting nasty and using the LSB of
timer_list.function for this..

>  	void *start_site;
>  	char start_comm[16];
> @@ -30,6 +33,7 @@
>  		.expires = (_expires),				\
>  		.data = (_data),				\
>  		.base = &boot_tvec_bases,			\
> +		.flags = 0,					\
>  	}
>  
>  #define DEFINE_TIMER(_name, _function, _expires, _data)		\
> Index: linux-2.6.19-rc-mm/include/linux/workqueue.h
> ===================================================================
> --- linux-2.6.19-rc-mm.orig/include/linux/workqueue.h	2006-11-13 15:06:26.000000000 -0800
> +++ linux-2.6.19-rc-mm/include/linux/workqueue.h	2006-11-13 16:01:03.000000000 -0800
> @@ -65,6 +65,8 @@
>  extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
>  extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  	struct work_struct *work, unsigned long delay);
> +extern int queue_soft_delayed_work_on(int cpu, struct workqueue_struct *wq,
> +	struct work_struct *work, unsigned long delay);

I don't think that's a well-chosen name.  What does the "soft" mean?

Also, this is a new timer API capability, but it is only exposed via the
workqueue API, and then only via a part of it.

A complete implementation would expose the new capability via extensions to
the timer API, and would then (in a separate patch) convert the workqueue
API to use those extensions.  (And in fact the third patch would convert
cpufreq to use the new workqueue capabilities...)

>  extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
>  
>  extern int FASTCALL(schedule_work(struct work_struct *work));
> Index: linux-2.6.19-rc-mm/kernel/timer.c
> ===================================================================
> --- linux-2.6.19-rc-mm.orig/kernel/timer.c	2006-11-13 15:06:26.000000000 -0800
> +++ linux-2.6.19-rc-mm/kernel/timer.c	2006-11-13 16:01:03.000000000 -0800
> @@ -639,6 +639,8 @@
>  	j = base->timer_jiffies & TVR_MASK;
>  	do {
>  		list_for_each_entry(nte, base->tv1.vec + j, entry) {
> +			if (nte->flags & TIMER_FLAG_NOT_IN_IDLE)
> +				continue;
>  			expires = nte->expires;
>  			found = nte;
>  			if (j < (base->timer_jiffies & TVR_MASK))
> Index: linux-2.6.19-rc-mm/kernel/workqueue.c
> ===================================================================
> --- linux-2.6.19-rc-mm.orig/kernel/workqueue.c	2006-11-13 15:06:26.000000000 -0800
> +++ linux-2.6.19-rc-mm/kernel/workqueue.c	2006-11-13 16:01:03.000000000 -0800
> @@ -196,6 +196,20 @@
>  }
>  EXPORT_SYMBOL_GPL(queue_delayed_work_on);
>  
> +int queue_soft_delayed_work_on(int cpu, struct workqueue_struct *wq,
> +			struct work_struct *work, unsigned long delay)
> +{
> +	int ret;
> +	struct timer_list *timer = &work->timer;
> +	ret = queue_delayed_work_on(cpu, wq, work, delay);
> +	if (ret) {
> +		timer->flags |= TIMER_FLAG_NOT_IN_IDLE;
> +	}
> +	return ret;
> +}

See, here we have workqueue code poking around in timer_list internals.

Also, it's weird and conceivably racy to go altering the timer _after_
scheduling the work.  What happens if the timer goes off before we set the
bit?  And suppose the workqueue callback function frees the storage at
*timer?

All these problems will go away if the APIs are done fully, and correctly.


