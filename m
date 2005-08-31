Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVHaVvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVHaVvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVHaVvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:51:51 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:46089 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932530AbVHaVvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:51:50 -0400
Date: Wed, 31 Aug 2005 14:51:48 -0700
Message-Id: <200508312151.j7VLpmu8003144@zach-dev.vmware.com>
Subject: [PATCH 2/2] Use page present for pae pdpes
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 31 Aug 2005 21:51:54.0593 (UTC) FILETIME=[33A7B510:01C5AE76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the use of "1 + " and subtraction of one for PAE PDPEs has confused
many people now.  Make it explicit what is going on and why anding with
PAGE_MASK is a better idea to strip these bits.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Depends-on: add-pgtable-allocation-notifiers
Index: linux-2.6.13/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pgtable.c	2005-08-31 14:48:17.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pgtable.c	2005-08-31 14:48:53.000000000 -0700
@@ -247,14 +247,14 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		if (!pmd)
 			goto out_oom;
 		SetPagePDE(virt_to_page(pmd));
-		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
+		set_pgd(&pgd[i], __pgd(_PAGE_PRESENT | __pa(pmd)));
 	}
 	return pgd;
 
 out_oom:
 	for (i--; i >= 0; i--) {
 		ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i]) & PAGE_MASK));
 	}
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
@@ -268,7 +268,7 @@ void pgd_free(pgd_t *pgd)
 	if (PTRS_PER_PMD > 1)
 		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
 			ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i]) & PAGE_MASK));
 		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
Index: linux-2.6.13/arch/i386/mm/init.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-08-31 14:48:17.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/init.c	2005-08-31 14:48:53.000000000 -0700
@@ -387,7 +387,7 @@ void zap_low_mappings (void)
 	 */
 	for (i = 0; i < USER_PTRS_PER_PGD; i++)
 #ifdef CONFIG_X86_PAE
-		set_pgd(swapper_pg_dir+i, __pgd(1 + __pa(empty_zero_page)));
+		set_pgd(swapper_pg_dir+i, __pgd(_PAGE_PRESENT | __pa(empty_zero_page)));
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
 #endif
