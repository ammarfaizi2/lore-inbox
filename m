Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWIGXnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWIGXnv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWIGXnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:43:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:51943 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751876AbWIGXnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:43:47 -0400
Subject: Re: [PATCH] FRV: Use the generic IRQ stuff
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
In-Reply-To: <20060907133845.5031.87111.stgit@warthog.cambridge.redhat.com>
References: <20060907133845.5031.87111.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 09:43:01 +1000
Message-Id: <1157672581.22705.345.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  #define __reg16(ADDR) (*(volatile unsigned short *)(ADDR))
>  
> @@ -33,83 +32,129 @@ #define __set_IMR(M)	do { __reg16(0xffc0
>  #define __get_IFR()	({ __reg16(0xffc0000c); })
>  #define __clr_IFR(M)	do { __reg16(0xffc0000c) = ~(M); wmb(); } while(0)
>  
> -static void frv_fpga_doirq(struct irq_source *source);
> -static void frv_fpga_control(struct irq_group *group, int irq, int on);
>  
> -/*****************************************************************************/
>  /*
> - * FPGA IRQ multiplexor
> + * on-motherboard FPGA PIC operations
>   */
> -static struct irq_source frv_fpga[4] = {
> -#define __FPGA(X, M)					\
> -	[X] = {						\
> -		.muxname	= "fpga."#X,		\
> -		.irqmask	= M,			\
> -		.doirq		= frv_fpga_doirq,	\
> -	}
> +static void frv_fpga_enable(unsigned int irq)
> +{
> +	uint16_t imr = __get_IMR();
>  
> -	__FPGA(0, 0x0028),
> -	__FPGA(1, 0x0050),
> -	__FPGA(2, 0x1c00),
> -	__FPGA(3, 0x6386),
> -};
> -
> -static struct irq_group frv_fpga_irqs = {
> -	.first_irq	= IRQ_BASE_FPGA,
> -	.control	= frv_fpga_control,
> -	.sources = {
> -		[ 1] = &frv_fpga[3],
> -		[ 2] = &frv_fpga[3],
> -		[ 3] = &frv_fpga[0],
> -		[ 4] = &frv_fpga[1],
> -		[ 5] = &frv_fpga[0],
> -		[ 6] = &frv_fpga[1],
> -		[ 7] = &frv_fpga[3],
> -		[ 8] = &frv_fpga[3],
> -		[ 9] = &frv_fpga[3],
> -		[10] = &frv_fpga[2],
> -		[11] = &frv_fpga[2],
> -		[12] = &frv_fpga[2],
> -		[13] = &frv_fpga[3],
> -		[14] = &frv_fpga[3],
> -	},
> -};
> +	imr &= ~(1 << (irq - IRQ_BASE_FPGA));
>  
> +	__set_IMR(imr);
> +}
>  
> -static void frv_fpga_control(struct irq_group *group, int index, int on)
> +static void frv_fpga_disable(unsigned int irq)
>  {
>  	uint16_t imr = __get_IMR();
>  
> -	if (on)
> -		imr &= ~(1 << index);
> -	else
> -		imr |= 1 << index;
> +	imr |= 1 << (irq - IRQ_BASE_FPGA);
>  
>  	__set_IMR(imr);
>  }
>  
> -static void frv_fpga_doirq(struct irq_source *source)
> +static void frv_fpga_ack(unsigned int irq)
> +{
> +	__clr_IFR(1 << (irq - IRQ_BASE_FPGA));
> +}
> +
> +static void frv_fpga_end(unsigned int irq)
> +{
> +}
> +
> +static struct irq_chip frv_fpga_pic = {
> +	.name		= "mb93091",
> +	.enable		= frv_fpga_enable,
> +	.disable	= frv_fpga_disable,
> +	.ack		= frv_fpga_ack,
> +	.mask		= frv_fpga_disable,
> +	.unmask		= frv_fpga_enable,
> +	.end		= frv_fpga_end,
> +};

Why do you have a end() handler ? (and an empty one....) Your FPGA
interrupts ase using the level generic flow handler right ? That doesn't
call end(). Though you might want to have a mask_ack() "combined"
callback to avoid two indirect calls (it's an optional optimisation). 

> +/*
> + * FPGA PIC interrupt handler
> + */
> +static irqreturn_t fpga_interrupt(int irq, void *_mask, struct pt_regs *regs)
>  {
> -	uint16_t mask, imr;
> +	uint16_t imr, mask = (unsigned long) _mask;
> +	irqreturn_t iret = 0;
>  
>  	imr = __get_IMR();
> -	mask = source->irqmask & ~imr & __get_IFR();
> -	if (mask) {
> -		__set_IMR(imr | mask);
> -		__clr_IFR(mask);
> -		distribute_irqs(&frv_fpga_irqs, mask);
> -		__set_IMR(imr);
> +	mask = mask & ~imr & __get_IFR();
> +
> +	/* poll all the triggered IRQs */
> +	while (mask) {
> +		int irq;
> +
> +		asm("scan %1,gr0,%0" : "=r"(irq) : "r"(mask));
> +		irq = 31 - irq;
> +		mask &= ~(1 << irq);
> +
> +		if (__do_IRQ(IRQ_BASE_FPGA + irq, regs))
> +			iret |= IRQ_HANDLED;
>  	}

Ahem... __do_IRQ()... That's probably part of your bloat... With a
conversion to genirq, you shouldn't use __do_IRQ() anymore (and thus it
shouldn't be compiled in). In fact, that defeats genirq completely as
you aren't calling the new handlers at all there. You should call
generic_handle_irq() instead.

> +	return iret;
>  }
>  
> +/*
> + * define an interrupt action for each FPGA PIC output
> + * - use dev_id to indicate the FPGA PIC input to output mappings
> + */
> +static struct irqaction fpga_irq[4]  = {
> +	[0] = {
> +		.handler	= fpga_interrupt,
> +		.flags		= IRQF_DISABLED | IRQF_SHARED,
> +		.mask		= CPU_MASK_NONE,
> +		.name		= "fpga.0",
> +		.dev_id		= (void *) 0x0028UL,
> +	},

 .../...

> +};
> +
> +/*
> + * initialise the motherboard FPGA's PIC
> + */
>  void __init fpga_init(void)
>  {
> +	int irq;
> +
> +	/* all PIC inputs are all set to be low-level driven, apart from the
> +	 * NMI button (15) which is fixed at falling-edge
> +	 */
>  	__set_IMR(0x7ffe);
>  	__clr_IFR(0x0000);
>  
> -	frv_irq_route_external(&frv_fpga[0], IRQ_CPU_EXTERNAL0);
> -	frv_irq_route_external(&frv_fpga[1], IRQ_CPU_EXTERNAL1);
> -	frv_irq_route_external(&frv_fpga[2], IRQ_CPU_EXTERNAL2);
> -	frv_irq_route_external(&frv_fpga[3], IRQ_CPU_EXTERNAL3);
> -	frv_irq_set_group(&frv_fpga_irqs);
> +	for (irq = IRQ_BASE_FPGA + 1; irq <= IRQ_BASE_FPGA + 14; irq++)
> +		set_irq_chip_and_handler(irq, &frv_fpga_pic, handle_level_irq);
> +
> +	set_irq_chip_and_handler(IRQ_FPGA_NMI, &frv_fpga_pic, handle_edge_irq);
> +
> +	/* the FPGA drives the first four external IRQ inputs on the CPU PIC */
> +	setup_irq(IRQ_CPU_EXTERNAL0, &fpga_irq[0]);
> +	setup_irq(IRQ_CPU_EXTERNAL1, &fpga_irq[1]);
> +	setup_irq(IRQ_CPU_EXTERNAL2, &fpga_irq[2]);
> +	setup_irq(IRQ_CPU_EXTERNAL3, &fpga_irq[3]);
>  }

Your approach to cascades might be wrong here. Instead of setting up an
irq handler, you could just attach a chained flow handler. Much less
overhead.

> +static void frv_fpga_end(unsigned int irq)
> +{
> +}
> +
> +static struct irq_chip frv_fpga_pic = {
> +	.name		= "mb93093",
> +	.enable		= frv_fpga_enable,
> +	.disable	= frv_fpga_disable,
> +	.ack		= frv_fpga_ack,
> +	.mask		= frv_fpga_disable,
> +	.unmask		= frv_fpga_enable,
> +	.end		= frv_fpga_end,
> +};

SImilar comments. Also, you are using enable/disable here. Just leave
them NULL and the generic code will call your mask/unmask.

> +/*
> + * FPGA PIC interrupt handler
> + */
> +static irqreturn_t fpga_interrupt(int irq, void *_mask, struct pt_regs *regs)
>  {
> -	uint16_t mask, imr;
> +	uint16_t imr, mask = (unsigned long) _mask;
> +	irqreturn_t iret = 0;
>  
>  	imr = __get_IMR();
> -	mask = source->irqmask & ~imr & __get_IFR();
> -	if (mask) {
> -		__set_IMR(imr | mask);
> -		__clr_IFR(mask);
> -		distribute_irqs(&frv_fpga_irqs, mask);
> -		__set_IMR(imr);
> +	mask = mask & ~imr & __get_IFR();
> +
> +	/* poll all the triggered IRQs */
> +	while (mask) {
> +		int irq;
> +
> +		asm("scan %1,gr0,%0" : "=r"(irq) : "r"(mask));
> +		irq = 31 - irq;
> +		mask &= ~(1 << irq);
> +
> +		if (__do_IRQ(IRQ_BASE_FPGA + irq, regs))
> +			iret |= IRQ_HANDLED;
>  	}
> +
> +	return iret;
>  }

Same comment as before. Don't call __do_IRQ()

> +/*
> + * define an interrupt action for each FPGA PIC output
> + * - use dev_id to indicate the FPGA PIC input to output mappings
> + */
> +static struct irqaction fpga_irq[1]  = {
> +	[0] = {
> +		.handler	= fpga_interrupt,
> +		.flags		= IRQF_DISABLED,
> +		.mask		= CPU_MASK_NONE,
> +		.name		= "fpga.0",
> +		.dev_id		= (void *) 0x0700UL,
> +	}
> +};
> +
> +/*
> + * initialise the motherboard FPGA's PIC
> + */
>  void __init fpga_init(void)
>  {
> +	int irq;
> +
> +	/* all PIC inputs are all set to be edge triggered */
>  	__set_IMR(0x0700);
>  	__clr_IFR(0x0000);
>  
> -	frv_irq_route_external(&frv_fpga[0], IRQ_CPU_EXTERNAL2);
> -	frv_irq_set_group(&frv_fpga_irqs);
> +	for (irq = IRQ_BASE_FPGA + 8; irq <= IRQ_BASE_FPGA + 10; irq++)
> +		set_irq_chip_and_handler(irq, &frv_fpga_pic, handle_edge_irq);
> +
> +	/* the FPGA drives external IRQ input #2 on the CPU PIC */
> +	setup_irq(IRQ_CPU_EXTERNAL2, &fpga_irq[0]);
>  }

And same comment as before vs. using a flow handler.

You do that in another one at least... And I have to go now so I can't
finish reviewing your patch :) But it looks like you aren't properly
"converting" to the genirq code and thus not getting all of the benefit,
like faster code path to cascade handlers, etc... and you aren't getting
rid of __do_IRQ() so at the end of the day, you aren't using the new
stuff and still link in the old one :)

Ben.

