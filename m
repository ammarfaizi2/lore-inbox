Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVCFR7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVCFR7R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVCFRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:53:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:23425 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261453AbVCFRvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:51:39 -0500
Message-ID: <422B526A.ED3E64CD@tv-sign.ru>
Date: Sun, 06 Mar 2005 21:56:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/5] vmalloc: use __vmalloc_area in arch/sparc64/
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded __vmalloc() with __vmalloc_area().

Uncompiled, untested.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/arch/sparc64/kernel/module.c~	2005-03-06 20:52:57.000000000 +0300
+++ 2.6.11/arch/sparc64/kernel/module.c	2005-03-06 21:07:02.000000000 +0300
@@ -17,108 +17,19 @@
 #include <asm/processor.h>
 #include <asm/spitfire.h>
 
-static struct vm_struct * modvmlist = NULL;
-
-static void module_unmap(void * addr)
-{
-	struct vm_struct **p, *tmp;
-	int i;
-
-	if (!addr)
-		return;
-	if ((PAGE_SIZE-1) & (unsigned long) addr) {
-		printk("Trying to unmap module with bad address (%p)\n", addr);
-		return;
-	}
-
-	for (p = &modvmlist; (tmp = *p) != NULL; p = &tmp->next) {
-		if (tmp->addr == addr) {
-			*p = tmp->next;
-			goto found;
-		}
-	}
-	printk("Trying to unmap nonexistent module vm area (%p)\n", addr);
-	return;
-
-found:
-	unmap_vm_area(tmp);
-	
-	for (i = 0; i < tmp->nr_pages; i++) {
-		if (unlikely(!tmp->pages[i]))
-			BUG();
-		__free_page(tmp->pages[i]);
-	}
-
-	kfree(tmp->pages);
-	kfree(tmp);
-}
-
-
 static void *module_map(unsigned long size)
 {
-	struct vm_struct **p, *tmp, *area;
-	struct page **pages;
-	void * addr;
-	unsigned int nr_pages, array_size, i;
+	struct vm_struct *area;
 
 	size = PAGE_ALIGN(size);
 	if (!size || size > MODULES_LEN)
 		return NULL;
-		
-	addr = (void *) MODULES_VADDR;
-	for (p = &modvmlist; (tmp = *p) != NULL; p = &tmp->next) {
-		if (size + (unsigned long) addr < (unsigned long) tmp->addr)
-			break;
-		addr = (void *) (tmp->size + (unsigned long) tmp->addr);
-	}
-	if ((unsigned long) addr + size >= MODULES_END)
-		return NULL;
-	
-	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
+
+	area = __get_vm_area(size, VM_ALLOC, MODULES_VADDR, MODULES_END);
 	if (!area)
 		return NULL;
-	area->size = size + PAGE_SIZE;
-	area->addr = addr;
-	area->next = *p;
-	area->pages = NULL;
-	area->nr_pages = 0;
-	area->phys_addr = 0;
-	*p = area;
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
-
-	for (i = 0; i < area->nr_pages; i++) {
-		area->pages[i] = alloc_page(GFP_KERNEL);
-		if (unlikely(!area->pages[i]))
-			goto fail;
-	}
-	
-	if (map_vm_area(area, PAGE_KERNEL, &pages)) {
-		unmap_vm_area(area);
-		goto fail;
-	}
-
-	return area->addr;
-
-fail:
-	if (area->pages) {
-		for (i = 0; i < area->nr_pages; i++) {
-			if (area->pages[i])
-				__free_page(area->pages[i]);
-		}
-		kfree(area->pages);
-	}
-	kfree(area);
 
-	return NULL;
+	return __vmalloc_area(area, GFP_KERNEL, PAGE_KERNEL);
 }
 
 void *module_alloc(unsigned long size)
@@ -141,9 +52,7 @@ void *module_alloc(unsigned long size)
 /* Free memory returned from module_core_alloc/module_init_alloc */
 void module_free(struct module *mod, void *module_region)
 {
-	write_lock(&vmlist_lock);
-	module_unmap(module_region);
-	write_unlock(&vmlist_lock);
+	vfree(module_region);
 	/* FIXME: If module_region == mod->init_region, trim exception
            table entries. */
 }
