Return-Path: <linux-kernel-owner+w=401wt.eu-S1422982AbWLURZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422982AbWLURZJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWLURZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:25:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54315 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422982AbWLURZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:25:07 -0500
Date: Thu, 21 Dec 2006 12:25:06 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
In-reply-to: <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Message-id: <Pine.LNX.4.64.0612211205530.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200611111541.34699.david-b@pacbell.net>
 <200612201312.36616.david-b@pacbell.net>
 <20061220221252.732f4e97.akpm@osdl.org>
 <200612202244.03351.david-b@pacbell.net>
 <Pine.LNX.4.64.0612210925130.18171@xanadu.home>
 <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006, pHilipp Zabel wrote:

> David suggested to have both inline and non-inline functions depending
> on whether gpio is constant. How is this patch?

More comments below.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/include/asm-arm/arch-pxa/gpio.h	2006-12-21
> 07:57:12.000000000 +0100
> @@ -0,0 +1,86 @@
[...]
> +static inline int gpio_direction_input(unsigned gpio)
> +{
> +	if (gpio > PXA_LAST_GPIO)
> +		return -EINVAL;
> +	pxa_gpio_mode(gpio | GPIO_IN);
> +}
> +
> +static inline int gpio_direction_output(unsigned gpio)
> +{
> +	if (gpio > PXA_LAST_GPIO)
> +		return -EINVAL;
> +	pxa_gpio_mode(gpio | GPIO_OUT);
> +}

Please push this test against PXA_LAST_GPIO inside pxa_gpio_mode().  It 
has no advantage to be inline if you're about to call a function anyway.  
That would make pxa_gpio_mode() more reliable for those not calling it 
through the generic API wrt that kind of error as well.

> --- linux-2.6.orig/arch/arm/mach-pxa/generic.c	2006-12-16
> +++ linux-2.6/arch/arm/mach-pxa/generic.c	2006-12-16 16:47:45.000000000
> @@ -129,6 +129,29 @@
> EXPORT_SYMBOL(pxa_gpio_mode);
> 
> /*
> + * Return GPIO level, nonzero means high, zero is low
> + */
> +int pxa_gpio_get_value(unsigned gpio)
> +{
> +	return GPLR(gpio) & GPIO_bit(gpio);
> +}
> +
> +EXPORT_SYMBOL(pxa_gpio_get_value);
> +
> +/*
> + * Set output GPIO level
> + */
> +void pxa_gpio_set_value(unsigned gpio, int value)
> +{
> +	if (value)
> +		GPSR(gpio) = GPIO_bit(gpio);
> +	else
> +		GPCR(gpio) = GPIO_bit(gpio);
> +}
> +
> +EXPORT_SYMBOL(pxa_gpio_set_value);

Instead of duplicating code here, you probably should just reuse 
__gpio_set_value() and __gpio_get_value() inside those functions.


Nicolas
