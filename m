Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423180AbWCXG1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423180AbWCXG1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423186AbWCXG1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:27:12 -0500
Received: from lixom.net ([66.141.50.11]:8921 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1423180AbWCXG1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:27:10 -0500
Date: Fri, 24 Mar 2006 00:26:24 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Kill machine numbers
Message-ID: <20060324062624.GA16815@pb15.lixom.net>
References: <1143178947.4257.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143178947.4257.78.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few comments below, I've cut out most of the patch to save
bandwidth...

On Fri, Mar 24, 2006 at 04:42:26PM +1100, Benjamin Herrenschmidt wrote:

> Index: linux-work/arch/powerpc/kernel/setup-common.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/setup-common.c	2006-03-24 11:42:13.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/setup-common.c	2006-03-24 11:45:28.000000000 +1100
> +void probe_machine(void)
> +{
> +	extern struct machdep_calls __machine_desc_start;
> +	extern struct machdep_calls __machine_desc_end;
> +
> +	/*
> +	 * Iterate all ppc_md structures until we find the proper
> +	 * one for the current machine type
> +	 */
> +	DBG("Probing machine type ...\n");
> +
> +	for (machine_id = &__machine_desc_start;
> +	     machine_id < &__machine_desc_end;
> +	     machine_id++) {
> +		DBG("  %s ...", machine_id->name);
> +		memcpy(&ppc_md, machine_id, sizeof(struct machdep_calls));
> +		if (ppc_md.probe()) {
> +			DBG(" match !\n");
> +			break;
> +		}
> +		DBG("\n");
> +	}

It would be very useful to print the ppc_md.name of the found machine
here, even without debugging enabled.

> +	/* What can we do if we didn't find ? */
> +	if (machine_id >= &__machine_desc_end) {
> +		DBG("No suitable machine found !\n");
> +		for (;;);
> +	}
> +}


> Index: linux-work/arch/powerpc/platforms/cell/setup.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2006-03-23 14:26:08.000000000 +1100
> +++ linux-work/arch/powerpc/platforms/cell/setup.c	2006-03-24 11:45:28.000000000 +1100
> @@ -195,9 +195,10 @@ static void __init cell_init_early(void)
>  }
>  
>  
> -static int __init cell_probe(int platform)
> +static int __init cell_probe(void)
>  {
> -	if (platform != PLATFORM_CELL)
> +	unsigned long root = of_get_flat_dt_root();
> +	if (!of_flat_dt_is_compatible(root, "IBM,CPB"))
>  		return 0;
>  
>  	return 1;
> @@ -212,7 +213,7 @@ static int cell_check_legacy_ioport(unsi
>  	return -ENODEV;
>  }
>  
> -struct machdep_calls __initdata cell_md = {
> +define_machine(cell) {
>  	.probe			= cell_probe,
>  	.setup_arch		= cell_setup_arch,
>  	.init_early		= cell_init_early,

You forgot to add a .name value here.

> Index: linux-work/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-03-10 15:58:17.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/prom_init.c	2006-03-24 14:41:14.000000000 +1100
[...]
> +	/* If not a mac, try to figure out if it's an IBM pSeries. We assume
> +	 * it is if :
> +	 *  - /device_type is "chrp" (please, do NOT use that for future
> +	 *    non-IBM designs !
> +	 *  - it has /rtas
> +	 */

It's really weird that IBM chose to use "chrp" to describe a
PAPR-compliant platform. I guess it's for historical reasons, but it
sure isn't CHRP any more.

Also, please change the wording. With power.org, there will likely be
non-IBM PAPR-compliant platforms at some point. "non-PAPR-compliant
designs" is a better term to use.

> Index: linux-work/Documentation/powerpc/booting-without-of.txt
> ===================================================================
> --- linux-work.orig/Documentation/powerpc/booting-without-of.txt	2006-03-24 11:42:13.000000000 +1100
> +++ linux-work/Documentation/powerpc/booting-without-of.txt	2006-03-24 14:28:27.000000000 +1100
> @@ -719,6 +719,10 @@ address which can extend beyond that lim
>      - model : this is your board name/model
>      - #address-cells : address representation for "root" devices
>      - #size-cells: the size representation for "root" devices
> +    - device_type : This property shouldn't be necessary. However, if
> +      device to create a device_type for your root node, make sure it

if you device to create... ?

> +      is _not_ "chrp" as this will be matched by the kernel to be a
> +      CHRP machine on 32 bits kernel or a pSeries on 64 bits kernels

...or a PAPR-compliant machine on 64-bit kernels.

(Also, "xx-bit kernels", not "xx bits kernels").


-Olof
