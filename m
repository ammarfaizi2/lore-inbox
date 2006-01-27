Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWA0Emj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWA0Emj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWA0Emj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:42:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:59791 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932365AbWA0Emi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:42:38 -0500
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Date: Fri, 27 Jan 2006 05:42:11 +0100
User-Agent: KMail/1.8.2
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rohit.seth@intel.com, asit.k.mallick@intel.com
References: <20060126015132.A8521@unix-os.sc.intel.com>
In-Reply-To: <20060126015132.A8521@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601270542.12404.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 10:51, Siddha, Suresh B wrote:

With this patch does the new distance checking code in the scheduler 
from Ingo automatically discover all the relevant distances?

> +#ifdef CONFIG_SMP
> +	unsigned int cpu = (c == &boot_cpu_data) ? 0 : (c - cpu_data);
> +#endif

Wouldn't it be better to just put that information into the cpuinfo_x86?
We're having too many per CPU arrays already.


> +int cpu_llc_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};

This needs a comment on what a LLC actually is.

> +
>  /* representing HT siblings of each logical CPU */
>  cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
>  EXPORT_SYMBOL(cpu_sibling_map);
> @@ -84,6 +86,8 @@ EXPORT_SYMBOL(cpu_core_map);
>  cpumask_t cpu_online_map __read_mostly;
>  EXPORT_SYMBOL(cpu_online_map);
>  
> +cpumask_t cpu_llc_shared_map[NR_CPUS] __read_mostly;

Dito.

> +u8 cpu_llc_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};

This could be __cpuinitdata, no?

Actually it would be better to pass this information in some other way
to smpboot.c than to add more and more arrays like this.  It's only
needed for the current CPU, because for the others the information
is in cpu_llc_shared_map

Perhaps SMP boot up should pass around a pointer to temporary data like this?
Or discover it in smpboot.c with a function call?

> -#ifdef CONFIG_SCHED_SMT
> +#if defined(CONFIG_SCHED_SMT)
>  		sd = &per_cpu(cpu_domains, i);
> +#elif defined(CONFIG_SCHED_MC)

elif? What happens where there are both shared caches and SMT? 

> +		sd = &per_cpu(core_domains, i);
>  #else
>  		sd = &per_cpu(phys_domains, i);
>  #endif


-Andi
