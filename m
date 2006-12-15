Return-Path: <linux-kernel-owner+w=401wt.eu-S1753100AbWLOR5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbWLOR5n (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbWLOR5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:57:43 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2182 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbWLOR5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:57:42 -0500
X-Greylist: delayed 2736 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 12:57:42 EST
Message-ID: <4582D756.7090702@shadowen.org>
Date: Fri, 15 Dec 2006 17:11:50 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       mkravetz@us.ibm.com, hch@infradead.org, jk@ozlabs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@samba.org,
       benh@kernel.crashing.org, gone@us.ibm.com
Subject: Re: [PATCH] Fix sparsemem on Cell
References: <20061215165335.61D9F775@localhost.localdomain>
In-Reply-To: <20061215165335.61D9F775@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> I think the comments added say it pretty well, but I'll repeat it here.
> 
> This fix is pretty similar in concept to the one that Arnd posted
> as a temporary workaround, but I've added a few comments explaining
> what the actual assumptions are, and improved it a wee little bit.
> 
> The end goal here is to simply avoid calling the early_*() functions
> when it is _not_ early.  Those functions stop working as soon as
> free_initmem() is called.  system_state is set to SYSTEM_RUNNING
> just after free_initmem() is called, so it seems appropriate to use
> here.
> 
> I did think twice about actually using SYSTEM_RUNNING because we
> moved away from it in other parts of memory hotplug, but those
> were actually for _allocations_ in favor of slab_is_available(),
> and we really don't care about the slab here.
> 
> The only other assumption is that all memory-hotplug-time pages 
> given to memmap_init_zone() are valid and able to be onlined into
> any any zone after the system is running.  The "valid" part is
> really just a question of whether or not a 'struct page' is there
> for the pfn, and *not* whether there is actual memory.  Since
> all sparsemem sections have contiguous mem_map[]s within them,
> and we only memory hotplug entire sparsemem sections, we can
> be confident that this assumption will hold.

ie. that if hotplug is pushing this memory into a zone on a node it 
really does know what its doing, and its putting it in the right place. 
  Obviously that code needs to be 'overlap' aware but thats ok for this 
interface.

> 
> As for the memory being in the right node, we'll assume tha
> memory hotplug is putting things in the right node.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> 
> ---
> 
>  lxc-dave/init/main.c     |    4 ++++
>  lxc-dave/mm/page_alloc.c |   28 +++++++++++++++++++++++++---
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff -puN init/main.c~sparsemem-fix init/main.c
> --- lxc/init/main.c~sparsemem-fix	2006-12-15 08:49:53.000000000 -0800
> +++ lxc-dave/init/main.c	2006-12-15 08:49:53.000000000 -0800
> @@ -770,6 +770,10 @@ static int init(void * unused)
>  	free_initmem();
>  	unlock_kernel();
>  	mark_rodata_ro();
> +	/*
> +	 * Memory hotplug requires that this system_state transition
> +	 * happer after free_initmem().  (see memmap_init_zone())
> +	 */

typo: happen

>  	system_state = SYSTEM_RUNNING;
>  	numa_default_policy();
>  
> diff -puN mm/page_alloc.c~sparsemem-fix mm/page_alloc.c
> --- lxc/mm/page_alloc.c~sparsemem-fix	2006-12-15 08:49:53.000000000 -0800
> +++ lxc-dave/mm/page_alloc.c	2006-12-15 08:49:53.000000000 -0800
> @@ -2056,6 +2056,30 @@ static inline unsigned long wait_table_b
>  
>  #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
>  
> +static int can_online_pfn_into_nid(unsigned long pfn, int nid)
> +{

__meminit ?

> +	/*
> +	 * There are two things that make this work:
> +	 * 1. The early_pfn...() functions are __init and
> +	 *    use __initdata.  If the system is < SYSTEM_RUNNING,
> +	 *    those functions and their data will still exist.
> +	 * 2. We also assume that all actual memory hotplug
> +	 *    (as opposed to boot-time) calls to this are only
> +	 *    for contiguous memory regions.  With sparsemem,
> +	 *    this guaranteed is easy because all sections are
> +	 *    contiguous and we never online more than one
> +	 *    section at a time.  Boot-time memory can have holes
> +	 *    anywhere.
> +	 */
> +	if (system_state >= SYSTEM_RUNNING)
> +		return 1;

Is there any value in codifying the assumption here, as a safety net?

if (system_state >= SYSTEM_RUNNING)
#ifdef CONFIG_SPARSEMEM
	return 1;
#else
	return 0;
#endif

> +	if (!early_pfn_valid(pfn))
> +		return 0;
> +	if (!early_pfn_in_nid(pfn, nid))
> +		return 0;
> +	return 1;
> +}
> +
>  /*
>   * Initially all pages are reserved - free ones are freed
>   * up by free_all_bootmem() once the early boot process is
> @@ -2069,9 +2093,7 @@ void __meminit memmap_init_zone(unsigned
>  	unsigned long pfn;
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> -		if (!early_pfn_valid(pfn))
> -			continue;
> -		if (!early_pfn_in_nid(pfn, nid))
> +		if (!can_online_pfn_into_nid(pfn))

We're not passing nid here?

>  			continue;
>  		page = pfn_to_page(pfn);
>  		set_page_links(page, zone, nid, pfn);
> _

Looks like this would do the job to me.

-apw
