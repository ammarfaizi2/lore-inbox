Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156377AbPLGP3i>; Tue, 7 Dec 1999 10:29:38 -0500
Received: by vger.rutgers.edu id <S156296AbPLGPZZ>; Tue, 7 Dec 1999 10:25:25 -0500
Received: from [63.211.176.148] ([63.211.176.148]:2426 "EHLO mail.mclinux.com") by vger.rutgers.edu with ESMTP id <S156424AbPLGPYo>; Tue, 7 Dec 1999 10:24:44 -0500
Message-ID: <384D26E6.6E21C624@missioncriticallinux.com>
Date: Tue, 07 Dec 1999 10:25:26 -0500
From: Larry Woodman <woodman@missioncriticallinux.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.rutgers.edu
Subject: 2.3.29 patch for releasing swap cache pages on exit and fixing race in  do_swap_page.Larry 
Content-Type: multipart/mixed; boundary="------------7B6A78D3F6E5DBAE40757136"
Sender: owner-linux-kernel@vger.rutgers.edu

This is a multi-part message in MIME format.
--------------7B6A78D3F6E5DBAE40757136
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

We have run into two problems in 2.3 related to the swap cache: 1.) When
a process
exits, some of its private pages can remain in the swap cache and tie up
swap space
unless shrink_mmap runs.  2.) What looks like a race  between
do_swap_page
and shrink_mmap.

Here is my attempt at a patch that fixes both problems.

Larry Woodman
http://www/missioncriticallinux.com

--------------7B6A78D3F6E5DBAE40757136
Content-Type: text/plain; charset=us-ascii;
 name="patch-2.3.29.race"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.3.29.race"

--- mm/memory.c.sav	Tue Dec  7 10:04:33 1999
+++ mm/memory.c	Tue Dec  7 10:06:14 1999
@@ -1004,12 +1004,15 @@
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	set_bit(PG_swap_entry, &page->flags);
+	lock_page(page);
 	if (write_access && !is_page_shared(page)) {
-		delete_from_swap_cache(page);
+		delete_from_swap_cache_nolock(page);
+		UnlockPage(page);
 		page = replace_with_highmem(page);
 		pte = mk_pte(page, vma->vm_page_prot);
 		pte = pte_mkwrite(pte_mkdirty(pte));
-	}
+	} else
+		UnlockPage(page);
 	set_pte(page_table, pte);
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
--- mm/swap_state.c.sav	Wed Dec  1 18:20:23 1999
+++ mm/swap_state.c	Tue Dec  7 10:07:17 1999
@@ -171,7 +171,7 @@
 	unlock_kernel();
 }
 
-static void delete_from_swap_cache_nolock(struct page *page)
+void delete_from_swap_cache_nolock(struct page *page)
 {
 	if (block_flushpage(NULL, page, 0))
 		lru_cache_del(page);
--- include/linux/swap.h.sav	Wed Dec  1 12:28:42 1999
+++ include/linux/swap.h	Tue Dec  7 10:01:16 1999
@@ -147,8 +147,9 @@
 	if (PageReserved(page))
 		return 1;
 	count = page_count(page);
-	if (PageSwapCache(page))
-		count += swap_count(page) - 2;
+	if (PageSwapCache(page)) 
+		/* page_count is 3 if shrink_mmap didnt free buffer yet */
+		count += swap_count(page) - 2 - !!page->buffers;
 	return  count > 1;
 }
 

--------------7B6A78D3F6E5DBAE40757136--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
