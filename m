Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWIYNCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWIYNCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWIYNCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:02:25 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:37258 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932101AbWIYNCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:02:24 -0400
Date: Mon, 25 Sep 2006 23:02:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux-kernel@vger.kernel.org,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Subject: Re: [PATCH] misc_register error return handling
Message-Id: <20060925230221.ed11c550.sfr@canb.auug.org.au>
In-Reply-To: <1159173781.25016.34.camel@amol.verismonetworks.com>
References: <1159173781.25016.34.camel@amol.verismonetworks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 14:13:01 +0530 Amol Lad <amol@verismonetworks.com> wrote:
>
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

NAK.  (This has been NAKed at least twice - I guess we need to add a
comment - see patch below)  The apm module can still do useful work even
if the misc_register() fails.

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
>  	}
>  	if ((num_online_cpus() > 1) && !power_off && !smp) {
>  		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
>  		apm_info.disabled = 1;
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_misc;
>  	}
>  	if (PM_IS_ACTIVE()) {
>  		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
>  		apm_info.disabled = 1;
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out_misc;
>  	}
>  #ifdef CONFIG_PM_LEGACY
>  	pm_active = 1;
> @@ -2339,7 +2348,8 @@ static int __init apm_init(void)
>  	ret = kernel_thread(apm, NULL, CLONE_KERNEL | SIGCHLD);
>  	if (ret < 0) {
>  		printk(KERN_ERR "apm: disabled - Unable to start kernel thread.\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto out_misc;
>  	}
>  
>  	if (num_online_cpus() > 1 && !smp ) {
> @@ -2348,8 +2358,6 @@ static int __init apm_init(void)
>  		return 0;
>  	}
>  
> -	misc_register(&apm_device);
> -
>  	if (HZ != 100)
>  		idle_period = (idle_period * HZ) / 100;
>  	if (idle_threshold < 100) {
> @@ -2359,6 +2367,9 @@ static int __init apm_init(void)
>  	}
>  
>  	return 0;
> +out_misc:
> +	misc_deregister(&apm_device);
> +	return ret;
>  }

So the rest is unnecessary as well ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

Note that we don't need to check the misc_register() return value in apm.c

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 8591f2f..b74ebf1 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -2348,6 +2348,11 @@ #endif
 		return 0;
 	}
 
+	/*
+	 * We don't check the return value of misc_register() because
+	 * the driver can still do very useful work even without the
+	 * user mode access provided by the misc device.
+	 */
 	misc_register(&apm_device);
 
 	if (HZ != 100)
