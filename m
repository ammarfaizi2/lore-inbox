Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUAXBg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 20:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUAXBg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 20:36:27 -0500
Received: from colo.lackof.org ([198.49.126.79]:52439 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S263638AbUAXBgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 20:36:18 -0500
Date: Fri, 23 Jan 2004 18:36:14 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: jgarzik@pobox.lackof.org, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [PATCH] 2.6.1 tg3 DMA engine test failure
Message-ID: <20040124013614.GB1310@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, Dave,
tg3 patch to resolve another problem with bcm5701 card running at 33Mhz
on an ia64 rx4640 using a to-be-released system firmware (new feature
is PCI hotplug).

The failure message was "DMA engine test failure".
The problem was the read-back (DMA Write test) failed completely.
No data was transferred back to the host.

The orginal failure was seen on RHAS 3.0 (tg3 v2.2) but the
tg3_test_dma() code is the same for 2.6.1 kernel.  The appended
patch addresses three issues:

1) Don't reset subcomponents. Broadcom indicated only the GRC reset
   has been tested and "unpredictable behavior" could happen
   by resetting subcomponents. Removing the RDMAC/WDMAC reset
   fixed the "DMA engine test failure". 

2) I've "improved" the test by verifying the data on the card
   is what we put into the buffer initially. I.E. the test can
   now differentiate between outbound and inbound corruptions.

3) Broadcom engineer noted the meaning of DMA_RWCTRL_ASSERT_ALL_BE
   has changed for bcm570[34] and also advised against setting
   it on BCM570[01] chips. I'm just implementing his advice.
   Comment below spells out more details.

The patch was tested on rx2600 (ia64) and a500 (parisc).

thanks,
grant

===== drivers/net/tg3.c 1.120 vs edited =====
--- 1.120/drivers/net/tg3.c	Mon Dec 22 00:04:23 2003
+++ edited/drivers/net/tg3.c	Thu Jan 22 20:51:15 2004
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
+         * Broadcom noted the GRC reset will also reset all sub-components.
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
@@ -7368,10 +7375,27 @@
 	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701) {
 		/* Remove this if it causes problems for some boards. */
 		tp->dma_rwctrl |= DMA_RWCTRL_USE_MEM_READ_MULT;
+	} else
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5703 ||
+	    GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704) {
+		/* More words of wisdom from Broadcom:
+		 *    By setting this bit 23 in register 0x6c, all DMA
+		 *    writes (to host) will have the byte enables asserted
+		 *    at the beginning and the end of the buffer. This means
+		 *    that if the skbuff starts at host address xxx2, the
+		 *    DMA will write 2 bytes of garbage to xxx0.  The same
+		 *    thing will happen at the end of the buffer.
+		 *    While this may not cause any real problem because
+		 *    buffers may have extra padding, I think it is better
+		 *    to DMA the exact amount of data.
+		 *
+		 *    On the 5703 and 5704, this bit has been redefined
+		 *    to enable a PCIX-related bug fix. Setting it to 1
+		 *    means the bug fix is enabled.
+		 */
+		tp->dma_rwctrl |= DMA_RWCTRL_ASSERT_ALL_BE;
 	}
 
-	tp->dma_rwctrl |= DMA_RWCTRL_ASSERT_ALL_BE;
-
 	tw32(TG3PCI_DMA_RW_CTRL, tp->dma_rwctrl);
 
 #if 0
@@ -7385,28 +7409,38 @@
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
@@ -7417,6 +7451,7 @@
 				tw32(TG3PCI_DMA_RW_CTRL, tp->dma_rwctrl);
 				break;
 			} else {
+				printk(KERN_ERR "tg3_test_dma() buffer corrupted on read back! (%d != %d)\n", p[i], i);
 				ret = -ENODEV;
 				goto out;
 			}
