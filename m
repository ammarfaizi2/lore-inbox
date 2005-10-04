Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVJDRYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVJDRYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVJDRYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:24:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47069 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964861AbVJDRYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:24:44 -0400
From: Andi Kleen <ak@suse.de>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
Date: Tue, 4 Oct 2005 19:24:56 +0200
User-Agent: KMail/1.8.2
Cc: lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <43426EB4.6080703@gmail.com>
In-Reply-To: <43426EB4.6080703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041924.56772.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 13:59, Tejun Heo wrote:
>   Hello, Andi.
>
>   In include/asm-x86_64/page.h, __VIRTUAL_MASK_SHIFT is defined as 48
> bits which is the size of virtual address space on current x86_64
> machines as used as such.  OTOH, __PHYSICAL_MASK_SHIFT is defined as 46
> and used as mask shift for physical page address (i.e. physaddr >> 12).
>
>   In addition to being a bit confusing due to similar names but
> different meanings, this means that we assume processors can physically
> address 58 (46 + 12) bits, but both amd64 and IA-32e manuals say that
> current architectural limit is 52 bits and bits 52-62 are reserved in
> all page table entries.  This currently (and in foreseeable future)
> doesn't cause any problem but it's still a bit weird.

You're right - PHYSICAL_MASK shouldn't be applied to PFNs, only to full
addresses. Fixed with appended patch.

The 46bits limit is because half of the 48bit virtual space 
is used for user space and the other 47 bit half is divided into
direct mapping and other mappings (ioremap, vmalloc etc.). All 
physical memory has to fit into the direct mapping, so you 
end with a 46 bit limit.

See also Documentation/x86-64/mm.txt

-Andi

Don't apply __PHYSICAL_MASK to page frame numbers

Pointed out by Tejun Heo.

Cc: htejun@gmail.com

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-x86_64/pgtable.h
===================================================================
--- linux.orig/include/asm-x86_64/pgtable.h
+++ linux/include/asm-x86_64/pgtable.h
@@ -259,7 +259,7 @@ static inline unsigned long pud_bad(pud_
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))	/* FIXME: is this
 						   right? */
 #define pte_page(x)	pfn_to_page(pte_pfn(x))
-#define pte_pfn(x)  ((pte_val(x) >> PAGE_SHIFT) & __PHYSICAL_MASK)
+#define pte_pfn(x)  ((pte_val(x) & __PHYSICAL_MASK) >> PAGE_SHIFT)
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
@@ -384,7 +384,7 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PTE_MASK & ~_PAGE_USER)) != 
_KERNPG_TABLE )
 #define pfn_pmd(nr,prot) (__pmd(((nr) << PAGE_SHIFT) | pgprot_val(prot)))
-#define pmd_pfn(x)  ((pmd_val(x) >> PAGE_SHIFT) & __PHYSICAL_MASK)
+#define pmd_pfn(x)  ((pmd_val(x) & __PHYSICAL_MASK) >> PAGE_SHIFT)
 
 #define pte_to_pgoff(pte) ((pte_val(pte) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
 #define pgoff_to_pte(off) ((pte_t) { ((off) << PAGE_SHIFT) | _PAGE_FILE })
