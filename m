Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVJYBVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVJYBVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 21:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVJYBVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 21:21:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12510 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751270AbVJYBVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 21:21:30 -0400
Date: Mon, 24 Oct 2005 18:22:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       anil.s.keshavamurthy@intel.com, prasanna@in.ibm.com,
       davem@davemloft.net
Subject: Re: [PATCH] Kprobes: preempt_disable/enable() reordering redux
Message-ID: <20051025012210.GB13091@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051024155719.GA6024@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024155719.GA6024@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 11:57:19AM -0400, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> This patch (over 2.6.14-rc4-mm1) reorganizes the preempt_disable/enable
> calls to eliminate the extra preempt depth. Changes based on Paul
> McKenney's review suggestions for the kprobes RCU changeset.

Looks good!!!  (Am assuming that the synchronize_sched() remains in
the 8/9 patch.)

						Thanx, Paul

Acked-by: <paulmck@us.ibm.com>

> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> ---
> 
>  arch/i386/kernel/kprobes.c    |   25 +++++++++++++++----------
>  arch/ia64/kernel/kprobes.c    |   37 ++++++++++++++++++++-----------------
>  arch/ppc64/kernel/kprobes.c   |   25 +++++++++++++++----------
>  arch/sparc64/kernel/kprobes.c |   21 +++++++++++++--------
>  arch/x86_64/kernel/kprobes.c  |   29 +++++++++++++++--------------
>  include/linux/kprobes.h       |    2 +-
>  kernel/kprobes.c              |    2 +-
>  7 files changed, 80 insertions(+), 61 deletions(-)
> 
> Index: linux-2.6.14-rc4/arch/i386/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/arch/i386/kernel/kprobes.c	2005-10-17 18:59:51.000000000 -0400
> +++ linux-2.6.14-rc4/arch/i386/kernel/kprobes.c	2005-10-21 11:02:52.000000000 -0400
> @@ -153,7 +153,14 @@ static int __kprobes kprobe_handler(stru
>  	int ret = 0;
>  	kprobe_opcode_t *addr = NULL;
>  	unsigned long *lp;
> -	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	struct kprobe_ctlblk *kcb;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing
> +	 */
> +	preempt_disable();
> +	kcb = get_kprobe_ctlblk();
>  
>  	/* Check if the application is using LDT entry for its code segment and
>  	 * calculate the address by reading the base address from the LDT entry.
> @@ -221,11 +228,6 @@ static int __kprobes kprobe_handler(stru
>  		goto no_kprobe;
>  	}
>  
> -	/*
> -	 * This preempt_disable() matches the preempt_enable_no_resched()
> -	 * in post_kprobe_handler()
> -	 */
> -	preempt_disable();
>  	set_current_kprobe(p, regs, kcb);
>  	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  
> @@ -239,6 +241,7 @@ ss_probe:
>  	return 1;
>  
>  no_kprobe:
> +	preempt_enable_no_resched();
>  	return ret;
>  }
>  
> @@ -310,8 +313,8 @@ int __kprobes trampoline_probe_handler(s
>  
>  	/*
>  	 * By returning a non-zero value, we are telling
> -	 * kprobe_handler() that we have handled unlocking
> -	 * and re-enabling preemption
> +	 * kprobe_handler() that we don't want the post_handler
> +	 * to run (and have re-enabled preemption)
>  	 */
>          return 1;
>  }
> @@ -455,7 +458,6 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	rcu_read_lock();
>  	switch (val) {
>  	case DIE_INT3:
>  		if (kprobe_handler(args->regs))
> @@ -467,14 +469,16 @@ int __kprobes kprobe_exceptions_notify(s
>  		break;
>  	case DIE_GPF:
>  	case DIE_PAGE_FAULT:
> +		/* kprobe_running() needs smp_processor_id() */
> +		preempt_disable();
>  		if (kprobe_running() &&
>  		    kprobe_fault_handler(args->regs, args->trapnr))
>  			ret = NOTIFY_STOP;
> +		preempt_enable();
>  		break;
>  	default:
>  		break;
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
>  
> @@ -537,6 +541,7 @@ int __kprobes longjmp_break_handler(stru
>  		*regs = kcb->jprobe_saved_regs;
>  		memcpy((kprobe_opcode_t *) stack_addr, kcb->jprobes_stack,
>  		       MIN_STACK_SIZE(stack_addr));
> +		preempt_enable_no_resched();
>  		return 1;
>  	}
>  	return 0;
> Index: linux-2.6.14-rc4/include/linux/kprobes.h
> ===================================================================
> --- linux-2.6.14-rc4.orig/include/linux/kprobes.h	2005-10-17 19:00:01.000000000 -0400
> +++ linux-2.6.14-rc4/include/linux/kprobes.h	2005-10-19 10:56:35.000000000 -0400
> @@ -159,7 +159,7 @@ extern void show_registers(struct pt_reg
>  extern kprobe_opcode_t *get_insn_slot(void);
>  extern void free_insn_slot(kprobe_opcode_t *slot);
>  
> -/* Get the kprobe at this addr (if any) - called under a rcu_read_lock() */
> +/* Get the kprobe at this addr (if any) - called with preemption disabled */
>  struct kprobe *get_kprobe(void *addr);
>  struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
>  
> Index: linux-2.6.14-rc4/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/kernel/kprobes.c	2005-10-17 19:00:02.000000000 -0400
> +++ linux-2.6.14-rc4/kernel/kprobes.c	2005-10-18 14:19:01.000000000 -0400
> @@ -167,7 +167,7 @@ static inline void reset_kprobe_instance
>   * This routine is called either:
>   * 	- under the kprobe_lock spinlock - during kprobe_[un]register()
>   * 				OR
> - * 	- under an rcu_read_lock() - from arch/xxx/kernel/kprobes.c
> + * 	- with preemption disabled - from arch/xxx/kernel/kprobes.c
>   */
>  struct kprobe __kprobes *get_kprobe(void *addr)
>  {
> Index: linux-2.6.14-rc4/arch/ia64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/arch/ia64/kernel/kprobes.c	2005-10-17 18:59:52.000000000 -0400
> +++ linux-2.6.14-rc4/arch/ia64/kernel/kprobes.c	2005-10-21 13:50:10.000000000 -0400
> @@ -389,11 +389,11 @@ int __kprobes trampoline_probe_handler(s
>  	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  	preempt_enable_no_resched();
>  
> -        /*
> -         * By returning a non-zero value, we are telling
> -         * kprobe_handler() that we have handled unlocking
> -	 * and re-enabling preemption
> -         */
> +	/*
> +	 * By returning a non-zero value, we are telling
> +	 * kprobe_handler() that we don't want the post_handler
> +	 * to run (and have re-enabled preemption)
> +	 */
>          return 1;
>  }
>  
> @@ -604,7 +604,14 @@ static int __kprobes pre_kprobes_handler
>  	int ret = 0;
>  	struct pt_regs *regs = args->regs;
>  	kprobe_opcode_t *addr = (kprobe_opcode_t *)instruction_pointer(regs);
> -	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	struct kprobe_ctlblk *kcb;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing
> +	 */
> +	preempt_disable();
> +	kcb = get_kprobe_ctlblk();
>  
>  	/* Handle recursion cases */
>  	if (kprobe_running()) {
> @@ -659,11 +666,6 @@ static int __kprobes pre_kprobes_handler
>  		goto no_kprobe;
>  	}
>  
> -	/*
> -	 * This preempt_disable() matches the preempt_enable_no_resched()
> -	 * in post_kprobes_handler()
> -	 */
> -	preempt_disable();
>  	set_current_kprobe(p, kcb);
>  	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  
> @@ -681,6 +683,7 @@ ss_probe:
>  	return 1;
>  
>  no_kprobe:
> +	preempt_enable_no_resched();
>  	return ret;
>  }
>  
> @@ -716,9 +719,6 @@ static int __kprobes kprobes_fault_handl
>  	struct kprobe *cur = kprobe_running();
>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>  
> -	if (!cur)
> -		return 0;
> -
>  	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
>  		return 1;
>  
> @@ -737,7 +737,6 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	rcu_read_lock();
>  	switch(val) {
>  	case DIE_BREAK:
>  		if (pre_kprobes_handler(args))
> @@ -748,12 +747,15 @@ int __kprobes kprobe_exceptions_notify(s
>  			ret = NOTIFY_STOP;
>  		break;
>  	case DIE_PAGE_FAULT:
> -		if (kprobes_fault_handler(args->regs, args->trapnr))
> +		/* kprobe_running() needs smp_processor_id() */
> +		preempt_disable();
> +		if (kprobe_running() &&
> +			kprobes_fault_handler(args->regs, args->trapnr))
>  			ret = NOTIFY_STOP;
> +		preempt_enable();
>  	default:
>  		break;
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
>  
> @@ -785,6 +787,7 @@ int __kprobes longjmp_break_handler(stru
>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>  
>  	*regs = kcb->jprobe_saved_regs;
> +	preempt_enable_no_resched();
>  	return 1;
>  }
>  
> Index: linux-2.6.14-rc4/arch/ppc64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/arch/ppc64/kernel/kprobes.c	2005-10-17 18:59:52.000000000 -0400
> +++ linux-2.6.14-rc4/arch/ppc64/kernel/kprobes.c	2005-10-19 11:00:02.000000000 -0400
> @@ -148,7 +148,14 @@ static inline int kprobe_handler(struct 
>  	struct kprobe *p;
>  	int ret = 0;
>  	unsigned int *addr = (unsigned int *)regs->nip;
> -	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	struct kprobe_ctlblk *kcb;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing
> +	 */
> +	preempt_disable();
> +	kcb = get_kprobe_ctlblk();
>  
>  	/* Check we're not actually recursing */
>  	if (kprobe_running()) {
> @@ -207,11 +214,6 @@ static inline int kprobe_handler(struct 
>  		goto no_kprobe;
>  	}
>  
> -	/*
> -	 * This preempt_disable() matches the preempt_enable_no_resched()
> -	 * in post_kprobe_handler().
> -	 */
> -	preempt_disable();
>  	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  	set_current_kprobe(p, regs, kcb);
>  	if (p->pre_handler && p->pre_handler(p, regs))
> @@ -224,6 +226,7 @@ ss_probe:
>  	return 1;
>  
>  no_kprobe:
> +	preempt_enable_no_resched();
>  	return ret;
>  }
>  
> @@ -296,8 +299,8 @@ int __kprobes trampoline_probe_handler(s
>  
>          /*
>           * By returning a non-zero value, we are telling
> -         * kprobe_handler() that we have handled unlocking
> -         * and re-enabling preemption.
> +         * kprobe_handler() that we don't want the post_handler
> +         * to run (and have re-enabled preemption)
>           */
>          return 1;
>  }
> @@ -385,7 +388,6 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	rcu_read_lock();
>  	switch (val) {
>  	case DIE_BPT:
>  		if (kprobe_handler(args->regs))
> @@ -397,14 +399,16 @@ int __kprobes kprobe_exceptions_notify(s
>  		break;
>  	case DIE_GPF:
>  	case DIE_PAGE_FAULT:
> +		/* kprobe_running() needs smp_processor_id() */
> +		preempt_disable();
>  		if (kprobe_running() &&
>  		    kprobe_fault_handler(args->regs, args->trapnr))
>  			ret = NOTIFY_STOP;
> +		preempt_enable();
>  		break;
>  	default:
>  		break;
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
>  
> @@ -441,6 +445,7 @@ int __kprobes longjmp_break_handler(stru
>  	 * saved regs...
>  	 */
>  	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
> +	preempt_enable_no_resched();
>  	return 1;
>  }
>  
> Index: linux-2.6.14-rc4/arch/sparc64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/arch/sparc64/kernel/kprobes.c	2005-10-17 18:59:53.000000000 -0400
> +++ linux-2.6.14-rc4/arch/sparc64/kernel/kprobes.c	2005-10-19 11:00:21.000000000 -0400
> @@ -113,7 +113,14 @@ static int __kprobes kprobe_handler(stru
>  	struct kprobe *p;
>  	void *addr = (void *) regs->tpc;
>  	int ret = 0;
> -	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	struct kprobe_ctlblk *kcb;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing
> +	 */
> +	preempt_disable();
> +	kcb = get_kprobe_ctlblk();
>  
>  	if (kprobe_running()) {
>  		p = get_kprobe(addr);
> @@ -159,11 +166,6 @@ static int __kprobes kprobe_handler(stru
>  		goto no_kprobe;
>  	}
>  
> -	/*
> -	 * This preempt_disable() matches the preempt_enable_no_resched()
> -	 * in post_kprobes_handler()
> -	 */
> -	preempt_disable();
>  	set_current_kprobe(p, regs, kcb);
>  	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  	if (p->pre_handler && p->pre_handler(p, regs))
> @@ -175,6 +177,7 @@ ss_probe:
>  	return 1;
>  
>  no_kprobe:
> +	preempt_enable_no_resched();
>  	return ret;
>  }
>  
> @@ -321,7 +324,6 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	rcu_read_lock();
>  	switch (val) {
>  	case DIE_DEBUG:
>  		if (kprobe_handler(args->regs))
> @@ -333,14 +335,16 @@ int __kprobes kprobe_exceptions_notify(s
>  		break;
>  	case DIE_GPF:
>  	case DIE_PAGE_FAULT:
> +		/* kprobe_running() needs smp_processor_id() */
> +		preempt_disable();
>  		if (kprobe_running() &&
>  		    kprobe_fault_handler(args->regs, args->trapnr))
>  			ret = NOTIFY_STOP;
> +		preempt_enable();
>  		break;
>  	default:
>  		break;
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
>  
> @@ -426,6 +430,7 @@ int __kprobes longjmp_break_handler(stru
>  		       &(kcb->jprobe_saved_stack),
>  		       sizeof(kcb->jprobe_saved_stack));
>  
> +		preempt_enable_no_resched();
>  		return 1;
>  	}
>  	return 0;
> Index: linux-2.6.14-rc4/arch/x86_64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/arch/x86_64/kernel/kprobes.c	2005-10-17 18:59:53.000000000 -0400
> +++ linux-2.6.14-rc4/arch/x86_64/kernel/kprobes.c	2005-10-19 11:01:31.000000000 -0400
> @@ -286,16 +286,19 @@ void __kprobes arch_prepare_kretprobe(st
>          }
>  }
>  
> -/*
> - * Interrupts are disabled on entry as trap3 is an interrupt gate and they
> - * remain disabled thorough out this function.
> - */
>  int __kprobes kprobe_handler(struct pt_regs *regs)
>  {
>  	struct kprobe *p;
>  	int ret = 0;
>  	kprobe_opcode_t *addr = (kprobe_opcode_t *)(regs->rip - sizeof(kprobe_opcode_t));
> -	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	struct kprobe_ctlblk *kcb;
> +
> +	/*
> +	 * We don't want to be preempted for the entire
> +	 * duration of kprobe processing
> +	 */
> +	preempt_disable();
> +	kcb = get_kprobe_ctlblk();
>  
>  	/* Check we're not actually recursing */
>  	if (kprobe_running()) {
> @@ -359,11 +362,6 @@ int __kprobes kprobe_handler(struct pt_r
>  		goto no_kprobe;
>  	}
>  
> -	/*
> -	 * This preempt_disable() matches the preempt_enable_no_resched()
> -	 * in post_kprobe_handler()
> -	 */
> -	preempt_disable();
>  	set_current_kprobe(p, regs, kcb);
>  	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>  
> @@ -377,6 +375,7 @@ ss_probe:
>  	return 1;
>  
>  no_kprobe:
> +	preempt_enable_no_resched();
>  	return ret;
>  }
>  
> @@ -448,8 +447,8 @@ int __kprobes trampoline_probe_handler(s
>  
>          /*
>           * By returning a non-zero value, we are telling
> -         * kprobe_handler() that we have handled unlocking
> -	 * and re-enabling preemption
> +         * kprobe_handler() that we don't want the post_handler
> +	 * to run (and have re-enabled preemption)
>           */
>          return 1;
>  }
> @@ -594,7 +593,6 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	rcu_read_lock();
>  	switch (val) {
>  	case DIE_INT3:
>  		if (kprobe_handler(args->regs))
> @@ -606,14 +604,16 @@ int __kprobes kprobe_exceptions_notify(s
>  		break;
>  	case DIE_GPF:
>  	case DIE_PAGE_FAULT:
> +		/* kprobe_running() needs smp_processor_id() */
> +		preempt_disable();
>  		if (kprobe_running() &&
>  		    kprobe_fault_handler(args->regs, args->trapnr))
>  			ret = NOTIFY_STOP;
> +		preempt_enable();
>  		break;
>  	default:
>  		break;
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
>  
> @@ -675,6 +675,7 @@ int __kprobes longjmp_break_handler(stru
>  		*regs = kcb->jprobe_saved_regs;
>  		memcpy((kprobe_opcode_t *) stack_addr, kcb->jprobes_stack,
>  		       MIN_STACK_SIZE(stack_addr));
> +		preempt_enable_no_resched();
>  		return 1;
>  	}
>  	return 0;
> 
