Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316803AbSE1PS1>; Tue, 28 May 2002 11:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSE1PS0>; Tue, 28 May 2002 11:18:26 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:24325 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316803AbSE1PSX>; Tue, 28 May 2002 11:18:23 -0400
Date: Tue, 28 May 2002 19:17:53 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: [patch] Re: kernel 2.5.18 on alpha
Message-ID: <20020528191753.A5254@jurassic.park.msu.ru>
In-Reply-To: <1022593339.21314.63.camel@sake> <000901c20654$0e215440$010b10ac@sbp.uptime.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 04:29:15PM +0200, Oliver Pitzeier wrote:
> I get this error when trying to compile kernel 2.5.18 on alpha.

Just intended to post the patch... :-)

- sync up with new pte/pfn/page/tlb macros
- pcibios_init() should return int;
- find last bit set: ctlz for ev67 and above, generic for others.

> /root/linux-2.5.18/include/linux/suspend.h:4:25: asm/suspend.h: No such
> file or directory

I'm not sure what to do with this. I doubt that we ever want this
file on alpha. For myself I moved "#include <asm/suspend.h>"
under #ifdef CONFIG_SOFTWARE_SUSPEND and everything compiles.

Ivan.

--- 2.5.18/arch/alpha/kernel/signal.c	Sat May 25 05:55:26 2002
+++ linux/arch/alpha/kernel/signal.c	Mon May 27 16:06:22 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
+#include <linux/binfmts.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
--- 2.5.18/arch/alpha/kernel/osf_sys.c	Sat May 25 05:55:16 2002
+++ linux/arch/alpha/kernel/osf_sys.c	Mon May 27 16:06:22 2002
@@ -33,6 +33,7 @@
 #include <linux/file.h>
 #include <linux/types.h>
 #include <linux/ipc.h>
+#include <linux/namei.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
--- 2.5.18/arch/alpha/kernel/pci.c	Sat May 25 05:55:19 2002
+++ linux/arch/alpha/kernel/pci.c	Mon May 27 17:07:15 2002
@@ -193,12 +193,12 @@ pcibios_align_resource(void *data, struc
 #undef MB
 #undef GB
 
-static void __init
+static int __init
 pcibios_init(void)
 {
-	if (!alpha_mv.init_pci)
-		return;
-	alpha_mv.init_pci();
+	if (alpha_mv.init_pci)
+		alpha_mv.init_pci();
+	return 0;
 }
 
 subsys_initcall(pcibios_init);
--- 2.5.18/include/asm-alpha/page.h	Sat May 25 05:55:29 2002
+++ linux/include/asm-alpha/page.h	Mon May 27 16:27:39 2002
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
--- 2.5.18/include/asm-alpha/pgtable.h	Sat May 25 05:55:22 2002
+++ linux/include/asm-alpha/pgtable.h	Mon May 27 16:27:39 2002
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
--- 2.5.18/include/asm-alpha/tlb.h	Sat May 25 05:55:25 2002
+++ linux/include/asm-alpha/tlb.h	Mon May 27 16:06:22 2002
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
--- 2.5.18/include/asm-alpha/bitops.h	Sat May 25 05:55:27 2002
+++ linux/include/asm-alpha/bitops.h	Mon May 27 16:27:39 2002
@@ -315,6 +315,20 @@ static inline int ffs(int word)
 	return word ? result+1 : 0;
 }
 
+/*
+ * fls: find last bit set.
+ */
+#if defined(__alpha_cix__) && defined(__alpha_fix__)
+static inline int fls(int word)
+{
+	long result;
+	__asm__("ctlz %1,%0" : "=r"(result) : "r"(word & 0xffffffff));
+	return 64 - result;
+}
+#else
+#define fls	generic_fls
+#endif
+
 /* Compute powers of two for the given integer.  */
 static inline int floor_log2(unsigned long word)
 {
