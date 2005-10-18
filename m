Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVJROBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVJROBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVJROBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:01:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:25021 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750752AbVJROBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:01:52 -0400
Date: Mon, 17 Oct 2005 22:49:30 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net,
       prasanna@in.ibm.com
Subject: Re: [PATCH 9/9] Kprobes: Use RCU for (un)register synchronization - arch changes
Message-ID: <20051018054930.GB1364@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051010143747.GA4389@in.ibm.com> <20051010143928.GB4389@in.ibm.com> <20051010144107.GC4389@in.ibm.com> <20051010144206.GD4389@in.ibm.com> <20051010144248.GE4389@in.ibm.com> <20051010144343.GF4389@in.ibm.com> <20051010144430.GG4389@in.ibm.com> <20051010144515.GH4389@in.ibm.com> <20051010144720.GI4389@in.ibm.com> <20051010144813.GJ4389@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010144813.GJ4389@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 10:48:13AM -0400, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Changes to the arch kprobes infrastructure to take advantage of the locking
> changes introduced by usage of RCU for synchronization. All handlers are
> now run without any locks held, so they have to be re-entrant or provide
> their own synchronization.

And a few very similar questions here as well...

							Thanx, Paul

> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> ---
> 
>  arch/i386/kernel/kprobes.c    |   22 +++++++---------------
>  arch/ia64/kernel/kprobes.c    |   16 ++++++----------
>  arch/ppc64/kernel/kprobes.c   |   24 ++++++------------------
>  arch/sparc64/kernel/kprobes.c |   14 ++------------
>  arch/x86_64/kernel/kprobes.c  |   25 ++++++-------------------
>  5 files changed, 27 insertions(+), 74 deletions(-)
> 
> Index: linux-2.6.14-rc3/arch/i386/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc3.orig/arch/i386/kernel/kprobes.c	2005-10-05 16:08:13.000000000 -0400
> +++ linux-2.6.14-rc3/arch/i386/kernel/kprobes.c	2005-10-05 16:08:48.000000000 -0400
> @@ -31,7 +31,6 @@
>  #include <linux/config.h>
>  #include <linux/kprobes.h>
>  #include <linux/ptrace.h>
> -#include <linux/spinlock.h>
>  #include <linux/preempt.h>
>  #include <asm/cacheflush.h>
>  #include <asm/kdebug.h>
> @@ -123,6 +122,7 @@ static inline void prepare_singlestep(st
>  		regs->eip = (unsigned long)&p->ainsn.insn;
>  }
>  
> +/* Called with kretprobe_lock held */
>  void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
>  				      struct pt_regs *regs)
>  {
> @@ -168,15 +168,12 @@ static int __kprobes kprobe_handler(stru
>  	}
>  	/* Check we're not actually recursing */
>  	if (kprobe_running()) {
> -		/* We *are* holding lock here, so this is safe.
> -		   Disarm the probe we just hit, and ignore it. */
>  		p = get_kprobe(addr);
>  		if (p) {
>  			if (kcb->kprobe_status == KPROBE_HIT_SS &&
>  				*p->ainsn.insn == BREAKPOINT_INSTRUCTION) {
>  				regs->eflags &= ~TF_MASK;
>  				regs->eflags |= kcb->kprobe_saved_eflags;
> -				unlock_kprobes();
>  				goto no_kprobe;
>  			}
>  			/* We have reentered the kprobe_handler(), since
> @@ -197,14 +194,11 @@ static int __kprobes kprobe_handler(stru
>  				goto ss_probe;
>  			}
>  		}
> -		/* If it's not ours, can't be delete race, (we hold lock). */
>  		goto no_kprobe;
>  	}
>  
> -	lock_kprobes();
>  	p = get_kprobe(addr);
>  	if (!p) {
> -		unlock_kprobes();
>  		if (regs->eflags & VM_MASK) {
>  			/* We are in virtual-8086 mode. Return 0 */
>  			goto no_kprobe;
> @@ -268,9 +262,10 @@ int __kprobes trampoline_probe_handler(s
>          struct kretprobe_instance *ri = NULL;
>          struct hlist_head *head;
>          struct hlist_node *node, *tmp;
> -	unsigned long orig_ret_address = 0;
> +	unsigned long flags, orig_ret_address = 0;
>  	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
>  
> +	spin_lock_irqsave(&kretprobe_lock, flags);
>          head = kretprobe_inst_table_head(current);
>  
>  	/*
> @@ -310,7 +305,7 @@ int __kprobes trampoline_probe_handler(s
>  	regs->eip = orig_ret_address;
>  
>  	reset_current_kprobe();
> -	unlock_kprobes();
> +	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  	preempt_enable_no_resched();
>  
>          /*
> @@ -395,7 +390,7 @@ static void __kprobes resume_execution(s
>  
>  /*
>   * Interrupts are disabled on entry as trap1 is an interrupt gate and they
> - * remain disabled thoroughout this function.  And we hold kprobe lock.
> + * remain disabled thoroughout this function.
>   */
>  static inline int post_kprobe_handler(struct pt_regs *regs)
>  {
> @@ -419,7 +414,6 @@ static inline int post_kprobe_handler(st
>  		goto out;
>  	}
>  	reset_current_kprobe();
> -	unlock_kprobes();
>  out:
>  	preempt_enable_no_resched();
>  
> @@ -434,7 +428,6 @@ out:
>  	return 1;
>  }
>  
> -/* Interrupts disabled, kprobe_lock held. */
>  static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  {
>  	struct kprobe *cur = kprobe_running();
> @@ -448,7 +441,6 @@ static inline int kprobe_fault_handler(s
>  		regs->eflags |= kcb->kprobe_old_eflags;
>  
>  		reset_current_kprobe();
> -		unlock_kprobes();
>  		preempt_enable_no_resched();
>  	}
>  	return 0;
> @@ -463,7 +455,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	preempt_disable();
> +	rcu_read_lock();

If synchronize_sched() is used on the update side, this needs to
remain preempt_disable() rather than rcu_read_lock().

>  	switch (val) {
>  	case DIE_INT3:
>  		if (kprobe_handler(args->regs))
> @@ -482,7 +474,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	default:
>  		break;
>  	}
> -	preempt_enable();
> +	rcu_read_unlock();
>  	return ret;
>  }
>  
> Index: linux-2.6.14-rc3/arch/ia64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc3.orig/arch/ia64/kernel/kprobes.c	2005-10-05 16:08:14.000000000 -0400
> +++ linux-2.6.14-rc3/arch/ia64/kernel/kprobes.c	2005-10-05 16:08:48.000000000 -0400
> @@ -26,7 +26,6 @@
>  #include <linux/config.h>
>  #include <linux/kprobes.h>
>  #include <linux/ptrace.h>
> -#include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/preempt.h>
> @@ -343,10 +342,11 @@ int __kprobes trampoline_probe_handler(s
>  	struct kretprobe_instance *ri = NULL;
>  	struct hlist_head *head;
>  	struct hlist_node *node, *tmp;
> -	unsigned long orig_ret_address = 0;
> +	unsigned long flags, orig_ret_address = 0;
>  	unsigned long trampoline_address =
>  		((struct fnptr *)kretprobe_trampoline)->ip;
>  
> +	spin_lock_irqsave(&kretprobe_lock, flags);
>          head = kretprobe_inst_table_head(current);
>  
>  	/*
> @@ -386,7 +386,7 @@ int __kprobes trampoline_probe_handler(s
>  	regs->cr_iip = orig_ret_address;
>  
>  	reset_current_kprobe();
> -	unlock_kprobes();
> +	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  	preempt_enable_no_resched();
>  
>          /*
> @@ -397,6 +397,7 @@ int __kprobes trampoline_probe_handler(s
>          return 1;
>  }
>  
> +/* Called with kretprobe_lock held */
>  void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
>  				      struct pt_regs *regs)
>  {
> @@ -612,7 +613,6 @@ static int __kprobes pre_kprobes_handler
>  			if ((kcb->kprobe_status == KPROBE_HIT_SS) &&
>  	 		     (p->ainsn.inst_flag == INST_FLAG_BREAK_INST)) {
>    				ia64_psr(regs)->ss = 0;
> -				unlock_kprobes();
>  				goto no_kprobe;
>  			}
>  			/* We have reentered the pre_kprobe_handler(), since
> @@ -641,10 +641,8 @@ static int __kprobes pre_kprobes_handler
>  		}
>  	}
>  
> -	lock_kprobes();
>  	p = get_kprobe(addr);
>  	if (!p) {
> -		unlock_kprobes();
>  		if (!is_ia64_break_inst(regs)) {
>  			/*
>  			 * The breakpoint instruction was removed right
> @@ -707,7 +705,6 @@ static int __kprobes post_kprobes_handle
>  		goto out;
>  	}
>  	reset_current_kprobe();
> -	unlock_kprobes();
>  
>  out:
>  	preempt_enable_no_resched();
> @@ -728,7 +725,6 @@ static int __kprobes kprobes_fault_handl
>  	if (kcb->kprobe_status & KPROBE_HIT_SS) {
>  		resume_execution(cur, regs);
>  		reset_current_kprobe();
> -		unlock_kprobes();
>  		preempt_enable_no_resched();
>  	}
>  
> @@ -741,7 +737,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	preempt_disable();
> +	rcu_read_lock();

Ditto here...

>  	switch(val) {
>  	case DIE_BREAK:
>  		if (pre_kprobes_handler(args))
> @@ -757,7 +753,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	default:
>  		break;
>  	}
> -	preempt_enable();
> +	rcu_read_unlock();
>  	return ret;
>  }
>  
> Index: linux-2.6.14-rc3/arch/ppc64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc3.orig/arch/ppc64/kernel/kprobes.c	2005-10-05 16:08:15.000000000 -0400
> +++ linux-2.6.14-rc3/arch/ppc64/kernel/kprobes.c	2005-10-05 16:08:48.000000000 -0400
> @@ -30,7 +30,6 @@
>  #include <linux/config.h>
>  #include <linux/kprobes.h>
>  #include <linux/ptrace.h>
> -#include <linux/spinlock.h>
>  #include <linux/preempt.h>
>  #include <asm/cacheflush.h>
>  #include <asm/kdebug.h>
> @@ -125,6 +124,7 @@ static inline void set_current_kprobe(st
>  	kcb->kprobe_saved_msr = regs->msr;
>  }
>  
> +/* Called with kretprobe_lock held */
>  void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
>  				      struct pt_regs *regs)
>  {
> @@ -152,8 +152,6 @@ static inline int kprobe_handler(struct 
>  
>  	/* Check we're not actually recursing */
>  	if (kprobe_running()) {
> -		/* We *are* holding lock here, so this is safe.
> -		   Disarm the probe we just hit, and ignore it. */
>  		p = get_kprobe(addr);
>  		if (p) {
>  			kprobe_opcode_t insn = *p->ainsn.insn;
> @@ -161,7 +159,6 @@ static inline int kprobe_handler(struct 
>  					is_trap(insn)) {
>  				regs->msr &= ~MSR_SE;
>  				regs->msr |= kcb->kprobe_saved_msr;
> -				unlock_kprobes();
>  				goto no_kprobe;
>  			}
>  			/* We have reentered the kprobe_handler(), since
> @@ -183,14 +180,11 @@ static inline int kprobe_handler(struct 
>  				goto ss_probe;
>  			}
>  		}
> -		/* If it's not ours, can't be delete race, (we hold lock). */
>  		goto no_kprobe;
>  	}
>  
> -	lock_kprobes();
>  	p = get_kprobe(addr);
>  	if (!p) {
> -		unlock_kprobes();
>  		if (*addr != BREAKPOINT_INSTRUCTION) {
>  			/*
>  			 * PowerPC has multiple variants of the "trap"
> @@ -254,9 +248,10 @@ int __kprobes trampoline_probe_handler(s
>          struct kretprobe_instance *ri = NULL;
>          struct hlist_head *head;
>          struct hlist_node *node, *tmp;
> -	unsigned long orig_ret_address = 0;
> +	unsigned long flags, orig_ret_address = 0;
>  	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
>  
> +	spin_lock_irqsave(&kretprobe_lock, flags);
>          head = kretprobe_inst_table_head(current);
>  
>  	/*
> @@ -296,7 +291,7 @@ int __kprobes trampoline_probe_handler(s
>  	regs->nip = orig_ret_address;
>  
>  	reset_current_kprobe();
> -	unlock_kprobes();
> +	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  	preempt_enable_no_resched();
>  
>          /*
> @@ -348,7 +343,6 @@ static inline int post_kprobe_handler(st
>  		goto out;
>  	}
>  	reset_current_kprobe();
> -	unlock_kprobes();
>  out:
>  	preempt_enable_no_resched();
>  
> @@ -363,7 +357,6 @@ out:
>  	return 1;
>  }
>  
> -/* Interrupts disabled, kprobe_lock held. */
>  static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  {
>  	struct kprobe *cur = kprobe_running();
> @@ -378,7 +371,6 @@ static inline int kprobe_fault_handler(s
>  		regs->msr |= kcb->kprobe_saved_msr;
>  
>  		reset_current_kprobe();
> -		unlock_kprobes();
>  		preempt_enable_no_resched();
>  	}
>  	return 0;
> @@ -393,11 +385,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	/*
> -	 * Interrupts are not disabled here.  We need to disable
> -	 * preemption, because kprobe_running() uses smp_processor_id().
> -	 */
> -	preempt_disable();
> +	rcu_read_lock();

And here...

>  	switch (val) {
>  	case DIE_BPT:
>  		if (kprobe_handler(args->regs))
> @@ -416,7 +404,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	default:
>  		break;
>  	}
> -	preempt_enable_no_resched();
> +	rcu_read_unlock();
>  	return ret;
>  }
>  
> Index: linux-2.6.14-rc3/arch/sparc64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc3.orig/arch/sparc64/kernel/kprobes.c	2005-10-05 16:08:15.000000000 -0400
> +++ linux-2.6.14-rc3/arch/sparc64/kernel/kprobes.c	2005-10-05 16:08:48.000000000 -0400
> @@ -116,15 +116,11 @@ static int __kprobes kprobe_handler(stru
>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>  
>  	if (kprobe_running()) {
> -		/* We *are* holding lock here, so this is safe.
> -		 * Disarm the probe we just hit, and ignore it.
> -		 */
>  		p = get_kprobe(addr);
>  		if (p) {
>  			if (kcb->kprobe_status == KPROBE_HIT_SS) {
>  				regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
>  					kcb->kprobe_orig_tstate_pil);
> -				unlock_kprobes();
>  				goto no_kprobe;
>  			}
>  			/* We have reentered the kprobe_handler(), since
> @@ -144,14 +140,11 @@ static int __kprobes kprobe_handler(stru
>  			if (p->break_handler && p->break_handler(p, regs))
>  				goto ss_probe;
>  		}
> -		/* If it's not ours, can't be delete race, (we hold lock). */
>  		goto no_kprobe;
>  	}
>  
> -	lock_kprobes();
>  	p = get_kprobe(addr);
>  	if (!p) {
> -		unlock_kprobes();
>  		if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
>  			/*
>  			 * The breakpoint instruction was removed right
> @@ -296,14 +289,12 @@ static inline int post_kprobe_handler(st
>  		goto out;
>  	}
>  	reset_current_kprobe();
> -	unlock_kprobes();
>  out:
>  	preempt_enable_no_resched();
>  
>  	return 1;
>  }
>  
> -/* Interrupts disabled, kprobe_lock held. */
>  static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  {
>  	struct kprobe *cur = kprobe_running();
> @@ -316,7 +307,6 @@ static inline int kprobe_fault_handler(s
>  		resume_execution(cur, regs, kcb);
>  
>  		reset_current_kprobe();
> -		unlock_kprobes();
>  		preempt_enable_no_resched();
>  	}
>  	return 0;
> @@ -331,7 +321,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	preempt_disable();
> +	rcu_read_lock();

As well as here...

>  	switch (val) {
>  	case DIE_DEBUG:
>  		if (kprobe_handler(args->regs))
> @@ -350,7 +340,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	default:
>  		break;
>  	}
> -	preempt_enable();
> +	rcu_read_unlock();
>  	return ret;
>  }
>  
> Index: linux-2.6.14-rc3/arch/x86_64/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.14-rc3.orig/arch/x86_64/kernel/kprobes.c	2005-10-05 16:08:33.000000000 -0400
> +++ linux-2.6.14-rc3/arch/x86_64/kernel/kprobes.c	2005-10-05 16:08:48.000000000 -0400
> @@ -34,7 +34,6 @@
>  #include <linux/config.h>
>  #include <linux/kprobes.h>
>  #include <linux/ptrace.h>
> -#include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/preempt.h>
> @@ -266,6 +265,7 @@ static void __kprobes prepare_singlestep
>  		regs->rip = (unsigned long)p->ainsn.insn;
>  }
>  
> +/* Called with kretprobe_lock held */
>  void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
>  				      struct pt_regs *regs)
>  {
> @@ -299,15 +299,12 @@ int __kprobes kprobe_handler(struct pt_r
>  
>  	/* Check we're not actually recursing */
>  	if (kprobe_running()) {
> -		/* We *are* holding lock here, so this is safe.
> -		   Disarm the probe we just hit, and ignore it. */
>  		p = get_kprobe(addr);
>  		if (p) {
>  			if (kcb->kprobe_status == KPROBE_HIT_SS &&
>  				*p->ainsn.insn == BREAKPOINT_INSTRUCTION) {
>  				regs->eflags &= ~TF_MASK;
>  				regs->eflags |= kcb->kprobe_saved_rflags;
> -				unlock_kprobes();
>  				goto no_kprobe;
>  			} else if (kcb->kprobe_status == KPROBE_HIT_SSDONE) {
>  				/* TODO: Provide re-entrancy from
> @@ -340,14 +337,11 @@ int __kprobes kprobe_handler(struct pt_r
>  				goto ss_probe;
>  			}
>  		}
> -		/* If it's not ours, can't be delete race, (we hold lock). */
>  		goto no_kprobe;
>  	}
>  
> -	lock_kprobes();
>  	p = get_kprobe(addr);
>  	if (!p) {
> -		unlock_kprobes();
>  		if (*addr != BREAKPOINT_INSTRUCTION) {
>  			/*
>  			 * The breakpoint instruction was removed right
> @@ -406,9 +400,10 @@ int __kprobes trampoline_probe_handler(s
>          struct kretprobe_instance *ri = NULL;
>          struct hlist_head *head;
>          struct hlist_node *node, *tmp;
> -	unsigned long orig_ret_address = 0;
> +	unsigned long flags, orig_ret_address = 0;
>  	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
>  
> +	spin_lock_irqsave(&kretprobe_lock, flags);
>          head = kretprobe_inst_table_head(current);
>  
>  	/*
> @@ -448,7 +443,7 @@ int __kprobes trampoline_probe_handler(s
>  	regs->rip = orig_ret_address;
>  
>  	reset_current_kprobe();
> -	unlock_kprobes();
> +	spin_unlock_irqrestore(&kretprobe_lock, flags);
>  	preempt_enable_no_resched();
>  
>          /*
> @@ -536,10 +531,6 @@ static void __kprobes resume_execution(s
>  	}
>  }
>  
> -/*
> - * Interrupts are disabled on entry as trap1 is an interrupt gate and they
> - * remain disabled thoroughout this function.  And we hold kprobe lock.
> - */
>  int __kprobes post_kprobe_handler(struct pt_regs *regs)
>  {
>  	struct kprobe *cur = kprobe_running();
> @@ -560,8 +551,6 @@ int __kprobes post_kprobe_handler(struct
>  	if (kcb->kprobe_status == KPROBE_REENTER) {
>  		restore_previous_kprobe(kcb);
>  		goto out;
> -	} else {
> -		unlock_kprobes();
>  	}
>  	reset_current_kprobe();
>  out:
> @@ -578,7 +567,6 @@ out:
>  	return 1;
>  }
>  
> -/* Interrupts disabled, kprobe_lock held. */
>  int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  {
>  	struct kprobe *cur = kprobe_running();
> @@ -592,7 +580,6 @@ int __kprobes kprobe_fault_handler(struc
>  		regs->eflags |= kcb->kprobe_old_rflags;
>  
>  		reset_current_kprobe();
> -		unlock_kprobes();
>  		preempt_enable_no_resched();
>  	}
>  	return 0;
> @@ -607,7 +594,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
>  
> -	preempt_disable();
> +	rcu_read_lock();

As well as here yet again...

>  	switch (val) {
>  	case DIE_INT3:
>  		if (kprobe_handler(args->regs))
> @@ -626,7 +613,7 @@ int __kprobes kprobe_exceptions_notify(s
>  	default:
>  		break;
>  	}
> -	preempt_enable();
> +	rcu_read_unlock();
>  	return ret;
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
