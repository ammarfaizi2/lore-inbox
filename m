Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSFCFi4>; Mon, 3 Jun 2002 01:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317213AbSFCFiz>; Mon, 3 Jun 2002 01:38:55 -0400
Received: from holomorphy.com ([66.224.33.161]:36515 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314680AbSFCFiz>;
	Mon, 3 Jun 2002 01:38:55 -0400
Date: Sun, 2 Jun 2002 22:38:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: forget_pte()
Message-ID: <20020603053832.GP10243@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <20020601164002.GC10243@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 09:40:02AM -0700, William Lee Irwin III wrote:
...

patch updated to incorporate rusty's suggestion:


===== mm/memory.c 1.70 vs edited =====
--- 1.70/mm/memory.c	Fri May 31 18:18:07 2002
+++ edited/mm/memory.c	Sun Jun  2 22:37:17 2002
@@ -310,17 +310,6 @@
 	return -ENOMEM;
 }
 
-/*
- * Return indicates whether a page was freed so caller can adjust rss
- */
-static inline void forget_pte(pte_t page)
-{
-	if (!pte_none(page)) {
-		printk("forget_pte: old mapping existed!\n");
-		BUG();
-	}
-}
-
 static void zap_pte_range(mmu_gather_t *tlb, pmd_t * pmd, unsigned long address, unsigned long size)
 {
 	unsigned long offset;
@@ -779,7 +768,8 @@
 		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
 		pte_t oldpage = ptep_get_and_clear(pte);
 		set_pte(pte, zero_pte);
-		forget_pte(oldpage);
+		/* PTE's must be unmapped */
+		BUG_ON(!pte_none(oldpage));
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
@@ -857,7 +847,8 @@
 
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
  			set_pte(pte, pfn_pte(pfn, prot));
-		forget_pte(oldpage);
+		/* PTE's must be unmapped */
+		BUG_ON(!pte_none(oldpage));
 		address += PAGE_SIZE;
 		pfn++;
 		pte++;
