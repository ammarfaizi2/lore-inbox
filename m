Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbRAES0G>; Fri, 5 Jan 2001 13:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbRAESZz>; Fri, 5 Jan 2001 13:25:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:53254 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130093AbRAESZh>; Fri, 5 Jan 2001 13:25:37 -0500
Date: Fri, 5 Jan 2001 14:34:04 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: linux-kernel@vger.kernel.org
cc: Rik van Riel <riel@conectiva.com.br>
Subject: swapin readahead pre-patch (what about the code?)
In-Reply-To: <Pine.LNX.4.21.0101051416080.2823-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101051432270.2823-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jan 2001, Marcelo Tosatti wrote:

> The following patch does this, and it also changes the readahead code to
> readaround. I'm not sure if readaround is better than readahead for the
> swapin case, and I'll have to test this more to make sure.

Ok, I'm stupid. I forgot to attach the patch. 

diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/memory.c linux/mm/memory.c
--- linux.orig/mm/memory.c	Thu Jan  4 16:23:39 2001
+++ linux/mm/memory.c	Fri Jan  5 02:53:24 2001
@@ -46,7 +46,7 @@
 #include <asm/pgalloc.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-
+#include <linux/shmem_fs.h>
 
 unsigned long max_mapnr;
 unsigned long num_physpages;
@@ -979,38 +979,189 @@
 	return;
 }
 
+static inline int swap_entry_check(swp_entry_t entry, struct swap_info_struct *p)
+{
+	if (!p->swap_map || !p->swap_map[SWP_OFFSET(entry)]) {
+		return 1;
+	}
+	return 0;
+}
+
+int swap_device_sanity(unsigned long type, struct swap_info_struct *p)
+{ 
+        if (type >= nr_swapfiles) {
+		printk("%s: Trying to free nonexistent swap-page\n", 
+			__FUNCTION__);
+		return 1;
+	}
+	return 0;
+}
 
 
 /* 
- * Primitive swap readahead code. We simply read an aligned block of
- * (1 << page_cluster) entries in the swap area. This method is chosen
- * because it doesn't cost us any seek time.  We also make sure to queue
- * the 'original' request together with the readahead ones...  
+ * Swap readaround code. We search for virtually contiguous pages starting from 
+ * the one which needs to be swapped in.
+ *
+ * The virtually contiguous pages which are physically contiguous on the swap 
+ * device are clustered together and read from disk.
+ *
+ * The search is done in both directions (first backwards and then afterwards) 
+ * with a maximum of (1 << page_cluster) cluster size. 
+ *
+ * We may encounter pte's which are already present, which means we dont 
+ * have to readahead them (holes in the cluster). If we allow too many
+ * holes there is more possibility that the elevator algorithm can't merge
+ * such a "broken" cluster. The workaround here is to only allow 4 holes 
+ * (two for each direction). The right thing here is to autotune (?) or 
+ * allow the user to configure.
  */
-void swapin_readahead(swp_entry_t entry)
+
+#define SWAP_READ_CLUSTER (1 << page_cluster)
+#define MAX_HOLES	 2 
+void swapin_readahead(swp_entry_t entry, pte_t *page_table, 
+			struct vm_area_struct *vma, unsigned long address)
 {
-	int i, num;
+	int i, count, first, holes = 0;
 	struct page *new_page;
-	unsigned long offset;
+	unsigned long offset, page_offset, curr, type, main_addr;
+	unsigned long end = vma->vm_end, start = vma->vm_start;
+	pte_t *cpte = page_table;
+	swp_entry_t pte_entry, swp_entry, entries[SWAP_READ_CLUSTER*2];
+	struct swap_info_struct *p;
+
+	/* If there are too many in-flight swap IOs dont do read-ahead. */
+	if (atomic_read(&nr_async_pages) >= (pager_daemon.swap_cluster
+			* (1 << page_cluster)))
+		return;
 
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
+	type = SWP_TYPE(entry);
+
+	page_offset = offset = SWP_OFFSET(entry);
+	
+	p = &swap_info[type];
+
+	spin_lock(&vma->vm_mm->page_table_lock);
+	swap_device_lock(p);
+
+	/* Sanity checks on this swap device. */
+	if(swap_device_sanity(type, p)) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		swap_device_unlock(p);
+		return;
+	}
+	
+	first = SWAP_READ_CLUSTER;
+	count = 0;
+	curr = 1;
+	main_addr = address;
+
+	holes = MAX_HOLES;
+
+	/* Start backwards search. */
+	do {
+		cpte--;
+
+		/* In case we already have too many holes in this direction
+		 * of the cluster, stop searching. 
+		 */
+		if (!pte_present(*cpte)) {
+			if(++holes > MAX_HOLES) 
+				break;
+			else continue;
+		}
+
+		pte_entry = pte_to_swp_entry(*cpte);
+
+		offset = page_offset - curr;
+		swp_entry = SWP_ENTRY(type, offset);
+
+		/* Check sanity on both swap entries. */
+		if(swap_entry_check(pte_entry, p)) 
+			break;
+		if(swap_entry_check(swp_entry, p))
 			break;
+
+		/* If the pte is different from the pte on the swap, 
+		 * stop backward searching.
+		 */
+		if(pte_entry.val != swp_entry.val)
+			break;
+		
+		entries[--first] = pte_entry;
+		address -= PAGE_SIZE;
+		curr++;
+		count++;
+		p->swap_map[offset]++;
+	} while (count < SWAP_READ_CLUSTER && address &&
+			(address > start));
+
+	/* Point the pte we use in the loop to the "non conditional" 
+	 * member of the cluster.
+	 */
+	cpte = page_table;
+	curr = 1;
+	holes = 0;
+	address = main_addr;
+
+	if(first == SWAP_READ_CLUSTER)
+		first = SWAP_READ_CLUSTER + 1;
+
+	/* Now start a forward search. */
+	do {
+		cpte++;
+		pte_entry = pte_to_swp_entry(*cpte);
+
+		offset = page_offset + curr;
+		swp_entry = SWP_ENTRY(type, offset);
+
+		if (!pte_present(*cpte)) {
+			if(++holes > MAX_HOLES) 
+				break;
+			else continue;
 		}
-		/* Ok, do the async read-ahead now */
-		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset), 0);
+
+                /* Don't read-ahead past the end of the swap area. */
+                if (offset >= p->max)
+                        break;
+
+		if (SWP_OFFSET(pte_entry) >= p->max)
+			break;
+
+		/* Check sanity on both swap entries. */
+		if(swap_entry_check(pte_entry, p)) 
+			break;
+		if(swap_entry_check(swp_entry, p))
+			break;
+
+		if(pte_entry.val != swp_entry.val)
+			break;
+
+		entries[first + count] = pte_entry;
+		count++;
+	       	curr++;
+		address += PAGE_SIZE;
+		p->swap_map[offset]++;
+
+	} while (count < SWAP_READ_CLUSTER && address &&
+			(address < end));
+
+	swap_device_unlock(p);
+	spin_unlock(&vma->vm_mm->page_table_lock);
+
+	for (i = 0; i < count; i++) {
+		/* Ok, do the async read-ahead now. */
+		int pos = first + i;
+		/* We do not write the "main" page of the cluster here because 
+		 * this is done by our callers. We hope the elevator does its 
+		 * job to merge the requests.
+		 */
+		if(pos == SWAP_READ_CLUSTER) 
+			continue;
+
+		new_page = read_swap_cache_async(entries[pos], 0);
 		if (new_page != NULL)
 			page_cache_release(new_page);
-		swap_free(SWP_ENTRY(SWP_TYPE(entry), offset));
+		swap_free(entries[pos]);
 	}
 	return;
 }
@@ -1024,7 +1175,7 @@
 
 	if (!page) {
 		lock_kernel();
-		swapin_readahead(entry);
+		swapin_readahead(entry, page_table, vma, address);
 		page = read_swap_cache(entry);
 		unlock_kernel();
 		if (!page)
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/shmem.c linux/mm/shmem.c
--- linux.orig/mm/shmem.c	Thu Jan  4 16:23:39 2001
+++ linux/mm/shmem.c	Thu Jan  4 16:25:15 2001
@@ -275,8 +275,9 @@
 		/* Look it up and read it in.. */
 		page = lookup_swap_cache(*entry);
 		if (!page) {
+			pte_t pte = swp_entry_to_pte(*entry);
 			lock_kernel();
-			swapin_readahead(*entry);
+			swapin_readahead(*entry, &pte, vma, address);
 			page = read_swap_cache(*entry);
 			unlock_kernel();
 			if (!page) 
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/swapfile.c linux/mm/swapfile.c
--- linux.orig/mm/swapfile.c	Thu Jan  4 16:23:39 2001
+++ linux/mm/swapfile.c	Thu Jan  4 18:25:54 2001
@@ -952,33 +952,3 @@
 	return;
 }
 
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
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Thu Jan  4 16:23:39 2001
+++ linux/include/linux/mm.h	Thu Jan  4 20:44:41 2001
@@ -410,7 +410,8 @@
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
-extern void swapin_readahead(swp_entry_t);
+extern void swapin_readahead(swp_entry_t, pte_t *, struct vm_area_struct *,
+			unsigned long address);
 
 /* mmap.c */
 extern void lock_vma_mappings(struct vm_area_struct *);
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Thu Jan  4 16:23:39 2001
+++ linux/include/linux/swap.h	Fri Jan  5 03:04:33 2001
@@ -146,7 +146,6 @@
 					struct inode **);
 extern int swap_duplicate(swp_entry_t);
 extern int swap_count(struct page *);
-extern int valid_swaphandles(swp_entry_t, unsigned long *);
 #define get_swap_page() __get_swap_page(1)
 extern void __swap_free(swp_entry_t, unsigned short);
 #define swap_free(entry) __swap_free((entry), 1)
@@ -157,6 +156,7 @@
 extern struct swap_list_t swap_list;
 asmlinkage long sys_swapoff(const char *);
 asmlinkage long sys_swapon(const char *, int);
+extern struct swap_info_struct swap_info[MAX_SWAPFILES];
 
 #define SWAP_CACHE_INFO

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
