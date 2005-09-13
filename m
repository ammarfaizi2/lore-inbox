Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVIMP6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVIMP6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVIMP6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:58:13 -0400
Received: from serv01.siteground.net ([70.85.91.68]:26525 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964823AbVIMP6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:58:11 -0400
Date: Tue, 13 Sep 2005 08:58:01 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 3/11] mm: Reimplementation of dynamic per-cpu allocator -- alloc_percpu_atomic
Message-ID: <20050913155801.GE3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch changes the alloc_percpu interface to accept gfp_flags as an
argument.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: alloc_percpu-2.6.13-rc6/include/linux/percpu.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/percpu.h	2005-08-15 17:28:42.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/include/linux/percpu.h	2005-08-15 18:44:17.000000000 -0700
@@ -29,16 +29,17 @@
 	((__typeof__(ptr))                      \
 	(RELOC_HIDE(ptr,  PCPU_BLKSIZE * cpu)))
 
-extern void *__alloc_percpu(size_t size, size_t align);
+extern void *__alloc_percpu(size_t size, size_t align, unsigned int gfpflags);
 extern void free_percpu(const void *);
 
 #else /* CONFIG_SMP */
 
 #define per_cpu_ptr(ptr, cpu) (ptr)
 
-static inline void *__alloc_percpu(size_t size, size_t align)
+static inline void *
+__alloc_percpu(size_t size, size_t align, unsigned int gfpflags)
 {
-	void *ret = kmalloc(size, GFP_KERNEL);
+	void *ret = kmalloc(size, gfpflags);
 	if (ret)
 		memset(ret, 0, size);
 	return ret;
@@ -51,7 +52,11 @@
 #endif /* CONFIG_SMP */
 
 /* Simple wrapper for the common case: zeros memory. */
-#define alloc_percpu(type) \
-	((type *)(__alloc_percpu(ALIGN(sizeof (type), PCPU_CURR_SIZE),  __alignof__(type))))
+#define alloc_percpu(type, gfpflags) 					\
+({									\
+	BUG_ON(~(GFP_ATOMIC|GFP_KERNEL) & gfpflags);			\
+	((type *)(__alloc_percpu(ALIGN(sizeof (type), PCPU_CURR_SIZE), 	\
+		   __alignof__(type), gfpflags)));			\
+})
 
 #endif /* __LINUX_PERCPU_H */
Index: alloc_percpu-2.6.13-rc6/mm/percpu.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/mm/percpu.c	2005-08-15 17:28:42.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/mm/percpu.c	2005-08-15 19:01:11.000000000 -0700
@@ -109,7 +109,7 @@
  * contiguous kva space, and PCPU_BLKSIZE amount of node local 
  * memory (pages) for all cpus possible + BLOCK_MANAGEMENT_SIZE pages
  */
-static void *valloc_percpu(void)
+static void *valloc_percpu(unsigned int gfpflags)
 {
 	int i, j = 0;
 	unsigned int nr_pages;
@@ -118,14 +118,21 @@
 	struct page *pages[BLOCK_MANAGEMENT_PAGES];
 	unsigned int cpu_pages = PCPU_BLKSIZE >> PAGE_SHIFT;
 	struct pcpu_block *blkp = NULL;
+	unsigned int flags;
 
 	BUG_ON(!IS_ALIGNED(PCPU_BLKSIZE, PAGE_SIZE));
 	BUG_ON(!PCPU_BLKSIZE);
 	nr_pages = PCPUPAGES_PER_BLOCK + BLOCK_MANAGEMENT_PAGES;
 
+	/* gfpflags can be either GFP_KERNEL or GFP_ATOMIC only */
+	if (gfpflags & GFP_KERNEL)
+		flags = GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO;
+	else
+		flags = GFP_ATOMIC|__GFP_ZERO;
+	
 	/* Alloc Managent block pages */
 	for (i = 0; i < BLOCK_MANAGEMENT_PAGES; i++) {
-		pages[i] = alloc_pages(GFP_ATOMIC|__GFP_ZERO, 0);
+		pages[i] = alloc_pages(flags, 0);
 		if (!pages[i]) {
 			while (--i >= 0)
 				__free_pages(pages[i], 0);
@@ -135,7 +142,7 @@
 
 	/* Get the contiguous VA space for this block */
 	area = __get_vm_area(nr_pages << PAGE_SHIFT, VM_MAP, VMALLOC_START,
-				VMALLOC_END, GFP_KERNEL);
+				VMALLOC_END, gfpflags);
 	if (!area)
 		goto rollback_mgt;
 
@@ -156,11 +163,8 @@
 	for_each_cpu(i) {
 		int start_idx = i * cpu_pages;
 		for (j = start_idx; j < start_idx + cpu_pages; j++) {
-			blkp->pages[j] = alloc_pages_node(cpu_to_node(i)
-							  ,
-							  GFP_ATOMIC |
-							  __GFP_HIGHMEM,
-							  0);
+			blkp->pages[j] = alloc_pages_node(cpu_to_node(i) , 
+						flags, 0);
 			if (unlikely(!blkp->pages[j]))
 				goto rollback_pages;
 		}
@@ -260,13 +264,13 @@
 
 }
 
-static int add_percpu_block(void)
+static int add_percpu_block(unsigned int gfpflags)
 {
 	struct pcpu_block *blkp;
 	void *start_addr;
 	unsigned long flags;
 
-	start_addr = valloc_percpu();
+	start_addr = valloc_percpu(gfpflags);
 	if (!start_addr)
 		return 0;
 	blkp = start_addr + PCPUPAGES_PER_BLOCK * PAGE_SIZE;
@@ -464,7 +468,7 @@
  * by during boot/module init.
  * Should not be called from interrupt context 
  */
-void *__alloc_percpu(size_t size, size_t align)
+void *__alloc_percpu(size_t size, size_t align, unsigned int gfpflags)
 {
 	struct pcpu_block *blkp;
 	struct list_head *l;
@@ -512,7 +516,7 @@
 unlock_and_get_mem:
 
 	spin_unlock_irqrestore(&blklist_lock, flags);
-	if (add_percpu_block())
+	if (add_percpu_block(gfpflags))
 		goto try_after_refill;
 	return NULL;
 
