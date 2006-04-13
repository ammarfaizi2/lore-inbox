Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWDMVH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWDMVH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWDMVH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:07:28 -0400
Received: from xenotime.net ([66.160.160.81]:49389 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964961AbWDMVH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:07:27 -0400
Date: Thu, 13 Apr 2006 14:09:53 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, mpm@selenic.com, ak@suse.de, davem@davemloft.net,
       paulus@samba.org, manfred@colorfullife.com, sct@redhat.com
Subject: [PATCH 1/2] add poison.h and patch primary users
Message-Id: <20060413140953.339ad6d9.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Matt Mackall wrote:
I think we should have a central poison.h file.

Localize poison values into one header file for better
documentation and easier/quicker debugging and so that the
same values won't be used for multiple purposes.

Use these constants in core arch., mm, driver, and fs code.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/mm/init.c       |    3 ++-
 arch/powerpc/mm/init_64.c |    3 ++-
 arch/sparc64/mm/init.c    |    3 ++-
 arch/x86_64/mm/init.c     |    7 +++++--
 drivers/base/dmapool.c    |    3 +--
 fs/jbd/journal.c          |    3 ++-
 include/linux/list.h      |    9 +--------
 include/linux/poison.h    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 mm/slab.c                 |   12 +-----------
 9 files changed, 61 insertions(+), 27 deletions(-)

--- linux-2617-rc1g5.orig/include/linux/list.h
+++ linux-2617-rc1g5/include/linux/list.h
@@ -4,18 +4,11 @@
 #ifdef __KERNEL__
 
 #include <linux/stddef.h>
+#include <linux/poison.h>
 #include <linux/prefetch.h>
 #include <asm/system.h>
 
 /*
- * These are non-NULL pointers that will result in page faults
- * under normal circumstances, used to verify that nobody uses
- * non-initialized list entries.
- */
-#define LIST_POISON1  ((void *) 0x00100100)
-#define LIST_POISON2  ((void *) 0x00200200)
-
-/*
  * Simple doubly linked list implementation.
  *
  * Some of the internal functions ("__xxx") are useful when
--- /dev/null
+++ linux-2617-rc1g5/include/linux/poison.h
@@ -0,0 +1,45 @@
+#ifndef _LINUX_POISON_H
+#define _LINUX_POISON_H
+
+/********** include/linux/list.h **********/
+/*
+ * These are non-NULL pointers that will result in page faults
+ * under normal circumstances, used to verify that nobody uses
+ * non-initialized list entries.
+ */
+#define LIST_POISON1  ((void *) 0x00100100)
+#define LIST_POISON2  ((void *) 0x00200200)
+
+/********** mm/slab.c **********/
+/*
+ * Magic nums for obj red zoning.
+ * Placed in the first word before and the first word after an obj.
+ */
+#define	RED_INACTIVE	0x5A2CF071UL	/* when obj is inactive */
+#define	RED_ACTIVE	0x170FC2A5UL	/* when obj is active */
+
+/* ...and for poisoning */
+#define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
+#define POISON_FREE	0x6b	/* for use-after-free poisoning */
+#define	POISON_END	0xa5	/* end-byte of poisoning */
+
+/********** arch/$ARCH/mm/init.c **********/
+#define POISON_FREE_INITMEM	0xcc
+
+/********** arch/x86_64/mm/init.c **********/
+#define	POISON_FREE_INITDATA	0xba
+
+/********** arch/ia64/hp/common/sba_iommu.c **********/
+/*
+ * arch/ia64/hp/common/sba_iommu.c uses a 16-byte poison string with a
+ * value of "SBAIOMMU POISON\0" for spill-over poisoning.
+ */
+
+/********** fs/jbd/journal.c **********/
+#define JBD_POISON_FREE	0x5b
+
+/********** drivers/base/dmapool.c **********/
+#define	POOL_POISON_FREED	0xa7	/* !inuse */
+#define	POOL_POISON_ALLOCATED	0xa9	/* !initted */
+
+#endif
--- linux-2617-rc1g5.orig/mm/slab.c
+++ linux-2617-rc1g5/mm/slab.c
@@ -89,6 +89,7 @@
 #include	<linux/config.h>
 #include	<linux/slab.h>
 #include	<linux/mm.h>
+#include	<linux/poison.h>
 #include	<linux/swap.h>
 #include	<linux/cache.h>
 #include	<linux/interrupt.h>
@@ -495,17 +496,6 @@ struct kmem_cache {
 #endif
 
 #if DEBUG
-/*
- * Magic nums for obj red zoning.
- * Placed in the first word before and the first word after an obj.
- */
-#define	RED_INACTIVE	0x5A2CF071UL	/* when obj is inactive */
-#define	RED_ACTIVE	0x170FC2A5UL	/* when obj is active */
-
-/* ...and for poisoning */
-#define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
-#define POISON_FREE	0x6b	/* for use-after-free poisoning */
-#define	POISON_END	0xa5	/* end-byte of poisoning */
 
 /*
  * memory layout of objects:
--- linux-2617-rc1g5.orig/drivers/base/dmapool.c
+++ linux-2617-rc1g5/drivers/base/dmapool.c
@@ -7,6 +7,7 @@
 #include <linux/dmapool.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/poison.h>
 
 /*
  * Pool allocator ... wraps the dma_alloc_coherent page allocator, so
@@ -35,8 +36,6 @@ struct dma_page {	/* cacheable header fo
 };
 
 #define	POOL_TIMEOUT_JIFFIES	((100 /* msec */ * HZ) / 1000)
-#define	POOL_POISON_FREED	0xa7	/* !inuse */
-#define	POOL_POISON_ALLOCATED	0xa9	/* !initted */
 
 static DECLARE_MUTEX (pools_lock);
 
--- linux-2617-rc1g5.orig/arch/x86_64/mm/init.c
+++ linux-2617-rc1g5/arch/x86_64/mm/init.c
@@ -23,6 +23,7 @@
 #include <linux/bootmem.h>
 #include <linux/proc_fs.h>
 #include <linux/pci.h>
+#include <linux/poison.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/memory_hotplug.h>
@@ -652,11 +653,13 @@ void free_initmem(void)
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		init_page_count(virt_to_page(addr));
-		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE); 
+		memset((void *)(addr & ~(PAGE_SIZE-1)),
+			POISON_FREE_INITMEM, PAGE_SIZE);
 		free_page(addr);
 		totalram_pages++;
 	}
-	memset(__initdata_begin, 0xba, __initdata_end - __initdata_begin);
+	memset(__initdata_begin, POISON_FREE_INITDATA,
+		__initdata_end - __initdata_begin);
 	printk ("Freeing unused kernel memory: %luk freed\n", (__init_end - __init_begin) >> 10);
 }
 
--- linux-2617-rc1g5.orig/fs/jbd/journal.c
+++ linux-2617-rc1g5/fs/jbd/journal.c
@@ -34,6 +34,7 @@
 #include <linux/suspend.h>
 #include <linux/pagemap.h>
 #include <linux/kthread.h>
+#include <linux/poison.h>
 #include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
@@ -1675,7 +1676,7 @@ static void journal_free_journal_head(st
 {
 #ifdef CONFIG_JBD_DEBUG
 	atomic_dec(&nr_journal_heads);
-	memset(jh, 0x5b, sizeof(*jh));
+	memset(jh, JBD_POISON_FREE, sizeof(*jh));
 #endif
 	kmem_cache_free(journal_head_cache, jh);
 }
--- linux-2617-rc1g5.orig/arch/i386/mm/init.c
+++ linux-2617-rc1g5/arch/i386/mm/init.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/poison.h>
 #include <linux/bootmem.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
@@ -752,7 +753,7 @@ void free_init_pages(char *what, unsigne
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		init_page_count(virt_to_page(addr));
-		memset((void *)addr, 0xcc, PAGE_SIZE);
+		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
 		free_page(addr);
 		totalram_pages++;
 	}
--- linux-2617-rc1g5.orig/arch/powerpc/mm/init_64.c
+++ linux-2617-rc1g5/arch/powerpc/mm/init_64.c
@@ -41,6 +41,7 @@
 #include <linux/idr.h>
 #include <linux/nodemask.h>
 #include <linux/module.h>
+#include <linux/poison.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -90,7 +91,7 @@ void free_initmem(void)
 
 	addr = (unsigned long)__init_begin;
 	for (; addr < (unsigned long)__init_end; addr += PAGE_SIZE) {
-		memset((void *)addr, 0xcc, PAGE_SIZE);
+		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
 		ClearPageReserved(virt_to_page(addr));
 		init_page_count(virt_to_page(addr));
 		free_page(addr);
--- linux-2617-rc1g5.orig/arch/sparc64/mm/init.c
+++ linux-2617-rc1g5/arch/sparc64/mm/init.c
@@ -18,6 +18,7 @@
 #include <linux/initrd.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
+#include <linux/poison.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/kprobes.h>
@@ -1474,7 +1475,7 @@ void free_initmem(void)
 		page = (addr +
 			((unsigned long) __va(kern_base)) -
 			((unsigned long) KERNBASE));
-		memset((void *)addr, 0xcc, PAGE_SIZE);
+		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
 		p = virt_to_page(page);
 
 		ClearPageReserved(p);


---
