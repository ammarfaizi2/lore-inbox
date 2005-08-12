Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVHLStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVHLStt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVHLSt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:29 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:29607 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1751199AbVHLStT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:19 -0400
Subject: [patch 28/39] remap_file_pages protection support: sparc64 bits.
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       wli@holomorphy.com
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:08 +0200
Message-Id: <20050812183608.6AEB924E7D8@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: William Lee Irwin III <wli@holomorphy.com>

Implement remap_file_pages-with-per-page-protections for sparc64.

See

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch

and

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-sparc64/pgtable.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff -puN include/asm-sparc64/pgtable.h~rfp-arch-sparc64 include/asm-sparc64/pgtable.h
--- linux-2.6.git/include/asm-sparc64/pgtable.h~rfp-arch-sparc64	2005-08-12 18:41:31.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-sparc64/pgtable.h	2005-08-12 18:41:31.000000000 +0200
@@ -367,9 +367,16 @@ static inline pte_t mk_pte_io(unsigned l
 
 /* File offset in PTE support. */
 #define pte_file(pte)		(pte_val(pte) & _PAGE_FILE)
-#define pte_to_pgoff(pte)	(pte_val(pte) >> PAGE_SHIFT)
-#define pgoff_to_pte(off)	(__pte(((off) << PAGE_SHIFT) | _PAGE_FILE))
-#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 1UL)
+#define __pte_to_pgprot(pte) \
+		__pgprot(pte_val(pte) & (_PAGE_READ|_PAGE_WRITE))
+#define __file_pte_to_pgprot(pte) \
+		__pgprot(((pte_val(pte) >> PAGE_SHIFT) & 0x3UL) << 8)
+#define pte_to_pgprot(pte) \
+	(pte_file(pte) ? __file_pte_to_pgprot(pte) : __pte_to_pgprot(pte))
+#define pte_to_pgoff(pte)	(pte_val(pte) >> (PAGE_SHIFT+2))
+#define pgoff_prot_to_pte(off, prot) \
+	((__pte(((off) | ((pgprot_val(prot) >> 8) & 0x3UL)))) << (PAGE_SHIFT+2) | _PAGE_FILE)
+#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 3UL)
 
 extern unsigned long prom_virt_to_phys(unsigned long, int *);
 
_
