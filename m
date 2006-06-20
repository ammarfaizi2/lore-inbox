Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWFTLti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWFTLti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWFTLtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:49:13 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:23169 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030223AbWFTLtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:49:06 -0400
Message-Id: <20060620114628.498986000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:02 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/13] SPARC64: Fix D-cache corruption in mremap
Content-Disposition: inline; filename=sparc64-fix-d-cache-corruption-in-mremap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

If we move a mapping from one virtual address to another,
and this changes the virtual color of the mapping to those
pages, we can see corrupt data due to D-cache aliasing.

Check for and deal with this by overriding the move_pte()
macro.  Set things up so that other platforms can cleanly
override the move_pte() macro too.

This long standing bug corrupts user memory, and in particular
has been notorious for corrupting Debian package database
files on sparc64 boxes.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 include/asm-generic/pgtable.h |   11 +----------
 include/asm-mips/pgtable.h    |   10 +++++++++-
 include/asm-sparc64/pgtable.h |   17 +++++++++++++++++
 3 files changed, 27 insertions(+), 11 deletions(-)

--- linux-2.6.16.21.orig/include/asm-generic/pgtable.h
+++ linux-2.6.16.21/include/asm-generic/pgtable.h
@@ -159,17 +159,8 @@ static inline void ptep_set_wrprotect(st
 #define lazy_mmu_prot_update(pte)	do { } while (0)
 #endif
 
-#ifndef __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#ifndef __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, prot, old_addr, new_addr)	(pte)
-#else
-#define move_pte(pte, prot, old_addr, new_addr)				\
-({									\
- 	pte_t newpte = (pte);						\
-	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
-			pte_page(pte) == ZERO_PAGE(old_addr))		\
-		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
-	newpte;								\
-})
 #endif
 
 /*
--- linux-2.6.16.21.orig/include/asm-mips/pgtable.h
+++ linux-2.6.16.21/include/asm-mips/pgtable.h
@@ -70,7 +70,15 @@ extern unsigned long zero_page_mask;
 #define ZERO_PAGE(vaddr) \
 	(virt_to_page(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask)))
 
-#define __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
+			pte_page(pte) == ZERO_PAGE(old_addr))		\
+		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
+	newpte;								\
+})
 
 extern void paging_init(void);
 
--- linux-2.6.16.21.orig/include/asm-sparc64/pgtable.h
+++ linux-2.6.16.21/include/asm-sparc64/pgtable.h
@@ -335,6 +335,23 @@ static inline void set_pte_at(struct mm_
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
+#ifdef DCACHE_ALIASING_POSSIBLE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (pte_present(pte)) {						\
+		unsigned long this_pfn = pte_pfn(pte);			\
+									\
+		if (pfn_valid(this_pfn) &&				\
+		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
+			flush_dcache_page_all(current->mm,		\
+					      pfn_to_page(this_pfn));	\
+	}								\
+	newpte;								\
+})
+#endif
+
 extern pgd_t swapper_pg_dir[2048];
 extern pmd_t swapper_low_pmd_dir[2048];
 

--
