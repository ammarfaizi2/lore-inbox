Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265298AbUEZD3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUEZD3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 23:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbUEZD3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 23:29:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:62087 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265296AbUEZD24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 23:28:56 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405251749500.9951@ppc970.osdl.org>
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
Content-Type: text/plain
Message-Id: <1085541906.14969.412.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 13:25:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 10:50, Linus Torvalds wrote: 
> On Wed, 26 May 2004, Benjamin Herrenschmidt wrote:
> > 
> > Heh, I can still send a patch "fixing" it if you want ;)
> 
> If you include a tested version of the ppc64 fix, I'd likely apply that.

Ok, that doesn't work. Trigger BUG_ON in rmap.c:421

I think we are using ptep_establish for more than just setting those
2 bits (like for setting up the new PTE in break_cow and such while
the current implementationL/definition is more like just setting
those bits and nothing else....

If we end up doing more than setting those bits, we need to flush the
PTE completely from the hash etc....

Anyway, here's the non working patch, including the rename.

Ben.

===== include/asm-generic/pgtable.h 1.5 vs edited =====
--- 1.5/include/asm-generic/pgtable.h	2004-05-26 06:04:54 +10:00
+++ edited/include/asm-generic/pgtable.h	2004-05-26 10:58:17 +10:00
@@ -3,8 +3,8 @@
 
 #ifndef __HAVE_ARCH_PTEP_ESTABLISH
 
-#ifndef ptep_update_dirty_accessed
-#define ptep_update_dirty_accessed(__ptep, __entry, __dirty) set_pte(__ptep, __entry)
+#ifndef ptep_set_dirty_accessed
+#define ptep_set_dirty_accessed(__ptep, __entry, __dirty) set_pte(__ptep, __entry)
 #endif
 
 /*
@@ -17,7 +17,7 @@
  */
 #define ptep_establish(__vma, __address, __ptep, __entry, __dirty)	\
 do {									\
-	ptep_update_dirty_accessed(__ptep, __entry, __dirty);		\
+	ptep_set_dirty_accessed(__ptep, __entry, __dirty);		\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
 #endif
===== include/asm-i386/pgtable.h 1.45 vs edited =====
--- 1.45/include/asm-i386/pgtable.h	2004-05-26 06:04:54 +10:00
+++ edited/include/asm-i386/pgtable.h	2004-05-26 10:59:12 +10:00
@@ -325,7 +325,7 @@
  * bit at the same time.
  */
 #define update_mmu_cache(vma,address,pte) do { } while (0)
-#define ptep_update_dirty_accessed(__ptep, __entry, __dirty)	\
+#define ptep_set_dirty_accessed(__ptep, __entry, __dirty)	\
 	do {							\
 		if (__dirty) set_pte(__ptep, __entry);		\
 	} while (0)
===== include/asm-ppc64/pgtable.h 1.33 vs edited =====
--- 1.33/include/asm-ppc64/pgtable.h	2004-05-23 07:56:24 +10:00
+++ edited/include/asm-ppc64/pgtable.h	2004-05-26 13:09:59 +10:00
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
+static inline void ptep_set_dirty_accessed(pte_t *ptep, pte_t entry, int dirty)
+{
+	unsigned long bits = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED);
+	unsigned long tmp;
+
+	WARN_ON(!pte_present(*ptep));
+
+	__asm__ __volatile__(
+	       "1:     ldarx   %0,0,%3\n\
+                or      %0,%2,%0\n\
+                stdcx.  %0,0,%3\n\
+                bne-    1b"
+	:"=&r" (tmp), "=m" (*ptep)
+	:"r" (bits), "r" (ptep)
+	:"cc");
+}
+
+/* Make asm-generic/pgtable.h know about it.. */
+#define ptep_set_dirty_accessed ptep_set_dirty_accessed
+
 
 /*
  * Macro to mark a page protection value as "uncacheable".


