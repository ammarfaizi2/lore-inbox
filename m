Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUAIAD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUAIAD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:03:28 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:1684 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264463AbUAIACu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:02:50 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: dipankar@in.ibm.com
Cc: Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] RCU for low latency [2/2] 
In-reply-to: Your message of "Thu, 08 Jan 2004 17:20:51 +0530."
             <20040108115051.GC5128@in.ibm.com> 
Date: Fri, 09 Jan 2004 10:43:34 +1100
Message-Id: <20040109000244.8C58D17DDE@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040108115051.GC5128@in.ibm.com> you write:
> @@ -54,6 +54,11 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
>  /* Fake initialization required by compiler */
>  static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
>  #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
> +#ifdef CONFIG_PREEMPT
> +static int rcu_max_bh_callbacks = 256;
> +#else 
> +static int rcu_max_bh_callbacks = 0;
> +#endif
>
> +static inline int rcu_limiting_needed(int cpu)
> +{
> +	if (in_softirq() && RCU_krcud(cpu))
> +		return 1;
> +	return 0;
> +}
> +
>  /*
>   * Invoke the completed RCU callbacks. They are expected to be in
>   * a per-cpu list.
> @@ -87,13 +99,24 @@ static void rcu_do_batch(struct list_hea
>  {
>  	struct list_head *entry;
>  	struct rcu_head *head;
> +	int count = 0;
> +	int cpu = smp_processor_id();
> +	int limit = rcu_limiting_needed(cpu);
>  
>  	while (!list_empty(list)) {
>  		entry = list->next;
>  		list_del(entry);
>  		head = list_entry(entry, struct rcu_head, list);
>  		head->func(head->arg);
> +		count++;
> +		if (limit && count > rcu_max_bh_callbacks &&
> +			rq_has_rt_task(cpu)) {

Perhaps you should do this the other way:

static inline unsigned int max_rcu_at_once(int cpu)
{
	if (in_softirq() && RCU_krcud(cpu) && rq_has_rt_task(cpu))
		return rcu_max_bh_callbacks;
	return (unsigned int)-1;
}

....

	unsigned int count, limit = max_rcu_at_once(cpu);

	...
		if (++count > limit)

Ideally you'd create a new workqueue for this, or at the very least
use kthread primitives (once they're in -mm, hopefully soon).

> +static int start_krcud(int cpu)
> +{
> +	if (rcu_max_bh_callbacks) {
> +		if (kernel_thread(krcud, (void *)(long)cpu, CLONE_KERNEL) < 0) {
> +			printk("krcud for %i failed\n", cpu);
> +			return -1;

EPERM seems unusual here.  How about:

	int pid;
	pid = kernel_thread(krcud, (void *)(long)cpu, CLONE_KERNEL);
	if (pid < 0) {
		printk(printk("krcud for %i failed\n", cpu);
		return pid;
	}


> +__setup("rcubhlimit=", rcu_bh_limit_setup);

Please use module_param().  If it's a good name for a variable, it's a
good name for a parameter.  eg. just call the variable bhlimit, and
then the boot parameter will be called "rcu.bhlimit" which fits the
calling conventio we're trying to encourage.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
