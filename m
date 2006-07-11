Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWGKTiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWGKTiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWGKTiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:38:10 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:20392 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1751210AbWGKTiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:38:09 -0400
Message-ID: <44B3FDE4.4040209@web.de>
Date: Tue, 11 Jul 2006 21:37:08 +0200
From: Jan Kiszka <jan.kiszka@web.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix oom roll-back of __vmalloc_area_node
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__vunmap must not rely on area->nr_pages when picking the
release methode for area->pages. It may be too small when
__vmalloc_area_node failed early due to lacking memory.
Instead, use a flag in vmstruct to differentiate.

Applies against 2.6.18-rc1, but sighted, developed, and
tested on a 2.6.16 kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>

---
 include/linux/vmalloc.h |    1 +
 mm/vmalloc.c            |    7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/vmalloc.h
===================================================================
--- linux-2.6.orig/include/linux/vmalloc.h
+++ linux-2.6/include/linux/vmalloc.h
@@ -11,6 +11,7 @@ struct vm_area_struct;
 #define VM_ALLOC	0x00000002	/* vmalloc() */
 #define VM_MAP		0x00000004	/* vmap()ed pages */
 #define VM_USERMAP	0x00000008	/* suitable for remap_vmalloc_range */
+#define VM_VPAGES	0x00000010	/* buffer for pages was vmalloc'ed */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -340,7 +340,7 @@ void __vunmap(void *addr, int deallocate
 			__free_page(area->pages[i]);
 		}
 
-		if (area->nr_pages > PAGE_SIZE/sizeof(struct page *))
+		if (area->flags & VM_VPAGES)
 			vfree(area->pages);
 		else
 			kfree(area->pages);
@@ -427,9 +427,10 @@ void *__vmalloc_area_node(struct vm_stru
 
 	area->nr_pages = nr_pages;
 	/* Please note that the recursion is strictly bounded. */
-	if (array_size > PAGE_SIZE)
+	if (array_size > PAGE_SIZE) {
 		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
-	else
+		area->flags |= VM_VPAGES;
+	} else
 		pages = kmalloc_node(array_size, (gfp_mask & ~__GFP_HIGHMEM), node);
 	area->pages = pages;
 	if (!area->pages) {


