Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319801AbSIMWD5>; Fri, 13 Sep 2002 18:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319804AbSIMWD5>; Fri, 13 Sep 2002 18:03:57 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59122 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S319801AbSIMWDx>; Fri, 13 Sep 2002 18:03:53 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@redhat.com>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vmalloc/ioremap race fix.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Sep 2002 23:08:44 +0100
Message-ID: <18904.1031954924@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	CPU0				CPU1
	----				----
	vfree()				vmalloc()
	remove vm_struct from list.
					reallocate same virtual range
					set up page tables
	tear down page tables

So we leave the vm_struct in the list but marked as being deleted, while we 
tear down the page tables. 

===== fs/proc/kcore.c 1.4 vs edited =====
--- 1.4/fs/proc/kcore.c	Fri Mar 15 11:18:21 2002
+++ edited/fs/proc/kcore.c	Fri Sep 13 22:47:36 2002
@@ -119,12 +119,12 @@
 
 	*num_vma = 0;
 	size = ((size_t)high_memory - PAGE_OFFSET + PAGE_SIZE);
-	if (!vmlist) {
+	if (list_empty(&vmlist)) {
 		*elf_buflen = PAGE_SIZE;
 		return (size);
 	}
 
-	for (m=vmlist; m; m=m->next) {
+	list_for_each_entry(m, &vmlist, list) {
 		try = (size_t)m->addr + m->size;
 		if (try > size)
 			size = try;
@@ -244,7 +244,7 @@
 	phdr->p_align	= PAGE_SIZE;
 
 	/* setup ELF PT_LOAD program header for every vmalloc'd area */
-	for (m=vmlist; m; m=m->next) {
+	list_for_each_entry(m, &vmlist, list) {
 		if (m->flags & VM_IOREMAP) /* don't dump ioremap'd stuff! (TA) */
 			continue;
 
@@ -404,11 +404,15 @@
 			memset(elf_buf, 0, tsz);
 
 			read_lock(&vmlist_lock);
-			for (m=vmlist; m && cursize; m=m->next) {
+			list_for_each_entry(m, &vmlist, list) {
 				unsigned long vmstart;
 				unsigned long vmsize;
-				unsigned long msize = m->size - PAGE_SIZE;
+				unsigned long msize;
 
+				if (!cursize)
+					break;
+
+				msize = m->size - PAGE_SIZE;
 				if (((unsigned long)m->addr + msize) < 
 								curstart)
 					continue;
===== mm/vmalloc.c 1.19 vs edited =====
--- 1.19/mm/vmalloc.c	Mon Aug 19 01:37:40 2002
+++ edited/mm/vmalloc.c	Fri Sep 13 22:28:09 2002
@@ -19,7 +19,7 @@
 
 
 rwlock_t vmlist_lock = RW_LOCK_UNLOCKED;
-struct vm_struct *vmlist;
+LIST_HEAD(vmlist);
 
 static inline void unmap_area_pte(pmd_t *pmd, unsigned long address,
 				  unsigned long size)
@@ -190,7 +190,7 @@
  */
 struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 {
-	struct vm_struct **p, *tmp, *area;
+	struct vm_struct *tmp, *area;
 	unsigned long addr = VMALLOC_START;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
@@ -203,7 +203,7 @@
 	size += PAGE_SIZE;
 
 	write_lock(&vmlist_lock);
-	for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		if ((size + addr) < addr)
 			goto out;
 		if (size + addr <= (unsigned long)tmp->addr)
@@ -214,8 +214,7 @@
 	}
 
 found:
-	area->next = *p;
-	*p = area;
+	list_add_tail(&area->list, &tmp->list);
 
 	area->flags = flags;
 	area->addr = (void *)addr;
@@ -244,18 +243,23 @@
  */
 struct vm_struct *remove_vm_area(void *addr)
 {
-	struct vm_struct **p, *tmp;
+	struct vm_struct *tmp;
 
 	write_lock(&vmlist_lock);
-	for (p = &vmlist ; (tmp = *p) ;p = &tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		 if (tmp->addr == addr)
 			 goto found;
 	}
 	write_unlock(&vmlist_lock);
 	return NULL;
 
-found:
-	*p = tmp->next;
+ found:
+	if (tmp->flags & VM_DELETING) {
+		printk(KERN_ERR "Trying to vfree() region being freed (%p)\n", addr);
+		tmp = NULL;
+	}
+	else 
+		tmp->flags |= VM_DELETING;
 	write_unlock(&vmlist_lock);
 	return tmp;
 }
@@ -293,6 +297,10 @@
 		kfree(area->pages);
 	}
 
+	write_lock(&vmlist_lock);
+	list_del(&area->list);
+	write_unlock(&vmlist_lock);
+
 	kfree(area);
 	return;
 }
@@ -302,7 +310,7 @@
  *
  *	@addr:		memory base address
  *
- *	Free the virtually continguos memory area starting at @addr, as
+ *	Free the virtually contiguous memory area starting at @addr, as
  *	obtained from vmalloc(), vmalloc_32() or __vmalloc().
  *
  *	May not be called in interrupt context.
@@ -317,7 +325,7 @@
  *
  *	@addr:		memory base address
  *
- *	Free the virtually continguos memory area starting at @addr,
+ *	Free the virtually contiguous memory area starting at @addr,
  *	which was created from the page array passed to vmap().
  *
  *	May not be called in interrupt context.
@@ -328,12 +336,12 @@
 }
 
 /**
- *	vmap  -  map an array of pages into virtually continguos space
+ *	vmap  -  map an array of pages into virtually contiguous space
  *
  *	@pages:		array of page pointers
  *	@count:		number of pages to map
  *
- *	Maps @count pages from @pages into continguos kernel virtual
+ *	Maps @count pages from @pages into contiguous kernel virtual
  *	space.
  */
 void *vmap(struct page **pages, unsigned int count)
@@ -355,14 +363,14 @@
 }
 
 /**
- *	__vmalloc  -  allocate virtually continguos memory
+ *	__vmalloc  -  allocate virtually contiguous memory
  *
  *	@size:		allocation size
  *	@gfp_mask:	flags for the page level allocator
  *	@prot:		protection mask for the allocated pages
  *
  *	Allocate enough pages to cover @size from the page level
- *	allocator with @gfp_mask flags.  Map them into continguos
+ *	allocator with @gfp_mask flags.  Map them into contiguous
  *	kernel virtual space, using a pagetable protection of @prot.
  */
 void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot)
@@ -410,12 +418,12 @@
 }
 
 /**
- *	vmalloc  -  allocate virtually continguos memory
+ *	vmalloc  -  allocate virtually contiguous memory
  *
  *	@size:		allocation size
  *
  *	Allocate enough pages to cover @size from the page level
- *	allocator and map them into continguos kernel virtual space.
+ *	allocator and map them into contiguous kernel virtual space.
  *
  *	For tight cotrol over page level allocator and protection flags
  *	use __vmalloc() instead.
@@ -426,12 +434,12 @@
 }
 
 /**
- *	vmalloc_32  -  allocate virtually continguos memory (32bit addressable)
+ *	vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
  *
  *	@size:		allocation size
  *
  *	Allocate enough 32bit PA addressable pages to cover @size from the
- *	page level allocator and map them into continguos kernel virtual space.
+ *	page level allocator and map them into contiguous kernel virtual space.
  */
 void *vmalloc_32(unsigned long size)
 {
@@ -449,7 +457,7 @@
 		count = -(unsigned long) addr;
 
 	read_lock(&vmlist_lock);
-	for (tmp = vmlist; tmp; tmp = tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		vaddr = (char *) tmp->addr;
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
 			continue;
@@ -487,7 +495,7 @@
 		count = -(unsigned long) addr;
 
 	read_lock(&vmlist_lock);
-	for (tmp = vmlist; tmp; tmp = tmp->next) {
+	list_for_each_entry(tmp, &vmlist, list) {
 		vaddr = (char *) tmp->addr;
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
 			continue;
===== include/linux/vmalloc.h 1.7 vs edited =====
--- 1.7/include/linux/vmalloc.h	Mon Aug  5 20:05:22 2002
+++ edited/include/linux/vmalloc.h	Fri Sep 13 22:28:16 2002
@@ -2,11 +2,13 @@
 #define _LINUX_VMALLOC_H
 
 #include <linux/spinlock.h>
+#include <linux/list.h>
 
 /* bits in vm_struct->flags */
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
 #define VM_ALLOC	0x00000002	/* vmalloc() */
 #define VM_MAP		0x00000004	/* vmap()ed pages */
+#define VM_DELETING	0x00000008	/* Being removed */
 
 struct vm_struct {
 	void			*addr;
@@ -15,7 +17,7 @@
 	struct page		**pages;
 	unsigned int		nr_pages;
 	unsigned long		phys_addr;
-	struct vm_struct	*next;
+	struct list_head	list;
 };
 
 /*
@@ -39,9 +41,9 @@
 extern void unmap_vm_area(struct vm_struct *area);
 
 /*
- *	Internals.  Dont't use..
+ *	Internals.  Don't use.
  */
 extern rwlock_t vmlist_lock;
-extern struct vm_struct *vmlist;
+extern struct list_head vmlist;
 
 #endif /* _LINUX_VMALLOC_H */

--
dwmw2


