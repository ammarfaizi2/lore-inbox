Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbUKSXYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUKSXYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUKSXXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:23:24 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:53190 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261680AbUKSXUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:20:09 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: [1/7] Xen VMM patch set : add ptep_establish_new to make va available
In-reply-to: Your message of "Fri, 19 Nov 2004 23:16:33 GMT."
             <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> 
Date: Fri, 19 Nov 2004 23:20:02 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CVI2t-0004ZC-00@mta1.cl.cam.ac.uk>
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

diff -Nurp pristine-linux-2.6.10-rc2/include/asm-generic/pgtable.h tmp-linux-2.6.10-rc2-xen.patch/include/asm-generic/pgtable.h
--- pristine-linux-2.6.10-rc2/include/asm-generic/pgtable.h	2004-11-15 01:27:18.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/include/asm-generic/pgtable.h	2004-11-18 19:58:13.000000000 +0000
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
diff -Nurp pristine-linux-2.6.10-rc2/mm/memory.c tmp-linux-2.6.10-rc2-xen.patch/mm/memory.c
--- pristine-linux-2.6.10-rc2/mm/memory.c	2004-11-15 01:27:26.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/mm/memory.c	2004-11-18 20:07:39.000000000 +0000
@@ -1472,7 +1472,7 @@ do_anonymous_page(struct mm_struct *mm, 
 		page_add_anon_rmap(page, vma, addr);
 	}
 
-	set_pte(page_table, entry);
+	ptep_establish_new(vma, addr, page_table, entry);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
@@ -1577,7 +1577,7 @@ retry:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte(page_table, entry);
+		ptep_establish_new(vma, address, page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);


