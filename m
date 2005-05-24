Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVEXM04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVEXM04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVEXM0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:26:55 -0400
Received: from colin.muc.de ([193.149.48.1]:56327 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262038AbVEXMZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:25:00 -0400
Date: 24 May 2005 14:24:57 +0200
Date: Tue, 24 May 2005 14:24:57 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [patch 2/4] CPU Hotplug support for X86_64
Message-ID: <20050524122457.GB86182@muc.de>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <20050524081304.402330000@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524081304.402330000@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 01:11:15AM -0700, Ashok Raj wrote:
>  /*
> @@ -97,6 +97,26 @@ cpumask_t cpu_core_map[NR_CPUS] __cachel
>  extern unsigned char trampoline_data[];
>  extern unsigned char trampoline_end[];
>  
> +/* State of each CPU */
> +DEFINE_PER_CPU(int, cpu_state) = { 0 };
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +/*
> + * Store all idle threads, this can be reused instead of creating
> + * a new thread. Also avoids complicated thread destroy functionality
> + * for idle threads.
> + */
> +struct task_struct *idle_thread_array[NR_CPUS];
> +
> +#define get_idle_for_cpu(x)     (idle_thread_array[(x)])
> +#define set_idle_for_cpu(x,p)   (idle_thread_array[(x)] = (p))

Why is this only enabled for HOTPLUG_CPU? It looks like it could
be used for the !HOTPLUG case too. That would be preferable
to have less ifdefs.

>  
> -static __cpuinitdata DEFINE_SPINLOCK(tsc_sync_lock);
> -static volatile __cpuinitdata unsigned long go[SLAVE + 1];
> -static int notscsync __cpuinitdata;
> +static __devinitdata DEFINE_SPINLOCK(tsc_sync_lock);
> +static volatile __devinitdata unsigned long go[SLAVE + 1];
> +static int notscsync __devinitdata;

Should be __cpuinitdata

>  
>  #undef DEBUG_TSC_SYNC
>  
> @@ -192,7 +212,7 @@ static int notscsync __cpuinitdata;
>  #define NUM_ITERS	5	/* likewise */
>  
>  /* Callback on boot CPU */
> -static __cpuinit void sync_master(void *arg)
> +static __devinit void sync_master(void *arg)

Didnt we agree to not do these changes?

Lots more cases in this file. The patch would be a lot smaller without
them.

> @@ -410,6 +430,8 @@ void __cpuinit smp_callin(void)
>  	 * Allow the master to continue.
>  	 */
>  	cpu_set(cpuid, cpu_callin_map);
> +	mb();
> +	local_flush_tlb();

Why is this needed?

> +#ifndef CONFIG_HOTPLUG_CPU
>  			cpu_set(i, cpu_possible_map);
> +#endif
>  		}
> +#ifdef CONFIG_HOTPLUG_CPU
> +			printk ("Setting possible cpus %d\n", i);
> +			cpu_set(i, cpu_possible_map);
> +#endif

Why these two ifdefs?  If possible remove them.


> @@ -1007,7 +1080,10 @@ int __cpuinit __cpu_up(unsigned int cpu)
>  
>  	while (!cpu_isset(cpu, cpu_online_map))
>  		cpu_relax();
> -	return 0;
> +	err = 0;
> +ret:
> +	flush_tlb_all();

Why this flush again?

How do you prevent the BP from being offlined? Currently
some stuff (NMIs, timer) rely on it being present :/ Longer
term they need to be fixed of course, but short term I would
refuse to offline it. Needs an audit probably.

> +		return -EBUSY;
> +
> +	disable_APIC_timer();
> +
> +	/* Allow any queued timer interrupts to get serviced */
> +	local_irq_enable();
> +	mdelay(1);

This wont work with variable timer tick. Need some other way 
to kick the timer. It looks unreliable anyways.

> +
> +	/*
> +	 * Need this per zwane, but this uses IPI, so cannot be used 
> +	 * in the machine down state. Need to find something else
> +	 *
> +	 * flush_tlb_all(); 
> +	 */
> +	local_flush_tlb();
> +	local_irq_disable();
> +	remove_siblinginfo(cpu);

No idea what all these TLB flushes are good for. Can you describe
them?

>  	/* Only the BSP gets external NMIs from the system.  */
> -	if (!smp_processor_id())
> +	if (!cpu)

e.g. here you have the first BP dependency... Ideally
it would shift if it is ever offlined.

>  		reason = get_nmi_reason();
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (!cpu_online(cpu))
> +		return;
> +#endif

Please remove the ifdef.

-Andi
