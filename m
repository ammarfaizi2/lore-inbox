Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030517AbWJJV4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbWJJV4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbWJJVqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:46:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24251 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030496AbWJJVq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:46:28 -0400
To: torvalds@osdl.org
Subject: [PATCH] ia64/sn __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPQh-0007Mf-9O@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:46:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/sn/pci/pcibr/pcibr_ate.c   |    2 +-
 arch/ia64/sn/pci/tioce_provider.c    |   42 +++++++++++++++++-----------------
 include/asm-ia64/sn/pcibr_provider.h |    2 +-
 include/asm-ia64/sn/tioca_provider.h |    4 ++-
 include/asm-ia64/sn/tioce_provider.h |    2 +-
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/ia64/sn/pci/pcibr/pcibr_ate.c b/arch/ia64/sn/pci/pcibr/pcibr_ate.c
index 5eb1e1e..935029f 100644
--- a/arch/ia64/sn/pci/pcibr/pcibr_ate.c
+++ b/arch/ia64/sn/pci/pcibr/pcibr_ate.c
@@ -126,7 +126,7 @@ int pcibr_ate_alloc(struct pcibus_info *
  * Setup an Address Translation Entry as specified.  Use either the Bridge
  * internal maps or the external map RAM, as appropriate.
  */
-static inline u64 *pcibr_ate_addr(struct pcibus_info *pcibus_info,
+static inline u64 __iomem *pcibr_ate_addr(struct pcibus_info *pcibus_info,
 				       int ate_index)
 {
 	if (ate_index < pcibus_info->pbi_int_ate_size) {
diff --git a/arch/ia64/sn/pci/tioce_provider.c b/arch/ia64/sn/pci/tioce_provider.c
index 0e81f68..46e16dc 100644
--- a/arch/ia64/sn/pci/tioce_provider.c
+++ b/arch/ia64/sn/pci/tioce_provider.c
@@ -53,7 +53,7 @@ #include <asm/sn/sn2/sn_hwperf.h>
  */
 
 static void inline
-tioce_mmr_war_pre(struct tioce_kernel *kern, void *mmr_addr)
+tioce_mmr_war_pre(struct tioce_kernel *kern, void __iomem *mmr_addr)
 {
 	u64 mmr_base;
 	u64 mmr_offset;
@@ -62,7 +62,7 @@ tioce_mmr_war_pre(struct tioce_kernel *k
 		return;
 
 	mmr_base = kern->ce_common->ce_pcibus.bs_base;
-	mmr_offset = (u64)mmr_addr - mmr_base;
+	mmr_offset = (unsigned long)mmr_addr - mmr_base;
 
 	if (mmr_offset < 0x45000) {
 		u64 mmr_war_offset;
@@ -79,7 +79,7 @@ tioce_mmr_war_pre(struct tioce_kernel *k
 }
 
 static void inline
-tioce_mmr_war_post(struct tioce_kernel *kern, void *mmr_addr)
+tioce_mmr_war_post(struct tioce_kernel *kern, void __iomem *mmr_addr)
 {
 	u64 mmr_base;
 	u64 mmr_offset;
@@ -88,7 +88,7 @@ tioce_mmr_war_post(struct tioce_kernel *
 		return;
 
 	mmr_base = kern->ce_common->ce_pcibus.bs_base;
-	mmr_offset = (u64)mmr_addr - mmr_base;
+	mmr_offset = (unsigned long)mmr_addr - mmr_base;
 
 	if (mmr_offset < 0x45000) {
 		if (mmr_offset == 0x100)
@@ -223,7 +223,7 @@ tioce_dma_d64(unsigned long ct_addr, int
  * @pci_dev.
  */
 static inline void
-pcidev_to_tioce(struct pci_dev *pdev, struct tioce **base,
+pcidev_to_tioce(struct pci_dev *pdev, struct tioce __iomem **base,
 		struct tioce_kernel **kernel, int *port)
 {
 	struct pcidev_info *pcidev_info;
@@ -235,7 +235,7 @@ pcidev_to_tioce(struct pci_dev *pdev, st
 	ce_kernel = (struct tioce_kernel *)ce_common->ce_kernel_private;
 
 	if (base)
-		*base = (struct tioce *)ce_common->ce_pcibus.bs_base;
+		*base = (struct tioce __iomem *)ce_common->ce_pcibus.bs_base;
 	if (kernel)
 		*kernel = ce_kernel;
 
@@ -275,13 +275,13 @@ tioce_alloc_map(struct tioce_kernel *ce_
 	u64 pagesize;
 	int msi_capable, msi_wanted;
 	u64 *ate_shadow;
-	u64 *ate_reg;
+	u64 __iomem *ate_reg;
 	u64 addr;
-	struct tioce *ce_mmr;
+	struct tioce __iomem *ce_mmr;
 	u64 bus_base;
 	struct tioce_dmamap *map;
 
-	ce_mmr = (struct tioce *)ce_kern->ce_common->ce_pcibus.bs_base;
+	ce_mmr = (struct tioce __iomem *)ce_kern->ce_common->ce_pcibus.bs_base;
 
 	switch (type) {
 	case TIOCE_ATE_M32:
@@ -386,7 +386,7 @@ tioce_dma_d32(struct pci_dev *pdev, u64 
 {
 	int dma_ok;
 	int port;
-	struct tioce *ce_mmr;
+	struct tioce __iomem *ce_mmr;
 	struct tioce_kernel *ce_kern;
 	u64 ct_upper;
 	u64 ct_lower;
@@ -461,7 +461,7 @@ tioce_dma_unmap(struct pci_dev *pdev, dm
 	int i;
 	int port;
 	struct tioce_kernel *ce_kern;
-	struct tioce *ce_mmr;
+	struct tioce __iomem *ce_mmr;
 	unsigned long flags;
 
 	bus_addr = tioce_dma_barrier(bus_addr, 0);
@@ -700,9 +700,9 @@ static void
 tioce_reserve_m32(struct tioce_kernel *ce_kern, u64 base, u64 limit)
 {
 	int ate_index, last_ate, ps;
-	struct tioce *ce_mmr;
+	struct tioce __iomem *ce_mmr;
 
-	ce_mmr = (struct tioce *)ce_kern->ce_common->ce_pcibus.bs_base;
+	ce_mmr = (struct tioce __iomem *)ce_kern->ce_common->ce_pcibus.bs_base;
 	ps = ce_kern->ce_ate3240_pagesize;
 	ate_index = ATE_PAGE(base, ps);
 	last_ate = ate_index + ATE_NPAGES(base, limit-base+1, ps) - 1;
@@ -736,7 +736,7 @@ tioce_kern_init(struct tioce_common *tio
 	int dev;
 	u32 tmp;
 	unsigned int seg, bus;
-	struct tioce *tioce_mmr;
+	struct tioce __iomem *tioce_mmr;
 	struct tioce_kernel *tioce_kern;
 
 	tioce_kern = kzalloc(sizeof(struct tioce_kernel), GFP_KERNEL);
@@ -767,7 +767,7 @@ tioce_kern_init(struct tioce_common *tio
 	 * the ate's.
 	 */
 
-	tioce_mmr = (struct tioce *)tioce_common->ce_pcibus.bs_base;
+	tioce_mmr = (struct tioce __iomem *)tioce_common->ce_pcibus.bs_base;
 	tioce_mmr_clri(tioce_kern, &tioce_mmr->ce_ure_page_map,
 		       CE_URE_PAGESIZE_MASK);
 	tioce_mmr_seti(tioce_kern, &tioce_mmr->ce_ure_page_map,
@@ -858,7 +858,7 @@ tioce_force_interrupt(struct sn_irq_info
 	struct pcidev_info *pcidev_info;
 	struct tioce_common *ce_common;
 	struct tioce_kernel *ce_kern;
-	struct tioce *ce_mmr;
+	struct tioce __iomem *ce_mmr;
 	u64 force_int_val;
 
 	if (!sn_irq_info->irq_bridge)
@@ -872,7 +872,7 @@ tioce_force_interrupt(struct sn_irq_info
 		return;
 
 	ce_common = (struct tioce_common *)pcidev_info->pdi_pcibus_info;
-	ce_mmr = (struct tioce *)ce_common->ce_pcibus.bs_base;
+	ce_mmr = (struct tioce __iomem *)ce_common->ce_pcibus.bs_base;
 	ce_kern = (struct tioce_kernel *)ce_common->ce_kernel_private;
 
 	/*
@@ -953,7 +953,7 @@ tioce_target_interrupt(struct sn_irq_inf
 	struct pcidev_info *pcidev_info;
 	struct tioce_common *ce_common;
 	struct tioce_kernel *ce_kern;
-	struct tioce *ce_mmr;
+	struct tioce __iomem *ce_mmr;
 	int bit;
 	u64 vector;
 
@@ -962,7 +962,7 @@ tioce_target_interrupt(struct sn_irq_inf
 		return;
 
 	ce_common = (struct tioce_common *)pcidev_info->pdi_pcibus_info;
-	ce_mmr = (struct tioce *)ce_common->ce_pcibus.bs_base;
+	ce_mmr = (struct tioce __iomem *)ce_common->ce_pcibus.bs_base;
 	ce_kern = (struct tioce_kernel *)ce_common->ce_kernel_private;
 
 	bit = sn_irq_info->irq_int_bit;
@@ -994,7 +994,7 @@ tioce_bus_fixup(struct pcibus_bussoft *p
 	cnodeid_t my_cnode, mem_cnode;
 	struct tioce_common *tioce_common;
 	struct tioce_kernel *tioce_kern;
-	struct tioce *tioce_mmr;
+	struct tioce __iomem *tioce_mmr;
 
 	/*
 	 * Allocate kernel bus soft and copy from prom.
@@ -1018,7 +1018,7 @@ tioce_bus_fixup(struct pcibus_bussoft *p
 	 * interrupt handler.
 	 */
 
-	tioce_mmr = (struct tioce *)tioce_common->ce_pcibus.bs_base;
+	tioce_mmr = (struct tioce __iomem *)tioce_common->ce_pcibus.bs_base;
 	tioce_mmr_seti(tioce_kern, &tioce_mmr->ce_adm_int_status_alias, ~0ULL);
 	tioce_mmr_seti(tioce_kern, &tioce_mmr->ce_adm_error_summary_alias,
 		       ~0ULL);
diff --git a/include/asm-ia64/sn/pcibr_provider.h b/include/asm-ia64/sn/pcibr_provider.h
index e3b0c3f..da3eade 100644
--- a/include/asm-ia64/sn/pcibr_provider.h
+++ b/include/asm-ia64/sn/pcibr_provider.h
@@ -135,7 +135,7 @@ extern void             pcireg_intr_addr
 extern void             pcireg_force_intr_set(struct pcibus_info *, int);
 extern u64         pcireg_wrb_flush_get(struct pcibus_info *, int);
 extern void             pcireg_int_ate_set(struct pcibus_info *, int, u64);
-extern u64 *	pcireg_int_ate_addr(struct pcibus_info *, int);
+extern u64 __iomem *	pcireg_int_ate_addr(struct pcibus_info *, int);
 extern void 		pcibr_force_interrupt(struct sn_irq_info *sn_irq_info);
 extern void 		pcibr_change_devices_irq(struct sn_irq_info *sn_irq_info);
 extern int 		pcibr_ate_alloc(struct pcibus_info *, int);
diff --git a/include/asm-ia64/sn/tioca_provider.h b/include/asm-ia64/sn/tioca_provider.h
index 65cdd73..9a820ac 100644
--- a/include/asm-ia64/sn/tioca_provider.h
+++ b/include/asm-ia64/sn/tioca_provider.h
@@ -162,11 +162,11 @@ static inline void
 tioca_tlbflush(struct tioca_kernel *tioca_kernel)
 {
 	volatile u64 tmp;
-	volatile struct tioca *ca_base;
+	volatile struct tioca __iomem *ca_base;
 	struct tioca_common *tioca_common;
 
 	tioca_common = tioca_kernel->ca_common;
-	ca_base = (struct tioca *)tioca_common->ca_common.bs_base;
+	ca_base = (struct tioca __iomem *)tioca_common->ca_common.bs_base;
 
 	/*
 	 * Explicit flushes not needed if GART is in cached mode
diff --git a/include/asm-ia64/sn/tioce_provider.h b/include/asm-ia64/sn/tioce_provider.h
index 6d62b13..32c32f3 100644
--- a/include/asm-ia64/sn/tioce_provider.h
+++ b/include/asm-ia64/sn/tioce_provider.h
@@ -53,7 +53,7 @@ struct tioce_dmamap {
 	u64		ct_start;	/* coretalk start address */
 	u64		pci_start;	/* bus start address */
 
-	u64		*ate_hw;	/* hw ptr of first ate in map */
+	u64		__iomem *ate_hw;/* hw ptr of first ate in map */
 	u64		*ate_shadow;	/* shadow ptr of firat ate */
 	u16		ate_count;	/* # ate's in the map */
 };
-- 
1.4.2.GIT


