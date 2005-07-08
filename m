Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVGHOOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVGHOOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVGHOOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:14:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:39311 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262670AbVGHOOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:14:17 -0400
Date: Fri, 8 Jul 2005 10:13:28 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, systemtap@sources.redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [4/6 PATCH] Kprobes : Prevent possible race conditions ppc64 changes
Message-ID: <20050708141328.GA5724@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20050707101015.GE12106@in.ibm.com> <20050707101119.GF12106@in.ibm.com> <20050707101447.GG12106@in.ibm.com> <20050707101650.GH12106@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707101650.GH12106@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 03:46:50PM +0530, Prasanna S Panchamukhi wrote:
> 
> This patch contains the ppc64 architecture specific changes to
> prevent the possible race conditions.

Prasanna,

Please cc or post this patch to linuxppc64-dev@ozlabs.org. This patch
touches files I am not sure I can comment on with authority.

Thanks,
Ananth

> 
> Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
> 
> 
> ---
> 
>  linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/kprobes.c     |   29 +++++-----
>  linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/misc.S        |    4 -
>  linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/traps.c       |    5 +
>  linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/vmlinux.lds.S |    1 
>  linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/mm/fault.c           |    5 +
>  linux-2.6.13-rc1-mm1-prasanna/include/asm-ppc64/processor.h   |   14 ++++
>  6 files changed, 38 insertions(+), 20 deletions(-)
> 
> diff -puN arch/ppc64/kernel/kprobes.c~kprobes-exclude-functions-ppc64 arch/ppc64/kernel/kprobes.c
> --- linux-2.6.13-rc1-mm1/arch/ppc64/kernel/kprobes.c~kprobes-exclude-functions-ppc64	2005-07-06 20:07:22.000000000 +0530
> +++ linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/kprobes.c	2005-07-06 20:07:22.000000000 +0530
> @@ -44,7 +44,7 @@ static struct kprobe *kprobe_prev;
>  static unsigned long kprobe_status_prev, kprobe_saved_msr_prev;
>  static struct pt_regs jprobe_saved_regs;
>  
> -int arch_prepare_kprobe(struct kprobe *p)
> +int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	int ret = 0;
>  	kprobe_opcode_t insn = *p->addr;
> @@ -68,27 +68,27 @@ int arch_prepare_kprobe(struct kprobe *p
>  	return ret;
>  }
>  
> -void arch_copy_kprobe(struct kprobe *p)
> +void __kprobes arch_copy_kprobe(struct kprobe *p)
>  {
>  	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
>  	p->opcode = *p->addr;
>  }
>  
> -void arch_arm_kprobe(struct kprobe *p)
> +void __kprobes arch_arm_kprobe(struct kprobe *p)
>  {
>  	*p->addr = BREAKPOINT_INSTRUCTION;
>  	flush_icache_range((unsigned long) p->addr,
>  			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>  }
>  
> -void arch_disarm_kprobe(struct kprobe *p)
> +void __kprobes arch_disarm_kprobe(struct kprobe *p)
>  {
>  	*p->addr = p->opcode;
>  	flush_icache_range((unsigned long) p->addr,
>  			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>  }
>  
> -void arch_remove_kprobe(struct kprobe *p)
> +void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
>  	up(&kprobe_mutex);
>  	free_insn_slot(p->ainsn.insn);
> @@ -122,7 +122,8 @@ static inline void restore_previous_kpro
>  	kprobe_saved_msr = kprobe_saved_msr_prev;
>  }
>  
> -void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
> +void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
> +				      struct pt_regs *regs)
>  {
>  	struct kretprobe_instance *ri;
>  
> @@ -244,7 +245,7 @@ void kretprobe_trampoline_holder(void)
>  /*
>   * Called when the probe at kretprobe trampoline is hit
>   */
> -int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
> +int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
>  {
>          struct kretprobe_instance *ri = NULL;
>          struct hlist_head *head;
> @@ -308,7 +309,7 @@ int trampoline_probe_handler(struct kpro
>   * single-stepped a copy of the instruction.  The address of this
>   * copy is p->ainsn.insn.
>   */
> -static void resume_execution(struct kprobe *p, struct pt_regs *regs)
> +static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
>  {
>  	int ret;
>  	unsigned int insn = *p->ainsn.insn;
> @@ -373,8 +374,8 @@ static inline int kprobe_fault_handler(s
>  /*
>   * Wrapper routine to for handling exceptions.
>   */
> -int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
> -			     void *data)
> +int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> +				       unsigned long val, void *data)
>  {
>  	struct die_args *args = (struct die_args *)data;
>  	int ret = NOTIFY_DONE;
> @@ -406,7 +407,7 @@ int kprobe_exceptions_notify(struct noti
>  	return ret;
>  }
>  
> -int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
> +int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct jprobe *jp = container_of(p, struct jprobe, kp);
>  
> @@ -419,16 +420,16 @@ int setjmp_pre_handler(struct kprobe *p,
>  	return 1;
>  }
>  
> -void jprobe_return(void)
> +void __kprobes jprobe_return(void)
>  {
>  	asm volatile("trap" ::: "memory");
>  }
>  
> -void jprobe_return_end(void)
> +void __kprobes jprobe_return_end(void)
>  {
>  };
>  
> -int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
> +int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  {
>  	/*
>  	 * FIXME - we should ideally be validating that we got here 'cos
> diff -puN arch/ppc64/kernel/traps.c~kprobes-exclude-functions-ppc64 arch/ppc64/kernel/traps.c
> --- linux-2.6.13-rc1-mm1/arch/ppc64/kernel/traps.c~kprobes-exclude-functions-ppc64	2005-07-06 20:07:22.000000000 +0530
> +++ linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/traps.c	2005-07-06 20:07:22.000000000 +0530
> @@ -30,6 +30,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/kprobes.h>
>  #include <asm/kdebug.h>
>  
>  #include <asm/pgtable.h>
> @@ -220,7 +221,7 @@ void instruction_breakpoint_exception(st
>  	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
>  }
>  
> -void single_step_exception(struct pt_regs *regs)
> +void __kprobes single_step_exception(struct pt_regs *regs)
>  {
>  	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
>  
> @@ -398,7 +399,7 @@ check_bug_trap(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -void program_check_exception(struct pt_regs *regs)
> +void __kprobes program_check_exception(struct pt_regs *regs)
>  {
>  	if (debugger_fault_handler(regs))
>  		return;
> diff -puN arch/ppc64/kernel/vmlinux.lds.S~kprobes-exclude-functions-ppc64 arch/ppc64/kernel/vmlinux.lds.S
> --- linux-2.6.13-rc1-mm1/arch/ppc64/kernel/vmlinux.lds.S~kprobes-exclude-functions-ppc64	2005-07-06 20:07:22.000000000 +0530
> +++ linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/vmlinux.lds.S	2005-07-06 20:07:22.000000000 +0530
> @@ -15,6 +15,7 @@ SECTIONS
>  	*(.text .text.*)
>  	SCHED_TEXT
>  	LOCK_TEXT
> +	KPROBES_TEXT
>  	*(.fixup)
>  	. = ALIGN(4096);
>  	_etext = .;
> diff -puN arch/ppc64/mm/fault.c~kprobes-exclude-functions-ppc64 arch/ppc64/mm/fault.c
> --- linux-2.6.13-rc1-mm1/arch/ppc64/mm/fault.c~kprobes-exclude-functions-ppc64	2005-07-06 20:07:22.000000000 +0530
> +++ linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/mm/fault.c	2005-07-06 20:07:22.000000000 +0530
> @@ -29,6 +29,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/smp_lock.h>
>  #include <linux/module.h>
> +#include <linux/kprobes.h>
>  
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
> @@ -84,8 +85,8 @@ static int store_updates_sp(struct pt_re
>   * The return value is 0 if the fault was handled, or the signal
>   * number if this is a kernel fault that can't be handled here.
>   */
> -int do_page_fault(struct pt_regs *regs, unsigned long address,
> -		  unsigned long error_code)
> +int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
> +			    unsigned long error_code)
>  {
>  	struct vm_area_struct * vma;
>  	struct mm_struct *mm = current->mm;
> diff -puN arch/ppc64/kernel/misc.S~kprobes-exclude-functions-ppc64 arch/ppc64/kernel/misc.S
> --- linux-2.6.13-rc1-mm1/arch/ppc64/kernel/misc.S~kprobes-exclude-functions-ppc64	2005-07-06 20:07:22.000000000 +0530
> +++ linux-2.6.13-rc1-mm1-prasanna/arch/ppc64/kernel/misc.S	2005-07-07 10:24:00.000000000 +0530
> @@ -183,7 +183,7 @@ PPC64_CACHES:
>   *   flush all bytes from start through stop-1 inclusive
>   */
>  
> -_GLOBAL(__flush_icache_range)
> +_KPROBE(__flush_icache_range)
>  
>  /*
>   * Flush the data cache to memory 
> @@ -223,7 +223,7 @@ _GLOBAL(__flush_icache_range)
>  	bdnz	2b
>  	isync
>  	blr
> -	
> +	.previous .text
>  /*
>   * Like above, but only do the D-cache.
>   *
> diff -puN include/asm-ppc64/processor.h~kprobes-exclude-functions-ppc64 include/asm-ppc64/processor.h
> --- linux-2.6.13-rc1-mm1/include/asm-ppc64/processor.h~kprobes-exclude-functions-ppc64	2005-07-06 20:07:22.000000000 +0530
> +++ linux-2.6.13-rc1-mm1-prasanna/include/asm-ppc64/processor.h	2005-07-07 10:22:29.000000000 +0530
> @@ -309,6 +309,20 @@ name: \
>  	.type GLUE(.,name),@function; \
>  GLUE(.,name):
>  
> +#define _KPROBE(name) \
> +	.section ".kprobes.text","a"; \
> +	.align 2 ; \
> +	.globl name; \
> +	.globl GLUE(.,name); \
> +	.section ".opd","aw"; \
> +name: \
> +	.quad GLUE(.,name); \
> +	.quad .TOC.@tocbase; \
> +	.quad 0; \
> +	.previous; \
> +	.type GLUE(.,name),@function; \
> +GLUE(.,name):
> +
>  #define _STATIC(name) \
>  	.section ".text"; \
>  	.align 2 ; \
> 
> _
> -- 
> 
> Prasanna S Panchamukhi
> Linux Technology Center
> India Software Labs, IBM Bangalore
> Ph: 91-80-25044636
> <prasanna@in.ibm.com>
