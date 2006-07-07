Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWGGX0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWGGX0j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWGGX0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:26:39 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:51867 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932401AbWGGX0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:26:36 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] remove empty node at boot time
Date: Fri, 7 Jul 2006 17:26:31 -0600
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607071726.31646.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 05:04, KAMEZAWA Hiroyuki wrote:
> Remove empty node -- a node which containes no cpu, no memory (and no I/O).
> for ia64.
> 
> This patch online nodes which has available resouces and avoid onlining 
> nodes which has only possible resouces.

This patch breaks my HP rx8640 box.  I suppose we have some unusual
SRAT configuration.  I'll debug it more next week.  If there's something
in particular I should look for, let me know.

Comparing old (working) with new (broken), I see:

- Number of logical nodes in system = 3
+ Number of logical nodes in system = 1

This box has two cells.  Each cell has four CPUs and some local memory.
There is also an interleaved region that uses memory from both cells.
I think firmware presents this as a logical node for each cell, plus
one for the interleaved region.

This box is configured with minimal local memory on each cell (8MB).
That's less than a granule, so we should discard it, leaving two nodes
with CPUs but no memory, and a third node with all the interleaved
memory but no CPUs.

It looks like this patch throws away two of the nodes, so I'm guessing
we discarded the nodes with CPUs and no memory.

> SRAT describes possible resources, cpu and memory.  It also shows proximity
> domain, pxm. Each numa node is created according to pxm.
> 
> Current ia64 SRAT parser onlining node when new pxm is found. But sometimes
> pxm just includes 'possible' resources, doesn't includes available resources.
> Such pxms will create an empty node.
> 
> When an empty node is onlined, it allocates a pgdat for an empty node.
> 
> Now, fundamental codes for node-hot-plug are ready in -mm. We can add
> cpu and memory dynamically to the created new node. (memory-less-node hotplug is
> not ready. But I don't know whether there are demands for it now.)
> Then, we can remove empty nodes, which just includes possible resource.
> 
> And, I'm now considering allocating new pgdat on-node. Empty nodes are
> obstacles to do that.
> 
> TBD: I/O only node detections scheme should be fixed (if necessary).
>      Does anyone have a suggestion ?
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
> Index: linux-2.6.17-rc5-mm2/arch/ia64/kernel/setup.c
> ===================================================================
> --- linux-2.6.17-rc5-mm2.orig/arch/ia64/kernel/setup.c	2006-06-01 18:34:08.000000000 +0900
> +++ linux-2.6.17-rc5-mm2/arch/ia64/kernel/setup.c	2006-06-01 19:09:19.000000000 +0900
> @@ -418,7 +418,7 @@
>  
>  	if (early_console_setup(*cmdline_p) == 0)
>  		mark_bsp_online();
> -
> +	reserve_memory();
>  #ifdef CONFIG_ACPI
>  	/* Initialize the ACPI boot-time table parser */
>  	acpi_table_init();
> Index: linux-2.6.17-rc5-mm2/arch/ia64/mm/contig.c
> ===================================================================
> --- linux-2.6.17-rc5-mm2.orig/arch/ia64/mm/contig.c	2006-06-01 18:32:18.000000000 +0900
> +++ linux-2.6.17-rc5-mm2/arch/ia64/mm/contig.c	2006-06-01 19:09:19.000000000 +0900
> @@ -146,8 +146,6 @@
>  {
>  	unsigned long bootmap_size;
>  
> -	reserve_memory();
> -
>  	/* first find highest page frame number */
>  	max_pfn = 0;
>  	efi_memmap_walk(find_max_pfn, &max_pfn);
> Index: linux-2.6.17-rc5-mm2/arch/ia64/mm/discontig.c
> ===================================================================
> --- linux-2.6.17-rc5-mm2.orig/arch/ia64/mm/discontig.c	2006-06-01 18:34:08.000000000 +0900
> +++ linux-2.6.17-rc5-mm2/arch/ia64/mm/discontig.c	2006-06-01 19:09:19.000000000 +0900
> @@ -443,8 +443,6 @@
>  {
>  	int node;
>  
> -	reserve_memory();
> -
>  	if (num_online_nodes() == 0) {
>  		printk(KERN_ERR "node info missing!\n");
>  		node_set_online(0);
> Index: linux-2.6.17-rc5-mm2/arch/ia64/kernel/acpi.c
> ===================================================================
> --- linux-2.6.17-rc5-mm2.orig/arch/ia64/kernel/acpi.c	2006-06-01 18:34:08.000000000 +0900
> +++ linux-2.6.17-rc5-mm2/arch/ia64/kernel/acpi.c	2006-06-01 19:09:19.000000000 +0900
> @@ -515,6 +515,43 @@
>  	num_node_memblks++;
>  }
>  
> +/* online node if node has valid memory */
> +static
> +int find_valid_memory_range(unsigned long start, unsigned long end, void *arg)
> +{
> +	int i;
> +	struct node_memblk_s *p;
> +	start = __pa(start);
> +	end = __pa(end);
> +	for (i = 0; i < num_node_memblks; ++i) {
> +		p = &node_memblk[i];
> +		if (end < p->start_paddr)
> +			continue;
> +		if (p->start_paddr + p->size <= start)
> +			continue;
> +		node_set_online(p->nid);
> +	}
> +	return 0;
> +}
> +
> +static void
> +acpi_online_node_fixup(void)
> +{
> +	int i, cpu;
> +	/* online node if a node has available cpus */
> +	for (i = 0; i < srat_num_cpus; ++i)
> +		for (cpu = 0; cpu < available_cpus; ++cpu)
> +			if (smp_boot_data.cpu_phys_id[cpu] ==
> +				node_cpuid[i].phys_id) {
> +				node_set_online(node_cpuid[i].nid);
> +				break;
> +			}
> +	/* memory */
> +	efi_memmap_walk(find_valid_memory_range, NULL);
> +
> +	/* TBD: check I/O devices which have valid nid. and online it*/
> +}
> +
>  void __init acpi_numa_arch_fixup(void)
>  {
>  	int i, j, node_from, node_to;
> @@ -526,22 +563,28 @@
>  		return;
>  	}
>  
> -	/*
> -	 * MCD - This can probably be dropped now.  No need for pxm ID to node ID
> -	 * mapping with sparse node numbering iff MAX_PXM_DOMAINS <= MAX_NUMNODES.
> -	 */
>  	nodes_clear(node_online_map);
> +	/* MAP pxm to nid */
>  	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
>  		if (pxm_bit_test(i)) {
> -			int nid = acpi_map_pxm_to_node(i);
> -			node_set_online(nid);
> +			/* this makes pxm <-> nid mapping */
> +			acpi_map_pxm_to_node(i);
>  		}
>  	}
> +	/* convert pxm information to nid information */
>  
> -	/* set logical node id in memory chunk structure */
>  	for (i = 0; i < num_node_memblks; i++)
>  		node_memblk[i].nid = pxm_to_node(node_memblk[i].nid);
>  
> +	for (i = 0; i < srat_num_cpus; i++)
> +		node_cpuid[i].nid = pxm_to_node(node_cpuid[i].nid);
> +
> +	/*
> +         * confirm node is online or not.
> +         * onlined node will have their own NODE_DATA
> +	 */
> +	acpi_online_node_fixup();
> +
>  	/* assign memory bank numbers for each chunk on each node */
>  	for_each_online_node(i) {
>  		int bank;
> @@ -552,9 +595,6 @@
>  				node_memblk[j].bank = bank++;
>  	}
>  
> -	/* set logical node id in cpu structure */
> -	for (i = 0; i < srat_num_cpus; i++)
> -		node_cpuid[i].nid = pxm_to_node(node_cpuid[i].nid);
>  
>  	printk(KERN_INFO "Number of logical nodes in system = %d\n",
>  	       num_online_nodes());
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
