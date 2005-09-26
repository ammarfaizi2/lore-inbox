Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVIZR7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVIZR7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVIZR7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:59:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6121 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932448AbVIZR7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:59:01 -0400
Date: Mon, 26 Sep 2005 10:58:19 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Eric Dumazet <dada1@cosmosbay.com>, Harald Welte <laforge@netfilter.org>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: vmalloc_node
In-Reply-To: <1127498679.10664.85.camel@localhost>
Message-ID: <Pine.LNX.4.62.0509261046410.3650@schroedinger.engr.sgi.com>
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de> 
 <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de> 
 <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com> 
 <4332D2D9.7090802@cosmosbay.com>  <20050923171120.GO731@sunbeam.de.gnumonks.org>
  <Pine.LNX.4.62.0509231043270.22308@schroedinger.engr.sgi.com>
 <1127498679.10664.85.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005, Dave Hansen wrote:

> Instead of hard-coding all of those -1's for the node to specify a
> default allocation, and changing all of those callers, why not:

Done.

> 	__vmalloc_node(size, gfp_mask, prot, -1);
> A named macro is probably better than -1, but if it is only used in one
> place, it is hard to complain.

-1 is used consistently in the *_node functions to indicate that the node 
is not specified. Should I replace -1 throughout the kernel with a 
constant?

Here is the updated vmalloc_node patch:

--

This patch adds

vmalloc_node(size, node)	-> Allocate necessary memory on the specified node

and

get_vm_area_node(size, flags, node)

and the other functions that it depends on.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc2/include/linux/vmalloc.h
===================================================================
--- linux-2.6.14-rc2.orig/include/linux/vmalloc.h	2005-09-19 20:00:41.000000000 -0700
+++ linux-2.6.14-rc2/include/linux/vmalloc.h	2005-09-26 10:40:57.000000000 -0700
@@ -32,22 +32,37 @@ struct vm_struct {
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
+				pgprot_t prot);
+extern void *__vmalloc_node(unsigned long size, unsigned int __nocast gfp_mask,
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
+++ linux-2.6.14-rc2/mm/vmalloc.c	2005-09-26 10:46:14.000000000 -0700
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
+		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
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
@@ -436,17 +426,18 @@ fail:
 }
 
 /**
- *	__vmalloc  -  allocate virtually contiguous memory
+ *	__vmalloc_node  -  allocate virtually contiguous memory
  *
  *	@size:		allocation size
  *	@gfp_mask:	flags for the page level allocator
  *	@prot:		protection mask for the allocated pages
+ *	@node		node to use for allocation or -1
  *
  *	Allocate enough pages to cover @size from the page level
  *	allocator with @gfp_mask flags.  Map them into contiguous
  *	kernel virtual space, using a pagetable protection of @prot.
  */
-void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot)
+void *__vmalloc_node(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot, int node)
 {
 	struct vm_struct *area;
 
@@ -454,13 +445,18 @@ void *__vmalloc(unsigned long size, unsi
 	if (!size || (size >> PAGE_SHIFT) > num_physpages)
 		return NULL;
 
-	area = get_vm_area(size, VM_ALLOC);
+	area = get_vm_area_node(size, VM_ALLOC, node);
 	if (!area)
 		return NULL;
 
-	return __vmalloc_area(area, gfp_mask, prot);
+	return __vmalloc_area(area, gfp_mask, prot, node);
 }
+EXPORT_SYMBOL(__vmalloc_node);
 
+void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot)
+{
+	return __vmalloc_node(size, gfp_mask, prot, -1);
+}
 EXPORT_SYMBOL(__vmalloc);
 
 /**
@@ -481,6 +477,25 @@ void *vmalloc(unsigned long size)
 
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
+       return __vmalloc_node(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL, node);
+}
+
+EXPORT_SYMBOL(vmalloc_node);
+
 #ifndef PAGE_KERNEL_EXEC
 # define PAGE_KERNEL_EXEC PAGE_KERNEL
 #endif
