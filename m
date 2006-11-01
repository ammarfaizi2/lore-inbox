Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946063AbWKAGpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946063AbWKAGpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946069AbWKAGpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:45:23 -0500
Received: from 1wt.eu ([62.212.114.60]:517 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1946063AbWKAGpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:45:22 -0500
Date: Wed, 1 Nov 2006 08:45:25 +0100
From: Willy Tarreau <w@1wt.eu>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 45/61] Watchdog: sc1200wdt - fix missing pnp_unregister_driver()
Message-ID: <20061101074525.GD543@1wt.eu>
References: <20061101053340.305569000@sous-sol.org> <20061101054331.907620000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101054331.907620000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:34:25PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> [WATCHDOG] sc1200wdt.c pnp unregister fix.
> 
> If no devices found or invalid parameter is specified,
> scl200wdt_pnp_driver is left unregistered.
> It breaks global list of pnp drivers.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> ---
>  drivers/char/watchdog/sc1200wdt.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.18.1.orig/drivers/char/watchdog/sc1200wdt.c
> +++ linux-2.6.18.1/drivers/char/watchdog/sc1200wdt.c
> @@ -392,7 +392,7 @@ static int __init sc1200wdt_init(void)
>  	if (io == -1) {
>  		printk(KERN_ERR PFX "io parameter must be specified\n");
>  		ret = -EINVAL;
> -		goto out_clean;
> +		goto out_pnp;
>  	}
>  
>  #if defined CONFIG_PNP
> @@ -405,7 +405,7 @@ static int __init sc1200wdt_init(void)
>  	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {
>  		printk(KERN_ERR PFX "Unable to register IO port %#x\n", io);
>  		ret = -EBUSY;
> -		goto out_clean;
> +		goto out_pnp;
>  	}
>  
>  	ret = sc1200wdt_probe();
> @@ -435,6 +435,11 @@ out_rbt:
>  out_io:
>  	release_region(io, io_len);
>  
> +out_pnp:
> +#if defined CONFIG_PNP
> +	if (isapnp)
> +		pnp_unregister_driver(&scl200wdt_pnp_driver);
> +#endif
>  	goto out_clean;
>  }

The first hunk seems to be valid for 2.4 too. The 2nd and 3rd ones
were already in 2.4. Wim, I'm going to merge it. No objection ?

Willy

