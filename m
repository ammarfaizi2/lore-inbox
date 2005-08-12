Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVHLSuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVHLSuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVHLSty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:54 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:62412 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750987AbVHLStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:25 -0400
Subject: [patch 33/39] remap_file_pages protection support: VM_FAULT_SIGSEGV permission checking rework
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:22 +0200
Message-Id: <20050812183622.E3B7E24E7E3@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Simplify the generic arch permission checking: the previous one was clumsy, as
it didn't account arch-specific implications (read implies exec, write implies
read, and so on).

Still to undo fixes for the archs (i386 and UML) which were modified for the
previous scheme.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/memory.c |   49 ++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff -puN mm/memory.c~rfp-sigsegv-4 mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-sigsegv-4	2005-08-12 17:18:55.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-12 17:18:55.000000000 +0200
@@ -1923,6 +1923,35 @@ oom:
 	goto out;
 }
 
+static inline int check_perms(struct vm_area_struct * vma, int access_mask) {
+	if (unlikely(vm_flags & VM_NONUNIFORM)) {
+		/* we used to check protections in arch handler, but with
+		 * VM_NONUNIFORM the check is skipped. */
+#if 0
+		if ((access_mask & VM_WRITE) > (vm_flags & VM_WRITE))
+			goto err;
+		if ((access_mask & VM_READ) > (vm_flags & VM_READ))
+			goto err;
+		if ((access_mask & VM_EXEC) > (vm_flags & VM_EXEC))
+			goto err;
+#else
+		/* access_mask contains the type of the access, vm_flags are the
+		 * declared protections, pte has the protection which will be
+		 * given to the PTE's in that area. */
+		//pte_t pte = pfn_pte(0UL, protection_map[vm_flags & 0x0f|VM_SHARED]);
+		pte_t pte = pfn_pte(0UL, vma->vm_page_prot);
+		if ((access_mask & VM_WRITE) && ! pte_write(pte))
+			goto err;
+		if ((access_mask & VM_READ) && ! pte_read(pte))
+			goto err;
+		if ((access_mask & VM_EXEC) && ! pte_exec(pte))
+			goto err;
+#endif
+	}
+	return 0;
+err:
+	return -EPERM;
+}
 /*
  * Fault of a previously existing named mapping. Repopulate the pte
  * from the encoded file_pte if possible. This enables swappable
@@ -1944,14 +1973,8 @@ static int do_file_page(struct mm_struct
 			((access_mask & VM_WRITE) && !(vma->vm_flags & VM_SHARED))) {
 		/* We're behaving as if pte_file was cleared, so check
 		 * protections like in handle_pte_fault. */
-		if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
-			if ((access_mask & VM_WRITE) > (vma->vm_flags & VM_WRITE))
-				goto out_segv;
-			if ((access_mask & VM_READ) > (vma->vm_flags & VM_READ))
-				goto out_segv;
-			if ((access_mask & VM_EXEC) > (vma->vm_flags & VM_EXEC))
-				goto out_segv;
-		}
+		if (check_perms(vma, access_mask))
+			goto out_segv;
 
 		pte_clear(mm, address, pte);
 		return do_no_page(mm, vma, address, access_mask & VM_WRITE, pte, pmd);
@@ -2007,14 +2030,8 @@ static inline int handle_pte_fault(struc
 		/* when pte_file(), the VMA protections are useless. Otherwise,
 		 * we used to check protections in arch handler, but with
 		 * VM_NONUNIFORM the check is skipped. */
-		if (unlikely(vma->vm_flags & VM_NONUNIFORM) && !pte_file(entry)) {
-			if ((access_mask & VM_WRITE) > (vma->vm_flags & VM_WRITE))
-				goto out_segv;
-			if ((access_mask & VM_READ) > (vma->vm_flags & VM_READ))
-				goto out_segv;
-			if ((access_mask & VM_EXEC) > (vma->vm_flags & VM_EXEC))
-				goto out_segv;
-		}
+		if (!pte_file(entry) && check_perms(vma, access_mask))
+			goto out_segv;
 
 		/*
 		 * If it truly wasn't present, we know that kswapd
_
