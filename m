Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbTEKKVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTEKKVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:21:48 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:296 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261220AbTEKKV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:29 -0400
Date: Sun, 11 May 2003 12:30:58 +0200
Message-Id: <200305111030.h4BAUwH9019664@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k pte_file
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add pte_file() for Motorola MMUs (from Roman Zippel):
  - Add support for file file offsets in pte's (recycle unused _PAGE_COW bit)
  - Move swap macros into the mmu specific header
  - Fix swap macros (lowest two bits must be cleared)

--- linux-2.5.x/include/asm-m68k/motorola_pgtable.h	24 Jul 2002 21:46:05 -0000	1.1.1.2
+++ linux-m68k-2.5.x/include/asm-m68k/motorola_pgtable.h	26 Mar 2003 02:18:30 -0000
@@ -14,7 +14,7 @@
 #define _PAGE_SUPER	0x080	/* 68040 supervisor only */
 #define _PAGE_FAKE_SUPER 0x200	/* fake supervisor only on 680[23]0 */
 #define _PAGE_GLOBAL040	0x400	/* 68040 global bit, used for kva descs */
-#define _PAGE_COW	0x800	/* implemented in software */
+#define _PAGE_FILE	0x800	/* pagecache or swap? */
 #define _PAGE_NOCACHE030 0x040	/* 68030 no-cache mode */
 #define _PAGE_NOCACHE	0x060	/* 68040 cache mode, non-serialized */
 #define _PAGE_NOCACHE_S	0x040	/* 68040 no-cache mode, serialized */
@@ -159,6 +159,7 @@
 extern inline int pte_exec(pte_t pte)		{ return 1; }
 extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
+static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 
 extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
 extern inline pte_t pte_rdprotect(pte_t pte)	{ return pte; }
@@ -255,6 +256,25 @@
 	}
 }
 
+#define PTE_FILE_MAX_BITS	29
+
+static inline unsigned long pte_to_pgoff(pte_t pte)
+{
+	return ((pte.pte >> 12) << 7) + ((pte.pte >> 2) & 0x1ff);
+}
+
+static inline pte_t pgoff_to_pte(inline unsigned off)
+{
+	pte_t pte = { ((off >> 7) << 12) + ((off & 0x1ff) << 2) + _PAGE_FILE };
+	return pte;
+}
+
+/* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
+#define __swp_type(x)		(((x).val >> 2) & 0x1ff)
+#define __swp_offset(x)		((x).val >> 12)
+#define __swp_entry(type, offset) ((swp_entry_t) { ((type) << 2) | ((offset) << 12) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #endif	/* !__ASSEMBLY__ */
 #endif /* _MOTOROLA_PGTABLE_H */
--- linux-2.5.x/include/asm-m68k/pgtable.h	16 Sep 2002 18:05:07 -0000	1.1.1.5
+++ linux-m68k-2.5.x/include/asm-m68k/pgtable.h	26 Mar 2003 02:18:31 -0000
@@ -136,25 +136,6 @@
 {
 }
 
-#ifdef CONFIG_SUN3
-/* Macros to (de)construct the fake PTEs representing swap pages. */
-#define __swp_type(x)		((x).val & 0x7F)
-#define __swp_offset(x)		(((x).val) >> 7)
-#define __swp_entry(type,offset) ((swp_entry_t) { ((type) | ((offset) << 7)) })
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
-
-#else
-
-/* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
-#define __swp_type(x)		(((x).val >> 1) & 0xff)
-#define __swp_offset(x)		((x).val >> 10)
-#define __swp_entry(type, offset) ((swp_entry_t) { ((type) << 1) | ((offset) << 10) })
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
-
-#endif /* CONFIG_SUN3 */
-
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)	(1)
--- linux-2.5.x/include/asm-m68k/sun3_pgtable.h	18 Mar 2003 18:31:03 -0000	1.1.1.3
+++ linux-m68k-2.5.x/include/asm-m68k/sun3_pgtable.h	26 Mar 2003 02:18:31 -0000
@@ -204,6 +204,12 @@
 #define pte_unmap(pte) kunmap(pte)
 #define pte_unmap_nested(pte) kunmap(pte)
 
+/* Macros to (de)construct the fake PTEs representing swap pages. */
+#define __swp_type(x)		((x).val & 0x7F)
+#define __swp_offset(x)		(((x).val) >> 7)
+#define __swp_entry(type,offset) ((swp_entry_t) { ((type) | ((offset) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
 #endif	/* !__ASSEMBLY__ */
 #endif	/* !_SUN3_PGTABLE_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
