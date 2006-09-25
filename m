Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWIYLTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWIYLTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWIYLTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:19:10 -0400
Received: from aun.it.uu.se ([130.238.12.36]:48575 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751158AbWIYLTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:19:09 -0400
Date: Mon, 25 Sep 2006 13:18:27 +0200 (MEST)
Message-Id: <200609251118.k8PBIRec000783@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: amol@verismonetworks.com, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc_register error return handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 14:29:00 +0530, Amol Lad wrote:
> diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/arch/i386/kernel/apm.c linux-2.6.18/arch/i386/kernel/apm.c
> --- linux-2.6.18-orig/arch/i386/kernel/apm.c	2006-09-21 10:15:25.000000000 +0530
> +++ linux-2.6.18/arch/i386/kernel/apm.c	2006-09-25 13:59:53.000000000 +0530
> @@ -2246,6 +2246,12 @@ static int __init apm_init(void)
>  		return -ENODEV;
>  	}
>  
> +	ret = misc_register(&apm_device);
> +	if (ret != 0) {
> +		printk(KERN_ERR "apm: cannot register misc device.\n");
> +		return ret;
> +	}
> +
>  	if (allow_ints)
>  		apm_info.allow_ints = 1;
>  	if (broken_psr)
> @@ -2282,17 +2288,20 @@ static int __init apm_init(void)
>  
>  	if (apm_info.disabled) {
>  		printk(KERN_NOTICE "apm: disabled on user request.\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_misc;

etc

NAK on the APM changes. APM can do its work just fine even if
it failed to register a device file; it will just lack some
user interface/control bits.

> @@ -2348,8 +2358,6 @@ static int __init apm_init(void)
>  		return 0;
>  	}
>  
> -	misc_register(&apm_device);
> -

This should just print a warning (but not fail) if misc_register()
returned failure.

/Mikael
