Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293479AbSBZCPx>; Mon, 25 Feb 2002 21:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293480AbSBZCPj>; Mon, 25 Feb 2002 21:15:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:56338 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293479AbSBZCPY>;
	Mon, 25 Feb 2002 21:15:24 -0500
Date: Mon, 25 Feb 2002 23:14:44 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: [PATCH] struct page #2
Message-ID: <Pine.LNX.4.33L.0202252310380.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Dave,

Here is the second version of the struct page shrinkage patch,
it includes davem's suggestion of accessing page->count only
through the atomic_t macros.

Reduce the size of struct page. The changes are:
 o page->wait is removed, instead we use a hash table of wait queues
   per zone ... collisions are ok because of wake-all semantics
 o page->virtual is only used on highmem machines and sparc64,
   other machines calculate the address instead
 o page->zone is folded into page->flags

Please include for 2.4.19-pre2.

thank you,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/



# This is a BitKeeper generated patch for the following project:
# Project Name: The Linux 2.4 Kernel
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.156.1.2 -> 1.159
#	include/asm-sparc64/pgtable.h	1.14    -> 1.15
#	include/linux/mmzone.h	1.6     -> 1.7
#	drivers/char/agp/agpgart_be.c	1.22    -> 1.23
#	include/asm-s390/pgtable.h	1.4     -> 1.5
#	         mm/vmscan.c	1.56    -> 1.57
#	drivers/char/drm/i810_dma.c	1.5     -> 1.6
#	include/asm-i386/pgtable.h	1.4     -> 1.5
#	include/asm-s390x/pgtable.h	1.4     -> 1.5
#	include/asm-sparc/pgtable.h	1.4     -> 1.5
#	include/asm-sh/pgtable.h	1.6     -> 1.7
#	include/asm-arm/pgtable.h	1.5     -> 1.6
#	         fs/buffer.c	1.54    -> 1.55
#	        mm/filemap.c	1.53    -> 1.54
#	  include/linux/mm.h	1.34    -> 1.36
#	     mm/page_alloc.c	1.40    -> 1.42
#	include/asm-mips/pgtable.h	1.3     -> 1.4
#	drivers/char/drm-4.0/i810_dma.c	1.1     -> 1.2
#	include/linux/pagemap.h	1.16    -> 1.17
#	include/asm-alpha/pgtable.h	1.7     -> 1.8
#	         mm/Makefile	1.3.1.1 -> 1.5
#	include/asm-mips64/pgtable.h	1.3     -> 1.4
#	include/asm-sparc64/page.h	1.3     -> 1.4
#	include/asm-ia64/pgtable.h	1.6     -> 1.7
#	include/asm-cris/pgtable.h	1.5     -> 1.6
#	include/asm-parisc/pgtable.h	1.2     -> 1.3
#	include/asm-ppc/pgtable.h	1.7     -> 1.8
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/25	riel@imladris.surriel.com	1.158
# merge the mm/Makefile changes by hand
# --------------------------------------------
# 02/02/25	riel@imladris.surriel.com	1.159
# replace init_page_count(page) by set_page_count(page, 0) to avoid
# direct access to the opaque type atomic_t  (as suggested by DaveM)
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Mon Feb 25 23:10:17 2002
+++ b/drivers/char/agp/agpgart_be.c	Mon Feb 25 23:10:17 2002
@@ -830,7 +830,7 @@
 	page = virt_to_page(pt);
 	atomic_dec(&page->count);
 	clear_bit(PG_locked, &page->flags);
-	wake_up(&page->wait);
+	wake_up_page(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
@@ -2835,7 +2835,7 @@
 	page = virt_to_page(pt);
 	atomic_dec(&page->count);
 	clear_bit(PG_locked, &page->flags);
-	wake_up(&page->wait);
+	wake_up_page(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Mon Feb 25 23:10:17 2002
+++ b/drivers/char/drm/i810_dma.c	Mon Feb 25 23:10:17 2002
@@ -294,14 +294,13 @@

 static void i810_free_page(drm_device_t *dev, unsigned long page)
 {
-	if(page == 0UL)
-		return;
-
-	atomic_dec(&virt_to_page(page)->count);
-	clear_bit(PG_locked, &virt_to_page(page)->flags);
-	wake_up(&virt_to_page(page)->wait);
-	free_page(page);
-	return;
+	if (page) {
+		struct page *p = virt_to_page(page);
+		atomic_dec(p);
+		clear_bit(PG_locked, &p->flags);
+		wake_up_page(p);
+		free_page(page);
+	}
 }

 static int i810_dma_cleanup(drm_device_t *dev)
diff -Nru a/drivers/char/drm-4.0/i810_dma.c b/drivers/char/drm-4.0/i810_dma.c
--- a/drivers/char/drm-4.0/i810_dma.c	Mon Feb 25 23:10:17 2002
+++ b/drivers/char/drm-4.0/i810_dma.c	Mon Feb 25 23:10:17 2002
@@ -288,12 +288,13 @@

 static void i810_free_page(drm_device_t *dev, unsigned long page)
 {
+	struct page * p = virt_to_page(page);
 	if(page == 0UL)
 		return;

-	atomic_dec(&virt_to_page(page)->count);
-	clear_bit(PG_locked, &virt_to_page(page)->flags);
-	wake_up(&virt_to_page(page)->wait);
+	atomic_dec(p->count);
+	clear_bit(PG_locked, p->flags);
+	wake_up_page(p);
 	free_page(page);
 	return;
 }
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Mon Feb 25 23:10:17 2002
+++ b/fs/buffer.c	Mon Feb 25 23:10:17 2002
@@ -2257,8 +2257,7 @@
  * of kiobuf structs (much like a user-space iovec list).
  *
  * The kiobuf must already be locked for IO.  IO is submitted
- * asynchronously: you need to check page->locked, page->uptodate, and
- * maybe wait on page->wait.
+ * asynchronously: you need to check page->locked and page->uptodate.
  *
  * It is up to the caller to make sure that there are enough blocks
  * passed in to completely map the iobufs to disk.
@@ -2391,8 +2390,8 @@
 /*
  * Start I/O on a page.
  * This function expects the page to be locked and may return
- * before I/O is complete. You then have to check page->locked,
- * page->uptodate, and maybe wait on page->wait.
+ * before I/O is complete. You then have to check page->locked
+ * and page->uptodate.
  *
  * brw_page() is SMP-safe, although it's being called with the
  * kernel lock held - but the code is ready.
diff -Nru a/include/asm-alpha/pgtable.h b/include/asm-alpha/pgtable.h
--- a/include/asm-alpha/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-alpha/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -268,8 +268,6 @@
 extern inline int pgd_present(pgd_t pgd)	{ return pgd_val(pgd) & _PAGE_VALID; }
 extern inline void pgd_clear(pgd_t * pgdp)	{ pgd_val(*pgdp) = 0; }

-#define page_address(page)	((page)->virtual)
-
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
diff -Nru a/include/asm-arm/pgtable.h b/include/asm-arm/pgtable.h
--- a/include/asm-arm/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-arm/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -98,7 +98,6 @@
 /*
  * Permanent address of a page. We never have highmem, so this is trivial.
  */
-#define page_address(page)	((page)->virtual)
 #define pages_to_mb(x)		((x) >> (20 - PAGE_SHIFT))

 /*
diff -Nru a/include/asm-cris/pgtable.h b/include/asm-cris/pgtable.h
--- a/include/asm-cris/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-cris/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -438,7 +438,6 @@

 /* permanent address of a page */

-#define page_address(page)      ((page)->virtual)
 #define __page_address(page)    (PAGE_OFFSET + (((page) - mem_map) << PAGE_SHIFT))
 #define pte_page(pte)           (mem_map+pte_pagenr(pte))

diff -Nru a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-i386/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -263,11 +263,7 @@
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)

-/*
- * Permanent address of a page. Obviously must never be
- * called on a highmem page.
- */
-#define page_address(page) ((page)->virtual)
+
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))

 /*
diff -Nru a/include/asm-ia64/pgtable.h b/include/asm-ia64/pgtable.h
--- a/include/asm-ia64/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-ia64/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -165,11 +165,6 @@
  * addresses:
  */

-/*
- * Given a pointer to an mem_map[] entry, return the kernel virtual
- * address corresponding to that page.
- */
-#define page_address(page)	((page)->virtual)

 /* Quick test to see if ADDR is a (potentially) valid physical address. */
 static inline long
diff -Nru a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
--- a/include/asm-mips/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-mips/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -329,11 +329,6 @@
 extern inline int pgd_present(pgd_t pgd)	{ return 1; }
 extern inline void pgd_clear(pgd_t *pgdp)	{ }

-/*
- * Permanent address of a page.  On MIPS we never have highmem, so this
- * is simple.
- */
-#define page_address(page)	((page)->virtual)
 #ifdef CONFIG_CPU_VR41XX
 #define pte_page(x)             (mem_map+(unsigned long)((pte_val(x) >> (PAGE_SHIFT + 2))))
 #else
diff -Nru a/include/asm-mips64/pgtable.h b/include/asm-mips64/pgtable.h
--- a/include/asm-mips64/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-mips64/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -366,11 +366,6 @@
 	pgd_val(*pgdp) = ((unsigned long) invalid_pmd_table);
 }

-/*
- * Permanent address of a page.  On MIPS64 we never have highmem, so this
- * is simple.
- */
-#define page_address(page)	((page)->virtual)
 #ifndef CONFIG_DISCONTIGMEM
 #define pte_page(x)		(mem_map+(unsigned long)((pte_val(x) >> PAGE_SHIFT)))
 #else
diff -Nru a/include/asm-parisc/pgtable.h b/include/asm-parisc/pgtable.h
--- a/include/asm-parisc/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-parisc/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -275,7 +275,6 @@
  * Permanent address of a page. Obviously must never be
  * called on a highmem page.
  */
-#define page_address(page) ({ if (!(page)->virtual) BUG(); (page)->virtual; })
 #define __page_address(page) ({ if (PageHighMem(page)) BUG(); PAGE_OFFSET + (((page) - mem_map) << PAGE_SHIFT); })
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
 #define pte_page(x) (mem_map+pte_pagenr(x))
diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-ppc/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -341,10 +341,6 @@
 #define	pmd_present(pmd)	((pmd_val(pmd) & PAGE_MASK) != 0)
 #define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)

-/*
- * Permanent address of a page.
- */
-#define page_address(page)	((page)->virtual)
 #define pte_page(x)		(mem_map+(unsigned long)((pte_val(x) >> PAGE_SHIFT)))

 #ifndef __ASSEMBLY__
diff -Nru a/include/asm-s390/pgtable.h b/include/asm-s390/pgtable.h
--- a/include/asm-s390/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-s390/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -238,10 +238,6 @@
 	*pteptr = pteval;
 }

-/*
- * Permanent address of a page.
- */
-#define page_address(page) ((page)->virtual)
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))

 /*
diff -Nru a/include/asm-s390x/pgtable.h b/include/asm-s390x/pgtable.h
--- a/include/asm-s390x/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-s390x/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -233,10 +233,6 @@
 	*pteptr = pteval;
 }

-/*
- * Permanent address of a page.
- */
-#define page_address(page) ((page)->virtual)
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))

 /*
diff -Nru a/include/asm-sh/pgtable.h b/include/asm-sh/pgtable.h
--- a/include/asm-sh/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-sh/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -206,11 +206,6 @@
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)

-/*
- * Permanent address of a page. Obviously must never be
- * called on a highmem page.
- */
-#define page_address(page)  ((page)->virtual) /* P1 address of the page */
 #define pages_to_mb(x)	((x) >> (20-PAGE_SHIFT))
 #define pte_page(x) 	phys_to_page(pte_val(x)&PTE_PHYS_MASK)

diff -Nru a/include/asm-sparc/pgtable.h b/include/asm-sparc/pgtable.h
--- a/include/asm-sparc/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-sparc/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -293,9 +293,6 @@
 #define page_pte_prot(page, prot)	mk_pte(page, prot)
 #define page_pte(page)			page_pte_prot(page, __pgprot(0))

-/* Permanent address of a page. */
-#define page_address(page)  ((page)->virtual)
-
 BTFIXUPDEF_CALL(struct page *, pte_page, pte_t)
 #define pte_page(pte) BTFIXUP_CALL(pte_page)(pte)

diff -Nru a/include/asm-sparc64/page.h b/include/asm-sparc64/page.h
--- a/include/asm-sparc64/page.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-sparc64/page.h	Mon Feb 25 23:10:17 2002
@@ -30,6 +30,9 @@

 #define PAGE_BUG(page)	BUG()

+/* Sparc64 is slow at multiplication, we prefer to use some extra space. */
+#define WANT_PAGE_VIRTUAL 1
+
 extern void _clear_page(void *page);
 #define clear_page(X)	_clear_page((void *)(X))
 extern void clear_user_page(void *page, unsigned long vaddr);
diff -Nru a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
--- a/include/asm-sparc64/pgtable.h	Mon Feb 25 23:10:17 2002
+++ b/include/asm-sparc64/pgtable.h	Mon Feb 25 23:10:17 2002
@@ -243,8 +243,7 @@
 #define pte_mkold(pte)		(__pte(((pte_val(pte)<<1UL)>>1UL) & ~_PAGE_ACCESSED))

 /* Permanent address of a page. */
-#define __page_address(page)	((page)->virtual)
-#define page_address(page)	({ __page_address(page); })
+#define __page_address(page)	page_address(page)

 #define pte_page(x) (mem_map+(((pte_val(x)&_PAGE_PADDR)-phys_base)>>PAGE_SHIFT))

diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Mon Feb 25 23:10:17 2002
+++ b/include/linux/mm.h	Mon Feb 25 23:10:17 2002
@@ -159,12 +159,23 @@
 					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by pagemap_lru_lock !! */
-	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
 	struct page **pprev_hash;	/* Complement to *next_hash. */
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
+
+	/*
+	 * On machines where all RAM is mapped into kernel address space,
+	 * we can simply calculate the virtual address. On machines with
+	 * highmem some memory is mapped into kernel virtual memory
+	 * dynamically, so we need a place to store that address.
+	 * Note that this field could be 16 bits on x86 ... ;)
+	 *
+	 * Architectures with slow multiplication can define
+	 * WANT_PAGE_VIRTUAL in asm/page.h
+	 */
+#if defined(CONFIG_HIGHMEM) || defined(WANT_PAGE_VIRTUAL)
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
-	struct zone_struct *zone;	/* Memory zone we are in. */
+#endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
 } mem_map_t;

 /*
@@ -239,7 +250,7 @@
  * - private pages which have been modified may need to be swapped out
  *   to swap space and (later) to be read back into memory.
  * During disk I/O, PG_locked is used. This bit is set before I/O
- * and reset when I/O completes. page->wait is a wait queue of all
+ * and reset when I/O completes. page_waitqueue(page) is a wait queue of all
  * tasks waiting for the I/O on this page to complete.
  * PG_uptodate tells whether the page's contents is valid.
  * When a read completes, the page becomes uptodate, unless a disk I/O
@@ -301,6 +312,61 @@
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
+#define __SetPageReserved(page)	__set_bit(PG_reserved, &(page)->flags)
+
+/*
+ * The zone field is never updated after free_area_init_core()
+ * sets it, so none of the operations on it need to be atomic.
+ */
+#define NODE_SHIFT 4
+#define ZONE_SHIFT (BITS_PER_LONG - 8)
+
+struct zone_struct;
+extern struct zone_struct *zone_table[];
+
+static inline zone_t *page_zone(struct page *page)
+{
+	return zone_table[page->flags >> ZONE_SHIFT];
+}
+
+static inline void set_page_zone(struct page *page, unsigned long zone_num)
+{
+	page->flags &= ~(~0UL << ZONE_SHIFT);
+	page->flags |= zone_num << ZONE_SHIFT;
+}
+
+/*
+ * In order to avoid #ifdefs within C code itself, we define
+ * set_page_address to a noop for non-highmem machines, where
+ * the field isn't useful.
+ * The same is true for page_address() in arch-dependent code.
+ */
+#if defined(CONFIG_HIGHMEM) || defined(WANT_PAGE_VIRTUAL)
+
+#define set_page_address(page, address)			\
+	do {						\
+		(page)->virtual = (address);		\
+	} while(0)
+
+#else /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
+#define set_page_address(page, address)  do { } while(0)
+#endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
+
+/*
+ * Permanent address of a page. Obviously must never be
+ * called on a highmem page.
+ */
+#if defined(CONFIG_HIGHMEM) || defined(WANT_PAGE_VIRTUAL)
+
+#define page_address(page) ((page)->virtual)
+
+#else /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */
+
+#define page_address(page)						\
+	__va( (((page) - page_zone(page)->zone_mem_map) << PAGE_SHIFT)	\
+			+ page_zone(page)->zone_start_paddr)
+
+#endif /* CONFIG_HIGHMEM || WANT_PAGE_VIRTUAL */

 extern void FASTCALL(set_page_dirty(struct page *));

diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Mon Feb 25 23:10:17 2002
+++ b/include/linux/mmzone.h	Mon Feb 25 23:10:17 2002
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/wait.h>

 /*
  * Free memory management - zoned buddy allocator.
@@ -48,6 +49,35 @@
 	free_area_t		free_area[MAX_ORDER];

 	/*
+	 * wait_table		-- the array holding the hash table
+	 * wait_table_size	-- the size of the hash table array
+	 * wait_table_shift	-- wait_table_size
+	 * 				== BITS_PER_LONG (1 << wait_table_bits)
+	 *
+	 * The purpose of all these is to keep track of the people
+	 * waiting for a page to become available and make them
+	 * runnable again when possible. The trouble is that this
+	 * consumes a lot of space, especially when so few things
+	 * wait on pages at a given time. So instead of using
+	 * per-page waitqueues, we use a waitqueue hash table.
+	 *
+	 * The bucket discipline is to sleep on the same queue when
+	 * colliding and wake all in that wait queue when removing.
+	 * When something wakes, it must check to be sure its page is
+	 * truly available, a la thundering herd. The cost of a
+	 * collision is great, but given the expected load of the
+	 * table, they should be so rare as to be outweighed by the
+	 * benefits from the saved space.
+	 *
+	 * __wait_on_page() and unlock_page() in mm/filemap.c, are the
+	 * primary users of these fields, and in mm/page_alloc.c
+	 * free_area_init_core() performs the initialization of them.
+	 */
+	wait_queue_head_t	* wait_table;
+	unsigned long		wait_table_size;
+	unsigned long		wait_table_shift;
+
+	/*
 	 * Discontig memory support fields.
 	 */
 	struct pglist_data	*zone_pgdat;
@@ -132,10 +162,14 @@

 #define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
+#define MAX_NR_NODES		1

 #else /* !CONFIG_DISCONTIGMEM */

 #include <asm/mmzone.h>
+
+/* page->zone is currently 8 bits ... */
+#define MAX_NR_NODES		(255 / MAX_NR_ZONES)

 #endif /* !CONFIG_DISCONTIGMEM */

diff -Nru a/include/linux/pagemap.h b/include/linux/pagemap.h
--- a/include/linux/pagemap.h	Mon Feb 25 23:10:17 2002
+++ b/include/linux/pagemap.h	Mon Feb 25 23:10:17 2002
@@ -97,6 +97,8 @@
 		___wait_on_page(page);
 }

+extern void wake_up_page(struct page *);
+
 extern struct page * grab_cache_page (struct address_space *, unsigned long);
 extern struct page * grab_cache_page_nowait (struct address_space *, unsigned long);

diff -Nru a/mm/Makefile b/mm/Makefile
--- a/mm/Makefile	Mon Feb 25 23:10:17 2002
+++ b/mm/Makefile	Mon Feb 25 23:10:17 2002
@@ -9,7 +9,7 @@

 O_TARGET := mm.o

-export-objs := shmem.o filemap.o memory.o
+export-objs := shmem.o filemap.o memory.o page_alloc.o

 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Mon Feb 25 23:10:17 2002
+++ b/mm/filemap.c	Mon Feb 25 23:10:17 2002
@@ -745,6 +745,67 @@
 	return 0;
 }

+/*
+ * Knuth recommends primes in approximately golden ratio to the maximum
+ * integer representable by a machine word for multiplicative hashing.
+ * Chuck Lever verified the effectiveness of this technique:
+ * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ *
+ * These primes are chosen to be bit-sparse, that is operations on
+ * them can use shifts and additions instead of multiplications for
+ * machines where multiplications are slow.
+ */
+#if BITS_PER_LONG == 32
+/* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e370001UL
+#elif BITS_PER_LONG == 64
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
+#else
+#error Define GOLDEN_RATIO_PRIME for your wordsize.
+#endif
+
+/*
+ * In order to wait for pages to become available there must be
+ * waitqueues associated with pages. By using a hash table of
+ * waitqueues where the bucket discipline is to maintain all
+ * waiters on the same queue and wake all when any of the pages
+ * become available, and for the woken contexts to check to be
+ * sure the appropriate page became available, this saves space
+ * at a cost of "thundering herd" phenomena during rare hash
+ * collisions.
+ */
+static inline wait_queue_head_t *page_waitqueue(struct page *page)
+{
+	const zone_t *zone = page_zone(page);
+	wait_queue_head_t *wait = zone->wait_table;
+	unsigned long hash = (unsigned long)page;
+
+#if BITS_PER_LONG == 64
+	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
+	unsigned long n = hash;
+	n <<= 18;
+	hash -= n;
+	n <<= 33;
+	hash -= n;
+	n <<= 3;
+	hash += n;
+	n <<= 3;
+	hash -= n;
+	n <<= 4;
+	hash += n;
+	n <<= 2;
+	hash += n;
+#else
+	/* On some cpus multiply is faster, on others gcc will do shifts */
+	hash *= GOLDEN_RATIO_PRIME;
+#endif
+
+	hash >>= zone->wait_table_shift;
+
+	return &wait[hash];
+}
+
 /*
  * Wait for a page to get unlocked.
  *
@@ -754,10 +815,11 @@
  */
 void ___wait_on_page(struct page *page)
 {
+	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);

-	add_wait_queue(&page->wait, &wait);
+	add_wait_queue(waitqueue, &wait);
 	do {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!PageLocked(page))
@@ -765,19 +827,23 @@
 		sync_page(page);
 		schedule();
 	} while (PageLocked(page));
-	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&page->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(waitqueue, &wait);
 }

+/*
+ * Unlock the page and wake up sleepers in ___wait_on_page.
+ */
 void unlock_page(struct page *page)
 {
+	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	clear_bit(PG_launder, &(page)->flags);
 	smp_mb__before_clear_bit();
 	if (!test_and_clear_bit(PG_locked, &(page)->flags))
 		BUG();
 	smp_mb__after_clear_bit();
-	if (waitqueue_active(&(page)->wait))
-	wake_up(&(page)->wait);
+	if (waitqueue_active(waitqueue))
+		wake_up_all(waitqueue);
 }

 /*
@@ -786,10 +852,11 @@
  */
 static void __lock_page(struct page *page)
 {
+	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);

-	add_wait_queue_exclusive(&page->wait, &wait);
+	add_wait_queue_exclusive(waitqueue, &wait);
 	for (;;) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
@@ -799,10 +866,15 @@
 		if (!TryLockPage(page))
 			break;
 	}
-	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&page->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(waitqueue, &wait);
+}
+
+void wake_up_page(struct page *page)
+{
+	wake_up(page_waitqueue(page));
 }
-
+EXPORT_SYMBOL(wake_up_page);

 /*
  * Get an exclusive lock on the page, optimistically
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Mon Feb 25 23:10:17 2002
+++ b/mm/page_alloc.c	Mon Feb 25 23:10:17 2002
@@ -1,6 +1,9 @@
 /*
  *  linux/mm/page_alloc.c
  *
+ *  Manages the free list, the system allocates free pages here.
+ *  Note that kmalloc() lives in slab.c
+ *
  *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
  *  Swap reorganised 29.12.95, Stephen Tweedie
  *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
@@ -18,6 +21,7 @@
 #include <linux/bootmem.h>
 #include <linux/slab.h>
 #include <linux/compiler.h>
+#include <linux/module.h>

 int nr_swap_pages;
 int nr_active_pages;
@@ -26,6 +30,10 @@
 struct list_head active_list;
 pg_data_t *pgdat_list;

+/* Used to look up the address of the struct zone encoded in page->zone */
+zone_t *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
+EXPORT_SYMBOL(zone_table);
+
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 static int zone_balance_ratio[MAX_NR_ZONES] __initdata = { 128, 128, 128, };
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
@@ -54,12 +62,31 @@
 /*
  * Temporary debugging check.
  */
-#define BAD_RANGE(zone,x) (((zone) != (x)->zone) || (((x)-mem_map) < (zone)->zone_start_mapnr) || (((x)-mem_map) >= (zone)->zone_start_mapnr+(zone)->size))
+#define BAD_RANGE(zone, page)						\
+(									\
+	(((page) - mem_map) >= ((zone)->zone_start_mapnr+(zone)->size))	\
+	|| (((page) - mem_map) < (zone)->zone_start_mapnr)		\
+	|| ((zone) != page_zone(page))					\
+)

 /*
- * Buddy system. Hairy. You really aren't expected to understand this
+ * Freeing function for a buddy system allocator.
+ *
+ * The concept of a buddy system is to maintain direct-mapped table
+ * (containing bit values) for memory blocks of various "orders".
+ * The bottom level table contains the map for the smallest allocatable
+ * units of memory (here, pages), and each level above it describes
+ * pairs of units from the levels below, hence, "buddies".
+ * At a high level, all that happens here is marking the table entry
+ * at the bottom level available, and propagating the changes upward
+ * as necessary, plus some accounting needed to play nicely with other
+ * parts of the VM system.
+ *
+ * TODO: give references to descriptions of buddy system allocators,
+ * describe precisely the silly trick buddy allocators use to avoid
+ * storing an extra bit, utilizing entry point information.
  *
- * Hint: -mask = 1+~mask
+ * -- wli
  */

 static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
@@ -96,7 +123,7 @@
 		goto local_freelist;
  back_local_freelist:

-	zone = page->zone;
+	zone = page_zone(page);

 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
@@ -123,6 +150,8 @@
 			break;
 		/*
 		 * Move the buddy up one level.
+		 * This code is taking advantage of the identity:
+		 * 	-mask = 1+~mask
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
@@ -261,7 +290,7 @@
 			entry = local_pages->next;
 			do {
 				tmp = list_entry(entry, struct page, list);
-				if (tmp->index == order && memclass(tmp->zone, classzone)) {
+				if (tmp->index == order && memclass(page_zone(tmp), classzone)) {
 					list_del(entry);
 					current->nr_local_pages--;
 					set_page_count(tmp, 1);
@@ -623,6 +652,48 @@
 	}
 }

+/*
+ * Helper functions to size the waitqueue hash table.
+ * Essentially these want to choose hash table sizes sufficiently
+ * large so that collisions trying to wait on pages are rare.
+ * But in fact, the number of active page waitqueues on typical
+ * systems is ridiculously low, less than 200. So this is even
+ * conservative, even though it seems large.
+ *
+ * The constant PAGES_PER_WAITQUEUE specifies the ratio of pages to
+ * waitqueues, i.e. the size of the waitq table given the number of pages.
+ */
+#define PAGES_PER_WAITQUEUE	256
+
+static inline unsigned long wait_table_size(unsigned long pages)
+{
+	unsigned long size = 1;
+
+	pages /= PAGES_PER_WAITQUEUE;
+
+	while (size < pages)
+		size <<= 1;
+
+	/*
+	 * Once we have dozens or even hundreds of threads sleeping
+	 * on IO we've got bigger problems than wait queue collision.
+	 * Limit the size of the wait table to a reasonable size.
+	 */
+	size = min(size, 4096UL);
+
+	return size;
+}
+
+/*
+ * This is an integer logarithm so that shifts can be used later
+ * to extract the more random high bits from the multiplicative
+ * hash function before the remainder is taken.
+ */
+static inline unsigned long wait_table_bits(unsigned long size)
+{
+	return ffz(~size);
+}
+
 #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))

 /*
@@ -635,7 +706,6 @@
 	unsigned long *zones_size, unsigned long zone_start_paddr,
 	unsigned long *zholes_size, struct page *lmem_map)
 {
-	struct page *p;
 	unsigned long i, j;
 	unsigned long map_size;
 	unsigned long totalpages, offset, realtotalpages;
@@ -678,24 +748,13 @@
 	pgdat->node_start_mapnr = (lmem_map - mem_map);
 	pgdat->nr_zones = 0;

-	/*
-	 * Initially all pages are reserved - free ones are freed
-	 * up by free_all_bootmem() once the early boot process is
-	 * done.
-	 */
-	for (p = lmem_map; p < lmem_map + totalpages; p++) {
-		set_page_count(p, 0);
-		SetPageReserved(p);
-		init_waitqueue_head(&p->wait);
-		memlist_init(&p->list);
-	}
-
 	offset = lmem_map - mem_map;
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		zone_t *zone = pgdat->node_zones + j;
 		unsigned long mask;
 		unsigned long size, realsize;

+		zone_table[nid * MAX_NR_ZONES + j] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -710,6 +769,20 @@
 		if (!size)
 			continue;

+		/*
+		 * The per-page waitqueue mechanism uses hashed waitqueues
+		 * per zone.
+		 */
+		zone->wait_table_size = wait_table_size(size);
+		zone->wait_table_shift =
+			BITS_PER_LONG - wait_table_bits(zone->wait_table_size);
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat, zone->wait_table_size
+						* sizeof(wait_queue_head_t));
+
+		for(i = 0; i < zone->wait_table_size; ++i)
+			init_waitqueue_head(zone->wait_table + i);
+
 		pgdat->nr_zones = j+1;

 		mask = (realsize / zone_balance_ratio[j]);
@@ -728,11 +801,19 @@
 		if ((zone_start_paddr >> PAGE_SHIFT) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");

+		/*
+		 * Initially all pages are reserved - free ones are freed
+		 * up by free_all_bootmem() once the early boot process is
+		 * done. Non-atomic initialization, single-pass.
+		 */
 		for (i = 0; i < size; i++) {
 			struct page *page = mem_map + offset + i;
-			page->zone = zone;
+			set_page_zone(page, nid * MAX_NR_ZONES + j);
+			set_page_count(page, 0);
+			__SetPageReserved(page);
+			memlist_init(&page->list);
 			if (j != ZONE_HIGHMEM)
-				page->virtual = __va(zone_start_paddr);
+				set_page_address(page, __va(zone_start_paddr));
 			zone_start_paddr += PAGE_SIZE;
 		}

diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Mon Feb 25 23:10:17 2002
+++ b/mm/vmscan.c	Mon Feb 25 23:10:17 2002
@@ -58,7 +58,7 @@
 		return 0;

 	/* Don't bother replenishing zones not under pressure.. */
-	if (!memclass(page->zone, classzone))
+	if (!memclass(page_zone(page), classzone))
 		return 0;

 	if (TryLockPage(page))
@@ -369,7 +369,7 @@
 		if (unlikely(!page_count(page)))
 			continue;

-		if (!memclass(page->zone, classzone))
+		if (!memclass(page_zone(page), classzone))
 			continue;

 		/* Racy check to avoid trylocking when not worthwhile */

