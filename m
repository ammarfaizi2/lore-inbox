Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWGCAfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWGCAfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWGCAfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:35:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750813AbWGCAfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:35:40 -0400
Date: Sun, 2 Jul 2006 17:35:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: torvalds@osdl.org, mingo@elte.hu, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-Id: <20060702173527.cbdbf0e1.akpm@osdl.org>
In-Reply-To: <1151885928.24611.24.camel@localhost.localdomain>
References: <1151885928.24611.24.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 02:18:48 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Linus: "The hacks in kernel/irq/handle.c are really horrid. REALLY
> horrid."
> 
> They are indeed. Move the dyntick quirks to ARM where they belong.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Index: linux-2.6.git/include/asm-arm/hw_irq.h
> ===================================================================
> --- linux-2.6.git.orig/include/asm-arm/hw_irq.h	2006-07-03 00:13:24.000000000 +0200
> +++ linux-2.6.git/include/asm-arm/hw_irq.h	2006-07-03 00:52:04.000000000 +0200
> @@ -6,4 +6,15 @@
>  
>  #include <asm/mach/irq.h>
>  
> +#if defined(CONFIG_NO_IDLE_HZ)
> +# include <asm/dyntick.h>
> +# define handle_dynamic_tick(action)					\
> +	if (!(action->flags & SA_TIMER) && system_timer->dyn_tick) {	\
> +		write_seqlock(&xtime_lock);				\
> +		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)	\
> +			system_timer->dyn_tick->handler(irq, 0, regs);	\
> +		write_sequnlock(&xtime_lock);				\
> +	}
> +#endif
> +
>  #endif
> Index: linux-2.6.git/include/linux/irq.h
> ===================================================================
> --- linux-2.6.git.orig/include/linux/irq.h	2006-07-03 00:13:24.000000000 +0200
> +++ linux-2.6.git/include/linux/irq.h	2006-07-03 00:49:01.000000000 +0200
> @@ -182,6 +182,10 @@ extern int setup_irq(unsigned int irq, s
>  
>  #ifdef CONFIG_GENERIC_HARDIRQS
>  
> +#ifndef handle_dynamic_tick
> +# define handle_dynamic_tick(a)		do { } while (0)
> +#endif
> +
>  #ifdef CONFIG_SMP
>  static inline void set_native_irq_info(int irq, cpumask_t mask)
>  {

This is not exactly a thing of beauty either.  It's much cleaner to use
__attribute__((weak)), but that will add an empty call-return to everyone's
interrupts.

The requirement "if you implement this then you must do so as a macro" is a
bit regrettable.  The ARCH_HAS_HANDLE_DYNAMIC_TICK approach would eliminate
that requirement.



btw, is this, from include/linux/irq.h:

/*
 * Please do not include this file in generic code.  There is currently
 * no requirement for any architecture to implement anything held
 * within this file.
 *
 * Thanks. --rmk
 */

still true?
