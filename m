Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSHJPUZ>; Sat, 10 Aug 2002 11:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSHJPUY>; Sat, 10 Aug 2002 11:20:24 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:27918 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317017AbSHJPUX>; Sat, 10 Aug 2002 11:20:23 -0400
Date: Sat, 10 Aug 2002 19:23:44 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: pte/pfn/page/tlb macros update [1/10]
Message-ID: <20020810192344.A20505@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This starts a large set of alpha patches accumulated since 2.5.18 or
even earlier. All of this was reasonably well tested.
Thanks to Jeff Wiedemeier for SMP testing and fixes.

- sync up with (2.5.18?) pte/pfn/page/tlb etc. macros;
- asm-generic/tlb.h: loading unsigned long constant to unsigned int
  tlb->nr causes compiler warnings on 64 bit platforms.

Ivan.

--- 2.5.30/include/asm-alpha/page.h	Fri Aug  2 01:16:33 2002
+++ linux/include/asm-alpha/page.h	Thu Aug  8 19:28:01 2002
@@ -15,10 +15,10 @@
 #define STRICT_MM_TYPECHECKS
 
 extern void clear_page(void *page);
-#define clear_user_page(page, vaddr)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
 
 extern void copy_page(void * _to, void * _from);
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
@@ -95,8 +95,12 @@ extern __inline__ int get_order(unsigned
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 #ifndef CONFIG_DISCONTIGMEM
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #endif /* CONFIG_DISCONTIGMEM */
 
 #define VM_DATA_DEFAULT_FLAGS		(VM_READ | VM_WRITE | VM_EXEC | \
--- 2.5.30/include/asm-alpha/pgtable.h	Fri Aug  2 01:16:17 2002
+++ linux/include/asm-alpha/pgtable.h	Thu Aug  8 19:28:02 2002
@@ -179,11 +179,12 @@ extern unsigned long __zero_page(void);
 #endif
 #if defined(CONFIG_ALPHA_GENERIC) || \
     (defined(CONFIG_ALPHA_EV6) && !defined(USE_48_BIT_KSEG))
-#define PHYS_TWIDDLE(phys) \
-  ((((phys) & 0xc0000000000UL) == 0x40000000000UL) \
-  ? ((phys) ^= 0xc0000000000UL) : (phys))
+#define KSEG_PFN	(0xc0000000000UL >> PAGE_SHIFT)
+#define PHYS_TWIDDLE(pfn) \
+  ((((pfn) & KSEG_PFN) == (0x40000000000UL >> PAGE_SHIFT)) \
+  ? ((pfn) ^= KSEG_PFN) : (pfn))
 #else
-#define PHYS_TWIDDLE(phys) (phys)
+#define PHYS_TWIDDLE(pfn) (pfn)
 #endif
 
 /*
@@ -199,12 +200,13 @@ extern unsigned long __zero_page(void);
 #endif
 
 #ifndef CONFIG_DISCONTIGMEM
+#define pte_pfn(pte)	(pte_val(pte) >> 32)
+#define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 #define mk_pte(page, pgprot)						\
 ({									\
 	pte_t pte;							\
 									\
-	pte_val(pte) = ((unsigned long)(page - mem_map) << 32) |	\
-		       pgprot_val(pgprot);				\
+	pte_val(pte) = (page_to_pfn(page) << 32) | pgprot_val(pgprot);	\
 	pte;								\
 })
 #else
@@ -219,10 +221,20 @@ extern unsigned long __zero_page(void);
 										\
 	pte;									\
 })
+#define pte_page(x)							\
+({									\
+	unsigned long kvirt;						\
+	struct page * __xx;						\
+									\
+	kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\
+	__xx = virt_to_page(kvirt);					\
+									\
+	__xx;								\
+})
 #endif
 
-extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
-{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpage) << (32-PAGE_SHIFT)) | pgprot_val(pgprot); return pte; }
+extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)
+{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpfn) << 32) | pgprot_val(pgprot); return pte; }
 
 extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot); return pte; }
@@ -233,20 +245,6 @@ extern inline void pmd_set(pmd_t * pmdp,
 extern inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
 { pgd_val(*pgdp) = _PAGE_TABLE | ((((unsigned long) pmdp) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
 
-#ifndef CONFIG_DISCONTIGMEM
-#define pte_page(x)	(mem_map+(unsigned long)((pte_val(x) >> 32)))
-#else
-#define pte_page(x)							\
-({									\
-	unsigned long kvirt;						\
-	struct page * __xx;						\
-									\
-	kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\
-	__xx = virt_to_page(kvirt);					\
-									\
-	__xx;								\
-})
-#endif
 
 extern inline unsigned long
 pmd_page_kernel(pmd_t pmd)
--- 2.5.30/include/asm-alpha/system.h	Fri Aug  2 01:16:28 2002
+++ linux/include/asm-alpha/system.h	Thu Aug  8 19:28:02 2002
@@ -130,8 +130,10 @@ struct el_common_EV6_mcheck {
 extern void halt(void) __attribute__((noreturn));
 #define __halt() __asm__ __volatile__ ("call_pal %0 #halt" : : "i" (PAL_halt))
 
-#define prepare_to_switch()	do { } while(0)
-#define switch_to(prev,next)						  \
+#define prepare_arch_schedule(prev)		do { } while(0)
+#define finish_arch_schedule(prev)		do { } while(0)
+
+#define switch_to(prev,next,last)						  \
 do {									  \
 	alpha_switch_to(virt_to_phys(&(next)->thread_info->pcb), (prev)); \
 	check_mmu_context();						  \
--- 2.5.30/include/asm-alpha/tlb.h	Fri Aug  2 01:16:22 2002
+++ linux/include/asm-alpha/tlb.h	Thu Aug  8 19:28:02 2002
@@ -1 +1,15 @@
+#ifndef _ALPHA_TLB_H
+#define _ALPHA_TLB_H
+
+#define tlb_start_vma(tlb, vma)			do { } while (0)
+#define tlb_end_vma(tlb, vma)			do { } while (0)
+#define tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)
+
+#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
+
 #include <asm-generic/tlb.h>
+
+#define pte_free_tlb(tlb,pte)			pte_free(pte)
+#define pmd_free_tlb(tlb,pmd)			pmd_free(pmd)
+ 
+#endif
--- 2.5.30/include/asm-generic/tlb.h	Fri Aug  2 01:15:59 2002
+++ linux/include/asm-generic/tlb.h	Thu Aug  8 19:28:01 2002
@@ -54,7 +54,7 @@ static inline mmu_gather_t *tlb_gather_m
 	tlb->mm = mm;
 
 	/* Use fast mode if only one CPU is online */
-	tlb->nr = num_online_cpus() > 1 ? 0UL : ~0UL;
+	tlb->nr = num_online_cpus() > 1 ? 0U : ~0U;
 
 	tlb->fullmm = full_mm_flush;
 	tlb->freed = 0;
