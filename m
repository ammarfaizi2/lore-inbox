Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSEVJmR>; Wed, 22 May 2002 05:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316910AbSEVJmQ>; Wed, 22 May 2002 05:42:16 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:63661 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316908AbSEVJmN>;
	Wed, 22 May 2002 05:42:13 -0400
Date: Wed, 22 May 2002 11:42:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] duplicate clock calculation code in 3 IDE drivers
Message-ID: <20020522114206.D31145@ucw.cz>
In-Reply-To: <20020522093013.GD312@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 01:30:13PM +0400, Andrey Panin wrote:
> Hi,
> 
> now it is more interesting patch. AMD, PIIX and VIA IDE drivers contain
> some duplicated code for (amd|piix|via)_clock calculation. Attached
> patch moves this code into one function in ata-timing.c file.
> 
> Please take a look at it.

Looks quite OK - though it'd be better if "system_bus_speed" already
could be giving these reasonable values - this way we could get rid of
the (amd|piix|via)_clock variables altogether.

> 
> Best regards.
> 
> -- 
> Andrey Panin            | Embedded systems software engineer
> pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
> diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/ata-timing.c linux/drivers/ide/ata-timing.c
> --- linux.vanilla/drivers/ide/ata-timing.c	Tue May 21 01:56:18 2002
> +++ linux/drivers/ide/ata-timing.c	Wed May 22 04:06:53 2002
> @@ -256,3 +256,22 @@
>  
>  	return 0;
>  }
> +
> +unsigned int ata_system_bus_clock(void)
> +{
> +	unsigned int clock = system_bus_speed * 1000;
> +
> +	switch (clock) {
> +		case 33000: clock = 33333; break;
> +		case 37000: clock = 37500; break;
> +		case 41000: clock = 41666; break;
> +	}
> +
> +	if (clock < 20000 || clock > 50000) {
> +		printk(KERN_WARNING "ATA: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", clock);
> +		printk(KERN_WARNING "ATA: Use ide0=ata66 if you want to assume 80-wire cable\n");
> +		clock = 33333;
> +	}
> +
> +	return clock;
> +}
> diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/ata-timing.h linux/drivers/ide/ata-timing.h
> --- linux.vanilla/drivers/ide/ata-timing.h	Tue May  7 23:50:09 2002
> +++ linux/drivers/ide/ata-timing.h	Wed May 22 04:02:13 2002
> @@ -82,4 +82,6 @@
>  extern struct ata_timing* ata_timing_data(short speed);
>  extern int ata_timing_compute(struct ata_device *drive,
>  		short speed, struct ata_timing *t, int T, int UT);
> +
> +extern unsigned int ata_system_bus_clock(void);
>  #endif
> diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
> --- linux.vanilla/drivers/ide/amd74xx.c	Tue May 21 01:55:57 2002
> +++ linux/drivers/ide/amd74xx.c	Wed May 22 03:59:12 2002
> @@ -360,20 +360,7 @@
>  /*
>   * Determine the system bus clock.
>   */
> -
> -	amd_clock = system_bus_speed * 1000;
> -
> -	switch (amd_clock) {
> -		case 33000: amd_clock = 33333; break;
> -		case 37000: amd_clock = 37500; break;
> -		case 41000: amd_clock = 41666; break;
> -	}
> -
> -	if (amd_clock < 20000 || amd_clock > 50000) {
> -		printk(KERN_WARNING "AMD_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", amd_clock);
> -		printk(KERN_WARNING "AMD_IDE: Use ide0=ata66 if you want to assume 80-wire cable\n");
> -		amd_clock = 33333;
> -	}
> +	amd_clock = ata_system_bus_clock();
>  
>  /*
>   * Print the boot message.
> diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/piix.c linux/drivers/ide/piix.c
> --- linux.vanilla/drivers/ide/piix.c	Tue May 21 01:55:58 2002
> +++ linux/drivers/ide/piix.c	Wed May 22 04:03:37 2002
> @@ -497,19 +497,7 @@
>   * Determine the system bus clock.
>   */
>  
> -	piix_clock = system_bus_speed * 1000;
> -
> -	switch (piix_clock) {
> -		case 33000: piix_clock = 33333; break;
> -		case 37000: piix_clock = 37500; break;
> -		case 41000: piix_clock = 41666; break;
> -	}
> -
> -	if (piix_clock < 20000 || piix_clock > 50000) {
> -		printk(KERN_WARNING "PIIX: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", piix_clock);
> -		printk(KERN_WARNING "PIIX: Use ide0=ata66 if you want to assume 80-wire cable\n");
> -		piix_clock = 33333;
> -	}
> +	piix_clock = ata_system_bus_clock();
>  
>  /*
>   * Print the boot message.
> diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
> --- linux.vanilla/drivers/ide/via82cxxx.c	Tue May 21 01:55:59 2002
> +++ linux/drivers/ide/via82cxxx.c	Wed May 22 04:03:17 2002
> @@ -474,19 +474,7 @@
>   * Determine system bus clock.
>   */
>  
> -	via_clock = system_bus_speed * 1000;
> -
> -	switch (via_clock) {
> -		case 33000: via_clock = 33333; break;
> -		case 37000: via_clock = 37500; break;
> -		case 41000: via_clock = 41666; break;
> -	}
> -
> -	if (via_clock < 20000 || via_clock > 50000) {
> -		printk(KERN_WARNING "VP_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", via_clock);
> -		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.\n");
> -		via_clock = 33333;
> -	}
> +	via_clock = ata_system_bus_clock();
>  
>  /*
>   * Print the boot message.




-- 
Vojtech Pavlik
SuSE Labs
