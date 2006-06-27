Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWF0S7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWF0S7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWF0S7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:59:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:10938 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932528AbWF0S7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:59:08 -0400
Date: Tue, 27 Jun 2006 11:59:45 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] srcu: RCU variant permitting read-side blocking
Message-ID: <20060627185945.GD1286@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627211358.GA484@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627211358.GA484@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 01:13:58AM +0400, Oleg Nesterov wrote:
> Hello Paul,
> 
> "Paul E. McKenney" wrote:
> >
> > +void init_srcu_struct(struct srcu_struct *sp)
> > +{
> > +	int cpu;
> > +
> > +	sp->completed = 0;
> > +	sp->per_cpu_ref = (struct srcu_struct_array *)
> > +			  kmalloc(NR_CPUS * sizeof(*sp->per_cpu_ref),
> > +				  GFP_KERNEL);
> > +	for_each_cpu(cpu) {
> > +		sp->per_cpu_ref[cpu].c[0] = 0;
> > +		sp->per_cpu_ref[cpu].c[1] = 0;
> > +	}
> 
> Isn't it simpler to just do:
> 
> 	sp->per_cpu_ref = kzmalloc(NR_CPUS * sizeof(*sp->per_cpu_ref),
> 				GFP_KERNEL);
> 
> and drop 'for_each_cpu(cpu)' initialization ?

Yes, and even simpler to use the alloc_percpu(), as Andrew suggested.

> > +int srcu_read_lock(struct srcu_struct *sp)
> > +{
> > +	int idx;
> > +
> > +	preempt_disable();
> > +	idx = sp->completed & 0x1;
> > +	barrier();
> > +	sp->per_cpu_ref[smp_processor_id()].c[idx]++;
> > +	preempt_enable();
> > +	return idx;
> > +}
> 
> Could you explain this 'barrier()' ?

It ensures that the compiler picks up sp->completed but once.
It is hard to imagine a compiler generating code that fetched sp->completed
more than once, but I have been unpleasantly surprised before.

Thoughts?

> > +void synchronize_srcu(struct srcu_struct *sp)
> > +{
> > +	int cpu;
> > +	int idx;
> > +	int sum;
> > +
> > +	might_sleep();
> > +
> > +	mutex_lock(&sp->mutex);
> > +
> > +	smp_mb();  /* Prevent operations from leaking in. */
> 
> Why smp_wmb() is not enough? We are doing synchronize_sched() below
> before reading ->per_cpu_ref, and ->completed is protected by ->mutex.

Could well be that smp_wmb() is sufficient.  I frankly was not engaging
in that level of optimization on this round.  Seems likely, given that
I was not able to come up with a convincing counter-example.

That said, I am not going to change it until I can prove that it is
safe.  ;-)

> > +	idx = sp->completed & 0x1;
> > +	sp->completed++;
> 
> But srcu_read_lock()'s path and rcu_dereference() doesn't have rmb(),
> and the reader can block, so I can't understand how this all works.
> 
> Suppose ->completed == 0,
> 
> 	WRITER:						READER:
> 
> 	old = global_ptr;
> 	rcu_assign_pointer(global_ptr, new);
> 
> 	synchronize_srcu:
> 
> 		locks mutex, does mb,
> 		->completed++;
> 		
> 							srcu_read_lock();
> 								// reads ->completed == 1
> 								// does .c[1]++
> 							ptr = rcu_dereference(global_ptr)
> 								// reads the *OLD* value,
> 								// because we don't have rmb()

Hmmm...  I thought I was handling this case, but my rationale as to
how is looking a bit flimsy at the moment.  ;-)  I will look at this
more carefully.  If you are correct, one fix is to replace the prior mb
with synchronize_sched().  Do you agree that this would fix the problem?

> 							block_on_something();
> 
> 
> 		synchronize_sched();

The above synchronize_sched() guarantees that all srcu_read_lock() calls
that are still in flight will either (1) already be accounted for in .c[1]
or (2) do their accounting in .c[0].

> 							// ... still blocked ...
> 
> 		checks sum_of(.c[0]) == 0, yes
> 
> 		synchronize_sched();

This one handles the srcu_read_unlock() analog of the situation you
are worried about above.  The reader does not have memory barriers in
srcu_read_unlock(), so an access to the data structure might get
reordered to follow the decrement of .c[0] -- which would get messed
up by the following kfree().

The synchronize_sched() guarantees that all concurrent srcu_read_unlock()
calls complete cleanly before synchronize_sched() returns, inserting
a memory barrier on each CPU to enforce this.

> 							// ... still blocked ...
> 
> 	kfree(old);
> 
> 							// wake up
> 							do_something(ptr);
> 
> 
> Also, I can't understand the purpose of 2-nd synchronize_sched() in
> synchronize_srcu().

(See above.)

> Please help!

Thank you for the careful review!  I will look more carefully into the
scenario you called out above.

							Thanx, Paul
