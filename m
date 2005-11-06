Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVKFIYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVKFIYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVKFIYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:24:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2825 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932327AbVKFIYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 03:24:37 -0500
Date: Sun, 6 Nov 2005 08:24:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, castet.matthieu@free.fr
Subject: Re: [PATCH] tpm: Fix lack of driver_unregister in init failcases
Message-ID: <20051106082425.GA25134@flint.arm.linux.org.uk>
Mail-Followup-To: Kylene Jo Hall <kjhall@us.ibm.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	castet.matthieu@free.fr
References: <1130769492.4882.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130769492.4882.37.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 08:38:12AM -0600, Kylene Jo Hall wrote:
> driver_unregister is not being properly called when the init function
> returns an error case.  Restructured the return logic such that this and
> the other cleanups all happen in one place.  Preformed many of the
> cleanups that Andrew Morton's patch on Thursday made in tpm_atmel.c.  
> Fixed Matthieu's concern about writing before discovery.
> 
> Signed-off-by: Kylene Hall
> ---
> --- linux-2.6.14-rc4/drivers/char/tpm/tpm_nsc.c	2005-10-28 15:04:47.000000000 +0200
> +++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm_nsc.c	2005-10-28 14:59:10.000000000 +0200
> @@ -286,8 +286,4 @@ static int __init init_nsc(void)
>  	int lo, hi;
>  	int nscAddrBase = TPM_ADDR;
>  
> -	driver_register(&nsc_drv);
> -
> - 	/* select PM channel 1 */
> -	tpm_write_index(nscAddrBase,NSC_LDN_INDEX, 0x12);
>  
> @@ -299,6 +297,8 @@ static int __init init_nsc(void)
>  			return -ENODEV;
>  	}
>  
> +	driver_register(&nsc_drv);
> +
>  	hi = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_HI);
>  	lo = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_LO);
>  	tpm_nsc.base = (hi<<8) | lo;
> @@ -306,38 +306,28 @@ static int __init init_nsc(void)
>  	/* enable the DPM module */
>  	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
>  
> -	pdev = kmalloc(sizeof(struct platform_device), GFP_KERNEL);
> -	if ( !pdev ) 
> -		return -ENOMEM;
> -
> -	memset(pdev, 0, sizeof(struct platform_device));
> +	pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
> +	if ( !pdev ) { 
> +		rc = -ENOMEM;
> +		goto err_unreg_drv;
> +	}
>  
>  	pdev->name = "tpm_nscl0";
>  	pdev->id = -1;
>  	pdev->num_resources = 0;
> -	pdev->dev.release = tpm_nsc_remove;	
> +	pdev->dev.release = tpm_nsc_remove;

This driver is buggy.  You must not provide your own release function -
it doesn't solve the problem which the warning (which you get when you
don't provide one) is telling you about.

You should convert your device driver over to the replacement dynamic
platform support, once it is merged.  IOW, something like:

        pdev = platform_device_alloc("mydev", id);
        if (pdev) {
                err = platform_device_add_resources(pdev, &resources,
                                                    ARRAY_SIZE(resources));
                if (err == 0)
                        err = platform_device_add_data(pdev, &platform_data,
                                                       sizeof(platform_data));
                if (err == 0)
                        err = platform_device_add(pdev);
        } else {
                err = -ENOMEM;
        }
        if (err)
                platform_device_put(pdev);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
