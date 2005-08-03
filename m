Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVHCKU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVHCKU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVHCKU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:20:27 -0400
Received: from ns1.suse.de ([195.135.220.2]:3212 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262186AbVHCKUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:20:25 -0400
Date: Wed, 3 Aug 2005 12:20:24 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Rajesh Shah <rajesh.shah@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Automatically enable bigsmp when we have more than 8 CPUs
Message-ID: <20050803102023.GN10895@wotan.suse.de>
References: <20050728115142.A30921@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728115142.A30921@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 11:51:42AM -0700, Venkatesh Pallipadi wrote:
>  				smp_found_config = 1;
> -				clustered_apic_check();

Removing that here will break x86-64.

> --- linux-2.6.13-rc3/arch/i386/kernel/mpparse.c	2005-07-29 00:58:06.175571504 -0700
> +++ linux-2.6.13-rc3-auto/arch/i386/kernel/mpparse.c	2005-07-29 01:38:13.557593808 -0700
> @@ -65,6 +65,8 @@ int nr_ioapics;
>  int pic_mode;
>  unsigned long mp_lapic_addr;
>  
> +unsigned int def_to_bigsmp = 0;
> +
>  /* Processor that is doing the boot up */
>  unsigned int boot_cpu_physical_apicid = -1U;
>  /* Internal processor count */
> @@ -213,6 +215,11 @@ static void __init MP_processor_info (st
>  		ver = 0x10;
>  	}
>  	apic_version[m->mpc_apicid] = ver;
> +	if ((num_processors > 8) && APIC_XAPIC(ver))
> +		def_to_bigsmp = 1;
> +	else
> +		def_to_bigsmp = 0;
> +

I think this needs at least an CPU vendor == INTEL check, because
bigsmp doesn't work on big AMD systems.

[I have a new physflat i386 subarch pending for that] 

Also I would add a printk somewhere that warns when bigsmp
is not available.

>  	dmi_scan_machine();
>  
> -#ifdef CONFIG_X86_GENERICARCH
> -	generic_apic_probe(*cmdline_p);
> -#endif	
>  	if (efi_enabled)
>  		efi_map_memmap();
>  
> @@ -1600,6 +1602,14 @@ void __init setup_arch(char **cmdline_p)
>  		get_smp_config();
>  #endif
>  
> +#ifdef CONFIG_X86_GENERICARCH
> +	generic_apic_probe(*cmdline_p);
> +#endif        

This move looks risky because ACPI can already switch subarchs. Are you
sure the command line option still works? Testing on summit and es7000
would be good.

-Andi
