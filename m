Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281643AbRKZM0F>; Mon, 26 Nov 2001 07:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281645AbRKZMZv>; Mon, 26 Nov 2001 07:25:51 -0500
Received: from sun.fadata.bg ([80.72.64.67]:10756 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S281643AbRKZMZe>;
	Mon, 26 Nov 2001 07:25:34 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Scalable page cache
From: Momchil Velikov <velco@fadata.bg>
Date: 26 Nov 2001 14:31:42 +0200
Message-ID: <87elml4ssx.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch:

        - replaces the global page cache hash table with a per mapping
          splay tree;

        - eliminates the ``pagecache_lock'', instead ``i_shared_lock''
          is used so serialize access during insertion/deletion
          into/from the tree;

The goals of the patch are to:

        - to improve scalability (via the elimination of the global
          lock);

        - reduce the memory/cache footprint (via to the
          ``page_hash_table'' elimination);

The patch is against 2.4.16-pre1. Comments are welcome. 

Regards,
-velco

diff -Nru a/arch/arm/mm/init.c b/arch/arm/mm/init.c
--- a/arch/arm/mm/init.c	Sun Nov 25 16:39:44 2001
+++ b/arch/arm/mm/init.c	Sun Nov 25 16:39:44 2001
@@ -103,7 +103,7 @@
  * #define PG_skip	10
  * #define PageSkip(page) (machine_is_riscpc() && test_bit(PG_skip, &(page)->flags))
  *			if (PageSkip(page)) {
- *				page = page->next_hash;
+ *				page = page->left;
  *				if (page == NULL)
  *					break;
  *			}
diff -Nru a/arch/arm/mm/small_page.c b/arch/arm/mm/small_page.c
--- a/arch/arm/mm/small_page.c	Sun Nov 25 16:39:44 2001
+++ b/arch/arm/mm/small_page.c	Sun Nov 25 16:39:44 2001
@@ -38,15 +38,15 @@
  * Theory:
  *  We "misuse" the Linux memory management system.  We use alloc_page
  *  to allocate a page and then mark it as reserved.  The Linux memory
- *  management system will then ignore the "offset", "next_hash" and
- *  "pprev_hash" entries in the mem_map for this page.
+ *  management system will then ignore the "offset", "left" and
+ *  "right" entries in the mem_map for this page.
  *
  *  We then use a bitstring in the "offset" field to mark which segments
  *  of the page are in use, and manipulate this as required during the
  *  allocation and freeing of these small pages.
  *
  *  We also maintain a queue of pages being used for this purpose using
- *  the "next_hash" and "pprev_hash" entries of mem_map;
+ *  the "left" and "right" entries of mem_map;
  */
 
 struct order {
@@ -81,20 +81,20 @@
 	if (page->pprev_hash)
 		PAGE_BUG(page);
 #endif
-	page->next_hash = *p;
+	page->left = *p;
 	if (*p)
-		(*p)->pprev_hash = &page->next_hash;
+		(struct page **)(*p)->right = &page->left;
 	*p = page;
-	page->pprev_hash = p;
+	(struct page **)page->right = p;
 }
 
 static void remove_page_from_queue(struct page *page)
 {
-	if (page->pprev_hash) {
-		if (page->next_hash)
-			page->next_hash->pprev_hash = page->pprev_hash;
-		*page->pprev_hash = page->next_hash;
-		page->pprev_hash = NULL;
+	if (page->right) {
+		if (page->left)
+			page->left->right = page->right;
+		*(struct page **)page->right = page->left;
+		page->right = NULL;
 	}
 }
 
diff -Nru a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	Sun Nov 25 16:39:44 2001
+++ b/arch/sparc64/mm/init.c	Sun Nov 25 16:39:44 2001
@@ -83,18 +83,18 @@
         if (pgd_cache_size > high / 4) {
 		struct page *page, *page2;
                 for (page2 = NULL, page = (struct page *)pgd_quicklist; page;) {
-                        if ((unsigned long)page->pprev_hash == 3) {
+                        if ((unsigned long)page->right == 3) {
                                 if (page2)
-                                        page2->next_hash = page->next_hash;
+                                        page2->left = page->left;
                                 else
-                                        (struct page *)pgd_quicklist = page->next_hash;
-                                page->next_hash = NULL;
-                                page->pprev_hash = NULL;
+                                        (struct page *)pgd_quicklist = page->left;
+                                page->left = NULL;
+                                page->right = NULL;
                                 pgd_cache_size -= 2;
                                 __free_page(page);
                                 freed++;
                                 if (page2)
-                                        page = page2->next_hash;
+                                        page = page2->left;
                                 else
                                         page = (struct page *)pgd_quicklist;
                                 if (pgd_cache_size <= low / 4)
@@ -102,7 +102,7 @@
                                 continue;
                         }
                         page2 = page;
-                        page = page->next_hash;
+                        page = page->left;
                 }
         }
 #endif
diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Sun Nov 25 16:39:44 2001
+++ b/drivers/block/rd.c	Sun Nov 25 16:39:44 2001
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
--- a/fs/inode.c	Sun Nov 25 16:39:44 2001
+++ b/fs/inode.c	Sun Nov 25 16:39:44 2001
@@ -110,6 +110,7 @@
 		sema_init(&inode->i_sem, 1);
 		sema_init(&inode->i_zombie, 1);
 		spin_lock_init(&inode->i_data.i_shared_lock);
+		inode->i_data.root = 0;
 	}
 }
 
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun Nov 25 16:39:44 2001
+++ b/include/linux/fs.h	Sun Nov 25 16:39:44 2001
@@ -403,6 +403,7 @@
 	struct vm_area_struct	*i_mmap;	/* list of private mappings */
 	struct vm_area_struct	*i_mmap_shared; /* list of shared mappings */
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
+	struct page             *root;
 	int			gfp_mask;	/* how to allocate the pages */
 };
 
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Sun Nov 25 16:39:44 2001
+++ b/include/linux/mm.h	Sun Nov 25 16:39:44 2001
@@ -152,15 +152,14 @@
 	struct list_head list;		/* ->mapping has some page lists. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
-	struct page *next_hash;		/* Next page sharing our hash bucket in
-					   the pagecache hash table. */
+	struct page *left;              /* Left child in the mapping tree */
+	struct page *right;             /* Right child in the mapping tree */
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
@@ -228,9 +227,9 @@
  * using the page->list list_head. These fields are also used for
  * freelist managemet (when page->count==0).
  *
- * There is also a hash table mapping (mapping,index) to the page
- * in memory if present. The lists for this hash table use the fields
- * page->next_hash and page->pprev_hash.
+ * There is also a per-mapping splay tree mapping (index) to the page
+ * in memory if present. The tree uses the fields page->left and
+ * page->right.
  *
  * All process pages can do I/O:
  * - inode pages may need to be read from disk,
diff -Nru a/include/linux/pagemap.h b/include/linux/pagemap.h
--- a/include/linux/pagemap.h	Sun Nov 25 16:39:44 2001
+++ b/include/linux/pagemap.h	Sun Nov 25 16:39:44 2001
@@ -41,53 +41,26 @@
  */
 #define page_cache_entry(x)	virt_to_page(x)
 
-extern unsigned int page_hash_bits;
-#define PAGE_HASH_BITS (page_hash_bits)
-#define PAGE_HASH_SIZE (1 << PAGE_HASH_BITS)
-
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
 
 extern void add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
 extern void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
-extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index, struct page **hash);
+extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index);
 
 extern void ___wait_on_page(struct page *);
 
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Sun Nov 25 16:39:44 2001
+++ b/init/main.c	Sun Nov 25 16:39:44 2001
@@ -597,7 +597,6 @@
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);
-	page_cache_init(mempages);
 #if defined(CONFIG_ARCH_S390)
 	ccwcache_init();
 #endif
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Sun Nov 25 16:39:44 2001
+++ b/kernel/ksyms.c	Sun Nov 25 16:39:44 2001
@@ -215,8 +215,6 @@
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_ro_fops);
 EXPORT_SYMBOL(generic_buffer_fdatasync);
-EXPORT_SYMBOL(page_hash_bits);
-EXPORT_SYMBOL(page_hash_table);
 EXPORT_SYMBOL(file_lock_list);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);
diff -Nru a/mm/Makefile b/mm/Makefile
--- a/mm/Makefile	Sun Nov 25 16:39:44 2001
+++ b/mm/Makefile	Sun Nov 25 16:39:44 2001
@@ -14,7 +14,7 @@
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
-	    shmem.o
+	    shmem.o page_splay.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Sun Nov 25 16:39:44 2001
+++ b/mm/filemap.c	Sun Nov 25 16:39:44 2001
@@ -31,6 +31,8 @@
 
 #include <linux/highmem.h>
 
+#include "page_splay.h"
+
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -44,8 +46,6 @@
  */
 
 atomic_t page_cache_size = ATOMIC_INIT(0);
-unsigned int page_hash_bits;
-struct page **page_hash_table;
 
 int vm_max_readahead = 31;
 int vm_min_readahead = 3;
@@ -53,35 +53,20 @@
 EXPORT_SYMBOL(vm_min_readahead);
 
 
-spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
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
 spinlock_t pagemap_lru_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
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
 
 static inline void add_page_to_inode_queue(struct address_space *mapping, struct page * page)
 {
@@ -101,18 +86,6 @@
 	page->mapping = NULL;
 }
 
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
@@ -121,18 +94,20 @@
 void __remove_inode_page(struct page *page)
 {
 	if (PageDirty(page)) BUG();
+	page_splay_tree_delete (&page->mapping->root, page->index);
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
@@ -153,10 +128,10 @@
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
@@ -176,11 +151,12 @@
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
@@ -211,7 +187,7 @@
 		continue;
 	}
 
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	spin_unlock(&pagemap_lru_lock);
 }
 
@@ -250,8 +226,9 @@
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
@@ -280,7 +257,7 @@
 				/* Restart on this page */
 				list_add(head, curr);
 
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			unlocked = 1;
 
  			if (!failed) {
@@ -301,7 +278,7 @@
 				schedule();
 			}
 
-			spin_lock(&pagecache_lock);
+			spin_lock(&mapping->i_shared_lock);
 			goto restart;
 		}
 		curr = curr->prev;
@@ -325,24 +302,25 @@
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
@@ -351,7 +329,7 @@
 		list_add_tail(head, curr);
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		truncate_complete_page(page);
 	} else {
 		if (page->buffers) {
@@ -360,7 +338,7 @@
 			list_add_tail(head, curr);
 
 			page_cache_get(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			block_invalidate_page(page);
 		} else
 			unlocked = 0;
@@ -372,8 +350,8 @@
 	return unlocked;
 }
 
-static int FASTCALL(invalidate_list_pages2(struct list_head *));
-static int invalidate_list_pages2(struct list_head *head)
+static int FASTCALL(invalidate_list_pages2(struct address_space *mapping, struct list_head *));
+static int invalidate_list_pages2(struct address_space *mapping, struct list_head *head)
 {
 	struct list_head *curr;
 	struct page * page;
@@ -387,7 +365,7 @@
 		if (!TryLockPage(page)) {
 			int __unlocked;
 
-			__unlocked = invalidate_this_page2(page, curr, head);
+			__unlocked = invalidate_this_page2(mapping, page, curr, head);
 			UnlockPage(page);
 			unlocked |= __unlocked;
 			if (!__unlocked) {
@@ -400,7 +378,7 @@
 			list_add(head, curr);
 
 			page_cache_get(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			unlocked = 1;
 			wait_on_page(page);
 		}
@@ -411,7 +389,7 @@
 			schedule();
 		}
 
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 		goto restart;
 	}
 	return unlocked;
@@ -426,32 +404,13 @@
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
@@ -489,13 +448,14 @@
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
@@ -508,7 +468,7 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		lock_page(page);
 
 		/* The buffers could have been free'd while we waited for the page lock */
@@ -516,11 +476,11 @@
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
@@ -531,17 +491,18 @@
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
@@ -586,7 +547,7 @@
 {
 	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 
         while (!list_empty(&mapping->dirty_pages)) {
 		struct page *page = list_entry(mapping->dirty_pages.next, struct page, list);
@@ -598,7 +559,7 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		lock_page(page);
 
@@ -609,9 +570,9 @@
 			UnlockPage(page);
 
 		page_cache_release(page);
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 /**
@@ -623,7 +584,7 @@
  */
 void filemap_fdatawait(struct address_space * mapping)
 {
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 
         while (!list_empty(&mapping->locked_pages)) {
 		struct page *page = list_entry(mapping->locked_pages.next, struct page, list);
@@ -635,14 +596,14 @@
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
@@ -658,10 +619,11 @@
 
 	page->index = index;
 	page_cache_get(page);
-	spin_lock(&pagecache_lock);
+	spin_lock (&mapping->i_shared_lock);
 	add_page_to_inode_queue(mapping, page);
-	add_page_to_hash_queue(page, page_hash(mapping, index));
-	spin_unlock(&pagecache_lock);
+	page_splay_tree_insert (&mapping->root, page);
+	atomic_inc(&page_cache_size);
+	spin_unlock(&mapping->i_shared_lock);
 
 	lru_cache_add(page);
 }
@@ -671,8 +633,7 @@
  * owned by us, but unreferenced, not uptodate and with no errors.
  */
 static inline void __add_to_page_cache(struct page * page,
-	struct address_space *mapping, unsigned long offset,
-	struct page **hash)
+	struct address_space *mapping, unsigned long offset)
 {
 	unsigned long flags;
 
@@ -681,34 +642,34 @@
 	page_cache_get(page);
 	page->index = offset;
 	add_page_to_inode_queue(mapping, page);
-	add_page_to_hash_queue(page, hash);
+	page_splay_tree_insert (&mapping->root, page);
+	atomic_inc(&page_cache_size);
 }
 
 void add_to_page_cache(struct page * page, struct address_space * mapping, unsigned long offset)
 {
-	spin_lock(&pagecache_lock);
-	__add_to_page_cache(page, mapping, offset, page_hash(mapping, offset));
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	__add_to_page_cache(page, mapping, offset);
+	spin_unlock(&mapping->i_shared_lock);
 	lru_cache_add(page);
 }
 
 int add_to_page_cache_unique(struct page * page,
-	struct address_space *mapping, unsigned long offset,
-	struct page **hash)
+	struct address_space *mapping, unsigned long offset)
 {
 	int err;
 	struct page *alias;
 
-	spin_lock(&pagecache_lock);
-	alias = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	alias = page_splay_tree_find (&mapping->root, offset);
 
 	err = 1;
 	if (!alias) {
-		__add_to_page_cache(page,mapping,offset,hash);
+		__add_to_page_cache(page,mapping,offset);
 		err = 0;
 	}
 
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	if (!err)
 		lru_cache_add(page);
 	return err;
@@ -722,12 +683,11 @@
 static int page_cache_read(struct file * file, unsigned long offset)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct page **hash = page_hash(mapping, offset);
 	struct page *page; 
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	page = page_splay_tree_find (&mapping->root, offset);
+	spin_unlock(&mapping->i_shared_lock);
 	if (page)
 		return 0;
 
@@ -735,7 +695,7 @@
 	if (!page)
 		return -ENOMEM;
 
-	if (!add_to_page_cache_unique(page, mapping, offset, hash)) {
+	if (!add_to_page_cache_unique(page, mapping, offset)) {
 		int error = mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
 		return error;
@@ -844,7 +804,7 @@
  * hashed page atomically.
  */
 struct page * __find_get_page(struct address_space *mapping,
-			      unsigned long offset, struct page **hash)
+			      unsigned long offset)
 {
 	struct page *page;
 
@@ -852,11 +812,11 @@
 	 * We scan the hash list read-only. Addition to and removal from
 	 * the hash-list needs a held write-lock.
 	 */
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	page = page_splay_tree_find (&mapping->root, offset);
 	if (page)
 		page_cache_get(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	return page;
 }
 
@@ -866,15 +826,14 @@
 struct page *find_trylock_page(struct address_space *mapping, unsigned long offset)
 {
 	struct page *page;
-	struct page **hash = page_hash(mapping, offset);
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	page = page_splay_tree_find (&mapping->root, offset);
 	if (page) {
 		if (TryLockPage(page))
 			page = NULL;
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	return page;
 }
 
@@ -883,9 +842,9 @@
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
 
@@ -894,13 +853,13 @@
 	 * the hash-list needs a held write-lock.
 	 */
 repeat:
-	page = __find_page_nolock(mapping, offset, hash);
+	page = page_splay_tree_find (&mapping->root, offset);
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
@@ -918,13 +877,13 @@
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
 
@@ -934,23 +893,22 @@
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
 		page = ERR_PTR(-ENOMEM);
 		if (newpage) {
-			spin_lock(&pagecache_lock);
-			page = __find_lock_page_helper(mapping, index, *hash);
+			spin_lock(&mapping->i_shared_lock);
+			page = __find_lock_page_helper(mapping, index);
 			if (likely(!page)) {
 				page = newpage;
-				__add_to_page_cache(page, mapping, index, hash);
+				__add_to_page_cache(page, mapping, index);
 				newpage = NULL;
 			}
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			if (newpage == NULL)
 				lru_cache_add(page);
 			else 
@@ -977,10 +935,9 @@
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
@@ -1005,7 +962,7 @@
 	if ( unlikely(!page) )
 		return NULL;	/* Failed to allocate a page */
 
-	if ( unlikely(add_to_page_cache_unique(page, mapping, index, hash)) ) {
+	if ( unlikely(add_to_page_cache_unique(page, mapping, index)) ) {
 		/* Someone else grabbed the page already. */
 		page_cache_release(page);
 		return NULL;
@@ -1330,7 +1287,7 @@
 	}
 
 	for (;;) {
-		struct page *page, **hash;
+		struct page *page;
 		unsigned long end_index, nr, ret;
 
 		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
@@ -1349,15 +1306,14 @@
 		/*
 		 * Try to find the data in the page cache..
 		 */
-		hash = page_hash(mapping, index);
 
-		spin_lock(&pagecache_lock);
-		page = __find_page_nolock(mapping, index, *hash);
+		spin_lock(&mapping->i_shared_lock);
+		page = page_splay_tree_find (&mapping->root, index);
 		if (!page)
 			goto no_cached_page;
 found_page:
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		if (!Page_Uptodate(page))
 			goto page_not_up_to_date;
@@ -1451,7 +1407,7 @@
 		 * We get here with the page cache lock held.
 		 */
 		if (!cached_page) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			cached_page = page_cache_alloc(mapping);
 			if (!cached_page) {
 				desc->error = -ENOMEM;
@@ -1462,8 +1418,8 @@
 			 * Somebody may have added the page while we
 			 * dropped the page cache lock. Check for that.
 			 */
-			spin_lock(&pagecache_lock);
-			page = __find_page_nolock(mapping, index, *hash);
+			spin_lock(&mapping->i_shared_lock);
+			page = page_splay_tree_find (&mapping->root, index);
 			if (page)
 				goto found_page;
 		}
@@ -1472,8 +1428,8 @@
 		 * Ok, add the new page to the hash-queues...
 		 */
 		page = cached_page;
-		__add_to_page_cache(page, mapping, index, hash);
-		spin_unlock(&pagecache_lock);
+		__add_to_page_cache(page, mapping, index);
+		spin_unlock(&mapping->i_shared_lock);
 		lru_cache_add(page);		
 		cached_page = NULL;
 
@@ -1873,7 +1829,7 @@
 	struct file *file = area->vm_file;
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	struct inode *inode = mapping->host;
-	struct page *page, **hash;
+	struct page *page;
 	unsigned long size, pgoff, endoff;
 
 	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
@@ -1895,9 +1851,8 @@
 	/*
 	 * Do we have something in the page cache already?
 	 */
-	hash = page_hash(mapping, pgoff);
 retry_find:
-	page = __find_get_page(mapping, pgoff, hash);
+	page = __find_get_page(mapping, pgoff);
 	if (!page)
 		goto no_cached_page;
 
@@ -2582,13 +2537,13 @@
 {
 	unsigned char present = 0;
 	struct address_space * as = vma->vm_file->f_dentry->d_inode->i_mapping;
-	struct page * page, ** hash = page_hash(as, pgoff);
+	struct page * page;
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(as, pgoff, *hash);
+	spin_lock(&as->i_shared_lock);
+	page = page_splay_tree_find (&as->root, pgoff);
 	if ((page) && (Page_Uptodate(page)))
 		present = 1;
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&as->i_shared_lock);
 
 	return present;
 }
@@ -2731,11 +2686,10 @@
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
@@ -2743,7 +2697,7 @@
 				return ERR_PTR(-ENOMEM);
 		}
 		page = cached_page;
-		if (add_to_page_cache_unique(page, mapping, index, hash))
+		if (add_to_page_cache_unique(page, mapping, index))
 			goto repeat;
 		cached_page = NULL;
 		err = filler(data, page);
@@ -2799,9 +2753,9 @@
 static inline struct page * __grab_cache_page(struct address_space *mapping,
 				unsigned long index, struct page **cached_page)
 {
-	struct page *page, **hash = page_hash(mapping, index);
+	struct page *page;
 repeat:
-	page = __find_lock_page(mapping, index, hash);
+	page = __find_lock_page(mapping, index);
 	if (!page) {
 		if (!*cached_page) {
 			*cached_page = page_cache_alloc(mapping);
@@ -2809,7 +2763,7 @@
 				return NULL;
 		}
 		page = *cached_page;
-		if (add_to_page_cache_unique(page, mapping, index, hash))
+		if (add_to_page_cache_unique(page, mapping, index))
 			goto repeat;
 		*cached_page = NULL;
 	}
@@ -3072,29 +3026,3 @@
 	goto out_status;
 }
 
-void __init page_cache_init(unsigned long mempages)
-{
-	unsigned long htable_size, order;
-
-	htable_size = mempages;
-	htable_size *= sizeof(struct page *);
-	for(order = 0; (PAGE_SIZE << order) < htable_size; order++)
-		;
-
-	do {
-		unsigned long tmp = (PAGE_SIZE << order) / sizeof(struct page *);
-
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
-}
diff -Nru a/mm/page_splay.c b/mm/page_splay.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/page_splay.c	Sun Nov 25 16:39:44 2001
@@ -0,0 +1,136 @@
+/* Self-adjusting binary search tree (splay tree).
+ *
+ * Copyright (C) 1999, 2000, 2001 Momchil Velikov
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
+#include <linux/mm.h>
+
+struct page *
+page_splay_tree_splay (struct page *t, unsigned long k)
+{
+	struct page N, *l, *r, *x;
+
+	if (t == 0)
+		return 0;
+
+	N.left = N.right = 0;
+	l = r = &N;
+
+	for (;;) {
+		if (k < t->index) {
+			x = t->left;
+			if (x == 0)
+				break;
+			if (k < x->index) {
+				t->left = x->right;
+				x->right = t;
+				t = x;
+				if (t->left == 0)
+					break;
+			}
+			r->left = t;
+			r = t;
+			t = t->left;
+		} else if (k > t->index) {
+			x = t->right;
+			if (x == 0)
+				break;
+			if (k > x->index) {
+				t->right = x->left;
+				x->left = t;
+				t = x;
+				if (t->right == 0)
+					break;
+			}
+			l->right = t;
+			l = t;
+			t = t->right;
+		}
+		else
+			break;
+	}
+
+	l->right = r->left = 0;
+
+	l->right = t->left;
+	r->left = t->right;
+	t->left = N.right;
+	t->right = N.left;
+
+	return t;
+}
+
+int
+page_splay_tree_insert (struct page **pt, struct page *k)
+{
+	struct page *t;
+
+	t = *pt;
+	if (t == 0) {
+		*pt = k;
+		return 0;
+	}
+
+	t = page_splay_tree_splay (t, k->index);
+
+	if (k->index < t->index) {
+		k->left = t->left;
+		k->right = t;
+		t->left = 0;
+
+		*pt = k;
+		return 0;
+	}
+
+	if (k->index > t->index) {
+		k->right = t->right;
+		k->left = t;
+		t->right = 0;
+
+		*pt = k;
+		return 0;
+	}
+
+	return -1;
+}
+
+struct page *
+page_splay_tree_delete (struct page **r, unsigned long k)
+{
+	struct page *t, *x;
+
+	if ((t = *r) == 0)
+		return 0;
+
+	t = page_splay_tree_splay (t, k);
+
+	if (t->index == k) {
+		if (t->left == 0)
+			x = t->right;
+		else {
+			x = page_splay_tree_splay (t->left, k);
+			x->right = t->right;
+		}
+
+		*r = x;
+
+		t->left = t->right = 0;
+		return t;
+	} else {
+		*r = t;
+		return 0;
+	}
+}
diff -Nru a/mm/page_splay.h b/mm/page_splay.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/page_splay.h	Sun Nov 25 16:39:44 2001
@@ -0,0 +1,36 @@
+/* Self-adjusting binary search tree (splay tree).
+ *
+ * Copyright (C) 1999, 2000, 2001 Momchil Velikov
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
+#ifndef _PAGE_SPLAY_H
+#define _PAGE_SPLAY_H
+
+struct page;
+extern struct page * page_splay_tree_splay (struct page *t, unsigned long k);
+extern int page_splay_tree_insert (struct page **pt, struct page *k);
+extern struct page *page_splay_tree_delete (struct page **r, unsigned long k);
+
+static inline struct page *
+page_splay_tree_find (struct page **r, unsigned long k) {
+	*r = page_splay_tree_splay (*r, k);
+
+	if (*r && (*r)->index == k)
+		return *r;
+	else
+		return 0;
+}
+#endif /* _PAGE_SPLAY_H */
diff -Nru a/mm/swap_state.c b/mm/swap_state.c
--- a/mm/swap_state.c	Sun Nov 25 16:39:44 2001
+++ b/mm/swap_state.c	Sun Nov 25 16:39:44 2001
@@ -75,8 +75,7 @@
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
-	if (add_to_page_cache_unique(page, &swapper_space, entry.val,
-			page_hash(&swapper_space, entry.val)) != 0) {
+	if (add_to_page_cache_unique(page, &swapper_space, entry.val) != 0) {
 		swap_free(entry);
 		INC_CACHE_INFO(exist_race);
 		return -EEXIST;
@@ -121,9 +120,9 @@
 
 	entry.val = page->index;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&swapper_space.i_shared_lock);
 	__delete_from_swap_cache(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&swapper_space.i_shared_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
diff -Nru a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	Sun Nov 25 16:39:44 2001
+++ b/mm/swapfile.c	Sun Nov 25 16:39:44 2001
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
--- a/mm/vmscan.c	Sun Nov 25 16:39:44 2001
+++ b/mm/vmscan.c	Sun Nov 25 16:39:44 2001
@@ -337,6 +337,7 @@
 static int shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int priority)
 {
 	struct list_head * entry;
+	struct address_space *mapping;
 	int max_scan = nr_inactive_pages / priority;
 	int max_mapped = nr_pages << (9 - priority);
 
@@ -391,7 +392,9 @@
 			continue;
 		}
 
-		if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping) {
+		mapping = page->mapping;
+
+		if (PageDirty(page) && is_page_cache_freeable(page) && mapping) {
 			/*
 			 * It is not critical here to write it only if
 			 * the page is unmapped beause any direct writer
@@ -402,7 +405,7 @@
 			 */
 			int (*writepage)(struct page *);
 
-			writepage = page->mapping->a_ops->writepage;
+			writepage = mapping->a_ops->writepage;
 			if ((gfp_mask & __GFP_FS) && writepage) {
 				ClearPageDirty(page);
 				SetPageLaunder(page);
@@ -429,7 +432,7 @@
 			page_cache_get(page);
 
 			if (try_to_release_page(page, gfp_mask)) {
-				if (!page->mapping) {
+				if (!mapping) {
 					/*
 					 * We must not allow an anon page
 					 * with no buffers to be visible on
@@ -466,13 +469,22 @@
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
@@ -492,7 +504,7 @@
 		 * the page is freeable* so not in use by anybody.
 		 */
 		if (PageDirty(page)) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			UnlockPage(page);
 			continue;
 		}
@@ -500,12 +512,12 @@
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
