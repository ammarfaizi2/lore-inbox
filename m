Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUDOBvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 21:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUDOBvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 21:51:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:2432 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262431AbUDOBvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 21:51:44 -0400
Subject: [PATCH] ppc64: Fix possible duplicate MMU hash entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081993642.2135.136.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 11:47:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The current code has a subtle race where 2 hash PTEs can be inserted
for the same virtual address for a short period of time. There should
not be a stale one as the "old" one ultimately gets flushed, but the
architecture specifies that having two hash PTE is illegal and can
result in undefined behaviour.

This patch fixes it by never clearing the _PAGE_HASHPTE bit when
doing test_and_clear_{young,dirty}. That means that subsequent faults
on those pages will have a bit more overhead to "discover" that the
hash entry was indeed evicted.

It also adds a small optisation to avoid doing the atomic operation
and the hash flush in test_and_clear_dirty when the page isn't dirty
or when setting write protect while it's already set.

Please, apply,
Ben.

--- 1.31/include/asm-ppc64/pgtable.h	Fri Feb 27 23:16:07 2004
+++ edited/include/asm-ppc64/pgtable.h	Thu Apr  8 17:30:57 2004
@@ -313,7 +313,9 @@
 {
 	unsigned long old;
 
-	old = pte_update(ptep, _PAGE_ACCESSED | _PAGE_HPTEFLAGS);
+       	if ((pte_val(*ptep) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pte_update(ptep, _PAGE_ACCESSED);
 	if (old & _PAGE_HASHPTE) {
 		hpte_update(ptep, old, 0);
 		flush_tlb_pending();	/* XXX generic code doesn't flush */
@@ -326,12 +328,13 @@
  * moment we always flush but we need to fix hpte_update and test if the
  * optimisation is worth it.
  */
-#if 1
 static inline int ptep_test_and_clear_dirty(pte_t *ptep)
 {
 	unsigned long old;
 
-	old = pte_update(ptep, _PAGE_DIRTY | _PAGE_HPTEFLAGS);
+       	if ((pte_val(*ptep) & _PAGE_DIRTY) == 0)
+		return 0;
+	old = pte_update(ptep, _PAGE_DIRTY);
 	if (old & _PAGE_HASHPTE)
 		hpte_update(ptep, old, 0);
 	return (old & _PAGE_DIRTY) != 0;
@@ -341,7 +344,9 @@
 {
 	unsigned long old;
 
-	old = pte_update(ptep, _PAGE_RW | _PAGE_HPTEFLAGS);
+       	if ((pte_val(*ptep) & _PAGE_RW) == 0)
+       		return;
+	old = pte_update(ptep, _PAGE_RW);
 	if (old & _PAGE_HASHPTE)
 		hpte_update(ptep, old, 0);
 }
@@ -358,7 +363,6 @@
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
 	int __young = ptep_test_and_clear_young(__ptep);		\
-	flush_tlb_page(__vma, __address);				\
 	__young;							\
 })
 
@@ -369,27 +373,6 @@
 	flush_tlb_page(__vma, __address);				\
 	__dirty;							\
 })
-
-#else
-static inline int ptep_test_and_clear_dirty(pte_t *ptep)
-{
-	unsigned long old;
-
-	old = pte_update(ptep, _PAGE_DIRTY);
-	if ((~old & (_PAGE_HASHPTE | _PAGE_RW | _PAGE_DIRTY)) == 0)
-		hpte_update(ptep, old, 1);
-	return (old & _PAGE_DIRTY) != 0;
-}
-
-static inline void ptep_set_wrprotect(pte_t *ptep)
-{
-	unsigned long old;
-
-	old = pte_update(ptep, _PAGE_RW);
-	if ((~old & (_PAGE_HASHPTE | _PAGE_RW | _PAGE_DIRTY)) == 0)
-		hpte_update(ptep, old, 1);
-}
-#endif
 
 static inline pte_t ptep_get_and_clear(pte_t *ptep)
 {


