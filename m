Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264072AbUEXGqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUEXGqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEXGqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:46:13 -0400
Received: from may.priocom.com ([213.156.65.50]:10382 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S264088AbUEXGpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:45:07 -0400
Subject: Re: memory leaks in 2.6.6...
From: Yury Umanets <torque@ukrpost.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040523132935.150d70cc.akpm@osdl.org>
References: <1085336681.11461.9.camel@firefly.localdomain>
	 <20040523132935.150d70cc.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085381022.3452.1.camel@firefly.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 May 2004 09:43:42 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-23 at 23:29, Andrew Morton wrote:
> Yury Umanets <torque@ukrpost.net> wrote:
> >
> > Thanks to smatch I have found few memory leaks and other related issues
> >  in 2.6.6. See the patch in attachment.
> 
> Looks OK, thanks.  I tweaked a few things:
> 
> - Various places had eight-spaces where a tab was itended.
> 
> - kfree() handles NULL pointers so we don't need to test for that before
>   calling kfree().
> 
> - Instead of:
> 
> 	foo()
> 	{
> 		char *p;
> 
> 		...
> 		p = kmalloc(..);
> 		...
> 		if (whatever) {
> 			kfree(p);
> 			goto out;
> 		}
> 		...
> 	out:
> 		return stuff;
> 	}
> 
>   it's tidier to do:
> 
> 	foo()
> 	{
> 		char *p = NULL;
> 
> 		...
> 		p = kmalloc(..);
> 		...
> 		if (whatever)
> 			goto out;
> 		...
> 	out:
> 		kfree(p);
> 		return stuff;
> 	}
> 
>   This is perhaps a tiny bit less efficient but it's a construct which
>   won't break or leak if people change things later on.
> 
> - In future, please prepare separate patches.  It's a bit weird having a
>   patch which touches fbdev, irda, usb and cpufreq.
> 
Ok, I see, next time will do :) Thanks.

> 
> 
>  25-akpm/arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    4 +-
>  25-akpm/drivers/usb/input/hiddev.c                 |    2 -
>  25-akpm/drivers/usb/misc/emi26.c                   |    2 -
>  25-akpm/drivers/usb/misc/emi62.c                   |    2 +
>  25-akpm/drivers/video/aty/atyfb_base.c             |   37 +++++++++++++--------
>  25-akpm/net/irda/ircomm/ircomm_tty.c               |    6 ++-
>  6 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff -puN arch/i386/kernel/cpu/cpufreq/powernow-k8.c~fix-various-memory-leaks arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> --- 25/arch/i386/kernel/cpu/cpufreq/powernow-k8.c~fix-various-memory-leaks	2004-05-23 13:18:16.698239552 -0700
> +++ 25-akpm/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-05-23 13:22:22.640850592 -0700
> @@ -681,7 +681,7 @@ static int powernow_k8_cpu_init_acpi(str
>  {
>  	int i;
>  	int cntlofreq = 0;
> -	struct cpufreq_frequency_table *powernow_table;
> +	struct cpufreq_frequency_table *powernow_table = NULL;
>  
>  	if (acpi_processor_register_performance(&data->acpi_data, data->cpu)) {
>  		dprintk(KERN_DEBUG PFX "register performance failed\n");
> @@ -762,7 +762,7 @@ err_out:
>  
>  	/* data->acpi_data.state_count informs us at ->exit() whether ACPI was used */
>  	data->acpi_data.state_count = 0;
> -                                                                                                            
> +	kfree(powernow_table);
>  	return -ENODEV;
>  }
>  
> diff -puN drivers/usb/input/hiddev.c~fix-various-memory-leaks drivers/usb/input/hiddev.c
> --- 25/drivers/usb/input/hiddev.c~fix-various-memory-leaks	2004-05-23 13:18:16.699239400 -0700
> +++ 25-akpm/drivers/usb/input/hiddev.c	2004-05-23 13:18:16.711237576 -0700
> @@ -612,7 +612,7 @@ static int hiddev_ioctl(struct inode *in
>  		uref = &uref_multi->uref;
>  		if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
>  			if (copy_from_user(uref_multi, (void *) arg, 
> -					   sizeof(uref_multi)))
> +					   sizeof(*uref_multi)))
>  				goto fault;
>  		} else {
>  			if (copy_from_user(uref, (void *) arg, sizeof(*uref)))
> diff -puN drivers/usb/misc/emi26.c~fix-various-memory-leaks drivers/usb/misc/emi26.c
> --- 25/drivers/usb/misc/emi26.c~fix-various-memory-leaks	2004-05-23 13:18:16.701239096 -0700
> +++ 25-akpm/drivers/usb/misc/emi26.c	2004-05-23 13:18:16.712237424 -0700
> @@ -194,7 +194,7 @@ static int emi26_load_firmware (struct u
>  
>  	/* return 1 to fail the driver inialization
>  	 * and give real driver change to load */
> -	return 1;
> +	err = 1;
>  
>  wraperr:
>  	kfree(buf);
> diff -puN drivers/usb/misc/emi62.c~fix-various-memory-leaks drivers/usb/misc/emi62.c
> --- 25/drivers/usb/misc/emi62.c~fix-various-memory-leaks	2004-05-23 13:18:16.703238792 -0700
> +++ 25-akpm/drivers/usb/misc/emi62.c	2004-05-23 13:18:16.712237424 -0700
> @@ -229,6 +229,8 @@ static int emi62_load_firmware (struct u
>  		goto wraperr;
>  	}
>  
> +	kfree(buf);
> +
>  	/* return 1 to fail the driver inialization
>  	 * and give real driver change to load */
>  	return 1;
> diff -puN drivers/video/aty/atyfb_base.c~fix-various-memory-leaks drivers/video/aty/atyfb_base.c
> --- 25/drivers/video/aty/atyfb_base.c~fix-various-memory-leaks	2004-05-23 13:18:16.705238488 -0700
> +++ 25-akpm/drivers/video/aty/atyfb_base.c	2004-05-23 13:21:38.808514120 -0700
> @@ -1938,6 +1938,19 @@ int __init atyfb_init(void)
>  			if (i < 0)
>  				continue;
>  
> +			rp = &pdev->resource[0];
> +			if (rp->flags & IORESOURCE_IO)
> +				rp = &pdev->resource[1];
> +			addr = rp->start;
> +			if (!addr)
> +				continue;
> +
> +			res_start = rp->start;
> +			res_size = rp->end - rp->start + 1;
> +			if (!request_mem_region
> +			    (res_start, res_size, "atyfb"))
> +				continue;
> +
>  			info =
>  			    kmalloc(sizeof(struct fb_info), GFP_ATOMIC);
>  			if (!info) {
> @@ -1960,19 +1973,6 @@ int __init atyfb_init(void)
>  			info->fix = atyfb_fix;
>  			info->par = default_par;
>  
> -			rp = &pdev->resource[0];
> -			if (rp->flags & IORESOURCE_IO)
> -				rp = &pdev->resource[1];
> -			addr = rp->start;
> -			if (!addr)
> -				continue;
> -
> -			res_start = rp->start;
> -			res_size = rp->end - rp->start + 1;
> -			if (!request_mem_region
> -			    (res_start, res_size, "atyfb"))
> -				continue;
> -
>  #ifdef __sparc__
>  			/*
>  			 * Map memory-mapped registers.
> @@ -2000,6 +2000,7 @@ int __init atyfb_init(void)
>  			if (!default_par->mmap_map) {
>  				printk
>  				    ("atyfb_init: can't alloc mmap_map\n");
> +				kfree(default_par);
>  				kfree(info);
>  				release_mem_region(res_start, res_size);
>  				return -ENXIO;
> @@ -2217,6 +2218,9 @@ int __init atyfb_init(void)
>  			    ioremap(info->fix.mmio_start, 0x1000);
>  
>  			if (!default_par->ati_regbase) {
> +#ifdef __sparc__
> +				kfree(default_par->mmap_map);
> +#endif
>  				kfree(default_par);
>  				kfree(info);
>  				release_mem_region(res_start, res_size);
> @@ -2247,6 +2251,10 @@ int __init atyfb_init(void)
>  			    (char *) ioremap(addr, 0x800000);
>  
>  			if (!info->screen_base) {
> +#ifdef __sparc__
> +				kfree(default_par->mmap_map);
> +#endif
> +				kfree(default_par);
>  				kfree(info);
>  				release_mem_region(res_start, res_size);
>  				return -ENXIO;
> @@ -2258,6 +2266,7 @@ int __init atyfb_init(void)
>  				if (default_par->mmap_map)
>  					kfree(default_par->mmap_map);
>  #endif
> +				kfree(default_par);
>  				kfree(info);
>  				release_mem_region(res_start, res_size);
>  				return -ENXIO;
> @@ -2326,6 +2335,7 @@ int __init atyfb_init(void)
>  		memset(default_par, 0, sizeof(struct atyfb_par));
>  
>  		info->fix = atyfb_fix;
> +		info->par = default_par;
>  
>  		/*
>  		 *  Map the video memory (physical address given) to somewhere in the
> @@ -2357,6 +2367,7 @@ int __init atyfb_init(void)
>  		}
>  
>  		if (!aty_init(info, "ISA bus")) {
> +			kfree(default_par);
>  			kfree(info);
>  			/* This is insufficient! kernel_map has added two large chunks!! */
>  			return -ENXIO;
> diff -puN net/irda/ircomm/ircomm_tty.c~fix-various-memory-leaks net/irda/ircomm/ircomm_tty.c
> --- 25/net/irda/ircomm/ircomm_tty.c~fix-various-memory-leaks	2004-05-23 13:18:16.706238336 -0700
> +++ 25-akpm/net/irda/ircomm/ircomm_tty.c	2004-05-23 13:18:16.716236816 -0700
> @@ -721,8 +721,10 @@ static int ircomm_tty_write(struct tty_s
>  		kbuf = kmalloc(count, GFP_KERNEL);
>  		if (kbuf == NULL)
>  			return -ENOMEM;
> -		if (copy_from_user(kbuf, ubuf, count))
> +		if (copy_from_user(kbuf, ubuf, count)) {
> +			kfree(kbuf);
>  			return -EFAULT;
> +		}
>  	} else
>  		/* The buffer is already in kernel space */
>  		kbuf = (unsigned char *) ubuf;
> @@ -779,6 +781,8 @@ static int ircomm_tty_write(struct tty_s
>  					    self->max_header_size);
>  			if (!skb) {
>  				spin_unlock_irqrestore(&self->spinlock, flags);
> +	                        if (from_user)
> +		                        kfree(kbuf);
>  				return -ENOBUFS;
>  			}
>  			skb_reserve(skb, self->max_header_size);
> 
> _
-- 
umka

