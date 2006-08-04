Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWHDRmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWHDRmj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161342AbWHDRmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:42:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:3535 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161339AbWHDRmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:42:39 -0400
Subject: Re: [PATCH 4/10] hot-add-mem x86_64: Enable SPARSEMEM in srat.c
From: Dave Hansen <haveblue@us.ibm.com>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, discuss@x86-64.org,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
In-Reply-To: <20060804131409.21401.58904.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	 <20060804131409.21401.58904.sendpatchset@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 10:42:32 -0700
Message-Id: <1154713352.10109.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 07:14 -0600, Keith Mannthey wrote:
> From: Keith Mannthey <kmannth@us.ibm.com>
> 
>  Enable x86_64 srat.c to share code between both reserve and sparsemem based add memory
> paths.  Both paths need the hot-add area node locality infomration (nodes_add).  This 
> code refactors the code path to allow this. 

I won't respond to all of these, but the set looks pretty darn sane.  

> Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
> ---
>  srat.c |   51 +++++++++++++++++++++++++++++----------------------
>  1 files changed, 29 insertions(+), 22 deletions(-)
> 
> Files orig/arch/x86_64/mm/.srat.c.swp and current/arch/x86_64/mm/.srat.c.swp differ
> diff -urN orig/arch/x86_64/mm/srat.c current/arch/x86_64/mm/srat.c
> --- orig/arch/x86_64/mm/srat.c	2006-08-04 00:41:17.000000000 -0400
> +++ current/arch/x86_64/mm/srat.c	2006-08-04 01:02:25.000000000 -0400
> @@ -21,12 +21,6 @@
>  #include <asm/numa.h>
>  #include <asm/e820.h>
>  
> -#if (defined(CONFIG_ACPI_HOTPLUG_MEMORY) || \
> -	defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) \
> -		&& !defined(CONFIG_MEMORY_HOTPLUG)
> -#define RESERVE_HOTADD 1
> -#endif

Thanks goodness this is going away :)

>  static struct acpi_table_slit *acpi_slit;
>  
>  static nodemask_t nodes_parsed __initdata;
> @@ -34,9 +28,6 @@
>  static struct bootnode nodes_add[MAX_NUMNODES] __initdata;
>  static int found_add_area __initdata;
>  int hotadd_percent __initdata = 0;
> -#ifndef RESERVE_HOTADD
> -#define hotadd_percent 0	/* Ignore all settings */
> -#endif
>  
>  /* Too small nodes confuse the VM badly. Usually they result
>     from BIOS bugs. */
> @@ -157,7 +148,7 @@
>  	       pxm, pa->apic_id, node);
>  }
>  
> -#ifdef RESERVE_HOTADD
> +#ifdef CONFIG_MEMORY_HOTPLUG_RESERVE
>  /*
>   * Protect against too large hotadd areas that would fill up memory.
>   */
> @@ -200,15 +191,37 @@
>  	return 1;
>  }
>  
> +static int update_end_of_memory(unsigned long end)
> +{
> +	found_add_area = 1;
> +	if ((end >> PAGE_SHIFT) > end_pfn)
> +		end_pfn = end >> PAGE_SHIFT;
> +	return 1;
> +}

I don't have a really strong feeling either way, but you can use
include/linux/pfn.h and PFN_DOWN() here, instead of the explicit >>'s.

> +static inline int save_add_info(void)
> +{
> +	return hotadd_percent > 0;
> +}

This name is a wee bit too generic to be in the global namespace.
Perhaps there should be a "memory" in there somewhere.


> -#ifdef RESERVE_HOTADD
> - 	if (ma->flags.hot_pluggable && reserve_hotadd(node, start, end) < 0) {
> + 	if (ma->flags.hot_pluggable && !reserve_hotadd(node, start, end) < 0) {
>  		/* Ignore hotadd region. Undo damage */
>  		printk(KERN_NOTICE "SRAT: Hotplug region ignored\n");
>  		*nd = oldnode;
>  		if ((nd->start | nd->end) == 0)
>  			node_clear(node, nodes_parsed);
>  	}
> -#endif
>  }

Cool.  No more #ifdef.

-- Dave

