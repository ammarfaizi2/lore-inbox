Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbULHHdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbULHHdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbULHHap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:30:45 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:33162 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262059AbULHH3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:29:09 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: [1/6] Xen VMM #4: add ptep_establish_new to make va available
In-reply-to: Your message of "Wed, 08 Dec 2004 07:28:16 GMT."
             <E1CbwFE-0006PZ-00@mta1.cl.cam.ac.uk> 
Date: Wed, 08 Dec 2004 07:29:01 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CbwFx-0006QL-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds 'ptep_establish_new', in keeping with the
existing 'ptep_establish', but for use where a mapping is being
established where there was previously none present. This
function is useful (rather than just using set_pte) because
having the virtual address available enables a very important
optimisation for arch-xen. We introduce
HAVE_ARCH_PTEP_ESTABLISH_NEW and define a generic implementation
in asm-generic/pgtable.h, following the pattern of the existing
ptep_establish.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---

diff -Nurp pristine-linux-2.6.10-rc3/include/asm-generic/pgtable.h tmp-linux-2.6.10-rc3-xen.patch/include/asm-generic/pgtable.h
--- pristine-linux-2.6.10-rc3/include/asm-generic/pgtable.h	2004-12-03 21:53:20.000000000 +0000
+++ tmp-linux-2.6.10-rc3-xen.patch/include/asm-generic/pgtable.h	2004-12-08 00:52:40.000000000 +0000
@@ -42,6 +42,16 @@ do {				  					  \
 } while (0)
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_ESTABLISH_NEW
+/*
+ * Establish a mapping where none previously existed
+ */
+#define ptep_establish_new(__vma, __address, __ptep, __entry)		\
+do {									\
+	set_pte(__ptep, __entry);					\
+} while (0)
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(pte_t *ptep)
 {
diff -Nurp pristine-linux-2.6.10-rc3/mm/memory.c tmp-linux-2.6.10-rc3-xen.patch/mm/memory.c
--- pristine-linux-2.6.10-rc3/mm/memory.c	2004-12-03 21:53:46.000000000 +0000
+++ tmp-linux-2.6.10-rc3-xen.patch/mm/memory.c	2004-12-08 00:56:47.000000000 +0000
@@ -1468,7 +1468,7 @@ do_anonymous_page(struct mm_struct *mm, 
 		page_add_anon_rmap(page, vma, addr);
 	}
 
-	set_pte(page_table, entry);
+	ptep_establish_new(vma, addr, page_table, entry);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
@@ -1573,7 +1573,7 @@ retry:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte(page_table, entry);
+		ptep_establish_new(vma, address, page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);

