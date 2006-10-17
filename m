Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWJQVNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWJQVNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWJQVNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:13:07 -0400
Received: from palrel10.hp.com ([156.153.255.245]:3261 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750884AbWJQVNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:13:06 -0400
Date: Tue, 17 Oct 2006 16:13:03 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] cciss: disable dma prefetch for P600
Message-ID: <20061017211303.GB17874@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 2/2
Turned off DMA prefetch for the P600 on systems which may present
discontiguous memory.

---
commit 68e76156e7a203a86996ac99c1326f098d3191f6
tree b191a99ae1bfa6588860136265f11f9ef789683a
parent 499cc64fc708f3a25985bea3b77b40c3448ccbf8
author Mike Miller <mikem@beardog.cca.cpqcorp.net> Tue, 17 Oct 2006 16:02:22 -0500
committer Mike Miller <mikem@beardog.cca.cpqcorp.net> Tue, 17 Oct 2006 16:02:22 -0500

Signed-off-by: Mike Miller <mikem@beardog.cca.cpqcorp.net>

 drivers/block/cciss.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index a0a1dd9..b445528 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -2982,6 +2982,21 @@ #ifdef CONFIG_X86
 	}
 #endif
 
+#if defined CONFIG_IA64 || if defined CONFIG_X86_64
+	{
+		/* DMA prefetch must be disabled on P600 on platforms that may
+		 * present noncontiguous memory.
+		 */
+
+		__u32 dma_prefetch;
+		if(board_id == 0x3225103C) {
+			dma_prefetch = readl(c->vaddr + I2O0_DMA1_CFG);
+			dma_prefetch |= 0x8000;
+			writel(c->vaddr + I2O0_DMA1_CFG, dma_prefetch);
+		}
+	}
+#endif /* CONFIG_IA64 || CONFIG_X86_64 */
+
 #ifdef CCISS_DEBUG
 	printk("Trying to put board into Simple mode\n");
 #endif				/* CCISS_DEBUG */
