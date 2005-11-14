Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVKNPIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVKNPIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVKNPIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:08:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42730 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751143AbVKNPIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:08:05 -0500
Subject: Re: [RFC] NUMA memory policy support for HUGE pages
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.62.0511111225100.21071@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511111051080.20589@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.62.0511111225100.21071@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 14 Nov 2005 09:06:53 -0600
Message-Id: <1131980814.13502.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 12:28 -0800, Christoph Lameter wrote:
> I just saw that mm2 is out. This is the same patch against mm2 with 
> hugetlb COW support.

This all seems reasonable to me.  Were you planning to send out a
separate patch to support MPOL_BIND?

> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Acked-By: Adam Litke <agl@us.ibm.com>

> Index: linux-2.6.14-mm2/mm/mempolicy.c
> ===================================================================
> --- linux-2.6.14-mm2.orig/mm/mempolicy.c	2005-11-11 12:10:19.000000000 -0800
> +++ linux-2.6.14-mm2/mm/mempolicy.c	2005-11-11 12:11:01.000000000 -0800
> @@ -1179,6 +1179,24 @@ static unsigned offset_il_node(struct me
>  	return nid;
>  }
>  
> +/* Return a zonelist suitable for a huge page allocation. */
> +struct zonelist *huge_zonelist(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	struct mempolicy *pol = get_vma_policy(current, vma, addr);
> +
> +	if (pol->policy == MPOL_INTERLEAVE) {
> +		unsigned nid;
> +		unsigned long off;
> +
> +		off = vma->vm_pgoff;
> +		off += (addr - vma->vm_start) >> HPAGE_SHIFT;
> +		nid = offset_il_node(pol, vma, off);
> +
> +		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
> +	}
> +	return zonelist_policy(GFP_HIGHUSER, pol);
> +}
> +
>  /* Allocate a page in interleaved policy.
>     Own path because it needs to do special accounting. */
>  static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
> Index: linux-2.6.14-mm2/mm/hugetlb.c
> ===================================================================
> --- linux-2.6.14-mm2.orig/mm/hugetlb.c	2005-11-11 12:10:48.000000000 -0800
> +++ linux-2.6.14-mm2/mm/hugetlb.c	2005-11-11 12:23:14.000000000 -0800
> @@ -33,11 +33,12 @@ static void enqueue_huge_page(struct pag
>  	free_huge_pages_node[nid]++;
>  }
>  
> -static struct page *dequeue_huge_page(void)
> +static struct page *dequeue_huge_page(struct vm_area_struct *vma,
> +				unsigned long address)
>  {
>  	int nid = numa_node_id();
>  	struct page *page = NULL;
> -	struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists;
> +	struct zonelist *zonelist = huge_zonelist(vma, address);
>  	struct zone **z;
>  
>  	for (z = zonelist->zones; *z; z++) {
> @@ -83,13 +84,13 @@ void free_huge_page(struct page *page)
>  	spin_unlock(&hugetlb_lock);
>  }
>  
> -struct page *alloc_huge_page(void)
> +struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	struct page *page;
>  	int i;
>  
>  	spin_lock(&hugetlb_lock);
> -	page = dequeue_huge_page();
> +	page = dequeue_huge_page(vma, addr);
>  	if (!page) {
>  		spin_unlock(&hugetlb_lock);
>  		return NULL;
> @@ -192,7 +193,7 @@ static unsigned long set_max_huge_pages(
>  	spin_lock(&hugetlb_lock);
>  	try_to_free_low(count);
>  	while (count < nr_huge_pages) {
> -		struct page *page = dequeue_huge_page();
> +		struct page *page = dequeue_huge_page(NULL, 0);
>  		if (!page)
>  			break;
>  		update_and_free_page(page);
> @@ -361,8 +362,8 @@ void unmap_hugepage_range(struct vm_area
>  	flush_tlb_range(vma, start, end);
>  }
>  
> -static struct page *find_or_alloc_huge_page(struct address_space *mapping,
> -				unsigned long idx, int shared)
> +static struct page *find_or_alloc_huge_page(struct vm_area_struct *vma, unsigned long addr,
> +			struct address_space *mapping, unsigned long idx)
>  {
>  	struct page *page;
>  	int err;
> @@ -374,13 +375,13 @@ retry:
>  
>  	if (hugetlb_get_quota(mapping))
>  		goto out;
> -	page = alloc_huge_page();
> +	page = alloc_huge_page(vma, addr);
>  	if (!page) {
>  		hugetlb_put_quota(mapping);
>  		goto out;
>  	}
>  
> -	if (shared) {
> +	if (vma->vm_flags & VM_SHARED) {
>  		err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
>  		if (err) {
>  			put_page(page);
> @@ -414,7 +415,7 @@ static int hugetlb_cow(struct mm_struct 
>  	}
>  
>  	page_cache_get(old_page);
> -	new_page = alloc_huge_page();
> +	new_page = alloc_huge_page(vma, address);
>  
>  	if (!new_page) {
>  		page_cache_release(old_page);
> @@ -463,8 +464,7 @@ int hugetlb_no_page(struct mm_struct *mm
>  	 * Use page lock to guard against racing truncation
>  	 * before we get page_table_lock.
>  	 */
> -	page = find_or_alloc_huge_page(mapping, idx,
> -			vma->vm_flags & VM_SHARED);
> +	page = find_or_alloc_huge_page(vma, address, mapping, idx);			;
>  	if (!page)
>  		goto out;
>  
> Index: linux-2.6.14-mm2/include/linux/mempolicy.h
> ===================================================================
> --- linux-2.6.14-mm2.orig/include/linux/mempolicy.h	2005-11-11 12:08:24.000000000 -0800
> +++ linux-2.6.14-mm2/include/linux/mempolicy.h	2005-11-11 12:11:01.000000000 -0800
> @@ -159,6 +159,8 @@ extern void numa_policy_init(void);
>  extern void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new);
>  extern struct mempolicy default_policy;
>  extern unsigned next_slab_node(struct mempolicy *policy);
> +extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
> +				unsigned long addr);
>  
>  int do_migrate_pages(struct mm_struct *mm,
>  	const nodemask_t *from_nodes, const nodemask_t *to_nodes, int flags);
> Index: linux-2.6.14-mm2/include/linux/hugetlb.h
> ===================================================================
> --- linux-2.6.14-mm2.orig/include/linux/hugetlb.h	2005-11-11 12:04:14.000000000 -0800
> +++ linux-2.6.14-mm2/include/linux/hugetlb.h	2005-11-11 12:11:01.000000000 -0800
> @@ -22,7 +22,7 @@ int hugetlb_report_meminfo(char *);
>  int hugetlb_report_node_meminfo(int, char *);
>  int is_hugepage_mem_enough(size_t);
>  unsigned long hugetlb_total_pages(void);
> -struct page *alloc_huge_page(void);
> +struct page *alloc_huge_page(struct vm_area_struct *, unsigned long);
>  void free_huge_page(struct page *);
>  int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, int write_access);
> @@ -97,7 +97,7 @@ static inline unsigned long hugetlb_tota
>  #define is_hugepage_only_range(mm, addr, len)	0
>  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
>  						do { } while (0)
> -#define alloc_huge_page()			({ NULL; })
> +#define alloc_huge_page(vma, addr)		({ NULL; })
>  #define free_huge_page(p)			({ (void)(p); BUG(); })
>  #define hugetlb_fault(mm, vma, addr, write)	({ BUG(); 0; })
>  
> 
> 
> 
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

