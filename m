Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUDEXom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUDEXom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:44:42 -0400
Received: from pxy6allmi.all.mi.charter.com ([24.247.15.57]:27842 "EHLO
	proxy6-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S263526AbUDEXoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:44:39 -0400
Message-ID: <4071EF44.7090006@quark.didntduck.org>
Date: Mon, 05 Apr 2004 19:44:04 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] use EFLAGS #defines instead of inline constants
References: <20040405160745.3f21f9c3.rddunlap@osdl.org>
In-Reply-To: <20040405160745.3f21f9c3.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> // linux-2.6.5
> // use x86 EFLAGS defines in place of inline constants;
> 
> diffstat:=
>  arch/i386/kernel/doublefault.c |    3 ++-
>  arch/i386/kernel/process.c     |    2 +-
>  arch/i386/kernel/signal.c      |    7 ++++++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> 
> diff -Naurp ./arch/i386/kernel/doublefault.c~use_eflags ./arch/i386/kernel/doublefault.c
> --- ./arch/i386/kernel/doublefault.c~use_eflags	2004-03-10 18:55:22.000000000 -0800
> +++ ./arch/i386/kernel/doublefault.c	2004-04-01 21:10:04.000000000 -0800
> @@ -6,6 +6,7 @@
>  
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
> +#include <asm/processor.h>
>  #include <asm/desc.h>
>  
>  #define DOUBLEFAULT_STACKSIZE (1024)
> @@ -53,7 +54,7 @@ struct tss_struct doublefault_tss __cach
>  	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
>  
>  	.eip		= (unsigned long) doublefault_fn,
> -	.eflags		= 0x00000082,
> +	.eflags		= X86_EFLAGS_SF | 0x2,	/* 0x2 bit is always set */
>  	.esp		= STACK_START,
>  	.es		= __USER_DS,
>  	.cs		= __KERNEL_CS,
> diff -Naurp ./arch/i386/kernel/process.c~use_eflags ./arch/i386/kernel/process.c
> --- ./arch/i386/kernel/process.c~use_eflags	2004-03-30 17:41:30.000000000 -0800
> +++ ./arch/i386/kernel/process.c	2004-04-01 21:10:56.000000000 -0800
> @@ -278,7 +278,7 @@ int kernel_thread(int (*fn)(void *), voi
>  	regs.orig_eax = -1;
>  	regs.eip = (unsigned long) kernel_thread_helper;
>  	regs.xcs = __KERNEL_CS;
> -	regs.eflags = 0x286;
> +	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
>  
>  	/* Ok, create the new process.. */
>  	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
> diff -Naurp ./arch/i386/kernel/signal.c~use_eflags ./arch/i386/kernel/signal.c
> --- ./arch/i386/kernel/signal.c~use_eflags	2004-03-10 18:55:26.000000000 -0800
> +++ ./arch/i386/kernel/signal.c	2004-04-01 21:19:14.000000000 -0800
> @@ -20,6 +20,7 @@
>  #include <linux/personality.h>
>  #include <linux/suspend.h>
>  #include <linux/elf.h>
> +#include <asm/processor.h>
>  #include <asm/ucontext.h>
>  #include <asm/uaccess.h>
>  #include <asm/i387.h>
> @@ -152,6 +153,10 @@ restore_sigcontext(struct pt_regs *regs,
>  	  err |= __get_user(tmp, &sc->seg);				\
>  	  loadsegment(seg,tmp); }
>  
> +#define	FIX_EFLAGS	(X86_EFLAGS_AC | X86_EFLAGS_OF | X86_EFLAGS_DF | \
> +			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
> +			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
> +
>  	GET_SEG(gs);
>  	GET_SEG(fs);
>  	COPY_SEG(es);
> @@ -170,7 +175,7 @@ restore_sigcontext(struct pt_regs *regs,
>  	{
>  		unsigned int tmpflags;
>  		err |= __get_user(tmpflags, &sc->eflags);
> -		regs->eflags = (regs->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
> +		regs->eflags = (regs->eflags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
>  		regs->orig_eax = -1;		/* disable syscall checks */
>  	}
>  
> 
> 
> --
> ~Randy

kernel_thread() doesn't really needs PF and SF.  They are just result 
flags that nothing should depend on.  Some additional suggestions are 
cleanup the vm86 code to use the defines from processor.h instead of its 
own, and moving FIX_EFLAGS to processor.h (rename it X86_EFLAGS_USER or 
something).

--
				Brian Gerst
