Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264321AbSIVPtM>; Sun, 22 Sep 2002 11:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264327AbSIVPtM>; Sun, 22 Sep 2002 11:49:12 -0400
Received: from franka.aracnet.com ([216.99.193.44]:21664 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264321AbSIVPtJ>; Sun, 22 Sep 2002 11:49:09 -0400
Date: Sun, 22 Sep 2002 08:52:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <73440311.1032684750@[10.10.2.3]>
In-Reply-To: <200209211159.41751.efocht@ess.nec.de>
References: <200209211159.41751.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few comments ... mainly just i386 arch things (which aren't
really your fault, was just a lack of the mechanisms being in
mainline), and a request to push a couple of things down into
the arch trees from rearing their ugly head into generic code ;-)

M.

> +static int __initdata nr_lnodes = 0;
> +

Use numnodes.

>  	cpu = ++cpucount;
> +#ifdef CONFIG_NUMA_SCHED
> +	cell = SAPICID_TO_PNODE(apicid);
> +	if (pnode_to_lnode[cell] < 0) {
> +		pnode_to_lnode[cell] = nr_lnodes++;
> +	}
> +#endif

pnodes and lnodes are all 1-1, so they're just called nodes for
i386, and there's no such thing as a SAPICID on this platform.

>  	/*
>  	 * We can't use kernel_thread since we must avoid to
>  	 * reschedule the child.
> @@ -996,6 +1004,10 @@ static void __init smp_boot_cpus(unsigne
>  	set_bit(0, &cpu_callout_map);
>  	boot_cpu_logical_apicid = logical_smp_processor_id();
>  	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
> +#ifdef CONFIG_NUMA_SCHED
> +	pnode_to_lnode[SAPICID_TO_PNODE(boot_cpu_apicid)] = nr_lnodes++;
> +	printk("boot_cpu_apicid = %d, nr_lnodes = %d, lnode = %d\n", boot_cpu_apicid, nr_lnodes, pnode_to_lnode[0]);
> +#endif

Ditto. All these mappings exist already. No need to reinvent them.
The -mm tree has a generic cpu_to_node macro, which keys off the
logical_apic_id.

http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.37/2.5.37-mm1/broken-out/topology-api.patch

> +#ifdef CONFIG_NUMA_SCHED
> +#define NR_NODES               8

MAX_NUMNODES exists for every arch (except maybe ia64 ;-))

> +#define cpu_physical_id(cpuid) (cpu_to_physical_apicid(cpuid))

Not needed, should be buried within a wrapper, not exposed to
generic code.

> +#define SAPICID_TO_PNODE(hwid)  (hwid >> 4)

Grrr. No such thing.

> diff -urNp a/include/linux/sched.h b/include/linux/sched.h

> +extern int pnode_to_lnode[NR_NODES];
> +extern char lnode_number[NR_CPUS] __cacheline_aligned;

Can't you push all this down into the arch ....

> +#define CPU_TO_NODE(cpu) lnode_number[cpu]

... by letting them define cpu_to_node() themselves?
(most people don't have lnodes and pnodes, etc).

> +EXPORT_SYMBOL(runqueues_address);
> +EXPORT_SYMBOL(numpools);
> +EXPORT_SYMBOL(pool_ptr);
> +EXPORT_SYMBOL(pool_cpus);
> +EXPORT_SYMBOL(pool_nr_cpus);
> +EXPORT_SYMBOL(pool_mask);
> +EXPORT_SYMBOL(sched_migrate_task);

Aren't these internal scheduler things?

> diff -urNp a/kernel/sched.c b/kernel/sched.c

> +int pnode_to_lnode[NR_NODES] = { [0 ... NR_NODES-1] = -1 };
> +char lnode_number[NR_CPUS] __cacheline_aligned;

Ditto.

> +	int this_pool = CPU_TO_NODE(this_cpu);
> +	int this_pool=CPU_TO_NODE(this_cpu), weight, maxweight=0;

Howcome you can use the CPU_TO_NODE abstraction here ...

> +	/* build translation table for CPU_TO_NODE macro */
> +	for (i = 0; i < NR_CPUS; i++)
> +		if (cpu_online(i))
> +			lnode_number[i] = pnode_to_lnode[SAPICID_TO_PNODE(cpu_physical_id(i))];

But not here?


