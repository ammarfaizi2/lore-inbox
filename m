Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267627AbUHEKz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267627AbUHEKz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267629AbUHEKz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:55:29 -0400
Received: from zero.aec.at ([193.170.194.10]:16388 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267627AbUHEKzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:55:23 -0400
To: prasanna@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [0/3]kprobes-base-268-rc3.patch
References: <2pMzT-XA-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 05 Aug 2004 12:55:17 +0200
In-Reply-To: <2pMzT-XA-21@gated-at.bofh.it> (Prasanna S. Panchamukhi's
 message of "Thu, 05 Aug 2004 11:20:09 +0200")
Message-ID: <m3hdrhyhuy.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:

Hallo,

Overall it looks good, but some issues noted below. 

> @@ -437,6 +437,9 @@ asmlinkage void do_general_protection(st
>  	if (regs->eflags & VM_MASK)
>  		goto gp_in_vm86;
>  
> +	if (kprobe_running() && kprobe_fault_handler(regs, 13))
> +		return;

Please port the notifier lists from x86-64 first to give a clean
interface (see include/asm-x86_64/kdebug.h and the trap handlers there). 
Otherwise this  will always conflict with everybody who wants to 
add exception handlers too.


> +
>  	if (!(regs->xcs & 3))
>  		goto gp_in_kernel;
>  
> @@ -557,6 +560,17 @@ void unset_nmi_callback(void)
>  	nmi_callback = dummy_nmi_callback;
>  }
>  
> +asmlinkage int do_int3(struct pt_regs *regs, long error_code)
> +{
> +	if (kprobe_handler(regs))
> +		return 1;

Same.

> +	/* This is an interrupt gate, because kprobes wants interrupts
> +           disabled.  Normal trap handlers don't. */
> +	restore_interrupts(regs);
> +	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
> +	return 0;
> +}
> +
>  /*
>   * Our handling of the processor debug registers is non-trivial.
>   * We do not clear them on entry and exit from the kernel. Therefore
> @@ -579,12 +593,15 @@ void unset_nmi_callback(void)
>   * find every occurrence of the TF bit that could be saved away even
>   * by user code)
>   */
> -asmlinkage void do_debug(struct pt_regs * regs, long error_code)
> +asmlinkage int do_debug(struct pt_regs * regs, long error_code)
>  {
>  	unsigned int condition;
>  	struct task_struct *tsk = current;
>  	siginfo_t info;
>  
> +	if (post_kprobe_handler(regs))
> +		return 1;
> +

Also notifier list.

>  clear_TF_reenable:
>  	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
>  clear_TF:
>  	regs->eflags &= ~TF_MASK;
> -	return;
> +	return 0;
>  }
>  
>  /*
> @@ -817,6 +834,8 @@ asmlinkage void math_state_restore(struc
>  	struct thread_info *thread = current_thread_info();
>  	struct task_struct *tsk = thread->task;
>  
> +	if (kprobe_running() && kprobe_fault_handler(&regs, 7))
> +		return;

Same.


>  	clts();		/* Allow maths ops (or we recurse) */
>  	if (!tsk->used_math)
>  		init_fpu(tsk);
> @@ -911,7 +930,7 @@ void __init trap_init(void)
>  	set_trap_gate(0,&divide_error);
>  	set_intr_gate(1,&debug);
>  	set_intr_gate(2,&nmi);
> -	set_system_gate(3,&int3);	/* int3-5 can be called from all */
> +	_set_gate(idt_table+3,14,3,&int3,__KERNEL_CS); /* int3-5 can be called from all */

Please define a macro for this (set_system_intr_gate) 


> +#include <linux/kprobes.h>
>  
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> @@ -226,6 +227,9 @@ asmlinkage void do_page_fault(struct pt_
>  	/* get the address */
>  	__asm__("movl %%cr2,%0":"=r" (address));
>  
> +	if (kprobe_running() && kprobe_fault_handler(regs, 14))
> +		return;

Also notifier here. 

> +/* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
> + * if necessary, before executing the original int3/1 (trap) handler.
> + */
> +static inline void restore_interrupts(struct pt_regs *regs)
> +{
> +	if (regs->eflags & IF_MASK)
> +		__asm__ __volatile__ ("sti");

That's local_irq_enable()

> +
> +/* You have to be holding the kprobe_lock */
> +struct kprobe *get_kprobe(void *addr)
> +{
> +	struct list_head *head, *tmp;

A hlist would be probably better for the hash table (saves some space) 

> +
> +int register_kprobe(struct kprobe *p)
> +{
> +	int ret = 0;
> +
> +	spin_lock_irq(&kprobe_lock);

Better use _irqsave here. Safer interface for users.


> +
> +void unregister_kprobe(struct kprobe *p)
> +{
> +	spin_lock_irq(&kprobe_lock);

Better make this an _irqsave() 

> +	*p->addr = p->opcode;
> +	list_del(&p->list);
> +	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));

This flush will probably need good review by other architecture
maintainers. it's ok right now since it is 386 only.
My suspection is that it is will not be enough for some people


-Andi

