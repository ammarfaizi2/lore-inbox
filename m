Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933356AbWK0Ujv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbWK0Ujv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933390AbWK0Ujv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:39:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:32588 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S933356AbWK0Uju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:39:50 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,464,1157353200"; 
   d="scan'208"; a="20268599:sNHT19494432"
Date: Mon, 27 Nov 2006 12:34:52 -0800
From: Mark Gross <mgross@linux.intel.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>, akpm@osdl.org
Subject: Re: [PATCH] tlclk: fix platform_device_register_simple() error check
Message-ID: <20061127203452.GA12279@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20061122184111.GC2985@APFDCB5C>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122184111.GC2985@APFDCB5C>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 03:41:11AM +0900, Akinobu Mita wrote:
> The return value of platform_device_register_simple() should be
> checked by IS_ERR().
> 
> This patch also fix misc_register() error case. Because misc_register()
> returns error code.
> 
> Cc: Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> ---
>  drivers/char/tlclk.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: work-fault-inject/drivers/char/tlclk.c
> ===================================================================
> --- work-fault-inject.orig/drivers/char/tlclk.c
> +++ work-fault-inject/drivers/char/tlclk.c
> @@ -792,15 +792,14 @@ static int __init tlclk_init(void)
>  	ret = misc_register(&tlclk_miscdev);
>  	if (ret < 0) {
>  		printk(KERN_ERR "tlclk: misc_register returns %d.\n", ret);
> -		ret = -EBUSY;

results in an non-error return when there this device isn't on the
system.

* NAK *
>  		goto out3;
>  	}
>  
>  	tlclk_device = platform_device_register_simple("telco_clock",
>  				-1, NULL, 0);
> -	if (!tlclk_device) {
> +	if (IS_ERR(tlclk_device)) {
ok

>  		printk(KERN_ERR "tlclk: platform_device_register failed.\n");
> -		ret = -EBUSY;
> +		ret = PTR_ERR(tlclk_device);

I don't know about this but I could be wrong.  Please convince me.

>  		goto out4;
>  	}
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
