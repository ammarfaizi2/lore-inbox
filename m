Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVIBOkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVIBOkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVIBOkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:40:47 -0400
Received: from S01060013104bd78e.vc.shawcable.net ([24.85.145.160]:35742 "EHLO
	r3000.fsmlabs.com") by vger.kernel.org with ESMTP id S1751146AbVIBOkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:40:46 -0400
Date: Fri, 2 Sep 2005 07:40:42 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Alexander Nyberg <alexn@telia.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
In-Reply-To: <20050902143012.GA18532@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0509020737380.3393@r3000.fsmlabs.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <20050902143012.GA18532@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, Alexander Nyberg wrote:

> On Thu, Sep 01, 2005 at 03:55:42AM -0700 Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> > 
> 
> i386-boottime-for_each_cpu-broken.patch
> i386-boottime-for_each_cpu-broken-fix.patch
> 
> The SMP version of __alloc_percpu checks the cpu_possible_map
> before allocating memory for a certain cpu. With the above patches
> the BSP cpuid is never set in cpu_possible_map which breaks CONFIG_SMP
> on uniprocessor machines (as soon as someone tries to dereference
> something allocated via __alloc_percpu, which in fact is never allocated
> since the cpu is not set in cpu_possible_map).

Yes indeed, if there is no mptable or madt we would have missed setting 
it.

> The below fixes this, I'm not entirely sure about the voyager
> part, should the cpu_possible_map really be CPU_MASK_ALL to begin
> with there, Zwane?

I wanted to avoid breaking it wholesale and since i don't entirely 
understand the voyager SMP boot sequence, i opted for the safe method. 
cpu_possible_map is fine because it's supposed to cover all possible 
processors, upto NR_CPUS. 

> Signed-off-by: Alexander Nyberg <alexn@telia.com>

Thanks Alex,

Acked-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

> Index: mm/arch/i386/kernel/smpboot.c
> ===================================================================
> --- mm.orig/arch/i386/kernel/smpboot.c	2005-09-02 15:28:20.000000000 +0200
> +++ mm/arch/i386/kernel/smpboot.c	2005-09-02 16:16:46.000000000 +0200
> @@ -1265,6 +1265,7 @@
>  	cpu_set(smp_processor_id(), cpu_online_map);
>  	cpu_set(smp_processor_id(), cpu_callout_map);
>  	cpu_set(smp_processor_id(), cpu_present_map);
> +	cpu_set(smp_processor_id(), cpu_possible_map);
>  	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
>  }
>  
> Index: mm/arch/i386/mach-voyager/voyager_smp.c
> ===================================================================
> --- mm.orig/arch/i386/mach-voyager/voyager_smp.c	2005-09-02 15:28:20.000000000 +0200
> +++ mm/arch/i386/mach-voyager/voyager_smp.c	2005-09-02 16:17:29.000000000 +0200
> @@ -1910,6 +1910,7 @@
>  {
>  	cpu_set(smp_processor_id(), cpu_online_map);
>  	cpu_set(smp_processor_id(), cpu_callout_map);
> +	cpu_set(smp_processor_id(), cpu_possible_map);
>  }
>  
>  int __devinit
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
