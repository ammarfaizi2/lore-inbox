Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbTCGPgP>; Fri, 7 Mar 2003 10:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbTCGPgP>; Fri, 7 Mar 2003 10:36:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33297 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261649AbTCGPgM>; Fri, 7 Mar 2003 10:36:12 -0500
Date: Fri, 7 Mar 2003 15:46:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] protect 'action' in show_interrupts
Message-ID: <20030307154643.L17492@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com> <20030306222328.14b5929c.akpm@digeo.com> <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com> <20030306233517.68c922f9.akpm@digeo.com> <Pine.LNX.4.50.0303070502400.18716-100000@montezuma.mastecende.com> <20030307022829.7868dda2.akpm@digeo.com> <Pine.LNX.4.50.0303071030500.18716-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50.0303071030500.18716-100000@montezuma.mastecende.com>; from zwane@linuxpower.ca on Fri, Mar 07, 2003 at 10:32:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 10:32:13AM -0500, Zwane Mwaikambo wrote:
> --- linux-2.5.64/arch/arm/kernel/irq.c	5 Mar 2003 05:08:11 -0000	1.1.1.1
> +++ linux-2.5.64/arch/arm/kernel/irq.c	7 Mar 2003 15:05:36 -0000
> @@ -165,17 +165,22 @@
>  {
>  	int i;
>  	struct irqaction * action;
> +	unsigned long flags;
>  
>  	for (i = 0 ; i < NR_IRQS ; i++) {
> +		spin_lock_irqsave(&irq_desc[i].lock, flags);
>  	    	action = irq_desc[i].action;
>  		if (!action)
> -			continue;
> +			goto unlock;
> +
>  		seq_printf(p, "%3d: %10u ", i, kstat_irqs(i));
>  		seq_printf(p, "  %s", action->name);
> -		for (action = action->next; action; action = action->next) {
> +		for (action = action->next; action; action = action->next)
>  			seq_printf(p, ", %s", action->name);
> -		}
> +
>  		seq_putc(p, '\n');
> +unlock:
> +		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
>  	}
>  
>  #ifdef CONFIG_ARCH_ACORN

We don't have a per-irq_desc spinlock on ARM - it's a global
irq_controller_lock.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

