Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWAPW10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWAPW10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWAPW10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:27:26 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:48026 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751046AbWAPW10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:27:26 -0500
In-Reply-To: <20060111065752.245711000.dtor_core@ameritech.net>
References: <20060111064746.560312000.dtor_core@ameritech.net> <20060111065752.245711000.dtor_core@ameritech.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <78070C28-51BD-4372-B94E-785358E8752E@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device interface
Date: Mon, 16 Jan 2006 16:27:17 -0600
To: Dmitry Torokhov <dtor_core@ameritech.net>
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

This patch is breaking arch/ppc & arch/powerpc usage of 8250.c.  The  
issue appears to be with the order in which platform_driver_register 
() is called vs platform_device_add().

arch/powerpc/kernel/legacy_serial.c registers an 8250 device on the  
platform bus before 8250_init() gets called.

Changing the order of platform_driver_register() vs  
platform_device_add() fixes the issue.  I'm still not sure what the  
correct solution to this is. Ideas? comments?

- kumar

On Jan 11, 2006, at 12:47 AM, Dmitry Torokhov wrote:

> serial8250: convert to the new platform device interface
>
> Do not use platform_device_register_simple() as it is going away.
> Also set up driver's owner to create link driver->module in sysfs.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>  drivers/serial/8250.c |   30 ++++++++++++++++++++----------
>  1 files changed, 20 insertions(+), 10 deletions(-)
>
> Index: work/drivers/serial/8250.c
> ===================================================================
> --- work.orig/drivers/serial/8250.c
> +++ work/drivers/serial/8250.c
> @@ -2453,6 +2453,7 @@ static struct platform_driver serial8250
>  	.resume		= serial8250_resume,
>  	.driver		= {
>  		.name	= "serial8250",
> +		.owner	= THIS_MODULE,
>  	},
>  };
>
> @@ -2593,21 +2594,30 @@ static int __init serial8250_init(void)
>  	if (ret)
>  		goto out;
>
> -	serial8250_isa_devs = platform_device_register_simple("serial8250",
> -					 PLAT8250_DEV_LEGACY, NULL, 0);
> -	if (IS_ERR(serial8250_isa_devs)) {
> -		ret = PTR_ERR(serial8250_isa_devs);
> -		goto unreg;
> +	ret = platform_driver_register(&serial8250_isa_driver);
> +	if (ret)
> +		goto unreg_uart_drv;
> +
> +	serial8250_isa_devs = platform_device_alloc("serial8250",
> +						    PLAT8250_DEV_LEGACY);
> +	if (!serial8250_isa_devs) {
> +		ret = -ENOMEM;
> +		goto unreg_plat_drv;
>  	}
>
> +	ret = platform_device_add(serial8250_isa_devs);
> +	if (ret)
> +		goto put_dev;
> +
>  	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs- 
> >dev);
>
> -	ret = platform_driver_register(&serial8250_isa_driver);
> -	if (ret == 0)
> -		goto out;
> +	goto out;
>
> -	platform_device_unregister(serial8250_isa_devs);
> - unreg:
> + put_dev:
> +	platform_device_put(serial8250_isa_devs);
> + unreg_plat_drv:
> +	platform_driver_unregister(&serial8250_isa_driver);
> + unreg_uart_drv:
>  	uart_unregister_driver(&serial8250_reg);
>   out:
>  	return ret;
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

