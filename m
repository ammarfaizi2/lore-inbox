Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSJVRi0>; Tue, 22 Oct 2002 13:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264780AbSJVRi0>; Tue, 22 Oct 2002 13:38:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61131 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261908AbSJVRhs>;
	Tue, 22 Oct 2002 13:37:48 -0400
Date: Tue, 22 Oct 2002 19:57:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
Message-ID: <Pine.LNX.4.44.0210221936010.18790-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (ontop of 2.5.44-mm2) implements generic (swappable!)
nonlinear mappings and sys_remap_file_pages() support. Ie. no more
MAP_LOCKED restrictions and strange pagefault semantics.

to implement this i added a new pte concept: "file pte's". This means that
upon swapout, shared-named mappings do not get cleared but get converted
into file pte's, which can then be decoded by the pagefault path and can
be looked up in the pagecache.

the normal linear pagefault path from now on does not assume linearity and
decodes the offset in the pte. This also tests pte encoding/decoding in
the pagecache case, and the ->populate functions.

the offset is stored in the raw pte the following way, for x86 32-bit
ptes:

   #define pte_to_pgoff(pte) \
       ((((pte).pte_low >> 1) & 0x1f ) + (((pte).pte_low >> 8) << 5 ))

   #define pgoff_to_pte(off) \
       ((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })

the encoding is much simpler in the 64-bit x86 pte (PAE-highmem) case:

   #define pte_to_pgoff(pte) ((pte).pte_high)
   #define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })

in the 32-bit pte (4K page) case the max offset (ie. max file size)
supported is 2 TBs. In the PAE case it's the former 16 TB limit (can be
much more if/when page->index is enlarged).

the swap-pte needs one more bit (besides _PAGE_PROTNONE) to tell pagecache
and swapcache ptes apart, but fortunately _PAGE_FILE does not affect swap
device limits.

NOTE: sys_file_remap_pages() currently ignores the 'prot' parameter and
uses the default one in the vma, but i'm planning, as a next step, to
extend these new pte encodings with protection bits as well, which also
enables an mprotect() implementation that does not cause vmas to be split
up (yummie!).

NOTE2: anonymous mappings are not random-remappable yet, that will be yet
another future step.

the patch also cleans up some aspects of nonlinear vmas.

i have tested the patch quite extensively on nohighmem and highmem-64GB
(PAE) as well, under heavy swapping load, but with such an intrusive patch
there might be some details missing.

	Ingo

--- linux/include/linux/mm.h.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/include/linux/mm.h	2002-10-22 17:08:28.000000000 +0200
@@ -130,7 +130,7 @@
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
-	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, unsigned long prot, unsigned long pgoff, int nonblock);
+	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
 /* forward declaration; pte_chain is meant to be internal to rmap.c */
@@ -373,7 +373,7 @@
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
-extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, unsigned long prot);
+extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
--- linux/include/linux/swapops.h.orig	2002-09-20 17:20:13.000000000 +0200
+++ linux/include/linux/swapops.h	2002-10-22 19:20:00.000000000 +0200
@@ -51,6 +51,7 @@
 {
 	swp_entry_t arch_entry;
 
+	BUG_ON(pte_file(pte));
 	arch_entry = __pte_to_swp_entry(pte);
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
@@ -64,5 +65,6 @@
 	swp_entry_t arch_entry;
 
 	arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
+	BUG_ON(pte_file(__swp_entry_to_pte(arch_entry)));
 	return __swp_entry_to_pte(arch_entry);
 }
--- linux/include/asm-i386/pgtable.h.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/include/asm-i386/pgtable.h	2002-10-22 19:12:58.000000000 +0200
@@ -121,6 +121,7 @@
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
 
+#define _PAGE_FILE	0x040	/* pagecache or swap? */
 #define _PAGE_PROTNONE	0x080	/* If not present */
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -199,6 +200,7 @@
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
+static inline int pte_file(pte_t pte)		{ return (pte).pte_low & _PAGE_FILE; }
 
 static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
 static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
@@ -306,7 +308,7 @@
 #define update_mmu_cache(vma,address,pte) do { } while (0)
 
 /* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 1) & 0x3f)
+#define __swp_type(x)			(((x).val >> 1) & 0x1f)
 #define __swp_offset(x)			((x).val >> 8)
 #define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
--- linux/include/asm-i386/pgtable-2level.h.orig	2002-10-22 19:12:15.000000000 +0200
+++ linux/include/asm-i386/pgtable-2level.h	2002-10-22 19:13:16.000000000 +0200
@@ -63,4 +63,14 @@
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
+/*
+ * Bits 0, 6 and 7 are taken, split up the 29 bits of offset
+ * into this range:
+ */
+#define pte_to_pgoff(pte) \
+	((((pte).pte_low >> 1) & 0x1f ) + (((pte).pte_low >> 8) << 5 ))
+
+#define pgoff_to_pte(off) \
+	((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
+
 #endif /* _I386_PGTABLE_2LEVEL_H */
--- linux/include/asm-i386/pgtable-3level.h.orig	2002-10-22 19:12:21.000000000 +0200
+++ linux/include/asm-i386/pgtable-3level.h	2002-10-22 19:17:08.000000000 +0200
@@ -108,4 +108,11 @@
 
 extern struct kmem_cache_s *pae_pgd_cachep;
 
+/*
+ * Bits 0, 6 and 7 are taken in the low part of the pte,
+ * put the 32 bits of offset into the high part.
+ */
+#define pte_to_pgoff(pte) ((pte).pte_high)
+#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
--- linux/mm/fremap.c.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/mm/fremap.c	2002-10-22 19:07:22.000000000 +0200
@@ -17,12 +17,12 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static inline void zap_pte(struct mm_struct *mm, pte_t *ptep)
+static inline int zap_pte(struct mm_struct *mm, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 
 	if (pte_none(pte))
-		return;
+		return 0;
 	if (pte_present(pte)) {
 		unsigned long pfn = pte_pfn(pte);
 
@@ -37,9 +37,12 @@
 				mm->rss--;
 			}
 		}
+		return 1;
 	} else {
-		free_swap_and_cache(pte_to_swp_entry(pte));
+		if (!pte_file(pte))
+			free_swap_and_cache(pte_to_swp_entry(pte));
 		pte_clear(ptep);
+		return 0;
 	}
 }
 
@@ -48,16 +51,16 @@
  * previously existing mapping.
  */
 int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, struct page *page, unsigned long prot)
+		unsigned long addr, struct page *page, pgprot_t prot)
 {
-	int err = -ENOMEM;
+	int err = -ENOMEM, flush;
 	struct page *ptepage;
 	pte_t *pte, entry;
 	pgd_t *pgd;
 	pmd_t *pmd;
 
-	spin_lock(&mm->page_table_lock);
 	pgd = pgd_offset(mm, addr);
+	spin_lock(&mm->page_table_lock);
 
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
@@ -72,7 +75,6 @@
 			ptepage = pmd_page(*pmd);
 		} else
 			pte = pte_offset_map(pmd, addr);
-		goto mapped;
 	} else {
 #endif	
 		pte = pte_alloc_map(mm, pmd, addr);
@@ -83,22 +85,19 @@
 		pte_page_lock(ptepage);
 #ifdef CONFIG_SHAREPTE
 	}
-mapped:
 #endif
-	zap_pte(mm, pte);
+	flush = zap_pte(mm, pte);
 
 	mm->rss++;
 	flush_page_to_ram(page);
 	flush_icache_page(vma, page);
-	entry = mk_pte(page, protection_map[prot]);
-	if (prot & PROT_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
+	entry = mk_pte(page, prot);
 	set_pte(pte, entry);
 	page_add_rmap(page, pte);
 	pte_unmap(pte);
-	flush_tlb_page(vma, addr);
+	if (flush)
+		flush_tlb_page(vma, addr);
 
-	pte_page_unlock(ptepage);
 	spin_unlock(&mm->page_table_lock);
 
 	return 0;
@@ -119,26 +118,28 @@
  *
  * this syscall works purely via pagetables, so it's the most efficient
  * way to map the same (large) file into a given virtual window. Unlike
- * mremap()/mmap() it does not create any new vmas.
+ * mmap()/mremap() it does not create any new vmas. The new mappings are
+ * also safe across swapout.
  *
- * The new mappings do not live across swapout, so either use MAP_LOCKED
- * or use PROT_NONE in the original linear mapping and add a special
- * SIGBUS pagefault handler to reinstall zapped mappings.
+ * NOTE: the 'prot' parameter right now is ignored, and the vma's default
+ * protection is used. Arbitrary protections might be implemented in the
+ * future.
  */
 int sys_remap_file_pages(unsigned long start, unsigned long size,
-	unsigned long prot, unsigned long pgoff, unsigned long flags)
+	unsigned long __prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long end = start + size;
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
 
+	if (__prot & ~0xf)
+		return err;
 	/*
 	 * Sanitize the syscall parameters:
 	 */
-	start = PAGE_ALIGN(start);
-	size = PAGE_ALIGN(size);
-	prot &= 0xf;
+	start = start & PAGE_MASK;
+	size = size & PAGE_MASK;
 
 	down_read(&mm->mmap_sem);
 
@@ -151,15 +152,9 @@
 	if (vma && (vma->vm_flags & VM_SHARED) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end) {
-		/*
-		 * Change the default protection to PROT_NONE:
-		 */
-		if (pgprot_val(vma->vm_page_prot) != pgprot_val(__S000))
-			vma->vm_page_prot = __S000;
-		err = vma->vm_ops->populate(vma, start, size, prot,
-						pgoff, flags & MAP_NONBLOCK);
-	}
+				end <= vma->vm_end)
+		err = vma->vm_ops->populate(vma, start, size, vma->vm_page_prot,
+				pgoff, flags & MAP_NONBLOCK);
 
 	up_read(&mm->mmap_sem);
 
--- linux/mm/shmem.c.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/mm/shmem.c	2002-10-22 17:09:41.000000000 +0200
@@ -954,7 +954,7 @@
 
 static int shmem_populate(struct vm_area_struct *vma,
 	unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long pgoff, int nonblock)
+	pgprot_t prot, unsigned long pgoff, int nonblock)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct mm_struct *mm = vma->vm_mm;
--- linux/mm/filemap.c.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/mm/filemap.c	2002-10-22 17:10:23.000000000 +0200
@@ -1290,7 +1290,7 @@
 static int filemap_populate(struct vm_area_struct *vma,
 			unsigned long addr,
 			unsigned long len,
-			unsigned long prot,
+			pgprot_t prot,
 			unsigned long pgoff,
 			int nonblock)
 {
--- linux/mm/swapfile.c.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/mm/swapfile.c	2002-10-22 18:59:53.000000000 +0200
@@ -377,6 +377,8 @@
 {
 	pte_t pte = *dir;
 
+	if (pte_file(pte))
+		return;
 	if (likely(pte_to_swp_entry(pte).val != entry.val))
 		return;
 	if (unlikely(pte_none(pte) || pte_present(pte)))
--- linux/mm/rmap.c.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/mm/rmap.c	2002-10-22 19:17:09.000000000 +0200
@@ -666,11 +666,21 @@
 	}
 	pte_page_unlock(ptepage);
 
-	/* Store the swap location in the pte. See handle_pte_fault() ... */
 	if (PageSwapCache(page)) {
+		/*
+		 * Store the swap location in the pte.
+		 * See handle_pte_fault() ...
+		 */
 		swp_entry_t entry = { .val = page->index };
 		swap_duplicate(entry);
 		set_pte(ptep, swp_entry_to_pte(entry));
+		BUG_ON(pte_file(*ptep));
+	} else {
+		/*
+		 * Store the file page offset in the pte.
+		 */
+		set_pte(ptep, pgoff_to_pte(page->index));
+		BUG_ON(!pte_file(*ptep));
 	}
 
 	/* Move the dirty bit to the physical page now the pte is gone. */
--- linux/mm/memory.c.orig	2002-10-22 17:03:22.000000000 +0200
+++ linux/mm/memory.c	2002-10-22 19:11:42.000000000 +0200
@@ -311,7 +311,8 @@
 				goto unshare_skip_set;
 
 			if (!pte_present(pte)) {
-				swap_duplicate(pte_to_swp_entry(pte));
+				if (!pte_file(pte))
+					swap_duplicate(pte_to_swp_entry(pte));
 				set_pte(dst_pte, pte);
 				goto unshare_skip_set;
 			}
@@ -716,7 +717,8 @@
 					goto cont_copy_pte_range_noset;
 				/* pte contains position in swap, so copy. */
 				if (!pte_present(pte)) {
-					swap_duplicate(pte_to_swp_entry(pte));
+					if (!pte_file(pte))
+						swap_duplicate(pte_to_swp_entry(pte));
 					set_pte(dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
@@ -810,7 +812,8 @@
 				}
 			}
 		} else {
-			free_swap_and_cache(pte_to_swp_entry(pte));
+			if (!pte_file(pte))
+				free_swap_and_cache(pte_to_swp_entry(pte));
 			pte_clear(ptep);
 		}
 	}
@@ -1805,6 +1808,41 @@
 }
 
 /*
+ * Fault of a previously existing named mapping. Repopulate the pte
+ * from the encoded file_pte if possible. This enables swappable
+ * nonlinear vmas.
+ */
+static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
+	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+{
+	unsigned long pgoff;
+	int err;
+
+	BUG_ON(!vma->vm_ops || !vma->vm_ops->nopage);
+	/*
+	 * Fall back to the linear mapping if the fs does not support
+	 * ->populate:
+	 */
+	if (!vma->vm_ops || !vma->vm_ops->populate || 
+			(write_access && !(vma->vm_flags & VM_SHARED))) {
+		pte_clear(pte);
+		return do_no_page(mm, vma, address, write_access, pte, pmd);
+	}
+
+	pgoff = pte_to_pgoff(*pte);
+
+	pte_unmap(pte);
+	spin_unlock(&mm->page_table_lock);
+
+	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err)
+		return VM_FAULT_OOM;
+	return VM_FAULT_MAJOR;
+}
+
+/*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
  * RISC architectures).  The early dirtying is also good on the i386.
@@ -1833,13 +1871,10 @@
 
 	entry = *pte;
 	if (!pte_present(entry)) {
-		/*
-		 * If it truly wasn't present, we know that kswapd
-		 * and the PTE updates will not touch it later. So
-		 * drop the lock.
-		 */
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte, pmd);
+		if (pte_file(entry))
+			return do_file_page(mm, vma, address, write_access, pte, pmd);
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}
 

