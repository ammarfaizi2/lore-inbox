Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279943AbRKFSnK>; Tue, 6 Nov 2001 13:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279944AbRKFSm7>; Tue, 6 Nov 2001 13:42:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48909 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280015AbRKFSmp>; Tue, 6 Nov 2001 13:42:45 -0500
Date: Tue, 6 Nov 2001 15:23:29 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
In-Reply-To: <Pine.LNX.4.21.0111061217110.9867-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0111061519180.10244-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Marcelo Tosatti wrote:

> 
> > With the more aggressive max_mapped, the oom failure count could be
> > dropped to something smaller, as a false positive from shrink_caches
> > should be fairly rare. I don't think it needs to be tunable on memory
> > size, I just didn't even try any other values on my machines (I noticed
> > that the old values were too high once max_mapped was upped and the swap
> > cache reclaiming was re-done, but I didn't try if five seconds and ten
> > failures was any better than 10 seconds and five failures, for example)
> 
> Ok, I'll take a careful look at shrink_cache()/try_to_free_pages() path
> later and find out "saner" magic numbers for big/small memory workloads.

Ok, I found it. The problem is that swap_out() tries to scan the _whole_
address space looking for pte's to deactivate, and try_to_swap_out() does
not return a value indicating the lack of swap space, so at each
swap_out() call we simply loop around the whole VM when there is no swap
space available.

Here goes the tested fix.


--- linux.orig/mm/vmscan.c	Sun Nov  4 22:54:44 2001
+++ linux/mm/vmscan.c	Tue Nov  6 16:06:08 2001
@@ -36,7 +36,8 @@
 /*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
- * It returns zero if it couldn't do anything,
+ * It returns zero if it couldn't free the given pte or -1
+ * if there was no swap space left.
  *
  * rss may decrease because pages are shared, but this
  * doesn't count as having freed a page.
@@ -142,7 +143,7 @@
 	/* No swap space left */
 	set_pte(page_table, pte);
 	UnlockPage(page);
-	return 0;
+	return -1;
 }
 
 /* mm->page_table_lock is held. mmap_sem is not held */
@@ -170,7 +171,12 @@
 			struct page *page = pte_page(*pte);
 
 			if (VALID_PAGE(page) && !PageReserved(page)) {
-				count -= try_to_swap_out(mm, vma, address, pte, page, classzone);
+				int ret = try_to_swap_out(mm, vma, address, pte, page, classzone);
+				if (ret < 0)
+					return ret;
+
+				count -= ret;
+
 				if (!count) {
 					address += PAGE_SIZE;
 					break;
@@ -205,7 +211,11 @@
 		end = pgd_end;
 	
 	do {
-		count = swap_out_pmd(mm, vma, pmd, address, end, count, classzone);
+		int ret = swap_out_pmd(mm, vma, pmd, address, end, count, classzone);
+
+		if (ret < 0)
+			return ret;
+		count = ret;
 		if (!count)
 			break;
 		address = (address + PMD_SIZE) & PMD_MASK;
@@ -230,7 +240,10 @@
 	if (address >= end)
 		BUG();
 	do {
-		count = swap_out_pgd(mm, vma, pgdir, address, end, count, classzone);
+		int ret = swap_out_pgd(mm, vma, pgdir, address, end, count, classzone);
+		if (ret < 0)
+			return ret;
+		count = ret;
 		if (!count)
 			break;
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
@@ -287,7 +300,7 @@
 static int FASTCALL(swap_out(unsigned int priority, unsigned int gfp_mask, zone_t * classzone));
 static int swap_out(unsigned int priority, unsigned int gfp_mask, zone_t * classzone)
 {
-	int counter, nr_pages = SWAP_CLUSTER_MAX;
+	int counter, nr_pages = SWAP_CLUSTER_MAX, ret;
 	struct mm_struct *mm;
 
 	counter = mmlist_nr;
@@ -311,9 +324,15 @@
 		atomic_inc(&mm->mm_users);
 		spin_unlock(&mmlist_lock);
 
-		nr_pages = swap_out_mm(mm, nr_pages, &counter, classzone);
+		ret = swap_out_mm(mm, nr_pages, &counter, classzone);
 
 		mmput(mm);
+
+		/* No more swap space ? */
+		if (ret < 0)
+			return nr_pages;
+
+		nr_pages = ret;
 
 		if (!nr_pages)
 			return 1;

