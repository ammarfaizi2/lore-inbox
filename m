Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267473AbUHFAdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267473AbUHFAdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUHFAdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:33:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7617 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S267473AbUHFAds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:33:48 -0400
Date: Thu, 5 Aug 2004 17:33:46 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Remove pci-dma.c
Message-ID: <20040805173346.K14159@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pci-dma.c. It is cruft left over from the DMA API changes.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/kernel/pci-dma.c b/arch/ppc/kernel/pci-dma.c
--- a/arch/ppc/kernel/pci-dma.c	Thu Aug  5 17:22:09 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,49 +0,0 @@
-/*
- * Copyright (C) 2000   Ani Joshi <ajoshi@unixbox.com>
- *
- *
- * Dynamic DMA mapping support.
- *
- * swiped from i386
- *
- */
-
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/pci.h>
-#include <asm/io.h>
-
-void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-			   dma_addr_t *dma_handle)
-{
-	void *ret;
-	int gfp = GFP_ATOMIC;
-
-	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
-		gfp |= GFP_DMA;
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	ret = consistent_alloc(gfp, size, dma_handle);
-#else
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-#endif
-
-	if (ret != NULL) {
-		memset(ret, 0, size);
-#ifndef CONFIG_NOT_COHERENT_CACHE
-		*dma_handle = virt_to_bus(ret);
-#endif
-	}
-	return ret;
-}
-
-void pci_free_consistent(struct pci_dev *hwdev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle)
-{
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	consistent_free(vaddr);
-#else
-	free_pages((unsigned long)vaddr, get_order(size));
-#endif
-}
