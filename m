Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUI1PTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUI1PTA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUI1PSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:18:55 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:45248 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S267876AbUI1PSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:18:49 -0400
Date: Tue, 28 Sep 2004 17:07:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: clameter@sgi.com
Cc: akpm@osdl.org, luto@myrealbox.com, ak@suse.de, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V9: [7/7] atomic pte operatiosn for s390
Message-ID: <20040928150743.GA6305@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> 7/7: Atomic pte operations for s390
> 
>    Add atomic PTE operations for S390. This has also not been tested
>    yet since I have no S/390 available. Feedback from the S/390 people
>    seems to indicate though that the way it is done is fine.

I finally found some time to experiment with your page scalability
patches. Unluckily it is not possible to implement a spinlock free
update of page table entries if we want to keep our ipte optimization.
The ipte instruction is behind our ptep_clear_flush and ptep_establish
primitives. The instruction invalidates a pte by setting the invalid
bit (0x400) and flushes the tlbs on all cpus referring to this pte.
The catch is that the instruction only works on the original,
unmodified pte and that the store of the byte containing the invalid
bit isn't atomic in regard to other changes to the pte. So we have
to take the page table lock for all changes to ptes because ipte
might race against other updates.

Since we don't have that many processors on s390 the selective
purging of the tlb by the ipte instruction is more important then
the spinlock free page table update. The only operation that could
use an atomic update on s390 is pgd_test_and_populate for 64 bit.
Since this is a rather infrequently used operation it doesn't make
too much sense to optimize it. That leaves ptep_xchg_flush as the
operation that needs to get implemented by use of the ipte. You'll
find a new patch that adds an implementation of ptep_xchg_flush for
s390 below, the old patch is broken. Please replace.

There are some more things that need improvement:
* You should introduce a #define for each of the new primitives
  (__HAVE_ARCH_PTEP_CMPXCHG, __HAVE_ARCH_PTEP_XCHG_FLUSH, etc) so
  that the architectures can redefine the primitives separatly.
  For s390 I need to define a ptep_xchg_flush but want to use the
  default implementation for all the other new primitives.
* In the generic implementations of the new primitives please use
  the mm from the vma to do the locking. To rely on the fact that
  the memory structure in the functions that use the macros are always
  called "mm" is quite a hack.
* The ptep_get_clear_flush primitive isn't used anywhere and should
  be removed.
* The flush_tlb_page in the generic ptep_cmpxchg implementation
  shouldn't be there, the macro is used in code sequences where it
  isn't needed (the old code didn't flush).

blue skies
  Martin.

---
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Changelog
	* Provide ptep_xchg_flush primitive for s390

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diff -urN linux-2.6.orig/include/asm-generic/pgtable.h linux-2.6/include/asm-generic/pgtable.h
--- linux-2.6.orig/include/asm-generic/pgtable.h	2004-09-28 16:51:25.000000000 +0200
+++ linux-2.6/include/asm-generic/pgtable.h	2004-09-28 16:54:31.000000000 +0200
@@ -134,6 +134,7 @@
  * page_table_handling of the cpu may bypass all locking.
  */
 
+#ifndef __HAVE_ARCH_PTEP_XCHG_FLUSH
 #define ptep_xchg_flush(__vma, __address, __ptep, __pteval)		\
 ({									\
 	pte_t __pte;							\
@@ -144,6 +145,7 @@
 	spin_unlock(&mm->page_table_lock);				\
 	__pte;								\
 })
+#endif
 
 
 #define ptep_get_clear_flush(__vma, __address, __ptep)			\
diff -urN linux-2.6.orig/include/asm-s390/pgtable.h linux-2.6/include/asm-s390/pgtable.h
--- linux-2.6.orig/include/asm-s390/pgtable.h	2004-08-14 07:37:38.000000000 +0200
+++ linux-2.6/include/asm-s390/pgtable.h	2004-09-28 16:54:09.000000000 +0200
@@ -567,6 +567,17 @@
 	return pte;
 }
 
+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)		\
+({									\
+	struct mm_struct *__mm = __vma->vm_mm;				\
+	pte_t __pte;							\
+	spin_lock(&__mm->page_table_lock);				\
+	__pte = ptep_clear_flush(__vma, __address, __ptep);		\
+	set_pte(__ptep, __pteval);					\
+	spin_unlock(&__mm->page_table_lock);				\
+	__pte;								\
+})
+
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
@@ -796,6 +807,7 @@
 #define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
+#define __HAVE_ARCH_PTEP_XCHG_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
