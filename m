Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVCFRzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVCFRzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVCFRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:54:42 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:28289 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261454AbVCFRvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:51:42 -0500
Message-ID: <422B526F.17B8431@tv-sign.ru>
Date: Sun, 06 Mar 2005 21:56:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/5] vmalloc: use list of pages instead of array in vm_struct
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch assumes that there is no valid usage of
vmalloced_or_vmaped_page->lru.

In such a case vm_struct->array could be eliminated.
It saves some memory and simplifies code a bit.

In vmap/vunmap case vm_struct->page_list is used only
in map_vm_area(), so it is ok to do:

	addr1 = vmap(pages, count);
	addr2 = vmap(pages, count);
	...
	vunmap(addr1);
	vunmap(addr2);

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/include/linux/1_vmalloc.h	2005-03-06 19:39:05.000000000 +0300
+++ 2.6.11/include/linux/vmalloc.h	2005-03-06 21:59:30.000000000 +0300
@@ -2,6 +2,7 @@
 #define _LINUX_VMALLOC_H
 
 #include <linux/spinlock.h>
+#include <linux/list.h>
 #include <asm/page.h>		/* pgprot_t */
 
 /* bits in vm_struct->flags */
@@ -14,8 +15,7 @@ struct vm_struct {
 	void			*addr;
 	unsigned long		size;
 	unsigned long		flags;
-	struct page		**pages;
-	unsigned int		nr_pages;
+	struct list_head	page_list;
 	unsigned long		phys_addr;
 	struct vm_struct	*next;
 };
@@ -30,6 +30,7 @@ extern void *__vmalloc(unsigned long siz
 extern void *__vmalloc_area(struct vm_struct *area, int gfp_mask, pgprot_t prot);
 extern void vfree(void *addr);
 
+struct page;
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
 extern void vunmap(void *addr);
@@ -41,8 +42,7 @@ extern struct vm_struct *get_vm_area(uns
 extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 					unsigned long start, unsigned long end);
 extern struct vm_struct *remove_vm_area(void *addr);
-extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
-			struct page ***pages);
+extern int map_vm_area(struct vm_struct *area, pgprot_t prot);
 extern void unmap_vm_area(struct vm_struct *area);
 
 /*
--- 2.6.11/mm/1_vmalloc.c	2005-03-06 20:31:01.000000000 +0300
+++ 2.6.11/mm/vmalloc.c	2005-03-06 22:12:55.000000000 +0300
@@ -112,7 +112,7 @@ static void unmap_area_pud(pgd_t *pgd, u
 
 static int map_area_pte(pte_t *pte, unsigned long address,
 			       unsigned long size, pgprot_t prot,
-			       struct page ***pages)
+			       struct list_head **pages)
 {
 	unsigned long end;
 
@@ -122,22 +122,23 @@ static int map_area_pte(pte_t *pte, unsi
 		end = PMD_SIZE;
 
 	do {
-		struct page *page = **pages;
+		struct page *page;
+
 		WARN_ON(!pte_none(*pte));
-		if (!page)
-			return -ENOMEM;
+
+		*pages = (*pages)->next;
+		page = list_entry(*pages, struct page, lru);
 
 		set_pte(pte, mk_pte(page, prot));
 		address += PAGE_SIZE;
 		pte++;
-		(*pages)++;
 	} while (address < end);
 	return 0;
 }
 
 static int map_area_pmd(pmd_t *pmd, unsigned long address,
 			       unsigned long size, pgprot_t prot,
-			       struct page ***pages)
+			       struct list_head **pages)
 {
 	unsigned long base, end;
 
@@ -162,7 +163,7 @@ static int map_area_pmd(pmd_t *pmd, unsi
 
 static int map_area_pud(pud_t *pud, unsigned long address,
 			       unsigned long end, pgprot_t prot,
-			       struct page ***pages)
+			       struct list_head **pages)
 {
 	do {
 		pmd_t *pmd = pmd_alloc(&init_mm, pud, address);
@@ -198,8 +199,9 @@ void unmap_vm_area(struct vm_struct *are
 	flush_tlb_kernel_range((unsigned long) area->addr, end);
 }
 
-int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page ***pages)
+int map_vm_area(struct vm_struct *area, pgprot_t prot)
 {
+	struct list_head *pages = &area->page_list;
 	unsigned long address = (unsigned long) area->addr;
 	unsigned long end = address + (area->size-PAGE_SIZE);
 	unsigned long next;
@@ -218,7 +220,7 @@ int map_vm_area(struct vm_struct *area, 
 		next = (address + PGDIR_SIZE) & PGDIR_MASK;
 		if (next < address || next > end)
 			next = end;
-		if (map_area_pud(pud, address, next, prot, pages)) {
+		if (map_area_pud(pud, address, next, prot, &pages)) {
 			err = -ENOMEM;
 			break;
 		}
@@ -290,8 +292,7 @@ found:
 	area->flags = flags;
 	area->addr = (void *)addr;
 	area->size = size;
-	area->pages = NULL;
-	area->nr_pages = 0;
+	INIT_LIST_HEAD(&area->page_list);
 	area->phys_addr = 0;
 	write_unlock(&vmlist_lock);
 
@@ -368,20 +369,12 @@ void __vunmap(void *addr, int deallocate
 		WARN_ON(1);
 		return;
 	}
-	
-	if (deallocate_pages) {
-		int i;
 
-		for (i = 0; i < area->nr_pages; i++) {
-			if (unlikely(!area->pages[i]))
-				BUG();
-			__free_page(area->pages[i]);
-		}
+	if (deallocate_pages) {
+		struct page *page, *tmp;
 
-		if (area->nr_pages > PAGE_SIZE/sizeof(struct page *))
-			vfree(area->pages);
-		else
-			kfree(area->pages);
+		list_for_each_entry_safe(page, tmp, &area->page_list, lru)
+			__free_page(page);
 	}
 
 	kfree(area);
@@ -440,13 +433,17 @@ void *vmap(struct page **pages, unsigned
 {
 	struct vm_struct *area;
 
-	if (count > num_physpages)
-		return NULL;
-
 	area = get_vm_area((count << PAGE_SHIFT), flags);
 	if (!area)
 		return NULL;
-	if (map_vm_area(area, prot, &pages)) {
+
+	while (count--) {
+		struct page *page = *pages++;
+		BUG_ON(!page);
+		list_add_tail(&page->lru, &area->page_list);
+	}
+
+	if (map_vm_area(area, prot)) {
 		vunmap(area->addr);
 		return NULL;
 	}
@@ -458,37 +455,20 @@ EXPORT_SYMBOL(vmap);
 
 void *__vmalloc_area(struct vm_struct *area, int gfp_mask, pgprot_t prot)
 {
-	struct page **pages;
-	unsigned int nr_pages, array_size, i;
+	unsigned int nr_pages;
 
 	nr_pages = (area->size - PAGE_SIZE) >> PAGE_SHIFT;
-	array_size = (nr_pages * sizeof(struct page *));
 
-	area->nr_pages = nr_pages;
-	/* Please note that the recursion is strictly bounded. */
-	if (array_size > PAGE_SIZE)
-		pages = __vmalloc(array_size, gfp_mask, PAGE_KERNEL);
-	else
-		pages = kmalloc(array_size, (gfp_mask & ~__GFP_HIGHMEM));
-	area->pages = pages;
-	if (!area->pages) {
-		remove_vm_area(area->addr);
-		kfree(area);
-		return NULL;
-	}
-	memset(area->pages, 0, array_size);
-
-	for (i = 0; i < area->nr_pages; i++) {
-		area->pages[i] = alloc_page(gfp_mask);
-		if (unlikely(!area->pages[i])) {
-			/* Successfully allocated i pages, free them in __vunmap() */
-			area->nr_pages = i;
+	while (nr_pages--) {
+		struct page *page = alloc_page(gfp_mask);
+		if (!page)
 			goto fail;
-		}
+		list_add_tail(&page->lru, &area->page_list);
 	}
 
-	if (map_vm_area(area, prot, &pages))
+	if (map_vm_area(area, prot))
 		goto fail;
+
 	return area->addr;
 
 fail:
