Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVHQTQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVHQTQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVHQTQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:16:23 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:15542 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751210AbVHQTQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:16:22 -0400
Subject: [PATCH] fix cciss DMA unmap brokenness
From: Alex Williamson <alex.williamson@hp.com>
To: Mike Miller <Mike.Miller@hp.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Wed, 17 Aug 2005 13:16:24 -0600
Message-Id: <1124306185.6049.10.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The CCISS driver seems to loose track of DMA mappings created by it's
fill_cmd() routine.  Neither callers of this routine are extracting the
DMA address created in order to do the unmap.  Instead, they simply try
to unmap 0x0.  It's easy to see this problem on an x86_64 system when
using the "swiotlb=force" boot option.  In this case, the driver is
leaking resources of the swiotlb and not causing a sync of the bounce
buffer.  Thanks

Signed-off-by: Alex Williamson <alex.williamson@hp.com>

diff -r b9c8e9fdd6b2 drivers/block/cciss.c
--- a/drivers/block/cciss.c	Wed Aug 17 04:06:25 2005
+++ b/drivers/block/cciss.c	Wed Aug 17 12:53:40 2005
@@ -1420,8 +1420,10 @@
 		}
 	}	
 	/* unlock the buffers from DMA */
+	buff_dma_handle.val32.lower = c->SG[0].Addr.lower;
+	buff_dma_handle.val32.upper = c->SG[0].Addr.upper;
 	pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
-			size, PCI_DMA_BIDIRECTIONAL);
+			c->SG[0].Len, PCI_DMA_BIDIRECTIONAL);
 	cmd_free(h, c, 0);
         return(return_status);
 
@@ -1860,8 +1862,10 @@
 		
 cleanup1:	
 	/* unlock the data buffer from DMA */
+	buff_dma_handle.val32.lower = c->SG[0].Addr.lower;
+	buff_dma_handle.val32.upper = c->SG[0].Addr.upper;
 	pci_unmap_single(info_p->pdev, (dma_addr_t) buff_dma_handle.val,
-				size, PCI_DMA_BIDIRECTIONAL);
+				c->SG[0].Len, PCI_DMA_BIDIRECTIONAL);
 	cmd_free(info_p, c, 1);
 	return (status);
 } 


