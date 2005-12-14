Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVLNHwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVLNHwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVLNHwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:52:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:19649 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932080AbVLNHwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:52:50 -0500
Message-ID: <439FCF4E.3090202@us.ibm.com>
Date: Tue, 13 Dec 2005 23:52:46 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andrea@suse.de, Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 1/6] Create Critical Page Pool
References: <439FCECA.3060909@us.ibm.com>
In-Reply-To: <439FCECA.3060909@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030609020006050500090808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030609020006050500090808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Create the basic Critical Page Pool.  Any allocation specifying
__GFP_CRITICAL will, as a last resort before failing the allocation, try to
get a page from the critical pool.  For now, only singleton (order 0) pages
are supported.

-Matt

--------------030609020006050500090808
Content-Type: text/x-patch;
 name="critical_pool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="critical_pool.patch"

Implement a Critical Page Pool:

* Write a number of pages into /proc/sys/vm/critical_pages
* These pages will be reserved for 'critical' allocations, signified
     by the __GFP_CRITICAL flag passed to an allocation request
* Reading /proc/sys/vm/critical_pages will give statistics about the
     critical page pool

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc5+critical_pool/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/Documentation/sysctl/vm.txt	2005-12-13 15:56:55.819232488 -0800
+++ linux-2.6.15-rc5+critical_pool/Documentation/sysctl/vm.txt	2005-12-13 16:01:57.783326968 -0800
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
Index: linux-2.6.15-rc5+critical_pool/include/linux/gfp.h
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/include/linux/gfp.h	2005-12-13 15:56:55.820232336 -0800
+++ linux-2.6.15-rc5+critical_pool/include/linux/gfp.h	2005-12-13 15:56:57.531972112 -0800
@@ -47,6 +47,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_CRITICAL	((__force gfp_t)0x40000u) /* Critical allocation. MUST succeed! */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -55,7 +56,7 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_CRITICAL)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
@@ -64,6 +65,8 @@ struct vm_area_struct;
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
 			 __GFP_HIGHMEM)
+#define GFP_ATOMIC_CRIT	(GFP_ATOMIC | __GFP_CRITICAL)
+#define GFP_KERNEL_CRIT	(GFP_KERNEL | __GFP_CRITICAL)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
Index: linux-2.6.15-rc5+critical_pool/include/linux/sysctl.h
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/include/linux/sysctl.h	2005-12-13 15:56:55.820232336 -0800
+++ linux-2.6.15-rc5+critical_pool/include/linux/sysctl.h	2005-12-13 16:02:13.757898464 -0800
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_CRITICAL_PAGES=29,	/* # of pages to reserve for __GFP_CRITICAL allocs */
 };
 
 
Index: linux-2.6.15-rc5+critical_pool/kernel/sysctl.c
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/kernel/sysctl.c	2005-12-13 15:56:55.820232336 -0800
+++ linux-2.6.15-rc5+critical_pool/kernel/sysctl.c	2005-12-13 16:01:57.784326816 -0800
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
 
Index: linux-2.6.15-rc5+critical_pool/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/mm/page_alloc.c	2005-12-13 15:56:55.820232336 -0800
+++ linux-2.6.15-rc5+critical_pool/mm/page_alloc.c	2005-12-13 16:01:57.810322864 -0800
@@ -53,6 +53,68 @@ unsigned long totalram_pages __read_most
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
 
+/* The number of pages to maintain in the critical page pool */
+int critical_pages = 0;
+
+/* Critical Page Pool control structure */
+static struct critical_pool {
+	unsigned int free, min_free;
+	spinlock_t lock;
+	struct list_head pages;
+} critical_pool = {
+	.free		= 0,
+	.min_free	= 0,
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.pages		= LIST_HEAD_INIT(critical_pool.pages),
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
+		if (critical_pool.free < critical_pool.min_free)
+			critical_pool.min_free = critical_pool.free;
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
@@ -302,6 +364,10 @@ static inline void __free_pages_bulk (st
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
+	else if (!is_critical_pool_full())
+		/* If the critical pool isn't full, add this page to it */
+		if (put_critical_page(page))
+			return;
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
 
@@ -997,6 +1063,19 @@ rebalance:
 	}
 
 nopage:
+	/*
+	 * This is the LAST DITCH effort.
+	 * We maintain a pool of singleton (order 0) 'critical' pages,
+	 * specifically for allocation requests marked __GFP_CRITICAL.
+	 * Rather than fail one of these allocations, take a page,
+	 * if there are any, from the critical pool.
+	 */
+	if ((gfp_mask & __GFP_CRITICAL) && !order) {
+		page = get_critical_page(gfp_mask);
+		if (page)
+			goto got_pg;
+	}
+
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
 		printk(KERN_WARNING "%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
@@ -2539,6 +2618,90 @@ int lowmem_reserve_ratio_sysctl_handler(
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
+		critical_pool.min_free++;
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
+		if (critical_pool.free < critical_pool.min_free)
+			critical_pool.min_free = critical_pool.free;
+		spin_unlock(&critical_pool.lock);
+			
+		__free_pages(page, 0);
+	}
+}
+
+/*
+ * critical_pages_sysctl_handler - handle r/w of /proc/sys/vm/critical_pages
+ *     On write, add/remove pages to/from the critical page pool.
+ *     On read, dump out some simple stats about the critical page pool.
+ */
+int critical_pages_sysctl_handler(ctl_table *table, int write,
+				   struct file *file, void __user *buffer,
+				   size_t *length, loff_t *ppos)
+{
+	char buf[100];
+	int num, len;
+
+	if (write) {
+		proc_dointvec(table, write, file, buffer, length, ppos);
+
+		num = critical_pages - critical_pool.free;
+		if (num > 0)
+			fill_critical_pool(num);
+		else if (num < 0)
+			drain_critical_pool(-num);
+
+		return 0;
+	}
+
+	if (!*length || *ppos) {
+		*length = 0;
+		return 0;
+	}
+
+	sprintf(buf, "Critical Page Pool Size: %d\n"
+		"Critical Pages In Use: %d\n"
+		"Max Critical Pages In Use: %d\n", critical_pages,
+		critical_pages - critical_pool.free,
+		critical_pages - critical_pool.min_free);
+	len = strlen(buf);
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	*length = len;
+	*ppos += len;
+	return 0;
+}
+
 __initdata int hashdist = HASHDIST_DEFAULT;
 
 #ifdef CONFIG_NUMA
Index: linux-2.6.15-rc5+critical_pool/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/include/linux/mmzone.h	2005-12-13 15:56:55.820232336 -0800
+++ linux-2.6.15-rc5+critical_pool/include/linux/mmzone.h	2005-12-13 15:56:57.537971200 -0800
@@ -422,6 +422,8 @@ int min_free_kbytes_sysctl_handler(struc
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
+int critical_pages_sysctl_handler(struct ctl_table *, int, struct file *,
+				  void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
Index: linux-2.6.15-rc5+critical_pool/include/linux/mm.h
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/include/linux/mm.h	2005-12-13 15:56:55.820232336 -0800
+++ linux-2.6.15-rc5+critical_pool/include/linux/mm.h	2005-12-13 16:01:57.783326968 -0800
@@ -32,6 +32,8 @@ extern int sysctl_legacy_va_layout;
 #define sysctl_legacy_va_layout 0
 #endif
 
+extern int critical_pages;
+
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>

--------------030609020006050500090808--
