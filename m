Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUIVUCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUIVUCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUIVUCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:02:39 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:14976 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S266687AbUIVUCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:02:30 -0400
Date: Wed, 22 Sep 2004 22:02:28 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040922200228.GB11017@vana.vc.cvut.cz>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4151C949.1080807@aknet.ru>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 10:49:45PM +0400, Stas Sergeev wrote:
> Hi Petr et al.
> 
> I coded up something that remotely looks like the
> discussed patch.
> I have deviated from your proposals at some important
> points:
> 1. I am not allocating the ring1 stack separately,
> I am allocating it on a ring0 stack. Much simpler
> code, although non-reentrant/preempt-unsafe.

I think that it is problem.  And do not forget that NMI can occur at any
place, so I'm not quite sure how your code works.

> 2. I am disabling the interrupts after all. That's
> because of the preempt-unsafeness. I pass up the
> IOPL=1 when necessary, to avoid problems.
> But I guess also with your technique the interrupts
> had to be disabled, unless the ring1 stack is
> per-thread.

What if exception occurs in CPL1 code?  Processor reloads SS/ESP from
TSS, pointing at top of CPL0 stack - where it overwrites CPL1 stack -
- and it pushes on top of CPL0 stack address of CPL1 - and real return
address for CPL3 was lost :-(  Boom.

You change base address for SS segment - in that case you need per-CPU
SS segment, it wont' work with global SS segment.

> 3. I am using LAR. Do you really think it can be
> slower than the whole thing of locating LDT?

Try measuring that.  I think that LAR will be faster than lookup in
memory, but...
> 
> Let me know if I did something stupid.
> The patch is attached.
> I tested (pretty much) everything in it, except
> probably the "popl %esp" restartability. But that
> one looks fairly simple and should work.

Did you tried setting SS/ESP on stack to invalid values, so IRET on CPL1
triggers fault?  You should be able to do that by modifying SS/ESP from
signal handler.

> +#define NMI_STACK_RESERVE 0x400
> +#define MAKE_ESPFIX \
> +	cli; \
> +	subl $NMI_STACK_RESERVE, %esp; \

This is ugly.  What if NMI handler uses more than 1KB?

> +	.rept 5; \
> +	pushl NMI_STACK_RESERVE+0x10(%esp); \
> +	.endr; \
> +	pushl %eax; \
> +	movl %esp, %eax; \
> +	pushl %ebp; \
> +	GET_THREAD_INFO(%ebp); \
> +	movl TI_cpu(%ebp), %ebp; \
> +	shll $GDT_SIZE_SHIFT, %ebp; \
> +	addl $cpu_gdt_table, %ebp; \
> +	movw %ax, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 2)(%ebp); \
> +	shrl $16, %eax; \
> +	movb %al, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 4)(%ebp); \
> +	movb %ah, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 7)(%ebp); \
> +	popl %ebp; \
> +	popl %eax; \
> +	pushw 14(%esp); \

What about referencing 14+NMI_STACK_RESERVE() ?  And ESP is not
multiple of 4 here - it may slow down processor a bit.

I think that you should prepare stack by using moves to
-NMI_STACK_RESERVE-xx(%esp) instead of adjusting stack and using pushes.
Or you can (if you want per-thread and not per-CPU stack) prepare CPL1
stack above CPL0 stack - this way you steal 24 bytes from CPL0 stack,
but CPL0 can use full 4KB (8KB), without NMI being limited by 1KB.

> +	pushw $4; \
> +	pushl $__ESPFIX_SS; \
> +	pushl $0; \
> +	pushl 20(%esp); \
> +	andl $~(IF_MASK | TF_MASK | RF_MASK | NT_MASK | AC_MASK), (%esp); \
> +	orl $IOPL1_MASK, (%esp); \

Does this work if userspace runs with iopl 3,2 or 1?  Does iret on CPL1
set iopl level properly (i.e. is iopl set if IOPL <= CPL, or only if CPL=0?).

> +	pushl $__ESPFIX_CS; \
> +	pushl $espfix_trampoline;
> +
>  #define SAVE_ALL \
>  	cld; \
>  	pushl %es; \
> @@ -122,9 +172,24 @@
>  .previous
>  
>  
> +/* If returning to Ring-3, not to V86, and with
> + * the small stack, try to fix the higher word of
> + * ESP, as the CPU won't restore it from stack.
> + * This is an "official" bug of all the x86-compatible
> + * CPUs, which we can try to work around to make
> + * dosemu happy. */
>  #define RESTORE_ALL	\
> -	RESTORE_REGS	\
> -	addl $4, %esp;	\
> +	movl EFLAGS(%esp), %eax; \
> +	movb CS(%esp), %al; \
> +	andl $(VM_MASK | 2), %eax; \
> +	cmpl $2, %eax; \
> +	jne 3f; \
> +	larl OLDSS(%esp), %eax; \
> +	testl $0x00400000, %eax; \
> +3:	RESTORE_REGS	\
> +	leal 4(%esp), %esp; \
> +	jnz 1f; \
> +	MAKE_ESPFIX \
>  1:	iret;		\
>  .section .fixup,"ax";   \

I'm not sure about lea speed.  And fast path should NOT jump,
forward jumps are initialy predicted as not taken... Maybe:

   3: RESTORE_REGS
      jz 8f
      add $4,%esp
   1: iret
   8: add $4,%esp
      MAKE_ESPFIX
      iret

And then you can move MAKE_ESPFIX out of macro.

And it seems to me that it adds too many operations to fast path.
Maybe you want to introduce some per-thread flag, or leave syscall path
to corrupt ESP (dosemu apps should not call Linux INT syscall, yes?).

> diff -urN linux-2.6.8-pcsp/arch/i386/kernel/process.c linux-2.6.8-stacks/arch/i386/kernel/process.c
> --- linux-2.6.8-pcsp/arch/i386/kernel/process.c	2004-06-21 09:19:07.000000000 +0400
> +++ linux-2.6.8-stacks/arch/i386/kernel/process.c	2004-09-21 10:45:55.000000000 +0400
> @@ -225,7 +225,7 @@
>  	printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, smp_processor_id());
>  	print_symbol("EIP is at %s\n", regs->eip);
>  
> -	if (regs->xcs & 3)
> +	if (regs->xcs & 2)
>  		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);

I think you should leave this as is, regs->xss/regs->esp should be valid
for CPL1 exceptions.

>  	printk(" EFLAGS: %08lx    %s  (%s)\n",regs->eflags, print_tainted(),UTS_RELEASE);
>  	printk("EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
> diff -urN linux-2.6.8-pcsp/arch/i386/kernel/signal.c linux-2.6.8-stacks/arch/i386/kernel/signal.c
> --- linux-2.6.8-pcsp/arch/i386/kernel/signal.c	2004-08-10 11:02:36.000000000 +0400
> +++ linux-2.6.8-stacks/arch/i386/kernel/signal.c	2004-09-21 10:48:38.000000000 +0400
> @@ -558,7 +558,7 @@
>  	 * kernel mode. Just return without doing anything
>  	 * if so.
>  	 */
> -	if ((regs->xcs & 3) != 3)
> +	if (!(regs->xcs & 2))
>  		return 1;

Really?  I think that it should stay.

> @@ -630,7 +630,7 @@
>  	/* If this is a kernel mode trap, save the user PC on entry to 
>  	 * the kernel, that's what the debugger can make sense of.
>  	 */
> -	info.si_addr = ((regs->xcs & 3) == 0) ? (void *)tsk->thread.eip : 
> +	info.si_addr = ((regs->xcs & 2) == 0) ? (void *)tsk->thread.eip : 
>  	                                        (void *)regs->eip;

Sure?  Maybe this should be (regs->xcs & 3 != 3) instead?

Rest looks fine, but I'm not completely sure that SMP and NMIs are
handled in the best possible way.
							Petr Vandrovec
