Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVDVLY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVDVLY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 07:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVDVLY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 07:24:58 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:12740 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261985AbVDVLVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 07:21:12 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec driver for 2.6.12-rc2-mm3
References: <16987.39773.267117.925489@jaguar.mkp.net>
	<20050412032747.51c0c514.akpm@osdl.org>
	<yq07jj8123j.fsf@jaguar.mkp.net>
	<20050413204335.GA17012@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Apr 2005 07:21:05 -0400
In-Reply-To: <20050413204335.GA17012@infradead.org>
Message-ID: <yq08y3bys4e.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's an updated version of the mspec driver. I have tried to address
pretty much all the issues reported by Christoph. I left out most of
the comments, but specific details on a few items below.

Patch at the end - I hope it's ready for the next -mm release now.

Cheers,
Jes


>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Tue, Apr 12, 2005 at 10:50:08AM -0400, Jes Sorensen
Christoph> wrote:
>> data. */ + spinlock_t lock; /* Serialize access to the vma. */ +
>> int count; /* Number of pages allocated. */ + int type; /* Type of
>> pages allocated. */ + unsigned long maddr[1]; /* Array of MSPEC
>> addresses. */

Christoph> dito

The code use the size to calculate, it could be changed either way,
don't think it's worth making the change.

>> + /* + * The kernel requires a page structure to be returned upon +
>> * success, but there are no page structures for low granule pages.
>> + * remap_page_range() creates the pte for us and we return a + *
>> bogus page back to the kernel fault handler to keep it happy + *
>> (the page is freed immediately there).  + */

Christoph> Please don't use the ->nopage approach thenm but do
Christoph> remap_pfn_range beforehand.  ->nopage is very nice if the
Christoph> region is actually backed by normal RAM, but what you're
Christoph> doing doesn't make much sense.

Thats what I used to think, however you want the node-local setup for
performance reasons. Otherwise I would have switched to remap_pfn_range.

>> +/* + * Walk the EFI memory map to pull out leftover pages in the
>> lower + * memory regions which do not end up in the regular memory
>> map and + * stick them into the uncached allocator + */ +static
>> void __init +mspec_walk_efi_memmap_uc (void)

Christoph> I'm pretty sure this was NACKed on the ia64 list, and SGI
Christoph> was told to do a more generic efi memmap walk.

No the issue back then was that the driver just took the memory and
kept it to itself. The new approach exports it for other users.

...............................


Memory special driver for cached, uncached and 'fetchop' (SGI SN2 specific)
memory mappings, formerly known as fetchop. Mostly Used by parallel
appplictions. 

This patch relies on the PG_uncached support patch and the generic
allocator patch (genalloc).

Signed-off-by: Jes Sorensen <jes@wildopensource.com>


diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/arch/ia64/Kconfig linux-2.6.12-rc2-mm3/arch/ia64/Kconfig
--- linux-2.6.12-rc2-mm3-vanilla/arch/ia64/Kconfig	2005-04-12 02:09:02 -07:00
+++ linux-2.6.12-rc2-mm3/arch/ia64/Kconfig	2005-04-12 02:14:06 -07:00
@@ -217,6 +217,16 @@
 	  If you are compiling a kernel that will run under SGI's IA-64
 	  simulator (Medusa) then say Y, otherwise say N.
 
+config MSPEC
+	tristate "Special Memory support"
+	select GENERIC_ALLOCATOR
+	help
+	  This driver allows for cached and uncached mappings of memory
+	  to user processes. On SGI SN hardware it will also export the
+	  special fetchop memory facility.
+	  Fetchops are atomic memory operations that are implemented in the
+	  memory controller on SGI SN hardware.
+
 config FORCE_MAX_ZONEORDER
 	int
 	default "18"
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/arch/ia64/configs/sn2_defconfig linux-2.6.12-rc2-mm3/arch/ia64/configs/sn2_defconfig
--- linux-2.6.12-rc2-mm3-vanilla/arch/ia64/configs/sn2_defconfig	2005-04-12 02:09:02 -07:00
+++ linux-2.6.12-rc2-mm3/arch/ia64/configs/sn2_defconfig	2005-04-12 02:14:06 -07:00
@@ -82,6 +82,7 @@
 # CONFIG_IA64_CYCLONE is not set
 CONFIG_IOSAPIC=y
 CONFIG_IA64_SGI_SN_SIM=y
+CONFIG_MSPEC=m
 CONFIG_FORCE_MAX_ZONEORDER=18
 CONFIG_SMP=y
 CONFIG_NR_CPUS=512
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/arch/ia64/defconfig linux-2.6.12-rc2-mm3/arch/ia64/defconfig
--- linux-2.6.12-rc2-mm3-vanilla/arch/ia64/defconfig	2005-04-12 02:09:02 -07:00
+++ linux-2.6.12-rc2-mm3/arch/ia64/defconfig	2005-04-12 02:14:06 -07:00
@@ -80,6 +80,7 @@
 CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
 CONFIG_IA64_CYCLONE=y
 CONFIG_IOSAPIC=y
+CONFIG_MSPEC=m
 CONFIG_FORCE_MAX_ZONEORDER=18
 CONFIG_SMP=y
 CONFIG_NR_CPUS=512
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/arch/ia64/kernel/Makefile linux-2.6.12-rc2-mm3/arch/ia64/kernel/Makefile
--- linux-2.6.12-rc2-mm3-vanilla/arch/ia64/kernel/Makefile	2005-03-01 23:38:33 -08:00
+++ linux-2.6.12-rc2-mm3/arch/ia64/kernel/Makefile	2005-04-12 02:14:06 -07:00
@@ -20,6 +20,7 @@
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
+obj-$(CONFIG_MSPEC)		+= mspec.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
 # The gate DSO image is built using a special linker script.
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/arch/ia64/kernel/mspec.c linux-2.6.12-rc2-mm3/arch/ia64/kernel/mspec.c
--- linux-2.6.12-rc2-mm3-vanilla/arch/ia64/kernel/mspec.c	1969-12-31 16:00:00 -08:00
+++ linux-2.6.12-rc2-mm3/arch/ia64/kernel/mspec.c	2005-04-22 04:10:18 -07:00
@@ -0,0 +1,771 @@
+/*
+ * Copyright (C) 2001-2005 Silicon Graphics, Inc.  All rights
+ * reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ */
+
+/*
+ * SN Platform Special Memory (mspec) Support
+ *
+ * This driver exports the SN special memory (mspec) facility to user processes.
+ * There are three types of memory made available thru this driver:
+ * fetchops, uncached and cached.
+ *
+ * Fetchops are atomic memory operations that are implemented in the
+ * memory controller on SGI SN hardware.
+ *
+ * Uncached are used for memory write combining feature of the ia64
+ * cpu.
+ *
+ * Cached are used for areas of memory that are used as cached addresses
+ * on our partition and used as uncached addresses from other partitions.
+ * Due to a design constraint of the SN2 Shub, you can not have processors
+ * on the same FSB perform both a cached and uncached reference to the
+ * same cache line.  These special memory cached regions prevent the
+ * kernel from ever dropping in a TLB entry and therefore prevent the
+ * processor from ever speculating a cache line from this page.
+ */
+
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
+#include <linux/bitops.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#include <linux/efi.h>
+#include <linux/genalloc.h>
+#include <asm/page.h>
+#include <asm/pal.h>
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/atomic.h>
+#include <asm/tlbflush.h>
+#include <asm/sn/addrs.h>
+#include <asm/sn/arch.h>
+#include <asm/sn/mspec.h>
+#include <asm/sn/sn_cpuid.h>
+#include <asm/sn/io.h>
+#include <asm/sn/bte.h>
+#include <asm/sn/shubio.h>
+
+
+#define DEBUG	0
+
+#if DEBUG
+#define dprintk			printk
+#else
+#define dprintk(x...)		do { } while (0)
+#endif
+
+
+#define FETCHOP_ID	"Fetchop,"
+#define CACHED_ID	"Cached,"
+#define UNCACHED_ID	"Uncached"
+#define REVISION	"3.0"
+#define MSPEC_BASENAME	"mspec"
+
+
+/*
+ * Page types allocated by the device.
+ */
+enum {
+	MSPEC_FETCHOP = 1,
+	MSPEC_CACHED,
+	MSPEC_UNCACHED
+};
+
+
+/*
+ * One of these structures is allocated when an mspec region is mmaped. The
+ * structure is pointed to by the vma->vm_private_data field in the vma struct. 
+ * This structure is used to record the addresses of the mspec pages.
+ */
+struct vma_data {
+	atomic_t	refcnt;		/* Number of vmas sharing the data. */
+	spinlock_t	lock;		/* Serialize access to the vma. */
+	int		count;		/* Number of pages allocated. */
+	int		type;		/* Type of pages allocated. */
+	unsigned long	maddr[1];	/* Array of MSPEC addresses. */
+};
+
+
+/*
+ * Memory Special statistics.
+ */
+struct mspec_stats {
+	atomic_t	map_count;	/* Number of active mmap's */
+	atomic_t	pages_in_use;	/* Number of mspec pages in use */
+	unsigned long	pages_total;	/* Total number of mspec pages */
+};
+
+static struct mspec_stats	mspec_stats;
+
+#define MAX_UNCACHED_GRANULES	5
+static int allocated_granules;
+
+struct gen_pool *mspec_pool[MAX_NUMNODES];
+
+
+static inline int zero_block(unsigned long addr, int len)
+{
+	int status;
+
+	if (ia64_platform_is("sn2"))
+		status = bte_copy(0, addr - __IA64_UNCACHED_OFFSET, len,
+				  BTE_WACQUIRE | BTE_ZERO_FILL, NULL);
+	else {
+		memset((char *)addr, 0, len);
+		status = 0;
+	}
+	return status;
+}
+
+
+static void mspec_ipi_visibility(void *data)
+{
+	int status;
+
+	status = ia64_pal_prefetch_visibility(PAL_VISIBILITY_PHYSICAL);
+	if ((status != PAL_VISIBILITY_OK) &&
+	    (status != PAL_VISIBILITY_OK_REMOTE_NEEDED))
+		printk(KERN_DEBUG "pal_prefetch_visibility() returns %i on "
+		       "CPU %i\n", status, get_cpu());
+}
+
+
+static void mspec_ipi_mc_drain(void *data)
+{
+	int status;
+	status = ia64_pal_mc_drain();
+	if (status)
+		printk(KERN_WARNING "ia64_pal_mc_drain() failed with %i on "
+		       "CPU %i\n", status, get_cpu());
+}
+
+
+static unsigned long
+mspec_get_new_chunk(struct gen_pool *poolp)
+{
+	struct page *page;
+	void *tmp;
+	int status, i;
+	unsigned long addr, node;
+
+	if (allocated_granules >= MAX_UNCACHED_GRANULES)
+		return 0;
+
+	node = poolp->private;
+	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO,
+				IA64_GRANULE_SHIFT-PAGE_SHIFT);
+
+	dprintk(KERN_INFO "get_new_chunk page %p, addr %lx\n",
+		page, (unsigned long)(page-vmem_map) << PAGE_SHIFT);
+
+	/*
+	 * Do magic if no mem on local node! XXX
+	 */
+	if (!page)
+		return 0;
+	tmp = page_address(page);
+
+	/*
+	 * There's a small race here where it's possible for someone to
+	 * access the page through /dev/mem halfway through the conversion
+	 * to uncached - not sure it's really worth bothering about
+	 */
+	for (i = 0; i < (IA64_GRANULE_SIZE / PAGE_SIZE); i++)
+		SetPageUncached(&page[i]);
+
+	flush_tlb_kernel_range(tmp, tmp + IA64_GRANULE_SIZE);
+
+	status = ia64_pal_prefetch_visibility(PAL_VISIBILITY_PHYSICAL);
+
+	dprintk(KERN_INFO "pal_prefetch_visibility() returns %i on cpu %i\n",
+		status, get_cpu());
+
+	if (!status) {
+		status = smp_call_function(mspec_ipi_visibility, NULL, 0, 1);
+		if (status)
+			printk(KERN_WARNING "smp_call_function failed for "
+			       "mspec_ipi_visibility! (%i)\n", status);
+	}
+
+	sn_flush_all_caches((unsigned long)tmp, IA64_GRANULE_SIZE);
+	ia64_pal_mc_drain();
+	status = smp_call_function(mspec_ipi_mc_drain, NULL, 0, 1);
+	if (status)
+		printk(KERN_WARNING "smp_call_function failed for "
+		       "mspec_ipi_mc_drain! (%i)\n", status);
+
+	addr = (unsigned long)tmp - PAGE_OFFSET + __IA64_UNCACHED_OFFSET;
+
+	allocated_granules++;
+	return addr;
+}
+
+
+/*
+ * mspec_alloc_page
+ *
+ * Allocate 1 mspec page. Allocates on the requested node. If no
+ * mspec pages are available on the requested node, roundrobin starting
+ * with higher nodes.
+ */
+static unsigned long
+mspec_alloc_page(int nid)
+{
+	unsigned long maddr;
+
+	maddr = gen_pool_alloc(mspec_pool[nid], PAGE_SIZE);
+
+	dprintk(KERN_DEBUG "mspec_alloc_page returns %lx on node %i\n",
+		maddr, nid);
+
+	/*
+	 * If no memory is availble on our local node, try the
+	 * remaining nodes in the system.
+	 */
+	if (!maddr) {
+		int i;
+
+		for (i = MAX_NUMNODES - 1; i >= 0; i--) {
+			if (i == nid || !node_online(i))
+				continue;
+			maddr = gen_pool_alloc(mspec_pool[i], PAGE_SIZE);
+			dprintk(KERN_DEBUG "mspec_alloc_page alternate search "
+				"returns %lx on node %i\n", maddr, i);
+			if (maddr) {
+				break;
+			}
+		}
+	}
+
+	if (maddr)
+		atomic_inc(&mspec_stats.pages_in_use);
+
+	return maddr;
+}
+EXPORT_SYMBOL(mspec_alloc_page);
+
+
+/*
+ * mspec_free_page
+ *
+ * Free a single mspec page.
+ */
+static void
+mspec_free_page(unsigned long maddr)
+{
+	int node;
+
+	node = nasid_to_cnodeid(NASID_GET(maddr));
+
+	dprintk(KERN_DEBUG "mspec_free_page(%lx) on node %i\n", maddr, node);
+
+	if ((maddr & (0XFUL << 60)) != __IA64_UNCACHED_OFFSET)
+		panic("mspec_free_page invalid address %lx\n", maddr); 
+
+	atomic_dec(&mspec_stats.pages_in_use);
+	gen_pool_free(mspec_pool[node], maddr, PAGE_SIZE);
+}
+EXPORT_SYMBOL(mspec_free_page);
+
+
+/*
+ * mspec_open
+ *
+ * Called when a device mapping is created by a means other than mmap
+ * (via fork, etc.).  Increments the reference count on the underlying
+ * mspec data so it is not freed prematurely.
+ */
+static void
+mspec_open(struct vm_area_struct *vma)
+{
+	struct vma_data *vdata;
+
+	vdata = vma->vm_private_data;
+	atomic_inc(&vdata->refcnt);
+}
+
+
+/*
+ * mspec_close
+ *
+ * Called when unmapping a device mapping. Frees all mspec pages
+ * belonging to the vma.
+ */
+static void
+mspec_close(struct vm_area_struct *vma)
+{
+	struct vma_data *vdata;
+	int i, pages, result;
+
+	vdata = vma->vm_private_data;
+	if (atomic_dec_and_test(&vdata->refcnt)) {
+		pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+		for (i = 0; i < pages; i++) {
+			if (vdata->maddr[i] != 0) {
+				/*
+				 * Clear the page before sticking it back 
+				 * into the pool.
+				 */
+				result = zero_block(vdata->maddr[i], PAGE_SIZE);
+				if (!result)
+					mspec_free_page(vdata->maddr[i]);
+				else
+					printk(KERN_WARNING "mspec_close(): "
+					       "failed to zero page %i\n",
+					       result);
+			}
+		}
+		if (vdata->count) 
+			atomic_dec(&mspec_stats.map_count);
+		vfree(vdata);
+	}
+}
+
+
+/*
+ * mspec_get_one_pte
+ *
+ * Return the pte for a given mm and address.
+ */
+static __inline__ int
+mspec_get_one_pte(struct mm_struct *mm, u64 address, pte_t **pte)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pud_t *pud;
+
+	pgd = pgd_offset(mm, address);
+	if (pgd_present(*pgd)) {
+		pud = pud_offset(pgd, address);
+		if (pud_present(*pud)) {
+			pmd = pmd_offset(pud, address);
+			if (pmd_present(*pmd)) {
+				*pte = pte_offset_map(pmd, address);
+				if (pte_present(**pte)) {
+					return 0;
+				}
+			}
+		}
+	}
+
+	return -1;
+}
+
+
+/*
+ * mspec_nopage
+ *
+ * Creates a mspec page and maps it to user space.
+ */
+static struct page *
+mspec_nopage(struct vm_area_struct *vma, unsigned long address, int *unused)
+{
+	unsigned long paddr, maddr = 0;
+	unsigned long pfn;
+	int index;
+	pte_t *pte;
+	struct page *page;
+	struct vma_data *vdata = vma->vm_private_data;
+
+	spin_lock(&vdata->lock);
+
+	index = (address - vma->vm_start) >> PAGE_SHIFT;
+	if (vdata->maddr[index] == 0) {
+		vdata->count++;
+		spin_unlock(&vdata->lock);
+		maddr = mspec_alloc_page(numa_node_id());
+		if (maddr == 0)
+			BUG();
+		spin_lock(&vdata->lock);
+		vdata->maddr[index] = maddr;
+	} else if (mspec_get_one_pte(vma->vm_mm, address, &pte) == 0) {
+		printk(KERN_ERR "page already mapped\n");
+		/*
+		 * The page may have already been faulted by another
+		 * pthread.  If so, we need to avoid remapping the
+		 * page or we will trip a BUG check in the
+		 * remap_page_range() path.
+		 */
+		goto getpage;
+	}
+
+	if (vdata->type == MSPEC_FETCHOP)
+		paddr = TO_AMO(vdata->maddr[index]);
+	else
+		paddr = __pa(TO_CAC(vdata->maddr[index]));
+
+	/*
+	 * XXX - is this correct?
+	 */
+	pfn = paddr >> PAGE_SHIFT;
+	if (remap_pfn_range(vma, address, pfn, PAGE_SIZE, vma->vm_page_prot)) {
+		printk(KERN_ERR "remap_pfn_range failed!\n");
+		goto error;
+	}
+
+	/*
+	 * The kernel requires a page structure to be returned upon
+	 * success, but there are no page structures for low granule pages.
+	 * remap_page_range() creates the pte for us and we return a
+	 * bogus page back to the kernel fault handler to keep it happy
+	 * (the page is freed immediately there).
+	 */
+	if (mspec_get_one_pte(vma->vm_mm, address, &pte) == 0) {
+		spin_lock(&vma->vm_mm->page_table_lock);
+		inc_mm_counter(vma->vm_mm, rss);
+		spin_unlock(&vma->vm_mm->page_table_lock);
+
+		set_pte(pte, pte_mkwrite(pte_mkdirty(*pte)));
+	}
+ getpage:
+	/*
+	 * Is this really correct?
+	 */
+	spin_unlock(&vdata->lock);
+	page = alloc_pages(GFP_USER, 0);
+	return page;
+
+ error:
+	if (maddr) {
+		mspec_free_page(vdata->maddr[index]);
+		vdata->maddr[index] = 0;
+		vdata->count--;
+	}
+	spin_unlock(&vdata->lock);
+	return NOPAGE_SIGBUS;
+}
+
+
+static struct vm_operations_struct mspec_vm_ops = {
+	.open		mspec_open,
+	.close		mspec_close,
+	.nopage		mspec_nopage
+};
+
+
+/*
+ * mspec_mmap
+ *
+ * Called when mmaping the device.  Initializes the vma with a fault handler
+ * and private data structure necessary to allocate, track, and free the
+ * underlying pages.
+ */
+static int
+mspec_mmap(struct file *file, struct vm_area_struct *vma, int type)
+{
+	struct vma_data *vdata;
+	int pages;
+
+	if (vma->vm_pgoff != 0)
+		return -EINVAL;
+
+	if ((vma->vm_flags & VM_WRITE) == 0)
+		return -EPERM;
+
+	pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	if (!(vdata = vmalloc(sizeof(struct vma_data)+(pages-1)*sizeof(long))))
+		return -ENOMEM;
+	memset(vdata, 0, sizeof(struct vma_data)+(pages-1)*sizeof(long));
+
+	vdata->type = type;
+	spin_lock_init(&vdata->lock);
+	vdata->refcnt = ATOMIC_INIT(1);
+	vma->vm_private_data = vdata;
+
+	vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
+	if (vdata->type == MSPEC_FETCHOP || vdata->type == MSPEC_UNCACHED)
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_ops = &mspec_vm_ops;
+
+	atomic_inc(&mspec_stats.map_count);
+	return 0;
+}
+
+
+static int
+fetchop_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return mspec_mmap(file, vma, MSPEC_FETCHOP);
+}
+
+
+static int
+cached_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return mspec_mmap(file, vma, MSPEC_CACHED);
+}
+
+
+static int
+uncached_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return mspec_mmap(file, vma, MSPEC_UNCACHED);
+}
+
+
+#ifdef CONFIG_PROC_FS
+static void *
+mspec_seq_start(struct seq_file *file, loff_t *offset)
+{
+	if (*offset < MAX_NUMNODES)
+		return offset;
+	return NULL;			
+}
+
+static void *
+mspec_seq_next(struct seq_file *file, void *data, loff_t *offset)
+{
+	(*offset)++;
+	if (*offset < MAX_NUMNODES)
+		return offset;
+	return NULL;
+}
+
+static void
+mspec_seq_stop(struct seq_file *file, void *data)
+{
+}
+
+static int
+mspec_seq_show(struct seq_file *file, void *data)
+{
+	int i;
+
+	i = *(loff_t *)data;
+
+	if (!i) {
+		seq_printf(file, "mappings               : %i\n",
+			   atomic_read(&mspec_stats.map_count));
+		seq_printf(file, "current mspec pages    : %i\n",
+			   atomic_read(&mspec_stats.pages_in_use));
+		seq_printf(file, "%4s %7s %7s\n", "node", "total", "free");
+	}
+	return 0;
+}
+
+
+static struct seq_operations mspec_seq_ops = {
+	.start = mspec_seq_start,
+	.next = mspec_seq_next,
+	.stop = mspec_seq_stop,
+	.show = mspec_seq_show
+};
+
+int
+mspec_proc_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &mspec_seq_ops);
+}
+
+static struct file_operations proc_mspec_operations = {
+	.open		= mspec_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+
+static struct proc_dir_entry   *proc_mspec;
+
+#endif /* CONFIG_PROC_FS */
+
+/*
+ * mspec_build_memmap,
+ *
+ * Called at boot time to build a map of pages that can be used for
+ * memory special operations.
+ */
+static int __init
+mspec_build_memmap(unsigned long start, unsigned long end)
+{
+	long length;
+	unsigned long vstart, vend;
+	int node, result;
+
+	length = end - start;
+	vstart = start + __IA64_UNCACHED_OFFSET;
+	vend = end + __IA64_UNCACHED_OFFSET;
+
+	dprintk(KERN_ERR "mspec_build_memmap(%lx %lx)\n", start, end);
+
+	result = zero_block(vstart, length);
+	if (result)
+		panic("Failed while trying to zero mspec page: %i\n", result);
+
+	node = nasid_to_cnodeid(NASID_GET(start));
+
+	for (; vstart < vend ; vstart += PAGE_SIZE) {
+		dprintk(KERN_INFO "sticking %lx into the pool!\n", vstart);
+		gen_pool_free(mspec_pool[node], vstart, PAGE_SIZE);
+	}
+
+	return 0;
+}
+
+/*
+ * Walk the EFI memory map to pull out leftover pages in the lower
+ * memory regions which do not end up in the regular memory map and
+ * stick them into the uncached allocator
+ */
+static void __init
+mspec_walk_efi_memmap_uc (void)
+{
+	void *efi_map_start, *efi_map_end, *p;
+	efi_memory_desc_t *md;
+	u64 efi_desc_size, start, end;
+
+	efi_map_start = __va(ia64_boot_param->efi_memmap);
+	efi_map_end = efi_map_start + ia64_boot_param->efi_memmap_size;
+	efi_desc_size = ia64_boot_param->efi_memdesc_size;
+
+	for (p = efi_map_start; p < efi_map_end; p += efi_desc_size) {
+		md = p;
+		if (md->attribute == EFI_MEMORY_UC) {
+			start = PAGE_ALIGN(md->phys_addr);
+			end = PAGE_ALIGN((md->phys_addr+(md->num_pages << EFI_PAGE_SHIFT)) & PAGE_MASK);
+			if (mspec_build_memmap(start, end) < 0)
+				return;
+		}
+	}
+}
+
+
+static struct file_operations fetchop_fops = {
+	.owner		THIS_MODULE,
+	.mmap		fetchop_mmap
+};
+static struct miscdevice fetchop_miscdev = {
+	.minor		MISC_DYNAMIC_MINOR,
+	.name		"sgi_fetchop",
+	.fops		&fetchop_fops
+};
+
+
+static struct file_operations cached_fops = {
+	.owner		THIS_MODULE,
+	.mmap		cached_mmap
+};
+static struct miscdevice cached_miscdev = {
+	.minor		MISC_DYNAMIC_MINOR,
+	.name		"sgi_cached",
+	.fops		&cached_fops
+};
+
+
+static struct file_operations uncached_fops = {
+	.owner		THIS_MODULE,
+	.mmap		uncached_mmap
+};
+static struct miscdevice uncached_miscdev = {
+	.minor		MISC_DYNAMIC_MINOR,
+	.name		"sgi_uncached",
+	.fops		&uncached_fops
+};
+
+
+/*
+ * mspec_init
+ *
+ * Called at boot time to initialize the mspec facility.
+ */
+static int __init
+mspec_init(void)
+{
+	int i, ret;
+
+	/*
+	 * The fetchop device only works on SN2 hardware, uncached and cached
+	 * memory drivers should both be valid on all ia64 hardware
+	 */
+	if (ia64_platform_is("sn2")) {
+		if ((ret = misc_register(&fetchop_miscdev))) {
+			printk(KERN_ERR "%s: failed to register device %i\n",
+			       FETCHOP_ID, ret);
+			return ret;
+		}
+	}
+	if ((ret = misc_register(&cached_miscdev))) {
+		printk(KERN_ERR "%s: failed to register device %i\n",
+		       CACHED_ID, ret);
+		misc_deregister(&fetchop_miscdev);
+		return ret;
+	}
+	if ((ret = misc_register(&uncached_miscdev))) {
+		printk(KERN_ERR "%s: failed to register device %i\n",
+		       UNCACHED_ID, ret);
+		misc_deregister(&cached_miscdev);
+		misc_deregister(&fetchop_miscdev);
+		return ret;
+	}
+
+	/*
+	 * /proc code needs to be updated to work with the new
+	 * allocation scheme
+	 */
+#ifdef CONFIG_PROC_FS
+	if (!(proc_mspec = create_proc_entry(MSPEC_BASENAME, 0444, NULL))){
+		printk(KERN_ERR "%s: unable to create proc entry",
+		       MSPEC_BASENAME);
+		misc_deregister(&uncached_miscdev);
+		misc_deregister(&cached_miscdev);
+		misc_deregister(&fetchop_miscdev);
+		return -EINVAL;
+	}
+	proc_mspec->proc_fops = &proc_mspec_operations;
+#endif
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (!node_online(i))
+			continue;
+		mspec_pool[i] = gen_pool_create(0, IA64_GRANULE_SHIFT,
+						&mspec_get_new_chunk, i);
+	}
+
+	mspec_walk_efi_memmap_uc();
+
+	printk(KERN_INFO "%s %s initialized devices: %s %s %s\n",
+	       MSPEC_BASENAME, REVISION,
+	       ia64_platform_is("sn2") ? "" : FETCHOP_ID,
+	       CACHED_ID, UNCACHED_ID);
+
+	return 0;
+}
+
+
+static void __exit
+mspec_exit(void)
+{
+	BUG_ON(atomic_read(&mspec_stats.pages_in_use) > 0);
+
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry(MSPEC_BASENAME, NULL);
+#endif
+	misc_deregister(&uncached_miscdev);
+	misc_deregister(&cached_miscdev);
+	misc_deregister(&fetchop_miscdev);
+}
+
+
+module_init(mspec_init);
+module_exit(mspec_exit);
+
+
+MODULE_AUTHOR("Silicon Graphics, Inc.");
+MODULE_DESCRIPTION("Driver for SGI SN special memory operations");
+MODULE_LICENSE("GPL");
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/include/asm-ia64/sn/fetchop.h linux-2.6.12-rc2-mm3/include/asm-ia64/sn/fetchop.h
--- linux-2.6.12-rc2-mm3-vanilla/include/asm-ia64/sn/fetchop.h	2005-03-01 23:38:12 -08:00
+++ linux-2.6.12-rc2-mm3/include/asm-ia64/sn/fetchop.h	1969-12-31 16:00:00 -08:00
@@ -1,85 +0,0 @@
-/*
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (c) 2001-2004 Silicon Graphics, Inc.  All rights reserved.
- */
-
-#ifndef _ASM_IA64_SN_FETCHOP_H
-#define _ASM_IA64_SN_FETCHOP_H
-
-#include <linux/config.h>
-
-#define FETCHOP_BASENAME	"sgi_fetchop"
-#define FETCHOP_FULLNAME	"/dev/sgi_fetchop"
-
-
-
-#define FETCHOP_VAR_SIZE 64 /* 64 byte per fetchop variable */
-
-#define FETCHOP_LOAD		0
-#define FETCHOP_INCREMENT	8
-#define FETCHOP_DECREMENT	16
-#define FETCHOP_CLEAR		24
-
-#define FETCHOP_STORE		0
-#define FETCHOP_AND		24
-#define FETCHOP_OR		32
-
-#define FETCHOP_CLEAR_CACHE	56
-
-#define FETCHOP_LOAD_OP(addr, op) ( \
-         *(volatile long *)((char*) (addr) + (op)))
-
-#define FETCHOP_STORE_OP(addr, op, x) ( \
-         *(volatile long *)((char*) (addr) + (op)) = (long) (x))
-
-#ifdef __KERNEL__
-
-/*
- * Convert a region 6 (kaddr) address to the address of the fetchop variable
- */
-#define FETCHOP_KADDR_TO_MSPEC_ADDR(kaddr)	TO_MSPEC(kaddr)
-
-
-/*
- * Each Atomic Memory Operation (AMO formerly known as fetchop)
- * variable is 64 bytes long.  The first 8 bytes are used.  The
- * remaining 56 bytes are unaddressable due to the operation taking
- * that portion of the address.
- * 
- * NOTE: The AMO_t _MUST_ be placed in either the first or second half
- * of the cache line.  The cache line _MUST NOT_ be used for anything
- * other than additional AMO_t entries.  This is because there are two
- * addresses which reference the same physical cache line.  One will
- * be a cached entry with the memory type bits all set.  This address
- * may be loaded into processor cache.  The AMO_t will be referenced
- * uncached via the memory special memory type.  If any portion of the
- * cached cache-line is modified, when that line is flushed, it will
- * overwrite the uncached value in physical memory and lead to
- * inconsistency.
- */
-typedef struct {
-        u64 variable;
-        u64 unused[7];
-} AMO_t;
-
-
-/*
- * The following APIs are externalized to the kernel to allocate/free pages of
- * fetchop variables.
- *	fetchop_kalloc_page	- Allocate/initialize 1 fetchop page on the
- *				  specified cnode. 
- *	fetchop_kfree_page	- Free a previously allocated fetchop page
- */
-
-unsigned long fetchop_kalloc_page(int nid);
-void fetchop_kfree_page(unsigned long maddr);
-
-
-#endif /* __KERNEL__ */
-
-#endif /* _ASM_IA64_SN_FETCHOP_H */
-
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/include/asm-ia64/sn/mspec.h linux-2.6.12-rc2-mm3/include/asm-ia64/sn/mspec.h
--- linux-2.6.12-rc2-mm3-vanilla/include/asm-ia64/sn/mspec.h	1969-12-31 16:00:00 -08:00
+++ linux-2.6.12-rc2-mm3/include/asm-ia64/sn/mspec.h	2005-04-12 02:14:06 -07:00
@@ -0,0 +1,72 @@
+/*
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2001-2004 Silicon Graphics, Inc.  All rights reserved.
+ */
+
+#ifndef _ASM_IA64_SN_MSPEC_H
+#define _ASM_IA64_SN_MSPEC_H
+
+#define FETCHOP_VAR_SIZE 64 /* 64 byte per fetchop variable */
+
+#define FETCHOP_LOAD		0
+#define FETCHOP_INCREMENT	8
+#define FETCHOP_DECREMENT	16
+#define FETCHOP_CLEAR		24
+
+#define FETCHOP_STORE		0
+#define FETCHOP_AND		24
+#define FETCHOP_OR		32
+
+#define FETCHOP_CLEAR_CACHE	56
+
+#define FETCHOP_LOAD_OP(addr, op) ( \
+         *(volatile long *)((char*) (addr) + (op)))
+
+#define FETCHOP_STORE_OP(addr, op, x) ( \
+         *(volatile long *)((char*) (addr) + (op)) = (long) (x))
+
+#ifdef __KERNEL__
+
+/*
+ * Each Atomic Memory Operation (AMO formerly known as fetchop)
+ * variable is 64 bytes long.  The first 8 bytes are used.  The
+ * remaining 56 bytes are unaddressable due to the operation taking
+ * that portion of the address.
+ * 
+ * NOTE: The AMO_t _MUST_ be placed in either the first or second half
+ * of the cache line.  The cache line _MUST NOT_ be used for anything
+ * other than additional AMO_t entries.  This is because there are two
+ * addresses which reference the same physical cache line.  One will
+ * be a cached entry with the memory type bits all set.  This address
+ * may be loaded into processor cache.  The AMO_t will be referenced
+ * uncached via the memory special memory type.  If any portion of the
+ * cached cache-line is modified, when that line is flushed, it will
+ * overwrite the uncached value in physical memory and lead to
+ * inconsistency.
+ */
+typedef struct {
+        u64 variable;
+        u64 unused[7];
+} AMO_t;
+
+
+/*
+ * The following APIs are externalized to the kernel to allocate/free pages of
+ * fetchop variables.
+ *	mspec_kalloc_page	- Allocate/initialize 1 fetchop page on the
+ *				  specified cnode. 
+ *	mspec_kfree_page	- Free a previously allocated fetchop page
+ */
+
+extern unsigned long mspec_kalloc_page(int);
+extern void mspec_kfree_page(unsigned long);
+
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_IA64_SN_MSPEC_H */
+
