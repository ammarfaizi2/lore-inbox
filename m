Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbULNPcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbULNPcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULNPcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:32:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:23265 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261530AbULNPar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:30:47 -0500
Subject: Re: Anticipatory prefaulting in the page fault handler V1
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	 <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
	 <41AEBAB9.3050705@pobox.com> <20041201230217.1d2071a8.akpm@osdl.org>
	 <179540000.1101972418@[10.10.2.4]> <41AEC4D7.4060507@pobox.com>
	 <20041202101029.7fe8b303.cliffw@osdl.org>
	 <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1103038096.28318.404.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Dec 2004 09:28:16 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What benchmark are you using to generate the following results?  I'd
like to run this on some of my hardware and see how the results compare.

On Wed, 2004-12-08 at 11:24, Christoph Lameter wrote:
> Standard Kernel on a 512 Cpu machine allocating 32GB with an increasing
> number of threads (and thus increasing parallellism of page faults):
> 
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>  32   3    1    1.416s    138.165s 139.050s 45073.831  45097.498
>  32   3    2    1.397s    148.523s  78.044s 41965.149  80201.646
>  32   3    4    1.390s    152.618s  44.044s 40851.258 141545.239
>  32   3    8    1.500s    374.008s  53.001s 16754.519 118671.950
>  32   3   16    1.415s   1051.759s  73.094s  5973.803  85087.358
>  32   3   32    1.867s   3400.417s 117.003s  1849.186  53754.928
>  32   3   64    5.361s  11633.040s 197.034s   540.577  31881.112
>  32   3  128   23.387s  39386.390s 332.055s   159.642  18918.599
>  32   3  256   15.409s  20031.450s 168.095s   313.837  37237.918
>  32   3  512   18.720s  10338.511s  86.047s   607.446  72752.686
> 
> Patched kernel:
> 
> Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>  32   3    1    1.098s    138.544s 139.063s 45053.657  45057.920
>  32   3    2    1.022s    127.770s  67.086s 48849.350  92707.085
>  32   3    4    0.995s    119.666s  37.045s 52141.503 167955.292
>  32   3    8    0.928s     87.400s  18.034s 71227.407 342934.242
>  32   3   16    1.067s     72.943s  11.035s 85007.293 553989.377
>  32   3   32    1.248s    133.753s  10.038s 46602.680 606062.151
>  32   3   64    5.557s    438.634s  13.093s 14163.802 451418.617
>  32   3  128   17.860s   1496.797s  19.048s  4153.714 322808.509
>  32   3  256   13.382s    766.063s  10.016s  8071.695 618816.838
>  32   3  512   17.067s    369.106s   5.041s 16291.764 1161285.521
> 
> These number are roughly equal to what can be accomplished with the
> page fault scalability patches.
> 
> Kernel patches with both the page fault scalability patches and
> prefaulting:
> 
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
>  32  10    1    4.103s    456.384s 460.046s 45541.992  45544.369
>  32  10    2    4.005s    415.119s 221.095s 50036.407  94484.174
>  32  10    4    3.855s    371.317s 111.076s 55898.259 187635.724
>  32  10    8    3.902s    308.673s  67.094s 67092.476 308634.397
>  32  10   16    4.011s    224.213s  37.016s 91889.781 564241.062
>  32  10   32    5.483s    209.391s  27.046s 97598.647 763495.417
>  32  10   64   19.166s    219.925s  26.030s 87713.212 797286.395
>  32  10  128   53.482s    342.342s  27.024s 52981.744 769687.791
>  32  10  256   67.334s    180.321s  15.036s 84679.911 1364614.334
>  32  10  512   66.516s     93.098s   9.015s131387.893 2291548.865
> 
> The fault rate doubles when both patches are applied.
> 
> And on the high end (512 processors allocating 256G) (No numbers
> for regular kernels because they are extremely slow, also no
> number for a low number of threads. Also very slow)
> 
> With prefaulting:
> 
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
> 256   3    4    8.241s   1414.348s 449.016s 35380.301 112056.239
> 256   3    8    8.306s   1300.982s 247.025s 38441.977 203559.271
> 256   3   16    8.368s   1223.853s 154.089s 40846.272 324940.924
> 256   3   32    8.536s   1284.041s 110.097s 38938.970 453556.624
> 256   3   64   13.025s   3587.203s 110.010s 13980.123 457131.492
> 256   3  128   25.025s  11460.700s 145.071s  4382.104 345404.909
> 256   3  256   26.150s   6061.649s  75.086s  8267.625 663414.482
> 256   3  512   20.637s   3037.097s  38.062s 16460.435 1302993.019
> 
> Page fault scalability patch and prefaulting. Max prefault order
> increased to 5 (max preallocation of 32 pages):
> 
>  Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
> 256  10    8   33.571s   4516.293s 863.021s 36874.099 194356.930
> 256  10   16   33.103s   3737.688s 461.028s 44492.553 363704.484
> 256  10   32   35.094s   3436.561s 321.080s 48326.262 521352.840
> 256  10   64   46.675s   2899.997s 245.020s 56936.124 684214.256
> 256  10  128   85.493s   2890.198s 203.008s 56380.890 826122.524
> 256  10  256   74.299s   1374.973s  99.088s115762.963 1679630.272
> 256  10  512   62.760s    706.559s  53.027s218078.311 3149273.714
> 
> We are getting into an almost linear scalability in the high end with
> both patches and end up with a fault rate > 3 mio faults per second.
> 
> The one thing that takes up a lot of time is still be the zeroing
> of pages in the page fault handler. There is a another
> set of patches that I am working on which will prezero pages
> and led to another an increase in performance by a factor of 2-4
> (if prezeroed pages are available which may not always be the case).
> Maybe we can reach 10 mio fault /sec that way.
> 
> Patch against 2.6.10-rc3-bk3:
> 
> Index: linux-2.6.9/include/linux/sched.h
> ===================================================================
> --- linux-2.6.9.orig/include/linux/sched.h	2004-12-01 10:37:31.000000000 -0800
> +++ linux-2.6.9/include/linux/sched.h	2004-12-01 10:38:15.000000000 -0800
> @@ -537,6 +537,8 @@
>  #endif
> 
>  	struct list_head tasks;
> +	unsigned long anon_fault_next_addr;	/* Predicted sequential fault address */
> +	int anon_fault_order;			/* Last order of allocation on fault */
>  	/*
>  	 * ptrace_list/ptrace_children forms the list of my children
>  	 * that were stolen by a ptracer.
> Index: linux-2.6.9/mm/memory.c
> ===================================================================
> --- linux-2.6.9.orig/mm/memory.c	2004-12-01 10:38:11.000000000 -0800
> +++ linux-2.6.9/mm/memory.c	2004-12-01 10:45:01.000000000 -0800
> @@ -55,6 +55,7 @@
> 
>  #include <linux/swapops.h>
>  #include <linux/elf.h>
> +#include <linux/pagevec.h>
> 
>  #ifndef CONFIG_DISCONTIGMEM
>  /* use the per-pgdat data instead for discontigmem - mbligh */
> @@ -1432,8 +1433,106 @@
>  		unsigned long addr)
>  {
>  	pte_t entry;
> -	struct page * page = ZERO_PAGE(addr);
> +	struct page * page;
> +
> +	addr &= PAGE_MASK;
> +
> + 	if (current->anon_fault_next_addr == addr) {
> + 		unsigned long end_addr;
> + 		int order = current->anon_fault_order;
> +
> +		/* Sequence of page faults detected. Perform preallocation of pages */
> 
> +		/* The order of preallocations increases with each successful prediction */
> + 		order++;
> +
> +		if ((1 << order) < PAGEVEC_SIZE)
> +			end_addr = addr + (1 << (order + PAGE_SHIFT));
> +		else
> +			end_addr = addr + PAGEVEC_SIZE * PAGE_SIZE;
> +
> +		if (end_addr > vma->vm_end)
> +			end_addr = vma->vm_end;
> +		if ((addr & PMD_MASK) != (end_addr & PMD_MASK))
> +			end_addr &= PMD_MASK;
> +
> +		current->anon_fault_next_addr = end_addr;
> +	 	current->anon_fault_order = order;
> +
> +		if (write_access) {
> +
> +			struct pagevec pv;
> +			unsigned long a;
> +			struct page **p;
> +
> +			pte_unmap(page_table);
> +			spin_unlock(&mm->page_table_lock);
> +
> +			pagevec_init(&pv, 0);
> +
> +			if (unlikely(anon_vma_prepare(vma)))
> +				return VM_FAULT_OOM;
> +
> +			/* Allocate the necessary pages */
> +			for(a = addr;a < end_addr ; a += PAGE_SIZE) {
> +				struct page *p = alloc_page_vma(GFP_HIGHUSER, vma, a);
> +
> +				if (p) {
> +					clear_user_highpage(p, a);
> +					pagevec_add(&pv,p);
> +				} else
> +					break;
> +			}
> +			end_addr = a;
> +
> +			spin_lock(&mm->page_table_lock);
> +
> + 			for(p = pv.pages; addr < end_addr; addr += PAGE_SIZE, p++) {
> +
> +				page_table = pte_offset_map(pmd, addr);
> +				if (!pte_none(*page_table)) {
> +					/* Someone else got there first */
> +					page_cache_release(*p);
> +					pte_unmap(page_table);
> +					continue;
> +				}
> +
> + 				entry = maybe_mkwrite(pte_mkdirty(mk_pte(*p,
> + 							 vma->vm_page_prot)),
> + 						      vma);
> +
> +				mm->rss++;
> +				lru_cache_add_active(*p);
> +				mark_page_accessed(*p);
> +				page_add_anon_rmap(*p, vma, addr);
> +
> +				set_pte(page_table, entry);
> +				pte_unmap(page_table);
> +
> + 				/* No need to invalidate - it was non-present before */
> + 				update_mmu_cache(vma, addr, entry);
> +			}
> + 		} else {
> + 			/* Read */
> + 			for(;addr < end_addr; addr += PAGE_SIZE) {
> +				page_table = pte_offset_map(pmd, addr);
> + 				entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
> +				set_pte(page_table, entry);
> +				pte_unmap(page_table);
> +
> + 				/* No need to invalidate - it was non-present before */
> +				update_mmu_cache(vma, addr, entry);
> +
> +			};
> +		}
> +		spin_unlock(&mm->page_table_lock);
> +		return VM_FAULT_MINOR;
> +	}
> +
> +	current->anon_fault_next_addr = addr + PAGE_SIZE;
> +	current->anon_fault_order = 0;
> +
> +	page = ZERO_PAGE(addr);
>  	/* Read-only mapping of ZERO_PAGE. */
>  	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

