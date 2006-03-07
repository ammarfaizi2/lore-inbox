Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751986AbWCHBEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbWCHBEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWCHBEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:04:00 -0500
Received: from fmr14.intel.com ([192.55.52.68]:27092 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751986AbWCHBD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:03:59 -0500
Subject: Re: [Patch] Move swiotlb_init early on X86_64
From: Zou Nan hai <nanhai.zou@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
In-Reply-To: <200603070939.03368.ak@suse.de>
References: <1141175458.2642.78.camel@linux-znh>
	 <200603070939.03368.ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1141773788.2537.27.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Mar 2006 07:23:08 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 16:39, Andi Kleen wrote:
> On Wednesday 01 March 2006 02:10, Zou Nan hai wrote:
> > on X86_64, swiotlb buffer is allocated in mem_init, after memmap and vfs cache allocation.
> > 
> > On platforms with huge physical memory, 
> > large memmap and vfs cache may eat up all usable system memory 
> > under 4G.
> > 
> > Move swiotlb_init early before memmap is allocated can
> > solve this issue.
> > 
> > Signed-off-by: Zou Nan hai <Nanhai.zou@intel.com>
> 
> 
> I came up with a simpler change now that should fix the problem too.
> It just try to move the memmap to the end of the node. I don't have a system
> big enough to test the original problem though.
> 
> It should be fairly safe because if the allocation fails we just fallback
> to the normal old way of allocating it near the beginning.
> 
> Try to allocate node memmap near the end of node
> 
> This fixes problems with very large nodes (over 128GB) filling up all of 
> the first 4GB with their mem_map and not leaving enough
> space for the swiotlb.
> 
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/x86_64/mm/numa.c   |   12 +++++++++++-
>  include/linux/bootmem.h |    3 +++
>  mm/bootmem.c            |    2 +-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> Index: linux/arch/x86_64/mm/numa.c
> ===================================================================
> --- linux.orig/arch/x86_64/mm/numa.c
> +++ linux/arch/x86_64/mm/numa.c
> @@ -172,7 +172,7 @@ void __init setup_node_bootmem(int nodei
>  /* Initialize final allocator for a zone */
>  void __init setup_node_zones(int nodeid)
>  { 
> -	unsigned long start_pfn, end_pfn; 
> +	unsigned long start_pfn, end_pfn, memmapsize, limit;
>  	unsigned long zones[MAX_NR_ZONES];
>  	unsigned long holes[MAX_NR_ZONES];
>  
> @@ -182,6 +182,16 @@ void __init setup_node_zones(int nodeid)
>  	Dprintk(KERN_INFO "Setting up node %d %lx-%lx\n",
>  		nodeid, start_pfn, end_pfn);
>  
> +	/* Try to allocate mem_map at end to not fill up precious <4GB
> +	   memory. */
> +	memmapsize = sizeof(struct page) * (end_pfn-start_pfn);
> +	limit = end_pfn << PAGE_SHIFT;
> +	NODE_DATA(nodeid)->node_mem_map = 
> +		__alloc_bootmem_core(NODE_DATA(nodeid)->bdata, 
> +				memmapsize, SMP_CACHE_BYTES, 
> +				limit, 
> +				round_down(limit - memmapsize, PAGE_SIZE));
> +

, round_down(limit - memmapsize, PAGE_SIZE), limit);?


Zou Nan hai



