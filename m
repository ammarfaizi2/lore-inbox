Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWIZLXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWIZLXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 07:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWIZLXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 07:23:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:2207 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751122AbWIZLXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 07:23:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,219,1157353200"; 
   d="scan'208"; a="137558464:sNHT64580677"
Message-ID: <45190D99.20605@intel.com>
Date: Tue, 26 Sep 2006 19:23:05 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: "tony.luck@intel.com" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, GOTO <y-goto@jp.fujitsu.com>
Subject: Re: [BUGFIX][PATCH] cpu to node relationship fixup take2 [2/2] map
 cpu to node
References: <20060922152702.4b01c192.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060922152702.4b01c192.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> Assume that a cpu is *physically* offlined at boot time...
> 
> Because smpboot.c::smp_boot_cpu_map() canoot find cpu's sapicid,
> numa.c::build_cpu_to_node_map() cannot build cpu<->node map for
> offlined cpu.
> 
> For such cpus, cpu_to_node map should be fixed at cpu-hot-add.
> This mapping should be done before cpu onlining.
> 
> This patch also handles cpu hotremove case.
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
>  arch/ia64/kernel/numa.c     |   34 +++++++++++++++++++++++++++++++---
>  arch/ia64/kernel/topology.c |    6 +++++-
>  include/asm-ia64/numa.h     |    4 ++++
>  3 files changed, 40 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.18/arch/ia64/kernel/numa.c
> ===================================================================
> --- linux-2.6.18.orig/arch/ia64/kernel/numa.c	2006-09-22 14:22:44.000000000 +0900
> +++ linux-2.6.18/arch/ia64/kernel/numa.c	2006-09-22 14:44:46.000000000 +0900
> @@ -29,6 +29,36 @@
>  
>  cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
>  
> +void __cpuinit map_cpu_to_node(int cpu, int nid)
> +{
> +	int oldnid;
> +	if (nid < 0) { /* just initialize by zero */
> +		cpu_to_node_map[cpu] = 0;
> +		return;
> +	}
> +	/* sanity check first */
> +	oldnid = cpu_to_node_map[cpu];
> +	if (cpu_isset(cpu, node_to_cpu_mask[oldnid])) {
> +		return; /* nothing to do */
> +	}
> +	/* we don't have cpu-driven node hot add yet...
> +	   In usual case, node is created from SRAT at boot time. */
> +	if (!node_online(nid))
> +		nid = first_online_node;
> +	cpu_to_node_map[cpu] = nid;
> +	cpu_set(cpu, node_to_cpu_mask[nid]);
> +	return;
> +}
> +
> +void __cpuinit unmap_cpu_from_node(int cpu, int nid)
> +{
> +	WARN_ON(!cpu_isset(cpu, node_to_cpu_mask[nid]));
> +	WARN_ON(cpu_to_node_map[cpu] != nid);
> +	cpu_to_node_map[cpu] = 0;
> +	cpu_clear(cpu, node_to_cpu_mask[nid]);
> +}
> +
> +
>  /**
>   * build_cpu_to_node_map - setup cpu to node and node to cpumask arrays
>   *
> @@ -49,8 +79,6 @@
>  				node = node_cpuid[i].nid;
>  				break;
>  			}
> -		cpu_to_node_map[cpu] = (node >= 0) ? node : 0;
> -		if (node >= 0)
> -			cpu_set(cpu, node_to_cpu_mask[node]);
> +		map_cpu_to_node(cpu, node);
>  	}
>  }
> Index: linux-2.6.18/include/asm-ia64/numa.h
> ===================================================================
> --- linux-2.6.18.orig/include/asm-ia64/numa.h	2006-09-22 14:22:44.000000000 +0900
> +++ linux-2.6.18/include/asm-ia64/numa.h	2006-09-22 14:25:07.000000000 +0900
> @@ -64,6 +64,10 @@
>  
>  #define local_nodeid (cpu_to_node_map[smp_processor_id()])
>  
> +extern void map_cpu_to_node(int cpu, int nid);
> +extern void unmap_cpu_from_node(int cpu, int nid);
> +
> +
>  #else /* !CONFIG_NUMA */
>  
>  #define paddr_to_nid(addr)	0
> Index: linux-2.6.18/arch/ia64/kernel/topology.c
> ===================================================================
> --- linux-2.6.18.orig/arch/ia64/kernel/topology.c	2006-09-22 14:22:44.000000000 +0900
> +++ linux-2.6.18/arch/ia64/kernel/topology.c	2006-09-22 14:25:07.000000000 +0900
> @@ -36,6 +36,9 @@
>  	 */
>  	if (!can_cpei_retarget() && is_cpu_cpei_target(num))
>  		sysfs_cpus[num].cpu.no_control = 1;
> +#ifdef CONFIG_NUMA
> +	map_cpu_to_node(num, node_cpuid[num].nid);
> +#endif
>  #endif
>  
>  	return register_cpu(&sysfs_cpus[num].cpu, num);
> @@ -45,7 +48,8 @@
>  
>  void arch_unregister_cpu(int num)
>  {
> -	return unregister_cpu(&sysfs_cpus[num].cpu);
> +	unregister_cpu(&sysfs_cpus[num].cpu);
> +	unmap_cpu_from_node(num, cpu_to_node(num));
This patch failed to compile in my IA64 box, my machine is not NUMA machine,
there is unmap_cpu_from_node not defined error like this.

arch/ia64/kernel/built-in.o: In function `arch_unregister_cpu':
arch/ia64/kernel/topology.c:52: undefined reference to `unmap_cpu_from_node'
make: *** [.tmp_vmlinux1] Error 1

thanks
bibo,mao

>  }
>  EXPORT_SYMBOL(arch_register_cpu);
>  EXPORT_SYMBOL(arch_unregister_cpu);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
