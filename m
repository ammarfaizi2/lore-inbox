Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311501AbSCTECJ>; Tue, 19 Mar 2002 23:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311504AbSCTEAu>; Tue, 19 Mar 2002 23:00:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:53262 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311505AbSCTEAH>; Tue, 19 Mar 2002 23:00:07 -0500
Message-ID: <3C9808EE.B5C38E84@zip.com.au>
Date: Tue, 19 Mar 2002 19:58:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-110-zone_accounting
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



1: page_cache_size is no longer an atomic type - it's now just an
   unsigned long.  It's always altered under pagecache_lock.

2: accounting for number of pages on active LRU, number of pages on
   inactive LRU pages and total page cache size is now per-classzone
   rather than global.

3: Various macros to hide the above mechanism.

4: The use of the per-classzone counters was introduced in
   aa-096-swap_out.  This match actually makes them right, and the VM
   starts working again.

Andrea originally had the per-zone and global nr_inactive_pages,
nr_active_pages and page_cache_size accounting implemented as macros in
swap.h.  Linus described these as "macros from hell", so the hint was
taken and I implemented them as functions in swap.c.

These page-accounting functions require page_cache_lock for atomicity. 
That's fine for 2.4 but won't cut it with the radix-tree pagecache
which is 2.5-probable.

For ratcache, we'll need to turn these into per-zone, per-cpu counters,
as I did in the delayed-allocate locked- and dirty- page accounting
code.  That works OK.



=====================================

--- 2.4.19-pre3/arch/sparc64/kernel/sys_sunos32.c~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/arch/sparc64/kernel/sys_sunos32.c	Tue Mar 19 19:49:01 2002
@@ -157,7 +157,7 @@ asmlinkage int sunos_brk(u32 baddr)
 	 * fool it, but this should catch most mistakes.
 	 */
 	freepages = atomic_read(&buffermem_pages) >> PAGE_SHIFT;
-	freepages += atomic_read(&page_cache_size);
+	freepages += page_cache_size;
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
--- 2.4.19-pre3/arch/sparc/kernel/sys_sunos.c~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/arch/sparc/kernel/sys_sunos.c	Tue Mar 19 19:49:01 2002
@@ -193,7 +193,7 @@ asmlinkage int sunos_brk(unsigned long b
 	 * fool it, but this should catch most mistakes.
 	 */
 	freepages = atomic_read(&buffermem_pages) >> PAGE_SHIFT;
-	freepages += atomic_read(&page_cache_size);
+	freepages += page_cache_size;
 	freepages >>= 1;
 	freepages += nr_free_pages();
 	freepages += nr_swap_pages;
--- 2.4.19-pre3/fs/buffer.c~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/fs/buffer.c	Tue Mar 19 19:49:14 2002
@@ -2738,10 +2738,10 @@ void show_buffers(void)
 #endif
 
 	printk("Buffer memory:   %6dkB\n",
-			atomic_read(&buffermem_pages) << (PAGE_SHIFT-10));
+		atomic_read(&buffermem_pages) << (PAGE_SHIFT-10));
 
-	printk("Cache memory:   %6dkB\n",
-			(atomic_read(&page_cache_size)- atomic_read(&buffermem_pages)) << (PAGE_SHIFT-10));
+	printk("Cache memory:   %6ldkB\n",
+		(page_cache_size - atomic_read(&buffermem_pages)) << (PAGE_SHIFT-10));
 
 #ifdef CONFIG_SMP /* trylock does nothing on UP and so we could deadlock */
 	if (!spin_trylock(&lru_list_lock))
--- 2.4.19-pre3/fs/proc/proc_misc.c~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/fs/proc/proc_misc.c	Tue Mar 19 19:49:01 2002
@@ -142,7 +142,7 @@ static int meminfo_read_proc(char *page,
 #define B(x) ((unsigned long long)(x) << PAGE_SHIFT)
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	pg_size = atomic_read(&page_cache_size) - i.bufferram ;
+	pg_size = page_cache_size - i.bufferram;
 
 	len = sprintf(page, "        total:    used:    free:  shared: buffers:  cached:\n"
 		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
--- 2.4.19-pre3/include/linux/pagemap.h~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/include/linux/pagemap.h	Tue Mar 19 19:49:01 2002
@@ -45,7 +45,7 @@ extern unsigned int page_hash_bits;
 #define PAGE_HASH_BITS (page_hash_bits)
 #define PAGE_HASH_SIZE (1 << PAGE_HASH_BITS)
 
-extern atomic_t page_cache_size; /* # of pages currently in the hash table */
+extern unsigned long page_cache_size; /* # of pages currently in the hash table */
 extern struct page **page_hash_table;
 
 extern void page_cache_init(unsigned long);
--- 2.4.19-pre3/include/linux/swap.h~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/include/linux/swap.h	Tue Mar 19 19:49:14 2002
@@ -88,7 +88,7 @@ extern unsigned int nr_free_buffer_pages
 extern int nr_active_pages;
 extern int nr_inactive_pages;
 extern atomic_t nr_async_pages;
-extern atomic_t page_cache_size;
+extern unsigned long page_cache_size;
 extern atomic_t buffermem_pages;
 extern spinlock_t pagecache_lock;
 extern void __remove_inode_page(struct page *);
@@ -173,33 +173,45 @@ do {						\
 		BUG();				\
 } while (0)
 
+extern void delta_nr_active_pages(struct page *page, long delta);
+#define inc_nr_active_pages(page) delta_nr_active_pages(page, 1)
+#define dec_nr_active_pages(page) delta_nr_active_pages(page, -1)
+
+extern void delta_nr_inactive_pages(struct page *page, long delta);
+#define inc_nr_inactive_pages(page) delta_nr_inactive_pages(page, 1)
+#define dec_nr_inactive_pages(page) delta_nr_inactive_pages(page, -1)
+
 #define add_page_to_active_list(page)		\
 do {						\
 	DEBUG_LRU_PAGE(page);			\
 	SetPageActive(page);			\
 	list_add(&(page)->lru, &active_list);	\
-	nr_active_pages++;			\
+	inc_nr_active_pages(page);		\
 } while (0)
 
 #define add_page_to_inactive_list(page)		\
 do {						\
 	DEBUG_LRU_PAGE(page);			\
 	list_add(&(page)->lru, &inactive_list);	\
-	nr_inactive_pages++;			\
+	inc_nr_inactive_pages(page);		\
 } while (0)
 
 #define del_page_from_active_list(page)		\
 do {						\
 	list_del(&(page)->lru);			\
 	ClearPageActive(page);			\
-	nr_active_pages--;			\
+	dec_nr_active_pages(page);		\
 } while (0)
 
 #define del_page_from_inactive_list(page)	\
 do {						\
 	list_del(&(page)->lru);			\
-	nr_inactive_pages--;			\
+	dec_nr_inactive_pages(page);		\
 } while (0)
+
+extern void delta_nr_cache_pages(struct page *page, long delta);
+#define inc_nr_cache_pages(page) delta_nr_cache_pages(page, 1)
+#define dec_nr_cache_pages(page) delta_nr_cache_pages(page, -1)
 
 extern spinlock_t swaplock;
 
--- 2.4.19-pre3/mm/filemap.c~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/filemap.c	Tue Mar 19 19:49:13 2002
@@ -43,7 +43,7 @@
  * SMP-threaded pagemap-LRU 1999, Andrea Arcangeli <andrea@suse.de>
  */
 
-atomic_t page_cache_size = ATOMIC_INIT(0);
+unsigned long page_cache_size;
 unsigned int page_hash_bits;
 struct page **page_hash_table;
 
@@ -80,7 +80,7 @@ static void add_page_to_hash_queue(struc
 		next->pprev_hash = &page->next_hash;
 	if (page->buffers)
 		PAGE_BUG(page);
-	atomic_inc(&page_cache_size);
+	inc_nr_cache_pages(page);
 }
 
 static inline void add_page_to_inode_queue(struct address_space *mapping, struct page * page)
@@ -110,7 +110,7 @@ static inline void remove_page_from_hash
 		next->pprev_hash = pprev;
 	*pprev = next;
 	page->pprev_hash = NULL;
-	atomic_dec(&page_cache_size);
+	dec_nr_cache_pages(page);
 }
 
 /*
--- 2.4.19-pre3/mm/mmap.c~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/mmap.c	Tue Mar 19 19:49:01 2002
@@ -69,7 +69,7 @@ int vm_enough_memory(long pages)
 	    return 1;
 
 	/* The page cache contains buffer pages these days.. */
-	free = atomic_read(&page_cache_size);
+	free = page_cache_size;
 	free += nr_free_pages();
 	free += nr_swap_pages;
 
--- 2.4.19-pre3/mm/swap.c~aa-110-zone_accounting	Tue Mar 19 19:49:01 2002
+++ 2.4.19-pre3-akpm/mm/swap.c	Tue Mar 19 19:49:11 2002
@@ -93,6 +93,78 @@ void lru_cache_del(struct page * page)
 	spin_unlock(&pagemap_lru_lock);
 }
 
+/**
+ * delta_nr_active_pages: alter the number of active pages.
+ *
+ * @page: the page which is being activated/deactivated
+ * @delta: +1 for activation, -1 for deactivation
+ *
+ * Called under pagecache_lock
+ */
+void delta_nr_active_pages(struct page *page, long delta)
+{
+	pg_data_t * __pgdat;
+	zone_t * __classzone, * __overflow;
+
+	__classzone = page_zone(page);
+	__pgdat = __classzone->zone_pgdat;
+	__overflow = __pgdat->node_zones + __pgdat->nr_zones;
+
+	while (__classzone < __overflow) {
+		__classzone->nr_active_pages += delta;
+		__classzone++;
+	}
+	nr_active_pages += delta;
+}
+
+/**
+ * delta_nr_inactive_pages: alter the number of inactive pages.
+ *
+ * @page: the page which is being deactivated/activated
+ * @delta: +1 for deactivation, -1 for activation
+ *
+ * Called under pagecache_lock
+ */
+void delta_nr_inactive_pages(struct page *page, long delta)
+{
+	pg_data_t * __pgdat;
+	zone_t * __classzone, * __overflow;
+
+	__classzone = page_zone(page);
+	__pgdat = __classzone->zone_pgdat;
+	__overflow = __pgdat->node_zones + __pgdat->nr_zones;
+
+	while (__classzone < __overflow) {
+		__classzone->nr_inactive_pages += delta;
+		__classzone++;
+	}
+	nr_inactive_pages += delta;
+}
+
+/**
+ * delta_nr_cache_pages: alter the number of pages in the pagecache
+ *
+ * @page: the page which is being added/removed
+ * @delta: +1 for addition, -1 for removal
+ *
+ * Called under pagecache_lock
+ */
+void delta_nr_cache_pages(struct page *page, long delta)
+{
+	pg_data_t * __pgdat;
+	zone_t * __classzone, * __overflow;
+
+	__classzone = page_zone(page);
+	__pgdat = __classzone->zone_pgdat;
+	__overflow = __pgdat->node_zones + __pgdat->nr_zones;
+
+	while (__classzone < __overflow) {
+		__classzone->nr_cache_pages += delta;
+		__classzone++;
+	}
+	page_cache_size += delta;
+}
+
 /*
  * Perform any setup for the swap system
  */

-
