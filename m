Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbUAJOje (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUAJOjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:39:33 -0500
Received: from smtp.hccnet.nl ([62.251.0.13]:43978 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S265172AbUAJOj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:39:26 -0500
Message-ID: <40000E9A.7070805@iae.nl>
Date: Sat, 10 Jan 2004 15:39:22 +0100
From: Jan Evert van Grootheest <janevert@iae.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, en, nl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ht6560b patch for 2.4 (and 2.6?)
References: <3FEEE8C1.9080102@iae.nl> <200401090112.19681.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200401090112.19681.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart,

Thanks! I'll get on with it as soon as possible.

If you don't mind, I'd like to remove the module code.
I don't use it and I'm not convinced that all functions have proper 
__init or similar designations.

In the meantime, perhaps you could give some hints how to get DMA going?
In 2.2 it would do to use hdparm -d1, but in 2.4 that fails (for obvious 
reasons when examining the code).
Would it be a trivial task?

Thanks,
Jan Evert

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Sorry for long delay.
> 
> On Sunday 28 of December 2003 15:29, Jan Evert van Grootheest wrote:
> 
>>Andre,
>>
>>You're listed as the IDE maintainer for 2.4.
>>I'm one of the few people that own one of those Holtek 6560B VLB IDE
>>interfaces.
> 
> 
> Andre no longer have time to do this.
> You can contact me although I am concentrated on 2.6.x.
> 
> 
>>Here's a patch against 2.4.23 that at least allows the kernel to boot
>>when using the driver. Without this patch it simply hangs somewhere
>>during early initialisation.
>>
>>I won't be surprised if a comparable patch is required for 2.6, although
>>I have not checked whether it applies. (I have no 2.6 sources yet)
> 
> 
> Surprise, surprise :-).
> 
> 
>>This is my first kernel patch so if there is something not in order
>>please let me know.
> 
> 
> Can you try this patch against kernel 2.4.24?
> It is backport of my 2.6.x patch plus your ide_register_driver() fix.
> 
> --bart
> 
> [IDE] update ht6560b driver
> 
> From: Jan Evert van Grootheest <janevert@iae.nl>:
> - register driver with IDE core or it won't work
> 
> Backport of my 2.6.x changes:
> - common ht6560b_init() for built-in and module
> - release hwif only if hwif->chipset == ide_ht6560b
> - when releasing hwif, restore hwif->channel to the default value
> - mark exit functions with __exit
> - do not use ide_hwifs[] directly
> - minor cleanups
> 
>  drivers/ide/legacy/ht6560b.c |  155 ++++++++++++++++++-------------------------
>  1 files changed, 67 insertions(+), 88 deletions(-)
> 
> diff -puN drivers/ide/legacy/ht6560b.c~ide-ht6560b-update drivers/ide/legacy/ht6560b.c
> --- linux-2.4.23/drivers/ide/legacy/ht6560b.c~ide-ht6560b-update	2004-01-09 00:30:21.840090880 +0100
> +++ linux-2.4.23-root/drivers/ide/legacy/ht6560b.c	2004-01-09 01:06:47.081883632 +0100
> @@ -312,119 +312,98 @@ static void tune_ht6560b (ide_drive_t *d
>  #endif
>  }
>  
> -void __init probe_ht6560b (void)
> +static int __init ht6560b_init(void)
>  {
> +	ide_hwif_t *hwif, *mate;
>  	int t;
> -	
> -	request_region(HT_CONFIG_PORT, 1, ide_hwifs[0].name);
> -	ide_hwifs[0].chipset = ide_ht6560b;
> -	ide_hwifs[1].chipset = ide_ht6560b;
> -	ide_hwifs[0].selectproc = &ht6560b_selectproc;
> -	ide_hwifs[1].selectproc = &ht6560b_selectproc;
> -	ide_hwifs[0].tuneproc = &tune_ht6560b;
> -	ide_hwifs[1].tuneproc = &tune_ht6560b;
> -	ide_hwifs[0].serialized = 1;  /* is this needed? */
> -	ide_hwifs[1].serialized = 1;  /* is this needed? */
> -	ide_hwifs[0].mate = &ide_hwifs[1];
> -	ide_hwifs[1].mate = &ide_hwifs[0];
> -	ide_hwifs[1].channel = 1;
> -			
> +
> +	hwif = &ide_hwifs[0];
> +	mate = &ide_hwifs[1];
> +
> +	if (!request_region(HT_CONFIG_PORT, 1, hwif->name)) {
> +		printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
> +			__FUNCTION__);
> +		return -ENODEV;
> +	}
> +
> +	if (!try_to_init_ht6560b()) {
> +		release_region(HT_CONFIG_PORT, 1);
> +		printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
> +		return -ENODEV;
> +	}
> +
> +	hwif->chipset = ide_ht6560b;
> +	hwif->selectproc = &ht6560b_selectproc;
> +	hwif->tuneproc = &tune_ht6560b;
> +	hwif->serialized = 1;	/* is this needed? */
> +	hwif->mate = mate;
> +
> +	mate->chipset = ide_ht6560b;
> +	mate->selectproc = &ht6560b_selectproc;
> +	mate->tuneproc = &tune_ht6560b;
> +	mate->serialized = 1;	/* is this needed? */
> +	mate->mate = hwif;
> +	mate->channel = 1;
> +
>  	/*
>  	 * Setting default configurations for drives
>  	 */
>  	t = (HT_CONFIG_DEFAULT << 8);
>  	t |= HT_TIMING_DEFAULT;
> -	ide_hwifs[0].drives[0].drive_data = t;
> -	ide_hwifs[0].drives[1].drive_data = t;
> +	hwif->drives[0].drive_data = t;
> +	hwif->drives[1].drive_data = t;
> +
>  	t |= (HT_SECONDARY_IF << 8);
> -	ide_hwifs[1].drives[0].drive_data = t;
> -	ide_hwifs[1].drives[1].drive_data = t;
> +	mate->drives[0].drive_data = t;
> +	mate->drives[1].drive_data = t;
>  
>  #ifndef HWIF_PROBE_CLASSIC_METHOD
> -	probe_hwif_init(&ide_hwifs[0]);
> -	probe_hwif_init(&ide_hwifs[1]);
> -#endif /* HWIF_PROBE_CLASSIC_METHOD */
> +	probe_hwif_init(hwif);
> +	probe_hwif_init(mate);
> +#endif
>  
> +	return 0;
>  }
>  
> -void __init ht6560b_release (void)
> +#ifndef MODULE
> +/* Can be called from ide.c. */
> +void __init ht6560b_builtin_init(void)
>  {
> -	if (ide_hwifs[0].chipset != ide_ht6560b &&
> -	    ide_hwifs[1].chipset != ide_ht6560b)
> -                return;
> -
> -	ide_hwifs[0].chipset = ide_unknown;
> -	ide_hwifs[1].chipset = ide_unknown;
> -	ide_hwifs[0].tuneproc = NULL;
> -	ide_hwifs[1].tuneproc = NULL;
> -	ide_hwifs[0].selectproc = NULL;
> -	ide_hwifs[1].selectproc = NULL;
> -	ide_hwifs[0].serialized = 0;
> -	ide_hwifs[1].serialized = 0;
> -	ide_hwifs[0].mate = NULL;
> -	ide_hwifs[1].mate = NULL;
> -
> -	ide_hwifs[0].drives[0].drive_data = 0;
> -	ide_hwifs[0].drives[1].drive_data = 0;
> -	ide_hwifs[1].drives[0].drive_data = 0;
> -	ide_hwifs[1].drives[1].drive_data = 0;
> -	release_region(HT_CONFIG_PORT, 1);
> +	(void)ht6560b_init();
>  }
>  
> -#ifndef MODULE
> -/*
> - * init_ht6560b:
> - *
> - * called by ide.c when parsing command line
> - */
> -
> -void __init init_ht6560b (void)
> +void __init init_ht6560b(void)
>  {
> -	if (check_region(HT_CONFIG_PORT,1)) {
> -		printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
> -			__FUNCTION__);
> -		return;
> -	}
> -	if (!try_to_init_ht6560b()) {
> -                printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
> -		return;
> -	}
> -	probe_ht6560b();
> +	ide_register_driver(ht6560b_builtin_init);
>  }
> -
>  #else
> -
> -MODULE_AUTHOR("See Local File");
> -MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
> -MODULE_LICENSE("GPL");
> -
> -int __init ht6560b_mod_init(void)
> +static void __exit ht6560b_release_hwif(ide_hwif_t *hwif)
>  {
> -	if (check_region(HT_CONFIG_PORT,1)) {
> -		printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
> -			__FUNCTION__);
> -		return -ENODEV;
> -	}
> +	if (hwif->chipset != ide_ht6560b)
> +		return;
>  
> -	if (!try_to_init_ht6560b()) {
> -		printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
> -		return -ENODEV;
> -	}
> +	hwif->chipset = ide_unknown;
> +	hwif->tuneproc = NULL;
> +	hwif->selectproc = NULL;
> +	hwif->serialized = 0;
> +	hwif->mate = NULL;
> +	hwif->channel = 0;
>  
> -	probe_ht6560b();
> -        if (ide_hwifs[0].chipset != ide_ht6560b &&
> -            ide_hwifs[1].chipset != ide_ht6560b) {
> -                ht6560b_release();
> -                return -ENODEV;
> -        }
> -        return 0;
> +	hwif->drives[0].drive_data = 0;
> +	hwif->drives[1].drive_data = 0;
>  }
> -module_init(ht6560b_mod_init);
>  
> -void __init ht6560b_mod_exit(void)
> +static void __exit ht6560b_exit(void)
>  {
> -        ht6560b_release();
> +	ht6560b_release_hwif(&ide_hwifs[0]);
> +	ht6560b_release_hwif(&ide_hwifs[1]);
> +	release_region(HT_CONFIG_PORT, 1);
>  }
> -module_exit(ht6560b_mod_exit);
> +
> +module_init(ht6560b_init);
> +module_exit(ht6560b_exit);
>  #endif
>  
> +MODULE_AUTHOR("See Local File");
> +MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
> +MODULE_LICENSE("GPL");
> 
> _
> 

