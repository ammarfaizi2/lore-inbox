Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTABEpQ>; Wed, 1 Jan 2003 23:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTABEpQ>; Wed, 1 Jan 2003 23:45:16 -0500
Received: from holomorphy.com ([66.224.33.161]:57538 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265543AbTABEpG>;
	Wed, 1 Jan 2003 23:45:06 -0500
Date: Wed, 1 Jan 2003 20:53:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.53-mm2
Message-ID: <20030102045327.GC7644@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E0E4744.8EE126ED@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E0E4744.8EE126ED@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 04:52:20PM -0800, Andrew Morton wrote:
> wli-11_pgd_ctor.patch
>   (undescribed patch)

A moment's reflection on the subject suggests to me it's worthwhile to
generalize pgd_ctor support so it works (without #ifdefs!) on both PAE
and non-PAE. This tiny tweak is actually more noticeably beneficial
on non-PAE systems but only really because pgd_alloc() is more visible;
the most likely reason it's less visible on PAE is "other overhead".
It looks particularly nice since it removes more code than it adds.

Touch tested on NUMA-Q (PAE). OFTC #kn testers testing the non-PAE case.

 arch/i386/mm/init.c               |   36 +++++++++++++----------
 arch/i386/mm/pgtable.c            |   58 ++++++++++++--------------------------
 include/asm-i386/pgtable-3level.h |    2 -
 include/asm-i386/pgtable.h        |   13 +-------
 4 files changed, 41 insertions(+), 68 deletions(-)


diff -urpN mm3-2.5.53-1/arch/i386/mm/init.c mm3-2.5.53-2/arch/i386/mm/init.c
--- mm3-2.5.53-1/arch/i386/mm/init.c	2003-01-01 18:49:19.000000000 -0800
+++ mm3-2.5.53-2/arch/i386/mm/init.c	2003-01-01 18:51:17.000000000 -0800
@@ -504,32 +504,36 @@ void __init mem_init(void)
 #endif
 }
 
-#if CONFIG_X86_PAE
 #include <linux/slab.h>
 
-kmem_cache_t *pae_pmd_cachep;
-kmem_cache_t *pae_pgd_cachep;
+kmem_cache_t *pmd_cache;
+kmem_cache_t *pgd_cache;
 
-void pae_pmd_ctor(void *, kmem_cache_t *, unsigned long);
-void pae_pgd_ctor(void *, kmem_cache_t *, unsigned long);
+void pmd_ctor(void *, kmem_cache_t *, unsigned long);
+void pgd_ctor(void *, kmem_cache_t *, unsigned long);
 
 void __init pgtable_cache_init(void)
 {
+	if (PTRS_PER_PMD > 1) {
+		pmd_cache = kmem_cache_create("pae_pmd",
+						PTRS_PER_PMD*sizeof(pmd_t),
+						0,
+						SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
+						pmd_ctor,
+						NULL);
+
+		if (!pmd_cache)
+			panic("pgtable_cache_init(): cannot create pmd cache");
+	}
+
         /*
          * PAE pgds must be 16-byte aligned:
          */
-	pae_pmd_cachep = kmem_cache_create("pae_pmd", 4096, 0,
-		SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, pae_pmd_ctor, NULL);
-
-	if (!pae_pmd_cachep)
-		panic("init_pae(): cannot allocate pae_pmd SLAB cache");
-
-        pae_pgd_cachep = kmem_cache_create("pae_pgd", 32, 0,
-                SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, pae_pgd_ctor, NULL);
-        if (!pae_pgd_cachep)
-                panic("init_pae(): Cannot alloc pae_pgd SLAB cache");
+        pgd_cache = kmem_cache_create("pgd", PTRS_PER_PGD*sizeof(pgd_t), 0,
+                SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, pgd_ctor, NULL);
+        if (!pgd_cache)
+                panic("pgtable_cache_init(): Cannot create pgd cache");
 }
-#endif
 
 /* Put this after the callers, so that it cannot be inlined */
 static int do_test_wp_bit(void)
diff -urpN mm3-2.5.53-1/arch/i386/mm/pgtable.c mm3-2.5.53-2/arch/i386/mm/pgtable.c
--- mm3-2.5.53-1/arch/i386/mm/pgtable.c	2003-01-01 18:49:19.000000000 -0800
+++ mm3-2.5.53-2/arch/i386/mm/pgtable.c	2003-01-01 18:51:17.000000000 -0800
@@ -166,19 +166,20 @@ struct page *pte_alloc_one(struct mm_str
 	return pte;
 }
 
-#if CONFIG_X86_PAE
+extern kmem_cache_t *pmd_cache;
+extern kmem_cache_t *pgd_cache;
 
-extern kmem_cache_t *pae_pmd_cachep;
-
-void pae_pmd_ctor(void *__pmd, kmem_cache_t *pmd_cache, unsigned long flags)
+void pmd_ctor(void *__pmd, kmem_cache_t *pmd_cache, unsigned long flags)
 {
 	clear_page(__pmd);
 }
 
-void pae_pgd_ctor(void *__pgd, kmem_cache_t *pgd_cache, unsigned long flags)
+void pgd_ctor(void *__pgd, kmem_cache_t *pgd_cache, unsigned long flags)
 {
 	pgd_t *pgd = __pgd;
 
+	if (PTRS_PER_PMD == 1)
+		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 	memcpy(pgd + USER_PTRS_PER_PGD,
 		swapper_pg_dir + USER_PTRS_PER_PGD,
 		(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
@@ -187,59 +188,38 @@ void pae_pgd_ctor(void *__pgd, kmem_cach
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
-	pgd_t *pgd = kmem_cache_alloc(pae_pgd_cachep, SLAB_KERNEL);
+	pgd_t *pgd = kmem_cache_alloc(pgd_cache, SLAB_KERNEL);
 
-	if (!pgd)
+	if (PTRS_PER_PMD == 1)
+		return pgd;
+	else if (!pgd)
 		return NULL;
 
 	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-		pmd_t *pmd = kmem_cache_alloc(pae_pmd_cachep, SLAB_KERNEL);
+		pmd_t *pmd = kmem_cache_alloc(pmd_cache, SLAB_KERNEL);
 		if (!pmd)
 			goto out_oom;
-		else if ((unsigned long)pmd & ~PAGE_MASK) {
-			printk("kmem_cache_alloc did wrong! death ensues!\n");
-			goto out_oom;
-		}
 		set_pgd(pgd + i, __pgd(1 + __pa((unsigned long long)((unsigned long)pmd))));
 	}
 	return pgd;
 
 out_oom:
 	for (i--; i >= 0; --i)
-		kmem_cache_free(pae_pmd_cachep, (void *)__va(pgd_val(pgd[i])-1));
-	kmem_cache_free(pae_pgd_cachep, (void *)pgd);
+		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	kmem_cache_free(pgd_cache, (void *)pgd);
 	return NULL;
 }
 
 void pgd_free(pgd_t *pgd)
 {
 	int i;
-	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-		kmem_cache_free(pae_pmd_cachep, (void *)__va(pgd_val(pgd[i])-1));
-		set_pgd(pgd + i, __pgd(0));
-	}
-	kmem_cache_free(pae_pgd_cachep, (void *)pgd);
-}
-
-#else
 
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-
-	if (pgd) {
-		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	if (PTRS_PER_PMD > 1) {
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+			set_pgd(pgd + i, __pgd(0));
+		}
 	}
-	return pgd;
-}
 
-void pgd_free(pgd_t *pgd)
-{
-	free_page((unsigned long)pgd);
+	kmem_cache_free(pgd_cache, (void *)pgd);
 }
-
-#endif /* CONFIG_X86_PAE */
-
diff -urpN mm3-2.5.53-1/include/asm-i386/pgtable-3level.h mm3-2.5.53-2/include/asm-i386/pgtable-3level.h
--- mm3-2.5.53-1/include/asm-i386/pgtable-3level.h	2002-12-23 21:21:07.000000000 -0800
+++ mm3-2.5.53-2/include/asm-i386/pgtable-3level.h	2003-01-01 18:51:17.000000000 -0800
@@ -106,6 +106,4 @@ static inline pmd_t pfn_pmd(unsigned lon
 	return __pmd(((unsigned long long)page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
 }
 
-extern struct kmem_cache_s *pae_pgd_cachep;
-
 #endif /* _I386_PGTABLE_3LEVEL_H */
diff -urpN mm3-2.5.53-1/include/asm-i386/pgtable.h mm3-2.5.53-2/include/asm-i386/pgtable.h
--- mm3-2.5.53-1/include/asm-i386/pgtable.h	2003-01-01 18:49:21.000000000 -0800
+++ mm3-2.5.53-2/include/asm-i386/pgtable.h	2003-01-01 18:51:17.000000000 -0800
@@ -41,22 +41,13 @@ extern unsigned long empty_zero_page[102
 #ifndef __ASSEMBLY__
 #if CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
-
-/*
- * Need to initialise the X86 PAE caches
- */
-extern void pgtable_cache_init(void);
-
 #else
 # include <asm/pgtable-2level.h>
+#endif
 
-/*
- * No page table caches to initialise
- */
-#define pgtable_cache_init()	do { } while (0)
+void pgtable_cache_init(void);
 
 #endif
-#endif
 
 #define __beep() asm("movb $0x3,%al; outb %al,$0x61")
 
