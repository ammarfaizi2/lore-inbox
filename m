Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWD0SdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWD0SdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWD0SdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:33:24 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:24595 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932415AbWD0SdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:33:23 -0400
Message-ID: <44510E3D.10201@vmware.com>
Date: Thu, 27 Apr 2006 11:32:29 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@osdl.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Hugh Dickins <hugh@veritas.com>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 1/2] I386 fix pte clear
References: <200604262203.k3QM3G9H009575@zach-dev.vmware.com> <4450AC7A.76E4.0078.0@novell.com>
In-Reply-To: <4450AC7A.76E4.0078.0@novell.com>
Content-Type: multipart/mixed;
 boundary="------------050401000108080705050202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050401000108080705050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Beulich wrote:
> Actually, wouldn't it seem necessary to also to the same adjustment to pmd_clear() then?
>
> Jan
>   
Yes, it would.  I have also fixed the barrier to be smp_wmb as Nick 
pointed out.  Please apply.


--------------050401000108080705050202
Content-Type: text/plain;
 name="i386-fix-pte-clear"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-fix-pte-clear"

Proposed fix for ptep_get_and_clear_full PAE bug.  Pte_clear had the same bug,
so use the same fix for both.  Turns out pmd_clear had it as well, but pgds
are not affected.

The problem is rather intricate.  Page table entries in PAE mode are 64-bits
wide, but the only atomic 8-byte write operation available in 32-bit mode is
cmpxchg8b, which is expensive (at least on P4), and thus avoided.  But it can
happen that the processor may prefetch entries into the TLB in the middle of an
operation which clears a page table entry.  So one must always clear the P-bit
in the low word of the page table entry first when clearing it.

Since the sequence *ptep = __pte(0) leaves the order of the write dependent on
the compiler, it must be coded explicitly as a clear of the low word followed
by a clear of the high word.  Further, there must be a write memory barrier
here to enforce proper ordering by the compiler (and, in the future, by the
processor as well).

On > 4GB memory machines, the implementation of pte_clear for PAE was clearly
deficient, as it could leave virtual mappings of physical memory above 4GB
aliased to memory below 4GB in the TLB.  The implementation of
ptep_get_and_clear_full has a similar bug, although not nearly as likely to
occur, since the mappings being cleared are in the process of being destroyed,
and should never be dereferenced again.

But, as luck would have it, it is possible to trigger bugs even without ever
dereferencing these bogus TLB mappings, even if the clear is followed fairly
soon after with a TLB flush or invalidation.  The problem is that memory above
4GB may now be aliased into the first 4GB of memory, and in fact, may hit a
region of memory with non-memory semantics.  These regions include AGP and PCI
space.  As such, these memory regions are not cached by the processor.  This
introduces the bug.

The processor can speculate memory operations, including memory writes, as long
as they are committed with the proper ordering.  Speculating a memory write to
a linear address that has a bogus TLB mapping is possible.  Normally, the
speculation is harmless.  But for cached memory, it does leave the falsely
speculated cacheline unmodified, but in a dirty state.  This cache line will be
eventually written back.  If this cacheline happens to intersect a region of
memory that is not protected by the cache coherency protocol, it can corrupt
data in I/O memory, which is generally a very bad thing to do, and can cause
total system failure or just plain undefined behavior.

These bugs are extremely unlikely, but the severity is of such magnitude, and
the fix so simple that I think fixing them immediately is justified.  Also,
they are nearly impossible to debug.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.17-rc/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/pgtable.h	2006-04-27 11:12:12.000000000 -0700
+++ linux-2.6.17-rc/include/asm-i386/pgtable.h	2006-04-27 11:14:01.000000000 -0700
@@ -204,12 +204,10 @@ extern unsigned long long __PAGE_KERNEL,
 extern unsigned long pg0[];
 
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
 /* To avoid harmful races, pmd_none(x) should check only the lower when PAE */
 #define pmd_none(x)	(!(unsigned long)pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 
@@ -268,7 +266,7 @@ static inline pte_t ptep_get_and_clear_f
 	pte_t pte;
 	if (full) {
 		pte = *ptep;
-		*ptep = __pte(0);
+		pte_clear(mm, addr, ptep);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
 	}
Index: linux-2.6.17-rc/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/pgtable-3level.h	2006-04-27 11:12:12.000000000 -0700
+++ linux-2.6.17-rc/include/asm-i386/pgtable-3level.h	2006-04-27 11:20:19.000000000 -0700
@@ -85,6 +85,26 @@ static inline void pud_clear (pud_t * pu
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
+/*
+ * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
+ * entry, so clear the bottom half first and enforce ordering with a compiler
+ * barrier.
+ */
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	ptep->pte_low = 0;
+	smp_wmb();
+	ptep->pte_high = 0;
+}
+
+static inline void pmd_clear(pmd_t *pmd)
+{
+	u32 *tmp = (u32 *)pmd;
+	*tmp = 0;
+	smp_wmb();
+	*(tmp + 1) = 0;
+}
+
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t res;
Index: linux-2.6.17-rc/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/pgtable-2level.h	2006-04-27 11:12:12.000000000 -0700
+++ linux-2.6.17-rc/include/asm-i386/pgtable-2level.h	2006-04-27 11:14:50.000000000 -0700
@@ -18,6 +18,9 @@
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
+
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))

--------------050401000108080705050202--
