Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVKGMm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVKGMm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVKGMm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:42:26 -0500
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:17289 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932474AbVKGMmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:42:25 -0500
Date: Mon, 7 Nov 2005 12:42:20 +0000
From: Ben Dooks <ben@fluff.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [RFC] IRQ type flags
Message-ID: <20051107124220.GA16281@home.fluff.org>
References: <20051106084012.GB25134@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106084012.GB25134@flint.arm.linux.org.uk>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 08:40:12AM +0000, Russell King wrote:
> I haven't had any feedback on this patch.  akpm - can you add it to -mm
> please?  Here's the sign-off for it, thanks.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> ----- Forwarded message from Russell King <rmk+lkml@arm.linux.org.uk> -----
> Date:	Fri, 28 Oct 2005 22:57:47 +0100
> From:	Russell King <rmk+lkml@arm.linux.org.uk>
> To:	Linux Kernel List <linux-kernel@vger.kernel.org>
> Subject: [RFC] IRQ type flags
> 
> Hi,
> 
> Some ARM platforms have the ability to program the interrupt controller
> to detect various interrupt edges and/or levels.  For some platforms,
> this is critical to setup correctly, particularly those which the
> setting is dependent on the device.
> 
> Currently, ARM drivers do (eg) the following:
> 
> 	err = request_irq(irq, ...);
> 
> 	set_irq_type(irq, IRQT_RISING);
> 
> However, if the interrupt has previously been programmed to be level
> sensitive (for whatever reason) then this will cause an interrupt
> storm.

surely, thats the other way around, going from edge to level.
 
> Hence, if we combine set_irq_type() with request_irq(), we can then
> safely set the type prior to unmasking the interrupt.  The unfortunate
> problem is that in order to support this, these flags need to be
> visible outside of the ARM architecture - drivers such as smc91x
> need these flags and they're cross-architecture.

I agree that the type of IRQ should be considered when registering
the IRQ. On the s3c2410, most boards do set the level/edge correctly
before startup (bootloader) but occasionally, the bootloader cannot
deal with all the cases.
 
> Finally, the SA_TRIGGER_* flag passed to request_irq() should reflect
> the property that the device would like.  The IRQ controller code
> should do its best to select the most appropriate supported mode.
> 
> Comments?
> 
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -681,10 +681,16 @@ int setup_irq(unsigned int irq, struct i
>  	 */
>  	desc = irq_desc + irq;
>  	spin_lock_irqsave(&irq_controller_lock, flags);
> +#define SA_TRIGGER	(SA_TRIGGER_HIGH|SA_TRIGGER_LOW|\
> +			 SA_TRIGGER_RISING|SA_TRIGGER_FALLING)
>  	p = &desc->action;
>  	if ((old = *p) != NULL) {
> -		/* Can't share interrupts unless both agree to */
> -		if (!(old->flags & new->flags & SA_SHIRQ)) {
> +		/*
> +		 * Can't share interrupts unless both agree to and are
> +		 * the same type.
> +		 */
> +		if (!(old->flags & new->flags & SA_SHIRQ) ||
> +		    (~old->flags & new->flags) & SA_TRIGGER) {
>  			spin_unlock_irqrestore(&irq_controller_lock, flags);
>  			return -EBUSY;
>  		}
> @@ -704,6 +710,12 @@ int setup_irq(unsigned int irq, struct i
>  		desc->running = 0;
>  		desc->pending = 0;
>  		desc->disable_depth = 1;
> +
> +		if (new->flags & SA_TRIGGER) {
> +			unsigned int type = new->flags & SA_TRIGGER;
> +			desc->chip->set_type(irq, type);
> +		}
> +
>  		if (!desc->noautoenable) {
>  			desc->disable_depth = 0;
>  			desc->chip->unmask(irq);
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -18,6 +18,14 @@
>  #define SA_PROBE		SA_ONESHOT
>  #define SA_SAMPLE_RANDOM	SA_RESTART
>  #define SA_SHIRQ		0x04000000
> +/*
> + * As above, these correspond to the __IRQT defines in asm-arm/irq.h
> + * to select the interrupt line behaviour.
> + */
> +#define SA_TRIGGER_HIGH		0x00000008
> +#define SA_TRIGGER_LOW		0x00000004
> +#define SA_TRIGGER_RISING	0x00000002
> +#define SA_TRIGGER_FALLING	0x00000001

How about making these compatible with the
triggers compatible with the flags from
include/linux/ioport.h definitions for the
IRQ resource (IORESOURCE_IRQ_*). 

This would make it easier to pass the resource's
flags field to the register irq code, and get
the right IRQ type for the app?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
