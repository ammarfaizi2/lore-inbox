Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRDOBMl>; Sat, 14 Apr 2001 21:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRDOBMb>; Sat, 14 Apr 2001 21:12:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45330 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132562AbRDOBMO>; Sat, 14 Apr 2001 21:12:14 -0400
Date: Sat, 14 Apr 2001 20:31:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Christoph Rohland <cr@sap.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [NEED TESTERS] remove swapin_readahead Re: shmem_getpage_locked()
 / swapin_readahead() race in 2.4.4-pre3
In-Reply-To: <Pine.LNX.4.33.0104141625200.9455-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104142007320.1866-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Apr 2001, Rik van Riel wrote:

> On Sat, 14 Apr 2001, Marcelo Tosatti wrote:
> 
> > There is a nasty race between shmem_getpage_locked() and
> > swapin_readahead() with the new shmem code (introduced in
> > 2.4.3-ac3 and merged in the main tree in 2.4.4-pre3):
> 
> > I don't see any clean fix for this one.
> > Suggestions ?
> 
> As we discussed with Alan on irc, we could remove the (physical)
> swapin_readahead() and get 2.4 stable. Once 2.4 is stable we
> could (if needed) introduce a virtual address based readahead
> strategy for swap-backed things ... most of that code has been
> ready for months thanks to Ben LaHaise.
> 
> A virtual-address based readahead not only makes much more sense
> from a performance POV, it also cleanly gets the ugly locking
> issues out of the way.

Test (multiple shm-stress) runs fine without swapin_readahead(), as
expected.

I tried "make -j32" test (128M RAM, 4 CPU's) and got 4m17 without
readahead against 3m40 with readahead, on average. Need real swap
intensive workloads to "really" know of how much it hurts, though.

People with swap intensive workloads: please test this and report results. 

Stephen/Linus? 


Patch against 2.4.4-pre3.


diff -Nur linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Sat Apr 14 21:31:38 2001
+++ linux/include/linux/mm.h	Sat Apr 14 21:30:44 2001
@@ -425,7 +425,6 @@
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
-extern void swapin_readahead(swp_entry_t);
 
 /* mmap.c */
 extern void lock_vma_mappings(struct vm_area_struct *);
diff -Nur linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Sat Apr 14 21:31:38 2001
+++ linux/include/linux/swap.h	Sat Apr 14 21:30:28 2001
@@ -145,7 +145,6 @@
 					struct inode **);
 extern int swap_duplicate(swp_entry_t);
 extern int swap_count(struct page *);
-extern int valid_swaphandles(swp_entry_t, unsigned long *);
 #define get_swap_page() __get_swap_page(1)
 extern void __swap_free(swp_entry_t, unsigned short);
 #define swap_free(entry) __swap_free((entry), 1)
diff -Nur linux.orig/mm/memory.c linux/mm/memory.c
--- linux.orig/mm/memory.c	Sat Apr 14 21:31:38 2001
+++ linux/mm/memory.c	Sat Apr 14 21:28:34 2001
@@ -1012,42 +1012,6 @@
 	return;
 }
 
-
-
-/* 
- * Primitive swap readahead code. We simply read an aligned block of
- * (1 << page_cluster) entries in the swap area. This method is chosen
- * because it doesn't cost us any seek time.  We also make sure to queue
- * the 'original' request together with the readahead ones...  
- */
-void swapin_readahead(swp_entry_t entry)
-{
-	int i, num;
-	struct page *new_page;
-	unsigned long offset;
-
-	/*
-	 * Get the number of handles we should do readahead io to. Also,
-	 * grab temporary references on them, releasing them as io completes.
-	 */
-	num = valid_swaphandles(entry, &offset);
-	for (i = 0; i < num; offset++, i++) {
-		/* Don't block on I/O for read-ahead */
-		if (atomic_read(&nr_async_pages) >= pager_daemon.swap_cluster
-				* (1 << page_cluster)) {
-			while (i++ < num)
-				swap_free(SWP_ENTRY(SWP_TYPE(entry), offset++));
-			break;
-		}
-		/* Ok, do the async read-ahead now */
-		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset), 0);
-		if (new_page != NULL)
-			page_cache_release(new_page);
-		swap_free(SWP_ENTRY(SWP_TYPE(entry), offset));
-	}
-	return;
-}
-
 /*
  * We hold the mm semaphore and the page_table_lock on entry and exit.
  */
@@ -1062,7 +1026,6 @@
 	page = lookup_swap_cache(entry);
 	if (!page) {
 		lock_kernel();
-		swapin_readahead(entry);
 		page = read_swap_cache(entry);
 		unlock_kernel();
 		if (!page) {
diff -Nur linux.orig/mm/shmem.c linux/mm/shmem.c
--- linux.orig/mm/shmem.c	Sat Apr 14 21:31:38 2001
+++ linux/mm/shmem.c	Sat Apr 14 21:28:44 2001
@@ -328,7 +328,6 @@
 		if (!page) {
 			spin_unlock (&info->lock);
 			lock_kernel();
-			swapin_readahead(*entry);
 			page = read_swap_cache(*entry);
 			unlock_kernel();
 			if (!page) 
diff -Nur linux.orig/mm/swapfile.c linux/mm/swapfile.c
--- linux.orig/mm/swapfile.c	Thu Mar 22 14:22:15 2001
+++ linux/mm/swapfile.c	Sat Apr 14 21:30:04 2001
@@ -955,34 +955,3 @@
 	}
 	return;
 }
-
-/*
- * Kernel_lock protects against swap device deletion. Grab an extra
- * reference on the swaphandle so that it dos not become unused.
- */
-int valid_swaphandles(swp_entry_t entry, unsigned long *offset)
-{
-	int ret = 0, i = 1 << page_cluster;
-	unsigned long toff;
-	struct swap_info_struct *swapdev = SWP_TYPE(entry) + swap_info;
-
-	*offset = SWP_OFFSET(entry);
-	toff = *offset = (*offset >> page_cluster) << page_cluster;
-
-	swap_device_lock(swapdev);
-	do {
-		/* Don't read-ahead past the end of the swap area */
-		if (toff >= swapdev->max)
-			break;
-		/* Don't read in bad or busy pages */
-		if (!swapdev->swap_map[toff])
-			break;
-		if (swapdev->swap_map[toff] == SWAP_MAP_BAD)
-			break;
-		swapdev->swap_map[toff]++;
-		toff++;
-		ret++;
-	} while (--i);
-	swap_device_unlock(swapdev);
-	return ret;
-}

