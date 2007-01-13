Return-Path: <linux-kernel-owner+w=401wt.eu-S1422822AbXAMXLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbXAMXLe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbXAMXK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:56 -0500
Received: from gw.goop.org ([64.81.55.164]:59918 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030531AbXAMXK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:27 -0500
Message-Id: <20070113014647.898074336@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:47 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 08/20] XEN-paravirt: paravirt pgd allocation alignment
Content-Disposition: inline; filename=pgd-alignment.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -573,6 +573,7 @@ struct paravirt_ops paravirt_ops = {
 	.paravirt_enabled = 0,
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
+	.pgd_alignment = sizeof(pgd_t) * PTRS_PER_PGD,
 
  	.patch = native_patch,
 	.banner = default_banner,
===================================================================
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -745,7 +745,7 @@ void __init pgtable_cache_init(void)
 	}
 	pgd_cache = kmem_cache_create("pgd",
 				      PTRS_PER_PGD*sizeof(pgd_t),
-				      PTRS_PER_PGD*sizeof(pgd_t),
+				      PGD_ALIGNMENT,
 				      0, NULL, NULL);
 	if (!pgd_cache)
 		panic("pgtable_cache_init(): Cannot create pgd cache");
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -33,9 +33,12 @@ struct mm_struct;
 struct mm_struct;
 struct paravirt_ops
 {
+ 	int paravirt_enabled;
 	unsigned int kernel_rpl;
+
 	int shared_kernel_pmd;
- 	int paravirt_enabled;
+	int pgd_alignment;
+
 	const char *name;
 
 	/*
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -270,6 +270,12 @@ static inline void vmalloc_sync_all(void
 #define pte_update_defer(mm, addr, ptep)	do { } while (0)
 #endif
 
+#ifdef CONFIG_PARAVIRT
+#define PGD_ALIGNMENT	(paravirt_ops.pgd_alignment)
+#else
+#define PGD_ALIGNMENT	(sizeof(pgd_t) * PTRS_PER_PGD)
+#endif
+
 /*
  * We only update the dirty/accessed state if we set
  * the dirty bit by hand in the kernel, since the hardware

-- 

