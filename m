Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVALTAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVALTAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVALS7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:59:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:57789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261265AbVALSzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:55:02 -0500
Date: Wed, 12 Jan 2005 10:53:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: holt@sgi.com, raybry@sgi.com, stevel@mvista.com, ak@muc.de,
       taka@valinux.co.jp, haveblue@us.ibm.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: page migration patchset
Message-Id: <20050112105315.2ac21173.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain>
References: <20050112123524.GA12843@lnx-holt.americas.sgi.com>
	<Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> The simplest solution, which most appeals to me, is to delete
>  swapin_readahead altogether - it's based on the principle "well,
>  if I'm going to read something from the disk, I might as well read
>  adjacent pages in one go, there's a ghost of a chance that some of
>  the others might be useful soon too, and if we're lucky, pushing
>  other pages out of cache to make way for these might pay off".
> 
>  Which probably is a win in some workloads, but I wonder how often.

Our current way of allocating swap can cause us to end up with little
correlation between adjacent pages on-disk.  But this can be improved.  THe
old swapspace-layout-improvements patch was designed to fix that up, but
needs more testing and tuning.

It clusters pages on-disk via their virtual address.

diff -puN mm/vmscan.c~swapspace-layout-improvements mm/vmscan.c
--- 25/mm/vmscan.c~swapspace-layout-improvements	2004-06-03 21:32:51.087602712 -0700
+++ 25-akpm/mm/vmscan.c	2004-06-03 21:32:51.102600432 -0700
@@ -381,8 +381,11 @@ static int shrink_list(struct list_head 
 		 * XXX: implement swap clustering ?
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
+			void *cookie = page->mapping;
+			pgoff_t index = page->index;
+
 			page_map_unlock(page);
-			if (!add_to_swap(page))
+			if (!add_to_swap(page, cookie, index))
 				goto activate_locked;
 			page_map_lock(page);
 		}
diff -puN mm/swap_state.c~swapspace-layout-improvements mm/swap_state.c
--- 25/mm/swap_state.c~swapspace-layout-improvements	2004-06-03 21:32:51.089602408 -0700
+++ 25-akpm/mm/swap_state.c	2004-06-03 21:32:51.103600280 -0700
@@ -137,8 +137,12 @@ void __delete_from_swap_cache(struct pag
  *
  * Allocate swap space for the page and add the page to the
  * swap cache.  Caller needs to hold the page lock. 
+ *
+ * We attempt to lay pages out on swap to that virtually-contiguous pages are
+ * contiguous on-disk.  To do this we utilise page->index (offset into vma) and
+ * page->mapping (the anon_vma's address).
  */
-int add_to_swap(struct page * page)
+int add_to_swap(struct page *page, void *cookie, pgoff_t index)
 {
 	swp_entry_t entry;
 	int pf_flags;
@@ -148,7 +152,7 @@ int add_to_swap(struct page * page)
 		BUG();
 
 	for (;;) {
-		entry = get_swap_page();
+		entry = get_swap_page(cookie, index);
 		if (!entry.val)
 			return 0;
 
diff -puN include/linux/swap.h~swapspace-layout-improvements include/linux/swap.h
--- 25/include/linux/swap.h~swapspace-layout-improvements	2004-06-03 21:32:51.090602256 -0700
+++ 25-akpm/include/linux/swap.h	2004-06-03 21:32:51.104600128 -0700
@@ -193,7 +193,7 @@ extern int rw_swap_page_sync(int, swp_en
 extern struct address_space swapper_space;
 #define total_swapcache_pages  swapper_space.nrpages
 extern void show_swap_cache_info(void);
-extern int add_to_swap(struct page *);
+extern int add_to_swap(struct page *page, void *cookie, pgoff_t index);
 extern void __delete_from_swap_cache(struct page *);
 extern void delete_from_swap_cache(struct page *);
 extern int move_to_swap_cache(struct page *, swp_entry_t);
@@ -210,7 +210,7 @@ extern int total_swap_pages;
 extern unsigned int nr_swapfiles;
 extern struct swap_info_struct swap_info[];
 extern void si_swapinfo(struct sysinfo *);
-extern swp_entry_t get_swap_page(void);
+extern swp_entry_t get_swap_page(void *cookie, pgoff_t index);
 extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
@@ -259,7 +259,7 @@ static inline int remove_exclusive_swap_
 	return 0;
 }
 
-static inline swp_entry_t get_swap_page(void)
+static inline swp_entry_t get_swap_page(void *cookie, pgoff_t index)
 {
 	swp_entry_t entry;
 	entry.val = 0;
diff -puN mm/shmem.c~swapspace-layout-improvements mm/shmem.c
--- 25/mm/shmem.c~swapspace-layout-improvements	2004-06-03 21:32:51.092601952 -0700
+++ 25-akpm/mm/shmem.c	2004-06-03 21:32:51.108599520 -0700
@@ -744,7 +744,7 @@ static int shmem_writepage(struct page *
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
 	struct address_space *mapping;
-	unsigned long index;
+	pgoff_t index;
 	struct inode *inode;
 
 	BUG_ON(!PageLocked(page));
@@ -756,7 +756,7 @@ static int shmem_writepage(struct page *
 	info = SHMEM_I(inode);
 	if (info->flags & VM_LOCKED)
 		goto redirty;
-	swap = get_swap_page();
+	swap = get_swap_page(mapping, index);
 	if (!swap.val)
 		goto redirty;
 
diff -puN mm/swapfile.c~swapspace-layout-improvements mm/swapfile.c
--- 25/mm/swapfile.c~swapspace-layout-improvements	2004-06-03 21:32:51.094601648 -0700
+++ 25-akpm/mm/swapfile.c	2004-06-03 23:40:44.396082512 -0700
@@ -25,6 +25,7 @@
 #include <linux/rmap.h>
 #include <linux/security.h>
 #include <linux/backing-dev.h>
+#include <linux/hash.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -83,71 +84,51 @@ void swap_unplug_io_fn(struct backing_de
 	up_read(&swap_unplug_sem);
 }
 
-static inline int scan_swap_map(struct swap_info_struct *si)
-{
-	unsigned long offset;
-	/* 
-	 * We try to cluster swap pages by allocating them
-	 * sequentially in swap.  Once we've allocated
-	 * SWAPFILE_CLUSTER pages this way, however, we resort to
-	 * first-free allocation, starting a new cluster.  This
-	 * prevents us from scattering swap pages all over the entire
-	 * swap partition, so that we reduce overall disk seek times
-	 * between swap pages.  -- sct */
-	if (si->cluster_nr) {
-		while (si->cluster_next <= si->highest_bit) {
-			offset = si->cluster_next++;
-			if (si->swap_map[offset])
-				continue;
-			si->cluster_nr--;
-			goto got_page;
-		}
-	}
-	si->cluster_nr = SWAPFILE_CLUSTER;
+int akpm;
 
-	/* try to find an empty (even not aligned) cluster. */
-	offset = si->lowest_bit;
- check_next_cluster:
-	if (offset+SWAPFILE_CLUSTER-1 <= si->highest_bit)
-	{
-		int nr;
-		for (nr = offset; nr < offset+SWAPFILE_CLUSTER; nr++)
-			if (si->swap_map[nr])
-			{
-				offset = nr+1;
-				goto check_next_cluster;
-			}
-		/* We found a completly empty cluster, so start
-		 * using it.
-		 */
-		goto got_page;
-	}
-	/* No luck, so now go finegrined as usual. -Andrea */
-	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
-		if (si->swap_map[offset])
+/*
+ * We divide the swapdev into 1024 kilobyte chunks.  We use the cookie and the
+ * upper bits of the index to select a chunk and the rest of the index as the
+ * offset into the selected chunk.
+ */
+#define CHUNK_SHIFT	(20 - PAGE_SHIFT)
+#define CHUNK_MASK	(-1UL << CHUNK_SHIFT)
+
+static int
+scan_swap_map(struct swap_info_struct *si, void *cookie, pgoff_t index)
+{
+	unsigned long chunk;
+	unsigned long nchunks;
+	unsigned long block;
+	unsigned long scan;
+
+	nchunks = si->max >> CHUNK_SHIFT;
+	chunk = 0;
+	if (nchunks)
+		chunk = hash_long((unsigned long)cookie + (index & CHUNK_MASK),
+					BITS_PER_LONG) % nchunks;
+
+	block = (chunk << CHUNK_SHIFT) + (index & ~CHUNK_MASK);
+
+	for (scan = 0; scan < si->max; scan++, block++) {
+		if (block == si->max)
+			block = 0;
+		if (block == 0)
 			continue;
-		si->lowest_bit = offset+1;
-	got_page:
-		if (offset == si->lowest_bit)
-			si->lowest_bit++;
-		if (offset == si->highest_bit)
-			si->highest_bit--;
-		if (si->lowest_bit > si->highest_bit) {
-			si->lowest_bit = si->max;
-			si->highest_bit = 0;
-		}
-		si->swap_map[offset] = 1;
-		si->inuse_pages++;
+		if (si->swap_map[block])
+			continue;
+		si->swap_map[block] = 1;
 		nr_swap_pages--;
-		si->cluster_next = offset+1;
-		return offset;
+		if (akpm)
+			printk("cookie:%p, index:%lu, chunk:%lu nchunks:%lu "
+				"block:%lu\n",
+				cookie, index, chunk, nchunks, block);
+		return block;
 	}
-	si->lowest_bit = si->max;
-	si->highest_bit = 0;
 	return 0;
 }
 
-swp_entry_t get_swap_page(void)
+swp_entry_t get_swap_page(void *cookie, pgoff_t index)
 {
 	struct swap_info_struct * p;
 	unsigned long offset;
@@ -166,7 +147,7 @@ swp_entry_t get_swap_page(void)
 		p = &swap_info[type];
 		if ((p->flags & SWP_ACTIVE) == SWP_ACTIVE) {
 			swap_device_lock(p);
-			offset = scan_swap_map(p);
+			offset = scan_swap_map(p, cookie, index);
 			swap_device_unlock(p);
 			if (offset) {
 				entry = swp_entry(type,offset);
diff -puN kernel/power/swsusp.c~swapspace-layout-improvements kernel/power/swsusp.c
--- 25/kernel/power/swsusp.c~swapspace-layout-improvements	2004-06-03 21:32:51.096601344 -0700
+++ 25-akpm/kernel/power/swsusp.c	2004-06-03 21:32:51.112598912 -0700
@@ -317,7 +317,7 @@ static int write_suspend_image(void)
 	for (i=0; i<nr_copy_pages; i++) {
 		if (!(i%100))
 			printk( "." );
-		if (!(entry = get_swap_page()).val)
+		if (!(entry = get_swap_page(NULL, i)).val)
 			panic("\nNot enough swapspace when writing data" );
 		
 		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
@@ -334,7 +334,7 @@ static int write_suspend_image(void)
 		cur = (union diskpage *)((char *) pagedir_nosave)+i;
 		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
 		printk( "." );
-		if (!(entry = get_swap_page()).val) {
+		if (!(entry = get_swap_page(NULL, i)).val) {
 			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
 			panic("Don't know how to recover");
 			free_page((unsigned long) buffer);
@@ -356,7 +356,7 @@ static int write_suspend_image(void)
 	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
 	BUG_ON (sizeof(struct link) != PAGE_SIZE);
-	if (!(entry = get_swap_page()).val)
+	if (!(entry = get_swap_page(NULL, i)).val)
 		panic( "\nNot enough swapspace when writing header" );
 	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 		panic("\nNot enough swapspace for header on suspend device" );
diff -puN kernel/power/pmdisk.c~swapspace-layout-improvements kernel/power/pmdisk.c
--- 25/kernel/power/pmdisk.c~swapspace-layout-improvements	2004-06-03 21:32:51.098601040 -0700
+++ 25-akpm/kernel/power/pmdisk.c	2004-06-03 21:32:51.113598760 -0700
@@ -206,7 +206,7 @@ static int write_swap_page(unsigned long
 	swp_entry_t entry;
 	int error = 0;
 
-	entry = get_swap_page();
+	entry = get_swap_page(NULL, addr >> PAGE_SHIFT);
 	if (swp_offset(entry) && 
 	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
 		error = rw_swap_page_sync(WRITE, entry,
_

