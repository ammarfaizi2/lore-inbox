Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbWIVWkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbWIVWkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWIVWkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:40:01 -0400
Received: from gw.goop.org ([64.81.55.164]:29313 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965244AbWIVWkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:40:00 -0400
Message-ID: <4514663E.5050707@goop.org>
Date: Fri, 22 Sep 2006 15:39:58 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
References: <1158925861.26261.3.camel@localhost.localdomain>	 <1158925997.26261.6.camel@localhost.localdomain>	 <1158926106.26261.8.camel@localhost.localdomain>	 <1158926215.26261.11.camel@localhost.localdomain>	 <1158926308.26261.14.camel@localhost.localdomain> <1158926386.26261.17.camel@localhost.localdomain>
In-Reply-To: <1158926386.26261.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> This patch actually uses the gs register to implement the per-cpu
> sections.  It's fairly straightforward: the gs segment starts at the
> per-cpu offset for the particular cpu (or 0, in very early boot).  
>
> We also implement x86_64-inspired (via Jeremy Fitzhardinge) per-cpu
> accesses where a general lvalue isn't needed.  These
> single-instruction accesses are slightly more efficient, plus (being a
> single insn) are atomic wrt. preemption so we can use them to
> implement cpu_local_inc etc.
>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> Index: ak-fresh/arch/i386/kernel/cpu/common.c
> ===================================================================
> --- ak-fresh.orig/arch/i386/kernel/cpu/common.c	2006-09-22 16:48:14.000000000 +1000
> +++ ak-fresh/arch/i386/kernel/cpu/common.c	2006-09-22 17:02:47.000000000 +1000
> @@ -13,6 +13,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/mtrr.h>
>  #include <asm/mce.h>
> +#include <asm/smp.h>
>  #ifdef CONFIG_X86_LOCAL_APIC
>  #include <asm/mpspec.h>
>  #include <asm/apic.h>
> @@ -601,12 +602,24 @@
>  	struct thread_struct *thread = &current->thread;
>  	struct desc_struct *gdt;
>  	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
> -	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
>  
>  	if (cpu_test_and_set(cpu, cpu_initialized)) {
>  		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
>  		for (;;) local_irq_enable();
>  	}
> +
> +	/* Set up GDT entry for 16bit stack */
> +	stk16_off = (u32)&per_cpu(cpu_16bit_stack, cpu);
> +	gdt = per_cpu(cpu_gdt_table, cpu);
> +	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
> +		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
> +		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
> +		(CPU_16BIT_STACK_SIZE - 1);
>   

This should use pack_descriptor().  I'd never got around to changing it, 
but it really should.

> +	/* Complete percpu area setup early, before calling printk(),
> +	   since it may end up using it indirectly. */
> +	setup_percpu_for_this_cpu(cpu);
> +
>   

I managed to get all this done in head.S before going into C code; is 
that not still possible?  Or is there a later patch to do this.

> +static __cpuinit void setup_percpu_descriptor(struct desc_struct *gdt,
> +					      unsigned long per_cpu_off)
> +{
> +	unsigned limit, flags;
> +
> +	limit = (1 << 20);
> +	flags = 0x8;		/* 4k granularity */
>   

Why not set the limit to the percpu section size?  It would avoid having 
it clipped under Xen.


> +/* Be careful not to use %gs references until this is setup: needs to
> + * be done on this CPU. */
> +void __init setup_percpu_for_this_cpu(unsigned int cpu)
> +{
> +	struct desc_struct *gdt = per_cpu(cpu_gdt_table, cpu);
> +	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
> +
> +	per_cpu(this_cpu_off, cpu) = __per_cpu_offset[cpu];
> +	setup_percpu_descriptor(&gdt[GDT_ENTRY_PERCPU],	__per_cpu_offset[cpu]);
> +	cpu_gdt_descr->address = (unsigned long)gdt;
> +	cpu_gdt_descr->size = GDT_SIZE - 1;
> +	load_gdt(cpu_gdt_descr);
> +	set_kernel_gs();
> +}
>   

Everything except the load_gdt and set_kernel_gs could be done in advance.

> +
>  void __devinit smp_prepare_boot_cpu(void)
>  {
> +	setup_percpu_for_this_cpu(0);
> +
>  	cpu_set(smp_processor_id(), cpu_online_map);
>  	cpu_set(smp_processor_id(), cpu_callout_map);
>  	cpu_set(smp_processor_id(), cpu_present_map);
> Index: ak-fresh/include/asm-i386/percpu.h
> ===================================================================
> --- ak-fresh.orig/include/asm-i386/percpu.h	2006-09-22 16:48:14.000000000 +1000
> +++ ak-fresh/include/asm-i386/percpu.h	2006-09-22 16:59:00.000000000 +1000
> @@ -1,6 +1,107 @@
>  #ifndef __ARCH_I386_PERCPU__
>  #define __ARCH_I386_PERCPU__
>  
> +#ifdef CONFIG_SMP
> +/* Same as generic implementation except for optimized local access. */
> +#define __GENERIC_PER_CPU
> +
> +/* This is used for other cpus to find our section. */
> +extern unsigned long __per_cpu_offset[NR_CPUS];
> +
> +/* Separate out the type, so (int[3], foo) works. */
> +#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
> +#define DEFINE_PER_CPU(type, name) \
> +    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
> +
> +/* We can use this directly for local CPU (faster). */
> +DECLARE_PER_CPU(unsigned long, this_cpu_off);
> +
> +/* var is in discarded region: offset to particular copy we want */
> +#define per_cpu(var, cpu) (*({				\
> +	extern int simple_indentifier_##var(void);	\
> +	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))
> +
> +#define __raw_get_cpu_var(var) (*({					\
> +	extern int simple_indentifier_##var(void);			\
> +	RELOC_HIDE(&per_cpu__##var, x86_read_percpu(this_cpu_off));	\
> +}))
> +
> +#define __get_cpu_var(var) __raw_get_cpu_var(var)
> +
> +/* A macro to avoid #include hell... */
> +#define percpu_modcopy(pcpudst, src, size)			\
> +do {								\
> +	unsigned int __i;					\
> +	for_each_possible_cpu(__i)				\
> +		memcpy((pcpudst)+__per_cpu_offset[__i],		\
> +		       (src), (size));				\
> +} while (0)
> +
> +#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
> +#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
> +
> +/* gs segment starts at (positive) offset == __per_cpu_offset[cpu] */
> +#define __percpu_seg "%%gs:"
> +#else  /* !SMP */
>  #include <asm-generic/percpu.h>
> +#define __percpu_seg ""
> +#endif	/* SMP */
> +
> +/* For arch-specific code, we can use direct single-insn ops (they
> + * don't give an lvalue though). */
> +extern void __bad_percpu_size(void);
> +
> +#define percpu_to_op(op,var,val)				\
> +	do {							\
> +		typedef typeof(var) T__;			\
> +		if (0) { T__ tmp__; tmp__ = (val); }		\
> +		switch (sizeof(var)) {				\
> +		case 1:						\
> +			asm(op "b %1,"__percpu_seg"%0"		\
>   

So are symbols referencing the .data.percpu section 0-based?  Wouldn't 
you need to subtract __per_cpu_start from the symbols to get a 0-based 
segment offset?

Or is the only percpu benefit you're getting from %gs is a slightly 
quicker way of getting the percpu_offset?  Does that help much?
> +#define x86_read_percpu(var) percpu_from_op("mov", per_cpu__##var)
> +#define x86_write_percpu(var,val) percpu_to_op("mov", per_cpu__##var, val)
> +#define x86_add_percpu(var,val) percpu_to_op("add", per_cpu__##var, val)
> +#define x86_sub_percpu(var,val) percpu_to_op("sub", per_cpu__##var, val)
> +#define x86_or_percpu(var,val) percpu_to_op("or", per_cpu__##var, val)
>   

Why x86_?  If some other arch implemented a similar mechanism, wouldn't 
they want to use the same macro names?

    J
