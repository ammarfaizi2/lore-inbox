Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbTHCCNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 22:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270823AbTHCCNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 22:13:18 -0400
Received: from holomorphy.com ([66.224.33.161]:16870 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270818AbTHCCMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 22:12:52 -0400
Date: Sat, 2 Aug 2003 19:14:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm3
Message-ID: <20030803021405.GK8121@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030802152202.7d5a6ad1.akpm@osdl.org> <20030803001119.GF32488@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803001119.GF32488@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 03:22:02PM -0700, Andrew Morton wrote:
>> . Added Ingo's 4G/4G memory split patch.  It takes my kernel build from
>>   1:51 to 1:53 so gee.

On Sat, Aug 02, 2003 at 05:11:19PM -0700, William Lee Irwin III wrote:
> No idea who, if anyone, listened last time I answered questions on
> this. Sending in fixes shortly...

Alright, let's get people an idea of what I'm talking about:

(a) pgd_ctor() is called once per pgd _object_, not once per page.
	The code as posted does list_add() to the same page during
	the ctor calls, and list_del() to the same page during dtor
	calls when PAE is configured, for the precise reason that
	there are multiple PAE pgd's per page. This is why mbligh hit
	list poison. This patch restores the check for PTRS_PER_PMD == 1
	in order to avoid oopsing on list poison.

(b) The entire pgd_ctor business (apart from the AGP fix, which was
	actually no longer necessary once the rest was backed out) was
	essentially backed out, since all preconstruction was backed out.
	This restores the world to doing preconstruction as it should.

(c) clear_page_tables() only clears _userspace_ pmd's; pgd_free() isn't
	clearing the trampoline pmd entries for the kernel pmd. This
	patch separates out a slab for kernel pmd's to enforce the
	separation (or otherwise bitblitting) _required_ by slab
	preconstruction invariants and so fixes bad pmd bugs (I suppose
	no one's reported them yet; perhaps not enough pmd_bad() checks
	are around to catch them all or the ordering of allocations and
	frees tends to be just right to avoid it for some odd reason).

(d) The #ifdef-lessness was backed out. Since everything else had to be
	rearranged, this patch restores the #ifdef-lessness for free.
	(This is actually a moderately useful property, since it means
	all cases get compiletested regardless of .config).

(e) Either PAE or XKVA is enough to dodge needing pgd_lock and pgd_list
	entirely. Don't touch them in those cases.

So the below is what it should actually look like. I didn't bother
waiting to test because there's a whole matrix to run through and that's
going to take ages, and apparently something needs to be out there to
demonstrate the right way to do this faster than that.

Yes, I'm testing (and bugfixing) the below myself.


-- wli


diff -prauN mm3-2.6.0-test2-1/arch/i386/mm/init.c mm3-2.6.0-test2-2/arch/i386/mm/init.c
--- mm3-2.6.0-test2-1/arch/i386/mm/init.c	2003-08-02 16:40:15.000000000 -0700
+++ mm3-2.6.0-test2-2/arch/i386/mm/init.c	2003-08-02 18:53:47.000000000 -0700
@@ -515,11 +515,13 @@ void __init mem_init(void)
 	load_LDT(&init_mm.context);
 }
 
-kmem_cache_t *pgd_cache;
-kmem_cache_t *pmd_cache;
+kmem_cache_t *pgd_cache, *pmd_cache, *kpmd_cache;
 
 void __init pgtable_cache_init(void)
 {
+	void (*ctor)(void *, kmem_cache_t *, unsigned long);
+	void (*dtor)(void *, kmem_cache_t *, unsigned long);
+
 	if (PTRS_PER_PMD > 1) {
 		pmd_cache = kmem_cache_create("pmd",
 					PTRS_PER_PMD*sizeof(pmd_t),
@@ -529,13 +531,36 @@ void __init pgtable_cache_init(void)
 					NULL);
 		if (!pmd_cache)
 			panic("pgtable_cache_init(): cannot create pmd cache");
+
+		if (TASK_SIZE > PAGE_OFFSET) {
+			kpmd_cache = kmem_cache_create("kpmd",
+					PTRS_PER_PMD*sizeof(pmd_t),
+					0,
+					SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
+					kpmd_ctor,
+					NULL);
+			if (!kpmd_cache)
+				panic("pgtable_cache_init(): "
+						"cannot create kpmd cache");
+		}
 	}
+
+	if (PTRS_PER_PMD == 1 || TASK_SIZE <= PAGE_OFFSET)
+		ctor = pgd_ctor;
+	else
+		ctor = NULL;
+
+	if (PTRS_PER_PMD == 1 && TASK_SIZE <= PAGE_OFFSET)
+		dtor = pgd_dtor;
+	else
+		dtor = NULL;
+
 	pgd_cache = kmem_cache_create("pgd",
 				PTRS_PER_PGD*sizeof(pgd_t),
 				0,
 				SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
-				pgd_ctor,
-				pgd_dtor);
+				ctor,
+				dtor);
 	if (!pgd_cache)
 		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
diff -prauN mm3-2.6.0-test2-1/arch/i386/mm/pgtable.c mm3-2.6.0-test2-2/arch/i386/mm/pgtable.c
--- mm3-2.6.0-test2-1/arch/i386/mm/pgtable.c	2003-08-02 16:40:15.000000000 -0700
+++ mm3-2.6.0-test2-2/arch/i386/mm/pgtable.c	2003-08-02 18:53:36.000000000 -0700
@@ -158,6 +158,17 @@ void pmd_ctor(void *pmd, kmem_cache_t *c
 	memset(pmd, 0, PTRS_PER_PMD*sizeof(pmd_t));
 }
 
+void kpmd_ctor(void *__pmd, kmem_cache_t *cache, unsigned long flags)
+{
+	pmd_t *kpmd, *pmd;
+	kpmd = pmd_offset(&swapper_pg_dir[PTRS_PER_PGD-1],
+				(PTRS_PER_PMD - NR_SHARED_PMDS)*PMD_SIZE);
+	pmd = (pmd_t *)__pmd + (PTRS_PER_PMD - NR_SHARED_PMDS);
+				
+	memset(__pmd, 0, (PTRS_PER_PMD - NR_SHARED_PMDS)*sizeof(pmd_t));
+	memcpy(pmd, kpmd, NR_SHARED_PMDS*sizeof(pmd_t));
+}
+
 /*
  * List of all pgd's needed so it can invalidate entries in both cached
  * and uncached pgd's. This is essentially codepath-based locking
@@ -169,21 +180,60 @@ void pmd_ctor(void *pmd, kmem_cache_t *c
  * could be used. The locking scheme was chosen on the basis of
  * manfred's recommendations and having no core impact whatsoever.
  * -- wli
+ *
+ * The entire issue goes away when XKVA is configured.
  */
 spinlock_t pgd_lock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(pgd_list);
 
+/*
+ * This is not that hard to figure out.
+ * (a) PTRS_PER_PMD == 1 means non-PAE.
+ * (b) PTRS_PER_PMD > 1 means PAE.
+ * (c) TASK_SIZE > PAGE_OFFSET means XKVA.
+ * (d) TASK_SIZE <= PAGE_OFFSET means non-XKVA.
+ *
+ * Do *NOT* back out the preconstruction like the patch I'm cleaning
+ * up after this very instant did, or at all, for that matter.
+ * This is never called when PTRS_PER_PMD > 1 && TASK_SIZE > PAGE_OFFSET.
+ * -- wli
+ */
 void pgd_ctor(void *__pgd, kmem_cache_t *cache, unsigned long unused)
 {
+	pgd_t *pgd = (pgd_t *)__pgd;
 	unsigned long flags;
-	pgd_t *pgd0 = __pgd;
 
-	spin_lock_irqsave(&pgd_lock, flags);
-	list_add(&virt_to_page(pgd0)->lru, &pgd_list);
-	spin_unlock_irqrestore(&pgd_lock, flags);
+	if (PTRS_PER_PMD == 1) {
+		if (TASK_SIZE <= PAGE_OFFSET)
+			spin_lock_irqsave(&pgd_lock, flags);
+		else
+ 			memcpy(&pgd[PTRS_PER_PGD - NR_SHARED_PMDS],
+ 				&swapper_pg_dir[PTRS_PER_PGD - NR_SHARED_PMDS],
+ 				NR_SHARED_PMDS * sizeof(pgd_t));
+	}
+
+	if (TASK_SIZE <= PAGE_OFFSET)
+ 		memcpy(pgd + USER_PTRS_PER_PGD,
+ 			swapper_pg_dir + USER_PTRS_PER_PGD,
+ 			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+
+	if (PTRS_PER_PMD > 1)
+		return;
+
+	if (TASK_SIZE > PAGE_OFFSET)
+		memset(pgd, 0, (PTRS_PER_PGD - NR_SHARED_PMDS)*sizeof(pgd_t));
+	else {
+		list_add(&virt_to_page(pgd)->lru, &pgd_list);
+		spin_unlock_irqrestore(&pgd_lock, flags);
+		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
+	}
 }
 
-/* never called when PTRS_PER_PMD > 1 */
+/*
+ * Never called when PTRS_PER_PMD > 1 || TASK_SIZE > PAGE_OFFSET
+ * for with PAE we would list_del() multiple times, and for non-PAE
+ * with XKVA all the AGP pgd shootdown code is unnecessary.
+ */
 void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long unused)
 {
 	unsigned long flags; /* can be called from interrupt context */
@@ -193,87 +243,80 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
-#ifdef CONFIG_X86_PAE
-
+/*
+ * See the comments above pgd_ctor() wrt. preconstruction.
+ * Do *NOT* memcpy() here. If you do, you back out important
+ * anti- cache pollution code.
+ * 
+ */
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
 
-	if (pgd) {
-#ifdef CONFIG_X86_4G_VM_LAYOUT
-		pmd_t *pmd0, *kernel_pmd0;
-#endif
-		pmd_t *pmd;
+	if (PTRS_PER_PMD == 1 || !pgd)
+		return pgd;
 
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
-			pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
-			if (!pmd)
-				goto out_oom;
-			set_pgd(&pgd[i], __pgd(1 + __pa((u64)((u32)pmd))));
-		}
+	/*
+	 * In the 4G userspace case alias the top 16 MB virtual
+	 * memory range into the user mappings as well (these
+	 * include the trampoline and CPU data structures).
+	 */
+	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+		kmem_cache_t *cache;
+		pmd_t *pmd;
 
-#ifdef CONFIG_X86_4G_VM_LAYOUT
-		/*
-		 * In the 4G userspace case alias the top 16 MB virtual
-		 * memory range into the user mappings as well (these
-		 * include the trampoline and CPU data structures).
-		 */
-		pmd0 = pmd;
-		kernel_pmd0 = (pmd_t *)__va(pgd_val(swapper_pg_dir[PTRS_PER_PGD-1]) & PAGE_MASK);
-		memcpy(pmd0 + PTRS_PER_PMD - NR_SHARED_PMDS, kernel_pmd0 + PTRS_PER_PMD - NR_SHARED_PMDS, sizeof(pmd_t) * NR_SHARED_PMDS);
-#else
-		memcpy(pgd + USER_PTRS_PER_PGD,
-			swapper_pg_dir + USER_PTRS_PER_PGD,
-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-#endif
+		if (TASK_SIZE > PAGE_OFFSET && i == USER_PTRS_PER_PGD - 1)
+			cache = kpmd_cache;
+		else
+			cache = pmd_cache;
+
+		pmd = kmem_cache_alloc(cache, GFP_KERNEL);
+		if (!pmd)
+			goto out_oom;
+		set_pgd(&pgd[i], __pgd(1 + __pa((u64)((u32)pmd))));
 	}
+
 	return pgd;
 out_oom:
+	/*
+	 * we don't have to handle the kpmd_cache here, since it's the
+	 * last allocation, and has either nothing to free or when it
+	 * succeeds the whole operation succeeds.
+	 */
 	for (i--; i >= 0; i--)
 		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
 
-#else /* ! PAE */
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
-
-	if (pgd) {
-#ifdef CONFIG_X86_4G_VM_LAYOUT
-		memset(pgd, 0, PTRS_PER_PGD * sizeof(pgd_t));
-		/*
-		 * In the 4G userspace case alias the top 16 MB virtual
-		 * memory range into the user mappings as well (these
-		 * include the trampoline and CPU data structures).
-		 */
- 		memcpy(pgd + PTRS_PER_PGD-NR_SHARED_PMDS,
- 			swapper_pg_dir + PTRS_PER_PGD-NR_SHARED_PMDS,
- 			NR_SHARED_PMDS * sizeof(pgd_t));
-#else
- 		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
- 		memcpy(pgd + USER_PTRS_PER_PGD,
- 			swapper_pg_dir + USER_PTRS_PER_PGD,
- 			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-#endif
-	}
-	return pgd;
-}
-
-#endif /* CONFIG_X86_PAE */
-
 void pgd_free(pgd_t *pgd)
 {
 	int i;
 
-	/* in the PAE case user pgd entries are overwritten before usage */
-	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
+	if (PTRS_PER_PMD == 1)
+		goto out_free;
+
+	/* in the PAE case user pgd entries are overwritten before usage */
+	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+		kmem_cache_t *cache;
+		pmd_t *pmd = __va(pgd_val(pgd[i]) - 1);
+
+		/*
+		 * only userspace pmd's are cleared for us
+		 * by mm/memory.c; it's a slab cache invariant
+		 * that we must separate the kernel pmd slab
+		 * all times, else we'll have bad pmd's.
+		 */
+		if (TASK_SIZE > PAGE_OFFSET && i == USER_PTRS_PER_PGD - 1)
+			cache = kpmd_cache;
+		else
+			cache = pmd_cache;
+
+		kmem_cache_free(cache, pmd);
+	}
+out_free:
 	kmem_cache_free(pgd_cache, pgd);
 }
 
diff -prauN mm3-2.6.0-test2-1/include/asm-i386/pgtable.h mm3-2.6.0-test2-2/include/asm-i386/pgtable.h
--- mm3-2.6.0-test2-1/include/asm-i386/pgtable.h	2003-08-02 16:40:24.000000000 -0700
+++ mm3-2.6.0-test2-2/include/asm-i386/pgtable.h	2003-08-02 18:29:46.000000000 -0700
@@ -32,12 +32,12 @@
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 extern unsigned long empty_zero_page[1024];
 extern pgd_t swapper_pg_dir[1024];
-extern kmem_cache_t *pgd_cache;
-extern kmem_cache_t *pmd_cache;
+extern kmem_cache_t *pgd_cache, *pmd_cache, *kpmd_cache;
 extern spinlock_t pgd_lock;
 extern struct list_head pgd_list;
 
 void pmd_ctor(void *, kmem_cache_t *, unsigned long);
+void kpmd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_dtor(void *, kmem_cache_t *, unsigned long);
 void pgtable_cache_init(void);
