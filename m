Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWCKXpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWCKXpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWCKXpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:45:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:49608 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751253AbWCKXpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:45:36 -0500
Subject: Re: [PATCH] powerpc: enable NAP only on cpus who support it to
	avoid memory corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060311215840.GA22766@suse.de>
References: <20060311215840.GA22766@suse.de>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 10:43:10 +1100
Message-Id: <1142120591.4057.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 22:58 +0100, Olaf Hering wrote:
> commit 51d3082fe6e55aecfa17113dbe98077c749f724c enabled NAP unconditinally
> on all powermacs. Early G3 cpus can not use it, the result is memory corruption.
> 
> Only enable powersave_nap in one place: probe_motherboard()
> ppc32 gets nap if the cpu supports it
> ppc32 smp gets no nap
> ppc64 gets nap unconditionally

CONFIG_SMP is certainly not the way to do it though... I wonder how we
got that wrong, I'll have a look.

Ben.


> ---
>  arch/powerpc/platforms/powermac/feature.c |    8 +++++++-
>  arch/powerpc/platforms/powermac/setup.c   |    4 ----
>  arch/powerpc/platforms/powermac/smp.c     |    4 ----
>  3 files changed, 7 insertions(+), 9 deletions(-)
> 
> Index: linux-2.6.16-rc5-olh/arch/powerpc/platforms/powermac/feature.c
> ===================================================================
> --- linux-2.6.16-rc5-olh.orig/arch/powerpc/platforms/powermac/feature.c
> +++ linux-2.6.16-rc5-olh/arch/powerpc/platforms/powermac/feature.c
> @@ -2513,8 +2513,11 @@ found:
>  		/* Nap mode not supported if flush-on-lock property is present */
>  		if (get_property(np, "flush-on-lock", NULL))
>  			break;
> +
> +#ifndef CONFIG_SMP
> +		/* 32 bits SMP can't NAP */
>  		powersave_nap = 1;
> -		printk(KERN_INFO "Processor NAP mode on idle enabled.\n");
> +#endif
>  		break;
>  	}
>  
> @@ -2526,6 +2529,9 @@ found:
>  #ifdef CONFIG_POWER4
>  	powersave_nap = 1;
>  #endif
> +	if (powersave_nap)
> +		printk(KERN_INFO "Using native/NAP idle loop\n");
> +
>  	/* Check for "mobile" machine */
>  	if (model && (strncmp(model, "PowerBook", 9) == 0
>  		   || strncmp(model, "iBook", 5) == 0))
> Index: linux-2.6.16-rc5-olh/arch/powerpc/platforms/powermac/setup.c
> ===================================================================
> --- linux-2.6.16-rc5-olh.orig/arch/powerpc/platforms/powermac/setup.c
> +++ linux-2.6.16-rc5-olh/arch/powerpc/platforms/powermac/setup.c
> @@ -621,10 +621,6 @@ static void __init pmac_init_early(void)
>  	/* Probe motherboard chipset */
>  	pmac_feature_init();
>  
> -	/* We can NAP */
> -	powersave_nap = 1;
> -	printk(KERN_INFO "Using native/NAP idle loop\n");
> -
>  	/* Initialize debug stuff */
>  	udbg_scc_init(!!strstr(cmd_line, "sccdbg"));
>  	udbg_adb_init(!!strstr(cmd_line, "btextdbg"));
> Index: linux-2.6.16-rc5-olh/arch/powerpc/platforms/powermac/smp.c
> ===================================================================
> --- linux-2.6.16-rc5-olh.orig/arch/powerpc/platforms/powermac/smp.c
> +++ linux-2.6.16-rc5-olh/arch/powerpc/platforms/powermac/smp.c
> @@ -739,10 +739,6 @@ static void __init smp_core99_setup(int 
>  			smp_hw_index[i] = i;
>  	}
>  #endif
> -
> -	/* 32 bits SMP can't NAP */
> -	if (!machine_is_compatible("MacRISC4"))
> -		powersave_nap = 0;
>  }
>  
>  static int __init smp_core99_probe(void)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

