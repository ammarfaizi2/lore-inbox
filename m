Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWHBPPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWHBPPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWHBPPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:15:15 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:29196 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751127AbWHBPPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:15:13 -0400
Date: Wed, 2 Aug 2006 16:15:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] at91_serial: support AVR32
Message-ID: <20060802151505.GA32102@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
References: <11545303083273-git-send-email-hskinnemoen@atmel.com> <11545303082669-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11545303082669-git-send-email-hskinnemoen@atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 04:51:46PM +0200, Haavard Skinnemoen wrote:
> diff --git a/drivers/serial/at91_serial.c b/drivers/serial/at91_serial.c
> index 54c6b2a..f2fecc6 100644
> --- a/drivers/serial/at91_serial.c
> +++ b/drivers/serial/at91_serial.c
> @@ -40,8 +40,10 @@ #include <asm/arch/at91rm9200_usart.h>
>  #include <asm/arch/at91rm9200_pdc.h>
>  #include <asm/mach/serial_at91.h>
>  #include <asm/arch/board.h>
> +#ifdef CONFIG_ARM
>  #include <asm/arch/system.h>

I'd rather this file wasn't included in any drivers in any case.

> @@ -611,7 +615,8 @@ static int at91_request_port(struct uart
>  		return -EBUSY;
>  
>  	if (port->flags & UPF_IOREMAP) {
> -		port->membase = ioremap(port->mapbase, size);
> +		if (port->membase == NULL)
> +			port->membase = ioremap(port->mapbase, size);

This change makes no sense.  If you don't want ioremap, don't set UPF_IOREMAP.

>  		if (port->membase == NULL) {
>  			release_mem_region(port->mapbase, size);
>  			return -ENOMEM;
> @@ -693,12 +698,19 @@ static void __devinit at91_init_port(str
>  	port->mapbase	= pdev->resource[0].start;
>  	port->irq	= pdev->resource[1].start;
>  
> +#ifdef CONFIG_AVR32
> +	port->flags |= UPF_IOREMAP;
> +	port->membase = ioremap(pdev->resource[0].start,
> +				pdev->resource[0].end
> +				- pdev->resource[0].start + 1);

Don't see the requirement for this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
