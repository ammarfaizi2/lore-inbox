Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSGRU5U>; Thu, 18 Jul 2002 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSGRU5U>; Thu, 18 Jul 2002 16:57:20 -0400
Received: from verein.lst.de ([212.34.181.86]:43021 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318342AbSGRU5M>;
	Thu, 18 Jul 2002 16:57:12 -0400
Date: Thu, 18 Jul 2002 23:00:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvals@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vmap_pages()
Message-ID: <20020718230003.A6500@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvals@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's more and more pressure getting XFS into mainline now that most
distributors ship it and SGI's Red Hat-based installers are in wide use,
and although most of the core kernel changes in the XFS tree have been
removed by redesigning/rewriting XFS code.

Still there are a bunch of core code changes that are needed for XFS to
work without beeing totally rewritten and this patch is an alternate
version (which should also be usable properly for non-XFS purposes) of
the probably most important missing core functionality needed by XFS.

The vmap_pages() functions allows to map an array of virtually
non-continguos pages into the kernel virtual memory.  The implementation
is very simple and a small variation of vmalloc() - instead of
allocating new pages in alloc_area_pte() uncondintionally a pointer to a
page array is passed down all through vmalloc_area_pages => alloc_area_pmd
=> alloc_area_pte and if it is non-null no pages are allocated but the
reference count on the existing ones is incremented.

The old vmalloc_area_pages is renamed to __vmap_area_pages and
vmalloc_area_pages is a small wrapper around it, passing in an NULL page
array.  Similarly __vmalloc is renamed to vmap_pages and a small wrapper
is added.

In addition I've removed th unused vmalloc_dma and cleaned up vmalloc.h
a little - this could need more cleanup (and kdoc documentation for
the vmalloc.c stuff), but I will do this later in an incremental patch.


--- linux-2.5/drivers/char/mem.c	Sat Jul 13 20:38:52 2002
+++ linux-2.5-xfs/drivers/char/mem.c	Thu Jul 18 23:45:36 2002
@@ -42,6 +42,9 @@
 #if defined(CONFIG_S390_TAPE) && defined(CONFIG_S390_TAPE_CHAR)
 extern void tapechar_init(void);
 #endif
+
+extern long vwrite(char *buf, char *addr, unsigned long count);
+extern long vread(char *buf, char *addr, unsigned long count);
      
 static ssize_t do_write_mem(struct file * file, void *p, unsigned long realp,
 			    const char * buf, size_t count, loff_t *ppos)
@@ -273,8 +276,6 @@
  	return virtr + read;
 }
 
-extern long vwrite(char *buf, char *addr, unsigned long count);
-
 /*
  * This function writes to the *virtual* memory as seen by the kernel.
  */
--- linux-2.5/kernel/ksyms.c	Sat Jul 13 20:40:52 2002
+++ linux-2.5-xfs/kernel/ksyms.c	Thu Jul 18 23:15:58 2002
@@ -112,6 +112,7 @@
 EXPORT_SYMBOL(vmalloc);
 EXPORT_SYMBOL(vmalloc_32);
 EXPORT_SYMBOL(vmalloc_to_page);
+EXPORT_SYMBOL(vmap_pages);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);
 EXPORT_SYMBOL(max_mapnr);
--- linux-2.5/include/linux/vmalloc.h	Sat Jul 13 20:40:46 2002
+++ linux-2.5-xfs/include/linux/vmalloc.h	Thu Jul 18 23:13:46 2002
@@ -1,10 +1,12 @@
-#ifndef __LINUX_VMALLOC_H
-#define __LINUX_VMALLOC_H
+#ifndef _LINUX_VMALLOC_H
+#define _LINUX_VMALLOC_H
 
 #include <linux/spinlock.h>
-
 #include <asm/pgtable.h>
 
+struct page;
+
+
 /* bits in vm_struct->flags */
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
 #define VM_ALLOC	0x00000002	/* vmalloc() */
@@ -17,28 +19,25 @@
 	struct vm_struct * next;
 };
 
-extern struct vm_struct * get_vm_area (unsigned long size, unsigned long flags);
-extern void vfree(void * addr);
+
 extern void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot);
-extern long vread(char *buf, char *addr, unsigned long count);
-extern void vmfree_area_pages(unsigned long address, unsigned long size);
+extern void * vmalloc(unsigned long size);
+extern void * vmalloc_32(unsigned long size);
+extern void * vmap_pages(struct page **pages, unsigned long size,
+			 int gfp_mask, pgprot_t prot);
+extern void vfree(void * addr);
+
+extern struct vm_struct * get_vm_area (unsigned long size, unsigned long flags);
 extern int vmalloc_area_pages(unsigned long address, unsigned long size,
                               int gfp_mask, pgprot_t prot);
+extern void vmfree_area_pages(unsigned long address, unsigned long size);
 extern struct vm_struct *remove_kernel_area(void *addr);
 
 /*
- * Various ways to allocate pages.
- */
-
-extern void * vmalloc(unsigned long size);
-extern void * vmalloc_32(unsigned long size);
-
-/*
  * vmlist_lock is a read-write spinlock that protects vmlist
  * Used in mm/vmalloc.c (get_vm_area() and vfree()) and fs/proc/kcore.c.
  */
 extern rwlock_t vmlist_lock;
-
 extern struct vm_struct * vmlist;
-#endif
 
+#endif /* _LINUX_VMALLOC_H */
--- linux-2.5/mm/vmalloc.c	Sat Jul 13 20:40:53 2002
+++ linux-2.5-xfs/mm/vmalloc.c	Thu Jul 18 23:11:36 2002
@@ -99,8 +99,9 @@
 	flush_tlb_kernel_range(start, end);
 }
 
-static inline int alloc_area_pte (pte_t * pte, unsigned long address,
-			unsigned long size, int gfp_mask, pgprot_t prot)
+static inline int alloc_area_pte(pte_t * pte, struct page ** pages,
+				 unsigned long address, unsigned long size,
+				 int gfp_mask, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -110,9 +111,17 @@
 		end = PMD_SIZE;
 	do {
 		struct page * page;
-		spin_unlock(&init_mm.page_table_lock);
-		page = alloc_page(gfp_mask);
-		spin_lock(&init_mm.page_table_lock);
+
+		if (pages) {
+			page = *(pages++);
+
+			/* Add a reference to the page so we can free later */
+			get_page(page);
+		} else {
+			spin_unlock(&init_mm.page_table_lock);
+			page = alloc_page(gfp_mask);
+			spin_lock(&init_mm.page_table_lock);
+		}
 		if (!pte_none(*pte))
 			printk(KERN_ERR "alloc_area_pte: page already exists\n");
 		if (!page)
@@ -124,7 +133,9 @@
 	return 0;
 }
 
-static inline int alloc_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size, int gfp_mask, pgprot_t prot)
+static inline int alloc_area_pmd(pmd_t * pmd, struct page ** pages,
+				 unsigned long address, unsigned long size,
+				 int gfp_mask, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -136,7 +147,8 @@
 		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
-		if (alloc_area_pte(pte, address, end - address, gfp_mask, prot))
+		if (alloc_area_pte(pte, pages, address, end - address,
+					gfp_mask, prot))
 			return -ENOMEM;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -144,8 +156,8 @@
 	return 0;
 }
 
-inline int vmalloc_area_pages (unsigned long address, unsigned long size,
-                               int gfp_mask, pgprot_t prot)
+int __vmap_area_pages(struct page ** pages, unsigned long address,
+		      unsigned long size, int gfp_mask, pgprot_t prot)
 {
 	pgd_t * dir;
 	unsigned long end = address + size;
@@ -162,7 +174,8 @@
 			break;
 
 		ret = -ENOMEM;
-		if (alloc_area_pmd(pmd, address, end - address, gfp_mask, prot))
+		if (alloc_area_pmd(pmd, pages, address, end - address,
+					gfp_mask, prot))
 			break;
 
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
@@ -175,6 +188,12 @@
 	return ret;
 }
 
+int vmalloc_area_pages(unsigned long address, unsigned long size,
+		       int gfp_mask, pgprot_t prot)
+{
+	return __vmap_area_pages(NULL, address, size, gfp_mask, prot);
+}
+
 struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
 {
 	unsigned long addr;
@@ -238,41 +257,15 @@
 	}
 	tmp = remove_kernel_area(addr); 
 	if (tmp) { 
-			vmfree_area_pages(VMALLOC_VMADDR(tmp->addr), tmp->size);
-			kfree(tmp);
-			return;
-		}
+		vmfree_area_pages(VMALLOC_VMADDR(tmp->addr), tmp->size);
+		kfree(tmp);
+		return;
+	}
 	printk(KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n", addr);
 }
 
-/*
- *	Allocate any pages
- */
-
-void * vmalloc (unsigned long size)
-{
-	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
-}
-
-/*
- *	Allocate ISA addressable pages for broke crap
- */
-
-void * vmalloc_dma (unsigned long size)
-{
-	return __vmalloc(size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL);
-}
-
-/*
- *	vmalloc 32bit PA addressable pages - eg for PCI 32bit devices
- */
-
-void * vmalloc_32(unsigned long size)
-{
-	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
-}
-
-void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot)
+void * vmap_pages(struct page **pages, unsigned long size,
+		 int gfp_mask, pgprot_t prot)
 {
 	void * addr;
 	struct vm_struct *area;
@@ -286,13 +279,37 @@
 	if (!area)
 		return NULL;
 	addr = area->addr;
-	if (vmalloc_area_pages(VMALLOC_VMADDR(addr), size, gfp_mask, prot)) {
+	if (__vmap_area_pages(pages, VMALLOC_VMADDR(addr), size, gfp_mask, prot)) {
 		vfree(addr);
 		return NULL;
 	}
 	return addr;
 }
 
+void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot)
+{
+	return vmap_pages(NULL, size, gfp_mask, prot);
+}
+
+/*
+ *	Allocate any pages
+ */
+
+void * vmalloc (unsigned long size)
+{
+	return vmap_pages(NULL, size, GFP_KERNEL|__GFP_HIGHMEM, PAGE_KERNEL);
+}
+
+/*
+ *	vmalloc 32bit PA addressable pages - eg for PCI 32bit devices
+ */
+
+void * vmalloc_32(unsigned long size)
+{
+	return vmap_pages(NULL, size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL);
+}
+
+
 long vread(char *buf, char *addr, unsigned long count)
 {
 	struct vm_struct *tmp;
