Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSFTG4G>; Thu, 20 Jun 2002 02:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSFTG4F>; Thu, 20 Jun 2002 02:56:05 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:61130 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S318131AbSFTG4D>; Thu, 20 Jun 2002 02:56:03 -0400
Message-ID: <3D117C53.2B4F7C53@cisco.com>
Date: Wed, 19 Jun 2002 23:55:15 -0700
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [Trivial Patch] : (2.5 latest) More __builtin_expect() cleanup in favour 
 of likely/unlikely
Content-Type: multipart/mixed;
 boundary="------------090CF21279BC6CBEB32C9845"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090CF21279BC6CBEB32C9845
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


	Copying Rusty as well.

	Changed files in the include/asm-ia64 directory to get rid of
	__builtin_expect() in favour of likely/unlikely.

	Diffs attached ....
--------------090CF21279BC6CBEB32C9845
Content-Type: text/plain; charset=us-ascii;
 name="a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a"

diff -u -r -U 6 include/asm-ia64/delay.h /home/manik/linux-2.5.22/include/asm-ia64/delay.h
--- include/asm-ia64/delay.h	Mon Jun 17 08:01:23 2002
+++ /home/manik/linux-2.5.22/include/asm-ia64/delay.h	Thu Jun 20 12:11:27 2002
@@ -12,12 +12,13 @@
  * Copyright (C) 1999 Don Dugger <don.dugger@intel.com>
  */
 
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/compiler.h>
 
 #include <asm/processor.h>
 
 static __inline__ void
 ia64_set_itm (unsigned long val)
 {
@@ -49,13 +50,13 @@
 ia64_get_itc (void)
 {
 	unsigned long result;
 
 	__asm__ __volatile__("mov %0=ar.itc" : "=r"(result) :: "memory");
 #ifdef CONFIG_ITANIUM
-	while (__builtin_expect ((__s32) result == -1, 0))
+	while (unlikely ((__s32) result == -1)
 		__asm__ __volatile__("mov %0=ar.itc" : "=r"(result) :: "memory");
 #endif
 	return result;
 }
 
 static __inline__ void
diff -u -r -U 6 include/asm-ia64/pgalloc.h /home/manik/linux-2.5.22/include/asm-ia64/pgalloc.h
--- include/asm-ia64/pgalloc.h	Mon Jun 17 08:01:23 2002
+++ /home/manik/linux-2.5.22/include/asm-ia64/pgalloc.h	Thu Jun 20 12:13:25 2002
@@ -14,12 +14,13 @@
  */
 
 #include <linux/config.h>
 
 #include <linux/mm.h>
 #include <linux/threads.h>
+#include <linux/compiler.h>
 
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 
 /*
  * Very stupidly, we used to get new pgd's and pmd's, init their contents
@@ -34,13 +35,13 @@
 
 static inline pgd_t*
 pgd_alloc_one_fast (struct mm_struct *mm)
 {
 	unsigned long *ret = pgd_quicklist;
 
-	if (__builtin_expect(ret != NULL, 1)) {
+	if (likely(ret != NULL)) {
 		pgd_quicklist = (unsigned long *)(*ret);
 		ret[0] = 0;
 		--pgtable_cache_size;
 	} else
 		ret = NULL;
 	return (pgd_t *) ret;
@@ -49,15 +50,15 @@
 static inline pgd_t*
 pgd_alloc (struct mm_struct *mm)
 {
 	/* the VM system never calls pgd_alloc_one_fast(), so we do it here. */
 	pgd_t *pgd = pgd_alloc_one_fast(mm);
 
-	if (__builtin_expect(pgd == NULL, 0)) {
+	if (unlikely(pgd == NULL)) {
 		pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-		if (__builtin_expect(pgd != NULL, 1))
+		if (likely(pgd != NULL))
 			clear_page(pgd);
 	}
 	return pgd;
 }
 
 static inline void
@@ -77,26 +78,26 @@
 
 static inline pmd_t*
 pmd_alloc_one_fast (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long *ret = (unsigned long *)pmd_quicklist;
 
-	if (__builtin_expect(ret != NULL, 1)) {
+	if (likely(ret != NULL)) {
 		pmd_quicklist = (unsigned long *)(*ret);
 		ret[0] = 0;
 		--pgtable_cache_size;
 	}
 	return (pmd_t *)ret;
 }
 
 static inline pmd_t*
 pmd_alloc_one (struct mm_struct *mm, unsigned long addr)
 {
 	pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
 
-	if (__builtin_expect(pmd != NULL, 1))
+	if (likely(pmd != NULL))
 		clear_page(pmd);
 	return pmd;
 }
 
 static inline void
 pmd_free (pmd_t *pmd)
@@ -122,23 +123,23 @@
 
 static inline struct page *
 pte_alloc_one (struct mm_struct *mm, unsigned long addr)
 {
 	struct page *pte = alloc_pages(GFP_KERNEL, 0);
 
-	if (__builtin_expect(pte != NULL, 1))
+	if (likely(pte != NULL))
 		clear_page(page_address(pte));
 	return pte;
 }
 
 static inline pte_t *
 pte_alloc_one_kernel (struct mm_struct *mm, unsigned long addr)
 {
 	pte_t *pte = (pte_t *) __get_free_page(GFP_KERNEL);
 
-	if (__builtin_expect(pte != NULL, 1))
+	if (likely(pte != NULL))
 		clear_page(pte);
 	return pte;
 }
 
 static inline void
 pte_free (struct page *pte)
diff -u -r -U 6 include/asm-ia64/processor.h /home/manik/linux-2.5.22/include/asm-ia64/processor.h
--- include/asm-ia64/processor.h	Mon Jun 17 08:01:30 2002
+++ /home/manik/linux-2.5.22/include/asm-ia64/processor.h	Thu Jun 20 12:14:14 2002
@@ -13,12 +13,13 @@
  * 06/16/00	A. Mallick	added csd/ssd/tssd for ia32 support
  */
 
 #include <linux/config.h>
 
 #include <linux/percpu.h>
+#include <linux/compiler.h>
 
 #include <asm/ptrace.h>
 #include <asm/kregs.h>
 #include <asm/system.h>
 #include <asm/types.h>
 
@@ -280,13 +281,13 @@
 	regs->ar_rnat = 0;									\
 	regs->ar_bspstore = IA64_RBS_BOT;							\
 	regs->ar_fpsr = FPSR_DEFAULT;								\
 	regs->loadrs = 0;									\
 	regs->r8 = current->mm->dumpable;	/* set "don't zap registers" flag */		\
 	regs->r12 = new_sp - 16;	/* allocate 16 byte scratch area */			\
-	if (!__builtin_expect (current->mm->dumpable, 1)) {					\
+	if (!likely (current->mm->dumpable)) {					\
 		/*										\
 		 * Zap scratch regs to avoid leaking bits between processes with different	\
 		 * uid/privileges.								\
 		 */										\
 		regs->ar_pfs = 0;								\
 		regs->pr = 0;									\
diff -u -r -U 6 include/asm-ia64/softirq.h /home/manik/linux-2.5.22/include/asm-ia64/softirq.h
--- include/asm-ia64/softirq.h	Mon Jun 17 08:01:35 2002
+++ /home/manik/linux-2.5.22/include/asm-ia64/softirq.h	Thu Jun 20 12:15:02 2002
@@ -1,22 +1,24 @@
 #ifndef _ASM_IA64_SOFTIRQ_H
 #define _ASM_IA64_SOFTIRQ_H
 
+#include <linux/compiler.h>
+
 /*
  * Copyright (C) 1998-2001 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 #include <asm/hardirq.h>
 
 #define __local_bh_enable()	do { barrier(); really_local_bh_count()--; } while (0)
 
 #define local_bh_disable()	do { really_local_bh_count()++; barrier(); } while (0)
 #define local_bh_enable()								\
 do {											\
 	__local_bh_enable();								\
-	if (__builtin_expect(local_softirq_pending(), 0) && really_local_bh_count() == 0)	\
+	if (unlikely(local_softirq_pending()) && really_local_bh_count() == 0)	\
 		do_softirq();								\
 } while (0)
 
 
 #define in_softirq()		(really_local_bh_count() != 0)
 

--------------090CF21279BC6CBEB32C9845--

