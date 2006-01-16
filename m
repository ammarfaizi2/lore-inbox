Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWAQACJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWAQACJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWAQACJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:02:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:1200 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751304AbWAQACI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:02:08 -0500
Date: Mon, 16 Jan 2006 17:54:28 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Kumar Gala <galak@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device
 interface
In-Reply-To: <20060116233143.GB23097@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Russell King wrote:

> On Mon, Jan 16, 2006 at 04:27:17PM -0600, Kumar Gala wrote:
> > This patch is breaking arch/ppc & arch/powerpc usage of 8250.c.  The  
> > issue appears to be with the order in which platform_driver_register 
> > () is called vs platform_device_add().
> > 
> > arch/powerpc/kernel/legacy_serial.c registers an 8250 device on the  
> > platform bus before 8250_init() gets called.
> > 
> > Changing the order of platform_driver_register() vs  
> > platform_device_add() fixes the issue.  I'm still not sure what the  
> > correct solution to this is. Ideas? comments?
> 
> Mea Culpa - should've spotted that - that patch is actually rather
> broken.  platform_driver_register() can't be moved from where it
> initially was.

This seems to fix my issue on arch/powerpc and arch/ppc, please push to 
Linus ASAP.

thanks

- kumar

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2595,15 +2595,11 @@ static int __init serial8250_init(void)
>  	if (ret)
>  		goto out;
>  
> -	ret = platform_driver_register(&serial8250_isa_driver);
> -	if (ret)
> -		goto unreg_uart_drv;
> -
>  	serial8250_isa_devs = platform_device_alloc("serial8250",
>  						    PLAT8250_DEV_LEGACY);
>  	if (!serial8250_isa_devs) {
>  		ret = -ENOMEM;
> -		goto unreg_plat_drv;
> +		goto unreg_uart_drv;
>  	}
>  
>  	ret = platform_device_add(serial8250_isa_devs);
> @@ -2612,12 +2608,13 @@ static int __init serial8250_init(void)
>  
>  	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
>  
> -	goto out;
> +	ret = platform_driver_register(&serial8250_isa_driver);
> +	if (ret == 0)
> +		goto out;
>  
> +	platform_device_del(serial8250_isa_devs);
>   put_dev:
>  	platform_device_put(serial8250_isa_devs);
> - unreg_plat_drv:
> -	platform_driver_unregister(&serial8250_isa_driver);
>   unreg_uart_drv:
>  	uart_unregister_driver(&serial8250_reg);
>   out:
> 
> 
> 

