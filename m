Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVJROBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVJROBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVJROBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:01:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18877 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750744AbVJROBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:01:48 -0400
Date: Mon, 17 Oct 2005 22:44:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: Re: [PATCH 8/9] Kprobes: Use RCU for (un)register synchronization - base changes
Message-ID: <20051018054436.GA1364@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com> <20051010144107.GC4389@in.ibm.com> <20051010144206.GD4389@in.ibm.com> <20051010144248.GE4389@in.ibm.com> <20051010144343.GF4389@in.ibm.com> <20051010144430.GG4389@in.ibm.com> <20051010144515.GH4389@in.ibm.com> <20051010144720.GI4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010144720.GI4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 10:47:20AM -0400, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Changes to the base kprobes infrastructure to use RCU for synchronization
> during kprobe registration and unregistration. These changes coupled with
> the arch kprobe changes (next in series):
> 
> a. serialize registration and unregistration of kprobes.
> b. enable lockless execution of handlers. Handlers can now run in parallel.

A couple of questions interspersed...  Probably my limited knowledge of
kprobes, but I have to ask...  Search for empty lines to find them.

						Thanx, Paul

> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> ---
> 
>  include/linux/kprobes.h |    9 +---
>  kernel/kprobes.c        |  101 +++++++++++++++++++-----------------------------
>  2 files changed, 45 insertions(+), 65 deletions(-)
> 
> Index: linux-2.6.14-rc3/include/linux/kprobes.h
> ===================================================================
> --- linux-2.6.14-rc3.orig/include/linux/kprobes.h	2005-10-07 21:40:43.000000000 -0400
> +++ linux-2.6.14-rc3/include/linux/kprobes.h	2005-10-07 21:40:49.000000000 -0400
> @@ -34,6 +34,8 @@
>  #include <linux/notifier.h>
>  #include <linux/smp.h>
>  #include <linux/percpu.h>
> +#include <linux/spinlock.h>
> +#include <linux/rcupdate.h>
>  
>  #include <asm/kprobes.h>
>  
> @@ -146,10 +148,7 @@ struct kretprobe_instance {
>  };
>  
>  #ifdef CONFIG_KPROBES
> -/* Locks kprobe: irq must be disabled */
> -void lock_kprobes(void);
> -void unlock_kprobes(void);
> -
> +extern spinlock_t kretprobe_lock;
>  extern int arch_prepare_kprobe(struct kprobe *p);
>  extern void arch_copy_kprobe(struct kprobe *p);
>  extern void arch_arm_kprobe(struct kprobe *p);
> @@ -160,7 +159,7 @@ extern void show_registers(struct pt_reg
>  extern kprobe_opcode_t *get_insn_slot(void);
>  extern void free_insn_slot(kprobe_opcode_t *slot);
>  
> -/* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
> +/* Get the kprobe at this addr (if any) - called under a rcu_read_lock() */

Since the update side uses synchronize_kernel() (in patch 9/9, right?),
shouldn't the above "rcu_read_lock()" instead by preempt_disable()?

Also, some of the code in the earlier patches seems to do preempt_disable.
For example, kprobe_handler() in arch/i386/kernel/kprobes.c.

In realtime kernels, synchronize_sched() does -not- guarantee that all
rcu_read_lock() critical sections have finished, only that any
preempt_disable() code sequences (explicit or implicit) have completed.

>  struct kprobe *get_kprobe(void *addr);
>  struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
>  
> Index: linux-2.6.14-rc3/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc3.orig/kernel/kprobes.c	2005-10-07 21:40:43.000000000 -0400
> +++ linux-2.6.14-rc3/kernel/kprobes.c	2005-10-07 21:41:11.000000000 -0400
> @@ -32,7 +32,6 @@
>   *		<prasanna@in.ibm.com> added function-return probes.
>   */
>  #include <linux/kprobes.h>
> -#include <linux/spinlock.h>
>  #include <linux/hash.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -48,8 +47,8 @@
>  static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
>  static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
>  
> -unsigned int kprobe_cpu = NR_CPUS;
> -static DEFINE_SPINLOCK(kprobe_lock);
> +static DEFINE_SPINLOCK(kprobe_lock);	/* Protects kprobe_table */
> +DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
>  
>  /*
> @@ -152,41 +151,6 @@ void __kprobes free_insn_slot(kprobe_opc
>  	}
>  }
>  
> -/* Locks kprobe: irqs must be disabled */
> -void __kprobes lock_kprobes(void)
> -{
> -	unsigned long flags = 0;
> -
> -	/* Avoiding local interrupts to happen right after we take the kprobe_lock
> -	 * and before we get a chance to update kprobe_cpu, this to prevent
> -	 * deadlock when we have a kprobe on ISR routine and a kprobe on task
> -	 * routine
> -	 */
> -	local_irq_save(flags);
> -
> -	spin_lock(&kprobe_lock);
> -	kprobe_cpu = smp_processor_id();
> -
> - 	local_irq_restore(flags);
> -}
> -
> -void __kprobes unlock_kprobes(void)
> -{
> -	unsigned long flags = 0;
> -
> -	/* Avoiding local interrupts to happen right after we update
> -	 * kprobe_cpu and before we get a a chance to release kprobe_lock,
> -	 * this to prevent deadlock when we have a kprobe on ISR routine and
> -	 * a kprobe on task routine
> -	 */
> -	local_irq_save(flags);
> -
> -	kprobe_cpu = NR_CPUS;
> -	spin_unlock(&kprobe_lock);
> -
> - 	local_irq_restore(flags);
> -}
> -
>  /* We have preemption disabled.. so it is safe to use __ versions */
>  static inline void set_kprobe_instance(struct kprobe *kp)
>  {
> @@ -198,14 +162,19 @@ static inline void reset_kprobe_instance
>  	__get_cpu_var(kprobe_instance) = NULL;
>  }
>  
> -/* You have to be holding the kprobe_lock */
> +/*
> + * This routine is called either:
> + * 	- under the kprobe_lock spinlock - during kprobe_[un]register()
> + * 				OR
> + * 	- under an rcu_read_lock() - from arch/xxx/kernel/kprobes.c

Same here -- shouldn't the rcu_read_lock() be preempt_disable()?

> + */
>  struct kprobe __kprobes *get_kprobe(void *addr)
>  {
>  	struct hlist_head *head;
>  	struct hlist_node *node;
>  
>  	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
> -	hlist_for_each(node, head) {
> +	hlist_for_each_rcu(node, head) {
>  		struct kprobe *p = hlist_entry(node, struct kprobe, hlist);
>  		if (p->addr == addr)
>  			return p;
> @@ -221,7 +190,7 @@ static int __kprobes aggr_pre_handler(st
>  {
>  	struct kprobe *kp;
>  
> -	list_for_each_entry(kp, &p->list, list) {
> +	list_for_each_entry_rcu(kp, &p->list, list) {
>  		if (kp->pre_handler) {
>  			set_kprobe_instance(kp);
>  			if (kp->pre_handler(kp, regs))
> @@ -237,7 +206,7 @@ static void __kprobes aggr_post_handler(
>  {
>  	struct kprobe *kp;
>  
> -	list_for_each_entry(kp, &p->list, list) {
> +	list_for_each_entry_rcu(kp, &p->list, list) {
>  		if (kp->post_handler) {
>  			set_kprobe_instance(kp);
>  			kp->post_handler(kp, regs, flags);
> @@ -276,6 +245,7 @@ static int __kprobes aggr_break_handler(
>  	return ret;
>  }
>  
> +/* Called with kretprobe_lock held */
>  struct kretprobe_instance __kprobes *get_free_rp_inst(struct kretprobe *rp)
>  {
>  	struct hlist_node *node;
> @@ -285,6 +255,7 @@ struct kretprobe_instance __kprobes *get
>  	return NULL;
>  }
>  
> +/* Called with kretprobe_lock held */
>  static struct kretprobe_instance __kprobes *get_used_rp_inst(struct kretprobe
>  							      *rp)
>  {
> @@ -295,6 +266,7 @@ static struct kretprobe_instance __kprob
>  	return NULL;
>  }
>  
> +/* Called with kretprobe_lock held */
>  void __kprobes add_rp_inst(struct kretprobe_instance *ri)
>  {
>  	/*
> @@ -313,6 +285,7 @@ void __kprobes add_rp_inst(struct kretpr
>  	hlist_add_head(&ri->uflist, &ri->rp->used_instances);
>  }
>  
> +/* Called with kretprobe_lock held */
>  void __kprobes recycle_rp_inst(struct kretprobe_instance *ri)
>  {
>  	/* remove rp inst off the rprobe_inst_table */
> @@ -346,13 +319,13 @@ void __kprobes kprobe_flush_task(struct 
>  	struct hlist_node *node, *tmp;
>  	unsigned long flags = 0;
>  
> -	spin_lock_irqsave(&kprobe_lock, flags);
> +	spin_lock_irqsave(&kretprobe_lock, flags);
>          head = kretprobe_inst_table_head(current);
>          hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
>                  if (ri->task == tk)
>                          recycle_rp_inst(ri);
>          }
> -	spin_unlock_irqrestore(&kprobe_lock, flags);
> +	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  }
>  
>  /*
> @@ -363,9 +336,12 @@ static int __kprobes pre_handler_kretpro
>  					   struct pt_regs *regs)
>  {
>  	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
> +	unsigned long flags = 0;
>  
>  	/*TODO: consider to only swap the RA after the last pre_handler fired */
> +	spin_lock_irqsave(&kretprobe_lock, flags);
>  	arch_prepare_kretprobe(rp, regs);
> +	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  	return 0;
>  }
>  
> @@ -396,13 +372,13 @@ static int __kprobes add_new_kprobe(stru
>          struct kprobe *kp;
>  
>  	if (p->break_handler) {
> -		list_for_each_entry(kp, &old_p->list, list) {
> +		list_for_each_entry_rcu(kp, &old_p->list, list) {
>  			if (kp->break_handler)
>  				return -EEXIST;
>  		}
> -		list_add_tail(&p->list, &old_p->list);
> +		list_add_tail_rcu(&p->list, &old_p->list);
>  	} else
> -		list_add(&p->list, &old_p->list);
> +		list_add_rcu(&p->list, &old_p->list);
>  	return 0;
>  }
>  
> @@ -420,18 +396,18 @@ static inline void add_aggr_kprobe(struc
>  	ap->break_handler = aggr_break_handler;
>  
>  	INIT_LIST_HEAD(&ap->list);
> -	list_add(&p->list, &ap->list);
> +	list_add_rcu(&p->list, &ap->list);
>  
>  	INIT_HLIST_NODE(&ap->hlist);
> -	hlist_del(&p->hlist);
> -	hlist_add_head(&ap->hlist,
> +	hlist_del_rcu(&p->hlist);
> +	hlist_add_head_rcu(&ap->hlist,
>  		&kprobe_table[hash_ptr(ap->addr, KPROBE_HASH_BITS)]);
>  }
>  
>  /*
>   * This is the second or subsequent kprobe at the address - handle
>   * the intricacies
> - * TODO: Move kcalloc outside the spinlock
> + * TODO: Move kcalloc outside the spin_lock
>   */
>  static int __kprobes register_aggr_kprobe(struct kprobe *old_p,
>  					  struct kprobe *p)
> @@ -457,7 +433,7 @@ static int __kprobes register_aggr_kprob
>  static inline void cleanup_kprobe(struct kprobe *p, unsigned long flags)
>  {
>  	arch_disarm_kprobe(p);
> -	hlist_del(&p->hlist);
> +	hlist_del_rcu(&p->hlist);
>  	spin_unlock_irqrestore(&kprobe_lock, flags);
>  	arch_remove_kprobe(p);
>  }
> @@ -465,11 +441,10 @@ static inline void cleanup_kprobe(struct
>  static inline void cleanup_aggr_kprobe(struct kprobe *old_p,
>  		struct kprobe *p, unsigned long flags)
>  {
> -	list_del(&p->list);
> -	if (list_empty(&old_p->list)) {
> +	list_del_rcu(&p->list);
> +	if (list_empty(&old_p->list))
>  		cleanup_kprobe(old_p, flags);
> -		kfree(old_p);
> -	} else
> +	else
>  		spin_unlock_irqrestore(&kprobe_lock, flags);
>  }
>  
> @@ -492,9 +467,9 @@ int __kprobes register_kprobe(struct kpr
>  	if ((ret = arch_prepare_kprobe(p)) != 0)
>  		goto rm_kprobe;
>  
> +	p->nmissed = 0;
>  	spin_lock_irqsave(&kprobe_lock, flags);
>  	old_p = get_kprobe(p->addr);
> -	p->nmissed = 0;
>  	if (old_p) {
>  		ret = register_aggr_kprobe(old_p, p);
>  		goto out;
> @@ -502,7 +477,7 @@ int __kprobes register_kprobe(struct kpr
>  
>  	arch_copy_kprobe(p);
>  	INIT_HLIST_NODE(&p->hlist);
> -	hlist_add_head(&p->hlist,
> +	hlist_add_head_rcu(&p->hlist,
>  		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
>  
>    	arch_arm_kprobe(p);
> @@ -523,10 +498,16 @@ void __kprobes unregister_kprobe(struct 
>  	spin_lock_irqsave(&kprobe_lock, flags);
>  	old_p = get_kprobe(p->addr);
>  	if (old_p) {
> +		/* cleanup_*_kprobe() does the spin_unlock_irqrestore */
>  		if (old_p->pre_handler == aggr_pre_handler)
>  			cleanup_aggr_kprobe(old_p, p, flags);
>  		else
>  			cleanup_kprobe(p, flags);
> +
> +		synchronize_sched();
> +		if (old_p->pre_handler == aggr_pre_handler &&
> +				list_empty(&old_p->list))
> +			kfree(old_p);
>  	} else
>  		spin_unlock_irqrestore(&kprobe_lock, flags);
>  }
> @@ -603,13 +584,13 @@ void __kprobes unregister_kretprobe(stru
>  
>  	unregister_kprobe(&rp->kp);
>  	/* No race here */
> -	spin_lock_irqsave(&kprobe_lock, flags);
> +	spin_lock_irqsave(&kretprobe_lock, flags);
>  	free_rp_inst(rp);
>  	while ((ri = get_used_rp_inst(rp)) != NULL) {
>  		ri->rp = NULL;
>  		hlist_del(&ri->uflist);
>  	}
> -	spin_unlock_irqrestore(&kprobe_lock, flags);
> +	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  }
>  
>  static int __init init_kprobes(void)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
