Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286214AbRLTMI2>; Thu, 20 Dec 2001 07:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286218AbRLTMIS>; Thu, 20 Dec 2001 07:08:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40647 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286214AbRLTMIE>; Thu, 20 Dec 2001 07:08:04 -0500
Date: Thu, 20 Dec 2001 17:43:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New per-cpu patch v2.5.1
Message-ID: <20011220174335.A10791@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

I appreciate the noble gesture of allowing NUMA people to
locate the per-cpu areas in different places in memory ;-)

That said, memcpy of static per-cpu areas doesn't seem right.
Why copy the same area to all the dynamically allocated per-cpu
areas ? Also, shouldn't the size be &__per_cpu_end - &__per_cpu_start ?
And how do we use this with per-cpu data used right
from smp boot, say apic_timer_irqs[] ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


In article <E16GwUZ-0004xr-00@wagner.rustcorp.com.au> Rusty Russell wrote:
> After some discussion, this may be a more sane (untested) per-cpu area
> patch.  It dynamically allocated the sections (and discards the
> original), which would allow (future) NUMA people to make sure their
> CPU area is allocated near them.

> Comments welcome,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>  /* Called by boot processor to activate the rest. */
>  static void __init smp_init(void)
>  {
> +	unsigned int i;
> +	size_t per_cpu_size;
> +
>  	/* Get other processors into their bootup holding patterns. */
>  	smp_boot_cpus();
>  	wait_init_idle = cpu_online_map;
> @@ -324,6 +328,16 @@
>  		barrier();
>  	}
>  	printk("All processors have done init_idle\n");
> +
> +	/* Set up per-CPU section pointers.  Page align to be safe. */
> +	per_cpu_size = ((&__per_cpu_end - &__per_cpu_start) + PAGE_SIZE-1)
> +		& ~(PAGE_SIZE-1);
> +	per_cpu_off[0] = kmalloc(per_cpu_size * smp_num_cpus, GFP_KERNEL);
> +	for (i = 0; i < smp_num_cpus; i++) {
> +		per_cpu_off[i] = per_cpu_off[0] + per_cpu_size;
> +		memcpy(per_cpu_off[i], &__per_cpu_start,
> +		       __per_cpu_end - &__per_cpu_start);
> +	}
>  }
>  
>  #endif


