Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVDLU1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVDLU1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVDLUZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:25:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:10184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbVDLKbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:13 -0400
Message-Id: <200504121031.j3CAV9KJ005249@shell0.pdx.osdl.net>
Subject: [patch 032/198] ppc32: Fix pte_update for 64-bit PTEs
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, galak@freescale.com,
       kumar.gala@freescale.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kumar Gala <galak@freescale.com>

While the existing pte_update code handled atomically modifying a 64-bit PTE,
it did not return all 64-bits of the PTE before it was modified.  This causes
problems in some places that expect the full PTE to be returned, like
ptep_get_and_clear().

Created a new pte_update function that is conditional on CONFIG_PTE_64BIT.  It
atomically reads the low PTE word which all PTE flags are required to be in
and returns a premodified full 64-bit PTE.

Since we now have an explicit 64-bit PTE version of pte_update we can also
remove the hack that existed to get the low PTE word regardless of size.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-ppc/pgtable.h |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff -puN include/asm-ppc/pgtable.h~ppc32-fix-pte_update-for-64-bit-ptes include/asm-ppc/pgtable.h
--- 25/include/asm-ppc/pgtable.h~ppc32-fix-pte_update-for-64-bit-ptes	2005-04-12 03:21:11.143442840 -0700
+++ 25-akpm/include/asm-ppc/pgtable.h	2005-04-12 03:21:11.147442232 -0700
@@ -526,10 +526,10 @@ extern void add_hash_page(unsigned conte
  * Atomic PTE updates.
  *
  * pte_update clears and sets bit atomically, and returns
- * the old pte value.
- * The ((unsigned long)(p+1) - 4) hack is to get to the least-significant
- * 32 bits of the PTE regardless of whether PTEs are 32 or 64 bits.
+ * the old pte value.  In the 64-bit PTE case we lock around the
+ * low PTE word since we expect ALL flag bits to be there
  */
+#ifndef CONFIG_PTE_64BIT
 static inline unsigned long pte_update(pte_t *p, unsigned long clr,
 				       unsigned long set)
 {
@@ -543,10 +543,31 @@ static inline unsigned long pte_update(p
 "	stwcx.	%1,0,%3\n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
-	: "r" ((unsigned long)(p+1) - 4), "r" (clr), "r" (set), "m" (*p)
+	: "r" (p), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
 	return old;
 }
+#else
+static inline unsigned long long pte_update(pte_t *p, unsigned long clr,
+				       unsigned long set)
+{
+	unsigned long long old;
+	unsigned long tmp;
+
+	__asm__ __volatile__("\
+1:	lwarx	%L0,0,%4\n\
+	lwzx	%0,0,%3\n\
+	andc	%1,%L0,%5\n\
+	or	%1,%1,%6\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%1,0,%4\n\
+	bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*p)
+	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
+	: "cc" );
+	return old;
+}
+#endif
 
 /*
  * set_pte stores a linux PTE into the linux page table.
_
