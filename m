Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVLXNUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVLXNUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 08:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVLXNUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 08:20:09 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:17332 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932283AbVLXNUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 08:20:07 -0500
Message-ID: <43AD4ADC.8050004@colorfullife.com>
Date: Sat, 24 Dec 2005 14:19:24 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: [PATCH] forcedeth: fix random memory scribbling bug
Content-Type: multipart/mixed;
 boundary="------------050507070605060005030100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507070605060005030100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Two critical bugs were found in forcedeth 0.47:
- TSO doesn't work.
- pci_map_single() for the rx buffers is called with size==0. This bug 
is critical, it causes random memory corruptions on systems with an iommu.

Below is a minimal fix for both bugs, for inclusion into 2.6.15.
TSO will be fixed properly in the next version.
Tested on x86-64.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------050507070605060005030100
Content-Type: text/plain;
 name="patch-forcedeth-048-bugfixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-forcedeth-048-bugfixes"

--- 2.6/drivers/net/forcedeth.c	2005-12-19 01:36:54.000000000 +0100
+++ x64/drivers/net/forcedeth.c	2005-12-24 12:16:30.000000000 +0100
@@ -10,7 +10,7 @@
  * trademarks of NVIDIA Corporation in the United States and other
  * countries.
  *
- * Copyright (C) 2003,4 Manfred Spraul
+ * Copyright (C) 2003,4,5 Manfred Spraul
  * Copyright (C) 2004 Andrew de Quincey (wol support)
  * Copyright (C) 2004 Carl-Daniel Hailfinger (invalid MAC handling, insane
  *		IRQ rate fixes, bigendian fixes, cleanups, verification)
@@ -100,6 +100,7 @@
  *	0.45: 18 Sep 2005: Remove nv_stop/start_rx from every link check
  *	0.46: 20 Oct 2005: Add irq optimization modes.
  *	0.47: 26 Oct 2005: Add phyaddr 0 in phy scan.
+ *	0.48: 24 Dec 2005: Disable TSO, bugfix for pci_map_single
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -111,7 +112,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.47"
+#define FORCEDETH_VERSION		"0.48"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -871,8 +872,8 @@
 		} else {
 			skb = np->rx_skbuff[nr];
 		}
-		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len,
-						PCI_DMA_FROMDEVICE);
+		np->rx_dma[nr] = pci_map_single(np->pci_dev, skb->data,
+					skb->end-skb->data, PCI_DMA_FROMDEVICE);
 		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
 			np->rx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->rx_dma[nr]);
 			wmb();
@@ -999,7 +1000,7 @@
 		wmb();
 		if (np->rx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev, np->rx_dma[i],
-						np->rx_skbuff[i]->len,
+						np->rx_skbuff[i]->end-np->rx_skbuff[i]->data,
 						PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(np->rx_skbuff[i]);
 			np->rx_skbuff[i] = NULL;
@@ -1334,7 +1335,7 @@
 		 * the performance.
 		 */
 		pci_unmap_single(np->pci_dev, np->rx_dma[i],
-				np->rx_skbuff[i]->len,
+				np->rx_skbuff[i]->end-np->rx_skbuff[i]->data,
 				PCI_DMA_FROMDEVICE);
 
 		{
@@ -2455,7 +2456,7 @@
 		np->txrxctl_bits |= NVREG_TXRXCTL_RXCHECK;
 		dev->features |= NETIF_F_HW_CSUM | NETIF_F_SG;
 #ifdef NETIF_F_TSO
-		dev->features |= NETIF_F_TSO;
+		/* disabled dev->features |= NETIF_F_TSO; */
 #endif
  	}
 

--------------050507070605060005030100--
