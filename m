Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWFTX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWFTX55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWFTX55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:57:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:974 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932126AbWFTX5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:57:55 -0400
Subject: Re: [PATCH 9/25] irq: Add a dynamic irq creation API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
In-Reply-To: <115084252131-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	 <11508425183073-git-send-email-ebiederm@xmission.com>
	 <11508425191381-git-send-email-ebiederm@xmission.com>
	 <11508425192220-git-send-email-ebiederm@xmission.com>
	 <11508425191063-git-send-email-ebiederm@xmission.com>
	 <1150842520235-git-send-email-ebiederm@xmission.com>
	 <11508425201406-git-send-email-ebiederm@xmission.com>
	 <1150842520775-git-send-email-ebiederm@xmission.com>
	 <11508425213394-git-send-email-ebiederm@xmission.com>
	 <115084252131-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:56:04 +1000
Message-Id: <1150847764.1901.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 16:28 -0600, Eric W. Biederman wrote:
> With the msi support comes a new concept in irq handling,
> irqs that are created dynamically at run time.
> 
> Currently the msi code allocates irqs backwards.  First it
> allocates a platform dependent routing value for an
> interrupt the ``vector'' and then it figures out from the
> vector which irq you are on.

You may want to look at the work I'm currently doing for powerpc where
we need a fully dynamic linux irq number allocation, completely separate
spaces for hw numbers (vectors) and linux irq numbers for arbitrary PICs
(and more than one in a given system) etc...

I'll post a patch that shows the stuff I'm adding later today so you can
have a look. There is some overlap with your dynamic irq stuff.

I haven't completely ported all of powerpc to my new core yet which is
why I haven't posted patches yet, but I'll have something out today.

Ben.
 
> This msi backwards allocator suffers from two basic
> problems.  The allocator suffers because it is trying
> to do something that is architecture specific in a generic
> way making it brittle, inflexible, and tied to tightly
> to the architecture implementation.  The alloctor also
> suffers from it's very backwards nature as it has tied
> things together that should have no dependencies.
> 
> To solve the basic dynamic irq allocation problem two
> new architecture specific functions are added:
> create_irq and destroy_irq.
> 
> create_irq takes no input and returns an unused irq number,
> that won't be reused until it is returned to the free
> poll with destroy_irq.  The irq then can be used for
> any purpose although the only initial consumer is
> the msi code.
> 
> destroy_irq takes an irq number allocated with create_irq
> and returns it to the free pool.
> 
> Making this functionality per architecture increases
> the simplicity of the irq allocation code and increases
> it's flexibility.
> 
> dynamic_irq_init() and dynamic_irq_cleanup() are added
> to automate the irq_desc initializtion that should happen
> for dynamic irqs.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  include/linux/irq.h |    9 +++++++-
>  kernel/irq/chip.c   |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b79d178..6d1ad88 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -392,8 +392,15 @@ set_irq_chained_handler(unsigned int irq
>  	__set_irq_handler(irq, handle, 1);
>  }
>  
> -/* Set/get chip/data for an IRQ: */
> +/* Handle dynamic irq creation and destruction */
> +extern int create_irq(void);
> +extern void destroy_irq(unsigned int irq);
> +
> +/* Dynamic irq helper functions */
> +extern void dynamic_irq_init(unsigned int irq);
> +extern void dynamic_irq_cleanup(unsigned int irq);
>  
> +/* Set/get chip/data for an IRQ: */
>  extern int set_irq_chip(unsigned int irq, struct irq_chip *chip);
>  extern int set_irq_data(unsigned int irq, void *data);
>  extern int set_irq_chip_data(unsigned int irq, void *data);
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 431e9d5..9c01e48 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -18,6 +18,62 @@ #include <linux/kernel_stat.h>
>  #include "internals.h"
>  
>  /**
> + *	dynamic_irq_init - initialize a dynamically allocated irq
> + *	@irq:	irq number to initialize
> + */
> +void dynamic_irq_init(unsigned int irq)
> +{
> +	struct irq_desc *desc;
> +	unsigned long flags;
> +
> +	if (irq >= NR_IRQS) {
> +		printk(KERN_ERR "Trying to initialize invalid IRQ%d\n", irq);
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	/* Ensure we don't have left over values from a previous use of this irq */
> +	desc = irq_desc + irq;
> +	spin_lock_irqsave(&desc->lock, flags);
> +	desc->status = IRQ_DISABLED;
> +	desc->chip = &no_irq_chip;
> +	desc->handle_irq = handle_bad_irq;
> +	desc->depth = 1;
> +	desc->handler_data = NULL;
> +	desc->chip_data = NULL;
> +	desc->action = NULL;
> +	desc->irq_count = 0;
> +	desc->irqs_unhandled = 0;
> +#ifdef CONFIG_SMP
> +	desc->affinity = CPU_MASK_ALL;
> +#endif
> +	spin_unlock_irqrestore(&desc->lock, flags);
> +}
> +
> +/**
> + *	dynamic_irq_cleanup - cleanup a dynamically allocated irq
> + *	@irq:	irq number to initialize
> + */
> +void dynamic_irq_cleanup(unsigned int irq)
> +{
> +	struct irq_desc *desc;
> +	unsigned long flags;
> +
> +	if (irq >= NR_IRQS) {
> +		printk(KERN_ERR "Trying to cleanup invalid IRQ%d\n", irq);
> +		WARN_ON(1);
> +		return;
> +	}
> +	
> +	desc = irq_desc + irq;
> +	spin_lock_irqsave(&desc->lock, flags);
> +	desc->handle_irq = handle_bad_irq;
> +	desc->chip = &no_irq_chip;
> +	spin_unlock_irqrestore(&desc->lock, flags);
> +}
> +
> +
> +/**
>   *	set_irq_chip - set the irq chip for an irq
>   *	@irq:	irq number
>   *	@chip:	pointer to irq chip description structure
> -- 
> 1.4.0.gc07e
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

