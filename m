Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269437AbUICJJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269437AbUICJJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269424AbUICJIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:08:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55559 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269435AbUICJFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:05:03 -0400
Date: Fri, 3 Sep 2004 10:04:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][6/8] Arch agnostic completely out of line locks / arm
Message-ID: <20040903100456.A7535@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@fsmlabs.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0409021237000.4481@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409021237000.4481@montezuma.fsmlabs.com>; from zwane@fsmlabs.com on Thu, Sep 02, 2004 at 08:02:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 08:02:55PM -0400, Zwane Mwaikambo wrote:
> --- linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/time.c	26 Aug 2004 13:13:04 -0000	1.1.1.1
> +++ linux-2.6.9-rc1-mm1-stage/arch/arm/kernel/time.c	2 Sep 2004 15:51:37 -0000
> @@ -52,6 +52,18 @@ EXPORT_SYMBOL(rtc_lock);
>  /* change this if you have some constant time drift */
>  #define USECS_PER_JIFFY	(1000000/HZ)
> 
> +#ifdef CONFIG_SMP
> +unsigned long profile_pc(struct pt_regs *regs)
> +{
> +	unsigned long pc = instruction_pointer(regs);
> +
> +	if (pc >= (unsigned long)&__lock_text_start &&
> +	    pc <= (unsigned long)&__lock_text_end)
> +		return regs->ARM_lr;
> +	return pc;
> +}
> +EXPORT_SYMBOL(profile_pc);
> +#endif

Looks good apart from this.  There's no guarantee that LR will be the
return address inside one of these lock functions - indeed the compiler
may have saved it onto the stack and decided to use the register for
something else.

Your best bet is to look at the get_wchan() code which walks the stack
frames (if present.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
