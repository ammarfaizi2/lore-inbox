Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265614AbUE1B32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265614AbUE1B32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 21:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUE1B31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 21:29:27 -0400
Received: from palrel11.hp.com ([156.153.255.246]:4307 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265614AbUE1B3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 21:29:24 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16566.38385.890086.935337@napali.hpl.hp.com>
Date: Thu, 27 May 2004 18:29:21 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 implementation of ptep_set_access_flags
In-Reply-To: <Pine.LNX.4.58.0405260756590.1929@ppc970.osdl.org>
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
	<1085554527.7835.59.camel@gaston>
	<1085555491.7835.61.camel@gaston>
	<Pine.LNX.4.58.0405260756590.1929@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 26 May 2004 08:22:35 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> said:

  Linus> What I did was to basically split up the old
  Linus> "ptep_establish()" into a new "ptep_establish()" that is only
  Linus> used for COW, and your "ptep_update_accessed_bits()", which
  Linus> is used for the other cases.

Below is an update for ia64.  I hope I didn't miss anything.

	--david

ia64: Implement race-free ptep_set_access_flags()

Signed-off-by: davidm@hpl.hp.com

===== include/asm-ia64/pgtable.h 1.40 vs edited =====
--- 1.40/include/asm-ia64/pgtable.h	Sat May 22 14:56:24 2004
+++ edited/include/asm-ia64/pgtable.h	Thu May 27 17:12:04 2004
@@ -8,7 +8,7 @@
  * This hopefully works with any (fixed) IA-64 page-size, as defined
  * in <asm/page.h> (currently 8192).
  *
- * Copyright (C) 1998-2003 Hewlett-Packard Co
+ * Copyright (C) 1998-2004 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
@@ -475,6 +475,42 @@
  * flushing that may be necessary.
  */
 extern void update_mmu_cache (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);
+
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+/*
+ * Update PTEP with ENTRY, which is guaranteed to be a less
+ * restrictive PTE.  That is, ENTRY may have the ACCESSED, DIRTY, and
+ * WRITABLE bits turned on, when the value at PTEP did not.  The
+ * WRITABLE bit may only be turned if SAFELY_WRITABLE is TRUE.
+ *
+ * SAFELY_WRITABLE is TRUE if we can update the value at PTEP without
+ * having to worry about races.  On SMP machines, there are only two
+ * cases where this is true:
+ *
+ *	(1) *PTEP has the PRESENT bit turned OFF
+ *	(2) ENTRY has the DIRTY bit turned ON
+ *
+ * On ia64, we could implement this routine with a cmpxchg()-loop
+ * which ORs in the _PAGE_A/_PAGE_D bit if they're set in ENTRY.
+ * However, like on x86, we can get a more streamlined version by
+ * observing that it is OK to drop ACCESSED bit updates when
+ * SAFELY_WRITABLE is FALSE.  Besides being rare, all that would do is
+ * result in an extra Access-bit fault, which would then turn on the
+ * ACCESSED bit in the low-level fault handler (iaccess_bit or
+ * daccess_bit in ivt.S).
+ */
+#ifdef CONFIG_SMP
+# define ptep_set_access_flags(__vma, __addr, __ptep, __entry, __safely_writable)	\
+do {											\
+	if (__safely_writable) {							\
+		set_pte(__ptep, __entry);						\
+		flush_tlb_page(__vma, __addr);						\
+	}										\
+} while (0)
+#else
+# define ptep_set_access_flags(__vma, __addr, __ptep, __entry, __safely_writable)	\
+	ptep_establish(__vma, __addr, __ptep, __entry)
+#endif
 
 #  ifdef CONFIG_VIRTUAL_MEM_MAP
   /* arch mem_map init routine is needed due to holes in a virtual mem_map */
