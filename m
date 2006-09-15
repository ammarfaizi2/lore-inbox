Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWIOGGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWIOGGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 02:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWIOGGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 02:06:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750791AbWIOGGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 02:06:17 -0400
Date: Thu, 14 Sep 2006 23:06:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Migration of standard timers
Message-Id: <20060914230611.27e28334.akpm@osdl.org>
In-Reply-To: <20060914132917.GA9898@sgi.com>
References: <20060914132917.GA9898@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 08:29:17 -0500
Dimitri Sivanich <sivanich@sgi.com> wrote:

> This patch allows the user to migrate currently queued
> standard timers from one cpu to another, thereby reducing
> timer induced latency on the chosen cpu.

Need more details, please.  Why would a user want to do that?

Performance-related, I assume?  If so, some numbers would be nice.

What is the use-case?

Why was a sysfs file chosen as the user inteface?

What are the permissions on that sysfs file and why?

Does it need to be available to non-altix^H^H^H^H^HNUMA machines?

The code you have there is suspiciously similar to migrate_timers().  Do we
really need to duplicate it?

> Index: linux/kernel/timer.c
> ===================================================================
> --- linux.orig/kernel/timer.c
> +++ linux/kernel/timer.c
> @@ -147,6 +147,7 @@ void fastcall init_timer(struct timer_li
>  {
>  	timer->entry.next = NULL;
>  	timer->base = __raw_get_cpu_var(tvec_bases);
> +	timer->aff = 0;

As Jes mentioned: `aff' isn't a very clear identifier.  Maybe is_bound_to_cpu?

>  }
>  EXPORT_SYMBOL(init_timer);
>  
> @@ -250,6 +251,7 @@ void add_timer_on(struct timer_list *tim
>    	BUG_ON(timer_pending(timer) || !timer->function);
>  	spin_lock_irqsave(&base->lock, flags);
>  	timer->base = base;
> +	timer->aff = 1;		/* Don't migrate */
>  	internal_add_timer(base, timer);
>  	spin_unlock_irqrestore(&base->lock, flags);
>  }
> @@ -1661,6 +1663,52 @@ static void __devinit migrate_timers(int
>  }
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
> +static void move_timer_list(tvec_base_t *new_base, struct list_head *head)
> +{
> +	struct timer_list *timer, *t;
> +
> +	list_for_each_entry_safe(timer, t, head, entry) {
> +		if (timer->aff)
> +			continue;
> +		detach_timer(timer, 0);
> +		timer->base = new_base;
> +		internal_add_timer(new_base, timer);
> +	}
> +}
> +
> +int move_timers(int cpu, int dest)
> +{

Again, unfortunate naming.  What's 'dest'?  Better would be `source_cpu'
and `dest_cpu', no?

> +	tvec_base_t *old_base;
> +	tvec_base_t *new_base;
> +	unsigned long flags;
> +	int i;
> +
> +	if (cpu == dest)
> +		return -EINVAL;
> +
> +	if (!cpu_online(cpu) || !cpu_online(dest))
> +		return -EINVAL;

Racy against CPU hotplug.  Wrapping it all in preempt_disable() (with a
comment explaining why) would suffice.

> +	old_base = per_cpu(tvec_bases, cpu);
> +	new_base = per_cpu(tvec_bases, dest);
> +	spin_lock_irqsave(&new_base->lock, flags);
> +	spin_lock(&old_base->lock);

If one CPU does move_timers(0, 1) and another CPU does move_timers(1, 0) at
the same time, we have an AB/BA deadlock, don't we?

If so, fixes would include:

a) always take the lower-addressed-lock first or

b) wrap the whole operation inside a single global lock.

Either way, lockdep is likely to get upset about this and special
annotations and cursing might be needed.

> +
> +	for (i = 0; i < TVR_SIZE; i++)
> +		move_timer_list(new_base, old_base->tv1.vec + i);
> +	for (i = 0; i < TVN_SIZE; i++) {
> +		move_timer_list(new_base, old_base->tv2.vec + i);
> +		move_timer_list(new_base, old_base->tv3.vec + i);
> +		move_timer_list(new_base, old_base->tv4.vec + i);
> +		move_timer_list(new_base, old_base->tv5.vec + i);
> +	}
> +
> +	spin_unlock(&old_base->lock);
> +	spin_unlock_irqrestore(&new_base->lock, flags);
> +	return 0;
> +}
> +
>  static int __cpuinit timer_cpu_notify(struct notifier_block *self,
>  				unsigned long action, void *hcpu)
>  {
> Index: linux/drivers/base/cpu.c
> ===================================================================
> --- linux.orig/drivers/base/cpu.c
> +++ linux/drivers/base/cpu.c
> @@ -54,6 +54,26 @@ static ssize_t store_online(struct sys_d
>  }
>  static SYSDEV_ATTR(online, 0600, show_online, store_online);
>  
> +static ssize_t store_migrate(struct sys_device *dev, const char *buf,
> +				size_t count)

A better name would be `store_timer_migrate'.

> +{
> +	unsigned int cpu = dev->id;
> +	unsigned long dest;
> +	int rc;
> +
> +	dest = simple_strtoul(buf, NULL, 10);
> +	if (dest > INT_MAX)
> +		return -EINVAL;
> +
> +	rc = move_timers(cpu, dest);
> +	if (rc < 0)
> +		return rc;
> +	else
> +		return count;
> +}
> +
> +static SYSDEV_ATTR(timer_migrate, 0200, NULL, store_migrate);

I'm supposed to point you at Documentation/ABI/, sorry.

> ===================================================================
> --- linux.orig/include/linux/timer.h
> +++ linux/include/linux/timer.h
> @@ -15,6 +15,8 @@ struct timer_list {
>  	unsigned long data;
>  
>  	struct tvec_t_base_s *base;
> +
> +	short aff;
>  };
>  
>  extern struct tvec_t_base_s boot_tvec_bases;
> @@ -24,6 +26,7 @@ extern struct tvec_t_base_s boot_tvec_ba
>  		.expires = (_expires),				\
>  		.data = (_data),				\
>  		.base = &boot_tvec_bases,			\
> +		.aff = 0,					\

It's not really needed if it's zero.

>  	}
>  
>  #define DEFINE_TIMER(_name, _function, _expires, _data)		\
> @@ -95,6 +98,7 @@ static inline void add_timer(struct time
>  
>  extern void init_timers(void);
>  extern void run_local_timers(void);
> +extern int move_timers(int, int);

I think it's nice to include the identifiers here (source_cpu and
dest_cpu), as a little bit of documentation.

(And I think it's more idiomatic to put the destination arg first, although
we violate that in rather a lot of places).


