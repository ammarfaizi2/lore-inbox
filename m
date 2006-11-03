Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753284AbWKCPyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbWKCPyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbWKCPyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:54:14 -0500
Received: from palrel12.hp.com ([156.153.255.237]:20123 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1753284AbWKCPyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:54:13 -0500
Date: Fri, 3 Nov 2006 09:54:12 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 5/8] resend cciss: disable DMA prefetch on P600
Message-ID: <20061103155412.GA1657@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 5 of 8 resend

This patch unconditionally disables DMA prefetch on the P600 controller. A
bug in the ASIC may result in prefetching either beyond the end of memory
or to fall off into a memory hole.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c     |   13 +++++++++++++
 cciss_cmd.h |    1 +
 2 files changed, 14 insertions(+)
--------------------------------------------------------------------------------
diff -urNp linux-2.6-p00004/drivers/block/cciss.c linux-2.6-p00005/drivers/block/cciss.c
--- linux-2.6-p00004/drivers/block/cciss.c	2006-10-31 15:20:25.000000000 -0600
+++ linux-2.6-p00005/drivers/block/cciss.c	2006-11-03 09:43:55.000000000 -0600
@@ -2997,6 +2997,19 @@ static int cciss_pci_init(ctlr_info_t *c
 	}
 #endif
 
+	{
+		/* Disabling DMA prefetch for the P600
+		 * An ASIC bug may result in a prefetch beyond
+		 * physical memory.
+		 */
+		__u32 dma_prefetch
+		if(board_id == 0x3225103C) {
+			dma_prefetch = readl(c->vaddr + I2O_DMA1_CFG);
+			dma_prefetch |= 0x8000;
+			writel(dma_prefetch, c->vaddr + I2O_DMA1_CFG);
+		}
+	}
+
 #ifdef CCISS_DEBUG
 	printk("Trying to put board into Simple mode\n");
 #endif				/* CCISS_DEBUG */
diff -urNp linux-2.6-p00004/drivers/block/cciss_cmd.h linux-2.6-p00005/drivers/block/cciss_cmd.h
--- linux-2.6-p00004/drivers/block/cciss_cmd.h	2006-10-31 14:31:05.000000000 -0600
+++ linux-2.6-p00005/drivers/block/cciss_cmd.h	2006-10-31 15:43:18.000000000 -0600
@@ -55,6 +55,7 @@
 #define I2O_INT_MASK            0x34
 #define I2O_IBPOST_Q            0x40
 #define I2O_OBPOST_Q            0x44
+#define I2O_DMA1_CFG		0x214
 
 //Configuration Table
 #define CFGTBL_ChangeReq        0x00000001l
