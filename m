Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbUCTKBo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbUCTKBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:01:42 -0500
Received: from ozlabs.org ([203.10.76.45]:50837 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263294AbUCTJ7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:59:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16476.5497.262639.401553@cargo.ozlabs.ibm.com>
Date: Sat, 20 Mar 2004 20:57:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix 2.6.5-rc1-mm2 on ppc64
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch makes the necessary pte_to_pgprot/pgoff_prot_to_pte changes
for -mm2 to compile and run on ppc64.

Paul.

diff -urN linux-2.6.5-rc1-mm2/include/asm-ppc64/mman.h mm2-g5/include/asm-ppc64/mman.h
--- linux-2.6.5-rc1-mm2/include/asm-ppc64/mman.h	2004-03-20 15:32:12.000000000 +1100
+++ mm2-g5/include/asm-ppc64/mman.h	2004-03-20 19:59:35.000000000 +1100
@@ -38,6 +38,7 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_INHERIT	0x20000		/* inherit prot of underlying vma */
 
 #define MADV_NORMAL	0x0		/* default page-in behavior */
 #define MADV_RANDOM	0x1		/* page-in minimum required */
diff -urN linux-2.6.5-rc1-mm2/include/asm-ppc64/pgtable.h mm2-g5/include/asm-ppc64/pgtable.h
--- linux-2.6.5-rc1-mm2/include/asm-ppc64/pgtable.h	2004-03-20 15:34:10.000000000 +1100
+++ mm2-g5/include/asm-ppc64/pgtable.h	2004-03-20 20:05:28.000000000 +1100
@@ -79,8 +79,8 @@
  */
 #define _PAGE_PRESENT	0x0001 /* software: pte contains a translation */
 #define _PAGE_USER	0x0002 /* matches one of the PP bits */
-#define _PAGE_FILE	0x0002 /* (!present only) software: pte holds file offset */
 #define _PAGE_RW	0x0004 /* software: user write access allowed */
+#define _PAGE_FILE	0x0008 /* !present: pte holds file offset */
 #define _PAGE_GUARDED	0x0008
 #define _PAGE_COHERENT	0x0010 /* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x0020 /* I: cache inhibit */
@@ -458,9 +458,15 @@
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
