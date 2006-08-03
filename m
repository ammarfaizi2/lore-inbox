Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWHCHoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWHCHoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWHCHoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:44:00 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:8902 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932298AbWHCHn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:43:59 -0400
Subject: [PATCH 3/4] Trivial move of ptep_set_access_flags
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
In-Reply-To: <1154590994.11423.54.camel@localhost.localdomain>
References: <1154590902.11423.52.camel@localhost.localdomain>
	 <1154590994.11423.54.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:43:57 +1000
Message-Id: <1154591038.11423.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move ptep_set_access_flags to be closer to the other ptep accessors,
and make the indentation standard.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable.h working-2.6.18-rc2-mm1-zach-3/include/asm-i386/pgtable.h
--- working-2.6.18-rc2-mm1-zach-2/include/asm-i386/pgtable.h	2006-08-03 17:28:26.000000000 +1000
+++ working-2.6.18-rc2-mm1-zach-3/include/asm-i386/pgtable.h	2006-08-03 17:29:59.000000000 +1000
@@ -246,6 +246,22 @@ static inline pte_t pte_mkhuge(pte_t pte
 # include <asm/pgtable-2level.h>
 #endif
 
+/*
+ * We only update the dirty/accessed state if we set
+ * the dirty bit by hand in the kernel, since the hardware
+ * will do the accessed bit for us, and we don't want to
+ * race with other CPU's that might be updating the dirty
+ * bit at the same time.
+ */
+#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags(vma, address, ptep, entry, dirty)		\
+do {									\
+	if (dirty) {							\
+		(ptep)->pte_low = (entry).pte_low;			\
+		flush_tlb_page(vma, address);				\
+	}								\
+} while (0)
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
@@ -415,23 +431,8 @@ extern void noexec_setup(const char *str
 /*
  * The i386 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
- *
- * Also, we only update the dirty/accessed state if we set
- * the dirty bit by hand in the kernel, since the hardware
- * will do the accessed bit for us, and we don't want to
- * race with other CPU's that might be updating the dirty
- * bit at the same time.
  */
 #define update_mmu_cache(vma,address,pte) do { } while (0)
-#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-	do {								  \
-		if (__dirty) {						  \
-			(__ptep)->pte_low = (__entry).pte_low;	  	  \
-			flush_tlb_page(__vma, __address);		  \
-		}							  \
-	} while (0)
-
 #endif /* !__ASSEMBLY__ */
 
 #ifdef CONFIG_FLATMEM

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

