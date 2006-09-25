Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWIYSHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWIYSHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWIYSHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:07:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25306 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751423AbWIYSHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:07:30 -0400
Date: Mon, 25 Sep 2006 11:08:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH] RCU: debug sleep check
Message-ID: <20060925180805.GF1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060923152957.GA13432@in.ibm.com> <20060924183509.GB22448@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924183509.GB22448@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 12:05:09AM +0530, Dipankar Sarma wrote:
> This adds an overhead of a function call and local_irq_save/restore
> in the rcu reader path when CONFIG_DEBUG_SPINLOCK_SLEEP is set.
> Hopefully that is not much of a concern. Comments are welcome.
> Applies on top of my earlier patches. The full patchset is
> at http://www.hill9.org/linux/kernel/patches/2.6.18-mm1/.
> 
> Add a debug check for rcu read-side critical section code calling
> a function that might sleep which is illegal. The check is enabled only
> if CONFIG_DEBUG_SPINLOCK_SLEEP is set.

Useful for non-CONFIG_PREEMPT kernels!

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> ---
> 
> 
>  include/linux/rcupdate.h |   34 ++++++++++++++++++++++++++++++----
>  kernel/rcupdate.c        |   33 +++++++++++++++++++++++++++++++++
>  kernel/sched.c           |    2 +-
>  3 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff -puN include/linux/rcupdate.h~rcu-reader-sleep-check include/linux/rcupdate.h
> --- linux-2.6.18-mm1-rcu/include/linux/rcupdate.h~rcu-reader-sleep-check	2006-09-24 23:18:35.000000000 +0530
> +++ linux-2.6.18-mm1-rcu-dipankar/include/linux/rcupdate.h	2006-09-24 23:18:35.000000000 +0530
> @@ -64,6 +64,16 @@ struct rcu_head {
>         (ptr)->next = NULL; (ptr)->func = NULL; \
>  } while (0)
>  
> +#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
> +extern int rcu_read_in_atomic(void);
> +extern void rcu_add_read_count(void);
> +extern void rcu_sub_read_count(void);
> +#else
> +static inline int rcu_read_in_atomic(void) { return 0;}
> +static inline void rcu_add_read_count(void) {}
> +static inline void rcu_sub_read_count(void) {}
> +#endif
> +
>  /**
>   * rcu_read_lock - mark the beginning of an RCU read-side critical section.
>   *
> @@ -93,14 +103,22 @@ struct rcu_head {
>   *
>   * It is illegal to block while in an RCU read-side critical section.
>   */
> -#define rcu_read_lock() __rcu_read_lock()
> +#define rcu_read_lock()	\
> +	do {	\
> +		rcu_add_read_count();	\
> +		__rcu_read_lock();	\
> +	} while (0)
>  
>  /**
>   * rcu_read_unlock - marks the end of an RCU read-side critical section.
>   *
>   * See rcu_read_lock() for more information.
>   */
> -#define rcu_read_unlock() __rcu_read_unlock()
> +#define rcu_read_unlock()	\
> +	do {	\
> +		__rcu_read_unlock();	\
> +		rcu_sub_read_count();	\
> +	} while (0)
>  
>  /*
>   * So where is rcu_write_lock()?  It does not exist, as there is no
> @@ -123,14 +141,22 @@ struct rcu_head {
>   * can use just rcu_read_lock().
>   *
>   */
> -#define rcu_read_lock_bh()	__rcu_read_lock_bh()
> +#define rcu_read_lock_bh()	\
> +	do {	\
> +		rcu_add_read_count();	\
> +		__rcu_read_lock_bh();	\
> +	} while (0)
>    
>  /**
>   * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
>   *
>   * See rcu_read_lock_bh() for more information.
>   */
> -#define rcu_read_unlock_bh()	__rcu_read_unlock_bh()
> +#define rcu_read_unlock_bh()	\
> +	do {	\
> +		__rcu_read_unlock_bh();	\
> +		rcu_sub_read_count();	\
> +	} while (0)
>    
>  /**
>   * rcu_dereference - fetch an RCU-protected pointer in an
> diff -puN kernel/rcupdate.c~rcu-reader-sleep-check kernel/rcupdate.c
> --- linux-2.6.18-mm1-rcu/kernel/rcupdate.c~rcu-reader-sleep-check	2006-09-24 23:18:35.000000000 +0530
> +++ linux-2.6.18-mm1-rcu-dipankar/kernel/rcupdate.c	2006-09-24 23:18:35.000000000 +0530
> @@ -127,5 +127,38 @@ void __init rcu_init(void)
>  	__rcu_init();
>  }
>  
> +#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
> +DEFINE_PER_CPU(int, rcu_read_count);
> +int rcu_read_in_atomic(void)
> +{
> +	int val;
> +	int cpu = get_cpu();
> +	val = per_cpu(rcu_read_count, cpu);
> +	put_cpu();
> +	return val;
> +}
> +
> +void rcu_add_read_count(void)
> +{
> +	int cpu, flags;
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	per_cpu(rcu_read_count, cpu)++;
> +	local_irq_restore(flags);
> +}
> +
> +void rcu_sub_read_count(void)
> +{
> +	int cpu, flags;
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	per_cpu(rcu_read_count, cpu)--;
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL_GPL(rcu_read_in_atomic);
> +EXPORT_SYMBOL_GPL(rcu_add_read_count);
> +EXPORT_SYMBOL_GPL(rcu_sub_read_count);
> +#endif
> +
>  EXPORT_SYMBOL_GPL(rcu_barrier);
>  EXPORT_SYMBOL_GPL(synchronize_rcu);
> diff -puN kernel/sched.c~rcu-reader-sleep-check kernel/sched.c
> --- linux-2.6.18-mm1-rcu/kernel/sched.c~rcu-reader-sleep-check	2006-09-24 23:18:35.000000000 +0530
> +++ linux-2.6.18-mm1-rcu-dipankar/kernel/sched.c	2006-09-24 23:18:35.000000000 +0530
> @@ -6974,7 +6974,7 @@ void __might_sleep(char *file, int line)
>  #ifdef in_atomic
>  	static unsigned long prev_jiffy;	/* ratelimiting */
>  
> -	if ((in_atomic() || irqs_disabled()) &&
> +	if ((in_atomic() || irqs_disabled() || rcu_read_in_atomic()) &&
>  	    system_state == SYSTEM_RUNNING && !oops_in_progress) {
>  		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
>  			return;
> 
> _
