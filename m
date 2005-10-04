Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVJDP5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVJDP5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVJDP5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:57:12 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:59822 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964830AbVJDP5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:57:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=F6JA1zVR6QbfM/CrTxoS3Jem9NxQPcibNVAc/cKpDjWCLBRpkXvcn6hvxWYWY3iFD/kS0ot6S2Fpkh+KhVkT/G0cn1dKDIDjKrOxXpsuB7t0d1uxzdGL5mSr8yrl/bEXrFg1i6Uz2cQxmY/lxYHkABJu09+xyMcL2HVqfNFE3QY=
Date: Wed, 5 Oct 2005 00:57:02 +0900
From: Tejun Heo <htejun@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6] vm: remove unused/broken page_pte[_prot] macros
Message-ID: <20051004155702.GA14543@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Andrew.

 This patch removes page_pte_prot and page_pte macros from all
architectures.  Some architectures define both, some only page_pte
(broken) and others none.  These macros are not used anywhere.

 page_pte_prot(page, prot) is identical to mk_pte(page, prot) and
page_pte(page) is identical to page_pte_prot(page, __pgprot(0)).

* The following architectures define both page_pte_prot and page_pte

  arm, arm26, ia64, sh64, sparc, sparc64

* The following architectures define only page_pte (broken)

  frv, i386, m32r, mips, sh, x86-64

* All other architectures define neither


Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/include/asm-arm/pgtable.h b/include/asm-arm/pgtable.h
--- a/include/asm-arm/pgtable.h
+++ b/include/asm-arm/pgtable.h
@@ -397,9 +397,6 @@ static inline pte_t *pmd_page_kernel(pmd
 #define pgd_clear(pgdp)		do { } while (0)
 #define set_pgd(pgd,pgdp)	do { } while (0)
 
-#define page_pte_prot(page,prot)	mk_pte(page, prot)
-#define page_pte(page)		mk_pte(page, __pgprot(0))
-
 /* to find an entry in a page-table-directory */
 #define pgd_index(addr)		((addr) >> PGDIR_SHIFT)
 
diff --git a/include/asm-arm26/pgtable.h b/include/asm-arm26/pgtable.h
--- a/include/asm-arm26/pgtable.h
+++ b/include/asm-arm26/pgtable.h
@@ -98,8 +98,6 @@ extern struct page *empty_zero_page;
 #define pfn_pte(pfn,prot)	(__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot)))
 #define pages_to_mb(x)		((x) >> (20 - PAGE_SHIFT))
 #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
-#define page_pte_prot(page,prot)	mk_pte(page, prot)
-#define page_pte(page)		mk_pte(page, __pgprot(0))
 
 /*
  * Terminology: PGD = Page Directory, PMD = Page Middle Directory,
diff --git a/include/asm-frv/pgtable.h b/include/asm-frv/pgtable.h
--- a/include/asm-frv/pgtable.h
+++ b/include/asm-frv/pgtable.h
@@ -436,8 +436,6 @@ static inline pte_t pte_modify(pte_t pte
 	return pte;
 }
 
-#define page_pte(page)	page_pte_prot((page), __pgprot(0))
-
 /* to find an entry in a page-table-directory. */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_index_k(addr) pgd_index(addr)
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -322,8 +322,6 @@ static inline pte_t pte_modify(pte_t pte
 	return pte;
 }
 
-#define page_pte(page) page_pte_prot(page, __pgprot(0))
-
 #define pmd_large(pmd) \
 ((pmd_val(pmd) & (_PAGE_PSE|_PAGE_PRESENT)) == (_PAGE_PSE|_PAGE_PRESENT))
 
diff --git a/include/asm-ia64/pgtable.h b/include/asm-ia64/pgtable.h
--- a/include/asm-ia64/pgtable.h
+++ b/include/asm-ia64/pgtable.h
@@ -236,9 +236,6 @@ ia64_phys_addr_valid (unsigned long addr
 #define pte_modify(_pte, newprot) \
 	(__pte((pte_val(_pte) & ~_PAGE_CHG_MASK) | (pgprot_val(newprot) & _PAGE_CHG_MASK)))
 
-#define page_pte_prot(page,prot)	mk_pte(page, prot)
-#define page_pte(page)			page_pte_prot(page, __pgprot(0))
-
 #define pte_none(pte) 			(!pte_val(pte))
 #define pte_present(pte)		(pte_val(pte) & (_PAGE_P | _PAGE_PROTNONE))
 #define pte_clear(mm,addr,pte)		(pte_val(*(pte)) = 0UL)
diff --git a/include/asm-m32r/pgtable.h b/include/asm-m32r/pgtable.h
--- a/include/asm-m32r/pgtable.h
+++ b/include/asm-m32r/pgtable.h
@@ -324,8 +324,6 @@ static inline pte_t pte_modify(pte_t pte
 	return pte;
 }
 
-#define page_pte(page)	page_pte_prot(page, __pgprot(0))
-
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -157,7 +157,6 @@ static inline void pgd_clear(pgd_t *pgdp
 #endif
 
 #define __pgd_offset(address)	pgd_index(address)
-#define page_pte(page) page_pte_prot(page, __pgprot(0))
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, 0)
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -76,7 +76,6 @@ extern void paging_init(void);
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
-#define page_pte(page)		page_pte_prot(page, __pgprot(0))
 #define pmd_phys(pmd)		(pmd_val(pmd) - PAGE_OFFSET)
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pmd_page_kernel(pmd)	pmd_val(pmd)
diff --git a/include/asm-sh/pgtable.h b/include/asm-sh/pgtable.h
--- a/include/asm-sh/pgtable.h
+++ b/include/asm-sh/pgtable.h
@@ -224,8 +224,6 @@ static inline pgprot_t pgprot_noncached(
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { set_pte(&pte, __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot))); return pte; }
 
-#define page_pte(page) page_pte_prot(page, __pgprot(0))
-
 #define pmd_page_kernel(pmd) \
 ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
diff --git a/include/asm-sh64/pgtable.h b/include/asm-sh64/pgtable.h
--- a/include/asm-sh64/pgtable.h
+++ b/include/asm-sh64/pgtable.h
@@ -457,9 +457,6 @@ extern inline pte_t pte_mkhuge(pte_t pte
 extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { set_pte(&pte, __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot))); return pte; }
 
-#define page_pte_prot(page, prot) mk_pte(page, prot)
-#define page_pte(page) page_pte_prot(page, __pgprot(0))
-
 typedef pte_t *pte_addr_t;
 #define pgtable_cache_init()	do { } while (0)
 
diff --git a/include/asm-sparc/pgtable.h b/include/asm-sparc/pgtable.h
--- a/include/asm-sparc/pgtable.h
+++ b/include/asm-sparc/pgtable.h
@@ -255,8 +255,6 @@ BTFIXUPDEF_CALL_CONST(pte_t, pte_mkyoung
 #define pte_mkdirty(pte) BTFIXUP_CALL(pte_mkdirty)(pte)
 #define pte_mkyoung(pte) BTFIXUP_CALL(pte_mkyoung)(pte)
 
-#define page_pte_prot(page, prot)	mk_pte(page, prot)
-#define page_pte(page)			mk_pte(page, __pgprot(0))
 #define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
 
 BTFIXUPDEF_CALL(unsigned long,	 pte_pfn, pte_t)
diff --git a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -231,9 +231,6 @@ extern struct page *mem_map_zero;
 #define pte_pfn(x)		((pte_val(x) & _PAGE_PADDR)>>PAGE_SHIFT)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#define page_pte_prot(page, prot)	mk_pte(page, prot)
-#define page_pte(page)			page_pte_prot(page, __pgprot(0))
-
 static inline pte_t pte_modify(pte_t orig_pte, pgprot_t new_prot)
 {
 	pte_t __pte;
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -318,8 +318,6 @@ static inline int pmd_large(pmd_t pte) {
  * and a page entry and page directory to the page they refer to.
  */
 
-#define page_pte(page) page_pte_prot(page, __pgprot(0))
-
 /*
  * Level 4 access.
  */
