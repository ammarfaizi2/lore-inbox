Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUCKG4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUCKG4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:56:37 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:272
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262978AbUCKGwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:52:16 -0500
Date: Thu, 11 Mar 2004 07:52:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>
Subject: anon_vma RFC2
Message-ID: <20040311065254.GT30940@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309030907.71a53a7c.akpm@osdl.org> <20040309114924.GA4581@elte.hu> <20040309160307.GI8193@dualathlon.random> <20040310103610.GB30940@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310103610.GB30940@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is the full current status of my anon_vma work. Now fork() and all
the other page_add/remove_rmap in memory.c plus the paging routines
seems fully covered and I'm now dealing with the  vma merging and the
anon_vma garbage collection (the latter is easy but I need to track all
the kmem_cache_free).

There is just one minor limitation with the vma merging of anonymous
memory that I didn't considered during the design phase (I figured it
out while coding).  In short this is only an issue with the mremap
syscall (and sometimes with mmap too while filling an hole). The vma
merging happening during mmap/brk (not filling an hole) is always going
to happen fine, since the newly created vma has vma->anon_vma == NULL
and I can have the guarantee from the caller that no page is yet mapped
to this vma, so I can merge it just fine and it'll be part of whatever
pre-existing anon_vma object (after possibly fixing up the vma->pg_off
of the newly created vma).

Only if I fill an hole (with mmap or brk) I may be not able to merge the
three anon vmas together if their pg_off disagrees. However their pg_off
may disagree only if somebody used mremap on those vmas previously,
since I setup the pg_off of anonymous memory in a way that if you only
use mmap/brk even filling the holes is guaranteed to do full merging.

The problem in mremap is not only the pgoff, the problem is that I can
merge anonymous vma only if (!vma1->anon_vma  || !vma2->anon_vma) is
true. If both vma1 and vma2 have a different anon_vma I cannot merge
them togheter (even if the pg_off agrees) because the pages under vma2
may point to vma2->anon_vma and the pages under vma1 may point to
vma1->anon_vma in their page->as.anon_vma.  There is no way to reach
efficiently the pages pointing to a certain anon_vma. As said yesterday
the invariant I use to garbage collect the anon_vma is to wait all vma
to go be unlinked from the anon_vma, but as far as there are vmas queued
into the anon_vma object I cannot release those anon_vma objects, and in
turn I cannot do merging either.

the only way to allow 100% merging through mremap would be to have a
list with the head in the anon_vma and the nodes in the page_t, that
would be very easy but it would waste 4 bytes per page_t for a
hlist_node (the 4byte waste in the anon_vma is not a problem). And the
merging would be very expensive too since I would need to run a
for_each_page_in_the_list loop to fixup first all the page->index
according to the spread between vma1->pg_off and vma2->pg_off, and
second I should reset the page->as.anon_vma (or page->as.vma for direct
pages) to point respectively to the other anon_vma (or the other vma for
direct pages).

So I think I will go ahead with the current data structures despite the
small regression in vma merging. I doubt it's an issue but please let me
know if you think it's an issue and that I should add an hlist_node to
the page_t and an hlist_head to the anon_vma_t. btw, it's something I
can always do later if it's really necessary. Even with the additional
4bytes per page_t the page_t size would not be bigger than mainline 2.4
and mainline 2.6.

 include/linux/mm.h         |   79 +++
 include/linux/objrmap.h    |   66 +++
 include/linux/page-flags.h |    4
 include/linux/rmap.h       |   53 --
 init/main.c                |    4
 kernel/fork.c              |   10
 mm/Makefile                |    2
 mm/memory.c                |  129 +-----
 mm/mmap.c                  |    9
 mm/nommu.c                 |    2
 mm/objrmap.c               |  575 ++++++++++++++++++++++++++++
 mm/page_alloc.c            |    6
 mm/rmap.c                  |  908 ---------------------------------------------
 14 files changed, 772 insertions(+), 1075 deletions(-)

--- sles-anobjrmap-2/include/linux/mm.h.~1~	2004-03-03 06:45:38.000000000 +0100
+++ sles-anobjrmap-2/include/linux/mm.h	2004-03-10 18:59:14.000000000 +0100
@@ -39,6 +39,22 @@ extern int page_cluster;
  * mmap() functions).
  */
 
+typedef struct anon_vma_s {
+	/* This serializes the accesses to the vma list. */
+	spinlock_t anon_vma_lock;
+
+	/*
+	 * This is a list of anonymous "related" vmas,
+	 * to scan if one of the pages pointing to this
+	 * anon_vma needs to be unmapped.
+	 * After we unlink the last vma we must garbage collect
+	 * the object if the list is empty because we're
+	 * guaranteed no page can be pointing to this anon_vma
+	 * if there's no vma anymore.
+	 */
+	struct list_head anon_vma_head;
+} anon_vma_t;
+
 /*
  * This struct defines a memory VMM memory area. There is one of these
  * per VM-area/task.  A VM area is any part of the process virtual memory
@@ -69,6 +85,19 @@ struct vm_area_struct {
 	 */
 	struct list_head shared;
 
+	/*
+	 * The same vma can be both queued into the i_mmap and in a
+	 * anon_vma too, for example after a cow in
+	 * a MAP_PRIVATE file mapping. However only the MAP_PRIVATE
+	 * will go both in the i_mmap and anon_vma. A MAP_SHARED
+	 * will only be in the i_mmap_shared and a MAP_ANONYMOUS (file = 0)
+	 * will only be queued only in the anon_vma.
+	 * The list is serialized by the anon_vma->lock.
+	 */
+	struct list_head anon_vma_node;
+	/* Serialized by the vma->vm_mm->page_table_lock */
+	anon_vma_t * anon_vma;
+
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
 
@@ -172,16 +201,51 @@ struct page {
 					   updated asynchronously */
 	atomic_t count;			/* Usage count, see below. */
 	struct list_head list;		/* ->mapping has some page lists. */
-	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by zone->lru_lock !! */
+
+	/*
+	 * Address space of this page.
+	 * A page can be either mapped to a file or to be anonymous
+	 * memory, so using the union is optimal here. The PG_anon
+	 * bitflag tells if this is anonymous or a file-mapping.
+	 * If PG_anon is clear we use the as.mapping, if PG_anon is
+	 * set and PG_direct is not set we use the as.anon_vma,
+	 * if PG_anon is set and PG_direct is set we use the as.vma.
+	 */
 	union {
-		struct pte_chain *chain;/* Reverse pte mapping pointer.
-					 * protected by PG_chainlock */
-		pte_addr_t direct;
-		int mapcount;
-	} pte;
+		/* The inode address space if it's a file mapping. */
+		struct address_space * mapping;
+
+		/*
+		 * This points to an anon_vma object.
+		 * The anon_vma can't go away under us if
+		 * we hold the PG_maplock.
+		 */
+		anon_vma_t * anon_vma;
+
+		/*
+		 * Before the first fork we avoid anon_vma object allocation
+		 * and we set PG_direct. anon_vma objects are only created
+		 * via fork(), and the vm then stop using the page->as.vma
+		 * and it starts using the as.anon_vma object instead.
+		 * After the first fork(), even if the child exit, the pages
+		 * cannot be downgraded to PG_direct anymore (even if we
+		 * wanted to) because there's no way to reach pages starting
+		 * from an anon_vma object.
+		 */
+		struct vm_struct * vma;
+	} as;
+	
+	/*
+	 * Number of ptes mapping this page.
+	 * It's serialized by PG_maplock.
+	 * This is needed only to maintain the nr_mapped global info
+	 * so it would be nice to drop it.
+	 */
+	unsigned long mapcount;		
+
 	unsigned long private;		/* mapping-private opaque data */
 
 	/*
@@ -440,7 +504,8 @@ void unmap_page_range(struct mmu_gather 
 			unsigned long address, unsigned long size);
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma);
+		    struct vm_area_struct *vma, struct vm_area_struct *orig_vma,
+		    anon_vma_t ** anon_vma);
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long from,
 			unsigned long size, pgprot_t prot);
 
--- sles-anobjrmap-2/include/linux/page-flags.h.~1~	2004-03-03 06:45:38.000000000 +0100
+++ sles-anobjrmap-2/include/linux/page-flags.h	2004-03-10 10:20:59.000000000 +0100
@@ -69,9 +69,9 @@
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
 #define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
+#define PG_maplock		15	/* lock bit for ->as.anon_vma and ->mapcount */
 
-#define PG_direct		16	/* ->pte_chain points directly at pte */
+#define PG_direct		16	/* if set it must use page->as.vma */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
--- sles-anobjrmap-2/include/linux/objrmap.h.~1~	2004-03-05 05:27:41.000000000 +0100
+++ sles-anobjrmap-2/include/linux/objrmap.h	2004-03-10 20:48:57.000000000 +0100
@@ -1,8 +1,7 @@
 #ifndef _LINUX_RMAP_H
 #define _LINUX_RMAP_H
 /*
- * Declarations for Reverse Mapping functions in mm/rmap.c
- * Its structures are declared within that file.
+ * Declarations for Object Reverse Mapping functions in mm/objrmap.c
  */
 #include <linux/config.h>
 
@@ -10,32 +9,46 @@
 
 #include <linux/linkage.h>
 #include <linux/slab.h>
+#include <linux/kernel.h>
 
-struct pte_chain;
-extern kmem_cache_t *pte_chain_cache;
+extern kmem_cache_t * anon_vma_cachep;
 
-#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, &page->flags)
-#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, &page->flags)
+#define page_map_lock(page)	bit_spin_lock(PG_maplock, &page->flags)
+#define page_map_unlock(page)	bit_spin_unlock(PG_maplock, &page->flags)
 
-struct pte_chain *pte_chain_alloc(int gfp_flags);
-void __pte_chain_free(struct pte_chain *pte_chain);
+static inline void anon_vma_free(anon_vma_t * anon_vma)
+{
+	kmem_cache_free(anon_vma);
+}
 
-static inline void pte_chain_free(struct pte_chain *pte_chain)
+static inline anon_vma_t * anon_vma_alloc(void)
 {
-	if (pte_chain)
-		__pte_chain_free(pte_chain);
+	might_sleep();
+
+	return kmem_cache_alloc(anon_vma_cachep, SLAB_KERNEL);
 }
 
-int FASTCALL(page_referenced(struct page *));
-struct pte_chain *FASTCALL(page_add_rmap(struct page *, pte_t *,
-					struct pte_chain *));
-void FASTCALL(page_remove_rmap(struct page *, pte_t *));
-int page_convert_anon(struct page *);
+static inline void anon_vma_unlink(struct vm_area_struct * vma)
+{
+	anon_vma_t * anon_vma = vma->anon_vma;
+
+	if (anon_vma) {
+		spin_lock(&anon_vma->anon_vma_lock);
+		list_del(&vma->anon_vm_node);
+		spin_unlock(&anon_vma->anon_vma_lock);
+	}
+}
+
+void FASTCALL(page_add_rmap(struct page *, struct vm_struct *));
+void FASTCALL(page_add_rmap_fork(struct page *, struct vm_area_struct *,
+				 struct vm_area_struct *, anon_vma_t **));
+void FASTCALL(page_remove_rmap(struct page *));
 
 /*
  * Called from mm/vmscan.c to handle paging out
  */
 int FASTCALL(try_to_unmap(struct page *));
+int FASTCALL(page_referenced(struct page *));
 
 /*
  * Return values of try_to_unmap
--- sles-anobjrmap-2/init/main.c.~1~	2004-02-29 17:47:36.000000000 +0100
+++ sles-anobjrmap-2/init/main.c	2004-03-09 05:32:34.000000000 +0100
@@ -85,7 +85,7 @@ extern void signals_init(void);
 extern void buffer_init(void);
 extern void pidhash_init(void);
 extern void pidmap_init(void);
-extern void pte_chain_init(void);
+extern void anon_vma_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
 extern void populate_rootfs(void);
@@ -495,7 +495,7 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
-	pte_chain_init();
+	anon_vma_init();
 
 #ifdef	CONFIG_KDB
 	kdb_init();
--- sles-anobjrmap-2/kernel/fork.c.~1~	2004-02-29 17:47:33.000000000 +0100
+++ sles-anobjrmap-2/kernel/fork.c	2004-03-10 18:58:29.000000000 +0100
@@ -276,6 +276,7 @@ static inline int dup_mmap(struct mm_str
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
 	unsigned long charge = 0;
+	anon_vma_t * anon_vma = NULL;
 
 	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(current->mm);
@@ -310,6 +311,11 @@ static inline int dup_mmap(struct mm_str
 				goto fail_nomem;
 			charge += len;
 		}
+		if (!anon_vma) {
+			anon_vma = anon_vma_alloc();
+			if (!anon_vma)
+				goto fail_nomem;
+		}
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
 			goto fail_nomem;
@@ -339,7 +345,7 @@ static inline int dup_mmap(struct mm_str
 		*pprev = tmp;
 		pprev = &tmp->vm_next;
 		mm->map_count++;
-		retval = copy_page_range(mm, current->mm, tmp);
+		retval = copy_page_range(mm, current->mm, tmp, mpnt, &anon_vma);
 		spin_unlock(&mm->page_table_lock);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
@@ -354,6 +360,8 @@ static inline int dup_mmap(struct mm_str
 out:
 	flush_tlb_mm(current->mm);
 	up_write(&oldmm->mmap_sem);
+	if (anon_vma)
+		anon_vma_free(anon_vma);
 	return retval;
 fail_nomem:
 	retval = -ENOMEM;
--- sles-anobjrmap-2/mm/mmap.c.~1~	2004-03-03 06:53:46.000000000 +0100
+++ sles-anobjrmap-2/mm/mmap.c	2004-03-11 07:43:32.158221568 +0100
@@ -325,7 +325,7 @@ static void move_vma_start(struct vm_are
 		inode = vma->vm_file->f_dentry->d_inode;
 	if (inode)
 		__remove_shared_vm_struct(vma, inode);
-	/* If no vm_file, perhaps we should always keep vm_pgoff at 0?? */
+	/* we must update pgoff even if no vm_file for the anon_vma_chain */
 	vma->vm_pgoff += (long)(addr - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = addr;
 	if (inode)
@@ -576,6 +576,7 @@ unsigned long __do_mmap_pgoff(struct mm_
 		case MAP_SHARED:
 			break;
 		}
+		pgoff = addr << PAGE_SHIFT;
 	}
 
 	error = security_file_mmap(file, prot, flags);
@@ -639,6 +640,8 @@ munmap_back:
 	vma->vm_private_data = NULL;
 	vma->vm_next = NULL;
 	INIT_LIST_HEAD(&vma->shared);
+	INIT_LIST_HEAD(&vma->anon_vma_node);
+	vma->anon_vma = NULL;
 
 	if (file) {
 		error = -EINVAL;
@@ -1381,10 +1384,12 @@ unsigned long do_brk(unsigned long addr,
 	vma->vm_flags = flags;
 	vma->vm_page_prot = protection_map[flags & 0x0f];
 	vma->vm_ops = NULL;
-	vma->vm_pgoff = 0;
+	vma->vm_pgoff = addr << PAGE_SHIFT;
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	INIT_LIST_HEAD(&vma->shared);
+	INIT_LIST_HEAD(&vma->anon_vma_node);
+	vma->anon_vma = NULL;
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 
--- sles-anobjrmap-2/mm/page_alloc.c.~1~	2004-03-03 06:45:38.000000000 +0100
+++ sles-anobjrmap-2/mm/page_alloc.c	2004-03-10 10:28:26.000000000 +0100
@@ -91,6 +91,7 @@ static void bad_page(const char *functio
 			1 << PG_writeback);
 	set_page_count(page, 0);
 	page->mapping = NULL;
+	page->mapcount = 0;
 }
 
 #if !defined(CONFIG_HUGETLB_PAGE) && !defined(CONFIG_CRASH_DUMP) \
@@ -216,8 +217,7 @@ static inline void __free_pages_bulk (st
 
 static inline void free_pages_check(const char *function, struct page *page)
 {
-	if (	page_mapped(page) ||
-		page->mapping != NULL ||
+	if (	page->as.mapping != NULL ||
 		page_count(page) != 0 ||
 		(page->flags & (
 			1 << PG_lru	|
@@ -329,7 +329,7 @@ static inline void set_page_refs(struct 
  */
 static void prep_new_page(struct page *page, int order)
 {
-	if (page->mapping || page_mapped(page) ||
+	if (page->as.mapping ||
 	    (page->flags & (
 			1 << PG_private	|
 			1 << PG_locked	|
--- sles-anobjrmap-2/mm/nommu.c.~1~	2004-02-04 16:07:06.000000000 +0100
+++ sles-anobjrmap-2/mm/nommu.c	2004-03-09 05:32:41.000000000 +0100
@@ -568,6 +568,6 @@ unsigned long get_unmapped_area(struct f
 	return -ENOMEM;
 }
 
-void pte_chain_init(void)
+void anon_vma_init(void)
 {
 }
--- sles-anobjrmap-2/mm/memory.c.~1~	2004-03-05 05:24:35.000000000 +0100
+++ sles-anobjrmap-2/mm/memory.c	2004-03-10 19:25:27.000000000 +0100
@@ -43,12 +43,11 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-#include <linux/rmap.h>
+#include <linux/objrmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
 #include <asm/pgalloc.h>
-#include <asm/rmap.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -105,7 +104,6 @@ static inline void free_one_pmd(struct m
 	}
 	page = pmd_page(*dir);
 	pmd_clear(dir);
-	pgtable_remove_rmap(page);
 	pte_free_tlb(tlb, page);
 }
 
@@ -164,7 +162,6 @@ pte_t fastcall * pte_alloc_map(struct mm
 			pte_free(new);
 			goto out;
 		}
-		pgtable_add_rmap(new, mm, address);
 		pmd_populate(mm, pmd, new);
 	}
 out:
@@ -190,7 +187,6 @@ pte_t fastcall * pte_alloc_kernel(struct
 			pte_free_kernel(new);
 			goto out;
 		}
-		pgtable_add_rmap(virt_to_page(new), mm, address);
 		pmd_populate_kernel(mm, pmd, new);
 	}
 out:
@@ -211,26 +207,17 @@ out:
  * but may be dropped within pmd_alloc() and pte_alloc_map().
  */
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma)
+		    struct vm_area_struct *vma, struct vm_area_struct *orig_vma,
+		    anon_vma_t ** anon_vma)
 {
 	pgd_t * src_pgd, * dst_pgd;
 	unsigned long address = vma->vm_start;
 	unsigned long end = vma->vm_end;
 	unsigned long cow;
-	struct pte_chain *pte_chain = NULL;
 
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst, src, vma);
 
-	pte_chain = pte_chain_alloc(GFP_ATOMIC);
-	if (!pte_chain) {
-		spin_unlock(&dst->page_table_lock);
-		pte_chain = pte_chain_alloc(GFP_KERNEL);
-		spin_lock(&dst->page_table_lock);
-		if (!pte_chain)
-			goto nomem;
-	}
-	
 	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
@@ -299,7 +286,7 @@ skip_copy_pte_range:
 				pfn = pte_pfn(pte);
 				/* the pte points outside of valid memory, the
 				 * mapping is assumed to be good, meaningful
-				 * and not mapped via rmap - duplicate the
+				 * and not mapped via objrmap - duplicate the
 				 * mapping as is.
 				 */
 				page = NULL;
@@ -331,30 +318,20 @@ skip_copy_pte_range:
 				dst->rss++;
 
 				set_pte(dst_pte, pte);
-				pte_chain = page_add_rmap(page, dst_pte,
-							pte_chain);
-				if (pte_chain)
-					goto cont_copy_pte_range_noset;
-				pte_chain = pte_chain_alloc(GFP_ATOMIC);
-				if (pte_chain)
-					goto cont_copy_pte_range_noset;
+				page_add_rmap_fork(page, vma, orig_vma, anon_vma);
+
+				if (need_resched()) {
+					pte_unmap_nested(src_pte);
+					pte_unmap(dst_pte);
+					spin_unlock(&src->page_table_lock);	
+					spin_unlock(&dst->page_table_lock);	
+					__cond_resched();
+					spin_lock(&dst->page_table_lock);	
+					spin_lock(&src->page_table_lock);
+					dst_pte = pte_offset_map(dst_pmd, address);
+					src_pte = pte_offset_map_nested(src_pmd, address);
+				}
 
-				/*
-				 * pte_chain allocation failed, and we need to
-				 * run page reclaim.
-				 */
-				pte_unmap_nested(src_pte);
-				pte_unmap(dst_pte);
-				spin_unlock(&src->page_table_lock);	
-				spin_unlock(&dst->page_table_lock);	
-				pte_chain = pte_chain_alloc(GFP_KERNEL);
-				spin_lock(&dst->page_table_lock);	
-				if (!pte_chain)
-					goto nomem;
-				spin_lock(&src->page_table_lock);
-				dst_pte = pte_offset_map(dst_pmd, address);
-				src_pte = pte_offset_map_nested(src_pmd,
-								address);
 cont_copy_pte_range_noset:
 				address += PAGE_SIZE;
 				if (address >= end) {
@@ -377,10 +354,9 @@ cont_copy_pmd_range:
 out_unlock:
 	spin_unlock(&src->page_table_lock);
 out:
-	pte_chain_free(pte_chain);
 	return 0;
+
 nomem:
-	pte_chain_free(pte_chain);
 	return -ENOMEM;
 }
 
@@ -421,7 +397,7 @@ zap_pte_range(struct mmu_gather *tlb, pm
 							!PageSwapCache(page))
 						mark_page_accessed(page);
 					tlb->freed++;
-					page_remove_rmap(page, ptep);
+					page_remove_rmap(page);
 					tlb_remove_page(tlb, page);
 				}
 			}
@@ -1014,7 +990,6 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
-	struct pte_chain *pte_chain;
 	pte_t entry;
 
 	if (unlikely(!pfn_valid(pfn))) {
@@ -1053,9 +1028,6 @@ static int do_wp_page(struct mm_struct *
 	page_cache_get(old_page);
 	spin_unlock(&mm->page_table_lock);
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto no_pte_chain;
 	new_page = alloc_page(GFP_HIGHUSER);
 	if (!new_page)
 		goto no_new_page;
@@ -1069,10 +1041,10 @@ static int do_wp_page(struct mm_struct *
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
-		page_remove_rmap(old_page, page_table);
+		page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
 		SetPageAnon(new_page);
-		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
+		page_add_rmap(new_page, vma);
 		lru_cache_add_active(new_page);
 
 		/* Free the old page.. */
@@ -1082,12 +1054,9 @@ static int do_wp_page(struct mm_struct *
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
-	pte_chain_free(pte_chain);
 	return VM_FAULT_MINOR;
 
 no_new_page:
-	pte_chain_free(pte_chain);
-no_pte_chain:
 	page_cache_release(old_page);
 	return VM_FAULT_OOM;
 }
@@ -1245,7 +1214,6 @@ static int do_swap_page(struct mm_struct
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
 	int ret = VM_FAULT_MINOR;
-	struct pte_chain *pte_chain = NULL;
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
@@ -1275,11 +1243,6 @@ static int do_swap_page(struct mm_struct
 	}
 
 	mark_page_accessed(page);
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain) {
-		ret = VM_FAULT_OOM;
-		goto out;
-	}
 	lock_page(page);
 
 	/*
@@ -1312,14 +1275,13 @@ static int do_swap_page(struct mm_struct
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
 	SetPageAnon(page);
-	pte_chain = page_add_rmap(page, page_table, pte_chain);
+	page_add_rmap(page, vma);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 out:
-	pte_chain_free(pte_chain);
 	return ret;
 }
 
@@ -1335,20 +1297,8 @@ do_anonymous_page(struct mm_struct *mm, 
 {
 	pte_t entry;
 	struct page * page = ZERO_PAGE(addr);
-	struct pte_chain *pte_chain;
 	int ret;
 
-	pte_chain = pte_chain_alloc(GFP_ATOMIC);
-	if (!pte_chain) {
-		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
-		pte_chain = pte_chain_alloc(GFP_KERNEL);
-		if (!pte_chain)
-			goto no_mem;
-		spin_lock(&mm->page_table_lock);
-		page_table = pte_offset_map(pmd, addr);
-	}
-		
 	/* Read-only mapping of ZERO_PAGE. */
 	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
 
@@ -1359,8 +1309,8 @@ do_anonymous_page(struct mm_struct *mm, 
 		spin_unlock(&mm->page_table_lock);
 
 		page = alloc_page(GFP_HIGHUSER);
-		if (!page)
-			goto no_mem;
+		if (unlikely(!page))
+			return VM_FAULT_OOM;
 		clear_user_highpage(page, addr);
 
 		spin_lock(&mm->page_table_lock);
@@ -1370,8 +1320,7 @@ do_anonymous_page(struct mm_struct *mm, 
 			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
-			ret = VM_FAULT_MINOR;
-			goto out;
+			return VM_FAULT_MINOR;
 		}
 		mm->rss++;
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
@@ -1383,20 +1332,16 @@ do_anonymous_page(struct mm_struct *mm, 
 	}
 
 	set_pte(page_table, entry);
-	/* ignores ZERO_PAGE */
-	pte_chain = page_add_rmap(page, page_table, pte_chain);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
 	spin_unlock(&mm->page_table_lock);
 	ret = VM_FAULT_MINOR;
-	goto out;
 
-no_mem:
-	ret = VM_FAULT_OOM;
-out:
-	pte_chain_free(pte_chain);
+	/* ignores ZERO_PAGE */
+	page_add_rmap(page, vma);
+
 	return ret;
 }
 
@@ -1419,7 +1364,6 @@ do_no_page(struct mm_struct *mm, struct 
 	struct page * new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
-	struct pte_chain *pte_chain;
 	int sequence = 0;
 	int ret = VM_FAULT_MINOR;
 
@@ -1443,10 +1387,6 @@ retry:
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
 
-	pte_chain = pte_chain_alloc(GFP_KERNEL);
-	if (!pte_chain)
-		goto oom;
-
 	/* See if nopage returned an anon page */
 	if (!new_page->mapping || PageSwapCache(new_page))
 		SetPageAnon(new_page);
@@ -1476,7 +1416,6 @@ retry:
 		sequence = atomic_read(&mapping->truncate_count);
 		spin_unlock(&mm->page_table_lock);
 		page_cache_release(new_page);
-		pte_chain_free(pte_chain);
 		goto retry;
 	}
 	page_table = pte_offset_map(pmd, address);
@@ -1500,7 +1439,7 @@ retry:
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte(page_table, entry);
-		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
+		page_add_rmap(new_page, vma);
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
@@ -1513,13 +1452,13 @@ retry:
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	spin_unlock(&mm->page_table_lock);
-	goto out;
-oom:
+ out:
+	return ret;
+
+ oom:
 	page_cache_release(new_page);
 	ret = VM_FAULT_OOM;
-out:
-	pte_chain_free(pte_chain);
-	return ret;
+	goto out;
 }
 
 /*
--- sles-anobjrmap-2/mm/objrmap.c.~1~	2004-03-05 05:40:21.000000000 +0100
+++ sles-anobjrmap-2/mm/objrmap.c	2004-03-10 20:29:20.000000000 +0100
@@ -1,105 +1,27 @@
 /*
- * mm/rmap.c - physical to virtual reverse mappings
- *
- * Copyright 2001, Rik van Riel <riel@conectiva.com.br>
- * Released under the General Public License (GPL).
+ *  mm/objrmap.c
  *
+ *  Provides methods for unmapping all sort of mapped pages
+ *  using the vma objects, the brainer part of objrmap is the
+ *  tracking of the vma to analyze for every given mapped page.
+ *  The anon_vma methods are tracking anonymous pages,
+ *  and the inode methods are tracking pages belonging
+ *  to an inode.
  *
- * Simple, low overhead pte-based reverse mapping scheme.
- * This is kept modular because we may want to experiment
- * with object-based reverse mapping schemes. Please try
- * to keep this thing as modular as possible.
+ *  anonymous methods by Andrea Arcangeli <andrea@suse.de> 2004
+ *  inode methods by Dave McCracken <dmccr@us.ibm.com> 2003, 2004
  */
 
 /*
- * Locking:
- * - the page->pte.chain is protected by the PG_chainlock bit,
- *   which nests within the the mm->page_table_lock,
- *   which nests within the page lock.
- * - because swapout locking is opposite to the locking order
- *   in the page fault path, the swapout path uses trylocks
- *   on the mm->page_table_lock
- */
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-#include <linux/swap.h>
-#include <linux/swapops.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/rmap.h>
-#include <linux/cache.h>
-#include <linux/percpu.h>
-
-#include <asm/pgalloc.h>
-#include <asm/rmap.h>
-#include <asm/tlb.h>
-#include <asm/tlbflush.h>
-
-/* #define DEBUG_RMAP */
-
-/*
- * Shared pages have a chain of pte_chain structures, used to locate
- * all the mappings to this page. We only need a pointer to the pte
- * here, the page struct for the page table page contains the process
- * it belongs to and the offset within that process.
- *
- * We use an array of pte pointers in this structure to minimise cache misses
- * while traversing reverse maps.
- */
-#define NRPTE ((L1_CACHE_BYTES - sizeof(unsigned long))/sizeof(pte_addr_t))
-
-/*
- * next_and_idx encodes both the address of the next pte_chain and the
- * offset of the highest-index used pte in ptes[].
+ * try_to_unmap/page_referenced/page_add_rmap/page_remove_rmap
+ * inherit from the rmap design mm/rmap.c under
+ * Copyright 2001, Rik van Riel <riel@conectiva.com.br>
+ * Released under the General Public License (GPL).
  */
-struct pte_chain {
-	unsigned long next_and_idx;
-	pte_addr_t ptes[NRPTE];
-} ____cacheline_aligned;
-
-kmem_cache_t	*pte_chain_cache;
 
-static inline struct pte_chain *pte_chain_next(struct pte_chain *pte_chain)
-{
-	return (struct pte_chain *)(pte_chain->next_and_idx & ~NRPTE);
-}
-
-static inline struct pte_chain *pte_chain_ptr(unsigned long pte_chain_addr)
-{
-	return (struct pte_chain *)(pte_chain_addr & ~NRPTE);
-}
-
-static inline int pte_chain_idx(struct pte_chain *pte_chain)
-{
-	return pte_chain->next_and_idx & NRPTE;
-}
-
-static inline unsigned long
-pte_chain_encode(struct pte_chain *pte_chain, int idx)
-{
-	return (unsigned long)pte_chain | idx;
-}
-
-/*
- * pte_chain list management policy:
- *
- * - If a page has a pte_chain list then it is shared by at least two processes,
- *   because a single sharing uses PageDirect. (Well, this isn't true yet,
- *   coz this code doesn't collapse singletons back to PageDirect on the remove
- *   path).
- * - A pte_chain list has free space only in the head member - all succeeding
- *   members are 100% full.
- * - If the head element has free space, it occurs in its leading slots.
- * - All free space in the pte_chain is at the start of the head member.
- * - Insertion into the pte_chain puts a pte pointer in the last free slot of
- *   the head member.
- * - Removal from a pte chain moves the head pte of the head member onto the
- *   victim pte and frees the head member if it became empty.
- */
+#include <linux/mm.h>
 
-/**
- ** VM stuff below this comment
- **/
+kmem_cache_t * anon_vma_cachep;
 
 /**
  * find_pte - Find a pte pointer given a vma and a struct page.
@@ -157,17 +79,17 @@ out:
 }
 
 /**
- * page_referenced_obj_one - referenced check for object-based rmap
+ * page_referenced_inode_one - referenced check for object-based rmap
  * @vma: the vma to look in.
  * @page: the page we're working on.
  *
  * Find a pte entry for a page/vma pair, then check and clear the referenced
  * bit.
  *
- * This is strictly a helper function for page_referenced_obj.
+ * This is strictly a helper function for page_referenced_inode.
  */
 static int
-page_referenced_obj_one(struct vm_area_struct *vma, struct page *page)
+page_referenced_inode_one(struct vm_area_struct *vma, struct page *page)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte;
@@ -188,11 +110,11 @@ page_referenced_obj_one(struct vm_area_s
 }
 
 /**
- * page_referenced_obj_one - referenced check for object-based rmap
+ * page_referenced_inode_one - referenced check for object-based rmap
  * @page: the page we're checking references on.
  *
  * For an object-based mapped page, find all the places it is mapped and
- * check/clear the referenced flag.  This is done by following the page->mapping
+ * check/clear the referenced flag.  This is done by following the page->as.mapping
  * pointer, then walking the chain of vmas it holds.  It returns the number
  * of references it found.
  *
@@ -202,29 +124,54 @@ page_referenced_obj_one(struct vm_area_s
  * assume a reference count of 1.
  */
 static int
-page_referenced_obj(struct page *page)
+page_referenced_inode(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page->as.mapping;
 	struct vm_area_struct *vma;
-	int referenced = 0;
+	int referenced;
 
-	if (!page->pte.mapcount)
+	if (!page->mapcount)
 		return 0;
 
-	if (!mapping)
-		BUG();
+	BUG_ON(!mapping);
+	BUG_ON(PageSwapCache(page));
 
-	if (PageSwapCache(page))
-		BUG();
+	if (down_trylock(&mapping->i_shared_sem))
+		return 1;
+
+	referenced = 0;
+
+	list_for_each_entry(vma, &mapping->i_mmap, shared)
+		referenced += page_referenced_inode_one(vma, page);
+
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
+		referenced += page_referenced_inode_one(vma, page);
+
+	up(&mapping->i_shared_sem);
+
+	return referenced;
+}
+
+static int page_referenced_anon(struct page *page)
+{
+	int referenced;
+
+	if (!page->mapcount)
+		return 0;
+
+	BUG_ON(!mapping);
+	BUG_ON(PageSwapCache(page));
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return 1;
-	
+
+	referenced = 0;
+
 	list_for_each_entry(vma, &mapping->i_mmap, shared)
-		referenced += page_referenced_obj_one(vma, page);
+		referenced += page_referenced_inode_one(vma, page);
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
-		referenced += page_referenced_obj_one(vma, page);
+		referenced += page_referenced_inode_one(vma, page);
 
 	up(&mapping->i_shared_sem);
 
@@ -244,7 +191,6 @@ page_referenced_obj(struct page *page)
  */
 int fastcall page_referenced(struct page * page)
 {
-	struct pte_chain *pc;
 	int referenced = 0;
 
 	if (page_test_and_clear_young(page))
@@ -253,209 +199,179 @@ int fastcall page_referenced(struct page
 	if (TestClearPageReferenced(page))
 		referenced++;
 
-	if (!PageAnon(page)) {
-		referenced += page_referenced_obj(page);
-		goto out;
-	}
-	if (PageDirect(page)) {
-		pte_t *pte = rmap_ptep_map(page->pte.direct);
-		if (ptep_test_and_clear_young(pte))
-			referenced++;
-		rmap_ptep_unmap(pte);
-	} else {
-		int nr_chains = 0;
+	if (!PageAnon(page))
+		referenced += page_referenced_inode(page);
+	else
+		referenced += page_referenced_anon(page);
 
-		/* Check all the page tables mapping this page. */
-		for (pc = page->pte.chain; pc; pc = pte_chain_next(pc)) {
-			int i;
-
-			for (i = pte_chain_idx(pc); i < NRPTE; i++) {
-				pte_addr_t pte_paddr = pc->ptes[i];
-				pte_t *p;
-
-				p = rmap_ptep_map(pte_paddr);
-				if (ptep_test_and_clear_young(p))
-					referenced++;
-				rmap_ptep_unmap(p);
-				nr_chains++;
-			}
-		}
-		if (nr_chains == 1) {
-			pc = page->pte.chain;
-			page->pte.direct = pc->ptes[NRPTE-1];
-			SetPageDirect(page);
-			pc->ptes[NRPTE-1] = 0;
-			__pte_chain_free(pc);
-		}
-	}
-out:
 	return referenced;
 }
 
+/* this needs the page->flags PG_map_lock held */
+static void inline anon_vma_page_link(struct page * page, struct vm_area_struct * vma)
+{
+	BUG_ON(page->mapcount != 1);
+	BUG_ON(PageDirect(page));
+
+	SetPageDirect(page);
+	page->as.vma = vma;
+}
+
+/* this needs the page->flags PG_map_lock held */
+static void inline anon_vma_page_link_fork(struct page * page, struct vm_area_struct * vma,
+					   struct vm_area_struct * orig_vma, anon_vma_t ** anon_vma)
+{
+	anon_vma_t * anon_vma = orig_vma->anon_vma;
+
+	BUG_ON(page->mapcount <= 1);
+	BUG_ON(!PageDirect(page));
+
+	if (!anon_vma) {
+		anon_vma = *anon_vma;
+		*anon_vma = NULL;
+
+		/* it's single threaded here, avoid the anon_vma->anon_vma_lock */
+		list_add(&vma->anon_vma_node, &anon_vma->anon_vma_head);
+		list_add(&orig_vma->anon_vma_node, &anon_vma->anon_vma_head);
+
+		orig_vma->anon_vma = vma->anon_vma = anon_vma;
+	} else {
+		/* multithreaded here, anon_vma existed already in other mm */
+		spin_lock(&anon_vma->anon_vma_lock);
+		list_add(&vma->anon_vma_node, &anon_vma->anon_vma_head);
+		spin_unlock(&anon_vma->anon_vma_lock);
+	}
+
+	ClearPageDirect(page);
+	page->as.anon_vma = anon_vma;
+}
+
 /**
  * page_add_rmap - add reverse mapping entry to a page
  * @page: the page to add the mapping to
- * @ptep: the page table entry mapping this page
+ * @vma: the vma that is covering the page
  *
  * Add a new pte reverse mapping to a page.
- * The caller needs to hold the mm->page_table_lock.
  */
-struct pte_chain * fastcall
-page_add_rmap(struct page *page, pte_t *ptep, struct pte_chain *pte_chain)
+void fastcall page_add_rmap(struct page *page, struct vm_area_struct * vma)
 {
-	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
-	struct pte_chain *cur_pte_chain;
+	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
+		return;
 
-	if (PageReserved(page))
-		return pte_chain;
+	page_map_lock(page);
 
-	pte_chain_lock(page);
+	if (!page->mapcount++)
+		inc_page_state(nr_mapped);
 
-	/*
-	 * If this is an object-based page, just count it.  We can
- 	 * find the mappings by walking the object vma chain for that object.
-	 */
-	if (!PageAnon(page)) {
-		if (!page->mapping)
-			BUG();
-		if (PageSwapCache(page))
-			BUG();
-		if (!page->pte.mapcount)
-			inc_page_state(nr_mapped);
-		page->pte.mapcount++;
-		goto out;
+	if (PageAnon(page))
+		anon_vma_page_link(page, vma);
+	else {
+		/*
+		 * If this is an object-based page, just count it.
+		 * We can find the mappings by walking the object
+		 * vma chain for that object.
+		 */
+		BUG_ON(!page->as.mapping);
+		BUG_ON(PageSwapCache(page));
 	}
 
-	if (page->pte.direct == 0) {
-		page->pte.direct = pte_paddr;
-		SetPageDirect(page);
+	page_map_unlock(page);
+}
+
+/* called from fork() */
+void fastcall page_add_rmap_fork(struct page *page, struct vm_area_struct * vma,
+				 struct vm_area_struct * orig_vma, anon_vma_t ** anon_vma)
+{
+	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
+		return;
+
+	page_map_lock(page);
+
+	if (!page->mapcount++)
 		inc_page_state(nr_mapped);
-		goto out;
-	}
 
-	if (PageDirect(page)) {
-		/* Convert a direct pointer into a pte_chain */
-		ClearPageDirect(page);
-		pte_chain->ptes[NRPTE-1] = page->pte.direct;
-		pte_chain->ptes[NRPTE-2] = pte_paddr;
-		pte_chain->next_and_idx = pte_chain_encode(NULL, NRPTE-2);
-		page->pte.direct = 0;
-		page->pte.chain = pte_chain;
-		pte_chain = NULL;	/* We consumed it */
-		goto out;
+	if (PageAnon(page))
+		anon_vma_page_link_fork(page, vma, orig_vma, anon_vma);
+	else {
+		/*
+		 * If this is an object-based page, just count it.
+		 * We can find the mappings by walking the object
+		 * vma chain for that object.
+		 */
+		BUG_ON(!page->as.mapping);
+		BUG_ON(PageSwapCache(page));
 	}
 
-	cur_pte_chain = page->pte.chain;
-	if (cur_pte_chain->ptes[0]) {	/* It's full */
-		pte_chain->next_and_idx = pte_chain_encode(cur_pte_chain,
-								NRPTE - 1);
-		page->pte.chain = pte_chain;
-		pte_chain->ptes[NRPTE-1] = pte_paddr;
-		pte_chain = NULL;	/* We consumed it */
-		goto out;
+	page_map_unlock(page);
+}
+
+/* this needs the page->flags PG_map_lock held */
+static void inline anon_vma_page_unlink(struct page * page)
+{
+	/*
+	 * Cleanup if this anon page is gone
+	 * as far as the vm is concerned.
+	 */
+	if (!page->mapcount) {
+		page->as.vma = 0;
+#if 0
+		/*
+		 * The above clears page->as.anon_vma too
+		 * if the page wasn't direct.
+		 */
+		page->as.anon_vma = 0;
+#endif
+		ClearPageDirect(page);
 	}
-	cur_pte_chain->ptes[pte_chain_idx(cur_pte_chain) - 1] = pte_paddr;
-	cur_pte_chain->next_and_idx--;
-out:
-	pte_chain_unlock(page);
-	return pte_chain;
 }
 
 /**
  * page_remove_rmap - take down reverse mapping to a page
  * @page: page to remove mapping from
- * @ptep: page table entry to remove
  *
  * Removes the reverse mapping from the pte_chain of the page,
  * after that the caller can clear the page table entry and free
  * the page.
- * Caller needs to hold the mm->page_table_lock.
  */
-void fastcall page_remove_rmap(struct page *page, pte_t *ptep)
+void fastcall page_remove_rmap(struct page *page)
 {
-	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
-	struct pte_chain *pc;
-
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
 
-	pte_chain_lock(page);
+	page_map_lock(page);
 
 	if (!page_mapped(page))
 		goto out_unlock;
 
-	/*
-	 * If this is an object-based page, just uncount it.  We can
-	 * find the mappings by walking the object vma chain for that object.
-	 */
-	if (!PageAnon(page)) {
-		if (!page->mapping)
-			BUG();
-		if (PageSwapCache(page))
-			BUG();
-		if (!page->pte.mapcount)
-			BUG();
-		page->pte.mapcount--;
-		if (!page->pte.mapcount)
-			dec_page_state(nr_mapped);
-		goto out_unlock;
+	if (!--page->mapcount)
+		dec_page_state(nr_mapped);
+
+	if (PageAnon(page))
+		anon_vma_page_unlink(page, vma);
+	else {
+		/*
+		 * If this is an object-based page, just uncount it.
+		 * We can find the mappings by walking the object vma
+		 * chain for that object.
+		 */
+		BUG_ON(!page->as.mapping);
+		BUG_ON(PageSwapCache(page));
 	}
   
-	if (PageDirect(page)) {
-		if (page->pte.direct == pte_paddr) {
-			page->pte.direct = 0;
-			ClearPageDirect(page);
-			goto out;
-		}
-	} else {
-		struct pte_chain *start = page->pte.chain;
-		struct pte_chain *next;
-		int victim_i = pte_chain_idx(start);
-
-		for (pc = start; pc; pc = next) {
-			int i;
-
-			next = pte_chain_next(pc);
-			if (next)
-				prefetch(next);
-			for (i = pte_chain_idx(pc); i < NRPTE; i++) {
-				pte_addr_t pa = pc->ptes[i];
-
-				if (pa != pte_paddr)
-					continue;
-				pc->ptes[i] = start->ptes[victim_i];
-				start->ptes[victim_i] = 0;
-				if (victim_i == NRPTE-1) {
-					/* Emptied a pte_chain */
-					page->pte.chain = pte_chain_next(start);
-					__pte_chain_free(start);
-				} else {
-					start->next_and_idx++;
-				}
-				goto out;
-			}
-		}
-	}
-out:
-	if (page->pte.direct == 0 && page_test_and_clear_dirty(page))
-		set_page_dirty(page);
-	if (!page_mapped(page))
-		dec_page_state(nr_mapped);
-out_unlock:
-	pte_chain_unlock(page);
+	page_map_unlock(page);
 	return;
 }
 
 /**
- * try_to_unmap_obj - unmap a page using the object-based rmap method
+ * try_to_unmap_one - unmap a page using the object-based rmap method
  * @page: the page to unmap
  *
  * Determine whether a page is mapped in a given vma and unmap it if it's found.
  *
- * This function is strictly a helper function for try_to_unmap_obj.
+ * This function is strictly a helper function for try_to_unmap_inode.
  */
-static inline int
-try_to_unmap_obj_one(struct vm_area_struct *vma, struct page *page)
+static int
+try_to_unmap_one(struct vm_area_struct *vma, struct page *page)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -477,17 +393,39 @@ try_to_unmap_obj_one(struct vm_area_stru
 	}
 
 	flush_cache_page(vma, address);
-	pteval = ptep_get_and_clear(pte);
-	flush_tlb_page(vma, address);
+	pteval = ptep_clear_flush(vma, address, pte);
+
+	if (PageSwapCache(page)) {
+		/*
+		 * Store the swap location in the pte.
+		 * See handle_pte_fault() ...
+		 */
+		swp_entry_t entry = { .val = page->index };
+		swap_duplicate(entry);
+		set_pte(pte, swp_entry_to_pte(entry));
+		BUG_ON(pte_file(*pte));
+	} else {
+		unsigned long pgidx;
+		/*
+		 * If a nonlinear mapping then store the file page offset
+		 * in the pte.
+		 */
+		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
+		pgidx += vma->vm_pgoff;
+		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
+		if (page->index != pgidx) {
+			set_pte(pte, pgoff_to_pte(page->index));
+			BUG_ON(!pte_file(*pte));
+		}
+	}
 
 	if (pte_dirty(pteval))
 		set_page_dirty(page);
 
-	if (!page->pte.mapcount)
-		BUG();
+	BUG_ON(!page->mapcount);
 
 	mm->rss--;
-	page->pte.mapcount--;
+	page->mapcount--;
 	page_cache_release(page);
 
 out_unmap:
@@ -499,7 +437,7 @@ out:
 }
 
 /**
- * try_to_unmap_obj - unmap a page using the object-based rmap method
+ * try_to_unmap_inode - unmap a page using the object-based rmap method
  * @page: the page to unmap
  *
  * Find all the mappings of a page using the mapping pointer and the vma chains
@@ -511,30 +449,26 @@ out:
  * return a temporary error.
  */
 static int
-try_to_unmap_obj(struct page *page)
+try_to_unmap_inode(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page->as.mapping;
 	struct vm_area_struct *vma;
 	int ret = SWAP_AGAIN;
 
-	if (!mapping)
-		BUG();
-
-	if (PageSwapCache(page))
-		BUG();
+	BUG_ON(PageSwapCache(page));
 
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;
 	
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		ret = try_to_unmap_obj_one(vma, page);
-		if (ret == SWAP_FAIL || !page->pte.mapcount)
+		ret = try_to_unmap_one(vma, page);
+		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		ret = try_to_unmap_obj_one(vma, page);
-		if (ret == SWAP_FAIL || !page->pte.mapcount)
+		ret = try_to_unmap_one(vma, page);
+		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
 	}
 
@@ -543,94 +477,33 @@ out:
 	return ret;
 }
 
-/**
- * try_to_unmap_one - worker function for try_to_unmap
- * @page: page to unmap
- * @ptep: page table entry to unmap from page
- *
- * Internal helper function for try_to_unmap, called for each page
- * table entry mapping a page. Because locking order here is opposite
- * to the locking order used by the page fault path, we use trylocks.
- * Locking:
- *	    page lock			shrink_list(), trylock
- *		pte_chain_lock		shrink_list()
- *		    mm->page_table_lock	try_to_unmap_one(), trylock
- */
-static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
-static int fastcall try_to_unmap_one(struct page * page, pte_addr_t paddr)
-{
-	pte_t *ptep = rmap_ptep_map(paddr);
-	unsigned long address = ptep_to_address(ptep);
-	struct mm_struct * mm = ptep_to_mm(ptep);
-	struct vm_area_struct * vma;
-	pte_t pte;
-	int ret;
-
-	if (!mm)
-		BUG();
-
-	/*
-	 * We need the page_table_lock to protect us from page faults,
-	 * munmap, fork, etc...
-	 */
-	if (!spin_trylock(&mm->page_table_lock)) {
-		rmap_ptep_unmap(ptep);
-		return SWAP_AGAIN;
-	}
-
-
-	/* During mremap, it's possible pages are not in a VMA. */
-	vma = find_vma(mm, address);
-	if (!vma) {
-		ret = SWAP_FAIL;
-		goto out_unlock;
-	}
-
-	/* The page is mlock()d, we cannot swap it out. */
-	if (vma->vm_flags & VM_LOCKED) {
-		ret = SWAP_FAIL;
-		goto out_unlock;
-	}
+static int
+try_to_unmap_anon(struct page * page)
+{
+	int ret = SWAP_AGAIN;
 
-	/* Nuke the page table entry. */
-	flush_cache_page(vma, address);
-	pte = ptep_clear_flush(vma, address, ptep);
+	page_map_lock(page);
 
-	if (PageSwapCache(page)) {
-		/*
-		 * Store the swap location in the pte.
-		 * See handle_pte_fault() ...
-		 */
-		swp_entry_t entry = { .val = page->index };
-		swap_duplicate(entry);
-		set_pte(ptep, swp_entry_to_pte(entry));
-		BUG_ON(pte_file(*ptep));
+	if (PageDirect(page)) {
+		vma = page->as.vma;
+		ret = try_to_unmap_one(page->as.vma, page);
 	} else {
-		unsigned long pgidx;
-		/*
-		 * If a nonlinear mapping then store the file page offset
-		 * in the pte.
-		 */
-		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
-		pgidx += vma->vm_pgoff;
-		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-		if (page->index != pgidx) {
-			set_pte(ptep, pgoff_to_pte(page->index));
-			BUG_ON(!pte_file(*ptep));
+		struct vm_area_struct * vma;
+		anon_vma_t * anon_vma = page->as.anon_vma;
+
+		spin_lock(&anon_vma->anon_vma_lock);
+		list_for_each_entry(vma, &anon_vma->anon_vma_head, anon_vma_node) {
+			ret = try_to_unmap_one(vma, page);
+			if (ret == SWAP_FAIL || !page->mapcount) {
+				spin_unlock(&anon_vma->anon_vma_lock);
+				goto out;
+			}
 		}
+		spin_unlock(&anon_vma->anon_vma_lock);
 	}
 
-	/* Move the dirty bit to the physical page now the pte is gone. */
-	if (pte_dirty(pte))
-		set_page_dirty(page);
-
-	mm->rss--;
-	page_cache_release(page);
-	ret = SWAP_SUCCESS;
-
-out_unlock:
-	rmap_ptep_unmap(ptep);
-	spin_unlock(&mm->page_table_lock);
+out:
+	page_map_unlock(page);
 	return ret;
 }
 
@@ -650,82 +523,22 @@ int fastcall try_to_unmap(struct page * 
 {
 	struct pte_chain *pc, *next_pc, *start;
 	int ret = SWAP_SUCCESS;
-	int victim_i;
 
 	/* This page should not be on the pageout lists. */
-	if (PageReserved(page))
-		BUG();
-	if (!PageLocked(page))
-		BUG();
-	/* We need backing store to swap out a page. */
-	if (!page->mapping)
-		BUG();
+	BUG_ON(PageReserved(page));
+	BUG_ON(!PageLocked(page));
 
 	/*
-	 * If it's an object-based page, use the object vma chain to find all
-	 * the mappings.
+	 * We need backing store to swap out a page.
+	 * Subtle: this checks for page->as.anon_vma too ;).
 	 */
-	if (!PageAnon(page)) {
-		ret = try_to_unmap_obj(page);
-		goto out;
-	}
+	BUG_ON(!page->as.mapping);
 
-	if (PageDirect(page)) {
-		ret = try_to_unmap_one(page, page->pte.direct);
-		if (ret == SWAP_SUCCESS) {
-			if (page_test_and_clear_dirty(page))
-				set_page_dirty(page);
-			page->pte.direct = 0;
-			ClearPageDirect(page);
-		}
-		goto out;
-	}		
+	if (!PageAnon(page))
+		ret = try_to_unmap_inode(page);
+	else
+		ret = try_to_unmap_anon(page);
 
-	start = page->pte.chain;
-	victim_i = pte_chain_idx(start);
-	for (pc = start; pc; pc = next_pc) {
-		int i;
-
-		next_pc = pte_chain_next(pc);
-		if (next_pc)
-			prefetch(next_pc);
-		for (i = pte_chain_idx(pc); i < NRPTE; i++) {
-			pte_addr_t pte_paddr = pc->ptes[i];
-
-			switch (try_to_unmap_one(page, pte_paddr)) {
-			case SWAP_SUCCESS:
-				/*
-				 * Release a slot.  If we're releasing the
-				 * first pte in the first pte_chain then
-				 * pc->ptes[i] and start->ptes[victim_i] both
-				 * refer to the same thing.  It works out.
-				 */
-				pc->ptes[i] = start->ptes[victim_i];
-				start->ptes[victim_i] = 0;
-				victim_i++;
-				if (victim_i == NRPTE) {
-					page->pte.chain = pte_chain_next(start);
-					__pte_chain_free(start);
-					start = page->pte.chain;
-					victim_i = 0;
-				} else {
-					start->next_and_idx++;
-				}
-				if (page->pte.direct == 0 &&
-				    page_test_and_clear_dirty(page))
-					set_page_dirty(page);
-				break;
-			case SWAP_AGAIN:
-				/* Skip this pte, remembering status. */
-				ret = SWAP_AGAIN;
-				continue;
-			case SWAP_FAIL:
-				ret = SWAP_FAIL;
-				goto out;
-			}
-		}
-	}
-out:
 	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
 		ret = SWAP_SUCCESS;
@@ -733,176 +546,30 @@ out:
 	return ret;
 }
 
-/**
- * page_convert_anon - Convert an object-based mapped page to pte_chain-based.
- * @page: the page to convert
- *
- * Find all the mappings for an object-based page and convert them
- * to 'anonymous', ie create a pte_chain and store all the pte pointers there.
- *
- * This function takes the address_space->i_shared_sem, sets the PageAnon flag,
- * then sets the mm->page_table_lock for each vma and calls page_add_rmap. This
- * means there is a period when PageAnon is set, but still has some mappings
- * with no pte_chain entry.  This is in fact safe, since page_remove_rmap will
- * simply not find it.  try_to_unmap might erroneously return success, but it
- * will never be called because the page_convert_anon() caller has locked the
- * page.
- *
- * page_referenced() may fail to scan all the appropriate pte's and may return
- * an inaccurate result.  This is so rare that it does not matter.
+/*
+ * No more VM stuff below this comment, only anon_vma helper
+ * functions.
  */
-int page_convert_anon(struct page *page)
-{
-	struct address_space *mapping;
-	struct vm_area_struct *vma;
-	struct pte_chain *pte_chain = NULL;
-	pte_t *pte;
-	int err = 0;
-
-	mapping = page->mapping;
-	if (mapping == NULL)
-		goto out;		/* truncate won the lock_page() race */
-
-	down(&mapping->i_shared_sem);
-	pte_chain_lock(page);
-
-	/*
-	 * Has someone else done it for us before we got the lock?
-	 * If so, pte.direct or pte.chain has replaced pte.mapcount.
-	 */
-	if (PageAnon(page)) {
-		pte_chain_unlock(page);
-		goto out_unlock;
-	}
-
-	SetPageAnon(page);
-	if (page->pte.mapcount == 0) {
-		pte_chain_unlock(page);
-		goto out_unlock;
-	}
-	/* This is gonna get incremented by page_add_rmap */
-	dec_page_state(nr_mapped);
-	page->pte.mapcount = 0;
-
-	/*
-	 * Now that the page is marked as anon, unlock it.  page_add_rmap will
-	 * lock it as necessary.
-	 */
-	pte_chain_unlock(page);
-
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		if (!pte_chain) {
-			pte_chain = pte_chain_alloc(GFP_KERNEL);
-			if (!pte_chain) {
-				err = -ENOMEM;
-				goto out_unlock;
-			}
-		}
-		spin_lock(&vma->vm_mm->page_table_lock);
-		pte = find_pte(vma, page, NULL);
-		if (pte) {
-			/* Make sure this isn't a duplicate */
-			page_remove_rmap(page, pte);
-			pte_chain = page_add_rmap(page, pte, pte_chain);
-			pte_unmap(pte);
-		}
-		spin_unlock(&vma->vm_mm->page_table_lock);
-	}
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		if (!pte_chain) {
-			pte_chain = pte_chain_alloc(GFP_KERNEL);
-			if (!pte_chain) {
-				err = -ENOMEM;
-				goto out_unlock;
-			}
-		}
-		spin_lock(&vma->vm_mm->page_table_lock);
-		pte = find_pte(vma, page, NULL);
-		if (pte) {
-			/* Make sure this isn't a duplicate */
-			page_remove_rmap(page, pte);
-			pte_chain = page_add_rmap(page, pte, pte_chain);
-			pte_unmap(pte);
-		}
-		spin_unlock(&vma->vm_mm->page_table_lock);
-	}
-
-out_unlock:
-	pte_chain_free(pte_chain);
-	up(&mapping->i_shared_sem);
-out:
-	return err;
-}
-
-/**
- ** No more VM stuff below this comment, only pte_chain helper
- ** functions.
- **/
-
-static void pte_chain_ctor(void *p, kmem_cache_t *cachep, unsigned long flags)
-{
-	struct pte_chain *pc = p;
-
-	memset(pc, 0, sizeof(*pc));
-}
-
-DEFINE_PER_CPU(struct pte_chain *, local_pte_chain) = 0;
 
-/**
- * __pte_chain_free - free pte_chain structure
- * @pte_chain: pte_chain struct to free
- */
-void __pte_chain_free(struct pte_chain *pte_chain)
+static void
+anon_vma_ctor(void *data, kmem_cache_t *cachep, unsigned long flags)
 {
-	struct pte_chain **pte_chainp;
-
-	pte_chainp = &get_cpu_var(local_pte_chain);
-	if (pte_chain->next_and_idx)
-		pte_chain->next_and_idx = 0;
-	if (*pte_chainp)
-		kmem_cache_free(pte_chain_cache, *pte_chainp);
-	*pte_chainp = pte_chain;
-	put_cpu_var(local_pte_chain);
-}
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		anon_vma_t * anon_vma = (anon_vma_t *) data;
 
-/*
- * pte_chain_alloc(): allocate a pte_chain structure for use by page_add_rmap().
- *
- * The caller of page_add_rmap() must perform the allocation because
- * page_add_rmap() is invariably called under spinlock.  Often, page_add_rmap()
- * will not actually use the pte_chain, because there is space available in one
- * of the existing pte_chains which are attached to the page.  So the case of
- * allocating and then freeing a single pte_chain is specially optimised here,
- * with a one-deep per-cpu cache.
- */
-struct pte_chain *pte_chain_alloc(int gfp_flags)
-{
-	struct pte_chain *ret;
-	struct pte_chain **pte_chainp;
-
-	might_sleep_if(gfp_flags & __GFP_WAIT);
-
-	pte_chainp = &get_cpu_var(local_pte_chain);
-	if (*pte_chainp) {
-		ret = *pte_chainp;
-		*pte_chainp = NULL;
-		put_cpu_var(local_pte_chain);
-	} else {
-		put_cpu_var(local_pte_chain);
-		ret = kmem_cache_alloc(pte_chain_cache, gfp_flags);
+		spin_lock_init(&anon_vma->anon_vma_lock);
+		INIT_LIST_HEAD(&anon_vma->anon_vma_head);
 	}
-	return ret;
 }
 
-void __init pte_chain_init(void)
+void __init anon_vma_init(void)
 {
-	pte_chain_cache = kmem_cache_create(	"pte_chain",
-						sizeof(struct pte_chain),
-						0,
-						SLAB_MUST_HWCACHE_ALIGN,
-						pte_chain_ctor,
-						NULL);
+	/* this is intentonally not hw aligned to avoid wasting ram */
+	anon_vma_cachep = kmem_cache_create("anon_vma",
+					    sizeof(anon_vma_t), 0, 0,
+					    anon_vma_ctor, NULL);
 
-	if (!pte_chain_cache)
-		panic("failed to create pte_chain cache!\n");
+	if(!anon_vma_cachep)
+		panic("Cannot create anon_vma SLAB cache");
 }
--- sles-anobjrmap-2/mm/Makefile.~1~	2004-02-29 17:47:30.000000000 +0100
+++ sles-anobjrmap-2/mm/Makefile	2004-03-10 20:26:16.000000000 +0100
@@ -4,7 +4,7 @@
 
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
-			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
+			   mlock.o mmap.o mprotect.o mremap.o msync.o objrmap.o \
 			   shmem.o vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
