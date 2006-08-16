Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWHPCXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWHPCXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWHPCXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:23:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54716 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750813AbWHPCXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:02 -0400
Date: Tue, 15 Aug 2006 19:22:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20060816022243.13379.78670.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 1/7] Extract allocpercpu from Slab
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the allocpercpu functions from the slab allocator

The allocpercpu functions __alloc_percpu and __free_percpu() are
heavily using the slab allocator. However, they are conceptually
different allocators that can be used independently from the
slab. This also simplifies SLOB.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4/mm/allocpercpu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/allocpercpu.c	2006-08-13 23:26:17.588539549 -0700
@@ -0,0 +1,76 @@
+/*
+ * linux/mm/allocpercpu.c
+ *
+ * Separated out from slab.c August 11, 2006 Christoph Lameter <clameter@sgi.com>
+ */
+#include <linux/mm.h>
+#include <linux/module.h>
+
+/**
+ * __alloc_percpu - allocate one copy of the object for every present
+ * cpu in the system, zeroing them.
+ * Objects should be dereferenced using the per_cpu_ptr macro only.
+ *
+ * @size: how many bytes of memory are required.
+ */
+void *__alloc_percpu(size_t size)
+{
+	int i;
+	struct percpu_data *pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
+
+	if (!pdata)
+		return NULL;
+
+	/*
+	 * Cannot use for_each_online_cpu since a cpu may come online
+	 * and we have no way of figuring out how to fix the array
+	 * that we have allocated then....
+	 */
+	for_each_possible_cpu(i) {
+		int node = cpu_to_node(i);
+
+		if (node_online(node))
+			pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, node);
+		else
+			pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
+
+		if (!pdata->ptrs[i])
+			goto unwind_oom;
+		memset(pdata->ptrs[i], 0, size);
+	}
+
+	/* Catch derefs w/o wrappers */
+	return (void *)(~(unsigned long)pdata);
+
+unwind_oom:
+	while (--i >= 0) {
+		if (!cpu_possible(i))
+			continue;
+		kfree(pdata->ptrs[i]);
+	}
+	kfree(pdata);
+	return NULL;
+}
+EXPORT_SYMBOL(__alloc_percpu);
+
+/**
+ * free_percpu - free previously allocated percpu memory
+ * @objp: pointer returned by alloc_percpu.
+ *
+ * Don't free memory not originally allocated by alloc_percpu()
+ * The complemented objp is to check for that.
+ */
+void free_percpu(const void *objp)
+{
+	int i;
+	struct percpu_data *p = (struct percpu_data *)(~(unsigned long)objp);
+
+	/*
+	 * We allocate for all cpus so we cannot use for online cpu here.
+	 */
+	for_each_possible_cpu(i)
+	    kfree(p->ptrs[i]);
+	kfree(p);
+}
+EXPORT_SYMBOL(free_percpu);
+
Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-13 23:26:17.597328068 -0700
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SMP)	+= allocpercpu.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6.18-rc4/mm/slab.c
===================================================================
--- linux-2.6.18-rc4.orig/mm/slab.c	2006-08-13 23:26:17.521160905 -0700
+++ linux-2.6.18-rc4/mm/slab.c	2006-08-13 23:26:17.600257574 -0700
@@ -3390,55 +3390,6 @@ void *__kmalloc_track_caller(size_t size
 EXPORT_SYMBOL(__kmalloc_track_caller);
 #endif
 
-#ifdef CONFIG_SMP
-/**
- * __alloc_percpu - allocate one copy of the object for every present
- * cpu in the system, zeroing them.
- * Objects should be dereferenced using the per_cpu_ptr macro only.
- *
- * @size: how many bytes of memory are required.
- */
-void *__alloc_percpu(size_t size)
-{
-	int i;
-	struct percpu_data *pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
-
-	if (!pdata)
-		return NULL;
-
-	/*
-	 * Cannot use for_each_online_cpu since a cpu may come online
-	 * and we have no way of figuring out how to fix the array
-	 * that we have allocated then....
-	 */
-	for_each_possible_cpu(i) {
-		int node = cpu_to_node(i);
-
-		if (node_online(node))
-			pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, node);
-		else
-			pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
-
-		if (!pdata->ptrs[i])
-			goto unwind_oom;
-		memset(pdata->ptrs[i], 0, size);
-	}
-
-	/* Catch derefs w/o wrappers */
-	return (void *)(~(unsigned long)pdata);
-
-unwind_oom:
-	while (--i >= 0) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(pdata->ptrs[i]);
-	}
-	kfree(pdata);
-	return NULL;
-}
-EXPORT_SYMBOL(__alloc_percpu);
-#endif
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
@@ -3484,29 +3435,6 @@ void kfree(const void *objp)
 }
 EXPORT_SYMBOL(kfree);
 
-#ifdef CONFIG_SMP
-/**
- * free_percpu - free previously allocated percpu memory
- * @objp: pointer returned by alloc_percpu.
- *
- * Don't free memory not originally allocated by alloc_percpu()
- * The complemented objp is to check for that.
- */
-void free_percpu(const void *objp)
-{
-	int i;
-	struct percpu_data *p = (struct percpu_data *)(~(unsigned long)objp);
-
-	/*
-	 * We allocate for all cpus so we cannot use for online cpu here.
-	 */
-	for_each_possible_cpu(i)
-	    kfree(p->ptrs[i]);
-	kfree(p);
-}
-EXPORT_SYMBOL(free_percpu);
-#endif
-
 unsigned int kmem_cache_size(struct kmem_cache *cachep)
 {
 	return obj_size(cachep);
Index: linux-2.6.18-rc4/mm/slob.c
===================================================================
--- linux-2.6.18-rc4.orig/mm/slob.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4/mm/slob.c	2006-08-13 23:26:17.611975599 -0700
@@ -343,48 +343,3 @@ void kmem_cache_init(void)
 atomic_t slab_reclaim_pages = ATOMIC_INIT(0);
 EXPORT_SYMBOL(slab_reclaim_pages);
 
-#ifdef CONFIG_SMP
-
-void *__alloc_percpu(size_t size)
-{
-	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
-
-	if (!pdata)
-		return NULL;
-
-	for_each_possible_cpu(i) {
-		pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
-		if (!pdata->ptrs[i])
-			goto unwind_oom;
-		memset(pdata->ptrs[i], 0, size);
-	}
-
-	/* Catch derefs w/o wrappers */
-	return (void *) (~(unsigned long) pdata);
-
-unwind_oom:
-	while (--i >= 0) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(pdata->ptrs[i]);
-	}
-	kfree(pdata);
-	return NULL;
-}
-EXPORT_SYMBOL(__alloc_percpu);
-
-void
-free_percpu(const void *objp)
-{
-	int i;
-	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
-
-	for_each_possible_cpu(i)
-		kfree(p->ptrs[i]);
-
-	kfree(p);
-}
-EXPORT_SYMBOL(free_percpu);
-
-#endif
