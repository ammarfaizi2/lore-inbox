Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTAHTjl>; Wed, 8 Jan 2003 14:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267862AbTAHTjl>; Wed, 8 Jan 2003 14:39:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27112 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267859AbTAHTjj>;
	Wed, 8 Jan 2003 14:39:39 -0500
Date: Wed, 8 Jan 2003 19:46:22 GMT
Message-Id: <200301081946.h08JkMiM006906@noodles.internal>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Fix up dma_alloc_coherent with 64bit DMA masks on i386.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cset 1.808 in 2.4 never got propagated forward to 2.5
It's pretty much the same fix as below (s/!=/</), but with the following
changes
- This was a patch to pci_alloc_consistant(), which now seems to be
  dma_alloc_coherent()
- Removal of the u32 cast


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/pci-dma.c linux-2.5/arch/i386/kernel/pci-dma.c
--- bk-linus/arch/i386/kernel/pci-dma.c	2003-01-08 10:46:59.000000000 -0100
+++ linux-2.5/arch/i386/kernel/pci-dma.c	2003-01-08 11:02:50.000000000 -0100
@@ -19,7 +19,7 @@ void *dma_alloc_coherent(struct device *
 	void *ret;
 	int gfp = GFP_ATOMIC;
 
-	if (dev == NULL || ((u32)*dev->dma_mask != 0xffffffff))
+	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
