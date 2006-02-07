Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWBGXi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWBGXi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWBGXi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:38:59 -0500
Received: from smtp-out.google.com ([216.239.45.12]:56943 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932482AbWBGXi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:38:58 -0500
Message-ID: <43E92F7D.7030904@google.com>
Date: Tue, 07 Feb 2006 15:38:37 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       apw@uk.ibm.com
Subject: Re: [PATCH -mm] i386: Don't disable the TSC on single node NUMAQs
References: <1139351607.10057.223.camel@cog.beaverton.ibm.com>
In-Reply-To: <1139351607.10057.223.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 	Currently on NUMAQ hardware we set tsc_disable=1 because on multi-node
> NUMAQ hardware the TSC is not synced. However, it is safe to use the TSC
> on single node NUMAQs. Thus this patch only disables the TSC if
> num_online_nodes() > 1.
> 
> This should fix performance issues seen w/ -mm by mbligh on elm3b132
> (which is a single node NUMAQ). These performance issues originated
> because with mainline code, the function that disables the TSC runs
> after time_init, thus the TSC is used regardless, allowing for possible
> timekeeping errors on multi-node systems.
> 
> With my new timekeeping work (in 2.6.16-rc1-mm1,mm2 and mm5), we do not
> select the TSC until later, so we see the TSC has been disabled and use
> the slower PIT instead as the original code intends. This caused the
> performance regression. 
> 
> While this patch allows the TSC to be used safely only on single node
> NUMAQs, multi-node NUMAQs may still see a performance drop from using
> the PIT, but this is necessary as using unsynched TSCs will result in
> incorrect timekeeping. 
> 
> 
> For test results, please see the graph:
> 	http://test.kernel.org/perf/kernbench.elm3b132.png
> 
> 2.6.16-rc1-mm5: without this patch
> 2.6.16-rc1-mm5+p22126: with this patch
> 
> 
> This patch also fixes the typo'ed function name.
> 
> thanks
> -john
> 
> Signed-off-by: John Stultz <johnstul@us.ibm.com>

Looks good ... thanks for fixing it ;-)

Signed-off-by: Martin J. Bligh <mbligh@google.com>

> diff --git a/arch/i386/kernel/numaq.c b/arch/i386/kernel/numaq.c
> index 5f5b075..0caf146 100644
> --- a/arch/i386/kernel/numaq.c
> +++ b/arch/i386/kernel/numaq.c
> @@ -79,10 +79,12 @@ int __init get_memcfg_numaq(void)
>  	return 1;
>  }
>  
> -static int __init numaq_dsc_disable(void)
> +static int __init numaq_tsc_disable(void)
>  {
> -	printk(KERN_DEBUG "NUMAQ: disabling TSC\n");
> -	tsc_disable = 1;
> +	if (num_online_nodes() > 1) {
> +		printk(KERN_DEBUG "NUMAQ: disabling TSC\n");
> +		tsc_disable = 1;
> +	}
>  	return 0;
>  }
> -core_initcall(numaq_dsc_disable);
> +arch_initcall(numaq_tsc_disable);
> 
> 

