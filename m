Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbTFZK7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265561AbTFZK7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:59:10 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:47630 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265550AbTFZK7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:59:07 -0400
Date: Thu, 26 Jun 2003 12:13:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] irq handling code consolidation (common part)
Message-ID: <20030626121318.A6576@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030626110247.GT9679@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030626110247.GT9679@pazke>; from pazke@donpac.ru on Thu, Jun 26, 2003 at 03:02:47PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifndef HAVE_ARCH_IRQ_DESC
> +
> +/*
> + * Controller mappings for all interrupt sources:
> + */
> +irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
> +	[0 ... NR_IRQS - 1] = {
> +		.handler =	&no_irq_type,
> +		.lock =		SPIN_LOCK_UNLOCKED,
> +	}
> +};
> +
> +#endif

What about getting rid of that ifdef and having irq_desc always
in arch code?  Seems a lot cleaner to me.

> +#if defined(CONFIG_SMP) && !defined(HAVE_ARCH_SYNCRONIZE_IRQ)
> +
> +inline void synchronize_irq(unsigned int irq)
> +{
> +	irq_desc_t *desc = irq_desc(irq);
> +
> +        /* is there anything to synchronize with? */
> +	if (!desc->action)
> +		return;
> +
> +	while (desc->status & IRQ_INPROGRESS)
> +		cpu_relax();
> +}
> +
> +#endif

Hmm, what arch can't use the generic version and why?  I really
don't like the HAVE_ARCH_ macros if there's a way around it.

> +#ifndef HAVE_ARCH_IRQ_PROC
> +void register_irq_proc(unsigned int irq);
> +#endif

Again, what arch can't use the generic code?

> +#ifndef HAVE_ARCH_IRQ_PROBE
> +
> +/*
> + * IRQ autodetection code..
> + *
> + * This depends on the fact that any interrupt that
> + * comes in on to an unassigned handler will get stuck
> + * with "IRQ_WAITING" cleared and the interrupt
> + * disabled.
> + */

Which architecture uses it's own version here?  Also we might
move this to a separate file as it doesn't make a lot of sense
without CONFIG_ISA

Otherwise it looks fine (of course)!  Let's hope we'll get some variant
of it in before 2.6.
