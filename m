Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265749AbUGHFT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbUGHFT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUGHFT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:19:28 -0400
Received: from palrel10.hp.com ([156.153.255.245]:43708 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265749AbUGHFTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:19:18 -0400
Message-ID: <16620.55635.184205.91365@napali.hpl.hp.com>
Date: Wed, 7 Jul 2004 22:19:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <200407072047.i67KlXk5028719@magilla.sf.frob.com>
References: <16620.16241.664033.493568@napali.hpl.hp.com>
	<200407072047.i67KlXk5028719@magilla.sf.frob.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
From: David Mosberger <davidm@napali.hpl.hp.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: Roland McGrath <roland@redhat.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: ptrace "fix" breaks ia64
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Oops, I promptly forgot to credit Peter Chubb for tracking down this bug.
 Mail below is unchanged except for the ChangeLog entry.]

>>>>> On Wed, 7 Jul 2004 13:47:33 -0700, Roland McGrath <roland@redhat.com> said:

  Roland> Sorry.  I skimmed all the code and comments for pgd_offset_k
  Roland> and thought at the time that it was strictly an optimized
  Roland> shortcut for pgd_offset.  Clearly I did not understand the
  Roland> ia64 code.

  >> I suppose we could have a new macro pgd_offset_gate() or
  >> something along those lines to accommodate platform-differences
  >> in where the gage page lives.

  Roland> That seems like the reasonable thing to do.  I considered
  Roland> just putting all that logic into arch-specific code, joining
  Roland> with the get_gate_vma code.  But that would leave x86_64
  Roland> requiring duplication of the generic version.  At least with
  Roland> the various arch cases around now, just adding
  Roland> pgd_offset_gate is the thing that will allow maximal code
  Roland> sharing.

The patch below fixes the problem for ia64 and should have no effect
on x86 or x86-64.  Just out of paranoia, I compiled-tested it on x86.

If it looks OK, please apply, Linus or Andrew.

Thanks,

	--david

---
Make get_user_pages() work again for ia64 gate area

Changeset

  roland@redhat.com[torvalds]|ChangeSet|20040624165002|30880

inadvertently broke ia64 because the patch assumed that pgd_offset_k()
is just an optimization of pgd_offset(), which it is not.  This patch
fixes the problem by introducing pgd_offset_gate().  On architectures
on which the gate area lives in the user's address-space, this should
be aliased to pgd_offset() and on architectures on which the gate area
lives in the kernel-mapped segment, this should be aliased to
pgd_offset_k().

This bug was found and tracked down by Peter Chubb.

Signed-off-by: davidm@hpl.hp.com

===== include/asm-generic/pgtable.h 1.6 vs edited =====
--- 1.6/include/asm-generic/pgtable.h	Wed May 26 07:56:17 2004
+++ edited/include/asm-generic/pgtable.h	Wed Jul  7 18:02:20 2004
@@ -122,4 +122,8 @@
 #define page_test_and_clear_young(page) (0)
 #endif
 
+#ifndef __HAVE_ARCH_PGD_OFFSET_GATE
+#define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
===== include/asm-ia64/pgtable.h 1.43 vs edited =====
--- 1.43/include/asm-ia64/pgtable.h	Sat Jun 19 07:48:59 2004
+++ edited/include/asm-ia64/pgtable.h	Wed Jul  7 18:03:55 2004
@@ -321,6 +321,11 @@
 #define pgd_offset_k(addr) \
 	(init_mm.pgd + (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)))
 
+/* Look up a pgd entry in the gate area.  On IA-64, the gate-area
+   resides in the kernel-mapped segment, hence we use pgd_offset_k()
+   here.  */
+#define pgd_offset_gate(mm, addr)	pgd_offset_k(addr)
+
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir,addr) \
 	((pmd_t *) pgd_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
@@ -552,6 +557,7 @@
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PGD_OFFSET_GATE
 #include <asm-generic/pgtable.h>
 
 #endif /* _ASM_IA64_PGTABLE_H */
===== mm/memory.c 1.148 vs edited =====
--- 1.148/mm/memory.c	Tue Jul  6 22:19:26 2004
+++ edited/mm/memory.c	Wed Jul  7 18:02:29 2004
@@ -727,7 +727,7 @@
 			pte_t *pte;
 			if (write) /* user gate pages are read-only */
 				return i ? : -EFAULT;
-			pgd = pgd_offset(mm, pg);
+			pgd = pgd_offset_gate(mm, pg);
 			if (!pgd)
 				return i ? : -EFAULT;
 			pmd = pmd_offset(pgd, pg);
