Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSKUWsv>; Thu, 21 Nov 2002 17:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKUWsv>; Thu, 21 Nov 2002 17:48:51 -0500
Received: from stingr.net ([212.193.32.15]:20238 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S265081AbSKUWsC>;
	Thu, 21 Nov 2002 17:48:02 -0500
Date: Fri, 22 Nov 2002 01:55:07 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CFT][PATCH] Latest -rmap15 stuff against 2.4.20-rc2-ac2
Message-ID: <20021121225507.GH20701@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on latest code riel committed to his rmap branch.
Rediffed against 2.4.20-rc2-ac2

ChangeSet@1.695.1.6, 2002-11-21 16:42:17-02:00, riel@duckman.distro.conectiva
  first stab at fine-tuning arjan's O(1) VM
  - split the active list in process working set and file cache
  - preferentially deactivate file cache pages, if there are many
    of those
  - speed up and slow down page aging as wanted

diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Fri Nov 22 00:36:57 2002
+++ b/fs/buffer.c	Fri Nov 22 00:36:58 2002
@@ -2915,6 +2915,30 @@
 	}
 }
 
+
+/*
+ * Do some IO post-processing here!!!
+ */
+void do_io_postprocessing(void)
+{
+	int i;
+	struct buffer_head *bh, *next;
+
+	spin_lock(&lru_list_lock);
+	bh = lru_list[BUF_LOCKED];
+	if (bh) {
+		for (i = nr_buffers_type[BUF_LOCKED]; i-- > 0; bh = next) {
+			next = bh->b_next_free;
+
+			if (!buffer_locked(bh)) 
+				__refile_buffer(bh);
+			else 
+				break;
+		}
+	}
+	spin_unlock(&lru_list_lock);
+}
+
 /*
  * This is the kernel update daemon. It was used to live in userspace
  * but since it's need to run safely we want it unkillable by mistake.
@@ -2966,6 +2990,7 @@
 #ifdef DEBUG
 		printk(KERN_DEBUG "kupdate() activated...\n");
 #endif
+		do_io_postprocessing();
 		sync_old_buffers();
 		run_task_queue(&tq_disk);
 	}
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Fri Nov 22 00:36:57 2002
+++ b/fs/proc/proc_misc.c	Fri Nov 22 00:36:57 2002
@@ -191,7 +191,10 @@
 		"Cached:       %8lu kB\n"
 		"SwapCached:   %8lu kB\n"
 		"Active:       %8u kB\n"
+		"ActiveAnon:   %8u kB\n"
+		"ActiveCache:  %8u kB\n"
 		"Inact_dirty:  %8u kB\n"
+		"Inact_laundry:%8u kB\n"
 		"Inact_clean:  %8u kB\n"
 		"Inact_target: %8u kB\n"
 		"HighTotal:    %8lu kB\n"
@@ -207,8 +210,11 @@
 		K(i.bufferram),
 		K(pg_size - swapper_space.nrpages),
 		K(swapper_space.nrpages),
-		K(nr_active_pages),
+		K(nr_active_anon_pages) + K(nr_active_cache_pages),
+		K(nr_active_anon_pages),
+		K(nr_active_cache_pages),
 		K(nr_inactive_dirty_pages),
+		K(nr_inactive_laundry_pages),
 		K(nr_inactive_clean_pages),
 		K(inactive_target()),
 		K(i.totalhigh),
diff -Nru a/include/linux/brlock.h b/include/linux/brlock.h
--- a/include/linux/brlock.h	Fri Nov 22 00:36:57 2002
+++ b/include/linux/brlock.h	Fri Nov 22 00:36:57 2002
@@ -37,6 +37,8 @@
 	BR_GLOBALIRQ_LOCK,
 	BR_NETPROTO_LOCK,
 	BR_LLC_LOCK,
+	BR_LRU_LOCK,
+
 	__BR_END
 };
 
diff -Nru a/include/linux/list.h b/include/linux/list.h
--- a/include/linux/list.h	Fri Nov 22 00:36:57 2002
+++ b/include/linux/list.h	Fri Nov 22 00:36:57 2002
@@ -137,8 +137,7 @@
 	return head->next == head;
 }
 
-static inline void __list_splice(struct list_head *list,
-				 struct list_head *head)
+static inline void __list_splice(struct list_head *list, struct list_head *head)
 {
 	struct list_head *first = list->next;
 	struct list_head *last = list->prev;
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Fri Nov 22 00:36:57 2002
+++ b/include/linux/mm.h	Fri Nov 22 00:36:57 2002
@@ -1,5 +1,23 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
+/*
+ * Copyright (c) 2002. All rights reserved.
+ *
+ * This software may be freely redistributed under the terms of the
+ * GNU General Public License.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Authors: 
+ *	Linus Torvalds
+ *	Stephen Tweedie
+ *	Andrea Arcangeli
+ *	Rik van Riel
+ *	Arjan van de Ven
+ *	and others
+ */
 
 #include <linux/sched.h>
 #include <linux/errno.h>
@@ -168,7 +186,7 @@
 	unsigned long flags;		/* atomic flags, some possibly
 					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
-					   protected by pagemap_lru_lock !! */
+					   protected by the lru lock !! */
 	unsigned char age;		/* Page aging counter. */
 	struct pte_chain * pte_chain;	/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock
@@ -279,7 +297,7 @@
  *
  * Note that the referenced bit, the page->lru list_head and the
  * active, inactive_dirty and inactive_clean lists are protected by
- * the pagemap_lru_lock, and *NOT* by the usual PG_locked bit!
+ * the lru lock, and *NOT* by the usual PG_locked bit!
  *
  * PG_skip is used on sparc/sparc64 architectures to "skip" certain
  * parts of the address space.
@@ -300,18 +318,21 @@
 #define PG_referenced		 2
 #define PG_uptodate		 3
 #define PG_dirty		 4
-#define PG_inactive_clean	 5
-#define PG_active		 6
+#define PG_active_anon		 5
 #define PG_inactive_dirty	 7
-#define PG_slab			 8
-#define PG_skip			10
-#define PG_highmem		11
-#define PG_checked		12	/* kill me in 2.5.<early>. */
-#define PG_arch_1		13
-#define PG_reserved		14
-#define PG_launder		15	/* written out by VM pressure.. */
-#define PG_chainlock		16	/* lock bit for ->pte_chain */
-#define PG_lru			17
+#define PG_inactive_laundry	 8
+#define PG_inactive_clean	 9
+#define PG_slab			10
+#define PG_skip			11
+#define PG_highmem		12
+#define PG_checked		13	/* kill me in 2.5.<early>. */
+#define PG_arch_1		14
+#define PG_reserved		15
+#define PG_launder		16	/* written out by VM pressure.. */
+#define PG_chainlock		17	/* lock bit for ->pte_chain */
+#define PG_lru			18
+#define PG_active_cache		19
+
 /* Don't you dare to use high bits, they seem to be used for something else! */
 
 
@@ -429,11 +450,21 @@
 #define PageClearSlab(page)	clear_bit(PG_slab, &(page)->flags)
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 
-#define PageActive(page)	test_bit(PG_active, &(page)->flags)
-#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
-#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-#define TestandSetPageActive(page)	test_and_set_bit(PG_active, &(page)->flags)
-#define TestandClearPageActive(page)	test_and_clear_bit(PG_active, &(page)->flags)
+#define PageActiveAnon(page)		test_bit(PG_active_anon, &(page)->flags)
+#define SetPageActiveAnon(page)	set_bit(PG_active_anon, &(page)->flags)
+#define ClearPageActiveAnon(page)	clear_bit(PG_active_anon, &(page)->flags)
+#define TestandSetPageActiveAnon(page)	test_and_set_bit(PG_active_anon, &(page)->flags)
+#define TestandClearPageActiveAnon(page)	test_and_clear_bit(PG_active_anon, &(page)->flags)
+
+#define PageActiveCache(page)		test_bit(PG_active_cache, &(page)->flags)
+#define SetPageActiveCache(page)	set_bit(PG_active_cache, &(page)->flags)
+#define ClearPageActiveCache(page)	clear_bit(PG_active_cache, &(page)->flags)
+#define TestandSetPageActiveCache(page)	test_and_set_bit(PG_active_cache, &(page)->flags)
+#define TestandClearPageActiveCache(page)	test_and_clear_bit(PG_active_cache, &(page)->flags)
+
+#define PageInactiveLaundry(page)	test_bit(PG_inactive_laundry, &(page)->flags)
+#define SetPageInactiveLaundry(page)	set_bit(PG_inactive_laundry, &(page)->flags)
+#define ClearPageInactiveLaundry(page)	clear_bit(PG_inactive_laundry, &(page)->flags)
 
 #define PageInactiveDirty(page)	test_bit(PG_inactive_dirty, &(page)->flags)
 #define SetPageInactiveDirty(page)	set_bit(PG_inactive_dirty, &(page)->flags)
diff -Nru a/include/linux/mm_inline.h b/include/linux/mm_inline.h
--- a/include/linux/mm_inline.h	Fri Nov 22 00:36:57 2002
+++ b/include/linux/mm_inline.h	Fri Nov 22 00:36:57 2002
@@ -2,23 +2,127 @@
 #define _LINUX_MM_INLINE_H
 
 #include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/brlock.h>
+
+
+/*
+ * Copyright (c) 2002. All rights reserved.
+ *
+ * This software may be freely redistributed under the terms of the
+ * GNU General Public License.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Authors: 
+ *	Linus Torvalds
+ *	Stephen Tweedie
+ *	Andrea Arcangeli
+ *	Rik van Riel
+ *	Arjan van de Ven
+ *	and others
+ */
+
+GPL_HEADER()
+
+extern unsigned char active_age_bias;
 
 /*
  * These inline functions tend to need bits and pieces of all the
  * other VM include files, meaning they cannot be defined inside
  * one of the other VM include files.
+ * 
+ */
+ 
+/**
+ * page_dirty - do we need to write the data out to disk
+ * @page: page to test
+ *
+ * Returns true if the page contains data which needs to
+ * be written to disk.  Doesn't test the page tables (yet?).
+ */
+static inline int page_dirty(struct page *page)
+{
+	struct buffer_head *tmp, *bh;
+
+	if (PageDirty(page))
+		return 1;
+
+	if (page->mapping && !page->buffers)
+		return 0;
+
+	tmp = bh = page->buffers;
+
+	do {
+		if (tmp->b_state & ((1<<BH_Dirty) | (1<<BH_Lock)))
+			return 1;
+		tmp = tmp->b_this_page;
+	} while (tmp != bh);
+
+	return 0;
+}
+
+/**
+ * page_anon - is this page ram/swap backed ?
+ * @page - page to test
  *
- * The include file mess really needs to be cleaned up...
+ * Returns 1 if the page is backed by ram/swap, 0 if the page is
+ * backed by a file in a filesystem on permanent storage.
  */
+static inline int page_anon(struct page * page)
+{
+	/* Pages of an mmap()d file won't trigger this unless they get
+	 * referenced on the inactive list and really are in the working
+	 * set of the process... */
+	if (page->pte_chain)
+		return 1;
+
+	if (!page->mapping && !page->buffers)
+		return 1;
+
+	if (PageSwapCache(page))
+		return 1;
+
+	if (!page->mapping->a_ops->writepage)
+		return 1;
 
-static inline void add_page_to_active_list(struct page * page)
+	/* TODO: ramfs, tmpfs shm segments and ramdisk */
+
+	return 0;
+}
+
+
+
+static inline void add_page_to_active_anon_list(struct page * page, int age)
 {
 	struct zone_struct * zone = page_zone(page);
 	DEBUG_LRU_PAGE(page);
-	SetPageActive(page);
-	list_add(&page->lru, &zone->active_list);
-	zone->active_pages++;
-	nr_active_pages++;
+	SetPageActiveAnon(page);
+	list_add(&page->lru, &zone->active_anon_list[age]);
+	page->age = age + active_age_bias;
+	zone->active_anon_pages++;
+	nr_active_anon_pages++;
+}
+
+static inline void add_page_to_active_cache_list(struct page * page, int age)
+{
+	struct zone_struct * zone = page_zone(page);
+	DEBUG_LRU_PAGE(page);
+	SetPageActiveCache(page);
+	list_add(&page->lru, &zone->active_cache_list[age]);
+	page->age = age + active_age_bias;
+	zone->active_cache_pages++;
+	nr_active_cache_pages++;
+}
+
+static inline void add_page_to_active_list(struct page * page, int age)
+{
+	if (page_anon(page))
+		add_page_to_active_anon_list(page, age);
+	else
+		add_page_to_active_cache_list(page, age);
 }
 
 static inline void add_page_to_inactive_dirty_list(struct page * page)
@@ -31,6 +135,16 @@
 	nr_inactive_dirty_pages++;
 }
 
+static inline void add_page_to_inactive_laundry_list(struct page * page)
+{
+	struct zone_struct * zone = page_zone(page);
+	DEBUG_LRU_PAGE(page);
+	SetPageInactiveLaundry(page);
+	list_add(&page->lru, &zone->inactive_laundry_list);
+	zone->inactive_laundry_pages++;
+	nr_inactive_laundry_pages++;
+}
+
 static inline void add_page_to_inactive_clean_list(struct page * page)
 {
 	struct zone_struct * zone = page_zone(page);
@@ -41,13 +155,31 @@
 	nr_inactive_clean_pages++;
 }
 
-static inline void del_page_from_active_list(struct page * page)
+static inline void del_page_from_active_anon_list(struct page * page)
+{
+	struct zone_struct * zone = page_zone(page);
+	unsigned char age;
+	list_del(&page->lru);
+	ClearPageActiveAnon(page);
+	nr_active_anon_pages--;
+	zone->active_anon_pages--;
+	age = page->age - active_age_bias;
+	if (age<=MAX_AGE)
+		zone->active_anon_count[age]--;
+	DEBUG_LRU_PAGE(page);
+}
+
+static inline void del_page_from_active_cache_list(struct page * page)
 {
 	struct zone_struct * zone = page_zone(page);
+	unsigned char age;
 	list_del(&page->lru);
-	ClearPageActive(page);
-	nr_active_pages--;
-	zone->active_pages--;
+	ClearPageActiveCache(page);
+	nr_active_cache_pages--;
+	zone->active_cache_pages--;
+	age = page->age - active_age_bias;
+	if (age<=MAX_AGE)
+		zone->active_cache_count[age]--;
 	DEBUG_LRU_PAGE(page);
 }
 
@@ -61,6 +193,16 @@
 	DEBUG_LRU_PAGE(page);
 }
 
+static inline void del_page_from_inactive_laundry_list(struct page * page)
+{
+	struct zone_struct * zone = page_zone(page);
+	list_del(&page->lru);
+	ClearPageInactiveLaundry(page);
+	nr_inactive_laundry_pages--;
+	zone->inactive_laundry_pages--;
+	DEBUG_LRU_PAGE(page);
+}
+
 static inline void del_page_from_inactive_clean_list(struct page * page)
 {
 	struct zone_struct * zone = page_zone(page);
@@ -184,7 +326,8 @@
 {
 	int inactive, target, inactive_base;
 
-	inactive_base = zone->active_pages + zone->inactive_dirty_pages;
+	inactive_base = zone->active_anon_pages + zone->active_cache_pages
+			+  zone->inactive_dirty_pages;
 	inactive_base /= INACTIVE_FACTOR;
 
 	/* GCC should optimise this away completely. */
@@ -253,7 +396,13 @@
  */
 static inline int inactive_high(struct zone_struct * zone)
 {
-	return inactive_limit(zone, VM_HIGH);
+	unsigned long active, inactive;
+	active = zone->active_anon_pages + zone->active_cache_pages
+		+ zone->free_pages;
+	inactive = zone->inactive_dirty_pages + zone->inactive_clean_pages + zone->inactive_laundry_pages;
+	if (inactive * 5 >   (active+inactive))
+		return -1;
+	return 1;
 }
 
 /*
@@ -263,12 +412,33 @@
 {
 	int target;
 
-	target = nr_active_pages + nr_inactive_dirty_pages
-			+ nr_inactive_clean_pages;
+	target = nr_active_anon_pages + nr_active_cache_pages
+			+ nr_inactive_dirty_pages + nr_inactive_clean_pages
+			+ nr_inactive_laundry_pages;
 
 	target /= INACTIVE_FACTOR;
 
 	return target;
+}
+
+static inline void lru_lock(struct zone_struct *zone)
+{
+	if (zone) {
+		br_read_lock(BR_LRU_LOCK);
+		spin_lock(&zone->lru_lock);
+	} else {
+		br_write_lock(BR_LRU_LOCK);
+	}
+}
+
+static inline void lru_unlock(struct zone_struct *zone)
+{
+	if (zone) {
+		spin_unlock(&zone->lru_lock);
+		br_read_unlock(BR_LRU_LOCK);
+	} else {
+		br_write_unlock(BR_LRU_LOCK);
+	}
 }
 
 #endif /* _LINUX_MM_INLINE_H */
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Fri Nov 22 00:36:57 2002
+++ b/include/linux/mmzone.h	Fri Nov 22 00:36:57 2002
@@ -13,11 +13,7 @@
  * Free memory management - zoned buddy allocator.
  */
 
-#ifndef CONFIG_FORCE_MAX_ZONEORDER
 #define MAX_ORDER 10
-#else
-#define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
-#endif
 
 typedef struct free_area_struct {
 	struct list_head	free_list;
@@ -29,6 +25,9 @@
 
 #define MAX_CHUNKS_PER_NODE 8
 
+#define MAX_AGE 15
+#define INITIAL_AGE 3
+
 #define MAX_PER_CPU_PAGES 512
 typedef struct per_cpu_pages_s {
 	int			nr_pages, max_nr_pages;
@@ -50,19 +49,27 @@
 	per_cpu_t		cpu_pages[NR_CPUS];
 	spinlock_t		lock;
 	unsigned long		free_pages;
-	unsigned long		active_pages;
+	unsigned long		active_anon_pages;
+	unsigned long		active_cache_pages;
 	unsigned long		inactive_dirty_pages;
+	unsigned long		inactive_laundry_pages;
 	unsigned long		inactive_clean_pages;
 	unsigned long		pages_min, pages_low, pages_high, pages_plenty;
 	int			need_balance;
+	int			need_scan;
+	int			active_anon_count[MAX_AGE+1];
+	int			active_cache_count[MAX_AGE+1];
 
 	/*
 	 * free areas of different sizes
 	 */
-	struct list_head	active_list;
+	struct list_head	active_anon_list[MAX_AGE+1];
+	struct list_head	active_cache_list[MAX_AGE+1];
 	struct list_head	inactive_dirty_list;
+	struct list_head	inactive_laundry_list;
 	struct list_head	inactive_clean_list;
 	free_area_t		free_area[MAX_ORDER];
+	spinlock_t		lru_lock;
 
 	/*
 	 * wait_table           -- the array holding the hash table
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Fri Nov 22 00:36:58 2002
+++ b/include/linux/module.h	Fri Nov 22 00:36:58 2002
@@ -287,6 +287,9 @@
 static const char __module_license[] __attribute__((section(".modinfo"))) =   \
 "license=" license
 
+#define GPL_HEADER() \
+static const char cpyright="This software may be freely redistributed under the terms of the GNU General Public License.";
+
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;
 
@@ -302,7 +305,6 @@
 static const char __module_using_checksums[] __attribute__((section(".modinfo"))) =
 "using_checksums=1";
 #endif
-
 #else /* MODULE */
 
 #define MODULE_AUTHOR(name)
@@ -311,6 +313,7 @@
 #define MODULE_SUPPORTED_DEVICE(name)
 #define MODULE_PARM(var,type)
 #define MODULE_PARM_DESC(var,desc)
+#define GPL_HEADER()
 
 /* Create a dummy reference to the table to suppress gcc unused warnings.  Put
  * the reference in the .data.exit section which is discarded when code is built
diff -Nru a/include/linux/pagemap.h b/include/linux/pagemap.h
--- a/include/linux/pagemap.h	Fri Nov 22 00:36:57 2002
+++ b/include/linux/pagemap.h	Fri Nov 22 00:36:57 2002
@@ -70,10 +70,6 @@
 
 #define page_hash(mapping,index) (page_hash_table+_page_hashfn(mapping,index))
 
-extern struct page * __find_get_page(struct address_space *mapping,
-				unsigned long index, struct page **hash);
-#define find_get_page(mapping, index) \
-	__find_get_page(mapping, index, page_hash(mapping, index))
 extern struct page * __find_lock_page (struct address_space * mapping,
 				unsigned long index, struct page **hash);
 extern struct page * find_or_create_page(struct address_space *mapping,
@@ -90,6 +86,13 @@
 extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index, struct page **hash);
 
 extern void ___wait_on_page(struct page *);
+extern int wait_on_page_timeout(struct page *page, int timeout);
+
+
+extern struct page * __find_pagecache_page(struct address_space *mapping,
+				unsigned long index, struct page **hash);
+#define find_pagecache_page(mapping, index) \
+	__find_pagecache_page(mapping, index, page_hash(mapping, index))
 
 static inline void wait_on_page(struct page * page)
 {
diff -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Fri Nov 22 00:36:57 2002
+++ b/include/linux/swap.h	Fri Nov 22 00:36:57 2002
@@ -85,8 +85,10 @@
 
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
-extern int nr_active_pages;
+extern int nr_active_anon_pages;
+extern int nr_active_cache_pages;
 extern int nr_inactive_dirty_pages;
+extern int nr_inactive_laundry_pages;
 extern int nr_inactive_clean_pages;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
@@ -115,6 +117,7 @@
 
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
+extern void FASTCALL(lru_cache_add_dirty(struct page *));
 extern void FASTCALL(__lru_cache_del(struct page *));
 extern void FASTCALL(lru_cache_del(struct page *));
 
@@ -175,8 +178,6 @@
 asmlinkage long sys_swapoff(const char *);
 asmlinkage long sys_swapon(const char *, int);
 
-extern spinlock_cacheline_t pagemap_lru_lock_cacheline;
-#define pagemap_lru_lock pagemap_lru_lock_cacheline.lock
 
 extern void FASTCALL(mark_page_accessed(struct page *));
 
@@ -191,13 +192,17 @@
 
 /*
  * List add/del helper macros. These must be called
- * with the pagemap_lru_lock held!
+ * with the lru lock held!
  */
 #define DEBUG_LRU_PAGE(page)			\
 do {						\
-	if (PageActive(page))			\
+	if (PageActiveAnon(page))		\
+		BUG();				\
+	if (PageActiveCache(page))		\
 		BUG();				\
 	if (PageInactiveDirty(page))		\
+		BUG();				\
+	if (PageInactiveLaundry(page))		\
 		BUG();				\
 	if (PageInactiveClean(page))		\
 		BUG();				\
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri Nov 22 00:36:57 2002
+++ b/kernel/ksyms.c	Fri Nov 22 00:36:57 2002
@@ -262,7 +262,6 @@
 EXPORT_SYMBOL(__pollwait);
 EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
-EXPORT_SYMBOL(__find_get_page);
 EXPORT_SYMBOL(__find_lock_page);
 EXPORT_SYMBOL(find_or_create_page);
 EXPORT_SYMBOL(grab_cache_page_nowait);
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Fri Nov 22 00:36:57 2002
+++ b/mm/filemap.c	Fri Nov 22 00:36:57 2002
@@ -55,15 +55,14 @@
 
 spinlock_cacheline_t pagecache_lock_cacheline  = {SPIN_LOCK_UNLOCKED};
 /*
- * NOTE: to avoid deadlocking you must never acquire the pagemap_lru_lock 
+ * NOTE: to avoid deadlocking you must never acquire the lru lock 
  *	with the pagecache_lock held.
  *
  * Ordering:
  *	swap_lock ->
- *		pagemap_lru_lock ->
+ *		   lru lock ->
  *			pagecache_lock
  */
-spinlock_cacheline_t pagemap_lru_lock_cacheline = {SPIN_LOCK_UNLOCKED};
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
@@ -183,7 +182,7 @@
 
 	head = &inode->i_mapping->clean_pages;
 
-	spin_lock(&pagemap_lru_lock);
+	lru_lock(ALL_ZONES);
 	spin_lock(&pagecache_lock);
 	curr = head->next;
 
@@ -216,7 +215,7 @@
 	}
 
 	spin_unlock(&pagecache_lock);
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(ALL_ZONES);
 }
 
 static int do_flushpage(struct page *page, unsigned long offset)
@@ -880,6 +879,32 @@
 		wake_up_all(waitqueue);
 }
 
+
+/* like wait_on_page but with a timeout (in jiffies).
+ * returns 1 on timeout 
+ */
+int wait_on_page_timeout(struct page *page, int timeout)
+{
+	wait_queue_head_t *waitqueue = page_waitqueue(page);
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+	
+	if (!PageLocked(page))
+		return 0;
+
+	add_wait_queue(waitqueue, &wait);
+	do {
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		if (!PageLocked(page))
+			break;
+		sync_page(page);
+		timeout = schedule_timeout(timeout);
+	} while (PageLocked(page) && timeout);
+	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(waitqueue, &wait);
+	return PageLocked(page);
+}
+
 /*
  * Get a lock on the page, assuming we need to sleep
  * to get it..
@@ -914,26 +939,6 @@
 		__lock_page(page);
 }
 
-/*
- * a rather lightweight function, finding and getting a reference to a
- * hashed page atomically.
- */
-struct page * __find_get_page(struct address_space *mapping,
-			      unsigned long offset, struct page **hash)
-{
-	struct page *page;
-
-	/*
-	 * We scan the hash list read-only. Addition to and removal from
-	 * the hash-list needs a held write-lock.
-	 */
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
-	if (page)
-		page_cache_get(page);
-	spin_unlock(&pagecache_lock);
-	return page;
-}
 
 /*
  * Same as above, but trylock it instead of incrementing the count.
@@ -1069,19 +1074,41 @@
 	 * been increased since the last time we were called, we
 	 * stop when the page isn't there.
 	 */
-	spin_lock(&pagemap_lru_lock);
+	lru_lock(ALL_ZONES);
 	while (--index >= start) {
 		struct page **hash = page_hash(mapping, index);
 		spin_lock(&pagecache_lock);
 		page = __find_page_nolock(mapping, index, *hash);
 		spin_unlock(&pagecache_lock);
-		if (!page || !PageActive(page))
+		if (!page || !PageActiveCache(page))
 			break;
 		drop_page(page);
 	}
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(ALL_ZONES);
+}
+
+/*
+ * Look up a page in the pagecache and return that page with
+ * a reference helt
+ */
+struct page * __find_pagecache_page(struct address_space *mapping,
+			      unsigned long offset, struct page **hash)
+{
+	struct page *page;
+
+	/*
+	 * We scan the hash list read-only. Addition to and removal from
+	 * the hash-list needs a held write-lock.
+	 */
+	spin_lock(&pagecache_lock);
+	page = __find_page_nolock(mapping, offset, *hash);
+	if (page)
+		page_cache_get(page);
+	spin_unlock(&pagecache_lock);
+	return page;
 }
 
+
 /* Same as grab_cache_page, but do not wait if the page is unavailable.
  * This is intended for speculative data generators, where the data can
  * be regenerated if the page couldn't be grabbed.  This routine should
@@ -1092,7 +1119,7 @@
 	struct page *page, **hash;
 
 	hash = page_hash(mapping, index);
-	page = __find_get_page(mapping, index, hash);
+	page = __find_pagecache_page(mapping, index, hash);
 
 	if ( page ) {
 		if ( !TryLockPage(page) ) {
@@ -1378,7 +1405,7 @@
 	/* Mark the page referenced, AFTER checking for previous usage.. */
 	SetPageReferenced(page);
 
-	if (unlikely(PageInactiveClean(page))) {
+	if (unlikely(PageInactiveClean(page) || PageInactiveLaundry(page))) {
 		struct zone_struct *zone = page_zone(page);
 		int free = zone->free_pages + zone->inactive_clean_pages;
 
@@ -2022,7 +2049,7 @@
 	 */
 	hash = page_hash(mapping, pgoff);
 retry_find:
-	page = __find_get_page(mapping, pgoff, hash);
+	page = __find_pagecache_page(mapping, pgoff, hash);
 	if (!page)
 		goto no_cached_page;
 
@@ -2885,7 +2912,7 @@
 	struct page *page, *cached_page = NULL;
 	int err;
 repeat:
-	page = __find_get_page(mapping, index, hash);
+	page = __find_pagecache_page(mapping, index, hash);
 	if (!page) {
 		if (!cached_page) {
 			cached_page = page_cache_alloc(mapping);
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Fri Nov 22 00:36:57 2002
+++ b/mm/page_alloc.c	Fri Nov 22 00:36:57 2002
@@ -26,8 +26,10 @@
 #include <linux/smp.h>
 
 int nr_swap_pages;
-int nr_active_pages;
+int nr_active_anon_pages;
+int nr_active_cache_pages;
 int nr_inactive_dirty_pages;
+int nr_inactive_laundry_pages;
 int nr_inactive_clean_pages;
 pg_data_t *pgdat_list;
 
@@ -109,16 +111,19 @@
 		BUG();
 	if (PageLocked(page))
 		BUG();
-	if (PageActive(page))
+	if (PageActiveAnon(page))
+		BUG();
+	if (PageActiveCache(page))
 		BUG();
 	if (PageInactiveDirty(page))
 		BUG();
+	if (PageInactiveLaundry(page))
+		BUG();
 	if (PageInactiveClean(page))
 		BUG();
 	if (page->pte_chain)
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
-	page->age = PAGE_AGE_START;
 	
 	zone = page_zone(page);
 
@@ -728,9 +733,10 @@
 		nr_free_pages() << (PAGE_SHIFT-10),
 		nr_free_highpages() << (PAGE_SHIFT-10));
 
-	printk("( Active: %d, inactive_dirty: %d, inactive_clean: %d, free: %d )\n",
-		nr_active_pages,
+	printk("( Active: %d/%d, inactive_laundry: %d, inactive_clean: %d, free: %d )\n",
+		nr_active_anon_pages + nr_active_cache_pages,
 		nr_inactive_dirty_pages,
+		nr_inactive_laundry_pages,
 		nr_inactive_clean_pages,
 		nr_free_pages());
 
@@ -941,12 +947,25 @@
 		zone->lock = SPIN_LOCK_UNLOCKED;
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->active_anon_pages = 0;
+		zone->active_cache_pages = 0;
 		zone->inactive_clean_pages = 0;
+		zone->inactive_laundry_pages = 0;
 		zone->inactive_dirty_pages = 0;
 		zone->need_balance = 0;
-		INIT_LIST_HEAD(&zone->active_list);
+		zone->need_scan = 0;
+		for (k = 0; k <= MAX_AGE ; k++) {
+			INIT_LIST_HEAD(&zone->active_anon_list[k]);
+			zone->active_anon_count[k] = 0;
+		}
+		for (k = 0; k <= MAX_AGE ; k++) {
+			INIT_LIST_HEAD(&zone->active_cache_list[k]);
+			zone->active_cache_count[k] = 0;
+		}
 		INIT_LIST_HEAD(&zone->inactive_dirty_list);
+		INIT_LIST_HEAD(&zone->inactive_laundry_list);
 		INIT_LIST_HEAD(&zone->inactive_clean_list);
+		spin_lock_init(&zone->lru_lock);
 
 		if (!size)
 			continue;
diff -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	Fri Nov 22 00:36:57 2002
+++ b/mm/rmap.c	Fri Nov 22 00:36:57 2002
@@ -14,7 +14,7 @@
 /*
  * Locking:
  * - the page->pte_chain is protected by the PG_chainlock bit,
- *   which nests within the pagemap_lru_lock, then the
+ *   which nests within the lru lock, then the
  *   mm->page_table_lock, and then the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
@@ -195,7 +195,7 @@
  * table entry mapping a page. Because locking order here is opposite
  * to the locking order used by the page fault path, we use trylocks.
  * Locking:
- *	pagemap_lru_lock		page_launder()
+ *	   lru lock			page_launder()
  *	    page lock			page_launder(), trylock
  *		pte_chain_lock		page_launder()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
@@ -263,7 +263,7 @@
  * @page: the page to get unmapped
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold pagemap_lru_lock
+ * page, used in the pageout path.  Caller must hold lru lock
  * and the page lock.  Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
diff -Nru a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Fri Nov 22 00:36:57 2002
+++ b/mm/shmem.c	Fri Nov 22 00:36:57 2002
@@ -581,7 +581,7 @@
 	 * cache and swap cache.  We need to recheck the page cache
 	 * under the protection of the info->lock spinlock. */
 
-	page = find_get_page(mapping, idx);
+	page = find_pagecache_page(mapping, idx);
 	if (page) {
 		if (TryLockPage(page))
 			goto wait_retry;
diff -Nru a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c	Fri Nov 22 00:36:57 2002
+++ b/mm/swap.c	Fri Nov 22 00:36:57 2002
@@ -36,7 +36,6 @@
 /**
  * (de)activate_page - move pages from/to active and inactive lists
  * @page: the page we want to move
- * @nolock - are we already holding the pagemap_lru_lock?
  *
  * Deactivate_page will move an active page to the right
  * inactive list, while activate_page will move a page back
@@ -51,18 +50,20 @@
 	 * (some pages aren't on any list at all)
 	 */
 	ClearPageReferenced(page);
-	page->age = 0;
-	if (PageActive(page)) {
-		del_page_from_active_list(page);
+	if (PageActiveAnon(page)) {
+		del_page_from_active_anon_list(page);
+		add_page_to_inactive_dirty_list(page);
+	} else if (PageActiveCache(page)) {
+		del_page_from_active_cache_list(page);
 		add_page_to_inactive_dirty_list(page);
 	}
 }	
 
 void deactivate_page(struct page * page)
 {
-	spin_lock(&pagemap_lru_lock);
+	lru_lock(page_zone(page));
 	deactivate_page_nolock(page);
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(page_zone(page));
 }
 
 /**
@@ -74,16 +75,54 @@
  * on the inactive_clean list it is placed on the inactive_dirty list
  * instead.
  *
- * Note: this function gets called with the pagemap_lru_lock held.
+ * Note: this function gets called with the lru lock held.
  */
+void drop_page_zone(struct zone_struct *zone, struct page * page)
+{
+	if (!TryLockPage(page)) {
+		if (page->mapping && page->buffers) {
+			page_cache_get(page);
+			lru_unlock(zone);
+			try_to_release_page(page, GFP_NOIO);
+			lru_lock(zone);
+			page_cache_release(page);
+		}
+		UnlockPage(page);
+	}
+
+	/* Make sure the page really is reclaimable. */
+	pte_chain_lock(page);
+	if (!page->mapping || PageDirty(page) || page->pte_chain ||
+			page->buffers || page_count(page) > 1)
+		deactivate_page_nolock(page);
+
+	else if (page_count(page) == 1) {
+		ClearPageReferenced(page);
+		if (PageActiveAnon(page)) {
+			del_page_from_active_anon_list(page);
+			add_page_to_inactive_clean_list(page);
+		} else if (PageActiveCache(page)) {
+			del_page_from_active_cache_list(page);
+			add_page_to_inactive_clean_list(page);
+		} else if (PageInactiveDirty(page)) {
+			del_page_from_inactive_dirty_list(page);
+			add_page_to_inactive_clean_list(page);
+		} else if (PageInactiveLaundry(page)) {
+			del_page_from_inactive_laundry_list(page);
+			add_page_to_inactive_clean_list(page);
+		}
+	}
+	pte_chain_unlock(page);
+}
+
 void drop_page(struct page * page)
 {
 	if (!TryLockPage(page)) {
 		if (page->mapping && page->buffers) {
 			page_cache_get(page);
-			spin_unlock(&pagemap_lru_lock);
+			lru_unlock(ALL_ZONES);
 			try_to_release_page(page, GFP_NOIO);
-			spin_lock(&pagemap_lru_lock);
+			lru_lock(ALL_ZONES);
 			page_cache_release(page);
 		}
 		UnlockPage(page);
@@ -97,13 +136,18 @@
 
 	else if (page_count(page) == 1) {
 		ClearPageReferenced(page);
-		page->age = 0;
-		if (PageActive(page)) {
-			del_page_from_active_list(page);
+		if (PageActiveAnon(page)) {
+			del_page_from_active_anon_list(page);
+			add_page_to_inactive_clean_list(page);
+		} else if (PageActiveCache(page)) {
+			del_page_from_active_cache_list(page);
 			add_page_to_inactive_clean_list(page);
 		} else if (PageInactiveDirty(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_inactive_clean_list(page);
+		} else if (PageInactiveLaundry(page)) {
+			del_page_from_inactive_laundry_list(page);
+			add_page_to_inactive_clean_list(page);
 		}
 	}
 	pte_chain_unlock(page);
@@ -116,21 +160,21 @@
 {
 	if (PageInactiveDirty(page)) {
 		del_page_from_inactive_dirty_list(page);
-		add_page_to_active_list(page);
+		add_page_to_active_list(page, INITIAL_AGE);
+	} else if (PageInactiveLaundry(page)) {
+		del_page_from_inactive_laundry_list(page);
+		add_page_to_active_list(page, INITIAL_AGE);
 	} else if (PageInactiveClean(page)) {
 		del_page_from_inactive_clean_list(page);
-		add_page_to_active_list(page);
+		add_page_to_active_list(page, INITIAL_AGE);
 	}
-
-	/* Make sure the page gets a fair chance at staying active. */
-	page->age = max((int)page->age, PAGE_AGE_START);
 }
 
 void activate_page(struct page * page)
 {
-	spin_lock(&pagemap_lru_lock);
+	lru_lock(page_zone(page));
 	activate_page_nolock(page);
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(page_zone(page));
 }
 
 /**
@@ -140,10 +184,10 @@
 void lru_cache_add(struct page * page)
 {
 	if (!PageLRU(page)) {
-		spin_lock(&pagemap_lru_lock);
+		lru_lock(page_zone(page));
 		SetPageLRU(page);
-		add_page_to_active_list(page);
-		spin_unlock(&pagemap_lru_lock);
+		add_page_to_active_list(page, INITIAL_AGE);
+		lru_unlock(page_zone(page));
 	}
 }
 
@@ -152,14 +196,18 @@
  * @page: the page to add
  *
  * This function is for when the caller already holds
- * the pagemap_lru_lock.
+ * the lru lock.
  */
 void __lru_cache_del(struct page * page)
 {
-	if (PageActive(page)) {
-		del_page_from_active_list(page);
+	if (PageActiveAnon(page)) {
+		del_page_from_active_anon_list(page);
+	} else if (PageActiveCache(page)) {
+		del_page_from_active_cache_list(page);
 	} else if (PageInactiveDirty(page)) {
 		del_page_from_inactive_dirty_list(page);
+	} else if (PageInactiveLaundry(page)) {
+		del_page_from_inactive_laundry_list(page);
 	} else if (PageInactiveClean(page)) {
 		del_page_from_inactive_clean_list(page);
 	}
@@ -172,9 +220,9 @@
  */
 void lru_cache_del(struct page * page)
 {
-	spin_lock(&pagemap_lru_lock);
+	lru_lock(page_zone(page));
 	__lru_cache_del(page);
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(page_zone(page));
 }
 
 /*
diff -Nru a/mm/swap_state.c b/mm/swap_state.c
--- a/mm/swap_state.c	Fri Nov 22 00:36:57 2002
+++ b/mm/swap_state.c	Fri Nov 22 00:36:57 2002
@@ -196,7 +196,7 @@
 {
 	struct page *found;
 
-	found = find_get_page(&swapper_space, entry.val);
+	found = find_pagecache_page(&swapper_space, entry.val);
 	/*
 	 * Unsafe to assert PageSwapCache and mapping on page found:
 	 * if SMP nothing prevents swapoff from deleting this page from
@@ -224,10 +224,10 @@
 		/*
 		 * First check the swap cache.  Since this is normally
 		 * called after lookup_swap_cache() failed, re-calling
-		 * that would confuse statistics: use find_get_page()
+		 * that would confuse statistics: use find_pagecache_page()
 		 * directly.
 		 */
-		found_page = find_get_page(&swapper_space, entry.val);
+		found_page = find_pagecache_page(&swapper_space, entry.val);
 		if (found_page)
 			break;
 
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Fri Nov 22 00:36:57 2002
+++ b/mm/vmscan.c	Fri Nov 22 00:36:57 2002
@@ -12,6 +12,7 @@
  *  to bring the system back to freepages.high: 2.4.97, Rik van Riel.
  *  Zone aware kswapd started 02/00, Kanoj Sarcar (kanoj@sgi.com).
  *  Multiqueue VM started 5.8.00, Rik van Riel.
+ *  O(1) rmap vm, Arjan van de ven <arjanv@redhat.com>
  */
 
 #include <linux/slab.h>
@@ -37,16 +38,36 @@
  */
 #define DEF_PRIORITY (6)
 
-static inline void age_page_up(struct page *page)
+static inline void age_page_up_nolock(struct page *page, int old_age)
 {
-	page->age = min((int) (page->age + PAGE_AGE_ADV), PAGE_AGE_MAX); 
-}
+	int new_age;
+	
+	new_age = old_age+4;
+	if (new_age < 0)
+		new_age = 0;
+	if (new_age > MAX_AGE)
+		new_age = MAX_AGE;	
+		
+	if (PageActiveAnon(page)) {
+		del_page_from_active_anon_list(page);
+		add_page_to_active_anon_list(page, new_age);	
+	} else if (PageActiveCache(page)) {
+		del_page_from_active_cache_list(page);
+		add_page_to_active_cache_list(page, new_age);	
+	} else if (PageInactiveDirty(page)) {
+		del_page_from_inactive_dirty_list(page);
+		add_page_to_active_list(page, new_age);	
+	} else if (PageInactiveLaundry(page)) {
+		del_page_from_inactive_laundry_list(page);
+		add_page_to_active_list(page, new_age);	
+	} else if (PageInactiveClean(page)) {
+		del_page_from_inactive_clean_list(page);
+		add_page_to_active_list(page, new_age);	
+	} else return;
 
-static inline void age_page_down(struct page *page)
-{
-	page->age -= min(PAGE_AGE_DECL, (int)page->age);
 }
 
+
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
 {
@@ -84,9 +105,9 @@
 
 	/*
 	 * We need to hold the pagecache_lock around all tests to make sure
-	 * reclaim_page() cannot race with find_get_page() and friends.
+	 * reclaim_page() doesn't race with other pagecache users
 	 */
-	spin_lock(&pagemap_lru_lock);
+	lru_lock(zone);
 	spin_lock(&pagecache_lock);
 	maxscan = zone->inactive_clean_pages;
 	while (maxscan-- && !list_empty(&zone->inactive_clean_list)) {
@@ -94,12 +115,7 @@
 		page = list_entry(page_lru, struct page, lru);
 
 		/* Wrong page on list?! (list corruption, should not happen) */
-		if (unlikely(!PageInactiveClean(page))) {
-			printk("VM: reclaim_page, wrong page on list.\n");
-			list_del(page_lru);
-			page_zone(page)->inactive_clean_pages--;
-			continue;
-		}
+		BUG_ON(unlikely(!PageInactiveClean(page)));
 
 		/* Page is being freed */
 		if (unlikely(page_count(page)) == 0) {
@@ -144,7 +160,7 @@
 		UnlockPage(page);
 	}
 	spin_unlock(&pagecache_lock);
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(zone);
 	return NULL;
 
 
@@ -152,11 +168,10 @@
 	__lru_cache_del(page);
 	pte_chain_unlock(page);
 	spin_unlock(&pagecache_lock);
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(zone);
 	if (entry.val)
 		swap_free(entry);
 	UnlockPage(page);
-	page->age = PAGE_AGE_START;
 	if (page_count(page) != 1)
 		printk("VM: reclaim_page, found page with count %d!\n",
 				page_count(page));
@@ -164,458 +179,626 @@
 }
 
 /**
- * page_dirty - do we need to write the data out to disk
- * @page: page to test
+ * need_rebalance_dirty - do we need to write inactive stuff to disk?
+ * @zone: the zone in question
  *
- * Returns true if the page contains data which needs to
- * be written to disk.  Doesn't test the page tables (yet?).
+ * Returns true if the zone in question has an inbalance between inactive
+ * dirty on one side and inactive laundry + inactive clean on the other
+ * Right now set the balance at 50%; may need tuning later on
  */
-static inline int page_dirty(struct page *page)
+static inline int need_rebalance_dirty(zone_t * zone)
 {
-	struct buffer_head *tmp, *bh;
-
-	if (PageDirty(page))
+	if (zone->inactive_dirty_pages > zone->inactive_laundry_pages + zone->inactive_clean_pages)
 		return 1;
 
-	if (page->mapping && !page->buffers)
-		return 0;
-
-	tmp = bh = page->buffers;
-
-	do {
-		if (tmp->b_state & ((1<<BH_Dirty) | (1<<BH_Lock)))
-			return 1;
-		tmp = tmp->b_this_page;
-	} while (tmp != bh);
+	return 0;
+}
 
+/**
+ * need_rebalance_laundry - does the zone have too few inactive_clean pages?
+ * @zone: the zone in question
+ *
+ * Returns true if the zone in question has too few pages in inactive clean
+ * + free
+ */
+static inline int need_rebalance_laundry(zone_t * zone)
+{
+	if (free_low(zone) >= 0)
+		return 1;
 	return 0;
 }
 
 /**
- * page_launder_zone - clean dirty inactive pages, move to inactive_clean list
+ * launder_page - clean dirty page, move to inactive_laundry list
  * @zone: zone to free pages in
  * @gfp_mask: what operations we are allowed to do
- * @full_flush: full-out page flushing, if we couldn't get enough clean pages
+ * @page: the page at hand, must be on the inactive dirty list
  *
- * This function is called when we are low on free / inactive_clean
- * pages, its purpose is to refill the free/clean list as efficiently
- * as possible.
- *
- * This means we do writes asynchronously as long as possible and will
- * only sleep on IO when we don't have another option. Since writeouts
- * cause disk seeks and make read IO slower, we skip writes alltogether
- * when the amount of dirty pages is small.
- *
- * This code is heavily inspired by the FreeBSD source code. Thanks
- * go out to Matthew Dillon.
- */
-int page_launder_zone(zone_t * zone, int gfp_mask, int full_flush)
-{
-	int maxscan, cleaned_pages, target, maxlaunder, iopages, over_rsslimit;
-	struct list_head * entry, * next;
-
-	target = max_t(int, free_plenty(zone), zone->pages_min);
-	cleaned_pages = iopages = 0;
-
-	/* If we can get away with it, only flush 2 MB worth of dirty pages */
-	if (full_flush)
-		maxlaunder = 1000000;
-	else {
-		maxlaunder = min_t(int, 512, zone->inactive_dirty_pages / 4);
-		maxlaunder = max(maxlaunder, free_plenty(zone) * 4);
-	}
-	
-	/* The main launder loop. */
-	spin_lock(&pagemap_lru_lock);
-rescan:
-	maxscan = zone->inactive_dirty_pages;
-	entry = zone->inactive_dirty_list.prev;
-	next = entry->prev;
-	while (maxscan-- && !list_empty(&zone->inactive_dirty_list) &&
-			next != &zone->inactive_dirty_list) {
-		struct page * page;
-		
-		/* Low latency reschedule point */
-		if (current->need_resched) {
-			spin_unlock(&pagemap_lru_lock);
-			schedule();
-			spin_lock(&pagemap_lru_lock);
-			continue;
-		}
-
-		entry = next;
-		next = entry->prev;
-		page = list_entry(entry, struct page, lru);
-
-		/* This page was removed while we looked the other way. */
-		if (!PageInactiveDirty(page))
-			goto rescan;
+ * per-zone lru lock is assumed to be held, but this function can drop
+ * it and sleep, so no other locks are allowed to be held.
+ *
+ * returns 0 for failure; 1 for success
+ */
+int launder_page(zone_t * zone, int gfp_mask, struct page *page)
+{
+	int over_rsslimit;
 
-		if (cleaned_pages > target)
-			break;
+	/*
+	 * Page is being freed, don't worry about it, but report progress.
+	 */
+	if (unlikely(page_count(page)) == 0)
+		return 1;
 
-		/* Stop doing IO if we've laundered too many pages already. */
-		if (maxlaunder < 0)
-			gfp_mask &= ~(__GFP_IO|__GFP_FS);
+	BUG_ON(!PageInactiveDirty(page));
+	del_page_from_inactive_dirty_list(page);
+	add_page_to_inactive_laundry_list(page);
+	/* store the time we start IO */
+	page->age = (jiffies/HZ)&255;
+	/*
+	 * The page is locked. IO in progress?
+	 * If so, move to laundry and report progress
+	 * Acquire PG_locked early in order to safely
+	 * access page->mapping.
+	 */
+	if (unlikely(TryLockPage(page))) {
+		return 1;
+	}
 
-		/*
-		 * Page is being freed, don't worry about it.
-		 */
-		if (unlikely(page_count(page)) == 0)
-			continue;
+	/*
+	 * The page is in active use or really unfreeable. Move to
+	 * the active list and adjust the page age if needed.
+	 */
+	pte_chain_lock(page);
+	if (page_referenced(page, &over_rsslimit) && !over_rsslimit &&
+			page_mapping_inuse(page)) {
+		del_page_from_inactive_laundry_list(page);
+		add_page_to_active_list(page, INITIAL_AGE);
+		pte_chain_unlock(page);
+		UnlockPage(page);
+		return 1;
+	}
 
-		/*
-		 * The page is locked. IO in progress?
-		 * Acquire PG_locked early in order to safely
-		 * access page->mapping.
-		 */
-		if (unlikely(TryLockPage(page))) {
-			iopages++;
-			continue;
+	/*
+	 * Anonymous process memory without backing store. Try to
+	 * allocate it some swap space here.
+	 *
+	 * XXX: implement swap clustering ?
+	 */
+	if (page->pte_chain && !page->mapping && !page->buffers) {
+		page_cache_get(page);
+		pte_chain_unlock(page);
+		lru_unlock(zone);
+		if (!add_to_swap(page)) {
+			activate_page(page);
+			lru_lock(zone);
+			UnlockPage(page);
+			page_cache_release(page);
+			return 0;
 		}
-
-		/*
-		 * The page is in active use or really unfreeable. Move to
-		 * the active list and adjust the page age if needed.
-		 */
-		pte_chain_lock(page);
-		if (page_referenced(page, &over_rsslimit) && !over_rsslimit &&
-				page_mapping_inuse(page)) {
-			del_page_from_inactive_dirty_list(page);
-			add_page_to_active_list(page);
-			page->age = max((int)page->age, PAGE_AGE_START);
-			pte_chain_unlock(page);
+		lru_lock(zone);
+		page_cache_release(page);
+		/* Note: may be on another list ! */
+		if (!PageInactiveLaundry(page)) {
 			UnlockPage(page);
-			continue;
+			return 1;
+		}
+		if (unlikely(page_count(page)) == 0) {
+			UnlockPage(page);
+			return 1;
 		}
+		pte_chain_lock(page);
+	}
 
-		/*
-		 * Anonymous process memory without backing store. Try to
-		 * allocate it some swap space here.
-		 *
-		 * XXX: implement swap clustering ?
-		 */
-		if (page->pte_chain && !page->mapping && !page->buffers) {
-			/* Don't bother if we can't swap it out now. */
-			if (maxlaunder < 0) {
+	/*
+	 * The page is mapped into the page tables of one or more
+	 * processes. Try to unmap it here.
+	 */
+	if (page->pte_chain && page->mapping) {
+		switch (try_to_unmap(page)) {
+			case SWAP_ERROR:
+			case SWAP_FAIL:
+				goto page_active;
+			case SWAP_AGAIN:
 				pte_chain_unlock(page);
 				UnlockPage(page);
-				list_del(entry);
-				list_add(entry, &zone->inactive_dirty_list);
-				continue;
-			}
-			page_cache_get(page);
-			pte_chain_unlock(page);
-			spin_unlock(&pagemap_lru_lock);
-			if (!add_to_swap(page)) {
-				activate_page(page);
-				UnlockPage(page);
-				page_cache_release(page);
-				spin_lock(&pagemap_lru_lock);
-				continue;
-			}
-			page_cache_release(page);
-			spin_lock(&pagemap_lru_lock);
-			pte_chain_lock(page);
+				return 0;
+			case SWAP_SUCCESS:
+				; /* fall through, try freeing the page below */
+			/* fixme: add a SWAP_MLOCK case */
 		}
+	}
+	pte_chain_unlock(page);
 
+	if (PageDirty(page) && page->mapping) {
 		/*
-		 * The page is mapped into the page tables of one or more
-		 * processes. Try to unmap it here.
+		 * The page can be dirtied after we start writing, but
+		 * in that case the dirty bit will simply be set again
+		 * and we'll need to write it again.
 		 */
-		if (page->pte_chain && page->mapping) {
-			switch (try_to_unmap(page)) {
-				case SWAP_ERROR:
-				case SWAP_FAIL:
-					goto page_active;
-				case SWAP_AGAIN:
-					pte_chain_unlock(page);
-					UnlockPage(page);
-					continue;
-				case SWAP_SUCCESS:
-					; /* try to free the page below */
-			}
+		int (*writepage)(struct page *);
+
+		writepage = page->mapping->a_ops->writepage;
+		if ((gfp_mask & __GFP_FS) && writepage) {
+			ClearPageDirty(page);
+			SetPageLaunder(page);
+			page_cache_get(page);
+			lru_unlock(zone);
+
+			writepage(page);
+
+			page_cache_release(page);
+			lru_lock(zone);
+			return 1;
+		} else {
+			del_page_from_inactive_laundry_list(page);
+			add_page_to_inactive_dirty_list(page);
+			/* FIXME: this is wrong for !__GFP_FS !!! */
+			UnlockPage(page);
+			return 0;
 		}
-		pte_chain_unlock(page);
+	}
 
-		if (PageDirty(page) && page->mapping) {
-			/*
-			 * It is not critical here to write it only if
-			 * the page is unmapped beause any direct writer
-			 * like O_DIRECT would set the PG_dirty bitflag
-			 * on the physical page after having successfully
-			 * pinned it and after the I/O to the page is finished,
-			 * so the direct writes to the page cannot get lost.
-			 */
-			int (*writepage)(struct page *);
+	/*
+	 * If the page has buffers, try to free the buffer mappings
+	 * associated with this page. If we succeed we try to free
+	 * the page as well.
+	 */
+	if (page->buffers) {
+		/* To avoid freeing our page before we're done. */
+		page_cache_get(page);
+		lru_unlock(zone);
 
-			writepage = page->mapping->a_ops->writepage;
-			if ((gfp_mask & __GFP_FS) && writepage) {
-				ClearPageDirty(page);
-				SetPageLaunder(page);
-				page_cache_get(page);
-				spin_unlock(&pagemap_lru_lock);
+		try_to_release_page(page, gfp_mask);
+		UnlockPage(page);
 
-				writepage(page);
-				maxlaunder--;
-				iopages++;
-				page_cache_release(page);
+		/* 
+		 * If the buffers were the last user of the page we free
+		 * the page here. Because of that we shouldn't hold the
+		 * lru lock yet.
+		 */
+		page_cache_release(page);
 
-				spin_lock(&pagemap_lru_lock);
-				continue;
-			} else {
-				UnlockPage(page);
-				list_del(entry);
-				list_add(entry, &zone->inactive_dirty_list);
-				continue;
-			}
-		}
+		lru_lock(zone);
+		return 1;
+	}
 
+	/*
+	 * If the page is really freeable now, move it to the
+	 * inactive_laundry list to keep LRU order.
+	 *
+	 * We re-test everything since the page could have been
+	 * used by somebody else while we waited on IO above.
+	 * This test is not safe from races; only the one in
+	 * reclaim_page() needs to be.
+	 */
+	pte_chain_lock(page);
+	if (page->mapping && !PageDirty(page) && !page->pte_chain &&
+			page_count(page) == 1) {
+		pte_chain_unlock(page);
+		UnlockPage(page);
+		return 1;
+	} else {
 		/*
-		 * If the page has buffers, try to free the buffer mappings
-		 * associated with this page. If we succeed we try to free
-		 * the page as well.
+		 * OK, we don't know what to do with the page.
+		 * It's no use keeping it here, so we move it
+		 * back to the active list.
 		 */
-		if (page->buffers) {
-			/* To avoid freeing our page before we're done. */
-			page_cache_get(page);
+ page_active:
+		activate_page_nolock(page);
+		pte_chain_unlock(page);
+		UnlockPage(page);
+	}
+	return 0;
+}
 
-			spin_unlock(&pagemap_lru_lock);
 
-			if (try_to_release_page(page, gfp_mask)) {
-				if (!page->mapping) {
-					/*
-					 * We must not allow an anon page
-					 * with no buffers to be visible on
-					 * the LRU, so we unlock the page after
-					 * taking the lru lock
-					 */
-					spin_lock(&pagemap_lru_lock);
-					UnlockPage(page);
-					__lru_cache_del(page);
+unsigned char active_age_bias = 0;
 
-					/* effectively free the page here */
-					page_cache_release(page);
+/* Ages down all pages on the active list */
+/* assumes the lru lock held */
+static inline void kachunk_anon(struct zone_struct * zone)
+{
+	int k;
+	if (!list_empty(&zone->active_anon_list[0]))
+		return;
+	if (!zone->active_anon_pages)
+		return;
 
-					cleaned_pages++;
-					continue;
-				} else {
-					/*
-					 * We freed the buffers but may have
-					 * slept; undo the stuff we did before
-					 * try_to_release_page and fall through
-					 * to the next step.
-					 * But only if the page is still on the inact. dirty 
-					 * list.
-					 */
-
-					spin_lock(&pagemap_lru_lock);
-					/* Check if the page was removed from the list
-					 * while we looked the other way. 
-					 */
-					if (!PageInactiveDirty(page)) {
-						page_cache_release(page);
-						continue;
-					}
-					page_cache_release(page);
-				}
-			} else {
-				/* failed to drop the buffers so stop here */
-				UnlockPage(page);
-				page_cache_release(page);
-				maxlaunder--;
-				iopages++;
+	for (k = 0; k < MAX_AGE; k++)  {
+		list_splice_init(&zone->active_anon_list[k+1], &zone->active_anon_list[k]);
+		zone->active_anon_count[k] = zone->active_anon_count[k+1];
+		zone->active_anon_count[k+1] = 0;
+	}
+
+	active_age_bias++;
+	/* flag this zone as having had activity -> rescan to age up is desired */
+	zone->need_scan++;
+}
+
+static inline void kachunk_cache(struct zone_struct * zone)
+{
+	int k;
+	if (!list_empty(&zone->active_cache_list[0]))
+		return;
+	if (!zone->active_cache_pages)
+		return;
+
+	for (k = 0; k < MAX_AGE; k++)  {
+		list_splice_init(&zone->active_cache_list[k+1], &zone->active_cache_list[k]);
+		zone->active_cache_count[k] = zone->active_cache_count[k+1];
+		zone->active_cache_count[k+1] = 0;
+	}
 
-				spin_lock(&pagemap_lru_lock);
+	active_age_bias++;
+	/* flag this zone as having had activity -> rescan to age up is desired */
+	zone->need_scan++;
+}
+
+#define BATCH_WORK_AMOUNT	64
+
+/*
+ * returns the active cache ratio relative to the total active list
+ * times 10 (eg. 30% cache returns 3)
+ */
+static inline int cache_ratio(struct zone_struct * zone)
+{
+	if (!zone->size)
+		return 0;
+	return 10 * zone->active_cache_pages / (zone->active_cache_pages +
+			zone->active_anon_pages + 1);
+}
+
+/*
+ * If the active_cache list is more than 20% of all active pages,
+ * we do extra heavy reclaim from this list and less reclaiming of
+ * the active_anon pages.
+ * These arrays are indexed by cache_ratio(), ie 0%, 10%, 20% ... 100%
+ */
+static int  active_anon_work[11] = {32, 32, 12,  4,  2,  1,  1,  1,  1,  1,  1};
+static int active_cache_work[11] = {32, 32, 52, 60, 62, 63, 63, 63, 63, 63, 63};
+
+/**
+ * refill_inactive_zone - scan the active list and find pages to deactivate
+ * @priority: how much are we allowed to scan
+ *
+ * This function will scan a portion of the active list of a zone to find
+ * unused pages, those pages will then be moved to the inactive list.
+ */
+int refill_inactive_zone(struct zone_struct * zone, int priority, int target)
+{
+	int maxscan = (zone->active_anon_pages + zone->active_cache_pages) >> priority;
+	struct list_head * page_lru;
+	struct page * page;
+	int over_rsslimit;
+	int progress = 0;
+	int ratio;
+
+	/* Take the lock while messing with the list... */
+	lru_lock(zone);
+	if (target < BATCH_WORK_AMOUNT)
+		target = BATCH_WORK_AMOUNT;
+
+	ratio = cache_ratio(zone);
+
+	while (maxscan-- && zone->active_anon_pages + zone->active_cache_pages > 0 && target > 0) {
+		int anon_work, cache_work;
+		anon_work = active_anon_work[ratio];
+		cache_work = active_cache_work[ratio];
+
+		while (anon_work-- >= 0 && zone->active_anon_pages) {
+			if (list_empty(&zone->active_anon_list[0])) {
+				kachunk_anon(zone);
 				continue;
 			}
-		}
 
+			page_lru = zone->active_anon_list[0].prev;
+			page = list_entry(page_lru, struct page, lru);
 
-		/*
-		 * If the page is really freeable now, move it to the
-		 * inactive_clean list.
-		 *
-		 * We re-test everything since the page could have been
-		 * used by somebody else while we waited on IO above.
-		 * This test is not safe from races, but only the one
-		 * in reclaim_page() needs to be.
-		 */
-		pte_chain_lock(page);
-		if (page->mapping && !PageDirty(page) && !page->pte_chain &&
-				page_count(page) == 1) {
-			del_page_from_inactive_dirty_list(page);
-			add_page_to_inactive_clean_list(page);
+			/* Wrong page on list?! (list corruption, should not happen) */
+			BUG_ON(unlikely(!PageActiveAnon(page)));
+		
+			/* Needed to follow page->mapping */
+			if (TryLockPage(page)) {
+				/* The page is already locked. This for sure means
+				 * someone is doing stuff with it which makes it
+				 * active by definition ;)
+				 */
+				del_page_from_active_anon_list(page);
+				add_page_to_active_anon_list(page, INITIAL_AGE);
+				continue;
+			}
+
+			/*
+			 * Do aging on the pages.
+			 */
+			pte_chain_lock(page);
+			if (page_referenced(page, &over_rsslimit) && !over_rsslimit) {
+				pte_chain_unlock(page);
+				age_page_up_nolock(page, 0);
+				UnlockPage(page);
+				continue;
+			}
 			pte_chain_unlock(page);
+
+			deactivate_page_nolock(page);
+			target--;
+			progress++;
 			UnlockPage(page);
-			cleaned_pages++;
-		} else {
+		}
+
+		while (cache_work-- >= 0 && zone->active_cache_pages) {
+			if (list_empty(&zone->active_cache_list[0])) {
+				kachunk_cache(zone);
+				continue;
+			}
+
+			page_lru = zone->active_cache_list[0].prev;
+			page = list_entry(page_lru, struct page, lru);
+
+			/* Wrong page on list?! (list corruption, should not happen) */
+			BUG_ON(unlikely(!PageActiveCache(page)));
+		
+			/* Needed to follow page->mapping */
+			if (TryLockPage(page)) {
+				/* The page is already locked. This for sure means
+				 * someone is doing stuff with it which makes it
+				 * active by definition ;)
+				 */
+				del_page_from_active_cache_list(page);
+				add_page_to_active_cache_list(page, INITIAL_AGE);
+				continue;
+			}
+
 			/*
-			 * OK, we don't know what to do with the page.
-			 * It's no use keeping it here, so we move it to
-			 * the active list.
+			 * Do aging on the pages.
 			 */
-page_active:
-			del_page_from_inactive_dirty_list(page);
-			add_page_to_active_list(page);
+			pte_chain_lock(page);
+			if (page_referenced(page, &over_rsslimit) && !over_rsslimit) {
+				pte_chain_unlock(page);
+				age_page_up_nolock(page, 0);
+				UnlockPage(page);
+				continue;
+			}
 			pte_chain_unlock(page);
+
+			deactivate_page_nolock(page);
+			target--;
+			progress++;
 			UnlockPage(page);
 		}
 	}
-	spin_unlock(&pagemap_lru_lock);
+	lru_unlock(zone);
 
-	/* Return the number of pages moved to the inactive_clean list. */
-	return cleaned_pages + iopages;
+	return progress;
 }
 
-/**
- * page_launder - clean dirty inactive pages, move to inactive_clean list
- * @gfp_mask: what operations we are allowed to do
- *
- * This function iterates over all zones and calls page_launder_zone(),
- * balancing still needs to be added...
- */
-int page_launder(int gfp_mask)
+static int need_active_anon_scan(struct zone_struct * zone)
 {
-	struct zone_struct * zone;
-	int freed = 0;
+	int low = 0, high = 0;
+	int k;
+	for (k=0; k < MAX_AGE/2; k++)
+		low += zone->active_anon_count[k];
 
-	/* Global balancing while we have a global shortage. */
-	if (free_high(ALL_ZONES) >= 0)
-		for_each_zone(zone)
-			if (free_plenty(zone) >= 0)
-				freed += page_launder_zone(zone, gfp_mask, 0);
-	
-	/* Clean up the remaining zones with a serious shortage, if any. */
-	for_each_zone(zone)
-		if (free_low(zone) >= 0) {
-			int fullflush = free_min(zone) > 0;
-			freed += page_launder_zone(zone, gfp_mask, fullflush);
-		}
+	for (k=MAX_AGE/2; k <= MAX_AGE; k++)
+		high += zone->active_anon_count[k];
+
+	if (high<low)
+		return 1;
+	return 0;
+}
+
+static int need_active_cache_scan(struct zone_struct * zone)
+{
+	int low = 0, high = 0;
+	int k;
+	for (k=0; k < MAX_AGE/2; k++)
+		low += zone->active_cache_count[k];
+
+	for (k=MAX_AGE/2; k <= MAX_AGE; k++)
+		high += zone->active_cache_count[k];
 
-	return freed;
+	if (high<low)
+		return 1;
+	return 0;
 }
 
-/**
- * refill_inactive_zone - scan the active list and find pages to deactivate
- * @priority: how much are we allowed to scan
- *
- * This function will scan a portion of the active list of a zone to find
- * unused pages, those pages will then be moved to the inactive list.
+static int scan_active_list(struct zone_struct * zone, int age, int anon)
+{
+	struct list_head * list, *page_lru , *next;
+	struct page * page;
+	int over_rsslimit;
+
+	if (anon)
+		list = &zone->active_anon_list[age];
+	else
+		list = &zone->active_cache_list[age];
+
+	/* Take the lock while messing with the list... */
+	lru_lock(zone);
+	list_for_each_safe(page_lru, next, list) {
+		page = list_entry(page_lru, struct page, lru);
+		pte_chain_lock(page);
+		if (page_referenced(page, &over_rsslimit) && !over_rsslimit)
+			age_page_up_nolock(page, age);
+		pte_chain_unlock(page);
+	}
+	lru_unlock(zone);
+	return 0;
+}
+
+/*
+ * Move max_work pages to the inactive clean list as long as there is a need
+ * for this. If gfp_mask allows it, sleep for IO to finish.
  */
-int refill_inactive_zone(struct zone_struct * zone, int priority)
+int rebalance_laundry_zone(struct zone_struct * zone, int max_work, unsigned int gfp_mask)
 {
-	int maxscan = zone->active_pages >> priority;
-	int nr_deactivated = 0, over_rsslimit;
-	int target = inactive_high(zone);
 	struct list_head * page_lru;
+	int max_loop;
+	int work_done = 0;
 	struct page * page;
 
+	max_loop = max_work;
+	if (max_loop < BATCH_WORK_AMOUNT)
+		max_loop = BATCH_WORK_AMOUNT;
 	/* Take the lock while messing with the list... */
-	spin_lock(&pagemap_lru_lock);
-	while (maxscan-- && !list_empty(&zone->active_list)) {
-		page_lru = zone->active_list.prev;
+	lru_lock(zone);
+	while (max_loop-- && !list_empty(&zone->inactive_laundry_list)) {
+		page_lru = zone->inactive_laundry_list.prev;
 		page = list_entry(page_lru, struct page, lru);
 
 		/* Wrong page on list?! (list corruption, should not happen) */
-		if (unlikely(!PageActive(page))) {
-			printk("VM: refill_inactive, wrong page on list.\n");
-			list_del(page_lru);
-			nr_active_pages--;
-			continue;
-		}
-		
-		/* Needed to follow page->mapping */
+		BUG_ON(unlikely(!PageInactiveLaundry(page)));
+
+		/* TryLock to see if the page IO is done */
 		if (TryLockPage(page)) {
-			list_del(page_lru);
-			list_add(page_lru, &zone->active_list);
-			continue;
+			/*
+			 * Page is locked (IO in progress?). If we can sleep,
+			 * wait for it to finish, except when we've already
+			 * done enough work.
+			 */
+			if ((gfp_mask & __GFP_WAIT) && (work_done < max_work)) {
+				int timed_out;
+				
+				page_cache_get(page);
+				lru_unlock(zone);
+				run_task_queue(&tq_disk);
+				timed_out = wait_on_page_timeout(page, 5 * HZ);
+				lru_lock(zone);
+				page_cache_release(page);
+				/*
+				 * If we timed out and the page has been in
+				 * flight for over 30 seconds, this might not
+				 * be the best page to wait on; move it to
+				 * the head of the dirty list.
+				 */
+				if (timed_out & PageInactiveLaundry(page)) {
+					unsigned char now;
+					now = (jiffies/HZ)&255;
+					if (now - page->age > 30) {
+						del_page_from_inactive_laundry_list(page);
+						add_page_to_inactive_dirty_list(page);
+					}
+					continue;
+				}
+				/* We didn't make any progress for our caller,
+				 * but we are actively avoiding a livelock
+				 * so undo the decrement and wait on this page
+				 * some more, until IO finishes or we timeout.
+				 */
+				max_loop++;
+				continue;
+			} else
+				/* No dice, we can't wait for IO */
+				break;
 		}
+		UnlockPage(page);
 
 		/*
-		 * If the object the page is in is not in use we don't
-		 * bother with page aging.  If the page is touched again
-		 * while on the inactive_clean list it'll be reactivated.
-		 * From here until the end of the current iteration
-		 * both PG_locked and the pte_chain_lock are held.
+		 * If we get here either the IO on the page is done or
+		 * IO never happened because it was clean. Either way
+		 * move it to the inactive clean list.
 		 */
-		pte_chain_lock(page);
-		if (!page_mapping_inuse(page)) {
-			pte_chain_unlock(page);
-			UnlockPage(page);
-			drop_page(page);
-			continue;
-		}
+
+		/* FIXME: check if the page is still clean or is accessed ? */
+
+		del_page_from_inactive_laundry_list(page);
+		add_page_to_inactive_clean_list(page);
+		work_done++;
 
 		/*
-		 * Do aging on the pages.
+		 * If we've done the minimal batch of work and there's
+		 * no longer a need to rebalance, abort now.
 		 */
-		if (page_referenced(page, &over_rsslimit)) {
-			age_page_up(page);
-		} else {
-			age_page_down(page);
-		}
+		if ((work_done > BATCH_WORK_AMOUNT) && (!need_rebalance_laundry(zone)))
+			break;
+	}
 
-		/* 
-		 * If the page age is 'hot' and the process using the
-		 * page doesn't exceed its RSS limit we keep the page.
-		 * Otherwise we move it to the inactive_dirty list.
+	lru_unlock(zone);
+	return work_done;
+}
+
+/*
+ * Move max_work pages from the dirty list as long as there is a need.
+ * Start IO if the gfp_mask allows it.
+ */
+int rebalance_dirty_zone(struct zone_struct * zone, int max_work, unsigned int gfp_mask)
+{
+	struct list_head * page_lru;
+	int max_loop;
+	int work_done = 0;
+	struct page * page;
+
+	max_loop = max_work;
+	if (max_loop < BATCH_WORK_AMOUNT)
+		max_loop = BATCH_WORK_AMOUNT;
+	/* Take the lock while messing with the list... */
+	lru_lock(zone);
+	while (max_loop-- && !list_empty(&zone->inactive_dirty_list)) {
+		page_lru = zone->inactive_dirty_list.prev;
+		page = list_entry(page_lru, struct page, lru);
+
+		/* Wrong page on list?! (list corruption, should not happen) */
+		BUG_ON(unlikely(!PageInactiveDirty(page)));
+
+		/*
+		 * Note: launder_page() sleeps so we can't safely look at
+		 * the page after this point!
+		 *
+		 * If we fail (only happens if we can't do IO) we just try
+		 * again on another page; launder_page makes sure we won't
+		 * see the same page over and over again.
 		 */
-		if (page->age && !over_rsslimit) {
-			list_del(page_lru);
-			list_add(page_lru, &zone->active_list);
-		} else {
-			deactivate_page_nolock(page);
-			if (++nr_deactivated > target) {
-				pte_chain_unlock(page);
-				UnlockPage(page);
-				goto done;
-			}
-		}
-		pte_chain_unlock(page);
-		UnlockPage(page);
+		if (!launder_page(zone, gfp_mask, page))
+			continue;
 
-		/* Low latency reschedule point */
-		if (current->need_resched) {
-			spin_unlock(&pagemap_lru_lock);
-			schedule();
-			spin_lock(&pagemap_lru_lock);
-		}
+		work_done++;
+
+		/*
+		 * If we've done the minimal batch of work and there's
+		 * no longer any need to rebalance, abort now.
+		 */
+		if ((work_done > BATCH_WORK_AMOUNT) && (!need_rebalance_dirty(zone)))
+			break;
 	}
+	lru_unlock(zone);
+
+	return work_done;
+}
+
+/* goal percentage sets the goal of the laundry+clean+free of the total zone size */
+int rebalance_inactive_zone(struct zone_struct * zone, int max_work, unsigned int gfp_mask, int goal_percentage)
+{
+	int ret = 0;
+	/* first deactivate memory */
+	if (((zone->inactive_laundry_pages + zone->inactive_clean_pages + zone->free_pages)*100 < zone->size * goal_percentage) &&
+			(inactive_high(zone) > 0))
+		refill_inactive_zone(zone, 0, max_work + BATCH_WORK_AMOUNT);
+
+	if (need_rebalance_dirty(zone))
+		ret += rebalance_dirty_zone(zone, max_work, gfp_mask);
+	if (need_rebalance_laundry(zone))
+		ret += rebalance_laundry_zone(zone, max_work, gfp_mask);
 
-done:
-	spin_unlock(&pagemap_lru_lock);
+	/* These pages will become freeable, let the OOM detection know */
+	ret += zone->inactive_laundry_pages;
 
-	return nr_deactivated;
+	return ret;
 }
 
-/**
- * refill_inactive - checks all zones and refills the inactive list as needed
- *
- * This function tries to balance page eviction from all zones by aging
- * the pages from each zone in the same ratio until the global inactive
- * shortage is resolved. After that it does one last "clean-up" scan to
- * fix up local inactive shortages.
- */
-int refill_inactive(void)
+int rebalance_inactive(unsigned int gfp_mask, int percentage)
 {
-	int maxtry = 1 << DEF_PRIORITY;
-	zone_t * zone;
+	struct zone_struct * zone;
+	int max_work;
 	int ret = 0;
 
-	/* Global balancing while we have a global shortage. */
-	while (maxtry-- && inactive_low(ALL_ZONES) >= 0) {
-		for_each_zone(zone) {
-			if (inactive_high(zone) >= 0)
-				ret += refill_inactive_zone(zone, DEF_PRIORITY);
-		}
-	}
+	max_work = 4 * BATCH_WORK_AMOUNT;
+	/* If we're in deeper trouble, do more work */
+	if (percentage >= 50)
+		max_work = 8 * BATCH_WORK_AMOUNT;
 
-	/* Local balancing for zones which really need it. */
-	for_each_zone(zone) {
-		if (inactive_min(zone) >= 0)
-			ret += refill_inactive_zone(zone, 0);
-	}
+	for_each_zone(zone)
+		ret += rebalance_inactive_zone(zone, max_work, gfp_mask, percentage);
+		/* 4 * BATCH_WORK_AMOUNT needs tuning */
 
 	return ret;
 }
@@ -636,7 +819,9 @@
 
 	for_each_zone(zone)
 		if (inactive_high(zone) > 0)
-			refill_inactive_zone(zone, priority);
+			refill_inactive_zone(zone, priority, BATCH_WORK_AMOUNT);
+	for_each_zone(zone)
+			rebalance_dirty_zone(zone, BATCH_WORK_AMOUNT, GFP_KSWAPD);
 }
 
 /*
@@ -655,18 +840,13 @@
 	 * Eat memory from filesystem page cache, buffer cache,
 	 * dentry, inode and filesystem quota caches.
 	 */
-	ret += page_launder(gfp_mask);
+	ret += rebalance_inactive(gfp_mask, 100);
 	ret += shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
 	ret += shrink_icache_memory(1, gfp_mask);
 #ifdef CONFIG_QUOTA
 	ret += shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif
 
-	/*
-	 * Move pages from the active list to the inactive list.
-	 */
-	refill_inactive();
-
 	/* 	
 	 * Reclaim unused slab cache memory.
 	 */
@@ -682,12 +862,54 @@
 	 * Hmm.. Cache shrink failed - time to kill something?
 	 * Mhwahahhaha! This is the part I really like. Giggle.
 	 */
-	if (ret < free_low(ANY_ZONE))
+	if (ret < free_low(ANY_ZONE) && (gfp_mask&__GFP_WAIT))
 		out_of_memory();
 
 	return ret;
 }
 
+/*
+ * Worker function for kswapd and try_to_free_pages, we get
+ * called whenever there is a shortage of free/inactive_clean
+ * pages.
+ *
+ * This function will also move pages to the inactive list,
+ * if needed.
+ */
+static int do_try_to_free_pages_kswapd(unsigned int gfp_mask)
+{
+	int ret = 0;
+	struct zone_struct * zone;
+
+	ret += shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
+	ret += shrink_icache_memory(DEF_PRIORITY, gfp_mask);
+#ifdef CONFIG_QUOTA
+	ret += shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
+#endif
+
+	/*
+	 * Eat memory from filesystem page cache, buffer cache,
+	 * dentry, inode and filesystem quota caches.
+	 */
+	rebalance_inactive(gfp_mask, 5);
+
+	for_each_zone(zone)
+		while (need_rebalance_dirty(zone))
+			rebalance_dirty_zone(zone,  16 * BATCH_WORK_AMOUNT,  gfp_mask);
+
+	for_each_zone(zone)
+		if (free_high(zone)>0)
+			rebalance_laundry_zone(zone, BATCH_WORK_AMOUNT, 0);
+
+	refill_freelist();
+
+	/* Start IO when needed. */
+	if (free_plenty(ALL_ZONES) > 0 || free_low(ANY_ZONE) > 0)
+		run_task_queue(&tq_disk);
+
+	return ret;
+}
+
 /**
  * refill_freelist - move inactive_clean pages to free list if needed
  *
@@ -764,7 +986,7 @@
 		 * zone is very short on free pages.
 		 */
 		if (free_high(ALL_ZONES) >= 0 || free_low(ANY_ZONE) > 0)
-			do_try_to_free_pages(GFP_KSWAPD);
+			do_try_to_free_pages_kswapd(GFP_KSWAPD);
 
 		refill_freelist();
 
@@ -846,7 +1068,7 @@
 	/* OK, the VM is very loaded. Sleep instead of using all CPU. */
 	kswapd_overloaded = 1;
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ / 4);
+	schedule_timeout(HZ / 40);
 	kswapd_overloaded = 0;
 	return;
 }
@@ -888,6 +1110,7 @@
 void rss_free_pages(unsigned int gfp_mask)
 {
 	long pause = 0;
+	struct zone_struct * zone;
 
 	if (current->flags & PF_MEMALLOC)
 		return;
@@ -895,7 +1118,10 @@
 	current->flags |= PF_MEMALLOC;
 
 	do {
-		page_launder(gfp_mask);
+		rebalance_inactive(gfp_mask, 100);
+		for_each_zone(zone)
+			if (free_plenty(zone) >= 0)
+				rebalance_laundry_zone(zone, BATCH_WORK_AMOUNT, 0);
 
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(pause);
@@ -907,11 +1133,77 @@
 	return;
 }
 
+/*
+ * The background page scanning daemon, started as a kernel thread
+ * from the init process. 
+ *
+ * This is the part that background scans the active list to find
+ * pages that are referenced and increases their age score.
+ * It is important that this scan rate is not proportional to vm pressure
+ * per se otherwise cpu usage becomes unbounded. On the other hand, if there's
+ * no VM pressure at all it shouldn't age stuff either otherwise everything
+ * ends up at the maximum age. 
+ */
+#define MAX_AGING_INTERVAL 5*HZ
+#define MIN_AGING_INTERVAL HZ/2
+int kscand(void *unused)
+{
+	struct task_struct *tsk = current;
+	struct zone_struct * zone;
+	unsigned long pause = MAX_AGING_INTERVAL;
+	int total_needscan = 0;
+	int age_faster = 0;
+	int num_zones = 0;
+	int age;
+
+	daemonize();
+	strcpy(tsk->comm, "kscand");
+	sigfillset(&tsk->blocked);
+	
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(pause);	
+		for_each_zone(zone) {
+			if (need_active_anon_scan(zone)) {
+				for (age = 0; age < MAX_AGE; age++)  {
+					scan_active_list(zone, age, 1);
+					if (current->need_resched)
+						schedule();
+				}
+			}
+
+			if (need_active_cache_scan(zone)) {
+				for (age = 0; age < MAX_AGE; age++)  {
+					scan_active_list(zone, age, 0);
+					if (current->need_resched)
+						schedule();
+				}
+			}
+
+			/* Check if we've been aging quickly enough */
+			if (zone->need_scan >= 2)
+				age_faster++;
+			total_needscan += zone->need_scan;
+			zone->need_scan = 0;
+			num_zones++;
+		}
+		if (age_faster)
+			pause = max(pause / 2, MIN_AGING_INTERVAL);
+		else if (total_needscan < num_zones)
+			pause = min(pause + pause / 2, MAX_AGING_INTERVAL);
+
+		total_needscan = 0;
+		num_zones = 0;
+	}
+}
+
+
 static int __init kswapd_init(void)
 {
 	printk("Starting kswapd\n");
 	swap_setup();
 	kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+	kernel_thread(kscand, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	return 0;
 }
 


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
