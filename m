Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbTADFAc>; Sat, 4 Jan 2003 00:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbTADFAc>; Sat, 4 Jan 2003 00:00:32 -0500
Received: from samael.donpac.ru ([195.161.172.239]:9478 "EHLO samael.donpac.ru")
	by vger.kernel.org with ESMTP id <S266730AbTADFAa> convert rfc822-to-8bit;
	Sat, 4 Jan 2003 00:00:30 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Sat, 4 Jan 2003 08:03:56 +0300
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation (common part)
Message-ID: <20030104050356.GA10477@pazke>
Mail-Followup-To: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
References: <20021224060331.GA1090@pazke> <15892.34096.565694.402521@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <15892.34096.565694.402521@napali.hpl.hp.com>
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 10:30:08AM -0800, David Mosberger wrote:
> >>>>> On Tue, 24 Dec 2002 09:03:31 +0300, "Andrey Panin" <pazke@orbita1.ru> said:
> 
>   Andrey> Hi all, this patch moves some common parts of irq handling
>   Andrey> code to one place.  Arch specific patches will follow. Patch
>   Andrey> for i386 is tested and performed well, but other arch
>   Andrey> specific patched are not. Please take a look.
> 
>   Andrey> Please CC me answering this letter, I'm not subscribed to
>   Andrey> lkml currently.
> 
> +/*
> + * Controller mappings for all interrupt sources:
> + */
> +irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
> +	[0 ... NR_IRQS - 1] = {
> +		.handler =	&no_irq_type,
> +		.lock =		SPIN_LOCK_UNLOCKED,
> +	}
> +};
> 
> This isn't good.  For example, NUMA platforms with per-CPU irqs want
> to allocate the irq descriptors in local memory.  On ia64, we
> introduced a minimal irq-descriptor API for this purpose:

I noticed this already, in the new patch which I want to post today
irq_desc declaration is guarded by #ifndef HAVE_ARCH_IRQ_DESC.

> 
> 	/* Return a pointer to the irq descriptor for IRQ.  */
> 	static inline struct irq_desc * irq_desc (int irq);
> 
> 	/* Extract the IA-64 vector that corresponds to IRQ.  */
> 	static inline ia64_vector irq_to_vector (int irq);
> 
> 	/*
> 	 * Convert the local IA-64 vector to the corresponding irq number.
> 	 * This translation is done in the context of the interrupt domain
> 	 * that the currently executing CPU belongs to.
> 	 */
> 	static inline unsigned int local_vector_to_irq (ia64_vector vec);
> 
> I think the platform-independent part of the code really would only
> need the first routine irq_desc().  The other two are ia64-specific.
>
> BTW: if you haven't done so already, I'd suggest to take a look at
> arch/ia64/kernel/irq.c.  I tried to keep this code as close as
> possible to the x86 version.  There shouldn't be anything in there
> that isn't wanted for a good reason.

Already done.

BTW: what is the state of ia64 port in stock 2.5 ? 
It looks horribly borken :(

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net
