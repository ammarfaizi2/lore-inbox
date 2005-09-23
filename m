Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVIWRpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVIWRpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVIWRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:45:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6837 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750848AbVIWRpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:45:20 -0400
Date: Fri, 23 Sep 2005 10:44:44 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Harald Welte <laforge@netfilter.org>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
In-Reply-To: <20050923171120.GO731@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.62.0509231043270.22308@schroedinger.engr.sgi.com>
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de>
 <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de>
 <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com>
 <4332D2D9.7090802@cosmosbay.com> <20050923171120.GO731@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated version of the vmalloc_node patch:

This patch adds

vmalloc_node(size, node)	-> Allocate necessary memory on the specified node

and

get_vm_area_node(size, flags, node)

and the other functions that it depends on.

Index: linux-2.6.14-rc2/include/linux/vmalloc.h
===================================================================
--- linux-2.6.14-rc2.orig/include/linux/vmalloc.h	2005-09-19 20:00:41.000000000 -0700
+++ linux-2.6.14-rc2/include/linux/vmalloc.h	2005-09-23 10:28:37.000000000 -0700
@@ -32,22 +32,35 @@ struct vm_struct {
  *	Highlevel APIs for driver use
  */
 extern void *vmalloc(unsigned long size);
+extern void *vmalloc_node(unsigned long size, int node);
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
-extern void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot);
-extern void *__vmalloc_area(struct vm_struct *area, unsigned int __nocast gfp_mask, pgprot_t prot);
-extern void vfree(void *addr);
+extern void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask,
+				pgprot_t prot, int node);
+extern void *__vmalloc_area(struct vm_struct *area, unsigned int __nocast gfp_mask,
+				pgprot_t prot, int node);
 
+extern void vfree(void *addr);
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
 extern void vunmap(void *addr);
- 
-/*
- *	Lowlevel-APIs (not for driver use!)
+
+/**
+ *      get_vm_area  -  reserve a contingous kernel virtual area
+ *
+ *      @size:          size of the area
+ *      @flags:         %VM_IOREMAP for I/O mappings or VM_ALLOC
+ *
+ *      Search an area of @size in the kernel virtual mapping area,
+ *      and reserved it for out purposes.  Returns the area descriptor
+ *      on success or %NULL on failure.
  */
-extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
 extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
-					unsigned long start, unsigned long end);
+					unsigned long start, unsigned long end, int node);
+#define get_vm_area(__size, __flags) __get_vm_area((__size), (__flags), VMALLOC_START, \
+				 VMALLOC_END, -1)
+#define get_vm_area_node(__size, __flags, __node) __get_vm_area((__size), (__flags), \
+				VMALLOC_START, VMALLOC_END, __node)
 extern struct vm_struct *remove_vm_area(void *addr);
 extern struct vm_struct *__remove_vm_area(void *addr);
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
Index: linux-2.6.14-rc2/mm/vmalloc.c
===================================================================
--- linux-2.6.14-rc2.orig/mm/vmalloc.c	2005-09-19 20:00:41.000000000 -0700
+++ linux-2.6.14-rc2/mm/vmalloc.c	2005-09-23 10:43:07.000000000 -0700
@@ -5,6 +5,7 @@
  *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
  *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian <tigran@veritas.com>, May 2000
  *  Major rework to support vmap/vunmap, Christoph Hellwig, SGI, August 2002
+ *  Numa awareness, Christoph Lameter, SGI, June 2005
  */
 
 #include <linux/mm.h>
@@ -159,7 +160,7 @@ int map_vm_area(struct vm_struct *area, 
 }
 
 struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
-				unsigned long start, unsigned long end)
+				unsigned long start, unsigned long end, int node)
 {
 	struct vm_struct **p, *tmp, *area;
 	unsigned long align = 1;
@@ -178,7 +179,7 @@ struct vm_struct *__get_vm_area(unsigned
 	addr = ALIGN(start, align);
 	size = PAGE_ALIGN(size);
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kmalloc_node(sizeof(*area), GFP_KERNEL, node);
 	if (unlikely(!area))
 		return NULL;
 
@@ -231,21 +232,6 @@ out:
 	return NULL;
 }
 
-/**
- *	get_vm_area  -  reserve a contingous kernel virtual area
- *
- *	@size:		size of the area
- *	@flags:		%VM_IOREMAP for I/O mappings or VM_ALLOC
- *
- *	Search an area of @size in the kernel virtual mapping area,
- *	and reserved it for out purposes.  Returns the area descriptor
- *	on success or %NULL on failure.
- */
-struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
-{
-	return __get_vm_area(size, flags, VMALLOC_START, VMALLOC_END);
-}
-
 /* Caller must hold vmlist_lock */
 struct vm_struct *__remove_vm_area(void *addr)
 {
@@ -395,7 +381,8 @@ void *vmap(struct page **pages, unsigned
 
 EXPORT_SYMBOL(vmap);
 
-void *__vmalloc_area(struct vm_struct *area, unsigned int __nocast gfp_mask, pgprot_t prot)
+void *__vmalloc_area(struct vm_struct *area, unsigned int __nocast gfp_mask,
+			pgprot_t prot, int node)
 {
 	struct page **pages;
 	unsigned int nr_pages, array_size, i;
@@ -406,9 +393,9 @@ void *__vmalloc_area(struct vm_struct *a
 	area->nr_pages = nr_pages;
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE)
-		pages = __vmalloc(array_size, gfp_mask, PAGE_KERNEL);
+		pages = __vmalloc(array_size, gfp_mask, PAGE_KERNEL, node);
 	else
-		pages = kmalloc(array_size, (gfp_mask & ~__GFP_HIGHMEM));
+		pages = kmalloc_node(array_size, (gfp_mask & ~__GFP_HIGHMEM), node);
 	area->pages = pages;
 	if (!area->pages) {
 		remove_vm_area(area->addr);
@@ -418,7 +405,10 @@ void *__vmalloc_area(struct vm_struct *a
 	memset(area->pages, 0, array_size);
 
 	for (i = 0; i < area->nr_pages; i++) {
-		area->pages[i] = alloc_page(gfp_mask);
+		if (node < 0)
+			area->pages[i] = alloc_page(gfp_mask);
+		else
+			area->pages[i] = alloc_pages_node(node, gfp_mask, 0);
 		if (unlikely(!area->pages[i])) {
 			/* Successfully allocated i pages, free them in __vunmap() */
 			area->nr_pages = i;
@@ -446,7 +436,7 @@ fail:
  *	allocator with @gfp_mask flags.  Map them into contiguous
  *	kernel virtual space, using a pagetable protection of @prot.
  */
-void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot)
+void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot, int node)
 {
 	struct vm_struct *area;
 
@@ -454,13 +444,12 @@ void *__vmalloc(unsigned long size, unsi
 	if (!size || (size >> PAGE_SHIFT) > num_physpages)
 		return NULL;
 
-	area = get_vm_area(size, VM_ALLOC);
+	area = get_vm_area_node(size, VM_ALLOC, node);
 	if (!area)
 		return NULL;
 
-	return __vmalloc_area(area, gfp_mask, prot);
+	return __vmalloc_area(area, gfp_mask, prot, node);
 }
-
 EXPORT_SYMBOL(__vmalloc);
 
 /**
@@ -476,11 +465,30 @@ EXPORT_SYMBOL(__vmalloc);
  */
 void *vmalloc(unsigned long size)
 {
-       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL, -1);
 }
 
 EXPORT_SYMBOL(vmalloc);
 
+/**
+ *	vmalloc_node  -  allocate memory on a specific node
+ *
+ *	@size:		allocation size
+ *	@node;		numa node
+ *
+ *	Allocate enough pages to cover @size from the page level
+ *	allocator and map them into contiguous kernel virtual space.
+ *
+ *	For tight cotrol over page level allocator and protection flags
+ *	use __vmalloc() instead.
+ */
+void *vmalloc_node(unsigned long size, int node)
+{
+       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL, node);
+}
+
+EXPORT_SYMBOL(vmalloc_node);
+
 #ifndef PAGE_KERNEL_EXEC
 # define PAGE_KERNEL_EXEC PAGE_KERNEL
 #endif
@@ -500,7 +508,7 @@ EXPORT_SYMBOL(vmalloc);
 
 void *vmalloc_exec(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC);
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC, -1);
 }
 
 /**
@@ -513,7 +521,7 @@ void *vmalloc_exec(unsigned long size)
  */
 void *vmalloc_32(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
+	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL, -1);
 }
 
 EXPORT_SYMBOL(vmalloc_32);
Index: linux-2.6.14-rc2/fs/xfs/linux-2.6/kmem.c
===================================================================
--- linux-2.6.14-rc2.orig/fs/xfs/linux-2.6/kmem.c	2005-09-19 20:00:41.000000000 -0700
+++ linux-2.6.14-rc2/fs/xfs/linux-2.6/kmem.c	2005-09-23 10:17:20.000000000 -0700
@@ -55,7 +55,7 @@ kmem_alloc(size_t size, unsigned int __n
 		if (size < MAX_SLAB_SIZE || retries > MAX_VMALLOCS)
 			ptr = kmalloc(size, lflags);
 		else
-			ptr = __vmalloc(size, lflags, PAGE_KERNEL);
+			ptr = __vmalloc(size, lflags, PAGE_KERNEL, -1);
 		if (ptr || (flags & (KM_MAYFAIL|KM_NOSLEEP)))
 			return ptr;
 		if (!(++retries % 100))
Index: linux-2.6.14-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.14-rc2.orig/mm/page_alloc.c	2005-09-19 20:00:41.000000000 -0700
+++ linux-2.6.14-rc2/mm/page_alloc.c	2005-09-23 10:17:20.000000000 -0700
@@ -2542,7 +2542,7 @@ void *__init alloc_large_system_hash(con
 		if (flags & HASH_EARLY)
 			table = alloc_bootmem(size);
 		else if (hashdist)
-			table = __vmalloc(size, GFP_ATOMIC, PAGE_KERNEL);
+			table = __vmalloc(size, GFP_ATOMIC, PAGE_KERNEL, -1);
 		else {
 			unsigned long order;
 			for (order = 0; ((1UL << order) << PAGE_SHIFT) < size; order++)
