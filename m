Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUC1Lga (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUC1Leh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:34:37 -0500
Received: from ozlabs.org ([203.10.76.45]:48054 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261170AbUC1LeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:34:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16486.43467.213263.396577@cargo.ozlabs.ibm.com>
Date: Sun, 28 Mar 2004 20:32:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32 pgtable.h fixes for -mm4
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried -mm4 on a ppc32 box, it hit a BUG because I hadn't
excluded _PAGE_FILE from the bits used for swap entries.  While
looking at that I realised that the pte_to_pgoff and pgoff_prot_to_pte
macros were wrong for 4xx and 8xx (embedded) PPC chips, since they use
different bit assignments in the PTEs.  This patch fixes it.

Paul.

diff -urN linux-2.6.5-rc2-mm4.orig/include/asm-ppc/pgtable.h linux-2.6.5-rc2-mm4/include/asm-ppc/pgtable.h
--- linux-2.6.5-rc2-mm4.orig/include/asm-ppc/pgtable.h	2004-03-28 15:46:23.683990296 +1000
+++ linux-2.6.5-rc2-mm4/include/asm-ppc/pgtable.h	2004-03-28 18:55:48.032948368 +1000
@@ -202,6 +202,7 @@
  */
 #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
 #define	_PAGE_RW	0x00000002		/* S: Write permission */
+#define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
 #define	_PAGE_DIRTY	0x00000004		/* S: Page dirty */
 #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
 #define _PAGE_HWWRITE	0x00000010		/* H: Dirty & RW */
@@ -210,7 +211,6 @@
 #define	_PAGE_ENDIAN	0x00000080		/* H: E bit */
 #define	_PAGE_GUARDED	0x00000100		/* H: G bit */
 #define	_PAGE_COHERENT	0x00000200		/* H: M bit */
-#define _PAGE_FILE	0x00000400		/* S: nonlinear file mapping */
 #define	_PAGE_NO_CACHE	0x00000400		/* H: I bit */
 #define	_PAGE_WRITETHRU	0x00000800		/* H: W bit */
 
@@ -624,20 +624,50 @@
 #define __swp_type(entry)		((entry).val & 0x1f)
 #define __swp_offset(entry)		((entry).val >> 5)
 #define __swp_entry(type, offset)	((swp_entry_t) { (type) | ((offset) << 5) })
+
+#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
+/* _PAGE_FILE and _PAGE_PRESENT are in the bottom 3 bits on all these chips. */
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
+#else	/* Classic PPC */
+#define __pte_to_swp_entry(pte)		\
+    ((swp_entry_t) { ((pte_val(pte) >> 3) & ~1) | ((pte_val(pte) >> 2) & 1) })
+#define __swp_entry_to_pte(x)		\
+    ((pte_t) { (((x).val & ~1) << 3) | (((x).val & 1) << 2) })
+#endif
 
 /* Encode and decode a nonlinear file mapping entry */
-#define PTE_FILE_MAX_BITS	27
-#define pte_to_pgoff(pte)	(((pte_val(pte) & ~0x7ff) >> 5)		\
-				 | ((pte_val(pte) & 0x3f0) >> 4))
-#define pte_to_pgprot(pte)	\
-__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT)) | _PAGE_ACCESSED)
+/* We can't use any the _PAGE_PRESENT, _PAGE_FILE, _PAGE_USER, _PAGE_RW,
+   or _PAGE_HASHPTE bits for storing a page offset. */
+#if defined(CONFIG_40x)
+/* 40x, avoid the 0x53 bits - to simplify things, avoid 0x73 */ */
+#define __pgoff_split(x)	((((x) << 5) & ~0x7f) | (((x) << 2) & 0xc))
+#define __pgoff_glue(x)		((((x) & ~0x7f) >> 5) | (((x) & 0xc) >> 2))
+#elif defined(CONFIG_44x)
+/* 44x, avoid the 0x47 bits */
+#define __pgoff_split(x)	((((x) << 4) & ~0x7f) | (((x) << 3) & 0x38))
+#define __pgoff_glue(x)		((((x) & ~0x7f) >> 4) | (((x) & 0x38) >> 3))
+#elif defined(CONFIG_8xx)
+/* 8xx, avoid the 0x843 bits */
+#define __pgoff_split(x)	((((x) << 4) & ~0xfff) | (((x) << 3) & 0x780) \
+				 | (((x) << 2) & 0x3c))
+#define __pgoff_glue(x)		((((x) & ~0xfff) >> 4) | (((x) & 0x780) >> 3))\
+				 | (((x) & 0x3c) >> 2))
+#else
+/* classic PPC, avoid the 0x40f bits */
+#define __pgoff_split(x)	((((x) << 5) & ~0x7ff) | (((x) << 4) & 0x3f0))
+#define __pgoff_glue(x)		((((x) & ~0x7ff) >> 5) | (((x) & 0x3f0) >> 4))
+#endif
 
+#define PTE_FILE_MAX_BITS	27
+#define pte_to_pgoff(pte)	__pgoff_glue(pte_val(pte))
 #define pgoff_prot_to_pte(off, prot)					\
-	((pte_t) { (((off) << 5) & ~0x7ff) | (((off) << 4) & 0x3f0)	\
-		   | (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW))		\
-		   | _PAGE_FILE })
+	((pte_t) { __pgoff_split(off) | _PAGE_FILE |			\
+		   (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW)) })
+
+#define pte_to_pgprot(pte)						\
+	__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT))	\
+		 | _PAGE_ACCESSED)
 
 /* CONFIG_APUS */
 /* For virtual address to physical address conversion */
