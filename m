Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWF0QwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWF0QwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWF0QwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:52:03 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:58860 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1161205AbWF0QwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:52:00 -0400
Date: Wed, 28 Jun 2006 01:13:58 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] srcu: RCU variant permitting read-side blocking
Message-ID: <20060627211358.GA484@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

"Paul E. McKenney" wrote:
>
> +void init_srcu_struct(struct srcu_struct *sp)
> +{
> +	int cpu;
> +
> +	sp->completed = 0;
> +	sp->per_cpu_ref = (struct srcu_struct_array *)
> +			  kmalloc(NR_CPUS * sizeof(*sp->per_cpu_ref),
> +				  GFP_KERNEL);
> +	for_each_cpu(cpu) {
> +		sp->per_cpu_ref[cpu].c[0] = 0;
> +		sp->per_cpu_ref[cpu].c[1] = 0;
> +	}

Isn't it simpler to just do:

	sp->per_cpu_ref = kzmalloc(NR_CPUS * sizeof(*sp->per_cpu_ref),
				GFP_KERNEL);

and drop 'for_each_cpu(cpu)' initialization ?

> +int srcu_read_lock(struct srcu_struct *sp)
> +{
> +	int idx;
> +
> +	preempt_disable();
> +	idx = sp->completed & 0x1;
> +	barrier();
> +	sp->per_cpu_ref[smp_processor_id()].c[idx]++;
> +	preempt_enable();
> +	return idx;
> +}

Could you explain this 'barrier()' ?

> +void synchronize_srcu(struct srcu_struct *sp)
> +{
> +	int cpu;
> +	int idx;
> +	int sum;
> +
> +	might_sleep();
> +
> +	mutex_lock(&sp->mutex);
> +
> +	smp_mb();  /* Prevent operations from leaking in. */

Why smp_wmb() is not enough? We are doing synchronize_sched() below
before reading ->per_cpu_ref, and ->completed is protected by ->mutex.

> +	idx = sp->completed & 0x1;
> +	sp->completed++;

But srcu_read_lock()'s path and rcu_dereference() doesn't have rmb(),
and the reader can block, so I can't understand how this all works.

Suppose ->completed == 0,

	WRITER:						READER:

	old = global_ptr;
	rcu_assign_pointer(global_ptr, new);

	synchronize_srcu:

		locks mutex, does mb,
		->completed++;
		
							srcu_read_lock();
								// reads ->completed == 1
								// does .c[1]++
							ptr = rcu_dereference(global_ptr)
								// reads the *OLD* value,
								// because we don't have rmb()

							block_on_something();


		synchronize_sched();
							// ... still blocked ...

		checks sum_of(.c[0]) == 0, yes

		synchronize_sched();
							// ... still blocked ...

	kfree(old);

							// wake up
							do_something(ptr);


Also, I can't understand the purpose of 2-nd synchronize_sched() in
synchronize_srcu().

Please help!

Oleg.

