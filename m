Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271925AbRHVEn6>; Wed, 22 Aug 2001 00:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271927AbRHVEns>; Wed, 22 Aug 2001 00:43:48 -0400
Received: from member.michigannet.com ([207.158.188.18]:268 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S271925AbRHVEni>; Wed, 22 Aug 2001 00:43:38 -0400
Date: Wed, 22 Aug 2001 00:43:20 -0400
From: Paul <set@pobox.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] [resolution]
Message-ID: <20010822004319.A234@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, Brian Gerst <bgerst@didntduck.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010819004703.A226@squish.home.loc> <3B831CDF.4CC930A7@didntduck.org> <20010821232557.G218@squish.home.loc> <3B832904.491AFE0E@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B832904.491AFE0E@didntduck.org>; from bgerst@didntduck.org on Tue, Aug 21, 2001 at 11:37:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org>, on Tue Aug 21, 2001 [11:37:40 PM] said:
> Paul wrote:
> > 
> > Brian Gerst <bgerst@didntduck.org>, on Tue Aug 21, 2001 [10:45:51 PM] said:
> > > > CPU:    0
> > > > EIP:    0010:[<c0180a18>]
> > > > Using defaults from ksymoops -t elf32-i386 -a i386
> > > > EFLAGS: 00010002
> > > > eax: 00001000   ebx: c4562368   ecx: 00000000   edx: 00000001
> > > > esi: c4562368   edi: c4a954d4   ebp: 00000001   esp: c6887d88
> > > > ds: 008   es: 0000   ss: 0018
> > >                 ^^^^
> > > Here is your problem.  %es is set to the null segment.  I had my
> > > suspicions about the segment reload optimisation in the -ac kernels, and
> > > this proves it.  Try backing out the changes to arch/i386/kernel/entry.S
> > > and include/asm-i386/hw_irq.h and see if that fixes the problem.
> > >

[....]

> Try the attached diff.
> 

	Dear Brian;

	Well, with this backed out, I cannot get an oops anymore.
	Thanks.

Paul
set@pobox.com

> --
> 						Brian Gerst
> --- linux-2.4.8-ac7/arch/i386/kernel/entry.S	Mon Aug 20 19:21:49 2001
> +++ linux-2.4.8/arch/i386/kernel/entry.S	Sat Jul  7 13:55:12 2001
> @@ -106,14 +106,10 @@
>  	popl %edi;	\
>  	popl %ebp;	\
>  	popl %eax;	\
> -	cmpl $__KERNEL_DS,(%esp); \
> -	je 4f ; \
>  1:	popl %ds;	\
>  2:	popl %es;	\
>  	addl $4,%esp;	\
>  3:	iret;		\
> -4:	addl $12,%esp;	\
> -	iret; \
>  .section .fixup,"ax";	\
>  4:	movl $0,(%esp);	\
>  	jmp 1b;		\
> @@ -289,11 +285,9 @@
>  	pushl %esi			# push the error code
>  	pushl %edx			# push the pt_regs pointer
>  	movl $(__KERNEL_DS),%edx
> -	cmpl %edx,%ecx
> -	jz	1f
>  	movl %edx,%ds
>  	movl %edx,%es
> -1:	GET_CURRENT(%ebx)
> +	GET_CURRENT(%ebx)
>  	call *%edi
>  	addl $8,%esp
>  	jmp ret_from_exception
> --- linux-2.4.8-ac7/include/asm-i386/hw_irq.h	Mon Aug 20 19:22:19 2001
> +++ linux-2.4.8/include/asm-i386/hw_irq.h	Sat Jul  7 13:55:40 2001
> @@ -95,10 +95,6 @@
>  #define __STR(x) #x
>  #define STR(x) __STR(x)
>  
> -/* 
> - * A segment register reload is rather expensive. Try to avoid it 
> - * if possible. 
> - */ 
>  #define SAVE_ALL \
>  	"cld\n\t" \
>  	"pushl %es\n\t" \
> @@ -110,12 +106,9 @@
>  	"pushl %edx\n\t" \
>  	"pushl %ecx\n\t" \
>  	"pushl %ebx\n\t" \
> -	"movl $" STR(__KERNEL_DS) ",%eax\n\t" \
> -	"cmpl %eax,7*4(%esp)\n\t"  \
> -	"je 1f\n\t"  \
> -	"movl %eax,%ds\n\t" \
> -	"movl %eax,%es\n\t" \
> -	"1:\n\t"
> +	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
> +	"movl %edx,%ds\n\t" \
> +	"movl %edx,%es\n\t"
>  
>  #define IRQ_NAME2(nr) nr##_interrupt(void)
>  #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)

