Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVANJaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVANJaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVANJap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:30:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:29421 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261843AbVANJaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:30:25 -0500
Date: Fri, 14 Jan 2005 20:35:19 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       rusty@rustcorp.com.au, dipankar@in.ibm.com
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
Message-ID: <20050114150519.GA3189@impedimenta.in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com> <20050113005730.0e10b2d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113005730.0e10b2d9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 12:57:30AM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> >
> > ...
> > The following patch re-implements the linux dynamic percpu memory allocator
> 
> Heavens, it's complex.

:p

> 
> > 1. Percpu memory dereference is faster 
> > 	- One less memory reference compared to existing simple alloc_percpu
> > 	- As fast as with static percpu areas, one mem ref less actually.
> > 2. Better memory usage
> > 	- Doesn't need a NR_CPUS pointer array for each allocation
> > 	- Interlaces objects making better utilization of memory/cachelines
> > 	- Userspace tests show 98% utilization with random sized allocations
> > 	  after repeated random frees
> > 3. Provides truly node local allocation
> > 	- The percpu memory with existing alloc_percpu does node local
> > 	  allocation, but the NR_CPUS place holder is not node local. This
> > 	  problem doesn't exist with the new implementation.
> 
> But it does consume vmalloc space and will incur additional TLB reload
> costs.
> 
> > +static void *
> > +valloc_percpu(void)
> > +{
> > +	int i,j = 0;
> > +	unsigned int nr_pages;
> > +	struct vm_struct *area, tmp;
> > +	struct page **tmppage;
> > +	struct page *pages[BLOCK_MANAGEMENT_PAGES];
> 
> How much stackspace is this guy using on 512-way?

36 bytes. BLOCK_MANAGEMENT_PAGES is not dependent on NR_CPUS.  It depends
on the number of objects in a block -- depends on the currency size and
the max obj size.  With current values, BLOCK_MANAGEMENT_PAGES is 9

> 
> > +	unsigned int cpu_pages = PCPU_BLKSIZE >> PAGE_SHIFT;
> > +	struct pcpu_block *blkp = NULL;
> > +
> > +	BUG_ON(!IS_ALIGNED(PCPU_BLKSIZE, PAGE_SIZE));
> > +	BUG_ON(!PCPU_BLKSIZE);
> > +	nr_pages = PCPUPAGES_PER_BLOCK + BLOCK_MANAGEMENT_PAGES;	
> > +
> > +	/* Alloc Managent block pages */
> > +	for ( i = 0; i < BLOCK_MANAGEMENT_PAGES; i++) {
> > +		pages[i] = alloc_pages(GFP_KERNEL, 0);
> 
> Can use __GFP_ZERO here.
> 
> > +		if (!pages[i]) {
> > +			while ( --i >= 0 ) 
> > +				__free_pages(pages[i], 0);
> > +			return NULL;
> > +		}
> > +		/* Zero the alloced page */
> > +		clear_page(page_address(pages[i]));
> 
> And so can remove this.
> 
> Cannot highmem pages be used here?

Yes. Will change patch to do that.

> 
> > +	for ( i = 0; i < BLOCK_MANAGEMENT_PAGES; i++)
> 
> Patch has a fair amount of whitespace oddities.

Will fix this.

> 
> > +	/* Alloc node local pages for all cpus possible */
> > +	for (i = 0; i < NR_CPUS; i++) {
> > +		if (cpu_possible(i)) {
> 
> Isn't this equivalent to for_each_cpu()?

Yes. Will fix this too. This patch has been in the cans for quite some time
and for_each_cpu wasn't available when I coded this up...

> 
> > +	/* Map pages for each cpu by splitting vm_struct for each cpu */
> > +	for (i = 0; i < NR_CPUS; i++) {
> > +		if (cpu_possible(i)) {
> 
> etc.
> 
> > +/* Sort obj_map array in ascending order -- simple bubble sort */
> > +static void
> > +sort_obj_map(struct obj_map_elmt map[], int nr)
> 
> That'll be unpopular ;)  Why not extract qsort from XFS?

Ok, I'll make a patch to move qsort to a common place like linux/lib 
and use it in the next iteration.  Just out of curiosity, is bubble 
sort unpopular or having two sort functions in the kernel source tree an
issue here?

> 
> Why cannot the code simply call vmalloc rather than copying its internals?

Node local allocation. vmalloc cannot ensure pages for correspomding
cpus are node local.  Also, design goal was to allocate pages for 
cpu_possible cpus only.  With plain vmalloc, we will end up allocating 
pages for NR_CPUS.

> 
> Have you considered trying a simple __alloc_pages, fall back to vmalloc if
> that fails, or if the requested size is more than eight pages, or something
> of that sort?

Again, node local allocation will be difficult and also this means we 
allocate pages for !cpu_possible cpus too.

I am travelling (we have a long weekend here), I will mail the revised patch
early next week.  Thanks for the review comments.


Thanks,
Kiran
Thanks,
Kiran
