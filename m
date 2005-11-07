Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVKGK42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVKGK42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVKGK42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:56:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58524 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751147AbVKGK41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:56:27 -0500
Date: Mon, 7 Nov 2005 10:56:24 +0000
From: arjan@infradead.org
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [patch 01/02] Debug option to write-protect rodata: change_page_attr fixes
Message-ID: <20051107105624.GA6531@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a patch that turns the kernel's .rodata section to be
actually read only, eg any write attempts to it cause a segmentation fault.
During this work I found a bug in the change_page_attr() code on x86-64, and
this patch 1 is the bugfix for that. Patch 2 will be the actual introduction
of the readonly option.


The bug fixed here is the following: when splitting a 2Mb PSE page that also
happened to contain kernel text, the split PMD would get the NX bit set
eventhough the individual pte entries for the 4Kb pages would not. This
causes problems still since this NX bit overrides in practice the sub bits.
The solution I've chosen is I think the right one: On splitting a 2Mb page
in the change_page_attr() code, inherit the existing pagetable permissions
exactly, for both the PMD page and all the 4Kb pte entries (with the
exception of the one that you wanted to change, but the code already did
that part correct).


Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-2.6.14/arch/x86_64/mm/pageattr.c linux-2.6.14-fordiff/arch/x86_64/mm/pageattr.c
--- linux-2.6.14/arch/x86_64/mm/pageattr.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-fordiff/arch/x86_64/mm/pageattr.c	2005-11-05 18:27:07.000000000 +0100
@@ -128,6 +131,7 @@ __change_page_attr(unsigned long address
 	pte_t *kpte; 
 	struct page *kpte_page;
 	unsigned kpte_flags;
+	pgprot_t ref_prot2;
 	kpte = lookup_address(address);
 	if (!kpte) return 0;
 	kpte_page = virt_to_page(((unsigned long)kpte) & PAGE_MASK);
@@ -140,10 +144,14 @@ __change_page_attr(unsigned long address
  			 * split_large_page will take the reference for this change_page_attr
  			 * on the split page.
  			 */
-			struct page *split = split_large_page(address, prot, ref_prot); 
+
+			struct page *split;
+			ref_prot2 = __pgprot(pgprot_val(pte_pgprot(*lookup_address(address))) & ~(1<<_PAGE_BIT_PSE));
+
+			split = split_large_page(address, prot, ref_prot2); 
 			if (!split)
 				return -ENOMEM;
-			set_pte(kpte,mk_pte(split, ref_prot));
+			set_pte(kpte,mk_pte(split, ref_prot2));
 			kpte_page = split;
 		}	
 		get_page(kpte_page);
diff -purN linux-2.6.14/include/asm-x86_64/pgtable.h linux-2.6.14-fordiff/include/asm-x86_64/pgtable.h
--- linux-2.6.14/include/asm-x86_64/pgtable.h	2005-11-03 18:49:01.000000000 +0100
+++ linux-2.6.14-fordiff/include/asm-x86_64/pgtable.h	2005-11-05 13:20:44.000000000 +0100
@@ -119,6 +119,8 @@ static inline pte_t ptep_get_and_clear_f
 
 #define pte_same(a, b)		((a).pte == (b).pte)
 
+#define pte_pgprot(a)	(__pgprot((a).pte & ~(PHYSICAL_PAGE_MASK)))
+
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 #define PUD_SIZE	(1UL << PUD_SHIFT)

