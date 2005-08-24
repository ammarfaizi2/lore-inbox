Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVHXSoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVHXSoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVHXSoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:44:00 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:5639 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751392AbVHXSn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:43:59 -0400
Date: Wed, 24 Aug 2005 11:44:15 -0700
Message-Id: <200508241844.j7OIiFZE001894@zach-dev.vmware.com>
Subject: [PATCH 4/5] Add address translation
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Virtualization Mailing List <virtualization@lists.osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
To: Pratap Subrahmanyam <pratap@vmware.com>
To: Christopher Li <chrisl@vmware.com>
To: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 24 Aug 2005 18:44:16.0344 (UTC) FILETIME=[D452FD80:01C5A8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to convert an arbitrary mapped virtual address to a
physical frame number.  Adapted from code by Chris Wright, added support
for large pages.

Because of the placement, this needs to be a macro; pgd_offset_k requires
init_mm to be defined, and getting the include files right seemed more
complicated than a macroized implementation.

A more proper location would be in asm/page.h, but that gets confounded
by the use of pgd_offset_k() again.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable.h	2005-08-24 09:43:27.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable.h	2005-08-24 09:47:38.000000000 -0700
@@ -388,6 +388,28 @@ static inline pte_t pte_modify(pte_t pte
 extern pte_t *lookup_address(unsigned long address);
 
 /*
+ * Helper function that returns physical page for virtual address.
+ * This assumes the mapping is valid.
+ */
+#define virt_to_pfn(_address) 					\
+({ 								\
+	unsigned long long __paddr;				\
+	pgd_t *pgd = pgd_offset_k(_address);			\
+	pud_t *pud = pud_offset(pgd, (_address));		\
+	pmd_t *pmd = pmd_offset(pud, (_address));		\
+	if (pmd_large(*pmd))					\
+		__paddr = (pmd_val(*pmd) & LARGE_PAGE_MASK) |	\
+			((_address) & ~LARGE_PAGE_MASK);	\
+	else {							\
+		pte_t *pte = pte_offset_kernel(pmd, (_address));\
+		__paddr = (pte_val(*pte) & PAGE_MASK) |		\
+			((_address) & ~PAGE_MASK);		\
+	}							\
+	__paddr >>= PAGE_SHIFT;					\
+	__paddr;						\
+}) 
+
+/*
  * Make a given kernel text page executable/non-executable.
  * Returns the previous executability setting of that page (which
  * is used to restore the previous state). Used by the SMP bootup code.
