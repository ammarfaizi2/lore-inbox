Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268762AbTCCUfV>; Mon, 3 Mar 2003 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268763AbTCCUfV>; Mon, 3 Mar 2003 15:35:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6855 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268762AbTCCUfN>;
	Mon, 3 Mar 2003 15:35:13 -0500
Date: Mon, 3 Mar 2003 21:45:21 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: [patch] remap-file-pages-2.5.63-A1
In-Reply-To: <Pine.LNX.4.44.0303030849050.11244-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303032136090.18483-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've attached the latest fremap() improvement patch, with the following
fixes relative to -A0:

 - keep the pte cleared and fall back to the linear path if the mapping is 
   linear. This keeps the mmap() limits untouched.

 - Muli Ben-Yehuda noticed a typo in an error code, it should be 
   VM_FAULT_SIGBUS, not VM_FAULT_OOM.

 - sys_remap_file_pages() is now enforcing the 'prot' parameter to be 
   zero. This restriction might be lifted in the future - i really hope we
   can have more flexible remapping once 64-bit platforms are commonplace
   - eg. things like memory debuggers could just use the permission bits
   directly, instead of creating many small vmas.

i've tested swappable nonlinear ptes and they are swapped out/in
correctly.

some other changes in -A0 relative to 2.5.63-BK:

 - slightly smarter TLB flushing in install_page(). This is still only a 
   stupid helper functions - a more efficient 'walk the pagecache tree
   and pagetable at once and use TLB-gather' implementation is preferred.

 - cleanup: pass on pgprot_t instead of unsigned long prot.

 - some sanity checks to make sure file_pte() rules are followed.

 - do not reduce the vma's default protection to PROT_NONE when using 
   remap_file_pages() on it. With swappable ptes this is now safe.

	Ingo

--- linux/include/linux/mm.h.orig	
+++ linux/include/linux/mm.h	
@@ -136,7 +136,7 @@ struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
-	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, unsigned long prot, unsigned long pgoff, int nonblock);
+	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
 /* forward declaration; pte_chain is meant to be internal to rmap.c */
@@ -419,7 +419,7 @@ extern int vmtruncate(struct inode * ino
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
-extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, unsigned long prot);
+extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
--- linux/include/linux/swapops.h.orig	
+++ linux/include/linux/swapops.h	
@@ -51,6 +51,7 @@ static inline swp_entry_t pte_to_swp_ent
 {
 	swp_entry_t arch_entry;
 
+	BUG_ON(pte_file(pte));
 	arch_entry = __pte_to_swp_entry(pte);
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
@@ -64,5 +65,6 @@ static inline pte_t swp_entry_to_pte(swp
 	swp_entry_t arch_entry;
 
 	arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
+	BUG_ON(pte_file(__swp_entry_to_pte(arch_entry)));
 	return __swp_entry_to_pte(arch_entry);
 }
--- linux/include/asm-i386/pgtable.h.orig	
+++ linux/include/asm-i386/pgtable.h	
@@ -112,6 +112,7 @@ void pgtable_cache_init(void);
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
 
+#define _PAGE_FILE	0x040	/* pagecache or swap? */
 #define _PAGE_PROTNONE	0x080	/* If not present */
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -189,6 +190,7 @@ static inline int pte_exec(pte_t pte)		{
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
+static inline int pte_file(pte_t pte)		{ return (pte).pte_low & _PAGE_FILE; }
 
 static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
 static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
@@ -286,7 +288,7 @@ typedef pte_t *pte_addr_t;
 #define update_mmu_cache(vma,address,pte) do { } while (0)
 
 /* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 1) & 0x3f)
+#define __swp_type(x)			(((x).val >> 1) & 0x1f)
 #define __swp_offset(x)			((x).val >> 8)
 #define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
--- linux/include/asm-i386/pgtable-2level.h.orig	
+++ linux/include/asm-i386/pgtable-2level.h	
@@ -63,4 +63,14 @@ static inline pmd_t * pmd_offset(pgd_t *
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
--- linux/include/asm-i386/pgtable-3level.h.orig	
+++ linux/include/asm-i386/pgtable-3level.h	
@@ -115,4 +115,11 @@ static inline pmd_t pfn_pmd(unsigned lon
 	return __pmd(((unsigned long long)page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
 }
 
+/*
+ * Bits 0, 6 and 7 are taken in the low part of the pte,
+ * put the 32 bits of offset into the high part.
+ */
+#define pte_to_pgoff(pte) ((pte).pte_high)
+#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
--- linux/mm/fremap.c.orig	
+++ linux/mm/fremap.c	
@@ -16,12 +16,12 @@
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
 
@@ -36,9 +36,12 @@ static inline void zap_pte(struct mm_str
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
 
@@ -47,9 +50,9 @@ static inline void zap_pte(struct mm_str
  * previously existing mapping.
  */
 int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, struct page *page, unsigned long prot)
+		unsigned long addr, struct page *page, pgprot_t prot)
 {
-	int err = -ENOMEM;
+	int err = -ENOMEM, flush;
 	pte_t *pte, entry;
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -69,18 +72,17 @@ int install_page(struct mm_struct *mm, s
 	if (!pte)
 		goto err_unlock;
 
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
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
-	flush_tlb_page(vma, addr);
+	if (flush)
+		flush_tlb_page(vma, addr);
 
 	spin_unlock(&mm->page_table_lock);
 	pte_chain_free(pte_chain);
@@ -104,26 +106,28 @@ err:
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
 
+	if (__prot)
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
 
@@ -136,15 +140,9 @@ int sys_remap_file_pages(unsigned long s
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
 
--- linux/mm/shmem.c.orig	
+++ linux/mm/shmem.c	
@@ -945,7 +945,7 @@ struct page *shmem_nopage(struct vm_area
 
 static int shmem_populate(struct vm_area_struct *vma,
 	unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long pgoff, int nonblock)
+	pgprot_t prot, unsigned long pgoff, int nonblock)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct mm_struct *mm = vma->vm_mm;
--- linux/mm/filemap.c.orig	
+++ linux/mm/filemap.c	
@@ -1195,7 +1195,7 @@ err:
 static int filemap_populate(struct vm_area_struct *vma,
 			unsigned long addr,
 			unsigned long len,
-			unsigned long prot,
+			pgprot_t prot,
 			unsigned long pgoff,
 			int nonblock)
 {
--- linux/mm/swapfile.c.orig	
+++ linux/mm/swapfile.c	
@@ -384,6 +384,8 @@ unuse_pte(struct vm_area_struct *vma, un
 {
 	pte_t pte = *dir;
 
+	if (pte_file(pte))
+		return;
 	if (likely(pte_to_swp_entry(pte).val != entry.val))
 		return;
 	if (unlikely(pte_none(pte) || pte_present(pte)))
--- linux/mm/rmap.c.orig	
+++ linux/mm/rmap.c	
@@ -365,11 +365,26 @@ static int try_to_unmap_one(struct page 
 	pte = ptep_get_and_clear(ptep);
 	flush_tlb_page(vma, address);
 
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
+		unsigned long pgidx;
+		/*
+		 * If a nonlinear mapping then store the file page offset
+		 * in the pte.
+		 */
+		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
+		if (page->index != pgidx) {
+			set_pte(ptep, pgoff_to_pte(page->index));
+			BUG_ON(!pte_file(*ptep));
+		}
 	}
 
 	/* Move the dirty bit to the physical page now the pte is gone. */
--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -281,7 +281,8 @@ skip_copy_pte_range:
 					goto cont_copy_pte_range_noset;
 				/* pte contains position in swap, so copy. */
 				if (!pte_present(pte)) {
-					swap_duplicate(pte_to_swp_entry(pte));
+					if (!pte_file(pte))
+						swap_duplicate(pte_to_swp_entry(pte));
 					set_pte(dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
@@ -408,7 +409,8 @@ zap_pte_range(struct mmu_gather *tlb, pm
 				}
 			}
 		} else {
-			free_swap_and_cache(pte_to_swp_entry(pte));
+			if (!pte_file(pte))
+				free_swap_and_cache(pte_to_swp_entry(pte));
 			pte_clear(ptep);
 		}
 	}
@@ -1381,6 +1383,41 @@ out:
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
+		return VM_FAULT_SIGBUS;
+	return VM_FAULT_MAJOR;
+}
+
+/*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
  * RISC architectures).  The early dirtying is also good on the i386.
@@ -1416,6 +1453,8 @@ static inline int handle_pte_fault(struc
 		 */
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte, pmd);
+		if (pte_file(entry))
+			return do_file_page(mm, vma, address, write_access, pte, pmd);
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}
 

