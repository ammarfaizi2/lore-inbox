Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030687AbVIIWKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030687AbVIIWKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030674AbVIIWKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:10:03 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:13470 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030682AbVIIWKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:10:00 -0400
Date: Fri, 9 Sep 2005 17:09:38 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 6/8] cciss: fix for DMA brokeness
Message-ID: <20050909220938.GF4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 6 of 8
The CCISS driver seems to loose track of DMA mappings
created by it's fill_cmd() routine.  Neither callers of this routine are
extracting the DMA address created in order to do the unmap.
Instead, they simply try to unmap 0x0.  It's easy to see this
problem on an x86_64 system when using the "swiotlb=force"
boot option.  In this case, the driver is leaking resources
of the swiotlb and not causing a sync of the bounce buffer.  Thanks

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613-p004/drivers/block/cciss.c lx2613/drivers/block/cciss.c
--- lx2613-p004/drivers/block/cciss.c	2005-09-09 16:09:13.362617000 -0500
+++ lx2613/drivers/block/cciss.c	2005-09-09 16:14:54.116814816 -0500
@@ -1731,8 +1731,10 @@ case CMD_HARDWARE_ERR:
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
 
@@ -2013,8 +2015,10 @@ resend_cmd1:
 		
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
@@ -3097,9 +3101,10 @@ static void __devexit cciss_remove_one (
 	/* remove it from the disk list */
 	for (j = 0; j < NWD; j++) {
 		struct gendisk *disk = hba[i]->gendisk[j];
-		if (disk->flags & GENHD_FL_UP)
-			blk_cleanup_queue(disk->queue);
+		if (disk->flags & GENHD_FL_UP) {
 			del_gendisk(disk);
+			blk_cleanup_queue(disk->queue);
+		}
 	}
 
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
