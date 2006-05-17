Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWEQF5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWEQF5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 01:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWEQF5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 01:57:02 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:36618 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932430AbWEQF5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 01:57:00 -0400
Date: Wed, 17 May 2006 07:56:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [patch 01/50] genirq: cleanup: merge irq_affinity[] into irq_desc[]
Message-ID: <20060517055650.GA19785@mars.ravnborg.org>
References: <20060517001323.GB12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517001323.GB12877@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 02:13:24AM +0200, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> consolidation: remove the irq_affinity[NR_IRQS] array and move it
> into the irq_desc[NR_IRQS].affinity field.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

> Index: linux-genirq.q/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- linux-genirq.q.orig/arch/powerpc/platforms/pseries/xics.c
> +++ linux-genirq.q/arch/powerpc/platforms/pseries/xics.c
> @@ -238,7 +238,7 @@ static int get_irq_server(unsigned int i
>  {
>  	unsigned int server;
>  	/* For the moment only implement delivery to all cpus or one cpu */
> -	cpumask_t cpumask = irq_affinity[irq];
> +	cpumask_t cpumask = irq_desc[irq].affinity;
>  	cpumask_t tmp = CPU_MASK_NONE;
>  
>  	if (!distribute_irqs)

Assigned unconditionally - outside CONFIG_SMP as I read the code but..

> Index: linux-genirq.q/include/linux/irq.h
> ===================================================================
> --- linux-genirq.q.orig/include/linux/irq.h
> +++ linux-genirq.q/include/linux/irq.h
> @@ -77,6 +77,9 @@ typedef struct irq_desc {
>  	unsigned int irq_count;		/* For detecting broken interrupts */
>  	unsigned int irqs_unhandled;
>  	spinlock_t lock;
> +#ifdef CONFIG_SMP
> +	cpumask_t affinity;
> +#endif

But defined only for SMP.
Looks wrong at first look.

	Sam
