Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVHLSwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVHLSwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVHLSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:52:21 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:9896 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1751230AbVHLSwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:52:04 -0400
Subject: [patch 29/39] remap_file_pages protection support: ppc64 bits
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       paulus@samba.org
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:10 +0200
Message-Id: <20050812183610.E9DE224E7DA@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Mackerras <paulus@samba.org>

ppc64 bits for remap_file_pages w/prot (no syscall table).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-ppc64/pgtable.h |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff -puN include/asm-ppc64/pgtable.h~rfp-arch-ppc64 include/asm-ppc64/pgtable.h
--- linux-2.6.git/include/asm-ppc64/pgtable.h~rfp-arch-ppc64	2005-08-12 18:42:20.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc64/pgtable.h	2005-08-12 18:42:20.000000000 +0200
@@ -62,8 +62,8 @@
  */
 #define _PAGE_PRESENT	0x0001 /* software: pte contains a translation */
 #define _PAGE_USER	0x0002 /* matches one of the PP bits */
-#define _PAGE_FILE	0x0002 /* (!present only) software: pte holds file offset */
 #define _PAGE_EXEC	0x0004 /* No execute on POWER4 and newer (we invert) */
+#define _PAGE_FILE	0x0008 /* !present: pte holds file offset */
 #define _PAGE_GUARDED	0x0008
 #define _PAGE_COHERENT	0x0010 /* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x0020 /* I: cache inhibit */
@@ -492,9 +492,15 @@ extern void update_mmu_cache(struct vm_a
 #define __swp_entry(type, offset) ((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) >> PTE_SHIFT })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val << PTE_SHIFT })
-#define pte_to_pgoff(pte)	(pte_val(pte) >> PTE_SHIFT)
-#define pgoff_to_pte(off)	((pte_t) {((off) << PTE_SHIFT)|_PAGE_FILE})
+
 #define PTE_FILE_MAX_BITS	(BITS_PER_LONG - PTE_SHIFT)
+#define pte_to_pgoff(pte)	(pte_val(pte) >> PTE_SHIFT)
+#define pte_to_pgprot(pte)	\
+__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot)					\
+	((pte_t) { ((off) << PTE_SHIFT) | _PAGE_FILE			\
+		   | (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW)) })
 
 /*
  * kern_addr_valid is intended to indicate whether an address is a valid
_
