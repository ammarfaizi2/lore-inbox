Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVGILxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVGILxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVGILxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:53:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16303 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261228AbVGILx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:53:27 -0400
Date: Sat, 9 Jul 2005 13:52:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [18/48] Suspend2 2.1.9.8 for 2.6.12: 501-tlb-flushing-functions.patch
Message-ID: <20050709115226.GB1878@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164411236@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164411236@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/platforms/pmac_feature.c 510-version-specific-mac.patch-new/arch/ppc/platforms/pmac_feature.c
> --- 510-version-specific-mac.patch-old/arch/ppc/platforms/pmac_feature.c	2005-06-20 11:46:45.000000000 +1000
> +++ 510-version-specific-mac.patch-new/arch/ppc/platforms/pmac_feature.c	2005-07-04 23:14:19.000000000 +1000
> @@ -2291,7 +2291,10 @@ static struct pmac_mb_def pmac_mb_defs[]
>  	},
>  	{	"PowerBook5,1",			"PowerBook G4 17\"",
>  		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
> -		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
> +		PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE
> +#ifdef CONFIG_SOFTWARE_REPLACE_SLEEP
> +		| PMAC_MB_CAN_SLEEP,
> +#endif

There's different number of ","s depending on CONFIG_... Is that ok?



> diff -ruNp 510-version-specific-mac.patch-old/arch/ppc/syslib/of_device.c 510-version-specific-mac.patch-new/arch/ppc/syslib/of_device.c
> --- 510-version-specific-mac.patch-old/arch/ppc/syslib/of_device.c	2004-11-03 21:55:03.000000000 +1100
> +++ 510-version-specific-mac.patch-new/arch/ppc/syslib/of_device.c	2005-07-04 23:14:19.000000000 +1000
> @@ -104,7 +104,7 @@ static int of_device_remove(struct devic
>  	return 0;
>  }
>  
> -static int of_device_suspend(struct device *dev, u32 state)
> +static int of_device_suspend(struct device *dev, pm_message_t state)
>  {
>  	struct of_device * of_dev = to_of_device(dev);
>  	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);

Can I have these separately?

> diff -ruNp 510-version-specific-mac.patch-old/drivers/macintosh/via-pmu.c 510-version-specific-mac.patch-new/drivers/macintosh/via-pmu.c
> --- 510-version-specific-mac.patch-old/drivers/macintosh/via-pmu.c	2005-07-06 11:25:14.000000000 +1000
> +++ 510-version-specific-mac.patch-new/drivers/macintosh/via-pmu.c	2005-07-04 23:14:19.000000000 +1000
> @@ -2894,6 +2894,13 @@ pmu_ioctl(struct inode * inode, struct f
>  			return -EACCES;
>  		if (sleep_in_progress)
>  			return -EBUSY;
> +#ifdef CONFIG_SOFTWARE_REPLACE_SLEEP
> +		{
> +		extern void software_suspend_pending(void);
> +		software_suspend_pending();
> +		return (0);
> +		}
> +#endif
>  		sleep_in_progress = 1;
>  		switch (pmu_kind) {
>  		case PMU_OHARE_BASED:

Indentation? And use return 0; not return (0);

									Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
