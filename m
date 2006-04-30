Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWD3Rcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWD3Rcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWD3Rcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:32:36 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:44754 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751187AbWD3Rcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:36 -0400
Message-Id: <20060430173025.752423000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:30:04 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 11/14] remap_file_pages protection support: pte_present should not trigger on PTE_FILE PROTNONE ptes
Content-Disposition: inline; filename=rfp/pte_present-for-PROT_NONE-pte.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

pte_present(pte) implies that pte_pfn(pte) is valid. Normally even with a
_PAGE_PROTNONE pte this holds, but not when such a PTE is installed by
the new install_file_pte; previously it didn't store protections, only file
offsets, with the patches it also stores protections, and can set
_PAGE_PROTNONE|_PAGE_FILE.

zap_pte_range, when acting on such a pte, calls vm_normal_page and gets
&mem_map[0], does page_remove_rmap, and we're easily in trouble, because it
happens to find a page with mapcount == 0. And it BUGs on this!

I've seen this trigger easily and repeatably on UML on 2.6.16-rc3. This was
likely avoided in the past by the PageReserved test - page 0 *had* to be
reserved on i386 (dunno on UML).

Implementation follows for UML and i386.

To avoid additional overhead, I also considered adding likely() for
_PAGE_PRESENT and unlikely() for the rest, but I'm uncertain about validity of
possible [un]likely(pte_present()) occurrences.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/pgtable.h
+++ linux-2.6.git/include/asm-um/pgtable.h
@@ -158,7 +158,7 @@ extern unsigned long pg0[1024];
 #define mk_phys(a, r) ((a) + (((unsigned long) r) << REGION_SHIFT))
 #define phys_addr(p) ((p) & ~REGION_MASK)
 
-#define pte_present(x)	pte_get_bits(x, (_PAGE_PRESENT | _PAGE_PROTNONE))
+#define pte_present(x)	(pte_get_bits(x, (_PAGE_PRESENT)) || (pte_get_bits(x, (_PAGE_PROTNONE)) && !pte_file(x)))
 
 /*
  * =================================
Index: linux-2.6.git/mm/memory.c
===================================================================
--- linux-2.6.git.orig/mm/memory.c
+++ linux-2.6.git/mm/memory.c
@@ -624,6 +624,8 @@ static unsigned long zap_pte_range(struc
 
 		(*zap_work) -= PAGE_SIZE;
 
+		/* XXX: This can trigger even if the PTE is only a PROTNONE
+		 * PTE_FILE pte - we'll then extract page 0 and unmap it! */
 		if (pte_present(ptent)) {
 			struct page *page;
 
Index: linux-2.6.git/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.git.orig/include/asm-i386/pgtable.h
+++ linux-2.6.git/include/asm-i386/pgtable.h
@@ -204,6 +204,8 @@ extern unsigned long long __PAGE_KERNEL,
 extern unsigned long pg0[];
 
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
+#define pte_present(x)  (((x).pte_low & _PAGE_PRESENT) || \
+		(((x).pte_low & (_PAGE_PROTNONE|_PAGE_FILE)) == _PAGE_PROTNONE))
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
 /* To avoid harmful races, pmd_none(x) should check only the lower when PAE */

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
