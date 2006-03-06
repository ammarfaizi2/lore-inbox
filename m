Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWCFRJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWCFRJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCFRJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:09:28 -0500
Received: from tim.rpsys.net ([194.106.48.114]:16561 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750884AbWCFRJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:09:27 -0500
Subject: Re: [patch] collie: fix missing pcmcia bits
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>, Russell King <rmk@arm.linux.org.uk>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       linux@dominikbrodowski.net, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060306132329.GA1737@elf.ucw.cz>
References: <20060305135351.GA16481@elf.ucw.cz>
	 <1141583008.6521.49.camel@localhost.localdomain>
	 <20060306132329.GA1737@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 17:08:54 +0000
Message-Id: <1141664934.6524.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 14:23 +0100, Pavel Machek wrote:
> Hi!
> 
> This adds missing bits of collie (sharp sl-5500) PCMCIA support and
> MFD support.
>  
> Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

> ---
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> index 6888816..ce2b479 100644
> --- a/arch/arm/mach-sa1100/collie.c
> +++ b/arch/arm/mach-sa1100/collie.c
> @@ -40,6 +40,7 @@
>  #include <asm/hardware/scoop.h>
>  #include <asm/mach/sharpsl_param.h>
>  #include <asm/hardware/locomo.h>
> +#include <asm/arch/mcp.h>
>  
>  #include "generic.h"
>  
> @@ -66,6 +67,32 @@ struct platform_device colliescoop_devic
>  	.resource	= collie_scoop_resources,
>  };
>  
> +static struct scoop_pcmcia_dev collie_pcmcia_scoop[] = {
> +{
> +       .dev        = &colliescoop_device.dev,
> +       .irq        = COLLIE_IRQ_GPIO_CF_IRQ,
> +       .cd_irq     = COLLIE_IRQ_GPIO_CF_CD,
> +       .cd_irq_str = "PCMCIA0 CD",
> +},
> +};
> +
> +static struct scoop_pcmcia_config collie_pcmcia_config = {
> +	.devs         = &collie_pcmcia_scoop[0],
> +	.num_devs     = 1,
> +};
> +
> +
> +static struct mcp_plat_data collie_mcp_data = {
> +	.mccr0          = MCCR0_ADM,
> +	.sclk_rate      = 11981000,
> +};
> +
> +
> +static struct sa1100_port_fns collie_port_fns __initdata = {
> +	.set_mctrl	= collie_uart_set_mctrl,
> +	.get_mctrl	= collie_uart_get_mctrl,
> +};
> +
>  
>  static struct resource locomo_resources[] = {
>  	[0] = {
> @@ -153,12 +246,14 @@ static void __init collie_init(void)
>  		 PPC_LDD6 | PPC_LDD7 | PPC_L_PCLK | PPC_L_LCLK | PPC_L_FCLK | PPC_L_BIAS | \
>  	 	 PPC_TXD1 | PPC_TXD2 | PPC_RXD2 | PPC_TXD3 | PPC_TXD4 | PPC_SCLK | PPC_SFRM );
>  
>  	PSDR = ( PPC_RXD1 | PPC_RXD2 | PPC_RXD3 | PPC_RXD4 );
>  
>  	GAFR |= GPIO_32_768kHz;
>  	GPDR |= GPIO_32_768kHz;
>  	TUCR  = TUCR_32_768kHz;
>  
> +	platform_scoop_config = &collie_pcmcia_config;
> +
>  	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
>  	if (ret) {
>  		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
> @@ -166,6 +302,7 @@ static void __init collie_init(void)
>  
>  	sa11x0_set_flash_data(&collie_flash_data, collie_flash_resources,
>  			      ARRAY_SIZE(collie_flash_resources));
> +	sa11x0_set_mcp_data(&collie_mcp_data);
>  
>  	sharpsl_save_param();
>  }
> 
> 

