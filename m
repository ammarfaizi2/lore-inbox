Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269096AbUIBUnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbUIBUnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUIBUlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:41:22 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:46606 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S269043AbUIBUiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:38:25 -0400
Message-ID: <413784C0.9010007@optonline.net>
Date: Thu, 02 Sep 2004 16:38:24 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: prototype "handle broken IRQ routing" patch
References: <20040902201648.GA31340@devserv.devel.redhat.com>
In-Reply-To: <20040902201648.GA31340@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> This works a treat on several boxes that otherwise simply won't run Linux
> in any useful form. The theory is simple - if an IRQ is delivered to the wrong 
> place then someone somewhere in our IRQ handler lists knows what to do with it.

Wow, this is a crime against humanity! Good job.

There is one problem, it doesn't increment irqs_unhandled when nobody 
handled anything. I'm sure these broken boxes are still capable of 
having screaming interrupts too ;)


> 
> Its if(1) for now, obviously its a boot option and if(my_computer_sucks) in
> a final version.
> 
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.8.1/arch/i386/kernel/irq.c linux-2.6.8.1.ac/arch/i386/kernel/irq.c
> --- linux-2.6.8.1/arch/i386/kernel/irq.c	2004-08-14 11:54:48.000000000 +0100
> +++ linux-2.6.8.1.ac/arch/i386/kernel/irq.c	2004-09-03 09:15:17.000000000 +0100
> @@ -280,6 +280,38 @@
>  __setup("noirqdebug", noirqdebug_setup);
>  
>  /*
> + *	Recovery handler for misrouted interrupts
> + */
> +
> +static int misrouted_irq(int irq, irq_desc_t *desc, struct pt_regs *regs)
> +{
> +	int i;
> +	for(i = 1; i < NR_IRQS; i++)
> +	{
> +		struct irqaction *action;
> +		if(i == irq)	/* Already tried */
> +			continue;
> +		spin_lock(&irq_desc[i].lock);
> +		if(irq_desc[i].status & IRQ_INPROGRESS)
> +		{
> +			spin_unlock(&irq_desc[i].lock);
> +			continue;
> +		}
> +		action = irq_desc[i].action;
> +		while(action)
> +		{
> +			if(action->flags & SA_SHIRQ)
> +			{
> +				if(action->handler(irq, action->dev_id, regs) == IRQ_HANDLED)
> +					desc->irqs_unhandled = 0;
> +			}
> +			action = action->next;
> +		}
> +		spin_unlock(&irq_desc[i].lock);
> +	}
> +}
> +
> +/*
>   * If 99,900 of the previous 100,000 interrupts have not been handled then
>   * assume that the IRQ is stuck in some manner.  Drop a diagnostic and try to
>   * turn the IRQ off.
> @@ -289,13 +321,68 @@
>   *
>   * Called under desc->lock
>   */
> -static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
> +static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret, struct pt_regs *regs)
>  {
>  	if (action_ret != IRQ_HANDLED) {
>  		desc->irqs_unhandled++;
>  		if (action_ret != IRQ_NONE)
>  			report_bad_irq(irq, desc, action_ret);
>  	}
> +	if(1)
> +	{
> +#ifdef CONFIG_4KSTACKS
> +		irqreturn_t action_ret;
> +		u32 *isp;
> +		union irq_ctx * curctx;
> +		union irq_ctx * irqctx;
> +
> +		curctx = (union irq_ctx *) current_thread_info();
> +		irqctx = hardirq_ctx[smp_processor_id()];
> +
> +		spin_unlock(&desc->lock);
> +
> +		/*
> +		 * this is where we switch to the IRQ stack. However, if we are already using
> +		 * the IRQ stack (because we interrupted a hardirq handler) we can't do that
> +		 * and just have to keep using the current stack (which is the irq stack already
> +		 * after all)
> +		 */
> +
> +		if (curctx == irqctx)
> +			misrouted_irq(irq, desc, regs);
> +		else {
> +			/* build the stack frame on the IRQ stack */
> +			isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
> +			irqctx->tinfo.task = curctx->tinfo.task;
> +			irqctx->tinfo.previous_esp = current_stack_pointer();
> +
> +			*--isp = (u32) regs;
> +			*--isp = (u32) desc;
> +			*--isp = (u32) irq;
> +
> +			asm volatile(
> +				"       xchgl   %%ebx,%%esp     \n"
> +				"       call    misrouted_irq   \n"
> +				"       xchgl   %%ebx,%%esp     \n"
> +				: "=a"(action_ret)
> +				: "b"(isp)
> +				: "memory", "cc", "edx", "ecx"
> +			);
> +
> +
> +		}
> +		spin_lock(&desc->lock);
> +		if (curctx != irqctx)
> +			irqctx->tinfo.task = NULL;
> +#else
> +		irqreturn_t action_ret;
> +		spin_unlock(&desc->lock);
> +
> +		misrouted_irq(irq, desc, regs);
> +
> +		spin_lock(&desc->lock);
> +#endif
> +	}
>  
>  	desc->irq_count++;
>  	if (desc->irq_count < 100000)
> @@ -487,7 +574,7 @@
>  	 * useful for irq hardware that does not mask cleanly in an
>  	 * SMP environment.
>  	 */
> -#ifdef CONFIG_4KSTACKS
> + #ifdef CONFIG_4KSTACKS
>  
>  	for (;;) {
>  		irqreturn_t action_ret;
> @@ -532,7 +619,7 @@
>  		}
>  		spin_lock(&desc->lock);
>  		if (!noirqdebug)
> -			note_interrupt(irq, desc, action_ret);
> +			note_interrupt(irq, desc, action_ret, &regs);
>  		if (curctx != irqctx)
>  			irqctx->tinfo.task = NULL;
>  		if (likely(!(desc->status & IRQ_PENDING)))
> @@ -551,7 +638,7 @@
>  
>  		spin_lock(&desc->lock);
>  		if (!noirqdebug)
> -			note_interrupt(irq, desc, action_ret);
> +			note_interrupt(irq, desc, action_ret, &regs);
>  		if (likely(!(desc->status & IRQ_PENDING)))
>  			break;
>  		desc->status &= ~IRQ_PENDING;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
