Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289014AbSAFTfU>; Sun, 6 Jan 2002 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSAFTfO>; Sun, 6 Jan 2002 14:35:14 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:45987 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289014AbSAFTfD>; Sun, 6 Jan 2002 14:35:03 -0500
Date: Sun, 6 Jan 2002 12:34:49 -0700
Message-Id: <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Matt Dainty <matt@bodgit-n-scarper.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Dainty writes:
> Please find attached a patch to add support for devfs to the i386 cpuid and
> msr drivers. Not only that, but it fixes a problem with loading these
> drivers as modules in that the exit hooks on the module never run, (simply
> changing the function prototypes to include 'static' seems to fix this).
> 
> Patch is against 2.4.17. SMP environment isn't tested, but I can't see any
> reason why it wouldn't work...

Looks mostly reasonable, except for:

> -void __exit cpuid_exit(void)
> +static void __exit cpuid_exit(void)
>  {
> -  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
> +  int i;
> +  devfs_handle_t parent;
> +
> +  for(i = 0; i < NR_CPUS; i++) {
> +    parent = devfs_get_parent(devfs_handle[i]);
> +    devfs_unregister(devfs_handle[i]);
> +    if(devfs_get_first_child(parent) == NULL)
> +      devfs_unregister(parent);
> +  }
> +  devfs_unregister_chrdev(CPUID_MAJOR, "cpu/%d/cpuid");
>  }

There is no need to remove the parent /dev/cpu/%d directory, and in
fact it's better not to. All you need is this simpler loop:
	for(i = 0; i < NR_CPUS; i++)
		devfs_unregister(devfs_handle[i]);

You do something similar in the MSR driver.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
