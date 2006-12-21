Return-Path: <linux-kernel-owner+w=401wt.eu-S1423058AbWLUUCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423058AbWLUUCs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423075AbWLUUCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:02:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35850 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423058AbWLUUCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:02:46 -0500
Date: Thu, 21 Dec 2006 12:01:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: schwidefsky@de.ibm.com, Martin Michlmayr <tbm@cyrius.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1166692812.32117.2.camel@twins>
Message-ID: <Pine.LNX.4.64.0612211134370.3536@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <1166571749.10372.178.camel@twins>  <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
  <1166605296.10372.191.camel@twins>  <1166607554.3365.1354.camel@laptopd505.fenrus.org>
  <1166614001.10372.205.camel@twins>  <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
  <1166622979.10372.224.camel@twins>  <20061220170323.GA12989@deprecation.cyrius.com>
  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> 
 <20061220175309.GT30106@deprecation.cyrius.com>  <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
  <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>  <1166652901.30008.1.camel@twins>
  <Pine.LNX.4.64.0612201441030.3576@woody.osdl.org>  <1166655805.30008.18.camel@twins>
  <1166692586.27750.4.camel@localhost> <1166692812.32117.2.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2006, Peter Zijlstra wrote:
> 
> Also, I'm dubious about the while thing and stuck a WARN_ON(ret) thing
> at the beginning of the loop. flush_tlb_page() does IPI the other cpus
> to flush their tlb too, so there should not be a SMP race, Arjan?

Now, the reason I think the loop may be needed is:

	CPU#0				CPU#1
	-----				-----
					load old PTE entry
	clear dirty and WP bits
					write to page using old PTE
					NOT CHECKING that the new one
					is write-protected, and just
					setting the dirty bit blindly
					(but atomically)
	flush_tlb_page()
					TLB flushed, but we now have a
					page that is marked dirty and
					unwritable in the page tables,
					and we will mark it clean in
					"struct page *"

Now, the scary thing is, IF a CPU does this, then the way we do all this, 
we may actually have the following sequence:

	CPU#0				CPU#1
	-----				-----
					load old PTE entry
	ptep_clear_flush():
					atomic "set dirty bit" sequence
					PTEP now contains 0000040 !!!
	flush_tlb_page();
					TLB flushed, but PTEP is still 
					"dirty zero"
	write the clear/readonly PTE
					THE DIRTY BIT WAS LOST!

which might actually explain this bug.

I personally _thought_ that Intel CPU's don't actually do an "set dirty 
bit atomically" sequence, but more of a "set dirty bit but trap if the TLB 
is nonpresent" thing, but I have absolutely no proof for that.

Anyway, IF this is the case, then the following patch may or may not fix 
things. It avoids things by never overwriting a PTE entry, not even the 
"cleared" one. It always does an atomic "xchg()" with a valid new entry, 
and looks at the old bits.

What do you guys think? Does something like this work out for S/390 too? I 
tried to make that "ptep_flush_dirty()" concept work for architectures 
that hide the dirty bit somewhere else too, but..

It actually simplifies the architecture-specific code (you just need to 
implement a trivial "ptep_exchange()" and "ptep_flush_dirty()" macro), but 
I only did x86-64 and i386, and while I've booted with this, I haven't 
really given the thing a lot of really _deep_ thought.

But I think this might be safer, as per above.. And it _might_ actually 
explain the problem. Exactly because the "ptep_clear() + blindly assign to 
ptep" might lose a dirty bit that was written by another CPU.

But this really does depend on what a CPU does when it marks a page dirty. 
Does it just blindly write the dirty bit? Or does it actually _validate_ 
that the old page table entry was still present and writable?

This patch makes no assumptions. It should work even if a CPU just writes 
the dirty bit blindly, and the only expectation is that the page tables 
can be accessed atomically (which had _better_ be true on any SMP 
architecture)

Arjan, can you please check within Intel, and ask what the "proper" 
sequence for doing something like this is?

			Linus

----
commit 301d2d53ca0e5d2f61b1c1c259da410c7ee6d6a7
Author: Linus Torvalds <torvalds@woody.osdl.org>
Date:   Thu Dec 21 11:11:05 2006 -0800

    Rewrite the page table "clear dirty and writable" accesses
    
    This is much simpler for most architectures, and allows us to do the
    dirty and writable clear in a single operation without any races or any
    double flushes.
    
    It's also much more careful: we never overwrite the old dirty bits at
    any time, and always make sure to do atomic memory ops to exchange and
    see the old value.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 9d774d0..8879f1d 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -61,31 +61,6 @@ do {				  					  \
 })
 #endif
 
-#ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-#define ptep_test_and_clear_dirty(__vma, __address, __ptep)		\
-({									\
-	pte_t __pte = *__ptep;						\
-	int r = 1;							\
-	if (!pte_dirty(__pte))						\
-		r = 0;							\
-	else								\
-		set_pte_at((__vma)->vm_mm, (__address), (__ptep),	\
-			   pte_mkclean(__pte));				\
-	r;								\
-})
-#endif
-
-#ifndef __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
-#define ptep_clear_flush_dirty(__vma, __address, __ptep)		\
-({									\
-	int __dirty;							\
-	__dirty = ptep_test_and_clear_dirty(__vma, __address, __ptep);	\
-	if (__dirty)							\
-		flush_tlb_page(__vma, __address);			\
-	__dirty;							\
-})
-#endif
-
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear(__mm, __address, __ptep)			\
 ({									\
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
index e6a4723..b61d6f9 100644
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -300,18 +300,20 @@ do {									\
 	flush_tlb_page(vma, address);					\
 } while (0)
 
-#define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
-#define ptep_clear_flush_dirty(vma, address, ptep)			\
-({									\
-	int __dirty;							\
-	__dirty = pte_dirty(*(ptep));					\
-	if (__dirty) {							\
-		clear_bit(_PAGE_BIT_DIRTY, &(ptep)->pte_low);		\
-		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
-		flush_tlb_page(vma, address);				\
-	}								\
-	__dirty;							\
-})
+/*
+ * "ptep_exchange()" can be used to atomically change a set of
+ * page table protection bits, returning the old ones (the dirty
+ * and accessed bits in particular, since they are set by hw).
+ *
+ * "ptep_flush_dirty()" then returns the dirty status of the
+ * page (on x86-64, we just look at the dirty bit in the returned
+ * pte, but some other architectures have the dirty bits in
+ * other places than the page tables).
+ */
+#define ptep_exchange(vma, address, ptep, old, new) \
+	(old).pte_low = xchg(&(ptep)->pte_low, (new).pte_low);
+#define ptep_flush_dirty(vma, address, ptep, old) \
+	pte_dirty(old)
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(vma, address, ptep)			\
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index 59901c6..07754b5 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -283,12 +283,20 @@ static inline pte_t pte_clrhuge(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) &
 
 struct vm_area_struct;
 
-static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
-{
-	if (!pte_dirty(*ptep))
-		return 0;
-	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte);
-}
+/*
+ * "ptep_exchange()" can be used to atomically change a set of
+ * page table protection bits, returning the old ones (the dirty
+ * and accessed bits in particular, since they are set by hw).
+ *
+ * "ptep_flush_dirty()" then returns the dirty status of the
+ * page (on x86-64, we just look at the dirty bit in the returned
+ * pte, but some other architectures have the dirty bits in
+ * other places than the page tables).
+ */
+#define ptep_exchange(vma, address, ptep, old, new) \
+	(old).pte = xchg(&(ptep)->pte, (new).pte);
+#define ptep_flush_dirty(vma, address, ptep, old) \
+	pte_dirty(old)
 
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index d8a842a..a028803 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -432,7 +432,7 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t *pte, entry;
+	pte_t *ptep;
 	spinlock_t *ptl;
 	int ret = 0;
 
@@ -440,22 +440,24 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address, &ptl);
-	if (!pte)
-		goto out;
-
-	if (!pte_dirty(*pte) && !pte_write(*pte))
-		goto unlock;
-
-	entry = ptep_get_and_clear(mm, address, pte);
-	entry = pte_mkclean(entry);
-	entry = pte_wrprotect(entry);
-	ptep_establish(vma, address, pte, entry);
-	lazy_mmu_prot_update(entry);
-	ret = 1;
-
-unlock:
-	pte_unmap_unlock(pte, ptl);
+	ptep = page_check_address(page, mm, address, &ptl);
+	if (ptep) {
+		pte_t old, new;
+
+		old = *ptep;
+		new = pte_wrprotect(pte_mkclean(old));
+		if (!pte_same(old, new)) {
+			for (;;) {
+				flush_cache_page(vma, address, page_to_pfn(page));
+				ptep_exchange(vma, address, ptep, old, new);
+				if (pte_same(old, new))
+					break;
+				ret |= ptep_flush_dirty(vma, address, ptep, old);
+				flush_tlb_page(vma, address);
+			}
+		}
+		pte_unmap_unlock(pte, ptl);
+	}
 out:
 	return ret;
 }
