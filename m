Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129123AbQKFPxo>; Mon, 6 Nov 2000 10:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQKFPxe>; Mon, 6 Nov 2000 10:53:34 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:53172 "EHLO
	mailgate1.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S129123AbQKFPxX>; Mon, 6 Nov 2000 10:53:23 -0500
Message-ID: <3A06D464.51AC88AB@us.ibm.com>
Date: Mon, 06 Nov 2000 09:55:16 -0600
From: Steven Pratt <slpratt@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] 2.4.0-test10 zap_page_range
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in April there was some discussion about the race condition where a
call to zap_page_range followed by a call to flush_tlb_range allows for
a page which has been freed to be re-allocated on a different cpu and
referenced via a tlb on a third cpu before the tlb is actually flushed.

Below is a patch which removes the race condition by moving the call to
flush_tlb_range inside of zap_page_range (actually inside of
zap_pte_range).  For performance reasons the single loop which removed
the entry from the pte then freed the page was changed to 2 loops so
that we don't have to flush the tlb on every page.

Comments welcome.


--- linux/mm/memory.c	Mon Oct 30 16:32:57 2000
+++ linux-2.4.0-test10patch/mm/memory.c	Fri Nov  3 10:48:40 2000
@@ -53,6 +53,8 @@
 void * high_memory;
 struct page *highmem_start_page;
 
+static pte_t page_to_free[256];
+
 /*
  * We special-case the C-O-W ZERO_PAGE, because it's such
  * a common occurrence (no need to read the page to know
@@ -288,6 +290,8 @@
 {
 	pte_t * pte;
 	int freed;
+    unsigned long start = address;
+    int i;
 
 	if (pmd_none(*pmd))
 		return 0;
@@ -302,17 +306,20 @@
 		size = PMD_SIZE - address;
 	size >>= PAGE_SHIFT;
 	freed = 0;
-	for (;;) {
-		pte_t page;
-		if (!size)
-			break;
-		page = ptep_get_and_clear(pte);
-		pte++;
-		size--;
-		if (pte_none(page))
-			continue;
-		freed += free_pte(page);
-	}
+    while (size > 0) {
+    	for (i = 0;i < 256 && size > 0; i++, pte++, size--) {
+    		page_to_free[i] = ptep_get_and_clear(pte);
+        }
+
+		flush_tlb_range(mm, start, start + (i<<PAGE_SHIFT) );
+        start += i<<PAGE_SHIFT; 
+
+        for (i--; i>=0; i--) {
+    		if (pte_none(page_to_free[i]))
+    			continue;
+    		freed += free_pte(page_to_free[i]);
+    	}
+    }
 	return freed;
 }
 
@@ -938,7 +945,6 @@
 		if (mpnt->vm_pgoff >= pgoff) {
 			flush_cache_range(mm, start, end);
 			zap_page_range(mm, start, len);
-			flush_tlb_range(mm, start, end);
 			continue;
 		}
 
@@ -957,7 +963,6 @@
 		}
 		flush_cache_range(mm, start, end);
 		zap_page_range(mm, start, len);
-		flush_tlb_range(mm, start, end);
 	} while ((mpnt = mpnt->vm_next_share) != NULL);
 }
 			      
--- linux/mm/mmap.c	Fri Oct 13 14:10:30 2000
+++ linux-2.4.0-test10patch/mm/mmap.c	Fri Nov  3 10:49:20 2000
@@ -339,7 +339,6 @@
 	/* Undo any partial mapping done by a device driver. */
 	flush_cache_range(mm, vma->vm_start, vma->vm_end);
 	zap_page_range(mm, vma->vm_start, vma->vm_end - vma->vm_start);
-	flush_tlb_range(mm, vma->vm_start, vma->vm_end);
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 	return error;
@@ -711,7 +710,6 @@
 
 		flush_cache_range(mm, st, end);
 		zap_page_range(mm, st, size);
-		flush_tlb_range(mm, st, end);
 
 		/*
 		 * Fix the mapping, and free the old area if it wasn't reused.
--- linux/mm/mremap.c	Wed Oct 18 16:25:46 2000
+++ linux-2.4.0-test10patch/mm/mremap.c	Fri Nov  3 10:49:43 2000
@@ -119,7 +119,6 @@
 	while ((offset += PAGE_SIZE) < len)
 		move_one_page(mm, new_addr + offset, old_addr + offset);
 	zap_page_range(mm, new_addr, len);
-	flush_tlb_range(mm, new_addr, new_addr + len);
 	return -1;
 }
 
--- linux/mm/filemap.c	Mon Oct 30 17:27:16 2000
+++ linux-2.4.0-test10patch/mm/filemap.c	Fri Nov  3 14:21:20 2000
@@ -1995,7 +1995,6 @@
 
 	flush_cache_range(vma->vm_mm, start, end);
 	zap_page_range(vma->vm_mm, start, end - start);
-	flush_tlb_range(vma->vm_mm, start, end);
 	return 0;
 }
 
--- linux/drivers/char/mem.c	Tue Oct 10 12:33:51 2000
+++ linux-2.4.0-test10patch/drivers/char/mem.c	Fri Nov  3 10:49:47 2000
@@ -366,7 +366,6 @@
 		flush_cache_range(mm, addr, addr + count);
 		zap_page_range(mm, addr, count);
         	zeromap_page_range(addr, count, PAGE_COPY);
-        	flush_tlb_range(mm, addr, addr + count);
 
 		size -= count;
 		buf += count;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
