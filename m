Return-Path: <linux-kernel-owner+w=401wt.eu-S1755134AbWL3DPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbWL3DPd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 22:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWL3DPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 22:15:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9817 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134AbWL3DPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 22:15:32 -0500
Date: Fri, 29 Dec 2006 22:15:31 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
In-reply-to: <200612291821.44675.david-b@pacbell.net>
X-X-Sender: nico@xanadu.home
To: David Brownell <david-b@pacbell.net>
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Message-id: <Pine.LNX.4.64.0612292141440.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200611111541.34699.david-b@pacbell.net>
 <20061220221328.ee3bfc5d.akpm@osdl.org>
 <74d0deb30612212316i12090ca0hfe8524a80f63475a@mail.gmail.com>
 <200612291821.44675.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006, David Brownell wrote:

> Here's a version that compiles ...

This patch is completely broken.

> Arch-neutral GPIO calls for PXA.

This is not PXA but SA1100 to start with.

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Index: pxa/include/asm-arm/arch-sa1100/gpio.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ pxa/include/asm-arm/arch-sa1100/gpio.h	2006-12-29 
> 18:21:00.000000000 -0800
> @@ -0,0 +1,100 @@

[...]

> +static inline int gpio_direction_input(unsigned gpio)
> +{
> +	if (gpio > GPIO_MAX)
> +		return -EINVAL;
> +	GPDR = (GPDR_In << gpio);

This is crap.  It will expand to GPDR = 0 effectively making _all_ gpios 
as input.

What you want here is:

	GPDR &= ~(1 << gpio);

and you most probably need to protect the implied read-modify-write 
cycle with a spinlock unless the generic gpio API expects this 
protection is the responsibility of the caller.

> +static inline int gpio_direction_output(unsigned gpio)
> +{
> +	if (gpio > GPIO_MAX)
> +		return -EINVAL;
> +	GPDR = (GPDR_Out << gpio);

Same issue, although this would make all gpios as input except for the 
specified one.

What you want is:

	GPDR |= (1 << gpio);

And again spinlock protection is probably needed.

> +static inline int __gpio_get_value(unsigned gpio)
> +{
> +	return GPLR & GPIO_GPIO(gpio);
> +}
> +
> +#define gpio_get_value(gpio)			\
> +	(__builtin_constant_p(gpio)		\
> +	? __gpio_get_value(gpio)		\
> +	: sa1100_gpio_get_value(gpio))
> +

Please drop the out of line version.  It will always be more costly than 
the inline version even for non constant gpio values.  And I think the 
usage of GPIO_GPIO(gpio) is more obfuscating than directly using
(1 << gpio).

> +static inline void __gpio_set_value(unsigned gpio, int value)
> +{
> +	if (value)
> +		GPSR = GPIO_GPIO(gpio);
> +	else
> +		GPCR = GPIO_GPIO(gpio);
> +}
> +
> +#define gpio_set_value(gpio,value)		\
> +	(__builtin_constant_p(gpio)		\
> +	? __gpio_set_value(gpio, value)		\
> +	: sa1100_gpio_set_value(gpio, value))

Same as above.


Nicolas
