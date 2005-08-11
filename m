Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVHKE6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVHKE6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVHKE6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:58:46 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:55558 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932266AbVHKE6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:58:43 -0400
Date: Wed, 10 Aug 2005 21:58:41 -0700
From: zach@vmware.com
Message-Id: <200508110458.j7B4wfh4019635@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 14/14] i386 / Introduce hypervisor lazy pinning hooks
X-OriginalArrivalTime: 11 Aug 2005 04:58:54.0342 (UTC) FILETIME=[5F8A6A60:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xen uses lazy pinning of MM structures including the page table root and LDT,
which requires hooks at context creation and destruction time to maintain the
lazy list.

Patch-against: 2.6.13-rc5-mm1
Patch-keys: i386 mmu paravirt xen
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/mmu_context.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mmu_context.h	2005-08-10 17:06:52.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mmu_context.h	2005-08-10 17:11:40.000000000 -0700
@@ -6,6 +6,7 @@
 #include <asm/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <mach_mmu.h>
 
 /*
  * Used for LDT copy/destruction.
@@ -15,12 +16,14 @@
 	struct mm_struct * old_mm;
 	int retval = 0;
 
+	memset(&mm->context, 0, sizeof(mm->context));
 	init_MUTEX(&mm->context.sem);
-	mm->context.size = 0;
 	old_mm = current->mm;
 	if (old_mm && unlikely(old_mm->context.size > 0)) {
 		retval = copy_ldt(&mm->context, &old_mm->context);
 	}
+	if (retval == 0)
+		add_lazy_mm(mm);
 	return retval;
 }
 
@@ -31,6 +34,7 @@
 {
 	if (unlikely(mm->context.size))
 		destroy_ldt(mm);
+	del_lazy_mm(mm);
 }
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
Index: linux-2.6.13/include/asm-i386/mach-default/mach_mmu.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_mmu.h	2005-08-10 17:11:40.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_mmu.h	2005-08-10 17:11:40.000000000 -0700
@@ -0,0 +1,10 @@
+#ifndef __ASM_MACH_MMU_H
+#define __ASM_MACH_MMU_H
+
+/*
+ * Stub hooks for lazy hypervisor pinning.
+ */
+#define add_lazy_mm(_mm)
+#define del_lazy_mm(_mm)
+
+#endif
