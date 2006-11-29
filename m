Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967203AbWK2OQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967203AbWK2OQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967204AbWK2OQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:16:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60939 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S967203AbWK2OQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:16:10 -0500
Date: Wed, 29 Nov 2006 14:15:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mike Galbraith <efault@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc patch] Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061129141551.GB5740@ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org> <1164463898.6221.24.camel@Homer.simpson.net> <200611251812.53246.rjw@sisk.pl> <1164516833.6543.0.camel@Homer.simpson.net> <1164708110.6021.12.camel@Homer.simpson.net> <1164795696.6147.2.camel@Homer.simpson.net> <1164796231.6147.12.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164796231.6147.12.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Wed, 2006-11-29 at 11:21 +0100, Mike Galbraith wrote:
> > > The serial console appears to be innocent.  The suspend/resume methods
> > > for my 16550A serial port aren't even being _called_, apparently because
> > > pnp swiped ttyS0.
> 
> (ahem, bad aim with mouse, resuming)
> 
> Well, after further rummaging, the suspend/resume methods aren't being
> called because we're using 8250_pnp.c when CONFIG_PNP is set, and it
> doesn't have any :)  The below works for me, though I'm not sure it's
> sufficient.  If it is deemed sufficient, I'll submit it to Andrew.
> 
> Add suspend/resume methods to 8250_pnp driver.

Patch looks okay to me... care to sign-it-off and submit it to akpm?

							Pavel

> --- linux-2.6.19-rc6-mm2/drivers/serial/8250_pnp.c.org	2006-11-29 07:14:15.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/drivers/serial/8250_pnp.c	2006-11-29 10:55:17.000000000 +0100
> @@ -464,11 +464,38 @@ static void __devexit serial_pnp_remove(
>  		serial8250_unregister_port(line - 1);
>  }
>  
> +#ifdef CONFIG_PM
> +static int serial_pnp_suspend(struct pnp_dev *dev, pm_message_t state)
> +{
> +	long line = (long)pnp_get_drvdata(dev);
> +
> +	if (!line)
> +		return -ENODEV;
> +	serial8250_suspend_port(line - 1);
> +	return 0;
> +}
> +
> +static int serial_pnp_resume(struct pnp_dev *dev)
> +{
> +	long line = (long)pnp_get_drvdata(dev);
> +
> +	if (!line)
> +		return -ENODEV;
> +	serial8250_resume_port(line - 1);
> +	return 0;
> +}
> +
> +#endif /* CONFIG_PM */
> +
>  static struct pnp_driver serial_pnp_driver = {
>  	.name		= "serial",
> -	.id_table	= pnp_dev_table,
>  	.probe		= serial_pnp_probe,
>  	.remove		= __devexit_p(serial_pnp_remove),
> +#ifdef CONFIG_PM
> +	.suspend	= serial_pnp_suspend,
> +	.resume		= serial_pnp_resume,
> +#endif
> +	.id_table	= pnp_dev_table,
>  };
>  
>  static int __init serial8250_pnp_init(void)
> 
> 
> 
> 
> 

-- 
Thanks for all the (sleeping) penguins.
