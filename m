Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWEaGkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWEaGkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWEaGkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:40:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:48779 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964828AbWEaGkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:40:52 -0400
Subject: Re: [patch, -rc5-mm1] genirq MSI fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060531061500.GA20609@elte.hu>
References: <20060531061500.GA20609@elte.hu>
Content-Type: text/plain
Date: Wed, 31 May 2006 16:40:37 +1000
Message-Id: <1149057637.766.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 08:15 +0200, Ingo Molnar wrote:
> this is a fixed up and cleaned up replacement for 
> genirq-msi-fixes.patch, which should solve the i386 4KSTACKS problem. I 
> also added Ben's idea of pushing the __do_IRQ() check into 
> generic_handle_irq().
> 
> i booted this with MSI enabled, but i only have MSI devices, not MSI-X 
> devices. I'd still expect MSI-X to work now.

Looks good except the likely statement in generic_handle_irq() :) I'd
let the CPU speculate here and not try to influence the choice... but
heh... I understand why you want to "favor" the new scheme :)

Ben.

> --------------
> Subject: genirq-msi-fixes
> From: Ingo Molnar <mingo@elte.hu>
> 
> irqchip migration helper: call __do_IRQ() if a descriptor is attached
> to an irqtype-style controller. This also fixes MSI-X IRQ handling on
> i386 and x86_64.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
> 
>  arch/i386/kernel/irq.c |    5 +++++
>  include/linux/irq.h    |   27 ++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
> Index: linux/arch/i386/kernel/irq.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/irq.c
> +++ linux/arch/i386/kernel/irq.c
> @@ -77,6 +77,10 @@ fastcall unsigned int do_IRQ(struct pt_r
>  	}
>  #endif
>  
> +	if (!irq_desc[irq].handle_irq) {
> +		__do_IRQ(irq, regs);
> +		goto out_exit;
> +	}
>  #ifdef CONFIG_4KSTACKS
>  
>  	curctx = (union irq_ctx *) current_thread_info();
> @@ -109,6 +113,7 @@ fastcall unsigned int do_IRQ(struct pt_r
>  #endif
>  		desc->handle_irq(irq, desc, regs);
>  
> +out_exit:
>  	irq_exit();
>  
>  	return 1;
> Index: linux/include/linux/irq.h
> ===================================================================
> --- linux.orig/include/linux/irq.h
> +++ linux/include/linux/irq.h
> @@ -176,17 +176,6 @@ typedef struct irq_desc		irq_desc_t;
>   */
>  #include <asm/hw_irq.h>
>  
> -/*
> - * Architectures call this to let the generic IRQ layer
> - * handle an interrupt:
> - */
> -static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
> -{
> -	struct irq_desc *desc = irq_desc + irq;
> -
> -	desc->handle_irq(irq, desc, regs);
> -}
> -
>  extern int setup_irq(unsigned int irq, struct irqaction *new);
>  
>  #ifdef CONFIG_GENERIC_HARDIRQS
> @@ -324,6 +313,22 @@ handle_irq_name(void fastcall (*handle)(
>   */
>  extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
>  
> +/*
> + * Architectures call this to let the generic IRQ layer
> + * handle an interrupt. If the descriptor is attached to an
> + * irqchip-style controller then we call the ->handle_irq() handler,
> + * and it calls __do_IRQ() if it's attached to an irqtype-style controller.
> + */
> +static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
> +{
> +	struct irq_desc *desc = irq_desc + irq;
> +
> +	if (likely(desc->handle_irq))
> +		desc->handle_irq(irq, desc, regs);
> +	else
> +		__do_IRQ(irq, regs);
> +}
> +
>  /* Handling of unhandled and spurious interrupts: */
>  extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
>  			   int action_ret, struct pt_regs *regs);

