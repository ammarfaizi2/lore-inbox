Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVIIHhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVIIHhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVIIHhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:37:06 -0400
Received: from fsmlabs.com ([168.103.115.128]:39079 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751430AbVIIHhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:37:05 -0400
Date: Fri, 9 Sep 2005 00:43:38 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Nyberg <alexn@telia.com>
Subject: Re: [PATCH] i386 boottime for_each_cpu broken
In-Reply-To: <20050909002640.2b0f0d00.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509090040280.978@montezuma.fsmlabs.com>
References: <200509050815.j858FLxR027791@hera.kernel.org>
 <20050909002640.2b0f0d00.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Andrew Morton wrote:

> >  static void __init MP_processor_info (struct mpc_config_processor *m)
> >  {
> > - 	int ver, apicid;
> > + 	int ver, apicid, cpu, found_bsp = 0;
> >  	physid_mask_t tmp;
> >   	
> >  	if (!(m->mpc_cpuflag & CPU_ENABLED))
> > @@ -181,6 +181,7 @@ static void __init MP_processor_info (st
> >  	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
> >  		Dprintk("    Bootup CPU\n");
> >  		boot_cpu_physical_apicid = m->mpc_apicid;
> > +		found_bsp = 1;
> >  	}
> >  
> >  	if (num_processors >= NR_CPUS) {
> > @@ -204,6 +205,11 @@ static void __init MP_processor_info (st
> >  		return;
> >  	}
> >  
> > +	if (found_bsp)
> > +		cpu = 0;
> > +	else
> > +		cpu = num_processors - 1;
> > +	cpu_set(cpu, cpu_possible_map);
> 
> Looky here:
> 
> akpm: found_bsp=0 cpu=0 tmp=0x0001 num_processors=1
> akpm: found_bsp=0 cpu=1 tmp=0x0002 num_processors=2
> akpm: found_bsp=0 cpu=2 tmp=0x0004 num_processors=3
> akpm: found_bsp=1 cpu=0 tmp=0x0008 num_processors=4
> 
> On this machine, the BSP is the last one to pass through
> MP_processor_info(), so the rude-looking assumption above screws things up.

Yes that's a terrible assumption, 

> I don't know what that found_bsp code is trying to do.  It wasn't
> changelogged and it wasn't commented and removing it makes by box boot again.
> 
> What did I break?

Nothing gov =)

> -	if (found_bsp)
> -		cpu = 0;
> -	else
> -		cpu = num_processors - 1;
> -	cpu_set(cpu, cpu_possible_map);
> -	tmp = apicid_to_cpu_present(apicid);
> -	physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
> -	
> +	cpu_set(num_processors, cpu_possible_map);
> +	num_processors++;
> +	phys_cpu = apicid_to_cpu_present(apicid);
> +	physids_or(phys_cpu_present_map, phys_cpu_present_map, phys_cpu);
> +

That looks fine to me, my BSP assumption was bad bad bad!

Thanks,
	Zwane

