Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753391AbWKFUTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbWKFUTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbWKFUTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:19:38 -0500
Received: from palrel12.hp.com ([156.153.255.237]:6087 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1752622AbWKFUTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:19:37 -0500
Date: Mon, 6 Nov 2006 14:19:36 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 5/12] repost: cciss: disable DMA prefetch on P600
Message-ID: <20061106201936.GE17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 5 of 12

This patch unconditionally disables DMA prefetch on the P600 controller. An
ASIC bug may result in prefetching beyond the end of physical memory.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

--------------------------------------------------------------------------------

---

 drivers/block/cciss.c     |   11 +++++++++++
 drivers/block/cciss_cmd.h |    1 +
 2 files changed, 12 insertions(+)

diff -puN drivers/block/cciss.c~cciss_p600_dma_for_lx2619-rc4 drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_p600_dma_for_lx2619-rc4	2006-11-06 13:16:01.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:27:24.000000000 -0600
@@ -2997,6 +2997,17 @@ static int cciss_pci_init(ctlr_info_t *c
 	}
 #endif
 
+	/* Disabling DMA prefetch for the P600
+	 * An ASIC bug may result in a prefetch beyond
+	 * physical memory.
+	 */
+	if(board_id == 0x3225103C) {
+		__u32 dma_prefetch;
+		dma_prefetch = readl(c->vaddr + I2O_DMA1_CFG);
+		dma_prefetch |= 0x8000;
+		writel(dma_prefetch, c->vaddr + I2O_DMA1_CFG);
+	}
+
 #ifdef CCISS_DEBUG
 	printk("Trying to put board into Simple mode\n");
 #endif				/* CCISS_DEBUG */
diff -puN drivers/block/cciss_cmd.h~cciss_p600_dma_for_lx2619-rc4 drivers/block/cciss_cmd.h
--- linux-2.6/drivers/block/cciss_cmd.h~cciss_p600_dma_for_lx2619-rc4	2006-11-06 13:16:01.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss_cmd.h	2006-11-06 13:26:42.000000000 -0600
@@ -55,6 +55,7 @@
 #define I2O_INT_MASK            0x34
 #define I2O_IBPOST_Q            0x40
 #define I2O_OBPOST_Q            0x44
+#define I2O_DMA1_CFG		0x214
 
 //Configuration Table
 #define CFGTBL_ChangeReq        0x00000001l
_
