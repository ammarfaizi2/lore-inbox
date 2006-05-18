Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWERNxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWERNxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 09:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWERNxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 09:53:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20045 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751027AbWERNxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 09:53:48 -0400
Date: Thu, 18 May 2006 09:53:47 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH -rt 2/2] arm update
In-reply-to: <200605141557.k4EFv5Sd004979@dwalker1.mvista.com>
X-X-Sender: nico@localhost.localdomain
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0605180947180.18071@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200605141557.k4EFv5Sd004979@dwalker1.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - adds a new NR_syscalls macro, converts the old one into __NR_syscalls for
>    calculating the table padding .

Why?

> --- linux-2.6.16.orig/arch/arm/kernel/entry-common.S
> +++ linux-2.6.16/arch/arm/kernel/entry-common.S
> @@ -90,8 +90,8 @@ ENTRY(ret_from_fork)
>  	b	ret_slow_syscall
>  	
>  
> -	.equ NR_syscalls,0
> -#define CALL(x) .equ NR_syscalls,NR_syscalls+1
> +	.equ __NR_syscalls,0			@ Used to determine syscall table padding.
> +#define CALL(x) .equ __NR_syscalls,__NR_syscalls+1
>  #include "calls.S"
>  #undef CALL
>  #define CALL(x) .long x
> @@ -205,7 +205,7 @@ ENTRY(vector_swi)
>  	tst	ip, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
>  	bne	__sys_trace
>  
> -	cmp	scno, #NR_syscalls		@ check upper syscall limit
> +	cmp	scno, #__NR_syscalls		@ check upper syscall limit
[...]

Please get rid of those changes.

> --- linux-2.6.16.orig/include/asm-arm/unistd.h
> +++ linux-2.6.16/include/asm-arm/unistd.h
> @@ -361,6 +361,9 @@
>  #define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
>  #define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
>  
> +// FIXME: check this number ...
> +#define NR_syscalls			322
> +
>  /*
>   * The following SWIs are ARM private.
>   */
> @@ -534,9 +537,6 @@ type name(type1 arg1, type2 arg2, type3 
>  #define __ARCH_WANT_SYS_SOCKETCALL
>  #endif
>  
> -// FIXME: check this number ...
> -#define NR_syscalls	328
> -
>  #endif
>  
>  #ifdef __KERNEL_SYSCALLS__

And no NR_syscalls definition should be present in asm-arm/unistd.h at 
all.


Nicolas
