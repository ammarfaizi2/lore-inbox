Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWHKJTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWHKJTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWHKJTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:19:00 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:64941 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750998AbWHKJS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:18:59 -0400
Date: Fri, 11 Aug 2006 02:18:55 -0700
Message-Id: <200608110918.k7B9ItGw023342@zach-dev.vmware.com>
Subject: [PATCH 4/9] 00mm5 combine flush accessed dirty.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:18:55.0705 (UTC) FILETIME=[2B743C90:01C6BD27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ptep_test_and_clear_{dirty|young} from i386, and instead use the
dominating functions, ptep_clear_flush_{dirty|young}.  This allows the
TLB page flush to be contained in the same macro, and allows for an
eager optimization - if reading the PTE initially returned dirty/accessed,
we can assume the fact that no subsequent update to the PTE which cleared
accessed / dirty has occurred, as the only way A/D bits can change without
holding the page table lock is if a remote processor clears them.  This
eliminates an extra branch which came from the generic version of the
code, as we know that no other CPU could have cleared the A/D bit, so the
flush will always be needed.

We still export these two defines, even though we do not actually define
the macros in the i386 code:

 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY

The reason for this is that the only use of these functions is within the
generic clear_flush functions, and we want a strong guarantee that there
are no other users of these functions, so we want to prevent the generic
code from defining them for us.

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -262,21 +262,36 @@ do {									\
 	}								\
 } while (0)
 
+/*
+ * We don't actually have these, but we want to advertise them so that
+ * we can encompass the flush here.
+ */
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
-{
-	if (!pte_dirty(*ptep))
-		return 0;
-	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
-}
-
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
-{
-	if (!pte_young(*ptep))
-		return 0;
-	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
-}
+
+#define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
+#define ptep_clear_flush_dirty(vma, address, ptep)			\
+({									\
+	int __dirty;							\
+	__dirty = pte_dirty(*(ptep));					\
+	if (__dirty) {							\
+		clear_bit(_PAGE_BIT_DIRTY, &(ptep)->pte_low);		\
+		flush_tlb_page(vma, address);				\
+	}								\
+	__dirty;							\
+})
+
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+#define ptep_clear_flush_young(vma, address, ptep)			\
+({									\
+	int __young;							\
+	__young = pte_young(*(ptep));					\
+	if (__young) {							\
+		clear_bit(_PAGE_BIT_ACCESSED, &(ptep)->pte_low);	\
+		flush_tlb_page(vma, address);				\
+	}								\
+	__young;							\
+})
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
