Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVAMI62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVAMI62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVAMI61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:58:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:44433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261322AbVAMI5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:57:54 -0500
Date: Thu, 13 Jan 2005 00:57:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       rusty@rustcorp.com.au, dipankar@in.ibm.com
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
Message-Id: <20050113005730.0e10b2d9.akpm@osdl.org>
In-Reply-To: <20050113083412.GA7567@impedimenta.in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> ...
> The following patch re-implements the linux dynamic percpu memory allocator

Heavens, it's complex.

> 1. Percpu memory dereference is faster 
> 	- One less memory reference compared to existing simple alloc_percpu
> 	- As fast as with static percpu areas, one mem ref less actually.
> 2. Better memory usage
> 	- Doesn't need a NR_CPUS pointer array for each allocation
> 	- Interlaces objects making better utilization of memory/cachelines
> 	- Userspace tests show 98% utilization with random sized allocations
> 	  after repeated random frees
> 3. Provides truly node local allocation
> 	- The percpu memory with existing alloc_percpu does node local
> 	  allocation, but the NR_CPUS place holder is not node local. This
> 	  problem doesn't exist with the new implementation.

But it does consume vmalloc space and will incur additional TLB reload
costs.

> +static void *
> +valloc_percpu(void)
> +{
> +	int i,j = 0;
> +	unsigned int nr_pages;
> +	struct vm_struct *area, tmp;
> +	struct page **tmppage;
> +	struct page *pages[BLOCK_MANAGEMENT_PAGES];

How much stackspace is this guy using on 512-way?

> +	unsigned int cpu_pages = PCPU_BLKSIZE >> PAGE_SHIFT;
> +	struct pcpu_block *blkp = NULL;
> +
> +	BUG_ON(!IS_ALIGNED(PCPU_BLKSIZE, PAGE_SIZE));
> +	BUG_ON(!PCPU_BLKSIZE);
> +	nr_pages = PCPUPAGES_PER_BLOCK + BLOCK_MANAGEMENT_PAGES;	
> +
> +	/* Alloc Managent block pages */
> +	for ( i = 0; i < BLOCK_MANAGEMENT_PAGES; i++) {
> +		pages[i] = alloc_pages(GFP_KERNEL, 0);

Can use __GFP_ZERO here.

> +		if (!pages[i]) {
> +			while ( --i >= 0 ) 
> +				__free_pages(pages[i], 0);
> +			return NULL;
> +		}
> +		/* Zero the alloced page */
> +		clear_page(page_address(pages[i]));

And so can remove this.

Cannot highmem pages be used here?

> +	for ( i = 0; i < BLOCK_MANAGEMENT_PAGES; i++)

Patch has a fair amount of whitespace oddities.

> +	/* Alloc node local pages for all cpus possible */
> +	for (i = 0; i < NR_CPUS; i++) {
> +		if (cpu_possible(i)) {

Isn't this equivalent to for_each_cpu()?

> +	/* Map pages for each cpu by splitting vm_struct for each cpu */
> +	for (i = 0; i < NR_CPUS; i++) {
> +		if (cpu_possible(i)) {

etc.

> +/* Sort obj_map array in ascending order -- simple bubble sort */
> +static void
> +sort_obj_map(struct obj_map_elmt map[], int nr)

That'll be unpopular ;)  Why not extract qsort from XFS?

Why cannot the code simply call vmalloc rather than copying its internals?

Have you considered trying a simple __alloc_pages, fall back to vmalloc if
that fails, or if the requested size is more than eight pages, or something
of that sort?
