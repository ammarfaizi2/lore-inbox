Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSEHKzY>; Wed, 8 May 2002 06:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313012AbSEHKzX>; Wed, 8 May 2002 06:55:23 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:10757 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S312983AbSEHKzX>; Wed, 8 May 2002 06:55:23 -0400
Date: Wed, 8 May 2002 14:54:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: Richard Henderson <rth@twiddle.net>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Problems with mm on Alpha...
Message-ID: <20020508145454.A2394@jurassic.park.msu.ru>
In-Reply-To: <20020508113428.D31998@dualathlon.random> <003701c1f675$3d1c5cc0$010b10ac@sbp.uptime.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 11:46:28AM +0200, Oliver Pitzeier wrote:
> memory.c:80: warning: implicit declaration of function `pte_pfn'
> memory.c:81: warning: implicit declaration of function `pfn_valid'
> memory.c:83: warning: implicit declaration of function `pfn_to_page'

New pte/pfn/page macros are defined only for i386 as yet.
Patch appended. However, CONFIG_DISCONTIGMEM is still broken in 2.5.
I hope Andrea will take a look into this some day.

Ivan.

--- 2.5.14/include/asm-alpha/page.h	Fri May  3 04:22:55 2002
+++ linux/include/asm-alpha/page.h	Tue May  7 13:47:53 2002
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
--- 2.5.14/include/asm-alpha/pgtable.h	Fri May  3 04:22:46 2002
+++ linux/include/asm-alpha/pgtable.h	Wed May  8 14:44:22 2002
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
@@ -221,8 +223,8 @@ extern unsigned long __zero_page(void);
 })
 #endif
 
-extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
-{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpage) << (32-PAGE_SHIFT)) | pgprot_val(pgprot); return pte; }
+extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)
+{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpfn) << 32) | pgprot_val(pgprot); return pte; }
 
 extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot); return pte; }
