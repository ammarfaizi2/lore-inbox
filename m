Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263560AbUJ2XYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263560AbUJ2XYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUJ2XWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:22:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:35787 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263560AbUJ2XNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:13:30 -0400
Date: Sat, 30 Oct 2004 01:13:22 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch 7/8] KGDB support for x86_64
Message-ID: <20041029231322.GD31914@wotan.suse.de>
References: <6.29102004.trini@kernel.crashing.org> <1.29102004.trini@kernel.crashing.org> <7.29102004.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7.29102004.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:34:21AM -0700, Tom Rini wrote:
> 
> Cc: Andi Kleen <ak@suse.de>
> This adds KGDB support for x86_64.

Can you please explain what the additional hooks are good for? 


> +++ linux-2.6.10-rc1-trini/arch/x86_64/kernel/Makefile	2004-10-29 11:26:45.757144605 -0700
> @@ -10,6 +10,8 @@ obj-y	:= process.o semaphore.o signal.o 
>  		setup64.o bootflag.o e820.o reboot.o warmreboot.o
>  obj-y += mce.o
>  
> +CFLAGS_vsyscall.o := -g0
> +

What's this? 


> +#include <linux/kgdb.h>
>  #include <asm/uaccess.h>
>  #include <asm/io_apic.h>
>  
> @@ -103,6 +104,13 @@ asmlinkage unsigned int do_IRQ(struct pt
>  	__do_IRQ(irq, regs);
>  	irq_exit();
>  
> +	/*
> +	 * Do not call breakpoint as on the x86_64 architecture if the
> +	 * exception tables are not set.
> +	 */
> +	if(CHECK_EXCEPTION_STACK())
> +		kgdb_process_breakpoint();
> +

And that?   Why do you need to check breakpoints in interrupts?

>  #include <linux/moduleparam.h>
> +#include <linux/debugger.h>
>  
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> @@ -642,7 +643,7 @@ asmlinkage void *do_debug(struct pt_regs
>  	tsk->thread.debugreg6 = condition;
>  
>  	/* Mask out spurious TF errors due to lazy TF clearing */
> -	if (condition & DR_STEP) {
> +	if (condition & DR_STEP && !debugger_step) {

This also looks bogus. What is this exactly for and why is it not
handled through the debug chain? 


-Andi
