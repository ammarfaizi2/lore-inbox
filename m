Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRC3ME7>; Fri, 30 Mar 2001 07:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131335AbRC3MEt>; Fri, 30 Mar 2001 07:04:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:17924 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131323AbRC3MEf>; Fri, 30 Mar 2001 07:04:35 -0500
Date: Fri, 30 Mar 2001 16:02:04 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
   Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] alpha pte/pmd alloc update vs. 2.4.3
Message-ID: <20010330160204.A852@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically the same stuff as in -ac tree; added `mm_struct *mm' argument.

Ivan.

--- 2.4.3/include/asm-alpha/pgalloc.h	Fri Mar 30 13:54:33 2001
+++ linux/include/asm-alpha/pgalloc.h	Fri Mar 30 14:07:46 2001
@@ -241,6 +241,9 @@ extern struct pgtable_cache_struct {
 #define pte_quicklist (quicklists.pte_cache)
 #define pgtable_cache_size (quicklists.pgtable_cache_sz)
 
+#define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
+#define pgd_populate(mm, pgd, pmd)	pgd_set(pgd, pmd)
+
 extern pgd_t *get_pgd_slow(void);
 
 static inline pgd_t *get_pgd_fast(void)
@@ -268,9 +271,15 @@ static inline void free_pgd_slow(pgd_t *
 	free_page((unsigned long)pgd);
 }
 
-extern pmd_t *get_pmd_slow(pgd_t *pgd, unsigned long address_premasked);
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL);
+	if (ret)
+		clear_page(ret);
+	return ret;
+}
 
-static inline pmd_t *get_pmd_fast(void)
+static inline pmd_t *pmd_alloc_one_fast(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *ret;
 
@@ -282,21 +291,27 @@ static inline pmd_t *get_pmd_fast(void)
 	return (pmd_t *)ret;
 }
 
-static inline void free_pmd_fast(pmd_t *pmd)
+static inline void pmd_free_fast(pmd_t *pmd)
 {
 	*(unsigned long *)pmd = (unsigned long) pte_quicklist;
 	pte_quicklist = (unsigned long *) pmd;
 	pgtable_cache_size++;
 }
 
-static inline void free_pmd_slow(pmd_t *pmd)
+static inline void pmd_free_slow(pmd_t *pmd)
 {
 	free_page((unsigned long)pmd);
 }
 
-extern pte_t *get_pte_slow(pmd_t *pmd, unsigned long address_preadjusted);
+static inline pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL);
+	if (pte)
+		clear_page(pte);
+	return pte;
+}
 
-static inline pte_t *get_pte_fast(void)
+static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *ret;
 
@@ -308,66 +323,22 @@ static inline pte_t *get_pte_fast(void)
 	return (pte_t *)ret;
 }
 
-static inline void free_pte_fast(pte_t *pte)
+static inline void pte_free_fast(pte_t *pte)
 {
 	*(unsigned long *)pte = (unsigned long) pte_quicklist;
 	pte_quicklist = (unsigned long *) pte;
 	pgtable_cache_size++;
 }
 
-static inline void free_pte_slow(pte_t *pte)
+static inline void pte_free_slow(pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-extern void __bad_pte(pmd_t *pmd);
-extern void __bad_pmd(pgd_t *pgd);
-
-#define pte_free_kernel(pte)	free_pte_fast(pte)
-#define pte_free(pte)		free_pte_fast(pte)
-#define pmd_free_kernel(pmd)	free_pmd_fast(pmd)
-#define pmd_free(pmd)		free_pmd_fast(pmd)
+#define pte_free(pte)		pte_free_fast(pte)
+#define pmd_free(pmd)		pmd_free_fast(pmd)
 #define pgd_free(pgd)		free_pgd_fast(pgd)
 #define pgd_alloc()		get_pgd_fast()
-
-static inline pte_t * pte_alloc(pmd_t *pmd, unsigned long address)
-{
-	address = (address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
-	if (pmd_none(*pmd)) {
-		pte_t *page = get_pte_fast();
-		
-		if (!page)
-			return get_pte_slow(pmd, address);
-		pmd_set(pmd, page);
-		return page + address;
-	}
-	if (pmd_bad(*pmd)) {
-		__bad_pte(pmd);
-		return NULL;
-	}
-	return (pte_t *) pmd_page(*pmd) + address;
-}
-
-static inline pmd_t * pmd_alloc(pgd_t *pgd, unsigned long address)
-{
-	address = (address >> PMD_SHIFT) & (PTRS_PER_PMD - 1);
-	if (pgd_none(*pgd)) {
-		pmd_t *page = get_pmd_fast();
-		
-		if (!page)
-			return get_pmd_slow(pgd, address);
-		pgd_set(pgd, page);
-		return page + address;
-	}
-	if (pgd_bad(*pgd)) {
-		__bad_pmd(pgd);
-		return NULL;
-	}
-	return (pmd_t *) pgd_page(*pgd) + address;
-}
-
-#define pte_alloc_kernel	pte_alloc
-#define pmd_alloc_kernel	pmd_alloc
 
 extern int do_check_pgt_cache(int, int);
 
--- 2.4.3/arch/alpha/mm/init.c	Fri Mar 30 13:54:33 2001
+++ linux/arch/alpha/mm/init.c	Fri Mar 30 14:11:20 2001
@@ -43,20 +43,6 @@ struct thread_struct original_pcb;
 struct pgtable_cache_struct quicklists;
 #endif
 
-void
-__bad_pmd(pgd_t *pgd)
-{
-	printk("Bad pgd in pmd_alloc: %08lx\n", pgd_val(*pgd));
-	pgd_set(pgd, BAD_PAGETABLE);
-}
-
-void
-__bad_pte(pmd_t *pmd)
-{
-	printk("Bad pmd in pte_alloc: %08lx\n", pmd_val(*pmd));
-	pmd_set(pmd, (pte_t *) BAD_PAGETABLE);
-}
-
 pgd_t *
 get_pgd_slow(void)
 {
@@ -80,66 +66,26 @@ get_pgd_slow(void)
 	return ret;
 }
 
-pmd_t *
-get_pmd_slow(pgd_t *pgd, unsigned long offset)
-{
-	pmd_t *pmd;
-
-	pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
-	if (pgd_none(*pgd)) {
-		if (pmd) {
-			clear_page((void *)pmd);
-			pgd_set(pgd, pmd);
-			return pmd + offset;
-		}
-		pgd_set(pgd, BAD_PAGETABLE);
-		return NULL;
-	}
-	free_page((unsigned long)pmd);
-	if (pgd_bad(*pgd)) {
-		__bad_pmd(pgd);
-		return NULL;
-	}
-	return (pmd_t *) pgd_page(*pgd) + offset;
-}
-
-pte_t *
-get_pte_slow(pmd_t *pmd, unsigned long offset)
-{
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_page(GFP_KERNEL);
-	if (pmd_none(*pmd)) {
-		if (pte) {
-			clear_page((void *)pte);
-			pmd_set(pmd, pte);
-			return pte + offset;
-		}
-		pmd_set(pmd, (pte_t *) BAD_PAGETABLE);
-		return NULL;
-	}
-	free_page((unsigned long)pte);
-	if (pmd_bad(*pmd)) {
-		__bad_pte(pmd);
-		return NULL;
-	}
-	return (pte_t *) pmd_page(*pmd) + offset;
-}
-
 int do_check_pgt_cache(int low, int high)
 {
 	int freed = 0;
-        if(pgtable_cache_size > high) {
-                do {
-                        if(pgd_quicklist)
-                                free_pgd_slow(get_pgd_fast()), freed++;
-                        if(pmd_quicklist)
-                                free_pmd_slow(get_pmd_fast()), freed++;
-                        if(pte_quicklist)
-                                free_pte_slow(get_pte_fast()), freed++;
-                } while(pgtable_cache_size > low);
-        }
-        return freed;
+	if(pgtable_cache_size > high) {
+		do {
+			if(pgd_quicklist) {
+				free_pgd_slow(get_pgd_fast());
+				freed++;
+			}
+			if(pmd_quicklist) {
+				pmd_free_slow(pmd_alloc_one_fast(NULL, 0));
+				freed++;
+			}
+			if(pte_quicklist) {
+				pte_free_slow(pte_alloc_one_fast(NULL, 0));
+				freed++;
+			}
+		} while(pgtable_cache_size > low);
+	}
+	return freed;
 }
 
 /*
