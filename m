Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUAZIB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 03:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUAZIBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 03:01:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55238 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262794AbUAZIBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 03:01:43 -0500
Date: Sun, 25 Jan 2004 23:52:42 -0800 (PST)
Message-Id: <20040125.235242.118621155.davem@redhat.com>
To: grundler@parisc-linux.org
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040125021306.GE16272@colo.lackof.org>
References: <20040124073032.GA7265@colo.lackof.org>
	<20040123.233241.59493446.davem@redhat.com>
	<20040125021306.GE16272@colo.lackof.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here is the final patch I added to my tree.

Thanks again Grant.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1519  -> 1.1520 
#	   drivers/net/tg3.c	1.120   -> 1.121  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/25	grundler@parisc-linux.org	1.1520
# [TG3]: Fix DMA test failures.
# 
# 1) Do not reset subcomponents.  GRC reset takes care of it.
# 2) Improve test by verifying the data on the card too.
# 3) Do not set DMA_RWCTRL_ASSERT_ALL_BE on chips where the
#    meaning of this bit is different.
# --------------------------------------------
#
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Sun Jan 25 23:57:37 2004
+++ b/drivers/net/tg3.c	Sun Jan 25 23:57:37 2004
@@ -7190,26 +7190,33 @@
 	test_desc.addr_lo = buf_dma & 0xffffffff;
 	test_desc.nic_mbuf = 0x00002100;
 	test_desc.len = size;
+
+	/*
+	 * HP ZX1 was seeing test failures for 5701 cards running at 33Mhz
+	 * the *second* time the tg3 driver was getting loaded after an
+	 * initial scan.
+	 *
+	 * Broadcom tells me:
+	 *   ...the DMA engine is connected to the GRC block and a DMA
+	 *   reset may affect the GRC block in some unpredictable way...
+	 *   The behavior of resets to individual blocks has not been tested.
+	 *
+	 * Broadcom noted the GRC reset will also reset all sub-components.
+	 */
 	if (to_device) {
 		test_desc.cqid_sqid = (13 << 8) | 2;
-		tw32(RDMAC_MODE, RDMAC_MODE_RESET);
-		tr32(RDMAC_MODE);
-		udelay(40);
 
 		tw32(RDMAC_MODE, RDMAC_MODE_ENABLE);
 		tr32(RDMAC_MODE);
 		udelay(40);
 	} else {
 		test_desc.cqid_sqid = (16 << 8) | 7;
-		tw32(WDMAC_MODE, WDMAC_MODE_RESET);
-		tr32(WDMAC_MODE);
-		udelay(40);
 
 		tw32(WDMAC_MODE, WDMAC_MODE_ENABLE);
 		tr32(WDMAC_MODE);
 		udelay(40);
 	}
-	test_desc.flags = 0x00000004;
+	test_desc.flags = 0x00000005;
 
 	for (i = 0; i < (sizeof(test_desc) / sizeof(u32)); i++) {
 		u32 val;
@@ -7368,9 +7375,19 @@
 	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701) {
 		/* Remove this if it causes problems for some boards. */
 		tp->dma_rwctrl |= DMA_RWCTRL_USE_MEM_READ_MULT;
-	}
 
-	tp->dma_rwctrl |= DMA_RWCTRL_ASSERT_ALL_BE;
+		/* On 5700/5701 chips, we need to set this bit.
+		 * Otherwise the chip will issue cacheline transactions
+		 * to streamable DMA memory with not all the byte
+		 * enables turned on.  This is an error on several
+		 * RISC PCI controllers, in particular sparc64.
+		 *
+		 * On 5703/5704 chips, this bit has been reassigned
+		 * a different meaning.  In particular, it is used
+		 * on those chips to enable a PCI-X workaround.
+		 */
+		tp->dma_rwctrl |= DMA_RWCTRL_ASSERT_ALL_BE;
+	}
 
 	tw32(TG3PCI_DMA_RW_CTRL, tp->dma_rwctrl);
 
@@ -7385,28 +7402,38 @@
 		goto out;
 
 	while (1) {
-		u32 *p, i;
+		u32 *p = buf, i;
 
-		p = buf;
 		for (i = 0; i < TEST_BUFFER_SIZE / sizeof(u32); i++)
 			p[i] = i;
 
 		/* Send the buffer to the chip. */
 		ret = tg3_do_test_dma(tp, buf, buf_dma, TEST_BUFFER_SIZE, 1);
-		if (ret)
+		if (ret) {
+			printk(KERN_ERR "tg3_test_dma() Write the buffer failed %d\n", ret);
 			break;
+		}
 
-		p = buf;
-		for (i = 0; i < TEST_BUFFER_SIZE / sizeof(u32); i++)
+		/* validate data reached card RAM correctly. */
+		for (i = 0; i < TEST_BUFFER_SIZE / sizeof(u32); i++) {
+			u32 val;
+			tg3_read_mem(tp, 0x2100 + (i*4), &val);
+			if (val != p[i]) {
+				printk( KERN_ERR "  tg3_test_dma()  Card buffer currupted on write! (%d != %d)\n", val, i);
+				/* ret = -ENODEV here? */
+			}
 			p[i] = 0;
+		}
 
 		/* Now read it back. */
 		ret = tg3_do_test_dma(tp, buf, buf_dma, TEST_BUFFER_SIZE, 0);
-		if (ret)
+		if (ret) {
+			printk(KERN_ERR "tg3_test_dma() Read the buffer failed %d\n", ret);
+
 			break;
+		}
 
 		/* Verify it. */
-		p = buf;
 		for (i = 0; i < TEST_BUFFER_SIZE / sizeof(u32); i++) {
 			if (p[i] == i)
 				continue;
@@ -7417,6 +7444,7 @@
 				tw32(TG3PCI_DMA_RW_CTRL, tp->dma_rwctrl);
 				break;
 			} else {
+				printk(KERN_ERR "tg3_test_dma() buffer corrupted on read back! (%d != %d)\n", p[i], i);
 				ret = -ENODEV;
 				goto out;
 			}
