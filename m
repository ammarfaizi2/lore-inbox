Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVJNTXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVJNTXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVJNTXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:23:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42118 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750908AbVJNTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:23:08 -0400
Date: Fri, 14 Oct 2005 14:22:56 -0500
From: Robin Holt <holt@sgi.com>
To: linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com, Dave Hansen <haveblue@us.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: [Patch 3/3] Special Memory (mspec) driver.
Message-ID: <20051014192256.GE14418@lnx-holt.americas.sgi.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce the special memory (mspec) driver.  This is used to allow
userland to map fetchop, etc pages

Signed-off-by: holt@sgi.com



Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig	2005-10-14 13:05:33.061934274 -0500
+++ linux-2.6/arch/ia64/Kconfig	2005-10-14 13:06:30.140195032 -0500
@@ -231,6 +231,16 @@ config IA64_SGI_SN_XP
 	  this feature will allow for direct communication between SSIs
 	  based on a network adapter and DMA messaging.
 
+config MSPEC
+	tristate "Special Memory support"
+	select IA64_UNCACHED_ALLOCATOR
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
Index: linux-2.6/arch/ia64/kernel/Makefile
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/Makefile	2005-10-14 13:05:33.062910739 -0500
+++ linux-2.6/arch/ia64/kernel/Makefile	2005-10-14 13:06:30.145077354 -0500
@@ -23,6 +23,7 @@ obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
+obj-$(CONFIG_MSPEC)		+= mspec.o
 obj-$(CONFIG_IA64_UNCACHED_ALLOCATOR)	+= uncached.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
Index: linux-2.6/arch/ia64/kernel/mspec.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/ia64/kernel/mspec.c	2005-10-14 14:02:08.473328177 -0500
@@ -0,0 +1,388 @@
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
+#include <asm/page.h>
+#include <asm/pal.h>
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/atomic.h>
+#include <asm/tlbflush.h>
+#include <asm/uncached.h>
+#include <asm/sn/addrs.h>
+#include <asm/sn/arch.h>
+#include <asm/sn/mspec.h>
+#include <asm/sn/sn_cpuid.h>
+#include <asm/sn/io.h>
+#include <asm/sn/bte.h>
+#include <asm/sn/shubio.h>
+
+
+#define FETCHOP_ID	"Fetchop,"
+#define CACHED_ID	"Cached,"
+#define UNCACHED_ID	"Uncached"
+#define REVISION	"3.0"
+#define MSPEC_BASENAME	"mspec"
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
+/*
+ * One of these structures is allocated when an mspec region is mmaped. The
+ * structure is pointed to by the vma->vm_private_data field in the vma struct.
+ * This structure is used to record the addresses of the mspec pages.
+ */
+struct vma_data {
+	atomic_t refcnt;	/* Number of vmas sharing the data. */
+	spinlock_t lock;	/* Serialize access to the vma. */
+	int count;		/* Number of pages allocated. */
+	int type;		/* Type of pages allocated. */
+	unsigned long maddr[0];	/* Array of MSPEC addresses. */
+};
+
+/* used on shub2 to clear FOP cache in the HUB */
+static unsigned long uncached_scratch_page;
+static void *fetchop_cache_clear;
+#define SH2_AMO_CACHE_ENTRIES	4
+
+static inline int
+mspec_zero_block(unsigned long addr, int len)
+{
+	int status;
+
+	if (ia64_platform_is("sn2")) {
+		if (fetchop_cache_clear) {
+			void *p = fetchop_cache_clear;
+			int i;
+
+			for (i=0; i < SH2_AMO_CACHE_ENTRIES; i++) {
+				FETCHOP_LOAD_OP(p, FETCHOP_LOAD);
+				p += FETCHOP_VAR_SIZE;
+			}
+		}
+		status = bte_copy(0, addr & ~__IA64_UNCACHED_OFFSET, len,
+				  BTE_WACQUIRE | BTE_ZERO_FILL, NULL);
+	} else {
+		memset((char *) addr, 0, len);
+		status = 0;
+	}
+	return status;
+}
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
+	if (!atomic_dec_and_test(&vdata->refcnt))
+		return;
+
+	pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	for (i = 0; i < pages; i++) {
+		if (vdata->maddr[i] == 0)
+			continue;
+		/*
+		 * Clear the page before sticking it back
+		 * into the pool.
+		 */
+		result = mspec_zero_block(vdata->maddr[i], PAGE_SIZE);
+		if (!result)
+			uncached_free_page(vdata-> maddr[i]);
+		else
+			printk(KERN_WARNING "mspec_close(): "
+			       "failed to zero page %i\n",
+			       result);
+	}
+
+	vfree(vdata);
+}
+
+/*
+ * mspec_nopage
+ *
+ * Creates a mspec page and maps it to user space.
+ */
+static struct page *
+mspec_nopage(struct vm_area_struct *vma,
+	     unsigned long address, int *unused)
+{
+	unsigned long paddr, maddr = 0;
+	unsigned long pfn;
+	int index;
+	pte_t *page_table, pte;
+	struct vma_data *vdata = vma->vm_private_data;
+
+	index = (address - vma->vm_start) >> PAGE_SHIFT;
+	maddr = (volatile unsigned long) vdata->maddr[index];
+	if (maddr == 0) {
+		maddr = uncached_alloc_page(numa_node_id());
+		if (maddr == 0)
+			return NOPAGE_OOM;
+
+		spin_lock(&vdata->lock);
+		if (vdata->maddr[index] == 0) {
+			vdata->count++;
+			vdata->maddr[index] = maddr;
+		} else {
+			uncached_free_page(maddr);
+			maddr = vdata->maddr[index];
+		}
+		spin_unlock(&vdata->lock);
+	}
+
+	spin_lock(&vma->vm_mm->page_table_lock);
+	page_table = get_one_pte_map(vma->vm_mm, address);
+	if (page_table != NULL && !pte_present(*page_table)) {
+		if (vdata->type == MSPEC_FETCHOP)
+			paddr = TO_AMO(maddr);
+		else
+			paddr = __pa(TO_CAC(maddr));
+
+		pfn = paddr >> PAGE_SHIFT;
+		pte = pfn_pte(pfn, vma->vm_page_prot);
+		pte = pte_mkwrite(pte_mkdirty(pte));
+		set_pte(page_table, pte);
+	}
+	spin_unlock(&vma->vm_mm->page_table_lock);
+
+	return NOPAGE_FAULTED;
+}
+
+static struct vm_operations_struct mspec_vm_ops = {
+	.open mspec_open,
+	.close mspec_close,
+	.nopage mspec_nopage
+};
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
+	vdata = vmalloc(sizeof(struct vma_data) + pages * sizeof(long));
+	if (!vdata)
+		return -ENOMEM;
+	memset(vdata, 0, sizeof(struct vma_data) + pages * sizeof(long));
+
+	vdata->type = type;
+	spin_lock_init(&vdata->lock);
+	vdata->refcnt = ATOMIC_INIT(1);
+	vma->vm_private_data = vdata;
+
+	vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED | VM_RESERVED);
+	if (vdata->type == MSPEC_FETCHOP || vdata->type == MSPEC_UNCACHED)
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_ops = &mspec_vm_ops;
+
+	return 0;
+}
+
+static int
+fetchop_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return mspec_mmap(file, vma, MSPEC_FETCHOP);
+}
+
+static int
+cached_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return mspec_mmap(file, vma, MSPEC_CACHED);
+}
+
+static int
+uncached_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return mspec_mmap(file, vma, MSPEC_UNCACHED);
+}
+
+static struct file_operations fetchop_fops = {
+	.owner THIS_MODULE,
+	.mmap fetchop_mmap
+};
+
+static struct miscdevice fetchop_miscdev = {
+	.minor MISC_DYNAMIC_MINOR,
+	.name "sgi_fetchop",
+	.fops &fetchop_fops
+};
+
+static struct file_operations cached_fops = {
+	.owner THIS_MODULE,
+	.mmap cached_mmap
+};
+
+static struct miscdevice cached_miscdev = {
+	.minor MISC_DYNAMIC_MINOR,
+	.name "sgi_cached",
+	.fops &cached_fops
+};
+
+static struct file_operations uncached_fops = {
+	.owner THIS_MODULE,
+	.mmap uncached_mmap
+};
+
+static struct miscdevice uncached_miscdev = {
+	.minor MISC_DYNAMIC_MINOR,
+	.name "sgi_uncached",
+	.fops &uncached_fops
+};
+
+/*
+ * mspec_init
+ *
+ * Called at boot time to initialize the mspec facility.
+ */
+static int __init
+mspec_init(void)
+{
+	int ret;
+
+	/*
+	 * The fetchop device only works on SN2 hardware, uncached and cached
+	 * memory drivers should both be valid on all ia64 hardware
+	 */
+	if (ia64_platform_is("sn2")) {
+		if (is_shub2()) {
+			uncached_scratch_page = uncached_alloc_page(0);
+			fetchop_cache_clear = (void *)TO_AMO(uncached_scratch_page);
+		}
+
+		ret = misc_register(&fetchop_miscdev);
+		if (ret) {
+			printk(KERN_ERR
+			       "%s: failed to register device %i\n",
+			       FETCHOP_ID, ret);
+			return ret;
+		}
+	}
+	ret = misc_register(&cached_miscdev);
+	if (ret) {
+		printk(KERN_ERR "%s: failed to register device %i\n",
+		       CACHED_ID, ret);
+		misc_deregister(&fetchop_miscdev);
+		return ret;
+	}
+	ret = misc_register(&uncached_miscdev);
+	if (ret) {
+		printk(KERN_ERR "%s: failed to register device %i\n",
+		       UNCACHED_ID, ret);
+		misc_deregister(&cached_miscdev);
+		misc_deregister(&fetchop_miscdev);
+		return ret;
+	}
+
+	printk(KERN_INFO "%s %s initialized devices: %s %s %s\n",
+	       MSPEC_BASENAME, REVISION,
+	       ia64_platform_is("sn2") ? FETCHOP_ID : "",
+	       CACHED_ID, UNCACHED_ID);
+
+	return 0;
+}
+
+static void __exit
+mspec_exit(void)
+{
+	misc_deregister(&uncached_miscdev);
+	misc_deregister(&cached_miscdev);
+	if (ia64_platform_is("sn2")) {
+		misc_deregister(&fetchop_miscdev);
+		if (uncached_scratch_page)
+			uncached_free_page(uncached_scratch_page);
+	}
+}
+
+module_init(mspec_init);
+module_exit(mspec_exit);
+
+MODULE_AUTHOR("Silicon Graphics, Inc.");
+MODULE_DESCRIPTION("Driver for SGI SN special memory operations");
+MODULE_LICENSE("GPL");
