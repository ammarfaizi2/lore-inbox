Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265328AbUEZG7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUEZG7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 02:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUEZG7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 02:59:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:41865 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265314AbUEZG72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 02:59:28 -0400
Subject: Re: [PATCH] (signoff) ppc64: Fix possible race with set_pte on a
	present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <1085551152.6320.38.camel@gaston>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	 <20040525153501.GA19465@foobazco.org>
	 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	 <20040525102547.35207879.davem@redhat.com>
	 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	 <20040525105442.2ebdc355.davem@redhat.com>
	 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
	 <1085521251.24948.127.camel@gaston>
	 <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
	 <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
	 <1085522860.15315.133.camel@gaston>
	 <Pine.LNX.4.58.0405251514200.9951@ppc970.osdl.org>
	 <1085530867.14969.143.camel@gaston>
	 <Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>
	 <1085541906.14969.412.camel@gaston>
	 <Pine.LNX.4.58.0405252031270.15534@ppc970.osdl.org>
	 <1085546780.5584.19.camel@gaston>
	 <Pine.LNX.4.58.0405252151100.15534@ppc970.osdl.org>
	 <1085551152.6320.38.camel@gaston>
Content-Type: text/plain
Message-Id: <1085554527.7835.59.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 16:55:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 15:59, Benjamin Herrenschmidt wrote:
> (Same with signoff :)
> 
> Ok, here it is. I blasted ptep_establish completely and the macro
> thing and changed the function to ptep_set_access_flags() which
> becomes also responsible for the flush if necesary.

Ok, ppc64 implementation is bogus, I just completely forgot that
we have to also atomically wait for busy to be cleared. (Or we
would race with the hash refill which does set busy atomically
at the beginning of the opertation, but later updates the linux
PTE non atomically & clears it).

Brown paper bag since I'm the one who implemented the hash refill
this way in the first place =P

Here's a fixed version:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- 1.5/include/asm-generic/pgtable.h	2004-05-26 06:04:54 +10:00
+++ edited/include/asm-generic/pgtable.h	2004-05-26 15:37:02 +10:00
@@ -1,24 +1,11 @@
 #ifndef _ASM_GENERIC_PGTABLE_H
 #define _ASM_GENERIC_PGTABLE_H
 
-#ifndef __HAVE_ARCH_PTEP_ESTABLISH
-
-#ifndef ptep_update_dirty_accessed
-#define ptep_update_dirty_accessed(__ptep, __entry, __dirty) set_pte(__ptep, __entry)
-#endif
-
-/*
- * Establish a new mapping:
- *  - flush the old one
- *  - update the page tables
- *  - inform the TLB about the new one
- *
- * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
- */
-#define ptep_establish(__vma, __address, __ptep, __entry, __dirty)	\
-do {									\
-	ptep_update_dirty_accessed(__ptep, __entry, __dirty);		\
-	flush_tlb_page(__vma, __address);				\
+#ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+do {				  					  \
+	set_pte(__ptep, __entry);					  \
+	flush_tlb_page(__vma, __address);				  \
 } while (0)
 #endif
 
===== include/asm-i386/pgtable.h 1.45 vs edited =====
--- 1.45/include/asm-i386/pgtable.h	2004-05-26 06:04:54 +10:00
+++ edited/include/asm-i386/pgtable.h	2004-05-26 15:34:57 +10:00
@@ -325,9 +325,13 @@
  * bit at the same time.
  */
 #define update_mmu_cache(vma,address,pte) do { } while (0)
-#define ptep_update_dirty_accessed(__ptep, __entry, __dirty)	\
-	do {							\
-		if (__dirty) set_pte(__ptep, __entry);		\
+#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+	do {								  \
+		if (__dirty) {						  \
+			set_pte(__ptep, __entry);		  	  \
+			flush_tlb_page(__vma, __address);		  \
+		}							  \
 	} while (0)
 
 /* Encode and de-code a swap entry */
===== include/asm-ppc64/pgtable.h 1.33 vs edited =====
--- 1.33/include/asm-ppc64/pgtable.h	2004-05-23 07:56:24 +10:00
+++ edited/include/asm-ppc64/pgtable.h	2004-05-26 16:47:05 +10:00
@@ -306,7 +306,10 @@
 	return old;
 }
 
-/* PTE updating functions */
+/* PTE updating functions, this function puts the PTE in the
+ * batch, doesn't actually triggers the hash flush immediately,
+ * you need to call flush_tlb_pending() to do that.
+ */
 extern void hpte_update(pte_t *ptep, unsigned long pte, int wrprot);
 
 static inline int ptep_test_and_clear_young(pte_t *ptep)
@@ -318,7 +321,7 @@
 	old = pte_update(ptep, _PAGE_ACCESSED);
 	if (old & _PAGE_HASHPTE) {
 		hpte_update(ptep, old, 0);
-		flush_tlb_pending();	/* XXX generic code doesn't flush */
+		flush_tlb_pending();
 	}
 	return (old & _PAGE_ACCESSED) != 0;
 }
@@ -396,10 +399,36 @@
  */
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	if (pte_present(*ptep))
+	if (pte_present(*ptep)) {
 		pte_clear(ptep);
+		flush_tlb_pending();
+	}
 	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS;
 }
+
+/* Set the dirty and/or accessed bits atomically in a linux PTE, this
+ * function doesn't need to flush the hash entry
+ */
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
+{
+	unsigned long bits = pte_val(entry) &
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
+	unsigned long old, tmp;
+
+	__asm__ __volatile__(
+        "1:     ldarx   %0,0,%4\n\
+	        andi.	%1,%0,%6\n\
+	        bne-	1b \n\
+                or      %0,%3,%0\n\
+                stdcx.  %0,0,%4\n\
+                bne-    1b"
+	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
+	:"r" (bits), "r" (ptep), "m" (ptep), "i" (_PAGE_BUSY)
+	:"cc");
+}
+#define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+        __ptep_set_access_flags(__ptep, __entry, __dirty)
 
 /*
  * Macro to mark a page protection value as "uncacheable".
===== mm/memory.c 1.177 vs edited =====
--- 1.177/mm/memory.c	2004-05-26 05:37:09 +10:00
+++ edited/mm/memory.c	2004-05-26 15:35:40 +10:00
@@ -1004,7 +1004,11 @@
 	flush_cache_page(vma, address);
 	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
 			      vma);
-	ptep_establish(vma, address, page_table, entry, 1);
+
+	/* Get rid of the old entry, replace with new */
+	ptep_clear_flush(vma, address, page_table);
+	set_pte(page_table, entry);
+
 	update_mmu_cache(vma, address, entry);
 }
 
@@ -1056,7 +1060,7 @@
 			flush_cache_page(vma, address);
 			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
 					      vma);
-			ptep_establish(vma, address, page_table, entry, 1);
+       			ptep_set_access_flags(vma, address, page_table, entry, 1);
 			update_mmu_cache(vma, address, entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
@@ -1646,7 +1650,7 @@
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	ptep_establish(vma, address, pte, entry, write_access);
+	ptep_set_access_flags(vma, address, pte, entry, write_access);
 	update_mmu_cache(vma, address, entry);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);


