Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272538AbTGZOmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272516AbTGZOgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:36:16 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:37410 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272517AbTGZOcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:42 -0400
Date: Sat, 26 Jul 2003 16:51:50 +0200
Message-Id: <200307261451.h6QEpoPQ002388@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k page
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68k page updates (from Roman Zippel):
  - Set _PAGE_RONLY bit and clear _PAGE_PRESENT to mark PAGE_NONE pte entries
    (this also makes PAGE_NONE fixup unnecessary)
  - Move _PAGE_FILE to a lower, so pte_to_pgoff/pgoff_to_pte becomes simpler

--- linux-2.6.x/arch/m68k/mm/motorola.c	Tue Nov  5 10:09:42 2002
+++ linux-m68k-2.6.x/arch/m68k/mm/motorola.c	Thu Mar 27 10:58:38 2003
@@ -223,18 +223,6 @@
 		for (i = 0; i < 16; i++)
 			pgprot_val(protection_map[i]) |= _PAGE_CACHE040;
 	}
-	/* Fix the PAGE_NONE value. */
-	if (CPU_IS_040_OR_060) {
-		/* On the 680[46]0 we can use the _PAGE_SUPER bit.  */
-		pgprot_val(protection_map[0]) |= _PAGE_SUPER;
-		pgprot_val(protection_map[VM_SHARED]) |= _PAGE_SUPER;
-	} else {
-		/* Otherwise we must fake it. */
-		pgprot_val(protection_map[0]) &= ~_PAGE_PRESENT;
-		pgprot_val(protection_map[0]) |= _PAGE_FAKE_SUPER;
-		pgprot_val(protection_map[VM_SHARED]) &= ~_PAGE_PRESENT;
-		pgprot_val(protection_map[VM_SHARED]) |= _PAGE_FAKE_SUPER;
-	}
 
 	/*
 	 * Map the physical memory available into the kernel virtual
--- linux-2.6.x/include/asm-m68k/motorola_pgtable.h	Sun Apr 13 13:53:20 2003
+++ linux-m68k-2.6.x/include/asm-m68k/motorola_pgtable.h	Thu Mar 27 10:58:42 2003
@@ -12,9 +12,7 @@
 #define _PAGE_ACCESSED	0x008
 #define _PAGE_DIRTY	0x010
 #define _PAGE_SUPER	0x080	/* 68040 supervisor only */
-#define _PAGE_FAKE_SUPER 0x200	/* fake supervisor only on 680[23]0 */
 #define _PAGE_GLOBAL040	0x400	/* 68040 global bit, used for kva descs */
-#define _PAGE_FILE	0x800	/* pagecache or swap? */
 #define _PAGE_NOCACHE030 0x040	/* 68030 no-cache mode */
 #define _PAGE_NOCACHE	0x060	/* 68040 cache mode, non-serialized */
 #define _PAGE_NOCACHE_S	0x040	/* 68040 no-cache mode, serialized */
@@ -29,6 +27,9 @@
 #define _PAGE_TABLE	(_PAGE_SHORT)
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_NOCACHE)
 
+#define _PAGE_PROTNONE	0x004
+#define _PAGE_FILE	0x008	/* pagecache or swap? */
+
 #ifndef __ASSEMBLY__
 
 /* This is the cache mode to be used for pages containing page descriptors for
@@ -54,7 +55,7 @@
 extern unsigned long mm_cachebits;
 #endif
 
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED | mm_cachebits)
+#define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED | mm_cachebits)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | mm_cachebits)
 #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED | mm_cachebits)
 #define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED | mm_cachebits)
@@ -62,7 +63,7 @@
 
 /* Alternate definitions that are compile time constants, for
    initializing protection_map.  The cachebits are fixed later.  */
-#define PAGE_NONE_C	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)
+#define PAGE_NONE_C	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
 #define PAGE_SHARED_C	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
 #define PAGE_COPY_C	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)
 #define PAGE_READONLY_C	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)
@@ -118,7 +119,7 @@
 
 
 #define pte_none(pte)		(!pte_val(pte))
-#define pte_present(pte)	(pte_val(pte) & (_PAGE_PRESENT | _PAGE_FAKE_SUPER))
+#define pte_present(pte)	(pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROTNONE))
 #define pte_clear(ptep)		({ pte_val(*(ptep)) = 0; })
 
 #define pte_page(pte)		(mem_map + ((unsigned long)(__va(pte_val(pte)) - PAGE_OFFSET) >> PAGE_SHIFT))
@@ -256,23 +257,23 @@
 	}
 }
 
-#define PTE_FILE_MAX_BITS	29
+#define PTE_FILE_MAX_BITS	28
 
 static inline unsigned long pte_to_pgoff(pte_t pte)
 {
-	return ((pte.pte >> 12) << 7) + ((pte.pte >> 2) & 0x1ff);
+	return pte.pte >> 4;
 }
 
 static inline pte_t pgoff_to_pte(inline unsigned off)
 {
-	pte_t pte = { ((off >> 7) << 12) + ((off & 0x1ff) << 2) + _PAGE_FILE };
+	pte_t pte = { (off << 4) + _PAGE_FILE };
 	return pte;
 }
 
 /* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
-#define __swp_type(x)		(((x).val >> 2) & 0x1ff)
+#define __swp_type(x)		(((x).val >> 4) & 0xff)
 #define __swp_offset(x)		((x).val >> 12)
-#define __swp_entry(type, offset) ((swp_entry_t) { ((type) << 2) | ((offset) << 12) })
+#define __swp_entry(type, offset) ((swp_entry_t) { ((type) << 4) | ((offset) << 12) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
