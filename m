Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVKRTgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVKRTgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVKRTgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:36:09 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:30418 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932127AbVKRTgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:36:07 -0500
Message-ID: <437E2D23.10109@us.ibm.com>
Date: Fri, 18 Nov 2005 11:36:03 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 1/8] Create Critical Page Pool
References: <437E2C69.4000708@us.ibm.com>
In-Reply-To: <437E2C69.4000708@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040906020008040706030809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040906020008040706030809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Create the critical page pool and it's associated /proc/sys/vm/ file.

-Matt

--------------040906020008040706030809
Content-Type: text/x-patch;
 name="critical_pool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="critical_pool.patch"

Implement a Critical Page Pool:

* Write a number of pages into /proc/sys/vm/critical_pages
* These pages will be reserved for 'critical' allocations, signified
     by the __GFP_CRITICAL flag passed to an allocation request.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc1+critical_pool/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/Documentation/sysctl/vm.txt	2005-11-15 13:47:14.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/Documentation/sysctl/vm.txt	2005-11-17 16:27:33.108545112 -0800
@@ -26,6 +26,7 @@ Currently, these files are in /proc/sys/
 - min_free_kbytes
 - laptop_mode
 - block_dump
+- critical_pages
 
 ==============================================================
 
@@ -102,3 +103,12 @@ This is used to force the Linux VM to ke
 of kilobytes free.  The VM uses this number to compute a pages_min
 value for each lowmem zone in the system.  Each lowmem zone gets 
 a number of reserved free pages based proportionally on its size.
+
+==============================================================
+
+critical_pages:
+
+This is used to force the Linux VM to reserve a pool of pages for
+emergency (__GFP_CRITICAL) allocations.  Allocations with this flag
+MUST succeed.
+The number written into this file is the number of pages to reserve.
Index: linux-2.6.15-rc1+critical_pool/include/linux/gfp.h
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/include/linux/gfp.h	2005-11-15 13:46:37.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/include/linux/gfp.h	2005-11-17 16:28:28.375143312 -0800
@@ -41,6 +41,7 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_NORECLAIM  ((__force gfp_t)0x20000u) /* No realy zone reclaim during allocation */
 #define __GFP_HARDWALL   ((__force gfp_t)0x40000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_CRITICAL	((__force gfp_t)0x80000u) /* Critical allocation. MUST succeed! */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -49,7 +50,8 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL| \
+			__GFP_CRITICAL)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
@@ -58,6 +60,8 @@ struct vm_area_struct;
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
 			 __GFP_HIGHMEM)
+#define GFP_ATOMIC_CRIT	(GFP_ATOMIC | __GFP_CRITICAL)
+#define GFP_KERNEL_CRIT	(GFP_KERNEL | __GFP_CRITICAL)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
Index: linux-2.6.15-rc1+critical_pool/include/linux/sysctl.h
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/include/linux/sysctl.h	2005-11-15 13:46:38.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/include/linux/sysctl.h	2005-11-17 16:27:33.111544656 -0800
@@ -181,6 +181,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_CRITICAL_PAGES=30,	/* # of pages to reserve for __GFP_CRITICAL allocs */
 };
 
 
Index: linux-2.6.15-rc1+critical_pool/kernel/sysctl.c
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/kernel/sysctl.c	2005-11-15 13:47:25.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/kernel/sysctl.c	2005-11-17 16:27:33.116543896 -0800
@@ -849,6 +849,16 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_CRITICAL_PAGES,
+		.procname	= "critical_pages",
+		.data		= &critical_pages,
+		.maxlen		= sizeof(critical_pages),
+		.mode		= 0644,
+		.proc_handler	= &critical_pages_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6.15-rc1+critical_pool/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/mm/page_alloc.c	2005-11-15 13:47:26.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/mm/page_alloc.c	2005-11-17 16:27:33.120543288 -0800
@@ -53,6 +53,65 @@ unsigned long totalram_pages __read_most
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
 
+/* The number of pages to maintain in the critical page pool */
+int critical_pages = 0;
+
+/* Critical Page Pool control structure */
+static struct critical_pool {
+	unsigned int free;
+	spinlock_t lock;
+	struct list_head pages;
+} critical_pool = {
+	.free	= 0,
+	.lock	= SPIN_LOCK_UNLOCKED,
+	.pages	= LIST_HEAD_INIT(critical_pool.pages),
+};
+
+/* MCD - This needs to be arch specific */
+#define CRITICAL_POOL_GFPMASK	(GFP_KERNEL)
+
+static inline int is_critical_pool_full(void)
+{
+	return critical_pool.free >= critical_pages;
+}
+
+static inline struct page *get_critical_page(gfp_t gfpmask)
+{
+	struct page *page = NULL;
+
+	spin_lock(&critical_pool.lock);
+	if (!list_empty(&critical_pool.pages)) {
+		/* Grab the next free critical pool page */
+		page = list_entry(critical_pool.pages.next, struct page, lru);
+		list_del(&page->lru);
+		critical_pool.free--;
+	}
+	spin_unlock(&critical_pool.lock);
+
+	return page;
+}
+
+static inline int put_critical_page(struct page *page)
+{
+	int ret = 0;
+
+	spin_lock(&critical_pool.lock);
+	if (!is_critical_pool_full()) {
+		/*
+		 * We snached this page away in the process of being freed, so
+		 * we must re-increment it's count so we don't cause problems
+		 * when we hand it back out to a future __GFP_CRITICAL alloc.
+		 */
+		BUG_ON(!get_page_testone(page));
+		list_add(&page->lru, &critical_pool.pages);
+		critical_pool.free++;
+		ret = 1;
+	}
+	spin_unlock(&critical_pool.lock);
+
+	return ret;
+}
+
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
@@ -305,6 +364,10 @@ static inline void __free_pages_bulk (st
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
+	else if (!is_critical_pool_full())
+		/* If the critical pool isn't full, add this page to it */
+		if (put_critical_page(page))
+			return;
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
 
@@ -984,6 +1047,20 @@ rebalance:
 	}
 
 nopage:
+	/*
+	 * This is the LAST DITCH effort.  We maintain a pool of 'critical'
+	 * pages specifically for allocation requests marked __GFP_CRITICAL.
+	 * Rather than fail one of these allocations, take a page (if any)
+	 * from the critical pool.
+	 */
+	if (gfp_mask & __GFP_CRITICAL) {
+		page = get_critical_page(gfp_mask);
+		if (page) {
+			z = page_zone(page);
+			goto got_pg;
+		}
+	}
+
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
 		printk(KERN_WARNING "%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
@@ -2522,6 +2599,68 @@ int lowmem_reserve_ratio_sysctl_handler(
 	return 0;
 }
 
+static inline void fill_critical_pool(int num)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		page = alloc_page(CRITICAL_POOL_GFPMASK);
+		if (!page)
+			return;
+		spin_lock(&critical_pool.lock);
+		list_add(&page->lru, &critical_pool.pages);
+		critical_pool.free++;
+		spin_unlock(&critical_pool.lock);
+	}
+}
+
+static inline void drain_critical_pool(int num)
+{
+	struct page *page;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		spin_lock(&critical_pool.lock);
+		BUG_ON(critical_pool.free < 0);
+		if (list_empty(&critical_pool.pages) || !critical_pool.free) {
+			spin_unlock(&critical_pool.lock);
+			break;
+		}
+			
+		page = list_entry(critical_pool.pages.next, struct page, lru);
+		list_del(&page->lru);
+		critical_pool.free--;
+		spin_unlock(&critical_pool.lock);
+			
+		__free_pages(page, 0);
+	}
+}
+
+/*
+ * critical_pages_sysctl_handler - handle writes to /proc/sys/vm/critical_pages
+ *     Whenever this file changes, add/remove pages to/from the critical page
+ *     pool.
+ */
+int critical_pages_sysctl_handler(ctl_table *table, int write,
+				   struct file *file, void __user *buffer,
+				   size_t *length, loff_t *ppos)
+{
+	int num;
+
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	if (!write)
+		return 0;
+
+	num = critical_pages - critical_pool.free;
+	if (num > 0)
+		fill_critical_pool(num);
+	else if (num < 0)
+		drain_critical_pool(-num);
+
+	return 0;
+}
+
 __initdata int hashdist = HASHDIST_DEFAULT;
 
 #ifdef CONFIG_NUMA
Index: linux-2.6.15-rc1+critical_pool/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/include/linux/mmzone.h	2005-11-15 13:46:38.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/include/linux/mmzone.h	2005-11-17 16:27:33.121543136 -0800
@@ -430,6 +430,8 @@ int min_free_kbytes_sysctl_handler(struc
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
+int critical_pages_sysctl_handler(struct ctl_table *, int, struct file *,
+				  void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
Index: linux-2.6.15-rc1+critical_pool/include/linux/mm.h
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/include/linux/mm.h	2005-11-15 13:46:36.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/include/linux/mm.h	2005-11-17 16:27:33.125542528 -0800
@@ -32,6 +32,8 @@ extern int sysctl_legacy_va_layout;
 #define sysctl_legacy_va_layout 0
 #endif
 
+extern int critical_pages;
+
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>

--------------040906020008040706030809--
