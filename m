Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVIYTQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVIYTQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 15:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVIYTQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 15:16:25 -0400
Received: from [85.8.12.41] ([85.8.12.41]:57477 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932270AbVIYTQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 15:16:24 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] wbsd: use dma_alloc insted of kmalloc
Date: Sun, 25 Sep 2005 21:16:23 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.co.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050925191614.23944.2485.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 doesn't seem to like being passed pointers allocated using
kmalloc to the DMA mapping API. Change allocation to use
dma_alloc_coherent() instead.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1543,18 +1543,17 @@ static void __devinit wbsd_request_dma(s
 	 * We need to allocate a special buffer in
 	 * order for ISA to be able to DMA to it.
 	 */
-	host->dma_buffer = kmalloc(WBSD_DMA_SIZE,
+
+	mmc_dev(host->mmc)->coherent_dma_mask = 0xffffff;
+	mmc_dev(host->mmc)->dma_mask = &mmc_dev(host->mmc)->coherent_dma_mask;
+
+	host->dma_buffer = dma_alloc_coherent(mmc_dev(host->mmc),
+		WBSD_DMA_SIZE, &host->dma_addr,
 		GFP_NOIO | GFP_DMA | __GFP_REPEAT | __GFP_NOWARN);
 	if (!host->dma_buffer)
 		goto free;
 
 	/*
-	 * Translate the address to a physical address.
-	 */
-	host->dma_addr = dma_map_single(host->mmc->dev, host->dma_buffer,
-		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
-
-	/*
 	 * ISA DMA must be aligned on a 64k basis.
 	 */
 	if ((host->dma_addr & 0xffff) != 0)
@@ -1575,12 +1574,11 @@ kfree:
 	 */
 	BUG_ON(1);
 
-	dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
-		DMA_BIDIRECTIONAL);
-	host->dma_addr = (dma_addr_t)NULL;
+	dma_free_coherent(mmc_dev(host->mmc), WBSD_DMA_SIZE,
+		host->dma_buffer, host->dma_addr);
 
-	kfree(host->dma_buffer);
 	host->dma_buffer = NULL;
+	host->dma_addr = (dma_addr_t)NULL;
 
 free:
 	free_dma(dma);
@@ -1592,11 +1590,9 @@ err:
 
 static void __devexit wbsd_release_dma(struct wbsd_host* host)
 {
-	if (host->dma_addr)
-		dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
-			DMA_BIDIRECTIONAL);
 	if (host->dma_buffer)
-		kfree(host->dma_buffer);
+		dma_free_coherent(mmc_dev(host->mmc), WBSD_DMA_SIZE,
+			host->dma_buffer, host->dma_addr);
 	if (host->dma >= 0)
 		free_dma(host->dma);
 

