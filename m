Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265362AbSJRXCF>; Fri, 18 Oct 2002 19:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265389AbSJRXCF>; Fri, 18 Oct 2002 19:02:05 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:9177 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265362AbSJRXBK>; Fri, 18 Oct 2002 19:01:10 -0400
Date: Fri, 18 Oct 2002 18:06:57 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <309790000.1034982417@baldur.austin.ibm.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========734028336=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========734028336==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Ok, I've shaken the shared page table code hard, and fixed all the bugs I
could find.  It now runs reliably on all the configurations I have access
to, including regression runs of LTP.

I've audited the usage of page_table_lock, and I believe I have covered all
the places that also need to hold the pte_page_lock.

For reference, one of the tests was TPC-H.  My code reduced the number of
allocated pte_chains from 5 million to 50 thousand.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========734028336==========
Content-Type: text/plain; charset=iso-8859-1; name="shpte-2.5.43-mm2-4.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shpte-2.5.43-mm2-4.diff";
 size=64160

--- 2.5.43-mm2/./fs/exec.c	2002-10-17 11:12:59.000000000 -0500
+++ 2.5.43-mm2-shpte/./fs/exec.c	2002-10-17 11:42:16.000000000 -0500
@@ -47,6 +47,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
+#include <asm/rmap.h>
=20
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
@@ -311,8 +312,8 @@
 	flush_page_to_ram(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
 	page_add_rmap(page, pte);
+	increment_rss(kmap_atomic_to_page(pte));
 	pte_unmap(pte);
-	tsk->mm->rss++;
 	spin_unlock(&tsk->mm->page_table_lock);
=20
 	/* no need for flush_tlb */
--- 2.5.43-mm2/./arch/i386/kernel/vm86.c	2002-10-15 22:27:15.000000000 =
-0500
+++ 2.5.43-mm2-shpte/./arch/i386/kernel/vm86.c	2002-10-18 =
13:35:44.000000000 -0500
@@ -39,6 +39,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/highmem.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -120,6 +121,7 @@
=20
 static void mark_screen_rdonly(struct task_struct * tsk)
 {
+	struct page *ptepage;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte, *mapped;
@@ -143,6 +145,8 @@
 		pmd_clear(pmd);
 		goto out;
 	}
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
 	pte =3D mapped =3D pte_offset_map(pmd, 0xA0000);
 	for (i =3D 0; i < 32; i++) {
 		if (pte_present(*pte))
@@ -150,6 +154,7 @@
 		pte++;
 	}
 	pte_unmap(mapped);
+	pte_page_unlock(ptepage);
 out:
 	spin_unlock(&tsk->mm->page_table_lock);
 	preempt_enable();
--- 2.5.43-mm2/./arch/i386/Config.help	2002-10-15 22:27:14.000000000 -0500
+++ 2.5.43-mm2-shpte/./arch/i386/Config.help	2002-10-17 11:42:16.000000000 =
-0500
@@ -165,6 +165,13 @@
   low memory.  Setting this option will put user-space page table
   entries in high memory.
=20
+CONFIG_SHAREPTE
+  Normally each address space has its own complete page table for all
+  its mappings.  This can mean many mappings of a set of shared data
+  pages.  With this option, the VM will attempt to share the bottom
+  level of the page table between address spaces that are sharing data
+  pages.
+
 CONFIG_HIGHMEM4G
   Select this if you have a 32-bit processor and between 1 and 4
   gigabytes of physical RAM.
--- 2.5.43-mm2/./arch/i386/config.in	2002-10-17 11:12:53.000000000 -0500
+++ 2.5.43-mm2-shpte/./arch/i386/config.in	2002-10-17 11:42:16.000000000 =
-0500
@@ -233,6 +233,7 @@
 if [ "$CONFIG_HIGHMEM4G" =3D "y" -o "$CONFIG_HIGHMEM64G" =3D "y" ]; then
    bool 'Allocate 3rd-level pagetables from highmem' CONFIG_HIGHPTE
 fi
+bool 'Share 3rd-level pagetables' CONFIG_SHAREPTE y
=20
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
--- 2.5.43-mm2/./include/linux/mm.h	2002-10-17 11:13:00.000000000 -0500
+++ 2.5.43-mm2-shpte/./include/linux/mm.h	2002-10-17 11:42:16.000000000 =
-0500
@@ -164,6 +164,8 @@
 		struct pte_chain *chain;/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock */
 		pte_addr_t direct;
+		struct mm_chain *mmchain;/* Reverse mm_struct mapping pointer */
+		struct mm_struct *mmdirect;
 	} pte;
 	unsigned long private;		/* mapping-private opaque data */
=20
@@ -358,7 +360,12 @@
 extern int shmem_zero_setup(struct vm_area_struct *);
=20
 extern void zap_page_range(struct vm_area_struct *vma, unsigned long =
address, unsigned long size);
+#ifdef CONFIG_SHAREPTE
+extern pte_t *pte_unshare(struct mm_struct *mm, pmd_t *pmd, unsigned long =
address);
+extern int share_page_range(struct mm_struct *dst, struct mm_struct *src, =
struct vm_area_struct *vma, pmd_t **prev_pmd);
+#else
 extern int copy_page_range(struct mm_struct *dst, struct mm_struct *src, =
struct vm_area_struct *vma);
+#endif
 extern int remap_page_range(struct vm_area_struct *vma, unsigned long =
from, unsigned long to, unsigned long size, pgprot_t prot);
 extern int zeromap_page_range(struct vm_area_struct *vma, unsigned long =
from, unsigned long size, pgprot_t prot);
=20
--- 2.5.43-mm2/./include/linux/rmap-locking.h	2002-10-15 22:27:16.000000000 =
-0500
+++ 2.5.43-mm2-shpte/./include/linux/rmap-locking.h	2002-10-17 =
11:42:19.000000000 -0500
@@ -23,6 +23,18 @@
 #endif
 }
=20
+static inline int pte_chain_trylock(struct page *page)
+{
+	preempt_disable();
+#ifdef CONFIG_SMP
+	if (test_and_set_bit(PG_chainlock, &page->flags)) {
+		preempt_enable();
+		return 0;
+	}
+#endif
+	return 1;
+}
+
 static inline void pte_chain_unlock(struct page *page)
 {
 #ifdef CONFIG_SMP
@@ -31,3 +43,7 @@
 #endif
 	preempt_enable();
 }
+
+#define pte_page_lock		pte_chain_lock
+#define pte_page_trylock	pte_chain_trylock
+#define pte_page_unlock		pte_chain_unlock
--- 2.5.43-mm2/./include/linux/page-flags.h	2002-10-17 11:13:00.000000000 =
-0500
+++ 2.5.43-mm2-shpte/./include/linux/page-flags.h	2002-10-17 =
16:06:42.000000000 -0500
@@ -68,7 +68,7 @@
 #define PG_chainlock		15	/* lock bit for ->pte_chain */
=20
 #define PG_direct		16	/* ->pte_chain points directly at pte */
-
+#define	PG_ptepage		17	/* This page is a pte page */
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -239,6 +239,12 @@
 #define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, =
&(page)->flags)
=20
+#define PagePtepage(page)	test_bit(PG_ptepage, &(page)->flags)
+#define SetPagePtepage(page)	set_bit(PG_ptepage, &(page)->flags)
+#define TestSetPagePtepage(page)	test_and_set_bit(PG_ptepage, =
&(page)->flags)
+#define ClearPagePtepage(page)		clear_bit(PG_ptepage, &(page)->flags)
+#define TestClearPagePtepage(page)	test_and_clear_bit(PG_ptepage, =
&(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
--- 2.5.43-mm2/./include/asm-generic/rmap.h	2002-10-15 22:28:24.000000000 =
-0500
+++ 2.5.43-mm2-shpte/./include/asm-generic/rmap.h	2002-10-17 =
11:42:16.000000000 -0500
@@ -26,33 +26,6 @@
  */
 #include <linux/mm.h>
=20
-static inline void pgtable_add_rmap(struct page * page, struct mm_struct * =
mm, unsigned long address)
-{
-#ifdef BROKEN_PPC_PTE_ALLOC_ONE
-	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
-	extern int mem_init_done;
-
-	if (!mem_init_done)
-		return;
-#endif
-	page->mapping =3D (void *)mm;
-	page->index =3D address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-	inc_page_state(nr_page_table_pages);
-}
-
-static inline void pgtable_remove_rmap(struct page * page)
-{
-	page->mapping =3D NULL;
-	page->index =3D 0;
-	dec_page_state(nr_page_table_pages);
-}
-
-static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
-{
-	struct page * page =3D kmap_atomic_to_page(ptep);
-	return (struct mm_struct *) page->mapping;
-}
-
 static inline unsigned long ptep_to_address(pte_t * ptep)
 {
 	struct page * page =3D kmap_atomic_to_page(ptep);
@@ -87,4 +60,10 @@
 }
 #endif
=20
+extern void pgtable_add_rmap(struct page * page, struct mm_struct * mm, =
unsigned long address);
+extern void pgtable_add_rmap_locked(struct page * page, struct mm_struct * =
mm, unsigned long address);
+extern void pgtable_remove_rmap(struct page * page, struct mm_struct *mm);
+extern void pgtable_remove_rmap_locked(struct page * page, struct =
mm_struct *mm);
+extern void increment_rss(struct page *ptepage);
+
 #endif /* _GENERIC_RMAP_H */
--- 2.5.43-mm2/./include/asm-i386/rmap.h	2002-10-15 22:28:25.000000000 =
-0500
+++ 2.5.43-mm2-shpte/./include/asm-i386/rmap.h	2002-10-17 =
16:06:42.000000000 -0500
@@ -9,12 +9,15 @@
 {
 	unsigned long pfn =3D (unsigned long)(pte_paddr >> PAGE_SHIFT);
 	unsigned long off =3D ((unsigned long)pte_paddr) & ~PAGE_MASK;
+
+	preempt_disable();
 	return (pte_t *)((char *)kmap_atomic(pfn_to_page(pfn), KM_PTE2) + off);
 }
=20
 static inline void rmap_ptep_unmap(pte_t *pte)
 {
 	kunmap_atomic(pte, KM_PTE2);
+	preempt_enable();
 }
 #endif
=20
--- 2.5.43-mm2/./include/asm-i386/pgtable.h	2002-10-15 22:28:33.000000000 =
-0500
+++ 2.5.43-mm2-shpte/./include/asm-i386/pgtable.h	2002-10-17 =
11:42:16.000000000 -0500
@@ -124,6 +124,7 @@
 #define _PAGE_PROTNONE	0x080	/* If not present */
=20
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | =
_PAGE_ACCESSED | _PAGE_DIRTY)
+#define _PAGE_TABLE_RDONLY	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED | =
_PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | =
_PAGE_DIRTY)
 #define _PAGE_CHG_MASK	(PTE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
=20
@@ -184,8 +185,8 @@
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
-#define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) !=3D =
_KERNPG_TABLE)
-
+#define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER & ~_PAGE_RW)) =
!=3D \
+			(_KERNPG_TABLE & ~_PAGE_RW))
=20
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
=20
@@ -209,6 +210,9 @@
 static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |=3D =
_PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |=3D =
_PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |=3D _PAGE_RW; =
return pte; }
+static inline int pmd_write(pmd_t pmd)		{ return (pmd).pmd & _PAGE_RW; }
+static inline pmd_t pmd_wrprotect(pmd_t pmd)	{ (pmd).pmd &=3D ~_PAGE_RW; =
return pmd; }
+static inline pmd_t pmd_mkwrite(pmd_t pmd)	{ (pmd).pmd |=3D _PAGE_RW; =
return pmd; }
=20
 static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return =
test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
 static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return =
test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low); }
@@ -265,12 +269,20 @@
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + __pte_offset(address))
 #define pte_offset_map_nested(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + __pte_offset(address))
+#define pte_page_map(__page, address) \
+	((pte_t *)kmap_atomic(__page,KM_PTE0) + __pte_offset(address))
+#define pte_page_map_nested(__page, address) \
+	((pte_t *)kmap_atomic(__page,KM_PTE1) + __pte_offset(address))
 #define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
 #else
 #define pte_offset_map(dir, address) \
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
 #define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
+#define pte_page_map(__page, address) \
+	((pte_t *)page_address(__page) + __pte_offset(address))
+#define pte_page_map_nested(__page, address) \
+	((pte_t *)page_address(__page) + __pte_offset(address))
 #define pte_unmap(pte) do { } while (0)
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
--- 2.5.43-mm2/./kernel/fork.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./kernel/fork.c	2002-10-17 11:42:16.000000000 -0500
@@ -210,6 +210,9 @@
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
 	unsigned long charge =3D 0;
+#ifdef CONFIG_SHAREPTE
+	pmd_t *prev_pmd =3D 0;
+#endif
=20
 	flush_cache_mm(current->mm);
 	mm->locked_vm =3D 0;
@@ -273,7 +276,11 @@
 		*pprev =3D tmp;
 		pprev =3D &tmp->vm_next;
 		mm->map_count++;
+#ifdef CONFIG_SHAREPTE
+		retval =3D share_page_range(mm, current->mm, tmp, &prev_pmd);
+#else
 		retval =3D copy_page_range(mm, current->mm, tmp);
+#endif
 		spin_unlock(&mm->page_table_lock);
=20
 		if (tmp->vm_ops && tmp->vm_ops->open)
--- 2.5.43-mm2/./mm/swapfile.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/swapfile.c	2002-10-18 13:36:14.000000000 -0500
@@ -15,8 +15,10 @@
 #include <linux/shm.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/pgtable.h>
+#include <asm/rmap.h>
 #include <linux/swapops.h>
=20
 spinlock_t swaplock =3D SPIN_LOCK_UNLOCKED;
@@ -371,7 +373,7 @@
  */
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
 static inline void unuse_pte(struct vm_area_struct * vma, unsigned long =
address,
-	pte_t *dir, swp_entry_t entry, struct page* page)
+	pte_t *dir, swp_entry_t entry, struct page* page, pmd_t *pmd)
 {
 	pte_t pte =3D *dir;
=20
@@ -383,7 +385,7 @@
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_rmap(page, dir);
 	swap_free(entry);
-	++vma->vm_mm->rss;
+	increment_rss(pmd_page(*pmd));
 }
=20
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
@@ -391,6 +393,7 @@
 	unsigned long address, unsigned long size, unsigned long offset,
 	swp_entry_t entry, struct page* page)
 {
+	struct page *ptepage;
 	pte_t * pte;
 	unsigned long end;
=20
@@ -401,6 +404,8 @@
 		pmd_clear(dir);
 		return;
 	}
+	ptepage =3D pmd_page(*dir);
+	pte_page_lock(ptepage);
 	pte =3D pte_offset_map(dir, address);
 	offset +=3D address & PMD_MASK;
 	address &=3D ~PMD_MASK;
@@ -408,10 +413,11 @@
 	if (end > PMD_SIZE)
 		end =3D PMD_SIZE;
 	do {
-		unuse_pte(vma, offset+address-vma->vm_start, pte, entry, page);
+		unuse_pte(vma, offset+address-vma->vm_start, pte, entry, page, dir);
 		address +=3D PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_page_unlock(ptepage);
 	pte_unmap(pte - 1);
 }
=20
--- 2.5.43-mm2/./mm/msync.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/msync.c	2002-10-18 13:31:24.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -43,6 +44,7 @@
 	unsigned long address, unsigned long end,=20
 	struct vm_area_struct *vma, unsigned int flags)
 {
+	struct page *ptepage;
 	pte_t *pte;
 	int error;
=20
@@ -53,6 +55,8 @@
 		pmd_clear(pmd);
 		return 0;
 	}
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
 	pte =3D pte_offset_map(pmd, address);
 	if ((address & PMD_MASK) !=3D (end & PMD_MASK))
 		end =3D (address & PMD_MASK) + PMD_SIZE;
@@ -64,6 +68,7 @@
 	} while (address && (address < end));
=20
 	pte_unmap(pte - 1);
+	pte_page_unlock(ptepage);
=20
 	return error;
 }
--- 2.5.43-mm2/./mm/mprotect.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/mprotect.c	2002-10-17 11:42:16.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -24,10 +25,11 @@
 #include <asm/tlbflush.h>
=20
 static inline void
-change_pte_range(pmd_t *pmd, unsigned long address,
+change_pte_range(struct vm_area_struct *vma, pmd_t *pmd, unsigned long =
address,
 		unsigned long size, pgprot_t newprot)
 {
 	pte_t * pte;
+	struct page *ptepage;
 	unsigned long end;
=20
 	if (pmd_none(*pmd))
@@ -37,11 +39,32 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte =3D pte_offset_map(pmd, address);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
 	address &=3D ~PMD_MASK;
 	end =3D address + size;
 	if (end > PMD_SIZE)
 		end =3D PMD_SIZE;
+
+#ifdef CONFIG_SHAREPTE
+	if (page_count(ptepage) > 1) {
+		if ((address =3D=3D 0) && (end =3D=3D PMD_SIZE)) {
+			pmd_t	pmdval =3D *pmd;
+
+			if (vma->vm_flags & VM_MAYWRITE)
+				pmdval =3D pmd_mkwrite(pmdval);
+			else
+				pmdval =3D pmd_wrprotect(pmdval);
+			set_pmd(pmd, pmdval);
+			pte_page_unlock(ptepage);
+			return;
+		}
+		pte =3D pte_unshare(vma->vm_mm, pmd, address);
+		ptepage =3D pmd_page(*pmd);
+	} else
+#endif
+		pte =3D pte_offset_map(pmd, address);
+
 	do {
 		if (pte_present(*pte)) {
 			pte_t entry;
@@ -56,11 +79,12 @@
 		address +=3D PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_page_unlock(ptepage);
 	pte_unmap(pte - 1);
 }
=20
 static inline void
-change_pmd_range(pgd_t *pgd, unsigned long address,
+change_pmd_range(struct vm_area_struct *vma, pgd_t *pgd, unsigned long =
address,
 		unsigned long size, pgprot_t newprot)
 {
 	pmd_t * pmd;
@@ -79,7 +103,7 @@
 	if (end > PGDIR_SIZE)
 		end =3D PGDIR_SIZE;
 	do {
-		change_pte_range(pmd, address, end - address, newprot);
+		change_pte_range(vma, pmd, address, end - address, newprot);
 		address =3D (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -98,7 +122,7 @@
 		BUG();
 	spin_lock(&current->mm->page_table_lock);
 	do {
-		change_pmd_range(dir, start, end - start, newprot);
+		change_pmd_range(vma, dir, start, end - start, newprot);
 		start =3D (start + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (start && (start < end));
--- 2.5.43-mm2/./mm/memory.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/memory.c	2002-10-18 16:57:25.000000000 -0500
@@ -36,6 +36,20 @@
  *		(Gerhard.Wichert@pdb.siemens.de)
  */
=20
+/*
+ * A note on locking of the page table structure:
+ *
+ *  The top level lock that protects the page table is the
+ *  mm->page_table_lock.  This lock protects the pgd and pmd layer.
+ *  However, with the advent of shared pte pages, this lock is not
+ *  sufficient.  The pte layer is now protected by the pte_page_lock,
+ *  set in the struct page of the pte page.  Note that with this
+ *  locking scheme, once the pgd and pmd layers have been set in the
+ *  page fault path and the pte_page_lock has been taken, the
+ *  page_table_lock can be released.
+ *=20
+ */
+
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
@@ -44,6 +58,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/vcache.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -83,7 +98,7 @@
  */
 static inline void free_one_pmd(mmu_gather_t *tlb, pmd_t * dir)
 {
-	struct page *page;
+	struct page *ptepage;
=20
 	if (pmd_none(*dir))
 		return;
@@ -92,10 +107,20 @@
 		pmd_clear(dir);
 		return;
 	}
-	page =3D pmd_page(*dir);
+	ptepage =3D pmd_page(*dir);
+
+	pte_page_lock(ptepage);
+
+	BUG_ON(page_count(ptepage) !=3D 1);
+
 	pmd_clear(dir);
-	pgtable_remove_rmap(page);
-	pte_free_tlb(tlb, page);
+	pgtable_remove_rmap_locked(ptepage, tlb->mm);
+	dec_page_state(nr_page_table_pages);
+	ClearPagePtepage(ptepage);
+
+	pte_page_unlock(ptepage);
+
+	pte_free_tlb(tlb, ptepage);
 }
=20
 static inline void free_one_pgd(mmu_gather_t *tlb, pgd_t * dir)
@@ -136,6 +161,318 @@
 	} while (--nr);
 }
=20
+#ifdef CONFIG_SHAREPTE
+/*
+ * This function makes the decision whether a pte page needs to be
+ * unshared or not.  Note that page_count() =3D=3D 1 isn't even tested
+ * here.  The assumption is that if the pmd entry is marked writeable,
+ * then the page is either already unshared or doesn't need to be
+ * unshared.  This catches the situation where task B unshares the pte
+ * page, then task A faults and needs to unprotect the pmd entry.
+ * This is actually done in pte_unshare.
+ *
+ * This function should be called with the page_table_lock held.
+ */
+static inline int pte_needs_unshare(struct mm_struct *mm,
+				    struct vm_area_struct *vma,
+				    pmd_t *pmd, unsigned long address,
+				    int write_access)
+{
+	struct page *ptepage;
+
+	/* It's not even there, nothing to unshare. */
+	if (!pmd_present(*pmd))
+		return 0;
+
+	/*
+	 * If it's already writable, then it doesn't need to be unshared.
+	 * It's either already not shared or it's part of a large shared
+	 * region that will never need to be unshared.
+	 */
+	if (pmd_write(*pmd))
+		return 0;
+
+	/* If this isn't a write fault we don't need to unshare. */
+	if (!write_access)
+		return 0;
+
+	/*
+	 * If this page fits entirely inside a shared region, don't unshare it.
+	 */
+	ptepage =3D pmd_page(*pmd);
+	if ((vma->vm_flags & VM_SHARED) &&
+	    (vma->vm_start <=3D ptepage->index) &&
+	    (vma->vm_end >=3D (ptepage->index + PMD_SIZE))) {
+		return 0;
+	}
+	/*
+	 * Ok, we have to unshare.
+	 */
+	return 1;
+}
+
+/**
+ * pte_unshare - Unshare a pte page
+ * @mm: the mm_struct that gets an unshared pte page
+ * @pmd: a pointer to the pmd entry that needs unsharing
+ * @address: the virtual address that triggered the unshare
+ *
+ * Here is where a pte page is actually unshared.  It actually covers
+ * a couple of possible conditions.  If the page_count() is already 1,
+ * then that means it just needs to be set writeable.  Otherwise, a
+ * new page needs to be allocated.
+ *
+ * When each pte entry is copied, it is evaluated for COW protection,
+ * as well as checking whether the swap count needs to be incremented.
+ *
+ * This function must be called with the page_table_lock held.  It
+ * will release and reacquire the lock when it allocates a new page.
+ *
+ * The function must also be called with the pte_page_lock held on the
+ * old page.  This lock will also be dropped, then reacquired when we
+ * allocate a new page.  The pte_page_lock will be taken on the new
+ * page.  Whichever pte page is returned will have its pte_page_lock
+ * held.
+ */
+
+pte_t *pte_unshare(struct mm_struct *mm, pmd_t *pmd, unsigned long =
address)
+{
+	pte_t	*src_ptb, *dst_ptb;
+	struct page *oldpage, *newpage;
+	struct vm_area_struct *vma;
+	int	base, addr;
+	int	end, page_end;
+	int	src_unshare;
+
+	oldpage =3D pmd_page(*pmd);
+
+	/* If it's already unshared, we just need to set it writeable */
+	if (page_count(oldpage) =3D=3D 1) {
+is_unshared:
+		pmd_populate(mm, pmd, oldpage);
+		flush_tlb_mm(mm);
+		goto out_map;
+	}
+
+	pte_page_unlock(oldpage);
+	spin_unlock(&mm->page_table_lock);
+	newpage =3D pte_alloc_one(mm, address);
+	spin_lock(&mm->page_table_lock);
+	if (unlikely(!newpage))
+		return NULL;
+
+	/*
+	 * Fetch the ptepage pointer again in case it changed while
+	 * the lock was dropped.
+	 */
+	oldpage =3D pmd_page(*pmd);
+	pte_page_lock(oldpage);
+
+	/* See if it got unshared while we dropped the lock */
+	if (page_count(oldpage) =3D=3D 1) {
+		pte_free(newpage);
+		goto is_unshared;
+	}
+
+	pte_page_lock(newpage);
+
+	base =3D addr =3D oldpage->index;
+	page_end =3D base + PMD_SIZE;
+	vma =3D find_vma(mm, base);
+	src_unshare =3D page_count(oldpage) =3D=3D 2;
+	dst_ptb =3D pte_page_map(newpage, base);
+
+	if (!vma || (page_end <=3D vma->vm_start)) {
+		goto no_vma;
+	}
+
+	if (vma->vm_start > addr)
+		addr =3D vma->vm_start;
+
+	if (vma->vm_end < page_end)
+		end =3D vma->vm_end;
+	else
+		end =3D page_end;
+
+	src_ptb =3D pte_page_map_nested(oldpage, base);
+
+	do {
+		unsigned int cow =3D 0;
+		pte_t *src_pte =3D src_ptb + __pte_offset(addr);
+		pte_t *dst_pte =3D dst_ptb + __pte_offset(addr);
+
+		cow =3D (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) =3D=3D VM_MAYWRITE;
+
+		do {
+			pte_t pte =3D *src_pte;
+			struct page *page;
+
+			if (pte_none(pte))
+				goto unshare_skip_set;
+
+			if (!pte_present(pte)) {
+				swap_duplicate(pte_to_swp_entry(pte));
+				set_pte(dst_pte, pte);
+				goto unshare_skip_set;
+			}
+			page =3D pte_page(pte);
+			if (!PageReserved(page)) {
+				/* COW mappings require write protecting both sides */
+				if (cow) {
+					pte =3D pte_wrprotect(pte);
+					if (src_unshare)
+						set_pte(src_pte, pte);
+				}
+				/* If it's a shared mapping,
+				 *  mark it clean in the new mapping
+				 */
+				if (vma->vm_flags & VM_SHARED)
+					pte =3D pte_mkclean(pte);
+				pte =3D pte_mkold(pte);
+				get_page(page);
+			}
+			set_pte(dst_pte, pte);
+			page_add_rmap(page, dst_pte);
+unshare_skip_set:
+			src_pte++;
+			dst_pte++;
+			addr +=3D PAGE_SIZE;
+		} while (addr < end);
+
+		if (addr >=3D page_end)
+			break;
+
+		vma =3D vma->vm_next;
+		if (!vma)
+			break;
+
+		if (page_end <=3D vma->vm_start)
+			break;
+
+		addr =3D vma->vm_start;
+		if (vma->vm_end < page_end)
+			end =3D vma->vm_end;
+		else
+			end =3D page_end;
+	} while (1);
+
+	pte_unmap_nested(src_ptb);
+
+no_vma:
+	SetPagePtepage(newpage);
+	pgtable_remove_rmap_locked(oldpage, mm);
+	pgtable_add_rmap_locked(newpage, mm, base);
+	pmd_populate(mm, pmd, newpage);
+	inc_page_state(nr_page_table_pages);
+
+	/* Copy rss count */
+	newpage->private =3D oldpage->private;
+
+	flush_tlb_mm(mm);
+
+	put_page(oldpage);
+
+	pte_page_unlock(oldpage);
+
+	return dst_ptb + __pte_offset(address);
+
+out_map:
+	return pte_offset_map(pmd, address);
+}
+
+/**
+ * pte_try_to_share - Attempt to find a pte page that can be shared
+ * @mm: the mm_struct that needs a pte page
+ * @vma: the vm_area the address is in
+ * @pmd: a pointer to the pmd entry that needs filling
+ * @address: the address that caused the fault
+ *
+ * This function is called during a page fault.  If there is no pte
+ * page for this address, it checks the vma to see if it is shared,
+ * and if it spans the pte page.  If so, it goes to the address_space
+ * structure and looks through for matching vmas from other tasks that
+ * already have a pte page that can be shared.  If it finds one, it
+ * attaches it and makes it a shared page.
+ */
+
+static pte_t *pte_try_to_share(struct mm_struct *mm, struct vm_area_struct =
*vma,
+			       pmd_t *pmd, unsigned long address)
+{
+	struct address_space *as;
+	struct vm_area_struct *lvma;
+	struct page *ptepage;
+	unsigned long base;
+	pte_t *pte =3D NULL;
+
+	/*
+	 * It already has a pte page.  No point in checking further.
+	 * We can go ahead and return it now, since we know it's there.
+	 */
+	if (pmd_present(*pmd)) {
+		ptepage =3D pmd_page(*pmd);
+		pte_page_lock(ptepage);
+		return pte_page_map(ptepage, address);
+	}
+
+	/* It's not even shared memory. We definitely can't share the page. */
+	if (!(vma->vm_flags & VM_SHARED))
+		return NULL;
+
+	/* We can only share if the entire pte page fits inside the vma */
+	base =3D address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
+	if ((base < vma->vm_start) || (vma->vm_end < (base + PMD_SIZE)))
+		return NULL;
+
+	as =3D vma->vm_file->f_dentry->d_inode->i_mapping;
+
+	spin_lock(&as->i_shared_lock);
+
+	list_for_each_entry(lvma, &as->i_mmap_shared, shared) {
+		pgd_t *lpgd;
+		pmd_t *lpmd;
+		pmd_t pmdval;
+
+		/* Skip the one we're working on */
+		if (lvma =3D=3D vma)
+			continue;
+
+		/* It has to be mapping to the same address */
+		if ((lvma->vm_start !=3D vma->vm_start) ||
+		    (lvma->vm_end !=3D vma->vm_end) ||
+		    (lvma->vm_pgoff !=3D vma->vm_pgoff))
+			continue;
+
+		lpgd =3D pgd_offset(lvma->vm_mm, address);
+		lpmd =3D pmd_offset(lpgd, address);
+
+		/* This page table doesn't have a pte page either, so skip it. */
+		if (!pmd_present(*lpmd))
+			continue;
+
+		/* Ok, we can share it. */
+
+		ptepage =3D pmd_page(*lpmd);
+		pte_page_lock(ptepage);
+		get_page(ptepage);
+		pgtable_add_rmap_locked(ptepage, mm, address);
+		/*
+		 * If this vma is only mapping it read-only, set the
+		 * pmd entry read-only to protect it from writes.
+		 * Otherwise set it writeable.
+		 */
+		if (vma->vm_flags & VM_MAYWRITE)
+			pmdval =3D pmd_mkwrite(*lpmd);
+		else
+			pmdval =3D pmd_wrprotect(*lpmd);
+		set_pmd(pmd, pmdval);
+		pte =3D pte_page_map(ptepage, address);
+		break;
+	}
+	spin_unlock(&as->i_shared_lock);
+	return pte;
+}
+#endif
+
 pte_t * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long =
address)
 {
 	if (!pmd_present(*pmd)) {
@@ -155,13 +492,13 @@
 			pte_free(new);
 			goto out;
 		}
+		SetPagePtepage(new);
 		pgtable_add_rmap(new, mm, address);
 		pmd_populate(mm, pmd, new);
+		inc_page_state(nr_page_table_pages);
 	}
 out:
-	if (pmd_present(*pmd))
-		return pte_offset_map(pmd, address);
-	return NULL;
+	return pte_offset_map(pmd, address);
 }
=20
 pte_t * pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long =
address)
@@ -183,7 +520,6 @@
 			pte_free_kernel(new);
 			goto out;
 		}
-		pgtable_add_rmap(virt_to_page(new), mm, address);
 		pmd_populate_kernel(mm, pmd, new);
 	}
 out:
@@ -192,6 +528,111 @@
 #define PTE_TABLE_MASK	((PTRS_PER_PTE-1) * sizeof(pte_t))
 #define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))
=20
+#ifdef CONFIG_SHAREPTE
+/**
+ * share_page_range - share a range of pages at the pte page level at fork =
time
+ * @dst: the mm_struct of the forked child
+ * @src: the mm_struct of the forked parent
+ * @vma: the vm_area to be shared
+ * @prev_pmd: A pointer to the pmd entry we did at last invocation
+ *
+ * This function shares pte pages between parent and child at fork.
+ * If the vm_area is shared and spans the page, it sets it
+ * writeable. Otherwise it sets it read-only.  The prev_pmd parameter
+ * is used to keep track of pte pages we've already shared, since this
+ * function can be called with multiple vmas that point to the same
+ * pte page.
+ */
+int share_page_range(struct mm_struct *dst, struct mm_struct *src,
+	struct vm_area_struct *vma, pmd_t **prev_pmd)
+{
+	pgd_t *src_pgd, *dst_pgd;
+	unsigned long address =3D vma->vm_start;
+	unsigned long end =3D vma->vm_end;
+	
+	if (is_vm_hugetlb_page(vma))
+		return copy_hugetlb_page_range(dst, src, vma);
+
+	src_pgd =3D pgd_offset(src, address)-1;
+	dst_pgd =3D pgd_offset(dst, address)-1;
+
+	for (;;) {
+		pmd_t * src_pmd, * dst_pmd;
+
+		src_pgd++; dst_pgd++;
+		
+		if (pgd_none(*src_pgd))
+			goto skip_share_pmd_range;
+		if (pgd_bad(*src_pgd)) {
+			pgd_ERROR(*src_pgd);
+			pgd_clear(src_pgd);
+skip_share_pmd_range:	address =3D (address + PGDIR_SIZE) & PGDIR_MASK;
+			if (!address || (address >=3D end))
+				goto out;
+			continue;
+		}
+
+		src_pmd =3D pmd_offset(src_pgd, address);
+		dst_pmd =3D pmd_alloc(dst, dst_pgd, address);
+		if (!dst_pmd)
+			goto nomem;
+
+		spin_lock(&src->page_table_lock);
+
+		do {
+			pmd_t	pmdval =3D *src_pmd;
+			struct page *ptepage =3D pmd_page(pmdval);
+
+			if (pmd_none(pmdval))
+				goto skip_share_pte_range;
+			if (pmd_bad(pmdval)) {
+				pmd_ERROR(*src_pmd);
+				pmd_clear(src_pmd);
+				goto skip_share_pte_range;
+			}
+
+			/*
+			 * We set the pmd read-only in both the parent and the
+			 * child unless it's a writeable shared region that
+			 * spans the entire pte page.
+			 */
+			if ((((vma->vm_flags & (VM_SHARED|VM_MAYWRITE)) !=3D
+			    (VM_SHARED|VM_MAYWRITE)) ||
+			    (ptepage->index < vma->vm_start) ||
+			    ((ptepage->index + PMD_SIZE) > vma->vm_end)) &&
+			    pmd_write(pmdval)) {
+				pmdval =3D pmd_wrprotect(pmdval);
+				set_pmd(src_pmd, pmdval);
+			}
+			set_pmd(dst_pmd, pmdval);
+
+			/* Only do this if we haven't seen this pte page before */
+			if (src_pmd !=3D *prev_pmd) {
+				get_page(ptepage);
+				pgtable_add_rmap(ptepage, dst, address);
+				*prev_pmd =3D src_pmd;
+				dst->rss +=3D ptepage->private;
+			}
+
+skip_share_pte_range:	address =3D (address + PMD_SIZE) & PMD_MASK;
+			if (address >=3D end)
+				goto out_unlock;
+
+			src_pmd++;
+			dst_pmd++;
+		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
+		spin_unlock(&src->page_table_lock);
+	}
+
+out_unlock:
+	spin_unlock(&src->page_table_lock);
+
+out:
+	return 0;
+nomem:
+	return -ENOMEM;
+}
+#else
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
@@ -241,6 +682,7 @@
 			goto nomem;
=20
 		do {
+			struct page *ptepage;
 			pte_t * src_pte, * dst_pte;
 		
 			/* copy_pte_range */
@@ -260,10 +702,12 @@
 			if (!dst_pte)
 				goto nomem;
 			spin_lock(&src->page_table_lock);			
+			ptepage =3D pmd_page(*src_pmd);
+			pte_page_lock(ptepage);
 			src_pte =3D pte_offset_map_nested(src_pmd, address);
 			do {
 				pte_t pte =3D *src_pte;
-				struct page *ptepage;
+				struct page *page;
 				unsigned long pfn;
 				
 				/* copy_one_pte */
@@ -276,12 +720,12 @@
 					set_pte(dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
-				ptepage =3D pte_page(pte);
+				page =3D pte_page(pte);
 				pfn =3D pte_pfn(pte);
 				if (!pfn_valid(pfn))
 					goto cont_copy_pte_range;
-				ptepage =3D pfn_to_page(pfn);
-				if (PageReserved(ptepage))
+				page =3D pfn_to_page(pfn);
+				if (PageReserved(page))
 					goto cont_copy_pte_range;
=20
 				/* If it's a COW mapping, write protect it both in the parent and the =
child */
@@ -294,13 +738,14 @@
 				if (vma->vm_flags & VM_SHARED)
 					pte =3D pte_mkclean(pte);
 				pte =3D pte_mkold(pte);
-				get_page(ptepage);
+				get_page(page);
 				dst->rss++;
=20
 cont_copy_pte_range:		set_pte(dst_pte, pte);
-				page_add_rmap(ptepage, dst_pte);
+				page_add_rmap(page, dst_pte);
 cont_copy_pte_range_noset:	address +=3D PAGE_SIZE;
 				if (address >=3D end) {
+					pte_page_unlock(ptepage);
 					pte_unmap_nested(src_pte);
 					pte_unmap(dst_pte);
 					goto out_unlock;
@@ -308,6 +753,7 @@
 				src_pte++;
 				dst_pte++;
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
+			pte_page_unlock(ptepage);
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);
 			spin_unlock(&src->page_table_lock);
@@ -323,24 +769,22 @@
 nomem:
 	return -ENOMEM;
 }
+#endif
=20
 static void zap_pte_range(mmu_gather_t *tlb, pmd_t * pmd, unsigned long =
address, unsigned long size)
 {
 	unsigned long offset;
+	struct mm_struct *mm =3D tlb->mm;
+	struct page *ptepage =3D pmd_page(*pmd);
 	pte_t *ptep;
=20
-	if (pmd_none(*pmd))
-		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	ptep =3D pte_offset_map(pmd, address);
 	offset =3D address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size =3D PMD_SIZE - offset;
 	size &=3D PAGE_MASK;
+
+	ptep =3D pte_offset_map(pmd, address);
+
 	for (offset=3D0; offset < size; ptep++, offset +=3D PAGE_SIZE) {
 		pte_t pte =3D *ptep;
 		if (pte_none(pte))
@@ -359,6 +803,8 @@
 							!PageSwapCache(page))
 						mark_page_accessed(page);
 					tlb->freed++;
+					ptepage->private--;
+					mm->rss--;
 					page_remove_rmap(page, ptep);
 					tlb_remove_page(tlb, page);
 				}
@@ -371,8 +817,12 @@
 	pte_unmap(ptep-1);
 }
=20
-static void zap_pmd_range(mmu_gather_t *tlb, pgd_t * dir, unsigned long =
address, unsigned long size)
+static void zap_pmd_range(mmu_gather_t **tlb, pgd_t * dir, unsigned long =
address, unsigned long size)
 {
+	struct page *ptepage;
+#ifdef CONFIG_SHAREPTE
+	struct mm_struct *mm =3D (*tlb)->mm;
+#endif
 	pmd_t * pmd;
 	unsigned long end;
=20
@@ -388,26 +838,59 @@
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end =3D ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address);
+		if (pmd_none(*pmd))
+			goto skip_pmd;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			goto skip_pmd;
+		}
+
+		ptepage =3D pmd_page(*pmd);
+		pte_page_lock(ptepage);
+#ifdef CONFIG_SHAREPTE
+		if (page_count(ptepage) > 1) {
+			if ((address <=3D ptepage->index) &&
+			    (end >=3D (ptepage->index + PMD_SIZE))) {
+				pmd_clear(pmd);
+				pgtable_remove_rmap_locked(ptepage, mm);
+				mm->rss -=3D ptepage->private;
+				put_page(ptepage);
+				pte_page_unlock(ptepage);
+				goto skip_pmd;
+			} else {
+				pte_t *pte;
+
+				tlb_finish_mmu(*tlb, address, end);
+				pte =3D pte_unshare(mm, pmd, address);
+				pte_unmap(pte);
+				*tlb =3D tlb_gather_mmu(mm, 0);
+				ptepage =3D pmd_page(*pmd);
+			}
+		}
+#endif
+		zap_pte_range(*tlb, pmd, address, end - address);
+		pte_page_unlock(ptepage);
+skip_pmd:
 		address =3D (address + PMD_SIZE) & PMD_MASK;=20
 		pmd++;
 	} while (address < end);
 }
=20
-void unmap_page_range(mmu_gather_t *tlb, struct vm_area_struct *vma, =
unsigned long address, unsigned long end)
+void unmap_page_range(mmu_gather_t **tlb, struct vm_area_struct *vma, =
unsigned long address, unsigned long end)
 {
 	pgd_t * dir;
=20
 	BUG_ON(address >=3D end);
=20
 	dir =3D pgd_offset(vma->vm_mm, address);
-	tlb_start_vma(tlb, vma);
+	tlb_start_vma(*tlb, vma);
 	do {
 		zap_pmd_range(tlb, dir, address, end - address);
 		address =3D (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	tlb_end_vma(tlb, vma);
+	tlb_end_vma(*tlb, vma);
 }
=20
 /* Dispose of an entire mmu_gather_t per rescheduling point */
@@ -451,7 +934,7 @@
 =20
  		flush_cache_range(vma, address, end);
  		tlb =3D tlb_gather_mmu(mm, 0);
- 		unmap_page_range(tlb, vma, address, end);
+ 		unmap_page_range(&tlb, vma, address, end);
  		tlb_finish_mmu(tlb, address, end);
 =20
  		cond_resched_lock(&mm->page_table_lock);
@@ -463,6 +946,126 @@
 	spin_unlock(&mm->page_table_lock);
 }
=20
+/**
+ * unmap_all_pages - unmap all the pages for an mm_struct
+ * @mm: the mm_struct to unmap
+ *
+ * This function is only called when an mm_struct is about to be
+ * released.  It walks through all vmas and removes their pages
+ * from the page table.  It understands shared pte pages and will
+ * decrement the count appropriately.
+ */
+void unmap_all_pages(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	struct page *ptepage;
+	mmu_gather_t *tlb;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	unsigned long address;
+	unsigned long vm_end, pmd_end;
+
+	tlb =3D tlb_gather_mmu(mm, 1);
+
+	vma =3D mm->mmap;
+	for (;;) {
+		if (!vma)
+			goto out;
+
+		address =3D vma->vm_start;
+next_vma:
+		vm_end =3D vma->vm_end;
+		mm->map_count--;
+		/*
+		 * Advance the vma pointer to the next vma.
+		 * To facilitate coalescing adjacent vmas, the
+		 * pointer always points to the next one
+		 * beyond the range we're currently working
+		 * on, which means vma will be null on the
+		 * last iteration.
+		 */
+		vma =3D vma->vm_next;
+		if (vma) {
+			/*
+			 * Go ahead and include hugetlb vmas
+			 * in the range we process.  The pmd
+			 * entry will be cleared by close, so
+			 * we'll just skip over them.  This is
+			 * easier than trying to avoid them.
+			 */
+			if (is_vm_hugetlb_page(vma))
+				vma->vm_ops->close(vma);
+
+			/*
+			 * Coalesce adjacent vmas and process
+			 * them all in one iteration.
+			 */
+			if (vma->vm_start =3D=3D vm_end) {
+				goto next_vma;
+			}
+		}
+		pgd =3D pgd_offset(mm, address);
+		do {
+			if (pgd_none(*pgd))
+				goto skip_pgd;
+
+			if (pgd_bad(*pgd)) {
+				pgd_ERROR(*pgd);
+				pgd_clear(pgd);
+skip_pgd:
+				address +=3D PGDIR_SIZE;
+				if (address > vm_end)
+					address =3D vm_end;
+				goto next_pgd;
+			}
+			pmd =3D pmd_offset(pgd, address);
+			if (vm_end > ((address + PGDIR_SIZE) & PGDIR_MASK))
+				pmd_end =3D (address + PGDIR_SIZE) & PGDIR_MASK;
+			else
+				pmd_end =3D vm_end;
+
+			for (;;) {
+				if (pmd_none(*pmd))
+					goto next_pmd;
+				if (pmd_bad(*pmd)) {
+					pmd_ERROR(*pmd);
+					pmd_clear(pmd);
+					goto next_pmd;
+				}
+				
+				ptepage =3D pmd_page(*pmd);
+				pte_page_lock(ptepage);
+#ifdef CONFIG_SHAREPTE
+				if (page_count(ptepage) > 1) {
+					pmd_clear(pmd);
+					pgtable_remove_rmap_locked(ptepage, mm);
+					mm->rss -=3D ptepage->private;
+					put_page(ptepage);
+				} else
+#endif
+					zap_pte_range(tlb, pmd, address,
+						      vm_end - address);
+
+				pte_page_unlock(ptepage);
+next_pmd:
+				address =3D  (address + PMD_SIZE) & PMD_MASK;
+				if (address >=3D pmd_end) {
+					address =3D pmd_end;
+					break;
+				}
+				pmd++;
+			}
+next_pgd:
+			pgd++;
+		} while (address < vm_end);
+
+	}
+
+out:
+	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
+	tlb_finish_mmu(tlb, 0, TASK_SIZE);
+}
+
 /*
  * Do a quick page-table lookup for a single page.
  * mm->page_table_lock must be held.
@@ -790,6 +1393,7 @@
 	unsigned long address, pte_t *page_table, pmd_t *pmd, pte_t pte)
 {
 	struct page *old_page, *new_page;
+	struct page *ptepage =3D pmd_page(*pmd);
 	unsigned long pfn =3D pte_pfn(pte);
=20
 	if (!pfn_valid(pfn))
@@ -803,7 +1407,7 @@
 			flush_cache_page(vma, address);
 			establish_pte(vma, address, page_table, =
pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
+			pte_page_unlock(ptepage);
 			return VM_FAULT_MINOR;
 		}
 	}
@@ -813,7 +1417,7 @@
 	 * Ok, we need to copy. Oh, well..
 	 */
 	page_cache_get(old_page);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
=20
 	new_page =3D alloc_page(GFP_HIGHUSER);
 	if (!new_page)
@@ -823,11 +1427,12 @@
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	spin_lock(&mm->page_table_lock);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
 	page_table =3D pte_offset_map(pmd, address);
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
-			++mm->rss;
+			increment_rss(ptepage);
 		page_remove_rmap(old_page, page_table);
 		break_cow(vma, new_page, address, page_table);
 		page_add_rmap(new_page, page_table);
@@ -837,14 +1442,14 @@
 		new_page =3D old_page;
 	}
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	return VM_FAULT_MINOR;
=20
 bad_wp_page:
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
 	printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n", address);
 	/*
 	 * This should really halt the system so it can be debugged or
@@ -973,12 +1578,13 @@
 	pte_t *page_table, pmd_t *pmd, pte_t orig_pte, int write_access)
 {
 	struct page *page;
+	struct page *ptepage =3D pmd_page(*pmd);
 	swp_entry_t entry =3D pte_to_swp_entry(orig_pte);
 	pte_t pte;
 	int ret =3D VM_FAULT_MINOR;
=20
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
 	page =3D lookup_swap_cache(entry);
 	if (!page) {
 		swapin_readahead(entry);
@@ -988,14 +1594,15 @@
 			 * Back out if somebody else faulted in this pte while
 			 * we released the page table lock.
 			 */
-			spin_lock(&mm->page_table_lock);
+			ptepage =3D pmd_page(*pmd);
+			pte_page_lock(ptepage);
 			page_table =3D pte_offset_map(pmd, address);
 			if (pte_same(*page_table, orig_pte))
 				ret =3D VM_FAULT_OOM;
 			else
 				ret =3D VM_FAULT_MINOR;
 			pte_unmap(page_table);
-			spin_unlock(&mm->page_table_lock);
+			pte_page_unlock(ptepage);
 			return ret;
 		}
=20
@@ -1011,11 +1618,12 @@
 	 * Back out if somebody else faulted in this pte while we
 	 * released the page table lock.
 	 */
-	spin_lock(&mm->page_table_lock);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
 	page_table =3D pte_offset_map(pmd, address);
 	if (!pte_same(*page_table, orig_pte)) {
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
+		pte_page_unlock(ptepage);
 		unlock_page(page);
 		page_cache_release(page);
 		return VM_FAULT_MINOR;
@@ -1027,7 +1635,7 @@
 	if (vm_swap_full())
 		remove_exclusive_swap_page(page);
=20
-	mm->rss++;
+	increment_rss(ptepage);
 	pte =3D mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page))
 		pte =3D pte_mkdirty(pte_mkwrite(pte));
@@ -1041,7 +1649,7 @@
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
 	return ret;
 }
=20
@@ -1054,6 +1662,7 @@
 {
 	pte_t entry;
 	struct page * page =3D ZERO_PAGE(addr);
+	struct page *ptepage =3D pmd_page(*pmd);
=20
 	/* Read-only mapping of ZERO_PAGE. */
 	entry =3D pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
@@ -1062,23 +1671,24 @@
 	if (write_access) {
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
-		spin_unlock(&mm->page_table_lock);
+		pte_page_unlock(ptepage);
=20
 		page =3D alloc_page(GFP_HIGHUSER);
 		if (!page)
 			goto no_mem;
 		clear_user_highpage(page, addr);
=20
-		spin_lock(&mm->page_table_lock);
+		ptepage =3D pmd_page(*pmd);
+		pte_page_lock(ptepage);
 		page_table =3D pte_offset_map(pmd, addr);
=20
 		if (!pte_none(*page_table)) {
 			pte_unmap(page_table);
 			page_cache_release(page);
-			spin_unlock(&mm->page_table_lock);
+			pte_page_unlock(ptepage);
 			return VM_FAULT_MINOR;
 		}
-		mm->rss++;
+		increment_rss(ptepage);
 		flush_page_to_ram(page);
 		entry =3D pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		lru_cache_add(page);
@@ -1091,7 +1701,7 @@
=20
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
 	return VM_FAULT_MINOR;
=20
 no_mem:
@@ -1114,12 +1724,13 @@
 	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
 {
 	struct page * new_page;
+	struct page *ptepage =3D pmd_page(*pmd);
 	pte_t entry;
=20
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table, pmd, write_access, =
address);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
=20
 	new_page =3D vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
=20
@@ -1144,7 +1755,8 @@
 		new_page =3D page;
 	}
=20
-	spin_lock(&mm->page_table_lock);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
 	page_table =3D pte_offset_map(pmd, address);
=20
 	/*
@@ -1159,7 +1771,7 @@
 	 */
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
-		++mm->rss;
+		increment_rss(ptepage);
 		flush_page_to_ram(new_page);
 		flush_icache_page(vma, new_page);
 		entry =3D mk_pte(new_page, vma->vm_page_prot);
@@ -1172,13 +1784,13 @@
 		/* One of our sibling threads was faster, back out. */
 		pte_unmap(page_table);
 		page_cache_release(new_page);
-		spin_unlock(&mm->page_table_lock);
+		pte_page_unlock(ptepage);
 		return VM_FAULT_MINOR;
 	}
=20
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(ptepage);
 	return VM_FAULT_MAJOR;
 }
=20
@@ -1230,7 +1842,7 @@
 	entry =3D pte_mkyoung(entry);
 	establish_pte(vma, address, pte, entry);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	pte_page_unlock(pmd_page(*pmd));
 	return VM_FAULT_MINOR;
 }
=20
@@ -1255,9 +1867,29 @@
 	pmd =3D pmd_alloc(mm, pgd, address);
=20
 	if (pmd) {
-		pte_t * pte =3D pte_alloc_map(mm, pmd, address);
+		pte_t * pte;
+
+#ifdef CONFIG_SHAREPTE
+		if (pte_needs_unshare(mm, vma, pmd, address, write_access)) {
+			pte_page_lock(pmd_page(*pmd));
+			pte =3D pte_unshare(mm, pmd, address);
+		} else {
+			pte =3D pte_try_to_share(mm, vma, pmd, address);
+			if (!pte) {
+				pte =3D pte_alloc_map(mm, pmd, address);
+				if (pte)
+					pte_page_lock(pmd_page(*pmd));
+			}
+		}
+#else
+		pte =3D pte_alloc_map(mm, pmd, address);
 		if (pte)
+			pte_page_lock(pmd_page(*pmd));
+#endif
+		if (pte) {
+			spin_unlock(&mm->page_table_lock);
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		}
 	}
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
--- 2.5.43-mm2/./mm/mremap.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/mremap.c	2002-10-18 11:58:43.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/swap.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -23,6 +24,7 @@
=20
 static pte_t *get_one_pte_map_nested(struct mm_struct *mm, unsigned long =
addr)
 {
+	struct page *ptepage;
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte =3D NULL;
@@ -45,8 +47,18 @@
 		goto end;
 	}
=20
-	pte =3D pte_offset_map_nested(pmd, addr);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
+#ifdef CONFIG_SHAREPTE
+	if (page_count(ptepage) > 1) {
+		pte =3D pte_unshare(mm, pmd, addr);
+		ptepage =3D pmd_page(*pmd);
+	} else
+#endif
+		pte =3D pte_offset_map_nested(pmd, addr);
+
 	if (pte_none(*pte)) {
+		pte_page_unlock(ptepage);
 		pte_unmap_nested(pte);
 		pte =3D NULL;
 	}
@@ -54,6 +66,32 @@
 	return pte;
 }
=20
+static inline void drop_pte_nested(struct mm_struct *mm, unsigned long =
addr, pte_t *pte)
+{
+	struct page *ptepage;
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	pgd =3D pgd_offset(mm, addr);
+	pmd =3D pmd_offset(pgd, addr);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_unlock(ptepage);
+	pte_unmap_nested(pte);
+}
+
+static inline void drop_pte(struct mm_struct *mm, unsigned long addr, =
pte_t *pte)
+{
+	struct page *ptepage;
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	pgd =3D pgd_offset(mm, addr);
+	pmd =3D pmd_offset(pgd, addr);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_unlock(ptepage);
+	pte_unmap(pte);
+}
+
 #ifdef CONFIG_HIGHPTE	/* Save a few cycles on the sane machines */
 static inline int page_table_present(struct mm_struct *mm, unsigned long =
addr)
 {
@@ -72,12 +110,24 @@
=20
 static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long =
addr)
 {
+	struct page *ptepage;
 	pmd_t * pmd;
 	pte_t * pte =3D NULL;
=20
 	pmd =3D pmd_alloc(mm, pgd_offset(mm, addr), addr);
-	if (pmd)
+	if (pmd) {
+		ptepage =3D pmd_page(*pmd);
+#ifdef CONFIG_SHAREPTE
+		pte_page_lock(ptepage);
+		if (page_count(ptepage) > 1) {
+			pte_unshare(mm, pmd, addr);
+			ptepage =3D pmd_page(*pmd);
+		}
+		pte_page_unlock(ptepage);
+#endif
 		pte =3D pte_alloc_map(mm, pmd, addr);
+		pte_page_lock(ptepage);
+	}
 	return pte;
 }
=20
@@ -121,15 +171,15 @@
 		 * atomic kmap
 		 */
 		if (!page_table_present(mm, new_addr)) {
-			pte_unmap_nested(src);
+			drop_pte_nested(mm, old_addr, src);
 			src =3D NULL;
 		}
 		dst =3D alloc_one_pte_map(mm, new_addr);
 		if (src =3D=3D NULL)
 			src =3D get_one_pte_map_nested(mm, old_addr);
 		error =3D copy_one_pte(mm, src, dst);
-		pte_unmap_nested(src);
-		pte_unmap(dst);
+		drop_pte_nested(mm, old_addr, src);
+		drop_pte(mm, new_addr, dst);
 	}
 	flush_tlb_page(vma, old_addr);
 	spin_unlock(&mm->page_table_lock);
--- 2.5.43-mm2/./mm/mmap.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/mmap.c	2002-10-17 11:42:30.000000000 -0500
@@ -23,7 +23,11 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
=20
-extern void unmap_page_range(mmu_gather_t *,struct vm_area_struct *vma, =
unsigned long address, unsigned long size);
+extern void unmap_page_range(mmu_gather_t **,struct vm_area_struct *vma, =
unsigned long address, unsigned long size);
+#ifdef CONFIG_SHAREPTE
+extern void unmap_shared_range(struct mm_struct *mm, unsigned long =
address, unsigned long end);
+#endif
+extern void unmap_all_pages(struct mm_struct *mm);
 extern void clear_page_tables(mmu_gather_t *tlb, unsigned long first, int =
nr);
=20
 /*
@@ -1013,7 +1017,7 @@
 		from =3D start < mpnt->vm_start ? mpnt->vm_start : start;
 		to =3D end > mpnt->vm_end ? mpnt->vm_end : end;
=20
-		unmap_page_range(tlb, mpnt, from, to);
+		unmap_page_range(&tlb, mpnt, from, to);
=20
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			len =3D to - from;
@@ -1275,10 +1279,19 @@
 	}
 }
=20
+/*
+ * For small tasks, it's most efficient to unmap the pages for each
+ * vma.  For larger tasks, it's better to just walk the entire address
+ * space in one pass, particularly with shared pte pages.  This
+ * threshold determines the size where we switch from one method to
+ * the other.
+ */
+
+#define	UNMAP_THRESHOLD		500
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct * mm)
 {
-	mmu_gather_t *tlb;
 	struct vm_area_struct * mpnt;
=20
 	profile_exit_mmap(mm);
@@ -1287,36 +1300,14 @@
 =20
 	spin_lock(&mm->page_table_lock);
=20
-	tlb =3D tlb_gather_mmu(mm, 1);
-
 	flush_cache_mm(mm);
-	mpnt =3D mm->mmap;
-	while (mpnt) {
-		unsigned long start =3D mpnt->vm_start;
-		unsigned long end =3D mpnt->vm_end;
-
-		/*
-		 * If the VMA has been charged for, account for its
-		 * removal
-		 */
-		if (mpnt->vm_flags & VM_ACCOUNT)
-			vm_unacct_memory((end - start) >> PAGE_SHIFT);
=20
-		mm->map_count--;
-		if (!(is_vm_hugetlb_page(mpnt)))
-			unmap_page_range(tlb, mpnt, start, end);
-		else
-			mpnt->vm_ops->close(mpnt);
-		mpnt =3D mpnt->vm_next;
-	}
+	unmap_all_pages(mm);
=20
 	/* This is just debugging */
 	if (mm->map_count)
 		BUG();
=20
-	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
-	tlb_finish_mmu(tlb, 0, TASK_SIZE);
-
 	mpnt =3D mm->mmap;
 	mm->mmap =3D mm->mmap_cache =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
@@ -1332,6 +1323,14 @@
 	 */
 	while (mpnt) {
 		struct vm_area_struct * next =3D mpnt->vm_next;
+
+		/*
+		 * If the VMA has been charged for, account for its
+		 * removal
+		 */
+		if (mpnt->vm_flags & VM_ACCOUNT)
+			vm_unacct_memory((mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT);
+
 		remove_shared_vm_struct(mpnt);
 		if (mpnt->vm_ops) {
 			if (mpnt->vm_ops->close)
--- 2.5.43-mm2/./mm/rmap.c	2002-10-15 22:29:02.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/rmap.c	2002-10-18 16:56:51.000000000 -0500
@@ -14,11 +14,11 @@
 /*
  * Locking:
  * - the page->pte.chain is protected by the PG_chainlock bit,
- *   which nests within the zone->lru_lock, then the
- *   mm->page_table_lock, and then the page lock.
+ *   which nests within the zone->lru_lock, then the pte_page_lock,
+ *   and then the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
- *   on the mm->page_table_lock
+ *   on the pte_page_lock.
  */
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -45,11 +45,17 @@
  */
 #define NRPTE ((L1_CACHE_BYTES - sizeof(void *))/sizeof(pte_addr_t))
=20
+struct mm_chain {
+	struct mm_chain *next;
+	struct mm_struct *mm;
+};
+
 struct pte_chain {
 	struct pte_chain *next;
 	pte_addr_t ptes[NRPTE];
 };
=20
+static kmem_cache_t	*mm_chain_cache;
 static kmem_cache_t	*pte_chain_cache;
=20
 /*
@@ -102,6 +108,25 @@
 	kmem_cache_free(pte_chain_cache, pte_chain);
 }
=20
+static inline struct mm_chain *mm_chain_alloc(void)
+{
+	struct mm_chain *ret;
+
+	ret =3D kmem_cache_alloc(mm_chain_cache, GFP_ATOMIC);
+	return ret;
+}
+
+static void mm_chain_free(struct mm_chain *mc,
+		struct mm_chain *prev_mc, struct page *page)
+{
+	if (prev_mc)
+		prev_mc->next =3D mc->next;
+	else if (page)
+		page->pte.mmchain =3D mc->next;
+
+	kmem_cache_free(mm_chain_cache, mc);
+}
+
 /**
  ** VM stuff below this comment
  **/
@@ -161,13 +186,139 @@
 	return referenced;
 }
=20
+/*
+ * pgtable_add_rmap_locked - Add an mm_struct to the chain for a pte page.
+ * @page: The pte page to add the mm_struct to
+ * @mm: The mm_struct to add
+ * @address: The address of the page we're mapping
+ *
+ * Pte pages maintain a chain of mm_structs that use it.  This adds a new
+ * mm_struct to the chain.
+ *
+ * This function must be called with the pte_page_lock held for the page
+ */
+void pgtable_add_rmap_locked(struct page * page, struct mm_struct * mm,
+			     unsigned long address)
+{
+	struct mm_chain *mc;
+
+#ifdef BROKEN_PPC_PTE_ALLOC_ONE
+	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
+	extern int mem_init_done;
+
+	if (!mem_init_done)
+		return;
+#endif
+#ifdef RMAP_DEBUG
+	BUG_ON(mm =3D=3D NULL);
+	BUG_ON(!PagePtepage(page));
+#endif
+	
+	if (PageDirect(page)) {
+		mc =3D mm_chain_alloc();
+		mc->mm =3D page->pte.mmdirect;
+		mc->next =3D NULL;
+		page->pte.mmchain =3D mc;
+		ClearPageDirect(page);
+	}
+	if (page->pte.mmchain) {
+		/* Hook up the mm_chain to the page. */
+		mc =3D mm_chain_alloc();
+		mc->mm =3D mm;
+		mc->next =3D page->pte.mmchain;
+		page->pte.mmchain =3D mc;
+	} else {
+		page->pte.mmdirect =3D mm;
+		SetPageDirect(page);
+		page->index =3D address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
+	}
+}
+
+/*
+ * pgtable_remove_rmap_locked - Remove an mm_struct from the chain for a =
pte page.
+ * @page: The pte page to remove the mm_struct from
+ * @mm: The mm_struct to remove
+ *
+ * Pte pages maintain a chain of mm_structs that use it.  This removes an=20
+ * mm_struct from the chain.
+ *
+ * This function must be called with the pte_page_lock held for the page
+ */
+void pgtable_remove_rmap_locked(struct page * page, struct mm_struct *mm)
+{
+	struct mm_chain * mc, * prev_mc =3D NULL;
+
+#ifdef DEBUG_RMAP
+	BUG_ON(mm =3D=3D NULL);
+	BUG_ON(!PagePtepage(page));
+#endif
+
+	if (PageDirect(page)) {
+		if (page->pte.mmdirect =3D=3D mm) {
+			page->pte.mmdirect =3D NULL;
+			ClearPageDirect(page);
+			page->index =3D 0;
+			goto out;
+		}
+	} else {
+#ifdef DEBUG_RMAP
+		BUG_ON(page->pte.mmchain->next =3D=3D NULL);
+#endif
+		for (mc =3D page->pte.mmchain; mc; prev_mc =3D mc, mc =3D mc->next) {
+			if (mc->mm =3D=3D mm) {
+				mm_chain_free(mc, prev_mc, page);
+				/* Check whether we can convert to direct */
+				mc =3D page->pte.mmchain;
+				if (!mc->next) {
+					page->pte.mmdirect =3D mc->mm;
+					SetPageDirect(page);
+					mm_chain_free(mc, NULL, NULL);
+				}
+				goto out;
+			}
+		}
+	}
+	BUG();
+out:
+}
+
+/*
+ * pgtable_add_rmap - Add an mm_struct to the chain for a pte page.
+ * @page: The pte page to add the mm_struct to
+ * @mm: The mm_struct to add
+ * @address: The address of the page we're mapping
+ *
+ * This is a wrapper for pgtable_add_rmap_locked that takes the lock
+ */
+void pgtable_add_rmap(struct page * page, struct mm_struct * mm,
+			     unsigned long address)
+{
+	pte_page_lock(page);
+	pgtable_add_rmap_locked(page, mm, address);
+	pte_page_unlock(page);
+}
+
+/*
+ * pgtable_remove_rmap_locked - Remove an mm_struct from the chain for a =
pte page.
+ * @page: The pte page to remove the mm_struct from
+ * @mm: The mm_struct to remove
+ *
+ * This is a wrapper for pgtable_remove_rmap_locked that takes the lock
+ */
+void pgtable_remove_rmap(struct page * page, struct mm_struct *mm)
+{
+	pte_page_lock(page);
+	pgtable_remove_rmap_locked(page, mm);
+	pte_page_unlock(page);
+}
+
 /**
  * page_add_rmap - add reverse mapping entry to a page
  * @page: the page to add the mapping to
  * @ptep: the page table entry mapping this page
  *
  * Add a new pte reverse mapping to a page.
- * The caller needs to hold the mm->page_table_lock.
+ * The caller needs to hold the pte_page_lock.
  */
 void page_add_rmap(struct page * page, pte_t * ptep)
 {
@@ -180,8 +331,7 @@
 		BUG();
 	if (!pte_present(*ptep))
 		BUG();
-	if (!ptep_to_mm(ptep))
-		BUG();
+	BUG_ON(PagePtepage(page));
 #endif
=20
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
@@ -199,12 +349,15 @@
 			if (page->pte.direct =3D=3D pte_paddr)
 				BUG();
 		} else {
+			int count =3D 0;
 			for (pc =3D page->pte.chain; pc; pc =3D pc->next) {
-				for (i =3D 0; i < NRPTE; i++) {
+				for (i =3D 0; i < NRPTE; i++, count++) {
 					pte_addr_t p =3D pc->ptes[i];
=20
-					if (p && p =3D=3D pte_paddr)
+					if (p && p =3D=3D pte_paddr) {
+						printk(KERN_ERR "page_add_rmap: page %08lx (count %d), ptep %08lx, =
rmap count %d\n", page, page_count(page), ptep, count);
 						BUG();
+					}
 				}
 			}
 		}
@@ -263,7 +416,7 @@
  * Removes the reverse mapping from the pte_chain of the page,
  * after that the caller can clear the page table entry and free
  * the page.
- * Caller needs to hold the mm->page_table_lock.
+ * Caller needs to hold the pte_page_lock.
  */
 void page_remove_rmap(struct page * page, pte_t * ptep)
 {
@@ -277,6 +430,10 @@
 	if (!page_mapped(page))
 		return;		/* remap_page_range() from a driver? */
=20
+#ifdef DEBUG_RMAP
+	BUG_ON(PagePtepage(page));
+#endif
+
 	pte_chain_lock(page);
=20
 	if (PageDirect(page)) {
@@ -342,6 +499,130 @@
 	return;
 }
=20
+static int pgtable_check_mlocked_mm(struct mm_struct *mm, unsigned long =
address)
+{
+	struct vm_area_struct *vma;
+	int ret =3D SWAP_SUCCESS;
+
+	/* During mremap, it's possible pages are not in a VMA. */
+	vma =3D find_vma(mm, address);
+	if (!vma) {
+		ret =3D SWAP_FAIL;
+		goto out;
+	}
+
+	/* The page is mlock()d, we cannot swap it out. */
+	if (vma->vm_flags & VM_LOCKED) {
+		ret =3D SWAP_FAIL;
+	}
+out:
+	return ret;
+}
+
+static int pgtable_check_mlocked(struct page *ptepage, unsigned long =
address)
+{
+	struct mm_chain *mc;
+	int ret =3D SWAP_SUCCESS;
+
+#ifdef DEBUG_RMAP
+	BUG_ON(!PagePtepage(ptepage));
+#endif
+	if (PageDirect(ptepage)) {
+		ret =3D pgtable_check_mlocked_mm(ptepage->pte.mmdirect, address);
+		goto out;
+	}
+
+	for (mc =3D ptepage->pte.mmchain; mc; mc =3D mc->next) {
+#ifdef DEBUG_RMAP
+		BUG_ON(mc->mm =3D=3D NULL);
+#endif
+		ret =3D pgtable_check_mlocked_mm(mc->mm, address);
+		if (ret !=3D SWAP_SUCCESS)
+			goto out;
+	}
+out:
+	return ret;
+}
+
+/**
+ * pgtable_unmap_one_mm - Decrement the rss count and flush for an =
mm_struct
+ * @mm: - the mm_struct to decrement
+ * @address: - The address of the page we're removing
+ *
+ * All pte pages keep a chain of mm_struct that are using it.  This does a =
flush
+ * of the address for that mm_struct and decrements the rss count.
+ */
+static int pgtable_unmap_one_mm(struct mm_struct *mm, unsigned long =
address)
+{
+	struct vm_area_struct *vma;
+	int ret =3D SWAP_SUCCESS;
+
+	/* During mremap, it's possible pages are not in a VMA. */
+	vma =3D find_vma(mm, address);
+	if (!vma) {
+		ret =3D SWAP_FAIL;
+		goto out;
+	}
+	flush_tlb_page(vma, address);
+	flush_cache_page(vma, address);
+	mm->rss--;
+
+out:
+	return ret;
+}
+
+/**
+ * pgtable_unmap_one - Decrement all rss counts and flush caches for a pte =
page
+ * @ptepage: the pte page to decrement the count for
+ * @address: the address of the page we're removing
+ *
+ * This decrements the rss counts of all mm_structs that map this pte page
+ * and flushes the tlb and cache for these mm_structs and address
+ */
+static int pgtable_unmap_one(struct page *ptepage, unsigned long address)
+{
+	struct mm_chain *mc;
+	int ret =3D SWAP_SUCCESS;
+
+#ifdef DEBUG_RMAP
+	BUG_ON(!PagePtepage(ptepage));
+#endif
+
+	if (PageDirect(ptepage)) {
+		ret =3D pgtable_unmap_one_mm(ptepage->pte.mmdirect, address);
+		if (ret !=3D SWAP_SUCCESS)
+			goto out;
+	} else for (mc =3D ptepage->pte.mmchain; mc; mc =3D mc->next) {
+		ret =3D pgtable_unmap_one_mm(mc->mm, address);
+		if (ret !=3D SWAP_SUCCESS)
+			goto out;
+	}
+	ptepage->private--;
+out:
+	return ret;
+}
+
+/**
+ * increment_rss - increment the rss count by one
+ * @ptepage: The pte page that's getting a new paged mapped
+ *
+ * Since mapping a page into a pte page can increment the rss
+ * for multiple mm_structs, this function iterates through all
+ * the mms and increments them.  It also keeps an rss count
+ * per pte page.
+ */
+void increment_rss(struct page *ptepage)
+{
+	struct mm_chain *mc;
+
+	if (PageDirect(ptepage))
+		ptepage->pte.mmdirect->rss++;
+	else for (mc =3D ptepage->pte.mmchain; mc; mc =3D mc->next)
+		mc->mm->rss++;
+
+	ptepage->private++;
+}
+
 /**
  * try_to_unmap_one - worker function for try_to_unmap
  * @page: page to unmap
@@ -354,48 +635,36 @@
  *	zone->lru_lock			page_launder()
  *	    page lock			page_launder(), trylock
  *		pte_chain_lock		page_launder()
- *		    mm->page_table_lock	try_to_unmap_one(), trylock
+ *		    pte_page_lock	try_to_unmap_one(), trylock
  */
 static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
 static int try_to_unmap_one(struct page * page, pte_addr_t paddr)
 {
 	pte_t *ptep =3D rmap_ptep_map(paddr);
-	unsigned long address =3D ptep_to_address(ptep);
-	struct mm_struct * mm =3D ptep_to_mm(ptep);
-	struct vm_area_struct * vma;
 	pte_t pte;
+	struct page *ptepage =3D kmap_atomic_to_page(ptep);
+	unsigned long address =3D ptep_to_address(ptep);
 	int ret;
=20
-	if (!mm)
-		BUG();
-
-	/*
-	 * We need the page_table_lock to protect us from page faults,
-	 * munmap, fork, etc...
-	 */
-	if (!spin_trylock(&mm->page_table_lock)) {
+#ifdef DEBUG_RMAP
+	BUG_ON(!PagePtepage(ptepage));
+#endif
+	if (!pte_page_trylock(ptepage)) {
 		rmap_ptep_unmap(ptep);
 		return SWAP_AGAIN;
 	}
=20
-
-	/* During mremap, it's possible pages are not in a VMA. */
-	vma =3D find_vma(mm, address);
-	if (!vma) {
-		ret =3D SWAP_FAIL;
+	ret =3D pgtable_check_mlocked(ptepage, address);
+	if (ret !=3D SWAP_SUCCESS)
 		goto out_unlock;
-	}
+	pte =3D ptep_get_and_clear(ptep);
=20
-	/* The page is mlock()d, we cannot swap it out. */
-	if (vma->vm_flags & VM_LOCKED) {
-		ret =3D SWAP_FAIL;
+	ret =3D pgtable_unmap_one(ptepage, address);
+	if (ret !=3D SWAP_SUCCESS) {
+		set_pte(ptep, pte);
 		goto out_unlock;
 	}
-
-	/* Nuke the page table entry. */
-	pte =3D ptep_get_and_clear(ptep);
-	flush_tlb_page(vma, address);
-	flush_cache_page(vma, address);
+	pte_page_unlock(ptepage);
=20
 	/* Store the swap location in the pte. See handle_pte_fault() ... */
 	if (PageSwapCache(page)) {
@@ -408,13 +677,15 @@
 	if (pte_dirty(pte))
 		set_page_dirty(page);
=20
-	mm->rss--;
 	page_cache_release(page);
 	ret =3D SWAP_SUCCESS;
+	goto out;
=20
 out_unlock:
+	pte_page_unlock(ptepage);
+
+out:
 	rmap_ptep_unmap(ptep);
-	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
=20
@@ -523,6 +794,17 @@
=20
 void __init pte_chain_init(void)
 {
+
+	mm_chain_cache =3D kmem_cache_create(	"mm_chain",
+						sizeof(struct mm_chain),
+						0,
+						0,
+						NULL,
+						NULL);
+
+	if (!mm_chain_cache)
+		panic("failed to create mm_chain cache!\n");
+
 	pte_chain_cache =3D kmem_cache_create(	"pte_chain",
 						sizeof(struct pte_chain),
 						0,
--- 2.5.43-mm2/./mm/fremap.c	2002-10-17 11:13:01.000000000 -0500
+++ 2.5.43-mm2-shpte/./mm/fremap.c	2002-10-18 12:17:30.000000000 -0500
@@ -11,6 +11,8 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swapops.h>
+#include <linux/rmap-locking.h>
+
 #include <asm/mmu_context.h>
=20
 static inline void zap_pte(struct mm_struct *mm, pte_t *ptep)
@@ -47,6 +49,7 @@
 		unsigned long addr, struct page *page, unsigned long prot)
 {
 	int err =3D -ENOMEM;
+	struct page *ptepage;
 	pte_t *pte, entry;
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -58,10 +61,25 @@
 	if (!pmd)
 		goto err_unlock;
=20
+#ifdef CONFIG_SHAREPTE
+	if (pmd_present(*pmd)) {
+		ptepage =3D pmd_page(*pmd);
+		if (page_count(ptepage) > 1) {
+			pte =3D pte_unshare(mm, pmd, addr);
+			ptepage =3D pmd_page(*pmd);
+			goto mapped;
+		}
+	}
+#endif	
+
 	pte =3D pte_alloc_map(mm, pmd, addr);
 	if (!pte)
 		goto err_unlock;
=20
+	pte_page_lock(ptepage);
+#ifdef CONFIG_SHAREPTE
+mapped:
+#endif
 	zap_pte(mm, pte);
=20
 	mm->rss++;
@@ -75,11 +93,13 @@
 	pte_unmap(pte);
 	flush_tlb_page(vma, addr);
=20
+	pte_page_unlock(ptepage);
 	spin_unlock(&mm->page_table_lock);
=20
 	return 0;
=20
 err_unlock:
+	pte_page_unlock(ptepage);
 	spin_unlock(&mm->page_table_lock);
 	return err;
 }

--==========734028336==========--

