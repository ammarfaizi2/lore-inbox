Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965319AbVKBWcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965319AbVKBWcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965324AbVKBWcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:32:42 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:49577 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S965319AbVKBWcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:32:41 -0500
Date: Thu, 3 Nov 2005 00:32:40 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] sh: Use pfn_valid() for lazy dcache write-back on SH7705.
Message-ID: <20051102223240.GG27200@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SH7705 in extended cache mode has some left-over VALID_PAGE() cruft that
it checks when doing lazy dcache write-back. This has been gone for some
time (the last bits were in the discontig code, which should now also be
gone -- this also fixes up a build error in the non-discontig case).

pfn_valid() gives the desired behaviour, so we switch to that.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/mm/tlb-sh3.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

applies-to: e05fa4b455e074c8f5e7ce3604d86367cf793e35
35cbddae99cc6382932f930bb6db3a4499279377
diff --git a/arch/sh/mm/tlb-sh3.c b/arch/sh/mm/tlb-sh3.c
index 7a0d5c1..46b09e2 100644
--- a/arch/sh/mm/tlb-sh3.c
+++ b/arch/sh/mm/tlb-sh3.c
@@ -40,12 +40,17 @@ void update_mmu_cache(struct vm_area_str
 		return;
 
 #if defined(CONFIG_SH7705_CACHE_32KB)
-	struct page *page;
-	page = pte_page(pte);
-	if (VALID_PAGE(page) && !test_bit(PG_mapped, &page->flags)) {
-		unsigned long phys = pte_val(pte) & PTE_PHYS_MASK;
-		__flush_wback_region((void *)P1SEGADDR(phys), PAGE_SIZE);
-		__set_bit(PG_mapped, &page->flags);
+	{
+		struct page *page = pte_page(pte);
+		unsigned long pfn = pte_pfn(pte);
+
+		if (pfn_valid(pfn) && !test_bit(PG_mapped, &page->flags)) {
+			unsigned long phys = pte_val(pte) & PTE_PHYS_MASK;
+
+			__flush_wback_region((void *)P1SEGADDR(phys),
+					     PAGE_SIZE);
+			__set_bit(PG_mapped, &page->flags);
+		}
 	}
 #endif
 
@@ -80,7 +85,7 @@ void __flush_tlb_page(unsigned long asid
 	 */
 	addr = MMU_TLB_ADDRESS_ARRAY | (page & 0x1F000);
 	data = (page & 0xfffe0000) | asid; /* VALID bit is off */
-	
+
 	if ((cpu_data->flags & CPU_HAS_MMU_PAGE_ASSOC)) {
 		addr |= MMU_PAGE_ASSOC_BIT;
 		ways = 1;	/* we already know the way .. */
---
0.99.8.GIT
