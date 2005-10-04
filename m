Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVJDSwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVJDSwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVJDSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:52:42 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:18681 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964908AbVJDSwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:52:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=g9F6cvYxoJNoODfx/4stj8Y8PDw8kk51ia6Uwrc94QU8Ufs6a2MnbKm1THuiXqMrJtJKPo8MKvhAlAJQtBq1HWZDpLmGWKAhkbizUecXclG2N9wAIJ0012+6p/RP+gV5x0aEHZSJP67UKHqdMjlj4J63Cni1HFyVXcoPyvVs1aA=
Date: Wed, 5 Oct 2005 03:52:30 +0900
From: Tejun Heo <htejun@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
Message-ID: <20051004185230.GA8431@htj.dyndns.org>
References: <43426EB4.6080703@gmail.com> <200510041924.56772.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510041924.56772.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Andi.

On Tue, Oct 04, 2005 at 07:24:56PM +0200, Andi Kleen wrote:
> 
> You're right - PHYSICAL_MASK shouldn't be applied to PFNs, only to full
> addresses. Fixed with appended patch.
> 
> The 46bits limit is because half of the 48bit virtual space 
> is used for user space and the other 47 bit half is divided into
> direct mapping and other mappings (ioremap, vmalloc etc.). All 
> physical memory has to fit into the direct mapping, so you 
> end with a 46 bit limit.

 __PHYSICAL_MASK is only used to mask out non-pfn bits from page table
entries.  I don't really see how it's related to virtual space
construction.

> 
> See also Documentation/x86-64/mm.txt
> 

 Thanks.  :-)

 I think PHYSICAL_PAGE_MASK and PTE_FILE_MAX_BITS should also be
updated.  How about the following patch?  Compile & boot tested.


 This patch cleans up __PHYSICAL_MASK and related constants.

- __PHYSICAL_MASK_SHIFT is changed to 52 to reflect architectural
  physical address limit.

- PHYSICAL_PAGE_MASK is fixed to properly mask pfn bits of page table
  entries.

- PTE_FILE_MAX_BITS is fixed to properly reflect available bits in a
  page table entry (40bits).

- Macros dealing with page table entries are modified to universally
  use PTE_MASK (which equals PHYSICAL_PAGE_MASK) when extracting pfn
  for consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
--- a/include/asm-x86_64/page.h
+++ b/include/asm-x86_64/page.h
@@ -11,7 +11,7 @@
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
-#define PHYSICAL_PAGE_MASK	(~(PAGE_SIZE-1) & (__PHYSICAL_MASK << PAGE_SHIFT))
+#define PHYSICAL_PAGE_MASK	(PAGE_MASK & __PHYSICAL_MASK)
 
 #define THREAD_ORDER 1 
 #ifdef __ASSEMBLY__
@@ -81,7 +81,7 @@ typedef struct { unsigned long pgprot; }
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
 /* See Documentation/x86_64/mm.txt for a description of the memory map. */
-#define __PHYSICAL_MASK_SHIFT	46
+#define __PHYSICAL_MASK_SHIFT	52
 #define __PHYSICAL_MASK		((1UL << __PHYSICAL_MASK_SHIFT) - 1)
 #define __VIRTUAL_MASK_SHIFT	48
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -101,7 +101,7 @@ static inline void pgd_clear (pgd_t * pg
 }
 
 #define pud_page(pud) \
-((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
+((unsigned long) __va(pud_val(pud) & PTE_MASK))
 
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
 
@@ -245,7 +245,7 @@ static inline unsigned long pud_bad(pud_
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))	/* FIXME: is this
 						   right? */
 #define pte_page(x)	pfn_to_page(pte_pfn(x))
-#define pte_pfn(x)  ((pte_val(x) >> PAGE_SHIFT) & __PHYSICAL_MASK)
+#define pte_pfn(x)	((pte_val(x) & PTE_MASK) >> PAGE_SHIFT)
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
@@ -352,11 +352,11 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PTE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE )
 #define pfn_pmd(nr,prot) (__pmd(((nr) << PAGE_SHIFT) | pgprot_val(prot)))
-#define pmd_pfn(x)  ((pmd_val(x) >> PAGE_SHIFT) & __PHYSICAL_MASK)
+#define pmd_pfn(x)	((pmd_val(x) & PTE_MASK) >> PAGE_SHIFT)
 
-#define pte_to_pgoff(pte) ((pte_val(pte) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
+#define pte_to_pgoff(pte) ((pte_val(pte) & PTE_MASK) >> PAGE_SHIFT)
 #define pgoff_to_pte(off) ((pte_t) { ((off) << PAGE_SHIFT) | _PAGE_FILE })
-#define PTE_FILE_MAX_BITS __PHYSICAL_MASK_SHIFT
+#define PTE_FILE_MAX_BITS (__PHYSICAL_MASK_SHIFT - PAGE_SHIFT)
 
 /* PTE - Level 1 access. */
 
