Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbUIWSJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbUIWSJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUIWSJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:09:48 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:12418 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S268213AbUIWSGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:06:12 -0400
Date: Thu, 23 Sep 2004 20:06:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040923180607.GA20678@vana.vc.cvut.cz>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41530326.2050900@aknet.ru>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 09:08:54PM +0400, Stas Sergeev wrote:
> Petr Vandrovec wrote:
> >>1. I am not allocating the ring1 stack separately,
> >>I am allocating it on a ring0 stack. Much simpler
> >>code, although non-reentrant/preempt-unsafe.
> >I think that it is problem.  And do not forget that NMI can occur at any
> >place, so I'm not quite sure how your code works.
> I assume this was a misunderstanding. Now I use
> "preempt_stop" instead of "cli" to make it more
> obvious what am I doing. So I assume that part is
> preempt-unsafe, but not NMI-unsafe.
> 
> >>+#define NMI_STACK_RESERVE 0x400
> >>+#define MAKE_ESPFIX \
> >>+	cli; \
> >>+	subl $NMI_STACK_RESERVE, %esp; \
> >This is ugly.  What if NMI handler uses more than 1KB?
> In that new patch I set the const to 0xe00, which
> is 3,5K. Is it still the limitation? I can probably
> raise it ever higher, but I am not sure if there is
> some sensible data below the stack that I may overwrite
> ocasionally?

For 4KB stacks 2KB looks better (if NMIs do not use
its own stacks).

> >Rest looks fine, but I'm not completely sure that SMP and NMIs are
> >handled in the best possible way.
> Well, even though my patch can be improved, I don't
> feel quite comfortable with its complexity.
> Now I really want to re-assure myself that this all
> is not possible to do on ring0, in which case this
> will simply be the trivial thing.
> Anonymous LKML reader (whom I have to thank for the
> hints) proposed 2 things:
> 1. Try lss followed by iret. In that case the interrupt
> will not kill us because after lss the interrupts are
> not accepted until the next insn is executed, AFAIK.
> But he was not sure, and I don't know either, if it is
> true even for NMI. So if it is - we could just do
> lss/iret, and the problem is solved. So is this true
> for NMI? Is this documented anywhere?

LSS is exempted from rule that interrupts cannot occur after
operation modifying SS, as with LSS you are supposed to
load SS together with ESP in one operation, and so you
do not need interrupt holdoff.  And when exception
occurs on iret, it will happen with 16bit stack, and
you are dead...

> 2. Set task gate for NMI. AFAICS, the task-gate is
> now used only for the doublefault exception, but not
> for NMI. If I understand the idea correctly, this
> will guarantee that the NMI will be executing on a
> separate stack, which may be a good idea in any case,
> and will allow us to use the small stack at ring-0,
> if only we disable the interrupts. Are there any
> chances to use the task-gate for NMI? I may even try to
> implement that myself, but I guess there are *reasons*
> why it is not yet? (of course this applies only if 1.
> fails)

Yes. But you still have to handle exceptions on iret
to userspace :-(

> Or maybe somehow to modify the NMI handler itself,
> so that it will check if it is on a "small" stack,
> and switch to the "big" stack before anything else?
> Well, doing the whole trick at ring-0 sounds really
> plausible to me...

If you can do that, great.  But you have to modify
at least NMI, GP and SS fault handlers to reload
SS/ESP with correct values.

> diff -urN linux-2.6.8-pcsp/arch/i386/kernel/entry.S linux-2.6.8-stacks/arch/i386/kernel/entry.S
> --- linux-2.6.8-pcsp/arch/i386/kernel/entry.S	2004-06-10 13:28:35.000000000 +0400
> +++ linux-2.6.8-stacks/arch/i386/kernel/entry.S	2004-09-23 16:14:55.209520160 +0400
> @@ -122,8 +129,23 @@
>  .previous
>  
>  
> +#define NMI_STACK_RESERVE 0xe00
> +/* If returning to Ring-3, not to V86, and with
> + * the small stack, try to fix the higher word of
> + * ESP, as the CPU won't restore it from stack.
> + * This is an "official" bug of all the x86-compatible
> + * CPUs, which we can try to work around to make
> + * dosemu happy. */
>  #define RESTORE_ALL	\
> -	RESTORE_REGS	\
> +	movl EFLAGS(%esp), %eax; \
> +	movb CS(%esp), %al; \
> +	andl $(VM_MASK | 2), %eax; \
> +	cmpl $2, %eax;  \
> +	jne 3f;         \
> +	larl OLDSS(%esp), %eax; \
> +	testl $0x00400000, %eax; \
> +3:	RESTORE_REGS	\
> +	jz 8f;          \
>  	addl $4, %esp;	\
>  1:	iret;		\
>  .section .fixup,"ax";   \
> @@ -137,8 +159,43 @@
>  .section __ex_table,"a";\
>  	.align 4;	\
>  	.long 1b,2b;	\
> -.previous
> -
> +.previous; \
> +	/* preparing the ESPfix here */ \
> +	/* reserve some space on stack for the NMI handler */ \
> +8:	subl $(NMI_STACK_RESERVE-4), %esp; \
> +	.rept 5; \

Any reason why you left this part of RESTORE_ALL macro?  It can
be moved out, IMHO.  RESTORE_ALL is used twice in entry.S, so you
could save one copy.  Though I'm not sure why NMI handler simple
does not jump to RESTORE_ALL we already have.

> +	pushl NMI_STACK_RESERVE+16(%esp); \
> +	.endr; \
> +	pushl %eax; \
> +	movl %esp, %eax; \
> +	pushl %ebp; \
> +	preempt_stop; \
> +	GET_THREAD_INFO(%ebp); \
> +	movl TI_cpu(%ebp), %ebp; \
> +	shll $GDT_SIZE_SHIFT, %ebp; \
> +	/* find GDT of the proper CPU */ \
> +	addl $cpu_gdt_table, %ebp; \

I did not know we have per-CPU GDT tables...  This explains it.

> +	/* patch the base of the ring-1 16bit stack */ \
> +	movw %ax, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 2)(%ebp); \
> +	shrl $16, %eax; \
> +	movb %al, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 4)(%ebp); \
> +	movb %ah, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 7)(%ebp); \
> +	popl %ebp; \
> +	popl %eax; \
> +	/* push the ESP value to preload on ring-1 */ \
> +	pushl 12(%esp); \
> +	movw $4, (%esp); \
> +	/* push the iret frame for our ring-1 trampoline */ \
> +	pushl $__ESPFIX_SS; \
> +	pushl $0; \
> +	/* push ring-3 flags only to get the IOPL right */ \
> +	pushl 20(%esp); \
> +	andl $~(IF_MASK | TF_MASK | RF_MASK | NT_MASK | AC_MASK), (%esp); \
> +	/* we need at least IOPL1 to re-enable interrupts */ \
> +	orl $IOPL1_MASK, (%esp); \
> +	pushl $__ESPFIX_CS; \
> +	pushl $espfix_trampoline; \
> +	iret;

FYI, on my system (P4/1.6GHz) 100M loops of these pushes takes 1.20sec
while written with subl $24,%esp and then doing movs to xx(%esp) takes
0.94sec.  Plus you could then reorganize code a bit (first do 5 pushes
to copy stack, then subtract 24 from esp, and push eax/ebp after that.
This way you can use %eax for computations you currently do in memory
(which are probably most important for 27% slowdown between
pushes and movs - I wrote mov code with using eax for EFLAGS1 & ESP1).

> -	.quad 0x0000000000000000	/* 0xd0 - unused */
> -	.quad 0x0000000000000000	/* 0xd8 - unused */
> +	.quad 0x00cfba000000ffff	/* 0xd0 - ESPfix CS */
> +	.quad 0x0000b2000000ffff	/* 0xd8 - ESPfix SS */

Set SS limit to 23 bytes, so misuse can be quickly catched?  As SP=0 and
we use 16bit stack, it goes from 0000 => FFFE, and you could corrupt
memory 64KB beyond top of CPL1 stack.
					Best regards,
						Petr Vandrovec


