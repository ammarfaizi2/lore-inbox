Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUEYRtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUEYRtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUEYRtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:49:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:23478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265005AbUEYRtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:49:35 -0400
Date: Tue, 25 May 2004 10:49:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: wesolows@foobazco.org, willy@debian.org, andrea@suse.de,
       benh@kernel.crashing.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu, bcrl@kvack.org, linux-mm@kvack.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525102547.35207879.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525153501.GA19465@foobazco.org>
 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org> <20040525102547.35207879.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, David S. Miller wrote:
> 
> Not true on 32-bit Sparc sun4m systems, it's exactly like i386 except
> the hardware is stupid and we only have an atomic swap instruction.
> :-)

Ouch.

Ok. My second suggestion ("don't bother with accessed bit on hw that does 
it on its own") should work fine there too, I guess.

So what I can tell, the fix is really something like this (this does both 
x86 and ppc64 just to show how two different approaches would handle it, 
but I have literally _tested_ neither).

What do people think?

Ben, does this fix your problem? Does my ppc64 assembly code look sane? 
Shamelessly stolen from the function above it, and it seems to compile ;)

		Linus

-----
===== include/asm-generic/pgtable.h 1.3 vs edited =====
--- 1.3/include/asm-generic/pgtable.h	Sun Jan 18 22:35:59 2004
+++ edited/include/asm-generic/pgtable.h	Tue May 25 10:39:38 2004
@@ -10,9 +10,9 @@
  *
  * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
  */
-#define ptep_establish(__vma, __address, __ptep, __entry)		\
+#define ptep_establish(__vma, __address, __ptep, __entry, __dirty)	\
 do {									\
-	set_pte(__ptep, __entry);					\
+	ptep_update_dirty_accessed(__ptep, __entry, __dirty);		\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
 #endif
===== include/asm-i386/pgtable.h 1.44 vs edited =====
--- 1.44/include/asm-i386/pgtable.h	Sat May 22 14:56:24 2004
+++ edited/include/asm-i386/pgtable.h	Tue May 25 10:39:56 2004
@@ -225,6 +225,12 @@
 static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, &ptep->pte_low); }
 static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
 
+static inline void ptep_update_dirty_accessed(pte_t *ptep, pte_t entry, int dirty)
+{
+	if (dirty)
+		set_pte(ptep, entry);
+}
+
 /*
  * Macro to mark a page protection value as "uncacheable".  On processors which do not support
  * it, this is a no-op.
===== include/asm-ppc64/pgtable.h 1.33 vs edited =====
--- 1.33/include/asm-ppc64/pgtable.h	Sat May 22 14:56:24 2004
+++ edited/include/asm-ppc64/pgtable.h	Tue May 25 10:45:58 2004
@@ -306,6 +306,21 @@
 	return old;
 }
 
+static inline void ptep_update_dirty_accessed(pte_t *p, pte_t entry, int dirty)
+{
+	unsigned long old, tmp;
+
+	__asm__ __volatile__(
+	"1:	ldarx   %0,0,%3\n\
+	or	%1,%0,%4 \n\
+	stdcx.	%1,0,%3 \n\
+	bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*p)
+	: "r" (p), "r" (pte_val(entry)), "m" (*p)
+	: "cc" );
+}
+
+
 /* PTE updating functions */
 extern void hpte_update(pte_t *ptep, unsigned long pte, int wrprot);
 
===== mm/memory.c 1.176 vs edited =====
--- 1.176/mm/memory.c	Sat May 22 14:56:30 2004
+++ edited/mm/memory.c	Tue May 25 10:37:19 2004
@@ -1004,7 +1004,7 @@
 	flush_cache_page(vma, address);
 	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
 			      vma);
-	ptep_establish(vma, address, page_table, entry);
+	ptep_establish(vma, address, page_table, entry, 1);
 	update_mmu_cache(vma, address, entry);
 }
 
@@ -1056,7 +1056,7 @@
 			flush_cache_page(vma, address);
 			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
 					      vma);
-			ptep_establish(vma, address, page_table, entry);
+			ptep_establish(vma, address, page_table, entry, 1);
 			update_mmu_cache(vma, address, entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
@@ -1646,7 +1646,7 @@
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	ptep_establish(vma, address, pte, entry);
+	ptep_establish(vma, address, pte, entry, write_access);
 	update_mmu_cache(vma, address, entry);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
