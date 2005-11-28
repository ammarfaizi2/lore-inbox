Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVK1Gwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVK1Gwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 01:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVK1Gwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 01:52:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932101AbVK1Gwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 01:52:49 -0500
Date: Mon, 28 Nov 2005 01:52:33 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, akpm@osdl.org, Stuart_Hayes@Dell.com
Subject: change page attr fix.
Message-ID: <20051128065233.GA23531@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, arjan@infradead.org, akpm@osdl.org,
	Stuart_Hayes@Dell.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'make rodata read-only' patch in -mm exposes a latent bug
in the 32-bit change_page_attr() function, which causes
certain CPUs (Those with NX basically) to reboot instantly
after pages are marked read-only.

The same bug got fixed a while back on x86-64, but never got
propagated to i386.

Stuart Hayes from Dell also picked up on this last June,
but it never got fixed, as the only thing affected by it
aparently was the nvidia driver.

Blatantly stealing description from his post..

"It doesn't appear to be fixed (in the i386 arch).  The
 change_page_attr()/split_large_page() code will still still set all the
 4K PTEs to PAGE_KERNEL (setting the _PAGE_NX bit) when a large page
 needs to be split.

 This wouldn't be a problem for the bulk of the kernel memory, but there
 are pages in the lower 4MB of memory that's free, and are part of large
 executable pages that also contain kernel code.  If change_page_attr()
 is called on these, it will set the _PAGE_NX bit on the whole 2MB region
 that was covered by the large page, causing a large chunk of kernel code
 to be non-executable."

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/arch/i386/mm/pageattr.c.nopatch	2005-10-04 10:33:12.000000000 -0500
+++ linux-2.6/arch/i386/mm/pageattr.c	2005-10-04 10:33:33.000000000 -0500
@@ -31,7 +31,8 @@ pte_t *lookup_address(unsigned long addr
         return pte_offset_kernel(pmd, address);
 } 
 
-static struct page *split_large_page(unsigned long address, pgprot_t prot)
+static struct page *split_large_page(unsigned long address, pgprot_t prot,
+					pgprot_t ref_prot)
 { 
 	int i; 
 	unsigned long addr;
@@ -54,7 +54,7 @@ static struct page *split_large_page(uns
 	pbase = (pte_t *)page_address(base);
 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
                set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
-                                          addr == address ? prot : PAGE_KERNEL));
+                                          addr == address ? prot : ref_prot));
 	}
 	return base;
 } 
@@ -98,11 +98,17 @@ static void set_pmd_pte(pte_t *kpte, uns
  */
 static inline void revert_page(struct page *kpte_page, unsigned long address)
 {
+	pgprot_t ref_prot;
+
+	ref_prot =
+	((address & LARGE_PAGE_MASK) < (unsigned long)&_etext)
+		? PAGE_KERNEL_LARGE_EXEC : PAGE_KERNEL_LARGE;
+
 	pte_t *linear = (pte_t *) 
 		pmd_offset(pud_offset(pgd_offset_k(address), address), address);
 	set_pmd_pte(linear,  address,
 		    pfn_pte((__pa(address) & LARGE_PAGE_MASK) >> PAGE_SHIFT,
-			    PAGE_KERNEL_LARGE));
+			    ref_prot));
 }
 
 static int
@@ -121,10 +128,16 @@ __change_page_attr(struct page *page, pg
 		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
 			set_pte_atomic(kpte, mk_pte(page, prot)); 
 		} else {
-			struct page *split = split_large_page(address, prot); 
+			pgprot_t ref_prot;
+			struct page *split;
+	
+			ref_prot =
+			((address & LARGE_PAGE_MASK) < (unsigned long)&_etext)
+				? PAGE_KERNEL_EXEC : PAGE_KERNEL;
+			split = split_large_page(address, prot, ref_prot); 
 			if (!split)
 				return -ENOMEM;
-			set_pmd_pte(kpte,address,mk_pte(split, PAGE_KERNEL));
+			set_pmd_pte(kpte,address,mk_pte(split, ref_prot));
 			kpte_page = split;
 		}	
 		get_page(kpte_page);

