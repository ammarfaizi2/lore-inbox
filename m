Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVLMOtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVLMOtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVLMOtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:49:45 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:10842 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964977AbVLMOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:49:44 -0500
In-Reply-To: <20051212114759.GA10243@flint.arm.linux.org.uk>
References: <20051106084012.GB25134@flint.arm.linux.org.uk> <20051212114759.GA10243@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <192FCF8D-4C27-44DF-9EEA-612AAC427164@kernel.crashing.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] IRQ type flags
Date: Tue, 13 Dec 2005 08:49:50 -0600
To: Russell King <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 12, 2005, at 5:47 AM, Russell King wrote:

> Here's an updated patch, taking account of folks comments.  The  
> changes
> from the previous patch are:
>
> * Move SA_TRIGGER into linux/signal.h
> * Change SA_TRIGGER_* to match IORESOURCE_IRQ_* definitions
> * Change ARM __IRQT_* definitions to match IORESOURCE_IRQ_*  
> definitions
> * Add a comment to explain the case where no SA_TRIGGER_* flags are
>   passed to request_irq.
>
> ----
> Some ARM platforms have the ability to program the interrupt  
> controller to
> detect various interrupt edges and/or levels.  For some platforms,  
> this is
> critical to setup correctly, particularly those which the setting is
> dependent on the device.
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
>
> Hence, if we combine set_irq_type() with request_irq(), we can then  
> safely
> set the type prior to unmasking the interrupt.  The unfortunate  
> problem is
> that in order to support this, these flags need to be visible  
> outside of
> the ARM architecture - drivers such as smc91x need these flags and  
> they're
> cross-architecture.
>
> Finally, the SA_TRIGGER_* flag passed to request_irq() should  
> reflect the
> property that the device would like.  The IRQ controller code  
> should do its
> best to select the most appropriate supported mode.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>
>  arch/arm/kernel/irq.c  |   14 ++++++++++++--
>  include/asm-arm/irq.h  |   12 ++++++++----
>  include/linux/signal.h |   13 +++++++++++++
>  3 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -684,8 +684,12 @@ int setup_irq(unsigned int irq, struct i
>  	spin_lock_irqsave(&irq_controller_lock, flags);
>  	p = &desc->action;
>  	if ((old = *p) != NULL) {
> -		/* Can't share interrupts unless both agree to */
> -		if (!(old->flags & new->flags & SA_SHIRQ)) {
> +		/*
> +		 * Can't share interrupts unless both agree to and are
> +		 * the same type.
> +		 */
> +		if (!(old->flags & new->flags & SA_SHIRQ) ||
> +		    (~old->flags & new->flags) & SA_TRIGGER_MASK) {
>  			spin_unlock_irqrestore(&irq_controller_lock, flags);
>  			return -EBUSY;
>  		}
> @@ -705,6 +709,12 @@ int setup_irq(unsigned int irq, struct i
>  		desc->running = 0;
>  		desc->pending = 0;
>  		desc->disable_depth = 1;
> +
> +		if (new->flags & SA_TRIGGER_MASK) {
> +			unsigned int type = new->flags & SA_TRIGGER;
> +			desc->chip->set_type(irq, type);
> +		}
> +
>  		if (!desc->noautoenable) {
>  			desc->disable_depth = 0;
>  			desc->chip->unmask(irq);
> diff --git a/include/asm-arm/irq.h b/include/asm-arm/irq.h
> --- a/include/asm-arm/irq.h
> +++ b/include/asm-arm/irq.h
> @@ -25,10 +25,14 @@ extern void disable_irq_nosync(unsigned
>  extern void disable_irq(unsigned int);
>  extern void enable_irq(unsigned int);
>
> -#define __IRQT_FALEDGE	(1 << 0)
> -#define __IRQT_RISEDGE	(1 << 1)
> -#define __IRQT_LOWLVL	(1 << 2)
> -#define __IRQT_HIGHLVL	(1 << 3)
> +/*
> + * These correspond with the SA_TRIGGER_* defines, and therefore the
> + * IRQRESOURCE_IRQ_* defines.

comment nit.  Should be IORESOURCE_IRQ_* not IRQRESOURCE_IRQ_*

> + */
> +#define __IRQT_RISEDGE	(1 << 0)
> +#define __IRQT_FALEDGE	(1 << 1)
> +#define __IRQT_HIGHLVL	(1 << 2)
> +#define __IRQT_LOWLVL	(1 << 3)
>
>  #define IRQT_NOEDGE	(0)
>  #define IRQT_RISING	(__IRQT_RISEDGE)
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -18,6 +18,19 @@
>  #define SA_PROBE		SA_ONESHOT
>  #define SA_SAMPLE_RANDOM	SA_RESTART
>  #define SA_SHIRQ		0x04000000
> +/*
> + * As above, these correspond to the IORESOURCE_IRQ_* defines in
> + * linux/ioport.h to select the interrupt line behaviour.  When
> + * requesting an interrupt without specifying a SA_TRIGGER, the
> + * setting should be assumed to be "as already configured", which
> + * may be as per machine or firmware initialisation.
> + */
> +#define SA_TRIGGER_LOW		0x00000008
> +#define SA_TRIGGER_HIGH		0x00000004
> +#define SA_TRIGGER_FALLING	0x00000002
> +#define SA_TRIGGER_RISING	0x00000001
> +#define SA_TRIGGER_MASK	(SA_TRIGGER_HIGH|SA_TRIGGER_LOW|\
> +				 SA_TRIGGER_RISING|SA_TRIGGER_FALLING)

Do you mind expand the comment to convey that LOW/HIGH are related to  
level sensitive interrupts and FALLING/RISING are for edge.  This is  
different naming that I'm used to with PowerPC and it can get a  
little confusing.

- kumar

