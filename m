Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSHTRjH>; Tue, 20 Aug 2002 13:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319211AbSHTRjG>; Tue, 20 Aug 2002 13:39:06 -0400
Received: from ra.abo.fi ([130.232.213.1]:4532 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S317253AbSHTRjF>;
	Tue, 20 Aug 2002 13:39:05 -0400
Date: Tue, 20 Aug 2002 20:43:09 +0300 (EEST)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.5] vmalloc.c error path fixes
Message-ID: <Pine.LNX.4.44.0208202022100.16857-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there are some problems in vmalloc.c.  The two first parts 
of the diff fix a spinlock being held if an error occurs in 
map_vm_area, and the last part fixes the error path of __vmalloc.

Perhaps somebody who knows more of the mm could verify this.

Marcus

===== mm/vmalloc.c 1.18 vs edited =====
--- 1.18/mm/vmalloc.c	Mon Aug  5 22:05:22 2002
+++ edited/mm/vmalloc.c	Mon Aug 19 00:37:40 2002
@@ -153,15 +153,20 @@
 	unsigned long address = VMALLOC_VMADDR(area->addr);
 	unsigned long end = address + (area->size-PAGE_SIZE);
 	pgd_t *dir;
+	int err = 0;
 
 	dir = pgd_offset_k(address);
 	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
-		if (!pmd)
-			return -ENOMEM;
-		if (map_area_pmd(pmd, address, end - address, prot, pages))
-			return -ENOMEM;
+		if (!pmd) {
+			err = -ENOMEM;
+			break;
+		}
+		if (map_area_pmd(pmd, address, end - address, prot, pages)) {
+			err = -ENOMEM;
+			break;
+		}
 
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
@@ -169,7 +174,7 @@
 
 	spin_unlock(&init_mm.page_table_lock);
 	flush_cache_all();
-	return 0;
+	return err;
 }
 
 
@@ -379,14 +384,20 @@
 
 	area->nr_pages = nr_pages;
 	area->pages = pages = kmalloc(array_size, (gfp_mask & ~__GFP_HIGHMEM));
-	if (!area->pages)
+	if (!area->pages) {
+		remove_vm_area(area->addr);
+		kfree(area);
 		return NULL;
+	}
 	memset(area->pages, 0, array_size);
 
 	for (i = 0; i < area->nr_pages; i++) {
 		area->pages[i] = alloc_page(gfp_mask);
-		if (unlikely(!area->pages[i]))
+		if (unlikely(!area->pages[i])) {
+			/* Successfully allocated i pages, free them in __vunmap() */
+			area->nr_pages = i;
 			goto fail;
+		}
 	}
 	
 	if (map_vm_area(area, prot, &pages))

-- 
Marcus Alanen * Embedded Systems Laboratory * http://www.eslab.cs.abo.fi/
marcus.alanen@abo.fi


