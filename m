Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269823AbRHJA6X>; Thu, 9 Aug 2001 20:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269126AbRHJA6N>; Thu, 9 Aug 2001 20:58:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21775 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269823AbRHJA6D>;
	Thu, 9 Aug 2001 20:58:03 -0400
Date: Thu, 9 Aug 2001 21:57:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [autoPATCH] 2.4.7-swapfree
Message-ID: <Pine.LNX.4.33L.0108092156100.17803-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch frees up swap space on swapin when
the swap area gets full.

This increases effective VM area from max(ram, swap)
all the way to memory = ram + swap.

Please apply for the next pre-kernel,

Rik('s fictional cronjob)
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

--- linux-2.4.7-ac7/mm/memory.c.orig	Mon Aug  6 12:23:33 2001
+++ linux-2.4.7-ac7/mm/memory.c	Tue Aug  7 14:20:11 2001
@@ -1147,6 +1147,20 @@
 	swap_free(entry);
 	if (write_access && exclusive_swap_page(page))
 		pte = pte_mkwrite(pte_mkdirty(pte));
+
+	/*
+	 * If swap space is getting low and we were the last user
+	 * of this piece of swap space, we free this space so
+	 * somebody else can be swapped out.
+	 *
+	 * We are protected against try_to_swap_out() because the
+	 * page is locked and against do_fork() because we have
+	 * read_lock(&mm->mmap_sem).
+	 */
+	if (vm_swap_full() && exclusive_swap_page(page)) {
+		delete_from_swap_cache_nolock(page);
+		pte = pte_mkwrite(pte_mkdirty(pte));
+	}
 	UnlockPage(page);

 	flush_page_to_ram(page);
--- linux-2.4.7-ac7/mm/swapfile.c.orig	Mon Aug  6 12:23:33 2001
+++ linux-2.4.7-ac7/mm/swapfile.c	Tue Aug  7 11:55:18 2001
@@ -19,11 +19,34 @@

 spinlock_t swaplock = SPIN_LOCK_UNLOCKED;
 unsigned int nr_swapfiles;
+int total_swap_pages;

 struct swap_list_t swap_list = {-1, -1};

 struct swap_info_struct swap_info[MAX_SWAPFILES];

+/*
+ * When swap space gets filled up, we will set this flag.
+ * This will make do_swap_page(), in the page fault path,
+ * free swap entries on swapin so we'll reclaim swap space
+ * in order to be able to swap something out.
+ *
+ * At the moment we start reclaiming when swap usage goes
+ * over 80% of swap space and we continue reclaiming until
+ * the amount of occupied swap drops to less than 75%.
+ * XXX: these are random numbers, fixme.
+ */
+#define SWAP_FULL_PCT 80
+int vm_swap_full (void) {
+	int full = 0;
+	int swap_used = total_swap_pages - nr_swap_pages;
+
+	if (swap_used * 100 > total_swap_pages * SWAP_FULL_PCT)
+		full = 1;
+
+	return full;
+}
+
 #define SWAPFILE_CLUSTER 256

 static inline int scan_swap_map(struct swap_info_struct *si, unsigned short count)
@@ -469,6 +492,7 @@
 		swap_list.next = swap_list.head;
 	}
 	nr_swap_pages -= p->pages;
+	total_swap_pages -= p->pages;
 	swap_list_unlock();
 	p->flags = SWP_USED;
 	err = try_to_unuse(type);
@@ -484,6 +508,7 @@
 		else
 			swap_info[prev].next = p - swap_info;
 		nr_swap_pages += p->pages;
+		total_swap_pages += p->pages;
 		swap_list_unlock();
 		p->flags = SWP_WRITEOK;
 		goto out_dput;
@@ -771,6 +796,7 @@
 	p->pages = nr_good_pages;
 	swap_list_lock();
 	nr_swap_pages += nr_good_pages;
+	total_swap_pages += nr_good_pages;
 	printk(KERN_INFO "Adding Swap: %dk swap-space (priority %d)\n",
 	       nr_good_pages<<(PAGE_SHIFT-10), p->prio);

--- linux-2.4.7-ac7/include/linux/swap.h.orig	Mon Aug  6 12:33:35 2001
+++ linux-2.4.7-ac7/include/linux/swap.h	Mon Aug  6 20:08:44 2001
@@ -158,6 +158,7 @@
 extern void free_page_and_swap_cache(struct page *page);

 /* linux/mm/swapfile.c */
+extern int vm_swap_full(void);
 extern unsigned int nr_swapfiles;
 extern struct swap_info_struct swap_info[];
 extern int is_swap_partition(kdev_t);

