Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVAVHiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVAVHiN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 02:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVAVHiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 02:38:13 -0500
Received: from ozlabs.org ([203.10.76.45]:32129 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262677AbVAVHhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 02:37:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16882.705.142187.82807@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 18:37:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, linas@linas.org
Subject: [PATCH] PPC64: Trivial Cleanup: EEH_REGION
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is originally from Linas Vepstas <linas@linas.org>.

This is a dumb, dorky cleanup patch:
Per last round of emails, the concept of EEH_REGION is gone, 
but a few stubs remained.  This patch removes them.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/mm/hash_utils.c test/arch/ppc64/mm/hash_utils.c
--- linux-2.5/arch/ppc64/mm/hash_utils.c	2005-01-06 13:13:08.000000000 +1100
+++ test/arch/ppc64/mm/hash_utils.c	2005-01-22 16:42:48.000000000 +1100
@@ -294,12 +294,6 @@
 		vsid = get_kernel_vsid(ea);
 		break;
 #if 0
-	case EEH_REGION_ID:
-		/*
-		 * Should only be hit if there is an access to MMIO space
-		 * which is protected by EEH.
-		 * Send the problem up to do_page_fault 
-		 */
 	case KERNEL_REGION_ID:
 		/*
 		 * Should never get here - entire 0xC0... region is bolted.
diff -urN linux-2.5/arch/ppc64/mm/slb.c test/arch/ppc64/mm/slb.c
--- linux-2.5/arch/ppc64/mm/slb.c	2005-01-06 13:13:08.000000000 +1100
+++ test/arch/ppc64/mm/slb.c	2005-01-22 16:44:26.000000000 +1100
@@ -78,7 +78,7 @@
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
 	unsigned long offset = get_paca()->slb_cache_ptr;
-	unsigned long esid_data;
+	unsigned long esid_data = 0;
 	unsigned long pc = KSTK_EIP(tsk);
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long unmapped_base;
@@ -97,11 +97,8 @@
 	}
 
 	/* Workaround POWER5 < DD2.1 issue */
-	if (offset == 1 || offset > SLB_CACHE_ENTRIES) {
-		/* flush segment in EEH region, we shouldn't ever
-		 * access addresses in this region. */
-		asm volatile("slbie %0" : : "r"(EEHREGIONBASE));
-	}
+	if (offset == 1 || offset > SLB_CACHE_ENTRIES)
+		asm volatile("slbie %0" : : "r" (esid_data));
 
 	get_paca()->slb_cache_ptr = 0;
 	get_paca()->context = mm->context;
diff -urN linux-2.5/include/asm-ppc64/page.h test/include/asm-ppc64/page.h
--- linux-2.5/include/asm-ppc64/page.h	2005-01-06 13:13:10.000000000 +1100
+++ test/include/asm-ppc64/page.h	2005-01-22 16:42:48.000000000 +1100
@@ -205,10 +205,8 @@
 #define KERNELBASE      PAGE_OFFSET
 #define VMALLOCBASE     ASM_CONST(0xD000000000000000)
 #define IOREGIONBASE    ASM_CONST(0xE000000000000000)
-#define EEHREGIONBASE   ASM_CONST(0xA000000000000000)
 
 #define IO_REGION_ID       (IOREGIONBASE>>REGION_SHIFT)
-#define EEH_REGION_ID      (EEHREGIONBASE>>REGION_SHIFT)
 #define VMALLOC_REGION_ID  (VMALLOCBASE>>REGION_SHIFT)
 #define KERNEL_REGION_ID   (KERNELBASE>>REGION_SHIFT)
 #define USER_REGION_ID     (0UL)
