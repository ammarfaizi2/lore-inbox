Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbWHJThL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWHJThL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbWHJThJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:3052 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932658AbWHJThE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:04 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [105/145] x86_64: only verify the allocation bitmap if CONFIG_IOMMU_DEBUG is on
Message-Id: <20060810193703.62D2A13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:03 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Introduce new function verify_bit_range(). Define two versions, one
for CONFIG_IOMMU_DEBUG enabled and one for disabled. Previously we
were checking that the bitmap was consistent every time we allocated
or freed an entry in the TCE table, which is good for debugging but
incurs an unnecessary penalty on non debug builds.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |   44 +++++++++++++++++++++++++++++++--------
 1 files changed, 35 insertions(+), 9 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -133,12 +133,35 @@ static inline void tce_cache_blast_stres
 {
 	tce_cache_blast(tbl);
 }
+
+static inline unsigned long verify_bit_range(unsigned long* bitmap,
+	int expected, unsigned long start, unsigned long end)
+{
+	unsigned long idx = start;
+
+	BUG_ON(start >= end);
+
+	while (idx < end) {
+		if (!!test_bit(idx, bitmap) != expected)
+			return idx;
+		++idx;
+	}
+
+	/* all bits have the expected value */
+	return ~0UL;
+}
 #else /* debugging is disabled */
 int debugging __read_mostly = 0;
 
 static inline void tce_cache_blast_stress(struct iommu_table *tbl)
 {
 }
+
+static inline unsigned long verify_bit_range(unsigned long* bitmap,
+	int expected, unsigned long start, unsigned long end)
+{
+	return ~0UL;
+}
 #endif /* CONFIG_IOMMU_DEBUG */
 
 static inline unsigned int num_dma_pages(unsigned long dma, unsigned int dmalen)
@@ -162,6 +185,7 @@ static void iommu_range_reserve(struct i
 {
 	unsigned long index;
 	unsigned long end;
+	unsigned long badbit;
 
 	index = start_addr >> PAGE_SHIFT;
 
@@ -173,14 +197,15 @@ static void iommu_range_reserve(struct i
 	if (end > tbl->it_size) /* don't go off the table */
 		end = tbl->it_size;
 
-	while (index < end) {
-		if (test_bit(index, tbl->it_map))
+	badbit = verify_bit_range(tbl->it_map, 0, index, end);
+	if (badbit != ~0UL) {
+		if (printk_ratelimit())
 			printk(KERN_ERR "Calgary: entry already allocated at "
 			       "0x%lx tbl %p dma 0x%lx npages %u\n",
-			       index, tbl, start_addr, npages);
-		++index;
+			       badbit, tbl, start_addr, npages);
 	}
-	set_bit_string(tbl->it_map, start_addr >> PAGE_SHIFT, npages);
+
+	set_bit_string(tbl->it_map, index, npages);
 }
 
 static unsigned long iommu_range_alloc(struct iommu_table *tbl,
@@ -247,7 +272,7 @@ static void __iommu_free(struct iommu_ta
 	unsigned int npages)
 {
 	unsigned long entry;
-	unsigned long i;
+	unsigned long badbit;
 
 	entry = dma_addr >> PAGE_SHIFT;
 
@@ -255,11 +280,12 @@ static void __iommu_free(struct iommu_ta
 
 	tce_free(tbl, entry, npages);
 
-	for (i = 0; i < npages; ++i) {
-		if (!test_bit(entry + i, tbl->it_map))
+	badbit = verify_bit_range(tbl->it_map, 1, entry, entry + npages);
+	if (badbit != ~0UL) {
+		if (printk_ratelimit())
 			printk(KERN_ERR "Calgary: bit is off at 0x%lx "
 			       "tbl %p dma 0x%Lx entry 0x%lx npages %u\n",
-			       entry + i, tbl, dma_addr, entry, npages);
+			       badbit, tbl, dma_addr, entry, npages);
 	}
 
 	__clear_bit_string(tbl->it_map, entry, npages);
