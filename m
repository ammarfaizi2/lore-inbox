Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVIUTRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVIUTRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVIUTRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:17:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12555 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751379AbVIUTRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:17:46 -0400
Date: Wed, 21 Sep 2005 20:17:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pantelis Antoniou <pantelis@embeddedalley.com>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Au1x00 8250 uart support (Updated - take #2).
Message-ID: <20050921191737.GA13246@flint.arm.linux.org.uk>
Mail-Followup-To: Pantelis Antoniou <pantelis@embeddedalley.com>,
	linux-kernel@vger.kernel.org, cw@f00f.org,
	Pete Popov <ppopov@embeddedalley.com>,
	Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
References: <200509192340.10450.pantelis@embeddedalley.com> <200509202050.03979.pantelis@embeddedalley.com> <20050921071111.GA12590@flint.arm.linux.org.uk> <200509211914.10460.pantelis@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509211914.10460.pantelis@embeddedalley.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 07:14:09PM +0300, Pantelis Antoniou wrote:
> > This is also buggy - the problem this has is that although you're
> > unregistering the platform device, references can still remain after
> > the module has been unloaded.  This means you have two options:
> > 
> > 1. never allow code with statically allocated platform devices to be
> >    modules.
> > 2. use something like platform_device_register_simple() (which doesn't
> >    currently exist in a useful form for devices with platform data.)
> > 
> 
> Yes, this is stinking mess. I resorted to just not allowing a module build.
> 
> BTW, the current platform_device_register_simple suffers from the same bug.
> 
> ! struct platform_device *platform_device_register_simple(char *name, unsigned int id,
> !                                                         struct resource *res, unsigned int num)
> !
> 
> later on in the function body we have...
> 
> !         pobj->pdev.name = name;
> 
> It's clearly buggy, since the typical calling sequence passes a constant
> string as a 'name' argument, which is located in the read only segment
> of the module (.text or .rodata).
> 
> To fix this space for the name must be allocated just like the resources...

Is this true?  platform_device_register uses pdev.name to construct the
bus id.  pdev.name is also used when matching against drivers.

However, once a platform device is unregistered, it is no longer available
to be matched against drivers, so pdev.name is unused.  Therefore, I don't
think this is a problem.

> +#ifdef CONFIG_SERIAL_8250_AU1X00_MODULE
> +#error This file can not yet be compiled as a module.
> +#endif

This isn't how we prevent modular builds...

> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -207,6 +207,14 @@ config SERIAL_8250_ACORN
>  	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
>  	  cards.  If unsure, say N.
>  
> +config SERIAL_8250_AU1X00
> +	tristate "AU1X00 serial port support"

We prevent them by setting this to 'bool'.

> +	depends on SOC_AU1X00 && SERIAL_8250

It doens't really depend on SERIAL_8250 - it can live independently of it.
However, it can be built in when SERIAL_8250 isn't, so this dependency
should be SERIAL_8250 != n.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
