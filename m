Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWDUIpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWDUIpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWDUIpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:45:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:4818 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750967AbWDUIpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:45:06 -0400
Date: Fri, 21 Apr 2006 10:45:04 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] mm: introduce remap_vmalloc_range (pls. drop previous patchset)
Message-ID: <20060421084503.GS21660@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew isn't keen to push previous patchset upstream, so let's forget
that. Here is just the split out remap_vmalloc_range that can go upstream
easily and driver writers may use as they wish.

Nick

---
Add remap_vmalloc_range, vmalloc_user, and vmalloc_32_user so that drivers
can have a nice interface for remapping vmalloc memory.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -257,6 +257,19 @@ struct vm_struct *get_vm_area_node(unsig
 }
 
 /* Caller must hold vmlist_lock */
+static struct vm_struct *__find_vm_area(void *addr)
+{
+	struct vm_struct *tmp;
+
+	for (tmp = vmlist; tmp != NULL; tmp = tmp->next) {
+		 if (tmp->addr == addr)
+			break;
+	}
+
+	return tmp;
+}
+
+/* Caller must hold vmlist_lock */
 struct vm_struct *__remove_vm_area(void *addr)
 {
 	struct vm_struct **p, *tmp;
@@ -498,11 +511,33 @@ EXPORT_SYMBOL(__vmalloc);
  */
 void *vmalloc(unsigned long size)
 {
-       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
 }
 EXPORT_SYMBOL(vmalloc);
 
 /**
+ *	vmalloc_user  -  allocate virtually contiguous memory which has
+ *			   been zeroed so it can be mapped to userspace without
+ *			   leaking data.
+ *
+ *	@size:		allocation size
+ */
+void *vmalloc_user(unsigned long size)
+{
+	struct vm_struct *area;
+	void *ret;
+
+	ret = __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
+	write_lock(&vmlist_lock);
+	area = __find_vm_area(ret);
+	area->flags |= VM_USERMAP;
+	write_unlock(&vmlist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(vmalloc_user);
+
+/**
  *	vmalloc_node  -  allocate memory on a specific node
  *
  *	@size:		allocation size
@@ -516,7 +551,7 @@ EXPORT_SYMBOL(vmalloc);
  */
 void *vmalloc_node(unsigned long size, int node)
 {
-       return __vmalloc_node(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL, node);
+	return __vmalloc_node(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL, node);
 }
 EXPORT_SYMBOL(vmalloc_node);
 
@@ -556,6 +591,28 @@ void *vmalloc_32(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_32);
 
+/**
+ *	vmalloc_32_user  -  allocate virtually contiguous memory (32bit
+ *			      addressable) which is zeroed so it can be
+ *			      mapped to userspace without leaking data.
+ *
+ *	@size:		allocation size
+ */
+void *vmalloc_32_user(unsigned long size)
+{
+	struct vm_struct *area;
+	void *ret;
+
+	ret = __vmalloc(size, GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL);
+	write_lock(&vmlist_lock);
+	area = __find_vm_area(ret);
+	area->flags |= VM_USERMAP;
+	write_unlock(&vmlist_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(vmalloc_32_user);
+
 long vread(char *buf, char *addr, unsigned long count)
 {
 	struct vm_struct *tmp;
@@ -630,3 +687,64 @@ finished:
 	read_unlock(&vmlist_lock);
 	return buf - buf_start;
 }
+
+/**
+ *	remap_vmalloc_range  -  map vmalloc pages to userspace
+ *
+ *	@vma:		vma to cover (map full range of vma)
+ *	@addr:		vmalloc memory
+ *	@pgoff:		number of pages into addr before first page to map
+ *	@returns:	0 for success, -Exxx on failure
+ *
+ *	This function checks that addr is a valid vmalloc'ed area, and
+ *	that it is big enough to cover the vma. Will return failure if
+ *	that criteria isn't met.
+ *
+ *	Similar to remap_pfn_range (see mm/memory.c)
+ */
+int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
+						unsigned long pgoff)
+{
+	struct vm_struct *area;
+	unsigned long uaddr = vma->vm_start;
+	unsigned long usize = vma->vm_end - vma->vm_start;
+	int ret;
+
+	if ((PAGE_SIZE-1) & (unsigned long)addr)
+		return -EINVAL;
+
+	read_lock(&vmlist_lock);
+	area = __find_vm_area(addr);
+	if (!area)
+		goto out_einval_locked;
+
+	if (!(area->flags & VM_USERMAP))
+		goto out_einval_locked;
+
+	if (usize + (pgoff << PAGE_SHIFT) > area->size - PAGE_SIZE)
+		goto out_einval_locked;
+	read_unlock(&vmlist_lock);
+
+	addr = (void *)((unsigned long)addr + (pgoff << PAGE_SHIFT));
+	do {
+		struct page *page = vmalloc_to_page(addr);
+		ret = vm_insert_page(vma, uaddr, page);
+		if (ret)
+			return ret;
+
+		uaddr += PAGE_SIZE;
+		addr = (void *)((unsigned long)addr+PAGE_SIZE);
+		usize -= PAGE_SIZE;
+	} while (usize > 0);
+
+	/* Prevent "things" like memory migration? VM_flags need a cleanup... */
+	vma->vm_flags |= VM_RESERVED;
+
+	return ret;
+
+out_einval_locked:
+	read_unlock(&vmlist_lock);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(remap_vmalloc_range);
+
Index: linux-2.6/include/linux/vmalloc.h
===================================================================
--- linux-2.6.orig/include/linux/vmalloc.h
+++ linux-2.6/include/linux/vmalloc.h
@@ -8,6 +8,7 @@
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
 #define VM_ALLOC	0x00000002	/* vmalloc() */
 #define VM_MAP		0x00000004	/* vmap()ed pages */
+#define VM_USERMAP	0x00000008	/* suitable for remap_vmalloc_range */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
@@ -32,9 +33,11 @@ struct vm_struct {
  *	Highlevel APIs for driver use
  */
 extern void *vmalloc(unsigned long size);
+extern void *vmalloc_user(unsigned long size);
 extern void *vmalloc_node(unsigned long size, int node);
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
+extern void *vmalloc_32_user(unsigned long size);
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot);
 extern void *__vmalloc_area(struct vm_struct *area, gfp_t gfp_mask,
 				pgprot_t prot);
@@ -45,6 +48,9 @@ extern void vfree(void *addr);
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
 extern void vunmap(void *addr);
+
+extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
+							unsigned long pgoff);
  
 /*
  *	Lowlevel-APIs (not for driver use!)

