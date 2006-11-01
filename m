Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752514AbWKAWGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbWKAWGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbWKAWGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:06:35 -0500
Received: from palrel10.hp.com ([156.153.255.245]:26858 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1752514AbWKAWGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:06:34 -0500
Date: Wed, 1 Nov 2006 16:06:33 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 5/8] cciss: disable DMA prefetch for P600
Message-ID: <20061101220633.GE29928@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PATCH 5/8 

This disables DMA prefetch for the P600 on IPF. A chip bug may result in
a DMA prefetch going falling off into holes in memory. On Proliant x86[_64]
systems the top page of memory is mapped out and the io hole below 4GB is
similiarly protected because the memory at the lower boundary of the hole 
is used by ACPI and other things.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c     |   14 ++++++++++++++
 cciss_cmd.h |    1 +
 2 files changed, 15 insertions(+)
--------------------------------------------------------------------------------
diff -urNp linux-2.6-p00004/drivers/block/cciss.c linux-2.6/drivers/block/cciss.c
--- linux-2.6-p00004/drivers/block/cciss.c	2006-10-31 15:20:25.000000000 -0600
+++ linux-2.6/drivers/block/cciss.c	2006-10-31 15:42:59.000000000 -0600
@@ -2997,6 +2997,20 @@ static int cciss_pci_init(ctlr_info_t *c
 	}
 #endif
 
+#ifdef CONFIG_IA64
+	{
+		/* DMA prefetch must be disabled on P600 on platforms that may
+		 * present noncontiguous memory.
+		 */
+		__u32 dma_prefetch
+		if(board_id == 0x3225103C) {
+			dma_prefetch = readl(c->vaddr + I2O_DMA1_CFG);
+			dma_prefetch |= 0x8000;
+			writel(dma_prefetch, c->vaddr + I2O_DMA1_CFG);
+		}
+	}
+#endif /* CONFIG_IA64 */
+
 #ifdef CCISS_DEBUG
 	printk("Trying to put board into Simple mode\n");
 #endif				/* CCISS_DEBUG */
diff -urNp linux-2.6-p00004/drivers/block/cciss_cmd.h linux-2.6/drivers/block/cciss_cmd.h
--- linux-2.6-p00004/drivers/block/cciss_cmd.h	2006-10-31 14:31:05.000000000 -0600
+++ linux-2.6/drivers/block/cciss_cmd.h	2006-10-31 15:43:18.000000000 -0600
@@ -55,6 +55,7 @@
 #define I2O_INT_MASK            0x34
 #define I2O_IBPOST_Q            0x40
 #define I2O_OBPOST_Q            0x44
+#define I2O_DMA1_CFG		0x214
 
 //Configuration Table
 #define CFGTBL_ChangeReq        0x00000001l
