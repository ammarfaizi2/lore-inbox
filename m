Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVHFA2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVHFA2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVHFA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:28:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:37137 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262170AbVHFA2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:28:21 -0400
Date: Fri, 5 Aug 2005 17:26:06 -0700
From: zach@vmware.com
Message-Id: <200508060026.j760Q6FT025108@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, pratap@vmware.com,
       Riley@Williams.Name, zach@vmware.com
Subject: [PATCH 1/1] i386 Encapsulate copying of pgd entries
X-OriginalArrivalTime: 06 Aug 2005 00:27:08.0702 (UTC) FILETIME=[948E73E0:01C59A1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clone operation for pgd updates.

This helps complete the encapsulation of updates to page tables (or pages
about to become page tables) into accessor functions rather than using
memcpy() to duplicate them.  This is both generally good for consistency
and also necessary for running in a hypervisor which requires explicit
updates to page table entries.

The new function is:

clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
 
   dst - pointer to pgd range anwhere on a pgd page
   src - ""
   count - the number of pgds to copy.

   dst and src can be on the same page, but the range must not overlap
   and must not cross a page boundary.

Note that I ommitted using this call to copy pgd entries into the
software suspend page root, since this is not technically a live paging
structure, rather it is used on resume from suspend.  CC'ing Pavel in case
he has any feedback on this.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pgtable.c	2005-08-04 12:02:10.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pgtable.c	2005-08-05 17:13:29.000000000 -0700
@@ -207,19 +207,18 @@
 {
 	unsigned long flags;
 
+	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 	if (PTRS_PER_PMD == 1)
 		spin_lock_irqsave(&pgd_lock, flags);
 
-	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
+	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-
+			KERNEL_PGD_PTRS);
 	if (PTRS_PER_PMD > 1)
 		return;
 
 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
-	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 }
 
 /* never called when PTRS_PER_PMD > 1 */
Index: linux-2.6.13/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/smpboot.c	2005-08-04 12:02:10.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/smpboot.c	2005-08-04 13:15:45.000000000 -0700
@@ -1017,8 +1017,8 @@
 	tsc_sync_disabled = 1;
 
 	/* init low mem mapping */
-	memcpy(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
-			sizeof(swapper_pg_dir[0]) * KERNEL_PGD_PTRS);
+	clone_pgd_range(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
+			KERNEL_PGD_PTRS);
 	flush_tlb_all();
 	schedule_work(&task);
 	wait_for_completion(&done);
Index: linux-2.6.13/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable.h	2005-08-04 12:02:10.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable.h	2005-08-05 17:12:33.000000000 -0700
@@ -276,6 +276,21 @@
 }
 
 /*
+ * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
+ *
+ *  dst - pointer to pgd range anwhere on a pgd page
+ *  src - ""
+ *  count - the number of pgds to copy.
+ *
+ * dst and src can be on the same page, but the range must not overlap,
+ * and must not cross a page boundary.
+ */
+static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
+{
+       memcpy(dst, src, count * sizeof(pgd_t));
+}
+
+/*
  * Macro to mark a page protection value as "uncacheable".  On processors which do not support
  * it, this is a no-op.
  */
