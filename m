Return-Path: <linux-kernel-owner+w=401wt.eu-S1750792AbXACN50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbXACN50 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbXACN50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:57:26 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:59372 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbXACN5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:57:25 -0500
X-Originating-Ip: 74.109.98.100
Date: Wed, 3 Jan 2007 08:51:43 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Replace __get_free_page() + memset(0) with get_zeroed_page()
 calls.
Message-ID: <Pine.LNX.4.64.0701030845500.5042@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Replace the small number of combinations of __get_free_page() plus a
call to memset(...,0,PAGE_SIZE) with a single call to
get_zeroed_page().

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  all of the following simplifications *look* valid, but i'm happy to
be convinced otherwise.


 arch/sparc/mm/sun4c.c           |    4 +---
 arch/sparc64/kernel/pci_iommu.c |    3 +--
 drivers/s390/net/qeth_eddp.c    |    3 +--
 include/asm-m68k/sun3_pgalloc.h |    3 +--
 include/asm-um/pgtable-3level.h |    5 +----
 sound/oss/emu10k1/main.c        |    3 +--
 sound/oss/emu10k1/mixer.c       |    3 +--
 7 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 436021c..ccb6d20 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -1946,9 +1946,7 @@ static pte_t *sun4c_pte_alloc_one_kernel(struct mm_struct *mm, unsigned long add
 	if ((pte = sun4c_pte_alloc_one_fast(mm, address)) != NULL)
 		return pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		memset(pte, 0, PAGE_SIZE);
+	pte = (pte_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
 	return pte;
 }

diff --git a/arch/sparc64/kernel/pci_iommu.c b/arch/sparc64/kernel/pci_iommu.c
index 2e7f142..c9c45cc 100644
--- a/arch/sparc64/kernel/pci_iommu.c
+++ b/arch/sparc64/kernel/pci_iommu.c
@@ -149,12 +149,11 @@ void pci_iommu_table_init(struct pci_iommu *iommu, int tsbsize, u32 dma_offset,
 	/* Allocate and initialize the dummy page which we
 	 * set inactive IO PTEs to point to.
 	 */
-	iommu->dummy_page = __get_free_pages(GFP_KERNEL, 0);
+	iommu->dummy_page = get_zeroed_page(GFP_KERNEL);
 	if (!iommu->dummy_page) {
 		prom_printf("PCI_IOMMU: Error, gfp(dummy_page) failed.\n");
 		prom_halt();
 	}
-	memset((void *)iommu->dummy_page, 0, PAGE_SIZE);
 	iommu->dummy_page_pa = (unsigned long) __pa(iommu->dummy_page);

 	/* Now allocate and setup the IOMMU page table itself.  */
diff --git a/drivers/s390/net/qeth_eddp.c b/drivers/s390/net/qeth_eddp.c
index 6bb558a..68c06d0 100644
--- a/drivers/s390/net/qeth_eddp.c
+++ b/drivers/s390/net/qeth_eddp.c
@@ -558,14 +558,13 @@ qeth_eddp_create_context_generic(struct qeth_card *card, struct sk_buff *skb,
 		return NULL;
 	}
 	for (i = 0; i < ctx->num_pages; ++i){
-		addr = (u8 *)__get_free_page(GFP_ATOMIC);
+		addr = (u8 *)get_zeroed_page(GFP_ATOMIC);
 		if (addr == NULL){
 			QETH_DBF_TEXT(trace, 2, "ceddpcn3");
 			ctx->num_pages = i;
 			qeth_eddp_free_context(ctx);
 			return NULL;
 		}
-		memset(addr, 0, PAGE_SIZE);
 		ctx->pages[i] = addr;
 	}
 	ctx->elements = kcalloc(ctx->num_elements,
diff --git a/include/asm-m68k/sun3_pgalloc.h b/include/asm-m68k/sun3_pgalloc.h
index fd82411..b3932e5 100644
--- a/include/asm-m68k/sun3_pgalloc.h
+++ b/include/asm-m68k/sun3_pgalloc.h
@@ -36,12 +36,11 @@ static inline void pte_free(struct page *page)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	unsigned long page = __get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	unsigned long page = get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);

 	if (!page)
 		return NULL;

-	memset((void *)page, 0, PAGE_SIZE);
 	return (pte_t *) (page);
 }

diff --git a/include/asm-um/pgtable-3level.h b/include/asm-um/pgtable-3level.h
index ca0c2a9..6f43b58 100644
--- a/include/asm-um/pgtable-3level.h
+++ b/include/asm-um/pgtable-3level.h
@@ -61,10 +61,7 @@ static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }

 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-        pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
-
-        if(pmd)
-                memset(pmd, 0, PAGE_SIZE);
+        pmd_t *pmd = (pmd_t *) get_zeroed_page(GFP_KERNEL);

         return pmd;
 }
diff --git a/sound/oss/emu10k1/main.c b/sound/oss/emu10k1/main.c
index 6c59df7..c71976c 100644
--- a/sound/oss/emu10k1/main.c
+++ b/sound/oss/emu10k1/main.c
@@ -576,13 +576,12 @@ static int __devinit fx_init(struct emu10k1_card *card)
 		mgr->current_pages = (11 + PATCHES_PER_PAGE - 1) / PATCHES_PER_PAGE;

 	for (i = 0; i < mgr->current_pages; i++) {
-		mgr->patch[i] = (void *)__get_free_page(GFP_KERNEL);
+		mgr->patch[i] = (void *)get_zeroed_page(GFP_KERNEL);
 		if (mgr->patch[i] == NULL) {
 			mgr->current_pages = i;
 			fx_cleanup(mgr);
 			return -ENOMEM;
 		}
-		memset(mgr->patch[i], 0, PAGE_SIZE);
 	}

 	if (card->is_audigy) {
diff --git a/sound/oss/emu10k1/mixer.c b/sound/oss/emu10k1/mixer.c
index 6419796..53363a9 100644
--- a/sound/oss/emu10k1/mixer.c
+++ b/sound/oss/emu10k1/mixer.c
@@ -369,13 +369,12 @@ static int emu10k1_private_mixer(struct emu10k1_card *card, unsigned int cmd, un

 				if (page >= card->mgr.current_pages) {
 					for (i = card->mgr.current_pages; i < page + 1; i++) {
-				                card->mgr.patch[i] = (void *)__get_free_page(GFP_KERNEL);
+				                card->mgr.patch[i] = (void *)get_zeroed_page(GFP_KERNEL);
 						if(card->mgr.patch[i] == NULL) {
 							card->mgr.current_pages = i;
 							ret = -ENOMEM;
 							break;
 						}
-						memset(card->mgr.patch[i], 0, PAGE_SIZE);
 					}
 					card->mgr.current_pages = page + 1;
 				}

