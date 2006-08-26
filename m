Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422937AbWHZAEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422937AbWHZAEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422941AbWHZADL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:03:11 -0400
Received: from mga06.intel.com ([134.134.136.21]:59488 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422934AbWHZADH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:03:07 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="h'?scan'208"; a="115152404:sNHT32177166"
Message-Id: <20060826000303.763296000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 17:02:33 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Kyle McMartin <kyle@parisc-linux.org>,
       Valerie Henson <val_henson@linux.intel.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: [patch 06/10] [TULIP] Clean up tulip.h
Content-Disposition: inline; filename=tulip-clean-up-tulip.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Grundler <grundler@parisc-linux.org>

Update/cleanup some definitions in tulip.h and tulip_core.c.

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/tulip.h      |   17 +++++++++++------
 drivers/net/tulip/tulip_core.c |    7 ++-----
 2 files changed, 13 insertions(+), 11 deletions(-)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip.h
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip.h
@@ -30,11 +30,10 @@
 /* undefine, or define to various debugging levels (>4 == obscene levels) */
 #define TULIP_DEBUG 1
 
-/* undefine USE_IO_OPS for MMIO, define for PIO */
 #ifdef CONFIG_TULIP_MMIO
-# undef USE_IO_OPS
+#define TULIP_BAR	1	/* CBMA */
 #else
-# define USE_IO_OPS 1
+#define TULIP_BAR	0	/* CBIO */
 #endif
 
 
@@ -143,6 +142,7 @@ enum status_bits {
 	RxNoBuf = 0x80,
 	RxIntr = 0x40,
 	TxFIFOUnderflow = 0x20,
+	RxErrIntr = 0x10,
 	TxJabber = 0x08,
 	TxNoBuf = 0x04,
 	TxDied = 0x02,
@@ -193,9 +193,14 @@ struct tulip_tx_desc {
 
 
 enum desc_status_bits {
-	DescOwned = 0x80000000,
-	RxDescFatalErr = 0x8000,
-	RxWholePkt = 0x0300,
+	DescOwned    = 0x80000000,
+	DescWholePkt = 0x60000000,
+	DescEndPkt   = 0x40000000,
+	DescStartPkt = 0x20000000,
+	DescEndRing  = 0x02000000,
+	DescUseLink  = 0x01000000,
+	RxDescFatalErr = 0x008000,
+	RxWholePkt   = 0x00000300,
 };
 
 
--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip_core.c
@@ -1369,11 +1369,8 @@ static int __devinit tulip_init_one (str
 	if (pci_request_regions (pdev, "tulip"))
 		goto err_out_free_netdev;
 
-#ifndef USE_IO_OPS
-	ioaddr =  pci_iomap(pdev, 1, tulip_tbl[chip_idx].io_size);
-#else
-	ioaddr =  pci_iomap(pdev, 0, tulip_tbl[chip_idx].io_size);
-#endif
+	ioaddr =  pci_iomap(pdev, TULIP_BAR, tulip_tbl[chip_idx].io_size);
+
 	if (!ioaddr)
 		goto err_out_free_res;
 

--
