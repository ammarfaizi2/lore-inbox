Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbRLWWba>; Sun, 23 Dec 2001 17:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282489AbRLWWbQ>; Sun, 23 Dec 2001 17:31:16 -0500
Received: from [217.9.226.246] ([217.9.226.246]:4992 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S282213AbRLWWbD>; Sun, 23 Dec 2001 17:31:03 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Scalable page cache - take two
From: Momchil Velikov <velco@fadata.bg>
Date: 24 Dec 2001 00:15:33 +0200
Message-ID: <87bsgp7fcq.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

This is the second mutation of the scalable page cache patch.  It:

        - removes the global page cache hash table and the associated lock

	- implements the page cache as a per mapping radix tree. This
          increases the size of ``struct inode'' by 8 bytes (in 32bit
          ports).  The branch factor is a compile time constant
          ``RAD_MAP_SHIFT'' (currently 7, 128 pointers)

        - decreases the size of ``struct page'' by removing
          ``next_hash'' and ``pprev_hash' fields as they are no longer
          needed for the page cache.  NOTE that this curently breaks
          sparc64 and arm ports. The sparc64 port is trivialy fixable.

The patch is stable on UP (survives make -j6) and does not have
noticeable performance impact (at least for the kernel compile
benchmark) in either direction.

Regards,
-velco

diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Sun Dec 23 23:58:21 2001
+++ b/drivers/block/rd.c	Sun Dec 23 23:58:21 2001
@@ -243,7 +243,6 @@
 
 	do {
 		int count;
-		struct page ** hash;
 		struct page * page;
 		char * src, * dst;
 		int unlock = 0;
@@ -253,8 +252,7 @@
 			count = size;
 		size -= count;
 
-		hash = page_hash(mapping, index);
-		page = __find_get_page(mapping, index, hash);
+		page = __find_get_page(mapping, index);
 		if (!page) {
 			page = grab_cache_page(mapping, index);
 			err = -ENOMEM;
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sun Dec 23 23:58:21 2001
+++ b/fs/inode.c	Sun Dec 23 23:58:21 2001
@@ -110,6 +110,8 @@
 		sema_init(&inode->i_sem, 1);
 		sema_init(&inode->i_zombie, 1);
 		spin_lock_init(&inode->i_data.i_shared_lock);
+		inode->i_data.root = NULL;
+		inode->i_data.height = 0;
 	}
 }
 
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun Dec 23 23:58:21 2001
+++ b/include/linux/fs.h	Sun Dec 23 23:58:21 2001
@@ -403,6 +403,8 @@
 	struct vm_area_struct	*i_mmap;	/* list of private mappings */
 	struct vm_area_struct	*i_mmap_shared; /* list of shared mappings */
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
+	struct rat_node		*root;
+	unsigned int		height;
 	int			gfp_mask;	/* how to allocate the pages */
 };
 
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Sun Dec 23 23:58:21 2001
+++ b/include/linux/mm.h	Sun Dec 23 23:58:21 2001
@@ -152,15 +152,12 @@
 	struct list_head list;		/* ->mapping has some page lists. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
-	struct page *next_hash;		/* Next page sharing our hash bucket in
-					   the pagecache hash table. */
 	atomic_t count;			/* Usage count, see below. */
 	unsigned long flags;		/* atomic flags, some possibly
 					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by pagemap_lru_lock !! */
 	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
-	struct page **pprev_hash;	/* Complement to *next_hash. */
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
@@ -228,9 +225,8 @@
  * using the page->list list_head. These fields are also used for
  * freelist managemet (when page->count==0).
  *
- * There is also a hash table mapping (mapping,index) to the page
- * in memory if present. The lists for this hash table use the fields
- * page->next_hash and page->pprev_hash.
+ * There is also a per-mapping radix tree mapping index to the page
+ * in memory if present. The tree is rooted at mapping->root.  
  *
  * All process pages can do I/O:
  * - inode pages may need to be read from disk,
@@ -507,6 +503,24 @@
 		return 1;
 	else
 		return 0;
+}
+
+static inline void add_page_to_inode_queue(struct address_space *mapping, struct page * page)
+{
+	struct list_head *head = &mapping->clean_pages;
+
+	mapping->nrpages++;
+	list_add(&page->list, head);
+	page->mapping = mapping;
+}
+
+static inline void remove_page_from_inode_queue(struct page * page)
+{
+	struct address_space * mapping = page->mapping;
+
+	mapping->nrpages--;
+	list_del(&page->list);
+	page->mapping = NULL;
 }
 
 struct zone_t;
diff -Nru a/include/linux/pagemap.h b/include/linux/pagemap.h
--- a/include/linux/pagemap.h	Sun Dec 23 23:58:21 2001
+++ b/include/linux/pagemap.h	Sun Dec 23 23:58:21 2001
@@ -41,53 +41,28 @@
  */
 #define page_cache_entry(x)	virt_to_page(x)
 
-extern unsigned int page_hash_bits;
-#define PAGE_HASH_BITS (page_hash_bits)
-#define PAGE_HASH_SIZE (1 << PAGE_HASH_BITS)
+extern void page_cache_init(void);
 
-extern atomic_t page_cache_size; /* # of pages currently in the hash table */
-extern struct page **page_hash_table;
-
-extern void page_cache_init(unsigned long);
-
-/*
- * We use a power-of-two hash table to avoid a modulus,
- * and get a reasonable hash by knowing roughly how the
- * inode pointer and indexes are distributed (ie, we
- * roughly know which bits are "significant")
- *
- * For the time being it will work for struct address_space too (most of
- * them sitting inside the inodes). We might want to change it later.
- */
-static inline unsigned long _page_hashfn(struct address_space * mapping, unsigned long index)
-{
-#define i (((unsigned long) mapping)/(sizeof(struct inode) & ~ (sizeof(struct inode) - 1)))
-#define s(x) ((x)+((x)>>PAGE_HASH_BITS))
-	return s(i+index) & (PAGE_HASH_SIZE-1);
-#undef i
-#undef s
-}
-
-#define page_hash(mapping,index) (page_hash_table+_page_hashfn(mapping,index))
+extern atomic_t page_cache_size; /* # of pages currently in the page cache */
 
 extern struct page * __find_get_page(struct address_space *mapping,
-				unsigned long index, struct page **hash);
+				     unsigned long index);
 #define find_get_page(mapping, index) \
-	__find_get_page(mapping, index, page_hash(mapping, index))
+	__find_get_page(mapping, index)
 extern struct page * __find_lock_page (struct address_space * mapping,
-				unsigned long index, struct page **hash);
+				       unsigned long index);
 extern struct page * find_or_create_page(struct address_space *mapping,
 				unsigned long index, unsigned int gfp_mask);
 
 extern void FASTCALL(lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 #define find_lock_page(mapping, index) \
-	__find_lock_page(mapping, index, page_hash(mapping, index))
+	__find_lock_page(mapping, index)
 extern struct page *find_trylock_page(struct address_space *, unsigned long);
 
-extern void add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
-extern void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
-extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index, struct page **hash);
+extern int add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
+extern int add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
+extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index);
 
 extern void ___wait_on_page(struct page *);
 
diff -Nru a/include/linux/rat.h b/include/linux/rat.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/rat.h	Sun Dec 23 23:58:21 2001
@@ -0,0 +1,81 @@
+/* Radix tree declarations.  
+ *
+ * Copyright (C) 2001 Momchil Velikov
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2, or (at
+ * your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __linux_rat_h__
+#define __linix_rat_h__
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+
+#define RAT_MAP_SHIFT 7
+#define RAT_MAP_SIZE (1UL << RAT_MAP_SHIFT)
+#define RAT_MAP_MASK (RAT_MAP_SIZE - 1)
+#define RAT_INDEX_BITS (8 /* CHAR_BIT */ * sizeof (unsigned long))
+#define RAT_HEIGHT_MAX  (((RAT_INDEX_BITS + RAT_MAP_SHIFT - 1) & ~(RAT_MAP_SHIFT - 1)) \
+			 / RAT_MAP_SHIFT)
+#define RAT_SLOT_RESERVED ((struct page *)~0UL)
+
+struct address_space;
+struct page;
+
+/* Radix tree node.  */
+struct rat_node
+{
+	unsigned int count;
+	void *slots [RAT_MAP_SIZE];
+};
+typedef struct rat_node rat_node_t;
+
+/* Radix tree node cache. */
+extern kmem_cache_t *rat_node_cachep;
+
+/* Return the maximum key, which can be store into a radix tree with
+   height HEIGHT.  */
+static inline unsigned long
+rat_index_max (unsigned int height)
+{
+	unsigned int tmp = height * RAT_MAP_SHIFT;
+	unsigned long index = (~0UL >> (RAT_INDEX_BITS - tmp - 1)) >> 1;
+	if (tmp >= RAT_INDEX_BITS)
+		index = ~0UL;
+	return index;
+}
+
+/* Reserve a slot in a radix tree for the index INDEX.  */
+extern int rat_reserve (struct address_space *mapping, unsigned long index, struct page ***pslot);
+
+/* Insert a page into the radix tree.  */
+static inline int
+rat_insert (struct address_space *mapping, unsigned long index, struct page *page)
+{
+	struct page **slot;
+	int err;
+
+	err = rat_reserve (mapping, index, &slot);
+	if (!err)
+		*slot = page;
+	return err;
+}
+
+/* Lookup a page in the radix tree.  */
+extern struct page *rat_lookup (struct address_space *mapping, unsigned long index);
+
+/* Remove a page from the radix tree.  */
+extern int rat_delete (struct address_space *mapping, unsigned long index);
+
+#endif /* __linux_rat_h__ */
diff -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Sun Dec 23 23:58:21 2001
+++ b/include/linux/swap.h	Sun Dec 23 23:58:21 2001
@@ -97,7 +97,7 @@
 struct task_struct;
 struct vm_area_struct;
 struct sysinfo;
-
+struct address_space;
 struct zone_t;
 
 /* linux/mm/swap.c */
@@ -127,6 +127,8 @@
 extern int add_to_swap_cache(struct page *, swp_entry_t);
 extern void __delete_from_swap_cache(struct page *page);
 extern void delete_from_swap_cache(struct page *page);
+extern int move_to_swap_cache (struct page *page, swp_entry_t entry);
+extern int move_from_swap_cache (struct page *page, unsigned long index, struct address_space *mapping);
 extern void free_page_and_swap_cache(struct page *page);
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t);
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Sun Dec 23 23:58:21 2001
+++ b/init/main.c	Sun Dec 23 23:58:21 2001
@@ -599,7 +599,7 @@
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);
-	page_cache_init(mempages);
+	page_cache_init ();
 #if defined(CONFIG_ARCH_S390)
 	ccwcache_init();
 #endif
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Sun Dec 23 23:58:21 2001
+++ b/kernel/ksyms.c	Sun Dec 23 23:58:21 2001
@@ -216,8 +216,6 @@
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_ro_fops);
 EXPORT_SYMBOL(generic_buffer_fdatasync);
-EXPORT_SYMBOL(page_hash_bits);
-EXPORT_SYMBOL(page_hash_table);
 EXPORT_SYMBOL(file_lock_list);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);
diff -Nru a/mm/Makefile b/mm/Makefile
--- a/mm/Makefile	Sun Dec 23 23:58:21 2001
+++ b/mm/Makefile	Sun Dec 23 23:58:21 2001
@@ -14,7 +14,7 @@
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
-	    shmem.o
+	    shmem.o rat.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Sun Dec 23 23:58:21 2001
+++ b/mm/filemap.c	Sun Dec 23 23:58:21 2001
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/iobuf.h>
 #include <linux/compiler.h>
+#include <linux/rat.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -44,75 +45,26 @@
  */
 
 atomic_t page_cache_size = ATOMIC_INIT(0);
-unsigned int page_hash_bits;
-struct page **page_hash_table;
 
 int vm_max_readahead = 31;
 int vm_min_readahead = 3;
 EXPORT_SYMBOL(vm_max_readahead);
 EXPORT_SYMBOL(vm_min_readahead);
 
-
-spinlock_t pagecache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 /*
  * NOTE: to avoid deadlocking you must never acquire the pagemap_lru_lock 
- *	with the pagecache_lock held.
+ *	with the mapping lock held.
  *
  * Ordering:
  *	swap_lock ->
  *		pagemap_lru_lock ->
- *			pagecache_lock
+ *			mapping lock
  */
 spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
 
-static void FASTCALL(add_page_to_hash_queue(struct page * page, struct page **p));
-static void add_page_to_hash_queue(struct page * page, struct page **p)
-{
-	struct page *next = *p;
-
-	*p = page;
-	page->next_hash = next;
-	page->pprev_hash = p;
-	if (next)
-		next->pprev_hash = &page->next_hash;
-	if (page->buffers)
-		PAGE_BUG(page);
-	atomic_inc(&page_cache_size);
-}
-
-static inline void add_page_to_inode_queue(struct address_space *mapping, struct page * page)
-{
-	struct list_head *head = &mapping->clean_pages;
-
-	mapping->nrpages++;
-	list_add(&page->list, head);
-	page->mapping = mapping;
-}
-
-static inline void remove_page_from_inode_queue(struct page * page)
-{
-	struct address_space * mapping = page->mapping;
-
-	mapping->nrpages--;
-	list_del(&page->list);
-	page->mapping = NULL;
-}
-
-static inline void remove_page_from_hash_queue(struct page * page)
-{
-	struct page *next = page->next_hash;
-	struct page **pprev = page->pprev_hash;
-
-	if (next)
-		next->pprev_hash = pprev;
-	*pprev = next;
-	page->pprev_hash = NULL;
-	atomic_dec(&page_cache_size);
-}
-
 /*
  * Remove a page from the page cache and free it. Caller has to make
  * sure the page is locked and that nobody else uses it - or that usage
@@ -121,18 +73,20 @@
 void __remove_inode_page(struct page *page)
 {
 	if (PageDirty(page)) BUG();
+	rat_delete (page->mapping, page->index);
 	remove_page_from_inode_queue(page);
-	remove_page_from_hash_queue(page);
+	atomic_dec(&page_cache_size);
 }
 
 void remove_inode_page(struct page *page)
 {
+	struct address_space *mapping = page->mapping;
 	if (!PageLocked(page))
 		PAGE_BUG(page);
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	__remove_inode_page(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 static inline int sync_page(struct page *page)
@@ -153,10 +107,10 @@
 		struct address_space *mapping = page->mapping;
 
 		if (mapping) {
-			spin_lock(&pagecache_lock);
+			spin_lock(&mapping->i_shared_lock);
 			list_del(&page->list);
 			list_add(&page->list, &mapping->dirty_pages);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 
 			if (mapping->host)
 				mark_inode_dirty_pages(mapping->host);
@@ -176,11 +130,12 @@
 {
 	struct list_head *head, *curr;
 	struct page * page;
+	struct address_space *mapping = inode->i_mapping;
 
-	head = &inode->i_mapping->clean_pages;
+	head = &mapping->clean_pages;
 
 	spin_lock(&pagemap_lru_lock);
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	curr = head->next;
 
 	while (curr != head) {
@@ -211,7 +166,7 @@
 		continue;
 	}
 
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	spin_unlock(&pagemap_lru_lock);
 }
 
@@ -250,8 +205,9 @@
 	page_cache_release(page);
 }
 
-static int FASTCALL(truncate_list_pages(struct list_head *, unsigned long, unsigned *));
-static int truncate_list_pages(struct list_head *head, unsigned long start, unsigned *partial)
+static int FASTCALL(truncate_list_pages(struct address_space *, struct list_head *, unsigned long, unsigned *));
+static int truncate_list_pages(struct address_space *mapping,
+	struct list_head *head, unsigned long start, unsigned *partial)
 {
 	struct list_head *curr;
 	struct page * page;
@@ -280,7 +236,7 @@
 				/* Restart on this page */
 				list_add(head, curr);
 
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			unlocked = 1;
 
  			if (!failed) {
@@ -301,7 +257,7 @@
 				schedule();
 			}
 
-			spin_lock(&pagecache_lock);
+			spin_lock(&mapping->i_shared_lock);
 			goto restart;
 		}
 		curr = curr->prev;
@@ -325,24 +281,25 @@
 	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
 	int unlocked;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	do {
-		unlocked = truncate_list_pages(&mapping->clean_pages, start, &partial);
-		unlocked |= truncate_list_pages(&mapping->dirty_pages, start, &partial);
-		unlocked |= truncate_list_pages(&mapping->locked_pages, start, &partial);
+		unlocked = truncate_list_pages(mapping, &mapping->clean_pages, start, &partial);
+		unlocked |= truncate_list_pages(mapping, &mapping->dirty_pages, start, &partial);
+		unlocked |= truncate_list_pages(mapping, &mapping->locked_pages, start, &partial);
 	} while (unlocked);
 	/* Traversed all three lists without dropping the lock */
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
-static inline int invalidate_this_page2(struct page * page,
+static inline int invalidate_this_page2(struct address_space *mapping,
+					struct page * page,
 					struct list_head * curr,
 					struct list_head * head)
 {
 	int unlocked = 1;
 
 	/*
-	 * The page is locked and we hold the pagecache_lock as well
+	 * The page is locked and we hold the mapping lock as well
 	 * so both page_count(page) and page->buffers stays constant here.
 	 */
 	if (page_count(page) == 1 + !!page->buffers) {
@@ -351,7 +308,7 @@
 		list_add_tail(head, curr);
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		truncate_complete_page(page);
 	} else {
 		if (page->buffers) {
@@ -360,7 +317,7 @@
 			list_add_tail(head, curr);
 
 			page_cache_get(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			block_invalidate_page(page);
 		} else
 			unlocked = 0;
@@ -372,8 +329,8 @@
 	return unlocked;
 }
 
-static int FASTCALL(invalidate_list_pages2(struct list_head *));
-static int invalidate_list_pages2(struct list_head *head)
+static int FASTCALL(invalidate_list_pages2(struct address_space *mapping, struct list_head *));
+static int invalidate_list_pages2(struct address_space *mapping, struct list_head *head)
 {
 	struct list_head *curr;
 	struct page * page;
@@ -387,7 +344,7 @@
 		if (!TryLockPage(page)) {
 			int __unlocked;
 
-			__unlocked = invalidate_this_page2(page, curr, head);
+			__unlocked = invalidate_this_page2(mapping, page, curr, head);
 			UnlockPage(page);
 			unlocked |= __unlocked;
 			if (!__unlocked) {
@@ -400,7 +357,7 @@
 			list_add(head, curr);
 
 			page_cache_get(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			unlocked = 1;
 			wait_on_page(page);
 		}
@@ -411,7 +368,7 @@
 			schedule();
 		}
 
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 		goto restart;
 	}
 	return unlocked;
@@ -426,32 +383,13 @@
 {
 	int unlocked;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	do {
-		unlocked = invalidate_list_pages2(&mapping->clean_pages);
-		unlocked |= invalidate_list_pages2(&mapping->dirty_pages);
-		unlocked |= invalidate_list_pages2(&mapping->locked_pages);
+		unlocked = invalidate_list_pages2(mapping, &mapping->clean_pages);
+		unlocked |= invalidate_list_pages2(mapping, &mapping->dirty_pages);
+		unlocked |= invalidate_list_pages2(mapping, &mapping->locked_pages);
 	} while (unlocked);
-	spin_unlock(&pagecache_lock);
-}
-
-static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
-{
-	goto inside;
-
-	for (;;) {
-		page = page->next_hash;
-inside:
-		if (!page)
-			goto not_found;
-		if (page->mapping != mapping)
-			continue;
-		if (page->index == offset)
-			break;
-	}
-
-not_found:
-	return page;
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 /*
@@ -489,13 +427,14 @@
 	return error;
 }
 
-static int do_buffer_fdatasync(struct list_head *head, unsigned long start, unsigned long end, int (*fn)(struct page *))
+static int do_buffer_fdatasync(struct address_space *mapping,
+	struct list_head *head, unsigned long start, unsigned long end, int (*fn)(struct page *))
 {
 	struct list_head *curr;
 	struct page *page;
 	int retval = 0;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	curr = head->next;
 	while (curr != head) {
 		page = list_entry(curr, struct page, list);
@@ -508,7 +447,7 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		lock_page(page);
 
 		/* The buffers could have been free'd while we waited for the page lock */
@@ -516,11 +455,11 @@
 			retval |= fn(page);
 
 		UnlockPage(page);
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 		curr = page->list.next;
 		page_cache_release(page);
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 
 	return retval;
 }
@@ -531,17 +470,18 @@
  */
 int generic_buffer_fdatasync(struct inode *inode, unsigned long start_idx, unsigned long end_idx)
 {
+	struct address_space *mapping = inode->i_mapping;
 	int retval;
 
 	/* writeout dirty buffers on pages from both clean and dirty lists */
-	retval = do_buffer_fdatasync(&inode->i_mapping->dirty_pages, start_idx, end_idx, writeout_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->clean_pages, start_idx, end_idx, writeout_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->locked_pages, start_idx, end_idx, writeout_one_page);
+	retval = do_buffer_fdatasync(mapping, &mapping->dirty_pages, start_idx, end_idx, writeout_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->clean_pages, start_idx, end_idx, writeout_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->locked_pages, start_idx, end_idx, writeout_one_page);
 
 	/* now wait for locked buffers on pages from both clean and dirty lists */
-	retval |= do_buffer_fdatasync(&inode->i_mapping->dirty_pages, start_idx, end_idx, waitfor_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->clean_pages, start_idx, end_idx, waitfor_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->locked_pages, start_idx, end_idx, waitfor_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->dirty_pages, start_idx, end_idx, waitfor_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->clean_pages, start_idx, end_idx, waitfor_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->locked_pages, start_idx, end_idx, waitfor_one_page);
 
 	return retval;
 }
@@ -586,7 +526,7 @@
 {
 	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 
         while (!list_empty(&mapping->dirty_pages)) {
 		struct page *page = list_entry(mapping->dirty_pages.next, struct page, list);
@@ -598,7 +538,7 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		lock_page(page);
 
@@ -609,9 +549,9 @@
 			UnlockPage(page);
 
 		page_cache_release(page);
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 /**
@@ -623,7 +563,7 @@
  */
 void filemap_fdatawait(struct address_space * mapping)
 {
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 
         while (!list_empty(&mapping->locked_pages)) {
 		struct page *page = list_entry(mapping->locked_pages.next, struct page, list);
@@ -635,14 +575,14 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		___wait_on_page(page);
 
 		page_cache_release(page);
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 /*
@@ -651,28 +591,34 @@
  * The caller must have locked the page and 
  * set all the page flags correctly..
  */
-void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index)
+int add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index)
 {
 	if (!PageLocked(page))
 		BUG();
 
 	page->index = index;
 	page_cache_get(page);
-	spin_lock(&pagecache_lock);
+	spin_lock (&mapping->i_shared_lock);
+	if (rat_insert (mapping, index, page) < 0)
+		goto nomem;
 	add_page_to_inode_queue(mapping, page);
-	add_page_to_hash_queue(page, page_hash(mapping, index));
-	spin_unlock(&pagecache_lock);
+	atomic_inc(&page_cache_size);
+	spin_unlock(&mapping->i_shared_lock);
 
 	lru_cache_add(page);
+	return 0;
+ nomem:
+	spin_unlock (&mapping->i_shared_lock);
+	page_cache_release (page);
+	return -ENOMEM;
 }
 
 /*
  * This adds a page to the page cache, starting out as locked,
  * owned by us, but unreferenced, not uptodate and with no errors.
  */
-static inline void __add_to_page_cache(struct page * page,
-	struct address_space *mapping, unsigned long offset,
-	struct page **hash)
+static inline int __add_to_page_cache(struct page * page, struct address_space *mapping,
+				      unsigned long offset)
 {
 	unsigned long flags;
 
@@ -680,35 +626,44 @@
 	page->flags = flags | (1 << PG_locked);
 	page_cache_get(page);
 	page->index = offset;
+	if (rat_insert (mapping, offset, page) < 0)
+		goto nomem;
 	add_page_to_inode_queue(mapping, page);
-	add_page_to_hash_queue(page, hash);
+
+	atomic_inc(&page_cache_size);
+	return 0;
+ nomem:
+	page_cache_release (page);
+	return -ENOMEM;
 }
 
-void add_to_page_cache(struct page * page, struct address_space * mapping, unsigned long offset)
+int add_to_page_cache(struct page * page, struct address_space * mapping, unsigned long offset)
 {
-	spin_lock(&pagecache_lock);
-	__add_to_page_cache(page, mapping, offset, page_hash(mapping, offset));
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	if (__add_to_page_cache(page, mapping, offset) < 0)
+		goto nomem;
+	spin_unlock(&mapping->i_shared_lock);
 	lru_cache_add(page);
+	return 0;
+ nomem:
+	spin_unlock (&mapping->i_shared_lock);
+	return -ENOMEM;
 }
 
-int add_to_page_cache_unique(struct page * page,
-	struct address_space *mapping, unsigned long offset,
-	struct page **hash)
+int add_to_page_cache_unique(struct page * page, struct address_space *mapping,
+			     unsigned long offset)
 {
 	int err;
 	struct page *alias;
 
-	spin_lock(&pagecache_lock);
-	alias = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	alias = rat_lookup (mapping, offset);
 
-	err = 1;
-	if (!alias) {
-		__add_to_page_cache(page,mapping,offset,hash);
-		err = 0;
-	}
+	err = -EEXIST;
+	if (!alias)
+		err = __add_to_page_cache(page,mapping,offset);
 
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	if (!err)
 		lru_cache_add(page);
 	return err;
@@ -722,12 +677,12 @@
 static int page_cache_read(struct file * file, unsigned long offset)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct page **hash = page_hash(mapping, offset);
 	struct page *page; 
+	int error;
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	page = rat_lookup (mapping, offset);
+	spin_unlock(&mapping->i_shared_lock);
 	if (page)
 		return 0;
 
@@ -735,17 +690,27 @@
 	if (!page)
 		return -ENOMEM;
 
-	if (!add_to_page_cache_unique(page, mapping, offset, hash)) {
-		int error = mapping->a_ops->readpage(file, page);
+	error = add_to_page_cache_unique (page, mapping, offset);
+	while (error == -ENOMEM) {  
+		/* Yield for kswapd, and try again */
+		current->policy |= SCHED_YIELD;
+		__set_current_state(TASK_RUNNING);
+		schedule();
+		error = add_to_page_cache_unique (page, mapping, offset);
+	}
+
+	if (!error) {
+		error = mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
 		return error;
 	}
 	/*
 	 * We arrive here in the unlikely event that someone 
-	 * raced with us and added our page to the cache first.
+	 * raced with us and added our page to the cache first
+	 * or we are out of memory.  
 	 */
 	page_cache_release(page);
-	return 0;
+	return error == -ENOMEM ? -ENOMEM : 0;
 }
 
 /*
@@ -843,8 +808,7 @@
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */
-struct page * __find_get_page(struct address_space *mapping,
-			      unsigned long offset, struct page **hash)
+struct page * __find_get_page(struct address_space *mapping, unsigned long offset)
 {
 	struct page *page;
 
@@ -852,11 +816,11 @@
 	 * We scan the hash list read-only. Addition to and removal from
 	 * the hash-list needs a held write-lock.
 	 */
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	page = rat_lookup (mapping, offset);
 	if (page)
 		page_cache_get(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	return page;
 }
 
@@ -866,15 +830,14 @@
 struct page *find_trylock_page(struct address_space *mapping, unsigned long offset)
 {
 	struct page *page;
-	struct page **hash = page_hash(mapping, offset);
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	page = rat_lookup (mapping, offset);
 	if (page) {
 		if (TryLockPage(page))
 			page = NULL;
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	return page;
 }
 
@@ -883,9 +846,9 @@
  * will return with it held (but it may be dropped
  * during blocking operations..
  */
-static struct page * FASTCALL(__find_lock_page_helper(struct address_space *, unsigned long, struct page *));
+static struct page * FASTCALL(__find_lock_page_helper(struct address_space *, unsigned long));
 static struct page * __find_lock_page_helper(struct address_space *mapping,
-					unsigned long offset, struct page *hash)
+					unsigned long offset)
 {
 	struct page *page;
 
@@ -894,13 +857,13 @@
 	 * the hash-list needs a held write-lock.
 	 */
 repeat:
-	page = __find_page_nolock(mapping, offset, hash);
+	page = rat_lookup (mapping, offset);
 	if (page) {
 		page_cache_get(page);
 		if (TryLockPage(page)) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			lock_page(page);
-			spin_lock(&pagecache_lock);
+			spin_lock(&mapping->i_shared_lock);
 
 			/* Has the page been re-allocated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
@@ -918,13 +881,13 @@
  * it's still valid once we own it.
  */
 struct page * __find_lock_page (struct address_space *mapping,
-				unsigned long offset, struct page **hash)
+				unsigned long offset)
 {
 	struct page *page;
 
-	spin_lock(&pagecache_lock);
-	page = __find_lock_page_helper(mapping, offset, *hash);
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	page = __find_lock_page_helper(mapping, offset);
+	spin_unlock(&mapping->i_shared_lock);
 	return page;
 }
 
@@ -934,23 +897,22 @@
 struct page * find_or_create_page(struct address_space *mapping, unsigned long index, unsigned int gfp_mask)
 {
 	struct page *page;
-	struct page **hash = page_hash(mapping, index);
 
-	spin_lock(&pagecache_lock);
-	page = __find_lock_page_helper(mapping, index, *hash);
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	page = __find_lock_page_helper(mapping, index);
+	spin_unlock(&mapping->i_shared_lock);
 	if (!page) {
 		struct page *newpage = alloc_page(gfp_mask);
-		page = NULL;
 		if (newpage) {
-			spin_lock(&pagecache_lock);
-			page = __find_lock_page_helper(mapping, index, *hash);
+			spin_lock(&mapping->i_shared_lock);
+			page = __find_lock_page_helper(mapping, index);
 			if (likely(!page)) {
-				page = newpage;
-				__add_to_page_cache(page, mapping, index, hash);
-				newpage = NULL;
+				if (__add_to_page_cache (newpage, mapping, index) == 0) {
+					page = newpage;
+					newpage = NULL;
+				}
 			}
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			if (newpage == NULL)
 				lru_cache_add(page);
 			else 
@@ -977,10 +939,9 @@
  */
 struct page *grab_cache_page_nowait(struct address_space *mapping, unsigned long index)
 {
-	struct page *page, **hash;
+	struct page *page;
 
-	hash = page_hash(mapping, index);
-	page = __find_get_page(mapping, index, hash);
+	page = __find_get_page(mapping, index);
 
 	if ( page ) {
 		if ( !TryLockPage(page) ) {
@@ -1005,7 +966,7 @@
 	if ( unlikely(!page) )
 		return NULL;	/* Failed to allocate a page */
 
-	if ( unlikely(add_to_page_cache_unique(page, mapping, index, hash)) ) {
+	if ( unlikely(add_to_page_cache_unique(page, mapping, index)) ) {
 		/* Someone else grabbed the page already. */
 		page_cache_release(page);
 		return NULL;
@@ -1330,7 +1291,7 @@
 	}
 
 	for (;;) {
-		struct page *page, **hash;
+		struct page *page;
 		unsigned long end_index, nr, ret;
 
 		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
@@ -1349,15 +1310,14 @@
 		/*
 		 * Try to find the data in the page cache..
 		 */
-		hash = page_hash(mapping, index);
 
-		spin_lock(&pagecache_lock);
-		page = __find_page_nolock(mapping, index, *hash);
+		spin_lock(&mapping->i_shared_lock);
+		page = rat_lookup (mapping, index);
 		if (!page)
 			goto no_cached_page;
 found_page:
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		if (!Page_Uptodate(page))
 			goto page_not_up_to_date;
@@ -1451,7 +1411,7 @@
 		 * We get here with the page cache lock held.
 		 */
 		if (!cached_page) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			cached_page = page_cache_alloc(mapping);
 			if (!cached_page) {
 				desc->error = -ENOMEM;
@@ -1462,8 +1422,8 @@
 			 * Somebody may have added the page while we
 			 * dropped the page cache lock. Check for that.
 			 */
-			spin_lock(&pagecache_lock);
-			page = __find_page_nolock(mapping, index, *hash);
+			spin_lock(&mapping->i_shared_lock);
+			page = rat_lookup (mapping, index);
 			if (page)
 				goto found_page;
 		}
@@ -1471,9 +1431,13 @@
 		/*
 		 * Ok, add the new page to the hash-queues...
 		 */
+		if (__add_to_page_cache (cached_page, mapping, index) < 0) {
+			spin_unlock (&mapping->i_shared_lock);
+			desc->error = -ENOMEM;
+			break;
+		}
 		page = cached_page;
-		__add_to_page_cache(page, mapping, index, hash);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		lru_cache_add(page);		
 		cached_page = NULL;
 
@@ -1873,7 +1837,7 @@
 	struct file *file = area->vm_file;
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	struct inode *inode = mapping->host;
-	struct page *page, **hash;
+	struct page *page;
 	unsigned long size, pgoff, endoff;
 
 	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
@@ -1895,9 +1859,8 @@
 	/*
 	 * Do we have something in the page cache already?
 	 */
-	hash = page_hash(mapping, pgoff);
 retry_find:
-	page = __find_get_page(mapping, pgoff, hash);
+	page = __find_get_page(mapping, pgoff);
 	if (!page)
 		goto no_cached_page;
 
@@ -2582,13 +2545,13 @@
 {
 	unsigned char present = 0;
 	struct address_space * as = vma->vm_file->f_dentry->d_inode->i_mapping;
-	struct page * page, ** hash = page_hash(as, pgoff);
+	struct page * page;
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(as, pgoff, *hash);
+	spin_lock(&as->i_shared_lock);
+	page = rat_lookup (as, pgoff);
 	if ((page) && (Page_Uptodate(page)))
 		present = 1;
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&as->i_shared_lock);
 
 	return present;
 }
@@ -2731,20 +2694,24 @@
 				int (*filler)(void *,struct page*),
 				void *data)
 {
-	struct page **hash = page_hash(mapping, index);
 	struct page *page, *cached_page = NULL;
 	int err;
 repeat:
-	page = __find_get_page(mapping, index, hash);
+	page = __find_get_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
 			cached_page = page_cache_alloc(mapping);
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
-		page = cached_page;
-		if (add_to_page_cache_unique(page, mapping, index, hash))
+		err = add_to_page_cache_unique (cached_page, mapping, index);
+		if (err == -EEXIST)
 			goto repeat;
+		if (err < 0) {
+			page_cache_release(cached_page);
+			return ERR_PTR(err);
+		}
+		page = cached_page;
 		cached_page = NULL;
 		err = filler(data, page);
 		if (err < 0) {
@@ -2799,19 +2766,23 @@
 static inline struct page * __grab_cache_page(struct address_space *mapping,
 				unsigned long index, struct page **cached_page)
 {
-	struct page *page, **hash = page_hash(mapping, index);
+	int err;
+	struct page *page;
 repeat:
-	page = __find_lock_page(mapping, index, hash);
+	page = __find_lock_page(mapping, index);
 	if (!page) {
 		if (!*cached_page) {
 			*cached_page = page_cache_alloc(mapping);
 			if (!*cached_page)
 				return NULL;
 		}
-		page = *cached_page;
-		if (add_to_page_cache_unique(page, mapping, index, hash))
+		err = add_to_page_cache_unique (*cached_page, mapping, index);
+		if (err == -EEXIST)
 			goto repeat;
-		*cached_page = NULL;
+		if (err == 0) {
+			page = *cached_page;
+			*cached_page = NULL;
+		}
 	}
 	return page;
 }
@@ -3072,29 +3043,15 @@
 	goto out_status;
 }
 
-void __init page_cache_init(unsigned long mempages)
+static void rat_node_ctor (void *node, kmem_cache_t *cachep, unsigned long flags)
 {
-	unsigned long htable_size, order;
-
-	htable_size = mempages;
-	htable_size *= sizeof(struct page *);
-	for(order = 0; (PAGE_SIZE << order) < htable_size; order++)
-		;
-
-	do {
-		unsigned long tmp = (PAGE_SIZE << order) / sizeof(struct page *);
+	memset (node, 0, sizeof (rat_node_t));
+}
 
-		page_hash_bits = 0;
-		while((tmp >>= 1UL) != 0UL)
-			page_hash_bits++;
-
-		page_hash_table = (struct page **)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while(page_hash_table == NULL && --order > 0);
-
-	printk("Page-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-	       (1 << page_hash_bits), order, (PAGE_SIZE << order));
-	if (!page_hash_table)
-		panic("Failed to allocate page hash table\n");
-	memset((void *)page_hash_table, 0, PAGE_HASH_SIZE * sizeof(struct page *));
+void __init page_cache_init()
+{
+	rat_node_cachep = kmem_cache_create ("rat node cache", sizeof (rat_node_t), 0,
+					     SLAB_HWCACHE_ALIGN, rat_node_ctor, 0);
+	if (!rat_node_cachep)
+		panic ("Failed to create pagecache cache\n");
 }
diff -Nru a/mm/rat.c b/mm/rat.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/rat.c	Sun Dec 23 23:58:21 2001
@@ -0,0 +1,187 @@
+/* Page cache radix tree.  
+ *
+ * Copyright (C) 2001 Momchil Velikov
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2, or (at
+ * your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/rat.h>
+
+/* Radix tree node cache.  */
+kmem_cache_t *rat_node_cachep;
+
+#if 0
+/* Default node allocation/deallocation functions.  */
+rat_node_t *rat_node_alloc ()
+{
+	return kmem_cache_alloc (rat_node_cachep, GFP_KERNEL);
+}
+
+void rat_node_free (rat_node_t *node)
+{
+	kmem_cache_free (rat_node_cachep, node);
+}
+#endif
+
+/* Extend a radix tree so it can store key INDEX.  */
+static int
+rat_extend (struct address_space *mapping, unsigned long index)
+{
+	rat_node_t *node;
+	unsigned int height;
+
+	/* Figure out what the height should be.  */
+	height = mapping->height + 1;
+	while (index > rat_index_max (height))
+		height ++;
+
+	if (mapping->root == NULL) {
+		mapping->height = height;
+		return 0;
+	}
+
+	do {
+		/* Allocate addtional node.  */
+		node = kmem_cache_alloc (rat_node_cachep, GFP_ATOMIC);
+		if (node == NULL)
+			return -1;
+
+		/* Increase the height.  */
+		node->slots [0] = mapping->root;
+		if (mapping->root)
+			node->count = 1;
+		mapping->root = node;
+		mapping->height++;
+	} while (height > mapping->height);
+
+	return 0;
+}
+
+/* Reserve a slot in a radix tree for the index INDEX.  */
+int
+rat_reserve (struct address_space *mapping, unsigned long index, struct page ***pslot)
+{
+	unsigned int height, shift;
+	rat_node_t *tmp, *node, **slot;
+
+	/* Make sure the tree is high enough.  */
+	if (index > rat_index_max (mapping->height) && rat_extend (mapping, index))
+		return -ENOMEM;
+    
+	height = mapping->height;
+	shift = (height - 1) * RAT_MAP_SHIFT;
+	node = NULL;
+	slot = (rat_node_t **) &mapping->root;
+
+	while (height > 0) {
+		if (*slot == NULL) {
+			/* Have to add a child node.  */
+			tmp = kmem_cache_alloc (rat_node_cachep, GFP_ATOMIC);
+			if (tmp == NULL)
+				return -ENOMEM;
+
+			*slot = tmp;
+			if (node)
+				node->count++;
+		}
+
+		/* Go a level down.  */
+		node = *slot;
+		slot = (rat_node_t **) (node->slots + ((index >> shift) & RAT_MAP_MASK));
+		shift -= RAT_MAP_SHIFT;
+		height --;
+	}
+
+	if (*slot != NULL)
+		return -EEXIST;
+
+	if (node)
+		node->count++;
+
+	*pslot = (struct page **) slot;
+	**pslot = RAT_SLOT_RESERVED;
+	return 0;
+}
+
+/* Lookup a page in the radix tree.  */
+struct page *
+rat_lookup (struct address_space *mapping, unsigned long index)
+{
+	unsigned int height, shift;
+	rat_node_t **slot;
+
+	height = mapping->height;
+	if (index > rat_index_max (height))
+		return NULL;
+
+	shift = (height - 1) * RAT_MAP_SHIFT;
+	slot = (rat_node_t **) &mapping->root;
+
+	while (height > 0) {
+		if (*slot == NULL)
+			return NULL;
+
+		slot = (rat_node_t **) ((*slot)->slots + ((index >> shift) & RAT_MAP_MASK));
+		shift -= RAT_MAP_SHIFT;
+		height --;
+	}
+
+	return (struct page *) *slot;
+}
+
+/* Remove a page from the radix tree.  */
+int
+rat_delete (struct address_space *mapping, unsigned long index)
+{
+	unsigned int height, shift;
+	struct {
+		rat_node_t *node;
+		rat_node_t **slot;
+	} path [ RAT_INDEX_BITS / RAT_MAP_SHIFT + 2], *pathp = path;
+
+	height = mapping->height;
+	if (index > rat_index_max (height))
+		return -ENOENT;
+
+	shift = (height - 1) * RAT_MAP_SHIFT;
+	pathp->node = NULL;
+	pathp->slot = (rat_node_t **) &mapping->root;
+
+	while (height > 0) {
+		if (*pathp->slot == NULL)
+			return -ENOENT;
+
+		pathp [1].node = *pathp [0].slot;
+		pathp [1].slot = (rat_node_t **) (pathp [1].node->slots
+						  + ((index >> shift) & RAT_MAP_MASK));
+		pathp ++;
+		shift -= RAT_MAP_SHIFT;
+		height --;
+	}
+
+	if (*pathp [0].slot == NULL)
+		return -ENOENT;
+
+	*pathp [0].slot = NULL;
+
+	while (pathp [0].node && --pathp [0].node->count == 0) {
+		pathp--;
+		*pathp[0].slot = NULL;
+		kmem_cache_free (rat_node_cachep, pathp [1].node);
+	}
+
+	return 0;
+}
diff -Nru a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Sun Dec 23 23:58:21 2001
+++ b/mm/shmem.c	Sun Dec 23 23:58:21 2001
@@ -27,6 +27,7 @@
 #include <linux/string.h>
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
+#include <linux/rat.h>
 
 #include <asm/uaccess.h>
 
@@ -365,7 +366,7 @@
 	swp_entry_t *ptr;
 	unsigned long idx;
 	int offset;
-	
+
 	idx = 0;
 	spin_lock (&info->lock);
 	offset = shmem_clear_swp (entry, info->i_direct, SHMEM_NR_DIRECT);
@@ -384,11 +385,8 @@
 	spin_unlock (&info->lock);
 	return 0;
 found:
-	delete_from_swap_cache(page);
-	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
-	SetPageDirty(page);
-	SetPageUptodate(page);
-	info->swapped--;
+	if (!move_from_swap_cache (page, offset + idx, info->inode->i_mapping))
+		info->swapped--;
 	spin_unlock(&info->lock);
 	return 1;
 }
@@ -420,6 +418,7 @@
  */
 static int shmem_writepage(struct page * page)
 {
+	int err;
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
 	struct address_space *mapping;
@@ -450,29 +449,28 @@
 	if (entry->val)
 		BUG();
 
-	/* Remove it from the page cache */
-	remove_inode_page(page);
-	page_cache_release(page);
-
-	/* Add it to the swap cache */
-	if (add_to_swap_cache(page, swap) != 0) {
-		/*
-		 * Raced with "speculative" read_swap_cache_async.
-		 * Add page back to page cache, unref swap, try again.
-		 */
-		add_to_page_cache_locked(page, mapping, index);
+	err = move_to_swap_cache (page, swap);
+	if (!err) {
+		*entry = swap;
+		info->swapped++;
 		spin_unlock(&info->lock);
-		swap_free(swap);
-		goto getswap;
+		SetPageUptodate(page);
+		set_page_dirty(page);
+		UnlockPage(page);
+		return 0;
 	}
 
-	*entry = swap;
-	info->swapped++;
-	spin_unlock(&info->lock);
-	SetPageUptodate(page);
-	set_page_dirty(page);
-	UnlockPage(page);
-	return 0;
+	spin_unlock (&info->lock);
+	swap_free (swap);
+	
+	if (err == -ENOMEM) {
+		/* Yield for kswapd, and try again */
+		current->policy |= SCHED_YIELD;
+		__set_current_state(TASK_RUNNING);
+		schedule();
+	}
+
+	goto getswap;
 }
 
 /*
@@ -545,16 +543,15 @@
 			goto repeat;
 		}
 
-		/* We have to this with page locked to prevent races */
+		/* We have to do this with page locked to prevent races */
 		if (TryLockPage(page)) 
 			goto wait_retry;
 
+		if (move_from_swap_cache (page, idx, mapping))
+			goto nomem_retry;
+
 		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
-		delete_from_swap_cache(page);
-		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
-		page->flags = flags | (1 << PG_dirty);
-		add_to_page_cache_locked(page, mapping, idx);
 		info->swapped--;
 		spin_unlock (&info->lock);
 	} else {
@@ -576,9 +573,14 @@
 		page = page_cache_alloc(mapping);
 		if (!page)
 			return ERR_PTR(-ENOMEM);
+		while (add_to_page_cache (page, mapping, idx) < 0) {
+			/* Yield for kswapd, and try again */
+			current->policy |= SCHED_YIELD;
+			__set_current_state(TASK_RUNNING);
+			schedule();
+		}
 		clear_highpage(page);
 		inode->i_blocks += BLOCKS_PER_PAGE;
-		add_to_page_cache (page, mapping, idx);
 	}
 
 	/* We have the page */
@@ -592,6 +594,17 @@
 	spin_unlock (&info->lock);
 	wait_on_page(page);
 	page_cache_release(page);
+	goto repeat;
+
+nomem_retry:
+	spin_unlock (&info->lock);
+	UnlockPage (page);
+	page_cache_release (page);
+
+	/* Yield for kswapd, and try again */
+	current->policy |= SCHED_YIELD;
+	__set_current_state(TASK_RUNNING);
+	schedule();
 	goto repeat;
 }
 
diff -Nru a/mm/swap_state.c b/mm/swap_state.c
--- a/mm/swap_state.c	Sun Dec 23 23:58:21 2001
+++ b/mm/swap_state.c	Sun Dec 23 23:58:21 2001
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/rat.h>
 
 #include <asm/pgtable.h>
 
@@ -69,17 +70,20 @@
 
 int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
+	int error;
+
 	if (page->mapping)
 		BUG();
 	if (!swap_duplicate(entry)) {
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
-	if (add_to_page_cache_unique(page, &swapper_space, entry.val,
-			page_hash(&swapper_space, entry.val)) != 0) {
+
+	error = add_to_page_cache_unique(page, &swapper_space, entry.val);
+	if (error != 0) {
 		swap_free(entry);
 		INC_CACHE_INFO(exist_race);
-		return -EEXIST;
+		return error;
 	}
 	if (!PageLocked(page))
 		BUG();
@@ -121,12 +125,97 @@
 
 	entry.val = page->index;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&swapper_space.i_shared_lock);
 	__delete_from_swap_cache(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&swapper_space.i_shared_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
+}
+
+int move_to_swap_cache (struct page *page, swp_entry_t entry)
+{
+	int err;
+	struct page **pslot;
+	struct address_space *mapping = page->mapping;
+
+	if (!mapping)
+		BUG();
+
+	if (!swap_duplicate (entry)) {
+		INC_CACHE_INFO (noent_race);
+		return -ENOENT;
+	}
+
+	spin_lock (&swapper_space.i_shared_lock);
+	spin_lock (&mapping->i_shared_lock);
+
+	err = rat_reserve (&swapper_space, entry.val, &pslot);
+	if (!err) {
+		/* Remove it from the page cache */
+		__remove_inode_page (page);
+
+		/* Add it to the swap cache */
+		*pslot = page;
+		page->flags = ((page->flags & ~(1 << PG_uptodate | 1 << PG_error
+						| 1 << PG_dirty  | 1 << PG_referenced
+						| 1 << PG_arch_1 | 1 << PG_checked))
+			       | (1 << PG_locked));
+		page->index = entry.val;
+		add_page_to_inode_queue(&swapper_space, page);
+		atomic_inc(&page_cache_size);
+	}
+
+	spin_unlock (&mapping->i_shared_lock);
+	spin_unlock (&swapper_space.i_shared_lock);
+
+	if (!err) {
+		INC_CACHE_INFO (add_total);
+		return 0;
+	}
+
+	swap_free (entry);
+
+	if (err == -EEXIST)
+		INC_CACHE_INFO (exist_race);
+
+	return err;
+}
+
+int move_from_swap_cache (struct page *page, unsigned long index, struct address_space *mapping)
+{
+	int err;
+	struct page **pslot;
+
+	if (!PageLocked(page))
+		BUG();
+
+	spin_lock (&swapper_space.i_shared_lock);
+	spin_lock (&mapping->i_shared_lock);
+
+	err = rat_reserve (mapping, index, &pslot);
+	if (!err) {
+		swp_entry_t entry;
+
+		block_flushpage (page, 0);
+		entry.val = page->index;
+		__delete_from_swap_cache (page);
+		swap_free (entry);
+
+		*pslot = page;
+		page->flags = ((page->flags & ~(1 << PG_uptodate | 1 << PG_error
+						| 1 << PG_referenced | 1 << PG_arch_1
+						| 1 << PG_checked))
+			       | (1 << PG_dirty));
+		page->index = index;
+		add_page_to_inode_queue (mapping, page);
+		atomic_inc (&page_cache_size);
+	}
+
+	spin_lock (&mapping->i_shared_lock);
+	spin_lock (&swapper_space.i_shared_lock);
+
+	return err;
 }
 
 /* 
diff -Nru a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	Sun Dec 23 23:58:21 2001
+++ b/mm/swapfile.c	Sun Dec 23 23:58:21 2001
@@ -239,10 +239,10 @@
 		/* Is the only swap cache user the cache itself? */
 		if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
-			spin_lock(&pagecache_lock);
+			spin_lock(&swapper_space.i_shared_lock);
 			if (page_count(page) - !!page->buffers == 2)
 				retval = 1;
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&swapper_space.i_shared_lock);
 		}
 		swap_info_put(p);
 	}
@@ -307,13 +307,13 @@
 	retval = 0;
 	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
-		spin_lock(&pagecache_lock);
+		spin_lock(&swapper_space.i_shared_lock);
 		if (page_count(page) - !!page->buffers == 2) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&swapper_space.i_shared_lock);
 	}
 	swap_info_put(p);
 
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Sun Dec 23 23:58:21 2001
+++ b/mm/vmscan.c	Sun Dec 23 23:58:21 2001
@@ -136,10 +136,16 @@
 		 * (adding to the page cache will clear the dirty
 		 * and uptodate bits, so we need to do it again)
 		 */
-		if (add_to_swap_cache(page, entry) == 0) {
+		switch (add_to_swap_cache (page, entry)) {
+		case 0:
 			SetPageUptodate(page);
 			set_page_dirty(page);
 			goto set_swap_pte;
+		case -ENOMEM:
+			swap_free (entry);
+			goto preserve;
+		default:
+			break;
 		}
 		/* Raced with "speculative" read_swap_cache_async */
 		swap_free(entry);
@@ -337,6 +343,7 @@
 static int shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int priority)
 {
 	struct list_head * entry;
+	struct address_space *mapping;
 	int max_scan = nr_inactive_pages / priority;
 	int max_mapped = min((nr_pages << (10 - priority)), max_scan / 10);
 
@@ -391,7 +398,9 @@
 			continue;
 		}
 
-		if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping) {
+		mapping = page->mapping;
+
+		if (PageDirty(page) && is_page_cache_freeable(page) && mapping) {
 			/*
 			 * It is not critical here to write it only if
 			 * the page is unmapped beause any direct writer
@@ -402,7 +411,7 @@
 			 */
 			int (*writepage)(struct page *);
 
-			writepage = page->mapping->a_ops->writepage;
+			writepage = mapping->a_ops->writepage;
 			if ((gfp_mask & __GFP_FS) && writepage) {
 				ClearPageDirty(page);
 				SetPageLaunder(page);
@@ -429,7 +438,7 @@
 			page_cache_get(page);
 
 			if (try_to_release_page(page, gfp_mask)) {
-				if (!page->mapping) {
+				if (!mapping) {
 					/*
 					 * We must not allow an anon page
 					 * with no buffers to be visible on
@@ -466,13 +475,22 @@
 			}
 		}
 
-		spin_lock(&pagecache_lock);
+		/*
+		 * Page is locked, so mapping can't change under our
+		 * feet.
+		 */
+		if (!mapping) {
+			UnlockPage (page);
+			goto page_mapped;
+		}
+
+		spin_lock(&mapping->i_shared_lock);
 
 		/*
 		 * this is the non-racy check for busy page.
 		 */
-		if (!page->mapping || !is_page_cache_freeable(page)) {
-			spin_unlock(&pagecache_lock);
+		if (!is_page_cache_freeable(page)) {
+			spin_unlock(&mapping->i_shared_lock);
 			UnlockPage(page);
 page_mapped:
 			if (--max_mapped >= 0)
@@ -492,7 +510,7 @@
 		 * the page is freeable* so not in use by anybody.
 		 */
 		if (PageDirty(page)) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			UnlockPage(page);
 			continue;
 		}
@@ -500,12 +518,12 @@
 		/* point of no return */
 		if (likely(!PageSwapCache(page))) {
 			__remove_inode_page(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 		} else {
 			swp_entry_t swap;
 			swap.val = page->index;
 			__delete_from_swap_cache(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			swap_free(swap);
 		}
 
