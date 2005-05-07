Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVEGMTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVEGMTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbVEGMTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 08:19:37 -0400
Received: from mx3.mail.ru ([194.67.23.149]:1355 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S263070AbVEGMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 08:19:26 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: Re: [PATCH 7/17] ARMNOMMU - platform patch for atmel
Date: Sat, 7 May 2005 16:23:12 +0000
User-Agent: KMail/1.7.2
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
References: <0IG400GQR1G2NY@mmp2.samsung.com>
In-Reply-To: <0IG400GQR1G2NY@mmp2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505071623.13143.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 May 2005 08:10, Hyok S. Choi wrote:
> --- linux-2.6.12-rc3-mm3/arch/arm/mach-atmel/Makefile
> +++ linux-2.6.12-rc3-mm3-hsc0/arch/arm/mach-atmel/Makefile

> +#
> +# Makefile for the linux kernel.
> +#

> +# Object file lists.

Useless comments.

> +obj-y		+= arch.o irq.o time.o

> --- linux-2.6.12-rc3-mm3/arch/arm/mach-atmel/arch.c
> +++ linux-2.6.12-rc3-mm3-hsc0/arch/arm/mach-atmel/arch.c

[21 #include directives snipped]

> +extern void atmel_time_init(void);
> +extern unsigned long atmel_gettimeoffset(void);
> +
> +extern void __init atmel_init_irq(void);
> +
> +extern struct sys_timer atmel_timer;
> +
> +MACHINE_START(ATMEL, "ATMEL EB01")
> +	MAINTAINER("Hyok S. Choi <hyok.choi@samsung.com>")
> +	INITIRQ(atmel_init_irq)
> +	.timer		= &atmel_timer,
> +MACHINE_END

So, all you need is:
	include/linux/init.h
	include/asm-arm/mach/time.h
	include/asm-arm/mach/arch.h
And maybe one or two more.

> --- linux-2.6.12-rc3-mm3/arch/arm/mach-atmel/irq.c
> +++ linux-2.6.12-rc3-mm3-hsc0/arch/arm/mach-atmel/irq.c

> +static unsigned char eb01_irq_prtable[32] = {

Should it be ...[NR_IRQS] ?

> +        7 << 5, /* FIQ */
> +        0 << 5, /* SWIRQ */
> +        0 << 5, /* US0IRQ */
> +        0 << 5, /* US1IRQ */
> +        2 << 5, /* TC0IRQ */
> +        2 << 5, /* TC1IRQ */
> +        2 << 5, /* TC2IRQ */
> +        0 << 5, /* WDIRQ */
> +        0 << 5, /* PIOAIRQ */
> +        0 << 5, /* reserved */
> +        0 << 5, /* reserved */
> +        0 << 5, /* reserved */
> +        0 << 5, /* reserved */
> +        0 << 5, /* reserved */
> +        0 << 5, /* reserved */
> +        0 << 5, /* reserved */
> +        1 << 5, /* IRQ0 */
> +	0 << 5, /* IRQ1 */
> +        0 << 5, /* IRQ2 */
> +};

You are doing "eb01_irq_prtable[irq] >> 5" always.

> +        for ( irq = 0 ; irq < 32 ; irq++ )
> +        {
> +                __raw_writel(irq, AIC_EOICR);
> +        }

> +        for ( irq = 0 ; irq < 32 ; irq++ )
> +        {
> +            __raw_writel((eb01_irq_prtable[irq] >> 5) | eb01_irq_type[irq],
> +		 AIC_SMR(irq));
> +        }

Use consistent style for "for" statements and brackets. Like in the next line.

> +	for (irq = 0; irq < NR_IRQS; irq++) {

Please, remove trailing whitespace from this patch. There is quite a few of 
it.
