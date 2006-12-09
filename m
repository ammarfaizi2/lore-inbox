Return-Path: <linux-kernel-owner+w=401wt.eu-S936889AbWLILYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936889AbWLILYP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936890AbWLILYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:24:15 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:56954 "EHLO
	mx4.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936889AbWLILYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:24:14 -0500
Date: Sat, 9 Dec 2006 03:23:58 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [Patch](memory hotplug) Fix compile error for i386 with NUMA
 config
In-Reply-To: <20061209183320.0761.Y-GOTO@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64N.0612090318510.11325@attu4.cs.washington.edu>
References: <20061209183320.0761.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006, Yasunori Goto wrote:

> Hello.
> 
> This patch is to fix compile error when config memory hotplug
> with numa on i386.
> 
> The cause of compile error was missing of arch_add_memory(), remove_memory(),
> and memory_add_physaddr_to_nid() when NUMA config is on.
> 
> This is for 2.6.19, and I tested no compile error of it.
> 
> Please apply.
> 
> Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
> 
> ---
>  arch/i386/mm/discontig.c |   17 +++++++++++++++++
>  arch/i386/mm/init.c      |    4 +---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.19/arch/i386/mm/init.c
> ===================================================================
> --- linux-2.6.19.orig/arch/i386/mm/init.c	2006-12-04 20:06:32.000000000 +0900
> +++ linux-2.6.19/arch/i386/mm/init.c	2006-12-04 21:09:49.000000000 +0900
> @@ -681,10 +681,9 @@
>   * memory to the highmem for now.
>   */
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -#ifndef CONFIG_NEED_MULTIPLE_NODES
>  int arch_add_memory(int nid, u64 start, u64 size)
>  {
> -	struct pglist_data *pgdata = &contig_page_data;
> +	struct pglist_data *pgdata = NODE_DATA(nid);
>  	struct zone *zone = pgdata->node_zones + ZONE_HIGHMEM;
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> @@ -697,7 +696,6 @@
>  	return -EINVAL;
>  }
>  #endif
> -#endif
>  
>  kmem_cache_t *pgd_cache;
>  kmem_cache_t *pmd_cache;

The reason for the #ifndef CONFIG_NEED_MULTIPLE_NODES check seems to 
solely exist for excluding the NUMA case, so it doesn't appear as though 
this is the correct fix since your changelog indicates a compile problem 
with a NUMA build.  This hypothesis is supported by the comment which 
conveniently appears just before arch_add_memory which _explicitly_ states 
that the following is for non-NUMA cases.

> Index: linux-2.6.19/arch/i386/mm/discontig.c
> ===================================================================
> --- linux-2.6.19.orig/arch/i386/mm/discontig.c	2006-12-04 20:06:32.000000000 +0900
> +++ linux-2.6.19/arch/i386/mm/discontig.c	2006-12-09 17:30:24.000000000 +0900
> @@ -405,3 +405,20 @@
>  	totalram_pages += totalhigh_pages;
>  #endif
>  }
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +/* This is the case that there is no _PXM on DSDT for added memory */
> +int memory_add_physaddr_to_nid(u64 addr)
> +{
> +	int nid;
> +	unsigned long pfn = addr >> PAGE_SHIFT;
> +
> +	for (nid = 0; nid < MAX_NUMNODES; nid++){
> +		if (node_start_pfn[nid] <= pfn &&
> +		    pfn < node_end_pfn[nid])
> +			return nid;
> +	}
> +
> +	return 0;
> +}
> +#endif
> 

memory_add_physaddr_to_nid is only declared as extern in 
include/linux/memory_hotplug.h in the CONFIG_NUMA case so this also 
doesn't appear as the correct fix but probably worked for your compile 
since you had CONFIG_MEMORY_HOTPLUG enabled.

		David
