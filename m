Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSAPSBG>; Wed, 16 Jan 2002 13:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285703AbSAPR7L>; Wed, 16 Jan 2002 12:59:11 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2075 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285369AbSAPR5g>; Wed, 16 Jan 2002 12:57:36 -0500
Date: Wed, 16 Jan 2002 18:58:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: pte-highmem-5
Message-ID: <20020116185814.I22791@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After weeks of remote debugging I found one problem triggered by people
with the real highmem64 hardware and that really needs that much memory
mapped from lots of tasks at the same time.

They were running out of pagetables, mapping 1G per-task (shm for
example) will overflow the lowmem zone with PAE with some houndred tasks
in the system. They were pointing the finger at the VM but the VM was
just doing the very right thing to do.

This patch in short will move pagetables into highmem, obviously it
breaks all the archs out there. This should fix the problem completly
allowing linux to effectively support all the 64G possibly available in
the ia32 boxes (currently, without this patch, you risk to be able to
use only a few gigabytes).

-aa kernels as well obviously will support this feature from the very
next release and this patch is against 2.4.18pre2aa2, I recommend people
to test it on top of 2.4.18pre2aa2 and tell me if it works well or not.
If you don't have highmem you still can test it by configuring the
kernel with highmem emulation enabled.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.18pre2aa2/pte-highmem-5

This will have to be forward ported to 2.5 as well of course. I
developed it on top of 2.4 because I must support this in 2.4-aa too
because HIGHMEM64G is basically useless for the most important people
without this additional change.

I'm too lazy to describe how it works with words, you've the source,
it seems not too dirty (it may still need some cleanup, suggestions as
welcome of course), and if you have questions I'll be glad to answer as
usual. patch is as well attached because it's not too big and I know
some people is annoyed by ftp downloads (mee too sometime :). thanks,

Andrea

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pte-highmem-5

diff -urN 2.4.18pre2aa2/arch/i386/kernel/traps.c pte-5/arch/i386/kernel/traps.c
--- 2.4.18pre2aa2/arch/i386/kernel/traps.c	Sun Sep 30 21:26:08 2001
+++ pte-5/arch/i386/kernel/traps.c	Wed Jan 16 17:52:49 2002
@@ -737,6 +737,7 @@
 	pte = pte_offset(pmd, page);
 	__free_page(pte_page(*pte));
 	*pte = mk_pte_phys(__pa(&idt_table), PAGE_KERNEL_RO);
+	pte_kunmap(pte);
 	/*
 	 * Not that any PGE-capable kernel should have the f00f bug ...
 	 */
diff -urN 2.4.18pre2aa2/arch/i386/kernel/vm86.c pte-5/arch/i386/kernel/vm86.c
--- 2.4.18pre2aa2/arch/i386/kernel/vm86.c	Wed Jan 16 17:51:25 2002
+++ pte-5/arch/i386/kernel/vm86.c	Wed Jan 16 17:52:49 2002
@@ -93,7 +93,7 @@
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, *pte_orig;
 	int i;
 
 	pgd = pgd_offset(tsk->mm, 0xA0000);
@@ -112,12 +112,13 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset(pmd, 0xA0000);
+	pte_orig = pte = pte_offset(pmd, 0xA0000);
 	for (i = 0; i < 32; i++) {
 		if (pte_present(*pte))
 			set_pte(pte, pte_wrprotect(*pte));
 		pte++;
 	}
+	pte_kunmap(pte_orig);
 	flush_tlb();
 }
 
diff -urN 2.4.18pre2aa2/arch/i386/mm/fault.c pte-5/arch/i386/mm/fault.c
--- 2.4.18pre2aa2/arch/i386/mm/fault.c	Wed Jan 16 17:52:15 2002
+++ pte-5/arch/i386/mm/fault.c	Wed Jan 16 17:52:49 2002
@@ -388,6 +388,7 @@
 		pgd_t *pgd, *pgd_k;
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
+		int present;
 
 		asm("movl %%cr3,%0":"=r" (pgd));
 		pgd = offset + (pgd_t *)__va(pgd);
@@ -403,8 +404,12 @@
 			goto no_context;
 		set_pmd(pmd, *pmd_k);
 
-		pte_k = pte_offset(pmd_k, address);
-		if (!pte_present(*pte_k))
+		local_irq_disable();
+		pte_k = pte_offset_atomic_irq(pmd_k, address);
+		present = pte_present(*pte_k);
+		pte_kunmap(pte_k);
+		local_irq_enable();
+		if (!present)
 			goto no_context;
 		return;
 	}
diff -urN 2.4.18pre2aa2/arch/i386/mm/init.c pte-5/arch/i386/mm/init.c
--- 2.4.18pre2aa2/arch/i386/mm/init.c	Wed Jan 16 17:52:15 2002
+++ pte-5/arch/i386/mm/init.c	Wed Jan 16 17:52:49 2002
@@ -76,7 +76,7 @@
 pgprot_t kmap_prot;
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
+	pte_offset_lowmem(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)
 {
@@ -143,7 +143,7 @@
 		printk("PAE BUG #01!\n");
 		return;
 	}
-	pte = pte_offset(pmd, vaddr);
+	pte = pte_offset_lowmem(pmd, vaddr);
 	if (pte_val(*pte))
 		pte_ERROR(*pte);
 	pgprot_val(prot) = pgprot_val(PAGE_KERNEL) | pgprot_val(flags);
@@ -195,8 +195,8 @@
 		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
 			if (pmd_none(*pmd)) {
 				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-				set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
-				if (pte != pte_offset(pmd, 0))
+				set_pmd(pmd, mk_pmd_phys(__pa(pte), __pgprot(_KERNPG_TABLE)));
+				if (pte != pte_offset_lowmem(pmd, 0))
 					BUG();
 			}
 			vaddr += PMD_SIZE;
@@ -244,17 +244,17 @@
 			if (end && (vaddr >= end))
 				break;
 			if (cpu_has_pse) {
-				unsigned long __pe;
+				unsigned long prot;
 
 				set_in_cr4(X86_CR4_PSE);
 				boot_cpu_data.wp_works_ok = 1;
-				__pe = _KERNPG_TABLE + _PAGE_PSE + __pa(vaddr);
+				prot = _KERNPG_TABLE + _PAGE_PSE;
 				/* Make it "global" too if supported */
 				if (cpu_has_pge) {
 					set_in_cr4(X86_CR4_PGE);
-					__pe += _PAGE_GLOBAL;
+					prot += _PAGE_GLOBAL;
 				}
-				set_pmd(pmd, __pmd(__pe));
+				set_pmd(pmd, mk_pmd_phys(__pa(vaddr), __pgprot(prot)));
 				continue;
 			}
 
@@ -266,8 +266,8 @@
 					break;
 				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
 			}
-			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
-			if (pte_base != pte_offset(pmd, 0))
+			set_pmd(pmd, mk_pmd_phys(__pa(pte_base), __pgprot(_KERNPG_TABLE)));
+			if (pte_base != pte_offset_lowmem(pmd, 0))
 				BUG();
 
 		}
@@ -285,11 +285,11 @@
 	 * Permanent kmaps:
 	 */
 	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr, vaddr + PKMAP_SIZE, pgd_base);
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset(pmd, vaddr);
+	pte = pte_offset_lowmem(pmd, vaddr);
 	pkmap_page_table = pte;
 #endif
 
@@ -398,7 +398,7 @@
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset(pmd, vaddr);
+	pte = pte_offset_lowmem(pmd, vaddr);
 	old_pte = *pte;
 	*pte = mk_pte_phys(0, PAGE_READONLY);
 	local_flush_tlb();
diff -urN 2.4.18pre2aa2/arch/i386/mm/ioremap.c pte-5/arch/i386/mm/ioremap.c
--- 2.4.18pre2aa2/arch/i386/mm/ioremap.c	Tue Mar 20 17:13:33 2001
+++ pte-5/arch/i386/mm/ioremap.c	Wed Jan 16 17:52:49 2002
@@ -53,6 +53,7 @@
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
+		pte_kunmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
diff -urN 2.4.18pre2aa2/drivers/char/drm/drm_proc.h pte-5/drivers/char/drm/drm_proc.h
--- 2.4.18pre2aa2/drivers/char/drm/drm_proc.h	Thu Nov 22 20:46:37 2001
+++ pte-5/drivers/char/drm/drm_proc.h	Wed Jan 16 17:52:49 2002
@@ -449,7 +449,7 @@
 		for (i = vma->vm_start; i < vma->vm_end; i += PAGE_SIZE) {
 			pgd = pgd_offset(vma->vm_mm, i);
 			pmd = pmd_offset(pgd, i);
-			pte = pte_offset(pmd, i);
+			pte = pte_offset_atomic(pmd, i);
 			if (pte_present(*pte)) {
 				address = __pa(pte_page(*pte))
 					+ (i & (PAGE_SIZE-1));
@@ -465,6 +465,7 @@
 			} else {
 				DRM_PROC_PRINT("      0x%08lx\n", i);
 			}
+			pte_kunmap(pte);
 		}
 #endif
 	}
diff -urN 2.4.18pre2aa2/drivers/char/drm/drm_scatter.h pte-5/drivers/char/drm/drm_scatter.h
--- 2.4.18pre2aa2/drivers/char/drm/drm_scatter.h	Thu Nov 22 20:46:37 2001
+++ pte-5/drivers/char/drm/drm_scatter.h	Wed Jan 16 17:52:49 2002
@@ -145,9 +145,10 @@
 
 		pte = pte_offset( pmd, i );
 		if ( !pte_present( *pte ) )
-			goto failed;
+			goto failed_unmap;
 
 		entry->pagelist[j] = pte_page( *pte );
+		pte_kunmap(pte);
 
 		SetPageReserved( entry->pagelist[j] );
 	}
@@ -205,6 +206,8 @@
 
 	return 0;
 
+ failed_unmap:
+	pte_kunmap(pte);
  failed:
 	DRM(sg_cleanup)( entry );
 	return -ENOMEM;
diff -urN 2.4.18pre2aa2/drivers/char/drm/drm_vm.h pte-5/drivers/char/drm/drm_vm.h
--- 2.4.18pre2aa2/drivers/char/drm/drm_vm.h	Thu Nov 22 20:46:37 2001
+++ pte-5/drivers/char/drm/drm_vm.h	Wed Jan 16 17:52:49 2002
@@ -170,9 +170,10 @@
 	pmd = pmd_offset( pgd, i );
 	if( !pmd_present( *pmd ) ) return NOPAGE_OOM;
 	pte = pte_offset( pmd, i );
-	if( !pte_present( *pte ) ) return NOPAGE_OOM;
+	if( !pte_present( *pte ) ) { pte_kunmap(pte); return NOPAGE_OOM; }
 
 	page = pte_page(*pte);
+	pte_kunmap(pte);
 	get_page(page);
 
 	DRM_DEBUG("shm_nopage 0x%lx\n", address);
diff -urN 2.4.18pre2aa2/fs/exec.c pte-5/fs/exec.c
--- 2.4.18pre2aa2/fs/exec.c	Fri Dec 21 18:41:55 2001
+++ pte-5/fs/exec.c	Wed Jan 16 17:52:49 2002
@@ -274,7 +274,7 @@
 	if (!pte)
 		goto out;
 	if (!pte_none(*pte))
-		goto out;
+		goto out_unmap;
 	lru_cache_add(page);
 	flush_dcache_page(page);
 	flush_page_to_ram(page);
@@ -282,8 +282,12 @@
 	tsk->mm->rss++;
 	spin_unlock(&tsk->mm->page_table_lock);
 
+	pte_kunmap(pte);
+
 	/* no need for flush_tlb */
 	return;
+out_unmap:
+	pte_kunmap(pte);
 out:
 	spin_unlock(&tsk->mm->page_table_lock);
 	__free_page(page);
diff -urN 2.4.18pre2aa2/fs/proc/array.c pte-5/fs/proc/array.c
--- 2.4.18pre2aa2/fs/proc/array.c	Wed Jan 16 17:52:17 2002
+++ pte-5/fs/proc/array.c	Wed Jan 16 17:52:49 2002
@@ -432,6 +432,7 @@
 		if (page_count(pte_page(page)) > 1)
 			++*shared;
 	} while (address < end);
+	pte_kunmap(pte - 1);
 }
 
 static inline void statm_pmd_range(pgd_t * pgd, unsigned long address, unsigned long size,
diff -urN 2.4.18pre2aa2/include/asm-i386/fixmap.h pte-5/include/asm-i386/fixmap.h
--- 2.4.18pre2aa2/include/asm-i386/fixmap.h	Thu Nov 22 20:46:19 2001
+++ pte-5/include/asm-i386/fixmap.h	Wed Jan 16 17:56:22 2002
@@ -87,7 +87,7 @@
  */
 #define FIXADDR_TOP	(0xffffe000UL)
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE + PAGE_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 
diff -urN 2.4.18pre2aa2/include/asm-i386/highmem.h pte-5/include/asm-i386/highmem.h
--- 2.4.18pre2aa2/include/asm-i386/highmem.h	Thu Nov 22 20:46:19 2001
+++ pte-5/include/asm-i386/highmem.h	Wed Jan 16 18:12:41 2002
@@ -41,31 +41,39 @@
 
 extern void kmap_init(void) __init;
 
+enum km_serie_type {
+	KM_SERIE_DEFAULT,
+	KM_SERIE_PAGETABLE,
+	KM_SERIE_PAGETABLE2,
+	KM_NR_SERIES,
+};
+
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
-#define PKMAP_BASE (0xfe000000UL)
-#ifdef CONFIG_X86_PAE
-#define LAST_PKMAP 512
-#else
 #define LAST_PKMAP 1024
-#endif
 #define LAST_PKMAP_MASK (LAST_PKMAP-1)
+#define PKMAP_SIZE ((LAST_PKMAP*KM_NR_SERIES) << PAGE_SHIFT)
+#define PKMAP_BASE (FIXADDR_START - PKMAP_SIZE - PAGE_SIZE) /* left a page in between */
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-extern void * FASTCALL(kmap_high(struct page *page));
-extern void FASTCALL(kunmap_high(struct page *page));
+extern void * FASTCALL(kmap_high(struct page *page, int serie));
+extern void FASTCALL(kunmap_high(void * vaddr));
+
+#define kmap(page) kmap_serie(page, KM_SERIE_DEFAULT)
+#define kmap_pagetable(page) kmap_serie(page, KM_SERIE_PAGETABLE)
+#define kmap_pagetable2(page) kmap_serie(page, KM_SERIE_PAGETABLE2)
 
-static inline void *kmap(struct page *page)
+static inline void *kmap_serie(struct page *page, int serie)
 {
 	if (in_interrupt())
 		BUG();
 	if (page < highmem_start_page)
 		return page_address(page);
-	return kmap_high(page);
+	return kmap_high(page, serie);
 }
 
 static inline void kunmap(struct page *page)
@@ -74,7 +82,7 @@
 		BUG();
 	if (page < highmem_start_page)
 		return;
-	kunmap_high(page);
+	kunmap_high(page->virtual);
 }
 
 /*
@@ -122,6 +130,23 @@
 	pte_clear(kmap_pte-idx);
 	__flush_tlb_one(vaddr);
 #endif
+}
+
+static inline void kunmap_vaddr(unsigned long kvaddr)
+{
+	/* direct map */
+	if (kvaddr < PKMAP_BASE)
+		return;
+	/* atomic kmap */
+	if (kvaddr >= FIXADDR_START) {
+		enum fixed_addresses idx;
+		idx = (__fix_to_virt(FIX_KMAP_BEGIN) - kvaddr) >> PAGE_SHIFT;
+		kunmap_atomic((void *)kvaddr, idx % KM_TYPE_NR);
+		return;
+	}
+	if (in_interrupt())
+		BUG();
+	kunmap_high((void *)kvaddr);
 }
 
 #endif /* __KERNEL__ */
diff -urN 2.4.18pre2aa2/include/asm-i386/page.h pte-5/include/asm-i386/page.h
--- 2.4.18pre2aa2/include/asm-i386/page.h	Wed Jan 16 17:52:19 2002
+++ pte-5/include/asm-i386/page.h	Wed Jan 16 17:56:22 2002
@@ -38,20 +38,21 @@
  */
 #if CONFIG_X86_PAE
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct { unsigned long pmd_low, pmd_high; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+#define pmd_val(x)	((x).pmd_low | ((unsigned long long)(x).pmd_high << 32))
 #else
 typedef struct { unsigned long pte_low; } pte_t;
-typedef struct { unsigned long pmd; } pmd_t;
+typedef struct { unsigned long pmd_low; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low)
+#define pmd_val(x)	((x).pmd_low)
 #endif
 #define PTE_MASK	PAGE_MASK
 
 typedef struct { unsigned long pgprot; } pgprot_t;
 
-#define pmd_val(x)	((x).pmd)
 #define pgd_val(x)	((x).pgd)
 #define pgprot_val(x)	((x).pgprot)
 
diff -urN 2.4.18pre2aa2/include/asm-i386/pgalloc.h pte-5/include/asm-i386/pgalloc.h
--- 2.4.18pre2aa2/include/asm-i386/pgalloc.h	Wed Jan 16 17:52:19 2002
+++ pte-5/include/asm-i386/pgalloc.h	Wed Jan 16 18:13:16 2002
@@ -5,14 +5,14 @@
 #include <asm/processor.h>
 #include <asm/fixmap.h>
 #include <linux/threads.h>
+#include <linux/highmem.h>
 
 #define pgd_quicklist (current_cpu_data.pgd_quick)
 #define pmd_quicklist (current_cpu_data.pmd_quick)
 #define pte_quicklist (current_cpu_data.pte_quick)
 #define pgtable_cache_size (current_cpu_data.pgtable_cache_sz)
 
-#define pmd_populate(mm, pmd, pte) \
-		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
+#define pmd_populate(mm, pmd, page) set_pmd(pmd, mk_pmd(page, __pgprot(_PAGE_TABLE)))
 
 /*
  * Allocate and free page tables.
@@ -104,39 +104,39 @@
 #endif
 }
 
-static inline pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline struct page * pte_alloc_one_fast(struct mm_struct *mm,
+					       unsigned long address)
 {
-	pte_t *pte;
+	struct page * page;
 
-	pte = (pte_t *) __get_free_page(GFP_KERNEL);
-	if (pte)
-		clear_page(pte);
-	return pte;
-}
-
-static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm,
-					unsigned long address)
-{
-	unsigned long *ret;
-
-	if ((ret = (unsigned long *)pte_quicklist) != NULL) {
-		pte_quicklist = (unsigned long *)(*ret);
-		ret[0] = ret[1];
+	if ((page = pte_quicklist)) {
+		struct page ** pte_vaddr = kmap_atomic(page, KM_USER0);
+		pte_quicklist = *pte_vaddr;
+		pte_vaddr[0] = 0;
+		kunmap_atomic(pte_vaddr, KM_USER0);
 		pgtable_cache_size--;
 	}
-	return (pte_t *)ret;
+	return page;
 }
 
-static inline void pte_free_fast(pte_t *pte)
+static inline void pte_free_fast(struct page * page)
 {
-	*(unsigned long *)pte = (unsigned long) pte_quicklist;
-	pte_quicklist = (unsigned long *) pte;
+	struct page ** pte_vaddr = kmap_atomic(page, KM_USER0);
+	*pte_vaddr = pte_quicklist;
+	kunmap_atomic(pte_vaddr, KM_USER0);
+	pte_quicklist = page;
 	pgtable_cache_size++;
 }
 
-static __inline__ void pte_free_slow(pte_t *pte)
+static inline void pte_free_via_pmd(pmd_t pmd)
+{
+	struct page * page = mem_map + (pmd_val(pmd) >> PAGE_SHIFT);
+	pte_free_fast(page);
+}
+
+static __inline__ void pte_free_slow(struct page * page)
 {
-	free_page((unsigned long)pte);
+	__free_page(page);
 }
 
 #define pte_free(pte)		pte_free_fast(pte)
diff -urN 2.4.18pre2aa2/include/asm-i386/pgtable-2level.h pte-5/include/asm-i386/pgtable-2level.h
--- 2.4.18pre2aa2/include/asm-i386/pgtable-2level.h	Thu Jul 26 22:40:32 2001
+++ pte-5/include/asm-i386/pgtable-2level.h	Wed Jan 16 17:52:49 2002
@@ -58,6 +58,9 @@
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		(mem_map+((unsigned long)(((x).pte_low >> PAGE_SHIFT))))
 #define pte_none(x)		(!(x).pte_low)
+#define __pmd_page(x)		(mem_map + ((x).pmd_low >> PAGE_SHIFT))
+#define pmd_none(x)		(!(x).pmd_low)
 #define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
+#define __mk_pmd(page_nr,pgprot) __pmd(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
 
 #endif /* _I386_PGTABLE_2LEVEL_H */
diff -urN 2.4.18pre2aa2/include/asm-i386/pgtable-3level.h pte-5/include/asm-i386/pgtable-3level.h
--- 2.4.18pre2aa2/include/asm-i386/pgtable-3level.h	Thu Jul 26 22:40:32 2001
+++ pte-5/include/asm-i386/pgtable-3level.h	Wed Jan 16 17:52:49 2002
@@ -49,8 +49,13 @@
 	smp_wmb();
 	ptep->pte_low = pte.pte_low;
 }
-#define set_pmd(pmdptr,pmdval) \
-		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	pmdp->pmd_high = pmd.pmd_high;
+	smp_wmb();
+	pmdp->pmd_low = pmd.pmd_low;
+}
 #define set_pgd(pgdptr,pgdval) \
 		set_64bit((unsigned long long *)(pgdptr),pgd_val(pgdval))
 
@@ -88,6 +93,8 @@
 
 #define pte_page(x)	(mem_map+(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT))))
 #define pte_none(x)	(!(x).pte_low && !(x).pte_high)
+#define __pmd_page(x)	(mem_map + (((x).pmd_low >> PAGE_SHIFT) | ((x).pmd_high << (32-PAGE_SHIFT))))
+#define pmd_none(x)	(!(x).pmd_low && !(x).pmd_high)
 
 static inline pte_t __mk_pte(unsigned long page_nr, pgprot_t pgprot)
 {
@@ -96,6 +103,15 @@
 	pte.pte_high = page_nr >> (32 - PAGE_SHIFT);
 	pte.pte_low = (page_nr << PAGE_SHIFT) | pgprot_val(pgprot);
 	return pte;
+}
+
+static inline pmd_t __mk_pmd(unsigned long page_nr, pgprot_t pgprot)
+{
+	pmd_t pmd;
+
+	pmd.pmd_high = page_nr >> (32 - PAGE_SHIFT);
+	pmd.pmd_low = (page_nr << PAGE_SHIFT) | pgprot_val(pgprot);
+	return pmd;
 }
 
 #endif /* _I386_PGTABLE_3LEVEL_H */
diff -urN 2.4.18pre2aa2/include/asm-i386/pgtable.h pte-5/include/asm-i386/pgtable.h
--- 2.4.18pre2aa2/include/asm-i386/pgtable.h	Wed Jan 16 17:52:19 2002
+++ pte-5/include/asm-i386/pgtable.h	Wed Jan 16 17:56:22 2002
@@ -259,10 +259,9 @@
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
 #define pte_clear(xp)	do { set_pte(xp, __pte(0)); } while (0)
 
-#define pmd_none(x)	(!pmd_val(x))
-#define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define pmd_present(x)	((x).pmd_low & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
-#define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define	pmd_bad(x)	(((x).pmd_low & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 /*
  * Permanent address of a page. Obviously must never be
@@ -307,9 +306,11 @@
  */
 
 #define mk_pte(page, pgprot)	__mk_pte((page) - mem_map, (pgprot))
+#define mk_pmd(page, pgprot)	__mk_pmd((page) - mem_map, (pgprot))
 
 /* This takes a physical page address that is used by the remapping functions */
 #define mk_pte_phys(physpage, pgprot)	__mk_pte((physpage) >> PAGE_SHIFT, pgprot)
+#define mk_pmd_phys(physpage, pgprot)	__mk_pmd((physpage) >> PAGE_SHIFT, pgprot)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
@@ -320,8 +321,52 @@
 
 #define page_pte(page) page_pte_prot(page, __pgprot(0))
 
-#define pmd_page(pmd) \
-((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+#define pmd_page(pmd)				\
+({						\
+	struct page * __page = __pmd_page(pmd);	\
+	kmap_pagetable(__page);			\
+})
+
+#define pmd_page2(pmd)				\
+({						\
+	struct page * __page = __pmd_page(pmd);	\
+	kmap_pagetable2(__page);		\
+})
+
+#define pmd_page_atomic(pmd)			\
+({						\
+	struct page * __page = __pmd_page(pmd);	\
+	kmap_atomic(__page, KM_USER0);		\
+})
+
+#define pmd_page_atomic2(pmd)			\
+({						\
+	struct page * __page = __pmd_page(pmd);	\
+	kmap_atomic(__page, KM_USER1);		\
+})
+
+#define pmd_page_atomic_irq(pmd)		\
+({						\
+	struct page * __page = __pmd_page(pmd);	\
+	kmap_atomic(__page, KM_BH_IRQ);		\
+})
+
+#define pmd_page_under_lock(pmd, mm)			\
+({							\
+	struct page * __page = __pmd_page(pmd);		\
+	int page_highmem = PageHighMem(__page);		\
+	void *__kvaddr;					\
+							\
+	if (page_highmem)				\
+		spin_unlock(&(mm)->page_table_lock);	\
+	__kvaddr = kmap_pagetable(__page);		\
+	if (page_highmem)				\
+		spin_lock(&(mm)->page_table_lock);	\
+	__kvaddr;					\
+})
+
+#define pmd_page_lowmem(pmd) \
+	(__va((pmd).pmd_low & PAGE_MASK))
 
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
@@ -341,6 +386,19 @@
 		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address) ((pte_t *) pmd_page(*(dir)) + \
 			__pte_offset(address))
+#define pte_offset2(dir, address) ((pte_t *) pmd_page2(*(dir)) + \
+			__pte_offset(address))
+#define pte_offset_atomic(dir, address) ((pte_t *) pmd_page_atomic(*(dir)) + \
+			__pte_offset(address))
+#define pte_offset_atomic2(dir, address) ((pte_t *) pmd_page_atomic2(*(dir)) + \
+			__pte_offset(address))
+#define pte_offset_under_lock(dir, address, mm) ((pte_t *) pmd_page_under_lock(*(dir), mm) + \
+			__pte_offset(address))
+#define pte_offset_atomic_irq(dir, address) ((pte_t *) pmd_page_atomic_irq(*(dir)) + \
+			__pte_offset(address))
+#define pte_offset_lowmem(dir, address) ((pte_t *) pmd_page_lowmem(*(dir)) + \
+			__pte_offset(address))
+#define pte_kunmap(ptep) kunmap_vaddr((unsigned long) ptep & PAGE_MASK)
 
 /*
  * The i386 doesn't have any external MMU info: the kernel page
diff -urN 2.4.18pre2aa2/include/asm-i386/processor.h pte-5/include/asm-i386/processor.h
--- 2.4.18pre2aa2/include/asm-i386/processor.h	Wed Jan 16 17:52:19 2002
+++ pte-5/include/asm-i386/processor.h	Wed Jan 16 17:56:22 2002
@@ -51,7 +51,7 @@
 	unsigned long loops_per_jiffy;
 	unsigned long *pgd_quick;
 	unsigned long *pmd_quick;
-	unsigned long *pte_quick;
+	struct page *pte_quick;
 	unsigned long pgtable_cache_sz;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
diff -urN 2.4.18pre2aa2/include/linux/highmem.h pte-5/include/linux/highmem.h
--- 2.4.18pre2aa2/include/linux/highmem.h	Wed Jan 16 17:52:20 2002
+++ pte-5/include/linux/highmem.h	Wed Jan 16 18:13:15 2002
@@ -2,7 +2,6 @@
 #define _LINUX_HIGHMEM_H
 
 #include <linux/config.h>
-#include <asm/pgalloc.h>
 
 #ifdef CONFIG_HIGHMEM
 
@@ -76,6 +75,8 @@
 #define bh_kunmap(bh)			do { } while (0)
 #define bh_kmap_irq(bh, flags)		((bh)->b_data)
 #define bh_kunmap_irq(bh, flags)	do { *(flags) = 0; } while (0)
+
+#define kmap_pagetable(page) kmap(page)
 
 #endif /* CONFIG_HIGHMEM */
 
diff -urN 2.4.18pre2aa2/mm/filemap.c pte-5/mm/filemap.c
--- 2.4.18pre2aa2/mm/filemap.c	Wed Jan 16 17:52:20 2002
+++ pte-5/mm/filemap.c	Wed Jan 16 17:52:49 2002
@@ -2058,7 +2058,7 @@
 	unsigned long address, unsigned long size, 
 	struct vm_area_struct *vma, unsigned long offset, unsigned int flags)
 {
-	pte_t * pte;
+	pte_t * pte, * pte_orig;
 	unsigned long end;
 	int error;
 
@@ -2069,7 +2069,7 @@
 		pmd_clear(pmd);
 		return 0;
 	}
-	pte = pte_offset(pmd, address);
+	pte_orig = pte = pte_offset_atomic(pmd, address);
 	offset += address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
@@ -2081,6 +2081,7 @@
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_kunmap(pte_orig);
 	return error;
 }
 
diff -urN 2.4.18pre2aa2/mm/highmem.c pte-5/mm/highmem.c
--- 2.4.18pre2aa2/mm/highmem.c	Wed Jan 16 17:52:20 2002
+++ pte-5/mm/highmem.c	Wed Jan 16 17:52:49 2002
@@ -21,6 +21,7 @@
 #include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <asm/pgalloc.h>
 
 /*
  * Virtual_count is not a pure "count".
@@ -30,22 +31,38 @@
  *    since the last TLB flush - so we can't use it.
  *  n means that there are (n-1) current users of it.
  */
-static int pkmap_count[LAST_PKMAP];
-static unsigned int last_pkmap_nr;
+static int pkmap_count[LAST_PKMAP*KM_NR_SERIES];
+static unsigned int last_pkmap_nr[KM_NR_SERIES];
 static spinlock_cacheline_t kmap_lock_cacheline = {SPIN_LOCK_UNLOCKED};
 #define kmap_lock  kmap_lock_cacheline.lock
+#if HIGHMEM_DEBUG
+static int kmap_ready;
+#endif
 
 pte_t * pkmap_page_table;
 
-static DECLARE_WAIT_QUEUE_HEAD(pkmap_map_wait);
+static wait_queue_head_t pkmap_map_wait[KM_NR_SERIES];
 
-static void flush_all_zero_pkmaps(void)
+static __init int init_kmap(void)
+{
+	int i;
+
+	for (i = 0; i < KM_NR_SERIES; i++)
+		init_waitqueue_head(pkmap_map_wait + i);
+#if HIGHMEM_DEBUG
+	kmap_ready = 1;
+#endif
+	return 0;
+}
+__initcall(init_kmap);
+
+static void flush_all_zero_pkmaps(int serie)
 {
 	int i;
 
 	flush_cache_all();
 
-	for (i = 0; i < LAST_PKMAP; i++) {
+	for (i = serie * LAST_PKMAP; i < (serie+1) * LAST_PKMAP; i++) {
 		struct page *page;
 
 		/*
@@ -77,7 +94,7 @@
 	flush_tlb_all();
 }
 
-static inline unsigned long map_new_virtual(struct page *page)
+static inline unsigned long map_new_virtual(struct page *page, int serie)
 {
 	unsigned long vaddr;
 	int count;
@@ -86,12 +103,12 @@
 	count = LAST_PKMAP;
 	/* Find an empty entry */
 	for (;;) {
-		last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
-		if (!last_pkmap_nr) {
-			flush_all_zero_pkmaps();
+		last_pkmap_nr[serie] = ((last_pkmap_nr[serie] + 1) & LAST_PKMAP_MASK) + serie * LAST_PKMAP;
+		if (!(last_pkmap_nr[serie] & LAST_PKMAP_MASK)) {
+			flush_all_zero_pkmaps(serie);
 			count = LAST_PKMAP;
 		}
-		if (!pkmap_count[last_pkmap_nr])
+		if (!pkmap_count[last_pkmap_nr[serie]])
 			break;	/* Found a usable entry */
 		if (--count)
 			continue;
@@ -103,10 +120,10 @@
 			DECLARE_WAITQUEUE(wait, current);
 
 			current->state = TASK_UNINTERRUPTIBLE;
-			add_wait_queue(&pkmap_map_wait, &wait);
+			add_wait_queue(&pkmap_map_wait[serie], &wait);
 			spin_unlock(&kmap_lock);
 			schedule();
-			remove_wait_queue(&pkmap_map_wait, &wait);
+			remove_wait_queue(&pkmap_map_wait[serie], &wait);
 			spin_lock(&kmap_lock);
 
 			/* Somebody else might have mapped it while we slept */
@@ -117,19 +134,23 @@
 			goto start;
 		}
 	}
-	vaddr = PKMAP_ADDR(last_pkmap_nr);
-	set_pte(&(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));
+	vaddr = PKMAP_ADDR(last_pkmap_nr[serie]);
+	set_pte(&(pkmap_page_table[last_pkmap_nr[serie]]), mk_pte(page, kmap_prot));
 
-	pkmap_count[last_pkmap_nr] = 1;
+	pkmap_count[last_pkmap_nr[serie]] = 1;
 	page->virtual = (void *) vaddr;
 
 	return vaddr;
 }
 
-void *kmap_high(struct page *page)
+void *kmap_high(struct page *page, int serie)
 {
 	unsigned long vaddr;
 
+#if HIGHMEM_DEBUG
+	if (!kmap_ready)
+		BUG();
+#endif
 	/*
 	 * For highmem pages, we can't trust "virtual" until
 	 * after we have the lock.
@@ -139,7 +160,7 @@
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;
 	if (!vaddr)
-		vaddr = map_new_virtual(page);
+		vaddr = map_new_virtual(page, serie);
 	pkmap_count[PKMAP_NR(vaddr)]++;
 	if (pkmap_count[PKMAP_NR(vaddr)] < 2)
 		BUG();
@@ -147,23 +168,22 @@
 	return (void*) vaddr;
 }
 
-void kunmap_high(struct page *page)
+void kunmap_high(void * vaddr)
 {
-	unsigned long vaddr;
 	unsigned long nr;
-	int need_wakeup;
+	int need_wakeup, serie;
 
-	spin_lock(&kmap_lock);
-	vaddr = (unsigned long) page->virtual;
 	if (!vaddr)
 		BUG();
-	nr = PKMAP_NR(vaddr);
+	nr = PKMAP_NR((unsigned long) vaddr);
+	serie = nr / LAST_PKMAP;
 
 	/*
 	 * A count must never go down to zero
 	 * without a TLB flush!
 	 */
 	need_wakeup = 0;
+	spin_lock(&kmap_lock);
 	switch (--pkmap_count[nr]) {
 	case 0:
 		BUG();
@@ -178,13 +198,13 @@
 		 * no need for the wait-queue-head's lock.  Simply
 		 * test if the queue is empty.
 		 */
-		need_wakeup = waitqueue_active(&pkmap_map_wait);
+		need_wakeup = waitqueue_active(&pkmap_map_wait[serie]);
 	}
 	spin_unlock(&kmap_lock);
 
 	/* do wake-up, if needed, race-free outside of the spin lock */
 	if (need_wakeup)
-		wake_up(&pkmap_map_wait);
+		wake_up(&pkmap_map_wait[serie]);
 }
 
 #define POOL_SIZE 32
diff -urN 2.4.18pre2aa2/mm/memory.c pte-5/mm/memory.c
--- 2.4.18pre2aa2/mm/memory.c	Wed Jan 16 17:52:20 2002
+++ pte-5/mm/memory.c	Wed Jan 16 17:52:49 2002
@@ -90,7 +90,7 @@
  */
 static inline void free_one_pmd(pmd_t * dir)
 {
-	pte_t * pte;
+	pmd_t pmd;
 
 	if (pmd_none(*dir))
 		return;
@@ -99,9 +99,9 @@
 		pmd_clear(dir);
 		return;
 	}
-	pte = pte_offset(dir, 0);
+	pmd = *dir;
 	pmd_clear(dir);
-	pte_free(pte);
+	pte_free_via_pmd(pmd);
 }
 
 static inline void free_one_pgd(pgd_t * dir)
@@ -221,10 +221,10 @@
 				goto cont_copy_pmd_range;
 			}
 
-			src_pte = pte_offset(src_pmd, address);
 			dst_pte = pte_alloc(dst, dst_pmd, address);
 			if (!dst_pte)
 				goto nomem;
+			src_pte = pte_offset2(src_pmd, address);
 
 			spin_lock(&src->page_table_lock);			
 			do {
@@ -259,13 +259,19 @@
 
 cont_copy_pte_range:		set_pte(dst_pte, pte);
 cont_copy_pte_range_noset:	address += PAGE_SIZE;
-				if (address >= end)
+				if (address >= end) {
+					pte_kunmap(src_pte);
+					pte_kunmap(dst_pte);
 					goto out_unlock;
+				}
 				src_pte++;
 				dst_pte++;
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
 			spin_unlock(&src->page_table_lock);
-		
+
+			pte_kunmap((src_pte - 1));
+			pte_kunmap((dst_pte - 1));
+
 cont_copy_pmd_range:	src_pmd++;
 			dst_pmd++;
 		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
@@ -292,7 +298,7 @@
 static inline int zap_pte_range(mmu_gather_t *tlb, pmd_t * pmd, unsigned long address, unsigned long size)
 {
 	unsigned long offset;
-	pte_t * ptep;
+	pte_t * ptep, * ptep_orig;
 	int freed = 0;
 
 	if (pmd_none(*pmd))
@@ -302,7 +308,7 @@
 		pmd_clear(pmd);
 		return 0;
 	}
-	ptep = pte_offset(pmd, address);
+	ptep_orig = ptep = pte_offset_atomic(pmd, address);
 	offset = address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size = PMD_SIZE - offset;
@@ -322,6 +328,7 @@
 			pte_clear(ptep);
 		}
 	}
+	pte_kunmap(ptep_orig);
 
 	return freed;
 }
@@ -414,11 +421,10 @@
 	if (pmd_none(*pmd) || pmd_bad(*pmd))
 		goto out;
 
-	ptep = pte_offset(pmd, address);
-	if (!ptep)
-		goto out;
+	ptep = pte_offset_atomic(pmd, address);
 
 	pte = *ptep;
+	pte_kunmap(ptep);
 	if (pte_present(pte)) {
 		if (!write ||
 		    (pte_write(pte) && pte_dirty(pte)))
@@ -751,6 +757,7 @@
 		if (!pte)
 			return -ENOMEM;
 		zeromap_pte_range(pte, address, end - address, prot);
+		pte_kunmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -831,6 +838,7 @@
 		if (!pte)
 			return -ENOMEM;
 		remap_pte_range(pte, address, end - address, address + phys_addr, prot);
+		pte_kunmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -1355,8 +1363,11 @@
 
 	if (pmd) {
 		pte_t * pte = pte_alloc(mm, pmd, address);
-		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte);
+		if (pte) {
+			int ret = handle_pte_fault(mm, vma, address, write_access, pte);
+			pte_kunmap(pte);
+			return ret;
+		}
 	}
 	spin_unlock(&mm->page_table_lock);
 	return -1;
@@ -1399,6 +1410,16 @@
 	return pmd_offset(pgd, address);
 }
 
+static inline struct page * pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page * page;
+
+	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
+	if (page)
+		clear_highpage(page);
+	return page;
+}
+
 /*
  * Allocate the page table directory.
  *
@@ -1407,16 +1428,18 @@
  */
 pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
+	pte_t * pte;
+
 	if (pmd_none(*pmd)) {
-		pte_t *new;
+		struct page * page;
 
 		/* "fast" allocation can happen without dropping the lock.. */
-		new = pte_alloc_one_fast(mm, address);
-		if (!new) {
+		page = pte_alloc_one_fast(mm, address);
+		if (!page) {
 			spin_unlock(&mm->page_table_lock);
-			new = pte_alloc_one(mm, address);
+			page = pte_alloc_one(mm, address);
 			spin_lock(&mm->page_table_lock);
-			if (!new)
+			if (unlikely(!page))
 				return NULL;
 
 			/*
@@ -1424,15 +1447,16 @@
 			 * entry, as somebody else could have populated it..
 			 */
 			if (!pmd_none(*pmd)) {
-				pte_free(new);
+				pte_free(page);
 				check_pgt_cache();
 				goto out;
 			}
 		}
-		pmd_populate(mm, pmd, new);
+		pmd_populate(mm, pmd, page);
 	}
 out:
-	return pte_offset(pmd, address);
+	pte = pte_offset_under_lock(pmd, address, mm);
+	return pte;
 }
 
 int make_pages_present(unsigned long addr, unsigned long end)
diff -urN 2.4.18pre2aa2/mm/mprotect.c pte-5/mm/mprotect.c
--- 2.4.18pre2aa2/mm/mprotect.c	Tue Sep 18 00:30:23 2001
+++ pte-5/mm/mprotect.c	Wed Jan 16 17:52:49 2002
@@ -15,7 +15,7 @@
 static inline void change_pte_range(pmd_t * pmd, unsigned long address,
 	unsigned long size, pgprot_t newprot)
 {
-	pte_t * pte;
+	pte_t * pte, * pte_orig;
 	unsigned long end;
 
 	if (pmd_none(*pmd))
@@ -25,7 +25,7 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset(pmd, address);
+	pte_orig = pte = pte_offset_atomic(pmd, address);
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -44,6 +44,7 @@
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_kunmap(pte_orig);
 }
 
 static inline void change_pmd_range(pgd_t * pgd, unsigned long address,
diff -urN 2.4.18pre2aa2/mm/mremap.c pte-5/mm/mremap.c
--- 2.4.18pre2aa2/mm/mremap.c	Fri Sep 21 05:31:26 2001
+++ pte-5/mm/mremap.c	Wed Jan 16 17:52:49 2002
@@ -39,9 +39,11 @@
 		goto end;
 	}
 
-	pte = pte_offset(pmd, addr);
-	if (pte_none(*pte))
+	pte = pte_offset_under_lock(pmd, addr, mm);
+	if (pte_none(*pte)) {
+		pte_kunmap(pte);
 		pte = NULL;
+	}
 end:
 	return pte;
 }
@@ -61,6 +63,7 @@
 {
 	int error = 0;
 	pte_t pte;
+	int need_kunmap_dst = 1;
 
 	if (!pte_none(*src)) {
 		pte = ptep_get_and_clear(src);
@@ -68,9 +71,12 @@
 			/* No dest?  We must put it back. */
 			dst = src;
 			error++;
+			need_kunmap_dst = 0;
 		}
 		set_pte(dst, pte);
 	}
+	if (need_kunmap_dst)
+		pte_kunmap(dst);
 	return error;
 }
 
@@ -81,8 +87,10 @@
 
 	spin_lock(&mm->page_table_lock);
 	src = get_one_pte(mm, old_addr);
-	if (src)
+	if (src) {
 		error = copy_one_pte(mm, src, alloc_one_pte(mm, new_addr));
+		pte_kunmap(src);
+	}
 	spin_unlock(&mm->page_table_lock);
 	return error;
 }
diff -urN 2.4.18pre2aa2/mm/swapfile.c pte-5/mm/swapfile.c
--- 2.4.18pre2aa2/mm/swapfile.c	Wed Jan 16 17:52:20 2002
+++ pte-5/mm/swapfile.c	Wed Jan 16 17:52:49 2002
@@ -402,7 +402,7 @@
 	unsigned long address, unsigned long size, unsigned long offset,
 	swp_entry_t entry, struct page* page)
 {
-	pte_t * pte;
+	pte_t * pte, * pte_orig;
 	unsigned long end;
 
 	if (pmd_none(*dir))
@@ -412,7 +412,7 @@
 		pmd_clear(dir);
 		return;
 	}
-	pte = pte_offset(dir, address);
+	pte_orig = pte = pte_offset_atomic(dir, address);
 	offset += address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
@@ -423,6 +423,7 @@
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_kunmap(pte_orig);
 }
 
 /* mmlist_lock and vma->vm_mm->page_table_lock are held */
diff -urN 2.4.18pre2aa2/mm/vmalloc.c pte-5/mm/vmalloc.c
--- 2.4.18pre2aa2/mm/vmalloc.c	Wed Jan 16 17:52:20 2002
+++ pte-5/mm/vmalloc.c	Wed Jan 16 17:52:49 2002
@@ -21,7 +21,7 @@
 
 static inline void free_area_pte(pmd_t * pmd, unsigned long address, unsigned long size)
 {
-	pte_t * pte;
+	pte_t * pte, * pte_orig;
 	unsigned long end;
 
 	if (pmd_none(*pmd))
@@ -31,7 +31,7 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte = pte_offset(pmd, address);
+	pte_orig = pte = pte_offset_atomic(pmd, address);
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -51,6 +51,7 @@
 		}
 		printk(KERN_CRIT "Whee.. Swapped out page in kernel page table\n");
 	} while (address < end);
+	pte_kunmap(pte_orig);
 }
 
 static inline void free_area_pmd(pgd_t * dir, unsigned long address, unsigned long size)
@@ -126,10 +127,13 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
+		int err;
 		pte_t * pte = pte_alloc(&init_mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
-		if (alloc_area_pte(pte, address, end - address, gfp_mask, prot))
+		err = alloc_area_pte(pte, address, end - address, gfp_mask, prot);
+		pte_kunmap(pte);
+		if (err)
 			return -ENOMEM;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;

--DBIVS5p969aUjpLe--
