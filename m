Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRCBVjQ>; Fri, 2 Mar 2001 16:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRCBVjG>; Fri, 2 Mar 2001 16:39:06 -0500
Received: from [62.172.234.2] ([62.172.234.2]:11222 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129509AbRCBVjB>; Fri, 2 Mar 2001 16:39:01 -0500
Date: Fri, 2 Mar 2001 21:39:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] CS89x0 demands too many pages
In-Reply-To: <E14YteS-00020L-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103022137310.1440-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CS89x0 driver wants a 16KB or 64KB dma_buff (if use_dma and
ANY_ISA_DMA), thinks it's asking __get_dma_pages() for 4 or 16
pages, but actually it's demanding order 4 or order 16 buffer.
Patch below against 2.4.2-ac9 or 2.4.2, offset against 2.4.[01].

Hugh

--- 2.4.2-ac9/drivers/net/cs89x0.c	Tue Feb 13 21:15:05 2001
+++ linux/drivers/net/cs89x0.c	Fri Mar  2 18:23:42 2001
@@ -1075,7 +1075,7 @@
 		if (lp->isa_config & ANY_ISA_DMA) {
 			unsigned long flags;
 			lp->dma_buff = (unsigned char *)__get_dma_pages(GFP_KERNEL,
-							(lp->dmasize * 1024) / PAGE_SIZE);
+							get_order(lp->dmasize * 1024));
 
 			if (!lp->dma_buff) {
 				printk(KERN_ERR "%s: cannot get %dK memory for DMA\n", dev->name, lp->dmasize);
@@ -1456,7 +1456,7 @@
 static void release_dma_buff(struct net_local *lp)
 {
 	if (lp->dma_buff) {
-		free_pages((unsigned long)(lp->dma_buff), (lp->dmasize * 1024) / PAGE_SIZE);
+		free_pages((unsigned long)(lp->dma_buff), get_order(lp->dmasize * 1024));
 		lp->dma_buff = 0;
 	}
 }

