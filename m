Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUKCJm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUKCJm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKCJI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:08:29 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:30352 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261503AbUKCJHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:07:17 -0500
Date: Wed, 3 Nov 2004 10:07:10 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: avoid asmlinkage on x86 traps/interrupts
Message-ID: <20041103090710.GV3571@dualathlon.random>
References: <Pine.LNX.4.58.0411021250310.2187@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411021250310.2187@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 12:56:54PM -0800, Linus Torvalds wrote:
>  	if (curctx != irqctx) {
> +		int arg1, arg2, ebx;
> +
>  		/* build the stack frame on the IRQ stack */
>  		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
>  		irqctx->tinfo.task = curctx->tinfo.task;
>  		irqctx->tinfo.previous_esp = current_stack_pointer();
>  
> -		*--isp = (u32) &regs;
> -		*--isp = (u32) irq;
> -
>  		asm volatile(
>  			"       xchgl   %%ebx,%%esp      \n"
>  			"       call    __do_IRQ         \n"
> -			"       xchgl   %%ebx,%%esp      \n"
> -			: : "b"(isp)
> -			: "memory", "cc", "eax", "edx", "ecx"
> +			"       movl   %%ebx,%%esp      \n"
> +			: "=a" (arg1), "=d" (arg2), "=b" (ebx)
> +			:  "0" (irq),   "1" (regs),  "2" (isp)
> +			: "memory", "cc", "ecx"
>  		);

why do you restore the parameters into arg1/arg2/ebx? since it's
volatile I doubt gcc can optimize them away despite they're clearly
going to be discarded.

I guess it'd be nicer to simply move the output into the input with "a",
"d", "b", and the not add any output at all, and put "eax/edx" back into
the clobbers.
