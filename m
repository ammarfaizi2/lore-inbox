Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUDFNpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUDFNoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:44:39 -0400
Received: from ns.suse.de ([195.135.220.2]:30881 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263828AbUDFNkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:40:52 -0400
Date: Tue, 6 Apr 2004 15:39:00 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 8/ Add policy support to anonymous
 memory
Message-Id: <20040406153900.3b74586a.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change to core VM to use alloc_page_vma() instead of alloc_page().

Change the swap readahead to follow the policy of the VMA.


diff -u linux-2.6.5-numa/include/linux/swap.h-o linux-2.6.5-numa/include/linux/swap.h
--- linux-2.6.5-numa/include/linux/swap.h-o	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.5-numa/include/linux/swap.h	2004-04-06 13:36:12.000000000 +0200
@@ -152,7 +152,7 @@
 extern void out_of_memory(void);
 
 /* linux/mm/memory.c */
-extern void swapin_readahead(swp_entry_t);
+extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
 
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
@@ -216,7 +216,8 @@
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
 extern struct page * lookup_swap_cache(swp_entry_t);
-extern struct page * read_swap_cache_async(swp_entry_t);
+extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma, 
+					   unsigned long addr);
 
 /* linux/mm/swapfile.c */
 extern int total_swap_pages;
@@ -257,7 +258,7 @@
 #define free_swap_and_cache(swp)		/*NOTHING*/
 #define swap_duplicate(swp)			/*NOTHING*/
 #define swap_free(swp)				/*NOTHING*/
-#define read_swap_cache_async(swp)		NULL
+#define read_swap_cache_async(swp,vma,addr)	NULL
 #define lookup_swap_cache(swp)			NULL
 #define valid_swaphandles(swp, off)		0
 #define can_share_swap_page(p)			0
diff -u linux-2.6.5-numa/mm/memory.c-o linux-2.6.5-numa/mm/memory.c
--- linux-2.6.5-numa/mm/memory.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/mm/memory.c	2004-04-06 13:36:12.000000000 +0200
@@ -1056,7 +1056,7 @@
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain)
 		goto no_pte_chain;
-	new_page = alloc_page(GFP_HIGHUSER);
+	new_page = alloc_page_vma(GFP_HIGHUSER,vma,address);
 	if (!new_page)
 		goto no_new_page;
 	copy_cow_page(old_page,new_page,address);
@@ -1210,9 +1210,17 @@
  * (1 << page_cluster) entries in the swap area. This method is chosen
  * because it doesn't cost us any seek time.  We also make sure to queue
  * the 'original' request together with the readahead ones...  
+ * 
+ * This has been extended to use the NUMA policies from the mm triggering
+ * the readahead.
+ * 
+ * Caller must hold down_read on the vma->vm_mm if vma is not NULL.
  */
-void swapin_readahead(swp_entry_t entry)
+void swapin_readahead(swp_entry_t entry, unsigned long addr,struct vm_area_struct *vma) 
 {
+#ifdef CONFIG_NUMA
+	struct vm_area_struct *next_vma = vma ? vma->vm_next : NULL;
+#endif
 	int i, num;
 	struct page *new_page;
 	unsigned long offset;
@@ -1224,10 +1232,31 @@
 	for (i = 0; i < num; offset++, i++) {
 		/* Ok, do the async read-ahead now */
 		new_page = read_swap_cache_async(swp_entry(swp_type(entry),
-						offset));
+							   offset), vma, addr); 
 		if (!new_page)
 			break;
 		page_cache_release(new_page);
+#ifdef CONFIG_NUMA
+		/* 
+		 * Find the next applicable VMA for the NUMA policy.
+		 */
+		addr += PAGE_SIZE;
+		if (addr == 0) 
+			vma = NULL;
+		if (vma) { 
+			if (addr >= vma->vm_end) { 
+				vma = next_vma;
+				next_vma = vma ? vma->vm_next : NULL;
+			}
+			if (vma && addr < vma->vm_start) 
+				vma = NULL; 
+		} else { 
+			if (next_vma && addr >= next_vma->vm_start) { 
+				vma = next_vma;
+				next_vma = vma->vm_next;
+			}
+		} 
+#endif
 	}
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 }
@@ -1250,8 +1279,8 @@
 	spin_unlock(&mm->page_table_lock);
 	page = lookup_swap_cache(entry);
 	if (!page) {
-		swapin_readahead(entry);
-		page = read_swap_cache_async(entry);
+ 		swapin_readahead(entry, address, vma);
+ 		page = read_swap_cache_async(entry, vma, address);
 		if (!page) {
 			/*
 			 * Back out if somebody else faulted in this pte while
@@ -1356,7 +1385,7 @@
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
 
-		page = alloc_page(GFP_HIGHUSER);
+		page = alloc_page_vma(GFP_HIGHUSER,vma,addr);
 		if (!page)
 			goto no_mem;
 		clear_user_highpage(page, addr);
@@ -1448,7 +1477,7 @@
 	 * Should we do an early C-O-W break?
 	 */
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
-		struct page * page = alloc_page(GFP_HIGHUSER);
+		struct page * page = alloc_page_vma(GFP_HIGHUSER,vma,address);
 		if (!page)
 			goto oom;
 		copy_user_highpage(page, new_page, address);
diff -u linux-2.6.5-numa/mm/swap_state.c-o linux-2.6.5-numa/mm/swap_state.c
--- linux-2.6.5-numa/mm/swap_state.c-o	2004-03-21 21:12:13.000000000 +0100
+++ linux-2.6.5-numa/mm/swap_state.c	2004-04-06 13:36:13.000000000 +0200
@@ -331,7 +331,8 @@
  * A failure return means that either the page allocation failed or that
  * the swap entry is no longer in use.
  */
-struct page * read_swap_cache_async(swp_entry_t entry)
+struct page * 
+read_swap_cache_async(swp_entry_t entry, struct vm_area_struct *vma, unsigned long addr)
 {
 	struct page *found_page, *new_page = NULL;
 	int err;
@@ -351,7 +352,7 @@
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page(GFP_HIGHUSER);
+			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
diff -u linux-2.6.5-numa/mm/swapfile.c-o linux-2.6.5-numa/mm/swapfile.c
--- linux-2.6.5-numa/mm/swapfile.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/mm/swapfile.c	2004-04-06 13:36:13.000000000 +0200
@@ -607,7 +607,7 @@
 		 */
 		swap_map = &si->swap_map[i];
 		entry = swp_entry(type, i);
-		page = read_swap_cache_async(entry);
+		page = read_swap_cache_async(entry, NULL, 0);
 		if (!page) {
 			/*
 			 * Either swap_duplicate() failed because entry
