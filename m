Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVIKQ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVIKQ7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVIKQ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:59:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:28094 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750791AbVIKQ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:59:20 -0400
Date: Sun, 11 Sep 2005 18:59:19 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [3/3] Use the DMA32 zone for 
 dma_alloc_coherent()/pci_alloc_consistent on x86-64
Message-ID: <43246267.mailL4Y1GM1RI@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DMA32 zone for dma_alloc_coherent()/pci_alloc_consistent on x86-64

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/pci-gart.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-gart.c
+++ linux/arch/x86_64/kernel/pci-gart.c
@@ -219,6 +219,8 @@ dma_alloc_coherent(struct device *dev, s
 	/* Kludge to make it bug-to-bug compatible with i386. i386
 	   uses the normal dma_mask for alloc_coherent. */
 	dma_mask &= *dev->dma_mask;
+	if (dma_mask <= 0xffffffff)
+		gfp |= GFP_DMA32;
 
  again:
 	memory = dma_alloc_pages(dev, gfp, get_order(size));
@@ -245,7 +247,7 @@ dma_alloc_coherent(struct device *dev, s
 				}
 
 				if (!(gfp & GFP_DMA)) { 
-					gfp |= GFP_DMA; 
+					gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 					goto again;
 				}
 				return NULL;
