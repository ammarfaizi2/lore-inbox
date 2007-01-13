Return-Path: <linux-kernel-owner+w=401wt.eu-S1422796AbXAMXLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbXAMXLd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422822AbXAMXK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:57 -0500
Received: from gw.goop.org ([64.81.55.164]:59916 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030528AbXAMXK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:27 -0500
Message-Id: <20070113014647.693043448@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:45 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 06/20] XEN-paravirt: remove pgd ctor
Content-Disposition: inline; filename=remove-pgd-ctor.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ctor for the pgd cache.  There's no point in having the
cache machinery do this via an indirect call when all pgd are freed in
the one place anyway.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>

--
 arch/i386/mm/init.c        |    8 +++-----
 arch/i386/mm/pgtable.c     |   15 +++++++++++----
 include/asm-i386/pgtable.h |    2 --
 3 files changed, 14 insertions(+), 11 deletions(-)

===================================================================
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -739,11 +739,9 @@ void __init pgtable_cache_init(void)
 			panic("pgtable_cache_init(): cannot create pmd cache");
 	}
 	pgd_cache = kmem_cache_create("pgd",
-				PTRS_PER_PGD*sizeof(pgd_t),
-				PTRS_PER_PGD*sizeof(pgd_t),
-				0,
-				pgd_ctor,
-				PTRS_PER_PMD == 1 ? pgd_dtor : NULL);
+				      PTRS_PER_PGD*sizeof(pgd_t),
+				      PTRS_PER_PGD*sizeof(pgd_t),
+				      0, NULL, NULL);
 	if (!pgd_cache)
 		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
===================================================================
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -236,7 +236,7 @@ static inline void pgd_list_del(pgd_t *p
 		set_page_private(next, (unsigned long)pprev);
 }
 
-void pgd_ctor(void *pgd, struct kmem_cache *cache, unsigned long unused)
+static void pgd_ctor(pgd_t *pgd)
 {
 	unsigned long flags;
 
@@ -245,7 +245,7 @@ void pgd_ctor(void *pgd, struct kmem_cac
 		spin_lock_irqsave(&pgd_lock, flags);
 	}
 
-	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
+	clone_pgd_range(pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
 			KERNEL_PGD_PTRS);
 
@@ -261,10 +261,12 @@ void pgd_ctor(void *pgd, struct kmem_cac
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
-/* never called when PTRS_PER_PMD > 1 */
-void pgd_dtor(void *pgd, struct kmem_cache *cache, unsigned long unused)
+static void pgd_dtor(pgd_t *pgd)
 {
 	unsigned long flags; /* can be called from interrupt context */
+
+	if (PTRS_PER_PMD == 1)
+		return;
 
 	paravirt_release_pd(__pa(pgd) >> PAGE_SHIFT);
 	spin_lock_irqsave(&pgd_lock, flags);
@@ -276,6 +278,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
+
+	if (pgd)
+		pgd_ctor(pgd);
 
 	if (PTRS_PER_PMD == 1 || !pgd)
 		return pgd;
@@ -296,6 +301,7 @@ out_oom:
 		paravirt_release_pd(__pa(pmd) >> PAGE_SHIFT);
 		kmem_cache_free(pmd_cache, pmd);
 	}
+	pgd_dtor(pgd);
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -313,5 +319,6 @@ void pgd_free(pgd_t *pgd)
 			kmem_cache_free(pmd_cache, pmd);
 		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
+	pgd_dtor(pgd);
 	kmem_cache_free(pgd_cache, pgd);
 }
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -41,8 +41,6 @@ extern struct page *pgd_list;
 extern struct page *pgd_list;
 
 void pmd_ctor(void *, struct kmem_cache *, unsigned long);
-void pgd_ctor(void *, struct kmem_cache *, unsigned long);
-void pgd_dtor(void *, struct kmem_cache *, unsigned long);
 void pgtable_cache_init(void);
 void paging_init(void);
 

-- 

