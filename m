Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVCFRzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVCFRzL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVCFRx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:53:57 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:25985 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261452AbVCFRvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:51:40 -0500
Message-ID: <422B526D.C6814232@tv-sign.ru>
Date: Sun, 06 Mar 2005 21:56:45 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/5] vmalloc: use __vmalloc_area in arch/x86_64/
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded __vmalloc() with __vmalloc_area().

Uncompiled, untested.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/arch/x86_64/kernel/module.c~	2005-03-06 21:25:41.000000000 +0300
+++ 2.6.11/arch/x86_64/kernel/module.c	2005-03-06 21:32:34.000000000 +0300
@@ -29,107 +29,27 @@
 #include <asm/pgtable.h>
 
 #define DEBUGP(fmt...) 
- 
-static struct vm_struct *mod_vmlist;
 
 void module_free(struct module *mod, void *module_region)
 {
-	struct vm_struct **prevp, *map;
-	int i;
-	unsigned long addr = (unsigned long)module_region;
-
-	if (!addr)
-		return;
-	write_lock(&vmlist_lock); 
-	for (prevp = &mod_vmlist ; (map = *prevp) ; prevp = &map->next) {
-		if ((unsigned long)map->addr == addr) {
-			*prevp = map->next;
-			goto found;
-		}
-	}
-	write_unlock(&vmlist_lock); 
-	printk("Trying to unmap nonexistent module vm area (%lx)\n", addr);
-	return;
- found:
-	unmap_vm_area(map);
-	write_unlock(&vmlist_lock); 
-	if (map->pages) {
-		for (i = 0; i < map->nr_pages; i++)
-			if (map->pages[i])
-				__free_page(map->pages[i]);	
-		kfree(map->pages);
-	}
-	kfree(map);					
+	vfree(module_region);
 }
 
 void *module_alloc(unsigned long size)
 {
-	struct vm_struct **p, *tmp, *area;
-	struct page **pages;
-	void *addr;
-	unsigned int nr_pages, array_size, i;
+	struct vm_struct *area;
 
 	if (!size)
-		return NULL; 
+		return NULL;
 	size = PAGE_ALIGN(size);
 	if (size > MODULES_LEN)
 		return NULL;
 
-	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
+	area = __get_vm_area(size, VM_ALLOC, MODULES_VADDR, MODULES_END);
 	if (!area)
 		return NULL;
-	memset(area, 0, sizeof(struct vm_struct));
 
-	write_lock(&vmlist_lock);
-	addr = (void *) MODULES_VADDR;
-	for (p = &mod_vmlist; (tmp = *p); p = &tmp->next) {
-		void *next; 
-		DEBUGP("vmlist %p %lu addr %p\n", tmp->addr, tmp->size, addr);
-		if (size + (unsigned long) addr + PAGE_SIZE < (unsigned long) tmp->addr)
-			break;
-		next = (void *) (tmp->size + (unsigned long) tmp->addr);
-		if (next > addr) 
-			addr = next;
-	}
-
-	if ((unsigned long)addr + size >= MODULES_END) {
-		write_unlock(&vmlist_lock);
-		kfree(area); 
-		return NULL;
-	}
-	DEBUGP("addr %p\n", addr);
-
-	area->next = *p;
-	*p = area;
-	area->size = size + PAGE_SIZE;
-	area->addr = addr;
-	write_unlock(&vmlist_lock);
-
-	nr_pages = size >> PAGE_SHIFT;
-	array_size = (nr_pages * sizeof(struct page *));
-
-	area->nr_pages = nr_pages;
-	area->pages = pages = kmalloc(array_size, GFP_KERNEL);
-	if (!area->pages) 
-		goto fail;
-
-	memset(area->pages, 0, array_size);
-	for (i = 0; i < nr_pages; i++) {
-		area->pages[i] = alloc_page(GFP_KERNEL);
-		if (area->pages[i] == NULL)
-			goto fail;
-	}
-	
-	if (map_vm_area(area, PAGE_KERNEL_EXEC, &pages))
-		goto fail;
-	
-	memset(addr, 0, size);
-	DEBUGP("module_alloc size %lu = %p\n", size, addr);
-	return addr;
-
-fail:
-	module_free(NULL, addr);
-	return NULL;
+	return __vmalloc_area(area, GFP_KERNEL, PAGE_KERNEL_EXEC);
 }
 
 /* We don't need anything special. */
