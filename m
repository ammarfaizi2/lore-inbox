Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131584AbRCXGjR>; Sat, 24 Mar 2001 01:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131586AbRCXGjI>; Sat, 24 Mar 2001 01:39:08 -0500
Received: from ns1.samba.org ([203.17.0.92]:41313 "HELO au2.samba.org")
	by vger.kernel.org with SMTP id <S131584AbRCXGiz>;
	Sat, 24 Mar 2001 01:38:55 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15036.16299.562638.515233@argo.linuxcare.com.au>
Date: Sat, 24 Mar 2001 17:33:15 +1100 (EST)
To: torvalds@transmeta.com
Cc: cort@fsmlabs.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MM update for PPC
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The patch below updates the MM code for PowerPC to correspond with the
recent generic MM changes.  The patch is against 2.4.3-pre7, and it
affects only arch/ppc/mm/init.c, include/asm-ppc/pgalloc.h, and
include/asm-ppc/semaphore.h.

The changes to semaphore.h are only necessary because the definition
of INIT_MM in sched.h uses __RWSEM_INITIALIZER with the argument of
RW_LOCK_BIAS, meaning an unlocked semaphore.  I think RW_LOCK_BIAS is
at the very least a horrible name for something that means an unlocked
semaphore, and in fact it is really a private definition used in the
i386 semaphore code which should never be used in generic code like
this.  (But no I don't have a patch to fix this properly at the
moment.)

Paul.

diff -urN linux/arch/ppc/mm/init.c linuxppc_2_4/arch/ppc/mm/init.c
--- linux/arch/ppc/mm/init.c	Wed Mar 21 15:43:54 2001
+++ linuxppc_2_4/arch/ppc/mm/init.c	Thu Mar 22 10:39:23 2001
@@ -110,7 +110,7 @@
 #endif
 
 void MMU_init(void);
-static void *MMU_get_page(void);
+void *early_get_page(void);
 unsigned long prep_find_end_of_memory(void);
 unsigned long pmac_find_end_of_memory(void);
 unsigned long apus_find_end_of_memory(void);
@@ -125,7 +125,7 @@
 unsigned long m8260_find_end_of_memory(void);
 #endif /* CONFIG_8260 */
 static void mapin_ram(void);
-void map_page(unsigned long va, unsigned long pa, int flags);
+int map_page(unsigned long va, unsigned long pa, int flags);
 void set_phys_avail(unsigned long total_ram);
 extern void die_if_kernel(char *,struct pt_regs *,long);
 
@@ -206,41 +206,20 @@
 	pmd_val(*pmd) = (unsigned long) BAD_PAGETABLE;
 }
 
-pte_t *get_pte_slow(pmd_t *pmd, unsigned long offset)
-{
-        pte_t *pte;
-
-        if (pmd_none(*pmd)) {
-		if (!mem_init_done)
-			pte = (pte_t *) MMU_get_page();
-		else if ((pte = (pte_t *) __get_free_page(GFP_KERNEL)))
-			clear_page(pte);
-                if (pte) {
-                        pmd_val(*pmd) = (unsigned long)pte;
-                        return pte + offset;
-                }
-		pmd_val(*pmd) = (unsigned long)BAD_PAGETABLE;
-                return NULL;
-        }
-        if (pmd_bad(*pmd)) {
-                __bad_pte(pmd);
-                return NULL;
-        }
-        return (pte_t *) pmd_page(*pmd) + offset;
-}
-
 int do_check_pgt_cache(int low, int high)
 {
 	int freed = 0;
-	if(pgtable_cache_size > high) {
+	if (pgtable_cache_size > high) {
 		do {
-			if(pgd_quicklist)
-				free_pgd_slow(get_pgd_fast()), freed++;
-			if(pmd_quicklist)
-				free_pmd_slow(get_pmd_fast()), freed++;
-			if(pte_quicklist)
-				free_pte_slow(get_pte_fast()), freed++;
-		} while(pgtable_cache_size > low);
+                        if (pgd_quicklist) {
+				free_pgd_slow(get_pgd_fast());
+				freed++;
+			}
+			if (pte_quicklist) {
+				pte_free_slow(pte_alloc_one_fast());
+				freed++;
+			}
+		} while (pgtable_cache_size > low);
 	}
 	return freed;
 }
@@ -383,6 +362,7 @@
 __ioremap(unsigned long addr, unsigned long size, unsigned long flags)
 {
 	unsigned long p, v, i;
+	int err;
 
 	/*
 	 * Choose an address to map it to.
@@ -453,10 +433,20 @@
 		flags |= _PAGE_GUARDED;
 
 	/*
-	 * Is it a candidate for a BAT mapping?
+	 * Should check if it is a candidate for a BAT mapping
 	 */
-	for (i = 0; i < size; i += PAGE_SIZE)
-		map_page(v+i, p+i, flags);
+
+	spin_lock(&init_mm.page_table_lock);
+	err = 0;
+	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
+		err = map_page(v+i, p+i, flags);
+	spin_unlock(&init_mm.page_table_lock);
+	if (err) {
+		if (mem_init_done)
+			vfree((void *)v);
+		return NULL;
+	}
+
 out:
 	return (void *) (v + (addr & ~PAGE_MASK));
 }
@@ -492,7 +482,7 @@
 	return (pte_val(*pg) & PAGE_MASK) | (addr & ~PAGE_MASK);
 }
 
-void
+int
 map_page(unsigned long va, unsigned long pa, int flags)
 {
 	pmd_t *pd;
@@ -501,10 +491,13 @@
 	/* Use upper 10 bits of VA to index the first level map */
 	pd = pmd_offset(pgd_offset_k(va), va);
 	/* Use middle 10 bits of VA to index the second-level map */
-	pg = pte_alloc(pd, va);
+	pg = pte_alloc(&init_mm, pd, va);
+	if (pg == 0)
+		return -ENOMEM;
 	set_pte(pg, mk_pte_phys(pa & PAGE_MASK, __pgprot(flags)));
 	if (mem_init_done)
 		flush_hash_page(0, va);
+	return 0;
 }
 
 #ifndef CONFIG_8xx
@@ -830,21 +823,16 @@
 	}
 }
 
-/* In fact this is only called until mem_init is done. */
-static void __init *MMU_get_page(void)
+/* This is only called until mem_init is done. */
+void __init *early_get_page(void)
 {
 	void *p;
 
-	if (mem_init_done) {
-		p = (void *) __get_free_page(GFP_KERNEL);
-	} else if (init_bootmem_done) {
+	if (init_bootmem_done) {
 		p = alloc_bootmem_pages(PAGE_SIZE);
 	} else {
 		p = mem_pieces_find(PAGE_SIZE, PAGE_SIZE);
 	}
-	if (p == 0)
-		panic("couldn't get a page in MMU_get_page");
-	__clear_user(p, PAGE_SIZE);
 	return p;
 }
 
diff -urN linux/include/asm-ppc/pgalloc.h linuxppc_2_4/include/asm-ppc/pgalloc.h
--- linux/include/asm-ppc/pgalloc.h	Sun Nov 12 13:23:11 2000
+++ linuxppc_2_4/include/asm-ppc/pgalloc.h	Thu Mar 22 10:39:23 2001
@@ -52,48 +52,12 @@
 
 extern void __bad_pte(pmd_t *pmd);
 
-/* We don't use pmd cache, so this is a dummy routine */
-extern __inline__ pmd_t *get_pmd_fast(void)
-{
-	return (pmd_t *)0;
-}
-
-extern __inline__ void free_pmd_fast(pmd_t *pmd)
-{
-}
-
-extern __inline__ void free_pmd_slow(pmd_t *pmd)
-{
-}
-
-/*
- * allocating and freeing a pmd is trivial: the 1-entry pmd is
- * inside the pgd, so has no extra memory associated with it.
- */
-extern inline void pmd_free(pmd_t * pmd)
-{
-}
-
-extern inline pmd_t * pmd_alloc(pgd_t * pgd, unsigned long address)
-{
-	return (pmd_t *) pgd;
-}
-
-#define pmd_free_kernel		pmd_free
-#define pmd_alloc_kernel	pmd_alloc
-#define pte_alloc_kernel	pte_alloc
-
 extern __inline__ pgd_t *get_pgd_slow(void)
 {
-	pgd_t *ret, *init;
-	/*if ( (ret = (pgd_t *)get_zero_page_fast()) == NULL )*/
-	if ( (ret = (pgd_t *)__get_free_page(GFP_KERNEL)) != NULL )
-		memset (ret, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-	if (ret) {
-		init = pgd_offset(&init_mm, 0);
-		memcpy (ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-	}
+	pgd_t *ret;
+
+	if ((ret = (pgd_t *)__get_free_page(GFP_KERNEL)) != NULL)
+		clear_page(ret);
 	return ret;
 }
 
@@ -122,9 +86,34 @@
 	free_page((unsigned long)pgd);
 }
 
-extern pte_t *get_pte_slow(pmd_t *pmd, unsigned long address_preadjusted);
+#define pgd_free(pgd)		free_pgd_fast(pgd)
+#define pgd_alloc()		get_pgd_fast()
+
+/*
+ * We don't have any real pmd's, and this code never triggers because
+ * the pgd will always be present..
+ */
+#define pmd_alloc_one_fast()            ({ BUG(); ((pmd_t *)1); })
+#define pmd_alloc_one()                 ({ BUG(); ((pmd_t *)2); })
+#define pmd_free(x)                     do { } while (0)
+#define pgd_populate(pmd, pte)          BUG()
+
+static inline pte_t *pte_alloc_one(void)
+{
+	pte_t *pte;
+	extern int mem_init_done;
+	extern void *early_get_page(void);
+
+	if (mem_init_done)
+		pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	else
+		pte = (pte_t *) early_get_page();
+	if (pte != NULL)
+		clear_page(pte);
+	return pte;
+}
 
-extern __inline__ pte_t *get_pte_fast(void)
+static inline pte_t *pte_alloc_one_fast(void)
 {
         unsigned long *ret;
 
@@ -136,40 +125,21 @@
         return (pte_t *)ret;
 }
 
-extern __inline__ void free_pte_fast(pte_t *pte)
+extern __inline__ void pte_free_fast(pte_t *pte)
 {
         *(unsigned long **)pte = pte_quicklist;
         pte_quicklist = (unsigned long *) pte;
         pgtable_cache_size++;
 }
 
-extern __inline__ void free_pte_slow(pte_t *pte)
+extern __inline__ void pte_free_slow(pte_t *pte)
 {
 	free_page((unsigned long)pte);
 }
 
-#define pte_free_kernel(pte)    free_pte_fast(pte)
-#define pte_free(pte)           free_pte_fast(pte)
-#define pgd_free(pgd)           free_pgd_fast(pgd)
-#define pgd_alloc()             get_pgd_fast()
-
-extern inline pte_t * pte_alloc(pmd_t * pmd, unsigned long address)
-{
-	address = (address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
-	if (pmd_none(*pmd)) {
-		pte_t * page = (pte_t *) get_pte_fast();
-		
-		if (!page)
-			return get_pte_slow(pmd, address);
-		pmd_val(*pmd) = (unsigned long) page;
-		return page + address;
-	}
-	if (pmd_bad(*pmd)) {
-		__bad_pte(pmd);
-		return NULL;
-	}
-	return (pte_t *) pmd_page(*pmd) + address;
-}
+#define pte_free(pte)    pte_free_slow(pte)
+
+#define pmd_populate(pmd, pte)	(pmd_val(*(pmd)) = (unsigned long) (pte))
 
 extern int do_check_pgt_cache(int, int);
 
diff -urN linux/include/asm-ppc/semaphore.h linuxppc_2_4/include/asm-ppc/semaphore.h
--- linux/include/asm-ppc/semaphore.h	Wed Mar 21 15:44:07 2001
+++ linuxppc_2_4/include/asm-ppc/semaphore.h	Thu Mar 22 10:39:23 2001
@@ -119,20 +119,21 @@
 #endif
 };
 
-#define __RWSEM_INITIALIZER(name, rd, wr)		\
+#define RW_LOCK_BIAS	2	/* XXX bogus */
+#define __RWSEM_INITIALIZER(name, count)		\
 {							\
 	SPIN_LOCK_UNLOCKED,				\
-	(rd), (wr),					\
+	(count) == 1, (count) == 0,			\
 	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 	__SEM_DEBUG_INIT(name)				\
 }
 
-#define __DECLARE_RWSEM_GENERIC(name, rd, wr)		\
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name, rd, wr)
+#define __DECLARE_RWSEM_GENERIC(name, count)		\
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name, count)
 
-#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name, 0, 0)
-#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name, 1, 0)
-#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name, 0, 1)
+#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name, RW_LOCK_BIAS)
+#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name, RW_LOCK_BIAS-1)
+#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name, 0)
 
 extern inline void init_rwsem(struct rw_semaphore *sem)
 {
