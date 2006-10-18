Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWJRQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWJRQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWJRQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:26:42 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:60431 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422647AbWJRQ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:26:36 -0400
Date: Wed, 18 Oct 2006 18:26:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] Fix pte type checking.
Message-ID: <20061018162643.GE7158@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] Fix pte type checking.

handle_pte_fault uses pte_present, pte_none and pte_file to find out
the type of a pte. That is done without holding the page table lock.
This clashes with the way how ptep_clear_flush removes active page
table entries from the system. First the ipte instruction is used
to invalidate the pte and remove all plt entries for the page. The
ipte sets the hardware invalid bit without changing any other bit.
After the ipte finished the pte is cleared. A concurrent fault can
observe the the previously valid pte with the invalid bit set. With
the current encoding of the different pte types an invalidated
read-only pte can be misinterpreted as a swap-pte.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/pgtable.h |   50 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 40 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2006-10-18 17:12:41.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2006-10-18 17:12:56.000000000 +0200
@@ -200,18 +200,45 @@ extern char empty_zero_page[PAGE_SIZE];
  */
 
 /* Hardware bits in the page table entry */
-#define _PAGE_RO        0x200          /* HW read-only                     */
-#define _PAGE_INVALID   0x400          /* HW invalid                       */
+#define _PAGE_RO	0x200		/* HW read-only bit  */
+#define _PAGE_INVALID	0x400		/* HW invalid bit    */
+#define _PAGE_SWT	0x001		/* SW pte type bit t */
+#define _PAGE_SWX	0x002		/* SW pte type bit x */
 
-/* Mask and six different types of pages. */
-#define _PAGE_TYPE_MASK		0x601
+/* Six different types of pages. */
 #define _PAGE_TYPE_EMPTY	0x400
 #define _PAGE_TYPE_NONE		0x401
-#define _PAGE_TYPE_SWAP		0x600
-#define _PAGE_TYPE_FILE		0x601
+#define _PAGE_TYPE_SWAP		0x403
+#define _PAGE_TYPE_FILE		0x601	/* bit 0x002 is used for offset !! */
 #define _PAGE_TYPE_RO		0x200
 #define _PAGE_TYPE_RW		0x000
 
+/*
+ * PTE type bits are rather complicated. handle_pte_fault uses pte_present,
+ * pte_none and pte_file to find out the pte type WITHOUT holding the page
+ * table lock. ptep_clear_flush on the other hand uses ptep_clear_flush to
+ * invalidate a given pte. ipte sets the hw invalid bit and clears all tlbs
+ * for the page. The page table entry is set to _PAGE_TYPE_EMPTY afterwards.
+ * This change is done while holding the lock, but the intermediate step
+ * of a previously valid pte with the hw invalid bit set can be observed by
+ * handle_pte_fault. That makes it necessary that all valid pte types with
+ * the hw invalid bit set must be distinguishable from the four pte types
+ * empty, none, swap and file.
+ *
+ *			irxt  ipte  irxt
+ * _PAGE_TYPE_EMPTY	1000   ->   1000
+ * _PAGE_TYPE_NONE	1001   ->   1001
+ * _PAGE_TYPE_SWAP	1011   ->   1011
+ * _PAGE_TYPE_FILE	11?1   ->   11?1
+ * _PAGE_TYPE_RO	0100   ->   1100
+ * _PAGE_TYPE_RW	0000   ->   1000
+ *
+ * pte_none is true for bits combinations 1000, 1100
+ * pte_present is true for bits combinations 0000, 0010, 0100, 0110, 1001
+ * pte_file is true for bits combinations 1101, 1111
+ * swap pte is 1011 and 0001, 0011, 0101, 0111, 1010 and 1110 are invalid.
+ */
+
 #ifndef __s390x__
 
 /* Bits in the segment table entry */
@@ -365,18 +392,21 @@ static inline int pmd_bad(pmd_t pmd)
 
 static inline int pte_none(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_EMPTY;
+	return (pte_val(pte) & _PAGE_INVALID) && !(pte_val(pte) & _PAGE_SWT);
 }
 
 static inline int pte_present(pte_t pte)
 {
-	return !(pte_val(pte) & _PAGE_INVALID) ||
-		(pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_NONE;
+	unsigned long mask = _PAGE_RO | _PAGE_INVALID | _PAGE_SWT | _PAGE_SWX;
+	return (pte_val(pte) & mask) == _PAGE_TYPE_NONE ||
+		(!(pte_val(pte) & _PAGE_INVALID) &&
+		 !(pte_val(pte) & _PAGE_SWT));
 }
 
 static inline int pte_file(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_TYPE_MASK) == _PAGE_TYPE_FILE;
+	unsigned long mask = _PAGE_RO | _PAGE_INVALID | _PAGE_SWT;
+	return (pte_val(pte) & mask) == _PAGE_TYPE_FILE;
 }
 
 #define pte_same(a,b)	(pte_val(a) == pte_val(b))
