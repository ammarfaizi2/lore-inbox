Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273739AbSISXKC>; Thu, 19 Sep 2002 19:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273748AbSISXKC>; Thu, 19 Sep 2002 19:10:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16390 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S273739AbSISXKA>; Thu, 19 Sep 2002 19:10:00 -0400
Date: Fri, 20 Sep 2002 00:15:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.36 9/9: ARM trace support
Message-ID: <20020920001500.E11763@flint.arm.linux.org.uk>
References: <3D8A511A.B5F9044F@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8A511A.B5F9044F@opersys.com>; from karim@opersys.com on Thu, Sep 19, 2002 at 06:35:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should probably explicitly CC the architecture maintainers with
these patches.  Generally, there is no guarantee that they'll read
lkml.

On Thu, Sep 19, 2002 at 06:35:06PM -0400, Karim Yaghmour wrote:
> diff -urpN linux-2.5.36/arch/arm/kernel/entry-common.S linux-2.5.36-ltt/arch/arm/kernel/entry-common.S
> --- linux-2.5.36/arch/arm/kernel/entry-common.S	Tue Sep 17 20:58:42 2002
> +++ linux-2.5.36-ltt/arch/arm/kernel/entry-common.S	Thu Sep 19 16:29:55 2002
> @@ -35,6 +35,11 @@ ENTRY(__do_softirq)
>   * stack.
>   */
>  ret_fast_syscall:
> +#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
> +	mov	r7, r0				@ save returned r0
> +	bl	SYMBOL_NAME(trace_real_syscall_exit)
> +	mov	r0, r7
> +#endif

This misses the slow syscall exit path.

> +#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
> +asmlinkage void trace_real_syscall_entry(int scno,struct pt_regs * regs)
> +{
> +	int			depth = 0;
> +	unsigned long           end_code;
> +	unsigned long		*fp;			/* frame pointer */
> +	unsigned long		lower_bound;
> +	unsigned long		lr;			/* link register */
> +	unsigned long		*prev_fp;
> +	int			seek_depth;
> +	unsigned long           start_code;
> +	unsigned long           *start_stack;
> +	trace_syscall_entry	trace_syscall_event;
> +	unsigned long		upper_bound;
> +	int			use_bounds;
> +	int			use_depth;
> +
> +	trace_syscall_event.syscall_id = (uint8_t)scno;
> +	trace_syscall_event.address    = instruction_pointer(regs);
> +	
> +	if (! (user_mode(regs) ))
> +		goto trace_syscall_end;
> +
> +	if (trace_get_config(&use_depth,
> +			     &use_bounds,
> +			     &seek_depth,
> +			     (void*)&lower_bound,
> +			     (void*)&upper_bound) < 0)
> +		goto trace_syscall_end;
> +
> +	if ((use_depth == 1) || (use_bounds == 1)) {
> +		fp          = (unsigned long *)regs->ARM_fp;

You can't rely on FP being set to anything real.  Although the "APCS"
ABI defines that FP will be either zero or a pointer to a valid frame,
this isn't always true; a binary built with -fomit-frame-pointer will
use FP for its own purposes.  This means that there exists the possibility
for a program without any frames on the stack (although we could be
many functions deep within the program.)

Do you care about this?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

