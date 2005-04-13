Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVDMUnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDMUnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVDMUnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:43:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4318 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261188AbVDMUni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:43:38 -0400
Date: Wed, 13 Apr 2005 21:43:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-ID: <20050413204335.GA17012@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <16987.39773.267117.925489@jaguar.mkp.net> <20050412032747.51c0c514.akpm@osdl.org> <yq07jj8123j.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq07jj8123j.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 10:50:08AM -0400, Jes Sorensen wrote:
> +config MSPEC
> +	tristate "Special Memory support"
> +	select GENERIC_ALLOCATOR

should depend on IA64_GENERIC || IA64_SGI_SN2 because it's using sn2
functions like bte_copy

> +#define BTE_ZERO_BLOCK(_maddr, _len) \
> +	bte_copy(0, _maddr - __IA64_UNCACHED_OFFSET, _len, BTE_WACQUIRE | BTE_ZERO_FILL, NULL)

should become an line function.

> +static int fetchop_mmap(struct file *file, struct vm_area_struct *vma);
> +static int cached_mmap(struct file *file, struct vm_area_struct *vma);
> +static int uncached_mmap(struct file *file, struct vm_area_struct *vma);
> +static void mspec_open(struct vm_area_struct *vma);
> +static void mspec_close(struct vm_area_struct *vma);
> +static struct page * mspec_nopage(struct vm_area_struct *vma,
> +					unsigned long address, int *unused);

please try to reorder the code to avoid forward-prototypes where easily
possible.

> +/*
> + * There is one of these structs per node. It is used to manage the mspec
> + * space that is available on the node. Current assumption is that there is
> + * only 1 mspec block of memory per node.
> + */
> +struct node_mspecs {
> +	long		maddr;		/* phys addr of start of mspecs. */
> +	int		count;		/* Total number of mspec pages. */
> +	atomic_t	free;		/* Number of pages currently free. */
> +	unsigned long	bits[1];	/* Bitmap for managing pages. */

Please use the bits[0] gcc extensions so all the calculations for the
variable sized array easily make sense.

> +/*
> + * One of these structures is allocated when an mspec region is mmaped. The
> + * structure is pointed to by the vma->vm_private_data field in the vma struct. 
> + * This structure is used to record the addresses of the mspec pages.
> + */
> +struct vma_data {
> +	atomic_t	refcnt;		/* Number of vmas sharing the data. */
> +	spinlock_t	lock;		/* Serialize access to the vma. */
> +	int		count;		/* Number of pages allocated. */
> +	int		type;		/* Type of pages allocated. */
> +	unsigned long	maddr[1];	/* Array of MSPEC addresses. */

dito

> +};
> +
> +
> +/*
> + * Memory Special statistics.
> + */
> +struct mspec_stats {
> +	atomic_t	map_count;	/* Number of active mmap's */
> +	atomic_t	pages_in_use;	/* Number of mspec pages in use */
> +	unsigned long	pages_total;	/* Total number of mspec pages */
> +};
> +
> +static struct mspec_stats	mspec_stats;
> +static struct node_mspecs	*node_mspecs[MAX_NUMNODES];
> +
> +#define MAX_UNCACHED_GRANULES	5
> +static int allocated_granules;
> +
> +struct gen_pool *mspec_pool[MAX_NUMNODES];

> +static unsigned long
> +mspec_get_new_chunk(struct gen_pool *poolp)
> +{
> +	struct page *page;
> +	void *tmp;
> +	int status, node, i;
> +	unsigned long addr;
> +
> +	if (allocated_granules >= MAX_UNCACHED_GRANULES)
> +		return 0;
> +
> +	node = (int)poolp->private;

maybe the private data in the genpool should be an union of
void * and unsigned long so we can avoid all those casrs?

> +	page = alloc_pages_node(node, GFP_KERNEL,
> +				IA64_GRANULE_SHIFT-PAGE_SHIFT);

> +	tmp = page_address(page);
> +	memset(tmp, 0, IA64_GRANULE_SIZE);

shouldn't you just use __GFP_ZERO?

> +#if DEBUG
> +	printk(KERN_INFO "pal_prefetch_visibility() returns %i on cpu %i\n",
> +	       status, get_cpu());
> +#endif

same dprintk comment as for genalloc.

> +	vdata->lock = SPIN_LOCK_UNLOCKED;

you're supposed to use spin_lock_init() these days.

> +/*
> + * mspec_get_one_pte
> + *
> + * Return the pte for a given mm and address.
> + */
> +static __inline__ int
> +mspec_get_one_pte(struct mm_struct *mm, u64 address, pte_t **pte)
> +{
> +	pgd_t *pgd;
> +	pmd_t *pmd;
> +	pud_t *pud;
> +
> +	pgd = pgd_offset(mm, address);
> +	if (pgd_present(*pgd)) {
> +		pud = pud_offset(pgd, address);
> +		if (pud_present(*pud)) {
> +			pmd = pmd_offset(pud, address);
> +			if (pmd_present(*pmd)) {
> +				*pte = pte_offset_map(pmd, address);
> +				if (pte_present(**pte)) {
> +					return 0;
> +				}
> +			}
> +		}
> +	}
> +
> +	return -1;
> +}

> +	spin_lock(&vdata->lock);
> +
> +	index = (address - vma->vm_start) >> PAGE_SHIFT;
> +	if (vdata->maddr[index] == 0) {
> +		vdata->count++;
> +		maddr = mspec_alloc_page(numa_node_id(), vdata->type);

this looks like a page allocation under spinlock.

> +	/*
> +	 * The kernel requires a page structure to be returned upon
> +	 * success, but there are no page structures for low granule pages.
> +	 * remap_page_range() creates the pte for us and we return a
> +	 * bogus page back to the kernel fault handler to keep it happy
> +	 * (the page is freed immediately there).
> +	 */

Please don't use the ->nopage approach thenm but do remap_pfn_range
beforehand.  ->nopage is very nice if the region is actually backed by
normal RAM, but what you're doing doesn't make much sense.

> +/*
> + * Walk the EFI memory map to pull out leftover pages in the lower
> + * memory regions which do not end up in the regular memory map and
> + * stick them into the uncached allocator
> + */
> +static void __init
> +mspec_walk_efi_memmap_uc (void)

I'm pretty sure this was NACKed on the ia64 list, and SGI was told to do
a more generic efi memmap walk.

> +	/*
> +	 * The fetchop device only works on SN2 hardware, uncached and cached
> +	 * memory drivers should both be valid on all ia64 hardware
> +	 */

In which case my above comment about the depency doesn't make sense, but
you'll have to split the driver into separate files or add ifdefs.  Please
test it on some non-sgi hardware with a non-generic kernel build.

> +	printk(KERN_INFO "%s: v%s\n", FETCHOP_DRIVER_ID_STR, REVISION);
> +	printk(KERN_INFO "%s: v%s\n", CACHED_DRIVER_ID_STR, REVISION);
> +	printk(KERN_INFO "%s: v%s\n", UNCACHED_DRIVER_ID_STR, REVISION);

Please keep the noise level down and remove these.

> +unsigned long
> +mspec_kalloc_page(int nid)
> +{
> +	return TO_AMO(mspec_alloc_page(nid, MSPEC_FETCHOP));
> +}
> +
> +
> +void
> +mspec_kfree_page(unsigned long maddr)
> +{
> +	mspec_free_page(TO_PHYS(maddr) + __IA64_UNCACHED_OFFSET);
> +}
> +EXPORT_SYMBOL(mspec_kalloc_page);
> +EXPORT_SYMBOL(mspec_kfree_page);

What is this for?  these look like really odd APIs.

