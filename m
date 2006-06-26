Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWFZAff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWFZAff (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWFZAff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:35:35 -0400
Received: from xenotime.net ([66.160.160.81]:62157 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964960AbWFZAfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:35:34 -0400
Date: Sun, 25 Jun 2006 17:38:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       phelps@gnusto.com
Subject: Re: [ patch -mm ]  GTOD: add-scx200-hrt-clocksource.diff
Message-Id: <20060625173820.20ba5d78.rdunlap@xenotime.net>
In-Reply-To: <449F07C4.5030805@gmail.com>
References: <449F07C4.5030805@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 16:01:40 -0600 Jim Cromie wrote:

> $ diffstat add-scx200-hrt-clocksource.diff
>  arch/i386/Kconfig                |   24 ++++++---
>  drivers/clocksource/Makefile     |    5 +
>  drivers/clocksource/scx200_hrt.c |  101 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 9 deletions(-)
> 
> ---
> 
> diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-mm2/arch/i386/Kconfig linux-2.6.17-mm2-hrt-sk/arch/i386/Kconfig
> --- linux-2.6.17-mm2/arch/i386/Kconfig	2006-06-25 01:09:56.000000000 -0600
> +++ linux-2.6.17-mm2-hrt-sk/arch/i386/Kconfig	2006-06-25 07:48:18.000000000 -0600
> @@ -1073,13 +1073,23 @@ config SCx200
>  	tristate "NatSemi SCx200 support"
>  	depends on !X86_VOYAGER
>  	help
> -	  This provides basic support for the National Semiconductor SCx200
> -	  processor.  Right now this is just a driver for the GPIO pins.
> -
> -	  If you don't know what to do here, say N.
> -
> -	  This support is also available as a module.  If compiled as a
> -	  module, it will be called scx200.
> +	  This provides basic support for National Semiconductor's
> +	  (now AMD's) Geode processors.  The driver probes for the
> +	  PCI-IDs of several on-chip devices, so its a good dependency
                                                 it's
> +	  for other scx200_* drivers.
> +
> +	  If compiled as a module, the driver is named scx200.
> +
> +config SCx200HR_TIMER
> +	tristate "NatSemi SCx200 27MHz High-Resolution Timer Support"
> +	depends on SCx200 && GENERIC_TIME
> +	default y
> +	help
> +	  This driver provides a clocksource built upon the on-chip
> +	  27MHz high-resolution timer.  Its also a workaround for
                                        It's
> +	  NSC Geode SC-1100's buggy TSC, which loses time when the
> +	  processor goes idle (as is done by the scheduler).  The
> +	  other workaround is idle=poll boot option.
>  
>  config K8_NB
>  	def_bool y

> diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-mm2/drivers/clocksource/scx200_hrt.c linux-2.6.17-mm2-hrt-sk/drivers/clocksource/scx200_hrt.c
> --- linux-2.6.17-mm2/drivers/clocksource/scx200_hrt.c	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.17-mm2-hrt-sk/drivers/clocksource/scx200_hrt.c	2006-06-25 07:48:18.000000000 -0600
> @@ -0,0 +1,101 @@
> +/*
> + * Copyright (C) 2006 Jim Cromie
> + *
> +
> +static int mhz27;
> +module_param(mhz27, int, 0);	/* load time only */
> +MODULE_PARM_DESC(mhz27, "count at 27.0 MHz (default is 1.0 MHz)\n");

Don't need the newline.  Please drop it.

> +static int ppm;
> +module_param(ppm, int, 0);	/* load time only */
> +MODULE_PARM_DESC(ppm, "+-adjust to actual XO freq (ppm)\n");

Ditto.

> +static int __init init_hrt_clocksource(void)
> +{
> +	/* Make sure scx200 has initd the configuration block */

I expect some people won't know what "initd" is.
Please write it for other people to read.

> +	if (!scx200_cb_present())
> +		return -ENODEV;

---
~Randy
