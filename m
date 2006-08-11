Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWHKJUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWHKJUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWHKJUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:20:49 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:10500 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751010AbWHKJUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:20:48 -0400
Date: Fri, 11 Aug 2006 02:20:46 -0700
Message-Id: <200608110920.k7B9Kkod023360@zach-dev.vmware.com>
Subject: [PATCH 7/9] 00mma remove set pte atomic.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:20:47.0344 (UTC) FILETIME=[6DFEFF00:01C6BD27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ptep_establish has a definition in PAE i386 3-level paging code,
the only paging model which is insane enough to have multi-word hardware
PTEs which are not efficient to set atomically, we can remove the ghost
of set_pte_atomic from other architectures which falesly duplicated it,
and remove all knowledge of it from the generic pgtable code.

set_pte_atomic is now a private pte operator which is specific to i386

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/include/asm-frv/pgtable.h
+++ b/include/asm-frv/pgtable.h
@@ -175,8 +175,6 @@ do {							\
 	asm volatile("dcf %M0" :: "U"(*pteptr));	\
 } while(0)
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
-#define set_pte_atomic(pteptr, pteval)		set_pte((pteptr), (pteval))
 
 /*
  * pgd_offset() returns a (pgd_t *)
===================================================================
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -13,19 +13,11 @@
  * Note: the old pte is known to not be writable, so we don't need to
  * worry about dirty bits etc getting lost.
  */
-#ifndef __HAVE_ARCH_SET_PTE_ATOMIC
 #define ptep_establish(__vma, __address, __ptep, __entry)		\
 do {				  					\
 	set_pte_at((__vma)->vm_mm, (__address), __ptep, __entry);	\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
-#else /* __HAVE_ARCH_SET_PTE_ATOMIC */
-#define ptep_establish(__vma, __address, __ptep, __entry)		\
-do {				  					\
-	set_pte_atomic(__ptep, __entry);				\
-	flush_tlb_page(__vma, __address);				\
-} while (0)
-#endif /* __HAVE_ARCH_SET_PTE_ATOMIC */
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
===================================================================
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -73,7 +73,6 @@ static inline void set_pte_present(struc
 	ptep->pte_low = pte.pte_low;
 }
 
-#define __HAVE_ARCH_SET_PTE_ATOMIC
 #define set_pte_atomic(pteptr,pteval) \
 		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
 #define set_pmd(pmdptr,pmdval) \
===================================================================
--- a/include/asm-m32r/pgtable-2level.h
+++ b/include/asm-m32r/pgtable-2level.h
@@ -44,7 +44,7 @@ static inline int pgd_present(pgd_t pgd)
  */
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-#define set_pte_atomic(pteptr, pteval)	set_pte(pteptr, pteval)
+
 /*
  * (pmds are folded into pgds so this doesnt get actually called,
  * but the define is needed for a generic inline function.)
