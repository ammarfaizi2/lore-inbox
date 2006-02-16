Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWBPG1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWBPG1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 01:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWBPG1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 01:27:41 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:20098 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751175AbWBPG1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 01:27:41 -0500
Date: Thu, 16 Feb 2006 07:27:27 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060216062727.GB9241@osiris.boeblingen.de.ibm.com>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213104645.GA17173@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213104645.GA17173@elte.hu>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> introduce the CONFIG_DEFAULT_MIGRATION_COST method for an architecture
> to set the scheduler migration costs. This turns off automatic detection
> of migration costs. Makes sense on virtual platforms, where migration
> costs are hard to measure accurately.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> ----
> 
>  arch/s390/Kconfig |    4 ++++
>  kernel/sched.c    |   13 ++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> Index: linux-robust-list.q/arch/s390/Kconfig
> ===================================================================
> --- linux-robust-list.q.orig/arch/s390/Kconfig
> +++ linux-robust-list.q/arch/s390/Kconfig
> @@ -80,6 +80,10 @@ config HOTPLUG_CPU
>  	  can be controlled through /sys/devices/system/cpu/cpu#.
>  	  Say N if you want to disable CPU hotplug.
>  
> +config DEFAULT_MIGRATION_COST
> +	int
> +	default "1000000"
> +
>  config MATHEMU
>  	bool "IEEE FPU emulation"
>  	depends on MARCH_G5
> Index: linux-robust-list.q/kernel/sched.c
> ===================================================================
> --- linux-robust-list.q.orig/kernel/sched.c
> +++ linux-robust-list.q/kernel/sched.c
> @@ -5159,7 +5159,18 @@ static void init_sched_build_groups(stru
>  #define MAX_DOMAIN_DISTANCE 32
>  
>  static unsigned long long migration_cost[MAX_DOMAIN_DISTANCE] =
> -		{ [ 0 ... MAX_DOMAIN_DISTANCE-1 ] = -1LL };
> +		{ [ 0 ... MAX_DOMAIN_DISTANCE-1 ] =
> +/*
> + * Architectures may override the migration cost and thus avoid
> + * boot-time calibration. Unit is nanoseconds. Mostly useful for
> + * virtualized hardware:
> + */
> +#ifdef CONFIG_DEFAULT_MIGRATION_COST
> +			CONFIG_DEFAULT_MIGRATION_COST
> +#else
> +			-1LL
> +#endif
> +};
>  
>  /*
>   * Allow override of migration cost - in units of microseconds.
> -

This one should be applied then.

Thanks,
Heiko
