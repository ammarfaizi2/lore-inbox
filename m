Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVHLSst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVHLSst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVHLSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:48:48 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:51916 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750933AbVHLSsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:48:47 -0400
Subject: [patch 26/39] remap_file_pages protection support: ppc32 bits
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       mingo@elte.hu
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:02 +0200
Message-Id: <20050812183603.0927F24E7D2@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

PPC32 bits of RFP - as in original patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-ppc/pgtable.h |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff -puN include/asm-ppc/pgtable.h~rfp-arch-ppc include/asm-ppc/pgtable.h
--- linux-2.6.git/include/asm-ppc/pgtable.h~rfp-arch-ppc	2005-08-12 18:18:43.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc/pgtable.h	2005-08-12 18:39:57.000000000 +0200
@@ -309,8 +309,8 @@ extern unsigned long ioremap_bot, iorema
 /* Definitions for 60x, 740/750, etc. */
 #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
 #define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
-#define _PAGE_FILE	0x004	/* when !present: nonlinear file mapping */
 #define _PAGE_USER	0x004	/* usermode access allowed */
+#define _PAGE_FILE	0x008	/* when !present: nonlinear file mapping */
 #define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
 #define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
@@ -728,9 +728,16 @@ extern void paging_init(void);
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
 /* Encode and decode a nonlinear file mapping entry */
-#define PTE_FILE_MAX_BITS	29
-#define pte_to_pgoff(pte)	(pte_val(pte) >> 3)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 3) | _PAGE_FILE })
+#define PTE_FILE_MAX_BITS	27
+#define pte_to_pgoff(pte)	(((pte_val(pte) & ~0x7ff) >> 5)		\
+				 | ((pte_val(pte) & 0x3f0) >> 4))
+#define pte_to_pgprot(pte)	\
+__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot)					\
+	((pte_t) { (((off) << 5) & ~0x7ff) | (((off) << 4) & 0x3f0)	\
+		   | (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW))		\
+		   | _PAGE_FILE })
 
 /* CONFIG_APUS */
 /* For virtual address to physical address conversion */
_
