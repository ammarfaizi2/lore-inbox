Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUIJN1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUIJN1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 09:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIJN1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 09:27:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17876 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267404AbUIJN1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 09:27:34 -0400
Date: Fri, 10 Sep 2004 15:28:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org, mista.tapas@gmx.net, kr@cybsft.com,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040910132841.GA8552@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu> <20040909130526.2b015999.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20040909130526.2b015999.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Andrew Morton <akpm@osdl.org> wrote:

> diff -puN mm/vmscan.c~swapspace-layout-improvements mm/vmscan.c
> --- 25/mm/vmscan.c~swapspace-layout-improvements	2004-06-03 21:32:51.087602712 -0700
> +++ 25-akpm/mm/vmscan.c	2004-06-03 21:32:51.102600432 -0700

i've attached a merge against current BK-ish kernels. Lee, would you be
interested in testing it? It applies cleanly to an -S0 VP tree. I've
tested it only lightly - it compiles and boots and survives some simple
swapping but that's all.

	Ingo

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="swapspace-layout-improvements-2.6.9-rc1-bk12-A1"

--- linux/include/linux/swap.h.orig	
+++ linux/include/linux/swap.h	
@@ -193,7 +193,7 @@ extern int rw_swap_page_sync(int, swp_en
 extern struct address_space swapper_space;
 #define total_swapcache_pages  swapper_space.nrpages
 extern void show_swap_cache_info(void);
-extern int add_to_swap(struct page *);
+extern int add_to_swap(struct page *page, void *cookie, pgoff_t index);
 extern void __delete_from_swap_cache(struct page *);
 extern void delete_from_swap_cache(struct page *);
 extern int move_to_swap_cache(struct page *, swp_entry_t);
@@ -209,7 +209,7 @@ extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
 extern struct swap_info_struct swap_info[];
 extern void si_swapinfo(struct sysinfo *);
-extern swp_entry_t get_swap_page(void);
+extern swp_entry_t get_swap_page(void *cookie, pgoff_t index);
 extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
@@ -274,7 +274,7 @@ static inline int remove_exclusive_swap_
 	return 0;
 }
 
-static inline swp_entry_t get_swap_page(void)
+static inline swp_entry_t get_swap_page(void *cookie, pgoff_t index)
 {
 	swp_entry_t entry;
 	entry.val = 0;
--- linux/kernel/power/swsusp.c.orig	
+++ linux/kernel/power/swsusp.c	
@@ -317,7 +317,7 @@ static int write_suspend_image(void)
 	for (i=0; i<nr_copy_pages; i++) {
 		if (!(i%100))
 			printk( "." );
-		entry = get_swap_page();
+		entry = get_swap_page(NULL, i);
 		if (!entry.val)
 			panic("\nNot enough swapspace when writing data" );
 		
@@ -335,7 +335,7 @@ static int write_suspend_image(void)
 		cur = (union diskpage *)((char *) pagedir_nosave)+i;
 		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
 		printk( "." );
-		entry = get_swap_page();
+		entry = get_swap_page(NULL, i);
 		if (!entry.val) {
 			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
 			panic("Don't know how to recover");
@@ -358,7 +358,7 @@ static int write_suspend_image(void)
 	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
 	BUG_ON (sizeof(struct link) != PAGE_SIZE);
-	entry = get_swap_page();
+	entry = get_swap_page(NULL, i);
 	if (!entry.val)
 		panic( "\nNot enough swapspace when writing header" );
 	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
--- linux/kernel/power/pmdisk.c.orig	
+++ linux/kernel/power/pmdisk.c	
@@ -206,7 +206,7 @@ static int write_swap_page(unsigned long
 	swp_entry_t entry;
 	int error = 0;
 
-	entry = get_swap_page();
+	entry = get_swap_page(NULL, addr >> PAGE_SHIFT);
 	if (swp_offset(entry) && 
 	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
 		error = rw_swap_page_sync(WRITE, entry,
--- linux/mm/vmscan.c.orig	
+++ linux/mm/vmscan.c	
@@ -390,7 +390,10 @@ static int shrink_list(struct list_head 
 		 * Try to allocate it some swap space here.
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
-			if (!add_to_swap(page))
+			void *cookie = page->mapping;
+			pgoff_t index = page->index;
+
+			if (!add_to_swap(page, cookie, index))
 				goto activate_locked;
 		}
 #endif /* CONFIG_SWAP */
--- linux/mm/swap_state.c.orig	
+++ linux/mm/swap_state.c	
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
 
--- linux/mm/shmem.c.orig	
+++ linux/mm/shmem.c	
@@ -740,7 +740,7 @@ static int shmem_writepage(struct page *
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
 	struct address_space *mapping;
-	unsigned long index;
+	pgoff_t index;
 	struct inode *inode;
 
 	BUG_ON(!PageLocked(page));
@@ -752,7 +752,7 @@ static int shmem_writepage(struct page *
 	info = SHMEM_I(inode);
 	if (info->flags & VM_LOCKED)
 		goto redirty;
-	swap = get_swap_page();
+	swap = get_swap_page(mapping, index);
 	if (!swap.val)
 		goto redirty;
 
--- linux/mm/swapfile.c.orig	
+++ linux/mm/swapfile.c	
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
-		unsigned long nr;
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

--wq9mPyueHGvFACwf--
