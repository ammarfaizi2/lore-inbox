Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272511AbTGZOlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272528AbTGZOkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:40:42 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:54807 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272531AbTGZOcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:51 -0400
Date: Sat, 26 Jul 2003 16:51:59 +0200
Message-Id: <200307261451.h6QEpxOT002472@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Sun-3 pte_file
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3: pte_file fixes for sun-3 MMUs (from Sam Creasey)

--- linux-2.6.x/include/asm-m68k/sun3_pgtable.h	Tue May 27 19:03:41 2003
+++ linux-m68k-2.6.x/include/asm-m68k/sun3_pgtable.h	Fri Jul 18 16:24:45 2003
@@ -38,6 +38,8 @@
 #define _PAGE_PRESENT	(SUN3_PAGE_VALID)
 #define _PAGE_ACCESSED	(SUN3_PAGE_ACCESSED)
 
+#define PTE_FILE_MAX_BITS 28
+
 /* Compound page protection values. */
 //todo: work out which ones *should* have SUN3_PAGE_NOCACHE and fix...
 // is it just PAGE_KERNEL and PAGE_SHARED?
@@ -160,6 +162,7 @@
 extern inline int pte_exec(pte_t pte)		{ return 1; }
 extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_MODIFIED; }
 extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
+extern inline int pte_file(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
 
 extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
 extern inline pte_t pte_rdprotect(pte_t pte)	{ return pte; }
@@ -194,6 +197,18 @@
 {
 	return (pmd_t *) pgd;
 }
+
+static inline unsigned long pte_to_pgoff(pte_t pte)
+{
+	return pte.pte & SUN3_PAGE_PGNUM_MASK;
+}
+
+static inline pte_t pgoff_to_pte(inline unsigned off)
+{
+	pte_t pte = { off + SUN3_PAGE_ACCESSED };
+	return pte;
+}
+
 
 /* Find an entry in the third-level pagetable. */
 #define pte_index(address) ((address >> PAGE_SHIFT) & (PTRS_PER_PTE-1))

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
