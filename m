Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRCHVUI>; Thu, 8 Mar 2001 16:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRCHVT7>; Thu, 8 Mar 2001 16:19:59 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:37875 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129741AbRCHVTo>; Thu, 8 Mar 2001 16:19:44 -0500
Date: Thu, 8 Mar 2001 18:10:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <linux-mm@kvack.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] documentation mm.h + swap.h
Message-ID: <Pine.LNX.4.33.0103081807260.1314-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've changed the documentation of mm.h according to the feedback
I got about it yesterday and today and have added documentation
for swap.h

Tomorrow (or maybe even this evening) I will try to write some more
documentation, for other header files with MM structures...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.2-doc/include/linux/mm.h.orig	Wed Mar  7 15:36:32 2001
+++ linux-2.4.2-doc/include/linux/mm.h	Thu Mar  8 09:54:22 2001
@@ -39,32 +39,37 @@
  * library, the executable area etc).
  */
 struct vm_area_struct {
-	struct mm_struct * vm_mm;	/* VM area parameters */
-	unsigned long vm_start;
-	unsigned long vm_end;
+	struct mm_struct * vm_mm;	/* The address space we belong to. */
+	unsigned long vm_start;		/* Our start address within vm_mm. */
+	unsigned long vm_end;		/* Our end address within vm_mm. */

 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next;

-	pgprot_t vm_page_prot;
-	unsigned long vm_flags;
+	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
+	unsigned long vm_flags;		/* Flags, listed below. */

 	/* AVL tree of VM areas per task, sorted by address */
 	short vm_avl_height;
 	struct vm_area_struct * vm_avl_left;
 	struct vm_area_struct * vm_avl_right;

-	/* For areas with an address space and backing store,
+	/*
+	 * For areas with an address space and backing store,
 	 * one of the address_space->i_mmap{,shared} lists,
 	 * for shm areas, the list of attaches, otherwise unused.
 	 */
 	struct vm_area_struct *vm_next_share;
 	struct vm_area_struct **vm_pprev_share;

+	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
-	unsigned long vm_pgoff;		/* offset in PAGE_SIZE units, *not* PAGE_CACHE_SIZE */
-	struct file * vm_file;
-	unsigned long vm_raend;
+
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					   units, *not* PAGE_CACHE_SIZE */
+	struct file * vm_file;		/* File we map to (can be NULL). */
+	unsigned long vm_raend;		/* XXX: put full readahead info here. */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
 };

@@ -90,6 +95,7 @@
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000	/* Memory mapped I/O or similar */

+					/* Used by sys_madvise() */
 #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
 #define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */

@@ -124,37 +130,145 @@
 };

 /*
+ * Each physical page in the system has a struct page associated with
+ * it to keep track of whatever it is we are using the page for at the
+ * moment. Note that we have no way to track which tasks are using
+ * a page.
+ *
  * Try to keep the most commonly accessed fields in single cache lines
  * here (16 bytes or greater).  This ordering should be particularly
  * beneficial on 32-bit processors.
  *
  * The first line is data used in page cache lookup, the second line
  * is used for linear searches (eg. clock algorithm scans).
+ *
+ * TODO: make this structure smaller, it could be as small as 32 bytes.
  */
 typedef struct page {
-	struct list_head list;
-	struct address_space *mapping;
-	unsigned long index;
-	struct page *next_hash;
-	atomic_t count;
-	unsigned long flags;	/* atomic flags, some possibly updated asynchronously */
-	struct list_head lru;
-	unsigned long age;
-	wait_queue_head_t wait;
-	struct page **pprev_hash;
-	struct buffer_head * buffers;
-	void *virtual; /* non-NULL if kmapped */
-	struct zone_struct *zone;
+	struct list_head list;		/* ->mapping has some page lists. */
+	struct address_space *mapping;	/* The inode (or ...) we belong to. */
+	unsigned long index;		/* Our offset within mapping, in
+					   units of PAGE_CACHE_SIZE. */
+	struct page *next_hash;		/* Next page sharing our hash bucket in
+					   the pagecache hash table. */
+	atomic_t count;			/* Usage count, see below. */
+	unsigned long flags;		/* atomic flags, some possibly
+					   updated asynchronously */
+	struct list_head lru;		/* Pageout list, eg. active_list;
+					   protected by pagemap_lru_lock !! */
+	unsigned long age;		/* Page aging counter. */
+	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
+	struct page **pprev_hash;	/* Complement to *next_hash. */
+	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
+	void *virtual;			/* Kernel virtual address (NULL if
+					   not kmapped, ie. highmem) */
+	struct zone_struct *zone;	/* Memory zone we are in. */
 } mem_map_t;

+/*
+ * Methods to modify the page usage count.
+ *
+ * What counts for a page usage:
+ * - cache mapping   (page->mapping)
+ * - disk mapping    (page->buffers)
+ * - page mapped in a task's page tables, each mapping
+ *   is counted separately
+ *
+ * Also, many kernel routines increase the page count before a critical
+ * routine so they can be sure the page doesn't go away from under them.
+ */
 #define get_page(p)		atomic_inc(&(p)->count)
 #define put_page(p)		__free_page(p)
 #define put_page_testzero(p) 	atomic_dec_and_test(&(p)->count)
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)

-/* Page flag bit values */
-#define PG_locked		 0
+/*
+ * Various page->flags bits:
+ *
+ * PG_reserved is set for special pages, which can never be swapped
+ * out. Some of them might not even exist (eg. empty_bad_page)...
+ *
+ * Multiple processes may "see" the same page. E.g. for untouched
+ * mappings of /dev/null, all processes see the same page full of
+ * zeroes, and text pages of executables and shared libraries have
+ * only one copy in memory, at most, normally.
+ *
+ * For the non-reserved pages, page->count denotes a reference count.
+ *   page->count == 0 means the page is free.
+ *   page->count == 1 means the page is used for exactly one purpose
+ *   (e.g. a private data page of one process).
+ *
+ * A page may be used for kmalloc() or anyone else who does a
+ * __get_free_page(). In this case the page->count is at least 1, and
+ * all other fields are unused but should be 0 or NULL. The
+ * management of this page is the responsibility of the one who uses
+ * it.
+ *
+ * The other pages (we may call them "process pages") are completely
+ * managed by the Linux memory manager: I/O, buffers, swapping etc.
+ * The following discussion applies only to them.
+ *
+ * A page may belong to an inode's memory mapping. In this case,
+ * page->mapping is the pointer to the inode, and page->index is the
+ * file offset of the page, in units of PAGE_CACHE_SIZE.
+ *
+ * A page may have buffers allocated to it. In this case,
+ * page->buffers is a circular list of these buffer heads. Else,
+ * page->buffers == NULL.
+ *
+ * For pages belonging to inodes, the page->count is the number of
+ * attaches, plus 1 if buffers are allocated to the page, plus one
+ * for the page cache itself.
+ *
+ * All pages belonging to an inode are in these doubly linked lists:
+ * mapping->clean_pages, mapping->dirty_pages and mapping->locked_pages;
+ * using the page->list list_head. These fields are also used for
+ * freelist managemet (when page->count==0).
+ *
+ * There is also a hash table mapping (inode,offset) to the page
+ * in memory if present. The lists for this hash table use the fields
+ * page->next_hash and page->pprev_hash.
+ *
+ * All process pages can do I/O:
+ * - inode pages may need to be read from disk,
+ * - inode pages which have been modified and are MAP_SHARED may need
+ *   to be written to disk,
+ * - private pages which have been modified may need to be swapped out
+ *   to swap space and (later) to be read back into memory.
+ * During disk I/O, PG_locked is used. This bit is set before I/O
+ * and reset when I/O completes. page->wait is a wait queue of all
+ * tasks waiting for the I/O on this page to complete.
+ * PG_uptodate tells whether the page's contents is valid.
+ * When a read completes, the page becomes uptodate, unless a disk I/O
+ * error happened.
+ *
+ * For choosing which pages to swap out, inode pages carry a
+ * PG_referenced bit, which is set any time the system accesses
+ * that page through the (inode,offset) hash table. This referenced
+ * bit, together with the referenced bit in the page tables, is used
+ * to manipulate page->age and move the page across the active,
+ * inactive_dirty and inactive_clean lists.
+ *
+ * Note that the referenced bit, the page->lru list_head and the
+ * active, inactive_dirty and inactive_clean lists are protected by
+ * the pagemap_lru_lock, and *NOT* by the usual PG_locked bit!
+ *
+ * PG_skip is used on sparc/sparc64 architectures to "skip" certain
+ * parts of the address space.
+ *
+ * PG_error is set to indicate that an I/O error occurred on this page.
+ *
+ * PG_arch_1 is an architecture specific page state bit.  The generic
+ * code guarentees that this bit is cleared for a page when it first
+ * is entered into the page cache.
+ *
+ * PG_highmem pages are not permanently mapped into the kernel virtual
+ * address space, they need to be kmapped separately for doing IO on
+ * the pages. The struct page (these bits with information) are always
+ * mapped into kernel address space...
+ */
+#define PG_locked		 0	/* Page is locked. Don't touch. */
 #define PG_error		 1
 #define PG_referenced		 2
 #define PG_uptodate		 3
@@ -254,81 +368,7 @@
 #define NOPAGE_SIGBUS	(NULL)
 #define NOPAGE_OOM	((struct page *) (-1))

-
-/*
- * Various page->flags bits:
- *
- * PG_reserved is set for a page which must never be accessed (which
- * may not even be present).
- *
- * PG_DMA has been removed, page->zone now tells exactly wether the
- * page is suited to do DMAing into.
- *
- * Multiple processes may "see" the same page. E.g. for untouched
- * mappings of /dev/null, all processes see the same page full of
- * zeroes, and text pages of executables and shared libraries have
- * only one copy in memory, at most, normally.
- *
- * For the non-reserved pages, page->count denotes a reference count.
- *   page->count == 0 means the page is free.
- *   page->count == 1 means the page is used for exactly one purpose
- *   (e.g. a private data page of one process).
- *
- * A page may be used for kmalloc() or anyone else who does a
- * __get_free_page(). In this case the page->count is at least 1, and
- * all other fields are unused but should be 0 or NULL. The
- * management of this page is the responsibility of the one who uses
- * it.
- *
- * The other pages (we may call them "process pages") are completely
- * managed by the Linux memory manager: I/O, buffers, swapping etc.
- * The following discussion applies only to them.
- *
- * A page may belong to an inode's memory mapping. In this case,
- * page->inode is the pointer to the inode, and page->offset is the
- * file offset of the page (not necessarily a multiple of PAGE_SIZE).
- *
- * A page may have buffers allocated to it. In this case,
- * page->buffers is a circular list of these buffer heads. Else,
- * page->buffers == NULL.
- *
- * For pages belonging to inodes, the page->count is the number of
- * attaches, plus 1 if buffers are allocated to the page.
- *
- * All pages belonging to an inode make up a doubly linked list
- * inode->i_pages, using the fields page->next and page->prev. (These
- * fields are also used for freelist management when page->count==0.)
- * There is also a hash table mapping (inode,offset) to the page
- * in memory if present. The lists for this hash table use the fields
- * page->next_hash and page->pprev_hash.
- *
- * All process pages can do I/O:
- * - inode pages may need to be read from disk,
- * - inode pages which have been modified and are MAP_SHARED may need
- *   to be written to disk,
- * - private pages which have been modified may need to be swapped out
- *   to swap space and (later) to be read back into memory.
- * During disk I/O, PG_locked is used. This bit is set before I/O
- * and reset when I/O completes. page->wait is a wait queue of all
- * tasks waiting for the I/O on this page to complete.
- * PG_uptodate tells whether the page's contents is valid.
- * When a read completes, the page becomes uptodate, unless a disk I/O
- * error happened.
- *
- * For choosing which pages to swap out, inode pages carry a
- * PG_referenced bit, which is set any time the system accesses
- * that page through the (inode,offset) hash table.
- *
- * PG_skip is used on sparc/sparc64 architectures to "skip" certain
- * parts of the address space.
- *
- * PG_error is set to indicate that an I/O error occurred on this page.
- *
- * PG_arch_1 is an architecture specific page state bit.  The generic
- * code guarentees that this bit is cleared for a page when it first
- * is entered into the page cache.
- */
-
+/* The array of struct pages */
 extern mem_map_t * mem_map;

 /*
@@ -522,11 +562,6 @@
 }

 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
-
-#define buffer_under_min()	(atomic_read(&buffermem_pages) * 100 < \
-				buffer_mem.min_percent * num_physpages)
-#define pgcache_under_min()	(atomic_read(&page_cache_size) * 100 < \
-				page_cache.min_percent * num_physpages)

 #endif /* __KERNEL__ */

--- linux-2.4.2-doc/include/linux/swap.h.orig	Wed Mar  7 15:36:37 2001
+++ linux-2.4.2-doc/include/linux/swap.h	Thu Mar  8 09:54:02 2001
@@ -10,11 +10,23 @@

 #define MAX_SWAPFILES 8

+/*
+ * Magic header for a swap area. The first part of the union is
+ * what the swap magic looks like for the old (limited to 128MB)
+ * swap area format, the second part of the union adds - in the
+ * old reserved area - some extra information. Note that the first
+ * kilobyte is reserved for boot loader or disk label stuff...
+ *
+ * Having the magic at the end of the PAGE_SIZE makes detecting swap
+ * areas somewhat tricky on machines that support multiple page sizes.
+ * For 2.5 we'll probably want to move the magic to just beyond the
+ * bootbits...
+ */
 union swap_header {
 	struct
 	{
 		char reserved[PAGE_SIZE - 10];
-		char magic[10];
+		char magic[10];			/* SWAP-SPACE or SWAPSPACE2 */
 	} magic;
 	struct
 	{
@@ -46,6 +58,9 @@
 #define SWAP_MAP_MAX	0x7fff
 #define SWAP_MAP_BAD	0x8000

+/*
+ * The in-memory structure used to track swap areas.
+ */
 struct swap_info_struct {
 	unsigned int flags;
 	kdev_t swap_device;

