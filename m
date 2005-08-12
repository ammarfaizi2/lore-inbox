Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVHLSVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVHLSVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVHLSVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:21:46 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:47821 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750820AbVHLSPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:15:18 -0400
Subject: [patch 18/39] remap_file_pages protection support: add VM_FAULT_SIGSEGV
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       mingo@elte.hu
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:21:45 +0200
Message-Id: <20050812182145.DF52E24E7F3@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

Since with remap_file_pages w/prot we may put PROT_NONE on a single PTE rather
than a VMA, we must handle that inside handle_mm_fault.

This value must be handled in the arch-specific fault handlers, and this
change must be ported to every arch on the world; now the new support is not
in a separate syscall, so this *must* be done unless we want stability /
security issues (the *BUG()* for unknown return values of handle_mm_fault() is
triggerable from userspace calling remap_file_pages, and on other archs, we
have VM_FAULT_OOM which is worse). However, I've alleviated this need via the
previous "safety net" patch.

This patch includes the arch-specific part for i386.

Note, however, that _proper_ support is more intrusive; we can allow a write
on a readonly VMA, but the arch fault handler currently stops that; it should
test VM_NONUNIFORM instead and call handle_mm_fault() in case it's set. And it
will have to do on its own all protection checks. This is in the following
patches.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/mm/fault.c |    2 ++
 linux-2.6.git-paolo/include/linux/mm.h   |    9 +++++----
 linux-2.6.git-paolo/mm/memory.c          |   12 ++++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff -puN arch/i386/mm/fault.c~rfp-add-vm_fault_sigsegv arch/i386/mm/fault.c
--- linux-2.6.git/arch/i386/mm/fault.c~rfp-add-vm_fault_sigsegv	2005-08-11 14:19:57.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/mm/fault.c	2005-08-11 14:19:58.000000000 +0200
@@ -351,6 +351,8 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_SIGSEGV:
+			goto bad_area;
 		default:
 			BUG();
 	}
diff -puN include/linux/mm.h~rfp-add-vm_fault_sigsegv include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-add-vm_fault_sigsegv	2005-08-11 14:19:58.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-11 14:19:58.000000000 +0200
@@ -632,10 +632,11 @@ static inline int page_mapped(struct pag
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
  */
-#define VM_FAULT_OOM	(-1)
-#define VM_FAULT_SIGBUS	0
-#define VM_FAULT_MINOR	1
-#define VM_FAULT_MAJOR	2
+#define VM_FAULT_OOM		(-1)
+#define VM_FAULT_SIGBUS		0
+#define VM_FAULT_MINOR		1
+#define VM_FAULT_MAJOR		2
+#define VM_FAULT_SIGSEGV	3
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 
diff -puN mm/memory.c~rfp-add-vm_fault_sigsegv mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-add-vm_fault_sigsegv	2005-08-11 14:19:58.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 14:19:58.000000000 +0200
@@ -1995,6 +1995,18 @@ static inline int handle_pte_fault(struc
 		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
 	}
 
+	/*
+	 * Generate a SIGSEGV if a PROT_NONE page is accessed; this is handled
+	 * in arch-specific code if the whole VMA has PROT_NONE, and here if
+	 * just this pte has PROT_NONE (which can be done only with
+	 * remap_file_pages).
+	 */
+	if (pgprot_val(pte_to_pgprot(entry)) == pgprot_val(__P000)) {
+		pte_unmap(pte);
+		spin_unlock(&mm->page_table_lock);
+		return VM_FAULT_SIGSEGV;
+	}
+
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
_
