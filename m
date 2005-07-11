Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVGKSWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVGKSWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVGKSTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:19:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261977AbVGKSSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:18:04 -0400
Message-ID: <42D2B774.5080409@redhat.com>
Date: Mon, 11 Jul 2005 14:16:20 -0400
From: Kimball Murray <kmurray@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dirty page tracking patch
References: <20050711131531.8257.62845.sendpatchset@dhcp83-73.boston.redhat.com> <1121088959.3177.24.camel@laptopd505.fenrus.org>
In-Reply-To: <1121088959.3177.24.camel@laptopd505.fenrus.org>
Content-Type: multipart/mixed;
 boundary="------------080008080202000009060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008080202000009060306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:

>On Mon, 2005-07-11 at 09:16 -0400, Kimball Murray wrote:
>  
>
>>Hello to all.
>>
>>	On behalf of Stratus Technologies (www.stratus.com) I'd like to
>>present a patch to the i386 kernel code that will allow developers to track
>>dirty memory pages.  Stratus uses this technique to facilitate bringing
>>separate cpu and memory module "nodes" into lockstep with each other, with
>>a minimum of OS down time. This feature could also be used to provide inputs
>>into memory management algorithms, or to support hot-plug memory dimm modules
>>for specially developed hardware.
>>
>>    
>>
>
>is the stratus code entirely open source/GPL ? (I assume it is since you
>EXPORT_SYMBOL_GPL and also use other similar stuff). If so.. could you
>post an URL to that? It's customary to do so when you post interface
>patches for review so that the users of the interfaces can be seen, and
>thus the interface better reviewed.
>
I don't have access to a Stratus web server where I could post the code, 
since I'm currently sitting at a Redhat desk :)  So if you'll indulge 
me, I'll attach the harvest code to this note.  The harvest code is one 
component of a GPL'd kernel module.  The harvest component is the only 
one that interacts with the dirty page tracking patch.  Other parts of 
the module do PCI-hotplug related things that are specific to our platform.

For the purposes of looking at how Stratus uses the harvest and page 
tracking, have a look at the harvest and process_vector functions, both 
of which are called from the brownout_cycle function.  The rest of the 
code in the file is mostly scaffolding to support cpu rendezvous 
operations, and to make call-outs to routines that copy memory pages.

>Also this patch is just plain weird/really corner case...
>
>+#define mm_track(ptep)
>
>you have to make that a do { ; } while (0) define as per kernel
>convention/need
>
>also you now make set_pte() and co more than trivial assignments, please
>convert them to inlines so that typechecking is performed and no double
>evaluation of arguments is done!
>(this is a real problem for code that would do set_pte(pte++, value) in
>a loop or so)
>
thanks,  I'll make those changes and re-build/re-test/re-post.

>-       if (!pte_dirty(*ptep))
>-               return 0;
>-       return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
>+       mm_track(ptep);
>+               return (test_and_clear_bit(_PAGE_BIT_DIRTY,
>&ptep->pte_low) |
>+               test_and_clear_bit(_PAGE_BIT_SOFTDIRTY,
>&ptep->pte_low));
> }
>
>
>are you sure you're not introducing a race condition there?
>and if you're sure, why do you need 2 atomic ops in sequence?
>
I think we're OK there. That code only appears in the sys_msync path
(sync_page_range), after the page table lock is taken.  The only code
that moves hardware dirty bits to software dirty bits is in the harvest
itself (attached).  And that code runs with all other cpus parked.

-kimball


--------------080008080202000009060306
Content-Type: text/plain;
 name="harvest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="harvest.c"

/*
 * Low-level routines for memory mirroring.  Tracks dirty pages and
 * utilizes provided copy routine to transfer pages which have changed
 * between harvest passes.
 *
 * Copyright (C) 2005 Stratus Technologies Bermuda Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
#include "fosil.h"
#include "syncd.h"
#include "harvest.h"

/*
 * The following ifdef allows harvest to be built against a kernel
 * which does not implement memory tracking.
 */
#ifdef CONFIG_MEM_MIRROR

#include <linux/interrupt.h>
#include <linux/mm.h>
#include <linux/vmalloc.h>
#include <linux/highmem.h>
#include <linux/version.h>
#include <asm/io.h>
#include <asm/atomic.h>
#include <asm/tlbflush.h>

#define MAX_COPYRANGE 100	/* this is actually defined in cc/host.h */
#define MB (1024*1024)
#define MERGE_MAX_DELTA 100

#ifdef CONFIG_X86_PAE
typedef unsigned long long paddr_t;	/* physical address type */
#define PADDR_FMT "%09llx"		/* printf format for paddr_t */
#else
typedef unsigned long paddr_t;		/* physical address type */
#define PADDR_FMT "%08lx"		/* printf format for paddr_t */
#endif

enum {
	DBGLVL_NONE     = 0x00,
	DBGLVL_HARVEST  = 0x01,
	DBGLVL_BROWNOUT = 0x02,
	DBGLVL_TIMER    = 0x04,
};

static int dbgmask = DBGLVL_NONE;

#define DBGPRNT(lvl, args...)			\
	({					\
	 if (lvl & dbgmask)			\
	 printk(args);				\
	 })

enum {
	IN_BROWNOUT = 0,
	IN_BLACKOUT = 1,
};

struct syncd_data {
	unsigned long flags[NR_CPUS];
	copy_proc copy;
	sync_proc sync;
	void * context;
	is_pfn_valid_proc is_pfn_valid;
	int status;		// return status from command inside blackout
	int max_range;		// # of valid ranges in following CopyRange
	fosil_page_range_t CopyRange[MAX_COPYRANGE];
	unsigned long duration_in_ms;	// blackout during
	unsigned long bitcnt;	// number of bits find in last harvest
	int blackout;		// 1 == blackout, 0 == brownout
	int pass;		// # of times through harvest/process cycle
	int done;		// 1 == done - time to leave
	unsigned int threshold;	// number of dirty pages before sync
};

static void harvest_page(pgd_t * pgd_base, unsigned long addr)
{
	// for all pages in this vm_area_struct
	pgd_t *pgd;
	pmd_t *pmd;
	pte_t *pte;
	pmd_t newpmd;

#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,12)
	pud_t *pud;
#endif
	DBGPRNT(DBGLVL_HARVEST, "pgd_base %p + offset %ld\n",
			pgd_base, pgd_index(addr));

	DBGPRNT(DBGLVL_HARVEST, "    pgd[0] %09llx\n", pgd_val(pgd_base[0]));
	DBGPRNT(DBGLVL_HARVEST, "    pgd[1] %09llx\n", pgd_val(pgd_base[1]));
	DBGPRNT(DBGLVL_HARVEST, "    pgd[2] %09llx\n", pgd_val(pgd_base[2]));
	DBGPRNT(DBGLVL_HARVEST, "    pgd[3] %09llx\n", pgd_val(pgd_base[3]));

	pgd = pgd_base + pgd_index(addr);
	if (pgd_none(*pgd))
		return;

	if (!pgd_present(*pgd))
		return;

#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,12)
	pud = pud_offset(pgd, addr);
	if (pud_none(*pud))
		return;
	pmd = pmd_offset(pud, addr);
#else
	pmd = pmd_offset(pgd, addr);
#endif

	DBGPRNT(DBGLVL_HARVEST, "        pmd[%ld] %p is %llx\n",
			pmd_index(addr), pmd, pmd_val(*pmd));

	if (pmd_none(*pmd))
		return;

	if (!pmd_present(*pmd))
		return;

	newpmd = *pmd;

	// large pages
#ifdef CONFIG_X86_PAE
	if (pmd_large(newpmd)) {
		paddr_t i;
		paddr_t start, end;

		if ((pmd_val(newpmd) & (_PAGE_ACCESSED | _PAGE_DIRTY)) == 0)
			return;

		if (pmd_val(newpmd) & _PAGE_DIRTY)  {
			pmd_val(newpmd) &= ~_PAGE_DIRTY;
			pmd_val(newpmd) |= _PAGE_SOFTDIRTY;
		}

		if (pmd_val(newpmd) & _PAGE_ACCESSED)  {
			pmd_val(newpmd) &= ~_PAGE_ACCESSED;
		}

		if (pmd_val(*pmd) != pmd_val(newpmd)) {
			set_pmd(pmd, newpmd);
			// track the modified pmd
			if (pmd_val(*pmd) & _PAGE_BIT_GLOBAL)
				__flush_tlb_global();
			else
				__flush_tlb_one(addr);
			mm_track(&__pmd(__pa(pmd)));
		}

		start = pmd_val(newpmd) & ~((1LL<<PMD_SHIFT)-1);
		end   = start + ((1LL<<PMD_SHIFT) - 1);

		for (i = start; i < end; i += PAGE_SIZE) {
			mm_track(&i);
		}

		return;
	}
#endif

	/* 
	 * We only want to account for the hw access bit that are set in the
	 * page diretory and page table pages from the user side and not
	 * for the kernel page table. This is because we copy all the 
	 * page table pages in host_trigger_smi for the kernel space
	 *
 	 * The fact that we are here implies that we have set the 
	 * accessed bit. So, clear the bit and add it to the list of
	 * pages to be data moved.
	 */

	if ((pgd_base != init_mm.pgd) && (pmd_val(newpmd) & _PAGE_ACCESSED)) {

	        pmd_val(newpmd) &= ~_PAGE_ACCESSED;
	}

	if (pmd_val(*pmd) != pmd_val(newpmd)) {
		set_pmd(pmd, newpmd);
		// track the pmd as it was just modified
		mm_track(&__pmd(__pa(pmd)));
	}

	if (addr < PAGE_OFFSET)
		pte = pte_offset_map(pmd, addr);
	else
		pte = pte_offset_kernel(pmd, addr);

	DBGPRNT(DBGLVL_HARVEST, "            page table %llx\n",
		pmd_val(*pmd) & PAGE_MASK);
	DBGPRNT(DBGLVL_HARVEST, "            pte[%ld] %p is %llx\n",
		pte_index(addr), pte, pte_val(*pte));

	if (pte_present(*pte)) {
		pte_t newpte;

		newpte = *pte;

		if (pte_val(newpte) & _PAGE_ACCESSED) {
			newpte.pte_low &= ~_PAGE_ACCESSED;
		}

		if (pte_val(newpte) & _PAGE_DIRTY) {
			newpte.pte_low &= ~_PAGE_DIRTY;
			newpte.pte_low |= _PAGE_SOFTDIRTY;
		}

		if (pte_val(*pte) != pte_val(newpte)) {
			set_pte(pte, newpte);
			// Add the page table itself as we just dirtied it
			if (pte_val(*pte) & _PAGE_BIT_GLOBAL)
				__flush_tlb_global();
			else
				__flush_tlb_one(addr);
			mm_track(pmd);
		}
	}

	DBGPRNT(DBGLVL_HARVEST, "a           pte[%ld] %p is %llx\n",
		pte_index(addr), pte, pte_val(*pte));

	if (addr < PAGE_OFFSET)
		pte_unmap(pte);

	return;
}

static void harvest_kernel(void)
{
	unsigned long addr;

	for (addr = PAGE_OFFSET; addr; addr += PAGE_SIZE)
		harvest_page(init_mm.pgd, addr);
}

/*
 * Find all the hardware dirty bits and move them to soft dirty bits.
 * All cpus have checked in to a rendezvous, so we don't need page table
 * locks, etc.
 */
static unsigned long harvest(void * __attribute__ ((unused)) unused_arg)
{
	struct list_head * m = NULL;
	struct mm_struct * mmentry;
	struct vm_area_struct * mmap, * vma;
	unsigned long addr;

	m = &init_mm.mmlist;

	do {
		mmentry = list_entry(m, struct mm_struct, mmlist);
		m = m->next;

		vma = mmap = mmentry->mmap;
		if (!mmap)
			continue;

		do {
			unsigned long start, end;

			if (!vma)
				break;

			start = vma->vm_start;
			end   = vma->vm_end;

			for (addr = start; addr <= end; addr += PAGE_SIZE)
				harvest_page(mmentry->pgd, addr);

		} while ((vma = vma->vm_next) != mmap);
	} while (m != &init_mm.mmlist);

	harvest_kernel();

	return 0;
}

#define VIRT_TO_PFN(pfn) (virt_to_phys(pfn) >> PAGE_SHIFT)

/*
 * Look for set bits in the mm_tracking_struct bit vector.
 * Each bit set is a page that we need to copy from online to
 * offline board.
 */
static void process_vector(void * arg)
{
	struct syncd_data * x = (struct syncd_data *) arg;
	unsigned long pfn;
	unsigned long start_pfn, runlength;

	// traverse the the bitmap looking for dirty pages
	runlength = 0;
	start_pfn = 0;
	for (pfn = 0; pfn < mm_tracking_struct.bitcnt; pfn++) {
		if (test_and_clear_bit(pfn, mm_tracking_struct.vector) &&
		    (x->is_pfn_valid(pfn))) {
			atomic_dec(&mm_tracking_struct.count);
			if (runlength == 0) {
				start_pfn = pfn;
			}
			runlength++;
		} else if (runlength) {
			x->status = x->copy(start_pfn, runlength,
					    x->blackout, x->context);
			if (x->status != FOSIL_ERR_OK) {
				printk("%s: %d\n", __FUNCTION__, __LINE__);
				return;
			}
			start_pfn = runlength = 0;
		}
	}
}

static void enable_tracking(void)
{
	// initialize tracking structure
	atomic_set(&mm_tracking_struct.count, 0);
	memset(mm_tracking_struct.vector, 0, mm_tracking_struct.bitcnt/8);

        // turn on tracking
        atomic_set(&mm_tracking_struct.active, 1);
}

static void disable_tracking(void)
{
	// turn off tracking
	atomic_set(&mm_tracking_struct.active, 0);
}

/*
 * Merge adjacent copy ranges.  Ranges must be have a gap no larger than
 * MERGE_MAX_DELTA between them in order to be considered for a merge.
 */
static void merge_ranges(struct syncd_data * x)
{
	int delta;
	int i, ii;

	for (i = 0; i < x->max_range-1; i++) {
		delta = x->CopyRange[i+1].start_page -
			(x->CopyRange[i].start_page +
			 x->CopyRange[i].num_pages);

		// don't merge when the gap is too large
		if (delta > MERGE_MAX_DELTA)
			continue;

		x->CopyRange[i].num_pages += x->CopyRange[i+1].num_pages;
		x->CopyRange[i].num_pages += delta;

		// compress out the merged range
		for (ii = i+1; ii < x->max_range-1; ii++) {
			x->CopyRange[ii].start_page =
				x->CopyRange[ii+1].start_page;
			x->CopyRange[ii].num_pages  =
				x->CopyRange[ii+1].num_pages;
		}

		x->max_range--;
		x->CopyRange[x->max_range].start_page = 0;
		x->CopyRange[x->max_range].num_pages = 0;
	}
}

/*
 * Insert a pfn into the copy range list, adding to an existing range
 * if the new pfn is adjacent.
 */
static int insert_pfn(struct syncd_data * x, unsigned long long val)
{
	int i;

	if (x->max_range == 0)
		goto insert;

	// can val be pre/appended to a range?
	for (i = 0; i < x->max_range; i++) {
		if ((val >= x->CopyRange[i].start_page)
		    && ((x->CopyRange[i].start_page +
			 x->CopyRange[i].num_pages - 1) >= val)) {

		return 0;
		}
		if ((x->CopyRange[i].start_page - val) == 1) {
			x->CopyRange[i].start_page = val;
			x->CopyRange[i].num_pages++;

			merge_ranges(x);

			return 0;
		}

		if ((val - (x->CopyRange[i].start_page +
			    (x->CopyRange[i].num_pages - 1))) == 1) {
			x->CopyRange[i].num_pages++;

			merge_ranges(x);

			return 0;
		}
	}

	// make a new range
 insert:
	if (x->max_range == MAX_COPYRANGE)
		return 1;

	// insert into list, keeping ordered by start
	for (i = 0; i < x->max_range; i++) {
		if (val < x->CopyRange[i].start_page) {
			int ii;

			// shift everybody up one
			for (ii = x->max_range+1; ii > i; ii--) {
				x->CopyRange[ii].start_page =
					x->CopyRange[ii-1].start_page;
				x->CopyRange[ii].num_pages  =
					x->CopyRange[ii-1].num_pages;
			}

			x->CopyRange[i].start_page = val;
			x->CopyRange[i].num_pages = 1;

			x->max_range++;

			return 0;
		}
	}

	x->CopyRange[x->max_range].start_page = val;
	x->CopyRange[x->max_range].num_pages = 1;

	x->max_range++;

	return 0;
}

static unsigned long pmd_pfn(pmd_t pmd)
{
	return (pmd.pmd >> PAGE_SHIFT);
}

/*
 * With a fundamental knowledge of what absolutely MUST be copied
 * by the HOST during blackout, add pfn's to the copy range list.
 *
 * All page tables are added to avoid having to deal with optimizing
 * which ptes might be set dirty or accessed by the last few operations
 * before blackout.
 *
 * After page tables, the remainder of the pages are our known "working
 * set".  This includes the stack frames for this task and processor and
 * the syncd structure (which we are making dirty by compiling this list).
 *
 * Finally, all pages marked as dirty in their pte's are added to the
 * list.  These are pages which escaped the harvest/process cycles and
 * were presumably dirtied between harvest and here.
 */
static int setup_blackout_copylist(struct syncd_data * x)
{
	pgd_t * pgd;
	pmd_t * pmd;
	pte_t * pte;
	unsigned long addr;
	void * ptr;
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,12)
	pud_t *pud;
#endif

	x->max_range = 0;

	// Gather up the kernel page tables (> PAGE_OFFSET to 4GB)
	for (addr = PAGE_OFFSET; addr; addr += PAGE_SIZE) {
		pgd = init_mm.pgd + pgd_index(addr);

		if (pgd_none(*pgd) || !pgd_present(*pgd))
			continue;

#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,12)
#if 1
		pud = pud_offset(pgd, addr);
		pmd = pmd_offset(pud, addr);
#else
		pmd = (pmd_t*)pgd + pmd_index(addr);
#endif
#else
		pmd = pmd_offset(pgd, addr);
#endif

		if (pmd_none(*pmd) || !pmd_present(*pmd))
			continue;

		if (pmd_large(*pmd)) {
			paddr_t pfn, start, end;

			if ((pmd_val(*pmd) & _PAGE_DIRTY) == 0)
				continue;

			if (insert_pfn(x, pmd_pfn(*pmd)))
				return FOSIL_ERR_MERGE_FAIL;

			if (!x->is_pfn_valid(pmd_pfn(*pmd)))
				continue;

			start = pmd_val(*pmd) & ~((1LL<<PMD_SHIFT)-1);
			end   = start & ((1LL<<PMD_SHIFT)-1);

			printk("KAM: pmd large!\n");
			BUG();
			for (pfn = start; pfn < end; pfn += PAGE_SIZE)
				if (insert_pfn(x, pfn))
					return FOSIL_ERR_MERGE_FAIL;

			continue;
		}

		if (insert_pfn(x, pmd_pfn(*pmd)))
			return FOSIL_ERR_MERGE_FAIL;

		pte = pte_offset_kernel(pmd, addr);

		// add the dirty pages we find 
		if (pte_present(*pte) && (pte_val(*pte) & _PAGE_DIRTY))
			if (x->is_pfn_valid(pte_pfn(*pte)))
				if (insert_pfn(x, pte_pfn(*pte)))
					return FOSIL_ERR_MERGE_FAIL;
	}

	// copy the stack we are working from 
	ptr = current;
	if (insert_pfn(x, virt_to_phys(ptr) >> PAGE_SHIFT))
		return FOSIL_ERR_MERGE_FAIL;
	ptr += PAGE_SIZE;
	if (insert_pfn(x, virt_to_phys(ptr) >> PAGE_SHIFT))
		return FOSIL_ERR_MERGE_FAIL;

	// add syncd structure
	if (insert_pfn(x, virt_to_phys(x) >> PAGE_SHIFT))
		return FOSIL_ERR_MERGE_FAIL;

	// compact the list some more?
	merge_ranges(x);

	return FOSIL_ERR_OK;
}

static void __attribute__ ((__unused__)) do_blackout(void * arg)
{
	struct syncd_data * x = (struct syncd_data *) arg;
	fosil_page_range_t ranges[1] = {{0, ~0}};

	x->status = x->sync(1, ranges, &x->duration_in_ms, x->context);
}

/*
 * This is where all processors are sent for blackout processing.  
 * The driving processor is diverted to work on harvest and if necessary
 * entry to Common Code for synchronization.  All other processors are
 * spinning in a rendezvous at the bottom of this routine waiting for
 * the driving processor to finish.
 */
static unsigned long brownout_cycle(void * arg)
{
	struct syncd_data * x = (struct syncd_data *) arg;
	unsigned long long before, after;
	unsigned long delta;

	rdtscll(before);

	harvest(NULL);

	x->bitcnt = atomic_read(&mm_tracking_struct.count);

	if ((x->bitcnt < x->threshold) || (x->pass == 0)) {
		int err;

		x->blackout = IN_BLACKOUT;

		disable_tracking();

		rdtscll(after);

		process_vector(x);
		if (x->status != FOSIL_ERR_OK)
			return 0;

		err = setup_blackout_copylist(x);
		if (err) {
			x->status = err;
			return 0;
		}

		// Call function to copy pages from offline to online board.
		x->status = x->sync(x->max_range,
				    x->CopyRange,
				    &x->duration_in_ms, x->context);
		x->done = 1;

		if (x->status)
			printk("%s: %d (%s)\n", __FUNCTION__, __LINE__,
			       FOSIL_ERR_STRING(x->status));


		delta = after - before;
		return x->duration_in_ms + (delta / cpu_khz);
	}

	return 0;
}

struct blackout_data {
	atomic_t r[4];
	unsigned int oncpu;
	unsigned long (*func)(void *);
	void * arg;
};

static void fosil_blackout(void * arg)
{
	struct blackout_data * x = (struct blackout_data *) arg;
	unsigned long flags;
	unsigned long long before, after;

	local_bh_disable();
	rendezvous(&x->r[0]);
	local_irq_save(flags);
	rendezvous(&x->r[1]);

	if (smp_processor_id() == x->oncpu)
		x->func(x->arg);

	rendezvous(&x->r[2]);
	__flush_tlb_all();
	rendezvous(&x->r[3]);
	local_irq_restore(flags);
	local_bh_enable();
}

/*
 * Call the specified function with the provide argument in
 * during a blackout.  All blackout sequences for harvest
 * result in a flush_tlb_all for the captive processors.
 */
void fosil_exec_onall(unsigned long (*func)(void *), void * arg)
{
	struct blackout_data x;

	init_rendezvous(&x.r[0]);
	init_rendezvous(&x.r[1]);
	init_rendezvous(&x.r[2]);
	init_rendezvous(&x.r[3]);
	x.oncpu = smp_processor_id();
	x.func  = func;
	x.arg   = arg;

	fosil_syncd_start(SYNCD_ON_ALL_PROCESSORS, fosil_blackout, &x, 0);
	fosil_syncd_finish();
}

/*
 * This routine is responsible for driving all of the memory
 * synchronization processing.  When complete the sync function should
 * be called to enter blackout and finalize synchronization.
 */
int fosil_synchronize_memory(copy_proc copy,
			     sync_proc sync,
			     is_pfn_valid_proc is_pfn_valid,
			     unsigned int threshold,
			     unsigned int passes,
			     void * context)
{
	int status;
	struct syncd_data * x;

	x = kmalloc(sizeof(struct syncd_data), GFP_KERNEL);
	if (x == NULL) {
		printk("unable to allocate syncd control structure\n");
		return 1;
	}

	memset(x, 0, sizeof(struct syncd_data));

	x->copy = copy;
	x->sync = sync;
	x->is_pfn_valid = is_pfn_valid;
	x->bitcnt = 0;
	x->blackout = IN_BROWNOUT;
	x->done = 0;
	x->threshold = threshold;
	x->context = context;

	// clean up hardware dirty bits
	fosil_exec_onall(harvest, NULL);

	enable_tracking();

	/*
	 * Copy all memory.  After this we only copy modified
	 * pages, so we need to make sure the unchanged parts
	 * get copied at least once.
	 */
	status = x->copy(0, ~0, 0, x->context);
	if (status != FOSIL_ERR_OK) {
		printk("%s: %d\n", __FUNCTION__, __LINE__);
		return status;
	}

	for (x->pass = passes; (x->pass >= 0); x->pass--) {
		DBGPRNT(DBGLVL_BROWNOUT,
			"brownout pass %d - %ld pages found (%d)\n",
			x->pass, x->bitcnt,
			atomic_read(&mm_tracking_struct.count));

		fosil_exec_onall(brownout_cycle, x);

		if (x->done)
			break;

		process_vector(x);

		if (x->status) {
			printk("%s: %d\n", __FUNCTION__, __LINE__);
			break;
		}
	}

	disable_tracking();
	DBGPRNT(DBGLVL_BROWNOUT, "last pass found %ld pages\n", x->bitcnt);
	DBGPRNT(DBGLVL_BROWNOUT, "copy range max %d\n", x->max_range);

	status = x->status;

	kfree(x);

	return status;
}
EXPORT_SYMBOL(fosil_synchronize_memory);

int __init fosil_harvest_init(void)
{
	extern unsigned long num_physpages;

	mm_tracking_struct.vector = vmalloc(num_physpages/8);
	mm_tracking_struct.bitcnt = num_physpages;

	if (mm_tracking_struct.vector == NULL) {
		printk("%s: unable to allocate memory tracking bitmap\n",
		       __FUNCTION__);
		return -ENOMEM;
	}

	return 0;
}

void __exit fosil_harvest_cleanup(void)
{
	// make sure tracking is definitely turned off
	disable_tracking();

	// wake me after everyone is sure to be done with mm_track()
	synchronize_kernel();

	if (mm_tracking_struct.vector)
		vfree(mm_tracking_struct.vector);

	mm_tracking_struct.bitcnt = 0;

	return;
}

#else /* CONFIG_MEM_MIRROR */

int __init fosil_harvest_init(void)
{
	return 0;
}

void __exit fosil_harvest_cleanup(void)
{
	return;
}

#endif /* CONFIG_MEM_MIRROR */

--------------080008080202000009060306--

