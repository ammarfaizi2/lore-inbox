Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSFDEmz>; Tue, 4 Jun 2002 00:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSFDEmx>; Tue, 4 Jun 2002 00:42:53 -0400
Received: from holomorphy.com ([66.224.33.161]:39555 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316322AbSFDEmW>;
	Tue, 4 Jun 2002 00:42:22 -0400
Date: Mon, 3 Jun 2002 21:42:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: linux-2.5.20-ct1
Message-ID: <20020604044217.GE8263@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thunder from the hill <thunder@ngforever.de>,
	Lightweight patch manager <patch@luckynet.dynu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-Reply-To: <20020604042300.GA8263@holomorphy.com> <Pine.LNX.4.44.0206032228550.3833-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, William Lee Irwin III wrote:
>> There were discussions about a number of these patches resulting in
>> changes, would you mind letting me know what versions of these things
>> you're pushing upstream and let me hand you updates?

On Mon, Jun 03, 2002 at 10:30:18PM -0600, Thunder from the hill wrote:
> Since you  gave it no version number, it's exactly the version which is 
> saved at 
> <URL:ftp://luckynet.dynu.com/pub/linux/2.5.20-ct1/single-patches/>
> Usually the latest available.


Please replace the forget_pte() patch with the following:

Thanks,
Bill


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
